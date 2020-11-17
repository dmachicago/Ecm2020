
GO
print('***** FROM: view_EDW_CoachingDetail_MART.sql'); 
go

print ('Processing: view_EDW_CoachingDetail_MART ') ;
go

if exists(select NAME from sys.indexes where NAME = 'CI2_View_CMS_Tree_Joined_Regular')
BEGIN
    print ('ANALYZING index CI2_View_CMS_Tree_Joined_Regular');
	drop index View_CMS_Tree_Joined_Regular.CI2_View_CMS_Tree_Joined_Regular;
END
GO

if not exists(select NAME from sys.indexes where NAME = 'CI2_View_CMS_Tree_Joined_Regular')
BEGIN
    print ('Updating index CI2_View_CMS_Tree_Joined_Regular');

	SET ARITHABORT ON
	SET CONCAT_NULL_YIELDS_NULL ON
	SET QUOTED_IDENTIFIER ON
	SET ANSI_NULLS ON
	SET ANSI_PADDING ON
	SET ANSI_WARNINGS ON
	SET NUMERIC_ROUNDABORT OFF

	CREATE NONCLUSTERED INDEX [CI2_View_CMS_Tree_Joined_Regular] ON [dbo].[View_CMS_Tree_Joined_Regular]
(
	[ClassName] ASC,
	[DocumentForeignKeyValue],
	[DocumentCulture] ASC
)
INCLUDE ( 	[NodeID], [NodeGUID]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

END
GO

-- select count(*) from view_EDW_CoachingDetail_MART
if exists(select TABLE_NAME from INFORMATION_SCHEMA.VIEWS where TABLE_NAME = 'view_EDW_CoachingDetail_MART')
BEGIN
	drop view view_EDW_CoachingDetail_MART ;
END
GO

--GRANT SELECT
--	ON [dbo].[[view_EDW_CoachingDetail_MART]]
--	TO [EDWReader_PRD]
--GO

/* TEST Queries
select * from [view_EDW_CoachingDetail_MART]
select * from [view_EDW_CoachingDetail_MART] where CloseReasonLKPID != 0
select count(*) from [view_EDW_CoachingDetail_MART]
*/

create VIEW [dbo].[view_EDW_CoachingDetail_MART]
AS
--********************************************************************************************
--8/7/2014 - added and commented out DocumentGuid in case needed later
--8/8/2014 - Generated corrected view in DEV (WDM)
-- Verified last mod date available to EDW 9.10.2014
-- 01.02.2014 (WDM) added column HFUG.CloseReasonLKPID in order to satisfy Story #47923
-- 01.06.2014 (WDM) Tested with team B and found that the data was being returned. Stipulating that 
--					we converted the inner join to left outer join dbo.HFit_GoalOutcome. This 
--					allows data to be returned with the meaning that if NULL HFGO.EvaluationDate
--					is returned, the GOAL may exist without any input/update from the coach or
--					PPT
-- 01.07.2014 (WDM) This also takes care of 47976
--********************************************************************************************
	SELECT	DISTINCT
		HFUG.ItemID
		, HFUG.ItemGUID
		, GJ.GoalID
		, HFUG.UserID
		, cu.UserGUID
		, cus.HFitUserMpiNumber
		, cs.SiteGUID
		, hfa.AccountID
		, hfa.AccountCD
		, hfa.AccountName
		, HFUG.IsCreatedByCoach
		, HFUG.BaselineAmount
		, HFUG.GoalAmount
		, Null As DocumentID
		, HFUG.GoalStatusLKPID
		, HFLGS.GoalStatusLKPName
		, cast(HFUG.EvaluationStartDate as datetime) as EvaluationStartDate
		, cast(HFUG.EvaluationEndDate as datetime) as EvaluationEndDate
		, cast(HFUG.GoalStartDate as datetime) as GoalStartDate
		, HFUG.CoachDescription
		, cast(HFGO.EvaluationDate as datetime) as EvaluationDate
		, HFGO.Passed
		, cast(HFGO.WeekendDate as datetime) as WeekendDate
		, CASE	WHEN CAST(HFUG.ItemCreatedWhen AS DATE) = CAST(HFUG.ItemModifiedWhen AS DATE)
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		, cast(HFUG.ItemCreatedWhen as datetime) as ItemCreatedWhen
		, cast(HFUG.ItemModifiedWhen as datetime) as ItemModifiedWhen
		, GJ.NodeGUID
		, HFUG.CloseReasonLKPID
		, GRC.CloseReason

	FROM
		dbo.HFit_UserGoal AS HFUG WITH ( NOLOCK )
	INNER JOIN (
					SELECT
						VHFGJ.GoalID
						, VHFGJ.NodeID
						, VHFGJ.NodeGUID
						, VHFGJ.DocumentCulture
						, VHFGJ.DocumentGuid
						, VHFGJ.DocumentModifiedWhen	--WDM added 9.10.2014
					FROM
						dbo.View_HFit_Goal_Joined AS VHFGJ WITH ( NOLOCK )
					UNION ALL
					SELECT
						VHFTGJ.GoalID
						, VHFTGJ.NodeID
						, VHFTGJ.NodeGUID
						, VHFTGJ.DocumentCulture
						, VHFTGJ.DocumentGuid
						, VHFTGJ.DocumentModifiedWhen	--WDM added 9.10.2014
					FROM
						dbo.View_HFit_Tobacco_Goal_Joined AS VHFTGJ WITH ( NOLOCK )
				) AS GJ ON hfug.NodeID = gj.NodeID and GJ.DocumentCulture = 'en-us'		
	left outer join dbo.HFit_GoalOutcome AS HFGO WITH ( NOLOCK ) ON HFUG.ItemID = HFGO.UserGoalItemID	
	INNER JOIN dbo.HFit_LKP_GoalStatus AS HFLGS WITH ( NOLOCK ) ON HFUG.GoalStatusLKPID = HFLGS.GoalStatusLKPID	
	INNER JOIN dbo.CMS_User AS CU WITH ( NOLOCK ) ON HFUG.UserID = cu.UserID
	INNER JOIN dbo.CMS_UserSettings AS CUS WITH ( NOLOCK ) ON CU.UserGUID = CUS.UserSettingsUserGUID
	INNER JOIN dbo.CMS_UserSite AS CUS2 WITH ( NOLOCK ) ON cu.UserID = CUS2.UserID	
	INNER JOIN dbo.CMS_Site AS CS WITH ( NOLOCK ) ON CUS2.SiteID = CS.SiteID
	INNER JOIN dbo.HFit_Account AS HFA WITH ( NOLOCK ) ON cs.SiteID = hfa.SiteID
	left outer join HFit_LKP_GoalCloseReason as GRC on GRC.CloseReasonID = HFUG.CloseReasonLKPID
GO

  --  
  --  
GO 
print('***** Created: view_EDW_CoachingDetail_MART'); 
GO 

--Testing History
--1.1.2015: WDM Tested table creation, data entry, and view join
--Testing Criteria
--select * from HFit_LKP_GoalCloseReason
--select * from view_EDW_CoachingDetail_MART
--select * from view_EDW_CoachingDetail_MART where userid in (13470, 107, 13299) and CloseReasonLKPID != 0 
--select * from view_EDW_CoachingDetail_MART where UserGUID = '9C7F1657-8568-4D5D-A797-C6AEEA86834F'
--select * from view_EDW_CoachingDetail_MART where EvaluationDate is null 
--select * from view_EDW_CoachingDetail_MART  where HFitUserMpiNumber in (6238677) and CloseReasonLKPID != 0 
--select * from HFit_UserGoal where UserGUID = '9C7F1657-8568-4D5D-A797-C6AEEA86834F'
