GO
print('Creating view_EDW_HealthInterestList_STAGED'); 
GO

if exists(select name from sys.views where name = 'view_EDW_HealthInterestList_CT')
BEGIN 
	drop view view_EDW_HealthInterestList_CT ;
END
go

/*
select count(*) from view_EDW_HealthInterestList_CT

select count(*),  HealthAreaID
		,NodeID
		,NodeGuid
		,AccountCD
from view_EDW_HealthInterestList_CT
group by HealthAreaID
		,NodeID
		,NodeGuid
		,AccountCD
having count(*) > 1
*/
CREATE VIEW [dbo].[view_EDW_HealthInterestList_CT]
AS
	--12/03/2014 (wdm) this view was created by Chad Gurka and passed over to Team P to include into the build
	SELECT
		CHA.CoachingHealthAreaID AS HealthAreaID
		,CHA.NodeID
		,CHA.NodeGuid
		,A.AccountCD
		,CHA.NodeName AS HealthAreaName
		,CHA.HealthAreaDescription
		,CHA.CodeName
		,CHA.DocumentCreatedWhen
		,CHA.DocumentModifiedWhen
		   , HASHBYTES ('sha1',
				    isNull(CHA.NodeName,'-')
				    + isNull(CHA.CodeName,'-')
				    + isNull(cast(CHA.DocumentCreatedWhen as nvarchar(50)),'-')
				    + isNull(cast(CHA.DocumentModifiedWhen as nvarchar(50)),'-')
		  ) as HashCode
	FROM
		View_HFit_CoachingHealthArea_Joined AS CHA
		JOIN HFit_Account AS A ON A.SiteID = CHA.NodeSiteID
	WHERE DocumentCulture = 'en-us'

GO
print('Created view_EDW_HealthInterestList_CT'); 
GO
  --  
  --  
GO 
print('***** FROM: view_EDW_HealthInterestList_CT.sql'); 
GO 
