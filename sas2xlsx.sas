*###########################################################################################################
xlsx2sas

Author: Michel Lutz
Date: 19/06/23

Variables to set:
 table_name: 		libname.table - name of the lib to write
 file: str			direction of the xlsx file
################################################################################;

*global setup variables;
%let path_to_R = /usr/local/bin/Rscript;
%let path_to_R_script = /data/global/scripts/data/global/scripts/xlsx2sas/sas2xlsx.R;

*set working directory to root;
data _null_;
	rc=dlgcdir("/");
	put rc=;
run;

*parse filen_name.xlsx to filen_name.xpt;
*incredible complicated code to get simples things, thank you SAS... (get filen_name from string);
data sas2xlsx_temp;
	file_name = CATS(scan(&file, 1, '.'), '.xpt');
run;
%let file_name=;
data _null_;
  set sas2xlsx_temp;
  call symputx('file_name',file_name);
run;
%put &file_name;

*remove temp lib;
proc datasets library=work;
	delete  sas2xlsx_temp;
run;

*write table to xpt;
libname work XPORT &file_name;
data work.sas2xlsx_tmp;
	set &table_name	;
run;

*2. call r to transform xpt to .xlsx;
%let R_command = "&path_to_R. &path_to_R_script. &file.";
%put &R_command;

data _null_;
	call system(&R_command.);
run;

*reset working directory;
data _null_;
	rc=dlgcdir("/apps/sas/studioconfig");
	put rc=;
run;
