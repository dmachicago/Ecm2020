

GO 
print('***** FROM: view_EDW_HealthInterestDetail_CT.sql'); 
GO 
print ('Creating view_EDW_HealthInterestDetail_CT');
GO
--select count(*) from view_EDW_HealthInterestDetail
--select TOP 100 * from view_EDW_HealthInterestDetail_CT order by HashCode
if exists(select name from sys.views where name = 'view_EDW_HealthInterestDetail_CT')
BEGIN 
	drop view view_EDW_HealthInterestDetail_CT ;
END
go

/*  {Potential Natural Key}
select count(*), UserID,UserGUID,HFitUserMpiNumber,SiteGUID,CoachingHealthInterestID,FirstNodeID,SecondNodeGuid,ThirdNodeGuid
from 
view_EDW_HealthInterestDetail_CT
group by UserID,UserGUID,HFitUserMpiNumber,SiteGUID,CoachingHealthInterestID,FirstNodeID,SecondNodeGuid,ThirdNodeGuid
having Count(*) > 1
*/


CREATE VIEW [dbo].[view_EDW_HealthInterestDetail_CT]
AS
	SELECT
		HI.UserID
		,U.UserGUID
		,US.HFitUserMpiNumber
		,S.SiteGUID
		,HI.CoachingHealthInterestID

		,HA1.CoachingHealthAreaID AS FirstHealthAreaID
		,HA1.NodeID AS FirstNodeID
		,HA1.NodeGuid AS FirstNodeGuid
		,HA1.DocumentName AS FirstHealthAreaName
		,HA1.HealthAreaDescription AS FirstHealthAreaDescription
		,HA1.CodeName AS FirstCodeName
	
		,HA2.CoachingHealthAreaID AS SecondHealthAreaID
		,HA2.NodeID AS SecondNodeID
		,HA2.NodeGuid AS SecondNodeGuid
		,HA2.DocumentName AS SecondHealthAreaName
		,HA2.HealthAreaDescription AS SecondHealthAreaDescription
		,HA2.CodeName AS SecondCodeName
	
		,HA3.CoachingHealthAreaID AS ThirdHealthAreaID
		,HA3.NodeID AS ThirdNodeID
		,HA3.NodeGuid AS ThirdNodeGuid
		,HA3.DocumentName AS ThirdHealthAreaName
		,HA3.HealthAreaDescription AS ThirdHealthAreaDescription
		,HA3.CodeName AS ThirdCodeName

		,HI.ItemCreatedWhen
		,HI.ItemModifiedWhen

		  , HASHBYTES ('sha1',
				    isNull(HA1.DocumentName,'-')
				    + isNull(left(HA1.HealthAreaDescription,1000),'-')
				    + isNull(HA1.CodeName,'-')
				    + isNull(HA2.DocumentName,'-')
				    + isNull(left(HA2.HealthAreaDescription,1000),'-')
				    + isNull(HA2.CodeName,'-')
				    + isNull(HA3.DocumentName,'-')
				    + isNull(left(HA3.HealthAreaDescription,1000),'-')
				    + isNull(HA3.CodeName,'-')
		  ) as HashCode
		  --, HI.ItemModifiedWhen as LastModifiedDate
		  
	FROM
		HFit_CoachingHealthInterest AS HI
		JOIN CMS_User AS U ON HI.UserID = U.UserID
		JOIN CMS_UserSettings AS US ON HI.UserID = US.UserSettingsUserID
		JOIN CMS_UserSite AS US1 ON HI.UserID = US1.UserID
		JOIN CMS_Site AS S ON US1.SiteID = S.SiteID	 --Used only to find SiteGuid
		LEFT JOIN View_HFit_CoachingHealthArea_Joined AS HA1 ON HI.FirstInterest = HA1.NodeID
			AND HA1.DocumentCulture = 'en-us'
		LEFT JOIN View_HFit_CoachingHealthArea_Joined AS HA2 ON HI.SecondInterest = HA2.NodeID	
			AND HA2.DocumentCulture = 'en-us'
		LEFT JOIN View_HFit_CoachingHealthArea_Joined AS HA3 ON HI.ThirdInterest = HA3.NodeID
			AND HA3.DocumentCulture = 'en-us'
GO

print ('Created view_EDW_HealthInterestDetail_CT');
GO


