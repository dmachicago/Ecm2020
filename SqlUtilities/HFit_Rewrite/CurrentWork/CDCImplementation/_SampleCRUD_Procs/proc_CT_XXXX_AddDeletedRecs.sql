
GO
-- use KenticoCMS_Prod1

GO
PRINT 'Executing proc_CT_XXXX_AddDeletedRecs.sql';
GO
IF EXISTS ( SELECT
                   name
                   FROM sys.procedures
                   WHERE name = 'proc_CT_XXXX_AddDeletedRecs') 
    BEGIN
        DROP PROCEDURE
             proc_CT_XXXX_AddDeletedRecs;
    END;
GO
-- exec proc_CT_XXXX_AddDeletedRecs
CREATE PROCEDURE proc_CT_XXXX_AddDeletedRecs
AS
BEGIN

WDMXX

    DECLARE
    @iInserts AS int = @@ROWCOUNT;

    UPDATE STAGING_EDW_XXXX
      SET
          LastModifiedDate = GETDATE () 
           WHERE
                 LastModifiedDate IS NULL AND
                 DeletedFlg IS NOT NULL;

    PRINT 'Deleted Record Count: ' + CAST ( @iInserts AS nvarchar (50)) ;
    RETURN @iInserts;
END;

GO
PRINT 'Executed proc_CT_XXXX_AddDeletedRecs.sql';
GO
