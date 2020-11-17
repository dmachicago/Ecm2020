
--declare @TgtView AS nvarchar ( 100) = 'view_EDW_HealthAssesment';
DECLARE @CTVersionToPullNow AS int = ( SELECT
                                              MAX ( CurrentDbVersion) 
                                              FROM CT_VersionTracking
                                              WHERE
                                              SVRname = @@ServerName
                                          AND DBName = DB_NAME () 
                                          AND TgtView = 'view_EDW_HealthAssesment');

EXEC proc_EDW_BuildStagingTables @CTVersionToPullNow;

EXEC proc_Create_STAGED_EDW_PkHashkey_TBL ;

EXEC proc_CT_HA_MarkDeletedRecords ;

--************************************************
--MAKE SURE THE STAGED HASH KEY Table exists
EXEC proc_Create_STAGED_EDW_PkHashkey_TBL ;
--************************************************

EXEC dbo.sp_start_job N'job_EDW_CT_HA_MarkNewRecords_KenticoCMS_Prod1' ;

USE msdb ;
GO

EXEC dbo.sp_start_job N'Weekly Sales Data Backup' ;
GO