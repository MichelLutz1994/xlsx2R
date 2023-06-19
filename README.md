# xlsx2sas
Test implentation to import and write xlsx fils to sas e.g. from sas without using 
SAS PC Access, but god old R. 

## Example
See example.sas file

## xlsx2sas
1. SAS program calls R
2. Read in xlsx in R with openxlsx package, which does nor require java installation like xlsx2.
   Using foreign package to write two temporaray files:
	- data_temp.sas (sas program for importing .csv file to sas)
	- data_temp.txt (data in csv format)
3. SAS reads in csv file by executing the sas program
4. deleating temporaray files

## sas2xlsx
1. SAS code exports table as xpt file
2. Call R script and read in xpt file with haven package
3. write R dataframe as .xlsx file using the openxlsx package

## Installation:

copy files to: /data/global/xlsx2sas/
- sas2xlsx.R
- sas2xlsx.sas
- xlsx2sas.R
- xlsx2sas.sas

### Set up R with packages:
1. install R on redhat
2. install packages on RHLE
	- for tidyverse the following packages must install via rpm
		- sudo yum install openssl-devel
		- sudo yum install libxml2-devel 
		- sudo yum install libfontconfig-devel
		- sudo yum install fribidi-devel
		- sudo yum install harfbuzz-devel
		- sudo yum install libtiff-devel
		- sudo yum install libjpeg-turbo-devel
		 
3. open R sudo /usr/local/bin/R
	run:
		install.packages('pacman')
		library(pacman)
		pacman::p_load(tidyverse, haven, openxlsx, foreign, readr, fs)
	
			
