

PRINT 'TEST of exec proc_STAGING_EDW_HealthAssesment_V2';
-- use KenticoCMS_Prod1
-- exec quickcount FACT_MART_EDW_HealthAssesment
-- select top 100 * from FACT_MART_EDW_HealthAssesment
GO

DECLARE
       @I AS INT = 0;
EXEC @I = quickcount FACT_MART_EDW_HealthAssesment;
IF @I <= 1
    BEGIN
        PRINT 'The STAGING DATA must be reloaded, standby...';
        PRINT 'Normally runs for just over 2 hours.';
    END;
ELSE
    BEGIN
        PRINT 'STAGING DATA already loaded, proceeding...';
    END;
GO

DECLARE
       @I1 AS INT = 0;
EXEC @I1 = quickcount FACT_MART_EDW_HealthAssesment;

IF @I1 <= 1
    BEGIN
        PRINT 'FORCED Reload of FACT_MART_EDW_HealthAssesment';
        EXEC proc_STAGING_EDW_HA_Changes 1;
    END;

--EXEC proc_STAGING_EDW_HA_Changes 0;

GO
PRINT 'Reload Completed ';
PRINT GETDATE () ;
GO

IF EXISTS ( SELECT
                   table_name
                   FROM tempdb.information_schema.tables
                   WHERE table_name = '##TEMP_HealthAssessmentData'
) 
    BEGIN
        PRINT 'Dropping ##TEMP_HealthAssessmentData';
        PRINT GETDATE () ;
        DROP TABLE
             ##TEMP_HealthAssessmentData;
    END;
ELSE
    BEGIN
        PRINT 'Reloading TMEP table ##TEMP_HealthAssessmentData';
    END;
PRINT GETDATE () ;
GO

PRINT 'Transfering data into ##TEMP_HealthAssessmentData';
SELECT
       * INTO
              ##TEMP_HealthAssessmentData
       FROM FACT_MART_EDW_HealthAssesment;

EXEC proc_Add_EDW_CT_StdCols '##TEMP_HealthAssessmentData';
-- select * from ##TEMP_HealthAssessmentData
GO
PRINT GETDATE () ;
PRINT 'Adding indexes to ##TEMP_HealthAssessmentData';
GO

DECLARE
       @StIndexing AS DATETIME = GETDATE () ;

IF NOT EXISTS ( SELECT
                       NAME
                       FROM SYS.INDEXES
                       WHERE NAME = 'temp_PI_EDW_HealthAssessment_ChangeType') 
    BEGIN
        CREATE INDEX temp_PI_EDW_HealthAssessment_ChangeType ON ##TEMP_HealthAssessmentData ( CHANGETYPE) 
        WITH ( PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , SORT_IN_TEMPDB = OFF , DROP_EXISTING = OFF , ONLINE = OFF ,
        ALLOW_ROW_LOCKS = ON ,
        ALLOW_PAGE_LOCKS = ON) ;
    END;

IF NOT EXISTS ( SELECT
                       name
                       FROM sys.indexes
                       WHERE name = 'temp_PI_Staging_EDW_HealthAssesment_IDs') 
    BEGIN
        CREATE CLUSTERED INDEX temp_PI_Staging_EDW_HealthAssesment_IDs
        ON dbo.##TEMP_HealthAssessmentData ( UserID , UserGUID , SiteID , SiteGUID , itemid , TBL) 
        WITH ( PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , SORT_IN_TEMPDB = OFF , DROP_EXISTING = OFF , ONLINE = OFF ,
        ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ;
    END;

DECLARE
       @IdxTimeHrs AS DECIMAL (10 , 2) = 0;
DECLARE
       @Idxsecs AS DECIMAL (10 , 2) = 0;
SET @Idxsecs = DATEDIFF ( SECOND , @StIndexing , GETDATE ()) ;
SET @IdxTimeHrs = @Idxsecs / 60 / 60;
PRINT 'Indexes Created: ';
PRINT CHAR ( 10) ;
PRINT GETDATE () ;
PRINT CHAR ( 10) ;
PRINT 'Index Time in Hours : ' + CAST ( @IdxTimeHrs AS NVARCHAR (50)) ;
PRINT CHAR ( 10) ;
GO

PRINT 'Testing UPDATES';
PRINT GETDATE () ;
GO

UPDATE ##TEMP_HealthAssessmentData
  SET
      UserAnswerCodeName = UPPER (UserAnswerCodeName) 
       WHERE
             UserGUID IN (SELECT TOP 1
                                 UserGUID
                                 FROM ##TEMP_HealthAssessmentData
                                 ORDER BY
                                          UserGUID DESC) ;
GO
PRINT GETDATE () ;
PRINT 'Testing UPDATES';
PRINT GETDATE () ;

UPDATE ##TEMP_HealthAssessmentData
  SET
      hashcode = HASHBYTES ('sha1' ,
      ISNULL (UserAnswerCodeName , '-')) 
       WHERE
             UserGUID IN (SELECT TOP 1
                                 UserGUID
                                 FROM ##TEMP_HealthAssessmentData
                                 ORDER BY
                                          UserGUID DESC) ;

DECLARE
       @iupdt AS INT = 0;
EXEC @iupdt = proc_CT_HA_AddUpdatedRecs;

PRINT GETDATE () ;
PRINT 'Testing DELETES';
PRINT GETDATE () ;

DELETE FROM ##TEMP_HealthAssessmentData
       WHERE
             UserGUID IN (SELECT TOP 1
                                 UserGUID
                                 FROM ##TEMP_HealthAssessmentData
                                 ORDER BY
                                          UserGUID) ;
DECLARE
       @idels AS INT = 0;
EXEC @idels = proc_CT_HA_AddDeletedRecs;

PRINT GETDATE () ;
PRINT 'Testing NEW RECS';
PRINT GETDATE () ;

DELETE FROM FACT_MART_EDW_HealthAssesment
       WHERE
             UserGUID IN (SELECT TOP 1
                                 UserGUID
                                 FROM ##TEMP_HealthAssessmentData
                                 ORDER BY
                                          UserGUID DESC) ;
DECLARE
       @inew AS INT = 0;
EXEC @inew = proc_CT_HA_AddNewRecs;

PRINT '**********************************************';
PRINT '# of UPDATES: ' + CAST ( @iupdt AS NVARCHAR (50)) ;
PRINT '# of INSERTS: ' + CAST ( @inew AS NVARCHAR (50)) ;
PRINT '# of DELETES: ' + CAST ( @idels AS NVARCHAR (50)) ;
PRINT '**********************************************';
