ObjectDefinition
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE procedure [dbo].[Proc_EDW_HealthAssessment] (@StartDate as datetime, @EndDate as datetime)
as
begin

	--declare @StartDate as datetime ;
	--declare @EndDate as datetime ;
	--set @StartDate = '2014-05-28';
	--set @EndDate = '2014-05-29';

	-

(1 row(s) affected)

ObjectDefinition
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--select * from view_EDW_TrackerMetadata where TableName = 'HFit.CustomTrackerInstances'
--select * from Tracker_EDW_Metadata
--delete from Tracker_EDW_Metadata where TableName = 'HFit.TrackerWholeGrains'

--exec Proc_EDW_GenerateMetadata
--2014-07-30

(1 row(s) affected)

ObjectDefinition
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------







CREATE VIEW [dbo].[view_EDW_HealthAssesment]
AS
	SELECT distinct
		haus.ItemID AS UserStartedItemID
		, haus.HADocumentID
		, haus.UserID
		, cu.UserGUID
		, cus2.HFitUserMpiNumber
		, cs.SiteGUID
		, HFA.AccountID
		, HFA.AccountCD

(1 row(s) affected)

ObjectDefinition
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------



CREATE VIEW [dbo].[view_EDW_ClientCompany]

AS 

SELECT
    hfa.AccountID
   ,HFA.AccountCD
   ,HFA.AccountName
   ,HFA.ItemCreatedWhen AccountCreated
   ,HFA.ItemModifiedWhen AccountModified
   ,HFA.ItemGUID AccountGUID
   ,CS.SiteID
   

(1 row(s) affected)

ObjectDefinition
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

CREATE VIEW [dbo].[view_EDW_Coaches]

AS

SELECT distinct
    cu.UserGUID
   ,cs.SiteGUID
   ,HFA.AccountID
   ,HFA.AccountCD
   ,CoachID
   ,hfc.LastName
   ,hfc.FirstName
   ,hfc.StartDate
   ,hfc.Phone
   ,hfc.email
   ,hfc.Supervisor

(1 row(s) affected)

ObjectDefinition
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

CREATE VIEW [dbo].[view_EDW_CoachingDefinition]
AS
SELECT
	GJ.GoalID
	, GJ.DocumentID
	, GJ.NodeSiteID
	, cs.SiteGUID
	, GJ.GoalImage
	, GJ.Goal
	, dbo.udf_StripHTML(GJ.GoalText) GoalText --
	, dbo.udf_StripHTML(GJ.GoalSummary) GoalSummary --

(1 row(s) affected)

ObjectDefinition
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

CREATE VIEW [dbo].[view_EDW_CoachingDetail]
AS
	SELECT
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
		, HFUG.I

(1 row(s) affected)

ObjectDefinition
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------






CREATE VIEW [dbo].[view_EDW_HealthAssesmentClientView]
AS
	SELECT
		hfa.AccountID
		, hfa.AccountCD
		, hfa.AccountName
		, HFA.ItemGUID AS ClientGuid
		, cs.SiteGUID
		, NULL AS CompanyID
		, NULL AS CompanyGUID
		, NULL AS CompanyNa

(1 row(s) affected)

ObjectDefinition
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE VIEW [dbo].[view_EDW_HealthAssesmentDeffinition]
AS
--*******************************************************************************************
--WDM - 6/25/2014
--Query was returning a NULL dataset. Found that it is being caused by the Accoun

(1 row(s) affected)

ObjectDefinition
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------





CREATE VIEW [dbo].[view_EDW_Participant]
AS
	SELECT
		cus.HFitUserMpiNumber
		, cu.UserID
		, cu.UserGUID
		, CS.SiteGUID
		, hfa.AccountID
		, hfa.AccountCD
		, cus.HFitUserPreferredMailingAddress
		, cus.HFitUserPreferredMailingCity

(1 row(s) affected)

ObjectDefinition
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------





CREATE VIEW [dbo].[view_EDW_RewardAwardDetail]
AS
	SELECT DISTINCT
		cu.UserGUID
		, cs.SiteGUID
		, cus.HFitUserMpiNumber
		, VHFRLJ.RewardLevelID
		, HFRAUD.AwardDisplayName
		, HFRAUD.RewardValue
		, HFRAUD.ThresholdNumber
		, HFRAUD

(1 row(s) affected)

ObjectDefinition
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------





CREATE VIEW [dbo].[view_EDW_RewardsDefinition]
AS
	SELECT
		cs.SiteGUID
		, HFA.AccountID
		, hfa.AccountCD
		, RewardProgramID
		, RewardProgramName
		, RewardProgramPeriodStart
		, RewardProgramPeriodEnd
		, ProgramDescription
		, Re

(1 row(s) affected)

ObjectDefinition
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------





CREATE VIEW [dbo].[view_EDW_RewardTriggerParameters]
AS
	SELECT distinct
		cs.SiteGUID
		, VHFRTJ.RewardTriggerID
		, VHFRTJ.TriggerName
		, HFLRTPO.RewardTriggerParameterOperatorLKPDisplayName
		, VHFRTPJ.ParameterDisplayName
		, VHFRTPJ

