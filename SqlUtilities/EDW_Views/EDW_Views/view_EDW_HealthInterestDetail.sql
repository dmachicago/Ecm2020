

GO 
print('***** FROM: view_EDW_HealthInterestDetail.sql'); 
GO 
print ('Creating view_EDW_HealthInterestDetail');
GO

if exists(select name from sys.views where name = 'view_EDW_HealthInterestDetail')
BEGIN 
	drop view view_EDW_HealthInterestDetail ;
END
go

CREATE VIEW [dbo].[view_EDW_HealthInterestDetail]
AS
	--12/03/2014 1526 (wdm) this view was created by Chad Gurka and passed over to Team P to incloude into the build
	--12/03/2014 1845 (wdm) INSTALLATION: In running the script on Prod 1, an error was encountered when creating the 
	--view view_EDW_HealthInterestDetail. A base table, HFit_CoachingHealthInterest, referenced by the view on 
	--all prod servers was missing two columns, ItemCreatedWhen and ItemModifiedWhen.
	--In order to get the view created, I nulled out these two columns and a FIX will have to be applied to the 
	--view after these two columns are added to the base table. Chad had no way of knowing these columns were 
	--missing in Prod when he developed the view. And, it tested perfectly for John C. in Prod Staging this afternoon. 
	--This table, HFit_CoachingHealthInterest, will have these columns applied as part of the upcoming migration and 
	--are not available in Prod currently. However, the fix will be very minor and should correct itself as part of 
	--coming migration. Please take note that these columns will return only NULLS until the base table is modified 
	--to contain these columns.

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

		,cast(HI.ItemCreatedWhen as datetime ) as ItemCreatedWhen
		,cast(HI.ItemModifiedWhen as datetime ) as ItemModifiedWhen
	FROM
		HFit_CoachingHealthInterest AS HI
		JOIN CMS_User AS U ON HI.UserID = U.UserID
		JOIN CMS_UserSettings AS US ON HI.UserID = US.UserSettingsUserID
		JOIN CMS_UserSite AS US1 ON HI.UserID = US1.UserID
		JOIN CMS_Site AS S ON US1.SiteID = S.SiteID
		LEFT JOIN View_HFit_CoachingHealthArea_Joined AS HA1 ON HI.FirstInterest = HA1.NodeID
			AND HA1.DocumentCulture = 'en-us'
		LEFT JOIN View_HFit_CoachingHealthArea_Joined AS HA2 ON HI.SecondInterest = HA2.NodeID	
			AND HA2.DocumentCulture = 'en-us'
		LEFT JOIN View_HFit_CoachingHealthArea_Joined AS HA3 ON HI.ThirdInterest = HA3.NodeID
			AND HA3.DocumentCulture = 'en-us'
GO

print ('Created view_EDW_HealthInterestDetail');
GO


