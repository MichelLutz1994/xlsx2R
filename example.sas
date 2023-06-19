*Author:	Michel Lutz;
*Data:	 	19/06/23;

*Test for the xlsx2sas and sas2xlsx program;
*import as.xlsx to sas and write back;

*#######################################################################;
*xlsx2sas;

#Set paths and names;
%let file = data/projects/sandbox/sandbox_1/05-Prog-Env/mlutz/test/ae.xlsx;
%let sheet = NULL;
%let table_name = work.ae; 

*run scrip;
%include "/data/global/scripts/xlsx2sas/xlsx2sas.sas"

*compare work.ae with work.ae_base;
*import basic ae table;
libname aeOrigin xport '/data/projects/sandbox/sandbox_1/05-Prog-Env/mlutz/ae.xpt' access=readonly;

run;
*compare against imported version;
proc compare
    base=aeOrigin.ae
    compare=work.ae;
run;


*#######################################################################;
*sas2xlsx;

%let table_name = work.ae; 
%let file = "data/projects/sandbox/sandbox_1/05-Prog-Env/mlutz/test/ae_2.xlsx";

*run scrip;
%include /data/global/scripts/xlsx2sas/sas2xlx.sas
