--****************************************************************
-- NOTE: This database name must be changed in MANY places in 
--	this script. Please search and change.
--****************************************************************
use KenticoCMS_ProdStaging
go


--***************************************************************
--***************************************************************


print ('Creating View_EDW_RewardProgram_Joined' +  cast(getdate() as nvarchar(50)));
go
if exists (select name from sys.views where name = 'View_EDW_RewardProgram_Joined')
BEGIN
	print ('Re-creating View_EDW_RewardProgram_Joined' +  cast(getdate() as nvarchar(50)));
	drop view View_EDW_RewardProgram_Joined ;
END
go

--This view is created in place of View_Hfit_RewardProgram_Joined so that 
--Document Culture can be taken into consideration. 
CREATE VIEW [dbo].[View_EDW_RewardProgram_Joined] AS 
SELECT View_CMS_Tree_Joined.*, HFit_RewardProgram.* 
	FROM View_CMS_Tree_Joined 
	INNER JOIN HFit_RewardProgram 
		ON View_CMS_Tree_Joined.DocumentForeignKeyValue = HFit_RewardProgram.[RewardProgramID] 
WHERE ClassName = 'HFit.RewardProgram'
AND View_CMS_Tree_Joined.documentculture = 'en-US'
GO

print ('Created View_EDW_RewardProgram_Joined' + cast(getdate() as nvarchar(50)));
go
go
print ('Processing: view_EDW_RewardUserDetail ') ;
go

if exists(select TABLE_NAME from INFORMATION_SCHEMA.VIEWS where TABLE_NAME = 'view_EDW_RewardUserDetail')
BEGIN
	drop view view_EDW_RewardUserDetail ;
END
GO
--select * from [view_EDW_RewardUserDetail]
create VIEW [dbo].[view_EDW_RewardUserDetail]
AS

	--*********************************************************************************************************************************
	--select * from [view_EDW_RewardUserDetail] where ItemModifiedWhen between '2000-11-14' and '2014-11-15'
	--select * from [view_EDW_RewardUserDetail] where ItemModifiedWhen between '2014-05-12' and '2014-05-13' 
	--8/7/2014 - added and commented out DocumentGuid and NodeGuid in case needed later
	--8/08/2014 - Generated corrected view in DEV (WDM)
	--8/12/2014 - Performance Issue - 00:06:49 @ 258502
	--8/12/2014 - Performance Issue - Add PI01_view_EDW_RewardUserDetail
	--8/12/2014 - Performance Issue - 00:03:46 @ 258502
	--8/12/2014 - Performance Issue - Add PI02_view_EDW_RewardUserDetail
	--8/12/2014 - Performance Issue - 00:03:45 @ 258502
	--8/19/2014 - (WDM) Added where clause to make the query return english data only.	
	--09.11.2014 : (wdm) Verified last mod date available to EDW - RewardsUserActivity_ItemModifiedWhen
	--				RewardExceptionModifiedDate, RewardTrigger_DocumentModifiedWhen. Warned Laura this might create many dups.
	--11.14.2014 : (wdm) The dups have surfaced. The combination of  HFRUAD.ActivityCompletedDt, 
	--				HFRUAD.ItemModifiedWhen, HFRE.ItemModifiedWhen, HFRUAD.ItemModifiedWhen, VHFRTJ.DocumentModifiedWhen has exposed
	--				tens of thousands of semi-redundant rows. Today, I commented these dates out and added a distinct and went from \
	--				returning more than 100,000 rows for a given MPI and Client to 4 rows. I left in place the original dates of 
	--				HFRULD.ItemCreatedWhen and HFRULD.ItemModifiedWhen. This gives us whether it is an insert or update. If multiple 
	--				dates are used to determine changes, then it will be necessary to use a DATE filter to bring back only the 
	--				rows indicating a change.
	--11.18.2014 : (wdm) Found a USERID qualifier missing on the join of HFit_RewardsUserActivityDetail. Added this qualifier to USERID
	--				and the view now appears to be functioning correctly returning about 160K rows in 2.5 minutes. The DISTINCT clause
	--				made no difference in the number of returned rows, so it was removed and the speed of the query was halved.
	--*********************************************************************************************************************************

	SELECT	--DISTINCT		--wdm: dropped the DISTINCT 11.18.2014 as the numeric counts of returned records was the same with or without.
		cu.UserGUID
		, CS2.SiteGUID
		, cus2.HFitUserMpiNumber
		, VHFRAJ.RewardActivityID
		, VHFRPJ.RewardProgramName
		, VHFRPJ.RewardProgramID
		, VHFRPJ.RewardProgramPeriodStart
		, VHFRPJ.RewardProgramPeriodEnd
		, VHFRPJ.DocumentModifiedWhen AS RewardModifiedDate
		, VHFRGJ.GroupName
		, VHFRGJ.RewardGroupID
		, VHFRGJ.RewardGroupPeriodStart
		, VHFRGJ.RewardGroupPeriodEnd
		, VHFRGJ.DocumentModifiedWhen AS RewardGroupModifieDate
		, VHFRLJ.Level
		, HFLRLT.RewardLevelTypeLKPName
		, VHFRLJ.DocumentModifiedWhen AS RewardLevelModifiedDate
		, HFRULD.LevelCompletedDt
		, HFRULD.LevelVersionHistoryID
		, VHFRLJ.RewardLevelPeriodStart
		, VHFRLJ.RewardLevelPeriodEnd
		, VHFRAJ.ActivityName
		, HFRUAD.ActivityPointsEarned
		
		, HFRUAD.ActivityCompletedDt	--wdm - 11.17.2014 commented out as it was causing many thousands of duplicate records.
											--wdm	11.18.2014 deemed necesary by Laura B. 
											--wdm	11.18.2014 The cast to date was suggested by John C. and says it might meet their 'initial load' requirements
		, HFRUAD.ItemModifiedWhen AS RewardActivityModifiedDate		--wdm - 11.17.2014 commented out as it was causing many thousands of duplicate records.
																	--wdm	11.18.2014 deemed necesary by Laura B. 
																	--wdm	11.18.2014 The cast to date was suggested by John C. and says it might meet their 'initial load' requirements
		
		--, CASE	WHEN CAST(HFRUAD.ActivityCompletedDt AS DATE) = CAST(HFRUAD.ItemModifiedWhen AS DATE)
		--		THEN 'I'
		--		ELSE 'U'
		--	END AS RewardActivityChangeType
		
		, HFRUAD.ActivityVersionID

		, VHFRAJ.RewardActivityPeriodStart --Cast
		, VHFRAJ.RewardActivityPeriodEnd	--Cast
		, VHFRAJ.ActivityPoints
		, HFRE.UserAccepted
		, HFRE.UserExceptionAppliedTo		
		, VHFRTJ.TriggerName
		, VHFRTJ.RewardTriggerID
		, HFLRT2.RewardTriggerLKPDisplayName
		, HFLRT2.RewardTriggerDynamicValue
		, HFLRT2.ItemModifiedWhen AS RewardTriggerModifiedDate
		, HFLRT.RewardTypeLKPName
		, HFA.AccountID
		, HFA.AccountCD
		, CASE	WHEN CAST(HFRULD.ItemCreatedWhen AS DATE) = CAST(HFRULD.ItemModifiedWhen AS DATE)
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		, VHFRPJ.DocumentGuid		--WDM added 8/7/2014 in case needed
		, VHFRPJ.NodeGuid			--WDM added 8/7/2014 in case needed
		, HFRULD.ItemCreatedWhen
		, HFRULD.ItemModifiedWhen
		
		, HFRE.ItemModifiedWhen AS RewardExceptionModifiedDate		--wdm - 11.17.2014 commented out as it was causing many thousands of duplicate records.
																	--wdm	11.18.2014 deemed necesary by Laura B. 
		, HFRUAD.ItemModifiedWhen as RewardsUserActivity_ItemModifiedWhen	--09.11.2014 (wdm) added for EDW			
		, VHFRTJ.DocumentModifiedWhen as  RewardTrigger_DocumentModifiedWhen		--wdm - 11.17.2014 commented out as it was causing many thousands of duplicate records.

	FROM	
		--REPLACE THIS LINE WITH THE ONE BELOW IT.
		dbo.View_HFit_RewardProgram_Joined AS VHFRPJ WITH ( NOLOCK )
		--dbo.View_EDW_RewardProgram_Joined AS VHFRPJ WITH ( NOLOCK )
			
		LEFT OUTER JOIN dbo.View_HFit_RewardGroup_Joined AS VHFRGJ WITH ( NOLOCK ) ON VHFRPJ.NodeID = VHFRGJ.NodeParentID
			
		LEFT OUTER JOIN dbo.View_HFit_RewardLevel_Joined AS VHFRLJ WITH ( NOLOCK ) ON VHFRGJ.NodeID = VHFRLJ.NodeParentID
			
		LEFT OUTER JOIN dbo.HFit_LKP_RewardType AS HFLRT WITH ( NOLOCK ) ON VHFRLJ.AwardType = HFLRT.RewardTypeLKPID
		LEFT OUTER JOIN dbo.HFit_LKP_RewardLevelType AS HFLRLT WITH ( NOLOCK ) ON vhfrlj.LevelType = HFLRLT.RewardLevelTypeLKPID
		INNER JOIN dbo.HFit_RewardsUserLevelDetail AS HFRULD WITH ( NOLOCK ) ON VHFRLJ.NodeID = HFRULD.LevelNodeID
		INNER JOIN dbo.CMS_User AS CU WITH ( NOLOCK ) ON hfruld.UserID = cu.UserID
		INNER JOIN dbo.CMS_UserSite AS CUS WITH ( NOLOCK ) ON CU.UserID = CUS.UserID
		INNER JOIN dbo.CMS_Site AS CS2 WITH ( NOLOCK ) ON CUS.SiteID = CS2.SiteID
		INNER JOIN dbo.HFit_Account AS HFA WITH ( NOLOCK ) ON cs2.SiteID = HFA.SiteID
		INNER JOIN dbo.CMS_UserSettings AS CUS2 WITH ( NOLOCK ) ON cu.UserID = cus2.UserSettingsUserID
		LEFT OUTER JOIN dbo.View_HFit_RewardActivity_Joined AS VHFRAJ WITH ( NOLOCK ) ON VHFRLJ.NodeID = VHFRAJ.NodeParentID
			
		INNER JOIN dbo.HFit_RewardsUserActivityDetail AS HFRUAD WITH ( NOLOCK ) ON VHFRAJ.NodeID = HFRUAD.ActivityNodeID
			AND cu.UserID = HFRUAD.userid	--11.18.2014 (wdm) added tis filter so that only USER Detail was returned.
			
		LEFT OUTER JOIN dbo.View_HFit_RewardTrigger_Joined AS VHFRTJ WITH ( NOLOCK ) ON VHFRAJ.NodeID = VHFRTJ.NodeParentID
			
		LEFT OUTER JOIN dbo.HFit_LKP_RewardTrigger AS HFLRT2 WITH ( NOLOCK ) ON VHFRTJ.RewardTriggerLKPID = HFLRT2.RewardTriggerLKPID
		LEFT OUTER JOIN dbo.HFit_RewardException AS HFRE WITH ( NOLOCK ) ON HFRE.RewardActivityID = VHFRAJ.RewardActivityID
				AND HFRE.UserID = cu.UserID

		Where VHFRPJ.DocumentCulture = 'en-us'
			AND VHFRGJ.DocumentCulture = 'en-us'
			AND VHFRLJ.DocumentCulture = 'en-us'
			AND VHFRAJ.DocumentCulture = 'en-us'
			AND VHFRTJ.DocumentCulture = 'en-us'

--and AccountCD = 'jnj' 
--AND HFitUserMpiNumber = 6238315


go
print ('Completed : view_EDW_RewardUserDetail ') ;
go


print ('Processing: view_EDW_RewardTriggerParameters ') ;
go

if exists(select TABLE_NAME from INFORMATION_SCHEMA.VIEWS where TABLE_NAME = 'view_EDW_RewardTriggerParameters')
BEGIN
	drop view view_EDW_RewardTriggerParameters ;
END
GO


--GRANT SELECT
--	ON [dbo].[view_EDW_RewardTriggerParameters]
--	TO [EDWReader_PRD]
--GO


--********************************************************************************************************
--09.11.2014 : (wdm) Verified last mod date available to EDW - RewardTriggerParameter_DocumentModifiedWhen
--11.17.2014 : (wdm) John C. found that Spanish was being brought across in TriggerName and 
--				ParameterDisplayName. Found that View_HFit_RewardTrigger_Joined has no way to limit the 
--				returned data to Spanish. Created a new view, View_EDW_RewardProgram_Joined, and provided 
--				a FILTER on Document Culture. The, added Launguage fitlers as: 
--					where VHFRTJ.DocumentCulture = 'en-US' AND VHFRTPJ.DocumentCulture = 'en-US'
--				This appears to have eliminated the Spanish.
--********************************************************************************************************
create VIEW [dbo].[view_EDW_RewardTriggerParameters]
AS
--8/7/2014 - added and commented out DocumentGuid and NodeGuid in case needed later
--8/8/2014 - Generated corrected view in DEV (WDM)
	SELECT distinct
		cs.SiteGUID
		, VHFRTJ.RewardTriggerID
		, VHFRTJ.TriggerName
		, HFLRTPO.RewardTriggerParameterOperatorLKPDisplayName
		, VHFRTPJ.ParameterDisplayName
		, VHFRTPJ.RewardTriggerParameterOperator
		, VHFRTPJ.Value
		, hfa.AccountID
		, hfa.AccountCD
		, CASE	WHEN CAST(VHFRTJ.DocumentCreatedWhen AS DATE) = CAST(VHFRTJ.DocumentModifiedWhen AS DATE)
				THEN 'I'
				ELSE 'U'
			END AS ChangeType		
		, VHFRTJ.DocumentGuid		--WDM Added 8/7/2014 in case needed
		, VHFRTJ.NodeGuid		--WDM Added 8/7/2014 in case needed
		, VHFRTJ.DocumentCreatedWhen
		, VHFRTJ.DocumentModifiedWhen

		,VHFRTPJ.DocumentModifiedWhen as RewardTriggerParameter_DocumentModifiedWhen
		,VHFRTPJ.documentculture as documentculture_VHFRTPJ
		,VHFRTJ.documentculture as documentculture_VHFRTJ
	FROM
		dbo.View_HFit_RewardTrigger_Joined AS VHFRTJ WITH ( NOLOCK )
		--dbo.[View_EDW_RewardProgram_Joined] AS VHFRTJ WITH ( NOLOCK )		
	INNER JOIN dbo.View_HFit_RewardTriggerParameter_Joined AS VHFRTPJ WITH ( NOLOCK ) ON vhfrtj.NodeID = VHFRTPJ.NodeParentID
	INNER JOIN dbo.HFit_LKP_RewardTriggerParameterOperator AS HFLRTPO WITH ( NOLOCK ) ON VHFRTPJ.RewardTriggerParameterOperator = HFLRTPO.RewardTriggerParameterOperatorLKPID
	INNER JOIN dbo.CMS_Site AS CS WITH ( NOLOCK ) ON VHFRTJ.NodeSiteID = cs.SiteID
	INNER JOIN dbo.HFit_Account AS HFA WITH ( NOLOCK ) ON cs.SiteID = HFA.SiteID
	where VHFRTJ.DocumentCulture = 'en-US'
	AND VHFRTPJ.DocumentCulture = 'en-US'
      

GO




--***************************************************************
--***************************************************************

print ('Processing: view_EDW_RewardsDefinition ') ;
go

if exists(select TABLE_NAME from INFORMATION_SCHEMA.VIEWS where TABLE_NAME = 'view_EDW_RewardsDefinition')
BEGIN
	drop view view_EDW_RewardsDefinition ;
END
GO



--GRANT SELECT
--	ON [dbo].[view_EDW_RewardsDefinition]
--	TO [EDWReader_PRD]
--GO

