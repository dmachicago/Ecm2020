
GO
PRINT 'Executing proc_CT_FACT_TrackerCompositeDetails_TrackerShots.sql';
GO

IF EXISTS (SELECT
                  name
                  FROM sys.procedures
                  WHERE
                  name = 'proc_CT_FACT_TrackerCompositeDetails_TrackerShots') 
    BEGIN
        PRINT 'UPDATING proc_CT_FACT_TrackerCompositeDetails_TrackerShots.sql';
        DROP PROCEDURE
             proc_CT_FACT_TrackerCompositeDetails_TrackerShots;
    END;
GO

/*--------------------------------------------------------------------------------------------------------------
delete from FACT_EDW_TrackerCompositeDetails where TrackerNameAggregateTable = 'HFit_TrackerShots'
select count(*) from FACT_EDW_TrackerCompositeDetails where TrackerNameAggregateTable = 'HFit_TrackerShots'
select count(*) from BASE_HFit_TrackerShots
DBCC FREEPROCCACHE

update BASE_HFit_TrackerShots set HAshCode = '@' where ItemID in (select top 1000 itemid from BASE_HFit_TrackerShots)
exec proc_CT_FACT_TrackerCompositeDetails_TrackerShots ;

select top 100 * from BASE_HFit_TrackerShots

*/
CREATE PROCEDURE proc_CT_FACT_TrackerCompositeDetails_TrackerShots
AS
BEGIN

    --SET TRANSACTION ISOLATION LEVEL SNAPSHOT;
    --truncate table FACT_EDW_TrackerCompositeDetails

    DECLARE
    @AggregateTableName AS NVARCHAR (100) = 'HFit_TrackerShots'
  , @msg AS NVARCHAR (1000) = ''
  , @StepSecs AS BIGINT = 0
  , @TotalSecs AS BIGINT = 0
  , @StartTime AS DATETIME = GETDATE () 
  , @Step1Time AS DATETIME = GETDATE () 
  , @Step2Time AS DATETIME = GETDATE () 
  , @Step3Time AS DATETIME = GETDATE () 
  , @Step4Time AS DATETIME = GETDATE () 
  , @Step5Time AS DATETIME = GETDATE () 
  , @Step6Time AS DATETIME = GETDATE () 
  , @synchronization_version AS BIGINT = NULL
  , @LastVersion AS BIGINT = 0
  , @iCnt AS BIGINT = 0
  , @iChanges AS BIGINT = 0;

    SET @synchronization_version = CHANGE_TRACKING_CURRENT_VERSION () ;

    EXEC @LastVersion = proc_MASTER_LKP_CTVersion_Fetch 'BASE_HFit_TrackerShots' , 'proc_CT_FACT_TrackerCompositeDetails_TrackerShots';

    EXEC PrintImmediate 'Processing BASE_HFit_TrackerShots';
    SET @msg = 'Pulling CT Version: ' + CAST (@LastVersion AS NVARCHAR (50)) ;
    EXEC PrintImmediate @msg;
    -- select * from information_schema.tables where table_name like '%small%'
    EXEC @iCnt = proc_QuickRowCount BASE_HFit_TrackerShots;
    SET @msg = 'Total rows in Base Table: ' + CAST (@iCnt AS NVARCHAR (50)) ;
    EXEC PrintImmediate @msg;

    --******************************************************
    --CHECKPOINT;
    BEGIN TRY
        DROP TABLE
             #TrackerData;
    END TRY
    BEGIN CATCH
        EXEC printImmediate 'Loading temp table';
    END CATCH;
    SELECT
           ITEMID
         , SYS_CHANGE_VERSION
         , SYS_CHANGE_OPERATION
         , SYS_CHANGE_COLUMNS
         , SVR
         , DBNAME INTO
                       #TrackerData
           FROM CHANGETABLE (CHANGES BASE_HFit_TrackerShots, @LastVersion) AS CT;

    CREATE CLUSTERED INDEX PK_TT ON #TrackerData (SVR , DBNAME , ItemID , SYS_CHANGE_OPERATION) ;

    SET @iChanges = (SELECT
                            COUNT (*) 
                            FROM #TrackerData);
    IF @iChanges < 10
        BEGIN
            --EXEC proc_MASTER_LKP_CTVersion_Update  'BASE_HFit_TrackerShots', 'proc_CT_FACT_TrackerCompositeDetails_TrackerShots' , @synchronization_version;
            PRINT 'No changes registered to process.';
        END;

    SET @msg = 'Starting Time: ' + CAST (GETDATE () AS NVARCHAR (50)) ;
    EXEC printImmediate @msg;

    SET @iCnt = (SELECT
                        COUNT (*) 
                        FROM FACT_EDW_TrackerCompositeDetails
                        WHERE
                        TrackerNameAggregateTable = @AggregateTableName);

    IF
    @iChanges < 10
AND @iCnt > 0
        BEGIN
            --No changes found and RELOAD NOT needed. If reload needed, delete all entries for this table in the FACT table.
            EXEC proc_MASTER_LKP_CTVersion_Update  'BASE_HFit_TrackerShots' , 'proc_CT_FACT_TrackerCompositeDetails_TrackerShots' , @synchronization_version;
            PRINT 'No changes found to process, returning.';
            SET @msg = 'END Time: ' + CAST (GETDATE () AS NVARCHAR (50)) ;
            EXEC printImmediate @msg;
            RETURN;
        END;

    --If no records exists in the 
    IF @iCnt = 0
        BEGIN
            EXEC PrintImmediate 'RELOADING ALL RECORDS...';
            truncate TABLE #TrackerData;
            INSERT INTO #TrackerData (
                   ITEMID
                 , SYS_CHANGE_VERSION
                 , SYS_CHANGE_OPERATION
                 , SYS_CHANGE_COLUMNS
                 , SVR
                 , DBNAME) 
            SELECT
            --  'HFit_TrackerShots' AS AggregateTableName
                   ITEMID
          , 0 AS SYS_CHANGE_VERSION
          , 'I' AS SYS_CHANGE_OPERATION
          , NULL AS SYS_CHANGE_COLUMNS
          , SVR
          , DBNAME
                   FROM BASE_HFit_TrackerShots;
        END;

    SET @iCnt = (SELECT
                        COUNT (*) 
                        FROM #TrackerData);
    SET @msg = 'Total Records to Process: ' + CAST (@iCnt AS NVARCHAR (50)) ;
    EXEC printImmediate @msg;

    --select * from information_schema.columns where (table_name = 'FACT_EDW_TrackerCompositeDetails'
    --or table_name = 'BASE_HFit_TrackerShots') and Data_type like '%varchar%'
    --order by column_name, table_name

    --truncate table FACT_EDW_TrackerCompositeDetails

    INSERT INTO FACT_EDW_TrackerCompositeDetails
    (
           TrackerNameAggregateTable
         , ItemID
         , EventDate
         , IsProfessionallyCollected
         , TrackerCollectionSourceID
         , Notes
         , UserID
         , CollectionSourceName_Internal
         , CollectionSourceName_External
         , EventName
         , UOM
         , KEY1
         , VAL1
         , Key2
         , Val2
         , Key3
         , Val3
         , Key4
         , Val4
         , Key5
         , Val5
         , Key6
         , Val6
         , Key7
         , Val7
         , Key8
         , Val8
         , Key9
         , Val9
         , Key10
         , Val10
         , ItemCreatedBy
         , ItemCreatedWhen
         , ItemModifiedBy
         , ItemModifiedWhen
         , IsProcessedForHa
         , TXTKEY1
         , TXTVAL1
         , TXTKEY2
         , TXTVAL2
         , TXTKEY3
         , TXTVAL3
         , ItemOrder
         , ItemGuid
         , UserGuid
         , MPI
         , ClientCode
         , VendorID
         , VendorName
         , LastModifiedDate
         , SVR
         , DBNAME) 
    SELECT DISTINCT
           'HFit_TrackerShots' AS AggregateTableName
         , TT.ItemID
         , EventDate
         , TT.IsProfessionallyCollected
         , TT.TrackerCollectionSourceID
         , Notes
         , TT.UserID
         , NULL AS CollectionSourceName_Internal
         , NULL AS CollectionSourceName_External
         , 'MISSING' AS EventName
         , 'Y/N' AS UOM
         , 'FluShot' AS KEY1
         , CAST ( FluShot AS FLOAT) AS VAL1
         , 'PneumoniaShot' AS KEY2
         , CAST ( PneumoniaShot AS FLOAT) AS VAL2
         , 'NA' AS KEY3
         , NULL AS VAL3
         , 'NA' AS KEY4
         , NULL AS VAL4
         , 'NA' AS KEY5
         , NULL AS VAL5
         , 'NA' AS KEY6
         , NULL AS VAL6
         , 'NA' AS KEY7
         , NULL AS VAL7
         , 'NA' AS KEY8
         , NULL AS VAL8
         , 'NA' AS KEY9
         , NULL AS VAL9
         , 'NA' AS KEY10
         , NULL AS VAL10
         , TT.ItemCreatedBy
         , TT.ItemCreatedWhen
         , TT.ItemModifiedBy
         , TT.ItemModifiedWhen
         , NULL AS IsProcessedForHa
         , 'NA' AS TXTKEY1
         , NULL AS TXTVAL1
         , 'NA' AS TXTKEY2
         , NULL AS TXTVAL2
         , 'NA' AS TXTKEY3
         , NULL AS TXTVAL3
         , NULL AS ItemOrder
         , NULL AS ItemGuid
         , C.UserGuid
         , PP.MPI
         , PP.ClientCode
         , NULL AS VendorID	--VENDOR.ItemID as VendorID
         , NULL AS VendorName --VENDOR.VendorName
         , TT.LastModifiedDate
         , TT.SVR
         , TT.DBNAME
           FROM dbo.BASE_HFit_TrackerShots AS TT
                    INNER JOIN #TrackerData AS TD
                        ON TT.SVR = TD.SVR
                       AND TT.DBNAME = TD.DBNAME
                       AND TT.ItemID = TD.ItemID
                       AND TD.SYS_CHANGE_OPERATION = 'I'
                    INNER JOIN dbo.BASE_CMS_User AS C
                        ON C.UserID = TT.UserID
                       AND C.SVR = TT.SVR
                       AND C.DBNAME = TT.DBNAME
                    INNER JOIN dbo.BASE_HFit_ppteligibility AS PP
                        ON TT.UserID = PP.userID
                       AND TT.SVR = PP.SVR
                       AND TT.DBNAME = PP.DBNAME;

    SET @StepSecs = DATEDIFF (second , @StartTime , GETDATE ()) ;
    SET @msg = 'Step1 seconds: ' + CAST (@StepSecs AS NVARCHAR (50)) ;
    EXEC printImmediate @msg;
    SET @Step2Time = GETDATE () ;
    --******************************************************
    --CHECKPOINT;
    UPDATE FT
           SET
               FT.AccountID = ACCT.AccountID
             ,FT.AccountCD = ACCT.AccountCD
               FROM FACT_EDW_TrackerCompositeDetails AS FT
                        INNER JOIN dbo.BASE_HFit_Account AS ACCT
                            ON
                            FT.ClientCode = ACCT.AccountCD
                        AND FT.SVR = ACCT.SVR
                        AND FT.DBNAME = ACCT.DBNAME
                        AND FT.TrackerNameAggregateTable = @AggregateTableName
                        INNER JOIN #TrackerData AS TD
                            ON
                            FT.SVR = TD.SVR
                        AND FT.DBNAME = TD.DBNAME
                        AND FT.ItemID = TD.ItemID
                        AND FT.TrackerNameAggregateTable = @AggregateTableName

    SET @StepSecs = DATEDIFF (second , @Step1Time , @Step2Time) ;
    SET @msg = 'Step2 seconds: ' + CAST (@StepSecs AS NVARCHAR (50)) ;
    EXEC printImmediate @msg;
    SET @Step3Time = GETDATE () ;
    --******************************************************
    --CHECKPOINT;
    UPDATE FT
           SET
               FT.AccountCD = ACCT.AccountCD
               FROM FACT_EDW_TrackerCompositeDetails AS FT
                        INNER JOIN dbo.BASE_HFit_Account AS ACCT
                            ON
                            FT.ClientCode = ACCT.AccountCD
                        AND FT.SVR = ACCT.SVR
                        AND FT.DBNAME = ACCT.DBNAME
                        AND FT.TrackerNameAggregateTable = @AggregateTableName
                        INNER JOIN #TrackerData AS TD
                            ON
                            FT.SVR = TD.SVR
                        AND FT.DBNAME = TD.DBNAME
                        AND FT.ItemID = TD.ItemID
                        AND FT.TrackerNameAggregateTable = @AggregateTableName

    SET @StepSecs = DATEDIFF (second , @Step2Time , @Step3Time) ;
    SET @msg = 'Step3 seconds: ' + CAST (@StepSecs AS NVARCHAR (50)) ;
    EXEC printImmediate @msg;
    SET @Step4Time = GETDATE () ;
    --******************************************************
    --CHECKPOINT;
    UPDATE FT
           SET
               FT.SiteGUID = S.SiteGUID
               FROM FACT_EDW_TrackerCompositeDetails AS FT
                        INNER JOIN #TrackerData AS TD
                            ON
                            FT.SVR = TD.SVR
                        AND FT.DBNAME = TD.DBNAME
                        AND FT.ItemID = TD.ItemID
                        AND FT.TrackerNameAggregateTable = 'HFit_TrackerShots'
                        INNER JOIN dbo.BASE_HFit_Account AS ACCT
                            ON
                            FT.AccountCD = ACCT.AccountCD
                        AND FT.SVR = ACCT.SVR
                        AND FT.DBNAME = ACCT.DBNAME
                        INNER JOIN dbo.BASE_CMS_Site AS S
                            ON
                            ACCT.SiteID = S.SiteID
                        AND ACCT.SVR = S.SVR
                        AND ACCT.DBNAME = S.DBNAME;

    SET @StepSecs = DATEDIFF (second , @Step3Time , @Step4Time) ;
    SET @msg = 'Step4 seconds: ' + CAST (@StepSecs AS NVARCHAR (50)) ;
    EXEC printImmediate @msg;

    SET @Step5Time = GETDATE () ;
    --******************************************************
    --CHECKPOINT;
    EXEC printImmediate 'Starting Step5';

    UPDATE FT
           SET
               FT.CollectionSourceName_Internal = TC.CollectionSourceName_Internal
             ,FT.CollectionSourceName_External = TC.CollectionSourceName_External
               FROM FACT_EDW_TrackerCompositeDetails AS FT
                        INNER JOIN #TrackerData AS TD
                            ON
                            FT.SVR = TD.SVR
                        AND FT.DBNAME = TD.DBNAME
                        AND FT.ItemID = TD.ItemID
                        AND FT.TrackerNameAggregateTable = 'HFit_TrackerShots'
                        INNER JOIN dbo.BASE_HFit_TrackerCollectionSource AS TC
                            ON
                            TC.TrackerCollectionSourceID = FT.TrackerCollectionSourceID
                        AND TC.SVR = FT.SVR
                        AND TC.DBNAME = FT.DBNAME;

    --UPDATE FT
    --       SET
    --           FT.CollectionSourceName_Internal = TC.CollectionSourceName_Internal
    --         ,FT.CollectionSourceName_External = TC.CollectionSourceName_External
    --           FROM BASE_HFit_TrackerShots AS BT
    --                    INNER JOIN #TrackerData AS TD
    --                        ON BT.SVR = TD.SVR
    --                       AND BT.DBNAME = TD.DBNAME
    --                       AND BT.ItemID = TD.ItemID
    --                    JOIN FACT_EDW_TrackerCompositeDetails AS FT
    --                        ON
    --                        BT.ItemID = FT.ItemID
    --                    AND FT.SVR = BT.SVR
    --                    AND FT.DBNAME = BT.DBNAME
    --                    AND FT.TrackerNameAggregateTable = @AggregateTableName
    --                    INNER JOIN dbo.BASE_HFit_TrackerCollectionSource AS TC
    --                        ON
    --                        TC.TrackerCollectionSourceID = BT.TrackerCollectionSourceID
    --                    AND TC.SVR = BT.SVR
    --                    AND TC.DBNAME = BT.DBNAME  OPTION (
    --                                                      MAXDOP 1) ;

    SET @StepSecs = DATEDIFF (second , @Step4Time , @Step5Time) ;
    SET @msg = 'Step5 seconds: ' + CAST (@StepSecs AS NVARCHAR (50)) ;
    EXEC printImmediate @msg;

    SET @Step6Time = GETDATE () ;
    --******************************************************
    --CHECKPOINT;
    -- Select * from BASE_HFit_Tracker where AggregateTableName like '%HFit_TrackerShots%'
    UPDATE FT
           SET
               FT.IsAvailable = T.IsAvailable
             ,FT.IsCustom = T.IsCustom
             ,FT.UniqueName = T.UniqueName
             ,FT.ColDesc = T.UniqueName
               FROM FACT_EDW_TrackerCompositeDetails AS FT
                        INNER JOIN #TrackerData AS TD
                            ON
                            FT.SVR = TD.SVR
                        AND FT.DBNAME = TD.DBNAME
                        AND FT.ItemID = TD.ItemID
                        AND FT.TrackerNameAggregateTable = 'HFit_TrackerShots'
                        JOIN dbo.BASE_HFit_Tracker AS T
                            ON
                            T.AggregateTableName = 'HFit_TrackerShots'
                        AND T.SVR = FT.SVR
                        AND T.DBNAME = FT.DBNAME; --OPTION (MAXDOP 1) ;

    SET @StepSecs = DATEDIFF (second , @Step5Time , @Step6Time) ;
    SET @msg = 'Step6 seconds: ' + CAST (@StepSecs AS NVARCHAR (50)) ;
    EXEC printImmediate @msg;

    SET @StepSecs = DATEDIFF (second , @StartTime , GETDATE ()) ;
    SET @msg = 'Total Time in seconds: ' + CAST (@StepSecs AS NVARCHAR (50)) ;
    EXEC printImmediate @msg;

    EXEC proc_MASTER_LKP_CTVersion_Update  'BASE_HFit_TrackerShots' , 'proc_CT_FACT_TrackerCompositeDetails_TrackerShots' , @synchronization_version;

    EXEC printImmediate 'Ending Time: ';
    PRINT GETDATE () ;
END;
GO
PRINT 'Executed proc_CT_FACT_TrackerCompositeDetails_TrackerShots.sql';
GO
