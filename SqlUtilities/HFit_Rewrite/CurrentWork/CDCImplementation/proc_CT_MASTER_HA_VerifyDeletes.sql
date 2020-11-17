
GO
PRINT 'Executing proc_CT_MASTER_HA_VerifyDeletes.sql';
GO

IF EXISTS (SELECT name
             FROM sys.procedures
             WHERE name = 'proc_CT_MASTER_HA_VerifyDeletes') 
    BEGIN
        PRINT 'UPDATING proc_CT_MASTER_HA_VerifyDeletes.sql';
        DROP PROCEDURE proc_CT_MASTER_HA_VerifyDeletes;
    END;
GO
CREATE PROCEDURE proc_CT_MASTER_HA_VerifyDeletes
AS
BEGIN
    WITH CTE (DBNAME
            , ItemID) 
        AS (SELECT DBNAME
                 , UserStartedItemID
              FROM BASE_MART_EDW_HealthAssesment
            EXCEPT
            SELECT DBNAME
                 , ItemID
              FROM BASE_HFit_HealthAssesmentUserStarted) 
        DELETE BaseHA
          FROM BASE_MART_EDW_HealthAssesment BaseHA
               INNER JOIN
               CTE C
               ON BaseHA.DBNAME = C.DBNAME
              AND BaseHA.UserStartedItemID = C.ItemID;

    DELETE BaseHA
      FROM BASE_MART_EDW_HealthAssesment BaseHA
           INNER JOIN
           TEMP_HA_Changes C
           ON BaseHA.DBNAME = C.DBNAME
          AND BaseHA.UserStartedItemID = C.ItemID
          AND C.SYS_CHANGE_OPERATION = 'D';


END;
GO
PRINT 'Executed proc_CT_MASTER_HA_VerifyDeletes.sql';
GO