create VIEW [dbo].[view_EDW_RewardsDefinition]
AS
--*************************************************************************************************
--WDM Reviewed 8/6/2014 for needed updates, may be needed
--	My question - Is NodeGUID going to be passed onto the children
--8/7/2014 - added and commented out DocumentGuid in case needed later
--8/8/2014 - Generated corrected view in DEV (WDM)
--8/19/2014 - (WDM) Added where clause to make the query return english data only.	
--09.11.2014 : Added to facilitate EDW Last Mod Date determination and added language filters
--11.14.2014 : Found that this view was in PRod Staging and not in Prod.
--11.17.2014 : John C. found that Spanish was coming across. This was due to the view
--				View_HFit_RewardProgram_Joined not having the capability to FITER at the 
--				Document Culture level. Created a view, View_EDW_RewardProgram_Joined, that
--				used View_HFit_RewardProgram_Joined and added the capability to fiter languages.
--*************************************************************************************************

	SELECT DISTINCT
		cs.SiteGUID
		, HFA.AccountID
		, hfa.AccountCD
		, RewardProgramID
		, RewardProgramName
		, RewardProgramPeriodStart
		, RewardProgramPeriodEnd
		, ProgramDescription
		, RewardGroupID
		, GroupName
		, RewardContactGroups
		, RewardGroupPeriodStart
		, RewardGroupPeriodEnd
		, RewardLevelID
		, [Level]
		, RewardLevelTypeLKPName
		, RewardLevelPeriodStart
		, RewardLevelPeriodEnd
		, FrequencyMenu
		, AwardDisplayName
		, AwardType
		, AwardThreshold1
		, AwardThreshold2
		, AwardThreshold3
		, AwardThreshold4
		, AwardValue1
		, AwardValue2
		, AwardValue3
		, AwardValue4
		, CompletionText
		, ExternalFulfillmentRequired
		, RewardHistoryDetailDescription
		, VHFRAJ.RewardActivityID
		, VHFRAJ.ActivityName
		, VHFRAJ.ActivityFreqOrCrit
		, VHFRAJ.RewardActivityPeriodStart
		, VHFRAJ.RewardActivityPeriodEnd
		, VHFRAJ.RewardActivityLKPID
		, VHFRAJ.ActivityPoints
		, VHFRAJ.IsBundle
		, VHFRAJ.IsRequired
		, VHFRAJ.MaxThreshold
		, VHFRAJ.AwardPointsIncrementally
		, VHFRAJ.AllowMedicalExceptions
		, VHFRAJ.BundleText
		, RewardTriggerID
		, HFLRT.RewardTriggerDynamicValue
		, TriggerName
		, RequirementDescription
		, VHFRTPJ.RewardTriggerParameterOperator
		, VHFRTPJ.Value
		, vhfrtpj.ParameterDisplayName
		, CASE	WHEN CAST(VHFRPJ.DocumentCreatedWhen AS DATE) = CAST(VHFRPJ.DocumentModifiedWhen AS DATE)
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		, VHFRPJ.DocumentGuid	--WDM Added 8/7/2014 in case needed
		
		, VHFRPJ.DocumentCreatedWhen
		, VHFRPJ.DocumentModifiedWhen
		
		, VHFRAJ.DocumentModifiedWhen as RewardActivity_DocumentModifiedWhen	--09.11.2014 : Added to facilitate EDW Last Mod Date determination
		, VHFRAJ.DocumentCulture as DocumentCulture_VHFRAJ		
		,VHFRPJ.DocumentCulture as DocumentCulture_VHFRPJ
		,VHFRGJ.DocumentCulture as DocumentCulture_VHFRGJ
		,VHFRLJ.DocumentCulture as DocumentCulture_VHFRLJ
		,VHFRTPJ.DocumentCulture as DocumentCulture_VHFRTPJ
	FROM 
	--dbo.View_HFit_RewardProgram_Joined AS VHFRPJ
	dbo.[View_EDW_RewardProgram_Joined] AS VHFRPJ
	INNER JOIN dbo.View_HFit_RewardGroup_Joined AS VHFRGJ ON VHFRPJ.NodeID = VHFRGJ.NodeParentID
		and VHFRPJ.DocumentCulture = 'en-US'
		and VHFRGJ.DocumentCulture = 'en-US'
	INNER JOIN dbo.View_HFit_RewardLevel_Joined AS VHFRLJ ON VHFRGJ.NodeID = VHFRLJ.NodeParentID
		and VHFRLJ.DocumentCulture = 'en-US'
	INNER JOIN dbo.HFit_LKP_RewardLevelType AS HFLRLT ON VHFRLJ.LevelType = HFLRLT.RewardLevelTypeLKPID
	INNER JOIN dbo.View_HFit_RewardActivity_Joined AS VHFRAJ ON VHFRLJ.NodeID = VHFRAJ.NodeParentID
		and VHFRAJ.DocumentCulture = 'en-US'
	INNER JOIN dbo.View_HFit_RewardTrigger_Joined AS VHFRTJ ON VHFRAJ.NodeID = VHFRTJ.NodeParentID
		--and VHFRTJ.DocumentCulture = 'en-US'
	INNER JOIN dbo.View_HFit_RewardTriggerParameter_Joined AS VHFRTPJ ON vhfrtj.nodeid = vhfrtpj.nodeparentid
		and VHFRTPJ.DocumentCulture = 'en-US'
	INNER JOIN dbo.HFit_LKP_RewardTrigger AS HFLRT ON VHFRTJ.RewardTriggerLKPID = HFLRT.RewardTriggerLKPID
	INNER JOIN dbo.CMS_Site AS CS ON VHFRPJ.NodeSiteID = cs.SiteID
	INNER JOIN dbo.HFit_Account AS HFA ON cs.SiteID = HFA.SiteID
GO
print ('Processed: view_EDW_RewardsDefinition ') ;
go
--exec sp_helptext view_EDW_RewardsDefinition
print ('Processing: view_EDW_CoachingDefinition ') ;
go

if exists(select TABLE_NAME from INFORMATION_SCHEMA.VIEWS where TABLE_NAME = 'view_EDW_CoachingDefinition')
BEGIN
	drop view view_EDW_CoachingDefinition ;
END
GO


--GRANT SELECT
--	ON [dbo].[view_EDW_CoachingDefinition]
--	TO [EDWReader_PRD]
--GO


CREATE VIEW [dbo].[view_EDW_CoachingDefinition]
AS
--********************************************************************************************************
--8/7/2014 - added DocumentGuid 
--8/8/2014 - Generated corrected view in DEV (WDM)
-- Verified last mod date available to EDW 9.10.2014
--11.17.2014 - (wdm) John Croft found an issue with multiple languages being returned.
--		View_EDW_CoachingDefinition pulls its data from a nested view View_HFit_Tobacco_Goal_Joined. I added 
--		a Document Culture filter on the SELECT STATEMENT pulling the data from View_HFit_Tobacco_Goal_Joined.
--		In LAB DB, when the view is executed W/O the filter, I get 90 rows. When executed with the filter, I 
--		get 89 rows. This would indicate the filter can be applied at the SELCT statement level. The view has 
--		the change applied and is ready to be regenerated. Also, I needed to add a language filter to 
--		View_HFit_Goal_Joined. Additionally, I allow the view to return the Document Culture as a column so 
--		that we can see the associated language. This can be removed if not wanted, but for troubleshooting 
--		it is useful.
--********************************************************************************************************
SELECT
	GJ.GoalID
	, GJ.DocumentGuid	--, GJ.DocumentID
	, GJ.NodeSiteID
	, cs.SiteGUID
	, GJ.GoalImage
	, GJ.Goal
	, dbo.udf_StripHTML(GJ.GoalText) GoalText --
	, dbo.udf_StripHTML(GJ.GoalSummary) GoalSummary --
	, GJ.TrackerAssociation  --GJ.TrackerAssociation
	, GJ.GoalFrequency
	, HFLF.FrequencySingular
	, HFLF.FrequencyPlural
	, GJ.GoalUnitOfMeasure
	, HFLUOM.UnitOfMeasure
	, GJ.GoalDirection
	, GJ.GoalPrecision
	, GJ.GoalAbsoluteMin
	, GJ.GoalAbsoluteMax
	, dbo.udf_StripHTML(GJ.SetGoalText) SetGoalText --
	, dbo.udf_StripHTML(GJ.HelpText) HelpText --
	, GJ.EvaluationType
	, GJ.CatalogDisplay
	, GJ.AllowModification
	, GJ.ActivityText
	, dbo.udf_StripHTML(GJ.SetGoalModifyText) SetgoalModifyText
	, GJ.IsLifestyleGoal
	, GJ.CodeName
	, CASE	WHEN CAST(gj.DocumentCreatedWhen AS DATE) = CAST(gj.DocumentModifiedWhen AS DATE)
			THEN 'I'
			ELSE 'U'
		END AS ChangeType
	, GJ.DocumentCreatedWhen
	, GJ.DocumentModifiedWhen
	, GJ.DocumentCulture
FROM
	(
		SELECT
			VHFGJ.GoalID
			, VHFGJ.DocumentGuid	--, VHFGJ.DocumentID
			, VHFGJ.NodeSiteID
			, VHFGJ.GoalImage
			, VHFGJ.Goal
			, VHFGJ.GoalText
			, VHFGJ.GoalSummary
			, VHFGJ.TrackerNodeGUID as TrackerAssociation  --VHFGJ.TrackerAssociation
			, VHFGJ.GoalFrequency
			, VHFGJ.GoalUnitOfMeasure
			, VHFGJ.GoalDirection
			, VHFGJ.GoalPrecision
			, VHFGJ.GoalAbsoluteMin
			, VHFGJ.GoalAbsoluteMax
			, VHFGJ.SetGoalText
			, VHFGJ.HelpText
			, VHFGJ.EvaluationType
			, VHFGJ.CatalogDisplay
			, VHFGJ.AllowModification
			, VHFGJ.ActivityText
			, VHFGJ.SetGoalModifyText
			, VHFGJ.IsLifestyleGoal
			, VHFGJ.CodeName
			, VHFGJ.DocumentCreatedWhen
			, VHFGJ.DocumentModifiedWhen
			, VHFGJ.DocumentCulture
		FROM
			dbo.View_HFit_Goal_Joined AS VHFGJ
			where VHFGJ.DocumentCulture = 'en-US'
		UNION ALL
		SELECT
			VHFTGJ.GoalID
			, VHFTGJ.DocumentGuid	--, VHFTGJ.DocumentID
			, VHFTGJ.NodeSiteID
			, VHFTGJ.GoalImage
			, VHFTGJ.Goal
			, NULL AS GoalText
			, VHFTGJ.GoalSummary
			, VHFTGJ.TrackerNodeGUID as TrackerAssociation  --VHFTGJ.TrackerAssociation
			, VHFTGJ.GoalFrequency
			, NULL AS GoalUnitOfMeasure
			, VHFTGJ.GoalDirection
			, VHFTGJ.GoalPrecision
			, VHFTGJ.GoalAbsoluteMin
			, VHFTGJ.GoalAbsoluteMax
			, NULL AS SetGoalText
			, NULL AS HelpText
			, VHFTGJ.EvaluationType
			, VHFTGJ.CatalogDisplay
			, VHFTGJ.AllowModification
			, VHFTGJ.ActivityText
			, NULL SetGoalModifyText
			, VHFTGJ.IsLifestyleGoal
			, VHFTGJ.CodeName
			, VHFTGJ.DocumentCreatedWhen
			, VHFTGJ.DocumentModifiedWhen
			, VHFTGJ.DocumentCulture
		FROM
			dbo.View_HFit_Tobacco_Goal_Joined AS VHFTGJ
			where VHFTGJ.DocumentCulture = 'en-US'
	) AS GJ
LEFT OUTER JOIN dbo.HFit_LKP_UnitOfMeasure AS HFLUOM ON GJ.GoalUnitOfMeasure = HFLUOM.UnitOfMeasureID
LEFT OUTER JOIN dbo.HFit_LKP_Frequency AS HFLF ON GJ.GoalFrequency = HFLF.FrequencyID
INNER JOIN cms_site AS CS ON gj.nodesiteid = cs.siteid
--INNER JOIN cms_site AS CS ON gj.siteguid = cs.siteguid
WHERE
	gj.DocumentCreatedWhen IS NOT NULL
	AND gj.DocumentModifiedWhen IS NOT NULL 

GO

--select * from view_EDW_CoachingDefinition
print ('Processing: view_EDW_HealthAssesmentDeffinition ' + cast(getdate() as nvarchar(50))) ;
go


if exists(select TABLE_NAME from INFORMATION_SCHEMA.VIEWS where TABLE_NAME = 'view_EDW_HealthAssesmentDeffinition')
BEGIN
	drop view view_EDW_HealthAssesmentDeffinition ;
END
GO

--GRANT SELECT
--	ON [dbo].[view_EDW_HealthAssesmentDeffinition]
--	TO [EDWReader_PRD]
--GO

--select * from [view_EDW_HealthAssesmentDeffinition] where DocumentModifiedWhen between '2013-11-14 00:00:00.000' and '2013-11-15 00:00:00.000'

--**************************************************************************************************************
--NOTE: The column DocumentModifiedWhen comes from the CMS_TREE join - it was left 
--		unchanged when other dates added for the Last Mod Date additions. 
--		Therefore, the 'ChangeType' was left dependent upon this date only. 09.12.2014 (wdm)
--**************************************************************************************************************
--WDM - 6/25/2014
--Query was returning a NULL dataset. Found that it is being caused by the AccountCD join.
--Worked with Shane to discover the CMS Tree had been modified.
--Modified the code so that reads it reads the CMS tree correctly - working.
--7/14/2014 1:29 time to run - 79024 rows - DEV
--7/14/2014 0:58 time to run - 57472 rows - PROD1
--7/15/2014 - Query was returning NodeName of 'Campaigns' only
--	Found the issue in view View_HFit_HACampaign_Joined. Documented the change in the view.
--7/16/2014 - Full Select: Using a DocumentModifiedWhen filter 00:17:28 - Record Cnt: 793,520
--8/7/2014 - Executed in DEV with GUID changes and returned 1.13M Rows in 23:14.
--8/8/2014 - Executed in DEV with GUID changes, new views, and returned 1.13M Rows in 20:16.
--8/8/2014 - Generated corrected view in DEV
--8/12/2014 - John C. explained that Account Code and Site Guid are not needed, NULLED
--				them out. With them in the QRY, returned 43104 rows, with them nulled
--				out, returned 43104 rows. Using a DISTINCT, 28736 rows returned and execution
--				time doubled approximately.
--				Has to add a DISTINCT to all the queries - .
--				Original Query 0:25 @ 43104
--				Original Query 0:46 @ 28736 (distinct)
--				Filter added - VHFHAQ.DocumentCulture 0:22 @ 14368
--				Filter added - and VHFHARCJ.DocumentCulture = 'en-us'	 0:06 @ 3568
--				Filter added - and VHFHARAJ.DocumentCulture = 'en-us'	 0:03 @ 1784
--8/12/2014 - Applied the language filters with John C. and performance improved, as expected,
--				such that when running the view in QA: 
--*********************************************************************************************************************
--select * from [view_EDW_HealthAssesmentDeffinition] where DocumentModifiedWhen between '2000-11-14' and '2014-11-15'
--08/12/2014 - ProdStaging 00:21:52 @ 2442
--08/12/2014 - ProdStaging 00:21:09 @ 13272 (UNION ALL   --UNION)
--08/12/2014 - ProdStaging 00:21:37 @ 13272 (UNION ONLY)
--08/12/2014 - ProdStaging 00:06:26 @ 1582 (UNION ONLY & Select Filters Added for Culture)
--08/12/2014 - ProdStaging 00:10:07 @ 6636 (UNION ALL   --UNION) and all selected
--08/12/2014 - ProdStaging added PI PI_View_CMS_Tree_Joined_Regular_DocumentCulture: 00:2:34 @ 6636 
--08/12/2014 - DEV 00:00:58 @ 3792
--09.11.2014 - (wdm) added the needed date fields to help EDW in determining the last mod date of a row.
--10.01.2014 - Dale and Mark reworked this view to use NodeGUIDS and eliminated the CMS_TREE View from participating as well as Site and Account data
--*********************************************************************************************************************
go

