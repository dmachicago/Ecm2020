

go
-- use KenticoCMS_Prod1
GO
PRINT 'Executing proc_CT_HealthInterestList_AddUpdatedRecs.sql';
GO
IF EXISTS ( SELECT
                   name
                   FROM sys.procedures
                   WHERE name = 'proc_CT_HealthInterestList_AddUpdatedRecs') 
    BEGIN
        DROP PROCEDURE
             proc_CT_HealthInterestList_AddUpdatedRecs;
    END;
GO
CREATE PROCEDURE proc_CT_HealthInterestList_AddUpdatedRecs
AS
BEGIN

        DECLARE @RUNDATE AS datetime2 ( 7) = GETDATE () ;

        UPDATE S
          SET
              S.HealthAreaName = T.HealthAreaName
            ,S.HealthAreaDescription = T.HealthAreaDescription
            ,S.CodeName = T.CodeName
            ,S.DocumentCreatedWhen = T.DocumentCreatedWhen
            ,S.DocumentModifiedWhen = T.DocumentModifiedWhen
            ,S.HashCode = T.HashCode
            ,S.LastModifiedDate = GETDATE () 
            ,S.ConvertedToCentralTime = NULL

              FROM ##Temp_HealthInterestList AS T
                        JOIN DIM_EDW_HealthInterestList AS S
                        ON
                        S.HealthAreaID = T.HealthAreaID AND
                        S.NodeID = T.NodeID AND
                        S.NodeGuid = T.NodeGuid AND
                        S.AccountCD = T.AccountCD AND
                        S.HASHCODE != T.HASHCODE AND
                        S.DeletedFlg IS NULL;
 
    DECLARE
    @iInserts AS int = @@ROWCOUNT;
    PRINT 'Updated Record Count: ' + CAST ( @iInserts AS nvarchar (50)) ;
    RETURN @iInserts;
END;

GO
PRINT 'Executed proc_CT_HealthInterestList_AddUpdatedRecs.sql';
GO