(1 row(s) affected)

ObjectDefinition
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------




CREATE VIEW [dbo].[view_EDW_RewardUserDetail]
AS
	SELECT DISTINCT
		cu.UserGUID
		, CS2.SiteGUID
		, cus2.HFitUserMpiNumber
		, VHFRAJ.RewardActivityID
		, VHFRPJ.RewardProgramName
		, VHFRPJ.RewardProgramID
		, VHFRPJ.RewardProgramPeriodS

(1 row(s) affected)

ObjectDefinition
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE View [dbo].[view_EDW_ScreeningsFromTrackers]

AS

SELECT DISTINCT
	t.userid
	, t.EventDate
	, t.TrackerCollectionSourceID
	, t.ItemCreatedBy
	, t.ItemCreatedWhen
	, t.ItemModifiedBy
	, t.ItemModifiedWhen
FROM
	(
		SELECT DISTINCT

(1 row(s) affected)

ObjectDefinition
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE View [dbo].[view_EDW_TrackerMetadata]
as
--******************************************************************************************************
--TableName - this is the CMS_CLASS ClassName and is used to identify the needed metadata. 
--C

(1 row(s) affected)

ObjectDefinition
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE VIEW View_HFit_RewardActivity_Joined AS 
SELECT View_CMS_Tree_Joined.*, HFit_RewardActivity.* FROM View_CMS_Tree_Joined INNER JOIN HFit_RewardActivity ON View_CMS_Tree_Joined.DocumentForeignKeyValue = HFit_RewardActivity.[RewardActivityID] WHERE (Cl

(1 row(s) affected)

ObjectDefinition
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE VIEW View_HFit_RewardDefaultSettings_Joined AS 
SELECT View_CMS_Tree_Joined.*, HFit_RewardDefaultSettings.* FROM View_CMS_Tree_Joined INNER JOIN HFit_RewardDefaultSettings ON View_CMS_Tree_Joined.DocumentForeignKeyValue = HFit_RewardDefaultSettings.

(1 row(s) affected)

ObjectDefinition
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE VIEW View_HFit_RewardGroup_Joined AS 
SELECT View_CMS_Tree_Joined.*, HFit_RewardGroup.* FROM View_CMS_Tree_Joined INNER JOIN HFit_RewardGroup ON View_CMS_Tree_Joined.DocumentForeignKeyValue = HFit_RewardGroup.[RewardGroupID] WHERE (ClassName = 'HFit

(1 row(s) affected)

ObjectDefinition
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

CREATE VIEW [dbo].[View_HFIT_RewardGroupWithContactGroupIDs]
AS
SELECT HFRG.RewardGroupID, HFRG.GroupName, CGSplit.Item as ContactGroupID
   FROM HFit_RewardGroup HFRG
  CROSS APPLY
        (
         SELECT ItemNumber, Item
           FROM dbo.uf

(1 row(s) affected)

ObjectDefinition
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE VIEW View_HFit_RewardLevel_Joined AS 
SELECT View_CMS_Tree_Joined.*, HFit_RewardLevel.* FROM View_CMS_Tree_Joined INNER JOIN HFit_RewardLevel ON View_CMS_Tree_Joined.DocumentForeignKeyValue = HFit_RewardLevel.[RewardLevelID] WHERE (ClassName = 'HFit

(1 row(s) affected)

ObjectDefinition
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE VIEW View_HFit_RewardProgram_Joined AS 
SELECT View_CMS_Tree_Joined.*, HFit_RewardProgram.* FROM View_CMS_Tree_Joined INNER JOIN HFit_RewardProgram ON View_CMS_Tree_Joined.DocumentForeignKeyValue = HFit_RewardProgram.[RewardProgramID] WHERE (ClassNa

(1 row(s) affected)

ObjectDefinition
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE VIEW View_HFit_RewardsAboutInfoItem_Joined AS 
SELECT View_CMS_Tree_Joined.*, HFit_RewardsAboutInfoItem.* FROM View_CMS_Tree_Joined INNER JOIN HFit_RewardsAboutInfoItem ON View_CMS_Tree_Joined.DocumentForeignKeyValue = HFit_RewardsAboutInfoItem.[Rew

(1 row(s) affected)

ObjectDefinition
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Create View [dbo].[View_Hfit_RewardsUserActivityDetailOverrideActivity]
AS
SELECT DISTINCT vad.UserID, vad.ActivityCompletedDt 
FROM [HFit_RewardsUserActivityDetail]vad LEFT JOIN
[View_HFit_RewardActivity_Joined]raj ON raj.NodeID = vad.ActivityNodeId

(1 row(s) affected)

ObjectDefinition
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE VIEW View_HFit_RewardTrigger_Joined AS 
SELECT View_CMS_Tree_Joined.*, HFit_RewardTrigger.* FROM View_CMS_Tree_Joined INNER JOIN HFit_RewardTrigger ON View_CMS_Tree_Joined.DocumentForeignKeyValue = HFit_RewardTrigger.[RewardTriggerID] WHERE (ClassNa

(1 row(s) affected)

ObjectDefinition
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE VIEW View_HFit_RewardTriggerParameter_Joined AS 
SELECT View_CMS_Tree_Joined.*, HFit_RewardTriggerParameter.* FROM View_CMS_Tree_Joined INNER JOIN HFit_RewardTriggerParameter ON View_CMS_Tree_Joined.DocumentForeignKeyValue = HFit_RewardTriggerParame

(1 row(s) affected)

ObjectDefinition
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
NULL

(1 row(s) affected)

ObjectDefinition
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE VIEW [dbo].[view_HFit_TrackerEvents]
AS 

SELECT UserID, ItemID, EventDate, 'HFit_TrackerBloodPressure' AS TrackerName
FROM dbo.HFit_TrackerBloodPressure AS HFTBP
UNION ALL 
SELECT UserID, ItemID, EventDate, 'HFit_TrackerBloodSugarAndGlucose' 

(1 row(s) affected)

ObjectDefinition
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE  VIEW [dbo].[view_HFit_UsersWithTrackersFromScreening]
AS
      SELECT
        UserID
       ,TrackerCollectionSourceID
       ,EventDate
      FROM
        dbo.HFit_TrackerBloodPressure AS HFTBP
      WHERE
        TrackerCollectionSourceI

(1 row(s) affected)

ObjectDefinition
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

CREATE view [dbo].[view_HFit_TrackerCompositeDetails]
as
--WDM 6/26/2014
--This view is needed by EDW in order to process the Tracker tables' data.
--As of now, the Tracker tables are representative of objects and that would cause 
--	large volumes 

(1 row(s) affected)

ObjectDefinition
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

CREATE VIEW [dbo].[View_Hfit_GoalTracker]
AS
select g.DocumentID,g.TrackerNodeGuid,t.Type,t.NodeSiteID As SiteID, g.NodeID
  from view_HFit_Goal_Joined g 
  inner join View_HFit_TrackerDocument_Joined t on g.TrackerNodeGuid = t.NodeGuid

UNION ALL

(1 row(s) affected)

ObjectDefinition
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE View [dbo].[View_HFit_UserGoalTrackerDetails]
AS
	SELECT
		td.*
		,ug.UserID
		,ug.GoalAmount
		,m.UnitOfMeasure
		,f.FrequencySingular
		,g.ActivityText
		,ug.CoachDescription
		,ug.ItemID
		,g.NodeGUID as GoalNodeGUID
		,ug.EvaluationS

(1 row(s) affected)

ObjectDefinition
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE View [dbo].[view_EDW_ScreeningsFromTrackers]

AS

SELECT DISTINCT
	t.userid
	, t.EventDate
	, t.TrackerCollectionSourceID
	, t.ItemCreatedBy
	, t.ItemCreatedWhen
	, t.ItemModifiedBy
	, t.ItemModifiedWhen
FROM
	(
		SELECT DISTINCT

(1 row(s) affected)

ObjectDefinition
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE VIEW dbo.View_HFit_ChallengeTrackerDailySum
AS
SELECT        NEWID() AS ID, SUM(Steps) AS UserSteps, UserID, DATEADD(dd, DATEDIFF(dd, 0, EventDate), 0) AS DailySum
FROM            dbo.HFit_TrackerDailySteps
GROUP BY UserID, DATEADD(dd, DATEDIFF(

(1 row(s) affected)

ObjectDefinition
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE VIEW View_HFit_TrackerCategory_Joined AS 
SELECT View_CMS_Tree_Joined.*, HFit_TrackerCategory.* FROM View_CMS_Tree_Joined INNER JOIN HFit_TrackerCategory ON View_CMS_Tree_Joined.DocumentForeignKeyValue = HFit_TrackerCategory.[TrackerCategoryID] WHER

(1 row(s) affected)

ObjectDefinition
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE VIEW View_HFit_TrackerDocument_Joined AS 
SELECT View_CMS_Tree_Joined.*, HFit_TrackerDocument.* FROM View_CMS_Tree_Joined INNER JOIN HFit_TrackerDocument ON View_CMS_Tree_Joined.DocumentForeignKeyValue = HFit_TrackerDocument.[TrackerDocumentID] WHER

(1 row(s) affected)

ObjectDefinition
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE VIEW [dbo].[View_HFit_GroupConfiguration]
/*******************************************************************************
Description: A view that shows users, the groups they belong to, the membership and roles.

8/30/2013 SReutzel: Initial
9

(1 row(s) affected)

ObjectDefinition
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------





CREATE VIEW [dbo].[View_HFit_FeatureConfiguration]
/*******************************************************************************
Description: A view that shows the available features

8/30/2013 SReutzel: Initial
9/4/2013 bwright: changed 

(1 row(s) affected)

  --  
  --  
GO 
print('***** FROM: _EDW_View_Generation_Sctipts.07.31.2014.sql'); 
GO 