create VIEW [dbo].[view_EDW_HealthAssesmentDeffinition] 
AS
SELECT distinct 
		NULL as SiteGUID --cs.SiteGUID								--WDM 08.12.2014 per John C.
		, NULL as AccountCD	 --, HFA.AccountCD						--WDM 08.07.2014 per John C.
		, HA.NodeID AS HANodeID										--WDM 08.07.2014
		, HA.NodeName AS HANodeName									--WDM 08.07.2014
		--, HA.DocumentID AS HADocumentID								--WDM 08.07.2014 commented out and left in place for history
		, NULL AS HADocumentID										--WDM 08.07.2014
																	--09.29.2014: Mark and Dale discussed that NODEGUID should be used 
																	--such that the multi-language/culture is not a problem.
		, HA.NodeSiteID AS HANodeSiteID								--WDM 08.07.2014
		, HA.DocumentPublishedVersionHistoryID AS HADocPubVerID		--WDM 08.07.2014
		, VHFHAMJ.Title AS ModTitle
		--Per EDW Team, HTML text is truncated to 4000 bytes - we'll just do it here
		, dbo.udf_StripHTML(left(VHFHAMJ.IntroText,4000)) AS IntroText
		, VHFHAMJ.NodeGuid AS ModDocGuid	--, VHFHAMJ.DocumentID AS ModDocID	--WDM 08.07.2014	M&D 10.01.2014
		, VHFHAMJ.Weight AS ModWeight
		, VHFHAMJ.IsEnabled AS ModIsEnabled
		, VHFHAMJ.CodeName AS ModCodeName
		, VHFHAMJ.DocumentPublishedVersionHistoryID AS ModDocPubVerID
		, VHFHARCJ.Title AS RCTitle
		, VHFHARCJ.Weight AS RCWeight
		, VHFHARCJ.NodeGuid AS RCDocumentGUID	--, VHFHARCJ.DocumentID AS RCDocumentID	--WDM 08.07.2014	M&D 10.01.2014
		, VHFHARCJ.IsEnabled AS RCIsEnabled
		, VHFHARCJ.CodeName AS RCCodeName
		, VHFHARCJ.DocumentPublishedVersionHistoryID AS RCDocPubVerID
		, VHFHARAJ.Title AS RATytle
		, VHFHARAJ.Weight AS RAWeight
		, VHFHARAJ.NodeGuid AS RADocumentGuid	--, VHFHARAJ.DocumentID AS RADocumentID	--WDM 08.07.2014	M&D 10.01.2014
		, VHFHARAJ.IsEnabled AS RAIsEnabled
		, VHFHARAJ.CodeName AS RACodeName
		, VHFHARAJ.ScoringStrategyID AS RAScoringStrategyID
		, VHFHARAJ.DocumentPublishedVersionHistoryID AS RADocPubVerID
		, VHFHAQ.QuestionType
		, dbo.udf_StripHTML(left(VHFHAQ.Title,4000)) AS QuesTitle
		, VHFHAQ.Weight AS QuesWeight
		, VHFHAQ.IsRequired AS QuesIsRequired

		--, VHFHAQ.DocumentGuid AS QuesDocumentGuid	--, VHFHAQ.DocumentID AS QuesDocumentID	--WDM 08.07.2014	M&D 10.01.2014
		, VHFHAQ.NodeGuid AS QuesDocumentGuid	--, VHFHAQ.DocumentID AS QuesDocumentID	--WDM 08.07.2014
		
		, VHFHAQ.IsEnabled AS QuesIsEnabled
		, left(VHFHAQ.IsVisible,4000) AS QuesIsVisible
		, VHFHAQ.IsStaging AS QuesIsSTaging
		, VHFHAQ.CodeName AS QuestionCodeName
		, VHFHAQ.DocumentPublishedVersionHistoryID AS QuesDocPubVerID
		, VHFHAA.Value AS AnsValue
		, VHFHAA.Points AS AnsPoints
		
		--, VHFHAA.DocumentGuid AS AnsDocumentGuid	--, VHFHAA.DocumentID AS AnsDocumentID	--WDM 08.07.2014	M&D 10.01.2014
		, VHFHAA.NodeGuid AS AnsDocumentGuid	--, VHFHAA.DocumentID AS AnsDocumentID	--WDM 08.07.2014
		
		, VHFHAA.IsEnabled AS AnsIsEnabled
		, VHFHAA.CodeName AS AnsCodeName
		, VHFHAA.UOM AS AnsUOM
		, VHFHAA.DocumentPublishedVersionHistoryID AS AnsDocPUbVerID
		, CASE	WHEN CAST(HA.DocumentCreatedWhen AS DATE) = CAST(HA.DocumentModifiedWhen AS DATE)
			THEN 'I'
			ELSE 'U'
		END AS ChangeType
		, HA.DocumentCreatedWhen
		, HA.DocumentModifiedWhen
		, HA.NodeGuid as CmsTreeNodeGuid	--WDM 08.07.2014 ADDED TO the returned Columns
		, HA.NodeGUID as HANodeGUID

		--, NULL as SiteLastModified
		, NULL as SiteLastModified
		--, NULL as Account_ItemModifiedWhen
		, NULL as Account_ItemModifiedWhen
		--, c.DocumentModifiedWhen as Campaign_DocumentModifiedWhen
		, NULL as Campaign_DocumentModifiedWhen
		, HA.DocumentModifiedWhen as Assessment_DocumentModifiedWhen
		, VHFHAMJ.DocumentModifiedWhen as Module_DocumentModifiedWhen
		, VHFHARCJ.DocumentModifiedWhen as RiskCategory_DocumentModifiedWhen
		, VHFHARAJ.DocumentModifiedWhen as RiskArea_DocumentModifiedWhen
		, VHFHAQ.DocumentModifiedWhen as Question_DocumentModifiedWhen
		, VHFHAA.DocumentModifiedWhen as Answer_DocumentModifiedWhen
	 FROM
		--dbo.View_CMS_Tree_Joined AS VCTJ
		--INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
		--INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID
 
		--Campaign links Client which links to Assessment
		--INNER JOIN dbo.View_HFit_HACampaign_Joined as c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID	--Note: 
 
		View_HFit_HealthAssessment_Joined as HA WITH (NOLOCK) 
		INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ ON HA.NodeID = VHFHAMJ.NodeParentID		
		INNER JOIN dbo.View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
		INNER JOIN dbo.View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
		INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
		LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA ON VHFHAQ.NodeID = VHFHAA.NodeParentID
	where VHFHAQ.DocumentCulture = 'en-us'	--WDM 08.12.2014	
		and (VHFHAA.DocumentCulture = 'en-us' OR VHFHAA.DocumentCulture is null)	--WDM 08.12.2014		
		and VHFHARCJ.DocumentCulture = 'en-us'	--WDM 08.12.2014		
		and VHFHARAJ.DocumentCulture = 'en-us'	--WDM 08.12.2014		
		and VHFHAMJ.DocumentCulture = 'en-us'	--WDM 08.12.2014	
		and HA.DocumentCulture = 'en-us'		--WDM 08.12.2014	

UNION ALL   --UNION
--WDM Retrieve Matrix Level 1 Question Group
	SELECT distinct
		NULL as SiteGUID --cs.SiteGUID		--WDM 08.12.2014
		, NULL as AccountCD	 --, HFA.AccountCD												--WDM 08.07.2014
		, HA.NodeID		--WDM 08.07.2014
		, HA.NodeName		--WDM 08.07.2014
		, NULL AS HADocumentID		--WDM 08.07.2014
		, HA.NodeSiteID		--WDM 08.07.2014
       --,VCTJ.NodeAliasPath
		, HA.DocumentPublishedVersionHistoryID		--WDM 08.07.2014
		, VHFHAMJ.Title
		, dbo.udf_StripHTML(left(left(VHFHAMJ.IntroText,4000),4000)) AS IntroText
		, VHFHAMJ.NodeGuid
		, VHFHAMJ.Weight
		, VHFHAMJ.IsEnabled
		, VHFHAMJ.CodeName
       --,VHFHAMJ.NodeAliasPath
		, VHFHAMJ.DocumentPublishedVersionHistoryID
		, VHFHARCJ.Title
		, VHFHARCJ.Weight
		, VHFHARCJ.NodeGuid
		, VHFHARCJ.IsEnabled
		, VHFHARCJ.CodeName
       --,VHFHARCJ.NodeAliasPath
		, VHFHARCJ.DocumentPublishedVersionHistoryID
		, VHFHARAJ.Title
		, VHFHARAJ.Weight
		, VHFHARAJ.NodeGuid
		, VHFHARAJ.IsEnabled
		, VHFHARAJ.CodeName
       --,VHFHARAJ.NodeAliasPath
		, VHFHARAJ.ScoringStrategyID
		, VHFHARAJ.DocumentPublishedVersionHistoryID
		, VHFHAQ2.QuestionType
		, dbo.udf_StripHTML(left(VHFHAQ2.Title,4000)) AS QuesTitle
		, VHFHAQ2.Weight
		, VHFHAQ2.IsRequired
		, VHFHAQ2.NodeGuid
		, VHFHAQ2.IsEnabled
		, left(VHFHAQ2.IsVisible,4000)
		, VHFHAQ2.IsStaging
		, VHFHAQ2.CodeName AS QuestionCodeName
       --,VHFHAQ2.NodeAliasPath
		, VHFHAQ2.DocumentPublishedVersionHistoryID
		, VHFHAA2.Value
		, VHFHAA2.Points
		, VHFHAA2.NodeGuid
		, VHFHAA2.IsEnabled
		, VHFHAA2.CodeName
		, VHFHAA2.UOM
       --,VHFHAA2.NodeAliasPath
		, VHFHAA2.DocumentPublishedVersionHistoryID
		, CASE	WHEN CAST(HA.DocumentCreatedWhen AS DATE) = CAST(HA.DocumentModifiedWhen AS DATE)
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		, HA.DocumentCreatedWhen
		, HA.DocumentModifiedWhen
		, HA.NodeGuid as CmsTreeNodeGuid	--WDM 08.07.2014
		, HA.NodeGUID as HANodeGUID
	 
		, NULL as SiteLastModified
		, NULL as Account_ItemModifiedWhen
		--, c.DocumentModifiedWhen as Campaign_DocumentModifiedWhen
		, NULL as Campaign_DocumentModifiedWhen
		, HA.DocumentModifiedWhen as Assessment_DocumentModifiedWhen
		, VHFHAMJ.DocumentModifiedWhen as Module_DocumentModifiedWhen
		, VHFHARCJ.DocumentModifiedWhen as RiskCategory_DocumentModifiedWhen
		, VHFHARAJ.DocumentModifiedWhen as RiskArea_DocumentModifiedWhen
		, VHFHAQ.DocumentModifiedWhen as Question_DocumentModifiedWhen
		, VHFHAA.DocumentModifiedWhen as Answer_DocumentModifiedWhen
	FROM
 --dbo.View_CMS_Tree_Joined AS VCTJ
		--INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
		--INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID
 
		--Campaign links Client which links to Assessment
		--INNER JOIN dbo.View_HFit_HACampaign_Joined as c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID	--Note: 
 
View_HFit_HealthAssessment_Joined HA WITH (NOLOCK) 
 INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ ON HA.NodeID = VHFHAMJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
 INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
 LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA ON VHFHAQ.NodeID = VHFHAA.NodeParentID
--matrix level 1 questiongroup
	INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
	INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID
where VHFHAQ.DocumentCulture = 'en-us'	
		and (VHFHAA.DocumentCulture = 'en-us' OR VHFHAA.DocumentCulture is null)	--WDM 08.12.2014		
		and VHFHARCJ.DocumentCulture = 'en-us'	
		and VHFHARAJ.DocumentCulture = 'en-us'	
		and VHFHAMJ.DocumentCulture = 'en-us'	--WDM 08.12.2014	
		and HA.DocumentCulture = 'en-us'	--WDM 08.12.2014		

UNION ALL   --UNION
--WDM Retrieve Branching Level 1 Question and Matrix Level 1 Question Group
	SELECT distinct
		NULL as SiteGUID --cs.SiteGUID		--WDM 08.12.2014
		, NULL as AccountCD	 --, HFA.AccountCD												--WDM 08.07.2014
		, HA.NodeID		--WDM 08.07.2014
		, HA.NodeName		--WDM 08.07.2014
		, NULL AS HADocumentID		--WDM 08.07.2014
		, HA.NodeSiteID		--WDM 08.07.2014
       --,VCTJ.NodeAliasPath
		, HA.DocumentPublishedVersionHistoryID		--WDM 08.07.2014
		, VHFHAMJ.Title
		, dbo.udf_StripHTML(left(VHFHAMJ.IntroText,4000)) AS IntroText
		, VHFHAMJ.NodeGuid
		, VHFHAMJ.Weight
		, VHFHAMJ.IsEnabled
		, VHFHAMJ.CodeName
       --,VHFHAMJ.NodeAliasPath
		, VHFHAMJ.DocumentPublishedVersionHistoryID
		, VHFHARCJ.Title
		, VHFHARCJ.Weight
		, VHFHARCJ.NodeGuid
		, VHFHARCJ.IsEnabled
		, VHFHARCJ.CodeName
       --,VHFHARCJ.NodeAliasPath
		, VHFHARCJ.DocumentPublishedVersionHistoryID
		, VHFHARAJ.Title
		, VHFHARAJ.Weight
		, VHFHARAJ.NodeGuid
		, VHFHARAJ.IsEnabled
		, VHFHARAJ.CodeName
       --,VHFHARAJ.NodeAliasPath
		, VHFHARAJ.ScoringStrategyID
		, VHFHARAJ.DocumentPublishedVersionHistoryID
		, VHFHAQ3.QuestionType
		, dbo.udf_StripHTML(left(VHFHAQ3.Title,4000)) AS QuesTitle
		, VHFHAQ3.Weight
		, VHFHAQ3.IsRequired
		, VHFHAQ3.NodeGuid
		, VHFHAQ3.IsEnabled
		, left(VHFHAQ3.IsVisible,4000)
		, VHFHAQ3.IsStaging
		, VHFHAQ3.CodeName AS QuestionCodeName
       --,VHFHAQ3.NodeAliasPath
		, VHFHAQ3.DocumentPublishedVersionHistoryID
		, VHFHAA3.Value
		, VHFHAA3.Points
		, VHFHAA3.NodeGuid
		, VHFHAA3.IsEnabled
		, VHFHAA3.CodeName
		, VHFHAA3.UOM
       --,VHFHAA3.NodeAliasPath
		, VHFHAA3.DocumentPublishedVersionHistoryID
		, CASE	WHEN CAST(HA.DocumentCreatedWhen AS DATE) = CAST(HA.DocumentModifiedWhen AS DATE)
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		, HA.DocumentCreatedWhen
		, HA.DocumentModifiedWhen
		, HA.NodeGuid as CmsTreeNodeGuid	--WDM 08.07.2014
		, HA.NodeGUID as HANodeGUID
 
		, NULL as SiteLastModified
		, NULL as Account_ItemModifiedWhen
		--, c.DocumentModifiedWhen as Campaign_DocumentModifiedWhen
		, NULL as Campaign_DocumentModifiedWhen
		, HA.DocumentModifiedWhen as Assessment_DocumentModifiedWhen
		, VHFHAMJ.DocumentModifiedWhen as Module_DocumentModifiedWhen
		, VHFHARCJ.DocumentModifiedWhen as RiskCategory_DocumentModifiedWhen
		, VHFHARAJ.DocumentModifiedWhen as RiskArea_DocumentModifiedWhen
		, VHFHAQ.DocumentModifiedWhen as Question_DocumentModifiedWhen
		, VHFHAA.DocumentModifiedWhen as Answer_DocumentModifiedWhen
FROM
 --dbo.View_CMS_Tree_Joined AS VCTJ
		--INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
		--INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID
 
		--Campaign links Client which links to Assessment
		--INNER JOIN dbo.View_HFit_HACampaign_Joined as c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID	--Note: 
 
View_HFit_HealthAssessment_Joined HA WITH (NOLOCK)
 INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ ON HA.NodeID = VHFHAMJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
 INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
 LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA ON VHFHAQ.NodeID = VHFHAA.NodeParentID

--matrix level 1 questiongroup
--INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
--INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID

--Branching Level 1 Question 
	INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ3 ON VHFHAA.NodeID = VHFHAQ3.NodeParentID
	LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA3 ON VHFHAQ3.NodeID = VHFHAA3.NodeParentID
where VHFHAQ.DocumentCulture = 'en-us'	
		and (VHFHAA.DocumentCulture = 'en-us' OR VHFHAA.DocumentCulture is null)	--WDM 08.12.2014		
		and VHFHARCJ.DocumentCulture = 'en-us'	
		and VHFHARAJ.DocumentCulture = 'en-us'	
		and VHFHAMJ.DocumentCulture = 'en-us'	--WDM 08.12.2014	
		and HA.DocumentCulture = 'en-us'	--WDM 08.12.2014		

UNION ALL   --UNION
--WDM Retrieve Branching Level 1 Question and Matrix Level 2 Question Group
	SELECT distinct
		NULL as SiteGUID --cs.SiteGUID		--WDM 08.12.2014
		, NULL as AccountCD	 --, HFA.AccountCD												--WDM 08.07.2014
		, HA.NodeID		--WDM 08.07.2014
		, HA.NodeName		--WDM 08.07.2014
		, NULL AS HADocumentID		--WDM 08.07.2014
		, HA.NodeSiteID		--WDM 08.07.2014
       --,VCTJ.NodeAliasPath
		, HA.DocumentPublishedVersionHistoryID		--WDM 08.07.2014
		, VHFHAMJ.Title
		, dbo.udf_StripHTML(left(VHFHAMJ.IntroText,4000)) AS IntroText
		, VHFHAMJ.NodeGuid
		, VHFHAMJ.Weight
		, VHFHAMJ.IsEnabled
		, VHFHAMJ.CodeName
       --,VHFHAMJ.NodeAliasPath
		, VHFHAMJ.DocumentPublishedVersionHistoryID
		, VHFHARCJ.Title
		, VHFHARCJ.Weight
		, VHFHARCJ.NodeGuid
		, VHFHARCJ.IsEnabled
		, VHFHARCJ.CodeName
       --,VHFHARCJ.NodeAliasPath
		, VHFHARCJ.DocumentPublishedVersionHistoryID
		, VHFHARAJ.Title
		, VHFHARAJ.Weight
		, VHFHARAJ.NodeGuid
		, VHFHARAJ.IsEnabled
		, VHFHARAJ.CodeName
       --,VHFHARAJ.NodeAliasPath
		, VHFHARAJ.ScoringStrategyID
		, VHFHARAJ.DocumentPublishedVersionHistoryID
		, VHFHAQ7.QuestionType
		, dbo.udf_StripHTML(left(VHFHAQ7.Title,4000)) AS QuesTitle
		, VHFHAQ7.Weight
		, VHFHAQ7.IsRequired
		, VHFHAQ7.NodeGuid
		, VHFHAQ7.IsEnabled
		, left(VHFHAQ7.IsVisible,4000)
		, VHFHAQ7.IsStaging
		, VHFHAQ7.CodeName AS QuestionCodeName
       --,VHFHAQ7.NodeAliasPath
		, VHFHAQ7.DocumentPublishedVersionHistoryID
		, VHFHAA7.Value
		, VHFHAA7.Points
		, VHFHAA7.NodeGuid
		, VHFHAA7.IsEnabled
		, VHFHAA7.CodeName
		, VHFHAA7.UOM
       --,VHFHAA7.NodeAliasPath
		, VHFHAA7.DocumentPublishedVersionHistoryID
		, CASE	WHEN CAST(HA.DocumentCreatedWhen AS DATE) = CAST(HA.DocumentModifiedWhen AS DATE)
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		, HA.DocumentCreatedWhen
		, HA.DocumentModifiedWhen
		, HA.NodeGuid as CmsTreeNodeGuid	--WDM 08.07.2014
		, HA.NodeGUID as HANodeGUID
 
		, NULL as SiteLastModified
		, NULL as Account_ItemModifiedWhen
		--, c.DocumentModifiedWhen as Campaign_DocumentModifiedWhen
		, NULL as Campaign_DocumentModifiedWhen
		, HA.DocumentModifiedWhen as Assessment_DocumentModifiedWhen
		, VHFHAMJ.DocumentModifiedWhen as Module_DocumentModifiedWhen
		, VHFHARCJ.DocumentModifiedWhen as RiskCategory_DocumentModifiedWhen
		, VHFHARAJ.DocumentModifiedWhen as RiskArea_DocumentModifiedWhen
		, VHFHAQ.DocumentModifiedWhen as Question_DocumentModifiedWhen
		, VHFHAA.DocumentModifiedWhen as Answer_DocumentModifiedWhen
FROM
 --dbo.View_CMS_Tree_Joined AS VCTJ
		--INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
		--INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID
 
		--Campaign links Client which links to Assessment
		--INNER JOIN dbo.View_HFit_HACampaign_Joined as c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID	--Note: 
 
