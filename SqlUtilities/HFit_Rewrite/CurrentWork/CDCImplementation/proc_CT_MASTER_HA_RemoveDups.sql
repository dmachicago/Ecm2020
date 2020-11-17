


GO
PRINT 'Executing proc_CT_MASTER_HA_RemoveDups.sql';
GO

IF EXISTS (SELECT name
             FROM sys.procedures
             WHERE name = 'proc_CT_MASTER_HA_RemoveDups') 
    BEGIN
        DROP PROCEDURE proc_CT_MASTER_HA_RemoveDups;
    END;
GO

CREATE PROCEDURE proc_CT_MASTER_HA_RemoveDups (@ModDate datetime) 
AS
BEGIN


    DISABLE TRIGGER TRIG_DEL_BASE_HFit_HealthAssesmentUserStarted ON BASE_HFit_HealthAssesmentUserStarted;
    DISABLE TRIGGER TRIG_DEL_BASE_HFit_HealthAssesmentUserStarted_HA_Sync ON BASE_HFit_HealthAssesmentUserStarted;
    DISABLE TRIGGER TRIG_UPDT_BASE_HFit_HealthAssesmentUserStarted ON BASE_HFit_HealthAssesmentUserStarted;

    WITH CTE (DBNAME
            , ItemID
            , SYS_CHANGE_VERSION
            , DuplicateCount) 
        AS (SELECT DBNAME
                 , ItemID
                 , SYS_CHANGE_VERSION
                 , ROW_NUMBER () OVER (PARTITION BY DBNAME
                                                  , ItemID
                                                  , SYS_CHANGE_VERSION ORDER BY DBNAME, ItemID, SYS_CHANGE_VERSION) AS DuplicateCount
              FROM BASE_HFit_HealthAssesmentUserStarted) 
        DELETE FROM CTE
        WHERE DuplicateCount > 1;

    ENABLE TRIGGER TRIG_DEL_BASE_HFit_HealthAssesmentUserStarted ON BASE_HFit_HealthAssesmentUserStarted;
    ENABLE TRIGGER TRIG_DEL_BASE_HFit_HealthAssesmentUserStarted_HA_Sync ON BASE_HFit_HealthAssesmentUserStarted;
    ENABLE TRIGGER TRIG_UPDT_BASE_HFit_HealthAssesmentUserStarted ON BASE_HFit_HealthAssesmentUserStarted;

END;

GO
PRINT 'Executed proc_CT_MASTER_HA_RemoveDups.sql';
GO
