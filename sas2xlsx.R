#!/usr/bin/env Rscript
if (system.file(package = "pacman") == ""){
  install.packages('pacman')
}
library(pacman)
pacman::p_load(tidyverse, haven, xlsx, foreign, readr, fs)

# function reads xpt file
# writes <filename>.xlsx in the same directory
sas2xlsx <- function(file){
  target_dir <- path_dir(file)
  file_name <- path_ext_remove(path_file(file))
  data <- read_xpt(paste(path_ext_remove(file), "xpt", sep="."))
  write.xlsx2(data, paste(target_dir, paste(file_name, "xlsx", sep="."), sep="/"))
}

# parsing command line arguments
args = commandArgs(trailingOnly=TRUE)
if (length(args) != 1) {
  stop("Provide exactly 1. argument, which is the path to to xpt file", call.=FALSE)
} else {
  file <- args[1]
  file_name <- args[2]
}

print("Start table transfere...")
sas2xlsx(file=file)
print("Table transfere done.")