View_HFit_HealthAssessment_Joined HA WITH (NOLOCK)
 INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ ON HA.NodeID = VHFHAMJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
 INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
 LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA ON VHFHAQ.NodeID = VHFHAA.NodeParentID

--matrix level 1 questiongroup
--INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
--INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID

--Branching Level 1 Question 
	INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ3 ON VHFHAA.NodeID = VHFHAQ3.NodeParentID
--LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA3 ON VHFHAQ3.NodeID = VHFHAA3.NodeParentID

--Matrix Level 2 Question Group
	INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ7 ON VHFHAQ3.NodeID = VHFHAQ7.NodeParentID
	INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA7 ON VHFHAQ7.NodeID = VHFHAA7.NodeParentID
where VHFHAQ.DocumentCulture = 'en-us'	
		and (VHFHAA.DocumentCulture = 'en-us' OR VHFHAA.DocumentCulture is null)	--WDM 08.12.2014		
		and VHFHARCJ.DocumentCulture = 'en-us'	
		and VHFHARAJ.DocumentCulture = 'en-us'	
		and VHFHAMJ.DocumentCulture = 'en-us'	--WDM 08.12.2014	
		and HA.DocumentCulture = 'en-us'	--WDM 08.12.2014		

UNION ALL   --UNION
	--****************************************************
	--WDM 6/25/2014 Retrieve the Branching level 1 Question Group
	--THE PROBLEM LIES HERE in this part of query : 1:40 minute
	-- Added two perf indexes to the first query: 25 Sec
	--****************************************************
	SELECT distinct
		NULL as SiteGUID --cs.SiteGUID		--WDM 08.12.2014
		, NULL as AccountCD	 --, HFA.AccountCD												--WDM 08.07.2014
		, HA.NodeID		--WDM 08.07.2014
		, HA.NodeName		--WDM 08.07.2014
		, NULL AS HADocumentID		--WDM 08.07.2014
		, HA.NodeSiteID		--WDM 08.07.2014
       --,VCTJ.NodeAliasPath
		, HA.DocumentPublishedVersionHistoryID		--WDM 08.07.2014
		, VHFHAMJ.Title
		, dbo.udf_StripHTML(left(VHFHAMJ.IntroText,4000)) AS IntroText
		, VHFHAMJ.NodeGuid
		, VHFHAMJ.Weight
		, VHFHAMJ.IsEnabled
		, VHFHAMJ.CodeName
       --,VHFHAMJ.NodeAliasPath
		, VHFHAMJ.DocumentPublishedVersionHistoryID
		, VHFHARCJ.Title
		, VHFHARCJ.Weight
		, VHFHARCJ.NodeGuid
		, VHFHARCJ.IsEnabled
		, VHFHARCJ.CodeName
       --,VHFHARCJ.NodeAliasPath
		, VHFHARCJ.DocumentPublishedVersionHistoryID
		, VHFHARAJ.Title
		, VHFHARAJ.Weight
		, VHFHARAJ.NodeGuid
		, VHFHARAJ.IsEnabled
		, VHFHARAJ.CodeName
       --,VHFHARAJ.NodeAliasPath
		, VHFHARAJ.ScoringStrategyID
		, VHFHARAJ.DocumentPublishedVersionHistoryID
		, VHFHAQ8.QuestionType
		, dbo.udf_StripHTML(left(VHFHAQ8.Title,4000)) AS QuesTitle
		, VHFHAQ8.Weight
		, VHFHAQ8.IsRequired
		, VHFHAQ8.NodeGuid
		, VHFHAQ8.IsEnabled
		, left(VHFHAQ8.IsVisible,4000)
		, VHFHAQ8.IsStaging
		, VHFHAQ8.CodeName AS QuestionCodeName
       --,VHFHAQ8.NodeAliasPath
		, VHFHAQ8.DocumentPublishedVersionHistoryID
		, VHFHAA8.Value
		, VHFHAA8.Points
		, VHFHAA8.NodeGuid
		, VHFHAA8.IsEnabled
		, VHFHAA8.CodeName
		, VHFHAA8.UOM
       --,VHFHAA8.NodeAliasPath
		, VHFHAA8.DocumentPublishedVersionHistoryID
		, CASE	WHEN CAST(HA.DocumentCreatedWhen AS DATE) = CAST(HA.DocumentModifiedWhen AS DATE)
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		, HA.DocumentCreatedWhen
		, HA.DocumentModifiedWhen
		, HA.NodeGuid as CmsTreeNodeGuid	--WDM 08.07.2014
		, HA.NodeGUID as HANodeGUID
	
		, NULL as SiteLastModified
		, NULL as Account_ItemModifiedWhen
		--, c.DocumentModifiedWhen as Campaign_DocumentModifiedWhen
		, NULL as Campaign_DocumentModifiedWhen
		, HA.DocumentModifiedWhen as Assessment_DocumentModifiedWhen
		, VHFHAMJ.DocumentModifiedWhen as Module_DocumentModifiedWhen
		, VHFHARCJ.DocumentModifiedWhen as RiskCategory_DocumentModifiedWhen
		, VHFHARAJ.DocumentModifiedWhen as RiskArea_DocumentModifiedWhen
		, VHFHAQ.DocumentModifiedWhen as Question_DocumentModifiedWhen
		, VHFHAA.DocumentModifiedWhen as Answer_DocumentModifiedWhen
FROM
 --dbo.View_CMS_Tree_Joined AS VCTJ
		--INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
		--INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID
 
		--Campaign links Client which links to Assessment
		--INNER JOIN dbo.View_HFit_HACampaign_Joined as c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID	--Note: 
 
View_HFit_HealthAssessment_Joined HA WITH (NOLOCK)
 INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ ON HA.NodeID = VHFHAMJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
 INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
 LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA ON VHFHAQ.NodeID = VHFHAA.NodeParentID

			--matrix level 1 questiongroup
			--INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
			--INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID

			--Branching Level 1 Question 
			INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ3 ON VHFHAA.NodeID = VHFHAQ3.NodeParentID
			--LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA3 ON VHFHAQ3.NodeID = VHFHAA3.NodeParentID

			--Matrix Level 2 Question Group
			INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ7 ON VHFHAQ3.NodeID = VHFHAQ7.NodeParentID
			INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA7 ON VHFHAQ7.NodeID = VHFHAA7.NodeParentID

			--Matrix branching level 1 question group
			INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ8 ON VHFHAA7.NodeID = VHFHAQ8.NodeParentID
			INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA8 ON VHFHAQ8.NodeID = VHFHAA8.NodeParentID
where VHFHAQ.DocumentCulture = 'en-us'	
		and (VHFHAA.DocumentCulture = 'en-us' OR VHFHAA.DocumentCulture is null)	--WDM 08.12.2014		
		and VHFHARCJ.DocumentCulture = 'en-us'	
		and VHFHARAJ.DocumentCulture = 'en-us'	
		and VHFHAMJ.DocumentCulture = 'en-us'	--WDM 08.12.2014	
		and HA.DocumentCulture = 'en-us'	--WDM 08.12.2014		

UNION ALL   --UNION
	--****************************************************
	--WDM 6/25/2014 Retrieve the Branching level 2 Question Group
	--THE PROBLEM LIES HERE in this part of query : 1:48  minutes
	--With the new indexes: 29 Secs
	--****************************************************
	SELECT distinct
		NULL as SiteGUID --cs.SiteGUID		--WDM 08.12.2014
		, NULL as AccountCD	 --, HFA.AccountCD												--WDM 08.07.2014
		, HA.NodeID		--WDM 08.07.2014
		, HA.NodeName		--WDM 08.07.2014
		, NULL AS HADocumentID		--WDM 08.07.2014
		, HA.NodeSiteID		--WDM 08.07.2014
       --,VCTJ.NodeAliasPath
		, HA.DocumentPublishedVersionHistoryID		--WDM 08.07.2014
		, VHFHAMJ.Title
		, dbo.udf_StripHTML(left(VHFHAMJ.IntroText,4000)) AS IntroText
		, VHFHAMJ.NodeGuid
		, VHFHAMJ.Weight
		, VHFHAMJ.IsEnabled
		, VHFHAMJ.CodeName
       --,VHFHAMJ.NodeAliasPath
		, VHFHAMJ.DocumentPublishedVersionHistoryID
		, VHFHARCJ.Title
		, VHFHARCJ.Weight
		, VHFHARCJ.NodeGuid
		, VHFHARCJ.IsEnabled
		, VHFHARCJ.CodeName
       --,VHFHARCJ.NodeAliasPath
		, VHFHARCJ.DocumentPublishedVersionHistoryID
		, VHFHARAJ.Title
		, VHFHARAJ.Weight
		, VHFHARAJ.NodeGuid
		, VHFHARAJ.IsEnabled
		, VHFHARAJ.CodeName
       --,VHFHARAJ.NodeAliasPath
		, VHFHARAJ.ScoringStrategyID
		, VHFHARAJ.DocumentPublishedVersionHistoryID
		, VHFHAQ4.QuestionType
		, dbo.udf_StripHTML(left(VHFHAQ4.Title,4000)) AS QuesTitle
		, VHFHAQ4.Weight
		, VHFHAQ4.IsRequired
		, VHFHAQ4.NodeGuid
		, VHFHAQ4.IsEnabled
		, left(VHFHAQ4.IsVisible,4000)
		, VHFHAQ4.IsStaging
		, VHFHAQ4.CodeName AS QuestionCodeName
       --,VHFHAQ4.NodeAliasPath
		, VHFHAQ4.DocumentPublishedVersionHistoryID
		, VHFHAA4.Value
		, VHFHAA4.Points
		, VHFHAA4.NodeGuid
		, VHFHAA4.IsEnabled
		, VHFHAA4.CodeName
		, VHFHAA4.UOM
       --,VHFHAA4.NodeAliasPath
		, VHFHAA4.DocumentPublishedVersionHistoryID
		, CASE	WHEN CAST(HA.DocumentCreatedWhen AS DATE) = CAST(HA.DocumentModifiedWhen AS DATE)
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		, HA.DocumentCreatedWhen
		, HA.DocumentModifiedWhen
		, HA.NodeGuid as CmsTreeNodeGuid	--WDM 08.07.2014
		, HA.NodeGUID as HANodeGUID
 
		, NULL as SiteLastModified
		, NULL as Account_ItemModifiedWhen
		--, c.DocumentModifiedWhen as Campaign_DocumentModifiedWhen
		, NULL as Campaign_DocumentModifiedWhen
		, HA.DocumentModifiedWhen as Assessment_DocumentModifiedWhen
		, VHFHAMJ.DocumentModifiedWhen as Module_DocumentModifiedWhen
		, VHFHARCJ.DocumentModifiedWhen as RiskCategory_DocumentModifiedWhen
		, VHFHARAJ.DocumentModifiedWhen as RiskArea_DocumentModifiedWhen
		, VHFHAQ.DocumentModifiedWhen as Question_DocumentModifiedWhen
		, VHFHAA.DocumentModifiedWhen as Answer_DocumentModifiedWhen
FROM
 --dbo.View_CMS_Tree_Joined AS VCTJ
		--INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
		--INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID
 
		--Campaign links Client which links to Assessment
		--INNER JOIN dbo.View_HFit_HACampaign_Joined as c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID	--Note: 
 
View_HFit_HealthAssessment_Joined HA WITH (NOLOCK) 
 INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ ON HA.NodeID = VHFHAMJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
 INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
 LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA ON VHFHAQ.NodeID = VHFHAA.NodeParentID

			--matrix level 1 questiongroup
			--INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
			--INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID

			--Branching Level 1 Question 
			INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ3 ON VHFHAA.NodeID = VHFHAQ3.NodeParentID
			LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA3 ON VHFHAQ3.NodeID = VHFHAA3.NodeParentID

			--Matrix Level 2 Question Group
			--INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ7 ON VHFHAQ3.NodeID = VHFHAQ7.NodeParentID
			--INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA7 ON VHFHAQ7.NodeID = VHFHAA7.NodeParentID

			--Matrix branching level 1 question group
			--INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ8 ON VHFHAA7.NodeID = VHFHAQ8.NodeParentID
			--INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA8 ON VHFHAQ8.NodeID = VHFHAA8.NodeParentID

			--Branching level 2 Question Group
			INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ4 ON VHFHAA3.NodeID = VHFHAQ4.NodeParentID
			INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA4 ON VHFHAQ4.NodeID = VHFHAA4.NodeParentID
where VHFHAQ.DocumentCulture = 'en-us'	
		and (VHFHAA.DocumentCulture = 'en-us' OR VHFHAA.DocumentCulture is null)	--WDM 08.12.2014		
		and VHFHARCJ.DocumentCulture = 'en-us'	
		and VHFHARAJ.DocumentCulture = 'en-us'	
		and VHFHAMJ.DocumentCulture = 'en-us'	--WDM 08.12.2014	
		and HA.DocumentCulture = 'en-us'	--WDM 08.12.2014		

UNION ALL   --UNION
--WDM 6/25/2014 Retrieve the Branching level 3 Question Group
	SELECT distinct
		NULL as SiteGUID --cs.SiteGUID		--WDM 08.12.2014
		, NULL as AccountCD	 --, HFA.AccountCD												--WDM 08.07.2014
		, HA.NodeID		--WDM 08.07.2014
		, HA.NodeName		--WDM 08.07.2014
		, NULL AS HADocumentID		--WDM 08.07.2014
		, HA.NodeSiteID		--WDM 08.07.2014
       --,VCTJ.NodeAliasPath
		, HA.DocumentPublishedVersionHistoryID		--WDM 08.07.2014
		, VHFHAMJ.Title
		, dbo.udf_StripHTML(left(VHFHAMJ.IntroText,4000)) AS IntroText
		, VHFHAMJ.NodeGuid
		, VHFHAMJ.Weight
		, VHFHAMJ.IsEnabled
		, VHFHAMJ.CodeName
       --,VHFHAMJ.NodeAliasPath
		, VHFHAMJ.DocumentPublishedVersionHistoryID
		, VHFHARCJ.Title
		, VHFHARCJ.Weight
		, VHFHARCJ.NodeGuid
		, VHFHARCJ.IsEnabled
		, VHFHARCJ.CodeName
       --,VHFHARCJ.NodeAliasPath
		, VHFHARCJ.DocumentPublishedVersionHistoryID
		, VHFHARAJ.Title
		, VHFHARAJ.Weight
		, VHFHARAJ.NodeGuid
		, VHFHARAJ.IsEnabled
		, VHFHARAJ.CodeName
       --,VHFHARAJ.NodeAliasPath
		, VHFHARAJ.ScoringStrategyID
		, VHFHARAJ.DocumentPublishedVersionHistoryID
		, VHFHAQ5.QuestionType
		, dbo.udf_StripHTML(left(VHFHAQ5.Title,4000)) AS QuesTitle
		, VHFHAQ5.Weight
		, VHFHAQ5.IsRequired
		, VHFHAQ5.NodeGuid
		, VHFHAQ5.IsEnabled
		, left(VHFHAQ5.IsVisible,4000)
		, VHFHAQ5.IsStaging
		, VHFHAQ5.CodeName AS QuestionCodeName
       --,VHFHAQ5.NodeAliasPath
		, VHFHAQ5.DocumentPublishedVersionHistoryID
		, VHFHAA5.Value
		, VHFHAA5.Points
		, VHFHAA5.NodeGuid
		, VHFHAA5.IsEnabled
		, VHFHAA5.CodeName
		, VHFHAA5.UOM
       --,VHFHAA5.NodeAliasPath
		, VHFHAA5.DocumentPublishedVersionHistoryID
		, CASE	WHEN CAST(HA.DocumentCreatedWhen AS DATE) = CAST(HA.DocumentModifiedWhen AS DATE)
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		, HA.DocumentCreatedWhen
		, HA.DocumentModifiedWhen
		, HA.NodeGuid as CmsTreeNodeGuid	--WDM 08.07.2014
		, HA.NodeGUID as HANodeGUID
 
		, NULL as SiteLastModified
		, NULL as Account_ItemModifiedWhen
		--, c.DocumentModifiedWhen as Campaign_DocumentModifiedWhen
		, NULL as Campaign_DocumentModifiedWhen
		, HA.DocumentModifiedWhen as Assessment_DocumentModifiedWhen
		, VHFHAMJ.DocumentModifiedWhen as Module_DocumentModifiedWhen
		, VHFHARCJ.DocumentModifiedWhen as RiskCategory_DocumentModifiedWhen
		, VHFHARAJ.DocumentModifiedWhen as RiskArea_DocumentModifiedWhen
		, VHFHAQ.DocumentModifiedWhen as Question_DocumentModifiedWhen
		, VHFHAA.DocumentModifiedWhen as Answer_DocumentModifiedWhen
FROM
--dbo.View_CMS_Tree_Joined AS VCTJ
		--INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
		--INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID
 
		--Campaign links Client which links to Assessment
		--INNER JOIN dbo.View_HFit_HACampaign_Joined as c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID	--Note: 
 
