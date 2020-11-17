
GO
-- use KenticoCMS_Prod1

GO
PRINT 'Executing proc_CT_HealthInterestList_AddNewRecs.sql';
GO
IF EXISTS ( SELECT
                   name
                   FROM sys.procedures
                   WHERE name = 'proc_CT_HealthInterestList_AddNewRecs') 
    BEGIN
        DROP PROCEDURE
             proc_CT_HealthInterestList_AddNewRecs;
    END;
GO
CREATE PROCEDURE proc_CT_HealthInterestList_AddNewRecs
AS
BEGIN

    WITH CTE_NEW (
         HealthAreaID
       , NodeID
       , NodeGuid
       , AccountCD) 
        AS ( SELECT
                    HealthAreaID
                  , NodeID
                  , NodeGuid
                  , AccountCD
                    FROM ##Temp_HealthInterestList
             EXCEPT
             SELECT
                    HealthAreaID
                  , NodeID
                  , NodeGuid
                  , AccountCD
                    FROM DIM_EDW_HealthInterestList
                    WHERE LastModifiedDate IS NULL) 
        INSERT INTO DIM_EDW_HealthInterestList
        SELECT
               T.HealthAreaID
             , T.NodeID
             , T.NodeGuid
             , T.AccountCD
             , T.HealthAreaName
             , T.HealthAreaDescription
             , T.CodeName
             , T.DocumentCreatedWhen
             , T.DocumentModifiedWhen
             , T.HashCode
             , T.SVR
             , T.DBNAME
             , NULL AS LastModifiedDate
             , NULL AS RowNbr
             , NULL AS DeletedFlg
             , NULL AS TimeZone
             , NULL AS ConvertedToCentralTime
               FROM
                    ##Temp_HealthInterestList AS T
                         JOIN CTE_NEW AS C
                         ON
                            T.HealthAreaID = C.HealthAreaID AND
                            T.NodeID = C.NodeID AND
                            T.NodeGuid = C.NodeGuid AND
                            T.AccountCD = C.AccountCD;

    DECLARE
    @iInserts AS int = @@ROWCOUNT;
    PRINT 'NEW Insert Count: ' + CAST ( @iInserts AS nvarchar (50)) ;
    RETURN @iInserts;
END;

GO
PRINT 'Executed proc_CT_HealthInterestList_AddNewRecs.sql';
GO
