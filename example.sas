*Author:	Michel Lutz;
*Data:	 	19/06/23;

*Test for the xlsx2sas and sas2xlsx program;
*import as.xlsx to sas and write back;

*#######################################################################;
*xlsx2sas;

#Set paths and names;
%let file = "data/projects/sandbox/sandbox_1/05-Prog-Env/mlutz/ae.xlsx";
%let sheet = "NULL";
%let table_name = work.ae; 

*run scrip;
%include /data/global/xlsx2sas/xlsx2sas.sas

*compare work.ae with work.ae_base;
*import basic ae table;

*compare against imported version;


*#######################################################################;
*sas2xlsx;

%let table_name = work.ae; 
%let file = "data/projects/sandbox/sandbox_1/05-Prog-Env/mlutz/ae.xlsx";

*run scrip;
%include /data/global/xlsx2sas/sas2xlx.sas
