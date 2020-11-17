del IVP_ChangeTrackingBuild.sql

copy /B SetDB.sql IVP_ChangeTrackingBuild.sql

copy /B /Y IVP_ChangeTrackingBuild.sql + spacer.txt

copy /B /Y IVP_ChangeTrackingBuild.sql + udfGetCurrentIP.sql

copy /B /Y IVP_ChangeTrackingBuild.sql + spacer.txt
copy /B /Y IVP_ChangeTrackingBuild.sql + trgSchemaMonitor.sql 

copy /B /Y IVP_ChangeTrackingBuild.sql + SchemaChangeMonitor_rptData.sql 

copy /B /Y IVP_ChangeTrackingBuild.sql + CreateDdlAuditTables.sql 
copy /B /Y IVP_ChangeTrackingBuild.sql + sp_SchemaMonitorReport.sql 
copy /B /Y IVP_ChangeTrackingBuild.sql + SchemaChangeMonitorEvent.sql 
copy /B /Y IVP_ChangeTrackingBuild.sql + SchemaChangeMonitor.sql 


copy /B /Y IVP_ChangeTrackingBuild.sql + Proc_EDW_Compare_Tables.sql 
copy /B /Y IVP_ChangeTrackingBuild.sql + Proc_EDW_Compare_Views.sql 
copy /B /Y IVP_ChangeTrackingBuild.sql + Proc_EDW_Compare_MASTER.sql 

copy /B /Y IVP_ChangeTrackingBuild.sql + Create_Job_SchemaMonitorReport.sql 

copy /B /Y IVP_ChangeTrackingBuild.sql + TheEnd.sql

rem copy /B /Y IVP_ChangeTrackingBuild.sql + TestViewsExecution.sql




