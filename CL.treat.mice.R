# Version info: R 3.2.3, Biobase 2.30.0, GEOquery 2.40.0, limma 3.26.8
# R scripts generated  Fri Mar 6 08:55:23 EST 2020

################################################################
#   Differential expression analysis with limma
library(Biobase)
library(GEOquery)
library(limma)

# load series and platform data from GEO

gset <- getGEO("GSE55934", GSEMatrix =TRUE, getGPL=T)
if(length(gset) > 1) idx <- grep("GPL16570", attr(gset, "names")) else idx <- 1
gset <- gset[[idx]]

# make proper column names to match toptable 
fvarLabels(gset) <- make.names(fvarLabels(gset))

#remove NAs
expr <- exprs(gset)

dataAnnotation <- gset@featureData@data
expr <- expr[!dataAnnotation$unigene=="---",]
dataAnnotation <- dataAnnotation[!dataAnnotation$unigene=="---",]

# boxplot(expr, main = "before norm")
# expr <- normalizeBetweenArrays(expr)
# boxplot(expr, main = "after norm")

gset <- ExpressionSet(assayData = expr,
                      phenoData = gset@phenoData,
                      featureData = AnnotatedDataFrame(dataAnnotation))

# set up the data and proceed with analysis

design <- model.matrix(~0 + as.factor(c("Saline", "Saline", "Saline", "CL", "CL", "CL")), gset)
colnames(design) <- c("CL", "Saline")

fit <- lmFit(gset, design)
cont.matrix <- makeContrasts(CL-Saline, levels=design)
fit2 <- contrasts.fit(fit, cont.matrix)
fit2 <- eBayes(fit2)
tT <- topTable(fit2, adjust="fdr", sort.by="B", number=Inf)
hist(tT$P.Value)

sum(tT$adj.P.Val<=0.05)
tT <- tT[tT$adj.P.Val<=0.05,]
ClMice <- tT

mart <- useMart(biomart = "ensembl",dataset="mmusculus_gene_ensembl")
genes <- getBM(mart = mart,
               filters = "affy_mogene_2_1_st_v1", 
               values = ClMice$ID, 
               attributes = c("affy_mogene_2_1_st_v1","external_gene_name"))

genes$affy_mogene_2_1_st_v1 <- as.numeric(genes$affy_mogene_2_1_st_v1)
ClMice <- merge(x = genes, y = ClMice[,c("ID", "adj.P.Val", "logFC")], by.x = "affy_mogene_2_1_st_v1", by.y="ID")

head(ClMice)
expr["17221114",]

save(file = "data/CL.treat.mice.Rdata", ClMice)
# write.table(tT, file=stdout(), row.names=F, sep="\t")
