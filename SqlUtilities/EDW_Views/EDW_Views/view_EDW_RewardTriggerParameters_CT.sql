
GO
print ('Processing: view_EDW_RewardTriggerParameters_CT ') ;
go

if exists(select NAME from sys.VIEWS where NAME = 'view_EDW_RewardTriggerParameters_CT')
BEGIN
	drop view view_EDW_RewardTriggerParameters_CT ;
END
GO

--*******************************************************************************************************************
--8/7/2014  VHFRTJ.DocumentGuid		  --WDM Added in case needed
--8/7/2014  VHFRTJ.NodeGuid			  --WDM Added in case needed
--09.11.2014 : (wdm) Verified last mod date available to EDW - RewardTriggerParameter_DocumentModifiedWhen
--11.17.2014 : (wdm) John C. found that Spanish was being brought across in TriggerName and 
--				ParameterDisplayName. Found that View_HFit_RewardTrigger_Joined has no way to limit the 
--				returned data to Spanish. Created a new view, View_EDW_RewardProgram_Joined, and provided 
--				a FILTER on Document Culture. The, added Launguage fitlers as: 
--					where VHFRTJ.DocumentCulture = 'en-US' AND VHFRTPJ.DocumentCulture = 'en-US'
--				This appears to have eliminated the Spanish.
-- 03.03.2015 : (Dale/Natahn) no changes required.
-- 04.12.2015 : (WDM) In order to implement change tracking on this view, a STAGING table will simply be 
--			 dropped and recreated everytime using this view. It is too small to worry about otherwise.
-- 04.12.2015 : created view view_EDW_RewardTriggerParameters_CT so that change tracking would be consistent.
--SELECT * FROM [view_EDW_RewardTriggerParameters_CT]
--*******************************************************************************************************************
create VIEW [dbo].[view_EDW_RewardTriggerParameters_CT]
AS
--8/7/2014 - added and commented out DocumentGuid and NodeGuid in case needed later
--8/8/2014 - Generated corrected view in DEV (WDM)
	SELECT distinct
		cs.SiteGUID															 --CMS_Site
		, VHFRTJ.RewardTriggerID													 --HFit_RewardTrigger
		, VHFRTJ.TriggerName													 --HFit_RewardTrigger
		, HFLRTPO.RewardTriggerParameterOperatorLKPDisplayName							 --HFit_LKP_RewardTriggerParameterOperator 
		, VHFRTPJ.ParameterDisplayName											 --HFit_RewardTriggerParameter
		, VHFRTPJ.RewardTriggerParameterOperator									 --HFit_RewardTriggerParameter
		, VHFRTPJ.Value														 --HFit_RewardTriggerParameter
		, hfa.AccountID														 --HFit_Account
		, hfa.AccountCD														 --HFit_Account
		, CASE	WHEN CAST(VHFRTJ.DocumentCreatedWhen AS DATE) = CAST(VHFRTJ.DocumentModifiedWhen AS DATE)
				THEN 'I'
				ELSE 'U'
			END AS ChangeType		
		, VHFRTJ.DocumentGuid													 --CMS_Document
		, VHFRTJ.NodeGuid														 --CMS_Document
		, VHFRTJ.DocumentCreatedWhen												 --CMS_Document
		, VHFRTJ.DocumentModifiedWhen												 --CMS_Document
		,VHFRTPJ.DocumentModifiedWhen as RewardTriggerParameter_DocumentModifiedWhen	  	 --CMS_Document
		,VHFRTPJ.documentculture as documentculture_VHFRTPJ							 --CMS_Document
		,VHFRTJ.documentculture as documentculture_VHFRTJ								 --CMS_Document
	   ,hashbytes ('sha1',
			 isnull(cast(cs.SiteGUID as nvarchar(50)),'-')
			 + isnull(cast(VHFRTJ.RewardTriggerID as nvarchar(50)),'-')
			 + isnull(cast(VHFRTJ.TriggerName as nvarchar(250)),'-')
			 + isnull(cast(HFLRTPO.RewardTriggerParameterOperatorLKPDisplayName as nvarchar(250)),'-')
			 + isnull(cast(VHFRTPJ.ParameterDisplayName as nvarchar(250)),'-')
			 + isnull(cast(VHFRTPJ.RewardTriggerParameterOperator as nvarchar(50)),'-')
			 + isnull(cast(VHFRTPJ.Value as nvarchar(50)),'-')
			 + isnull(cast(VHFRTJ.DocumentGuid as nvarchar(50)),'-')
			 + isnull(cast(VHFRTJ.NodeGuid as nvarchar(50)),'-')
			 + isnull(cast(VHFRTJ.DocumentCreatedWhen as nvarchar(50)),'-')
			 + isnull(cast(VHFRTJ.DocumentModifiedWhen as nvarchar(50)),'-')
			 + isnull(cast(VHFRTPJ.DocumentModifiedWhen as nvarchar(50)),'-')
	   ) as HashCode

	FROM
		dbo.View_HFit_RewardTrigger_Joined AS VHFRTJ 
		--dbo.[View_EDW_RewardProgram_Joined] AS VHFRTJ 		
	INNER JOIN dbo.View_HFit_RewardTriggerParameter_Joined AS VHFRTPJ  ON vhfrtj.NodeID = VHFRTPJ.NodeParentID
	INNER JOIN dbo.HFit_LKP_RewardTriggerParameterOperator AS HFLRTPO  ON VHFRTPJ.RewardTriggerParameterOperator = HFLRTPO.RewardTriggerParameterOperatorLKPID
	INNER JOIN dbo.CMS_Site AS CS  ON VHFRTJ.NodeSiteID = cs.SiteID
	INNER JOIN dbo.HFit_Account AS HFA  ON cs.SiteID = HFA.SiteID
	where VHFRTJ.DocumentCulture = 'en-US'
	AND VHFRTPJ.DocumentCulture = 'en-US'
      

GO


  --  
  --  
GO 
print('***** Created: view_EDW_RewardTriggerParameters_CT.sql'); 
GO 
