-- select * from sys.procedures where name = 'proc_FACT_GetMaxCTVersionNbr'
-- drop PROCEDURE proc_FACT_CMS_Class_KenticoCMS_1_ApplyCT
-- exec proc_FACT_CMS_Class_KenticoCMS_1_ApplyCT

CREATE PROCEDURE proc_FACT_CMS_Class_KenticoCMS_1_ApplyCT
AS
BEGIN

    DECLARE @RowGuid AS nvarchar (100) = CAST (NEWID () AS nvarchar (50)) ;
    DECLARE @Action AS nvarchar (10) = 'N';
    DECLARE @NbrRecs AS bigint = 0;
    DECLARE @InstanceName AS nvarchar (100) = '';
    DECLARE @TblName AS nvarchar (100) = '';
    DECLARE @VersionTrackingTabl AS nvarchar (100) = '';
    DECLARE @MySql AS nvarchar (max) = '';
    DECLARE @last_sync_version  AS bigint = -1;
    DECLARE @curr_version  AS bigint = -1;
    DECLARE @result TABLE (
                          LastVerNo bigint) ;

    SET @TblName = 'CMS_Class';
    SET @InstanceName = 'KenticoCMS_1';
    SET @VersionTrackingTabl = 'BASE_' + @TblName + '_CTVerHIST ';
    SET @curr_version = (SELECT
                                MAX (CT.SYS_CHANGE_VERSION) 
                                FROM CHANGETABLE ( CHANGES KenticoCMS_1.dbo.CMS_Class, NULL) AS ct);

    EXEC @last_sync_version = proc_FACT_GetMaxCTVersionNbr @TblName;

    SET @Action = 'N';
    EXEC proc_FACT_PullTime_HIST @RowGuid, @Action, @InstanceName, @TblName, @NbrRecs;

    SET @MySql = 'select max(SYS_CHANGE_VERSION) from ' + @VersionTrackingTabl + ' Where DBMS = ''' + @InstanceName + '''';
    PRINT @MySql;

    INSERT INTO @result (
           LastVerNo) 
    EXEC (@MySql) ;

    SET @last_sync_version = (SELECT TOP (1) 
                                     LastVerNo
                                     FROM @result);
    IF @last_sync_version IS NULL
        BEGIN
            SET @last_sync_version = 0;
        END;
    PRINT 'PULLING VERSION# ' + CAST (@last_sync_version AS nvarchar (50)) ;

    --*************************************************************************************
    SET @Action = 'IS';
    EXEC proc_FACT_PullTime_HIST @RowGuid, @Action, @InstanceName, @TblName, @NbrRecs;
    EXEC @NbrRecs = proc_FACT_CMS_Class_KenticoCMS_1_Insert @last_sync_version;
    SET @Action = 'IE';
    EXEC proc_FACT_PullTime_HIST @RowGuid, @Action, @InstanceName, @TblName, @NbrRecs;
    --*************************************************************************************
    SET @Action = 'US';
    EXEC proc_FACT_PullTime_HIST @RowGuid, @Action, @InstanceName, @TblName, @NbrRecs;
    EXEC @NbrRecs = proc_FACT_CMS_Class_KenticoCMS_1_Update @last_sync_version;
    SET @Action = 'UE';
    EXEC proc_FACT_PullTime_HIST @RowGuid, @Action, @InstanceName, @TblName, @NbrRecs;
    --*************************************************************************************
    SET @Action = 'DS';
    EXEC proc_FACT_PullTime_HIST @RowGuid, @Action, @InstanceName, @TblName, @NbrRecs;
    EXEC @NbrRecs = proc_FACT_CMS_Class_KenticoCMS_1_Delete @last_sync_version;
    SET @Action = 'DE';
    EXEC proc_FACT_PullTime_HIST @RowGuid, @Action, @InstanceName, @TblName, @NbrRecs;
    --*************************************************************************************
    SET @Action = 'T';
    EXEC proc_FACT_PullTime_HIST @RowGuid, @Action, @InstanceName, @TblName, @NbrRecs;
    --*************************************************************************************

    EXEC proc_FACT_SaveCurrCTVersionNbr @InstanceName, @TblName , @curr_version;

END;



