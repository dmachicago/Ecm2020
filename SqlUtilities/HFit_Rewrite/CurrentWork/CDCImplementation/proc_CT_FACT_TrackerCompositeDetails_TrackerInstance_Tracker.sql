
GO
PRINT 'Executing proc_CT_FACT_TrackerCompositeDetails_TrackerInstance_Tracker.sql';
GO
IF EXISTS ( SELECT
                   NAME
                   FROM SYS.PROCEDURES
                   WHERE
                   NAME = 'proc_CT_FACT_TrackerCompositeDetails_TrackerInstance_Tracker') 
    BEGIN
        PRINT 'UPDATING proc_CT_FACT_TrackerCompositeDetails_TrackerInstance_Tracker.sql';
        DROP PROCEDURE
             PROC_CT_FACT_TRACKERCOMPOSITEDETAILS_TRACKERINSTANCE_TRACKER;
    END;
GO

/*-----------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------
select count(*) from FACT_EDW_TrackerCompositeDetails where TrackerNameAggregateTable = 'HFit_TrackerInstance_Tracker'
select count(*) from BASE_HFit_TrackerInstance_Tracker
delete from FACT_EDW_TrackerCompositeDetails where TrackerNameAggregateTable = 'HFit_TrackerInstance_Tracker'
DBCC FREEPROCCACHE
exec proc_CT_FACT_TrackerCompositeDetails_TrackerInstance_Tracker ;
select top 100 * from BASE_HFit_TrackerInstance_Tracker
update BASE_HFit_TrackerInstance_Tracker set HAshCode = '@' where ItemID in (select top 1000 itemid from BASE_HFit_TrackerInstance_Tracker)
*/

