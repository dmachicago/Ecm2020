

go
-- use KenticoCMS_Prod1
GO
PRINT 'Executing proc_CT_HealthInterestDetail_AddUpdatedRecs.sql';
GO
IF EXISTS ( SELECT
                   name
                   FROM sys.procedures
                   WHERE name = 'proc_CT_HealthInterestDetail_AddUpdatedRecs') 
    BEGIN
        DROP PROCEDURE
             proc_CT_HealthInterestDetail_AddUpdatedRecs;
    END;
GO
CREATE PROCEDURE proc_CT_HealthInterestDetail_AddUpdatedRecs
AS
BEGIN

    DECLARE
        @RUNDATE AS datetime2 ( 7) = GETDATE () ;

        UPDATE S
          SET
              S.UserID = T.UserID
            ,S.UserGUID = T.UserGUID
            ,S.HFitUserMpiNumber = T.HFitUserMpiNumber
            ,S.SiteGUID = T.SiteGUID
            ,S.CoachingHealthInterestID = T.CoachingHealthInterestID
            ,S.FirstHealthAreaID = T.FirstHealthAreaID
            ,S.FirstNodeID = T.FirstNodeID
            ,S.FirstNodeGuid = T.FirstNodeGuid
            ,S.FirstHealthAreaName = T.FirstHealthAreaName
            ,S.FirstHealthAreaDescription = T.FirstHealthAreaDescription
            ,S.FirstCodeName = T.FirstCodeName
            ,S.SecondHealthAreaID = T.SecondHealthAreaID
            ,S.SecondNodeID = T.SecondNodeID
            ,S.SecondNodeGuid = T.SecondNodeGuid
            ,S.SecondHealthAreaName = T.SecondHealthAreaName
            ,S.SecondHealthAreaDescription = T.SecondHealthAreaDescription
            ,S.SecondCodeName = T.SecondCodeName
            ,S.ThirdHealthAreaID = T.ThirdHealthAreaID
            ,S.ThirdNodeID = T.ThirdNodeID
            ,S.ThirdNodeGuid = T.ThirdNodeGuid
            ,S.ThirdHealthAreaName = T.ThirdHealthAreaName
            ,S.ThirdHealthAreaDescription = T.ThirdHealthAreaDescription
            ,S.ThirdCodeName = T.ThirdCodeName
            ,S.ItemCreatedWhen = T.ItemCreatedWhen
            ,S.ItemModifiedWhen = T.ItemModifiedWhen
            ,S.HashCode = T.HashCode
              --,S.DESC1 = T.DESC1
              --,S.DESC2 = T.DESC2
              --,S.DESC3 = T.DESC3
              --,S.[DeletedFlg] = T.[DeletedFlg]
            ,
              S.LastModifiedDate = GETDATE () 
            ,S.ConvertedToCentralTime = NULL
              FROM ##Temp_HealthInterestDetail AS T
                        JOIN
                        DIM_EDW_HealthInterestDetail AS S
                        ON
                        S.UserID = T.UserID AND
                        S.UserGUID = T.UserGUID AND
                        S.HFitUserMpiNumber = T.HFitUserMpiNumber AND
                        S.SiteGUID = T.SiteGUID AND
                        S.CoachingHealthInterestID = T.CoachingHealthInterestID AND
                        S.FirstNodeID = T.FirstNodeID AND
                        S.SecondNodeGuid = T.SecondNodeGuid AND
                        S.ThirdNodeGuid = T.ThirdNodeGuid AND
                        S.HASHCODE != T.HASHCODE AND
                        S.LastModifiedDate IS NULL and S.DeletedFlg is null;
              

    DECLARE
    @iInserts AS int = @@ROWCOUNT;
    PRINT 'Updated Record Count: ' + CAST ( @iInserts AS nvarchar (50)) ;
    RETURN @iInserts;
END;

GO
PRINT 'Executed proc_CT_HealthInterestDetail_AddUpdatedRecs.sql';
GO
