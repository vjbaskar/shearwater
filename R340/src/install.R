chooseCRANmirror(graphics = FALSE, ind = 1, local.only = FALSE)
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install(version = "3.5", ask = F)


list.of.packages <- c("Rhtslib", 'IRanges', 'GenomicRanges' )
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
message(new.packages)
if(length(new.packages)) BiocManager::install(new.packages)


list.of.packages <- c("devtools","RMySQL","dplyr")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)

