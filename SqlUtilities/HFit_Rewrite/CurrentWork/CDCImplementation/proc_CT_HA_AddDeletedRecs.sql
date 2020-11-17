
GO
PRINT 'Executing proc_CT_HA_AddDeletedRecs.sql';
GO
IF EXISTS (SELECT
                  name
           FROM sys.procedures
           WHERE
                  name = 'proc_CT_HA_AddDeletedRecs') 
    BEGIN
        DROP PROCEDURE
             proc_CT_HA_AddDeletedRecs;
    END;
GO
-- exec proc_CT_HA_AddDeletedRecs
CREATE PROCEDURE proc_CT_HA_AddDeletedRecs
AS
BEGIN
    DECLARE @ST AS DATETIME = GETDATE () ;
    DECLARE @CT AS DATETIME = GETDATE () ;
    DECLARE @ET AS DATETIME = GETDATE () ;

    SET @ET = GETDATE () ;
    EXEC proc_trace 'END Process', @CT, NULL;

/********************************************
--------------------------------------------
    IF ##EdwHAHashkeys is missing, build the 
    HASH KEY TABLE. Normally, this will take 
    about 45 minutes and must be done if 
    DELETES are detected.
********************************************/
    IF OBJECT_ID ('tempdb..##EdwHAHashkeys') IS NULL
        BEGIN EXEC proc_EDW_BuildHAHashkeys;
        END;

    DELETE FROM FACT_MART_EDW_HealthAssesment
    WHERE
          PKHashCode IS NULL;

    DELETE FROM ##EdwHAHashkeys
    WHERE
          PKHashCode IS NULL;

    DECLARE @DELDATE AS DATETIME2 (7) = GETDATE () ;
    -- select top 100 * from ##EdwHAHashkeys
    WITH CTE_DEL (
         UserStartedItemID
       , UserGUID
       , PKHashCode) 
        AS (SELECT
                   UserStartedItemID
                 , UserGUID
                 , PKHashCode
            FROM FACT_MART_EDW_HealthAssesment
            WHERE DeletedFlg IS NULL
            EXCEPT
            SELECT
                   HAUserStarted_ItemID
                 , UserGUID
                 , PKHashCode
            FROM ##EdwHAHashkeys
        --FROM view_EDW_PullHAData_NoCT
        ) 

        UPDATE S
            SET
                DeletedFlg = 1
              ,LastModifiedDate = @DELDATE
              ,ChangeType = 'D'
        FROM FACT_MART_EDW_HealthAssesment AS S
                  JOIN CTE_DEL AS C
                  ON
               C.UserStartedItemID = S.UserStartedItemID AND
               C.UserGUID = S.UserGUID AND
               C.PKHashCode = S.PKHashCode;

    DECLARE @iDels AS INT = @@ROWCOUNT;

    UPDATE FACT_MART_EDW_HealthAssesment
        SET
            LastModifiedDate = GETDATE () 
    WHERE
          LastModifiedDate IS NULL AND DeletedFlg IS NOT NULL;

    PRINT 'Deleted Record Count: ' + CAST (@iDels AS NVARCHAR (50)) ;
    SET @ET = GETDATE () ;
    EXEC proc_trace 'END Process', @CT, @ET;
    RETURN @iDels;
END;

GO
PRINT 'Executed proc_CT_HA_AddDeletedRecs.sql';
GO
