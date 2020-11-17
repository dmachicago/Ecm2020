
GO
PRINT 'Creating proc_CkUserTrackerHasChanged';
PRINT 'FROM proc_CkUserTrackerHasChanged.sql';

IF EXISTS (SELECT
              name
                  FROM sys.procedures
                  WHERE name = 'proc_CkUserTrackerHasChanged') 
    BEGIN
        DROP PROCEDURE
           proc_CkUserTrackerHasChanged
    END;
GO

CREATE PROC proc_CkUserTrackerHasChanged
AS
BEGIN

    DECLARE
    @UpdatesFOund TABLE (
       ChangeType nvarchar (10) NULL) ;
    DECLARE
    @b AS bit = 0;

    INSERT INTO @UpdatesFOund
    SELECT
       SYS_CHANGE_OPERATION
           FROM CHANGETABLE (CHANGES HFit_UserTracker, NULL) AS CT
    UNION
    SELECT
       SYS_CHANGE_OPERATION
           FROM CHANGETABLE (CHANGES CMS_Site, NULL) AS CT
    UNION
    SELECT
       SYS_CHANGE_OPERATION
           FROM CHANGETABLE (CHANGES CMS_UserSettings, NULL) AS CT
    UNION
    SELECT
       SYS_CHANGE_OPERATION
           FROM CHANGETABLE (CHANGES CMS_UserSettings, NULL) AS CT
    UNION
    SELECT
       SYS_CHANGE_OPERATION
           FROM CHANGETABLE (CHANGES HFit_Account, NULL) AS CT
    UNION
    SELECT
       SYS_CHANGE_OPERATION
           FROM CHANGETABLE (CHANGES HFit_TrackerCollectionSource, NULL) AS CT;

    DECLARE @NbrUpdates AS int = @@ROWCOUNT;

    IF @NbrUpdates = 0
        BEGIN
            PRINT 'No changes found';
            SET @b = 0;
        END;
    ELSE
        BEGIN
            PRINT 'Changes found';
            SET @b = 1;
            IF EXISTS (SELECT
                          ChangeType
                              FROM @UpdatesFOund
                              WHERE ChangeType = 'D') 
                BEGIN
                    PRINT 'DELETES found';
                    SET @b = 2;
                END;
            RETURN @b;
        END;
END;
GO
PRINT 'Created proc_CkUserTrackerHasChanged';
GO