View_HFit_HealthAssessment_Joined HA WITH (NOLOCK)  
 INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ ON HA.NodeID = VHFHAMJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
 INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
 LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA ON VHFHAQ.NodeID = VHFHAA.NodeParentID

		--matrix level 1 questiongroup
		--INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
		--INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID

		--Branching Level 1 Question 
		INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ3 ON VHFHAA.NodeID = VHFHAQ3.NodeParentID
		LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA3 ON VHFHAQ3.NodeID = VHFHAA3.NodeParentID

		--Matrix Level 2 Question Group
		--INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ7 ON VHFHAQ3.NodeID = VHFHAQ7.NodeParentID
		--INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA7 ON VHFHAQ7.NodeID = VHFHAA7.NodeParentID

		--Matrix branching level 1 question group
		--INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ8 ON VHFHAA7.NodeID = VHFHAQ8.NodeParentID
		--INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA8 ON VHFHAQ8.NodeID = VHFHAA8.NodeParentID

		--Branching level 2 Question Group
		INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ4 ON VHFHAA3.NodeID = VHFHAQ4.NodeParentID
		INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA4 ON VHFHAQ4.NodeID = VHFHAA4.NodeParentID

		--Branching level 3 Question Group
		INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ5 ON VHFHAA4.NodeID = VHFHAQ5.NodeParentID
		INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA5 ON VHFHAQ5.NodeID = VHFHAA5.NodeParentID
where VHFHAQ.DocumentCulture = 'en-us'	
		and (VHFHAA.DocumentCulture = 'en-us' OR VHFHAA.DocumentCulture is null)	--WDM 08.12.2014		
		and VHFHARCJ.DocumentCulture = 'en-us'	
		and VHFHARAJ.DocumentCulture = 'en-us'	
		and VHFHAMJ.DocumentCulture = 'en-us'	--WDM 08.12.2014	
		and HA.DocumentCulture = 'en-us'	--WDM 08.12.2014		

UNION ALL   --UNION
--WDM 6/25/2014 Retrieve the Branching level 4 Question Group
	SELECT distinct
		NULL as SiteGUID --cs.SiteGUID		--WDM 08.12.2014
		, NULL as AccountCD	 --, HFA.AccountCD												--WDM 08.07.2014
		, HA.NodeID		--WDM 08.07.2014
		, HA.NodeName		--WDM 08.07.2014
		, NULL AS HADocumentID		--WDM 08.07.2014
		, HA.NodeSiteID		--WDM 08.07.2014
       --,VCTJ.NodeAliasPath
		, HA.DocumentPublishedVersionHistoryID		--WDM 08.07.2014
		, VHFHAMJ.Title
		, dbo.udf_StripHTML(left(VHFHAMJ.IntroText,4000)) AS IntroText
		, VHFHAMJ.NodeGuid
		, VHFHAMJ.Weight
		, VHFHAMJ.IsEnabled
		, VHFHAMJ.CodeName
       --,VHFHAMJ.NodeAliasPath
		, VHFHAMJ.DocumentPublishedVersionHistoryID
		, VHFHARCJ.Title
		, VHFHARCJ.Weight
		, VHFHARCJ.NodeGuid
		, VHFHARCJ.IsEnabled
		, VHFHARCJ.CodeName
       --,VHFHARCJ.NodeAliasPath
		, VHFHARCJ.DocumentPublishedVersionHistoryID
		, VHFHARAJ.Title
		, VHFHARAJ.Weight
		, VHFHARAJ.NodeGuid
		, VHFHARAJ.IsEnabled
		, VHFHARAJ.CodeName
       --,VHFHARAJ.NodeAliasPath
		, VHFHARAJ.ScoringStrategyID
		, VHFHARAJ.DocumentPublishedVersionHistoryID
		, VHFHAQ6.QuestionType
		, dbo.udf_StripHTML(left(VHFHAQ6.Title,4000)) AS QuesTitle
		, VHFHAQ6.Weight
		, VHFHAQ6.IsRequired
		, VHFHAQ6.NodeGuid
		, VHFHAQ6.IsEnabled
		, left(VHFHAQ6.IsVisible,4000)
		, VHFHAQ6.IsStaging
		, VHFHAQ6.CodeName AS QuestionCodeName
       --,VHFHAQ6.NodeAliasPath
		, VHFHAQ6.DocumentPublishedVersionHistoryID
		, VHFHAA6.Value
		, VHFHAA6.Points
		, VHFHAA6.NodeGuid
		, VHFHAA6.IsEnabled
		, VHFHAA6.CodeName
		, VHFHAA6.UOM
       --,VHFHAA6.NodeAliasPath
		, VHFHAA6.DocumentPublishedVersionHistoryID
		, CASE	WHEN CAST(HA.DocumentCreatedWhen AS DATE) = CAST(HA.DocumentModifiedWhen AS DATE)
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		, HA.DocumentCreatedWhen
		, HA.DocumentModifiedWhen
		, HA.NodeGuid as CmsTreeNodeGuid	--WDM 08.07.2014
		, HA.NodeGUID as HANodeGUID
 
		, NULL as SiteLastModified
		, NULL as Account_ItemModifiedWhen
		--, c.DocumentModifiedWhen as Campaign_DocumentModifiedWhen
		, NULL as Campaign_DocumentModifiedWhen
		, HA.DocumentModifiedWhen as Assessment_DocumentModifiedWhen
		, VHFHAMJ.DocumentModifiedWhen as Module_DocumentModifiedWhen
		, VHFHARCJ.DocumentModifiedWhen as RiskCategory_DocumentModifiedWhen
		, VHFHARAJ.DocumentModifiedWhen as RiskArea_DocumentModifiedWhen
		, VHFHAQ.DocumentModifiedWhen as Question_DocumentModifiedWhen
		, VHFHAA.DocumentModifiedWhen as Answer_DocumentModifiedWhen
FROM
  --dbo.View_CMS_Tree_Joined AS VCTJ
		--INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
		--INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID
 
		--Campaign links Client which links to Assessment
		--INNER JOIN dbo.View_HFit_HACampaign_Joined as c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID	--Note: 
 
View_HFit_HealthAssessment_Joined HA WITH (NOLOCK) 
 INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ ON HA.NodeID = VHFHAMJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
 INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
 LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA ON VHFHAQ.NodeID = VHFHAA.NodeParentID

		--matrix level 1 questiongroup
		--INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
		--INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID

		--Branching Level 1 Question 
		INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ3 ON VHFHAA.NodeID = VHFHAQ3.NodeParentID
		LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA3 ON VHFHAQ3.NodeID = VHFHAA3.NodeParentID

		--Matrix Level 2 Question Group
		--INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ7 ON VHFHAQ3.NodeID = VHFHAQ7.NodeParentID
		--INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA7 ON VHFHAQ7.NodeID = VHFHAA7.NodeParentID

		--Matrix branching level 1 question group
		--INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ8 ON VHFHAA7.NodeID = VHFHAQ8.NodeParentID
		--INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA8 ON VHFHAQ8.NodeID = VHFHAA8.NodeParentID

		--Branching level 2 Question Group
		INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ4 ON VHFHAA3.NodeID = VHFHAQ4.NodeParentID
		INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA4 ON VHFHAQ4.NodeID = VHFHAA4.NodeParentID

		--Branching level 3 Question Group
		--select count(*) from dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA4
		INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ5 ON VHFHAA4.NodeID = VHFHAQ5.NodeParentID
		INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA5 ON VHFHAQ5.NodeID = VHFHAA5.NodeParentID

		--Branching level 4 Question Group
		INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ6 ON VHFHAA5.NodeID = VHFHAQ6.NodeParentID
		INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA6 ON VHFHAQ6.NodeID = VHFHAA6.NodeParentID
where  VHFHAQ.DocumentCulture = 'en-us'	
		and (VHFHAA.DocumentCulture = 'en-us' OR VHFHAA.DocumentCulture is null)	--WDM 08.12.2014		
		and VHFHARCJ.DocumentCulture = 'en-us'	
		and VHFHARAJ.DocumentCulture = 'en-us'	
		and VHFHAMJ.DocumentCulture = 'en-us'	--WDM 08.12.2014	
		and HA.DocumentCulture = 'en-us'	--WDM 08.12.2014		

UNION ALL   --UNION
	--WDM 6/25/2014 Retrieve the Branching level 5 Question Group
	SELECT distinct
		NULL as SiteGUID --cs.SiteGUID		--WDM 08.12.2014
		, NULL as AccountCD	 --, HFA.AccountCD												--WDM 08.07.2014
		, HA.NodeID		--WDM 08.07.2014
		, HA.NodeName		--WDM 08.07.2014
		, NULL AS HADocumentID		--WDM 08.07.2014
		, HA.NodeSiteID		--WDM 08.07.2014
       --,VCTJ.NodeAliasPath
		, HA.DocumentPublishedVersionHistoryID		--WDM 08.07.2014
		, VHFHAMJ.Title
		, dbo.udf_StripHTML(left(VHFHAMJ.IntroText,4000)) AS IntroText
		, VHFHAMJ.NodeGuid
		, VHFHAMJ.Weight
		, VHFHAMJ.IsEnabled
		, VHFHAMJ.CodeName
       --,VHFHAMJ.NodeAliasPath
		, VHFHAMJ.DocumentPublishedVersionHistoryID
		, VHFHARCJ.Title
		, VHFHARCJ.Weight
		, VHFHARCJ.NodeGuid
		, VHFHARCJ.IsEnabled
		, VHFHARCJ.CodeName
       --,VHFHARCJ.NodeAliasPath
		, VHFHARCJ.DocumentPublishedVersionHistoryID
		, VHFHARAJ.Title
		, VHFHARAJ.Weight
		, VHFHARAJ.NodeGuid
		, VHFHARAJ.IsEnabled
		, VHFHARAJ.CodeName
       --,VHFHARAJ.NodeAliasPath
		, VHFHARAJ.ScoringStrategyID
		, VHFHARAJ.DocumentPublishedVersionHistoryID
		, VHFHAQ9.QuestionType
		, dbo.udf_StripHTML(left(VHFHAQ9.Title,4000)) AS QuesTitle
		, VHFHAQ9.Weight
		, VHFHAQ9.IsRequired
		, VHFHAQ9.NodeGuid
		, VHFHAQ9.IsEnabled
		, left(VHFHAQ9.IsVisible,4000)
		, VHFHAQ9.IsStaging
		, VHFHAQ9.CodeName AS QuestionCodeName
       --,VHFHAQ9.NodeAliasPath
		, VHFHAQ9.DocumentPublishedVersionHistoryID
		, VHFHAA9.Value
		, VHFHAA9.Points
		, VHFHAA9.NodeGuid
		, VHFHAA9.IsEnabled
		, VHFHAA9.CodeName
		, VHFHAA9.UOM
       --,VHFHAA9.NodeAliasPath
		, VHFHAA9.DocumentPublishedVersionHistoryID
		, CASE	WHEN CAST(HA.DocumentCreatedWhen AS DATE) = CAST(HA.DocumentModifiedWhen AS DATE)
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		, HA.DocumentCreatedWhen
		, HA.DocumentModifiedWhen
		, HA.NodeGuid as CmsTreeNodeGuid	--WDM 08.07.2014
		, HA.NodeGUID as HANodeGUID
 
		, NULL as SiteLastModified
		, NULL as Account_ItemModifiedWhen
		--, c.DocumentModifiedWhen as Campaign_DocumentModifiedWhen
		, NULL as Campaign_DocumentModifiedWhen
		, HA.DocumentModifiedWhen as Assessment_DocumentModifiedWhen
		, VHFHAMJ.DocumentModifiedWhen as Module_DocumentModifiedWhen
		, VHFHARCJ.DocumentModifiedWhen as RiskCategory_DocumentModifiedWhen
		, VHFHARAJ.DocumentModifiedWhen as RiskArea_DocumentModifiedWhen
		, VHFHAQ.DocumentModifiedWhen as Question_DocumentModifiedWhen
		, VHFHAA.DocumentModifiedWhen as Answer_DocumentModifiedWhen
FROM

--dbo.View_CMS_Tree_Joined AS VCTJ
		--INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
		--INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID
 
		--Campaign links Client which links to Assessment
		--INNER JOIN dbo.View_HFit_HACampaign_Joined as c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID	--Note: 
 
View_HFit_HealthAssessment_Joined HA WITH (NOLOCK) 
 INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ ON HA.NodeID = VHFHAMJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
 INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
 LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA ON VHFHAQ.NodeID = VHFHAA.NodeParentID

		--matrix level 1 questiongroup
		--INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
		--INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID

		--Branching Level 1 Question 
		INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ3 ON VHFHAA.NodeID = VHFHAQ3.NodeParentID
		LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA3 ON VHFHAQ3.NodeID = VHFHAA3.NodeParentID

		--Matrix Level 2 Question Group
		--INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ7 ON VHFHAQ3.NodeID = VHFHAQ7.NodeParentID
		--INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA7 ON VHFHAQ7.NodeID = VHFHAA7.NodeParentID

		--Matrix branching level 1 question group
		--INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ8 ON VHFHAA7.NodeID = VHFHAQ8.NodeParentID
		--INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA8 ON VHFHAQ8.NodeID = VHFHAA8.NodeParentID

		--Branching level 2 Question Group
		INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ4 ON VHFHAA3.NodeID = VHFHAQ4.NodeParentID
		INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA4 ON VHFHAQ4.NodeID = VHFHAA4.NodeParentID

		--Branching level 3 Question Group
		--select count(*) from dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA4
		INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ5 ON VHFHAA4.NodeID = VHFHAQ5.NodeParentID
		INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA5 ON VHFHAQ5.NodeID = VHFHAA5.NodeParentID

		--Branching level 4 Question Group
		INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ6 ON VHFHAA5.NodeID = VHFHAQ6.NodeParentID
		INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA6 ON VHFHAQ6.NodeID = VHFHAA6.NodeParentID

		--Branching level 5 Question Group
		INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ9 ON VHFHAA6.NodeID = VHFHAQ9.NodeParentID
		INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA9 ON VHFHAQ9.NodeID = VHFHAA9.NodeParentID

	where  VHFHAQ.DocumentCulture = 'en-us'	
		and (VHFHAA.DocumentCulture = 'en-us' OR VHFHAA.DocumentCulture is null)	--WDM 08.12.2014		
		and VHFHARCJ.DocumentCulture = 'en-us'	
		and VHFHARAJ.DocumentCulture = 'en-us'	
		and VHFHAMJ.DocumentCulture = 'en-us'	--WDM 08.12.2014	
		and HA.DocumentCulture = 'en-us'	--WDM 08.12.2014		
GO

print ('Processed: view_EDW_HealthAssesmentDeffinition ') ;
go

GO
Print ('Creating view view_EDW_RewardUserLevel');
GO

if exists(select name from sys.views where name = 'view_EDW_RewardUserLevel')
BEGIN
	drop view view_EDW_RewardUserLevel ;
END
GO

create view view_EDW_RewardUserLevel
as
SELECT DISTINCT us.UserId, dl.LevelCompletedDt, rlj.NodeName AS LevelName, s.SiteName
  FROM [HFit_RewardsUserLevelDetail] dl INNER JOIN
  [View_HFit_RewardLevel_Joined] rlj ON rlj.NodeId = dl.LevelNodeId JOIN
  CMS_UserSite us ON us.UserId = dl.UserId JOIN
  CMS_Site s ON s.SiteId = us.SiteId

  
GO

Print ('Created view view_EDW_RewardUserLevel');
GO
print ('Processing: View_EDW_HealthAssesmentAnswers ') ;
go



if exists(select TABLE_NAME from INFORMATION_SCHEMA.VIEWS where TABLE_NAME = 'View_EDW_HealthAssesmentAnswers')
BEGIN
	drop view View_EDW_HealthAssesmentAnswers ;
END
GO


CREATE VIEW [dbo].[View_EDW_HealthAssesmentAnswers]
AS
--********************************************************************************************************
--WDM 8.8.2014 - Created this view in order to add the DocumentGUID as 
--			required by the EDW team. Was having a bit of push-back
--			from the developers, so created this one in order to 
--			expedite filling the need for runnable views for the EDW.
-- Verified last mod date available to EDW 9.10.2014
--********************************************************************************************************
      SELECT
        VHFHAPAJ.ClassName AS AnswerType
       ,VHFHAPAJ.Value
       ,VHFHAPAJ.Points
       ,VHFHAPAJ.NodeGUID
       ,VHFHAPAJ.IsEnabled
       ,VHFHAPAJ.CodeName
	   ,VHFHAPAJ.InputType
       ,VHFHAPAJ.UOM
       ,VHFHAPAJ.NodeAliasPath
       ,VHFHAPAJ.DocumentPublishedVersionHistoryID
       ,VHFHAPAJ.NodeID
       ,VHFHAPAJ.NodeOrder
       ,VHFHAPAJ.NodeLevel
       ,VHFHAPAJ.NodeParentID
       ,VHFHAPAJ.NodeLinkedNodeID
	   ,VHFHAPAJ.DocumentCulture
	   ,VHFHAPAJ.DocumentGuid
	   ,VHFHAPAJ.DocumentModifiedWhen
      FROM
        dbo.View_HFit_HealthAssesmentPredefinedAnswer_Joined AS VHFHAPAJ WITH(NOLOCK)
	where VHFHAPAJ.DocumentCulture = 'en-US'

GO

print ('Processed: View_EDW_HealthAssesmentAnswers ') ;
go





GO

if NOT exists(select name from sys.indexes where name = 'PI_CMSTREE_ClassDocID')
BEGIN
	CREATE NONCLUSTERED INDEX PI_CMSTR_ClassCulture
	ON [dbo].[View_CMS_Tree_Joined_Regular] ([ClassName],[DocumentCulture])
	INCLUDE ([NodeGUID],[DocumentForeignKeyValue])
END
GO

if NOT exists(select name from sys.indexes where name = 'PI_CMSTREE_ClassDocID')
BEGIN
	CREATE NONCLUSTERED INDEX PI_CMSTREE_ClassDocID
	ON [dbo].[View_CMS_Tree_Joined_Regular] ([ClassName],[DocumentID])
END
go

