
-- use KenticoCMS_Datamart
-- use [KenticoCMS_DataMart_2]

GO
IF EXISTS (SELECT
                  name
           FROM sys.procedures
           WHERE
                  name = 'proc_CleanFACT_TrackerData') 
    BEGIN
        PRINT 'Replacing proc_CleanFACT_TrackerData';
        DROP PROCEDURE
             proc_CleanFACT_TrackerData;
    END;
GO
CREATE PROCEDURE proc_CleanFACT_TrackerData
AS
BEGIN
    IF OBJECT_ID ('TEMPDB..#MissingKeys') IS NOT NULL
        BEGIN
            DROP TABLE
                 #MissingKeys;
        END;

    SELECT
           T.SurrogateKey_FACT_TrackerData INTO
                                                #MissingKeys
    FROM
         FACT_TrackerData AS T
         LEFT OUTER JOIN BASE_CMS_User AS C
         ON
            C.SVR = T.SVR AND
           C.DBNAME = T.DBNAME AND
           C.UserID = T.UserID
    WHERE C.UserID IS NULL;

    DELETE FROM FACT_TrackerData
    WHERE
          SurrogateKey_FACT_TrackerData IN (SELECT
                                                   SurrogateKey_FACT_TrackerData
                                            FROM #MissingKeys) ;
END;

GO
PRINT 'Executing Proc_RenameFACT_RowNumber.sql';
GO
IF EXISTS (SELECT
                  name
           FROM sys.procedures
           WHERE
                  name = 'Proc_RenameFACT_RowNumber') 
    BEGIN
        PRINT 'Replaceing Proc_RenameFACT_RowNumber';
        DROP PROCEDURE
             Proc_RenameFACT_RowNumber;
    END;
GO
-- EXEC Proc_RenameFACT_RowNumber FACT_HFit_TrackerSleepPlan
CREATE PROCEDURE Proc_RenameFACT_RowNumber (
       @TBL AS NVARCHAR (250)) 
AS
BEGIN

    PRINT 'PROCESSING: ' + @TBL;
    DECLARE
           @i AS INT = 0;
    DECLARE
           @TBLCOL AS NVARCHAR (250) ;
    DECLARE
           @NEWCOL AS NVARCHAR (250) ;

    SET @i = (SELECT
                     count (*) 
              FROM information_schema.columns
              WHERE
                     table_name = @TBL AND
                     column_name = 'RowNumber') ;
    IF @i = 0
        BEGIN
            PRINT @TBL + ' does not have a RowNumber column, skipping.';
            RETURN;
        END;

    -- set @TBL = 'FACT_HFit_TrackerCardio'
    SET @TBLCOL = @TBL + '.RowNumber';
    SET @NEWCOL = 'SurrogateKey_' + @TBL;

    EXEC sp_RENAME @TBLCOL , @NEWCOL , 'COLUMN';
END;
GO
PRINT 'Executed Proc_RenameFACT_RowNumber.sql';
GO
