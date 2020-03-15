chooseCRANmirror(graphics = FALSE, ind = 1, local.only = FALSE)
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install(version = "3.5", ask = F)

#install.packages("caTools","RMySQL")

#packages_to_install = c("dplyr", "ggplot2", "openxlsx", "NOISeq","rtracklayer","gplots", 'Rhtslib', 'IRanges', 'GenomicRanges', 'SummarizedExperiment', 'Biostrings', 'VGAM', 'VariantAnnotation')
#packages_to_install = c("dplyr", "ggplot2", "openxlsx", "NOISeq","rtracklayer","gplots", 'Rhtslib', 'IRanges', 'GenomicRanges', 'SummarizedExperiment', 'Biostrings', 'VGAM', 'VariantAnnotation')

packages_to_install = c('SummarizedExperiment','Biostrings','VGAM','VariantAnnotation')
BiocManager::install(packages_to_install)