if NOT exists(select name from sys.indexes where name = 'CI_CMSTree_ClassLang')
BEGIN
	CREATE NONCLUSTERED INDEX CI_CMSTree_ClassLang
	ON [dbo].[View_CMS_Tree_Joined_Regular] ([ClassName],[DocumentCulture])
	INCLUDE ([NodeID],[NodeAliasPath],[NodeParentID],[NodeLevel],[NodeGUID],[NodeOrder],[NodeLinkedNodeID],[DocumentModifiedWhen],[DocumentForeignKeyValue],[DocumentPublishedVersionHistoryID],[DocumentGUID])
END


if NOT exists(select name from sys.indexes where name = 'CI_HFit_HealthAssesmentUserQuestion_NodeGUID')
BEGIN
	CREATE NONCLUSTERED INDEX [ci_HFit_HealthAssesmentUserQuestion_NodeGUID]
	ON [dbo].[HFit_HealthAssesmentUserQuestion] ([HAQuestionNodeGUID])
	INCLUDE ([ItemID],[HAQuestionScore],[ItemModifiedWhen],[HARiskAreaItemID],[CodeName],[PreWeightedScore],[IsProfessionallyCollected])
END
GO

if NOT exists(select name from sys.indexes where name = 'PI_GuidLang')
BEGIN
	CREATE NONCLUSTERED INDEX [PI_GuidLang]
	ON [dbo].[View_CMS_Tree_Joined_Regular] ([NodeGUID],[DocumentCulture])
END
Go

if NOT exists(select name from sys.indexes where name = 'PI_ClassLang')
BEGIN
	CREATE NONCLUSTERED INDEX PI_ClassLang
	ON [dbo].[View_CMS_Tree_Joined_Regular] ([ClassName],[DocumentCulture])
	INCLUDE ([NodeGUID],[DocumentForeignKeyValue])
END
GO

if NOT exists(select name from sys.indexes where name = 'PI_Linked_ClassLang')
BEGIN
CREATE NONCLUSTERED INDEX PI_Linked_ClassLang
	ON [dbo].[View_CMS_Tree_Joined_Linked] ([ClassName],[DocumentCulture])
	INCLUDE ([NodeGUID],[DocumentForeignKeyValue])
END
GO        

--drop index [dbo].[View_CMS_Tree_Joined_Regular].[IX_View_CMS_Tree_Joined_Regular_NodeSiteID_DocumentCulture_NodeID]
--go

--CREATE UNIQUE CLUSTERED INDEX [IX_View_CMS_Tree_Joined_Regular_NodeSiteID_DocumentCulture_NodeID] 
--ON [dbo].[View_CMS_Tree_Joined_Regular]
--(
-- [NodeSiteID] ASC,
-- [DocumentCulture] ASC,
-- [NodeID] ASC,
-- [NodeParentID] ASC,
-- [DocumentID] ASC,
-- [DocumentPublishedVersionHistoryID] ASC,
-- [DocumentGUID] ASC
--)

GO

PRINT('Processing view_EDW_HealthAssesment');
GO


if exists(select name from sys.views where name = 'view_EDW_HealthAssesment')
BEGIN
	drop view view_EDW_HealthAssesment 
END
go

CREATE VIEW [dbo].[view_EDW_HealthAssesment]
AS
--********************************************************************************************************
--7/15/2014 17:19 min. 46,750 Rows DEV
--7/15/2014 per Mark Turner
--HAModuleDocumentID is on its way out, so is - 
--Module - RiskCategory - RiskArea - Question - Answer 
--all the "DocumentID" fields are deprecated and replaced by corresponding NodeGUID fields
--8/7/2014 - Executed in DEV with GUID changes and returned 51K Rows in 00:43:10.
--8/8/2014 - Generated corrected view in DEV
-- Verified last mod date available to EDW 9.10.2014

--09.08.2014: John Croft and I working together, realized there is a deficit in the ability 
--of the EDW to recognize changes to database records based on the last modified date of a row. 
--The views that we are currently using in the database or deeply nested. This means that 
--several base tables are involved in building a single view of data.
--
--09.30.2014: Verified with John Croft that he does want this view to return multi-languages.
--
--The views were initially designed to recognize a date change based on a record change very 
--high in the data hierarchy, the CMS Tree level which is the top most level. However, John 
--and I recognize that data can change at any level in the hierarchy and those changes must be 
--recognized as well. Currently, that is not the case. With the new modification to the views, 
--changes in CMS documents and base tables will filter up through the hierarchy and the EDW load 
--process will be able to realize that a change in this row’s data may affect and intrude into 
--the warehouse.

-- 10.01.2014 - Reviewed by Mark and Dale for use of the GUIDS
-- 10.01.2014 - Reviewed by Mark and Dale for use of Joins and fixed two that were incorrect (Thanks to Mark)

-- 10.23.2014 - (WDM) added two columns for the EDW HAPaperFlg / HATelephonicFlg
--			HAPaperFlg is whether the question was reveived electronically or on paper
--			HATelephonicFlg is whether the question was reveived by telephone or not

-- FIVE Pieces needed per John C. 10.16.2014
--	Document GUID -> HealthAssesmentUserStartedNodeGUID
--	Module GUID -> Module -> HAUserModule.HAModuleNodeGUID
--	Category GUID -> Category
--	RiskArea Node Guid -> RiskArea 
--	Question Node Guid -> Question
--	Answer Node Guid -> Answer 

 --   10.30.2014 : Sowmiya 
 --   The following are the possible values allowed in the HAStartedMode and HACompletedMode columns of the Hfit_HealthAssesmentUserStarted table
 --      Unknown = 0, 
 --       Paper = 1,  // Paper HA
 --       Telephonic = 2, // Telephonic HA
 --       Online = 3, // Online HA
 --       Ipad = 4 // iPAD
--********************************************************************************************************

	--11.05.2014 - removed the Distinct - may find it necessary to put it back as duplicates may be there.
	SELECT  --distinct
		HAUserStarted.ItemID AS UserStartedItemID				
		, VHAJ.NodeGUID as  HealthAssesmentUserStartedNodeGUID	--Per John C. 10.16.2014 requested that this be put back into the view.	
																--11.05.2014 - Changed from CMS_TREE Joined to View_HFit_HealthAssessment_Joined Mark T. / Dale M.
		, HAUserStarted.UserID
		, CMSUser.UserGUID
		, UserSettings.HFitUserMpiNumber
		, CMSSite.SiteGUID
		, ACCT.AccountID
		, ACCT.AccountCD
		, HAUserStarted.HAStartedDt
		, HAUserStarted.HACompletedDt
		, HAUserModule.ItemID AS UserModuleItemId
		, HAUserModule.CodeName AS UserModuleCodeName
		
		--, VCTJ.DocumentGUID as HAModuleNodeGUID	--WDM 8/7/2014 as HAModuleDocumentID
		--, VCTJ.NodeGUID as HAModuleNodeGUID		--WDM 9/30/2014 as HAModuleDocumentID	--Mark and Dale use NodeGUID instead of Doc GUID
		--, VCTJ.NodeGUID as CMSNodeGuid			--WDM 8/7/2014 as HAModuleDocumentID	--Left this and the above to kepp existing column structure

		, HAUserModule.HAModuleNodeGUID				--WDM 9/30/2014 as HAModuleDocumentID	--Mark and Dale use NodeGUID instead of Doc GUID
		
		--, NULL as CMSNodeGuid						--WDM 8/7/2014 as HAModuleDocumentID	--WDM 10.02.2014 place holder for EDW ETL
		, VHAJ.NodeGUID as CMSNodeGuid				--WDM 8/7/2014 as HAModuleDocumentID	--WDM 10.02.2014 place holder for EDW ETL per John C., Added back per John C. 10.16.2014

		, NULL as HAModuleVersionID		--WDM 10.02.2014 place holder for EDW ETL
		, HARiskCategory.ItemID AS UserRiskCategoryItemID
		, HARiskCategory.CodeName AS UserRiskCategoryCodeName
		, HARiskCategory.HARiskCategoryNodeGUID						--WDM 8/7/2014 as HARiskCategoryDocumentID
		, NULL as HARiskCategoryVersionID			--WDM 10.02.2014 place holder for EDW ETL
		, HAUserRiskArea.ItemID AS UserRiskAreaItemID
		, HAUserRiskArea.CodeName AS UserRiskAreaCodeName
		, HAUserRiskArea.HARiskAreaNodeGUID							--WDM 8/7/2014 as HARiskAreaDocumentID
		, NULL as HARiskAreaVersionID			--WDM 10.02.2014 place holder for EDW ETL
		, HAUserQuestion.ItemID AS UserQuestionItemID
		, HAQuestionsView.Title
		, HAUserQuestion.HAQuestionNodeGUID	as HAQuestionGuid		--WDM 9.2.2014	This is a repeat field but had to stay to match the previous view - this is the NODE GUID 
		--															and matches to the definition file to get the question. This tells you the question, language agnostic.
		, HAUserQuestion.CodeName AS UserQuestionCodeName
		, NULL as HAQuestionDocumentID	--WDM 10.1.2014 - this is GOING AWAY 		--WDM 10.02.2014 place holder for EDW ETL
		, NULL as HAQuestionVersionID			--WDM 10.1.2014 - this is GOING AWAY - no versions across environments 		--WDM 10.02.2014 place holder for EDW ETL
		, HAUserQuestion.HAQuestionNodeGUID		--WDM 10.01.2014	Left this in place to preserve column structure.		
		, HAUserAnswers.ItemID AS UserAnswerItemID
		, HAUserAnswers.HAAnswerNodeGUID								--WDM 8/7/2014 as HAAnswerDocumentID
		, NULL as HAAnswerVersionID		--WDM 10.1.2014 - this is GOING AWAY - no versions across environments		--WDM 10.02.2014 place holder for EDW ETL
		, HAUserAnswers.CodeName AS UserAnswerCodeName
		, HAUserAnswers.HAAnswerValue
		, HAUserModule.HAModuleScore
		, HARiskCategory.HARiskCategoryScore
		, HAUserRiskArea.HARiskAreaScore
		, HAUserQuestion.HAQuestionScore
		, HAUserAnswers.HAAnswerPoints
		, HAUserQuestionGroupResults.PointResults
		, HAUserAnswers.UOMCode
		, HAUserStarted.HAScore
		, HAUserModule.PreWeightedScore AS ModulePreWeightedScore
		, HARiskCategory.PreWeightedScore AS RiskCategoryPreWeightedScore
		, HAUserRiskArea.PreWeightedScore AS RiskAreaPreWeightedScore
		, HAUserQuestion.PreWeightedScore AS QuestionPreWeightedScore
		, HAUserQuestionGroupResults.CodeName AS QuestionGroupCodeName       
       ,CASE WHEN HAUserAnswers.ItemCreatedWhen = HAUserAnswers.ItemModifiedWhen THEN 'I'
             ELSE 'U'
        END AS ChangeType
		,HAUserAnswers.ItemCreatedWhen
       ,HAUserAnswers.ItemModifiedWhen
	   ,HAUserQuestion.IsProfessionallyCollected

	   ,HARiskCategory.ItemModifiedWhen as HARiskCategory_ItemModifiedWhen
	   ,HAUserRiskArea.ItemModifiedWhen as HAUserRiskArea_ItemModifiedWhen
	   ,HAUserQuestion.ItemModifiedWhen as HAUserQuestion_ItemModifiedWhen
	   ,HAUserAnswers.ItemModifiedWhen as HAUserAnswers_ItemModifiedWhen
	   ,HAUserStarted.HAPaperFlg
	   ,HAUserStarted.HATelephonicFlg
	   --,HAUserStarted.HAStartedMode
	   --,HAUserStarted.HACompletedMode
	FROM
	dbo.HFit_HealthAssesmentUserStarted AS HAUserStarted
	INNER JOIN dbo.CMS_User AS CMSUser ON HAUserStarted.UserID = CMSUser.UserID
	INNER JOIN dbo.CMS_UserSettings AS UserSettings ON UserSettings.UserSettingsUserID = CMSUser.UserID
	INNER JOIN dbo.CMS_UserSite AS UserSite ON CMSUser.UserID = UserSite.UserID
	INNER JOIN dbo.CMS_Site AS CMSSite ON UserSite.SiteID = CMSSite.SiteID
	INNER JOIN dbo.HFit_Account AS ACCT ON ACCT.SiteID = CMSSite.SiteID	
	INNER JOIN dbo.HFit_HealthAssesmentUserModule AS HAUserModule ON HAUserStarted.ItemID = HAUserModule.HAStartedItemID
		
	inner join View_HFit_HACampaign_Joined VHCJ on VHCJ.NodeGUID = HAUserStarted.HACampaignNodeGUID 
		AND VHCJ.NodeSiteID = UserSite.SiteID AND VHCJ.DocumentCulture = 'en-US'	--11.05.2014 - Mark T. / Dale M. - 
	
	--11.05.2014 - Mark T. / Dale M. needed to get the Document for the user
	inner join View_HFit_HealthAssessment_Joined VHAJ on VHAJ.DocumentID = VHCJ.HealthAssessmentID
	
	--11.05.2014 - Mark T. / Dale M. removed the link to View_CMS_Tree_Joined and replaced with View_HFit_HealthAssessment_Joined
	--inner join View_CMS_Tree_Joined as VCTJ on VCTJ.NodeGUID = HAUserModule.HAModuleNodeGUID
	--	and VCTJ.DocumentCulture = 'en-US'	--10.01.2014 put here to match John C. req. for language agnostic.

	INNER JOIN dbo.HFit_HealthAssesmentUserRiskCategory AS HARiskCategory ON HAUserModule.ItemID = HARiskCategory.HAModuleItemID
	INNER JOIN dbo.HFit_HealthAssesmentUserRiskArea AS HAUserRiskArea ON HARiskCategory.ItemID = HAUserRiskArea.HARiskCategoryItemID
	INNER JOIN dbo.HFit_HealthAssesmentUserQuestion AS HAUserQuestion ON HAUserRiskArea.ItemID = HAUserQuestion.HARiskAreaItemID
	INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS HAQuestionsView ON HAUserQuestion.HAQuestionNodeGUID = HAQuestionsView.NodeGUID
		AND HAQuestionsView.DocumentCulture = 'en-US'
	LEFT OUTER JOIN dbo.HFit_HealthAssesmentUserQuestionGroupResults AS HAUserQuestionGroupResults ON HAUserRiskArea.ItemID = HAUserQuestionGroupResults.HARiskAreaItemID
	INNER JOIN dbo.HFit_HealthAssesmentUserAnswers AS HAUserAnswers ON HAUserQuestion.ItemID = HAUserAnswers.HAQuestionItemID


GO


PRINT('Processed view_EDW_HealthAssesment');

go
print ('Processing view_EDW_BioMetrics' +  cast(getdate() as nvarchar(50)) + '  *** view_EDW_BioMetrics.sql' );
GO

--*****************************************************************************************************************************************
--************** TEST Criteria and Results ************************************************************************************************
--INSERT INTO [dbo].[EDW_BiometricViewRejectCriteria] ([AccountCD],[ItemCreatedWhen],[SiteID]) VALUES('XX','2014-03-19 00:00:00.000',17  )  
--NOTE:		XX is used so that the AccountCD is NOT taken into account and only SiteID and ItemCreatedWhen is used.
--GO	--Tested by wdm on 11.21.2014

--INSERT INTO [dbo].[EDW_BiometricViewRejectCriteria]([AccountCD],[ItemCreatedWhen],[SiteID])VALUES('JnJ','2014-03-19 00:00:00.000',-1)         
--NOTE:		-1 is used so that the SiteID is NOT taken into account and only AccountCD and ItemCreatedWhen is used.
--GO	--Tested by wdm on 11.21.2014

--select * from view_EDW_BioMetrics where ItemCreatedWhen < '2014-03-19' and AccountCD = 'JnJ' returns 1034
--		so the number should be 43814 - 1034 = 42780 with AccountCD = 'JnJ' and ItemCreatedWhen = '2014-03-19'
--		in table EDW_BiometricViewRejectCriteria. And it worked (wdm) 11.21.2014
--GO	--Tested by wdm on 11.21.2014

--select * from view_EDW_BioMetrics where SiteID = 17 and ItemCreatedWhen < '2014-03-19' returns 22,974
--		so the number should be 43814 - 22974 = 20840 with SIteID = 17 and ItemCreatedWhen = '2014-03-19'
--		in table EDW_BiometricViewRejectCriteria. And it worked (wdm) 11.21.2014
--GO	--Tested by wdm on 11.21.2014

