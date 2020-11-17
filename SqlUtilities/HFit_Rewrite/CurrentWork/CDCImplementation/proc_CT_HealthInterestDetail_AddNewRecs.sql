
GO
-- use KenticoCMS_Prod1

GO
PRINT 'Executing proc_CT_HealthInterestDetail_AddNewRecs.sql';
GO
IF EXISTS ( SELECT
                   name
                   FROM sys.procedures
                   WHERE name = 'proc_CT_HealthInterestDetail_AddNewRecs') 
    BEGIN
        DROP PROCEDURE
             proc_CT_HealthInterestDetail_AddNewRecs;
    END;
GO
CREATE PROCEDURE proc_CT_HealthInterestDetail_AddNewRecs
AS
BEGIN

 WITH CTE_NEW (
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
                        FROM ##Temp_HealthInterestDetail
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
                        FROM DIM_EDW_HealthInterestDetail
                        WHERE LastModifiedDate IS NULL) 
            INSERT INTO DIM_EDW_HealthInterestDetail
            SELECT
                   S.[UserID]
      ,S.[UserGUID]
      ,S.[HFitUserMpiNumber]
      ,S.[SiteGUID]
      ,S.[CoachingHealthInterestID]
      ,S.[FirstHealthAreaID]
      ,S.[FirstNodeID]
      ,S.[FirstNodeGuid]
      ,S.[FirstHealthAreaName]
      ,S.[FirstHealthAreaDescription]
      ,S.[FirstCodeName]
      ,S.[SecondHealthAreaID]
      ,S.[SecondNodeID]
      ,S.[SecondNodeGuid]
      ,S.[SecondHealthAreaName]
      ,S.[SecondHealthAreaDescription]
      ,S.[SecondCodeName]
      ,S.[ThirdHealthAreaID]
      ,S.[ThirdNodeID]
      ,S.[ThirdNodeGuid]
      ,S.[ThirdHealthAreaName]
      ,S.[ThirdHealthAreaDescription]
      ,S.[ThirdCodeName]
      ,S.[ItemCreatedWhen]
      ,S.[ItemModifiedWhen]
      ,S.[IsDeleted]
      ,S.[HashCode]
      ,S.[SVR]
      ,S.[DBNAME]
                 , NULL AS LastModifiedDate
                 , NULL AS RowNbr
                 , NULL AS DeletedFlg
                 , NULL AS TimeZone
                 , NULL AS ConvertedToCentralTime
                   FROM
                        ##Temp_HealthInterestDetail AS S
                             JOIN CTE_NEW AS C
                             ON
                                S.UserID = C.UserID AND
                                S.UserGUID = C.UserGUID AND
                                S.HFitUserMpiNumber = C.HFitUserMpiNumber AND
                                S.SiteGUID = C.SiteGUID AND
                                S.CoachingHealthInterestID = C.CoachingHealthInterestID AND
                                S.FirstNodeID = C.FirstNodeID AND
                                S.SecondNodeGuid = C.SecondNodeGuid AND
                                S.ThirdNodeGuid = C.ThirdNodeGuid;

    DECLARE
    @iInserts AS int = @@ROWCOUNT;
    PRINT 'NEW Insert Count: ' + CAST ( @iInserts AS nvarchar (50)) ;
    RETURN @iInserts;
END;

GO
PRINT 'Executed proc_CT_HealthInterestDetail_AddNewRecs.sql';
GO
