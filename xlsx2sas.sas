*################################################################################
xlsx2sas
Author: Michel Lutz
Date: 19/06/23

Variables to set:
 file: str			path to the xlsx file
 sheet: str			xlsx worksheet name to import. Use "NULL" to choose first sheet.
 table_name: 		libname.table - name for the new libray
################################################################################;

*global setup variables;
%let path_to_R = "/usr/local/bin/Rscript";
%let path_to_R_script = "/data/global/scripts/data/global/scripts/xlsx2sas/xlsx2sas.R";

* set wdir to root;
data _null_;
	rc=dlgcdir("/");
	put rc=;
run;

data _null_;
	call system('&path_to_R &path_to_R_script &file &sheet &table_name');
run;

*incredible complicated code to get simples things, thank you SAS... (get dir from file);
data xlsx2sas_temp;
	filename=&file;
	prog=CATS(substr(filename,1,find(filename,reverse(scan(reverse(filename),1,"/")))-1), "data_temp.sas");
run;
%let prog=;
data _null_;
  set xlsx2sas_temp;
  call symputx('prog',prog);
run;
%put &prog;

*execute sas script written by R;
%include "&prog";

*remove temp lib;
proc datasets library=work;
	delete  xlsx2sas_temp;
run;