--drop table EDW_BiometricViewRejectCriteria
--*****************************************************************************************************************************************
if NOT exists (Select name from sys.tables where name = 'EDW_BiometricViewRejectCriteria')
BEGIN
	print('EDW_BiometricViewRejectCriteria NOT found, creating');
	--This table contains the REJECT specifications for Biometric data. An entry causes all records before a date for a Client or SITE to be ignored.
	CREATE TABLE dbo.EDW_BiometricViewRejectCriteria
	(
		--Use AccountCD and ItemCreatedWhen together OR SiteID and ItemCreatedWhen together. They work and reject in pairs.
		AccountCD nvarchar(8) NOT NULL,
		ItemCreatedWhen datetime NOT NULL,
		SiteID int NOT NULL,
		RejectGUID uniqueidentifier NULL
	) ;

	ALTER TABLE dbo.EDW_BiometricViewRejectCriteria ADD CONSTRAINT
		DF_EDW_BiometricViewRejectCriteria_RejectGUID DEFAULT newid() FOR RejectGUID ;

	ALTER TABLE dbo.EDW_BiometricViewRejectCriteria SET (LOCK_ESCALATION = TABLE) ;
	
	EXEC sp_addextendedproperty 
    @name = N'PURPOSE', @value = 'This table contains the REJECT specifications for Biometric data. An entry causes all records before a date for a Client or SITE to be ignored. The data is entered as SiteID and Rejection Date OR AccountCD and Rejection Date. All dates prior to the rejection date wil be ignored.',
    @level0type = N'Schema', @level0name = 'dbo',
    @level1type = N'Table', @level1name = 'EDW_BiometricViewRejectCriteria' ;
    --@level2type = N'Column', @level2name = NULL

	EXEC sp_addextendedproperty 
    @name = N'MS_Description', @value = 'Use AccountCD and ItemCreatedWhen together, entering a non-existant value for SiteID. They work and reject in pairs and this type of entry will only take AccountCD and ItemCreatedWhen date into consideration.',
    @level0type = N'Schema', @level0name = 'dbo',
    @level1type = N'Table', @level1name = 'EDW_BiometricViewRejectCriteria',
    @level2type = N'Column', @level2name = 'AccountCD' ;

	EXEC sp_addextendedproperty 
    @name = N'USAGE', @value = 'Use SiteID and ItemCreatedWhen together, entering a non-existant value for AccountCD. They work and reject in pairs.',
    @level0type = N'Schema', @level0name = 'dbo',
    @level1type = N'Table', @level1name = 'EDW_BiometricViewRejectCriteria',
    @level2type = N'Column', @level2name = 'SiteID' ;

	EXEC sp_addextendedproperty 
    @name = N'USAGE', @value = 'Use AccountCD or SiteID and ItemCreatedWhen together. They work and reject in pairs. Any date before this date will NOT be retrieved.',
    @level0type = N'Schema', @level0name = 'dbo',
    @level1type = N'Table', @level1name = 'EDW_BiometricViewRejectCriteria',
    @level2type = N'Column', @level2name = 'ItemCreatedWhen' ;
END
GO

if not exists (select name from sys.indexes where name = 'PKI_EDW_BiometricViewRejectCriteria')
BEGIN
	print('PKI_EDW_BiometricViewRejectCriteria NOT found, creating');
	CREATE UNIQUE CLUSTERED INDEX [PKI_EDW_BiometricViewRejectCriteria] ON [dbo].[EDW_BiometricViewRejectCriteria]
	(
		[AccountCD] ASC,
		[ItemCreatedWhen] ASC,
		[SiteID] ASC
	) ;
END


if exists (Select name from sys.views where name = 'view_EDW_BioMetrics')
BEGIN
	print('Replacing view_EDW_BioMetrics.');
	drop view view_EDW_BioMetrics ;
END
GO
print('Creating view_EDW_BioMetrics.');
go

