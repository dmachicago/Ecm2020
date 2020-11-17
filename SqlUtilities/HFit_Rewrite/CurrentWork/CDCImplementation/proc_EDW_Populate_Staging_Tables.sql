GO
PRINT 'Creating proc_EDW_Populate_Staging_Tables.sql';
GO

-- use KenticoCMS_Prod2
-- exec [proc_EDW_Populate_Staging_Tables]
-- select count(*) from BASE_HFit_HealthAssesmentUserAnswers

IF EXISTS ( SELECT
                   NAME
                   FROM SYS.PROCEDURES
                   WHERE NAME = 'proc_EDW_Populate_Staging_Tables') 
    BEGIN
        DROP PROCEDURE
             proc_EDW_Populate_Staging_Tables;
    END;
GO

-- exec proc_EDW_Populate_Staging_Tables
CREATE PROCEDURE proc_EDW_Populate_Staging_Tables
     @LoadType AS int = 0
   , @TRACENAME AS nvarchar (100) = 'proc_EDW_Populate_Staging_Tables'
AS
BEGIN

/*------------------------------------------------------------------------------------------------------------
-------------------------------------------------------
**************************************************************************************************************
Author:	  W. Dale Miller
Created:	  06.15.2015
USE:		  exec proc_EDW_Populate_Staging_Tables
@LoadType:	 0 - Changes found with deletes, load all records in order to find deletes
			 1 - Reload ALL
			 2 - Changes found, no deletes, load only changed records
**************************************************************************************************************
*/

    -- declare @LoadType as int = 0 ;
    IF @LoadType IS NULL
        BEGIN
            SET @LoadType = 0;
        END;

    DECLARE
    @St AS datetime = GETDATE () ;
    PRINT 'proc_EDW_Populate_Staging_Tables Started: ' + CONVERT(VARCHAR, getdate(), 120) ;
    SET NOCOUNT ON;

    EXEC proc_EDW_Procedure_Performance_Monitor 'I' , @TRACENAME , '0011a - Start proc_EDW_Populate_Staging_Tables';
    EXEC proc_EDW_Procedure_Performance_Monitor 'I' , @TRACENAME , '0011b - Start proc_EDW_UpdateDIMTables';
    --*************************************************************************
    EXEC proc_EDW_UpdateDIMTables ;
    --*************************************************************************
    EXEC proc_EDW_Procedure_Performance_Monitor 'I' , @TRACENAME , '0011c - END proc_EDW_UpdateDIMTables';

    DECLARE
    @ms AS decimal (10, 3) = 0,
    @secs AS decimal (10, 3) = 0,
    @min AS decimal (10, 3) = 0,
    @hr AS decimal (10, 3) = 0;

    SET @ms = DATEDIFF ( ms , @st , GETDATE ()) ;
    SET @secs = @ms / 1000;
    SET @min = @secs / 60;
    SET @hr = @min / 60;

    PRINT 'TIME TO BUILD STAGING TABLE DATA';
    PRINT 'TempData Loaded: ' + CONVERT(VARCHAR, getdate(), 120) ;;    
    PRINT 'Elapsed Seconds: ' + CAST ( @secs AS nvarchar (50)) ;
    PRINT 'Elapsed Minutes: ' + CAST ( @min AS nvarchar (50)) ;
    PRINT 'Elapsed Hour: ' + CAST ( @hr AS nvarchar (50)) ;    
    PRINT 'Seconds: ' + CAST ( DATEDIFF ( SECOND , @St , GETDATE ()) AS nvarchar (50)) ;

    DECLARE
    @Stpulltime AS datetime = GETDATE (),
    @Stdataload AS datetime = GETDATE () ;

    IF EXISTS (  SELECT
                        name
                        FROM tempdb.dbo.sysobjects
                        WHERE id = OBJECT_ID ( N'tempdb..##HealthAssessmentData')) 
        BEGIN
            DROP TABLE
                 ##HealthAssessmentData;
        END;

    DECLARE
    @Sttxpulltime AS datetime = GETDATE () ;

    IF @LoadType = 2
        BEGIN
            EXEC proc_EDW_Procedure_Performance_Monitor 'I' , @TRACENAME , '0011d - proc_EDW_UpdateDIMTables ReloadType 2';
            --***********************************************************************
		  exec proc_EDW_Reload_EDW_HealthAssessment;
	   --***********************************************************************
            DECLARE
            @Recs01 AS int = @@Rowcount;

            PRINT 'Temp HA Data Loaded: ';
            PRINT GETDATE () ;
            PRINT 'HA Data Load Seconds: ' + CAST ( DATEDIFF ( SECOND , @Stpulltime , GETDATE ()) AS nvarchar (50)) ;
            PRINT '##HealthAssessmentData rows: ' + CAST ( @Recs01 AS nvarchar (50)) ;
            EXEC proc_EDW_Procedure_Performance_Monitor 'I' , @TRACENAME , '0011d - END ReloadType 2';
        END;
    IF @LoadType = 0
        BEGIN
            EXEC proc_EDW_Procedure_Performance_Monitor 'I' , @TRACENAME , '0011d - proc_EDW_UpdateDIMTables ReloadType 0';
            EXEC ('SELECT * INTO ##HealthAssessmentData FROM view_EDW_PullHAData_NoCT') ;
            DECLARE
            @Recs AS int = @@Rowcount;

            PRINT 'Temp HA Data Loaded: ';
            PRINT GETDATE () ;
            PRINT 'HA Data Load Seconds: ' + CAST ( DATEDIFF ( SECOND , @Stpulltime , GETDATE ()) AS nvarchar (50)) ;
            PRINT '##HealthAssessmentData rows: ' + CAST ( @Recs AS nvarchar (50)) ;
            EXEC proc_EDW_Procedure_Performance_Monitor 'I' , @TRACENAME , '0011d - END ReloadType 0';
        END;
    IF @LoadType = 1
        BEGIN
            EXEC proc_EDW_Procedure_Performance_Monitor 'I' , @TRACENAME , '0011d - proc_EDW_UpdateDIMTables ReloadType 1';
            DECLARE
            @Startreload AS datetime = GETDATE (), @Recsall AS int = 0;
		  --****************************************************************
             exec @Recsall  = proc_EDW_Reload_EDW_HealthAssessment;
		  --****************************************************************

            DECLARE
            @Reloadsecs AS decimal ( 10 , 2) = DATEDIFF ( second , @Startreload , GETDATE ()) ;
            DECLARE
            @Reloadhrs AS decimal ( 10 , 2) = @Reloadsecs / 60 / 60;

            PRINT 'RELOAD ALL SELECTED - ' + CAST ( @Recsall AS nvarchar ( 50)) + ' records moved into FACT_MART_EDW_HealthAssesment in' + CAST ( @Reloadhrs AS nvarchar ( 50)) + ' hours.';
            EXEC proc_EDW_Procedure_Performance_Monitor 'I' , @TRACENAME , '0011d - END ReloadType 1';
        END;

    DECLARE
    @Loadtimeha AS decimal ( 10 , 2) = 0;
    DECLARE
    @SEC AS decimal ( 10 , 2) = 0;

    SET @SEC = DATEDIFF ( SECOND , @Stdataload , GETDATE ()) ;
    SET @Loadtimeha = @SEC / 60 / 60;

    PRINT 'HA Data Loaded: ';
    PRINT GETDATE () ;
    PRINT 'Total Records Loaded : ' + CAST ( @Recs AS nvarchar (50)) ;
    PRINT 'Time in Hours to load TEMP TABLE: (Hrs) ' + CAST ( @Loadtimeha AS nvarchar (50)) ;

    DECLARE
    @Stindexing AS datetime = GETDATE () ;
    IF
    @LoadType = 0
 OR @LoadType = 2
        BEGIN
            DECLARE @idxstart AS datetime = GETDATE () ;
            IF NOT EXISTS ( SELECT
                                   NAME
                                   FROM SYS.INDEXES
                                   WHERE NAME = 'temp_PI_EDW_HealthAssessment_ChangeType') 
                BEGIN
                    CREATE INDEX temp_PI_EDW_HealthAssessment_ChangeType ON ##HealthAssessmentData ( CHANGETYPE) WITH ( PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , SORT_IN_TEMPDB = OFF , DROP_EXISTING = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ;
                END;
            IF NOT EXISTS ( SELECT
                                   NAME
                                   FROM SYS.INDEXES
                                   WHERE NAME = 'temp_PI_EDW_HealthAssessment_NATKEY') 
                BEGIN
                    CREATE CLUSTERED INDEX TEMP_PI_EDW_HealthAssessment_NATKEY ON DBO.##HealthAssessmentData ( USERSTARTEDITEMID , USERGUID , PKHASHCODE , HASHCODE , DeletedFlg, LastModifiedDATE) ;
                END;
            DECLARE @idxms  AS decimal (10, 3) = 0;
            SET @idxms = DATEDIFF (ms, @idxstart, GETDATE ()) ;
            SET @idxms = @idxms / 1000;    --seconds
            SET @idxms = @idxms / 60;	    --minutes
            SET @idxms = @idxms / 60;	    --hours
            PRINT 'Time to create TEMP Index (mins): ' + CAST (@idxms * 60 AS nvarchar (50)) ;
            PRINT 'Time to create TEMP Index (hrs): ' + CAST (@idxms AS nvarchar (50)) ;
        END;
    DECLARE
    @millisec AS decimal (10, 3) = 0;
    DECLARE
    @seconds AS decimal (10, 3) = 0;
    DECLARE
    @minutes AS decimal (10, 3) = 0;
    DECLARE
    @hours AS decimal (10, 3) = 0;
    SET @millisec = DATEDIFF ( ms , @st , GETDATE ()) ;
    SET @seconds = @millisec / 1000;
    SET @minutes = @seconds / 60;
    SET @hours = @minutes / 60;
    PRINT 'TIME TO COMPLETE proc_EDW_Populate_Staging_Tables:';
    PRINT 'Elapsed Seconds: ' + CAST ( @seconds AS nvarchar (50)) ;
    PRINT 'Elapsed Minutes: ' + CAST ( @minutes AS nvarchar (50)) ;
    PRINT 'Elapsed Hour: ' + CAST ( @hours AS nvarchar (50)) ;
    PRINT 'TOTAL ROWS: ' + CAST ( @Recs AS nvarchar (50)) ;
    PRINT 'Process Started:';
    PRINT @St;
    PRINT 'Process Ended:';
    PRINT GETDATE () ;
    EXEC proc_EDW_Procedure_Performance_Monitor 'I' , @TRACENAME , '0011e -END proc_EDW_UpdateDIMTables ReloadType';
    RETURN @Recs;
END;
GO
PRINT 'Created proc_EDW_Populate_Staging_Tables.sql';
GO
