
GO
PRINT '***** FROM: view_EDW_CoachingDetail_CT.sql';
GO

PRINT 'Processing: view_EDW_CoachingDetail_CT ';
GO

--if exists(select NAME from sys.indexes where NAME = 'CI2_View_CMS_Tree_Joined_Regular')
--BEGIN
--    print ('ANALYZING index CI2_View_CMS_Tree_Joined_Regular');
--	drop index View_CMS_Tree_Joined_Regular.CI2_View_CMS_Tree_Joined_Regular;
--END
--GO

--if not exists(select NAME from sys.indexes where NAME = 'CI2_View_CMS_Tree_Joined_Regular')
--BEGIN
--    print ('Updating index CI2_View_CMS_Tree_Joined_Regular');

--	SET ARITHABORT ON
--	SET CONCAT_NULL_YIELDS_NULL ON
--	SET QUOTED_IDENTIFIER ON
--	SET ANSI_NULLS ON
--	SET ANSI_PADDING ON
--	SET ANSI_WARNINGS ON
--	SET NUMERIC_ROUNDABORT OFF

--	CREATE NONCLUSTERED INDEX [CI2_View_CMS_Tree_Joined_Regular] ON [dbo].[View_CMS_Tree_Joined_Regular]
--(
--	[ClassName] ASC,
--	[DocumentForeignKeyValue],
--	[DocumentCulture] ASC
--)
--INCLUDE ( 	[NodeID], [NodeGUID]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

--END
--GO

IF EXISTS (SELECT
                  TABLE_NAME
                  FROM INFORMATION_SCHEMA.VIEWS
                  WHERE
                        TABLE_NAME = 'view_EDW_CoachingDetail_CT') 
    BEGIN
        DROP VIEW
             view_EDW_CoachingDetail_CT;
    END;
GO

--GRANT SELECT
--	ON [dbo].[[view_EDW_CoachingDetail_CT]]
--	TO [EDWReader_PRD]
--GO

/* TEST Queries
select * from [view_EDW_CoachingDetail_CT]
select * from [view_EDW_CoachingDetail_CT] where CloseReasonLKPID != 0
select count(*) from [view_EDW_CoachingDetail_CT]
*/

CREATE VIEW dbo.view_EDW_CoachingDetail_CT
AS

--********************************************************************************************

/*
select count(*),
	   ItemID
	   , ItemGUID
	   , GoalID
	   , UserID
	   , UserGUID
	   , HFitUserMpiNumber
	   , SiteGUID
	   , AccountID
	   , AccountCD
	   --, IsCreatedByCoach
	   , WeekendDate
	   , NodeGUID		
from [view_EDW_CoachingDetail_CT]
group by 
	   ItemID
	   , ItemGUID
	   , GoalID
	   , UserID
	   , UserGUID
	   , HFitUserMpiNumber
	   , SiteGUID
	   , AccountID
	   , AccountCD
	   --, IsCreatedByCoach
	   , WeekendDate
	   , NodeGUID		
having count(*) > 1
*/

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
     , NULL AS DocumentID
     , HFUG.GoalStatusLKPID
     , HFLGS.GoalStatusLKPName
     , HFUG.EvaluationStartDate
     , HFUG.EvaluationEndDate
     , HFUG.GoalStartDate
     , HFUG.CoachDescription
     , HFGO.EvaluationDate
     , HFGO.Passed
     , HFGO.WeekendDate
     , CASE
           WHEN
                CAST (HFUG.ItemCreatedWhen AS date) = CAST (HFUG.ItemModifiedWhen AS date) 
               THEN 'I'
           ELSE 'U'
       END AS ChangeType
     , HFUG.ItemCreatedWhen
     , HFUG.ItemModifiedWhen
     , GJ.NodeGUID
     , HFUG.CloseReasonLKPID
     , GRC.CloseReason
     , HASHBYTES ('sha1',
       ISNULL (CAST (HFUG.ItemID AS nvarchar (100)) , '-') + ISNULL (CAST ( HFUG.ItemGUID AS nvarchar (100)) , '-') + ISNULL (CAST ( GJ.GoalID AS nvarchar (100)) , '-') + ISNULL (CAST ( HFUG.UserID AS nvarchar (100)) , '-') + ISNULL (CAST ( cu.UserGUID AS nvarchar (100)) , '-') + ISNULL (CAST ( cus.HFitUserMpiNumber AS nvarchar (100)) , '-') + ISNULL (CAST ( cs.SiteGUID AS nvarchar (100)) , '-') + ISNULL (CAST ( hfa.AccountID AS nvarchar (100)) , '-') + ISNULL (CAST ( hfa.AccountCD AS nvarchar (100)) , '-') + ISNULL (CAST ( hfa.AccountName AS nvarchar (500)) , '-') + ISNULL (CAST ( HFUG.IsCreatedByCoach AS nvarchar (100)) , '-') + ISNULL (CAST ( HFUG.BaselineAmount AS nvarchar (100)) , '-') + ISNULL (CAST ( HFUG.GoalAmount AS nvarchar (100)) , '-') + ISNULL (CAST ( HFUG.GoalStatusLKPID AS nvarchar (100)) , '-') + ISNULL (CAST ( HFLGS.GoalStatusLKPName AS nvarchar (500)) , '-') + ISNULL (CAST ( HFUG.EvaluationStartDate AS nvarchar (100)) , '-') + ISNULL (CAST ( HFUG.EvaluationEndDate AS nvarchar (100)) , '-') + ISNULL (CAST ( HFUG.GoalStartDate AS nvarchar (100)) , '-') + ISNULL (LEFT (HFUG.CoachDescription, 1000) , '-') + ISNULL (CAST ( HFGO.EvaluationDate AS nvarchar (100)) , '-') + ISNULL (CAST ( HFGO.Passed AS nvarchar (100)) , '-') + ISNULL (CAST ( HFGO.WeekendDate AS nvarchar (100)) , '-') + ISNULL (CAST ( HFUG.ItemCreatedWhen AS nvarchar (100)) , '-') + ISNULL (CAST ( HFUG.ItemModifiedWhen AS nvarchar (100)) , '-') + ISNULL (CAST ( GJ.NodeGUID AS nvarchar (100)) , '-') + ISNULL (CAST ( HFUG.CloseReasonLKPID AS nvarchar (100)) , '-') + ISNULL (CAST ( GRC.CloseReason AS nvarchar (100)) , '-') 
       ) AS HashCode

       FROM
           dbo.HFit_UserGoal AS HFUG WITH (NOLOCK) 
               INNER JOIN(
            SELECT
                   VHFGJ.GoalID
                 , VHFGJ.NodeID
                 , VHFGJ.NodeGUID
                 , VHFGJ.DocumentCulture
                 , VHFGJ.DocumentGuid
                 , VHFGJ.DocumentModifiedWhen	--WDM added 9.10.2014
                   FROM dbo.View_HFit_Goal_Joined AS VHFGJ WITH (NOLOCK) 
            UNION ALL
            SELECT
                   VHFTGJ.GoalID
                 , VHFTGJ.NodeID
                 , VHFTGJ.NodeGUID
                 , VHFTGJ.DocumentCulture
                 , VHFTGJ.DocumentGuid
                 , VHFTGJ.DocumentModifiedWhen	--WDM added 9.10.2014
                   FROM dbo.View_HFit_Tobacco_Goal_Joined AS VHFTGJ WITH (NOLOCK))AS GJ
                   ON
       hfug.NodeID = gj.NodeID
   AND
       GJ.DocumentCulture = 'en-us'
                 LEFT OUTER JOIN dbo.HFit_GoalOutcome AS HFGO WITH (NOLOCK) 
                   ON
                      HFUG.ItemID = HFGO.UserGoalItemID
                 INNER JOIN dbo.HFit_LKP_GoalStatus AS HFLGS WITH (NOLOCK) 
                   ON
                      HFUG.GoalStatusLKPID = HFLGS.GoalStatusLKPID
                 INNER JOIN dbo.CMS_User AS CU WITH (NOLOCK) 
                   ON
                      HFUG.UserID = cu.UserID
                 INNER JOIN dbo.CMS_UserSettings AS CUS WITH (NOLOCK) 
                   ON
                      CU.UserGUID = CUS.UserSettingsUserGUID
                 INNER JOIN dbo.CMS_UserSite AS CUS2 WITH (NOLOCK) 
                   ON
                      cu.UserID = CUS2.UserID
                 INNER JOIN dbo.CMS_Site AS CS WITH (NOLOCK) 
                   ON
                      CUS2.SiteID = CS.SiteID
                 INNER JOIN dbo.HFit_Account AS HFA WITH (NOLOCK) 
                   ON
                      cs.SiteID = hfa.SiteID
                 LEFT OUTER JOIN HFit_LKP_GoalCloseReason AS GRC
                   ON
                      GRC.CloseReasonID = HFUG.CloseReasonLKPID;
GO

--  
--  
GO
PRINT '***** Created: view_EDW_CoachingDetail_CT';
GO

--Testing History
--1.1.2015: WDM Tested table creation, data entry, and view join
--Testing Criteria
--select * from HFit_LKP_GoalCloseReason
--select * from view_EDW_CoachingDetail_CT
--select * from view_EDW_CoachingDetail_CT where userid in (13470, 107, 13299) and CloseReasonLKPID != 0 
--select * from view_EDW_CoachingDetail_CT where UserGUID = '9C7F1657-8568-4D5D-A797-C6AEEA86834F'
--select * from view_EDW_CoachingDetail_CT where EvaluationDate is null 
--select * from view_EDW_CoachingDetail_CT  where HFitUserMpiNumber in (6238677) and CloseReasonLKPID != 0 
--select * from HFit_UserGoal where UserGUID = '9C7F1657-8568-4D5D-A797-C6AEEA86834F'
