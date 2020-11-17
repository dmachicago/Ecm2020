print ('Processing: view_EDW_CoachingDefinition_CT ') ;
go

if exists(select TABLE_NAME from INFORMATION_SCHEMA.VIEWS where TABLE_NAME = 'view_EDW_CoachingDefinition_CT')
BEGIN
	drop view view_EDW_CoachingDefinition_CT ;
END
GO


--GRANT SELECT
--	ON [dbo].[view_EDW_CoachingDefinition_CT]
--	TO [EDWReader_PRD]
--GO


CREATE VIEW [dbo].[view_EDW_CoachingDefinition_CT]
AS
--********************************************************************************************************
--8/7/2014 - added DocumentGuid 
--8/8/2014 - Generated corrected view in DEV (WDM)
-- Verified last mod date available to EDW 9.10.2014
--11.17.2014 - (wdm) John Croft found an issue with multiple languages being returned.
--		view_EDW_CoachingDefinition_CT pulls its data from a nested view View_HFit_Tobacco_Goal_Joined. I added 
--		a Document Culture filter on the SELECT STATEMENT pulling the data from View_HFit_Tobacco_Goal_Joined.
--		In LAB DB, when the view is executed W/O the filter, I get 90 rows. When executed with the filter, I 
--		get 89 rows. This would indicate the filter can be applied at the SELCT statement level. The view has 
--		the change applied and is ready to be regenerated. Also, I needed to add a language filter to 
--		View_HFit_Goal_Joined. Additionally, I allow the view to return the Document Culture as a column so 
--		that we can see the associated language. This can be removed if not wanted, but for troubleshooting 
--		it is useful.
--********************************************************************************************************
/*
drop table TEMPXX;
go
select * 
into TEMPXX
from view_EDW_CoachingDefinition_CT

select count(*) from [view_EDW_CoachingDefinition_CT]
select * from [view_EDW_CoachingDefinition_CT]
*/
SELECT
	GJ.GoalID
	, GJ.DocumentGuid
	, GJ.NodeSiteID
	, cs.SiteGUID
	, GJ.GoalImage
	, GJ.Goal
	, dbo.udf_StripHTML(GJ.GoalText) GoalText --
	, dbo.udf_StripHTML(GJ.GoalSummary) GoalSummary --
	, GJ.TrackerAssociation
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
	,hashbytes('sha1',
		   isNull(cast(GJ.GoalID as nvarchar(50)),'-')
		   + isNull(cast( GJ.DocumentGuid as nvarchar(50)),'-')
		   + isNull(cast( GJ.NodeSiteID as nvarchar(50)),'-')
		   + isNull(cast( cs.SiteGUID as nvarchar(50)),'-')
		   + isNull(cast( GJ.GoalImage as nvarchar(50)),'-')
		   + isNull(cast( GJ.Goal as nvarchar(50)),'-')
		   + isnull(LEFT(GJ.GoalText,1000),'-')
		   + isnull(left(GJ.GoalSummary,1000),'-')
		   + isNull(cast( GJ.TrackerAssociation as nvarchar(50)),'-')
		   + isNull(cast( GJ.GoalFrequency as nvarchar(50)),'-')
		   + isNull(cast( HFLF.FrequencySingular as nvarchar(50)),'-')
		   + isNull(cast( HFLF.FrequencyPlural as nvarchar(50)),'-')
		   + isNull(cast( GJ.GoalUnitOfMeasure as nvarchar(50)),'-')
		   + isNull(cast( HFLUOM.UnitOfMeasure as nvarchar(50)),'-')
		   + isNull(cast( GJ.GoalDirection as nvarchar(50)),'-')
		   + isNull(cast( GJ.GoalPrecision as nvarchar(50)),'-')
		   + isNull(cast( GJ.GoalAbsoluteMin as nvarchar(50)),'-')
		   + isNull(cast( GJ.GoalAbsoluteMax as nvarchar(50)),'-')
		   + isnull(left(GJ.SetGoalText,1000),'-')
		   + isnull(left(GJ.HelpText,1000),'-')
		   + isNull(cast( GJ.EvaluationType as nvarchar(50)),'-')
		   + isNull(cast( GJ.CatalogDisplay as nvarchar(50)),'-')
		   + isNull(cast( GJ.AllowModification as nvarchar(50)),'-')
		   + isnull(left(GJ.ActivityText, 1000),'-')
		   + isnull(left(GJ.SetGoalModifyText,1000),'-')
		   + isNull(cast( GJ.IsLifestyleGoal as nvarchar(50)),'-')
		   + isNUll( GJ.CodeName, '-')
		   + isNull(cast( GJ.DocumentCreatedWhen as nvarchar(50)),'-')
		   + isNull(cast( GJ.DocumentModifiedWhen as nvarchar(50)),'-')
		   + isNull( GJ.DocumentCulture, '-')
	   ) as HashCode
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

--select * from view_EDW_CoachingDefinition_CT  --  
  --  
GO 
print('Completed: view_EDW_CoachingDefinition_CT.sql'); 
print('***** FROM: view_EDW_CoachingDefinition_CT.sql'); 
GO 
