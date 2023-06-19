#!/usr/bin/env Rscript
if (system.file(package = "pacman") == ""){
  install.packages('pacman')
}
library(pacman)
pacman::p_load(tidyverse, haven, openxlsx, foreign, readr, fs)

# function reads xlsx file
# writes the file as data_temp.csv file and sas code to import the file in sas
xlsx2sas <- function(file, sheet=NULL, table_name){
  
  setwd(dirname(file))
  
  #import xlsx file
  if (is.null(sheet)){
    data <- read.xlsx(xlsxFile=file, sheet = 1)
  } else {
    data <- read.xlsx(file=file, sheetName = sheet)
  }
  
  print(paste("imported :", file, sep=""))
  # Function defined for converting factors and blanks
  convert_format_r2sas <- function(data){
    data <- data %>%
      dplyr::mutate_if(is.factor, as.character) %>%
      dplyr::mutate_if(is.character, tidyr::replace_na, replace = "")
    return(data)
  }
  
  # Convert some formatting
  data <- convert_format_r2sas(data)
  
  # Ensure the data and code files are saved in an easily accessible location 
  #(ideally in or downstream of your R project directory)
  write.foreign(df = data ,
                datafile = paste(dirname(file), 'data_temp.txt', sep="/"),
                codefile = 'data_temp.sas',
                dataname = table_name, # Destination in SAS to save the data
                package = 'SAS')
  
  # modify sas program, set and reset working directory and change root to sce
  path=paste(dirname(file), 'data_temp.sas', sep="/")
  begin_txt <- "data _null_;\n\trc=dlgcdir(\"/\");\n\tput rc=;\nrun;\n"
  end_txt <- "\ndata _null_;\n\trc=dlgcdir(\"/apps/sas/studioconfig\");\n\tput rc=;\nrun;"
  tx <- read_file(path)
  tx  <- gsub(pattern = "\"X:", replace = "\"data", x = tx)
  tx <- paste(begin_txt, tx, end_txt, sep="\n")
  write_file(tx, path)
}

# parsing command line arguments
args = commandArgs(trailingOnly=TRUE)
if (length(args) < 2 || length(args) > 3) {
  stop("Provide 2 or 3 arguments. First path to .xlsx file. Second destination libname.tablename. 
       Third sheet name, if none given the 1 sheet will be imported", call.=FALSE)
} else if (length(args) >= 2){
  file <- args[1]
  table_name <- args[2]
  sheet <- NULL
} else if (length(args) == 3){
  sheet <- args[3]
}

print("Start table transfere...")
xlsx2sas(file=file,
         sheet=NULL,
         table_name=table_name)
print("Table transfere done.")
