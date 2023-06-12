*###########################################################################################################
xlsx2sas
Variables to set:
 table_name: 		libname.table - name of the lib to write
 file: str			direction of the xlsx file

################################################################################;
%let table_name = work.ae; 
%let file = "data/projects/sandbox/sandbox_1/05-Prog-Env/mlutz/ae.xlsx";
*###############################################################################;

*global setup variables;
%let path_to_R = "C:\Program Files\R\R-4.2.2\bin\Rscript";

*set working directory to root;
data _null_;
	rc=dlgcdir("/");
	put rc=;
run;

*parse filen_name.xlsx to filen_name.xpt;
*todo;

*write table to xpt;
libname work XPORT &file;
data work.sas2xlsx_tmp;
	set &table_name	;
run;

*2. call r to transform xpt to .xlsx;
*data _null_;
*	call system('&path_to_R sas2xlsx.R &file');
*run;

*reset working directory;
data _null_;
	rc=dlgcdir("/apps/sas/studioconfig");
	put rc=;
run;