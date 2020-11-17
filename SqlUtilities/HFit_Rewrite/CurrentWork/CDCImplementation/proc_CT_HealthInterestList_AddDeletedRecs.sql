
GO
-- use KenticoCMS_Prod1

GO
PRINT 'Executing proc_CT_HealthInterestList_AddDeletedRecs.sql';
GO
IF EXISTS ( SELECT
                   name
                   FROM sys.procedures
                   WHERE name = 'proc_CT_HealthInterestList_AddDeletedRecs') 
    BEGIN
        DROP PROCEDURE
             proc_CT_HealthInterestList_AddDeletedRecs;
    END;
GO
-- exec proc_CT_HealthInterestList_AddDeletedRecs
CREATE PROCEDURE proc_CT_HealthInterestList_AddDeletedRecs
AS
BEGIN
      
        WITH CTE_DEL (
             HealthAreaID
           , NodeID
           , NodeGuid
           , AccountCD, DeletedFlg) 
            AS ( SELECT
                        HealthAreaID
                      , NodeID
                      , NodeGuid
                      , AccountCD, DeletedFlg
                        FROM DIM_EDW_HealthInterestList
                 EXCEPT
                 SELECT
                        HealthAreaID
                      , NodeID
                      , NodeGuid
                      , AccountCD, DeletedFlg
                        FROM ##Temp_HealthInterestList) 

            UPDATE S
              SET
                  DeletedFlg = 1
                ,LastModifiedDate = GETDATE () 
                  FROM DIM_EDW_HealthInterestList AS S
                            JOIN CTE_DEL AS C
                            ON
                            S.HealthAreaID = C.HealthAreaID AND
                            S.NodeID = C.NodeID AND
                            isnull(S.NodeGuid,'00000000-0000-0000-0000-000000000000')  = isnull(C.NodeGuid,'00000000-0000-0000-0000-000000000000')  AND
                            S.AccountCD = C.AccountCD AND
                            isnull(S.DeletedFlg,0)  = 0 ;

    DECLARE
    @iInserts AS int = @@ROWCOUNT;

    UPDATE DIM_EDW_HealthInterestList
      SET
          LastModifiedDate = GETDATE () 
           WHERE
                 LastModifiedDate IS NULL AND
                 DeletedFlg IS NOT NULL;

    PRINT 'Deleted Record Count: ' + CAST ( @iInserts AS nvarchar (50)) ;
    RETURN @iInserts;
END;

GO
PRINT 'Executed proc_CT_HealthInterestList_AddDeletedRecs.sql';
GO
