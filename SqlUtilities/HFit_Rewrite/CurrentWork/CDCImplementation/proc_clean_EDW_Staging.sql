
GO
PRINT 'Creating procedure proc_clean_EDW_Staging';
GO

IF EXISTS ( SELECT
                   name
                   FROM sys.procedures
                   WHERE name = 'proc_clean_EDW_Staging') 
    BEGIN
        PRINT 'Recreating procedure proc_clean_EDW_Staging';
        DROP PROCEDURE
             proc_clean_EDW_Staging;
    END;
GO
--exec proc_clean_EDW_Staging
CREATE PROCEDURE proc_clean_EDW_Staging
AS
BEGIN
    WITH CTE (
         SVR
       , DBNAME
       , UserStartedItemID
       , UserGUID
       , PKHashCode
       , DeletedFlg
       , LastModifiedDate
       , DuplicateCount) 
        AS (
        SELECT
               SVR
             , DBNAME
             ,UserStartedItemID
             , UserGUID
             , PKHashCode
             ,DeletedFlg
             ,LastModifiedDate
             ,ROW_NUMBER () OVER ( PARTITION BY  SVR
                                               , DBNAME
                                               , UserStartedItemID
                                               ,UserGUID
                                               ,PKHashCode ORDER BY  SVR, DBNAME, UserStartedItemID, UserGUID, PKHashCode , DeletedFlg , LastModifiedDate) AS DuplicateCount
               FROM FACT_MART_EDW_HealthAssesment
        ) 
        DELETE
        FROM CTE
        WHERE
              DuplicateCount > 1;
END;

GO
PRINT 'Recreated procedure proc_clean_EDW_Staging';
GO
