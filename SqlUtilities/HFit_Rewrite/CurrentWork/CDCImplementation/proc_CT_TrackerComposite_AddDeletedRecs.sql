
GO

PRINT 'Executing proc_CT_TrackerComposite_AddDeletedRecs.sql';

GO

IF EXISTS ( SELECT
                   name
              FROM sys.procedures
              WHERE
              name = 'proc_CT_TrackerComposite_AddDeletedRecs')

    BEGIN

        DROP PROCEDURE
             proc_CT_TrackerComposite_AddDeletedRecs;
    END;

GO

-- select * from ##TempCompositeData
-- select top 100 * from STAGING_EDW_TrackerComposite
-- exec proc_CT_TrackerComposite_AddDeletedRecs

CREATE PROCEDURE proc_CT_TrackerComposite_AddDeletedRecs
AS
BEGIN

    IF NOT EXISTS ( SELECT
                           name
                      FROM tempdb.dbo.sysobjects
                      WHERE
                      id = OBJECT_ID ( N'tempdb..##TempCompositeData'))

        BEGIN

            PRINT 'Reading changed data, standby...';
            EXEC proc_CkTrackerDataChanged;
        END;

    UPDATE S
    SET
        S.DeletedFlg = 1
      ,S.LastModifiedDate = GETDATE ()
      FROM dbo.BASE_FACT_EDW_Trackers AS S
           JOIN
           ##TempCompositeData AS T
               ON
               T.TGTTBL = S.TrackerNameAggregateTable
           AND T.ItemID = S.ItemID
           AND T.SYS_CHANGE_OPERATION = 'D'
           AND S.DeletedFlg IS NULL;

    DECLARE
       @iCnt AS int = @@ROWCOUNT;

    PRINT 'Deleted Count: ' + CAST ( @iCnt AS nvarchar(50));

    RETURN @iCnt;
END;

GO

PRINT 'Executed proc_CT_TrackerComposite_AddDeletedRecs.sql';

GO
