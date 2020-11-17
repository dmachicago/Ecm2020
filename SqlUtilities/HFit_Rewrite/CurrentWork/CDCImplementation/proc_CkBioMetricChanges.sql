

GO
PRINT 'executing proc_CkBioMetricChanges.sql';
-- Use KenticoCMS_Datamart_2
-- select * from information_schema.columns where table_name like '%BioMetrics%'
GO
IF EXISTS (SELECT
                  name
                  FROM sys.procedures
                  WHERE name = 'proc_CkBioMetricChanges') 
    BEGIN
        DROP PROCEDURE
             proc_CkBioMetricChanges
    END;

GO

CREATE PROCEDURE proc_CkBioMetricChanges
AS
BEGIN

    IF EXISTS ( SELECT
                       name
                       FROM tempdb.dbo.sysobjects
                       WHERE id = OBJECT_ID ( N'tempdb..##TEMP_BIO_TYPECHANGES') 

    ) 
        BEGIN
            PRINT 'Dropping ##TEMP_BIO_TYPECHANGES';
            DROP TABLE
                 ##TEMP_BIO_TYPECHANGES;
        END;
    --select * from  ##TEMP_BIO_TYPECHANGES
    DECLARE @iType AS int = 0;
    SELECT
           * INTO
                  ##TEMP_BIO_TYPECHANGES
           FROM(
                SELECT
                       SYS_CHANGE_OPERATION
                       FROM CHANGETABLE (CHANGES BASE_HFit_UserTracker, NULL) AS CT
                UNION ALL
                SELECT
                       SYS_CHANGE_OPERATION
                       FROM CHANGETABLE (CHANGES BASE_CMS_Site, NULL) AS CT
                UNION ALL
                SELECT
                       SYS_CHANGE_OPERATION
                       FROM CHANGETABLE (CHANGES BASE_CMS_UserSettings, NULL) AS CT
                UNION ALL
                SELECT
                       SYS_CHANGE_OPERATION
                       FROM CHANGETABLE (CHANGES BASE_CMS_UserSettings, NULL) AS CT
                UNION ALL
                SELECT
                       SYS_CHANGE_OPERATION
                       FROM CHANGETABLE (CHANGES BASE_HFit_Account, NULL) AS CT
                UNION ALL
                SELECT
                       SYS_CHANGE_OPERATION
                       FROM CHANGETABLE (CHANGES BASE_HFit_TrackerCollectionSource, NULL) AS CT)AS t;

    DECLARE
    @iUpdatesPresent AS int = @@ROWCOUNT;

    DECLARE
    @iDeletesPresent AS int = ( SELECT
                                       COUNT ( *) 

                                       FROM ##TEMP_BIO_TYPECHANGES
                                       WHERE SYS_CHANGE_OPERATION = 'D');
    IF @iDeletesPresent > 0
        BEGIN
            SET @iType = 2;
            RETURN @iType;
        END;

    IF @iUpdatesPresent > 0
        BEGIN
            SET @iType = 1;
        END;
    ELSE
        BEGIN
            SET @iType = 0;
        END;

    RETURN @iType;

END;

GO
PRINT 'executed proc_CkBioMetricChanges.sql';
GO
