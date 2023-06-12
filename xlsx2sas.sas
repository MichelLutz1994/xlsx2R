*###########################################################################################################
xlsx2sas
Variables to set:
 file: str			path to the xlsx file
 sheet: str			xlsx worksheet name to import. Use "NULL" to choose first sheet.
 table_name: 		libname.table - name for the new libray

################################################################################;
%let file = "data/projects/sandbox/sandbox_1/05-Prog-Env/mlutz/ae.xlsx";
%let sheet = "NULL";
%let table_name = work.ae; 
*###############################################################################;

*global setup variables;
%let path_to_R = "C:\Program Files\R\R-4.2.2\bin\Rscript"

* set wdir to root;
data _null_;
	rc=dlgcdir("/");
	put rc=;
run;

*toDO: run r script to transform .xlsx to csv
*data _null_;
*	call system('&path_to_R xlsx2sas.R &file &sheet &table_name');
*run;

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






