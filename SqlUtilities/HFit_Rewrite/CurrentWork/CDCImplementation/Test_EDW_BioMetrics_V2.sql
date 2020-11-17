

PRINT 'TEST of exec proc_EDW_BioMetrics_V2';
-- use KenticoCMS_Prod1
-- exec quickcount DIM_EDW_BioMetrics
-- select top 100 * from DIM_EDW_BioMetrics
EXEC proc_EDW_BioMetrics 1;
EXEC proc_EDW_BioMetrics 0;

IF EXISTS ( SELECT
                   table_name
                   FROM tempdb.information_schema.tables
                   WHERE table_name = '##Temp_BioMetrics'
) 
    BEGIN
        PRINT 'Dropping ##Temp_BioMetrics';
        DROP TABLE
             ##Temp_BioMetrics;
    END;

SELECT
       * INTO
              ##Temp_BioMetrics
       FROM DIM_EDW_BioMetrics;

EXEC proc_Add_EDW_CT_StdCols '##Temp_BioMetrics';

IF NOT EXISTS ( SELECT
                       name
                       FROM sys.indexes
                       WHERE name = 'temp_PI_EDW_BioMetrics_IDs') 
    BEGIN
        CREATE CLUSTERED INDEX temp_PI_EDW_BioMetrics_IDs 
	   ON dbo.##Temp_BioMetrics ( UserID , UserGUID , SiteID , SiteGUID ,itemid , TBL) 
	   WITH ( PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , SORT_IN_TEMPDB = OFF , DROP_EXISTING = OFF , ONLINE = OFF ,
        ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ;
    END;

-- select * from ##Temp_BioMetrics

UPDATE ##Temp_BioMetrics
  SET
      AccountCD = UPPER (AccountCD) 
       WHERE
             UserID IN (SELECT TOP 1
                               UserID
                               FROM ##Temp_BioMetrics
                               ORDER BY
                                        UserID DESC) ;

UPDATE ##Temp_BioMetrics
  SET
      hashcode = HASHBYTES ('sha1' ,
      ISNULL (AccountCD , '-')) 
       WHERE
             UserID IN (SELECT TOP 1
                               UserID
                               FROM ##Temp_BioMetrics
                               ORDER BY
                                        UserID DESC) ;

DECLARE @iupdt AS int = 0;
EXEC @iupdt = proc_CT_BioMetrics_AddUpdatedRecs;

DELETE FROM ##Temp_BioMetrics
       WHERE
             UserID IN (SELECT TOP 1
                               UserID
                               FROM ##Temp_BioMetrics
                               ORDER BY
                                        UserID) ;
DECLARE @idels AS int = 0;
EXEC @idels = proc_CT_BioMetrics_AddDeletedRecs;

DELETE FROM DIM_EDW_BioMetrics
       WHERE
             UserID IN (SELECT TOP 1
                               UserID
                               FROM ##Temp_BioMetrics
                               ORDER BY
                                        UserID DESC) ;
DECLARE @inew AS int = 0;
EXEC @inew = proc_CT_BioMetrics_AddNewRecs;

PRINT '**********************************************';
PRINT '# of UPDATES: ' + CAST ( @iupdt AS nvarchar (50)) ;
PRINT '# of INSERTS: ' + CAST ( @inew AS nvarchar (50)) ;
PRINT '# of DELETES: ' + CAST ( @idels AS nvarchar (50)) ;
PRINT '**********************************************';
