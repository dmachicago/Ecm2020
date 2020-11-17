GO
print('Creating view_EDW_HealthInterestList'); 
GO

if exists(select name from sys.views where name = 'view_EDW_HealthInterestList')
BEGIN 
	drop view view_EDW_HealthInterestList ;
END
go

CREATE VIEW [dbo].[view_EDW_HealthInterestList]
AS
	--12/03/2014 (wdm) this view was created by Chad Gurka and passed over to Team P to incloude into the build
	SELECT
		CHA.CoachingHealthAreaID AS HealthAreaID
		,CHA.NodeID
		,CHA.NodeGuid
		,A.AccountCD
		,CHA.NodeName AS HealthAreaName
		,CHA.HealthAreaDescription
		,CHA.CodeName
		,cast(CHA.DocumentCreatedWhen as datetime) as DocumentCreatedWhen
		,cast(CHA.DocumentModifiedWhen as datetime) as DocumentModifiedWhen
	FROM
		View_HFit_CoachingHealthArea_Joined AS CHA
		JOIN HFit_Account AS A ON A.SiteID = CHA.NodeSiteID
	WHERE DocumentCulture = 'en-us'

GO
print('Created view_EDW_HealthInterestList'); 
GO
  --  
  --  
GO 
print('***** FROM: view_EDW_HealthInterestList.sql'); 
GO 
