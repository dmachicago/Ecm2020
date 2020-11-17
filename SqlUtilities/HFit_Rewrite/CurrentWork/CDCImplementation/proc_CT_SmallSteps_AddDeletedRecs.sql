

GO
PRINT 'Executing proc_CT_SmallSteps_AddDeletedRecs.sql';
GO
IF EXISTS ( SELECT
                   name
              FROM sys.procedures
              WHERE name = 'proc_CT_SmallSteps_AddDeletedRecs' )
    BEGIN
        DROP PROCEDURE
             proc_CT_SmallSteps_AddDeletedRecs;
    END;
GO
CREATE PROCEDURE proc_CT_SmallSteps_AddDeletedRecs
AS
BEGIN

    WITH CTE (
         HFitUserMPINumber ,
         HashCode )
        AS ( SELECT
                    HFitUserMPINumber ,
                    HashCode
               FROM DIM_EDW_SmallSteps
             EXCEPT
             SELECT
                    HFitUserMPINumber ,
                    HashCode
               FROM ##Temp_SmallSteps )
        UPDATE S
          SET
              S.DeletedFlg = 1 ,
              LastModifiedDate = GETDATE( )
          FROM CTE AS T JOIN
                    DIM_EDW_SmallSteps AS S
                        ON
               S.HFitUserMPINumber = T.HFitUserMPINumber
           AND S.DeletedFlg IS NULL
           AND S.HashCode = T.HashCode;

    DECLARE
       @iCnt AS int = @@ROWCOUNT;
    PRINT 'Deleted Count: ' + CAST ( @iCnt AS nvarchar( 50 ));
    RETURN @iCnt;
END;

GO
PRINT 'Executed proc_CT_SmallSteps_AddDeletedRecs.sql';
GO
