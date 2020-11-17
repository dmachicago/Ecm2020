

go
-- use KenticoCMS_Prod1
GO
PRINT 'Executing proc_CT_XXXX_AddUpdatedRecs.sql';
GO
IF EXISTS ( SELECT
                   name
                   FROM sys.procedures
                   WHERE name = 'proc_CT_XXXX_AddUpdatedRecs') 
    BEGIN
        DROP PROCEDURE
             proc_CT_XXXX_AddUpdatedRecs;
    END;
GO
CREATE PROCEDURE proc_CT_XXXX_AddUpdatedRecs
AS
BEGIN

   wdmxx 
              WHERE
                            S.HashCode != T.HashCode and S.DeletedFlg is null;

    DECLARE
    @iInserts AS int = @@ROWCOUNT;
    PRINT 'Updated Record Count: ' + CAST ( @iInserts AS nvarchar (50)) ;
    RETURN @iInserts;
END;

GO
PRINT 'Executed proc_CT_XXXX_AddUpdatedRecs.sql';
GO