CREATE VIEW [dbo].[view_EDW_BioMetrics]
AS
      SELECT DISTINCT
	--HFit_UserTracker
        HFUT.UserID
       ,cus.UserSettingsUserGUID AS UserGUID
       ,cus.HFitUserMpiNumber
       ,cus2.SiteID
       ,cs.SiteGUID
       ,NULL AS CreatedDate
       ,NULL AS ModifiedDate
       ,NULL AS Notes
       ,NULL AS IsProfessionallyCollected
       ,NULL AS EventDate
       ,'Not Build Yet' AS EventName
       
	--HFit_TrackerWeight
       ,NULL AS PPTWeight
       
	--HFit_TrackerHbA1C
       ,NULL AS PPTHbA1C
       
	--HFit_TrackerCholesterol
       ,NULL AS Fasting
       ,NULL AS HDL
       ,NULL AS LDL
       ,NULL AS Ratio
       ,NULL AS Total
       ,NULL AS Triglycerides
       
	--HFit_TrackerBloodSugarandGlucose
       ,NULL AS Glucose
       ,NULL AS FastingState
       
	--HFit_TrackerBloodPressure
       ,NULL AS Systolic
       ,NULL AS Diastolic
       
	--HFit_TrackerBodyFat
       ,NULL AS PPTBodyFatPCT
       
	--HFit_TrackerBMI
       ,NULL AS BMI
       
	--HFit_TrackerBodyMeasurements
       ,NULL AS WaistInches
       ,NULL AS HipInches
       ,NULL AS ThighInches
       ,NULL AS ArmInches
       ,NULL AS ChestInches
       ,NULL AS CalfInches
       ,NULL AS NeckInches
       
	--HFit_TrackerHeight
       ,NULL AS Height
       
	--HFit_TrackerRestingHeartRate
       ,NULL AS HeartRate
       ,
	--HFit_TrackerShots
        NULL AS FluShot
       ,NULL AS PneumoniaShot
       
	--HFit_TrackerTests
       ,NULL AS PSATest
       ,NULL AS OtherExam
       ,NULL AS TScore
       ,NULL AS DRA
       ,NULL AS CotinineTest
       ,NULL AS ColoCareKit
       ,NULL AS CustomTest
       ,NULL AS CustomDesc
       ,NULL AS CollectionSource
       ,HFA.AccountID
       ,HFA.AccountCD
       ,CASE WHEN HFUT.ItemCreatedWhen = COALESCE(HFUT.ItemModifiedWhen, hfut.ItemCreatedWhen) THEN 'I'
             ELSE 'U'
        END AS ChangeType
       ,HFUT.ItemCreatedWhen
       ,HFUT.ItemModifiedWhen
	   ,0   As TrackerCollectionSourceID 
      FROM
        dbo.HFit_UserTracker AS HFUT WITH ( NOLOCK )
      INNER JOIN dbo.CMS_UserSettings AS CUS WITH ( NOLOCK ) ON hfut.UserID = cus.UserSettingsUserID
      INNER JOIN dbo.CMS_UserSite AS CUS2 WITH ( NOLOCK ) ON cus.UserSettingsUserID = cus2.UserID
      INNER JOIN dbo.CMS_Site AS CS WITH ( NOLOCK ) ON CUS2.SiteID = CS.SiteID
      INNER JOIN dbo.HFit_Account AS HFA WITH ( NOLOCK ) ON cs.SiteID = HFA.SiteID
	  --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table EDW_BiometricViewRejectCriteria
	  Where CS.SITEID NOT IN (Select SiteID from EDW_BiometricViewRejectCriteria where HFUT.ItemCreatedWhen < ItemCreatedWhen)
			AND HFA.AccountCD NOT IN (Select AccountCD from EDW_BiometricViewRejectCriteria where HFA.AccountCD = AccountCD AND HFUT.ItemCreatedWhen < ItemCreatedWhen)
			--11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table EDW_BiometricViewRejectCriteria
	  UNION ALL
      SELECT
        hftw.UserID
       ,cus.UserSettingsUserGUID
       ,cus.HFitUserMpiNumber
       ,cus2.SiteID
       ,cs.SiteGUID
       ,HFTW.ItemCreatedWhen
       ,HFTW.ItemModifiedWhen
       ,HFTW.Notes
       ,HFTW.IsProfessionallyCollected
       ,HFTW.EventDate
       ,'Not Build Yet' AS EventName
       ,hftw.Value AS PPTWeight
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,HFTCS.CollectionSourceName_External
       ,HFA.AccountID
       ,HFA.AccountCD
       ,CASE WHEN HFTW.ItemCreatedWhen = COALESCE(HFTW.ItemModifiedWhen, HFTW.ItemCreatedWhen) THEN 'I'
             ELSE 'U'
        END AS ChangeType
       ,HFTW.ItemCreatedWhen
       ,HFTW.ItemModifiedWhen
	   ,HFTCS.TrackerCollectionSourceID
      FROM
        dbo.HFit_TrackerWeight AS HFTW WITH ( NOLOCK )
      INNER JOIN dbo.HFit_TrackerCollectionSource AS HFTCS WITH ( NOLOCK ) ON HFTW.TrackerCollectionSourceID = HFTCS.TrackerCollectionSourceID
      INNER JOIN dbo.CMS_UserSettings AS CUS WITH ( NOLOCK ) ON HFTW.UserID = cus.UserSettingsUserID
      INNER JOIN dbo.CMS_UserSite AS CUS2 WITH ( NOLOCK ) ON cus.UserSettingsUserID = cus2.UserID
      INNER JOIN dbo.CMS_Site AS CS WITH ( NOLOCK ) ON CUS2.SiteID = CS.SiteID
      INNER JOIN dbo.HFit_Account AS HFA WITH ( NOLOCK ) ON cs.SiteID = HFA.SiteID
	  --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table EDW_BiometricViewRejectCriteria
	  Where CS.SITEID NOT IN (Select SiteID from EDW_BiometricViewRejectCriteria where HFTW.ItemCreatedWhen < ItemCreatedWhen)
			AND HFA.AccountCD NOT IN (Select AccountCD from EDW_BiometricViewRejectCriteria where HFA.AccountCD = AccountCD AND HFTW.ItemCreatedWhen < ItemCreatedWhen)
      UNION ALL
      SELECT
        HFTHA.UserID
       ,cus.UserSettingsUserGUID
       ,cus.HFitUserMpiNumber
       ,cus2.SiteID
       ,cs.SiteGUID
       ,HFTHA.ItemCreatedWhen
       ,HFTHA.ItemModifiedWhen
       ,HFTHA.Notes
       ,HFTHA.IsProfessionallyCollected
       ,HFTHA.EventDate
       ,'Not Build Yet' AS EventName
       ,NULL
       ,HFTHA.Value AS PPTHbA1C
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,HFTCS.CollectionSourceName_External
       ,HFA.AccountID
       ,HFA.AccountCD
       ,CASE WHEN HFTHA.ItemCreatedWhen = COALESCE(HFTHA.ItemModifiedWhen, HFTHA.ItemCreatedWhen) THEN 'I'
             ELSE 'U'
        END AS ChangeType
       ,HFTHA.ItemCreatedWhen
       ,HFTHA.ItemModifiedWhen
	   ,HFTCS.TrackerCollectionSourceID
      FROM
        dbo.HFit_TrackerHbA1c AS HFTHA WITH ( NOLOCK )
      INNER JOIN dbo.HFit_TrackerCollectionSource AS HFTCS WITH ( NOLOCK ) ON HFTHA.TrackerCollectionSourceID = HFTCS.TrackerCollectionSourceID
      INNER JOIN dbo.CMS_UserSettings AS CUS WITH ( NOLOCK ) ON HFTHA.UserID = cus.UserSettingsUserID
      INNER JOIN dbo.CMS_UserSite AS CUS2 WITH ( NOLOCK ) ON cus.UserSettingsUserID = cus2.UserID
      INNER JOIN dbo.CMS_Site AS CS WITH ( NOLOCK ) ON CUS2.SiteID = CS.SiteID
      INNER JOIN dbo.HFit_Account AS HFA WITH ( NOLOCK ) ON cs.SiteID = HFA.SiteID
	  --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table EDW_BiometricViewRejectCriteria
	  Where CS.SITEID NOT IN (Select SiteID from EDW_BiometricViewRejectCriteria where HFTHA.ItemCreatedWhen < ItemCreatedWhen)
			AND HFA.AccountCD NOT IN (Select AccountCD from EDW_BiometricViewRejectCriteria where HFA.AccountCD = AccountCD AND HFTHA.ItemCreatedWhen < ItemCreatedWhen)
      UNION ALL
      SELECT
        HFTC.UserID
       ,cus.UserSettingsUserGUID
       ,cus.HFitUserMpiNumber
       ,cus2.SiteID
       ,cs.SiteGUID
       ,HFTC.ItemCreatedWhen
       ,HFTC.ItemModifiedWhen
       ,HFTC.Notes
       ,HFTC.IsProfessionallyCollected
       ,HFTC.EventDate
       ,'Not Build Yet' AS EventName
       ,NULL
       ,NULL
       ,HFTC.Fasting
       ,HFTC.HDL
       ,HFTC.LDL
       ,HFTC.Ratio
       ,HFTC.Total
       ,HFTC.Tri
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,HFTCS.CollectionSourceName_External
       ,HFA.AccountID
       ,HFA.AccountCD
       ,CASE WHEN HFTC.ItemCreatedWhen = COALESCE(HFTC.ItemModifiedWhen, HFTC.ItemCreatedWhen) THEN 'I'
             ELSE 'U'
        END AS ChangeType
       ,HFTC.ItemCreatedWhen
       ,HFTC.ItemModifiedWhen
	   ,HFTCS.TrackerCollectionSourceID
      FROM
        dbo.HFit_TrackerCholesterol AS HFTC WITH ( NOLOCK )
      INNER JOIN dbo.HFit_TrackerCollectionSource AS HFTCS WITH ( NOLOCK ) ON HFTC.TrackerCollectionSourceID = HFTCS.TrackerCollectionSourceID
      INNER JOIN dbo.CMS_UserSettings AS CUS WITH ( NOLOCK ) ON HFTC.UserID = cus.UserSettingsUserID
      INNER JOIN dbo.CMS_UserSite AS CUS2 WITH ( NOLOCK ) ON cus.UserSettingsUserID = cus2.UserID
      INNER JOIN dbo.CMS_Site AS CS WITH ( NOLOCK ) ON CUS2.SiteID = CS.SiteID
      INNER JOIN dbo.HFit_Account AS HFA WITH ( NOLOCK ) ON cs.SiteID = HFA.SiteID
	  --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table EDW_BiometricViewRejectCriteria
	  Where CS.SITEID NOT IN (Select SiteID from EDW_BiometricViewRejectCriteria where HFTC.ItemCreatedWhen < ItemCreatedWhen)
			AND HFA.AccountCD NOT IN (Select AccountCD from EDW_BiometricViewRejectCriteria where HFA.AccountCD = AccountCD AND HFTC.ItemCreatedWhen < ItemCreatedWhen)
      UNION ALL
      SELECT
        HFTBSAG.UserID
       ,cus.UserSettingsUserGUID
       ,cus.HFitUserMpiNumber
       ,cus2.SiteID
       ,cs.SiteGUID
       ,HFTBSAG.ItemCreatedWhen
       ,HFTBSAG.ItemModifiedWhen
       ,HFTBSAG.Notes
       ,HFTBSAG.IsProfessionallyCollected
       ,HFTBSAG.EventDate
       ,'Not Build Yet' AS EventName
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,HFTBSAG.Units
       ,HFTBSAG.FastingState
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,HFTCS.CollectionSourceName_External
       ,HFA.AccountID
       ,HFA.AccountCD
       ,CASE WHEN HFTBSAG.ItemCreatedWhen = COALESCE(HFTBSAG.ItemModifiedWhen, HFTBSAG.ItemCreatedWhen) THEN 'I'
             ELSE 'U'
        END AS ChangeType
       ,HFTBSAG.ItemCreatedWhen
       ,HFTBSAG.ItemModifiedWhen
	   ,HFTCS.TrackerCollectionSourceID
      FROM
        dbo.HFit_TrackerBloodSugarAndGlucose AS HFTBSAG WITH ( NOLOCK )
      INNER JOIN dbo.HFit_TrackerCollectionSource AS HFTCS WITH ( NOLOCK ) ON HFTBSAG.TrackerCollectionSourceID = HFTCS.TrackerCollectionSourceID
      INNER JOIN dbo.CMS_UserSettings AS CUS WITH ( NOLOCK ) ON HFTBSAG.UserID = cus.UserSettingsUserID
      INNER JOIN dbo.CMS_UserSite AS CUS2 WITH ( NOLOCK ) ON cus.UserSettingsUserID = cus2.UserID
      INNER JOIN dbo.CMS_Site AS CS WITH ( NOLOCK ) ON CUS2.SiteID = CS.SiteID
      INNER JOIN dbo.HFit_Account AS HFA WITH ( NOLOCK ) ON cs.SiteID = HFA.SiteID
	  --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table EDW_BiometricViewRejectCriteria
	  Where CS.SITEID NOT IN (Select SiteID from EDW_BiometricViewRejectCriteria where HFTBSAG.ItemCreatedWhen < ItemCreatedWhen)
			AND HFA.AccountCD NOT IN (Select AccountCD from EDW_BiometricViewRejectCriteria where HFA.AccountCD = AccountCD AND HFTBSAG.ItemCreatedWhen < ItemCreatedWhen)
      UNION ALL
      SELECT
        HFTBP.UserID
       ,cus.UserSettingsUserGUID
       ,cus.HFitUserMpiNumber
       ,cus2.SiteID
       ,cs.SiteGUID
       ,HFTBP.ItemCreatedWhen
       ,HFTBP.ItemModifiedWhen
       ,HFTBP.Notes
       ,HFTBP.IsProfessionallyCollected
       ,HFTBP.EventDate
       ,'Not Build Yet' AS EventName
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,HFTBP.Systolic
       ,HFTBP.Diastolic
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,HFTCS.CollectionSourceName_External
       ,HFA.AccountID
       ,HFA.AccountCD
       ,CASE WHEN HFTBP.ItemCreatedWhen = COALESCE(HFTBP.ItemModifiedWhen, HFTBP.ItemCreatedWhen) THEN 'I'
             ELSE 'U'
        END AS ChangeType
       ,HFTBP.ItemCreatedWhen
       ,HFTBP.ItemModifiedWhen
	   ,HFTCS.TrackerCollectionSourceID
      FROM
        dbo.HFit_TrackerBloodPressure AS HFTBP WITH ( NOLOCK )
      INNER JOIN dbo.HFit_TrackerCollectionSource AS HFTCS WITH ( NOLOCK ) ON HFTBP.TrackerCollectionSourceID = HFTCS.TrackerCollectionSourceID
      INNER JOIN dbo.CMS_UserSettings AS CUS WITH ( NOLOCK ) ON HFTBP.UserID = cus.UserSettingsUserID
      INNER JOIN dbo.CMS_UserSite AS CUS2 WITH ( NOLOCK ) ON cus.UserSettingsUserID = cus2.UserID
      INNER JOIN dbo.CMS_Site AS CS WITH ( NOLOCK ) ON CUS2.SiteID = CS.SiteID
      INNER JOIN dbo.HFit_Account AS HFA WITH ( NOLOCK ) ON cs.SiteID = HFA.SiteID
	  --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table EDW_BiometricViewRejectCriteria
	  Where CS.SITEID NOT IN (Select SiteID from EDW_BiometricViewRejectCriteria where HFTBP.ItemCreatedWhen < ItemCreatedWhen)
			AND HFA.AccountCD NOT IN (Select AccountCD from EDW_BiometricViewRejectCriteria where HFA.AccountCD = AccountCD AND HFTBP.ItemCreatedWhen < ItemCreatedWhen)
      UNION ALL
      SELECT
        HFTBF.UserID
       ,cus.UserSettingsUserGUID
       ,cus.HFitUserMpiNumber
       ,cus2.SiteID
       ,cs.SiteGUID
       ,HFTBF.ItemCreatedWhen
       ,HFTBF.ItemModifiedWhen
       ,HFTBF.Notes
       ,HFTBF.IsProfessionallyCollected
       ,HFTBF.EventDate
       ,'Not Build Yet' AS EventName
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,HFTBF.Value AS PPTBodyFatPCT
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,HFTCS.CollectionSourceName_External
       ,HFA.AccountID
       ,HFA.AccountCD
       ,CASE WHEN HFTBF.ItemCreatedWhen = COALESCE(HFTBF.ItemModifiedWhen, HFTBF.ItemCreatedWhen) THEN 'I'
             ELSE 'U'
        END AS ChangeType
       ,HFTBF.ItemCreatedWhen
       ,HFTBF.ItemModifiedWhen
	   ,HFTCS.TrackerCollectionSourceID
      FROM
        dbo.HFit_TrackerBodyFat AS HFTBF WITH ( NOLOCK )
      INNER JOIN dbo.HFit_TrackerCollectionSource AS HFTCS WITH ( NOLOCK ) ON HFTBF.TrackerCollectionSourceID = HFTCS.TrackerCollectionSourceID
      INNER JOIN dbo.CMS_UserSettings AS CUS WITH ( NOLOCK ) ON HFTBF.UserID = cus.UserSettingsUserID
      INNER JOIN dbo.CMS_UserSite AS CUS2 WITH ( NOLOCK ) ON cus.UserSettingsUserID = cus2.UserID
      INNER JOIN dbo.CMS_Site AS CS WITH ( NOLOCK ) ON CUS2.SiteID = CS.SiteID
      INNER JOIN dbo.HFit_Account AS HFA WITH ( NOLOCK ) ON cs.SiteID = HFA.SiteID
	  --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table EDW_BiometricViewRejectCriteria
	  Where CS.SITEID NOT IN (Select SiteID from EDW_BiometricViewRejectCriteria where HFTBF.ItemCreatedWhen < ItemCreatedWhen)
			AND HFA.AccountCD NOT IN (Select AccountCD from EDW_BiometricViewRejectCriteria where HFA.AccountCD = AccountCD AND HFTBF.ItemCreatedWhen < ItemCreatedWhen)
      UNION ALL
      SELECT
        HFTB.UserID
       ,cus.UserSettingsUserGUID
       ,cus.HFitUserMpiNumber
       ,cus2.SiteID
       ,cs.SiteGUID
       ,HFTB.ItemCreatedWhen
       ,HFTB.ItemModifiedWhen
       ,HFTB.Notes
       ,HFTB.IsProfessionallyCollected
       ,HFTB.EventDate
       ,'Not Build Yet' AS EventName
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,HFTB.BMI
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,HFTCS.CollectionSourceName_External
       ,HFA.AccountID
       ,HFA.AccountCD
       ,CASE WHEN HFTB.ItemCreatedWhen = COALESCE(HFTB.ItemModifiedWhen, HFTB.ItemCreatedWhen) THEN 'I'
             ELSE 'U'
        END AS ChangeType
       ,HFTB.ItemCreatedWhen
       ,HFTB.ItemModifiedWhen
	   ,HFTCS.TrackerCollectionSourceID
      FROM
        dbo.HFit_TrackerBMI AS HFTB WITH ( NOLOCK )
      INNER JOIN dbo.HFit_TrackerCollectionSource AS HFTCS WITH ( NOLOCK ) ON HFTB.TrackerCollectionSourceID = HFTCS.TrackerCollectionSourceID
      INNER JOIN dbo.CMS_UserSettings AS CUS WITH ( NOLOCK ) ON HFTB.UserID = cus.UserSettingsUserID
      INNER JOIN dbo.CMS_UserSite AS CUS2 WITH ( NOLOCK ) ON cus.UserSettingsUserID = cus2.UserID
      INNER JOIN dbo.CMS_Site AS CS WITH ( NOLOCK ) ON CUS2.SiteID = CS.SiteID
      INNER JOIN dbo.HFit_Account AS HFA WITH ( NOLOCK ) ON cs.SiteID = HFA.SiteID
	  --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table EDW_BiometricViewRejectCriteria
	  Where CS.SITEID NOT IN (Select SiteID from EDW_BiometricViewRejectCriteria where HFTB.ItemCreatedWhen < ItemCreatedWhen)
			AND HFA.AccountCD NOT IN (Select AccountCD from EDW_BiometricViewRejectCriteria where HFA.AccountCD = AccountCD AND HFTB.ItemCreatedWhen < ItemCreatedWhen)
      UNION ALL
      SELECT
        HFTBM.UserID
       ,cus.UserSettingsUserGUID
       ,cus.HFitUserMpiNumber
       ,cus2.SiteID
       ,cs.SiteGUID
       ,HFTBM.ItemCreatedWhen
       ,HFTBM.ItemModifiedWhen
       ,HFTBM.Notes
       ,HFTBM.IsProfessionallyCollected
       ,HFTBM.EventDate
       ,'Not Build Yet' AS EventName
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,HFTBM.WaistInches
       ,HFTBM.HipInches
       ,HFTBM.ThighInches
       ,HFTBM.ArmInches
       ,HFTBM.ChestInches
       ,HFTBM.CalfInches
       ,HFTBM.NeckInches
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,HFTCS.CollectionSourceName_External
       ,HFA.AccountID
       ,HFA.AccountCD
       ,CASE WHEN HFTBM.ItemCreatedWhen = COALESCE(HFTBM.ItemModifiedWhen, HFTBM.ItemCreatedWhen) THEN 'I'
             ELSE 'U'
        END AS ChangeType
       ,HFTBM.ItemCreatedWhen
       ,HFTBM.ItemModifiedWhen
	   ,HFTCS.TrackerCollectionSourceID
      FROM
        dbo.HFit_TrackerBodyMeasurements AS HFTBM WITH ( NOLOCK )
      INNER JOIN dbo.HFit_TrackerCollectionSource AS HFTCS WITH ( NOLOCK ) ON HFTBM.TrackerCollectionSourceID = HFTCS.TrackerCollectionSourceID
      INNER JOIN dbo.CMS_UserSettings AS CUS WITH ( NOLOCK ) ON HFTBM.UserID = cus.UserSettingsUserID
      INNER JOIN dbo.CMS_UserSite AS CUS2 WITH ( NOLOCK ) ON cus.UserSettingsUserID = cus2.UserID
      INNER JOIN dbo.CMS_Site AS CS WITH ( NOLOCK ) ON CUS2.SiteID = CS.SiteID
      INNER JOIN dbo.HFit_Account AS HFA WITH ( NOLOCK ) ON cs.SiteID = HFA.SiteID
	  --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table EDW_BiometricViewRejectCriteria
	  Where CS.SITEID NOT IN (Select SiteID from EDW_BiometricViewRejectCriteria where HFTBM.ItemCreatedWhen < ItemCreatedWhen)
			AND HFA.AccountCD NOT IN (Select AccountCD from EDW_BiometricViewRejectCriteria where HFA.AccountCD = AccountCD AND HFTBM.ItemCreatedWhen < ItemCreatedWhen)
      UNION ALL
      SELECT
        HFTH.UserID
       ,cus.UserSettingsUserGUID
       ,cus.HFitUserMpiNumber
       ,cus2.SiteID
       ,cs.SiteGUID
       ,HFTH.ItemCreatedWhen
       ,HFTH.ItemModifiedWhen
       ,HFTH.Notes
       ,HFTH.IsProfessionallyCollected
       ,HFTH.EventDate
       ,'Not Build Yet' AS EventName
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,HFTH.Height
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,HFTCS.CollectionSourceName_External
       ,HFA.AccountID
       ,HFA.AccountCD
       ,CASE WHEN HFTH.ItemCreatedWhen = COALESCE(HFTH.ItemModifiedWhen, HFTH.ItemCreatedWhen) THEN 'I'
             ELSE 'U'
        END AS ChangeType
       ,HFTH.ItemCreatedWhen
       ,HFTH.ItemModifiedWhen 
	   ,HFTCS.TrackerCollectionSourceID
      FROM
		dbo.HFit_TrackerHeight AS HFTH WITH ( NOLOCK )
		INNER JOIN dbo.HFit_TrackerCollectionSource AS HFTCS WITH ( NOLOCK ) ON HFTH.TrackerCollectionSourceID = HFTCS.TrackerCollectionSourceID
		INNER JOIN dbo.CMS_UserSettings AS CUS WITH ( NOLOCK ) ON HFTH.UserID = cus.UserSettingsUserID
		INNER JOIN dbo.CMS_UserSite AS CUS2 WITH ( NOLOCK ) ON cus.UserSettingsUserID = cus2.UserID
		INNER JOIN dbo.CMS_Site AS CS WITH ( NOLOCK ) ON CUS2.SiteID = CS.SiteID
		INNER JOIN dbo.HFit_Account AS HFA WITH ( NOLOCK ) ON cs.SiteID = HFA.SiteID
		--11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table EDW_BiometricViewRejectCriteria
		Where CS.SITEID NOT IN (Select SiteID from EDW_BiometricViewRejectCriteria where HFTH.ItemCreatedWhen < ItemCreatedWhen)
			AND HFA.AccountCD NOT IN (Select AccountCD from EDW_BiometricViewRejectCriteria where HFA.AccountCD = AccountCD AND HFTH.ItemCreatedWhen < ItemCreatedWhen)
      UNION ALL
      SELECT
        HFTRHR.UserID
       ,cus.UserSettingsUserGUID
       ,cus.HFitUserMpiNumber
       ,cus2.SiteID
       ,cs.SiteGUID
       ,HFTRHR.ItemCreatedWhen
       ,HFTRHR.ItemModifiedWhen
       ,HFTRHR.Notes
       ,HFTRHR.IsProfessionallyCollected
       ,HFTRHR.EventDate
       ,'Not Build Yet' AS EventName
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,HFTRHR.HeartRate
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,HFTCS.CollectionSourceName_External
       ,HFA.AccountID
       ,HFA.AccountCD
       ,CASE WHEN HFTRHR.ItemCreatedWhen = COALESCE(HFTRHR.ItemModifiedWhen, HFTRHR.ItemCreatedWhen) THEN 'I'
             ELSE 'U'
        END AS ChangeType
       ,HFTRHR.ItemCreatedWhen
       ,HFTRHR.ItemModifiedWhen
	   ,HFTCS.TrackerCollectionSourceID
      FROM
        dbo.HFit_TrackerRestingHeartRate AS HFTRHR WITH ( NOLOCK )
      INNER JOIN dbo.HFit_TrackerCollectionSource AS HFTCS WITH ( NOLOCK ) ON HFTRHR.TrackerCollectionSourceID = HFTCS.TrackerCollectionSourceID
      INNER JOIN dbo.CMS_UserSettings AS CUS WITH ( NOLOCK ) ON HFTRHR.UserID = cus.UserSettingsUserID
      INNER JOIN dbo.CMS_UserSite AS CUS2 WITH ( NOLOCK ) ON cus.UserSettingsUserID = cus2.UserID
      INNER JOIN dbo.CMS_Site AS CS WITH ( NOLOCK ) ON CUS2.SiteID = CS.SiteID
      INNER JOIN dbo.HFit_Account AS HFA WITH ( NOLOCK ) ON cs.SiteID = HFA.SiteID
	  --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table EDW_BiometricViewRejectCriteria
	  Where CS.SITEID NOT IN (Select SiteID from EDW_BiometricViewRejectCriteria where HFTRHR.ItemCreatedWhen < ItemCreatedWhen)
			AND HFA.AccountCD NOT IN (Select AccountCD from EDW_BiometricViewRejectCriteria where HFA.AccountCD = AccountCD AND HFTRHR.ItemCreatedWhen < ItemCreatedWhen)
      UNION ALL
      SELECT
        HFTS.UserID
       ,cus.UserSettingsUserGUID
       ,cus.HFitUserMpiNumber
       ,cus2.SiteID
       ,cs.SiteGUID
       ,HFTS.ItemCreatedWhen
       ,HFTS.ItemModifiedWhen
       ,HFTS.Notes
       ,HFTS.IsProfessionallyCollected
       ,HFTS.EventDate
       ,'Not Build Yet' AS EventName
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,HFTS.FluShot
       ,HFTS.PneumoniaShot
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,HFTCS.CollectionSourceName_External
       ,HFA.AccountID
       ,HFA.AccountCD
       ,CASE WHEN HFTS.ItemCreatedWhen = COALESCE(HFTS.ItemModifiedWhen, HFTS.ItemCreatedWhen) THEN 'I'
             ELSE 'U'
        END AS ChangeType
       ,HFTS.ItemCreatedWhen
       ,HFTS.ItemModifiedWhen
		,HFTCS.TrackerCollectionSourceID
      FROM
        dbo.HFit_TrackerShots AS HFTS WITH ( NOLOCK )
      INNER JOIN dbo.HFit_TrackerCollectionSource AS HFTCS WITH ( NOLOCK ) ON HFTS.TrackerCollectionSourceID = HFTCS.TrackerCollectionSourceID
      INNER JOIN dbo.CMS_UserSettings AS CUS WITH ( NOLOCK ) ON HFTS.UserID = cus.UserSettingsUserID
      INNER JOIN dbo.CMS_UserSite AS CUS2 WITH ( NOLOCK ) ON cus.UserSettingsUserID = cus2.UserID
      INNER JOIN dbo.CMS_Site AS CS WITH ( NOLOCK ) ON CUS2.SiteID = CS.SiteID
      INNER JOIN dbo.HFit_Account AS HFA WITH ( NOLOCK ) ON cs.SiteID = HFA.SiteID
	  --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table EDW_BiometricViewRejectCriteria
	  Where CS.SITEID NOT IN (Select SiteID from EDW_BiometricViewRejectCriteria where HFTS.ItemCreatedWhen < ItemCreatedWhen)
			AND HFA.AccountCD NOT IN (Select AccountCD from EDW_BiometricViewRejectCriteria where HFA.AccountCD = AccountCD AND HFTS.ItemCreatedWhen < ItemCreatedWhen)
      UNION ALL
      SELECT
        HFTT.UserID
       ,cus.UserSettingsUserGUID
       ,cus.HFitUserMpiNumber
       ,cus2.SiteID
       ,cs.SiteGUID
       ,HFTT.ItemCreatedWhen
       ,HFTT.ItemModifiedWhen
       ,HFTT.Notes
       ,HFTT.IsProfessionallyCollected
       ,HFTT.EventDate
       ,'Not Build Yet' AS EventName
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,HFTT.PSATest
       ,HFTT.OtherExam
       ,HFTT.TScore
       ,HFTT.DRA
       ,HFTT.CotinineTest
       ,HFTT.ColoCareKit
       ,HFTT.CustomTest
       ,HFTT.CustomDesc
       ,HFTCS.CollectionSourceName_External
       ,HFA.AccountID
       ,HFA.AccountCD
       ,CASE WHEN HFTT.ItemCreatedWhen = COALESCE(HFTT.ItemModifiedWhen, HFTT.ItemCreatedWhen) THEN 'I'
             ELSE 'U'
        END AS ChangeType
       ,HFTT.ItemCreatedWhen
       ,HFTT.ItemModifiedWhen
	   ,HFTCS.TrackerCollectionSourceID
      FROM
        dbo.HFit_TrackerTests AS HFTT WITH ( NOLOCK )
      INNER JOIN dbo.HFit_TrackerCollectionSource AS HFTCS WITH ( NOLOCK ) ON HFTT.TrackerCollectionSourceID = HFTCS.TrackerCollectionSourceID
      INNER JOIN dbo.CMS_UserSettings AS CUS WITH ( NOLOCK ) ON HFTT.UserID = cus.UserSettingsUserID
      INNER JOIN dbo.CMS_UserSite AS CUS2 WITH ( NOLOCK ) ON cus.UserSettingsUserID = cus2.UserID
      INNER JOIN dbo.CMS_Site AS CS WITH ( NOLOCK ) ON CUS2.SiteID = CS.SiteID
      INNER JOIN dbo.HFit_Account AS HFA WITH ( NOLOCK ) ON cs.SiteID = HFA.SiteID
	  --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table EDW_BiometricViewRejectCriteria
	  Where CS.SITEID NOT IN (Select SiteID from EDW_BiometricViewRejectCriteria where HFTT.ItemCreatedWhen < ItemCreatedWhen)
			AND HFA.AccountCD NOT IN (Select AccountCD from EDW_BiometricViewRejectCriteria where HFA.AccountCD = AccountCD AND HFTT.ItemCreatedWhen < ItemCreatedWhen)
	--HFit_TrackerBMI
	--HFit_TrackerBodyMeasurements
	--HFit_TrackerHeight
	--HFit_TrackerRestingHeartRate
	--HFit_TrackerShots
	--HFit_TrackerTests

GO

print ('Created view_EDW_BioMetrics' +  cast(getdate() as nvarchar(50)));
GO


print (' ' );
print ('Processing complete - please check for errors.' );  --  
  --  
GO 
print('***** FROM: _ViewFixMaster.sql'); 
GO 