CREATE PROCEDURE proc_CT_FACT_TrackerCompositeDetails_TrackerInstance_Tracker
AS
BEGIN

    --SET TRANSACTION ISOLATION LEVEL SNAPSHOT;

    DECLARE
    @AggregateTableName AS NVARCHAR ( 100) = 'HFit_TrackerInstance_Tracker';
    DECLARE
    @Msg AS NVARCHAR ( 1000) = '';
    DECLARE
    @Stepsecs AS BIGINT = 0;
    DECLARE
    @Totalsecs AS BIGINT = 0;
    DECLARE
    @Starttime AS DATETIME = GETDATE () ;
    DECLARE
    @Step1time AS DATETIME = GETDATE () ;
    DECLARE
    @Step2time AS DATETIME = GETDATE () ;
    DECLARE
    @Step3time AS DATETIME = GETDATE () ;
    DECLARE
    @Step4time AS DATETIME = GETDATE () ;
    DECLARE
    @Step5time AS DATETIME = GETDATE () ;
    DECLARE
    @Step6time AS DATETIME = GETDATE () ;
    DECLARE
    @Synchronization_Version AS BIGINT = NULL;
    DECLARE
    @Lastversion AS BIGINT = 0;
    DECLARE
    @Icnt AS BIGINT = 0;
    DECLARE
    @Ichanges AS BIGINT = 0;
    SET @Synchronization_Version = CHANGE_TRACKING_CURRENT_VERSION () ;
    EXEC @Lastversion = PROC_MASTER_LKP_CTVERSION_FETCH 'BASE_HFit_TrackerInstance_Tracker' , 'proc_CT_FACT_TrackerCompositeDetails_TrackerInstance_Tracker';
    EXEC PRINTIMMEDIATE 'Processing BASE_HFit_TrackerInstance_Tracker';
    SET @Msg = 'Pulling CT Version: ' + CAST ( @Lastversion AS NVARCHAR ( 50)) ;
    EXEC PRINTIMMEDIATE @Msg;

    -- select * from information_schema.tables where table_name like '%small%'

    EXEC @Icnt = PROC_QUICKROWCOUNT BASE_HFIT_TRACKERINSTANCE_TRACKER;
    SET @Msg = 'Total rows in Base Table: ' + CAST ( @Icnt AS NVARCHAR ( 50)) ;
    EXEC PRINTIMMEDIATE @Msg;

    --******************************************************
    --CHECKPOINT;

    BEGIN TRY
        DROP TABLE
             #TRACKERDATA;
    END TRY
    BEGIN CATCH
        EXEC PRINTIMMEDIATE 'Loading temp table';
    END CATCH;
    SELECT
           ITEMID
         , SYS_CHANGE_VERSION
         , SYS_CHANGE_OPERATION
         , SYS_CHANGE_COLUMNS
         , SVR
         , DBNAME INTO
                       #TRACKERDATA
           FROM CHANGETABLE (CHANGES BASE_HFIT_TRACKERINSTANCE_TRACKER, @Lastversion) AS CT;
    CREATE CLUSTERED INDEX PK_TT ON #TRACKERDATA ( SVR , DBNAME , ITEMID , SYS_CHANGE_OPERATION) ;
    SET @Ichanges = ( SELECT
                             COUNT ( *) 
                             FROM #TRACKERDATA );
    IF @Ichanges < 10
        BEGIN

            --EXEC proc_MASTER_LKP_CTVersion_Update  'BASE_HFit_TrackerInstance_Tracker', 'proc_CT_FACT_TrackerCompositeDetails_TrackerInstance_Tracker' , @synchronization_version;

            PRINT 'No changes registered to process.';
        END;
    SET @Msg = 'Starting Time: ' + CAST ( GETDATE () AS NVARCHAR ( 50)) ;
    EXEC PRINTIMMEDIATE @Msg;
    SET @Icnt = ( SELECT
                         COUNT ( *) 
                         FROM FACT_EDW_TRACKERCOMPOSITEDETAILS
                         WHERE
                         TRACKERNAMEAGGREGATETABLE = @AggregateTableName );
    IF
    @Ichanges < 10
AND @Icnt > 0
        BEGIN

            --No changes found and RELOAD NOT needed. If reload needed, delete all entries for this table in the FACT table.

            EXEC PROC_MASTER_LKP_CTVERSION_UPDATE  'BASE_HFit_TrackerInstance_Tracker' , 'proc_CT_FACT_TrackerCompositeDetails_TrackerInstance_Tracker' , @Synchronization_Version;
            PRINT 'No changes found to process, returning.';
            SET @Msg = 'END Time: ' + CAST ( GETDATE () AS NVARCHAR ( 50)) ;
            EXEC PRINTIMMEDIATE @Msg;
            RETURN;
        END;

    --If no records exists in the 

    IF @Icnt = 0
        BEGIN
            EXEC PRINTIMMEDIATE 'RELOADING ALL RECORDS...';
            truncate TABLE #TRACKERDATA;
            INSERT INTO #TRACKERDATA (
                   ITEMID
                 , SYS_CHANGE_VERSION
                 , SYS_CHANGE_OPERATION
                 , SYS_CHANGE_COLUMNS
                 , SVR
                 , DBNAME) 
            SELECT

            --  'HFit_TrackerInstance_Tracker' AS TrackerNameAggregateTable

                   ITEMID
          , 0 AS SYS_CHANGE_VERSION
          , 'I' AS SYS_CHANGE_OPERATION
          , NULL AS SYS_CHANGE_COLUMNS
          , SVR
          , DBNAME
                   FROM BASE_HFIT_TRACKERINSTANCE_TRACKER;
        END;
    SET @Icnt = ( SELECT
                         COUNT ( *) 
                         FROM #TRACKERDATA );
    SET @Msg = 'Total Records to Process: ' + CAST ( @Icnt AS NVARCHAR ( 50)) ;
    EXEC PRINTIMMEDIATE @Msg;

    --select * from information_schema.columns where (table_name = 'FACT_EDW_TrackerCompositeDetails'
    --or table_name = 'BASE_HFit_TrackerInstance_Tracker') and Data_type like '%varchar%'
    --order by column_name, table_name
    --truncate table FACT_EDW_TrackerCompositeDetails

    INSERT INTO FACT_EDW_TRACKERCOMPOSITEDETAILS
    (
           TRACKERNAMEAGGREGATETABLE
         , ITEMID
         , EVENTDATE
         , ISPROFESSIONALLYCOLLECTED
         , TRACKERCOLLECTIONSOURCEID
         , NOTES
         , USERID
         , COLLECTIONSOURCENAME_INTERNAL
         , COLLECTIONSOURCENAME_EXTERNAL
         , EVENTNAME
         , UOM
         , KEY1
         , VAL1
         , KEY2
         , VAL2
         , KEY3
         , VAL3
         , KEY4
         , VAL4
         , KEY5
         , VAL5
         , KEY6
         , VAL6
         , KEY7
         , VAL7
         , KEY8
         , VAL8
         , KEY9
         , VAL9
         , KEY10
         , VAL10
         , ITEMCREATEDBY
         , ITEMCREATEDWHEN
         , ITEMMODIFIEDBY
         , ITEMMODIFIEDWHEN
         , ISPROCESSEDFORHA
         , TXTKEY1
         , TXTVAL1
         , TXTKEY2
         , TXTVAL2
         , TXTKEY3
         , TXTVAL3
         , ITEMORDER
         , ITEMGUID
         , USERGUID
         , MPI
         , CLIENTCODE
         , VENDORID
         , VENDORNAME
         , LASTMODIFIEDDATE
         , SVR
         , DBNAME) 
    SELECT DISTINCT
           'HFit_TrackerInstance_Tracker' AS TRACKERNAMEAGGREGATETABLE
         , TT.ITEMID
         , CAST ( EVENTDATE AS DATETIME) AS EVENTDATE
         , TT.ISPROFESSIONALLYCOLLECTED
         , TT.TRACKERCOLLECTIONSOURCEID
         , NOTES
         , TT.USERID
         , NULL AS COLLECTIONSOURCENAME_INTERNAL
         , NULL AS COLLECTIONSOURCENAME_EXTERNAL
         , 'MISSING' AS EVENTNAME
         , 'Y/N' AS UOM
         , 'TrackerDefID' AS KEY1
         , CAST ( TRACKERDEFID AS FLOAT) AS VAL1
         , 'YesNoValue' AS KEY2
         , CAST ( YESNOVALUE AS FLOAT) AS VAL2
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
         , TT.ITEMCREATEDBY
         , CAST ( TT.ITEMCREATEDWHEN AS DATETIME) AS ITEMCREATEDWHEN
         , TT.ITEMMODIFIEDBY
         , CAST ( TT.ITEMMODIFIEDWHEN AS DATETIME) AS ITEMMODIFIEDWHEN
         , NULL AS ISPROCESSEDFORHA
         , 'NA' AS TXTKEY1
         , NULL AS TXTVAL1
         , 'NA' AS TXTKEY2
         , NULL AS TXTVAL2
         , 'NA' AS TXTKEY3
         , NULL AS TXTVAL3
         , NULL AS ITEMORDER
         , NULL AS ITEMGUID
         , C.USERGUID
         , PP.MPI
         , PP.CLIENTCODE
         , NULL AS VENDORID

           --VENDOR.ItemID as VendorID

         , NULL AS VENDORNAME

           --VENDOR.VendorName

         , TT.LASTMODIFIEDDATE
         , TT.SVR
         , TT.DBNAME
           FROM DBO.BASE_HFIT_TRACKERINSTANCE_TRACKER AS TT
                    INNER JOIN #TRACKERDATA AS TD
                        ON TT.SVR = TD.SVR
                       AND TT.DBNAME = TD.DBNAME
                       AND TT.ITEMID = TD.ITEMID
                       AND TD.SYS_CHANGE_OPERATION = 'I'
                    INNER JOIN DBO.BASE_CMS_USER AS C
                        ON C.USERID = TT.USERID
                       AND C.SVR = TT.SVR
                       AND C.DBNAME = TT.DBNAME
                    INNER JOIN DBO.BASE_HFIT_PPTELIGIBILITY AS PP
                        ON TT.USERID = PP.USERID
                       AND TT.SVR = PP.SVR
                       AND TT.DBNAME = PP.DBNAME;
    SET @Stepsecs = DATEDIFF ( SECOND , @Starttime , GETDATE ()) ;
    SET @Msg = 'Step1 seconds: ' + CAST ( @Stepsecs AS NVARCHAR ( 50)) ;
    EXEC PRINTIMMEDIATE @Msg;
    SET @Step2time = GETDATE () ;

    --******************************************************
    --CHECKPOINT;

    UPDATE FT
           SET
               FT.ACCOUNTID = ACCT.ACCOUNTID
             ,FT.ACCOUNTCD = ACCT.ACCOUNTCD
               FROM FACT_EDW_TRACKERCOMPOSITEDETAILS AS FT
                        INNER JOIN DBO.BASE_HFIT_ACCOUNT AS ACCT
                            ON
                            FT.CLIENTCODE = ACCT.ACCOUNTCD
                        AND FT.SVR = ACCT.SVR
                        AND FT.DBNAME = ACCT.DBNAME
                        AND FT.TRACKERNAMEAGGREGATETABLE = 'HFit_TrackerInstance_Tracker'
                        INNER JOIN #TrackerData AS TD
                            ON
                            FT.SVR = TD.SVR
                        AND FT.DBNAME = TD.DBNAME
                        AND FT.ItemID = TD.ItemID
                        AND FT.TrackerNameAggregateTable = @AggregateTableName;

    SET @Stepsecs = DATEDIFF ( SECOND , @Step1time , @Step2time) ;
    SET @Msg = 'Step2 seconds: ' + CAST ( @Stepsecs AS NVARCHAR ( 50)) ;
    EXEC PRINTIMMEDIATE @Msg;
    SET @Step3time = GETDATE () ;

    --******************************************************
    --CHECKPOINT;

    UPDATE FT
           SET
               FT.ACCOUNTCD = ACCT.ACCOUNTCD
               FROM FACT_EDW_TRACKERCOMPOSITEDETAILS AS FT
                        INNER JOIN DBO.BASE_HFIT_ACCOUNT AS ACCT
                            ON
                            FT.CLIENTCODE = ACCT.ACCOUNTCD
                        AND FT.SVR = ACCT.SVR
                        AND FT.DBNAME = ACCT.DBNAME
                        AND FT.TRACKERNAMEAGGREGATETABLE = 'HFit_TrackerInstance_Tracker'
                        INNER JOIN #TrackerData AS TD
                            ON
                            FT.SVR = TD.SVR
                        AND FT.DBNAME = TD.DBNAME
                        AND FT.ItemID = TD.ItemID
                        AND FT.TrackerNameAggregateTable = @AggregateTableName;

    SET @Stepsecs = DATEDIFF ( SECOND , @Step2time , @Step3time) ;
    SET @Msg = 'Step3 seconds: ' + CAST ( @Stepsecs AS NVARCHAR ( 50)) ;
    EXEC PRINTIMMEDIATE @Msg;
    SET @Step4time = GETDATE () ;

    --******************************************************
    --CHECKPOINT;

    UPDATE FT
           SET
               FT.SITEGUID = S.SITEGUID
               FROM FACT_EDW_TRACKERCOMPOSITEDETAILS AS FT
                        INNER JOIN #TRACKERDATA AS TD
                            ON
                            FT.SVR = TD.SVR
                        AND FT.DBNAME = TD.DBNAME
                        AND FT.ITEMID = TD.ITEMID
                        AND FT.TRACKERNAMEAGGREGATETABLE = @AggregateTableName
                        INNER JOIN DBO.BASE_HFIT_ACCOUNT AS ACCT
                            ON
                            FT.ACCOUNTCD = ACCT.ACCOUNTCD
                        AND FT.SVR = ACCT.SVR
                        AND FT.DBNAME = ACCT.DBNAME
                        INNER JOIN DBO.BASE_CMS_SITE AS S
                            ON
                            ACCT.SITEID = S.SITEID
                        AND ACCT.SVR = S.SVR
                        AND ACCT.DBNAME = S.DBNAME;
    SET @Stepsecs = DATEDIFF ( SECOND , @Step3time , @Step4time) ;
    SET @Msg = 'Step4 seconds: ' + CAST ( @Stepsecs AS NVARCHAR ( 50)) ;
    EXEC PRINTIMMEDIATE @Msg;
    SET @Step5time = GETDATE () ;

    --******************************************************
    --CHECKPOINT;

    EXEC PRINTIMMEDIATE 'Starting Step5';
    UPDATE FT
           SET
               FT.COLLECTIONSOURCENAME_INTERNAL = TC.COLLECTIONSOURCENAME_INTERNAL
             ,FT.COLLECTIONSOURCENAME_EXTERNAL = TC.COLLECTIONSOURCENAME_EXTERNAL
               FROM FACT_EDW_TRACKERCOMPOSITEDETAILS AS FT
                        INNER JOIN #TRACKERDATA AS TD
                            ON
                            FT.SVR = TD.SVR
                        AND FT.DBNAME = TD.DBNAME
                        AND FT.ITEMID = TD.ITEMID
                        AND FT.TRACKERNAMEAGGREGATETABLE = @AggregateTableName
                        INNER JOIN DBO.BASE_HFIT_TRACKERCOLLECTIONSOURCE AS TC
                            ON
                            TC.TRACKERCOLLECTIONSOURCEID = FT.TRACKERCOLLECTIONSOURCEID
                        AND TC.SVR = FT.SVR
                        AND TC.DBNAME = FT.DBNAME;

    --UPDATE FT
    --       SET
    --           FT.CollectionSourceName_Internal = TC.CollectionSourceName_Internal
    --         ,FT.CollectionSourceName_External = TC.CollectionSourceName_External
    --           FROM BASE_HFit_TrackerInstance_Tracker AS BT
    --                    INNER JOIN #TrackerData AS TD
    --                        ON BT.SVR = TD.SVR
    --                       AND BT.DBNAME = TD.DBNAME
    --                       AND BT.ItemID = TD.ItemID
    --                    JOIN FACT_EDW_TrackerCompositeDetails AS FT
    --                        ON
    --                        BT.ItemID = FT.ItemID
    --                    AND FT.SVR = BT.SVR
    --                    AND FT.DBNAME = BT.DBNAME
    --                    AND FT.TrackerNameAggregateTable = 'HFit_TrackerInstance_Tracker'
    --                    INNER JOIN dbo.BASE_HFit_TrackerCollectionSource AS TC
    --                        ON
    --                        TC.TrackerCollectionSourceID = BT.TrackerCollectionSourceID
    --                    AND TC.SVR = BT.SVR
    --                    AND TC.DBNAME = BT.DBNAME  OPTION (
    --                                                      MAXDOP 1) ;

    SET @Stepsecs = DATEDIFF ( SECOND , @Step4time , @Step5time) ;
    SET @Msg = 'Step5 seconds: ' + CAST ( @Stepsecs AS NVARCHAR ( 50)) ;
    EXEC PRINTIMMEDIATE @Msg;
    SET @Step6time = GETDATE () ;

    --******************************************************
    --CHECKPOINT;
    -- Select * from BASE_HFit_Tracker where AggregateTableName like '%_TrackerInstance_Tracker%'

    UPDATE FT
           SET
               FT.ISAVAILABLE = T.ISAVAILABLE
             ,FT.ISCUSTOM = T.ISCUSTOM
             ,FT.UNIQUENAME = T.UNIQUENAME
             ,FT.COLDESC = T.UNIQUENAME
               FROM FACT_EDW_TRACKERCOMPOSITEDETAILS AS FT
                        INNER JOIN #TRACKERDATA AS TD
                            ON
                            FT.SVR = TD.SVR
                        AND FT.DBNAME = TD.DBNAME
                        AND FT.ITEMID = TD.ITEMID
                        AND FT.TRACKERNAMEAGGREGATETABLE = 'HFit_TrackerInstance_Tracker'
                        JOIN DBO.BASE_HFIT_TRACKER AS T
                            ON
                            T.AGGREGATETABLENAME = 'HFit_TrackerInstance_Tracker'
                        AND T.SVR = FT.SVR
                        AND T.DBNAME = FT.DBNAME;

    --OPTION (MAXDOP 1) ;

    SET @Stepsecs = DATEDIFF ( SECOND , @Step5time , @Step6time) ;
    SET @Msg = 'Step6 seconds: ' + CAST ( @Stepsecs AS NVARCHAR ( 50)) ;
    EXEC PRINTIMMEDIATE @Msg;
    SET @Stepsecs = DATEDIFF ( SECOND , @Starttime , GETDATE ()) ;
    SET @Msg = 'Total Time in seconds: ' + CAST ( @Stepsecs AS NVARCHAR ( 50)) ;
    EXEC PRINTIMMEDIATE @Msg;
    EXEC PROC_MASTER_LKP_CTVERSION_UPDATE  'BASE_HFit_TrackerInstance_Tracker' , 'proc_CT_FACT_TrackerCompositeDetails_TrackerInstance_Tracker' , @Synchronization_Version;
    EXEC PRINTIMMEDIATE 'Ending Time: ';
    PRINT GETDATE () ;
END;
GO
PRINT 'Executed proc_CT_FACT_TrackerCompositeDetails_TrackerInstance_Tracker.sql';
GO
