# Version info: R 3.2.3, Biobase 2.30.0, GEOquery 2.40.0, limma 3.26.8
# R scripts generated  Mon Mar 9 08:53:46 EDT 2020

################################################################
#   Differential expression analysis with limma
library(Biobase)
library(GEOquery)
library(limma)

# load series and platform data from GEO

gset <- getGEO("GSE62635", GSEMatrix =TRUE, AnnotGPL=TRUE)
if (length(gset) > 1) idx <- grep("GPL1261", attr(gset, "names")) else idx <- 1
gset <- gset[[idx]]

# make proper column names to match toptable 
fvarLabels(gset) <- make.names(fvarLabels(gset))

#remove NAs
expr <- exprs(gset)

dataAnnotation <- gset@featureData@data
expr <- expr[!dataAnnotation$Gene.symbol=="",]
dataAnnotation <- dataAnnotation[!dataAnnotation$Gene.symbol=="",]

#drop the expr with out

expr <- expr[,gset@phenoData@data$geo_accession[!grepl("tumor", gset@phenoData@data$`treatment:ch1`) & grepl("0|24h", gset@phenoData@data$`time point:ch1`)]]

gset@phenoData@data <- gset@phenoData@data[!grepl("tumor", gset@phenoData@data$`treatment:ch1`) & grepl("0|24h", gset@phenoData@data$`time point:ch1`),]

gset <- ExpressionSet(assayData = expr,
                      phenoData = gset@phenoData,
                      featureData = AnnotatedDataFrame(dataAnnotation))


design <- model.matrix(~0 + as.factor(c("Saline", "Saline", "Saline", "DEX", "DEX", "DEX")), gset)
colnames(design) <- c("DEX", "Saline")

fit <- lmFit(gset, design)
cont.matrix <- makeContrasts(DEX - Saline, levels=design)

fit2 <- contrasts.fit(fit, cont.matrix)
fit2 <- treat(fit2, lfc = log2(1.2))
tT <- topTreat(fit2, adjust="fdr", number=Inf)
hist(tT$P.Value)
#top treat skews the p-value hist

sum(tT$adj.P.Val<=0.05)
tT <- tT[tT$adj.P.Val<=0.05,]

dex3T3 <- tT[,c("Gene.symbol", "logFC", "adj.P.Val")]
save(file = "data/dex.treat.3T3.Rdata", dex3T3)
