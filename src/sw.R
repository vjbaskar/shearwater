suppressPackageStartupMessages({
library(deepSNV)
library(dplyr)
library(VariantAnnotation)
library(rtracklayer)
})

h <- Sys.getenv(c("SW_BEDFILE", "SW_BASEQUAL"), names=T)
nproc = as.numeric(system("nproc", intern = T))

SW_MVCF_BOOL = TRUE
SW_PRIOR_CUTOFF = 0.5
SW_MAP_QUAL_CUTOFF = 20
SW_ALIGN_MASK_BITWISE_FLAG = 0
SW_POST_ARTIFACT_PROB_CUTOFF = 0.05

folder_bam="/project/bams"
folder_refs = "/project/refs"
folder_outpt = "/project/sw_outpt/"



save_image = paste0(folder_outpt,"/sw.RData")
file_bed = paste0(folder_refs,"/baits.bed")


bamfiles <- list.files(folder_bam,pattern = "*.bam$",full.names = T)
bed <- read.table(file_bed, header=T, stringsAsFactors=F, sep="\t")

regs <- import.bed(file_bed)
regions <- reduce(regs)

# segment bait file based on their overlap



rgns = regions
files = bamfiles

getSampleNames <- function(files){
	file_base = sapply(files, basename)
	file_base = sapply(file_base, function(x)  strsplit(x = x, split = ".", fixed= T)[[1]][1])
	return(file_base)
}

sample_names <- getSampleNames(files)
message("Number of procs used = ", nproc)
message("1. Counting data ...")
counts_data <- loadAllData(files, regions = rgns, mc.cores = nproc) #, q=h[["SW_BASEQUAL"]]) #, mq=mapqual, mask=bitWiseFlag)
dim(counts_data)
save.image(save_image)
message("2. Calc bayes factors ...")
bf <- mcChunk("bbb", split = 200, X = counts_data, mc.cores = nproc)
dim(bf)
#bf <- bbb(counts_data, model = "OR", rho = 1e-4) #, rho=rho, truncate=truncate, return.value=returnType, model=model)
save.image(save_image)
message("3. Generating vcf files ...")

vcfBF <- bf2Vcf(bf, counts = counts_data, regions = rgns, prior = SW_PRIOR_CUTOFF, mvcf = SW_MVCF_BOOL, samples = sample_names, cutoff = SW_POST_ARTIFACT_PROB_CUTOFF)
#vcf <- bf2Vcf(BF=bf, regions = rgns, counts = counts_data) #, regions = rgns, counts = counts_data) #, regions = regs_list[[1]], counts = counts_data ) # , counts=c3, regions=rgn, samples=sampNames1, cutoff=cutoff, prior=prior)

message("Saving data ...")
writeVcf(vcfBF, filename=paste0(folder_outpt,"/sw.vcf"))
save.image(save_image)
