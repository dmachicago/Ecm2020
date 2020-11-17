del EDW_Fix.10.23.2014.sql
del EDW_Fix.MINOR.10.23.2014.sql

copy /B SetDB.sql EDW_Fix.10.23.2014.sql
copy /B SetDB.sql EDW_Fix.MINOR.10.23.2014.sql

copy /B /Y EDW_Fix.10.23.2014.sql + spacer.txt
copy /B /Y EDW_Fix.MINOR.10.23.2014.sql + spacer.txt

copy /B /Y EDW_Fix.10.23.2014.sql + view_EDW_HealthAssesment.sql 
copy /B /Y EDW_Fix.MINOR.10.23.2014.sql + view_EDW_HealthAssesment.sql 

copy /B /Y EDW_Fix.10.23.2014.sql + view_EDW_RewardUserLevel.sql

copy /B /Y EDW_Fix.10.23.2014.sql + View_EDW_HealthAssesmentAnswers.sql 
copy /B /Y EDW_Fix.MINOR.10.23.2014.sql + View_EDW_HealthAssesmentAnswers.sql

copy /B /Y EDW_Fix.10.23.2014.sql + spacer.txt
copy /B /Y EDW_Fix.MINOR.10.23.2014.sql + spacer.txt

copy /B /Y EDW_Fix.10.23.2014.sql + View_EDW_HealthAssesmentQuestions.sql
copy /B /Y EDW_Fix.MINOR.10.23.2014.sql + View_EDW_HealthAssesmentQuestions.sql

copy /B /Y EDW_Fix.10.23.2014.sql + SchemaChangeMonitor.sql
copy /B /Y EDW_Fix.10.23.2014.sql + SchemaChangeMonitor_rptData.sql
copy /B /Y EDW_Fix.10.23.2014.sql + SchemaChangeMonitorEvent.sql
copy /B /Y EDW_Fix.10.23.2014.sql + CreateDdlAuditTables.sql

copy /B /Y EDW_Fix.10.23.2014.sql + Proc_EDW_Compare_Tables.sql
copy /B /Y EDW_Fix.10.23.2014.sql + Proc_EDW_Compare_Views.sql

copy /B /Y EDW_Fix.10.23.2014.sql + udfGetCurrentIP.sql
copy /B /Y EDW_Fix.10.23.2014.sql + trgSchemaMonitor.sql

copy /B /Y EDW_Fix.10.23.2014.sql + spacer.txt
copy /B /Y EDW_Fix.10.23.2014.sql + sp_SchemaMonitorReport.sql
copy /B /Y EDW_Fix.10.23.2014.sql + Create_Job_SchemaMonitorReport.sql

copy /B /Y EDW_Fix.10.23.2014.sql + spacer.txt
copy /B /Y EDW_Fix.10.23.2014.sql + Proc_EDW_Compare_MASTER.sql

copy /B /Y EDW_Fix.10.23.2014.sql + SetDB.sql



copy /B /Y EDW_Fix.10.23.2014.sql + spacer.txt
copy /B /Y EDW_Fix.10.23.2014.sql + TheEnd.sql







