
GO
-- use KenticoCMS_Prod1

GO
PRINT 'Executing proc_CT_HealthInterestDetail_AddDeletedRecs.sql';
GO
IF EXISTS ( SELECT
                   name
                   FROM sys.procedures
                   WHERE name = 'proc_CT_HealthInterestDetail_AddDeletedRecs') 
    BEGIN
        DROP PROCEDURE
             proc_CT_HealthInterestDetail_AddDeletedRecs;
    END;
GO
-- exec proc_CT_HealthInterestDetail_AddDeletedRecs
CREATE PROCEDURE proc_CT_HealthInterestDetail_AddDeletedRecs
AS
BEGIN

DECLARE
        @DELDATE AS datetime2 ( 7) = GETDATE () ;
        WITH CTE_DEL (
             UserID
           , UserGUID
           , HFitUserMpiNumber
           , SiteGUID
           , CoachingHealthInterestID
           , FirstNodeID
           , SecondNodeGuid
           , ThirdNodeGuid) 
            AS ( SELECT
                        UserID
                      , UserGUID
                      , HFitUserMpiNumber
                      , SiteGUID
                      , CoachingHealthInterestID
                      , FirstNodeID
                      , SecondNodeGuid
                      , ThirdNodeGuid
                        FROM STAGING_EDW_HealthInterestDetail
                 EXCEPT
                 SELECT
                        UserID
                      , UserGUID
                      , HFitUserMpiNumber
                      , SiteGUID
                      , CoachingHealthInterestID
                      , FirstNodeID
                      , SecondNodeGuid
                      , ThirdNodeGuid
                        FROM ##Temp_HealthInterestDetail) 

            UPDATE S
              SET
                  DeletedFlg = 1
                ,LastModifiedDate = @DELDATE
                  FROM STAGING_EDW_HealthInterestDetail AS S
                            JOIN
                            CTE_DEL AS C
                            ON
                            S.UserID = C.UserID AND
                            S.UserGUID = C.UserGUID AND
                            S.HFitUserMpiNumber = C.HFitUserMpiNumber AND
                            S.SiteGUID = C.SiteGUID AND
                            S.CoachingHealthInterestID = C.CoachingHealthInterestID AND
                            S.FirstNodeID = C.FirstNodeID AND
                            S.SecondNodeGuid = C.SecondNodeGuid AND
                            S.ThirdNodeGuid = C.ThirdNodeGuid AND
                            S.DeletedFlg IS NULL;

    DECLARE
    @iInserts AS int = @@ROWCOUNT;

    UPDATE STAGING_EDW_HealthInterestDetail
      SET
          LastModifiedDate = GETDATE () 
           WHERE
                 LastModifiedDate IS NULL AND
                 DeletedFlg IS NOT NULL;

    PRINT 'Deleted Record Count: ' + CAST ( @iInserts AS nvarchar (50)) ;
    RETURN @iInserts;
END;

GO
PRINT 'Executed proc_CT_HealthInterestDetail_AddDeletedRecs.sql';
GO
