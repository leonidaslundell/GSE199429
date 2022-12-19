# Version info: R 3.2.3, Biobase 2.30.0, GEOquery 2.40.0, limma 3.26.8
# R scripts generated  Mon Mar 9 05:36:22 EDT 2020

################################################################
#   Differential expression analysis with limma
library(Biobase)
library(GEOquery)
library(limma)

# load series and platform data from GEO

gset <- getGEO("GSE43658", GSEMatrix =TRUE, AnnotGPL=FALSE)
if (length(gset) > 1) idx <- grep("GPL14661", attr(gset, "names")) else idx <- 1
gset <- gset[[idx]]

#remove NAs
expr <- exprs(gset)

dataAnnotation <- gset@featureData@data
expr <- expr[!dataAnnotation$GB_ACC=="",]
dataAnnotation <- dataAnnotation[!dataAnnotation$GB_ACC=="",]

boxplot(expr, main = "before norm")
# expr <- normalizeBetweenArrays(expr)
# boxplot(expr, main = "after norm")
#no normalization nesseary...

#drop the expr with out

expr <- expr[,gset@phenoData@data$geo_accession[grepl("Negative",gset@phenoData@data$source_name_ch1)]]

gset@phenoData@data <- gset@phenoData@data[grepl("Negative",gset@phenoData@data$source_name_ch1),]

gset <- ExpressionSet(assayData = expr,
                      phenoData = gset@phenoData,
                      featureData = AnnotatedDataFrame(dataAnnotation))

# set up the data and proceed with analysis

design <- model.matrix(~0 + as.factor(c("Saline", "Saline", "Saline", "ISO", "ISO", "ISO")), gset)
colnames(design) <- c("ISO", "Saline")

fit <- lmFit(gset, design)
cont.matrix <- makeContrasts(ISO - Saline, levels=design)

fit2 <- contrasts.fit(fit, cont.matrix)
fit2 <- treat(fit2, lfc = log2(1.2))
tT <- topTreat(fit2, adjust="fdr", number=Inf)
hist(tT$P.Value)

sum(tT$adj.P.Val<=0.05)
tT <- tT[tT$adj.P.Val<=0.05,]

# tT <- tT[,c("GB_ACC", "logFC", "adj.P.Val")]
# expr["384783_at",]


library(biomaRt)
mart <- useMart(biomart = "ensembl",dataset="mmusculus_gene_ensembl")
genes <- getBM(mart = mart,
               filters = "refseq_mrna", 
               values = tT$GB_ACC, 
               attributes = c("refseq_mrna","external_gene_name"))

tT <- merge(genes, tT, by.x = "refseq_mrna", by.y = "GB_ACC")
iso3T3 <- tT

head(tT)
save(file = "data/iso.treat.3T3.Rdata", iso3T3)
