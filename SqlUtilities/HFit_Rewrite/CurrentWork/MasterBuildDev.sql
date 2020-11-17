--****************************************************************
-- NOTE: This database name must be changed in MANY places in 
--	this script. Please search and change.
--****************************************************************
DECLARE @DBNAME nvarchar(100);
declare @ServerName nvarchar(80);
set @ServerName = (SELECT @@SERVERNAME ) ;
set @DBNAME = (SELECT DB_NAME() AS [Current Database]);

print ('***************************************************************************************************************************');
print ('Applying Updates to database ' + @DBNAME + ' : ON SERVER : '+ @ServerName + ' ON ' + cast(getdate() as nvarchar(50)));
print ('***************************************************************************************************************************');
go
  --  
  --  
GO 
print('***** FROM: SetDB.sql'); 
GO 

print('END: ' + cast(getdate() as nvarchar(50)));
print('@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-');
print'***************************************************************' ;
print('START: ' + cast(getdate() as nvarchar(50)));
print ('Create Table: EDW_PerformanceMeasure');
go

if exists (select name from sys.tables where name = 'EDW_PerformanceMeasure')
BEGIN
	drop table [dbo].[EDW_PerformanceMeasure] ;
END


	CREATE TABLE [dbo].[EDW_PerformanceMeasure](
		[TypeTest] [nvarchar](50) NULL,
		[ObjectName] [nvarchar](80) NULL,
		[RecCount] [int] NULL,
		[StartTime] [datetime] NULL,
		[EndTime] [datetime] NULL,
		[hrs] [int] NULL,
		[mins] [int] NULL,
		[secs] [int] NULL,
		[ms] [nchar](10) NULL
	)


GO

print ('Created Table: EDW_PerformanceMeasure');
go
  --  
  --  
GO 
print('***** FROM: createTableEDW_PerformanceMeasure.sql'); 
GO 

print('END: ' + cast(getdate() as nvarchar(50)));
print('@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-');
print'***************************************************************' ;
print('START: ' + cast(getdate() as nvarchar(50)));

print ('Processing: proc_GetRecordCount') ;
go


if exists (select * from sysobjects where name = 'proc_GetRecordCount' and Xtype = 'P')
BEGIN
	drop procedure proc_GetRecordCount ;
END 
go

create procedure proc_GetRecordCount (@TblView as nvarchar(80))
		as
		BEGIN

			--declare @TblView nvarchar(80); 
			--set @TblView = 'view_EDW_TrackerMetadata';
			DECLARE @rowcount TABLE (Value int);
			declare @ActualNumberOfResults int ;
			declare @StartTime datetime ;
			declare @EndTime datetime ;
			declare @iCnt int;
			declare @qry varchar(56)
			declare @T int ;

			declare @hrs int ;
			declare @mins int ;
			declare @secs int ;
			declare @ms int ;

			set @StartTime = getdate() ;
			set @qry = 'select COUNT(*) as RecCount from  ' + @TblView ;

			INSERT INTO @rowcount
				exec (@qry)

			SELECT @ActualNumberOfResults = Value FROM @rowcount;

			set @EndTime = getdate() ;
			set @T = datediff(ms, @StartTime,@EndTime) ;

			set @hrs = @T / 56000 % 100 ;
			set @mins = @T / 560 % 100 ;
			set @secs = @T / 100 % 100 ;
			set @ms = @T % 100 * 10 ;

			set @EndTime = (select dateadd(hour, (@T / 56000) % 100,
				   dateadd(minute, (@T / 560) % 100,
				   dateadd(second, (@T / 100) % 100,
				   dateadd(millisecond, (@T % 100) * 10, cast('00:00:00' as time(2))))))  );

				   print (@ActualNumberOfResults);
			print (@EndTime);
			print (@TblView + ' row cnt = ' + cast(@iCnt as varchar(20)));
	
			INSERT INTO [dbo].[EDW_PerformanceMeasure]
				   ([TypeTest],[ObjectName],[RecCount],[StartTime],[EndTime],hrs,mins,secs,ms)
			 VALUES
				   ('RowCount',@TblView,@ActualNumberOfResults,@StartTime,@T,@hrs,@mins,@secs,@ms)

		END

GO
--END OF proc_GetRecordCount

   --  
  --  
GO 
print('***** FROM: proc_GetRecordCount.sql'); 
GO 

print('END: ' + cast(getdate() as nvarchar(50)));
print('@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-');
print'***************************************************************' ;
print('START: ' + cast(getdate() as nvarchar(50)));
print ('Processing: EDW_HealthAssessment');
GO

if exists(select name from sys.tables where name = 'EDW_HealthAssessment')
BEGIN	
	drop table EDW_HealthAssessment ;
END

	CREATE TABLE [dbo].[EDW_HealthAssessment]
	(		
		UserStartedItemID  int,
        HealthAssesmentUserStartedNodeGUID  uniqueidentifier,
        UserID  bigint,
        UserGUID  uniqueidentifier,
        HFitUserMpiNumber  bigint,
        SiteGUID  uniqueidentifier,
        AccountID  int,
        AccountCD  nvarchar (8),
        HAStartedDt  datetime,
        HACompletedDt  datetime,
        UserModuleItemId  int,
        UserModuleCodeName  nvarchar(100)
        
		, HAModuleNodeGUID uniqueidentifier	--WDM 8/7/2014 as HAModuleDocumentID
		, CMSNodeGuid uniqueidentifier						--WDM 8/7/2014 as HAModuleDocumentID

        ,HAModuleVersionID  int,
        UserRiskCategoryItemID  int,
        UserRiskCategoryCodeName  nvarchar(100),
        HARiskCategoryNodeGUID  uniqueidentifier,
        HARiskCategoryVersionID  int,
        UserRiskAreaItemID  int,
        UserRiskAreaCodeName  nvarchar(100),
        HARiskAreaNodeGUID  uniqueidentifier,
        HARiskAreaVersionID  int,
        UserQuestionItemID  int,
        Title  nvarchar(4000),
        HAQuestionGuid  uniqueidentifier,
        UserQuestionCodeName  nvarchar(100),
        HAQuestionDocumentID  int,
        HAQuestionVersionID  bigint,
        HAQuestionNodeGUID  uniqueidentifier,
        UserAnswerItemID  int,
        HAAnswerNodeGUID  uniqueidentifier,
        HAAnswerVersionID  bigint,
        UserAnswerCodeName  nvarchar(100),
        HAAnswerValue  nvarchar(255),
        HAModuleScore  float,
        HARiskCategoryScore  float,
        HARiskAreaScore  float,
        HAQuestionScore  float,
        HAAnswerPoints  int,
        PointResults  int,
        UOMCode  nvarchar(10),
        HAScore  int,
        ModulePreWeightedScore  float,
        RiskCategoryPreWeightedScore  float,
        RiskAreaPreWeightedScore  float,
        QuestionPreWeightedScore  float,
        QuestionGroupCodeName  nvarchar(100),
        ChangeType  varchar(1)
       
	   ,IsProfessionallyCollected bit

	   ,ItemCreatedWhen datetime
       ,ItemModifiedWhen  datetime	   
	   ,HARiskCategory_ItemModifiedWhen datetime
	   ,HAUserRiskArea_ItemModifiedWhen datetime
	   ,HAUserQuestion_ItemModifiedWhen datetime
	   ,HAUserAnswers_ItemModifiedWhen datetime
	    ,HAPaperFlg bit
	   ,HATelephonicFlg bit
	)

GO
  --  
  --  
GO 
print('***** FROM: CreateTableEDW_HealthAssessment.sql'); 
GO 

print('END: ' + cast(getdate() as nvarchar(50)));
print('@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-');
print'***************************************************************' ;
print('START: ' + cast(getdate() as nvarchar(50)));print('Processing: EDW_HealthAssessmentDefinition');
GO

if exists(select name from sys.tables where name = 'EDW_HealthAssessmentDefinition')
BEGIN	
	drop table EDW_HealthAssessmentDefinition ;
END

	CREATE TABLE [dbo].[EDW_HealthAssessmentDefinition](
		[SiteGuid] [int] NULL,
		[AccountCD] [int] NULL,
		[HANodeID] [int] NOT NULL,
		[HANodeName] [nvarchar](100) NOT NULL,
		[HADocumentID] [int] NOT NULL,
		[HANodeSiteID] [int] NOT NULL,
		[HADocPubVerID] [int] NULL,
		[ModTitle] [nvarchar](150) NOT NULL,
		[IntroText] [varchar](4000) NULL,
		[ModDocGuid] [uniqueidentifier] NULL,
		[ModWeight] [int] NOT NULL,
		[ModIsEnabled] [bit] NOT NULL,
		[ModCodeName] [nvarchar](100) NOT NULL,
		[ModDocPubVerID] [int] NULL,
		[RCTitle] [nvarchar](150) NOT NULL,
		[RCWeight] [int] NOT NULL,
		[RCDocumentGUID] [uniqueidentifier] NULL,
		[RCIsEnabled] [bit] NOT NULL,
		[RCCodeName] [nvarchar](100) NOT NULL,
		[RCDocPubVerID] [int] NULL,
		[RATytle] [nvarchar](150) NOT NULL,
		[RAWeight] [int] NOT NULL,
		[RADocumentGuid] [uniqueidentifier] NULL,
		[RAIsEnabled] [bit] NOT NULL,
		[RACodeName] [nvarchar](100) NOT NULL,
		[RAScoringStrategyID] [int] NOT NULL,
		[RADocPubVerID] [int] NULL,
		[QuestionType] [nvarchar](100) NOT NULL,
		[QuesTitle] [varchar](max) NULL,
		[QuesWeight] [int] NOT NULL,
		[QuesIsRequired] [bit] NOT NULL,
		[QuesDocumentGuid] [uniqueidentifier] NULL,
		[QuesIsEnabled] [bit] NOT NULL,
		[QuesIsVisible] [nvarchar](max) NULL,
		[QuesIsSTaging] [bit] NOT NULL,
		[QuestionCodeName] [nvarchar](100) NOT NULL,
		[QuesDocPubVerID] [int] NULL,
		[AnsValue] [nvarchar](150) NULL,
		[AnsPoints] [int] NULL,
		[AnsDocumentGuid] [uniqueidentifier] NULL,
		[AnsIsEnabled] [bit] NULL,
		[AnsCodeName] [nvarchar](100) NULL,
		[AnsUOM] [nvarchar](5) NULL,
		[AnsDocPUbVerID] [int] NULL,
		[ChangeType] [varchar](1) NOT NULL,
		[DocumentCreatedWhen] [datetime] NULL,
		[DocumentModifiedWhen] [datetime] NULL,
		[CmsTreeNodeGuid] [uniqueidentifier] NOT NULL,
		[HANodeGUID] [uniqueidentifier] NOT NULL
	)

print('Processed: EDW_HealthAssessmentDefinition');
GO
  --  
  --  
GO 
print('***** FROM: CreateEDW_HealthAssessmentDefinition.sql'); 
GO 

print('END: ' + cast(getdate() as nvarchar(50)));
print('@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-');
print'***************************************************************' ;
print('START: ' + cast(getdate() as nvarchar(50)));
print('Processing: Performance Indexes');
go

if not exists(select name from sys.indexes where name = 'PI_HFIT_Tracker_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFIT_Tracker_LastUpdate ON [HFIT_Tracker] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerBloodPressure_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerBloodPressure_LastUpdate ON [HFit_TrackerBloodPressure] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerBloodSugarAndGlucose_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerBloodSugarAndGlucose_LastUpdate ON [HFit_TrackerBloodSugarAndGlucose] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerBMI_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerBMI_LastUpdate ON [HFit_TrackerBMI] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerBodyFat_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerBodyFat_LastUpdate ON [HFit_TrackerBodyFat] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerBodyMeasurements_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerBodyMeasurements_LastUpdate ON [HFit_TrackerBodyMeasurements] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerCardio_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerCardio_LastUpdate ON [HFit_TrackerCardio] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerCategory_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerCategory_LastUpdate ON [HFit_TrackerCategory] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerCholesterol_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerCholesterol_LastUpdate ON [HFit_TrackerCholesterol] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerCollectionSource_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerCollectionSource_LastUpdate ON [HFit_TrackerCollectionSource] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerDailySteps_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerDailySteps_LastUpdate ON [HFit_TrackerDailySteps] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerDef_Item_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerDef_Item_LastUpdate ON [HFit_TrackerDef_Item] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerDef_Tracker_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerDef_Tracker_LastUpdate ON [HFit_TrackerDef_Tracker] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerDocument_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerDocument_LastUpdate ON [HFit_TrackerDocument] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerFlexibility_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerFlexibility_LastUpdate ON [HFit_TrackerFlexibility] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerFruits_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerFruits_LastUpdate ON [HFit_TrackerFruits] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerHbA1c_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerHbA1c_LastUpdate ON [HFit_TrackerHbA1c] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerHeight_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerHeight_LastUpdate ON [HFit_TrackerHeight] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerHighFatFoods_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerHighFatFoods_LastUpdate ON [HFit_TrackerHighFatFoods] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerHighSodiumFoods_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerHighSodiumFoods_LastUpdate ON [HFit_TrackerHighSodiumFoods] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerInstance_Item_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerInstance_Item_LastUpdate ON [HFit_TrackerInstance_Item] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerInstance_Tracker_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerInstance_Tracker_LastUpdate ON [HFit_TrackerInstance_Tracker] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerMealPortions_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerMealPortions_LastUpdate ON [HFit_TrackerMealPortions] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerMedicalCarePlan_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerMedicalCarePlan_LastUpdate ON [HFit_TrackerMedicalCarePlan] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerRegularMeals_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerRegularMeals_LastUpdate ON [HFit_TrackerRegularMeals] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerRestingHeartRate_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerRestingHeartRate_LastUpdate ON [HFit_TrackerRestingHeartRate] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerShots_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerShots_LastUpdate ON [HFit_TrackerShots] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerSitLess_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerSitLess_LastUpdate ON [HFit_TrackerSitLess] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerSleepPlan_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerSleepPlan_LastUpdate ON [HFit_TrackerSleepPlan] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerStrength_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerStrength_LastUpdate ON [HFit_TrackerStrength] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerStress_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerStress_LastUpdate ON [HFit_TrackerStress] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerStressManagement_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerStressManagement_LastUpdate ON [HFit_TrackerStressManagement] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerSugaryDrinks_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerSugaryDrinks_LastUpdate ON [HFit_TrackerSugaryDrinks] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerSugaryFoods_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerSugaryFoods_LastUpdate ON [HFit_TrackerSugaryFoods] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerSummary_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerSummary_LastUpdate ON [HFit_TrackerSummary] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerTests_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerTests_LastUpdate ON [HFit_TrackerTests] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerTobaccoFree_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerTobaccoFree_LastUpdate ON [HFit_TrackerTobaccoFree] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerVegetables_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerVegetables_LastUpdate ON [HFit_TrackerVegetables] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerWater_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerWater_LastUpdate ON [HFit_TrackerWater] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerWeight_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerWeight_LastUpdate ON [HFit_TrackerWeight] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerWholeGrains_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerWholeGrains_LastUpdate ON [HFit_TrackerWholeGrains] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go

if not exists(select name from sys.indexes where name = 'PI_View_CMS_Tree_Joined_Regular_NodeGUID')
BEGIN
	CREATE NONCLUSTERED INDEX PI_View_CMS_Tree_Joined_Regular_NodeGUID
		ON [dbo].[View_CMS_Tree_Joined_Regular] ([NodeGUID])
END
go

if not exists(select name from sys.indexes where name = 'PI_View_CMS_Tree_Joined_Regular_NodeSiteID_DocumentCulture_NodeID')
BEGIN 
	CREATE INDEX PI_View_CMS_Tree_Joined_Regular_NodeSiteID_DocumentCulture_NodeID
    ON View_CMS_Tree_Joined_Regular
 (     [NodeSiteID] ASC 
      , [DocumentCulture] ASC 
      , [NodeID] ASC 
      , [NodeParentID] ASC 
      , [DocumentID] ASC 
      , [DocumentPublishedVersionHistoryID] ASC 
, [NodeGUID]
 )
END


GO

if not exists(select name from sys.indexes where name = 'PI_CMS_Tree_Joined_Regular_NODE_FK')
BEGIN 
	CREATE NONCLUSTERED INDEX PI_CMS_Tree_Joined_Regular_NODE_FK
		ON [dbo].[View_CMS_Tree_Joined_Regular] ([ClassName])
	INCLUDE ([NodeGUID],[DocumentForeignKeyValue])
END

GO


if not exists(select name from sys.indexes where name = 'pi_CMS_Tree_Joined_Regular_NodeGUID')
BEGIN 
	CREATE NONCLUSTERED INDEX pi_CMS_Tree_Joined_Regular_NodeGUID
	ON [dbo].[View_CMS_Tree_Joined_Regular] ([NodeGUID])
end

go  --  
  --  
GO 
print('***** FROM: CreateTrackerPerfIndexes.sql'); 
GO 

print('END: ' + cast(getdate() as nvarchar(50)));
print('@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-');
print'***************************************************************' ;
print('START: ' + cast(getdate() as nvarchar(50)));
print('Processing: proc_GetRecordCount');
go



if exists (select * from sysobjects where name = 'proc_GetRecordCount' and Xtype = 'P')
BEGIN
	drop procedure proc_GetRecordCount ;
END 
go

create procedure proc_GetRecordCount (@TblView as nvarchar(80))
		as
		BEGIN

			--declare @TblView nvarchar(80); 
			--set @TblView = 'view_EDW_TrackerMetadata';
			DECLARE @rowcount TABLE (Value int);
			declare @ActualNumberOfResults int ;
			declare @StartTime datetime ;
			declare @EndTime datetime ;
			declare @iCnt int;
			declare @qry varchar(56)
			declare @T int ;

			declare @hrs int ;
			declare @mins int ;
			declare @secs int ;
			declare @ms int ;

			set @StartTime = getdate() ;
			set @qry = 'select COUNT(*) as RecCount from  ' + @TblView ;

			INSERT INTO @rowcount
				exec (@qry)

			SELECT @ActualNumberOfResults = Value FROM @rowcount;

			set @EndTime = getdate() ;
			set @T = datediff(ms, @StartTime,@EndTime) ;

			set @hrs = @T / 56000 % 100 ;
			set @mins = @T / 560 % 100 ;
			set @secs = @T / 100 % 100 ;
			set @ms = @T % 100 * 10 ;

			set @EndTime = (select dateadd(hour, (@T / 56000) % 100,
				   dateadd(minute, (@T / 560) % 100,
				   dateadd(second, (@T / 100) % 100,
				   dateadd(millisecond, (@T % 100) * 10, cast('00:00:00' as time(2))))))  );

				   print (@ActualNumberOfResults);
			print (@EndTime);
			print (@TblView + ' row cnt = ' + cast(@iCnt as varchar(20)));
	
			INSERT INTO [dbo].[EDW_PerformanceMeasure]
				   ([TypeTest],[ObjectName],[RecCount],[StartTime],[EndTime],hrs,mins,secs,ms)
			 VALUES
				   ('RowCount',@TblView,@ActualNumberOfResults,@StartTime,@T,@hrs,@mins,@secs,@ms)

		END   --  
   --  
GO 
print('FROM: createProc_GetRecordCount.sql'); 
GO 
  --  
  --  
GO 
print('***** FROM: createProc_GetRecordCount.sql'); 
GO 

print('Processing: Tracker_EDW_Metadata');
go


--create proc CreateTracker_EDW_Metadata
--as
GO 

if not exists(Select name from sys.tables where name = 'Tracker_EDW_Metadata')
BEGIN
	print ('Creating the Tracker_EDW_Metadata table');
	CREATE TABLE [dbo].[Tracker_EDW_Metadata] (
			[TableName]             [nvarchar](100) NOT NULL,
			[ColName]               [nvarchar](100) NOT NULL,
			[AttrName]              [nvarchar](100) NOT NULL,
			[AttrVal]               [nvarchar](250) NULL,
			[CreatedDate]           [datetime] NULL,
			[LastModifiedDate]      [datetime] NULL,
			[ID]                    [int] IDENTITY(1, 1) NOT NULL,
			[ClassLastModified]     [datetime] NULL
	) ON [PRIMARY]

	ALTER TABLE [dbo].[Tracker_EDW_Metadata]
	ADD
	CONSTRAINT [DF_Tracker_EDW_Metadata_CreatedDate]
	DEFAULT (getdate()) FOR [CreatedDate]

	ALTER TABLE [dbo].[Tracker_EDW_Metadata]
		ADD
		CONSTRAINT [DF_Tracker_EDW_Metadata_LastModifiedDate]
		DEFAULT (getdate()) FOR [LastModifiedDate]

	CREATE UNIQUE CLUSTERED INDEX [PK_Tracker_EDW_Metadata]
		ON [dbo].[Tracker_EDW_Metadata] ([TableName], [ColName], [AttrName]) ON [PRIMARY]

	ALTER TABLE [dbo].[Tracker_EDW_Metadata] SET (LOCK_ESCALATION = TABLE)

END
GO


  --  
  --  
GO 
print('***** FROM: CreateTracker_EDW_Metadata.sql'); 
GO 

print ('Processing: udfElapsedTime') ;
go

if exists (select * from sysobjects where name = 'udfElapsedTime' and type = 'FN')
BEGIN
	drop function udfElapsedTime ;
END 
go
--DECLARE @ElapsedS INT
--declare @start_date datetime = getdate() ;
--declare @end_date  datetime = getdate() ;
--SET @ElapsedS = DATEDIFF(ms, @start_date, @end_date)
--SELECT TimeSpan = dbo.udfTimeSpanFromMilliSeconds(@ElapsedS)
--go

create FUNCTION [dbo].[udfElapsedTime] ( @StartTime as datetime, @EndTime as datetime)
RETURNS varchar(25)
AS
BEGIN
--**********************************************************************
--Author: W. Dale Miller / June 12, 2008
--USE:
--DECLARE @ElapsedS INT
--declare @StartTime datetime = getdate() ;
--declare @EndTime  datetime = getdate() ;
--SET @ElapsedS = DATEDIFF(ms, @start_date, @end_date)
--SELECT TimeSpan = dbo.udfElapsedTime(@StartTime, @EndTime)
--**********************************************************************
	DECLARE 
		 @milliSecs int 
		 , @DisplayTime varchar(50)
		 , @Seconds int 
		
		--Variable to hold our result
		 , @DHMS varchar(15)
		
		--Integers for doing the math
		, @MS int
		, @Days int --Integer days
		, @Hours int --Integer hours
		, @Minutes int --Integer minutes
		
		--Strings for providing the display : Unused presently
		, @sDays varchar(5) --String days
		, @sHours varchar(2) --String hours
		, @sMinutes varchar(2) --String minutes
		, @sSeconds varchar(2); --String seconds

	set @milliSecs = (SELECT DATEDIFF(millisecond, @StartTime, @EndTime )) ;

	set @Minutes = 0 ;
	set @MS = 0 ;
	set @Hours = 0 ; 
	--set @milliSecs = 111071120;
	--print (@milliSecs)

	--Get the values using modulos where appropriate
	SET @Seconds = (@milliSecs / 1000 ) ;	
	--print (@Seconds ) ;

	if (@Seconds > 59 )
	BEGIN
		set @Minutes = @Seconds / 60 ;
		set @Seconds = @Seconds - (@Minutes * 60) ;
	END
	ELSE
		set @Minutes = 0 ;
	
		
	if (@Minutes > 59)
	BEGIN
		set @Hours = @Minutes / 60 ;
		set @Minutes = @Minutes - (@Seconds * 60) ;
	END
	ELSE
		set @Hours = 0 ;
	

	if (@Hours > 24)
	BEGIN
		set @Days = @Hours / 24 ;
		set @Hours = @Hours - (@Minutes * 60) ;
	END
	ELSE
		set @Days = 0 ;
	
	set @milliSecs = @milliSecs % 1000;

	set @DisplayTime = 
		cast(@Days as varchar(50)) + ':' +
			cast(@Hours as varchar(50)) + ':' +
			cast(@Minutes as varchar(50)) + ':' +
			cast(@Seconds as varchar(50))  + '.' +
			cast(@milliSecs as varchar(50))  ;

	--print (@DisplayTime );
	return @DisplayTime ;

END

GO

  --  
  --  
GO 
print('***** FROM: udfElapsedTime.sql'); 
GO 
Print ('Creating udfTimeSpanFromMilliSeconds');
go

if exists (select * from sysobjects where name = 'udfTimeSpanFromMilliSeconds' and type = 'FN')
BEGIN
	drop function udfTimeSpanFromMilliSeconds ;
END 
go

--DECLARE @ElapsedS INT
--declare @start_date datetime = getdate() ;
--declare @end_date  datetime = getdate() ;
--SET @ElapsedS = DATEDIFF(ms, @start_date, @end_date)
--SELECT TimeSpan = dbo.udfTimeSpanFromMilliSeconds(@ElapsedS)
--go


create FUNCTION [dbo].[udfTimeSpanFromMilliSeconds] ( @milliSecs int )
RETURNS varchar(20)
AS
BEGIN
--**********************************************************************
--Author: W. Dale Miller / June 12, 2008
--USE:
--DECLARE @ElapsedS INT
--declare @start_date datetime = getdate() ;
--declare @end_date  datetime = getdate() ;
--SET @ElapsedS = DATEDIFF(ms, @start_date, @end_date)
--SELECT TimeSpan = dbo.udfTimeSpanFromMilliSeconds(@ElapsedS)
--**********************************************************************
	DECLARE 
		 @DisplayTime varchar(50)
		 , @Seconds int 
		
		--Variable to hold our result
		 , @DHMS varchar(15)
		
		--Integers for doing the math
		, @MS int
		, @Days int --Integer days
		, @Hours int --Integer hours
		, @Minutes int --Integer minutes
		
		--Strings for providing the display : Unused presently
		, @sDays varchar(5) --String days
		, @sHours varchar(2) --String hours
		, @sMinutes varchar(2) --String minutes
		, @sSeconds varchar(2); --String seconds

	set @Minutes = 0 ;
	set @MS = 0 ;
	set @Hours = 0 ; 
	--set @milliSecs = 111071120;
	--print (@milliSecs)

	--Get the values using modulos where appropriate
	SET @Seconds = (@milliSecs / 1000 ) ;	
	--print (@Seconds ) ;

	if (@Seconds > 59 )
	BEGIN
		set @Minutes = @Seconds / 60 ;
		set @Seconds = @Seconds - (@Minutes * 60) ;
	END
	ELSE
		set @Minutes = 0 ;
	
		
	if (@Minutes > 59)
	BEGIN
		set @Hours = @Minutes / 60 ;
		set @Minutes = @Minutes - (@Seconds * 60) ;
	END
	ELSE
		set @Hours = 0 ;
	

	if (@Hours > 24)
	BEGIN
		set @Days = @Hours / 24 ;
		set @Hours = @Hours - (@Minutes * 60) ;
	END
	ELSE
		set @Days = 0 ;
	
	set @milliSecs = @milliSecs % 1000;

	set @DisplayTime = 
		cast(@Days as varchar(50)) + ':' +
			cast(@Hours as varchar(50)) + ':' +
			cast(@Minutes as varchar(50)) + ':' +
			cast(@Seconds as varchar(50))  + '.' +
			cast(@milliSecs as varchar(50))  ;

	--print (@DisplayTime );
	return @DisplayTime ;

END

GO

  --  
  --  
GO 
print('***** FROM: udfTimeSpanFromMilliSeconds.sql'); 
GO 

print ('Creating View_EDW_RewardProgram_Joined: ' +  cast(getdate() as nvarchar(50)));
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

print ('Created View_EDW_RewardProgram_Joined: ' + cast(getdate() as nvarchar(50)));
go  --  
  --  
GO 
print('***** FROM: View_EDW_RewardProgram_Joined.sql'); 
GO 

go
print ('Processing: View_EDW_HealthAssesmentQuestions ') ;
go


if exists(select TABLE_NAME from INFORMATION_SCHEMA.VIEWS where TABLE_NAME = 'View_EDW_HealthAssesmentQuestions')
BEGIN
	drop view View_EDW_HealthAssesmentQuestions ;
END
GO

create VIEW [dbo].[View_EDW_HealthAssesmentQuestions]

AS 
--**********************************************************************************
--09.11.2014 (wdm) Added the DocumentModifiedWhen to facilitate the EDW need to 
--		determine the last mod date of a record.
--10.17.2014 (wdm)
-- view_EDW_HealthAssesmentDeffinition calls 
-- View_EDW_HealthAssesmentQuestions which calls
-- View_HFit_HealthAssesmentMultipleChoiceQuestion_Joined
--		and two other JOINED views.
--View view_EDW_HealthAssesmentDeffinition has a filter on document culture of 'EN-US'
--		which limits the retured data to Engoish only.
--Today, John found a number of TITLES in view_EDW_HealthAssesmentDeffinition that were Spanish.
--The problem seems to come from sevel levels of nesting causing intersection data to seep through 
--the EN-US filter if placed at the highest level of a set of nested views.
--I took the filter and applied it to all the joined views within View_EDW_HealthAssesmentQuestions 
--		and the issue seems to have resolved itself.
--10.17.2014 (wdm) Added a filter "DocumentCulture" - the issue appears to be 
--			caused in view view_EDW_HealthAssesmentDeffinition becuase
--			the FILTER at that level on EN-US allows a portion of the intersection 
--			data to be missed for whatever reason. Adding the filter at this level
--			of the nesting seems to omit the non-english titles found by John Croft.
--**********************************************************************************
SELECT 
	VHFHAMCQJ.ClassName AS QuestionType,
	VHFHAMCQJ.Title,
	VHFHAMCQJ.Weight,
	VHFHAMCQJ.IsRequired,
	VHFHAMCQJ.QuestionImageLeft,
	VHFHAMCQJ.QuestionImageRight,
	VHFHAMCQJ.NodeGUID,	
	VHFHAMCQJ.DocumentCulture,
	VHFHAMCQJ.IsEnabled,
	VHFHAMCQJ.IsVisible,
	VHFHAMCQJ.IsStaging,
	VHFHAMCQJ.CodeName,
	VHFHAMCQJ.QuestionGroupCodeName,
	VHFHAMCQJ.NodeAliasPath,
	VHFHAMCQJ.DocumentPublishedVersionHistoryID,
	VHFHAMCQJ.NodeLevel,
	VHFHAMCQJ.NodeOrder,
	VHFHAMCQJ.NodeID,
	VHFHAMCQJ.NodeParentID,
	VHFHAMCQJ.NodeLinkedNodeID, 
	0 AS DontKnowEnabled, 
	'' AS DontKnowLabel,
	(select pp.NodeOrder from dbo.CMS_Tree pp inner join dbo.CMS_Tree p on p.NodeParentID = pp.NodeID where p.NodeID = VHFHAMCQJ.NodeParentID) AS ParentNodeOrder
	,VHFHAMCQJ.DocumentGuid
	,VHFHAMCQJ.DocumentModifiedWhen	--(WDM) 09.11.2014 added to facilitate determining document last mod date 
FROM dbo.View_HFit_HealthAssesmentMultipleChoiceQuestion_Joined AS VHFHAMCQJ WITH(NOLOCK)
where VHFHAMCQJ.DocumentCulture = 'en-US'   --(WDM) 10.19.2014 added to filter at this level of nesting

UNION ALL 
SELECT 
	VHFHAMQJ.ClassName AS QuestionType,
	VHFHAMQJ.Title,
	VHFHAMQJ.Weight,
	VHFHAMQJ.IsRequired,
	VHFHAMQJ.QuestionImageLeft,
	VHFHAMQJ.QuestionImageRight,
	VHFHAMQJ.NodeGUID,
	VHFHAMQJ.DocumentCulture,
	VHFHAMQJ.IsEnabled,
	VHFHAMQJ.IsVisible,
	VHFHAMQJ.IsStaging,
	VHFHAMQJ.CodeName,
	VHFHAMQJ.QuestionGroupCodeName,
	VHFHAMQJ.NodeAliasPath,
	VHFHAMQJ.DocumentPublishedVersionHistoryID,
	VHFHAMQJ.NodeLevel,
	VHFHAMQJ.NodeOrder,
	VHFHAMQJ.NodeID,
	VHFHAMQJ.NodeParentID,
	VHFHAMQJ.NodeLinkedNodeID,
	0 AS DontKnowEnabled, 
	'' AS DontKnowLabel,
		(select pp.NodeOrder from dbo.CMS_Tree pp inner join dbo.CMS_Tree p on p.NodeParentID = pp.NodeID where p.NodeID = VHFHAMQJ.NodeParentID) AS ParentNodeOrder
	,VHFHAMQJ.DocumentGuid
	,VHFHAMQJ.DocumentModifiedWhen	--(WDM) 09.11.2014 added to facilitate determining document last mod date 
FROM dbo.View_HFit_HealthAssesmentMatrixQuestion_Joined AS VHFHAMQJ WITH(NOLOCK)
where VHFHAMQJ.DocumentCulture = 'en-US'   --(WDM) 10.19.2014 added to filter at this level of nesting

UNION ALL 
SELECT 
	VHFHAFFJ.ClassName AS QuestionType,
	VHFHAFFJ.Title,
	VHFHAFFJ.Weight,
	VHFHAFFJ.IsRequired,
	VHFHAFFJ.QuestionImageLeft,
	'' AS QuestionImageRight,
	VHFHAFFJ.NodeGUID,
	VHFHAFFJ.DocumentCulture,
	VHFHAFFJ.IsEnabled,
	VHFHAFFJ.IsVisible,
	VHFHAFFJ.IsStaging,
	VHFHAFFJ.CodeName,
	VHFHAFFJ.QuestionGroupCodeName,
	VHFHAFFJ.NodeAliasPath,
	VHFHAFFJ.DocumentPublishedVersionHistoryID,
	VHFHAFFJ.NodeLevel,
	VHFHAFFJ.NodeOrder,
	VHFHAFFJ.NodeID,
	VHFHAFFJ.NodeParentID,
	VHFHAFFJ.NodeLinkedNodeID,
	VHFHAFFJ.DontKnowEnabled,
	VHFHAFFJ.DontKnowLabel,
	(select pp.NodeOrder from dbo.CMS_Tree pp inner join dbo.CMS_Tree p on p.NodeParentID = pp.NodeID where p.NodeID = VHFHAFFJ.NodeParentID) AS ParentNodeOrder
	,VHFHAFFJ.DocumentGuid
	,VHFHAFFJ.DocumentModifiedWhen	--(WDM) 09.11.2014 added to facilitate determining document last mod date 
FROM dbo.View_HFit_HealthAssessmentFreeForm_Joined AS VHFHAFFJ WITH(NOLOCK)
where VHFHAFFJ.DocumentCulture = 'en-US'   --(WDM) 10.19.2014 added to filter at this level of nesting

GO
print ('Processed: View_EDW_HealthAssesmentQuestions ') ;
go



  --  
  --  
GO 
print('***** FROM: View_EDW_HealthAssesmentQuestions.sql'); 
GO 
print ('Processing: view_EDW_ClientCompany ') ;
go

if exists(select TABLE_NAME from INFORMATION_SCHEMA.VIEWS where TABLE_NAME = 'view_EDW_ClientCompany')
BEGIN
	drop view view_EDW_ClientCompany ;
END
GO



CREATE VIEW [dbo].[view_EDW_ClientCompany]
AS
--************************************************************
--One of the few views in the system that is not nested. 
--It combines the Account, Site and Company data.
--Last Tested: 09/04/2014 WDM
--WDM 9.10.2014 - verified dates were available to the EDW
--************************************************************
	SELECT
		hfa.AccountID
		, HFA.AccountCD
		, HFA.AccountName
		, HFA.ItemCreatedWhen as AccountCreated
		, HFA.ItemModifiedWhen as AccountModified
		, HFA.ItemGUID AccountGUID
		, CS.SiteID
		, CS.SiteGUID
		, CS.SiteLastModified
		, HFC.CompanyID
		, HFC.ParentID
		, HFC.CompanyName
		, HFC.CompanyShortName
		, HFC.CompanyStartDate
		, HFC.CompanyEndDate
		, HFC.CompanyStatus
		, CASE	WHEN CAST(hfa.ItemCreatedWhen AS DATE) = CAST(HFA.ItemModifiedWhen AS DATE)
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		, NULL AS CompanyCreated
		, NULL AS CompanyModified
	FROM
		dbo.HFit_Account AS HFA
	INNER JOIN dbo.CMS_Site AS CS ON HFA.SiteID = cs.SiteID
	LEFT OUTER JOIN dbo.HFit_Company AS HFC ON HFA.AccountID = hfc.AccountID






GO


  --  
  --  
GO 
print('***** FROM: view_EDW_ClientCompany.sql'); 
GO 
print ('Processing: view_EDW_Coaches ') ;
go

if exists(select TABLE_NAME from INFORMATION_SCHEMA.VIEWS where TABLE_NAME = 'view_EDW_Coaches')
BEGIN
	drop view view_EDW_Coaches ;
END
GO

--****************************************************
-- Verified last mod date available to EDW 9.10.2014
--****************************************************
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
   ,hfc.SuperCoach
   ,hfc.MaxParticipants
   ,hfc.Inactive
   ,hfc.MaxRiskLevel
   ,hfc.Locked
   ,hfc.TimeLocked
   ,hfc.terminated
   ,hfc.APMaxParticipants
   ,hfc.RNMaxParticipants
   ,hfc.RNPMaxParticipants
   ,hfc.Change_Type
   ,hfc.Last_Update_Dt
FROM
    dbo.HFit_Coaches AS HFC
LEFT OUTER JOIN dbo.CMS_User AS CU ON hfc.KenticoUserID = cu.UserID
LEFT OUTER JOIN dbo.CMS_UserSite AS CUS ON cu.userid = cus.UserID
LEFT OUTER JOIN dbo.CMS_Site AS CS ON CS.SiteID = CUS.SiteID
LEFT OUTER JOIN dbo.HFit_Account AS HFA ON cs.SiteID = hfa.SiteID

GO


  --  
  --  
GO 
print('***** FROM: view_EDW_Coaches.sql'); 
GO 
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

--select * from view_EDW_CoachingDefinition  --  
  --  
GO 
print('Completed: view_EDW_CoachingDefinition.sql'); 
print('***** FROM: view_EDW_CoachingDefinition.sql'); 
GO 

GO
print('***** FROM: view_EDW_CoachingDetail.sql'); 
go

print ('Processing: view_EDW_CoachingDetail ') ;
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


if exists(select TABLE_NAME from INFORMATION_SCHEMA.VIEWS where TABLE_NAME = 'view_EDW_CoachingDetail')
BEGIN
	drop view view_EDW_CoachingDetail ;
END
GO

--GRANT SELECT
--	ON [dbo].[[view_EDW_CoachingDetail]]
--	TO [EDWReader_PRD]
--GO

/* TEST Queries
select * from [view_EDW_CoachingDetail]
select * from [view_EDW_CoachingDetail] where CloseReasonLKPID != 0
select count(*) from [view_EDW_CoachingDetail]
*/

create VIEW [dbo].[view_EDW_CoachingDetail]
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
		, HFUG.IsCreatedByCoach
		, HFUG.BaselineAmount
		, HFUG.GoalAmount
		, Null As DocumentID
		, HFUG.GoalStatusLKPID
		, HFLGS.GoalStatusLKPName
		, HFUG.EvaluationStartDate
		, HFUG.EvaluationEndDate
		, HFUG.GoalStartDate
		, HFUG.CoachDescription
		, HFGO.EvaluationDate
		, HFGO.Passed
		, HFGO.WeekendDate
		, CASE	WHEN CAST(HFUG.ItemCreatedWhen AS DATE) = CAST(HFUG.ItemModifiedWhen AS DATE)
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		, HFUG.ItemCreatedWhen
		, HFUG.ItemModifiedWhen
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
print('***** Created: view_EDW_CoachingDetail'); 
GO 

--Testing History
--1.1.2015: WDM Tested table creation, data entry, and view join
--Testing Criteria
--select * from HFit_LKP_GoalCloseReason
--select * from view_EDW_CoachingDetail
--select * from view_EDW_CoachingDetail where userid in (13470, 107, 13299) and CloseReasonLKPID != 0 
--select * from view_EDW_CoachingDetail where UserGUID = '9C7F1657-8568-4D5D-A797-C6AEEA86834F'
--select * from view_EDW_CoachingDetail where EvaluationDate is null 
--select * from view_EDW_CoachingDetail  where HFitUserMpiNumber in (6238677) and CloseReasonLKPID != 0 
--select * from HFit_UserGoal where UserGUID = '9C7F1657-8568-4D5D-A797-C6AEEA86834F'


GO
-- select top 100 * from view_EDW_HealthAssesment
IF NOT EXISTS (SELECT [name]
			  FROM [sys].[indexes]
			  WHERE [name] = 'PI_View_CMS_Tree_Joined_Regular') 
    BEGIN
	   CREATE NONCLUSTERED INDEX [PI_View_CMS_Tree_Joined_Regular]
	   ON [dbo].[View_CMS_Tree_Joined_Regular] ([ClassName] , [DocumentID]) ;
    END;
GO

IF NOT EXISTS (SELECT [name]
			  FROM [sys].[indexes]
			  WHERE [name] = 'PI_CMSTREE_ClassDocID') 
    BEGIN
	   CREATE NONCLUSTERED INDEX [PI_CMSTR_ClassCulture]
	   ON [dbo].[View_CMS_Tree_Joined_Regular] ([ClassName] , [DocumentCulture]) 
	   INCLUDE ([NodeGUID] , [DocumentForeignKeyValue]) ;
    END;
GO

IF NOT EXISTS (SELECT [name]
			  FROM [sys].[indexes]
			  WHERE [name] = 'PI_CMSTREE_ClassDocID') 
    BEGIN
	   CREATE NONCLUSTERED INDEX [PI_CMSTREE_ClassDocID]
	   ON [dbo].[View_CMS_Tree_Joined_Regular] ([ClassName] , [DocumentID]) ;
    END;
GO

IF NOT EXISTS (SELECT [name]
			  FROM [sys].[indexes]
			  WHERE [name] = 'CI_CMSTree_ClassLang') 
    BEGIN
	   CREATE NONCLUSTERED INDEX [CI_CMSTree_ClassLang]
	   ON [dbo].[View_CMS_Tree_Joined_Regular] ([ClassName] , [DocumentCulture]) 
	   INCLUDE ([NodeID] , [NodeAliasPath] , [NodeParentID] , [NodeLevel] , [NodeGUID] , [NodeOrder] , [NodeLinkedNodeID] , [DocumentModifiedWhen] , [DocumentForeignKeyValue] , [DocumentPublishedVersionHistoryID] , [DocumentGUID]) ;
    END;

IF NOT EXISTS (SELECT [name]
			  FROM [sys].[indexes]
			  WHERE [name] = 'CI_HFit_HealthAssesmentUserQuestion_NodeGUID') 
    BEGIN
	   CREATE NONCLUSTERED INDEX [CI_HFit_HealthAssesmentUserQuestion_NodeGUID]
	   ON [dbo].[HFit_HealthAssesmentUserQuestion] ([HAQuestionNodeGUID]) 
	   INCLUDE ([ItemID] , [HAQuestionScore] , [ItemModifiedWhen] , [HARiskAreaItemID] , [CodeName] , [PreWeightedScore] , [IsProfessionallyCollected]) ;
    END;
GO

IF NOT EXISTS (SELECT [name]
			  FROM [sys].[indexes]
			  WHERE [name] = 'PI_GuidLang') 
    BEGIN
	   CREATE NONCLUSTERED INDEX [PI_GuidLang]
	   ON [dbo].[View_CMS_Tree_Joined_Regular] ([NodeGUID] , [DocumentCulture]) ;
    END;
GO

IF NOT EXISTS (SELECT [name]
			  FROM [sys].[indexes]
			  WHERE [name] = 'PI_ClassLang') 
    BEGIN
	   CREATE NONCLUSTERED INDEX [PI_ClassLang]
	   ON [dbo].[View_CMS_Tree_Joined_Regular] ([ClassName] , [DocumentCulture]) 
	   INCLUDE ([NodeGUID] , [DocumentForeignKeyValue]) ;
    END;
GO

IF NOT EXISTS (SELECT [name]
			  FROM [sys].[indexes]
			  WHERE [name] = 'CI_EDW_HealthAssesment_HAModuleItemID') 
    BEGIN
	   CREATE NONCLUSTERED INDEX [CI_EDW_HealthAssesment_HAModuleItemID]
	   ON [dbo].[HFit_HealthAssesmentUserRiskCategory] ([HAModuleItemID]) 
	   INCLUDE ([ItemID] , [ItemModifiedWhen] , [HARiskCategoryScore] , [CodeName] , [PreWeightedScore] , [HARiskCategoryNodeGUID]) ;
    END;

PRINT 'Processing view_EDW_HealthAssesment';
GO

IF EXISTS (SELECT [name]
		   FROM [sys].[views]
		   WHERE [name] = 'view_EDW_HealthAssesment') 
    BEGIN
	   DROP VIEW [view_EDW_HealthAssesment];
    END;
GO
--select top 100 * from [view_EDW_HealthAssesment]
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
-- 08/07/2014 - (WDM) as HAModuleDocumentID	--WDM 10.02.2014 place holder for EDW ETL per John C., Added back per John C. 10.16.2014
-- 09/30/2014 - (WDM) as HAModuleDocumentID	--Mark and Dale use NodeGUID instead of Doc GUID
--WDM 10.02.2014 place holder for EDW ETL
--Per John C. 10.16.2014 requested that this be put back into the view.	
--11.05.2014 - Changed from CMS_TREE Joined to View_HFit_HealthAssessment_Joined Mark T. / Dale M.
-- 11.05.2014 - Mark T. / Dale M. needed to get the Document for the user : ADDED inner join View_HFit_HealthAssessment_Joined as VHAJ on VHAJ.DocumentID = VHCJ.HealthAssessmentID
-- 11.05.2014 - removed the Distinct - may find it necessary to put it back as duplicates may be there. But the server resources required to do this may not be avail on P5.
--11.05.2014 - Mark T. / Dale M. removed the link to View_CMS_Tree_Joined and replaced with View_HFit_HealthAssessment_Joined
--inner join View_CMS_Tree_Joined as VCTJ on VCTJ.NodeGUID = HAUserModule.HAModuleNodeGUID
--	and VCTJ.DocumentCulture = 'en-US'	--10.01.2014 put here to match John C. req. for language agnostic.
-- 12.02.2014 - (wdm)Found that the view was being overwritten between Prod 1 and the copy of Prod 5 / Prod 1. Found a script inside a job on PRod 5 that reverted the view to a previous state. Removed the script and the view migrates correctly (d. miller and m. kimenski)
-- 12.02.2014 - (wdm) Found DUPS in Prod 1 and Prod 2, none in Prod 3. 
-- 12.17.2014 - Added two columns requested by the EDW team as noted by comments next to each column.
-- 12.29.2014 - Stripped HTML out of Title #47619
-- 12.31.2014 - Eliminated negative MPI's in response to CR47516 
-- 01.02.2014 - Tested the removal of negative MPI's in response to CR47516 
--01.27.2015 (WDM) #48941 - Add Client Identifier to View_EDW_Eligibility
--	   In analyzing this requirement, found that the PPT.ClientID is nvarchar (alphanumeric)
--	   and Hfit_Client.ClientID is integer. A bit of a domain/naming issue.
--	   This is NOT needed as the data is already contained in columns [AccountID] and [AccountCD]
--	   NOTE: Added the column [AccountName], just in case it were to be needed later.
--02.04.2015 (WDM) #48828 added:
--	    [HAUserStarted].[HACampaignNodeGUID], VCJ.BiometricCampaignStartDate
--	   , VCJ.BiometricCampaignEndDate, VCJ.CampaignStartDate
--	   , VCJ.CampaignEndDate, VCJ.Name as CampaignName, HACampaignID
--02.05.2015 Ashwin and I reviewed and approved
--********************************************************************************************************


SELECT 
[HAUserStarted].[ItemID] AS [UserStartedItemID]
, [VHAJ].[NodeGUID] AS [HealthAssesmentUserStartedNodeGUID]
, [HAUserStarted].[UserID]
, [CMSUser].[UserGUID]
, [UserSettings].[HFitUserMpiNumber]
, [CMSSite].[SiteGUID]
, [ACCT].[AccountID]
, [ACCT].[AccountCD]
, [ACCT].[AccountName]
, [HAUserStarted].[HAStartedDt]
, [HAUserStarted].[HACompletedDt]
, [HAUserModule].[ItemID] AS [UserModuleItemId]
, [HAUserModule].[CodeName] AS [UserModuleCodeName]
, [HAUserModule].[HAModuleNodeGUID]
, [VHAJ].[NodeGUID] AS [CMSNodeGuid]
, NULL AS [HAModuleVersionID]
, [HARiskCategory].[ItemID] AS [UserRiskCategoryItemID]
, [HARiskCategory].[CodeName] AS [UserRiskCategoryCodeName]
, [HARiskCategory].[HARiskCategoryNodeGUID]						--WDM 8/7/2014 as HARiskCategoryDocumentID
, NULL AS [HARiskCategoryVersionID]			--WDM 10.02.2014 place holder for EDW ETL
, [HAUserRiskArea].[ItemID] AS [UserRiskAreaItemID]
, [HAUserRiskArea].[CodeName] AS [UserRiskAreaCodeName]
, [HAUserRiskArea].[HARiskAreaNodeGUID]							--WDM 8/7/2014 as HARiskAreaDocumentID
, NULL AS [HARiskAreaVersionID]			--WDM 10.02.2014 place holder for EDW ETL
, [HAUserQuestion].[ItemID] AS [UserQuestionItemID]
, [dbo].[udf_StripHTML] ([HAQuestionsView].[Title]) AS [Title]			--WDM 47619 12.29.2014
, [HAUserQuestion].[HAQuestionNodeGUID]	AS [HAQuestionGuid]		--WDM 9.2.2014	This is a repeat field but had to stay to match the previous view - this is the NODE GUID and matches to the definition file to get the question. This tells you the question, language agnostic.
, [HAUserQuestion].[CodeName] AS [UserQuestionCodeName]
, NULL AS [HAQuestionDocumentID]	--WDM 10.1.2014 - this is GOING AWAY 		--WDM 10.02.2014 place holder for EDW ETL
, NULL AS [HAQuestionVersionID]			--WDM 10.1.2014 - this is GOING AWAY - no versions across environments 		--WDM 10.02.2014 place holder for EDW ETL
, [HAUserQuestion].[HAQuestionNodeGUID]		--WDM 10.01.2014	Left this in place to preserve column structure.		
, [HAUserAnswers].[ItemID] AS [UserAnswerItemID]
, [HAUserAnswers].[HAAnswerNodeGUID]								--WDM 8/7/2014 as HAAnswerDocumentID
, NULL AS [HAAnswerVersionID]		--WDM 10.1.2014 - this is GOING AWAY - no versions across environments		--WDM 10.02.2014 place holder for EDW ETL
, [HAUserAnswers].[CodeName] AS [UserAnswerCodeName]
, [HAUserAnswers].[HAAnswerValue]
, [HAUserModule].[HAModuleScore]
, [HARiskCategory].[HARiskCategoryScore]
, [HAUserRiskArea].[HARiskAreaScore]
, [HAUserQuestion].[HAQuestionScore]
, [HAUserAnswers].[HAAnswerPoints]
, [HAUserQuestionGroupResults].[PointResults]
, [HAUserAnswers].[UOMCode]
, [HAUserStarted].[HAScore]
, [HAUserModule].[PreWeightedScore] AS [ModulePreWeightedScore]
, [HARiskCategory].[PreWeightedScore] AS [RiskCategoryPreWeightedScore]
, [HAUserRiskArea].[PreWeightedScore] AS [RiskAreaPreWeightedScore]
, [HAUserQuestion].[PreWeightedScore] AS [QuestionPreWeightedScore]
, [HAUserQuestionGroupResults].[CodeName] AS [QuestionGroupCodeName]
, CASE
	 WHEN [HAUserAnswers].[ItemCreatedWhen] = [HAUserAnswers].[ItemModifiedWhen]
	 THEN 'I'
	 ELSE 'U'
  END AS [ChangeType]
, [HAUserAnswers].[ItemCreatedWhen]
, [HAUserAnswers].[ItemModifiedWhen]
, [HAUserQuestion].[IsProfessionallyCollected]

, [HARiskCategory].[ItemModifiedWhen] AS [HARiskCategory_ItemModifiedWhen]
, [HAUserRiskArea].[ItemModifiedWhen] AS [HAUserRiskArea_ItemModifiedWhen]
, [HAUserQuestion].[ItemModifiedWhen] AS [HAUserQuestion_ItemModifiedWhen]
, [HAUserAnswers].[ItemModifiedWhen] AS [HAUserAnswers_ItemModifiedWhen]
, [HAUserStarted].[HAPaperFlg]
, [HAUserStarted].[HATelephonicFlg]
, [HAUserStarted].[HAStartedMode]		--12.11.2014 WDM Sowmiya and dale talked and decided to implement this column 12.17.2014 - Added 
, [HAUserStarted].[HACompletedMode]	--12.11.2014 WDM Sowmiya and dale talked and decided to implement this column 12.17.2014 - Added 

, [VHCJ].[DocumentCulture] AS [DocumentCulture_VHCJ]
, [HAQuestionsView].[DocumentCulture] AS [DocumentCulture_HAQuestionsView]
, [HAUserStarted].[HACampaignNodeGUID] as CampaignNodeGUID
-- PER John C. 2.6.2015 - Please comment out all columns except the GUID in the Assesment view.  It will reduce the amount of data coming through the delta process.  Thank you
--, [VHCJ].BiometricCampaignStartDate
--, [VHCJ].BiometricCampaignEndDate
--, [VHCJ].CampaignStartDate
--, [VHCJ].CampaignEndDate
--, [VHCJ].Name as CampaignName 
--, [VHCJ].HACampaignID

/*
--the below are need in this view 
, HACampaign.BiometricCampaignStartDate
, HACampaign.BiometricCampaignEndDate
, HACampaign.CampaignStartDate
, HACampaign.CampaignEndDate
, HACampaign.Name

or only the 
select * from HAUserStarted
, HACampaign.NodeGuid as CampaignNodeGuid
*/


  FROM
	  [dbo].[HFit_HealthAssesmentUserStarted] AS [HAUserStarted]
		 INNER JOIN
		 [dbo].[CMS_User] AS [CMSUser]
		 ON [HAUserStarted].[UserID] = [CMSUser].[UserID]
		 INNER JOIN
		 [dbo].[CMS_UserSettings] AS [UserSettings]
		 ON [UserSettings].[UserSettingsUserID] = [CMSUser].[UserID]
		AND [HFitUserMpiNumber] >= 0
		AND [HFitUserMpiNumber] IS NOT NULL -- (WDM) CR47516 
		 INNER JOIN
		 [dbo].[CMS_UserSite] AS [UserSite]
		 ON [CMSUser].[UserID] = [UserSite].[UserID]
		 INNER JOIN
		 [dbo].[CMS_Site] AS [CMSSite]
		 ON [UserSite].[SiteID] = [CMSSite].[SiteID]
		 INNER JOIN
		 [dbo].[HFit_Account] AS [ACCT]
		 ON [ACCT].[SiteID] = [CMSSite].[SiteID]
		 INNER JOIN
		 [dbo].[HFit_HealthAssesmentUserModule] AS [HAUserModule]
		 ON [HAUserStarted].[ItemID] = [HAUserModule].[HAStartedItemID]
		 INNER JOIN
		 [View_HFit_HACampaign_Joined] AS [VHCJ]
		 ON [VHCJ].[NodeGUID] = [HAUserStarted].[HACampaignNodeGUID]
		AND [VHCJ].[NodeSiteID] = [UserSite].[SiteID]
		AND [VHCJ].[DocumentCulture] = 'en-US' --11.05.2014 - Mark T. / Dale M. - 
		 INNER JOIN
		 [View_HFit_HealthAssessment_Joined] AS [VHAJ]
		 ON [VHAJ].[DocumentID] = [VHCJ].[HealthAssessmentID]
		 INNER JOIN
		 [dbo].[HFit_HealthAssesmentUserRiskCategory] AS [HARiskCategory]
		 ON [HAUserModule].[ItemID] = [HARiskCategory].[HAModuleItemID]
		 INNER JOIN
		 [dbo].[HFit_HealthAssesmentUserRiskArea] AS [HAUserRiskArea]
		 ON [HARiskCategory].[ItemID] = [HAUserRiskArea].[HARiskCategoryItemID]
		 INNER JOIN
		 [dbo].[HFit_HealthAssesmentUserQuestion] AS [HAUserQuestion]
		 ON [HAUserRiskArea].[ItemID] = [HAUserQuestion].[HARiskAreaItemID]
		 INNER JOIN
		 [dbo].[View_EDW_HealthAssesmentQuestions] AS [HAQuestionsView]
		 ON [HAUserQuestion].[HAQuestionNodeGUID] = [HAQuestionsView].[NodeGUID]
		AND [HAQuestionsView].[DocumentCulture] = 'en-US'
		 LEFT OUTER JOIN
		 [dbo].[HFit_HealthAssesmentUserQuestionGroupResults] AS [HAUserQuestionGroupResults]
		 ON [HAUserRiskArea].[ItemID] = [HAUserQuestionGroupResults].[HARiskAreaItemID]
		 INNER JOIN
		 [dbo].[HFit_HealthAssesmentUserAnswers] AS [HAUserAnswers]
		 ON [HAUserQuestion].[ItemID] = [HAUserAnswers].[HAQuestionItemID]	
		 
		 --left outer join View_HFit_HACampaign_Joined as VCJ 
		 --on VCJ.NodeGuid = [HAUserStarted].[HACampaignNodeGUID]
		 	 
  WHERE [UserSettings].[HFitUserMpiNumber] NOT IN (SELECT [RejectMPICode]
										   FROM [HFit_LKP_EDW_RejectMPI]) ;
--CMSUser.UserGUID not in  (Select RejectUserGUID from HFit_LKP_EDW_RejectMPI)	--61788DF7-955D-4A78-B77E-3DA340847AE7

GO

PRINT 'Processed view_EDW_HealthAssesment';
GO
--  
--  
GO
PRINT '***** FROM: view_EDW_HealthAssesment.sql';
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



  --  
  --  
GO 
print('***** FROM: View_EDW_HealthAssesmentAnswers.sql'); 
GO 

GO
PRINT 'Processing: view_EDW_HealthAssesmentClientView ';
GO

IF EXISTS (SELECT [TABLE_NAME]
		   FROM [INFORMATION_SCHEMA].[VIEWS]
		   WHERE [TABLE_NAME] = 'view_EDW_HealthAssesmentClientView') 
    BEGIN
	   DROP VIEW [view_EDW_HealthAssesmentClientView];
    END;
GO

--GRANT SELECT
--	ON [dbo].[view_EDW_HealthAssesmentClientView]
--	TO [EDWReader_PRD]
--GO

--******************************************************************************
--8/8/2014 - Generated corrected view in DEV (WDM)
--09.11.2014 (wdm) added to facilitate EDW last mod date
--02.04.2015 (wdm) #48828 added , HACampaign.BiometricCampaignStartDate, 
--		  HACampaign.BiometricCampaignEndDate, HACampaign.CampaignStartDate, 
--		  HACampaign.CampaignEndDate, HACampaign.Name, 
--		  HACampaign.NodeGuid as CampaignNodeGuid
--02.05.2015 Ashwin and I reviewed and approved
-- select top 100 * from view_EDW_HealthAssesmentClientView
--******************************************************************************
CREATE VIEW [dbo].[view_EDW_HealthAssesmentClientView]
AS SELECT
   [HFitAcct].[AccountID]
 , [HFitAcct].[AccountCD]
 , [HFitAcct].[AccountName]
 , [HFitAcct].[ItemGUID] AS [ClientGuid]
 , [CMSSite].[SiteGUID]
 , NULL AS [CompanyID]
 , NULL AS [CompanyGUID]
 , NULL AS [CompanyName]
 , [HAJoined].[DocumentName]
 , [HACampaign].[DocumentPublishFrom] AS [HAStartDate]
 , [HACampaign].[DocumentPublishTo] AS [HAEndDate]
 , [HACampaign].[NodeSiteID]
 , [HAAssessmentMod].[Title]
 , [HAAssessmentMod].[CodeName]
 , [HAAssessmentMod].[IsEnabled]
 , CASE
	  WHEN CAST ([HACampaign].[DocumentCreatedWhen] AS date) = CAST ([HACampaign].[DocumentModifiedWhen] AS date) 
	  THEN 'I'
	  ELSE 'U'
   END AS [ChangeType]
 , [HACampaign].[DocumentCreatedWhen]
 , [HACampaign].[DocumentModifiedWhen]
 , [HAAssessmentMod].[DocumentModifiedWhen] AS [AssesmentModule_DocumentModifiedWhen]	--09.11.2014 (wdm) added to facilitate EDW last mod date
 , [HAAssessmentMod].[DocumentCulture] AS [DocumentCulture_HAAssessmentMod]
 , [HACampaign].[DocumentCulture] AS [DocumentCulture_HACampaign]
 , [HAJoined].[DocumentCulture] AS [DocumentCulture_HAJoined]
 , [HACampaign].[BiometricCampaignStartDate]
 , [HACampaign].[BiometricCampaignEndDate]
 , [HACampaign].[CampaignStartDate]
 , [HACampaign].[CampaignEndDate]
 , [HACampaign].[Name]
 , [HACampaign].[NodeGuid] AS [CampaignNodeGuid]
 , [HACampaign].HACampaignID
	FROM
		[dbo].[View_HFit_HACampaign_Joined] AS [HACampaign]
		    INNER JOIN [dbo].[CMS_Site] AS [CMSSite]
			   ON [HACampaign].[NodeSiteID] = [CMSSite].[SiteID]
		    INNER JOIN [dbo].[HFit_Account] AS [HFitAcct]
			   ON [HACampaign].[NodeSiteID] = [HFitAcct].[SiteID]
		    INNER JOIN [dbo].[View_HFit_HealthAssessment_Joined] AS [HAJoined]
			   ON CASE
					WHEN [HACampaign].[HealthAssessmentConfigurationID] < 0
					THEN [HACampaign].[HealthAssessmentID]
					ELSE [HACampaign].[HealthAssessmentConfigurationID]
				 END = HAJoined.DocumentID
			  AND [HAJoined].[DocumentCulture] = 'en-US'
		    INNER JOIN [dbo].[View_HFit_HealthAssesmentModule_Joined] AS [HAAssessmentMod]
			   ON [HAJoined].[nodeid] = [HAAssessmentMod].[NodeParentID]
			  AND [HAAssessmentMod].[DocumentCulture] = 'en-US'
	WHERE [HACampaign].[DocumentCulture] = 'en-US';

GO

PRINT 'Created: view_EDW_HealthAssesmentClientView ';
GO
--  
--  
GO
PRINT '***** FROM: view_EDW_HealthAssesmentClientView.sql';
GO 

print ('Processing: view_EDW_HealthAssesmentDeffinition ' + cast(getdate() as nvarchar(50))) ;
go

--select count(*) from view_EDW_HealthAssesmentDeffinition

if exists(select TABLE_NAME from INFORMATION_SCHEMA.VIEWS where TABLE_NAME = 'view_EDW_HealthAssesmentDeffinition')
BEGIN
	drop view view_EDW_HealthAssesmentDeffinition ;
END
GO

create VIEW [dbo].[view_EDW_HealthAssesmentDeffinition] 
AS
SELECT distinct 
--**************************************************************************************************************
--NOTE: The column DocumentModifiedWhen comes from the CMS_TREE join - it was left 
--		unchanged when other dates added for the Last Mod Date additions. 
--		Therefore, the 'ChangeType' was left dependent upon this date only. 09.12.2014 (wdm)
--*****************************************************************************************************************************************************
--Test Queries:
--select * from view_EDW_HealthAssesmentDeffinition where AnsDocumentGuid is not NULL
--Changes:
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
--8/12/2014 - select * from [view_EDW_HealthAssesmentDeffinition] where DocumentModifiedWhen between '2000-11-14' and 
--				'2014-11-15' now runs exceptionally fast
--08/12/2014 - ProdStaging 00:21:52 @ 2442
--08/12/2014 - ProdStaging 00:21:09 @ 13272 (UNION ALL   --UNION)
--08/12/2014 - ProdStaging 00:21:37 @ 13272 (UNION ONLY)
--08/12/2014 - ProdStaging 00:06:26 @ 1582 (UNION ONLY & Select Filters Added for Culture)
--08/12/2014 - ProdStaging 00:10:07 @ 6636 (UNION ALL   --UNION) and all selected
--08/12/2014 - ProdStaging added PI PI_View_CMS_Tree_Joined_Regular_DocumentCulture: 00:2:34 @ 6636 
--08/12/2014 - DEV 00:00:58 @ 3792
--09.11.2014 - (wdm) added the needed date fields to help EDW in determining the last mod date of a row.
--10.01.2014 - Dale and Mark reworked this view to use NodeGUIDS and eliminated the CMS_TREE View from participating as 
--				well as Site and Account data
--11.25.2014 - (wdm) added multi-select column capability. The values can be 0,1, NULL
--12.29.2014 - (wdm) Added HTML stripping to two columns #47619, the others mentioned already had stripping applied
--12.31.2014 - (wdm) Started the review to apply CR-47517: Eliminate Matrix Questions with NULL Answer GUID's
--01.07.2014 - (wdm) 47619 The Health Assessment Definition interface view contains HTML tags - corrected with udf_StripHTML
--************************************************************************************************************************************************************
		NULL as SiteGUID --cs.SiteGUID								--WDM 08.12.2014 per John C.
		, NULL as AccountCD	 --, HFA.AccountCD						--WDM 08.07.2014 per John C.
		, HA.NodeID AS HANodeID										--WDM 08.07.2014
		, HA.NodeName AS HANodeName									--WDM 08.07.2014
		--, HA.DocumentID AS HADocumentID								--WDM 08.07.2014 commented out and left in place for history
		, NULL AS HADocumentID										--WDM 08.07.2014; 09.29.2014: Mark and Dale discussed that NODEGUID should be used such that the multi-language/culture is not a problem.
		, HA.NodeSiteID AS HANodeSiteID								--WDM 08.07.2014
		, HA.DocumentPublishedVersionHistoryID AS HADocPubVerID		--WDM 08.07.2014
		, dbo.udf_StripHTML(VHFHAMJ.Title) AS ModTitle              --WDM 47619
		, dbo.udf_StripHTML(left(VHFHAMJ.IntroText,4000)) AS IntroText              --WDM 47619
		, VHFHAMJ.NodeGuid AS ModDocGuid	--, VHFHAMJ.DocumentID AS ModDocID	--WDM 08.07.2014	M&D 10.01.2014
		, VHFHAMJ.Weight AS ModWeight
		, VHFHAMJ.IsEnabled AS ModIsEnabled
		, VHFHAMJ.CodeName AS ModCodeName
		, VHFHAMJ.DocumentPublishedVersionHistoryID AS ModDocPubVerID
		, dbo.udf_StripHTML(VHFHARCJ.Title) AS RCTitle              --WDM 47619
		, VHFHARCJ.Weight AS RCWeight
		, VHFHARCJ.NodeGuid AS RCDocumentGUID	--, VHFHARCJ.DocumentID AS RCDocumentID	--WDM 08.07.2014	M&D 10.01.2014
		, VHFHARCJ.IsEnabled AS RCIsEnabled
		, VHFHARCJ.CodeName AS RCCodeName
		, VHFHARCJ.DocumentPublishedVersionHistoryID AS RCDocPubVerID
		, dbo.udf_StripHTML(VHFHARAJ.Title) AS RATytle              --WDM 47619
		, VHFHARAJ.Weight AS RAWeight
		, VHFHARAJ.NodeGuid AS RADocumentGuid	--, VHFHARAJ.DocumentID AS RADocumentID	--WDM 08.07.2014	M&D 10.01.2014
		, VHFHARAJ.IsEnabled AS RAIsEnabled
		, VHFHARAJ.CodeName AS RACodeName
		, VHFHARAJ.ScoringStrategyID AS RAScoringStrategyID
		, VHFHARAJ.DocumentPublishedVersionHistoryID AS RADocPubVerID
		, VHFHAQ.QuestionType
		, dbo.udf_StripHTML(left(VHFHAQ.Title,4000)) AS QuesTitle              --WDM 47619
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
		, VHFHAA.NodeGuid AS AnsDocumentGuid		--ref: #47517
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
		, HAMCQ.AllowMultiSelect
		, 'SID01' as LocID
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
			
		left outer join [View_HFit_HealthAssesmentMultipleChoiceQuestion_Joined] as HAMCQ 
			on VHFHAQ.Nodeguid = HAMCQ.Nodeguid
			AND HAMCQ.DocumentCulture = 'en-US'
	where VHFHAQ.DocumentCulture = 'en-us'	--WDM 08.12.2014	
		and (VHFHAA.DocumentCulture = 'en-us' OR VHFHAA.DocumentCulture is null)	--WDM 08.12.2014		
		and VHFHARCJ.DocumentCulture = 'en-us'	--WDM 08.12.2014		
		and VHFHARAJ.DocumentCulture = 'en-us'	--WDM 08.12.2014		
		and VHFHAMJ.DocumentCulture = 'en-us'	--WDM 08.12.2014	
		and HA.DocumentCulture = 'en-us'		--WDM 08.12.2014	
		AND VHFHAA.NodeGuid is not null		--ref: #47517

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
		, dbo.udf_StripHTML(VHFHAMJ.Title)              --WDM 47619
		, dbo.udf_StripHTML(left(left(VHFHAMJ.IntroText,4000),4000)) AS IntroText              --WDM 47619
		, VHFHAMJ.NodeGuid
		, VHFHAMJ.Weight
		, VHFHAMJ.IsEnabled
		, VHFHAMJ.CodeName
       --,VHFHAMJ.NodeAliasPath
		, VHFHAMJ.DocumentPublishedVersionHistoryID
		, dbo.udf_StripHTML(VHFHARCJ.Title)              --WDM 47619
		, VHFHARCJ.Weight
		, VHFHARCJ.NodeGuid
		, VHFHARCJ.IsEnabled
		, VHFHARCJ.CodeName
       --,VHFHARCJ.NodeAliasPath
		, VHFHARCJ.DocumentPublishedVersionHistoryID
		, dbo.udf_StripHTML(VHFHARAJ.Title)              --WDM 47619
		, VHFHARAJ.Weight
		, VHFHARAJ.NodeGuid
		, VHFHARAJ.IsEnabled
		, VHFHARAJ.CodeName
       --,VHFHARAJ.NodeAliasPath
		, VHFHARAJ.ScoringStrategyID
		, VHFHARAJ.DocumentPublishedVersionHistoryID
		, VHFHAQ2.QuestionType
		, dbo.udf_StripHTML(left(VHFHAQ2.Title,4000)) AS QuesTitle              --WDM 47619
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
		, VHFHAA2.NodeGuid		--ref: #47517
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
		, HAMCQ.AllowMultiSelect
		, 'SID02' as LocID
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
	left outer join [View_HFit_HealthAssesmentMultipleChoiceQuestion_Joined] as HAMCQ 
			on VHFHAQ.Nodeguid = HAMCQ.Nodeguid
			AND HAMCQ.DocumentCulture = 'en-US'
where VHFHAQ.DocumentCulture = 'en-us'	
		and (VHFHAA.DocumentCulture = 'en-us' OR VHFHAA.DocumentCulture is null)	--WDM 08.12.2014		
		and VHFHARCJ.DocumentCulture = 'en-us'	
		and VHFHARAJ.DocumentCulture = 'en-us'	
		and VHFHAMJ.DocumentCulture = 'en-us'	--WDM 08.12.2014	
		and HA.DocumentCulture = 'en-us'	--WDM 08.12.2014		
		AND VHFHAA2.NodeGuid is not null		--ref: #47517

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
		, dbo.udf_StripHTML(VHFHAMJ.Title)
		, dbo.udf_StripHTML(left(VHFHAMJ.IntroText,4000)) AS IntroText
		, VHFHAMJ.NodeGuid
		, VHFHAMJ.Weight
		, VHFHAMJ.IsEnabled
		, VHFHAMJ.CodeName
       --,VHFHAMJ.NodeAliasPath
		, VHFHAMJ.DocumentPublishedVersionHistoryID
		, dbo.udf_StripHTML(VHFHARCJ.Title)
		, VHFHARCJ.Weight
		, VHFHARCJ.NodeGuid
		, VHFHARCJ.IsEnabled
		, VHFHARCJ.CodeName
       --,VHFHARCJ.NodeAliasPath
		, VHFHARCJ.DocumentPublishedVersionHistoryID
		, dbo.udf_StripHTML(VHFHARAJ.Title)
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
		, VHFHAA3.NodeGuid		--ref: #47517
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
		, HAMCQ.AllowMultiSelect
		, 'SID03' as LocID
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
	left outer join [View_HFit_HealthAssesmentMultipleChoiceQuestion_Joined] as HAMCQ 
			on VHFHAQ.Nodeguid = HAMCQ.Nodeguid
			AND HAMCQ.DocumentCulture = 'en-US'
where VHFHAQ.DocumentCulture = 'en-us'	
		and (VHFHAA.DocumentCulture = 'en-us' OR VHFHAA.DocumentCulture is null)	--WDM 08.12.2014		
		and VHFHARCJ.DocumentCulture = 'en-us'	
		and VHFHARAJ.DocumentCulture = 'en-us'	
		and VHFHAMJ.DocumentCulture = 'en-us'	--WDM 08.12.2014	
		and HA.DocumentCulture = 'en-us'	--WDM 08.12.2014		
		AND VHFHAA3.NodeGuid is not null		--ref: #47517

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
		, dbo.udf_StripHTML(VHFHAMJ.Title)
		, dbo.udf_StripHTML(left(VHFHAMJ.IntroText,4000)) AS IntroText
		, VHFHAMJ.NodeGuid
		, VHFHAMJ.Weight
		, VHFHAMJ.IsEnabled
		, VHFHAMJ.CodeName
       --,VHFHAMJ.NodeAliasPath
		, VHFHAMJ.DocumentPublishedVersionHistoryID
		, dbo.udf_StripHTML(VHFHARCJ.Title)
		, VHFHARCJ.Weight
		, VHFHARCJ.NodeGuid
		, VHFHARCJ.IsEnabled
		, VHFHARCJ.CodeName
       --,VHFHARCJ.NodeAliasPath
		, VHFHARCJ.DocumentPublishedVersionHistoryID
		, dbo.udf_StripHTML(VHFHARAJ.Title)
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
		, VHFHAA7.NodeGuid		--ref: #47517
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
		, HAMCQ.AllowMultiSelect
		, 'SID04' as LocID
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
	left outer join [View_HFit_HealthAssesmentMultipleChoiceQuestion_Joined] as HAMCQ 
			on VHFHAQ.Nodeguid = HAMCQ.Nodeguid
			AND HAMCQ.DocumentCulture = 'en-US'
where VHFHAQ.DocumentCulture = 'en-us'	
		and (VHFHAA.DocumentCulture = 'en-us' OR VHFHAA.DocumentCulture is null)	--WDM 08.12.2014		
		and VHFHARCJ.DocumentCulture = 'en-us'	
		and VHFHARAJ.DocumentCulture = 'en-us'	
		and VHFHAMJ.DocumentCulture = 'en-us'	--WDM 08.12.2014	
		and HA.DocumentCulture = 'en-us'	--WDM 08.12.2014		
		AND VHFHAA7.NodeGuid is not null		--ref: #47517

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
		, dbo.udf_StripHTML(VHFHAMJ.Title)
		, dbo.udf_StripHTML(left(VHFHAMJ.IntroText,4000)) AS IntroText
		, VHFHAMJ.NodeGuid
		, VHFHAMJ.Weight
		, VHFHAMJ.IsEnabled
		, VHFHAMJ.CodeName
       --,VHFHAMJ.NodeAliasPath
		, VHFHAMJ.DocumentPublishedVersionHistoryID
		, dbo.udf_StripHTML(VHFHARCJ.Title)
		, VHFHARCJ.Weight
		, VHFHARCJ.NodeGuid
		, VHFHARCJ.IsEnabled
		, VHFHARCJ.CodeName
       --,VHFHARCJ.NodeAliasPath
		, VHFHARCJ.DocumentPublishedVersionHistoryID
		, dbo.udf_StripHTML(VHFHARAJ.Title)
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
		, VHFHAA8.NodeGuid		--ref: #47517
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
		, HAMCQ.AllowMultiSelect
		, 'SID05' as LocID
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
			left outer join [View_HFit_HealthAssesmentMultipleChoiceQuestion_Joined] as HAMCQ 
			on VHFHAQ.Nodeguid = HAMCQ.Nodeguid
			AND HAMCQ.DocumentCulture = 'en-US'
where VHFHAQ.DocumentCulture = 'en-us'	
		and (VHFHAA.DocumentCulture = 'en-us' OR VHFHAA.DocumentCulture is null)	--WDM 08.12.2014		
		and VHFHARCJ.DocumentCulture = 'en-us'	
		and VHFHARAJ.DocumentCulture = 'en-us'	
		and VHFHAMJ.DocumentCulture = 'en-us'	--WDM 08.12.2014	
		and HA.DocumentCulture = 'en-us'	--WDM 08.12.2014		
		AND VHFHAA8.NodeGuid is not null		--ref: #47517

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
		, dbo.udf_StripHTML(VHFHAMJ.Title)
		, dbo.udf_StripHTML(left(VHFHAMJ.IntroText,4000)) AS IntroText
		, VHFHAMJ.NodeGuid
		, VHFHAMJ.Weight
		, VHFHAMJ.IsEnabled
		, VHFHAMJ.CodeName
       --,VHFHAMJ.NodeAliasPath
		, VHFHAMJ.DocumentPublishedVersionHistoryID
		, dbo.udf_StripHTML(VHFHARCJ.Title)
		, VHFHARCJ.Weight
		, VHFHARCJ.NodeGuid
		, VHFHARCJ.IsEnabled
		, VHFHARCJ.CodeName
       --,VHFHARCJ.NodeAliasPath
		, VHFHARCJ.DocumentPublishedVersionHistoryID
		, dbo.udf_StripHTML(VHFHARAJ.Title)
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
		, VHFHAA4.NodeGuid		--ref: #47517
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
		, HAMCQ.AllowMultiSelect
		, 'SID06' as LocID
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
			left outer join [View_HFit_HealthAssesmentMultipleChoiceQuestion_Joined] as HAMCQ 
			on VHFHAQ.Nodeguid = HAMCQ.Nodeguid
			AND HAMCQ.DocumentCulture = 'en-US'
where VHFHAQ.DocumentCulture = 'en-us'	
		and (VHFHAA.DocumentCulture = 'en-us' OR VHFHAA.DocumentCulture is null)	--WDM 08.12.2014		
		and VHFHARCJ.DocumentCulture = 'en-us'	
		and VHFHARAJ.DocumentCulture = 'en-us'	
		and VHFHAMJ.DocumentCulture = 'en-us'	--WDM 08.12.2014	
		and HA.DocumentCulture = 'en-us'	--WDM 08.12.2014		
		AND VHFHAA4.NodeGuid is not null		--ref: #47517

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
		, dbo.udf_StripHTML(VHFHAMJ.Title)
		, dbo.udf_StripHTML(left(VHFHAMJ.IntroText,4000)) AS IntroText
		, VHFHAMJ.NodeGuid
		, VHFHAMJ.Weight
		, VHFHAMJ.IsEnabled
		, VHFHAMJ.CodeName
       --,VHFHAMJ.NodeAliasPath
		, VHFHAMJ.DocumentPublishedVersionHistoryID
		, dbo.udf_StripHTML(VHFHARCJ.Title)
		, VHFHARCJ.Weight
		, VHFHARCJ.NodeGuid
		, VHFHARCJ.IsEnabled
		, VHFHARCJ.CodeName
       --,VHFHARCJ.NodeAliasPath
		, VHFHARCJ.DocumentPublishedVersionHistoryID
		, dbo.udf_StripHTML(VHFHARAJ.Title)
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
		, VHFHAA5.NodeGuid		--ref: #47517
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
		, HAMCQ.AllowMultiSelect
		, 'SID07' as LocID
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
		left outer join [View_HFit_HealthAssesmentMultipleChoiceQuestion_Joined] as HAMCQ 
			on VHFHAQ.Nodeguid = HAMCQ.Nodeguid
			AND HAMCQ.DocumentCulture = 'en-US'
where VHFHAQ.DocumentCulture = 'en-us'	
		and (VHFHAA.DocumentCulture = 'en-us' OR VHFHAA.DocumentCulture is null)	--WDM 08.12.2014		
		and VHFHARCJ.DocumentCulture = 'en-us'	
		and VHFHARAJ.DocumentCulture = 'en-us'	
		and VHFHAMJ.DocumentCulture = 'en-us'	--WDM 08.12.2014	
		and HA.DocumentCulture = 'en-us'	--WDM 08.12.2014		
		AND VHFHAA5.NodeGuid is not null		--ref: #47517

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
		, dbo.udf_StripHTML(VHFHAMJ.Title)
		, dbo.udf_StripHTML(left(VHFHAMJ.IntroText,4000)) AS IntroText
		, VHFHAMJ.NodeGuid
		, VHFHAMJ.Weight
		, VHFHAMJ.IsEnabled
		, VHFHAMJ.CodeName
       --,VHFHAMJ.NodeAliasPath
		, VHFHAMJ.DocumentPublishedVersionHistoryID
		, dbo.udf_StripHTML(VHFHARCJ.Title)
		, VHFHARCJ.Weight
		, VHFHARCJ.NodeGuid
		, VHFHARCJ.IsEnabled
		, VHFHARCJ.CodeName
       --,VHFHARCJ.NodeAliasPath
		, VHFHARCJ.DocumentPublishedVersionHistoryID
		, dbo.udf_StripHTML(VHFHARAJ.Title)
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
		, VHFHAA6.NodeGuid		--ref: #47517
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
		, HAMCQ.AllowMultiSelect
		, 'SID08' as LocID
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
		left outer join [View_HFit_HealthAssesmentMultipleChoiceQuestion_Joined] as HAMCQ 
			on VHFHAQ.Nodeguid = HAMCQ.Nodeguid
			AND HAMCQ.DocumentCulture = 'en-US'
where  VHFHAQ.DocumentCulture = 'en-us'	
		and (VHFHAA.DocumentCulture = 'en-us' OR VHFHAA.DocumentCulture is null)	--WDM 08.12.2014		
		and VHFHARCJ.DocumentCulture = 'en-us'	
		and VHFHARAJ.DocumentCulture = 'en-us'	
		and VHFHAMJ.DocumentCulture = 'en-us'	--WDM 08.12.2014	
		and HA.DocumentCulture = 'en-us'	--WDM 08.12.2014		
		AND VHFHAA6.NodeGuid is not null		--ref: #47517

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
		, dbo.udf_StripHTML(VHFHAMJ.Title)
		, dbo.udf_StripHTML(left(VHFHAMJ.IntroText,4000)) AS IntroText
		, VHFHAMJ.NodeGuid
		, VHFHAMJ.Weight
		, VHFHAMJ.IsEnabled
		, VHFHAMJ.CodeName
       --,VHFHAMJ.NodeAliasPath
		, VHFHAMJ.DocumentPublishedVersionHistoryID
		, dbo.udf_StripHTML(VHFHARCJ.Title)
		, VHFHARCJ.Weight
		, VHFHARCJ.NodeGuid
		, VHFHARCJ.IsEnabled
		, VHFHARCJ.CodeName
       --,VHFHARCJ.NodeAliasPath
		, VHFHARCJ.DocumentPublishedVersionHistoryID
		, dbo.udf_StripHTML(VHFHARAJ.Title)
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
		, VHFHAA9.NodeGuid		--ref: #47517
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
		, HAMCQ.AllowMultiSelect
		, 'SID09' as LocID
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
		left outer join [View_HFit_HealthAssesmentMultipleChoiceQuestion_Joined] as HAMCQ 
			on VHFHAQ.Nodeguid = HAMCQ.Nodeguid
			AND HAMCQ.DocumentCulture = 'en-US'
	where  VHFHAQ.DocumentCulture = 'en-us'	
		and (VHFHAA.DocumentCulture = 'en-us' OR VHFHAA.DocumentCulture is null)	--WDM 08.12.2014		
		and VHFHARCJ.DocumentCulture = 'en-us'	
		and VHFHARAJ.DocumentCulture = 'en-us'	
		and VHFHAMJ.DocumentCulture = 'en-us'	--WDM 08.12.2014	
		and HA.DocumentCulture = 'en-us'	--WDM 08.12.2014		
		AND VHFHAA9.NodeGuid is not null		--ref: #47517

GO

print ('Processed: view_EDW_HealthAssesmentDeffinition ') ;
go
  --  
  --  
GO 
print('***** FROM: view_EDW_HealthAssesmentDeffinition.sql'); 
GO 
print ('Processing: view_EDW_HealthAssesmentDeffinitionCustom ') ;
go



if exists(select TABLE_NAME from INFORMATION_SCHEMA.VIEWS where TABLE_NAME = 'view_EDW_HealthAssesmentDeffinitionCustom')
BEGIN
	drop view view_EDW_HealthAssesmentDeffinitionCustom ;
END
GO

--GRANT SELECT
--	ON [dbo].[view_EDW_HealthAssesmentDeffinitionCustom]
--	TO [EDWReader_PRD]
--GO

--***********************************************************************************************
-- 09.11.2014 : (wdm) Verified DATES to resolve EDW last mod date issue
--***********************************************************************************************
CREATE VIEW [dbo].[view_EDW_HealthAssesmentDeffinitionCustom]
AS
	--8/8/2014 - DocGUID changes, NodeGuid
	--8/8/2014 - Generated corrected view in DEV
	--8/10/2014 - added WHERE to limit to English language
	--09.11.2014 - WDM : Added date fields to facilitate Last Mod Date determination
	SELECT 
		cs.SiteGUID
		, HFA.AccountCD		--WDM 08.07.2014
		, HA.NodeID AS HANodeID		--WDM 08.07.2014
		, HA.NodeName AS HANodeName		--WDM 08.07.2014
		, HA.DocumentID AS HADocumentID		--WDM 08.07.2014
		, HA.NodeSiteID AS HANodeSiteID		--WDM 08.07.2014
		, HA.DocumentPublishedVersionHistoryID AS HADocPubVerID		--WDM 08.07.2014
		, VHFHAMJ.Title AS ModTitle
		--Per EDW Team, HTML text is truncated to 4000 bytes - we'll just do it here
		, dbo.udf_StripHTML(left(left(VHFHAMJ.IntroText,4000),4000)) AS IntroText
		, VHFHAMJ.DocumentGuid AS ModDocGuid	--, VHFHAMJ.DocumentID AS ModDocID	--WDM 08.07.2014
		, VHFHAMJ.Weight AS ModWeight
		, VHFHAMJ.IsEnabled AS ModIsEnabled
		, VHFHAMJ.CodeName AS ModCodeName
		, VHFHAMJ.DocumentPublishedVersionHistoryID AS ModDocPubVerID
		, VHFHARCJ.Title AS RCTitle
		, VHFHARCJ.Weight AS RCWeight
		, VHFHARCJ.DocumentGuid AS RCDocumentGUID	--, VHFHARCJ.DocumentID AS RCDocumentID	--WDM 08.07.2014
		, VHFHARCJ.IsEnabled AS RCIsEnabled
		, VHFHARCJ.CodeName AS RCCodeName
		, VHFHARCJ.DocumentPublishedVersionHistoryID AS RCDocPubVerID
		, VHFHARAJ.Title AS RATytle
		, VHFHARAJ.Weight AS RAWeight
		, VHFHARAJ.DocumentGuid AS RADocumentGuid	--, VHFHARAJ.DocumentID AS RADocumentID	--WDM 08.07.2014
		, VHFHARAJ.IsEnabled AS RAIsEnabled
		, VHFHARAJ.CodeName AS RACodeName
		, VHFHARAJ.ScoringStrategyID AS RAScoringStrategyID
		, VHFHARAJ.DocumentPublishedVersionHistoryID AS RADocPubVerID
		, VHFHAQ.QuestionType
		, dbo.udf_StripHTML(left(VHFHAQ.Title,4000)) AS QuesTitle
		, VHFHAQ.Weight AS QuesWeight
		, VHFHAQ.IsRequired AS QuesIsRequired

		, VHFHAQ.DocumentGuid AS QuesDocumentGuid	--, VHFHAQ.DocumentID AS QuesDocumentID	--WDM 08.07.2014
		
		, VHFHAQ.IsEnabled AS QuesIsEnabled
		, left(VHFHAQ.IsVisible,4000) AS QuesIsVisible
		, VHFHAQ.IsStaging AS QuesIsSTaging
		, VHFHAQ.CodeName AS QuestionCodeName
		, VHFHAQ.DocumentPublishedVersionHistoryID AS QuesDocPubVerID
		, VHFHAA.Value AS AnsValue
		, VHFHAA.Points AS AnsPoints
		
		, VHFHAA.DocumentGuid AS AnsDocumentGuid	--, VHFHAA.DocumentID AS AnsDocumentID	--WDM 08.07.2014
		
		, VHFHAA.IsEnabled AS AnsIsEnabled
		, VHFHAA.CodeName AS AnsCodeName
		, VHFHAA.UOM AS AnsUOM
		, VHFHAA.DocumentPublishedVersionHistoryID AS AnsDocPUbVerID
		, CASE	WHEN CAST(VCTJ.DocumentCreatedWhen AS DATE) = CAST(vctj.DocumentModifiedWhen AS DATE)
			THEN 'I'
			ELSE 'U'
		END AS ChangeType
		, VCTJ.DocumentCreatedWhen
		, VCTJ.DocumentModifiedWhen
		, VCTJ.NodeGuid as CmsTreeNodeGuid	--WDM 08.07.2014 ADDED TO the returned Columns
	 
		, CS.SiteLastModified
		, hfa.ItemModifiedWhen as Account_ItemModifiedWhen
		, c.DocumentModifiedWhen as Campaign_DocumentModifiedWhen
		, HA.DocumentModifiedWhen as Assessment_DocumentModifiedWhen
		, VHFHAMJ.DocumentModifiedWhen as Module_DocumentModifiedWhen
		, VHFHARCJ.DocumentModifiedWhen as RiskCategory_DocumentModifiedWhen
		, VHFHARAJ.DocumentModifiedWhen as RiskArea_DocumentModifiedWhen
		, VHFHAQ.DocumentModifiedWhen as Question_DocumentModifiedWhen
		, VHFHAA.DocumentModifiedWhen as Answer_DocumentModifiedWhen
FROM
		dbo.View_CMS_Tree_Joined AS VCTJ
		INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
		INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID
 
		--Campaign links Client which links to Assessment
		INNER JOIN dbo.View_HFit_HACampaign_Joined as c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID
 
		INNER JOIN View_HFit_HealthAssessment_Joined as HA WITH (NOLOCK) ON c.HealthAssessmentID = HA.DocumentID
		--WDM 08.07.2014
		INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ ON HA.NodeID = VHFHAMJ.NodeParentID		
		INNER JOIN dbo.View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
		INNER JOIN dbo.View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
		INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
		LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA ON VHFHAQ.NodeID = VHFHAA.NodeParentID
		where VCTJ.DocumentCulture = 'en-us'	--WDM 08.07.2014
				AND VHFHAMJ.NodeName = 'Custom'
UNION ALL
--WDM Retrieve Matrix Level 1 Question Group
	SELECT
		cs.SiteGUID
		, HFA.AccountCD
		, HA.NodeID		--WDM 08.07.2014
		, HA.NodeName		--WDM 08.07.2014
		, HA.DocumentID		--WDM 08.07.2014
		, HA.NodeSiteID		--WDM 08.07.2014
       --,VCTJ.NodeAliasPath
		, HA.DocumentPublishedVersionHistoryID		--WDM 08.07.2014
		, VHFHAMJ.Title
		, dbo.udf_StripHTML(left(left(VHFHAMJ.IntroText,4000),4000)) AS IntroText
		, VHFHAMJ.DocumentGUID
		, VHFHAMJ.Weight
		, VHFHAMJ.IsEnabled
		, VHFHAMJ.CodeName
       --,VHFHAMJ.NodeAliasPath
		, VHFHAMJ.DocumentPublishedVersionHistoryID
		, VHFHARCJ.Title
		, VHFHARCJ.Weight
		, VHFHARCJ.DocumentGUID
		, VHFHARCJ.IsEnabled
		, VHFHARCJ.CodeName
       --,VHFHARCJ.NodeAliasPath
		, VHFHARCJ.DocumentPublishedVersionHistoryID
		, VHFHARAJ.Title
		, VHFHARAJ.Weight
		, VHFHARAJ.DocumentGUID
		, VHFHARAJ.IsEnabled
		, VHFHARAJ.CodeName
       --,VHFHARAJ.NodeAliasPath
		, VHFHARAJ.ScoringStrategyID
		, VHFHARAJ.DocumentPublishedVersionHistoryID
		, VHFHAQ2.QuestionType
		, dbo.udf_StripHTML(left(VHFHAQ2.Title,4000)) AS QuesTitle
		, VHFHAQ2.Weight
		, VHFHAQ2.IsRequired
		, VHFHAQ2.DocumentGUID
		, VHFHAQ2.IsEnabled
		, left(VHFHAQ2.IsVisible,4000)
		, VHFHAQ2.IsStaging
		, VHFHAQ2.CodeName AS QuestionCodeName
       --,VHFHAQ2.NodeAliasPath
		, VHFHAQ2.DocumentPublishedVersionHistoryID
		, VHFHAA2.Value
		, VHFHAA2.Points
		, VHFHAA2.DocumentGUID
		, VHFHAA2.IsEnabled
		, VHFHAA2.CodeName
		, VHFHAA2.UOM
       --,VHFHAA2.NodeAliasPath
		, VHFHAA2.DocumentPublishedVersionHistoryID
		, CASE	WHEN CAST(VCTJ.DocumentCreatedWhen AS DATE) = CAST(vctj.DocumentModifiedWhen AS DATE)
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		, VCTJ.DocumentCreatedWhen
		, VCTJ.DocumentModifiedWhen
		, VCTJ.NodeGuid as CmsTreeNodeGuid	--WDM 08.07.2014
	 
		, CS.SiteLastModified
		, hfa.ItemModifiedWhen as Account_ItemModifiedWhen
		, c.DocumentModifiedWhen as Campaign_DocumentModifiedWhen
		, HA.DocumentModifiedWhen as Assessment_DocumentModifiedWhen
		, VHFHAMJ.DocumentModifiedWhen as Module_DocumentModifiedWhen
		, VHFHARCJ.DocumentModifiedWhen as RiskCategory_DocumentModifiedWhen
		, VHFHARAJ.DocumentModifiedWhen as RiskArea_DocumentModifiedWhen
		, VHFHAQ.DocumentModifiedWhen as Question_DocumentModifiedWhen
		, VHFHAA.DocumentModifiedWhen as Answer_DocumentModifiedWhen
FROM
  dbo.View_CMS_Tree_Joined AS VCTJ

 INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
 INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID
 INNER JOIN dbo.View_HFit_HACampaign_Joined c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID
 INNER JOIN View_HFit_HealthAssessment_Joined HA WITH (NOLOCK) ON c.HealthAssessmentID = HA.DocumentID
 INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ ON HA.NodeID = VHFHAMJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
 INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
 LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA ON VHFHAQ.NodeID = VHFHAA.NodeParentID
--matrix level 1 questiongroup
	INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
	INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID
where VCTJ.DocumentCulture = 'en-us'	--WDM 08.07.2014
				AND VHFHAMJ.NodeName = 'Custom'

UNION ALL
--WDM Retrieve Branching Level 1 Question and Matrix Level 1 Question Group
	SELECT
		cs.SiteGUID
		, HFA.AccountCD
		, HA.NodeID		--WDM 08.07.2014
		, HA.NodeName		--WDM 08.07.2014
		, HA.DocumentID		--WDM 08.07.2014
		, HA.NodeSiteID		--WDM 08.07.2014
       --,VCTJ.NodeAliasPath
		, HA.DocumentPublishedVersionHistoryID		--WDM 08.07.2014
		, VHFHAMJ.Title
		, dbo.udf_StripHTML(left(VHFHAMJ.IntroText,4000)) AS IntroText
		, VHFHAMJ.DocumentGUID
		, VHFHAMJ.Weight
		, VHFHAMJ.IsEnabled
		, VHFHAMJ.CodeName
       --,VHFHAMJ.NodeAliasPath
		, VHFHAMJ.DocumentPublishedVersionHistoryID
		, VHFHARCJ.Title
		, VHFHARCJ.Weight
		, VHFHARCJ.DocumentGUID
		, VHFHARCJ.IsEnabled
		, VHFHARCJ.CodeName
       --,VHFHARCJ.NodeAliasPath
		, VHFHARCJ.DocumentPublishedVersionHistoryID
		, VHFHARAJ.Title
		, VHFHARAJ.Weight
		, VHFHARAJ.DocumentGUID
		, VHFHARAJ.IsEnabled
		, VHFHARAJ.CodeName
       --,VHFHARAJ.NodeAliasPath
		, VHFHARAJ.ScoringStrategyID
		, VHFHARAJ.DocumentPublishedVersionHistoryID
		, VHFHAQ3.QuestionType
		, dbo.udf_StripHTML(left(VHFHAQ3.Title,4000)) AS QuesTitle
		, VHFHAQ3.Weight
		, VHFHAQ3.IsRequired
		, VHFHAQ3.DocumentGUID
		, VHFHAQ3.IsEnabled
		, left(VHFHAQ3.IsVisible,4000)
		, VHFHAQ3.IsStaging
		, VHFHAQ3.CodeName AS QuestionCodeName
       --,VHFHAQ3.NodeAliasPath
		, VHFHAQ3.DocumentPublishedVersionHistoryID
		, VHFHAA3.Value
		, VHFHAA3.Points
		, VHFHAA3.DocumentGUID
		, VHFHAA3.IsEnabled
		, VHFHAA3.CodeName
		, VHFHAA3.UOM
       --,VHFHAA3.NodeAliasPath
		, VHFHAA3.DocumentPublishedVersionHistoryID
		, CASE	WHEN CAST(VCTJ.DocumentCreatedWhen AS DATE) = CAST(vctj.DocumentModifiedWhen AS DATE)
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		, VCTJ.DocumentCreatedWhen
		, VCTJ.DocumentModifiedWhen
		, VCTJ.NodeGuid as CmsTreeNodeGuid	--WDM 08.07.2014
 
		, CS.SiteLastModified
		, hfa.ItemModifiedWhen as Account_ItemModifiedWhen
		, c.DocumentModifiedWhen as Campaign_DocumentModifiedWhen
		, HA.DocumentModifiedWhen as Assessment_DocumentModifiedWhen
		, VHFHAMJ.DocumentModifiedWhen as Module_DocumentModifiedWhen
		, VHFHARCJ.DocumentModifiedWhen as RiskCategory_DocumentModifiedWhen
		, VHFHARAJ.DocumentModifiedWhen as RiskArea_DocumentModifiedWhen
		, VHFHAQ.DocumentModifiedWhen as Question_DocumentModifiedWhen
		, VHFHAA.DocumentModifiedWhen as Answer_DocumentModifiedWhen
FROM
  dbo.View_CMS_Tree_Joined AS VCTJ

 INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
 INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID
 INNER JOIN dbo.View_HFit_HACampaign_Joined c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID
 INNER JOIN View_HFit_HealthAssessment_Joined HA WITH (NOLOCK) ON c.HealthAssessmentID = HA.DocumentID
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
where VCTJ.DocumentCulture = 'en-us'	--WDM 08.07.2014
				AND VHFHAMJ.NodeName = 'Custom'

UNION ALL
--WDM Retrieve Branching Level 1 Question and Matrix Level 2 Question Group
	SELECT
		cs.SiteGUID
		, HFA.AccountCD
		, HA.NodeID		--WDM 08.07.2014
		, HA.NodeName		--WDM 08.07.2014
		, HA.DocumentID		--WDM 08.07.2014
		, HA.NodeSiteID		--WDM 08.07.2014
       --,VCTJ.NodeAliasPath
		, HA.DocumentPublishedVersionHistoryID		--WDM 08.07.2014
		, VHFHAMJ.Title
		, dbo.udf_StripHTML(left(VHFHAMJ.IntroText,4000)) AS IntroText
		, VHFHAMJ.DocumentGUID
		, VHFHAMJ.Weight
		, VHFHAMJ.IsEnabled
		, VHFHAMJ.CodeName
       --,VHFHAMJ.NodeAliasPath
		, VHFHAMJ.DocumentPublishedVersionHistoryID
		, VHFHARCJ.Title
		, VHFHARCJ.Weight
		, VHFHARCJ.DocumentGUID
		, VHFHARCJ.IsEnabled
		, VHFHARCJ.CodeName
       --,VHFHARCJ.NodeAliasPath
		, VHFHARCJ.DocumentPublishedVersionHistoryID
		, VHFHARAJ.Title
		, VHFHARAJ.Weight
		, VHFHARAJ.DocumentGUID
		, VHFHARAJ.IsEnabled
		, VHFHARAJ.CodeName
       --,VHFHARAJ.NodeAliasPath
		, VHFHARAJ.ScoringStrategyID
		, VHFHARAJ.DocumentPublishedVersionHistoryID
		, VHFHAQ7.QuestionType
		, dbo.udf_StripHTML(left(VHFHAQ7.Title,4000)) AS QuesTitle
		, VHFHAQ7.Weight
		, VHFHAQ7.IsRequired
		, VHFHAQ7.DocumentGUID
		, VHFHAQ7.IsEnabled
		, left(VHFHAQ7.IsVisible,4000)
		, VHFHAQ7.IsStaging
		, VHFHAQ7.CodeName AS QuestionCodeName
       --,VHFHAQ7.NodeAliasPath
		, VHFHAQ7.DocumentPublishedVersionHistoryID
		, VHFHAA7.Value
		, VHFHAA7.Points
		, VHFHAA7.DocumentGUID
		, VHFHAA7.IsEnabled
		, VHFHAA7.CodeName
		, VHFHAA7.UOM
       --,VHFHAA7.NodeAliasPath
		, VHFHAA7.DocumentPublishedVersionHistoryID
		, CASE	WHEN CAST(VCTJ.DocumentCreatedWhen AS DATE) = CAST(vctj.DocumentModifiedWhen AS DATE)
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		, VCTJ.DocumentCreatedWhen
		, VCTJ.DocumentModifiedWhen
		, VCTJ.NodeGuid as CmsTreeNodeGuid	--WDM 08.07.2014
 
		, CS.SiteLastModified
		, hfa.ItemModifiedWhen as Account_ItemModifiedWhen
		, c.DocumentModifiedWhen as Campaign_DocumentModifiedWhen
		, HA.DocumentModifiedWhen as Assessment_DocumentModifiedWhen
		, VHFHAMJ.DocumentModifiedWhen as Module_DocumentModifiedWhen
		, VHFHARCJ.DocumentModifiedWhen as RiskCategory_DocumentModifiedWhen
		, VHFHARAJ.DocumentModifiedWhen as RiskArea_DocumentModifiedWhen
		, VHFHAQ.DocumentModifiedWhen as Question_DocumentModifiedWhen
		, VHFHAA.DocumentModifiedWhen as Answer_DocumentModifiedWhen
FROM
 dbo.View_CMS_Tree_Joined AS VCTJ
 INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
 INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID
 INNER JOIN dbo.View_HFit_HACampaign_Joined c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID
 INNER JOIN View_HFit_HealthAssessment_Joined HA WITH (NOLOCK) ON c.HealthAssessmentID = HA.DocumentID
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
where VCTJ.DocumentCulture = 'en-us'	--WDM 08.07.2014
				AND VHFHAMJ.NodeName = 'Custom'

UNION ALL
	--****************************************************
	--WDM 6/25/2014 Retrieve the Branching level 1 Question Group
	--THE PROBLEM LIES HERE in this part of query : 1:40 minute
	-- Added two perf indexes to the first query: 25 Sec
	--****************************************************
	SELECT
		cs.SiteGUID
		, HFA.AccountCD
		, HA.NodeID		--WDM 08.07.2014
		, HA.NodeName		--WDM 08.07.2014
		, HA.DocumentID		--WDM 08.07.2014
		, HA.NodeSiteID		--WDM 08.07.2014
       --,VCTJ.NodeAliasPath
		, HA.DocumentPublishedVersionHistoryID		--WDM 08.07.2014
		, VHFHAMJ.Title
		, dbo.udf_StripHTML(left(VHFHAMJ.IntroText,4000)) AS IntroText
		, VHFHAMJ.DocumentGUID
		, VHFHAMJ.Weight
		, VHFHAMJ.IsEnabled
		, VHFHAMJ.CodeName
       --,VHFHAMJ.NodeAliasPath
		, VHFHAMJ.DocumentPublishedVersionHistoryID
		, VHFHARCJ.Title
		, VHFHARCJ.Weight
		, VHFHARCJ.DocumentGUID
		, VHFHARCJ.IsEnabled
		, VHFHARCJ.CodeName
       --,VHFHARCJ.NodeAliasPath
		, VHFHARCJ.DocumentPublishedVersionHistoryID
		, VHFHARAJ.Title
		, VHFHARAJ.Weight
		, VHFHARAJ.DocumentGUID
		, VHFHARAJ.IsEnabled
		, VHFHARAJ.CodeName
       --,VHFHARAJ.NodeAliasPath
		, VHFHARAJ.ScoringStrategyID
		, VHFHARAJ.DocumentPublishedVersionHistoryID
		, VHFHAQ8.QuestionType
		, dbo.udf_StripHTML(left(VHFHAQ8.Title,4000)) AS QuesTitle
		, VHFHAQ8.Weight
		, VHFHAQ8.IsRequired
		, VHFHAQ8.DocumentGUID
		, VHFHAQ8.IsEnabled
		, left(VHFHAQ8.IsVisible,4000)
		, VHFHAQ8.IsStaging
		, VHFHAQ8.CodeName AS QuestionCodeName
       --,VHFHAQ8.NodeAliasPath
		, VHFHAQ8.DocumentPublishedVersionHistoryID
		, VHFHAA8.Value
		, VHFHAA8.Points
		, VHFHAA8.DocumentGUID
		, VHFHAA8.IsEnabled
		, VHFHAA8.CodeName
		, VHFHAA8.UOM
       --,VHFHAA8.NodeAliasPath
		, VHFHAA8.DocumentPublishedVersionHistoryID
		, CASE	WHEN CAST(VCTJ.DocumentCreatedWhen AS DATE) = CAST(vctj.DocumentModifiedWhen AS DATE)
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		, VCTJ.DocumentCreatedWhen
		, VCTJ.DocumentModifiedWhen
		, VCTJ.NodeGuid as CmsTreeNodeGuid	--WDM 08.07.2014
	
		, CS.SiteLastModified
		, hfa.ItemModifiedWhen as Account_ItemModifiedWhen
		, c.DocumentModifiedWhen as Campaign_DocumentModifiedWhen
		, HA.DocumentModifiedWhen as Assessment_DocumentModifiedWhen
		, VHFHAMJ.DocumentModifiedWhen as Module_DocumentModifiedWhen
		, VHFHARCJ.DocumentModifiedWhen as RiskCategory_DocumentModifiedWhen
		, VHFHARAJ.DocumentModifiedWhen as RiskArea_DocumentModifiedWhen
		, VHFHAQ.DocumentModifiedWhen as Question_DocumentModifiedWhen
		, VHFHAA.DocumentModifiedWhen as Answer_DocumentModifiedWhen
FROM
  dbo.View_CMS_Tree_Joined AS VCTJ

 INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
 INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID
 INNER JOIN dbo.View_HFit_HACampaign_Joined c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID
 INNER JOIN View_HFit_HealthAssessment_Joined HA WITH (NOLOCK) ON c.HealthAssessmentID = HA.DocumentID
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
where VCTJ.DocumentCulture = 'en-us'	--WDM 08.07.2014
				AND VHFHAMJ.NodeName = 'Custom'

UNION ALL
	--****************************************************
	--WDM 6/25/2014 Retrieve the Branching level 2 Question Group
	--THE PROBLEM LIES HERE in this part of query : 1:48  minutes
	--With the new indexes: 29 Secs
	--****************************************************
	SELECT
		cs.SiteGUID
		, HFA.AccountCD
		, HA.NodeID		--WDM 08.07.2014
		, HA.NodeName		--WDM 08.07.2014
		, HA.DocumentID		--WDM 08.07.2014
		, HA.NodeSiteID		--WDM 08.07.2014
       --,VCTJ.NodeAliasPath
		, HA.DocumentPublishedVersionHistoryID		--WDM 08.07.2014
		, VHFHAMJ.Title
		, dbo.udf_StripHTML(left(VHFHAMJ.IntroText,4000)) AS IntroText
		, VHFHAMJ.DocumentGUID
		, VHFHAMJ.Weight
		, VHFHAMJ.IsEnabled
		, VHFHAMJ.CodeName
       --,VHFHAMJ.NodeAliasPath
		, VHFHAMJ.DocumentPublishedVersionHistoryID
		, VHFHARCJ.Title
		, VHFHARCJ.Weight
		, VHFHARCJ.DocumentGUID
		, VHFHARCJ.IsEnabled
		, VHFHARCJ.CodeName
       --,VHFHARCJ.NodeAliasPath
		, VHFHARCJ.DocumentPublishedVersionHistoryID
		, VHFHARAJ.Title
		, VHFHARAJ.Weight
		, VHFHARAJ.DocumentGUID
		, VHFHARAJ.IsEnabled
		, VHFHARAJ.CodeName
       --,VHFHARAJ.NodeAliasPath
		, VHFHARAJ.ScoringStrategyID
		, VHFHARAJ.DocumentPublishedVersionHistoryID
		, VHFHAQ4.QuestionType
		, dbo.udf_StripHTML(left(VHFHAQ4.Title,4000)) AS QuesTitle
		, VHFHAQ4.Weight
		, VHFHAQ4.IsRequired
		, VHFHAQ4.DocumentGUID
		, VHFHAQ4.IsEnabled
		, left(VHFHAQ4.IsVisible,4000)
		, VHFHAQ4.IsStaging
		, VHFHAQ4.CodeName AS QuestionCodeName
       --,VHFHAQ4.NodeAliasPath
		, VHFHAQ4.DocumentPublishedVersionHistoryID
		, VHFHAA4.Value
		, VHFHAA4.Points
		, VHFHAA4.DocumentGUID
		, VHFHAA4.IsEnabled
		, VHFHAA4.CodeName
		, VHFHAA4.UOM
       --,VHFHAA4.NodeAliasPath
		, VHFHAA4.DocumentPublishedVersionHistoryID
		, CASE	WHEN CAST(VCTJ.DocumentCreatedWhen AS DATE) = CAST(vctj.DocumentModifiedWhen AS DATE)
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		, VCTJ.DocumentCreatedWhen
		, VCTJ.DocumentModifiedWhen
		, VCTJ.NodeGuid as CmsTreeNodeGuid	--WDM 08.07.2014
 
		, CS.SiteLastModified
		, hfa.ItemModifiedWhen as Account_ItemModifiedWhen
		, c.DocumentModifiedWhen as Campaign_DocumentModifiedWhen
		, HA.DocumentModifiedWhen as Assessment_DocumentModifiedWhen
		, VHFHAMJ.DocumentModifiedWhen as Module_DocumentModifiedWhen
		, VHFHARCJ.DocumentModifiedWhen as RiskCategory_DocumentModifiedWhen
		, VHFHARAJ.DocumentModifiedWhen as RiskArea_DocumentModifiedWhen
		, VHFHAQ.DocumentModifiedWhen as Question_DocumentModifiedWhen
		, VHFHAA.DocumentModifiedWhen as Answer_DocumentModifiedWhen
FROM
  dbo.View_CMS_Tree_Joined AS VCTJ

 INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
 INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID
 INNER JOIN dbo.View_HFit_HACampaign_Joined c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID
 INNER JOIN View_HFit_HealthAssessment_Joined HA WITH (NOLOCK) ON c.HealthAssessmentID = HA.DocumentID
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
where VCTJ.DocumentCulture = 'en-us'	--WDM 08.07.2014
				AND VHFHAMJ.NodeName = 'Custom'

UNION ALL
--WDM 6/25/2014 Retrieve the Branching level 3 Question Group
	SELECT
		cs.SiteGUID
		, HFA.AccountCD
		, HA.NodeID		--WDM 08.07.2014
		, HA.NodeName		--WDM 08.07.2014
		, HA.DocumentID		--WDM 08.07.2014
		, HA.NodeSiteID		--WDM 08.07.2014
       --,VCTJ.NodeAliasPath
		, HA.DocumentPublishedVersionHistoryID		--WDM 08.07.2014
		, VHFHAMJ.Title
		, dbo.udf_StripHTML(left(VHFHAMJ.IntroText,4000)) AS IntroText
		, VHFHAMJ.DocumentGUID
		, VHFHAMJ.Weight
		, VHFHAMJ.IsEnabled
		, VHFHAMJ.CodeName
       --,VHFHAMJ.NodeAliasPath
		, VHFHAMJ.DocumentPublishedVersionHistoryID
		, VHFHARCJ.Title
		, VHFHARCJ.Weight
		, VHFHARCJ.DocumentGUID
		, VHFHARCJ.IsEnabled
		, VHFHARCJ.CodeName
       --,VHFHARCJ.NodeAliasPath
		, VHFHARCJ.DocumentPublishedVersionHistoryID
		, VHFHARAJ.Title
		, VHFHARAJ.Weight
		, VHFHARAJ.DocumentGUID
		, VHFHARAJ.IsEnabled
		, VHFHARAJ.CodeName
       --,VHFHARAJ.NodeAliasPath
		, VHFHARAJ.ScoringStrategyID
		, VHFHARAJ.DocumentPublishedVersionHistoryID
		, VHFHAQ5.QuestionType
		, dbo.udf_StripHTML(left(VHFHAQ5.Title,4000)) AS QuesTitle
		, VHFHAQ5.Weight
		, VHFHAQ5.IsRequired
		, VHFHAQ5.DocumentGUID
		, VHFHAQ5.IsEnabled
		, left(VHFHAQ5.IsVisible,4000)
		, VHFHAQ5.IsStaging
		, VHFHAQ5.CodeName AS QuestionCodeName
       --,VHFHAQ5.NodeAliasPath
		, VHFHAQ5.DocumentPublishedVersionHistoryID
		, VHFHAA5.Value
		, VHFHAA5.Points
		, VHFHAA5.DocumentGUID
		, VHFHAA5.IsEnabled
		, VHFHAA5.CodeName
		, VHFHAA5.UOM
       --,VHFHAA5.NodeAliasPath
		, VHFHAA5.DocumentPublishedVersionHistoryID
		, CASE	WHEN CAST(VCTJ.DocumentCreatedWhen AS DATE) = CAST(vctj.DocumentModifiedWhen AS DATE)
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		, VCTJ.DocumentCreatedWhen
		, VCTJ.DocumentModifiedWhen
		, VCTJ.NodeGuid as CmsTreeNodeGuid	--WDM 08.07.2014
 
		, CS.SiteLastModified
		, hfa.ItemModifiedWhen as Account_ItemModifiedWhen
		, c.DocumentModifiedWhen as Campaign_DocumentModifiedWhen
		, HA.DocumentModifiedWhen as Assessment_DocumentModifiedWhen
		, VHFHAMJ.DocumentModifiedWhen as Module_DocumentModifiedWhen
		, VHFHARCJ.DocumentModifiedWhen as RiskCategory_DocumentModifiedWhen
		, VHFHARAJ.DocumentModifiedWhen as RiskArea_DocumentModifiedWhen
		, VHFHAQ.DocumentModifiedWhen as Question_DocumentModifiedWhen
		, VHFHAA.DocumentModifiedWhen as Answer_DocumentModifiedWhen
FROM
  dbo.View_CMS_Tree_Joined AS VCTJ

 INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
 INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID
 INNER JOIN dbo.View_HFit_HACampaign_Joined c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID
 INNER JOIN View_HFit_HealthAssessment_Joined HA WITH (NOLOCK) ON c.HealthAssessmentID = HA.DocumentID
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
where VCTJ.DocumentCulture = 'en-us'	--WDM 08.07.2014
				AND VHFHAMJ.NodeName = 'Custom'

UNION ALL
--WDM 6/25/2014 Retrieve the Branching level 4 Question Group
	SELECT
		cs.SiteGUID
		, HFA.AccountCD
		, HA.NodeID		--WDM 08.07.2014
		, HA.NodeName		--WDM 08.07.2014
		, HA.DocumentID		--WDM 08.07.2014
		, HA.NodeSiteID		--WDM 08.07.2014
       --,VCTJ.NodeAliasPath
		, HA.DocumentPublishedVersionHistoryID		--WDM 08.07.2014
		, VHFHAMJ.Title
		, dbo.udf_StripHTML(left(VHFHAMJ.IntroText,4000)) AS IntroText
		, VHFHAMJ.DocumentGUID
		, VHFHAMJ.Weight
		, VHFHAMJ.IsEnabled
		, VHFHAMJ.CodeName
       --,VHFHAMJ.NodeAliasPath
		, VHFHAMJ.DocumentPublishedVersionHistoryID
		, VHFHARCJ.Title
		, VHFHARCJ.Weight
		, VHFHARCJ.DocumentGUID
		, VHFHARCJ.IsEnabled
		, VHFHARCJ.CodeName
       --,VHFHARCJ.NodeAliasPath
		, VHFHARCJ.DocumentPublishedVersionHistoryID
		, VHFHARAJ.Title
		, VHFHARAJ.Weight
		, VHFHARAJ.DocumentGUID
		, VHFHARAJ.IsEnabled
		, VHFHARAJ.CodeName
       --,VHFHARAJ.NodeAliasPath
		, VHFHARAJ.ScoringStrategyID
		, VHFHARAJ.DocumentPublishedVersionHistoryID
		, VHFHAQ6.QuestionType
		, dbo.udf_StripHTML(left(VHFHAQ6.Title,4000)) AS QuesTitle
		, VHFHAQ6.Weight
		, VHFHAQ6.IsRequired
		, VHFHAQ6.DocumentGUID
		, VHFHAQ6.IsEnabled
		, left(VHFHAQ6.IsVisible,4000)
		, VHFHAQ6.IsStaging
		, VHFHAQ6.CodeName AS QuestionCodeName
       --,VHFHAQ6.NodeAliasPath
		, VHFHAQ6.DocumentPublishedVersionHistoryID
		, VHFHAA6.Value
		, VHFHAA6.Points
		, VHFHAA6.DocumentGUID
		, VHFHAA6.IsEnabled
		, VHFHAA6.CodeName
		, VHFHAA6.UOM
       --,VHFHAA6.NodeAliasPath
		, VHFHAA6.DocumentPublishedVersionHistoryID
		, CASE	WHEN CAST(VCTJ.DocumentCreatedWhen AS DATE) = CAST(vctj.DocumentModifiedWhen AS DATE)
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		, VCTJ.DocumentCreatedWhen
		, VCTJ.DocumentModifiedWhen
		, VCTJ.NodeGuid as CmsTreeNodeGuid	--WDM 08.07.2014
 
		, CS.SiteLastModified
		, hfa.ItemModifiedWhen as Account_ItemModifiedWhen
		, c.DocumentModifiedWhen as Campaign_DocumentModifiedWhen
		, HA.DocumentModifiedWhen as Assessment_DocumentModifiedWhen
		, VHFHAMJ.DocumentModifiedWhen as Module_DocumentModifiedWhen
		, VHFHARCJ.DocumentModifiedWhen as RiskCategory_DocumentModifiedWhen
		, VHFHARAJ.DocumentModifiedWhen as RiskArea_DocumentModifiedWhen
		, VHFHAQ.DocumentModifiedWhen as Question_DocumentModifiedWhen
		, VHFHAA.DocumentModifiedWhen as Answer_DocumentModifiedWhen
FROM
  dbo.View_CMS_Tree_Joined AS VCTJ

 INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
 INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID
 INNER JOIN dbo.View_HFit_HACampaign_Joined c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID
 INNER JOIN View_HFit_HealthAssessment_Joined HA WITH (NOLOCK) ON c.HealthAssessmentID = HA.DocumentID
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
where VCTJ.DocumentCulture = 'en-us'	--WDM 08.07.2014
				AND VHFHAMJ.NodeName = 'Custom'

UNION ALL
	--WDM 6/25/2014 Retrieve the Branching level 5 Question Group
	SELECT
		cs.SiteGUID
		, HFA.AccountCD
		, HA.NodeID		--WDM 08.07.2014
		, HA.NodeName		--WDM 08.07.2014
		, HA.DocumentID		--WDM 08.07.2014
		, HA.NodeSiteID		--WDM 08.07.2014
       --,VCTJ.NodeAliasPath
		, HA.DocumentPublishedVersionHistoryID		--WDM 08.07.2014
		, VHFHAMJ.Title
		, dbo.udf_StripHTML(left(VHFHAMJ.IntroText,4000)) AS IntroText
		, VHFHAMJ.DocumentGUID
		, VHFHAMJ.Weight
		, VHFHAMJ.IsEnabled
		, VHFHAMJ.CodeName
       --,VHFHAMJ.NodeAliasPath
		, VHFHAMJ.DocumentPublishedVersionHistoryID
		, VHFHARCJ.Title
		, VHFHARCJ.Weight
		, VHFHARCJ.DocumentGUID
		, VHFHARCJ.IsEnabled
		, VHFHARCJ.CodeName
       --,VHFHARCJ.NodeAliasPath
		, VHFHARCJ.DocumentPublishedVersionHistoryID
		, VHFHARAJ.Title
		, VHFHARAJ.Weight
		, VHFHARAJ.DocumentGUID
		, VHFHARAJ.IsEnabled
		, VHFHARAJ.CodeName
       --,VHFHARAJ.NodeAliasPath
		, VHFHARAJ.ScoringStrategyID
		, VHFHARAJ.DocumentPublishedVersionHistoryID
		, VHFHAQ9.QuestionType
		, dbo.udf_StripHTML(left(VHFHAQ9.Title,4000)) AS QuesTitle
		, VHFHAQ9.Weight
		, VHFHAQ9.IsRequired
		, VHFHAQ9.DocumentGUID
		, VHFHAQ9.IsEnabled
		, left(VHFHAQ9.IsVisible,4000)
		, VHFHAQ9.IsStaging
		, VHFHAQ9.CodeName AS QuestionCodeName
       --,VHFHAQ9.NodeAliasPath
		, VHFHAQ9.DocumentPublishedVersionHistoryID
		, VHFHAA9.Value
		, VHFHAA9.Points
		, VHFHAA9.DocumentGUID
		, VHFHAA9.IsEnabled
		, VHFHAA9.CodeName
		, VHFHAA9.UOM
       --,VHFHAA9.NodeAliasPath
		, VHFHAA9.DocumentPublishedVersionHistoryID
		, CASE	WHEN CAST(VCTJ.DocumentCreatedWhen AS DATE) = CAST(vctj.DocumentModifiedWhen AS DATE)
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		, VCTJ.DocumentCreatedWhen
		, VCTJ.DocumentModifiedWhen
		, VCTJ.NodeGuid as CmsTreeNodeGuid	--WDM 08.07.2014
 
		, CS.SiteLastModified
		, hfa.ItemModifiedWhen as Account_ItemModifiedWhen
		, c.DocumentModifiedWhen as Campaign_DocumentModifiedWhen
		, HA.DocumentModifiedWhen as Assessment_DocumentModifiedWhen
		, VHFHAMJ.DocumentModifiedWhen as Module_DocumentModifiedWhen
		, VHFHARCJ.DocumentModifiedWhen as RiskCategory_DocumentModifiedWhen
		, VHFHARAJ.DocumentModifiedWhen as RiskArea_DocumentModifiedWhen
		, VHFHAQ.DocumentModifiedWhen as Question_DocumentModifiedWhen
		, VHFHAA.DocumentModifiedWhen as Answer_DocumentModifiedWhen
FROM
  dbo.View_CMS_Tree_Joined AS VCTJ

 INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
 INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID
 INNER JOIN dbo.View_HFit_HACampaign_Joined c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID
 INNER JOIN View_HFit_HealthAssessment_Joined HA WITH (NOLOCK) ON c.HealthAssessmentID = HA.DocumentID
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
where VCTJ.DocumentCulture = 'en-us'	--WDM 08.07.2014
				AND VHFHAMJ.NodeName = 'Custom'




GO


  --  
  --  
GO 
print('***** FROM: view_EDW_HealthAssesmentDeffinitionCustom.sql'); 
GO 
print ('Processing: view_EDW_Participant ') ;
go


if exists(select TABLE_NAME from INFORMATION_SCHEMA.VIEWS where TABLE_NAME = 'view_EDW_Participant')
BEGIN
	drop view view_EDW_Participant ;
END
GO


--*********************************************************************************************
--WDM Reviewed 8/6/2014 for needed updates, none required
--09.11.2014 (wdm) added date fields to facilitate EDW determination of last mod date 
--*********************************************************************************************
create VIEW [dbo].[view_EDW_Participant]
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
		, cus.HFitUserPreferredMailingState
		, cus.HFitUserPreferredMailingPostalCode
		, cus.HFitCoachingEnrollDate
		, cus.HFitUserAltPreferredPhone
		, cus.HFitUserAltPreferredPhoneExt
		, cus.HFitUserAltPreferredPhoneType
		, cus.HFitUserPreferredPhone
		, cus.HFitUserPreferredFirstName
		, CASE	WHEN CAST(cu.UserCreated AS DATE) = CAST(cu.UserLastModified AS DATE)
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		, cu.UserCreated
		, cu.UserLastModified
		, HFA.ItemModifiedWhen as Account_ItemModifiedWhen	--wdm: 09.11.2014 added to view
	FROM
		dbo.CMS_User AS CU
	INNER JOIN dbo.CMS_UserSite AS CUS2 WITH ( NOLOCK ) ON CU.UserID = CUS2.UserID
	INNER JOIN dbo.HFit_Account AS HFA WITH ( NOLOCK ) ON cus2.SiteID = hfa.SiteID
	INNER JOIN dbo.CMS_Site AS CS WITH ( NOLOCK ) ON CUS2.SiteID = CS.SiteID
	INNER JOIN dbo.CMS_UserSettings AS CUS WITH ( NOLOCK ) ON CU.UserID = CUS.UserSettingsUserID







GO


  --  
  --  
GO 
print('***** FROM: view_EDW_Participant.sql'); 
GO 

GO
PRINT 'Processing: view_EDW_RewardAwardDetail ';
GO

IF EXISTS (SELECT [TABLE_NAME]
		   FROM [INFORMATION_SCHEMA].[VIEWS]
		   WHERE [TABLE_NAME] = 'view_EDW_RewardAwardDetail') 
    BEGIN
	   DROP VIEW [view_EDW_RewardAwardDetail];
    END;
GO

CREATE VIEW [dbo].[view_EDW_RewardAwardDetail]
AS
--*************************************************************************************************
--WDM Reviewed 8/6/2014 for needed updates, none required
--09.11.2014 : (wdm) reviewed for EDW last mod date and the view is OK as is
--11.19.2014 : added language to verify returned data
--02.03.2015 : LevelName, LevelHeader, GroupHeadingText, GroupHeadingDescription
--*************************************************************************************************
SELECT DISTINCT
[cu].[UserGUID]
, [cs].[SiteGUID]
, [cus].[HFitUserMpiNumber]
, [RL_Joined].[RewardLevelID]
, [HFRAUD].[AwardDisplayName]
, [HFRAUD].[RewardValue]
, [HFRAUD].[ThresholdNumber]
, [HFRAUD].[UserNotified]
, [HFRAUD].[IsFulfilled]
, [hfa].[AccountID]
, [HFA].[AccountCD]
, CASE
	 WHEN CAST ([HFRAUD].[ItemCreatedWhen] AS date) = CAST ([HFRAUD].[ItemModifiedWhen] AS date) 
	 THEN 'I'
	 ELSE 'U'
  END AS [ChangeType]
, [HFRAUD].[ItemCreatedWhen]
, [HFRAUD].[ItemModifiedWhen]
, [RL_Joined].[DocumentCulture]
, [HFRAUD].[CultureCode]

, [RL_Joined].[LevelName]
, [RL_Joined].[LevelHeader]
, [RL_Joined].[GroupHeadingText]
, [RL_Joined].[GroupHeadingDescription]
  FROM
	  [dbo].[HFit_RewardsAwardUserDetail] AS [HFRAUD]  
		 INNER JOIN [dbo].[View_HFit_RewardLevel_Joined] AS [RL_Joined]  
			ON [hfraud].[RewardLevelNodeId] = [RL_Joined].[NodeID]
		    AND [RL_Joined].[DocumentCulture] = 'en-US'
		    AND [HFRAUD].[CultureCode] = 'en-US'
		 INNER JOIN [dbo].[CMS_User] AS [CU]  
			ON [hfraud].[UserId] = [cu].[UserID]
		 INNER JOIN [dbo].[CMS_UserSite] AS [CUS2]  
			ON [cu].[UserID] = [cus2].[UserID]
		 INNER JOIN [dbo].[HFit_Account] AS [HFA]  
			ON [cus2].[SiteID] = [HFA].[SiteID]
		 INNER JOIN [dbo].[CMS_Site] AS [CS]  
			ON [CUS2].[SiteID] = [CS].[SiteID]
		 INNER JOIN [dbo].[CMS_UserSettings] AS [CUS]  
			ON [cu].[UserID] = [cus].[UserSettingsUserID];

GO

PRINT 'Processed: view_EDW_RewardAwardDetail ';

--  
--  
GO
PRINT '***** FROM: view_EDW_RewardAwardDetail.sql';
GO 
PRINT 'Processing: view_EDW_RewardsDefinition:';
GO
IF EXISTS (SELECT
				  NAME
			 FROM sys.VIEWS
			 WHERE NAME = 'view_EDW_RewardsDefinition') 
	BEGIN
		DROP VIEW
			 view_EDW_RewardsDefinition;
	END;
GO

--select RewardActivityID,* from View_HFit_RewardActivity_Joined
--GRANT SELECT
--	ON [dbo].[view_EDW_RewardsDefinition]
--	TO [EDWReader_PRD]
--GO

--select top 100 * from view_EDW_RewardsDefinition

CREATE VIEW dbo.view_EDW_RewardsDefinition
AS

	 --****************************************************************************************************************************************************
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
	 --12.31.2014 (WDM) added left outer join HFit_LKP_RewardActivity AND VHFRAJ.RewardActivityLKPName to the view reference CR-47520
	 --01.01.2014 (WDM) tested changes for CR-47520
	 --02.16.2015 (WDM) Requested by John C. added as all required is a reference to the name
	 --		    ,[LevelName]
	 --			,[LevelHeader]
	 --		    ,[GroupHeadingText]
	 --		    ,[GroupHeadingDescription]
	 --****************************************************************************************************************************************************

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
		  , Level
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
		  , LKPRA.RewardActivityLKPName
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
		  , CASE
			WHEN CAST (VHFRPJ.DocumentCreatedWhen AS date) = CAST (VHFRPJ.DocumentModifiedWhen AS date) 
			THEN 'I'
			ELSE 'U'
			END AS ChangeType
		  , VHFRPJ.DocumentGuid

			--WDM Added 8/7/2014 in case needed

		  , VHFRPJ.DocumentCreatedWhen
		  , VHFRPJ.DocumentModifiedWhen
		  , VHFRAJ.DocumentModifiedWhen AS RewardActivity_DocumentModifiedWhen

			--09.11.2014 : Added to facilitate EDW Last Mod Date determination

		  , VHFRAJ.DocumentCulture AS DocumentCulture_VHFRAJ
		  , VHFRPJ.DocumentCulture AS DocumentCulture_VHFRPJ
		  , VHFRGJ.DocumentCulture AS DocumentCulture_VHFRGJ
		  , VHFRLJ.DocumentCulture AS DocumentCulture_VHFRLJ
		  , VHFRTPJ.DocumentCulture AS DocumentCulture_VHFRTPJ
		  , LevelName
		  , LevelHeader
		  , GroupHeadingText
		  , GroupHeadingDescription
	   FROM dbo.View_EDW_RewardProgram_Joined AS VHFRPJ
				INNER JOIN dbo.View_HFit_RewardGroup_Joined AS VHFRGJ
					ON VHFRPJ.NodeID = VHFRGJ.NodeParentID
				   AND VHFRPJ.DocumentCulture = 'en-US'
				   AND VHFRGJ.DocumentCulture = 'en-US'
				INNER JOIN dbo.View_HFit_RewardLevel_Joined AS VHFRLJ
					ON VHFRGJ.NodeID = VHFRLJ.NodeParentID
				   AND VHFRLJ.DocumentCulture = 'en-US'
				INNER JOIN dbo.HFit_LKP_RewardLevelType AS HFLRLT
					ON VHFRLJ.LevelType = HFLRLT.RewardLevelTypeLKPID
				INNER JOIN dbo.View_HFit_RewardActivity_Joined AS VHFRAJ
					ON VHFRLJ.NodeID = VHFRAJ.NodeParentID
				   AND VHFRAJ.DocumentCulture = 'en-US'
				LEFT OUTER JOIN HFit_LKP_RewardActivity AS LKPRA
					ON LKPRA.RewardActivityLKPID = VHFRAJ.RewardActivityLKPID

	 --Added 1.2.2015 for SR-47520

				INNER JOIN dbo.View_HFit_RewardTrigger_Joined AS VHFRTJ
					ON VHFRAJ.NodeID = VHFRTJ.NodeParentID
				   AND VHFRTJ.DocumentCulture = 'en-US'
				INNER JOIN dbo.View_HFit_RewardTriggerParameter_Joined AS VHFRTPJ
					ON vhfrtj.nodeid = vhfrtpj.nodeparentid
				   AND VHFRTPJ.DocumentCulture = 'en-US'
				INNER JOIN dbo.HFit_LKP_RewardTrigger AS HFLRT
					ON VHFRTJ.RewardTriggerLKPID = HFLRT.RewardTriggerLKPID
				INNER JOIN dbo.CMS_Site AS CS
					ON VHFRPJ.NodeSiteID = cs.SiteID
				INNER JOIN dbo.HFit_Account AS HFA
					ON cs.SiteID = HFA.SiteID;
GO
PRINT 'Processed: view_EDW_RewardsDefinition ';
GO

--exec sp_helptext view_EDW_RewardsDefinition
--  
--  

GO
PRINT '***** FROM: view_EDW_RewardsDefinition.sql';
GO 

GO
print ('Processing: view_EDW_RewardTriggerParameters ') ;
go

if exists(select NAME from sys.VIEWS where NAME = 'view_EDW_RewardTriggerParameters')
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
print('***** Created: view_EDW_RewardTriggerParameters.sql'); 
GO 
print ('Processing: view_EDW_ScreeningsFromTrackers ') ;
go

if exists(select TABLE_NAME from INFORMATION_SCHEMA.VIEWS where TABLE_NAME = 'view_EDW_ScreeningsFromTrackers')
BEGIN
	drop view view_EDW_ScreeningsFromTrackers ;
END
GO

--********************************************************************************************************
--09.11.2014 : (wdm) Verified last mod date available to EDW 
--********************************************************************************************************
CREATE VIEW [dbo].[view_EDW_ScreeningsFromTrackers]

AS

SELECT
	t.userid
	, t.EventDate
	, t.TrackerCollectionSourceID
	, t.ItemCreatedBy
	, t.ItemCreatedWhen
	, t.ItemModifiedBy
	, t.ItemModifiedWhen
FROM
	(
		SELECT
			userid
			, eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, ItemCreatedWhen
			, ItemModifiedBy
			, ItemModifiedWhen
		FROM
			HFit_TrackerBloodPressure
		UNION ALL
		SELECT
			userid
			, eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, ItemCreatedWhen
			, ItemModifiedBy
			, ItemModifiedWhen
		FROM
			HFit_TrackerBloodSugarAndGlucose
		UNION ALL
		SELECT
			userid
			, eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, ItemCreatedWhen
			, ItemModifiedBy
			, ItemModifiedWhen
		FROM
			HFit_TrackerBMI
		UNION ALL
		SELECT
			userid
			, eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, ItemCreatedWhen
			, ItemModifiedBy
			, ItemModifiedWhen
		FROM
			HFit_TrackerBodyFat
		UNION ALL
		SELECT
			userid
			, eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, ItemCreatedWhen
			, ItemModifiedBy
			, ItemModifiedWhen
		FROM
			HFit_TrackerBodyMeasurements
		UNION ALL
		SELECT
			userid
			, eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, ItemCreatedWhen
			, ItemModifiedBy
			, ItemModifiedWhen
		FROM
			HFit_TrackerCardio
		UNION ALL
		SELECT
			userid
			, eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, ItemCreatedWhen
			, ItemModifiedBy
			, ItemModifiedWhen
		FROM
			HFit_TrackerCholesterol
		UNION ALL
		SELECT
			userid
			, eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, ItemCreatedWhen
			, ItemModifiedBy
			, ItemModifiedWhen
		FROM
			HFit_TrackerDailySteps
		UNION ALL
		SELECT
			userid
			, eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, ItemCreatedWhen
			, ItemModifiedBy
			, ItemModifiedWhen
		FROM
			HFit_TrackerFlexibility
		UNION ALL
		SELECT
			userid
			, eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, ItemCreatedWhen
			, ItemModifiedBy
			, ItemModifiedWhen
		FROM
			HFit_TrackerFruits
		UNION ALL
		SELECT
			userid
			, eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, ItemCreatedWhen
			, ItemModifiedBy
			, ItemModifiedWhen
		FROM
			HFit_TrackerHbA1c
		UNION ALL
		SELECT
			userid
			, eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, ItemCreatedWhen
			, ItemModifiedBy
			, ItemModifiedWhen
		FROM
			HFit_TrackerHeight
		UNION ALL
		SELECT
			userid
			, eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, ItemCreatedWhen
			, ItemModifiedBy
			, ItemModifiedWhen
		FROM
			HFit_TrackerHighFatFoods
		UNION ALL
		SELECT
			userid
			, eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, ItemCreatedWhen
			, ItemModifiedBy
			, ItemModifiedWhen
		FROM
			HFit_TrackerHighSodiumFoods
		UNION ALL
		SELECT
			userid
			, eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, ItemCreatedWhen
			, ItemModifiedBy
			, ItemModifiedWhen
		FROM
			HFit_TrackerInstance_Tracker
		UNION ALL
		SELECT
			userid
			, eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, ItemCreatedWhen
			, ItemModifiedBy
			, ItemModifiedWhen
		FROM
			HFit_TrackerMealPortions
		UNION ALL
		SELECT
			userid
			, eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, ItemCreatedWhen
			, ItemModifiedBy
			, ItemModifiedWhen
		FROM
			HFit_TrackerMedicalCarePlan
		UNION ALL
		SELECT
			userid
			, eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, ItemCreatedWhen
			, ItemModifiedBy
			, ItemModifiedWhen
		FROM
			HFit_TrackerRegularMeals
		UNION ALL
		SELECT
			userid
			, eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, ItemCreatedWhen
			, ItemModifiedBy
			, ItemModifiedWhen
		FROM
			HFit_TrackerRestingHeartRate
		UNION ALL
		SELECT
			userid
			, eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, ItemCreatedWhen
			, ItemModifiedBy
			, ItemModifiedWhen
		FROM
			HFit_TrackerShots
		UNION ALL
		SELECT
			userid
			, eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, ItemCreatedWhen
			, ItemModifiedBy
			, ItemModifiedWhen
		FROM
			HFit_TrackerSitLess
		UNION ALL
		SELECT
			userid
			, eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, ItemCreatedWhen
			, ItemModifiedBy
			, ItemModifiedWhen
		FROM
			HFit_TrackerSleepPlan
		UNION ALL
		SELECT
			userid
			, eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, ItemCreatedWhen
			, ItemModifiedBy
			, ItemModifiedWhen
		FROM
			HFit_TrackerStrength
		UNION ALL
		SELECT
			userid
			, eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, ItemCreatedWhen
			, ItemModifiedBy
			, ItemModifiedWhen
		FROM
			HFit_TrackerStress
		UNION ALL
		SELECT
			userid
			, eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, ItemCreatedWhen
			, ItemModifiedBy
			, ItemModifiedWhen
		FROM
			HFit_TrackerStressManagement
		UNION ALL
		SELECT
			userid
			, eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, ItemCreatedWhen
			, ItemModifiedBy
			, ItemModifiedWhen
		FROM
			HFit_TrackerSugaryDrinks
		UNION ALL
		SELECT
			userid
			, eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, ItemCreatedWhen
			, ItemModifiedBy
			, ItemModifiedWhen
		FROM
			HFit_TrackerSugaryFoods
		UNION ALL
		SELECT
			userid
			, eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, ItemCreatedWhen
			, ItemModifiedBy
			, ItemModifiedWhen
		FROM
			HFit_TrackerTests
		UNION ALL
		SELECT
			userid
			, eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, ItemCreatedWhen
			, ItemModifiedBy
			, ItemModifiedWhen
		FROM
			HFit_TrackerTobaccoFree
		UNION ALL
		SELECT
			userid
			, eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, ItemCreatedWhen
			, ItemModifiedBy
			, ItemModifiedWhen
		FROM
			HFit_TrackerVegetables
		UNION ALL
		SELECT
			userid
			, eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, ItemCreatedWhen
			, ItemModifiedBy
			, ItemModifiedWhen
		FROM
			HFit_TrackerWater
		UNION ALL
		SELECT
			userid
			, eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, ItemCreatedWhen
			, ItemModifiedBy
			, ItemModifiedWhen
		FROM
			HFit_TrackerWeight
		UNION ALL
		SELECT
			userid
			, eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, ItemCreatedWhen
			, ItemModifiedBy
			, ItemModifiedWhen
		FROM
			HFit_TrackerWholeGrains
	) as T
INNER JOIN dbo.HFit_TrackerCollectionSource AS HFTCS ON t.TrackerCollectionSourceID = HFTCS.TrackerCollectionSourceID
WHERE HFTCS.isProfessionallyCollected = 1


GO


  --  
  --  
GO 
print('***** FROM: view_EDW_ScreeningsFromTrackers.sql'); 
GO 
--HFit_TrackerTobaccoAttestation
--HFit_TrackerPreventiveCare
--HFit_TrackerCotinine


PRINT 'Processing: view_EDW_TrackerCompositeDetails ';
GO

IF EXISTS (SELECT TABLE_NAME
			 FROM INFORMATION_SCHEMA.VIEWS
			 WHERE TABLE_NAME = 'view_EDW_TrackerCompositeDetails') 
	BEGIN
		DROP VIEW view_EDW_TrackerCompositeDetails;
	END;
GO

CREATE VIEW dbo.view_EDW_TrackerCompositeDetails
AS
	--************************************************************************************************************************************
	-- NOTES:
	--************************************************************************************************************************************
	 --WDM 6/26/2014
	 --This view is needed by EDW in order to process the Tracker tables' data.
	 --As of now, the Tracker tables are representative of objects and that would cause 
	 --	large volumes of ETL to be devloped and maintained. 
	 --This view represents a columnar representation of all tracker tables in a Key/Value pair representation.
	 --Each tracker table to be processed into the EDW must be represented in this view.
	 --ALL new tracker tables need only be entered once using the structure contained within this view
	 --	and the same EDW ETL should be able to process it.
	 --If there is a change to the strucuture of any one query in this view, then all have to be modified 
	 --	to be support the change.
	 --Column TrackerNameAggregratetable (AggregateTableName) will be NULL if the Tracker is not a member 
	 --		of the DISPLAYED Trackers. This allows us to capture all trackers, displayed or not.

	 --7/29/2014
	 --ISSUE: HFit_TrackerBMI,  HFit_TrackerCholesterol, and HFit_TrackerHeight are not in the HFIT_Tracker
	 --		table. This causes T.IsAvailable, T.IsCustom, T.UniqueName to be NULL. 
	 --		This raises the need for the Tracker Definition Table.

	 --NOTE: It is a goal to keep this view using BASE tables in order to gain max performance. Nested views will 
	 --		be avoided here if possible.

	 --**************** SPECIFIC TRACKER DATA **********************
	 --**************** on 7/29/2014          **********************
	 --Tracker GUID or Unique ID across all DB Instances (ItemGuid)
	 --Tracker NodeID (we use it for the External ID for Audit and error Triage)  (John: can use ItemID in this case)
	 --Tracker Table Name or Value Group Name (e.g. Body Measurements) - Categorization (TrackerNameAggregateTable)
	 --Tracker Column Unique Name ( In English)  Must be consistent across all DB Instances  ([UniqueName] will be 
	 --		the TABLE NAME if tracker name not found in the HFIT_Tracker table)
	 --Tracker Column Description (In English) (???)
	 --Tracker Column Data Type (e.g. Character, Numeric, Date, Bit or Yes/No) – so that we can set up the answer type
	 --	NULLS accepted for No Answer?	(KEY1, KEY2, VAL1, VAL2, etc)
	 --Tracker Active flag (IsAvailable will be null if tracker name not found in the HFIT_Tracker table)
	 --Tracker Unit of Measure (character) (Currently, the UOM is supplied in the view based on the table and type of Tracker)
	 --Tracker Insert Date ([ItemCreatedWhen])
	 --Tracker Last Update Date ([ItemModifiedWhen])
	 --NOTE: Convert all numerics to floats 7/30/2104 John/Dale
	 --****************************************************************************************************************************
	 -- 12.23.2014 - Added the Vendor ID and Vendor name to the view via the HFit_LKP_TrackerVendor table
	 -- 12.25.2014 - Tested the view to see that it returned the correct VendorID description
	 --************************************************************************************************************************************

	 --USE:
	 --select * from view_EDW_TrackerCompositeDetails where EventDate between '2013-11-01 15:02:00.000' and '2013-12-01 15:02:00.000'

	 --Set statistics IO ON
	 --GO

	 SELECT 'HFit_TrackerBloodPressure' AS TrackerNameAggregateTable ,
			TT.ItemID ,
			EventDate ,
			TT.IsProfessionallyCollected ,
			TT.TrackerCollectionSourceID ,
			Notes ,
			TT.UserID ,
			CollectionSourceName_Internal ,
			CollectionSourceName_External ,
			'MISSING' AS EventName ,
			'mm/Hg' AS UOM ,
			'Systolic' AS KEY1 ,
			CAST (Systolic AS float) AS VAL1 ,
			'Diastolic' AS KEY2 ,
			CAST (Diastolic AS float) AS VAL2 ,
			'NA' AS KEY3 ,
			NULL AS VAL3 ,
			'NA' AS KEY4 ,
			NULL AS VAL4 ,
			'NA' AS KEY5 ,
			NULL AS VAL5 ,
			'NA' AS KEY6 ,
			NULL AS VAL6 ,
			'NA' AS KEY7 ,
			NULL AS VAL7 ,
			'NA' AS KEY8 ,
			NULL AS VAL8 ,
			'NA' AS KEY9 ,
			NULL AS VAL9 ,
			'NA' AS KEY10 ,
			NULL AS VAL10 ,
			TT.ItemCreatedBy ,
			TT.ItemCreatedWhen ,
			TT.ItemModifiedBy ,
			TT.ItemModifiedWhen ,
			IsProcessedForHa ,
			'NA' AS TXTKEY1 ,
			NULL AS TXTVAL1 ,
			'NA' AS TXTKEY2 ,
			NULL AS TXTVAL2 ,
			'NA' AS TXTKEY3 ,
			NULL AS TXTVAL3 ,
			NULL AS ItemOrder ,
			NULL AS ItemGuid ,
			C.UserGuid ,
			PP.MPI ,
			PP.ClientCode ,
			S.SiteGUID ,
			ACCT.AccountID ,
			ACCT.AccountCD ,
			T.IsAvailable ,
			T.IsCustom ,
			ISNULL (T.UniqueName , 'bp') AS UniqueName ,
			ISNULL (T.UniqueName , 'bp') AS ColDesc ,
			VENDOR.ItemID AS VendorID ,
			VENDOR.VendorName
	   FROM dbo.HFit_TrackerBloodPressure AS TT
				INNER JOIN dbo.CMS_User AS C
					ON C.UserID = TT.UserID
				INNER JOIN dbo.hfit_ppteligibility AS PP
					ON TT.UserID = PP.userID
				INNER JOIN dbo.HFit_Account AS ACCT
					ON PP.ClientCode = ACCT.AccountCD
				INNER JOIN dbo.CMS_Site AS S
					ON ACCT.SiteID = S.SiteID
				INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
					ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
				LEFT OUTER JOIN dbo.HFIT_Tracker AS T
					ON T.AggregateTableName = 'HFit_TrackerBloodPressure'
				LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
					ON TT.VendorID = VENDOR.ItemID
	 UNION
	 SELECT 'HFit_TrackerBloodSugarAndGlucose' AS TrackerNameAggregateTable ,
			TT.ItemID ,
			EventDate ,
			TT.IsProfessionallyCollected ,
			TT.TrackerCollectionSourceID ,
			Notes ,
			TT.UserID ,
			CollectionSourceName_Internal ,
			CollectionSourceName_External ,
			'MISSING' AS EventName ,
			'mmol/L' AS UOM ,
			'Units' AS KEY1 ,
			CAST (Units AS float) AS VAL1 ,
			'FastingState' AS KEY2 ,
			CAST (FastingState AS float) AS VAL2 ,
			'NA' AS KEY3 ,
			NULL AS VAL3 ,
			'NA' AS KEY4 ,
			NULL AS VAL4 ,
			'NA' AS KEY5 ,
			NULL AS VAL5 ,
			'NA' AS KEY6 ,
			NULL AS VAL6 ,
			'NA' AS KEY7 ,
			NULL AS VAL7 ,
			'NA' AS KEY8 ,
			NULL AS VAL8 ,
			'NA' AS KEY9 ,
			NULL AS VAL9 ,
			'NA' AS KEY10 ,
			NULL AS VAL10 ,
			TT.ItemCreatedBy ,
			TT.ItemCreatedWhen ,
			TT.ItemModifiedBy ,
			TT.ItemModifiedWhen ,
			IsProcessedForHa ,
			'NA' AS TXTKEY1 ,
			NULL AS TXTVAL1 ,
			'NA' AS TXTKEY2 ,
			NULL AS TXTVAL2 ,
			'NA' AS TXTKEY3 ,
			NULL AS TXTVAL3 ,
			NULL AS ItemOrder ,
			NULL AS ItemGuid ,
			C.UserGuid ,
			PP.MPI ,
			PP.ClientCode ,
			S.SiteGUID ,
			ACCT.AccountID ,
			ACCT.AccountCD ,
			T.IsAvailable ,
			T.IsCustom ,
			ISNULL (T.UniqueName , 'glucose') AS UniqueName ,
			ISNULL (T.UniqueName , 'glucose') AS ColDesc ,
			VENDOR.ItemID AS VendorID ,
			VENDOR.VendorName
	   FROM dbo.HFit_TrackerBloodSugarAndGlucose AS TT
				INNER JOIN dbo.CMS_User AS C
					ON C.UserID = TT.UserID
				INNER JOIN dbo.hfit_ppteligibility AS PP
					ON TT.UserID = PP.userID
				INNER JOIN dbo.HFit_Account AS ACCT
					ON PP.ClientCode = ACCT.AccountCD
				INNER JOIN dbo.CMS_Site AS S
					ON ACCT.SiteID = S.SiteID
				INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
					ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
				LEFT OUTER JOIN dbo.HFIT_Tracker AS T
					ON T.AggregateTableName = 'HFit_TrackerBloodSugarAndGlucose'
				LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
					ON TT.VendorID = VENDOR.ItemID
	 UNION
	 SELECT 'HFit_TrackerBMI' AS TrackerNameAggregateTable ,
			TT.ItemID ,
			EventDate ,
			TT.IsProfessionallyCollected ,
			TT.TrackerCollectionSourceID ,
			Notes ,
			TT.UserID ,
			CollectionSourceName_Internal ,
			CollectionSourceName_External ,
			'MISSING' AS EventName ,
			'kg/m2' AS UOM ,
			'BMI' AS KEY1 ,
			CAST (BMI AS float) AS VAL1 ,
			'NA' AS KEY2 ,
			0 AS VAL2 ,
			'NA' AS KEY3 ,
			NULL AS VAL3 ,
			'NA' AS KEY4 ,
			NULL AS VAL4 ,
			'NA' AS KEY5 ,
			NULL AS VAL5 ,
			'NA' AS KEY6 ,
			NULL AS VAL6 ,
			'NA' AS KEY7 ,
			NULL AS VAL7 ,
			'NA' AS KEY8 ,
			NULL AS VAL8 ,
			'NA' AS KEY9 ,
			NULL AS VAL9 ,
			'NA' AS KEY10 ,
			NULL AS VAL10 ,
			TT.ItemCreatedBy ,
			TT.ItemCreatedWhen ,
			TT.ItemModifiedBy ,
			TT.ItemModifiedWhen ,
			NULL AS IsProcessedForHa ,
			'NA' AS TXTKEY1 ,
			NULL AS TXTVAL1 ,
			'NA' AS TXTKEY2 ,
			NULL AS TXTVAL2 ,
			'NA' AS TXTKEY3 ,
			NULL AS TXTVAL3 ,
			TT.ItemOrder ,
			NULL AS ItemGuid ,
			C.UserGuid ,
			PP.MPI ,
			PP.ClientCode ,
			S.SiteGUID ,
			ACCT.AccountID ,
			ACCT.AccountCD ,
			T.IsAvailable ,
			T.IsCustom ,
			ISNULL (T.UniqueName , 'HFit_TrackerBMI') AS UniqueName ,
			ISNULL (T.UniqueName , 'HFit_TrackerBMI') AS ColDesc ,
			VENDOR.ItemID AS VendorID ,
			VENDOR.VendorName
	   FROM dbo.HFit_TrackerBMI AS TT
				INNER JOIN dbo.CMS_User AS C
					ON C.UserID = TT.UserID
				INNER JOIN dbo.hfit_ppteligibility AS PP
					ON TT.UserID = PP.userID
				INNER JOIN dbo.HFit_Account AS ACCT
					ON PP.ClientCode = ACCT.AccountCD
				INNER JOIN dbo.CMS_Site AS S
					ON ACCT.SiteID = S.SiteID
				INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
					ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
				LEFT OUTER JOIN dbo.HFIT_Tracker AS T
					ON T.AggregateTableName = 'HFit_TrackerBMI'
				LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
					ON TT.VendorID = VENDOR.ItemID
	 UNION
	 SELECT 'HFit_TrackerBodyFat' AS TrackerNameAggregateTable ,
			TT.ItemID ,
			EventDate ,
			TT.IsProfessionallyCollected ,
			TT.TrackerCollectionSourceID ,
			Notes ,
			TT.UserID ,
			CollectionSourceName_Internal ,
			CollectionSourceName_External ,
			'MISSING' AS EventName ,
			'PCT' AS UOM ,
			'Value' AS KEY1 ,
			CAST ([Value] AS float) AS VAL1 ,
			'NA' AS KEY2 ,
			0 AS VAL2 ,
			'NA' AS KEY3 ,
			NULL AS VAL3 ,
			'NA' AS KEY4 ,
			NULL AS VAL4 ,
			'NA' AS KEY5 ,
			NULL AS VAL5 ,
			'NA' AS KEY6 ,
			NULL AS VAL6 ,
			'NA' AS KEY7 ,
			NULL AS VAL7 ,
			'NA' AS KEY8 ,
			NULL AS VAL8 ,
			'NA' AS KEY9 ,
			NULL AS VAL9 ,
			'NA' AS KEY10 ,
			NULL AS VAL10 ,
			TT.ItemCreatedBy ,
			TT.ItemModifiedBy ,
			TT.ItemCreatedWhen ,
			TT.ItemModifiedWhen ,
			NULL AS IsProcessedForHa ,
			'NA' AS TXTKEY1 ,
			NULL AS TXTVAL1 ,
			'NA' AS TXTKEY2 ,
			NULL AS TXTVAL2 ,
			'NA' AS TXTKEY3 ,
			NULL AS TXTVAL3 ,
			NULL AS ItemOrder ,
			NULL AS ItemGuid ,
			C.UserGuid ,
			PP.MPI ,
			PP.ClientCode ,
			S.SiteGUID ,
			ACCT.AccountID ,
			ACCT.AccountCD ,
			T.IsAvailable ,
			T.IsCustom ,
			ISNULL (T.UniqueName , 'HFit_TrackerBodyFat') AS UniqueName ,
			ISNULL (T.UniqueName , 'HFit_TrackerBodyFat') AS ColDesc ,
			VENDOR.ItemID AS VendorID ,
			VENDOR.VendorName
	   FROM dbo.HFit_TrackerBodyFat AS TT
				INNER JOIN dbo.CMS_User AS C
					ON C.UserID = TT.UserID
				INNER JOIN dbo.hfit_ppteligibility AS PP
					ON TT.UserID = PP.userID
				INNER JOIN dbo.HFit_Account AS ACCT
					ON PP.ClientCode = ACCT.AccountCD
				INNER JOIN dbo.CMS_Site AS S
					ON ACCT.SiteID = S.SiteID
				INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
					ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
				LEFT OUTER JOIN dbo.HFIT_Tracker AS T
					ON T.AggregateTableName = 'HFit_TrackerBodyFat'
				LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
					ON TT.VendorID = VENDOR.ItemID
	 UNION
	 --******************************************************************************
	 SELECT 'HFit_TrackerBodyMeasurements' AS TrackerNameAggregateTable ,
			TT.ItemID ,
			EventDate ,
			TT.IsProfessionallyCollected ,
			TT.TrackerCollectionSourceID ,
			Notes ,
			TT.UserID ,
			CollectionSourceName_Internal ,
			CollectionSourceName_External ,
			'MISSING' AS EventName ,
			'Inch' AS UOM ,
			'WaistInches' AS KEY1 ,
			CAST (WaistInches AS float) AS VAL1 ,
			'HipInches' AS KEY2 ,
			CAST (HipInches AS float) AS VAL2 ,
			'ThighInches' AS KEY3 ,
			CAST (ThighInches AS float) AS VAL3 ,
			'ArmInches' AS KEY4 ,
			CAST (ArmInches AS float) AS VAL4 ,
			'ChestInches' AS KEY5 ,
			CAST (ChestInches AS float) AS VAL5 ,
			'CalfInches' AS KEY6 ,
			CAST (CalfInches AS float) AS VAL6 ,
			'NeckInches' AS KEY7 ,
			CAST (NeckInches AS float) AS VAL7 ,
			'NA' AS KEY8 ,
			NULL AS VAL8 ,
			'NA' AS KEY9 ,
			NULL AS VAL9 ,
			'NA' AS KEY10 ,
			NULL AS VAL10 ,
			TT.ItemCreatedBy ,
			TT.ItemModifiedBy ,
			TT.ItemCreatedWhen ,
			TT.ItemModifiedWhen ,
			IsProcessedForHa ,
			'NA' AS TXTKEY1 ,
			NULL AS TXTVAL1 ,
			'NA' AS TXTKEY2 ,
			NULL AS TXTVAL2 ,
			'NA' AS TXTKEY3 ,
			NULL AS TXTVAL3 ,
			NULL AS ItemOrder ,
			NULL AS ItemGuid ,
			C.UserGuid ,
			PP.MPI ,
			PP.ClientCode ,
			S.SiteGUID ,
			ACCT.AccountID ,
			ACCT.AccountCD ,
			T.IsAvailable ,
			T.IsCustom ,
			T.UniqueName ,
			T.UniqueName AS ColDesc ,
			VENDOR.ItemID AS VendorID ,
			VENDOR.VendorName
	   FROM dbo.HFit_TrackerBodyMeasurements AS TT
				INNER JOIN dbo.CMS_User AS C
					ON C.UserID = TT.UserID
				INNER JOIN dbo.hfit_ppteligibility AS PP
					ON TT.UserID = PP.userID
				INNER JOIN dbo.HFit_Account AS ACCT
					ON PP.ClientCode = ACCT.AccountCD
				INNER JOIN dbo.CMS_Site AS S
					ON ACCT.SiteID = S.SiteID
				INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
					ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
				LEFT OUTER JOIN dbo.HFIT_Tracker AS T
					ON T.AggregateTableName = 'HFit_TrackerBodyMeasurements'
				LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
					ON TT.VendorID = VENDOR.ItemID
	 --******************************************************************************
	 UNION
	 SELECT 'HFit_TrackerCardio' AS TrackerNameAggregateTable ,
			TT.ItemID ,
			EventDate ,
			TT.IsProfessionallyCollected ,
			TT.TrackerCollectionSourceID ,
			Notes ,
			TT.UserID ,
			CollectionSourceName_Internal ,
			CollectionSourceName_External ,
			'MISSING' AS EventName ,
			'NA' AS UOM ,
			'Minutes' AS KEY1 ,
			CAST (Minutes AS float) AS VAL1 ,
			'Distance' AS KEY2 ,
			CAST (Distance AS float) AS VAL2 ,
			'DistanceUnit' AS KEY3 ,
			CAST (DistanceUnit AS float) AS VAL3 ,
			'Intensity' AS KEY4 ,
			CAST (Intensity AS float) AS VAL4 ,
			'ActivityID' AS KEY5 ,
			CAST (ActivityID AS float) AS VAL5 ,
			'NA' AS KEY6 ,
			NULL AS VAL6 ,
			'NA' AS KEY7 ,
			NULL AS VAL7 ,
			'NA' AS KEY8 ,
			NULL AS VAL8 ,
			'NA' AS KEY9 ,
			NULL AS VAL9 ,
			'NA' AS KEY10 ,
			NULL AS VAL10 ,
			TT.ItemCreatedBy ,
			TT.ItemModifiedBy ,
			TT.ItemCreatedWhen ,
			TT.ItemModifiedWhen ,
			NULL AS IsProcessedForHa ,
			'NA' AS TXTKEY1 ,
			NULL AS TXTVAL1 ,
			'NA' AS TXTKEY2 ,
			NULL AS TXTVAL2 ,
			'NA' AS TXTKEY3 ,
			NULL AS TXTVAL3 ,
			NULL AS ItemOrder ,
			NULL AS ItemGuid ,
			C.UserGuid ,
			PP.MPI ,
			PP.ClientCode ,
			S.SiteGUID ,
			ACCT.AccountID ,
			ACCT.AccountCD ,
			T.IsAvailable ,
			T.IsCustom ,
			T.UniqueName ,
			T.UniqueName AS ColDesc ,
			NULL AS VendorID	--VENDOR.ItemID as VendorID
			,
			NULL AS VendorName --VENDOR.VendorName
	   FROM dbo.HFit_TrackerCardio AS TT
				INNER JOIN dbo.CMS_User AS C
					ON C.UserID = TT.UserID
				INNER JOIN dbo.hfit_ppteligibility AS PP
					ON TT.UserID = PP.userID
				INNER JOIN dbo.HFit_Account AS ACCT
					ON PP.ClientCode = ACCT.AccountCD
				INNER JOIN dbo.CMS_Site AS S
					ON ACCT.SiteID = S.SiteID
				INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
					ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
				LEFT OUTER JOIN dbo.HFIT_Tracker AS T
					ON T.AggregateTableName = 'HFit_TrackerCardio'
	 --left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
	 UNION
	 SELECT 'HFit_TrackerCholesterol' AS TrackerNameAggregateTable ,
			TT.ItemID ,
			EventDate ,
			TT.IsProfessionallyCollected ,
			TT.TrackerCollectionSourceID ,
			Notes ,
			TT.UserID ,
			CollectionSourceName_Internal ,
			CollectionSourceName_External ,
			'MISSING' AS EventName ,
			'mg/dL' AS UOM ,
			'HDL' AS KEY1 ,
			CAST (HDL AS float) AS VAL1 ,
			'LDL' AS KEY2 ,
			CAST (LDL AS float) AS VAL2 ,
			'Total' AS KEY3 ,
			CAST (Total AS float) AS VAL3 ,
			'Tri' AS KEY4 ,
			CAST (Tri AS float) AS VAL4 ,
			'Ratio' AS KEY5 ,
			CAST (Ratio AS float) AS VAL5 ,
			'Fasting' AS KEY6 ,
			CAST (Fasting AS float) AS VAL6 ,
			'VLDL' AS VLDL ,
			CAST (VLDL AS float) AS VAL7 ,
			'NA' AS KEY8 ,
			NULL AS VAL8 ,
			'NA' AS KEY9 ,
			NULL AS VAL9 ,
			'NA' AS KEY10 ,
			NULL AS VAL10 ,
			TT.ItemCreatedBy ,
			TT.ItemCreatedWhen ,
			TT.ItemModifiedBy ,
			TT.ItemModifiedWhen ,
			IsProcessedForHa ,
			'NA' AS TXTKEY1 ,
			NULL AS TXTVAL1 ,
			'NA' AS TXTKEY2 ,
			NULL AS TXTVAL2 ,
			'NA' AS TXTKEY3 ,
			NULL AS TXTVAL3 ,
			NULL AS ItemOrder ,
			NULL AS ItemGuid ,
			C.UserGuid ,
			PP.MPI ,
			PP.ClientCode ,
			S.SiteGUID ,
			ACCT.AccountID ,
			ACCT.AccountCD ,
			T.IsAvailable ,
			T.IsCustom ,
			ISNULL (T.UniqueName , 'HFit_TrackerCholesterol') AS UniqueName ,
			ISNULL (T.UniqueName , 'HFit_TrackerCholesterol') AS ColDesc ,
			VENDOR.ItemID AS VendorID ,
			VENDOR.VendorName
	   FROM dbo.HFit_TrackerCholesterol AS TT
				INNER JOIN dbo.CMS_User AS C
					ON C.UserID = TT.UserID
				INNER JOIN dbo.hfit_ppteligibility AS PP
					ON TT.UserID = PP.userID
				INNER JOIN dbo.HFit_Account AS ACCT
					ON PP.ClientCode = ACCT.AccountCD
				INNER JOIN dbo.CMS_Site AS S
					ON ACCT.SiteID = S.SiteID
				INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
					ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
				LEFT OUTER JOIN dbo.HFIT_Tracker AS T
					ON T.AggregateTableName = 'HFit_TrackerCholesterol'
				LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
					ON TT.VendorID = VENDOR.ItemID
	 UNION
	 SELECT 'HFit_TrackerDailySteps' AS TrackerNameAggregateTable ,
			TT.ItemID ,
			EventDate ,
			TT.IsProfessionallyCollected ,
			TT.TrackerCollectionSourceID ,
			Notes ,
			TT.UserID ,
			CollectionSourceName_Internal ,
			CollectionSourceName_External ,
			'MISSING' AS EventName ,
			'Step' AS UOM ,
			'Steps' AS KEY1 ,
			CAST (Steps AS float) AS VAL1 ,
			'NA' AS KEY2 ,
			NULL AS VAL2 ,
			'NA' AS KEY3 ,
			NULL AS VAL3 ,
			'NA' AS KEY4 ,
			NULL AS VAL4 ,
			'NA' AS KEY5 ,
			NULL AS VAL5 ,
			'NA' AS KEY6 ,
			NULL AS VAL6 ,
			'NA' AS KEY7 ,
			NULL AS VAL7 ,
			'NA' AS KEY8 ,
			NULL AS VAL8 ,
			'NA' AS KEY9 ,
			NULL AS VAL9 ,
			'NA' AS KEY10 ,
			NULL AS VAL10 ,
			TT.ItemCreatedBy ,
			TT.ItemCreatedWhen ,
			TT.ItemModifiedBy ,
			TT.ItemModifiedWhen ,
			NULL AS IsProcessedForHa ,
			'NA' AS TXTKEY1 ,
			NULL AS TXTVAL1 ,
			'NA' AS TXTKEY2 ,
			NULL AS TXTVAL2 ,
			'NA' AS TXTKEY3 ,
			NULL AS TXTVAL3 ,
			NULL AS ItemOrder ,
			NULL AS ItemGuid ,
			C.UserGuid ,
			PP.MPI ,
			PP.ClientCode ,
			S.SiteGUID ,
			ACCT.AccountID ,
			ACCT.AccountCD ,
			T.IsAvailable ,
			T.IsCustom ,
			ISNULL (T.UniqueName , 'HFit_TrackerDailySteps') AS UniqueName ,
			ISNULL (T.UniqueName , 'HFit_TrackerDailySteps') AS ColDesc ,
			NULL AS VendorID	--VENDOR.ItemID as VendorID
			,
			NULL AS VendorName --VENDOR.VendorName
	   FROM dbo.HFit_TrackerDailySteps AS TT
				INNER JOIN dbo.CMS_User AS C
					ON C.UserID = TT.UserID
				INNER JOIN dbo.hfit_ppteligibility AS PP
					ON TT.UserID = PP.userID
				INNER JOIN dbo.HFit_Account AS ACCT
					ON PP.ClientCode = ACCT.AccountCD
				INNER JOIN dbo.CMS_Site AS S
					ON ACCT.SiteID = S.SiteID
				INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
					ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
				LEFT OUTER JOIN dbo.HFIT_Tracker AS T
					ON T.AggregateTableName = 'HFit_TrackerDailySteps'
	 --left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
	 UNION
	 SELECT 'HFit_TrackerFlexibility' AS TrackerNameAggregateTable ,
			TT.ItemID ,
			EventDate ,
			TT.IsProfessionallyCollected ,
			TT.TrackerCollectionSourceID ,
			Notes ,
			TT.UserID ,
			CollectionSourceName_Internal ,
			CollectionSourceName_External ,
			'MISSING' AS EventName ,
			'Y/N' AS UOM ,
			'HasStretched' AS KEY1 ,
			CAST (HasStretched AS float) AS VAL1 ,
			'NA' AS KEY2 ,
			NULL AS VAL2 ,
			'NA' AS KEY3 ,
			NULL AS VAL3 ,
			'NA' AS KEY4 ,
			NULL AS VAL4 ,
			'NA' AS KEY5 ,
			NULL AS VAL5 ,
			'NA' AS KEY6 ,
			NULL AS VAL6 ,
			'NA' AS KEY7 ,
			NULL AS VAL7 ,
			'NA' AS KEY8 ,
			NULL AS VAL8 ,
			'NA' AS KEY9 ,
			NULL AS VAL9 ,
			'NA' AS KEY10 ,
			NULL AS VAL10 ,
			TT.ItemCreatedBy ,
			TT.ItemCreatedWhen ,
			TT.ItemModifiedBy ,
			TT.ItemModifiedWhen ,
			NULL AS IsProcessedForHa ,
			'Activity' AS TXTKEY1 ,
			Activity AS TXTVAL1 ,
			'NA' AS TXTKEY2 ,
			NULL AS TXTVAL2 ,
			'NA' AS TXTKEY3 ,
			NULL AS TXTVAL3 ,
			NULL AS ItemOrder ,
			NULL AS ItemGuid ,
			C.UserGuid ,
			PP.MPI ,
			PP.ClientCode ,
			S.SiteGUID ,
			ACCT.AccountID ,
			ACCT.AccountCD ,
			T.IsAvailable ,
			T.IsCustom ,
			T.UniqueName ,
			T.UniqueName AS ColDesc ,
			NULL AS VendorID	--VENDOR.ItemID as VendorID
			,
			NULL AS VendorName --VENDOR.VendorName
	   FROM dbo.HFit_TrackerFlexibility AS TT
				INNER JOIN dbo.CMS_User AS C
					ON C.UserID = TT.UserID
				INNER JOIN dbo.hfit_ppteligibility AS PP
					ON TT.UserID = PP.userID
				INNER JOIN dbo.HFit_Account AS ACCT
					ON PP.ClientCode = ACCT.AccountCD
				INNER JOIN dbo.CMS_Site AS S
					ON ACCT.SiteID = S.SiteID
				INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
					ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
				LEFT OUTER JOIN dbo.HFIT_Tracker AS T
					ON T.AggregateTableName = 'HFit_TrackerFlexibility'
	 --left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
	 UNION
	 SELECT 'HFit_TrackerFruits' AS TrackerNameAggregateTable ,
			TT.ItemID ,
			EventDate ,
			TT.IsProfessionallyCollected ,
			TT.TrackerCollectionSourceID ,
			Notes ,
			TT.UserID ,
			CollectionSourceName_Internal ,
			CollectionSourceName_External ,
			'MISSING' AS EventName ,
			'CUP(8oz)' AS UOM ,
			'Cups' AS KEY1 ,
			CAST (Cups AS float) AS VAL1 ,
			'NA' AS KEY2 ,
			NULL AS VAL2 ,
			'NA' AS KEY3 ,
			NULL AS VAL3 ,
			'NA' AS KEY4 ,
			NULL AS VAL4 ,
			'NA' AS KEY5 ,
			NULL AS VAL5 ,
			'NA' AS KEY6 ,
			NULL AS VAL6 ,
			'NA' AS KEY7 ,
			NULL AS VAL7 ,
			'NA' AS KEY8 ,
			NULL AS VAL8 ,
			'NA' AS KEY9 ,
			NULL AS VAL9 ,
			'NA' AS KEY10 ,
			NULL AS VAL10 ,
			TT.ItemCreatedBy ,
			TT.ItemCreatedWhen ,
			TT.ItemModifiedBy ,
			TT.ItemModifiedWhen ,
			NULL AS IsProcessedForHa ,
			'NA' AS TXTKEY1 ,
			NULL AS TXTVAL1 ,
			'NA' AS TXTKEY2 ,
			NULL AS TXTVAL2 ,
			'NA' AS TXTKEY3 ,
			NULL AS TXTVAL3 ,
			NULL AS ItemOrder ,
			NULL AS ItemGuid ,
			C.UserGuid ,
			PP.MPI ,
			PP.ClientCode ,
			S.SiteGUID ,
			ACCT.AccountID ,
			ACCT.AccountCD ,
			T.IsAvailable ,
			T.IsCustom ,
			T.UniqueName ,
			T.UniqueName AS ColDesc ,
			NULL AS VendorID	--VENDOR.ItemID as VendorID
			,
			NULL AS VendorName --VENDOR.VendorName
	   FROM dbo.HFit_TrackerFruits AS TT
				INNER JOIN dbo.CMS_User AS C
					ON C.UserID = TT.UserID
				INNER JOIN dbo.hfit_ppteligibility AS PP
					ON TT.UserID = PP.userID
				INNER JOIN dbo.HFit_Account AS ACCT
					ON PP.ClientCode = ACCT.AccountCD
				INNER JOIN dbo.CMS_Site AS S
					ON ACCT.SiteID = S.SiteID
				INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
					ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
				LEFT OUTER JOIN dbo.HFIT_Tracker AS T
					ON T.AggregateTableName = 'HFit_TrackerFruits'
	 --left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
	 UNION
	 SELECT 'HFit_TrackerHbA1c' AS TrackerNameAggregateTable ,
			TT.ItemID ,
			EventDate ,
			TT.IsProfessionallyCollected ,
			TT.TrackerCollectionSourceID ,
			Notes ,
			TT.UserID ,
			CollectionSourceName_Internal ,
			CollectionSourceName_External ,
			'MISSING' AS EventName ,
			'mmol/mol' AS UOM ,
			'Value' AS KEY1 ,
			CAST ([Value] AS float) AS VAL1 ,
			'NA' AS KEY2 ,
			NULL AS VAL2 ,
			'NA' AS KEY3 ,
			NULL AS VAL3 ,
			'NA' AS KEY4 ,
			NULL AS VAL4 ,
			'NA' AS KEY5 ,
			NULL AS VAL5 ,
			'NA' AS KEY6 ,
			NULL AS VAL6 ,
			'NA' AS KEY7 ,
			NULL AS VAL7 ,
			'NA' AS KEY8 ,
			NULL AS VAL8 ,
			'NA' AS KEY9 ,
			NULL AS VAL9 ,
			'NA' AS KEY10 ,
			NULL AS VAL10 ,
			TT.ItemCreatedBy ,
			TT.ItemCreatedWhen ,
			TT.ItemModifiedBy ,
			TT.ItemModifiedWhen ,
			IsProcessedForHa ,
			'NA' AS TXTKEY1 ,
			NULL AS TXTVAL1 ,
			'NA' AS TXTKEY2 ,
			NULL AS TXTVAL2 ,
			'NA' AS TXTKEY3 ,
			NULL AS TXTVAL3 ,
			NULL AS ItemOrder ,
			NULL AS ItemGuid ,
			C.UserGuid ,
			PP.MPI ,
			PP.ClientCode ,
			S.SiteGUID ,
			ACCT.AccountID ,
			ACCT.AccountCD ,
			T.IsAvailable ,
			T.IsCustom ,
			T.UniqueName ,
			T.UniqueName AS ColDesc ,
			VENDOR.ItemID AS VendorID ,
			VENDOR.VendorName
	   FROM dbo.HFit_TrackerHbA1c AS TT
				INNER JOIN dbo.CMS_User AS C
					ON C.UserID = TT.UserID
				INNER JOIN dbo.hfit_ppteligibility AS PP
					ON TT.UserID = PP.userID
				INNER JOIN dbo.HFit_Account AS ACCT
					ON PP.ClientCode = ACCT.AccountCD
				INNER JOIN dbo.CMS_Site AS S
					ON ACCT.SiteID = S.SiteID
				INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
					ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
				LEFT OUTER JOIN dbo.HFIT_Tracker AS T
					ON T.AggregateTableName = 'HFit_TrackerHbA1c'
				LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
					ON TT.VendorID = VENDOR.ItemID
	 UNION
	 SELECT 'HFit_TrackerHeight' AS TrackerNameAggregateTable ,
			TT.ItemID ,
			EventDate ,
			TT.IsProfessionallyCollected ,
			TT.TrackerCollectionSourceID ,
			Notes ,
			TT.UserID ,
			CollectionSourceName_Internal ,
			CollectionSourceName_External ,
			'MISSING' AS EventName ,
			'inch' AS UOM ,
			'Height' AS KEY1 ,
			Height AS VAL1 ,
			'NA' AS KEY2 ,
			NULL AS VAL2 ,
			'NA' AS KEY3 ,
			NULL AS VAL3 ,
			'NA' AS KEY4 ,
			NULL AS VAL4 ,
			'NA' AS KEY5 ,
			NULL AS VAL5 ,
			'NA' AS KEY6 ,
			NULL AS VAL6 ,
			'NA' AS KEY7 ,
			NULL AS VAL7 ,
			'NA' AS KEY8 ,
			NULL AS VAL8 ,
			'NA' AS KEY9 ,
			NULL AS VAL9 ,
			'NA' AS KEY10 ,
			NULL AS VAL10 ,
			TT.ItemCreatedBy ,
			TT.ItemCreatedWhen ,
			TT.ItemModifiedBy ,
			TT.ItemModifiedWhen ,
			IsProcessedForHa ,
			'NA' AS TXTKEY1 ,
			NULL AS TXTVAL1 ,
			'NA' AS TXTKEY2 ,
			NULL AS TXTVAL2 ,
			'NA' AS TXTKEY3 ,
			NULL AS TXTVAL3 ,
			TT.ItemOrder ,
			TT.ItemGuid ,
			C.UserGuid ,
			PP.MPI ,
			PP.ClientCode ,
			S.SiteGUID ,
			ACCT.AccountID ,
			ACCT.AccountCD ,
			T.IsAvailable ,
			T.IsCustom ,
			ISNULL (T.UniqueName , 'HFit_TrackerHeight') AS UniqueName ,
			ISNULL (T.UniqueName , 'HFit_TrackerHeight') AS ColDesc ,
			VENDOR.ItemID AS VendorID ,
			VENDOR.VendorName
	   FROM dbo.HFit_TrackerHeight AS TT
				INNER JOIN dbo.CMS_User AS C
					ON C.UserID = TT.UserID
				INNER JOIN dbo.hfit_ppteligibility AS PP
					ON TT.UserID = PP.userID
				INNER JOIN dbo.HFit_Account AS ACCT
					ON PP.ClientCode = ACCT.AccountCD
				INNER JOIN dbo.CMS_Site AS S
					ON ACCT.SiteID = S.SiteID
				INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
					ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
				LEFT OUTER JOIN dbo.HFIT_Tracker AS T
					ON T.AggregateTableName = 'HFit_TrackerHeight'
				LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
					ON TT.VendorID = VENDOR.ItemID
	 UNION
	 SELECT 'HFit_TrackerHighFatFoods' AS TrackerNameAggregateTable ,
			TT.ItemID ,
			EventDate ,
			TT.IsProfessionallyCollected ,
			TT.TrackerCollectionSourceID ,
			Notes ,
			TT.UserID ,
			CollectionSourceName_Internal ,
			CollectionSourceName_External ,
			'MISSING' AS EventName ,
			'Occurs' AS UOM ,
			'Times' AS KEY1 ,
			CAST (Times AS float) AS VAL1 ,
			'NA' AS KEY2 ,
			NULL AS VAL2 ,
			'NA' AS KEY3 ,
			NULL AS VAL3 ,
			'NA' AS KEY4 ,
			NULL AS VAL4 ,
			'NA' AS KEY5 ,
			NULL AS VAL5 ,
			'NA' AS KEY6 ,
			NULL AS VAL6 ,
			'NA' AS KEY7 ,
			NULL AS VAL7 ,
			'NA' AS KEY8 ,
			NULL AS VAL8 ,
			'NA' AS KEY9 ,
			NULL AS VAL9 ,
			'NA' AS KEY10 ,
			NULL AS VAL10 ,
			TT.ItemCreatedBy ,
			TT.ItemCreatedWhen ,
			TT.ItemModifiedBy ,
			TT.ItemModifiedWhen ,
			NULL AS IsProcessedForHa ,
			'NA' AS TXTKEY1 ,
			NULL AS TXTVAL1 ,
			'NA' AS TXTKEY2 ,
			NULL AS TXTVAL2 ,
			'NA' AS TXTKEY3 ,
			NULL AS TXTVAL3 ,
			NULL AS ItemOrder ,
			NULL AS ItemGuid ,
			C.UserGuid ,
			PP.MPI ,
			PP.ClientCode ,
			S.SiteGUID ,
			ACCT.AccountID ,
			ACCT.AccountCD ,
			T.IsAvailable ,
			T.IsCustom ,
			T.UniqueName ,
			T.UniqueName AS ColDesc ,
			NULL AS VendorID	--VENDOR.ItemID as VendorID
			,
			NULL AS VendorName --VENDOR.VendorName
	   FROM dbo.HFit_TrackerHighFatFoods AS TT
				INNER JOIN dbo.CMS_User AS C
					ON C.UserID = TT.UserID
				INNER JOIN dbo.hfit_ppteligibility AS PP
					ON TT.UserID = PP.userID
				INNER JOIN dbo.HFit_Account AS ACCT
					ON PP.ClientCode = ACCT.AccountCD
				INNER JOIN dbo.CMS_Site AS S
					ON ACCT.SiteID = S.SiteID
				INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
					ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
				LEFT OUTER JOIN dbo.HFIT_Tracker AS T
					ON T.AggregateTableName = 'HFit_TrackerHighFatFoods'
	 --left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
	 UNION
	 SELECT 'HFit_TrackerHighSodiumFoods' AS TrackerNameAggregateTable ,
			TT.ItemID ,
			EventDate ,
			TT.IsProfessionallyCollected ,
			TT.TrackerCollectionSourceID ,
			Notes ,
			TT.UserID ,
			CollectionSourceName_Internal ,
			CollectionSourceName_External ,
			'MISSING' AS EventName ,
			'Occurs' AS UOM ,
			'Times' AS KEY1 ,
			CAST (Times AS float) AS VAL1 ,
			'NA' AS KEY2 ,
			NULL AS VAL2 ,
			'NA' AS KEY3 ,
			NULL AS VAL3 ,
			'NA' AS KEY4 ,
			NULL AS VAL4 ,
			'NA' AS KEY5 ,
			NULL AS VAL5 ,
			'NA' AS KEY6 ,
			NULL AS VAL6 ,
			'NA' AS KEY7 ,
			NULL AS VAL7 ,
			'NA' AS KEY8 ,
			NULL AS VAL8 ,
			'NA' AS KEY9 ,
			NULL AS VAL9 ,
			'NA' AS KEY10 ,
			NULL AS VAL10 ,
			TT.ItemCreatedBy ,
			TT.ItemCreatedWhen ,
			TT.ItemModifiedBy ,
			TT.ItemModifiedWhen ,
			NULL AS IsProcessedForHa ,
			'NA' AS TXTKEY1 ,
			NULL AS TXTVAL1 ,
			'NA' AS TXTKEY2 ,
			NULL AS TXTVAL2 ,
			'NA' AS TXTKEY3 ,
			NULL AS TXTVAL3 ,
			NULL AS ItemOrder ,
			NULL AS ItemGuid ,
			C.UserGuid ,
			PP.MPI ,
			PP.ClientCode ,
			S.SiteGUID ,
			ACCT.AccountID ,
			ACCT.AccountCD ,
			T.IsAvailable ,
			T.IsCustom ,
			T.UniqueName ,
			T.UniqueName AS ColDesc ,
			NULL AS VendorID	--VENDOR.ItemID as VendorID
			,
			NULL AS VendorName --VENDOR.VendorName
	   FROM dbo.HFit_TrackerHighSodiumFoods AS TT
				INNER JOIN dbo.CMS_User AS C
					ON C.UserID = TT.UserID
				INNER JOIN dbo.hfit_ppteligibility AS PP
					ON TT.UserID = PP.userID
				INNER JOIN dbo.HFit_Account AS ACCT
					ON PP.ClientCode = ACCT.AccountCD
				INNER JOIN dbo.CMS_Site AS S
					ON ACCT.SiteID = S.SiteID
				INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
					ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
				LEFT OUTER JOIN dbo.HFIT_Tracker AS T
					ON T.AggregateTableName = 'HFit_TrackerHighSodiumFoods'
	 --left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
	 UNION
	 SELECT 'HFit_TrackerInstance_Tracker' AS TrackerNameAggregateTable ,
			TT.ItemID ,
			EventDate ,
			TT.IsProfessionallyCollected ,
			TT.TrackerCollectionSourceID ,
			Notes ,
			TT.UserID ,
			CollectionSourceName_Internal ,
			CollectionSourceName_External ,
			'MISSING' AS EventName ,
			'Y/N' AS UOM ,
			'TrackerDefID' AS KEY1 ,
			CAST (TrackerDefID AS float) AS VAL1 ,
			'YesNoValue' AS KEY2 ,
			CAST (YesNoValue AS float) AS VAL2 ,
			'NA' AS KEY3 ,
			NULL AS VAL3 ,
			'NA' AS KEY4 ,
			NULL AS VAL4 ,
			'NA' AS KEY5 ,
			NULL AS VAL5 ,
			'NA' AS KEY6 ,
			NULL AS VAL6 ,
			'NA' AS KEY7 ,
			NULL AS VAL7 ,
			'NA' AS KEY8 ,
			NULL AS VAL8 ,
			'NA' AS KEY9 ,
			NULL AS VAL9 ,
			'NA' AS KEY10 ,
			NULL AS VAL10 ,
			TT.ItemCreatedBy ,
			TT.ItemCreatedWhen ,
			TT.ItemModifiedBy ,
			TT.ItemModifiedWhen ,
			NULL AS IsProcessedForHa ,
			'NA' AS TXTKEY1 ,
			NULL AS TXTVAL1 ,
			'NA' AS TXTKEY2 ,
			NULL AS TXTVAL2 ,
			'NA' AS TXTKEY3 ,
			NULL AS TXTVAL3 ,
			NULL AS ItemOrder ,
			NULL AS ItemGuid ,
			C.UserGuid ,
			PP.MPI ,
			PP.ClientCode ,
			S.SiteGUID ,
			ACCT.AccountID ,
			ACCT.AccountCD ,
			T.IsAvailable ,
			T.IsCustom ,
			T.UniqueName ,
			T.UniqueName AS ColDesc ,
			NULL AS VendorID	--VENDOR.ItemID as VendorID
			,
			NULL AS VendorName --VENDOR.VendorName
	   FROM dbo.HFit_TrackerInstance_Tracker AS TT
				INNER JOIN dbo.CMS_User AS C
					ON C.UserID = TT.UserID
				INNER JOIN dbo.hfit_ppteligibility AS PP
					ON TT.UserID = PP.userID
				INNER JOIN dbo.HFit_Account AS ACCT
					ON PP.ClientCode = ACCT.AccountCD
				INNER JOIN dbo.CMS_Site AS S
					ON ACCT.SiteID = S.SiteID
				INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
					ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
				LEFT OUTER JOIN dbo.HFIT_Tracker AS T
					ON T.AggregateTableName = 'HFit_TrackerInstance_Tracker'
	 --left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
	 UNION
	 SELECT 'HFit_TrackerMealPortions' AS TrackerNameAggregateTable ,
			TT.ItemID ,
			EventDate ,
			TT.IsProfessionallyCollected ,
			TT.TrackerCollectionSourceID ,
			Notes ,
			TT.UserID ,
			CollectionSourceName_Internal ,
			CollectionSourceName_External ,
			'MISSING' AS EventName ,
			'NA-portion' AS UOM ,
			'Portions' AS KEY1 ,
			CAST (Portions AS float) AS VAL1 ,
			'NA' AS KEY2 ,
			NULL AS VAL2 ,
			'NA' AS KEY3 ,
			NULL AS VAL3 ,
			'NA' AS KEY4 ,
			NULL AS VAL4 ,
			'NA' AS KEY5 ,
			NULL AS VAL5 ,
			'NA' AS KEY6 ,
			NULL AS VAL6 ,
			'NA' AS KEY7 ,
			NULL AS VAL7 ,
			'NA' AS KEY8 ,
			NULL AS VAL8 ,
			'NA' AS KEY9 ,
			NULL AS VAL9 ,
			'NA' AS KEY10 ,
			NULL AS VAL10 ,
			TT.ItemCreatedBy ,
			TT.ItemCreatedWhen ,
			TT.ItemModifiedBy ,
			TT.ItemModifiedWhen ,
			NULL AS IsProcessedForHa ,
			'NA' AS TXTKEY1 ,
			NULL AS TXTVAL1 ,
			'NA' AS TXTKEY2 ,
			NULL AS TXTVAL2 ,
			'NA' AS TXTKEY3 ,
			NULL AS TXTVAL3 ,
			NULL AS ItemOrder ,
			NULL AS ItemGuid ,
			C.UserGuid ,
			PP.MPI ,
			PP.ClientCode ,
			S.SiteGUID ,
			ACCT.AccountID ,
			ACCT.AccountCD ,
			T.IsAvailable ,
			T.IsCustom ,
			T.UniqueName ,
			T.UniqueName AS ColDesc ,
			NULL AS VendorID	--VENDOR.ItemID as VendorID
			,
			NULL AS VendorName --VENDOR.VendorName
	   FROM dbo.HFit_TrackerMealPortions AS TT
				INNER JOIN dbo.CMS_User AS C
					ON C.UserID = TT.UserID
				INNER JOIN dbo.hfit_ppteligibility AS PP
					ON TT.UserID = PP.userID
				INNER JOIN dbo.HFit_Account AS ACCT
					ON PP.ClientCode = ACCT.AccountCD
				INNER JOIN dbo.CMS_Site AS S
					ON ACCT.SiteID = S.SiteID
				INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
					ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
				LEFT OUTER JOIN dbo.HFIT_Tracker AS T
					ON T.AggregateTableName = 'HFit_TrackerMealPortions'
	 --left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
	 UNION
	 SELECT 'HFit_TrackerMedicalCarePlan' AS TrackerNameAggregateTable ,
			TT.ItemID ,
			EventDate ,
			TT.IsProfessionallyCollected ,
			TT.TrackerCollectionSourceID ,
			Notes ,
			TT.UserID ,
			CollectionSourceName_Internal ,
			CollectionSourceName_External ,
			'MISSING' AS EventName ,
			'Y/N' AS UOM ,
			'FollowedPlan' AS KEY1 ,
			CAST (FollowedPlan AS float) AS VAL1 ,
			'NA' AS KEY2 ,
			NULL AS VAL2 ,
			'NA' AS KEY3 ,
			NULL AS VAL3 ,
			'NA' AS KEY4 ,
			NULL AS VAL4 ,
			'NA' AS KEY5 ,
			NULL AS VAL5 ,
			'NA' AS KEY6 ,
			NULL AS VAL6 ,
			'NA' AS KEY7 ,
			NULL AS VAL7 ,
			'NA' AS KEY8 ,
			NULL AS VAL8 ,
			'NA' AS KEY9 ,
			NULL AS VAL9 ,
			'NA' AS KEY10 ,
			NULL AS VAL10 ,
			TT.ItemCreatedBy ,
			TT.ItemCreatedWhen ,
			TT.ItemModifiedBy ,
			TT.ItemModifiedWhen ,
			NULL AS IsProcessedForHa ,
			'NA' AS TXTKEY1 ,
			NULL AS TXTVAL1 ,
			'NA' AS TXTKEY2 ,
			NULL AS TXTVAL2 ,
			'NA' AS TXTKEY3 ,
			NULL AS TXTVAL3 ,
			NULL AS ItemOrder ,
			NULL AS ItemGuid ,
			C.UserGuid ,
			PP.MPI ,
			PP.ClientCode ,
			S.SiteGUID ,
			ACCT.AccountID ,
			ACCT.AccountCD ,
			T.IsAvailable ,
			T.IsCustom ,
			T.UniqueName ,
			T.UniqueName AS ColDesc ,
			NULL AS VendorID	--VENDOR.ItemID as VendorID
			,
			NULL AS VendorName --VENDOR.VendorName
	   FROM dbo.HFit_TrackerMedicalCarePlan AS TT
				INNER JOIN dbo.CMS_User AS C
					ON C.UserID = TT.UserID
				INNER JOIN dbo.hfit_ppteligibility AS PP
					ON TT.UserID = PP.userID
				INNER JOIN dbo.HFit_Account AS ACCT
					ON PP.ClientCode = ACCT.AccountCD
				INNER JOIN dbo.CMS_Site AS S
					ON ACCT.SiteID = S.SiteID
				INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
					ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
				LEFT OUTER JOIN dbo.HFIT_Tracker AS T
					ON T.AggregateTableName = 'HFit_TrackerMedicalCarePlan'
	 --left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
	 UNION
	 SELECT 'HFit_TrackerRegularMeals' AS TrackerNameAggregateTable ,
			TT.ItemID ,
			EventDate ,
			TT.IsProfessionallyCollected ,
			TT.TrackerCollectionSourceID ,
			Notes ,
			TT.UserID ,
			CollectionSourceName_Internal ,
			CollectionSourceName_External ,
			'MISSING' AS EventName ,
			'Occurs' AS UOM ,
			'Units' AS KEY1 ,
			CAST (Units AS float) AS VAL1 ,
			'NA' AS KEY2 ,
			NULL AS VAL2 ,
			'NA' AS KEY3 ,
			NULL AS VAL3 ,
			'NA' AS KEY4 ,
			NULL AS VAL4 ,
			'NA' AS KEY5 ,
			NULL AS VAL5 ,
			'NA' AS KEY6 ,
			NULL AS VAL6 ,
			'NA' AS KEY7 ,
			NULL AS VAL7 ,
			'NA' AS KEY8 ,
			NULL AS VAL8 ,
			'NA' AS KEY9 ,
			NULL AS VAL9 ,
			'NA' AS KEY10 ,
			NULL AS VAL10 ,
			TT.ItemCreatedBy ,
			TT.ItemCreatedWhen ,
			TT.ItemModifiedBy ,
			TT.ItemModifiedWhen ,
			NULL AS IsProcessedForHa ,
			'NA' AS TXTKEY1 ,
			NULL AS TXTVAL1 ,
			'NA' AS TXTKEY2 ,
			NULL AS TXTVAL2 ,
			'NA' AS TXTKEY3 ,
			NULL AS TXTVAL3 ,
			NULL AS ItemOrder ,
			NULL AS ItemGuid ,
			C.UserGuid ,
			PP.MPI ,
			PP.ClientCode ,
			S.SiteGUID ,
			ACCT.AccountID ,
			ACCT.AccountCD ,
			T.IsAvailable ,
			T.IsCustom ,
			T.UniqueName ,
			T.UniqueName AS ColDesc ,
			NULL AS VendorID	--VENDOR.ItemID as VendorID
			,
			NULL AS VendorName --VENDOR.VendorName
	   FROM dbo.HFit_TrackerRegularMeals AS TT
				INNER JOIN dbo.CMS_User AS C
					ON C.UserID = TT.UserID
				INNER JOIN dbo.hfit_ppteligibility AS PP
					ON TT.UserID = PP.userID
				INNER JOIN dbo.HFit_Account AS ACCT
					ON PP.ClientCode = ACCT.AccountCD
				INNER JOIN dbo.CMS_Site AS S
					ON ACCT.SiteID = S.SiteID
				INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
					ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
				LEFT OUTER JOIN dbo.HFIT_Tracker AS T
					ON T.AggregateTableName = 'HFit_TrackerRegularMeals'
	 --left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
	 UNION
	 SELECT 'HFit_TrackerRestingHeartRate' AS TrackerNameAggregateTable ,
			TT.ItemID ,
			EventDate ,
			TT.IsProfessionallyCollected ,
			TT.TrackerCollectionSourceID ,
			Notes ,
			TT.UserID ,
			CollectionSourceName_Internal ,
			CollectionSourceName_External ,
			'MISSING' AS EventName ,
			'BPM' AS UOM ,
			'HeartRate' AS KEY1 ,
			CAST (HeartRate AS float) AS VAL1 ,
			'NA' AS KEY2 ,
			NULL AS VAL2 ,
			'NA' AS KEY3 ,
			NULL AS VAL3 ,
			'NA' AS KEY4 ,
			NULL AS VAL4 ,
			'NA' AS KEY5 ,
			NULL AS VAL5 ,
			'NA' AS KEY6 ,
			NULL AS VAL6 ,
			'NA' AS KEY7 ,
			NULL AS VAL7 ,
			'NA' AS KEY8 ,
			NULL AS VAL8 ,
			'NA' AS KEY9 ,
			NULL AS VAL9 ,
			'NA' AS KEY10 ,
			NULL AS VAL10 ,
			TT.ItemCreatedBy ,
			TT.ItemCreatedWhen ,
			TT.ItemModifiedBy ,
			TT.ItemModifiedWhen ,
			NULL AS IsProcessedForHa ,
			'NA' AS TXTKEY1 ,
			NULL AS TXTVAL1 ,
			'NA' AS TXTKEY2 ,
			NULL AS TXTVAL2 ,
			'NA' AS TXTKEY3 ,
			NULL AS TXTVAL3 ,
			NULL AS ItemOrder ,
			NULL AS ItemGuid ,
			C.UserGuid ,
			PP.MPI ,
			PP.ClientCode ,
			S.SiteGUID ,
			ACCT.AccountID ,
			ACCT.AccountCD ,
			T.IsAvailable ,
			T.IsCustom ,
			T.UniqueName ,
			T.UniqueName AS ColDesc ,
			VENDOR.ItemID AS VendorID ,
			VENDOR.VendorName
	   FROM dbo.HFit_TrackerRestingHeartRate AS TT
				INNER JOIN dbo.CMS_User AS C
					ON C.UserID = TT.UserID
				INNER JOIN dbo.hfit_ppteligibility AS PP
					ON TT.UserID = PP.userID
				INNER JOIN dbo.HFit_Account AS ACCT
					ON PP.ClientCode = ACCT.AccountCD
				INNER JOIN dbo.CMS_Site AS S
					ON ACCT.SiteID = S.SiteID
				INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
					ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
				LEFT OUTER JOIN dbo.HFIT_Tracker AS T
					ON T.AggregateTableName = 'HFit_TrackerRestingHeartRate'
				LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
					ON TT.VendorID = VENDOR.ItemID
	 UNION
	 SELECT 'HFit_TrackerShots' AS TrackerNameAggregateTable ,
			TT.ItemID ,
			EventDate ,
			TT.IsProfessionallyCollected ,
			TT.TrackerCollectionSourceID ,
			Notes ,
			TT.UserID ,
			CollectionSourceName_Internal ,
			CollectionSourceName_External ,
			'MISSING' AS EventName ,
			'Y/N' AS UOM ,
			'FluShot' AS KEY1 ,
			CAST (FluShot AS float) AS VAL1 ,
			'PneumoniaShot' AS KEY2 ,
			CAST (PneumoniaShot AS float) AS VAL2 ,
			'NA' AS KEY3 ,
			NULL AS VAL3 ,
			'NA' AS KEY4 ,
			NULL AS VAL4 ,
			'NA' AS KEY5 ,
			NULL AS VAL5 ,
			'NA' AS KEY6 ,
			NULL AS VAL6 ,
			'NA' AS KEY7 ,
			NULL AS VAL7 ,
			'NA' AS KEY8 ,
			NULL AS VAL8 ,
			'NA' AS KEY9 ,
			NULL AS VAL9 ,
			'NA' AS KEY10 ,
			NULL AS VAL10 ,
			TT.ItemCreatedBy ,
			TT.ItemCreatedWhen ,
			TT.ItemModifiedBy ,
			TT.ItemModifiedWhen ,
			NULL AS IsProcessedForHa ,
			'NA' AS TXTKEY1 ,
			NULL AS TXTVAL1 ,
			'NA' AS TXTKEY2 ,
			NULL AS TXTVAL2 ,
			'NA' AS TXTKEY3 ,
			NULL AS TXTVAL3 ,
			TT.ItemOrder ,
			TT.ItemGuid ,
			C.UserGuid ,
			PP.MPI ,
			PP.ClientCode ,
			S.SiteGUID ,
			ACCT.AccountID ,
			ACCT.AccountCD ,
			T.IsAvailable ,
			T.IsCustom ,
			T.UniqueName ,
			T.UniqueName AS ColDesc ,
			VENDOR.ItemID AS VendorID ,
			VENDOR.VendorName
	   FROM dbo.HFit_TrackerShots AS TT
				INNER JOIN dbo.CMS_User AS C
					ON C.UserID = TT.UserID
				INNER JOIN dbo.hfit_ppteligibility AS PP
					ON TT.UserID = PP.userID
				INNER JOIN dbo.HFit_Account AS ACCT
					ON PP.ClientCode = ACCT.AccountCD
				INNER JOIN dbo.CMS_Site AS S
					ON ACCT.SiteID = S.SiteID
				INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
					ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
				LEFT OUTER JOIN dbo.HFIT_Tracker AS T
					ON T.AggregateTableName = 'HFit_TrackerShots'
				LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
					ON TT.VendorID = VENDOR.ItemID
	 UNION
	 SELECT 'HFit_TrackerSitLess' AS TrackerNameAggregateTable ,
			TT.ItemID ,
			EventDate ,
			TT.IsProfessionallyCollected ,
			TT.TrackerCollectionSourceID ,
			Notes ,
			TT.UserID ,
			CollectionSourceName_Internal ,
			CollectionSourceName_External ,
			'MISSING' AS EventName ,
			'Occurs' AS UOM ,
			'Times' AS KEY1 ,
			CAST (Times AS float) AS VAL1 ,
			'NA' AS KEY2 ,
			NULL AS VAL2 ,
			'NA' AS KEY3 ,
			NULL AS VAL3 ,
			'NA' AS KEY4 ,
			NULL AS VAL4 ,
			'NA' AS KEY5 ,
			NULL AS VAL5 ,
			'NA' AS KEY6 ,
			NULL AS VAL6 ,
			'NA' AS KEY7 ,
			NULL AS VAL7 ,
			'NA' AS KEY8 ,
			NULL AS VAL8 ,
			'NA' AS KEY9 ,
			NULL AS VAL9 ,
			'NA' AS KEY10 ,
			NULL AS VAL10 ,
			TT.ItemCreatedBy ,
			TT.ItemCreatedWhen ,
			TT.ItemModifiedBy ,
			TT.ItemModifiedWhen ,
			NULL AS IsProcessedForHa ,
			'NA' AS TXTKEY1 ,
			NULL AS TXTVAL1 ,
			'NA' AS TXTKEY2 ,
			NULL AS TXTVAL2 ,
			'NA' AS TXTKEY3 ,
			NULL AS TXTVAL3 ,
			NULL AS ItemOrder ,
			NULL AS ItemGuid ,
			C.UserGuid ,
			PP.MPI ,
			PP.ClientCode ,
			S.SiteGUID ,
			ACCT.AccountID ,
			ACCT.AccountCD ,
			T.IsAvailable ,
			T.IsCustom ,
			T.UniqueName ,
			T.UniqueName AS ColDesc ,
			NULL AS VendorID	--VENDOR.ItemID as VendorID
			,
			NULL AS VendorName --VENDOR.VendorName
	   FROM dbo.HFit_TrackerSitLess AS TT
				INNER JOIN dbo.CMS_User AS C
					ON C.UserID = TT.UserID
				INNER JOIN dbo.hfit_ppteligibility AS PP
					ON TT.UserID = PP.userID
				INNER JOIN dbo.HFit_Account AS ACCT
					ON PP.ClientCode = ACCT.AccountCD
				INNER JOIN dbo.CMS_Site AS S
					ON ACCT.SiteID = S.SiteID
				INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
					ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
				LEFT OUTER JOIN dbo.HFIT_Tracker AS T
					ON T.AggregateTableName = 'HFit_TrackerSitLess'
	 --left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
	 UNION
	 SELECT 'HFit_TrackerSleepPlan' AS TrackerNameAggregateTable ,
			TT.ItemID ,
			EventDate ,
			TT.IsProfessionallyCollected ,
			TT.TrackerCollectionSourceID ,
			Notes ,
			TT.UserID ,
			CollectionSourceName_Internal ,
			CollectionSourceName_External ,
			'MISSING' AS EventName ,
			'HR' AS UOM ,
			'DidFollow' AS KEY1 ,
			CAST (DidFollow AS float) AS VAL1 ,
			'HoursSlept' AS KEY2 ,
			HoursSlept AS VAL2 ,
			'NA' AS KEY3 ,
			NULL AS VAL3 ,
			'NA' AS KEY4 ,
			NULL AS VAL4 ,
			'NA' AS KEY5 ,
			NULL AS VAL5 ,
			'NA' AS KEY6 ,
			NULL AS VAL6 ,
			'NA' AS KEY7 ,
			NULL AS VAL7 ,
			'NA' AS KEY8 ,
			NULL AS VAL8 ,
			'NA' AS KEY9 ,
			NULL AS VAL9 ,
			'NA' AS KEY10 ,
			NULL AS VAL10 ,
			TT.ItemCreatedBy ,
			TT.ItemCreatedWhen ,
			TT.ItemModifiedBy ,
			TT.ItemModifiedWhen ,
			NULL AS IsProcessedForHa ,
			'Techniques' AS TXTKEY1 ,
			Techniques AS TXTVAL1 ,
			'NA' AS TXTKEY2 ,
			NULL AS TXTVAL2 ,
			'NA' AS TXTKEY3 ,
			NULL AS TXTVAL3 ,
			NULL AS ItemOrder ,
			NULL AS ItemGuid ,
			C.UserGuid ,
			PP.MPI ,
			PP.ClientCode ,
			S.SiteGUID ,
			ACCT.AccountID ,
			ACCT.AccountCD ,
			T.IsAvailable ,
			T.IsCustom ,
			T.UniqueName ,
			T.UniqueName AS ColDesc ,
			NULL AS VendorID	--VENDOR.ItemID as VendorID
			,
			NULL AS VendorName --VENDOR.VendorName
	   FROM dbo.HFit_TrackerSleepPlan AS TT
				INNER JOIN dbo.CMS_User AS C
					ON C.UserID = TT.UserID
				INNER JOIN dbo.hfit_ppteligibility AS PP
					ON TT.UserID = PP.userID
				INNER JOIN dbo.HFit_Account AS ACCT
					ON PP.ClientCode = ACCT.AccountCD
				INNER JOIN dbo.CMS_Site AS S
					ON ACCT.SiteID = S.SiteID
				INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
					ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
				LEFT OUTER JOIN dbo.HFIT_Tracker AS T
					ON T.AggregateTableName = 'HFit_TrackerSleepPlan'
	 --left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
	 UNION
	 SELECT 'HFit_TrackerStrength' AS TrackerNameAggregateTable ,
			TT.ItemID ,
			EventDate ,
			TT.IsProfessionallyCollected ,
			TT.TrackerCollectionSourceID ,
			Notes ,
			TT.UserID ,
			CollectionSourceName_Internal ,
			CollectionSourceName_External ,
			'MISSING' AS EventName ,
			'Y/N' AS UOM ,
			'HasTrained' AS KEY1 ,
			CAST (HasTrained AS float) AS VAL1 ,
			'NA' AS KEY2 ,
			NULL AS VAL2 ,
			'NA' AS KEY3 ,
			NULL AS VAL3 ,
			'NA' AS KEY4 ,
			NULL AS VAL4 ,
			'NA' AS KEY5 ,
			NULL AS VAL5 ,
			'NA' AS KEY6 ,
			NULL AS VAL6 ,
			'NA' AS KEY7 ,
			NULL AS VAL7 ,
			'NA' AS KEY8 ,
			NULL AS VAL8 ,
			'NA' AS KEY9 ,
			NULL AS VAL9 ,
			'NA' AS KEY10 ,
			NULL AS VAL10 ,
			TT.ItemCreatedBy ,
			TT.ItemCreatedWhen ,
			TT.ItemModifiedBy ,
			TT.ItemModifiedWhen ,
			NULL AS IsProcessedForHa ,
			'Activity' AS TXTKEY1 ,
			Activity AS TXTVAL1 ,
			'NA' AS TXTKEY2 ,
			NULL AS TXTVAL2 ,
			'NA' AS TXTKEY3 ,
			NULL AS TXTVAL3 ,
			NULL AS ItemOrder ,
			NULL AS ItemGuid ,
			C.UserGuid ,
			PP.MPI ,
			PP.ClientCode ,
			S.SiteGUID ,
			ACCT.AccountID ,
			ACCT.AccountCD ,
			T.IsAvailable ,
			T.IsCustom ,
			T.UniqueName ,
			T.UniqueName AS ColDesc ,
			NULL AS VendorID	--VENDOR.ItemID as VendorID
			,
			NULL AS VendorName --VENDOR.VendorName
	   FROM dbo.HFit_TrackerStrength AS TT
				INNER JOIN dbo.CMS_User AS C
					ON C.UserID = TT.UserID
				INNER JOIN dbo.hfit_ppteligibility AS PP
					ON TT.UserID = PP.userID
				INNER JOIN dbo.HFit_Account AS ACCT
					ON PP.ClientCode = ACCT.AccountCD
				INNER JOIN dbo.CMS_Site AS S
					ON ACCT.SiteID = S.SiteID
				INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
					ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
				LEFT OUTER JOIN dbo.HFIT_Tracker AS T
					ON T.AggregateTableName = 'HFit_TrackerStrength'
	 --left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
	 UNION
	 SELECT 'HFit_TrackerStress' AS TrackerNameAggregateTable ,
			TT.ItemID ,
			EventDate ,
			TT.IsProfessionallyCollected ,
			TT.TrackerCollectionSourceID ,
			Notes ,
			TT.UserID ,
			CollectionSourceName_Internal ,
			CollectionSourceName_External ,
			'MISSING' AS EventName ,
			'gradient' AS UOM ,
			'Intensity' AS KEY1 ,
			CAST (Intensity AS float) AS VAL1 ,
			'NA' AS KEY2 ,
			NULL AS VAL2 ,
			'NA' AS KEY3 ,
			NULL AS VAL3 ,
			'NA' AS KEY4 ,
			NULL AS VAL4 ,
			'NA' AS KEY5 ,
			NULL AS VAL5 ,
			'NA' AS KEY6 ,
			NULL AS VAL6 ,
			'NA' AS KEY7 ,
			NULL AS VAL7 ,
			'NA' AS KEY8 ,
			NULL AS VAL8 ,
			'NA' AS KEY9 ,
			NULL AS VAL9 ,
			'NA' AS KEY10 ,
			NULL AS VAL10 ,
			TT.ItemCreatedBy ,
			TT.ItemCreatedWhen ,
			TT.ItemModifiedBy ,
			TT.ItemModifiedWhen ,
			NULL AS IsProcessedForHa ,
			'Awareness' AS TXTKEY1 ,
			Awareness AS TXTVAL1 ,
			'NA' AS TXTKEY2 ,
			NULL AS TXTVAL2 ,
			'NA' AS TXTKEY3 ,
			NULL AS TXTVAL3 ,
			NULL AS ItemOrder ,
			NULL AS ItemGuid ,
			C.UserGuid ,
			PP.MPI ,
			PP.ClientCode ,
			S.SiteGUID ,
			ACCT.AccountID ,
			ACCT.AccountCD ,
			T.IsAvailable ,
			T.IsCustom ,
			T.UniqueName ,
			T.UniqueName AS ColDesc ,
			NULL AS VendorID	--VENDOR.ItemID as VendorID
			,
			NULL AS VendorName --VENDOR.VendorName
	   FROM dbo.HFit_TrackerStress AS TT
				INNER JOIN dbo.CMS_User AS C
					ON C.UserID = TT.UserID
				INNER JOIN dbo.hfit_ppteligibility AS PP
					ON TT.UserID = PP.userID
				INNER JOIN dbo.HFit_Account AS ACCT
					ON PP.ClientCode = ACCT.AccountCD
				INNER JOIN dbo.CMS_Site AS S
					ON ACCT.SiteID = S.SiteID
				INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
					ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
				LEFT OUTER JOIN dbo.HFIT_Tracker AS T
					ON T.AggregateTableName = 'HFit_TrackerStress'
	 --left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
	 UNION
	 SELECT 'HFit_TrackerStressManagement' AS TrackerNameAggregateTable ,
			TT.ItemID ,
			EventDate ,
			TT.IsProfessionallyCollected ,
			TT.TrackerCollectionSourceID ,
			Notes ,
			TT.UserID ,
			CollectionSourceName_Internal ,
			CollectionSourceName_External ,
			'MISSING' AS EventName ,
			'gradient' AS UOM ,
			'HasPracticed' AS KEY1 ,
			CAST (HasPracticed AS float) AS VAL1 ,
			'Effectiveness' AS KEY2 ,
			CAST (Effectiveness AS float) AS VAL2 ,
			'NA' AS KEY3 ,
			NULL AS VAL3 ,
			'NA' AS KEY4 ,
			NULL AS VAL4 ,
			'NA' AS KEY5 ,
			NULL AS VAL5 ,
			'NA' AS KEY6 ,
			NULL AS VAL6 ,
			'NA' AS KEY7 ,
			NULL AS VAL7 ,
			'NA' AS KEY8 ,
			NULL AS VAL8 ,
			'NA' AS KEY9 ,
			NULL AS VAL9 ,
			'NA' AS KEY10 ,
			NULL AS VAL10 ,
			TT.ItemCreatedBy ,
			TT.ItemCreatedWhen ,
			TT.ItemModifiedBy ,
			TT.ItemModifiedWhen ,
			NULL AS IsProcessedForHa ,
			'Activity' AS TXTKEY1 ,
			Activity AS TXTVAL1 ,
			'NA' AS TXTKEY2 ,
			NULL AS TXTVAL2 ,
			'NA' AS TXTKEY3 ,
			NULL AS TXTVAL3 ,
			NULL AS ItemOrder ,
			NULL AS ItemGuid ,
			C.UserGuid ,
			PP.MPI ,
			PP.ClientCode ,
			S.SiteGUID ,
			ACCT.AccountID ,
			ACCT.AccountCD ,
			T.IsAvailable ,
			T.IsCustom ,
			T.UniqueName ,
			T.UniqueName AS ColDesc ,
			NULL AS VendorID	--VENDOR.ItemID as VendorID
			,
			NULL AS VendorName --VENDOR.VendorName
	   FROM dbo.HFit_TrackerStressManagement AS TT
				INNER JOIN dbo.CMS_User AS C
					ON C.UserID = TT.UserID
				INNER JOIN dbo.hfit_ppteligibility AS PP
					ON TT.UserID = PP.userID
				INNER JOIN dbo.HFit_Account AS ACCT
					ON PP.ClientCode = ACCT.AccountCD
				INNER JOIN dbo.CMS_Site AS S
					ON ACCT.SiteID = S.SiteID
				INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
					ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
				LEFT OUTER JOIN dbo.HFIT_Tracker AS T
					ON T.AggregateTableName = 'HFit_TrackerStressManagement'
	 --left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
	 UNION
	 SELECT 'HFit_TrackerSugaryDrinks' AS TrackerNameAggregateTable ,
			TT.ItemID ,
			EventDate ,
			TT.IsProfessionallyCollected ,
			TT.TrackerCollectionSourceID ,
			Notes ,
			TT.UserID ,
			CollectionSourceName_Internal ,
			CollectionSourceName_External ,
			'MISSING' AS EventName ,
			'OZ' AS UOM ,
			'Ounces' AS KEY1 ,
			CAST (Ounces AS float) AS VAL1 ,
			'NA' AS KEY2 ,
			NULL AS VAL2 ,
			'NA' AS KEY3 ,
			NULL AS VAL3 ,
			'NA' AS KEY4 ,
			NULL AS VAL4 ,
			'NA' AS KEY5 ,
			NULL AS VAL5 ,
			'NA' AS KEY6 ,
			NULL AS VAL6 ,
			'NA' AS KEY7 ,
			NULL AS VAL7 ,
			'NA' AS KEY8 ,
			NULL AS VAL8 ,
			'NA' AS KEY9 ,
			NULL AS VAL9 ,
			'NA' AS KEY10 ,
			NULL AS VAL10 ,
			TT.ItemCreatedBy ,
			TT.ItemCreatedWhen ,
			TT.ItemModifiedBy ,
			TT.ItemModifiedWhen ,
			NULL AS IsProcessedForHa ,
			'NA' AS TXTKEY1 ,
			NULL AS TXTVAL1 ,
			'NA' AS TXTKEY2 ,
			NULL AS TXTVAL2 ,
			'NA' AS TXTKEY3 ,
			NULL AS TXTVAL3 ,
			NULL AS ItemOrder ,
			NULL AS ItemGuid ,
			C.UserGuid ,
			PP.MPI ,
			PP.ClientCode ,
			S.SiteGUID ,
			ACCT.AccountID ,
			ACCT.AccountCD ,
			T.IsAvailable ,
			T.IsCustom ,
			T.UniqueName ,
			T.UniqueName AS ColDesc ,
			NULL AS VendorID	--VENDOR.ItemID as VendorID
			,
			NULL AS VendorName --VENDOR.VendorName
	   FROM dbo.HFit_TrackerSugaryDrinks AS TT
				INNER JOIN dbo.CMS_User AS C
					ON C.UserID = TT.UserID
				INNER JOIN dbo.hfit_ppteligibility AS PP
					ON TT.UserID = PP.userID
				INNER JOIN dbo.HFit_Account AS ACCT
					ON PP.ClientCode = ACCT.AccountCD
				INNER JOIN dbo.CMS_Site AS S
					ON ACCT.SiteID = S.SiteID
				INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
					ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
				LEFT OUTER JOIN dbo.HFIT_Tracker AS T
					ON T.AggregateTableName = 'HFit_TrackerSugaryDrinks'
	 --left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
	 UNION
	 SELECT 'HFit_TrackerSugaryFoods' AS TrackerNameAggregateTable ,
			TT.ItemID ,
			EventDate ,
			TT.IsProfessionallyCollected ,
			TT.TrackerCollectionSourceID ,
			Notes ,
			TT.UserID ,
			CollectionSourceName_Internal ,
			CollectionSourceName_External ,
			'MISSING' AS EventName ,
			'NA-portion' AS UOM ,
			'Portions' AS KEY1 ,
			CAST (Portions AS float) AS VAL1 ,
			'NA' AS KEY2 ,
			NULL AS VAL2 ,
			'NA' AS KEY3 ,
			NULL AS VAL3 ,
			'NA' AS KEY4 ,
			NULL AS VAL4 ,
			'NA' AS KEY5 ,
			NULL AS VAL5 ,
			'NA' AS KEY6 ,
			NULL AS VAL6 ,
			'NA' AS KEY7 ,
			NULL AS VAL7 ,
			'NA' AS KEY8 ,
			NULL AS VAL8 ,
			'NA' AS KEY9 ,
			NULL AS VAL9 ,
			'NA' AS KEY10 ,
			NULL AS VAL10 ,
			TT.ItemCreatedBy ,
			TT.ItemCreatedWhen ,
			TT.ItemModifiedBy ,
			TT.ItemModifiedWhen ,
			NULL AS IsProcessedForHa ,
			'NA' AS TXTKEY1 ,
			NULL AS TXTVAL1 ,
			'NA' AS TXTKEY2 ,
			NULL AS TXTVAL2 ,
			'NA' AS TXTKEY3 ,
			NULL AS TXTVAL3 ,
			NULL AS ItemOrder ,
			NULL AS ItemGuid ,
			C.UserGuid ,
			PP.MPI ,
			PP.ClientCode ,
			S.SiteGUID ,
			ACCT.AccountID ,
			ACCT.AccountCD ,
			T.IsAvailable ,
			T.IsCustom ,
			T.UniqueName ,
			T.UniqueName AS ColDesc ,
			NULL AS VendorID	--VENDOR.ItemID as VendorID
			,
			NULL AS VendorName --VENDOR.VendorName
	   FROM dbo.HFit_TrackerSugaryFoods AS TT
				INNER JOIN dbo.CMS_User AS C
					ON C.UserID = TT.UserID
				INNER JOIN dbo.hfit_ppteligibility AS PP
					ON TT.UserID = PP.userID
				INNER JOIN dbo.HFit_Account AS ACCT
					ON PP.ClientCode = ACCT.AccountCD
				INNER JOIN dbo.CMS_Site AS S
					ON ACCT.SiteID = S.SiteID
				INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
					ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
				LEFT OUTER JOIN dbo.HFIT_Tracker AS T
					ON T.AggregateTableName = 'HFit_TrackerSugaryFoods'
	 --left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
	 UNION
	 SELECT 'HFit_TrackerTests' AS TrackerNameAggregateTable ,
			TT.ItemID ,
			EventDate ,
			TT.IsProfessionallyCollected ,
			TT.TrackerCollectionSourceID ,
			Notes ,
			TT.UserID ,
			CollectionSourceName_Internal ,
			CollectionSourceName_External ,
			'MISSING' AS EventName ,
			'NA' AS UOM ,
			'PSATest' AS KEY1 ,
			CAST (PSATest AS float) AS VAL1 ,
			'OtherExam' AS KEY1 ,
			CAST (OtherExam AS float) AS VAL2 ,
			'TScore' AS KEY3 ,
			CAST (TScore AS float) AS VAL3 ,
			'DRA' AS KEY4 ,
			CAST (DRA AS float) AS VAL4 ,
			'CotinineTest' AS KEY5 ,
			CAST (CotinineTest AS float) AS VAL5 ,
			'ColoCareKit' AS KEY6 ,
			CAST (ColoCareKit AS float) AS VAL6 ,
			'CustomTest' AS KEY7 ,
			CAST (CustomTest AS float) AS VAL7 ,
			'TSH' AS KEY8 ,
			CAST (TSH AS float) AS VAL8 ,
			'NA' AS KEY9 ,
			NULL AS VAL9 ,
			'NA' AS KEY10 ,
			NULL AS VAL10 ,
			TT.ItemCreatedBy ,
			TT.ItemCreatedWhen ,
			TT.ItemModifiedBy ,
			TT.ItemModifiedWhen ,
			NULL AS IsProcessedForHa ,
			'CustomDesc' AS TXTKEY1 ,
			CustomDesc AS TXTVAL1 ,
			'NA' AS TXTKEY2 ,
			NULL AS TXTVAL2 ,
			'NA' AS TXTKEY3 ,
			NULL AS TXTVAL3 ,
			TT.ItemOrder ,
			TT.ItemGuid ,
			C.UserGuid ,
			PP.MPI ,
			PP.ClientCode ,
			S.SiteGUID ,
			ACCT.AccountID ,
			ACCT.AccountCD ,
			T.IsAvailable ,
			T.IsCustom ,
			T.UniqueName ,
			T.UniqueName AS ColDesc ,
			VENDOR.ItemID AS VendorID ,
			VENDOR.VendorName
	   FROM dbo.HFit_TrackerTests AS TT
				INNER JOIN dbo.CMS_User AS C
					ON C.UserID = TT.UserID
				INNER JOIN dbo.hfit_ppteligibility AS PP
					ON TT.UserID = PP.userID
				INNER JOIN dbo.HFit_Account AS ACCT
					ON PP.ClientCode = ACCT.AccountCD
				INNER JOIN dbo.CMS_Site AS S
					ON ACCT.SiteID = S.SiteID
				INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
					ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
				LEFT OUTER JOIN dbo.HFIT_Tracker AS T
					ON T.AggregateTableName = 'HFit_TrackerTests'
				LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
					ON TT.VendorID = VENDOR.ItemID
	 UNION
	 SELECT 'HFit_TrackerTobaccoFree' AS TrackerNameAggregateTable ,
			TT.ItemID ,
			EventDate ,
			TT.IsProfessionallyCollected ,
			TT.TrackerCollectionSourceID ,
			Notes ,
			TT.UserID ,
			CollectionSourceName_Internal ,
			CollectionSourceName_External ,
			'MISSING' AS EventName ,
			'Y/N' AS UOM ,
			'WasTobaccoFree' AS KEY1 ,
			CAST (WasTobaccoFree AS float) AS VAL1 ,
			'NA' AS KEY2 ,
			NULL AS VAL2 ,
			'NA' AS KEY3 ,
			NULL AS VAL3 ,
			'NA' AS KEY4 ,
			NULL AS VAL4 ,
			'NA' AS KEY5 ,
			NULL AS VAL5 ,
			'NA' AS KEY6 ,
			NULL AS VAL6 ,
			'NA' AS KEY7 ,
			NULL AS VAL7 ,
			'NA' AS KEY8 ,
			NULL AS VAL8 ,
			'NA' AS KEY9 ,
			NULL AS VAL9 ,
			'NA' AS KEY10 ,
			NULL AS VAL10 ,
			TT.ItemCreatedBy ,
			TT.ItemCreatedWhen ,
			TT.ItemModifiedBy ,
			TT.ItemModifiedWhen ,
			NULL AS IsProcessedForHa ,
			'QuitAids' AS TXTKEY1 ,
			QuitAids AS TXTVAL1 ,
			'QuitMeds' AS TXTKEY2 ,
			QuitMeds AS TXTVAL2 ,
			'NA' AS TXTKEY3 ,
			NULL AS TXTVAL3 ,
			NULL AS ItemOrder ,
			NULL AS ItemGuid ,
			C.UserGuid ,
			PP.MPI ,
			PP.ClientCode ,
			S.SiteGUID ,
			ACCT.AccountID ,
			ACCT.AccountCD ,
			T.IsAvailable ,
			T.IsCustom ,
			T.UniqueName ,
			T.UniqueName AS ColDesc ,
			NULL AS VendorID	--VENDOR.ItemID as VendorID
			,
			NULL AS VendorName --VENDOR.VendorName
	   FROM dbo.HFit_TrackerTobaccoFree AS TT
				INNER JOIN dbo.CMS_User AS C
					ON C.UserID = TT.UserID
				INNER JOIN dbo.hfit_ppteligibility AS PP
					ON TT.UserID = PP.userID
				INNER JOIN dbo.HFit_Account AS ACCT
					ON PP.ClientCode = ACCT.AccountCD
				INNER JOIN dbo.CMS_Site AS S
					ON ACCT.SiteID = S.SiteID
				INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
					ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
				LEFT OUTER JOIN dbo.HFIT_Tracker AS T
					ON T.AggregateTableName = 'HFit_TrackerTobaccoFree'
	 --left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
	 UNION
	 SELECT 'HFit_TrackerVegetables' AS TrackerNameAggregateTable ,
			TT.ItemID ,
			EventDate ,
			TT.IsProfessionallyCollected ,
			TT.TrackerCollectionSourceID ,
			Notes ,
			TT.UserID ,
			CollectionSourceName_Internal ,
			CollectionSourceName_External ,
			'MISSING' AS EventName ,
			'CUP(8oz)' AS UOM ,
			'Cups' AS KEY1 ,
			CAST (Cups AS float) AS VAL1 ,
			'NA' AS KEY2 ,
			NULL AS VAL2 ,
			'NA' AS KEY3 ,
			NULL AS VAL3 ,
			'NA' AS KEY4 ,
			NULL AS VAL4 ,
			'NA' AS KEY5 ,
			NULL AS VAL5 ,
			'NA' AS KEY6 ,
			NULL AS VAL6 ,
			'NA' AS KEY7 ,
			NULL AS VAL7 ,
			'NA' AS KEY8 ,
			NULL AS VAL8 ,
			'NA' AS KEY9 ,
			NULL AS VAL9 ,
			'NA' AS KEY10 ,
			NULL AS VAL10 ,
			TT.ItemCreatedBy ,
			TT.ItemCreatedWhen ,
			TT.ItemModifiedBy ,
			TT.ItemModifiedWhen ,
			NULL AS IsProcessedForHa ,
			'NA' AS TXTKEY1 ,
			NULL AS TXTVAL1 ,
			'NA' AS TXTKEY2 ,
			NULL AS TXTVAL2 ,
			'NA' AS TXTKEY3 ,
			NULL AS TXTVAL3 ,
			NULL AS ItemOrder ,
			NULL AS ItemGuid ,
			C.UserGuid ,
			PP.MPI ,
			PP.ClientCode ,
			S.SiteGUID ,
			ACCT.AccountID ,
			ACCT.AccountCD ,
			T.IsAvailable ,
			T.IsCustom ,
			T.UniqueName ,
			T.UniqueName AS ColDesc ,
			NULL AS VendorID	--VENDOR.ItemID as VendorID
			,
			NULL AS VendorName --VENDOR.VendorName
	   FROM dbo.HFit_TrackerVegetables AS TT
				INNER JOIN dbo.CMS_User AS C
					ON C.UserID = TT.UserID
				INNER JOIN dbo.hfit_ppteligibility AS PP
					ON TT.UserID = PP.userID
				INNER JOIN dbo.HFit_Account AS ACCT
					ON PP.ClientCode = ACCT.AccountCD
				INNER JOIN dbo.CMS_Site AS S
					ON ACCT.SiteID = S.SiteID
				INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
					ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
				LEFT OUTER JOIN dbo.HFIT_Tracker AS T
					ON T.AggregateTableName = 'HFit_TrackerVegetables'
	 --left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
	 UNION
	 SELECT 'HFit_TrackerWater' AS TrackerNameAggregateTable ,
			TT.ItemID ,
			EventDate ,
			TT.IsProfessionallyCollected ,
			TT.TrackerCollectionSourceID ,
			Notes ,
			TT.UserID ,
			CollectionSourceName_Internal ,
			CollectionSourceName_External ,
			'MISSING' AS EventName ,
			'OZ' AS UOM ,
			'Ounces' AS KEY1 ,
			CAST (Ounces AS float) AS VAL1 ,
			'NA' AS KEY2 ,
			NULL AS VAL2 ,
			'NA' AS KEY3 ,
			NULL AS VAL3 ,
			'NA' AS KEY4 ,
			NULL AS VAL4 ,
			'NA' AS KEY5 ,
			NULL AS VAL5 ,
			'NA' AS KEY6 ,
			NULL AS VAL6 ,
			'NA' AS KEY7 ,
			NULL AS VAL7 ,
			'NA' AS KEY8 ,
			NULL AS VAL8 ,
			'NA' AS KEY9 ,
			NULL AS VAL9 ,
			'NA' AS KEY10 ,
			NULL AS VAL10 ,
			TT.ItemCreatedBy ,
			TT.ItemCreatedWhen ,
			TT.ItemModifiedBy ,
			TT.ItemModifiedWhen ,
			NULL AS IsProcessedForHa ,
			'NA' AS TXTKEY1 ,
			NULL AS TXTVAL1 ,
			'NA' AS TXTKEY2 ,
			NULL AS TXTVAL2 ,
			'NA' AS TXTKEY3 ,
			NULL AS TXTVAL3 ,
			NULL AS ItemOrder ,
			NULL AS ItemGuid ,
			C.UserGuid ,
			PP.MPI ,
			PP.ClientCode ,
			S.SiteGUID ,
			ACCT.AccountID ,
			ACCT.AccountCD ,
			T.IsAvailable ,
			T.IsCustom ,
			T.UniqueName ,
			T.UniqueName AS ColDesc ,
			NULL AS VendorID	--VENDOR.ItemID as VendorID
			,
			NULL AS VendorName --VENDOR.VendorName
	   FROM dbo.HFit_TrackerWater AS TT
				INNER JOIN dbo.CMS_User AS C
					ON C.UserID = TT.UserID
				INNER JOIN dbo.hfit_ppteligibility AS PP
					ON TT.UserID = PP.userID
				INNER JOIN dbo.HFit_Account AS ACCT
					ON PP.ClientCode = ACCT.AccountCD
				INNER JOIN dbo.CMS_Site AS S
					ON ACCT.SiteID = S.SiteID
				INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
					ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
				LEFT OUTER JOIN dbo.HFIT_Tracker AS T
					ON T.AggregateTableName = 'HFit_TrackerWater'
	 --left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
	 UNION
	 SELECT 'HFit_TrackerWeight' AS TrackerNameAggregateTable ,
			TT.ItemID ,
			EventDate ,
			TT.IsProfessionallyCollected ,
			TT.TrackerCollectionSourceID ,
			Notes ,
			TT.UserID ,
			CollectionSourceName_Internal ,
			CollectionSourceName_External ,
			'MISSING' AS EventName ,
			'LBS' AS UOM ,
			'Value' AS KEY1 ,
			[Value] AS VAL1 ,
			'NA' AS KEY2 ,
			NULL AS VAL2 ,
			'NA' AS KEY3 ,
			NULL AS VAL3 ,
			'NA' AS KEY4 ,
			NULL AS VAL4 ,
			'NA' AS KEY5 ,
			NULL AS VAL5 ,
			'NA' AS KEY6 ,
			NULL AS VAL6 ,
			'NA' AS KEY7 ,
			NULL AS VAL7 ,
			'NA' AS KEY8 ,
			NULL AS VAL8 ,
			'NA' AS KEY9 ,
			NULL AS VAL9 ,
			'NA' AS KEY10 ,
			NULL AS VAL10 ,
			TT.ItemCreatedBy ,
			TT.ItemCreatedWhen ,
			TT.ItemModifiedBy ,
			TT.ItemModifiedWhen ,
			IsProcessedForHa ,
			'NA' AS TXTKEY1 ,
			NULL AS TXTVAL1 ,
			'NA' AS TXTKEY2 ,
			NULL AS TXTVAL2 ,
			'NA' AS TXTKEY3 ,
			NULL AS TXTVAL3 ,
			NULL AS ItemOrder ,
			NULL AS ItemGuid ,
			C.UserGuid ,
			PP.MPI ,
			PP.ClientCode ,
			S.SiteGUID ,
			ACCT.AccountID ,
			ACCT.AccountCD ,
			T.IsAvailable ,
			T.IsCustom ,
			T.UniqueName ,
			T.UniqueName AS ColDesc ,
			VENDOR.ItemID AS VendorID ,
			VENDOR.VendorName
	   FROM dbo.HFit_TrackerWeight AS TT
				INNER JOIN dbo.CMS_User AS C
					ON C.UserID = TT.UserID
				INNER JOIN dbo.hfit_ppteligibility AS PP
					ON TT.UserID = PP.userID
				INNER JOIN dbo.HFit_Account AS ACCT
					ON PP.ClientCode = ACCT.AccountCD
				INNER JOIN dbo.CMS_Site AS S
					ON ACCT.SiteID = S.SiteID
				INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
					ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
				LEFT OUTER JOIN dbo.HFIT_Tracker AS T
					ON T.AggregateTableName = 'HFit_TrackerWeight'
				LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
					ON TT.VendorID = VENDOR.ItemID
	 UNION
	 SELECT 'HFit_TrackerWholeGrains' AS TrackerNameAggregateTable ,
			TT.ItemID ,
			EventDate ,
			TT.IsProfessionallyCollected ,
			TT.TrackerCollectionSourceID ,
			Notes ,
			TT.UserID ,
			CollectionSourceName_Internal ,
			CollectionSourceName_External ,
			'MISSING' AS EventName ,
			'NA-serving' AS UOM ,
			'Servings' AS KEY1 ,
			CAST (Servings AS float) AS VAL1 ,
			'NA' AS KEY2 ,
			NULL AS VAL2 ,
			'NA' AS KEY3 ,
			NULL AS VAL3 ,
			'NA' AS KEY4 ,
			NULL AS VAL4 ,
			'NA' AS KEY5 ,
			NULL AS VAL5 ,
			'NA' AS KEY6 ,
			NULL AS VAL6 ,
			'NA' AS KEY7 ,
			NULL AS VAL7 ,
			'NA' AS KEY8 ,
			NULL AS VAL8 ,
			'NA' AS KEY9 ,
			NULL AS VAL9 ,
			'NA' AS KEY10 ,
			NULL AS VAL10 ,
			TT.ItemCreatedBy ,
			TT.ItemCreatedWhen ,
			TT.ItemModifiedBy ,
			TT.ItemModifiedWhen ,
			NULL AS IsProcessedForHa ,
			'NA' AS TXTKEY1 ,
			NULL AS TXTVAL1 ,
			'NA' AS TXTKEY2 ,
			NULL AS TXTVAL2 ,
			'NA' AS TXTKEY3 ,
			NULL AS TXTVAL3 ,
			NULL AS ItemOrder ,
			NULL AS ItemGuid ,
			C.UserGuid ,
			PP.MPI ,
			PP.ClientCode ,
			S.SiteGUID ,
			ACCT.AccountID ,
			ACCT.AccountCD ,
			T.IsAvailable ,
			T.IsCustom ,
			T.UniqueName ,
			T.UniqueName AS ColDesc ,
			NULL AS VendorID	--VENDOR.ItemID as VendorID
			,
			NULL AS VendorName --VENDOR.VendorName
	   FROM dbo.HFit_TrackerWholeGrains AS TT
				INNER JOIN dbo.CMS_User AS C
					ON C.UserID = TT.UserID
				INNER JOIN dbo.hfit_ppteligibility AS PP
					ON TT.UserID = PP.userID
				INNER JOIN dbo.HFit_Account AS ACCT
					ON PP.ClientCode = ACCT.AccountCD
				INNER JOIN dbo.CMS_Site AS S
					ON ACCT.SiteID = S.SiteID
				INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
					ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
				LEFT OUTER JOIN dbo.HFIT_Tracker AS T
					ON T.AggregateTableName = 'HFit_TrackerWholeGrains'
	 --left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
	 UNION
	 SELECT 'HFit_TrackerShots' AS TrackerNameAggregateTable ,
			TT.ItemID ,
			EventDate ,
			TT.IsProfessionallyCollected ,
			TT.TrackerCollectionSourceID ,
			Notes ,
			TT.UserID ,
			NULL AS CollectionSourceName_Internal ,
			NULL AS CollectionSourceName_External ,
			'MISSING' AS EventName ,
			'NA' AS UOM ,
			'FluShot' AS KEY1 ,
			CAST (FluShot AS float) AS VAL1 ,
			'PneumoniaShot' AS KEY2 ,
			CAST (PneumoniaShot AS float) AS VAL2 ,
			'NA' AS KEY3 ,
			NULL AS VAL3 ,
			'NA' AS KEY4 ,
			NULL AS VAL4 ,
			'NA' AS KEY5 ,
			NULL AS VAL5 ,
			'NA' AS KEY6 ,
			NULL AS VAL6 ,
			'NA' AS KEY7 ,
			NULL AS VAL7 ,
			'NA' AS KEY8 ,
			NULL AS VAL8 ,
			'NA' AS KEY9 ,
			NULL AS VAL9 ,
			'NA' AS KEY10 ,
			NULL AS VAL10 ,
			TT.ItemCreatedBy ,
			TT.ItemCreatedWhen ,
			TT.ItemModifiedBy ,
			TT.ItemModifiedWhen ,
			NULL AS IsProcessedForHa ,
			'NA' AS TXTKEY1 ,
			NULL AS TXTVAL1 ,
			'NA' AS TXTKEY2 ,
			NULL AS TXTVAL2 ,
			'NA' AS TXTKEY3 ,
			NULL AS TXTVAL3 ,
			NULL AS ItemOrder ,
			NULL AS ItemGuid ,
			C.UserGuid ,
			PP.MPI ,
			PP.ClientCode ,
			S.SiteGUID ,
			ACCT.AccountID ,
			ACCT.AccountCD ,
			T.IsAvailable ,
			T.IsCustom ,
			T.UniqueName ,
			T.UniqueName AS ColDesc ,
			VENDOR.ItemID AS VendorID ,
			VENDOR.VendorName
	   FROM dbo.HFit_TrackerShots AS TT
				INNER JOIN dbo.CMS_User AS C
					ON C.UserID = TT.UserID
				INNER JOIN dbo.hfit_ppteligibility AS PP
					ON TT.UserID = PP.userID
				INNER JOIN dbo.HFit_Account AS ACCT
					ON PP.ClientCode = ACCT.AccountCD
				INNER JOIN dbo.CMS_Site AS S
					ON ACCT.SiteID = S.SiteID
				INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
					ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
				LEFT OUTER JOIN dbo.HFIT_Tracker AS T
					ON T.AggregateTableName = 'HFit_TrackerShots'
				LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
					ON TT.VendorID = VENDOR.ItemID
	 UNION
	 SELECT 'HFit_TrackerTests' AS TrackerNameAggregateTable ,
			TT.ItemID ,
			EventDate ,
			TT.IsProfessionallyCollected ,
			TT.TrackerCollectionSourceID ,
			Notes ,
			TT.UserID ,
			NULL AS CollectionSourceName_Internal ,
			NULL AS CollectionSourceName_External ,
			'MISSING' AS EventName ,
			'NA' AS UOM ,
			'PSATest' AS KEY1 ,
			CAST (PSATest AS float) AS VAL1 ,
			'OtherExam' AS KEY2 ,
			CAST (OtherExam AS float) AS VAL2 ,
			'TScore' AS KEY3 ,
			CAST (TScore AS float) AS VAL3 ,
			'DRA' AS KEY4 ,
			CAST (DRA AS float) AS VAL4 ,
			'CotinineTest' AS KEY5 ,
			CAST (CotinineTest AS float) AS VAL5 ,
			'ColoCareKit' AS KEY6 ,
			CAST (ColoCareKit AS float) AS VAL6 ,
			'CustomTest' AS KEY7 ,
			CAST (CustomTest AS float) AS VAL7 ,
			'NA' AS KEY8 ,
			NULL AS VAL8 ,
			'NA' AS KEY9 ,
			NULL AS VAL9 ,
			'NA' AS KEY10 ,
			NULL AS VAL10 ,
			TT.ItemCreatedBy ,
			TT.ItemCreatedWhen ,
			TT.ItemModifiedBy ,
			TT.ItemModifiedWhen ,
			NULL AS IsProcessedForHa ,
			'CustomDesc' AS TXTKEY1 ,
			CustomDesc AS TXTVAL1 ,
			'NA' AS TXTKEY2 ,
			NULL AS TXTVAL2 ,
			'NA' AS TXTKEY3 ,
			NULL AS TXTVAL3 ,
			NULL AS ItemOrder ,
			NULL AS ItemGuid ,
			C.UserGuid ,
			PP.MPI ,
			PP.ClientCode ,
			S.SiteGUID ,
			ACCT.AccountID ,
			ACCT.AccountCD ,
			T.IsAvailable ,
			T.IsCustom ,
			T.UniqueName ,
			T.UniqueName AS ColDesc ,
			VENDOR.ItemID AS VendorID ,
			VENDOR.VendorName
	   FROM dbo.HFit_TrackerTests AS TT
				INNER JOIN dbo.CMS_User AS C
					ON C.UserID = TT.UserID
				INNER JOIN dbo.hfit_ppteligibility AS PP
					ON TT.UserID = PP.userID
				INNER JOIN dbo.HFit_Account AS ACCT
					ON PP.ClientCode = ACCT.AccountCD
				INNER JOIN dbo.CMS_Site AS S
					ON ACCT.SiteID = S.SiteID
				INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
					ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
				LEFT OUTER JOIN dbo.HFIT_Tracker AS T
					ON T.AggregateTableName = 'HFit_TrackerTests'
				LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
					ON TT.VendorID = VENDOR.ItemID
 UNION
 	 SELECT 'HFit_TrackerCotinine' AS TrackerNameAggregateTable ,
			TT.ItemID ,
			EventDate ,
			TT.IsProfessionallyCollected ,
			TT.TrackerCollectionSourceID ,
			Notes ,
			TT.UserID ,
			NULL AS CollectionSourceName_Internal ,
			NULL AS CollectionSourceName_External ,
			'MISSING' AS EventName ,
			'NA' AS UOM ,
			'NicotineAssessment' AS KEY1 ,
			CAST (NicotineAssessment AS float) AS VAL1 ,
			'NA' AS KEY2 ,
			NULL AS VAL2 ,
			'NA' AS KEY3 ,
			NULL AS VAL3 ,
			'NA' AS KEY4 ,
			NULL AS VAL4 ,
			'NA' AS KEY5 ,
			NULL AS VAL5 ,
			'NA' AS KEY6 ,
			NULL AS VAL6 ,
			'NA' AS KEY7 ,
			NULL AS VAL7 ,
			'NA' AS KEY8 ,
			NULL AS VAL8 ,
			'NA' AS KEY9 ,
			NULL AS VAL9 ,
			'NA' AS KEY10 ,
			NULL AS VAL10 ,
			TT.ItemCreatedBy ,
			TT.ItemCreatedWhen ,
			TT.ItemModifiedBy ,
			TT.ItemModifiedWhen ,
			IsProcessedForHa ,
			'NA' AS TXTKEY1 ,
			NULL as TXTVAL1 ,
			'NA' AS TXTKEY2 ,
			NULL AS TXTVAL2 ,
			'NA' AS TXTKEY3 ,
			NULL AS TXTVAL3 ,
			NULL AS ItemOrder ,
			NULL AS ItemGuid ,
			C.UserGuid ,
			PP.MPI ,
			PP.ClientCode ,
			S.SiteGUID ,
			ACCT.AccountID ,
			ACCT.AccountCD ,
			T.IsAvailable ,
			T.IsCustom ,
			T.UniqueName ,
			T.UniqueName AS ColDesc ,
			--VENDOR.ItemID AS VendorID ,
			--VENDOR.VendorName,
			NULL AS VendorID,
			NULL AS VendorName
	   FROM dbo.HFit_TrackerCotinine AS TT
				INNER JOIN dbo.CMS_User AS C
					ON C.UserID = TT.UserID
				INNER JOIN dbo.hfit_ppteligibility AS PP
					ON TT.UserID = PP.userID
				INNER JOIN dbo.HFit_Account AS ACCT
					ON PP.ClientCode = ACCT.AccountCD
				INNER JOIN dbo.CMS_Site AS S
					ON ACCT.SiteID = S.SiteID
				INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
					ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
				LEFT OUTER JOIN dbo.HFIT_Tracker AS T
					ON T.AggregateTableName = 'HFit_TrackerTests'
				--LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
				--	ON TT.VendorID = VENDOR.ItemID;

UNION
 	 SELECT 'HFit_TrackerPreventiveCare' AS TrackerNameAggregateTable ,
			TT.ItemID ,
			EventDate ,
			TT.IsProfessionallyCollected ,
			TT.TrackerCollectionSourceID ,
			Notes ,
			TT.UserID ,
			NULL AS CollectionSourceName_Internal ,
			NULL AS CollectionSourceName_External ,
			'MISSING' AS EventName ,
			'NA' AS UOM ,
			'PreventiveCare' AS KEY1 ,
			CAST (PreventiveCare AS float) AS VAL1 ,
			'NA' AS KEY2 ,
			NULL AS VAL2 ,
			'NA' AS KEY3 ,
			NULL AS VAL3 ,
			'NA' AS KEY4 ,
			NULL AS VAL4 ,
			'NA' AS KEY5 ,
			NULL AS VAL5 ,
			'NA' AS KEY6 ,
			NULL AS VAL6 ,
			'NA' AS KEY7 ,
			NULL AS VAL7 ,
			'NA' AS KEY8 ,
			NULL AS VAL8 ,
			'NA' AS KEY9 ,
			NULL AS VAL9 ,
			'NA' AS KEY10 ,
			NULL AS VAL10 ,
			TT.ItemCreatedBy ,
			TT.ItemCreatedWhen ,
			TT.ItemModifiedBy ,
			TT.ItemModifiedWhen ,
			IsProcessedForHa ,
			'NA' AS TXTKEY1 ,
			NULL as TXTVAL1 ,
			'NA' AS TXTKEY2 ,
			NULL AS TXTVAL2 ,
			'NA' AS TXTKEY3 ,
			NULL AS TXTVAL3 ,
			NULL AS ItemOrder ,
			NULL AS ItemGuid ,
			C.UserGuid ,
			PP.MPI ,
			PP.ClientCode ,
			S.SiteGUID ,
			ACCT.AccountID ,
			ACCT.AccountCD ,
			T.IsAvailable ,
			T.IsCustom ,
			T.UniqueName ,
			T.UniqueName AS ColDesc ,
			--VENDOR.ItemID AS VendorID ,
			--VENDOR.VendorName,
			NULL AS VendorID,
			NULL AS VendorName
	   FROM dbo.HFit_TrackerPreventiveCare AS TT
				INNER JOIN dbo.CMS_User AS C
					ON C.UserID = TT.UserID
				INNER JOIN dbo.hfit_ppteligibility AS PP
					ON TT.UserID = PP.userID
				INNER JOIN dbo.HFit_Account AS ACCT
					ON PP.ClientCode = ACCT.AccountCD
				INNER JOIN dbo.CMS_Site AS S
					ON ACCT.SiteID = S.SiteID
				INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
					ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
				LEFT OUTER JOIN dbo.HFIT_Tracker AS T
					ON T.AggregateTableName = 'HFit_TrackerTests'
				--LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
				--	ON TT.VendorID = VENDOR.ItemID;
UNION
 	 SELECT 'HFit_TrackerTobaccoAttestation' AS TrackerNameAggregateTable ,
			TT.ItemID ,
			EventDate ,
			TT.IsProfessionallyCollected ,
			TT.TrackerCollectionSourceID ,
			Notes ,
			TT.UserID ,
			NULL AS CollectionSourceName_Internal ,
			NULL AS CollectionSourceName_External ,
			'MISSING' AS EventName ,
			'NA' AS UOM ,
			'TobaccoAttestation' AS KEY1 ,
			CAST (TobaccoAttestation AS float) AS VAL1 ,
			'NA' AS KEY2 ,
			NULL AS VAL2 ,
			'NA' AS KEY3 ,
			NULL AS VAL3 ,
			'NA' AS KEY4 ,
			NULL AS VAL4 ,
			'NA' AS KEY5 ,
			NULL AS VAL5 ,
			'NA' AS KEY6 ,
			NULL AS VAL6 ,
			'NA' AS KEY7 ,
			NULL AS VAL7 ,
			'NA' AS KEY8 ,
			NULL AS VAL8 ,
			'NA' AS KEY9 ,
			NULL AS VAL9 ,
			'NA' AS KEY10 ,
			NULL AS VAL10 ,
			TT.ItemCreatedBy ,
			TT.ItemCreatedWhen ,
			TT.ItemModifiedBy ,
			TT.ItemModifiedWhen ,
			IsProcessedForHa ,
			'NA' AS TXTKEY1 ,
			NULL as TXTVAL1 ,
			'NA' AS TXTKEY2 ,
			NULL AS TXTVAL2 ,
			'NA' AS TXTKEY3 ,
			NULL AS TXTVAL3 ,
			NULL AS ItemOrder ,
			NULL AS ItemGuid ,
			C.UserGuid ,
			PP.MPI ,
			PP.ClientCode ,
			S.SiteGUID ,
			ACCT.AccountID ,
			ACCT.AccountCD ,
			T.IsAvailable ,
			T.IsCustom ,
			T.UniqueName ,
			T.UniqueName AS ColDesc ,
			--VENDOR.ItemID AS VendorID ,
			--VENDOR.VendorName,
			NULL AS VendorID,
			NULL AS VendorName
	   FROM dbo.HFit_TrackerTobaccoAttestation AS TT
				INNER JOIN dbo.CMS_User AS C
					ON C.UserID = TT.UserID
				INNER JOIN dbo.hfit_ppteligibility AS PP
					ON TT.UserID = PP.userID
				INNER JOIN dbo.HFit_Account AS ACCT
					ON PP.ClientCode = ACCT.AccountCD
				INNER JOIN dbo.CMS_Site AS S
					ON ACCT.SiteID = S.SiteID
				INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
					ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
				LEFT OUTER JOIN dbo.HFIT_Tracker AS T
					ON T.AggregateTableName = 'HFit_TrackerTests'
				--LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
				--	ON TT.VendorID = VENDOR.ItemID;



GO

--  
--  
GO
PRINT '***** FROM: view_EDW_TrackerCompositeDetails.sql';
GO 

print ('Processing: view_EDW_TrackerMetadata ') ;
go

if exists(select TABLE_NAME from INFORMATION_SCHEMA.VIEWS where TABLE_NAME = 'view_EDW_TrackerMetadata')
BEGIN
	drop view view_EDW_TrackerMetadata ;
END
GO


CREATE View [dbo].[view_EDW_TrackerMetadata]
as
--******************************************************************************************************
--TableName - this is the CMS_CLASS ClassName and is used to identify the needed metadata. 
--ColumnName - Each Class has a set of columns. This is the name of the column as contained
--				within the CLASS.
--AttrName - The name of the attribute as it applies to the column (e.g. column type 
--				describes the datatype of the column (ColName) within the CLASS (ClassName).
--AttrVal - the value assigned to the AttrName.
--CreatedDate - the date this row of metadata was created.
--LastModifiedDate - the date this row of metadata was last changed in the Tracker_EDW_Metadata table.
--ID - An identity field within the Tracker_EDW_Metadata table.
--ClassLastModified - The last date the CLASS within CMS_CLASS was changed.
--09.11.2014 : (wdm) Verified last mod date available to EDW 
--******************************************************************************************************
SELECT TableName, ColName, AttrName, AttrVal, CreatedDate, LastModifiedDate, ID, CMS_CLASS.ClassLastModified
FROM     Tracker_EDW_Metadata
join CMS_CLASS on CMS_CLASS.ClassName = TableName


GO


  --  
  --  
GO 
print('***** FROM: view_EDW_TrackerMetadata.sql'); 
GO 

print ('Processing: view_EDW_TrackerShots ') ;



if exists(select TABLE_NAME from INFORMATION_SCHEMA.VIEWS where TABLE_NAME = 'view_EDW_TrackerShots')
BEGIN
	drop view view_EDW_TrackerShots ;
END
go

/****** Object:  View [dbo].[view_EDW_TrackerShots]    Script Date: 9/11/2014 11:14:43 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
--********************************************************************************************************
--09.11.2014 : (wdm) Verified last mod date available to EDW 
--********************************************************************************************************
CREATE VIEW [dbo].[view_EDW_TrackerShots]
AS
	SELECT
		HFTS.UserID
		, cus.UserSettingsUserGUID
		, CUS.HFitUserMpiNumber
		, CS.SiteID
		, cs.SiteGUID
		, HFTS.ItemID
		, HFTS.EventDate
		, HFTS.IsProfessionallyCollected
		, HFTS.TrackerCollectionSourceID
		, HFTS.Notes
		, HFTS.FluShot
		, HFTS.PneumoniaShot
		, HFTS.ItemCreatedWhen
		, HFTS.ItemModifiedWhen
		, HFTS.ItemGUID
	FROM
		dbo.HFit_TrackerShots AS HFTS
	INNER JOIN dbo.HFit_PPTEligibility AS HFPE WITH ( NOLOCK ) ON HFTS.UserID = HFPE.UserID
	INNER JOIN dbo.CMS_UserSettings AS CUS WITH ( NOLOCK ) ON HFTS.UserID = cus.UserSettingsUserID
	INNER JOIN dbo.CMS_UserSite AS CUS2 WITH ( NOLOCK ) ON cus.UserSettingsUserID = cus2.UserID
	INNER JOIN dbo.CMS_Site AS CS WITH ( NOLOCK ) ON cus2.SiteID = CS.SiteID
	INNER JOIN dbo.HFit_Account AS HFA WITH ( NOLOCK ) ON CS.SiteID = HFA.SiteID

GO


  --  
  --  
GO 
print('***** FROM: view_EDW_TrackerShots.sql'); 
GO 

print ('Processing: view_EDW_TrackerTests ') ;

GO


if exists(select TABLE_NAME from INFORMATION_SCHEMA.VIEWS where TABLE_NAME = 'view_EDW_TrackerTests')
BEGIN
	drop view view_EDW_TrackerTests ;
END

GO


--********************************************************************************************************
--09.11.2014 : (wdm) Verified last mod date available to EDW 
--********************************************************************************************************
CREATE VIEW [dbo].[view_EDW_TrackerTests]
AS
	SELECT
		HFTT.UserID
		, cus.UserSettingsUserGUID
		, CUS.HFitUserMpiNumber
		, CS.SiteID
		, cs.SiteGUID
		, HFTT.EventDate
		, HFTT.IsProfessionallyCollected
		, HFTT.TrackerCollectionSourceID
		, HFTT.Notes
		, HFTT.PSATest
		, HFTT.OtherExam
		, HFTT.TScore
		, HFTT.DRA
		, HFTT.CotinineTest
		, HFTT.ColoCareKit
		, HFTT.CustomTest
		, HFTT.CustomDesc
		, HFTT.TSH
		, HFTT.ItemCreatedWhen
		, HFTT.ItemModifiedWhen
		, HFTT.ItemGUID
	FROM
		dbo.HFit_TrackerTests AS HFTT
	INNER JOIN dbo.HFit_PPTEligibility AS HFPE WITH ( NOLOCK ) ON HFTT.UserID = HFPE.UserID
	INNER JOIN dbo.CMS_UserSettings AS CUS WITH ( NOLOCK ) ON HFTT.UserID = cus.UserSettingsUserID
	INNER JOIN dbo.CMS_UserSite AS CUS2 WITH ( NOLOCK ) ON cus.UserSettingsUserID = cus2.UserID
	INNER JOIN dbo.CMS_Site AS CS WITH ( NOLOCK ) ON cus2.SiteID = CS.SiteID
	INNER JOIN dbo.HFit_Account AS HFA WITH ( NOLOCK ) ON CS.SiteID = HFA.SiteID
GO


  --  
  --  
GO 
print('***** FROM: view_EDW_TrackerTests.sql'); 
GO 

print ('Creating view: view_EDW_HADefinition');
go
if exists (Select name from sys.views where name = 'view_EDW_HADefinition')
BEGIN
	drop view view_EDW_HADefinition ;
END
go

create view view_EDW_HADefinition
as
SELECT [SiteGuid]
      ,[AccountCD]
      ,[HANodeID]
      ,[HANodeName]
      ,[HADocumentID]
      ,[HANodeSiteID]
      ,[HADocPubVerID]
      ,[ModTitle]
      ,[IntroText]
      ,[ModDocGuid]
      ,[ModWeight]
      ,[ModIsEnabled]
      ,[ModCodeName]
      ,[ModDocPubVerID]
      ,[RCTitle]
      ,[RCWeight]
      ,[RCDocumentGUID]
      ,[RCIsEnabled]
      ,[RCCodeName]
      ,[RCDocPubVerID]
      ,[RATytle]
      ,[RAWeight]
      ,[RADocumentGuid]
      ,[RAIsEnabled]
      ,[RACodeName]
      ,[RAScoringStrategyID]
      ,[RADocPubVerID]
      ,[QuestionType]
      ,[QuesTitle]
      ,[QuesWeight]
      ,[QuesIsRequired]
      ,[QuesDocumentGuid]
      ,[QuesIsEnabled]
      ,[QuesIsVisible]
      ,[QuesIsSTaging]
      ,[QuestionCodeName]
      ,[QuesDocPubVerID]
      ,[AnsValue]
      ,[AnsPoints]
      ,[AnsDocumentGuid]
      ,[AnsIsEnabled]
      ,[AnsCodeName]
      ,[AnsUOM]
      ,[AnsDocPUbVerID]
      ,[ChangeType]
      ,[DocumentCreatedWhen]
      ,[DocumentModifiedWhen]
      ,[CmsTreeNodeGuid]
      ,[HANodeGUID]
  FROM [dbo].[EDW_HealthAssessmentDefinition]

go
print ('Created view: view_EDW_HADefinition');
go
  --  
  --  
GO 
print('***** FROM: view_EDW_HADefinition.sql'); 
GO 

print ('Processing: Proc_EDW_GenerateMetadata') ;
go


if exists (select * from sysobjects where name = 'Proc_EDW_GenerateMetadata' and Xtype = 'P')
BEGIN
	drop procedure Proc_EDW_GenerateMetadata ;
END 
go

--select * from view_EDW_TrackerMetadata where TableName = 'HFit.CustomTrackerInstances'
--select * from Tracker_EDW_Metadata
--delete from Tracker_EDW_Metadata where TableName = 'HFit.TrackerWholeGrains'

--exec Proc_EDW_GenerateMetadata
--2014-07-30 20:59:10.940

CREATE procedure [dbo].[Proc_EDW_GenerateMetadata]
as 
BEGIN
	--truncate table Tracker_EDW_Metadata;
	BEGIN TRAN T1;
	EXEC Proc_EDW_TrackerMetadataExtract 'HFIT.Tracker';	
	COMMIT TRAN T1;
	BEGIN TRAN T2;
	EXEC Proc_EDW_TrackerMetadataExtract 'HFit.TrackerCategory';
	COMMIT TRAN T2;
	BEGIN TRAN T3;
	EXEC Proc_EDW_TrackerMetadataExtract 'HFit.TrackerDocument';
	COMMIT TRAN T3;
	BEGIN TRAN T4;
	EXEC Proc_EDW_TrackerMetadataExtract 'HFit.UserTracker';
	COMMIT TRAN T4;
	BEGIN TRAN T5;
	EXEC Proc_EDW_TrackerMetadataExtract 'HFit.UserTrackerCategory';
	COMMIT TRAN T5;
	BEGIN TRAN T6;	
	EXEC Proc_EDW_TrackerMetadataExtract 'HFit.TrackerCollectionSource';
	COMMIT TRAN T6;
	BEGIN TRAN T7;
	EXEC Proc_EDW_TrackerMetadataExtract 'HFit.TrackerVegetables';	
	COMMIT TRAN T7;
	BEGIN TRAN T8;
	EXEC Proc_EDW_TrackerMetadataExtract 'HFit.LKP_TrackerTobaccoQuitAids';
	COMMIT TRAN T8;
	BEGIN TRAN T9;
	EXEC Proc_EDW_TrackerMetadataExtract 'HFit.TrackerTobaccoFree';
	COMMIT TRAN T9;
	BEGIN TRAN T10;
	EXEC Proc_EDW_TrackerMetadataExtract 'HFit.TrackerWholeGrains';
	COMMIT TRAN T10;
	BEGIN TRAN T11;
	EXEC Proc_EDW_TrackerMetadataExtract 'HFit.TrackerFruits';
	COMMIT TRAN T11;
	BEGIN TRAN T12;
	EXEC Proc_EDW_TrackerMetadataExtract 'HFit.TrackerSugaryDrinks';
	COMMIT TRAN T12;
	BEGIN  TRAN T13;
	EXEC Proc_EDW_TrackerMetadataExtract 'HFit.TrackerWater';
	COMMIT TRAN T13;
	BEGIN  TRAN T14;
	EXEC Proc_EDW_TrackerMetadataExtract 'HFit.TrackerHighSodiumFoods';
	COMMIT TRAN T15;
	BEGIN  TRAN T16;
	EXEC Proc_EDW_TrackerMetadataExtract 'HFit.TrackerHighFatFoods';
	COMMIT TRAN T16;
	BEGIN  TRAN T17;
	EXEC Proc_EDW_TrackerMetadataExtract 'HFit.TrackerSleepPlan';
	COMMIT TRAN T17;
	BEGIN  TRAN T18;
	EXEC Proc_EDW_TrackerMetadataExtract 'HFit.LKP_TrackerSleepPlanTechniques';
	COMMIT TRAN T18;
	BEGIN  TRAN T19;
	EXEC Proc_EDW_TrackerMetadataExtract 'HFit.TrackerMedicalCarePlan';
	COMMIT TRAN T19;
	BEGIN  TRAN T20;
	EXEC Proc_EDW_TrackerMetadataExtract 'HFit.TrackerSummary';
	COMMIT TRAN T20;
	BEGIN  TRAN T21;
	EXEC Proc_EDW_TrackerMetadataExtract 'HFit.TrackerRegularMeals';
	COMMIT TRAN T21;
	BEGIN  TRAN T22;
	EXEC Proc_EDW_TrackerMetadataExtract 'HFit.TrackerBodyFat';
	COMMIT TRAN T22;
	BEGIN  TRAN T23;
	EXEC Proc_EDW_TrackerMetadataExtract 'HFit.TrackerWeight';
	COMMIT TRAN T23;
	BEGIN  TRAN T24;
	EXEC Proc_EDW_TrackerMetadataExtract 'HFit.TrackerBloodSugarGlucose';
	COMMIT TRAN T24;
	BEGIN  TRAN T25;
	EXEC Proc_EDW_TrackerMetadataExtract 'HFit.TrackerHbA1c';
	COMMIT TRAN T25;
	BEGIN  TRAN T26;
	EXEC Proc_EDW_TrackerMetadataExtract 'HFit.TrackerMealPortions';
	COMMIT TRAN T26;
	BEGIN  TRAN T27;
	EXEC Proc_EDW_TrackerMetadataExtract 'HFit.TrackerSugaryFoods';
	COMMIT TRAN T27;
	BEGIN  TRAN T28;
	EXEC Proc_EDW_TrackerMetadataExtract 'HFit.LKP_TrackerStrengthActivity';
	COMMIT TRAN T29;
	BEGIN  TRAN T30;
	EXEC Proc_EDW_TrackerMetadataExtract 'HFit.TrackerRestingHeartRate';
	COMMIT TRAN T30;
	BEGIN  TRAN T31;
	EXEC Proc_EDW_TrackerMetadataExtract 'HFit.TrackerCholesterol';
	COMMIT TRAN T31;
	BEGIN  TRAN T32;
	EXEC Proc_EDW_TrackerMetadataExtract 'HFit.TrackerBodyMeasurements';
	COMMIT TRAN T32;
	BEGIN  TRAN T33;
	EXEC Proc_EDW_TrackerMetadataExtract 'HFit.TrackerBloodPressure';
	COMMIT TRAN T33;
	BEGIN  TRAN T34;
	EXEC Proc_EDW_TrackerMetadataExtract 'HFit.LKP_TrackerFlexibilityActivity';
	COMMIT TRAN T34;
	BEGIN  TRAN T35;
	EXEC Proc_EDW_TrackerMetadataExtract 'HFit.TrackerStressManagement';
	COMMIT TRAN T35;
	BEGIN  TRAN T36;
	EXEC Proc_EDW_TrackerMetadataExtract 'HFit.TrackerFlexibility';
	COMMIT TRAN T36;
	BEGIN  TRAN T37;
	EXEC Proc_EDW_TrackerMetadataExtract 'HFit.TrackerStress';
	COMMIT TRAN T37;
	BEGIN  TRAN T38;
	EXEC Proc_EDW_TrackerMetadataExtract 'HFit.TrackerCardio';
	COMMIT TRAN T39;
	BEGIN  TRAN T40;
	EXEC Proc_EDW_TrackerMetadataExtract 'HFit.TrackerSitLess';
	COMMIT TRAN T40;
	BEGIN  TRAN T41;
	EXEC Proc_EDW_TrackerMetadataExtract 'HFit.TrackerStrength';
	COMMIT TRAN T41;
	BEGIN  TRAN T42;
	EXEC Proc_EDW_TrackerMetadataExtract 'HFit.LKP_TrackerCardioActivity';
	COMMIT TRAN T42;
	BEGIN  TRAN T43;
	EXEC Proc_EDW_TrackerMetadataExtract 'HFit.TrackerBMI';
	COMMIT TRAN T43;
	BEGIN  TRAN T44;
	EXEC Proc_EDW_TrackerMetadataExtract 'HFit.Ref_RewardTrackerValidation';
	COMMIT TRAN T45;
	BEGIN  TRAN T46;
	EXEC Proc_EDW_TrackerMetadataExtract 'HFit.HFit_TrackerHeight';
	COMMIT TRAN T46;
	BEGIN  TRAN T47;
	EXEC Proc_EDW_TrackerMetadataExtract 'HFit.HFit_TrackerShots';
	COMMIT TRAN T47;
	BEGIN  TRAN T48;
	EXEC Proc_EDW_TrackerMetadataExtract 'HFit.HFit_TrackerTests';
	COMMIT TRAN T48;
	--BEGIN  TRAN T49;
	--EXEC Proc_EDW_TrackerMetadataExtract 'HFit.HealthAssessmentCodeNamesToTrackerMapping';
	--COMMIT TRAN T49;
	BEGIN  TRAN T50;
	EXEC Proc_EDW_TrackerMetadataExtract 'HFit.CustomTrackerInstances';
	COMMIT TRAN T50;
	BEGIN  TRAN T51;
	EXEC Proc_EDW_TrackerMetadataExtract 'HFit.TrackerDailySteps';
	COMMIT TRAN T51;
END

GO


  --  
  --  
GO 
print('***** FROM: Proc_EDW_GenerateMetadata.sql'); 
GO 

print ('Processing: Proc_EDW_HealthAssessment') ;
go

if exists (select * from sysobjects where name = 'Proc_EDW_HealthAssessment' and Xtype = 'P')
BEGIN
	drop procedure Proc_EDW_HealthAssessment ;
END 
go

CREATE procedure [dbo].[Proc_EDW_HealthAssessment] (@StartDate as datetime, @EndDate as datetime, @TrackPerf as nvarchar(1))
--WITH EXECUTE AS OWNER
as

--***********************************************************************************************
--NOTE: This proc is currently set up to enter records into a staging table "EDW_HealthAssessment".
--		It runs in about the same time as the non-staging query, This allows the EDW instant access
--		to the HA records once this proc has completed. No changes would be required to the EDW
--		processing as the column names and ordinals are the same. A job can be set up to run this 
--		procedure on a scheduled basis. IT IS NOT IN PRODUCTION YET.

--7/15/2014 17:19 min. 46,750 Rows DEV
--7/15/2014 per Mark Turner:
--	HAModuleDocumentID is on its way out, so is Module, RiskCategory, RiskArea, Question, Answer 
--	all the "DocumentID" fields are deprecated and replaced by corresponding NodeGUID fields
--08/08/2014 - Executed in DEV with GUID changes, new views
--08/08/2014 - Generated corrected view in DEV
--08/08/2014 - 18:06 min. 51,282 Rows DEV
--08/08/2014 - 00:35 sec. 51,282 Rows DEV after conversion to SP (wdm)
--08/08/2014 - 00:35 sec. 51,282 Rows QA after conversion to SP (wdm)
--08/19/2014 - Found this proc missing some of the views created yesterday - recreated the 2 missing views and all works well
--08/29/2014 - 00:35 sec. 51,282 Rows LAB/Prod1 (wdm)
--(52480 row(s) affected)  @EndTime: Sep  2 2014  3:24PM / 1:41 exec time (not using insert into staging table)
--(52480 row(s) affected)  @EndTime: Sep  2 2014  3:24PM / 1:40 exec time (using insert into staging table)
--USE: exec Proc_EDW_HealthAssessment '2013-05-22', '2014-09-23', 'Y'	--This causes between dates to be pulled
--     exec Proc_EDW_HealthAssessment NULL, NULL, 'Y'					--This causes one day's previous data to be pulled

--Auth:	GRANT EXECUTE ON dbo.Proc_EDW_HealthAssessment TO <UserID>;
--Action: This proc creates table EDW_HealthAssessment and a view to access the table view_EDW_HAassessment.
--			Select on the view is granted to PUBLIC. This provides EDW with instant access to data.


-- 09.11.2014 : (wdm) Verified DATES to resolve EDW last mod date issue
--***********************************************************************************************
begin

	IF OBJECT_ID('tempdb..#View_EDW_HealthAssesmentQuestions') IS NULL 
	BEGIN
		create TABLE #View_EDW_HealthAssesmentQuestions
		(
			Title nvarchar(4000),
			NodeGUID uniqueidentifier,
			DocumentGUID uniqueidentifier,
			DocumentCulture nvarchar(50)
		);
		INSERT INTO #View_EDW_HealthAssesmentQuestions (Title, NodeGUID, DocumentGUID, DocumentCulture)
			SELECT Title, NodeGUID, DocumentGUID, DocumentCulture
		FROM View_EDW_HealthAssesmentQuestions ;

		CREATE CLUSTERED INDEX [TEMPIX_View_EDW_HealthAssesmentQuestions] ON #View_EDW_HealthAssesmentQuestions
		(
			DocumentGUID ASC,
			NodeGUID ASC,
			DocumentCulture
		)
	END

	IF OBJECT_ID('tempdb..#View_CMS_Tree_Joined') IS NULL 
	BEGIN
		create TABLE #View_CMS_Tree_Joined
		(
			DocumentGUID uniqueidentifier,
			NodeGUID uniqueidentifier,
			DocumentCulture nvarchar(50)
		);
		INSERT INTO #View_CMS_Tree_Joined (DocumentGUID, NodeGUID, DocumentCulture)
			SELECT DocumentGUID, NodeGUID, DocumentCulture
		FROM View_CMS_Tree_Joined ;

		CREATE CLUSTERED INDEX [TEMPIX_View_CMS_Tree_Joined] ON #View_CMS_Tree_Joined
		(
			DocumentGUID ASC,
			NodeGUID ASC,
			DocumentCulture
		)
	END
	

	--declare @StartDate as datetime ;
	--declare @EndDate as datetime ;
	--declare @TrackPerf as char(1);
	set @TrackPerf = 'Y' ;
	set @StartDate = '2001-04-08';
	set @EndDate = '2015-07-02';

	declare @P0Start as datetime ;
	declare @P0End as datetime ;
	declare @P1Start as datetime ;
	declare @P1End as datetime ;
	
	set @P0Start = getdate() ;
	set @P1Start = getdate() ;
	
--select * from EDW_HealthAssessment	

if exists(select name from sys.tables where name = 'EDW_HealthAssessment')
BEGIN	
	drop table EDW_HealthAssessment ;
END


CREATE TABLE [dbo].[EDW_HealthAssessment](
	[UserStartedItemID] [int] NOT NULL,
	[HealthAssesmentUserStartedNodeGUID] [uniqueidentifier] NULL,
	[UserID] [bigint] NOT NULL,
	[UserGUID] [uniqueidentifier] NOT NULL,
	[HFitUserMpiNumber] [bigint] NULL,
	[SiteGUID] [uniqueidentifier] NOT NULL,
	[AccountID] [int] NOT NULL,
	[AccountCD] [nvarchar](8) NULL,
	[HAStartedDt] [datetime] NOT NULL,
	[HACompletedDt] [datetime] NULL,
	[UserModuleItemId] [int] NOT NULL,
	[UserModuleCodeName] [nvarchar](100) NOT NULL,
	[HAModuleNodeGUID] [uniqueidentifier] NOT NULL,
	[CMSNodeGuid] [uniqueidentifier] NOT NULL,
	[HAModuleVersionID] [int] NULL,
	[UserRiskCategoryItemID] [int] NOT NULL,
	[UserRiskCategoryCodeName] [nvarchar](100) NOT NULL,
	[HARiskCategoryNodeGUID] [uniqueidentifier] NOT NULL,
	[HARiskCategoryVersionID] [int] NULL,
	[UserRiskAreaItemID] [int] NOT NULL,
	[UserRiskAreaCodeName] [nvarchar](100) NOT NULL,
	[HARiskAreaNodeGUID] [uniqueidentifier] NOT NULL,
	[HARiskAreaVersionID] [int] NULL,
	[UserQuestionItemID] [int] NOT NULL,
	[Title] [nvarchar](max) NOT NULL,
	[HAQuestionGuid] [uniqueidentifier] NOT NULL,
	[UserQuestionCodeName] [nvarchar](100) NOT NULL,
	[HAQuestionDocumentID] [int] NULL,
	[HAQuestionVersionID] [int] NULL,
	[HAQuestionNodeGUID] [uniqueidentifier] NOT NULL,
	[UserAnswerItemID] [int] NOT NULL,
	[HAAnswerNodeGUID] [uniqueidentifier] NOT NULL,
	[HAAnswerVersionID] [int] NULL,
	[UserAnswerCodeName] [nvarchar](100) NOT NULL,
	[HAAnswerValue] [nvarchar](255) NULL,
	[HAModuleScore] [float] NOT NULL,
	[HARiskCategoryScore] [float] NULL,
	[HARiskAreaScore] [float] NULL,
	[HAQuestionScore] [float] NULL,
	[HAAnswerPoints] [int] NULL,
	[PointResults] [int] NULL,
	[UOMCode] [nvarchar](10) NULL,
	[HAScore] [int] NULL,
	[ModulePreWeightedScore] [float] NULL,
	[RiskCategoryPreWeightedScore] [float] NULL,
	[RiskAreaPreWeightedScore] [float] NULL,
	[QuestionPreWeightedScore] [float] NULL,
	[QuestionGroupCodeName] [nvarchar](100) NULL,
	[ChangeType] [varchar](1) NOT NULL,
	[ItemCreatedWhen] [datetime] NULL,
	[ItemModifiedWhen] [datetime] NULL,
	[IsProfessionallyCollected] [bit] NOT NULL,
	[HARiskCategory_ItemModifiedWhen] [datetime] NULL,
	[HAUserRiskArea_ItemModifiedWhen] [datetime] NULL,
	[HAUserQuestion_ItemModifiedWhen] [datetime] NULL,
	[HAUserAnswers_ItemModifiedWhen] [datetime] NULL,
	[HAPaperFlg] [bit] NOT NULL,
	[HATelephonicFlg] [bit] NOT NULL
	--[HAStartedMode] [int] NOT NULL,
	--[HACompletedMode] [int] NOT NULL
) ;


declare @SQL as varchar(2000) ;

if not exists(select name from sys.views where name = 'view_EDW_HAassessment')
BEGIN
	set @SQL = 
		'create view view_EDW_HAassessment
			as
			SELECT [UserStartedItemID]
		  ,[HealthAssesmentUserStartedNodeGUID]
		  ,[UserID]
		  ,[UserGUID]
		  ,[HFitUserMpiNumber]
		  ,[SiteGUID]
		  ,[AccountID]
		  ,[AccountCD]
		  ,[HAStartedDt]
		  ,[HACompletedDt]
		  ,[UserModuleItemId]
		  ,[UserModuleCodeName]
		  ,[HAModuleNodeGUID]
		  ,[CMSNodeGuid]
		  ,[HAModuleVersionID]
		  ,[UserRiskCategoryItemID]
		  ,[UserRiskCategoryCodeName]
		  ,[HARiskCategoryNodeGUID]
		  ,[HARiskCategoryVersionID]
		  ,[UserRiskAreaItemID]
		  ,[UserRiskAreaCodeName]
		  ,[HARiskAreaNodeGUID]
		  ,[HARiskAreaVersionID]
		  ,[UserQuestionItemID]
		  ,[Title]
		  ,[HAQuestionGuid]
		  ,[UserQuestionCodeName]
		  ,[HAQuestionDocumentID]
		  ,[HAQuestionVersionID]
		  ,[HAQuestionNodeGUID]
		  ,[UserAnswerItemID]
		  ,[HAAnswerNodeGUID]
		  ,[HAAnswerVersionID]
		  ,[UserAnswerCodeName]
		  ,[HAAnswerValue]
		  ,[HAModuleScore]
		  ,[HARiskCategoryScore]
		  ,[HARiskAreaScore]
		  ,[HAQuestionScore]
		  ,[HAAnswerPoints]
		  ,[PointResults]
		  ,[UOMCode]
		  ,[HAScore]
		  ,[ModulePreWeightedScore]
		  ,[RiskCategoryPreWeightedScore]
		  ,[RiskAreaPreWeightedScore]
		  ,[QuestionPreWeightedScore]
		  ,[QuestionGroupCodeName]
		  ,[ChangeType]
		  ,[ItemCreatedWhen]
		  ,[ItemModifiedWhen]
		  ,[IsProfessionallyCollected]
		  ,[HARiskCategory_ItemModifiedWhen]
		  ,[HAUserRiskArea_ItemModifiedWhen]
		  ,[HAUserQuestion_ItemModifiedWhen]
		  ,[HAUserAnswers_ItemModifiedWhen]
		  ,[HAPaperFlg]
		  ,[HATelephonicFlg]
		  --,[HAStartedMode]
		  --,[HACompletedMode]
	  FROM [dbo].[EDW_HealthAssessment]'; 
			  
	  exec (@SQL) ;

	  GRANT SELECT ON view_EDW_HAassessment TO public;

END

	IF @StartDate is null 
		BEGIN
			--set @StartDate = getdate() - 1 ;
			set @StartDate  =DATEADD(Day, 0, DATEDIFF(Day, 0, GetDate())) -1 ;	--Midnight yesterday;	
			set @StartDate = @StartDate  -1 ;	
		END
		IF @EndDate is null 
		BEGIN
			set @EndDate = getdate();
			--set @StartDate  =DATEADD(Day, 0, DATEDIFF(Day, 0, GetDate())) ;	--Midnight today;		
		END

--select top 10 * from view_EDW_HealthAssesment
	INSERT INTO [dbo].[EDW_HealthAssessment]
           ([UserStartedItemID]
           ,[HealthAssesmentUserStartedNodeGUID]
           ,[UserID]
           ,[UserGUID]
           ,[HFitUserMpiNumber]
           ,[SiteGUID]
           ,[AccountID]
           ,[AccountCD]
           ,[HAStartedDt]
           ,[HACompletedDt]
           ,[UserModuleItemId]
           ,[UserModuleCodeName]
           ,[HAModuleNodeGUID]
           ,[CMSNodeGuid]
           ,[HAModuleVersionID]
           ,[UserRiskCategoryItemID]
           ,[UserRiskCategoryCodeName]
           ,[HARiskCategoryNodeGUID]
           ,[HARiskCategoryVersionID]
           ,[UserRiskAreaItemID]
           ,[UserRiskAreaCodeName]
           ,[HARiskAreaNodeGUID]
           ,[HARiskAreaVersionID]
           ,[UserQuestionItemID]
           ,[Title]
           ,[HAQuestionGuid]
           ,[UserQuestionCodeName]
           ,[HAQuestionDocumentID]
           ,[HAQuestionVersionID]
           ,[HAQuestionNodeGUID]
           ,[UserAnswerItemID]
           ,[HAAnswerNodeGUID]
           ,[HAAnswerVersionID]
           ,[UserAnswerCodeName]
           ,[HAAnswerValue]
           ,[HAModuleScore]
           ,[HARiskCategoryScore]
           ,[HARiskAreaScore]
           ,[HAQuestionScore]
           ,[HAAnswerPoints]
           ,[PointResults]
           ,[UOMCode]
           ,[HAScore]
           ,[ModulePreWeightedScore]
           ,[RiskCategoryPreWeightedScore]
           ,[RiskAreaPreWeightedScore]
           ,[QuestionPreWeightedScore]
           ,[QuestionGroupCodeName]
           ,[ChangeType]
           ,[ItemCreatedWhen]
           ,[ItemModifiedWhen]
           ,[IsProfessionallyCollected]
           ,[HARiskCategory_ItemModifiedWhen]
           ,[HAUserRiskArea_ItemModifiedWhen]
           ,[HAUserQuestion_ItemModifiedWhen]
           ,[HAUserAnswers_ItemModifiedWhen]
           ,[HAPaperFlg]
           ,[HATelephonicFlg]
           --,[HAStartedMode]
           --,[HACompletedMode]
		   )
	
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

		WHERE HAUserAnswers.ItemModifiedWhen BETWEEN @StartDate AND @EndDate
		OR HARiskCategory.ItemModifiedWhen BETWEEN @StartDate AND @EndDate
		OR HAUserRiskArea.ItemModifiedWhen BETWEEN @StartDate AND @EndDate
		OR HAUserQuestion.ItemModifiedWhen BETWEEN @StartDate AND @EndDate
		
if @TrackPerf is not null 
BEGIN
	set @P1End = getdate() ;
	exec proc_EDW_MeasurePerf 'ElapsedTime','HealthAssessment-P1',0, @P1Start, @P1End;
	print ('Perf Details Recorded') ;
END
ELSE
	print ('No Perf Details Requested') ;
	
END	--END of PROC

GO

print ('Processed: Proc_EDW_HealthAssessment') ;
go

  --  
  --  
GO 
print('***** FROM: Proc_EDW_HealthAssessment.sql'); 
GO 

print ('Processing: Proc_EDW_HealthAssessmentDefinition') ;
go


if exists (select * from sysobjects where name = 'Proc_EDW_HealthAssessmentDefinition' and Xtype = 'P')
BEGIN
	drop procedure Proc_EDW_HealthAssessmentDefinition ;
END 
go

create proc [dbo].[Proc_EDW_HealthAssessmentDefinition] (@StartDate as datetime, @EndDate as datetime, @TrackPerf as nvarchar(1))
as
BEGIN
--*********************************************************************************************************************
--Action: This proc creates table EDW_HealthAssessmentDefinition and a view to access the table view_EDW_HADefinition.
--			Select on the view is granted to PUBLIC. This provides EDW with instant access to data.
--		Creates a staging table EDW_HealthAssessmentDefinition.
--USE:	exec Proc_EDW_HealthAssessmentDefinition NULL, NULL
--		exec Proc_EDW_HealthAssessmentDefinition '2013-11-14', '2013-11-15', 'Y'
--exec Proc_EDW_HealthAssessmentDefinition NULL, NULL, 'Y'
--exec Proc_EDW_HealthAssessmentDefinition '2010-11-14', '2014-11-15', 'Y'
--exec Proc_EDW_HealthAssessmentDefinition '2014-06-10', '2014-08-30', NULL
--*********************************************************************************************************************
--exec Proc_EDW_HealthAssessmentDefinition '2010-11-14', '2014-11-15', 'Y'
--08/12/2014 - ProdStaging 00:00:12 @ 2442
--*********************************************************************************************************************

--USE: exec Proc_EDW_HealthAssessmentDefinition '2001-04-08', '2015-07-02'	--This causes one between dates to be pulled
--     exec Proc_EDW_HealthAssessmentDefinition NULL, NULL					--This causes one day's previous data to be pulled
--Auth:	GRANT EXECUTE ON dbo.Proc_EDW_HealthAssessmentDefinition TO <UserID>;


-- ----FOR DEBUG PURPOSES, UNCOMMENT
--declare @TrackPerf as nvarchar(1);
--declare @StartDate as datetime;
--declare @EndDate as datetime;
--set @StartDate = '2010-11-14';
--set @EndDate = '2014-11-15';
----set @StartDate = NULL ;
----set @EndDate = NULL ;
--set @TrackPerf = 'Y' ;

if exists(select name from sys.tables where name = 'EDW_HealthAssessmentDefinition')
BEGIN	
	truncate table EDW_HealthAssessmentDefinition ;
END
ELSE
BEGIN
	CREATE TABLE [dbo].[EDW_HealthAssessmentDefinition](
		[SiteGuid] [int] NULL,
		[AccountCD] [int] NULL,
		[HANodeID] [int] NOT NULL,
		[HANodeName] [nvarchar](100) NOT NULL,
		[HADocumentID] [int] NOT NULL,
		[HANodeSiteID] [int] NOT NULL,
		[HADocPubVerID] [int] NULL,
		[ModTitle] [nvarchar](150) NOT NULL,
		[IntroText] [varchar](4000) NULL,
		[ModDocGuid] [uniqueidentifier] NULL,
		[ModWeight] [int] NOT NULL,
		[ModIsEnabled] [bit] NOT NULL,
		[ModCodeName] [nvarchar](100) NOT NULL,
		[ModDocPubVerID] [int] NULL,
		[RCTitle] [nvarchar](150) NOT NULL,
		[RCWeight] [int] NOT NULL,
		[RCDocumentGUID] [uniqueidentifier] NULL,
		[RCIsEnabled] [bit] NOT NULL,
		[RCCodeName] [nvarchar](100) NOT NULL,
		[RCDocPubVerID] [int] NULL,
		[RATytle] [nvarchar](150) NOT NULL,
		[RAWeight] [int] NOT NULL,
		[RADocumentGuid] [uniqueidentifier] NULL,
		[RAIsEnabled] [bit] NOT NULL,
		[RACodeName] [nvarchar](100) NOT NULL,
		[RAScoringStrategyID] [int] NOT NULL,
		[RADocPubVerID] [int] NULL,
		[QuestionType] [nvarchar](100) NOT NULL,
		[QuesTitle] [varchar](max) NULL,
		[QuesWeight] [int] NOT NULL,
		[QuesIsRequired] [bit] NOT NULL,
		[QuesDocumentGuid] [uniqueidentifier] NULL,
		[QuesIsEnabled] [bit] NOT NULL,
		[QuesIsVisible] [nvarchar](max) NULL,
		[QuesIsSTaging] [bit] NOT NULL,
		[QuestionCodeName] [nvarchar](100) NOT NULL,
		[QuesDocPubVerID] [int] NULL,
		[AnsValue] [nvarchar](150) NULL,
		[AnsPoints] [int] NULL,
		[AnsDocumentGuid] [uniqueidentifier] NULL,
		[AnsIsEnabled] [bit] NULL,
		[AnsCodeName] [nvarchar](100) NULL,
		[AnsUOM] [nvarchar](5) NULL,
		[AnsDocPUbVerID] [int] NULL,
		[ChangeType] [varchar](1) NOT NULL,
		[DocumentCreatedWhen] [datetime] NULL,
		[DocumentModifiedWhen] [datetime] NULL,
		[CmsTreeNodeGuid] [uniqueidentifier] NOT NULL,
		[HANodeGUID] [uniqueidentifier] NOT NULL
	)
END

declare @SQL as varchar(2000) ;

if not exists(select name from sys.views where name = 'view_EDW_HADefinition')
BEGIN
set @SQL = 
	'create view [view_EDW_HADefinition]
	as
	SELECT [SiteGuid]
		  ,[AccountCD]
		  ,[HANodeID]
		  ,[HANodeName]
		  ,[HADocumentID]
		  ,[HANodeSiteID]
		  ,[HADocPubVerID]
		  ,[ModTitle]
		  ,[IntroText]
		  ,[ModDocGuid]
		  ,[ModWeight]
		  ,[ModIsEnabled]
		  ,[ModCodeName]
		  ,[ModDocPubVerID]
		  ,[RCTitle]
		  ,[RCWeight]
		  ,[RCDocumentGUID]
		  ,[RCIsEnabled]
		  ,[RCCodeName]
		  ,[RCDocPubVerID]
		  ,[RATytle]
		  ,[RAWeight]
		  ,[RADocumentGuid]
		  ,[RAIsEnabled]
		  ,[RACodeName]
		  ,[RAScoringStrategyID]
		  ,[RADocPubVerID]
		  ,[QuestionType]
		  ,[QuesTitle]
		  ,[QuesWeight]
		  ,[QuesIsRequired]
		  ,[QuesDocumentGuid]
		  ,[QuesIsEnabled]
		  ,[QuesIsVisible]
		  ,[QuesIsSTaging]
		  ,[QuestionCodeName]
		  ,[QuesDocPubVerID]
		  ,[AnsValue]
		  ,[AnsPoints]
		  ,[AnsDocumentGuid]
		  ,[AnsIsEnabled]
		  ,[AnsCodeName]
		  ,[AnsUOM]
		  ,[AnsDocPUbVerID]
		  ,[ChangeType]
		  ,[DocumentCreatedWhen]
		  ,[DocumentModifiedWhen]
		  ,[CmsTreeNodeGuid]
		  ,[HANodeGUID]
	  FROM [dbo].[EDW_HealthAssessmentDefinition]' ; 
	  exec (@SQL) ;

	  GRANT SELECT ON view_EDW_HADefinition TO public;

END

declare @P0Start as datetime ;
declare @P0End as datetime ;
declare @P1Start as datetime ;
declare @P1End as datetime ;
declare @P2Start as datetime ;
declare @P2End as datetime ;
declare @P3Start as datetime ;
declare @P3End as datetime ;
declare @P4Start as datetime ;
declare @P4End as datetime ;
declare @P5Start as datetime ;
declare @P5End as datetime ;
declare @P6Start as datetime ;
declare @P6End as datetime ;
declare @P7Start as datetime ;
declare @P7End as datetime ;
declare @P8Start as datetime ;
declare @P8End as datetime ;

set @P0Start = getdate() ;

	IF @StartDate is null 
	BEGIN
		set @StartDate  =DATEADD(Day, 0, DATEDIFF(Day, 0, GetDate()));	--Midnight yesterday;	
		set @StartDate = @StartDate  -1 ;
	END
	
	IF @EndDate is null 
	BEGIN
		set @EndDate = cast (getdate() as date);
	END
	print ('Start Date: ' + cast(@StartDate as nvarchar(50)))
	print ('End Date: ' + cast(@EndDate as nvarchar(50))) 
	/****************************************************************************************/
	--Build the temporary tables. This should take under 10 seconds as a general rule.
	/****************************************************************************************/
	IF EXISTS
		(
			SELECT name
			FROM tempdb.dbo.sysobjects
			WHERE ID = OBJECT_ID(N'tempdb..#Temp_View_HFit_HealthAssessment_Joined')
		)
	BEGIN
		drop table #Temp_View_HFit_HealthAssessment_Joined ;
	END
	--GO
	select DocumentGUID, NodeGuid, NodeID, DocumentID, NodeName, NodeSiteID, DocumentPublishedVersionHistoryID
	into #Temp_View_HFit_HealthAssessment_Joined 
	from View_HFit_HealthAssessment_Joined 
	where View_HFit_HealthAssessment_Joined .DocumentCulture = 'en-us' ;
	--GO

	create clustered index PI_Temp_View_HFit_HealthAssessment_Joined on #Temp_View_HFit_HealthAssessment_Joined 
	(
	DocumentGUID, NodeGuid
	)
	--GO 

	IF EXISTS
		(
			SELECT name
			FROM tempdb.dbo.sysobjects
			WHERE ID = OBJECT_ID(N'tempdb..#Temp_View_HFit_HACampaign_Joined')
		)
	BEGIN
		drop table #Temp_View_HFit_HACampaign_Joined ;
	END
	--GO
	select DISTINCT NodeParentID, HealthAssessmentID
	into #Temp_View_HFit_HACampaign_Joined
	from 
	View_HFit_HACampaign_Joined
	--GO

	CREATE CLUSTERED INDEX [PI_Temp_View_HFit_HACampaign_Joined] ON #Temp_View_HFit_HACampaign_Joined 
	(
	[NodeParentID] ASC,
	HealthAssessmentID )
	--GO

	IF EXISTS
		(
			SELECT name
			FROM tempdb.dbo.sysobjects
			WHERE ID = OBJECT_ID(N'tempdb..#Temp_View_CMS_Tree_Joined')
		)
	BEGIN
		drop table #Temp_View_CMS_Tree_Joined ;
	END
	--GO
		SELECT DISTINCT
			VCTJ.NodeGuid
			, VCTJ.NodeID
			, VCTJ.NodeName
			, VCTJ.DocumentGUID
			, VCTJ.NodeSiteID 
			, VCTJ.DocumentPublishedVersionHistoryID
			, CASE	WHEN CAST(VCTJ.DocumentCreatedWhen AS DATE) = CAST(vctj.DocumentModifiedWhen AS DATE)
					THEN 'I'
					ELSE 'U'
				END AS ChangeType
			, VCTJ.DocumentCreatedWhen
			, VCTJ.DocumentModifiedWhen
			, VCTJ.DocumentCulture
		INTO #Temp_View_CMS_Tree_Joined
		FROM
		View_CMS_Tree_Joined AS VCTJ
		--where VCTJ.DocumentCulture = 'en-us'

		--GO 
		CREATE CLUSTERED INDEX PI_Temp_View_CMS_Tree_Joined
		ON [dbo].#Temp_View_CMS_Tree_Joined (
			[NodeID], 
			NodeSiteID,
			[NodeName],
			[DocumentGUID], 
			[DocumentPublishedVersionHistoryID],
			[DocumentCreatedWhen],
			[DocumentModifiedWhen]
		)
		--GO 

	IF EXISTS
		(
			SELECT name
			FROM tempdb.dbo.sysobjects
			WHERE ID = OBJECT_ID(N'tempdb..#Temp_View_HFit_HealthAssesmentModule_Joined')
		)
	BEGIN
		drop table #Temp_View_HFit_HealthAssesmentModule_Joined ;
	END
		--GO
		SELECT 
			VHFHAMJ.Title AS ModTitle
			, dbo.udf_StripHTML(left(VHFHAMJ.IntroText,4000)) AS IntroText
			, VHFHAMJ.DocumentGUID
			, VHFHAMJ.Weight
			, VHFHAMJ.IsEnabled
			, VHFHAMJ.CodeName AS ModCodeName
			, VHFHAMJ.DocumentPublishedVersionHistoryID AS ModDocPubVerID
			, VHFHAMJ.NodeParentID
			, VHFHAMJ.DocumentNodeID
			, VHFHAMJ.Title
			, VHFHAMJ.CodeName
			, VHFHAMJ.DocumentPublishedVersionHistoryID
			,VHFHAMJ.DocumentCulture
		INTO #Temp_View_HFit_HealthAssesmentModule_Joined
		FROM
		View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ
		--where VHFHAMJ.DocumentCulture = 'en-us'
		--GO
		Create clustered index PI_Temp_View_HFit_HealthAssesmentModule_Joined on #Temp_View_HFit_HealthAssesmentModule_Joined
		(
			NodeParentID, DocumentNodeID	,
			DocumentGUID, 
			Weight, 
			IsEnabled, 
			Title, 
			CodeName, 
			DocumentPublishedVersionHistoryID	
		)
		--GO
 
	 IF EXISTS
		(
			SELECT name
			FROM tempdb.dbo.sysobjects
			WHERE ID = OBJECT_ID(N'tempdb..#Temp_View_HFit_HealthAssesmentRiskCategory_Joined')
		)
	BEGIN
		drop table #Temp_View_HFit_HealthAssesmentRiskCategory_Joined ;
	END

	 --GO
		SELECT VHFHARCJ.Title
			, VHFHARCJ.Weight
			, VHFHARCJ.DocumentGUID
			, VHFHARCJ.IsEnabled
			, VHFHARCJ.CodeName
			, VHFHARCJ.DocumentPublishedVersionHistoryID
			, VHFHARCJ.NodeParentID
			, VHFHARCJ.DocumentNodeID
			, VHFHARCJ.DocumentCulture
		INTO #Temp_View_HFit_HealthAssesmentRiskCategory_Joined
		FROM
		View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ
		--where VHFHARCJ.DocumentCulture = 'en-us'	
		--GO

		create clustered index PI_Temp_View_HFit_HealthAssesmentRiskCategory_Joined on #Temp_View_HFit_HealthAssesmentRiskCategory_Joined
		(
			NodeParentID, DocumentGUID, DocumentNodeID
		)

	
	IF EXISTS
		(
			SELECT name
			FROM tempdb.dbo.sysobjects
			WHERE ID = OBJECT_ID(N'tempdb..#Temp_View_HFit_HealthAssesmentRiskArea_Joined')
		)
	BEGIN
		drop table #Temp_View_HFit_HealthAssesmentRiskArea_Joined ;
	END

		--GO
		SELECT 
			VHFHARAJ.Title
			, VHFHARAJ.Weight 
			, VHFHARAJ.DocumentGUID
			, VHFHARAJ.IsEnabled
			, VHFHARAJ.CodeName
			, VHFHARAJ.ScoringStrategyID
			, VHFHARAJ.DocumentPublishedVersionHistoryID
			, VHFHARAJ.NodeParentID
			, VHFHARAJ.DocumentNodeID
			, VHFHARAJ.DocumentCulture
		INTO #Temp_View_HFit_HealthAssesmentRiskArea_Joined
		FROM
		View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ
		--where VHFHARAJ.DocumentCulture = 'en-us'
 
	 --GO
	 Create clustered index PI_Temp_View_HFit_HealthAssesmentRiskArea_Joined on #Temp_View_HFit_HealthAssesmentRiskArea_Joined
	 (
		DocumentNodeID, NodeParentID, DocumentGUID
	 )
  	
	IF EXISTS
		(
			SELECT name
			FROM tempdb.dbo.sysobjects
			WHERE ID = OBJECT_ID(N'tempdb..#Temp_View_EDW_HealthAssesmentQuestions')
		)
	BEGIN
		drop table #Temp_View_EDW_HealthAssesmentQuestions ;
	END

	 --GO
	 SELECT 
			VHFHAQ.QuestionType
			, dbo.udf_StripHTML(left(VHFHAQ.Title,4000)) AS Title
			, VHFHAQ.[Weight]
			, VHFHAQ.IsRequired
			, VHFHAQ.DocumentGUID
			, VHFHAQ.IsEnabled
			--, VHFHAQ.IsVisible
			, left(VHFHAQ.IsVisible,4000) AS IsVisible
			, VHFHAQ.IsStaging
			, VHFHAQ.CodeName
			, VHFHAQ.DocumentPublishedVersionHistoryID
			, VHFHAQ.NodeParentID
			, VHFHAQ.NodeGuid
			, VHFHAQ.NodeID
			, VHFHAQ.DocumentCulture
		INTO #Temp_View_EDW_HealthAssesmentQuestions
		FROM
		View_EDW_HealthAssesmentQuestions AS VHFHAQ
		--where VHFHAQ.DocumentCulture = 'en-us'

		--GO
		Create clustered index  PI_Temp_View_HFit_HealthAssesmentQuestions on #Temp_View_EDW_HealthAssesmentQuestions
		(
			NodeGuid, NodeParentID
		)

		--GO
	IF EXISTS
		(
			SELECT name
			FROM tempdb.dbo.sysobjects
			WHERE ID = OBJECT_ID(N'tempdb..#Temp_View_EDW_HealthAssesmentAnswers')
		)
	BEGIN
		drop table #Temp_View_EDW_HealthAssesmentAnswers ;
	END

		--GO
		SELECT 
			VHFHAA.Value
			, VHFHAA.Points
			, VHFHAA.DocumentGUID
			, VHFHAA.IsEnabled 
			, VHFHAA.CodeName 
			, VHFHAA.UOM 
			, VHFHAA.DocumentPublishedVersionHistoryID 
			, VHFHAA.NodeParentID
			, VHFHAA.NodeGuid
			, VHFHAA.NodeID
			, VHFHAA.DocumentCulture
		INTO #Temp_View_EDW_HealthAssesmentAnswers
		FROM
		View_EDW_HealthAssesmentAnswers AS VHFHAA 
		--where VHFHAA.DocumentCulture = 'en-us'
		--GO 

		create clustered index PI_Temp_View_HFit_HealthAssesmentAnswers on #Temp_View_EDW_HealthAssesmentAnswers
		(
			NodeParentID, DocumentGUID, DocumentPublishedVersionHistoryID,
			Value, Points, IsEnabled, CodeName, UOM
		)

	--GO  

	IF NOT EXISTS
	(
		SELECT name
		FROM sys.indexes
		WHERE name = N'PI04_View_CMS_Tree_Joined_Linked'
	)
	BEGIN
		CREATE NONCLUSTERED INDEX PI04_View_CMS_Tree_Joined_Linked
		ON [dbo].[View_CMS_Tree_Joined_Linked] ([ClassName])
		INCLUDE ([NodeParentID],[DocumentGUID],[DocumentForeignKeyValue],[DocumentPublishedVersionHistoryID],[DocumentNodeID])
		--GO 
	END

	IF NOT EXISTS
	(
		SELECT name
		FROM sys.indexes
		WHERE name = N'PI_Temp_View_HFit_HealthAssesmentModule_Joined'
	)
	BEGIN
		drop index #Temp_View_HFit_HealthAssesmentModule_Joined.PI_Temp_View_HFit_HealthAssesmentModule_Joined ;
	END
	IF NOT EXISTS
	(
		SELECT name
		FROM sys.indexes
		WHERE name = N'PI_Temp_View_HFit_HealthAssesmentModule_Joined'
	)
	BEGIN
		create clustered index PI_Temp_View_HFit_HealthAssesmentModule_Joined 
		on #Temp_View_HFit_HealthAssesmentModule_Joined
		(
			DocumentGUID, 
			Weight, 
			IsEnabled, 
			Title, 
			CodeName, 
			DocumentPublishedVersionHistoryID	
		)
	END

	IF NOT EXISTS
		(
			SELECT name
			FROM sys.indexes
			WHERE name = N'PI01_HFit_Account'
		)
	BEGIN
			CREATE index PI01_HFit_Account on HFit_Account
			(
				SiteID
			)
	END

	IF NOT EXISTS
		(
			SELECT name
			FROM sys.indexes
			where name = N'CI01_View_CMS_Tree_Joined_Linked'
		)
	BEGIN
		CREATE NONCLUSTERED INDEX [CI01_View_CMS_Tree_Joined_Linked]
		ON [dbo].[View_CMS_Tree_Joined_Linked] 
		([ClassName]) INCLUDE ([NodeGuid],[DocumentGUID],[DocumentForeignKeyValue])
	END
	--GO 

if @TrackPerf is not null 
BEGIN
	set @P0End = getdate() ;
	exec proc_EDW_MeasurePerf 'ElapsedTime','HADef-P0',0, @P0Start, @P0End;
END

set @P1Start = getdate() ;


	/****************************************************************************************/
	--Begin the view using the TEMP tables
	/****************************************************************************************/

insert into EDW_HealthAssessmentDefinition
	(
	[SiteGuid],
		[AccountCD],
		[HANodeID],
		[HANodeName],
		[HADocumentID],
		[HANodeSiteID],
		[HADocPubVerID],
		[ModTitle],
		[IntroText],
		[ModDocGuid],
		[ModWeight],
		[ModIsEnabled],
		[ModCodeName],
		[ModDocPubVerID],
		[RCTitle],
		[RCWeight],
		[RCDocumentGUID],
		[RCIsEnabled],
		[RCCodeName],
		[RCDocPubVerID],
		[RATytle],
		[RAWeight],
		[RADocumentGuid],
		[RAIsEnabled],
		[RACodeName],
		[RAScoringStrategyID],
		[RADocPubVerID],
		[QuestionType],
		[QuesTitle],
		[QuesWeight],
		[QuesIsRequired],
		[QuesDocumentGuid],
		[QuesIsEnabled],
		[QuesIsVisible],
		[QuesIsSTaging],
		[QuestionCodeName],
		[QuesDocPubVerID],
		[AnsValue],
		[AnsPoints],
		[AnsDocumentGuid],
		[AnsIsEnabled],
		[AnsCodeName],
		[AnsUOM],
		[AnsDocPUbVerID],
		[ChangeType],
		[DocumentCreatedWhen],
		[DocumentModifiedWhen],
		[CmsTreeNodeGuid],
		[HANodeGUID]
	)

		SELECT Distinct 
		NULL as SiteGuid --cs.SiteGUID		--WDM 08.07.2014 per conversation with John Croft
		, NULL as AccountCD     --, HFA.AccountCD		--WDM 08.07.2014 per conversation with John Croft
		, HA.NodeID AS HANodeID		--WDM 08.07.2014
		, HA.NodeName AS HANodeName		--WDM 08.07.2014
		, HA.DocumentID AS HADocumentID		--WDM 08.07.2014
		, HA.NodeSiteID AS HANodeSiteID		--WDM 08.07.2014
		, HA.DocumentPublishedVersionHistoryID AS HADocPubVerID		--WDM 08.07.2014
		, VHFHAMJ.Title AS ModTitle
		--Per EDW Team, HTML text is truncated to 4000 bytes - we'll just do it here
		--, dbo.udf_StripHTML(left(left(VHFHAMJ.IntroText,4000),4000)) AS IntroText
		, VHFHAMJ.IntroText 
		, VHFHAMJ.DocumentGuid AS ModDocGuid	--, VHFHAMJ.DocumentID AS ModDocID	--WDM 08.07.2014
		, VHFHAMJ.Weight AS ModWeight
		, VHFHAMJ.IsEnabled AS ModIsEnabled
		, VHFHAMJ.CodeName AS ModCodeName
		, VHFHAMJ.DocumentPublishedVersionHistoryID AS ModDocPubVerID
		, VHFHARCJ.Title AS RCTitle
		, VHFHARCJ.Weight AS RCWeight
		, VHFHARCJ.DocumentGuid AS RCDocumentGUID	--, VHFHARCJ.DocumentID AS RCDocumentID	--WDM 08.07.2014
		, VHFHARCJ.IsEnabled AS RCIsEnabled
		, VHFHARCJ.CodeName AS RCCodeName
		, VHFHARCJ.DocumentPublishedVersionHistoryID AS RCDocPubVerID
		, VHFHARAJ.Title AS RATytle
		, VHFHARAJ.Weight AS RAWeight
		, VHFHARAJ.DocumentGuid AS RADocumentGuid	--, VHFHARAJ.DocumentID AS RADocumentID	--WDM 08.07.2014
		, VHFHARAJ.IsEnabled AS RAIsEnabled
		, VHFHARAJ.CodeName AS RACodeName
		, VHFHARAJ.ScoringStrategyID AS RAScoringStrategyID
		, VHFHARAJ.DocumentPublishedVersionHistoryID AS RADocPubVerID
		, VHFHAQ.QuestionType
		--, dbo.udf_StripHTML(left(VHFHAQ.Title,4000)) AS QuesTitle
		, VHFHAQ.Title AS QuesTitle
		, VHFHAQ.Weight AS QuesWeight
		, VHFHAQ.IsRequired AS QuesIsRequired

		, VHFHAQ.DocumentGuid AS QuesDocumentGuid	--, VHFHAQ.DocumentID AS QuesDocumentID	--WDM 08.07.2014
		
		, VHFHAQ.IsEnabled AS QuesIsEnabled
		, left(VHFHAQ.IsVisible,4000) AS QuesIsVisible
		, VHFHAQ.IsStaging AS QuesIsSTaging
		, VHFHAQ.CodeName AS QuestionCodeName
		, VHFHAQ.DocumentPublishedVersionHistoryID AS QuesDocPubVerID
		, VHFHAA.Value AS AnsValue
		, VHFHAA.Points AS AnsPoints
		
		, VHFHAA.DocumentGuid AS AnsDocumentGuid	--, VHFHAA.DocumentID AS AnsDocumentID	--WDM 08.07.2014
		
		, VHFHAA.IsEnabled AS AnsIsEnabled
		, VHFHAA.CodeName AS AnsCodeName
		, VHFHAA.UOM AS AnsUOM
		, VHFHAA.DocumentPublishedVersionHistoryID AS AnsDocPUbVerID
		, CASE	WHEN CAST(VCTJ.DocumentCreatedWhen AS DATE) = CAST(vctj.DocumentModifiedWhen AS DATE)
			THEN 'I'
			ELSE 'U'
		END AS ChangeType
		, VCTJ.DocumentCreatedWhen
		, VCTJ.DocumentModifiedWhen
		, VCTJ.NodeGuid as CmsTreeNodeGuid	--WDM 08.07.2014 ADDED TO the returned Columns
		, HA.NodeGUID as HANodeGUID
	 FROM
		dbo.#Temp_View_CMS_Tree_Joined AS VCTJ
		INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
		INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID
 
		--Campaign links Client which links to Assessment
		INNER JOIN dbo.#Temp_View_HFit_HACampaign_Joined as c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID
 
		INNER JOIN #Temp_View_HFit_HealthAssessment_Joined as HA WITH (NOLOCK) ON c.HealthAssessmentID = HA.DocumentID
		--WDM 08.07.2014
		INNER JOIN dbo.#Temp_View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ ON HA.NodeID = VHFHAMJ.NodeParentID		
		INNER JOIN dbo.#Temp_View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
		INNER JOIN dbo.#Temp_View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
		INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentQuestions AS VHFHAQ ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
		LEFT OUTER JOIN dbo.#Temp_View_EDW_HealthAssesmentAnswers AS VHFHAA ON VHFHAQ.NodeID = VHFHAA.NodeParentID
	where VCTJ.DocumentCulture = 'en-us'	--WDM 08.07.2014
		and VHFHAQ.DocumentCulture = 'en-us'	--WDM 08.12.2014	
		and (VHFHAA.DocumentCulture = 'en-us' OR VHFHAA.DocumentCulture is null)	--WDM 08.12.2014		
		and VHFHARCJ.DocumentCulture = 'en-us'	--WDM 08.12.2014		
		and VHFHARAJ.DocumentCulture = 'en-us'	--WDM 08.12.2014	
		and VHFHAMJ.DocumentCulture = 'en-us'	--WDM 08.12.2014		
		AND (VCTJ.DocumentCreatedWhen between @StartDate and @EndDate OR VCTJ.DocumentModifiedWhen between @StartDate and @EndDate)

UNION ALL
--WDM Retrieve Matrix Level 1 Question Group
	SELECT Distinct
		NULL as SiteGuid --cs.SiteGUID
		, NULL as AccountCD     --, HFA.AccountCD
		, HA.NodeID		--WDM 08.07.2014
		, HA.NodeName		--WDM 08.07.2014
		, HA.DocumentID		--WDM 08.07.2014
		, HA.NodeSiteID		--WDM 08.07.2014
       --,VCTJ.NodeAliasPath
		, HA.DocumentPublishedVersionHistoryID		--WDM 08.07.2014
		, VHFHAMJ.Title
		--, dbo.udf_StripHTML(left(left(VHFHAMJ.IntroText,4000),4000)) AS IntroText
		, VHFHAMJ.IntroText
		, VHFHAMJ.DocumentGUID
		, VHFHAMJ.Weight
		, VHFHAMJ.IsEnabled
		, VHFHAMJ.CodeName
       --,VHFHAMJ.NodeAliasPath
		, VHFHAMJ.DocumentPublishedVersionHistoryID
		, VHFHARCJ.Title
		, VHFHARCJ.Weight
		, VHFHARCJ.DocumentGUID
		, VHFHARCJ.IsEnabled
		, VHFHARCJ.CodeName
       --,VHFHARCJ.NodeAliasPath
		, VHFHARCJ.DocumentPublishedVersionHistoryID
		, VHFHARAJ.Title
		, VHFHARAJ.Weight
		, VHFHARAJ.DocumentGUID
		, VHFHARAJ.IsEnabled
		, VHFHARAJ.CodeName
       --,VHFHARAJ.NodeAliasPath
		, VHFHARAJ.ScoringStrategyID
		, VHFHARAJ.DocumentPublishedVersionHistoryID
		, VHFHAQ2.QuestionType
		--, dbo.udf_StripHTML(left(VHFHAQ2.Title,4000)) AS QuesTitle
		, VHFHAQ2.Title AS QuesTitle
		, VHFHAQ2.Weight
		, VHFHAQ2.IsRequired
		, VHFHAQ2.DocumentGUID
		, VHFHAQ2.IsEnabled
		, left(VHFHAQ2.IsVisible,4000)
		, VHFHAQ2.IsStaging
		, VHFHAQ2.CodeName AS QuestionCodeName
       --,VHFHAQ2.NodeAliasPath
		, VHFHAQ2.DocumentPublishedVersionHistoryID
		, VHFHAA2.Value
		, VHFHAA2.Points
		, VHFHAA2.DocumentGUID
		, VHFHAA2.IsEnabled
		, VHFHAA2.CodeName
		, VHFHAA2.UOM
       --,VHFHAA2.NodeAliasPath
		, VHFHAA2.DocumentPublishedVersionHistoryID
		, CASE	WHEN CAST(VCTJ.DocumentCreatedWhen AS DATE) = CAST(vctj.DocumentModifiedWhen AS DATE)
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		, VCTJ.DocumentCreatedWhen
		, VCTJ.DocumentModifiedWhen
		, VCTJ.NodeGuid as CmsTreeNodeGuid	--WDM 08.07.2014
		, HA.NodeGUID as HANodeGUID
	 FROM
		dbo.#Temp_View_CMS_Tree_Joined AS VCTJ

		INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
		INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID
		INNER JOIN dbo.#Temp_View_HFit_HACampaign_Joined c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID
		INNER JOIN #Temp_View_HFit_HealthAssessment_Joined HA WITH (NOLOCK) ON c.HealthAssessmentID = HA.DocumentID
		INNER JOIN dbo.#Temp_View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ ON HA.NodeID = VHFHAMJ.NodeParentID
		INNER JOIN dbo.#Temp_View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
		INNER JOIN dbo.#Temp_View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
		INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentQuestions AS VHFHAQ ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
		LEFT OUTER JOIN dbo.#Temp_View_EDW_HealthAssesmentAnswers AS VHFHAA ON VHFHAQ.NodeID = VHFHAA.NodeParentID
		--matrix level 1 questiongroup
		INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
		INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID
	where VCTJ.DocumentCulture = 'en-us'	--WDM 08.07.2014
		and VHFHAQ.DocumentCulture = 'en-us'	--WDM 08.12.2014	
		and (VHFHAA.DocumentCulture = 'en-us' OR VHFHAA.DocumentCulture is null)	--WDM 08.12.2014		
		and VHFHARCJ.DocumentCulture = 'en-us'	--WDM 08.12.2014		
		and VHFHARAJ.DocumentCulture = 'en-us'	--WDM 08.12.2014		
		and VHFHAMJ.DocumentCulture = 'en-us'	--WDM 08.12.2014		
		AND (VCTJ.DocumentCreatedWhen between @StartDate and @EndDate OR VCTJ.DocumentModifiedWhen between @StartDate and @EndDate)

UNION ALL
--WDM Retrieve Branching Level 1 Question and Matrix Level 1 Question Group
	SELECT Distinct
		NULL as SiteGuid --cs.SiteGUID
		, NULL as AccountCD     --, HFA.AccountCD
		, HA.NodeID		--WDM 08.07.2014
		, HA.NodeName		--WDM 08.07.2014
		, HA.DocumentID		--WDM 08.07.2014
		, HA.NodeSiteID		--WDM 08.07.2014
       --,VCTJ.NodeAliasPath
		, HA.DocumentPublishedVersionHistoryID		--WDM 08.07.2014
		, VHFHAMJ.Title
		--, dbo.udf_StripHTML(left(VHFHAMJ.IntroText,4000)) AS IntroText
		, VHFHAMJ.IntroText 
		, VHFHAMJ.DocumentGUID
		, VHFHAMJ.Weight
		, VHFHAMJ.IsEnabled
		, VHFHAMJ.CodeName
       --,VHFHAMJ.NodeAliasPath
		, VHFHAMJ.DocumentPublishedVersionHistoryID
		, VHFHARCJ.Title
		, VHFHARCJ.Weight
		, VHFHARCJ.DocumentGUID
		, VHFHARCJ.IsEnabled
		, VHFHARCJ.CodeName
       --,VHFHARCJ.NodeAliasPath
		, VHFHARCJ.DocumentPublishedVersionHistoryID
		, VHFHARAJ.Title
		, VHFHARAJ.Weight
		, VHFHARAJ.DocumentGUID
		, VHFHARAJ.IsEnabled
		, VHFHARAJ.CodeName
       --,VHFHARAJ.NodeAliasPath
		, VHFHARAJ.ScoringStrategyID
		, VHFHARAJ.DocumentPublishedVersionHistoryID
		, VHFHAQ3.QuestionType
		--, dbo.udf_StripHTML(left(VHFHAQ3.Title,4000)) AS QuesTitle
		, VHFHAQ3.Title AS QuesTitle
		, VHFHAQ3.Weight
		, VHFHAQ3.IsRequired
		, VHFHAQ3.DocumentGUID
		, VHFHAQ3.IsEnabled
		, left(VHFHAQ3.IsVisible,4000)
		, VHFHAQ3.IsStaging
		, VHFHAQ3.CodeName AS QuestionCodeName
       --,VHFHAQ3.NodeAliasPath
		, VHFHAQ3.DocumentPublishedVersionHistoryID
		, VHFHAA3.Value
		, VHFHAA3.Points
		, VHFHAA3.DocumentGUID
		, VHFHAA3.IsEnabled
		, VHFHAA3.CodeName
		, VHFHAA3.UOM
       --,VHFHAA3.NodeAliasPath
		, VHFHAA3.DocumentPublishedVersionHistoryID
		, CASE	WHEN CAST(VCTJ.DocumentCreatedWhen AS DATE) = CAST(vctj.DocumentModifiedWhen AS DATE)
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		, VCTJ.DocumentCreatedWhen
		, VCTJ.DocumentModifiedWhen
		, VCTJ.NodeGuid as CmsTreeNodeGuid	--WDM 08.07.2014
		, HA.NodeGUID as HANodeGUID
 FROM
  dbo.#Temp_View_CMS_Tree_Joined AS VCTJ

 INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
 INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID
 INNER JOIN dbo.#Temp_View_HFit_HACampaign_Joined c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID
 INNER JOIN #Temp_View_HFit_HealthAssessment_Joined HA WITH (NOLOCK) ON c.HealthAssessmentID = HA.DocumentID
 INNER JOIN dbo.#Temp_View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ ON HA.NodeID = VHFHAMJ.NodeParentID
 INNER JOIN dbo.#Temp_View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
 INNER JOIN dbo.#Temp_View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
 INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentQuestions AS VHFHAQ ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
 LEFT OUTER JOIN dbo.#Temp_View_EDW_HealthAssesmentAnswers AS VHFHAA ON VHFHAQ.NodeID = VHFHAA.NodeParentID

--matrix level 1 questiongroup
--INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
--INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID

--Branching Level 1 Question 
	INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentQuestions AS VHFHAQ3 ON VHFHAA.NodeID = VHFHAQ3.NodeParentID
	LEFT OUTER JOIN dbo.#Temp_View_EDW_HealthAssesmentAnswers AS VHFHAA3 ON VHFHAQ3.NodeID = VHFHAA3.NodeParentID
where VCTJ.DocumentCulture = 'en-us'	--WDM 08.07.2014
		and VHFHAQ.DocumentCulture = 'en-us'	--WDM 08.12.2014	
		and (VHFHAA.DocumentCulture = 'en-us' OR VHFHAA.DocumentCulture is null)	--WDM 08.12.2014		
		and VHFHARCJ.DocumentCulture = 'en-us'	--WDM 08.12.2014		
		and VHFHARAJ.DocumentCulture = 'en-us'	--WDM 08.12.2014		
		and VHFHAMJ.DocumentCulture = 'en-us'	--WDM 08.12.2014		
AND (VCTJ.DocumentCreatedWhen between @StartDate and @EndDate OR VCTJ.DocumentModifiedWhen between @StartDate and @EndDate)

UNION ALL
--WDM Retrieve Branching Level 1 Question and Matrix Level 2 Question Group
	SELECT Distinct
		NULL as SiteGuid --cs.SiteGUID
		, NULL as AccountCD     --, HFA.AccountCD
		, HA.NodeID		--WDM 08.07.2014
		, HA.NodeName		--WDM 08.07.2014
		, HA.DocumentID		--WDM 08.07.2014
		, HA.NodeSiteID		--WDM 08.07.2014
       --,VCTJ.NodeAliasPath
		, HA.DocumentPublishedVersionHistoryID		--WDM 08.07.2014
		, VHFHAMJ.Title
		--, dbo.udf_StripHTML(left(VHFHAMJ.IntroText,4000)) AS IntroText
		, VHFHAMJ.IntroText
		, VHFHAMJ.DocumentGUID
		, VHFHAMJ.Weight
		, VHFHAMJ.IsEnabled
		, VHFHAMJ.CodeName
       --,VHFHAMJ.NodeAliasPath
		, VHFHAMJ.DocumentPublishedVersionHistoryID
		, VHFHARCJ.Title
		, VHFHARCJ.Weight
		, VHFHARCJ.DocumentGUID
		, VHFHARCJ.IsEnabled
		, VHFHARCJ.CodeName
       --,VHFHARCJ.NodeAliasPath
		, VHFHARCJ.DocumentPublishedVersionHistoryID
		, VHFHARAJ.Title
		, VHFHARAJ.Weight
		, VHFHARAJ.DocumentGUID
		, VHFHARAJ.IsEnabled
		, VHFHARAJ.CodeName
       --,VHFHARAJ.NodeAliasPath
		, VHFHARAJ.ScoringStrategyID
		, VHFHARAJ.DocumentPublishedVersionHistoryID
		, VHFHAQ7.QuestionType
		--, dbo.udf_StripHTML(left(VHFHAQ7.Title,4000)) AS QuesTitle
		, VHFHAQ7.Title AS QuesTitle
		, VHFHAQ7.Weight
		, VHFHAQ7.IsRequired
		, VHFHAQ7.DocumentGUID
		, VHFHAQ7.IsEnabled
		, left(VHFHAQ7.IsVisible,4000)
		, VHFHAQ7.IsStaging
		, VHFHAQ7.CodeName AS QuestionCodeName
       --,VHFHAQ7.NodeAliasPath
		, VHFHAQ7.DocumentPublishedVersionHistoryID
		, VHFHAA7.Value
		, VHFHAA7.Points
		, VHFHAA7.DocumentGUID
		, VHFHAA7.IsEnabled
		, VHFHAA7.CodeName
		, VHFHAA7.UOM
       --,VHFHAA7.NodeAliasPath
		, VHFHAA7.DocumentPublishedVersionHistoryID
		, CASE	WHEN CAST(VCTJ.DocumentCreatedWhen AS DATE) = CAST(vctj.DocumentModifiedWhen AS DATE)
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		, VCTJ.DocumentCreatedWhen
		, VCTJ.DocumentModifiedWhen
		, VCTJ.NodeGuid as CmsTreeNodeGuid	--WDM 08.07.2014
		, HA.NodeGUID as HANodeGUID
 FROM
 dbo.#Temp_View_CMS_Tree_Joined AS VCTJ
 INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
 INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID
 INNER JOIN dbo.#Temp_View_HFit_HACampaign_Joined c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID
 INNER JOIN #Temp_View_HFit_HealthAssessment_Joined HA WITH (NOLOCK) ON c.HealthAssessmentID = HA.DocumentID
 INNER JOIN dbo.#Temp_View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ ON HA.NodeID = VHFHAMJ.NodeParentID
 INNER JOIN dbo.#Temp_View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
 INNER JOIN dbo.#Temp_View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
 INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentQuestions AS VHFHAQ ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
 LEFT OUTER JOIN dbo.#Temp_View_EDW_HealthAssesmentAnswers AS VHFHAA ON VHFHAQ.NodeID = VHFHAA.NodeParentID

--matrix level 1 questiongroup
--INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
--INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID

--Branching Level 1 Question 
	INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentQuestions AS VHFHAQ3 ON VHFHAA.NodeID = VHFHAQ3.NodeParentID
--LEFT OUTER JOIN dbo.#Temp_View_EDW_HealthAssesmentAnswers AS VHFHAA3 ON VHFHAQ3.NodeID = VHFHAA3.NodeParentID

--Matrix Level 2 Question Group
	INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentQuestions AS VHFHAQ7 ON VHFHAQ3.NodeID = VHFHAQ7.NodeParentID
	INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentAnswers AS VHFHAA7 ON VHFHAQ7.NodeID = VHFHAA7.NodeParentID
where VCTJ.DocumentCulture = 'en-us'	--WDM 08.07.2014
		and VHFHAQ.DocumentCulture = 'en-us'	--WDM 08.12.2014	
		and (VHFHAA.DocumentCulture = 'en-us' OR VHFHAA.DocumentCulture is null)	--WDM 08.12.2014		
		and VHFHARCJ.DocumentCulture = 'en-us'	--WDM 08.12.2014		
		and VHFHARAJ.DocumentCulture = 'en-us'	--WDM 08.12.2014		
		and VHFHAMJ.DocumentCulture = 'en-us'	--WDM 08.12.2014		
AND (VCTJ.DocumentCreatedWhen between @StartDate and @EndDate OR VCTJ.DocumentModifiedWhen between @StartDate and @EndDate)

UNION ALL
	--****************************************************
	--WDM 6/25/2014 Retrieve the Branching level 1 Question Group
	--THE PROBLEM LIES HERE in this part of query : 1:40 minute
	-- Added two perf indexes to the first query: 25 Sec
	--****************************************************
	SELECT Distinct
		NULL as SiteGuid --cs.SiteGUID
		, NULL as AccountCD     --, HFA.AccountCD
		, HA.NodeID		--WDM 08.07.2014
		, HA.NodeName		--WDM 08.07.2014
		, HA.DocumentID		--WDM 08.07.2014
		, HA.NodeSiteID		--WDM 08.07.2014
       --,VCTJ.NodeAliasPath
		, HA.DocumentPublishedVersionHistoryID		--WDM 08.07.2014
		, VHFHAMJ.Title
		--, dbo.udf_StripHTML(left(VHFHAMJ.IntroText,4000)) AS IntroText
		, VHFHAMJ.IntroText 
		, VHFHAMJ.DocumentGUID
		, VHFHAMJ.Weight
		, VHFHAMJ.IsEnabled
		, VHFHAMJ.CodeName
       --,VHFHAMJ.NodeAliasPath
		, VHFHAMJ.DocumentPublishedVersionHistoryID
		, VHFHARCJ.Title
		, VHFHARCJ.Weight
		, VHFHARCJ.DocumentGUID
		, VHFHARCJ.IsEnabled
		, VHFHARCJ.CodeName
       --,VHFHARCJ.NodeAliasPath
		, VHFHARCJ.DocumentPublishedVersionHistoryID
		, VHFHARAJ.Title
		, VHFHARAJ.Weight
		, VHFHARAJ.DocumentGUID
		, VHFHARAJ.IsEnabled
		, VHFHARAJ.CodeName
       --,VHFHARAJ.NodeAliasPath
		, VHFHARAJ.ScoringStrategyID
		, VHFHARAJ.DocumentPublishedVersionHistoryID
		, VHFHAQ8.QuestionType
		--, dbo.udf_StripHTML(left(VHFHAQ8.Title,4000)) AS QuesTitle
		, VHFHAQ8.Title AS QuesTitle
		, VHFHAQ8.Weight
		, VHFHAQ8.IsRequired
		, VHFHAQ8.DocumentGUID
		, VHFHAQ8.IsEnabled
		, left(VHFHAQ8.IsVisible,4000)
		, VHFHAQ8.IsStaging
		, VHFHAQ8.CodeName AS QuestionCodeName
       --,VHFHAQ8.NodeAliasPath
		, VHFHAQ8.DocumentPublishedVersionHistoryID
		, VHFHAA8.Value
		, VHFHAA8.Points
		, VHFHAA8.DocumentGUID
		, VHFHAA8.IsEnabled
		, VHFHAA8.CodeName
		, VHFHAA8.UOM
       --,VHFHAA8.NodeAliasPath
		, VHFHAA8.DocumentPublishedVersionHistoryID
		, CASE	WHEN CAST(VCTJ.DocumentCreatedWhen AS DATE) = CAST(vctj.DocumentModifiedWhen AS DATE)
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		, VCTJ.DocumentCreatedWhen
		, VCTJ.DocumentModifiedWhen
		, VCTJ.NodeGuid as CmsTreeNodeGuid	--WDM 08.07.2014
		, HA.NodeGUID as HANodeGUID
	FROM
  dbo.#Temp_View_CMS_Tree_Joined AS VCTJ

 INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
 INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID
 INNER JOIN dbo.#Temp_View_HFit_HACampaign_Joined c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID
 INNER JOIN #Temp_View_HFit_HealthAssessment_Joined HA WITH (NOLOCK) ON c.HealthAssessmentID = HA.DocumentID
 INNER JOIN dbo.#Temp_View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ ON HA.NodeID = VHFHAMJ.NodeParentID
 INNER JOIN dbo.#Temp_View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
 INNER JOIN dbo.#Temp_View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
 INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentQuestions AS VHFHAQ ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
 LEFT OUTER JOIN dbo.#Temp_View_EDW_HealthAssesmentAnswers AS VHFHAA ON VHFHAQ.NodeID = VHFHAA.NodeParentID

			--matrix level 1 questiongroup
			--INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
			--INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID

			--Branching Level 1 Question 
			INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentQuestions AS VHFHAQ3 ON VHFHAA.NodeID = VHFHAQ3.NodeParentID
			--LEFT OUTER JOIN dbo.#Temp_View_EDW_HealthAssesmentAnswers AS VHFHAA3 ON VHFHAQ3.NodeID = VHFHAA3.NodeParentID

			--Matrix Level 2 Question Group
			INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentQuestions AS VHFHAQ7 ON VHFHAQ3.NodeID = VHFHAQ7.NodeParentID
			INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentAnswers AS VHFHAA7 ON VHFHAQ7.NodeID = VHFHAA7.NodeParentID

			--Matrix branching level 1 question group
			INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentQuestions AS VHFHAQ8 ON VHFHAA7.NodeID = VHFHAQ8.NodeParentID
			INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentAnswers AS VHFHAA8 ON VHFHAQ8.NodeID = VHFHAA8.NodeParentID
where VCTJ.DocumentCulture = 'en-us'	--WDM 08.07.2014
		and VHFHAQ.DocumentCulture = 'en-us'	--WDM 08.12.2014	
		and (VHFHAA.DocumentCulture = 'en-us' OR VHFHAA.DocumentCulture is null)	--WDM 08.12.2014		
		and VHFHARCJ.DocumentCulture = 'en-us'	--WDM 08.12.2014		
		and VHFHARAJ.DocumentCulture = 'en-us'	--WDM 08.12.2014		
		and VHFHAMJ.DocumentCulture = 'en-us'	--WDM 08.12.2014		
AND (VCTJ.DocumentCreatedWhen between @StartDate and @EndDate OR VCTJ.DocumentModifiedWhen between @StartDate and @EndDate)

UNION ALL
	--****************************************************
	--WDM 6/25/2014 Retrieve the Branching level 2 Question Group
	--THE PROBLEM LIES HERE in this part of query : 1:48  minutes
	--With the new indexes: 29 Secs
	--****************************************************
	SELECT Distinct
		NULL as SiteGuid --cs.SiteGUID
		, NULL as AccountCD     --, HFA.AccountCD
		, HA.NodeID		--WDM 08.07.2014
		, HA.NodeName		--WDM 08.07.2014
		, HA.DocumentID		--WDM 08.07.2014
		, HA.NodeSiteID		--WDM 08.07.2014
       --,VCTJ.NodeAliasPath
		, HA.DocumentPublishedVersionHistoryID		--WDM 08.07.2014
		, VHFHAMJ.Title
		--, dbo.udf_StripHTML(left(VHFHAMJ.IntroText,4000)) AS IntroText
		, VHFHAMJ.IntroText
		, VHFHAMJ.DocumentGUID
		, VHFHAMJ.Weight
		, VHFHAMJ.IsEnabled
		, VHFHAMJ.CodeName
       --,VHFHAMJ.NodeAliasPath
		, VHFHAMJ.DocumentPublishedVersionHistoryID
		, VHFHARCJ.Title
		, VHFHARCJ.Weight
		, VHFHARCJ.DocumentGUID
		, VHFHARCJ.IsEnabled
		, VHFHARCJ.CodeName
       --,VHFHARCJ.NodeAliasPath
		, VHFHARCJ.DocumentPublishedVersionHistoryID
		, VHFHARAJ.Title
		, VHFHARAJ.Weight
		, VHFHARAJ.DocumentGUID
		, VHFHARAJ.IsEnabled
		, VHFHARAJ.CodeName
       --,VHFHARAJ.NodeAliasPath
		, VHFHARAJ.ScoringStrategyID
		, VHFHARAJ.DocumentPublishedVersionHistoryID
		, VHFHAQ4.QuestionType
		--, dbo.udf_StripHTML(left(VHFHAQ4.Title,4000)) AS QuesTitle
		, VHFHAQ4.Title AS QuesTitle
		, VHFHAQ4.Weight
		, VHFHAQ4.IsRequired
		, VHFHAQ4.DocumentGUID
		, VHFHAQ4.IsEnabled
		, left(VHFHAQ4.IsVisible,4000)
		, VHFHAQ4.IsStaging
		, VHFHAQ4.CodeName AS QuestionCodeName
       --,VHFHAQ4.NodeAliasPath
		, VHFHAQ4.DocumentPublishedVersionHistoryID
		, VHFHAA4.Value
		, VHFHAA4.Points
		, VHFHAA4.DocumentGUID
		, VHFHAA4.IsEnabled
		, VHFHAA4.CodeName
		, VHFHAA4.UOM
       --,VHFHAA4.NodeAliasPath
		, VHFHAA4.DocumentPublishedVersionHistoryID
		, CASE	WHEN CAST(VCTJ.DocumentCreatedWhen AS DATE) = CAST(vctj.DocumentModifiedWhen AS DATE)
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		, VCTJ.DocumentCreatedWhen
		, VCTJ.DocumentModifiedWhen
		, VCTJ.NodeGuid as CmsTreeNodeGuid	--WDM 08.07.2014
		, HA.NodeGUID as HANodeGUID
 FROM
  dbo.#Temp_View_CMS_Tree_Joined AS VCTJ

 INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
 INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID
 INNER JOIN dbo.#Temp_View_HFit_HACampaign_Joined c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID
 INNER JOIN #Temp_View_HFit_HealthAssessment_Joined HA WITH (NOLOCK) ON c.HealthAssessmentID = HA.DocumentID
 INNER JOIN dbo.#Temp_View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ ON HA.NodeID = VHFHAMJ.NodeParentID
 INNER JOIN dbo.#Temp_View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
 INNER JOIN dbo.#Temp_View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
 INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentQuestions AS VHFHAQ ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
 LEFT OUTER JOIN dbo.#Temp_View_EDW_HealthAssesmentAnswers AS VHFHAA ON VHFHAQ.NodeID = VHFHAA.NodeParentID

			--matrix level 1 questiongroup
			--INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
			--INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID

			--Branching Level 1 Question 
			INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentQuestions AS VHFHAQ3 ON VHFHAA.NodeID = VHFHAQ3.NodeParentID
			LEFT OUTER JOIN dbo.#Temp_View_EDW_HealthAssesmentAnswers AS VHFHAA3 ON VHFHAQ3.NodeID = VHFHAA3.NodeParentID

			--Matrix Level 2 Question Group
			--INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentQuestions AS VHFHAQ7 ON VHFHAQ3.NodeID = VHFHAQ7.NodeParentID
			--INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentAnswers AS VHFHAA7 ON VHFHAQ7.NodeID = VHFHAA7.NodeParentID

			--Matrix branching level 1 question group
			--INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentQuestions AS VHFHAQ8 ON VHFHAA7.NodeID = VHFHAQ8.NodeParentID
			--INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentAnswers AS VHFHAA8 ON VHFHAQ8.NodeID = VHFHAA8.NodeParentID

			--Branching level 2 Question Group
			INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentQuestions AS VHFHAQ4 ON VHFHAA3.NodeID = VHFHAQ4.NodeParentID
			INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentAnswers AS VHFHAA4 ON VHFHAQ4.NodeID = VHFHAA4.NodeParentID
where VCTJ.DocumentCulture = 'en-us'	--WDM 08.07.2014
		and VHFHAQ.DocumentCulture = 'en-us'	--WDM 08.12.2014	
		and (VHFHAA.DocumentCulture = 'en-us'  OR VHFHAA.DocumentCulture is null)	--WDM 08.12.2014		
		and VHFHARCJ.DocumentCulture = 'en-us'	--WDM 08.12.2014		
		and VHFHARAJ.DocumentCulture = 'en-us'	--WDM 08.12.2014		
		and VHFHAMJ.DocumentCulture = 'en-us'	--WDM 08.12.2014		
AND (VCTJ.DocumentCreatedWhen between @StartDate and @EndDate OR VCTJ.DocumentModifiedWhen between @StartDate and @EndDate)

UNION ALL
--WDM 6/25/2014 Retrieve the Branching level 3 Question Group
	SELECT Distinct
		NULL as SiteGuid --cs.SiteGUID
		, NULL as AccountCD     --, HFA.AccountCD
		, HA.NodeID		--WDM 08.07.2014
		, HA.NodeName		--WDM 08.07.2014
		, HA.DocumentID		--WDM 08.07.2014
		, HA.NodeSiteID		--WDM 08.07.2014
       --,VCTJ.NodeAliasPath
		, HA.DocumentPublishedVersionHistoryID		--WDM 08.07.2014
		, VHFHAMJ.Title
		--, dbo.udf_StripHTML(left(VHFHAMJ.IntroText,4000)) AS IntroText
		, VHFHAMJ.IntroText
		, VHFHAMJ.DocumentGUID
		, VHFHAMJ.Weight
		, VHFHAMJ.IsEnabled
		, VHFHAMJ.CodeName
       --,VHFHAMJ.NodeAliasPath
		, VHFHAMJ.DocumentPublishedVersionHistoryID
		, VHFHARCJ.Title
		, VHFHARCJ.Weight
		, VHFHARCJ.DocumentGUID
		, VHFHARCJ.IsEnabled
		, VHFHARCJ.CodeName
       --,VHFHARCJ.NodeAliasPath
		, VHFHARCJ.DocumentPublishedVersionHistoryID
		, VHFHARAJ.Title
		, VHFHARAJ.Weight
		, VHFHARAJ.DocumentGUID
		, VHFHARAJ.IsEnabled
		, VHFHARAJ.CodeName
       --,VHFHARAJ.NodeAliasPath
		, VHFHARAJ.ScoringStrategyID
		, VHFHARAJ.DocumentPublishedVersionHistoryID
		, VHFHAQ5.QuestionType
		, VHFHAQ5.Title AS QuesTitle
		, VHFHAQ5.Weight
		, VHFHAQ5.IsRequired
		, VHFHAQ5.DocumentGUID
		, VHFHAQ5.IsEnabled
		, left(VHFHAQ5.IsVisible,4000)
		, VHFHAQ5.IsStaging
		, VHFHAQ5.CodeName AS QuestionCodeName
       --,VHFHAQ5.NodeAliasPath
		, VHFHAQ5.DocumentPublishedVersionHistoryID
		, VHFHAA5.Value
		, VHFHAA5.Points
		, VHFHAA5.DocumentGUID
		, VHFHAA5.IsEnabled
		, VHFHAA5.CodeName
		, VHFHAA5.UOM
       --,VHFHAA5.NodeAliasPath
		, VHFHAA5.DocumentPublishedVersionHistoryID
		, CASE	WHEN CAST(VCTJ.DocumentCreatedWhen AS DATE) = CAST(vctj.DocumentModifiedWhen AS DATE)
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		, VCTJ.DocumentCreatedWhen
		, VCTJ.DocumentModifiedWhen
		, VCTJ.NodeGuid as CmsTreeNodeGuid	--WDM 08.07.2014
		, HA.NodeGUID as HANodeGUID
 FROM
  dbo.#Temp_View_CMS_Tree_Joined AS VCTJ

 INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
 INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID
 INNER JOIN dbo.#Temp_View_HFit_HACampaign_Joined c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID
 INNER JOIN #Temp_View_HFit_HealthAssessment_Joined HA WITH (NOLOCK) ON c.HealthAssessmentID = HA.DocumentID
 INNER JOIN dbo.#Temp_View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ ON HA.NodeID = VHFHAMJ.NodeParentID
 INNER JOIN dbo.#Temp_View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
 INNER JOIN dbo.#Temp_View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
 INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentQuestions AS VHFHAQ ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
 LEFT OUTER JOIN dbo.#Temp_View_EDW_HealthAssesmentAnswers AS VHFHAA ON VHFHAQ.NodeID = VHFHAA.NodeParentID

		--matrix level 1 questiongroup
		--INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
		--INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID

		--Branching Level 1 Question 
		INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentQuestions AS VHFHAQ3 ON VHFHAA.NodeID = VHFHAQ3.NodeParentID
		LEFT OUTER JOIN dbo.#Temp_View_EDW_HealthAssesmentAnswers AS VHFHAA3 ON VHFHAQ3.NodeID = VHFHAA3.NodeParentID

		--Matrix Level 2 Question Group
		--INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentQuestions AS VHFHAQ7 ON VHFHAQ3.NodeID = VHFHAQ7.NodeParentID
		--INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentAnswers AS VHFHAA7 ON VHFHAQ7.NodeID = VHFHAA7.NodeParentID

		--Matrix branching level 1 question group
		--INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentQuestions AS VHFHAQ8 ON VHFHAA7.NodeID = VHFHAQ8.NodeParentID
		--INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentAnswers AS VHFHAA8 ON VHFHAQ8.NodeID = VHFHAA8.NodeParentID

		--Branching level 2 Question Group
		INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentQuestions AS VHFHAQ4 ON VHFHAA3.NodeID = VHFHAQ4.NodeParentID
		INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentAnswers AS VHFHAA4 ON VHFHAQ4.NodeID = VHFHAA4.NodeParentID

		--Branching level 3 Question Group
		INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentQuestions AS VHFHAQ5 ON VHFHAA4.NodeID = VHFHAQ5.NodeParentID
		INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentAnswers AS VHFHAA5 ON VHFHAQ5.NodeID = VHFHAA5.NodeParentID
where VCTJ.DocumentCulture = 'en-us'	--WDM 08.07.2014
		and VHFHAQ.DocumentCulture = 'en-us'	--WDM 08.12.2014	
		and (VHFHAA.DocumentCulture = 'en-us'  OR VHFHAA.DocumentCulture is null)	--WDM 08.12.2014		
		and VHFHARCJ.DocumentCulture = 'en-us'	--WDM 08.12.2014		
		and VHFHARAJ.DocumentCulture = 'en-us'	--WDM 08.12.2014		
		and VHFHAMJ.DocumentCulture = 'en-us'	--WDM 08.12.2014		
AND (VCTJ.DocumentCreatedWhen between @StartDate and @EndDate OR VCTJ.DocumentModifiedWhen between @StartDate and @EndDate)

UNION ALL
--WDM 6/25/2014 Retrieve the Branching level 4 Question Group
	SELECT Distinct
		NULL as SiteGuid --cs.SiteGUID
		, NULL as AccountCD     --, HFA.AccountCD
		, HA.NodeID		--WDM 08.07.2014
		, HA.NodeName		--WDM 08.07.2014
		, HA.DocumentID		--WDM 08.07.2014
		, HA.NodeSiteID		--WDM 08.07.2014
       --,VCTJ.NodeAliasPath
		, HA.DocumentPublishedVersionHistoryID		--WDM 08.07.2014
		, VHFHAMJ.Title
		--, dbo.udf_StripHTML(left(VHFHAMJ.IntroText,4000)) AS IntroText
		, VHFHAMJ.IntroText
		, VHFHAMJ.DocumentGUID
		, VHFHAMJ.Weight
		, VHFHAMJ.IsEnabled
		, VHFHAMJ.CodeName
       --,VHFHAMJ.NodeAliasPath
		, VHFHAMJ.DocumentPublishedVersionHistoryID
		, VHFHARCJ.Title
		, VHFHARCJ.Weight
		, VHFHARCJ.DocumentGUID
		, VHFHARCJ.IsEnabled
		, VHFHARCJ.CodeName
       --,VHFHARCJ.NodeAliasPath
		, VHFHARCJ.DocumentPublishedVersionHistoryID
		, VHFHARAJ.Title
		, VHFHARAJ.Weight
		, VHFHARAJ.DocumentGUID
		, VHFHARAJ.IsEnabled
		, VHFHARAJ.CodeName
       --,VHFHARAJ.NodeAliasPath
		, VHFHARAJ.ScoringStrategyID
		, VHFHARAJ.DocumentPublishedVersionHistoryID
		, VHFHAQ6.QuestionType
		--, dbo.udf_StripHTML(left(VHFHAQ6.Title,4000)) AS QuesTitle
		, VHFHAQ6.Title AS QuesTitle
		, VHFHAQ6.Weight
		, VHFHAQ6.IsRequired
		, VHFHAQ6.DocumentGUID
		, VHFHAQ6.IsEnabled
		, left(VHFHAQ6.IsVisible,4000)
		, VHFHAQ6.IsStaging
		, VHFHAQ6.CodeName AS QuestionCodeName
       --,VHFHAQ6.NodeAliasPath
		, VHFHAQ6.DocumentPublishedVersionHistoryID
		, VHFHAA6.Value
		, VHFHAA6.Points
		, VHFHAA6.DocumentGUID
		, VHFHAA6.IsEnabled
		, VHFHAA6.CodeName
		, VHFHAA6.UOM
       --,VHFHAA6.NodeAliasPath
		, VHFHAA6.DocumentPublishedVersionHistoryID
		, CASE	WHEN CAST(VCTJ.DocumentCreatedWhen AS DATE) = CAST(vctj.DocumentModifiedWhen AS DATE)
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		, VCTJ.DocumentCreatedWhen
		, VCTJ.DocumentModifiedWhen
		, VCTJ.NodeGuid as CmsTreeNodeGuid	--WDM 08.07.2014
		, HA.NodeGUID as HANodeGUID
 FROM
	  dbo.#Temp_View_CMS_Tree_Joined AS VCTJ

	 INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
	 INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID
	 INNER JOIN dbo.#Temp_View_HFit_HACampaign_Joined c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID
	 INNER JOIN #Temp_View_HFit_HealthAssessment_Joined HA WITH (NOLOCK) ON c.HealthAssessmentID = HA.DocumentID
	 INNER JOIN dbo.#Temp_View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ ON HA.NodeID = VHFHAMJ.NodeParentID
	 INNER JOIN dbo.#Temp_View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
	 INNER JOIN dbo.#Temp_View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
	 INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentQuestions AS VHFHAQ ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
	 LEFT OUTER JOIN dbo.#Temp_View_EDW_HealthAssesmentAnswers AS VHFHAA ON VHFHAQ.NodeID = VHFHAA.NodeParentID

		--matrix level 1 questiongroup
		--INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
		--INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID

		--Branching Level 1 Question 
		INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentQuestions AS VHFHAQ3 ON VHFHAA.NodeID = VHFHAQ3.NodeParentID
		LEFT OUTER JOIN dbo.#Temp_View_EDW_HealthAssesmentAnswers AS VHFHAA3 ON VHFHAQ3.NodeID = VHFHAA3.NodeParentID

		--Matrix Level 2 Question Group
		--INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentQuestions AS VHFHAQ7 ON VHFHAQ3.NodeID = VHFHAQ7.NodeParentID
		--INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentAnswers AS VHFHAA7 ON VHFHAQ7.NodeID = VHFHAA7.NodeParentID

		--Matrix branching level 1 question group
		--INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentQuestions AS VHFHAQ8 ON VHFHAA7.NodeID = VHFHAQ8.NodeParentID
		--INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentAnswers AS VHFHAA8 ON VHFHAQ8.NodeID = VHFHAA8.NodeParentID

		--Branching level 2 Question Group
		INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentQuestions AS VHFHAQ4 ON VHFHAA3.NodeID = VHFHAQ4.NodeParentID
		INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentAnswers AS VHFHAA4 ON VHFHAQ4.NodeID = VHFHAA4.NodeParentID

		--Branching level 3 Question Group
		--select count(*) from dbo.#Temp_View_EDW_HealthAssesmentAnswers AS VHFHAA4
		INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentQuestions AS VHFHAQ5 ON VHFHAA4.NodeID = VHFHAQ5.NodeParentID
		INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentAnswers AS VHFHAA5 ON VHFHAQ5.NodeID = VHFHAA5.NodeParentID

		--Branching level 4 Question Group
		INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentQuestions AS VHFHAQ6 ON VHFHAA5.NodeID = VHFHAQ6.NodeParentID
		INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentAnswers AS VHFHAA6 ON VHFHAQ6.NodeID = VHFHAA6.NodeParentID
where VCTJ.DocumentCulture = 'en-us'	--WDM 08.07.2014
		and VHFHAQ.DocumentCulture = 'en-us'	--WDM 08.12.2014	
		and (VHFHAA.DocumentCulture = 'en-us'  OR VHFHAA.DocumentCulture is null)	--WDM 08.12.2014		
		and VHFHARCJ.DocumentCulture = 'en-us'	--WDM 08.12.2014		
		and VHFHARAJ.DocumentCulture = 'en-us'	--WDM 08.12.2014		
		and VHFHAMJ.DocumentCulture = 'en-us'	--WDM 08.12.2014		
AND (VCTJ.DocumentCreatedWhen between @StartDate and @EndDate OR VCTJ.DocumentModifiedWhen between @StartDate and @EndDate)

UNION ALL
	--WDM 6/25/2014 Retrieve the Branching level 5 Question Group
	SELECT Distinct
		NULL as SiteGuid --cs.SiteGUID
		, NULL as AccountCD     --, HFA.AccountCD
		, HA.NodeID		--WDM 08.07.2014
		, HA.NodeName		--WDM 08.07.2014
		, HA.DocumentID		--WDM 08.07.2014
		, HA.NodeSiteID		--WDM 08.07.2014
       --,VCTJ.NodeAliasPath
		, HA.DocumentPublishedVersionHistoryID		--WDM 08.07.2014
		, VHFHAMJ.Title
		--, dbo.udf_StripHTML(left(VHFHAMJ.IntroText,4000)) AS IntroText
		, VHFHAMJ.IntroText
		, VHFHAMJ.DocumentGUID
		, VHFHAMJ.Weight
		, VHFHAMJ.IsEnabled
		, VHFHAMJ.CodeName
       --,VHFHAMJ.NodeAliasPath
		, VHFHAMJ.DocumentPublishedVersionHistoryID
		, VHFHARCJ.Title
		, VHFHARCJ.Weight
		, VHFHARCJ.DocumentGUID
		, VHFHARCJ.IsEnabled
		, VHFHARCJ.CodeName
       --,VHFHARCJ.NodeAliasPath
		, VHFHARCJ.DocumentPublishedVersionHistoryID
		, VHFHARAJ.Title
		, VHFHARAJ.Weight
		, VHFHARAJ.DocumentGUID
		, VHFHARAJ.IsEnabled
		, VHFHARAJ.CodeName
       --,VHFHARAJ.NodeAliasPath
		, VHFHARAJ.ScoringStrategyID
		, VHFHARAJ.DocumentPublishedVersionHistoryID
		, VHFHAQ9.QuestionType
		--, dbo.udf_StripHTML(left(VHFHAQ9.Title,4000)) AS QuesTitle
		, VHFHAQ9.Title AS QuesTitle
		, VHFHAQ9.Weight
		, VHFHAQ9.IsRequired
		, VHFHAQ9.DocumentGUID
		, VHFHAQ9.IsEnabled
		, left(VHFHAQ9.IsVisible,4000)
		, VHFHAQ9.IsStaging
		, VHFHAQ9.CodeName AS QuestionCodeName
       --,VHFHAQ9.NodeAliasPath
		, VHFHAQ9.DocumentPublishedVersionHistoryID
		, VHFHAA9.Value
		, VHFHAA9.Points
		, VHFHAA9.DocumentGUID
		, VHFHAA9.IsEnabled
		, VHFHAA9.CodeName
		, VHFHAA9.UOM
       --,VHFHAA9.NodeAliasPath
		, VHFHAA9.DocumentPublishedVersionHistoryID
		, CASE	WHEN CAST(VCTJ.DocumentCreatedWhen AS DATE) = CAST(vctj.DocumentModifiedWhen AS DATE)
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		, VCTJ.DocumentCreatedWhen
		, VCTJ.DocumentModifiedWhen
		, VCTJ.NodeGuid as CmsTreeNodeGuid	--WDM 08.07.2014
		, HA.NodeGUID as HANodeGUID
 FROM
  dbo.#Temp_View_CMS_Tree_Joined AS VCTJ

 INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
 INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID
 INNER JOIN dbo.#Temp_View_HFit_HACampaign_Joined c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID
 INNER JOIN #Temp_View_HFit_HealthAssessment_Joined HA WITH (NOLOCK) ON c.HealthAssessmentID = HA.DocumentID
 INNER JOIN dbo.#Temp_View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ ON HA.NodeID = VHFHAMJ.NodeParentID
 INNER JOIN dbo.#Temp_View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
 INNER JOIN dbo.#Temp_View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
 INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentQuestions AS VHFHAQ ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
 LEFT OUTER JOIN dbo.#Temp_View_EDW_HealthAssesmentAnswers AS VHFHAA ON VHFHAQ.NodeID = VHFHAA.NodeParentID

		--matrix level 1 questiongroup
		--INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
		--INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID

		--Branching Level 1 Question 
		INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentQuestions AS VHFHAQ3 ON VHFHAA.NodeID = VHFHAQ3.NodeParentID
		LEFT OUTER JOIN dbo.#Temp_View_EDW_HealthAssesmentAnswers AS VHFHAA3 ON VHFHAQ3.NodeID = VHFHAA3.NodeParentID

		--Matrix Level 2 Question Group
		--INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentQuestions AS VHFHAQ7 ON VHFHAQ3.NodeID = VHFHAQ7.NodeParentID
		--INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentAnswers AS VHFHAA7 ON VHFHAQ7.NodeID = VHFHAA7.NodeParentID

		--Matrix branching level 1 question group
		--INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentQuestions AS VHFHAQ8 ON VHFHAA7.NodeID = VHFHAQ8.NodeParentID
		--INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentAnswers AS VHFHAA8 ON VHFHAQ8.NodeID = VHFHAA8.NodeParentID

		--Branching level 2 Question Group
		INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentQuestions AS VHFHAQ4 ON VHFHAA3.NodeID = VHFHAQ4.NodeParentID
		INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentAnswers AS VHFHAA4 ON VHFHAQ4.NodeID = VHFHAA4.NodeParentID

		--Branching level 3 Question Group
		--select count(*) from dbo.#Temp_View_EDW_HealthAssesmentAnswers AS VHFHAA4
		INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentQuestions AS VHFHAQ5 ON VHFHAA4.NodeID = VHFHAQ5.NodeParentID
		INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentAnswers AS VHFHAA5 ON VHFHAQ5.NodeID = VHFHAA5.NodeParentID

		--Branching level 4 Question Group
		INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentQuestions AS VHFHAQ6 ON VHFHAA5.NodeID = VHFHAQ6.NodeParentID
		INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentAnswers AS VHFHAA6 ON VHFHAQ6.NodeID = VHFHAA6.NodeParentID

		--Branching level 5 Question Group
		INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentQuestions AS VHFHAQ9 ON VHFHAA6.NodeID = VHFHAQ9.NodeParentID
		INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentAnswers AS VHFHAA9 ON VHFHAQ9.NodeID = VHFHAA9.NodeParentID
where VCTJ.DocumentCulture = 'en-us'	--WDM 08.07.2014
		and VHFHAQ.DocumentCulture = 'en-us'	--WDM 08.12.2014	
		and (VHFHAA.DocumentCulture = 'en-us'  OR VHFHAA.DocumentCulture is null)	--WDM 08.12.2014		
		and VHFHARCJ.DocumentCulture = 'en-us'	--WDM 08.12.2014		
		and VHFHARAJ.DocumentCulture = 'en-us'	--WDM 08.12.2014		
		and VHFHAMJ.DocumentCulture = 'en-us'	--WDM 08.12.2014		
AND (VCTJ.DocumentCreatedWhen between @StartDate and @EndDate OR VCTJ.DocumentModifiedWhen between @StartDate and @EndDate)

		--GO 
	
		drop index [View_CMS_Tree_Joined_Linked].PI04_View_CMS_Tree_Joined_Linked
		--GO

		drop index HFit_Account.PI01_HFit_Account
		--GO

		drop index [View_CMS_Tree_Joined_Linked].[CI01_View_CMS_Tree_Joined_Linked]

declare @cnt as int = (select count(*) from EDW_HealthAssessmentDefinition) ;
print('Processed Recs: ' + cast(@cnt as nvarchar(50)));
if @TrackPerf is not null 
BEGIN
	set @P1End = getdate() ;
	exec proc_EDW_MeasurePerf 'ElapsedTime','HADef-P1',0, @P1Start, @P1End;
END
ELSE
	print('No Perf details requested');


END	
  --  
  --  
GO 
print('***** FROM: Proc_EDW_HealthAssessmentDefinition.sql'); 
GO 

print ('Processing: proc_EDW_MeasurePerf') ;
go


if exists (select * from sysobjects where name = 'proc_EDW_MeasurePerf' and Xtype = 'P')
BEGIN
	drop procedure proc_EDW_MeasurePerf ;
END 
go


Create procedure [dbo].[proc_EDW_MeasurePerf] (@TypeTest as nvarchar(50),@ObjectName as nvarchar(50),@RecCount as int, @StartTime as datetime,@EndTime as datetime)
as
Begin

	declare @T int ;
	declare @eSecs int ;
	declare @hrs int ;
	declare @mins int ;
	declare @secs int ;
	declare @ms int ;

	if (@EndTime is null)
	BEGIN
		set @EndTime = getdate() ;
	END
	
	print ('@EndTime: ' + cast(@EndTime as nvarchar(20)));

	set @ms = datediff(ms, @StartTime,@EndTime) ;
	set @secs = datediff(ss, @StartTime,@EndTime) ;
	set @mins = datediff(mi, @StartTime,@EndTime) ;
	set @hrs = datediff(hh, @StartTime,@EndTime) ;

	--set @hrs = @T / 1000000 % 100 ;
	--set @mins = @T / 10000 % 100 ;
	--set @secs = @T / 100 % 100 ;
	--set @ms = @T % 1000 % 10 ;

	--set @EndTime = (select dateadd(hour, (@T / 1000000) % 100,
	--	   dateadd(minute, (@T / 10000) % 100,
	--	   dateadd(second, (@T / 100) % 100,
	--	   dateadd(millisecond, (@T % 100) * 10, cast('00:00:00' as time(2))))))  );
		INSERT INTO [dbo].[EDW_PerformanceMeasure]
           ([TypeTest],[ObjectName],[RecCount],[StartTime],[EndTime],hrs,mins,secs,ms)
     VALUES
           (@TypeTest,@ObjectName,@RecCount,@StartTime,@EndTime,@hrs,@mins,@secs,@ms)
End

GO
  --  
  --  
GO 
print('***** FROM: proc_EDW_MeasurePerf.sql'); 
GO 


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

		,HI.ItemCreatedWhen
		,HI.ItemModifiedWhen
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
		,CHA.DocumentCreatedWhen
		,CHA.DocumentModifiedWhen
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

print('END: ' + cast(getdate() as nvarchar(50)));
print('@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-');
print'***************************************************************' ;
print('START: ' + cast(getdate() as nvarchar(50)));
print('END: ' + cast(getdate() as nvarchar(50)));
print('@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-');
print'***************************************************************' ;
print('START: ' + cast(getdate() as nvarchar(50)));print ('Creating: Proc_EDW_RewardUserDetail' ) ;
go

if exists(select name from sys.objects where type ='P' and name = 'Proc_EDW_RewardUserDetail')
Begin 
	drop procedure Proc_EDW_RewardUserDetail
End

go

Create  proc [dbo].[Proc_EDW_RewardUserDetail] (@StartDate as datetime, @EndDate as datetime, @TrackPerf as nvarchar(1))
as
BEGIN


--********************************************************************************************************************
--select * from [view_EDW_RewardUserDetail] where ItemModifiedWhen between '2000-11-14' and '2014-11-15'
--select * from [view_EDW_RewardUserDetail] where ItemModifiedWhen between '2014-05-12' and '2014-05-13' 
--8/7/2014 - added and commented out DocumentGuid and NodeGuid in case needed later
--8/08/2014 - Generated corrected view in DEV (WDM)
--8/12/2014 - Performance Issue - 00:06:49 @ 258502
--8/12/2014 - Performance Issue - Add PI01_view_EDW_RewardUserDetail
--8/12/2014 - Performance Issue - 00:03:46 @ 258502
--8/12/2014 - Performance Issue - Add PI02_view_EDW_RewardUserDetail
--8/12/2014 - Performance Issue - 00:03:45 @ 258502
--********************************************************************************************************************

--********************************************************************************************************************
--EXECUTION:
--	@StartDate: The date from which to begin selection of data
--	@EndDate  : The date from which to stop selection of data
--	@TrackPerf: Anything other than a NULL char to track performance.
--	exec Proc_EDW_RewardUserDetail NULL, NULL, 'Y'
--	exec Proc_EDW_RewardUserDetail '2010-11-14', '2014-11-15', 'Y'
--	exec Proc_EDW_RewardUserDetail '2010-06-10', '2014-06-11', NULL
--********************************************************************************************************************

	declare @P0Start as datetime ;
	declare @P0End as datetime ;

	set @P0Start = getdate() ;
	
	IF @StartDate is null 
	BEGIN
		set @StartDate  =DATEADD(Day, 0, DATEDIFF(Day, 0, GetDate()));	--Midnight yesterday;	
		set @StartDate = @StartDate  -1 ;
	END
	
	IF @EndDate is null 
	BEGIN
		set @EndDate = cast (getdate() as date);
	END

	--*************************************************************************
if exists (select name from sys.tables where name = 'EDW_RewardUserDetail')
BEGIN
	drop table EDW_RewardUserDetail ;
END

IF not EXISTS
		(
			SELECT name
			FROM SYS.INDEXES
			WHERE NAME = 'pi_CMS_UserSettings_IDMPI'
		)
	BEGIN
		CREATE nonCLUSTERED  INDEX pi_CMS_UserSettings_IDMPI
		ON CMS_UserSettings
		(		[UserSettingsID] ASC 
				, [HFitUserMpiNumber]
		)
	END


	IF not EXISTS
		(
			SELECT name
			FROM SYS.INDEXES
			WHERE NAME = 'pi_CMS_UserSettings_IDMPI'
		)
	BEGIN
		CREATE nonCLUSTERED  INDEX pi_CMS_UserSettings_IDMPI
		ON CMS_UserSettings
		(		[UserSettingsID] ASC 
				, [HFitUserMpiNumber]
		)
	END
	--GO	

IF not EXISTS
		(
			SELECT name
			FROM SYS.INDEXES
			WHERE NAME = 'PI_CMS_UserSite_SiteID'
		)
	BEGIN
	CREATE NONCLUSTERED INDEX PI_CMS_UserSite_SiteID
		ON [dbo].[CMS_UserSite] ([SiteID])
		INCLUDE ([UserID])
	END

	IF EXISTS
		(
			SELECT name
			FROM tempdb.dbo.sysobjects			
			WHERE ID = OBJECT_ID(N'tempdb..#Temp_View_HFit_RewardProgram_Joined')
		)
	BEGIN
		drop table #Temp_View_HFit_RewardProgram_Joined;
	END
	--GO			
	select NodeID, RewardProgramName, RewardProgramID, 
		RewardProgramPeriodStart, RewardProgramPeriodEnd, DocumentModifiedWhen,
		NodeGUID, DocumentGUID
	into #Temp_View_HFit_RewardProgram_Joined 
	from View_HFit_RewardProgram_Joined 
	where View_HFit_RewardProgram_Joined.DocumentCulture = 'en-us' ;
	
	create clustered index PI_Temp_View_HFit_RewardProgram_Joined on #Temp_View_HFit_RewardProgram_Joined 
	(
		NodeID
	)
	--*************************************************************************
	
	IF EXISTS
		(
			SELECT name
			FROM tempdb.dbo.sysobjects			
			WHERE ID = OBJECT_ID(N'tempdb..#TEMP_View_HFit_RewardGroup_Joined')
		)
	BEGIN
		drop table #TEMP_View_HFit_RewardGroup_Joined;
	END
	--GO			
		select NodeID, NodeParentID, GroupName, RewardGroupID, RewardGroupPeriodStart ,RewardGroupPeriodEnd ,DocumentModifiedWhen 
	into #TEMP_View_HFit_RewardGroup_Joined
	from View_HFit_RewardGroup_Joined
	where View_HFit_RewardGroup_Joined.DocumentCulture = 'en-us' ;
	
	create clustered index PI_TEMP_View_HFit_RewardGroup_Joined
	 on #TEMP_View_HFit_RewardGroup_Joined
	(
		NodeID, NodeParentID, GroupName, RewardGroupID, RewardGroupPeriodStart ,RewardGroupPeriodEnd ,DocumentModifiedWhen 
	)
	--*************************************************************************
	--*************************************************************************
	
	IF EXISTS
		(
			SELECT name
			FROM tempdb.dbo.sysobjects			
			WHERE ID = OBJECT_ID(N'tempdb..#TEMP_View_HFit_RewardLevel_Joined')
		)
	BEGIN
		drop table #TEMP_View_HFit_RewardLevel_Joined;
	END
	--GO			
		select NodeID, NodeParentID, AwardType, LevelType, Level, DocumentModifiedWhen, RewardLevelPeriodStart, RewardLevelPeriodEnd
	into #TEMP_View_HFit_RewardLevel_Joined
	from View_HFit_RewardLevel_Joined
	where View_HFit_RewardLevel_Joined.DocumentCulture = 'en-us' ;
	
	create clustered index PI_TEMP_View_HFit_RewardLevel_Joined
	 on #TEMP_View_HFit_RewardLevel_Joined
	(
		NodeID, NodeParentID, AwardType, LevelType, Level, DocumentModifiedWhen, RewardLevelPeriodStart, RewardLevelPeriodEnd
	)
	--*************************************************************************
	--*************************************************************************
	
	IF EXISTS
		(
			SELECT name
			FROM tempdb.dbo.sysobjects			
			WHERE ID = OBJECT_ID(N'tempdb..#TEMP_View_HFit_RewardActivity_Joined')
		)
	BEGIN
		drop table #TEMP_View_HFit_RewardActivity_Joined;
	END
	--GO			
		select NodeID, NodeParentID, RewardActivityID, ActivityName, RewardActivityPeriodStart, RewardActivityPeriodEnd, ActivityPoints
	into #TEMP_View_HFit_RewardActivity_Joined
	from View_HFit_RewardActivity_Joined
	where View_HFit_RewardActivity_Joined.DocumentCulture = 'en-us' ;
	
	create clustered index PI_TEMP_View_HFit_RewardActivity_Joined
	 on #TEMP_View_HFit_RewardActivity_Joined
	(
		NodeID, NodeParentID, RewardActivityID, ActivityName, RewardActivityPeriodStart, RewardActivityPeriodEnd, ActivityPoints
	)
	--*************************************************************************
	--*************************************************************************	
	IF EXISTS
		(
			SELECT name
			FROM tempdb.dbo.sysobjects			
			WHERE ID = OBJECT_ID(N'tempdb..#TEMP_View_HFit_RewardTrigger_Joined')
		)
	BEGIN
		drop table #TEMP_View_HFit_RewardTrigger_Joined;
	END
	--GO			
		select NodeParentID, RewardTriggerLKPID, TriggerName, RewardTriggerID
	into #TEMP_View_HFit_RewardTrigger_Joined
	from View_HFit_RewardTrigger_Joined
	where View_HFit_RewardTrigger_Joined.DocumentCulture = 'en-us' ;
	
	create clustered index PI_TEMP_View_HFit_RewardTrigger_Joined
	 on #TEMP_View_HFit_RewardTrigger_Joined
	(
		NodeParentID, RewardTriggerLKPID, TriggerName, RewardTriggerID
	)
	--*************************************************************************
	--*************************************************************************	
	IF EXISTS
		(
			SELECT name
			FROM tempdb.dbo.sysobjects			
			WHERE ID = OBJECT_ID(N'tempdb..#TEMP_CMS_UserSettings')
		)
	BEGIN
		drop table #TEMP_CMS_UserSettings;
	END
	--GO			
		select HFitUserMpiNumber, UserSettingsUserID
	into #TEMP_CMS_UserSettings
	from CMS_UserSettings	
	
	create clustered index PI_TEMP_CMS_UserSettings
	 on #TEMP_CMS_UserSettings
	(
		HFitUserMpiNumber, UserSettingsUserID
	)

	CREATE NONCLUSTERED INDEX PI_TEMP_CMS_UserSettings2
		ON [dbo].[#TEMP_CMS_UserSettings] 
		([UserSettingsUserID])
		INCLUDE ([HFitUserMpiNumber])
	
	--*************************************************************************
	--***********************************************************************************************
	-- This is the data extraction QUERY
	--***********************************************************************************************
	SELECT 
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
		, HFRUAD.ActivityCompletedDt
		, HFRUAD.ActivityVersionID
		, HFRUAD.ItemModifiedWhen AS RewardActivityModifiedDate
		, VHFRAJ.RewardActivityPeriodStart
		, VHFRAJ.RewardActivityPeriodEnd
		, VHFRAJ.ActivityPoints
		, HFRE.UserAccepted
		, HFRE.UserExceptionAppliedTo
		--, HFRE.ItemModifiedWhen AS RewardExceptionModifiedDate
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
		, HFRULD.ItemCreatedWhen
		, HFRULD.ItemModifiedWhen
		
		, HFRE.ItemModifiedWhen AS RewardExceptionModifiedDate
		, HFRUAD.ItemModifiedWhen as RewardsUserActivity_ItemModifiedWhen	--09.11.2014 (wdm) added for EDW
		, VHFRTJ.DocumentModifiedWhen as  RewardTrigger_DocumentModifiedWhen
		, VHFRPJ.DocumentGuid		--WDM added 8/7/2014 in case needed
		, VHFRPJ.NodeGuid		--WDM added 8/7/2014 in case needed		
into EDW_RewardUserDetail
	FROM
		#Temp_View_HFit_RewardProgram_Joined AS VHFRPJ WITH ( NOLOCK )
		LEFT OUTER JOIN #TEMP_View_HFit_RewardGroup_Joined AS VHFRGJ WITH ( NOLOCK ) ON VHFRPJ.NodeID = VHFRGJ.NodeParentID
		LEFT OUTER JOIN #TEMP_View_HFit_RewardLevel_Joined AS VHFRLJ WITH ( NOLOCK ) ON VHFRGJ.NodeID = VHFRLJ.NodeParentID
		LEFT OUTER JOIN dbo.HFit_LKP_RewardType AS HFLRT WITH ( NOLOCK ) ON VHFRLJ.AwardType = HFLRT.RewardTypeLKPID
		LEFT OUTER JOIN dbo.HFit_LKP_RewardLevelType AS HFLRLT WITH ( NOLOCK ) ON vhfrlj.LevelType = HFLRLT.RewardLevelTypeLKPID
		INNER JOIN dbo.HFit_RewardsUserLevelDetail AS HFRULD WITH ( NOLOCK ) ON VHFRLJ.NodeID = HFRULD.LevelNodeID
		INNER JOIN dbo.CMS_User AS CU WITH ( NOLOCK ) ON hfruld.UserID = cu.UserID
		INNER JOIN dbo.CMS_UserSite AS CUS WITH ( NOLOCK ) ON CU.UserID = CUS.UserID
		INNER JOIN dbo.CMS_Site AS CS2 WITH ( NOLOCK ) ON CUS.SiteID = CS2.SiteID
		INNER JOIN dbo.HFit_Account AS HFA WITH ( NOLOCK ) ON cs2.SiteID = HFA.SiteID

		INNER JOIN #TEMP_CMS_UserSettings AS CUS2 ON cu.UserID = cus2.UserSettingsUserID		
		LEFT OUTER JOIN #TEMP_View_HFit_RewardActivity_Joined AS VHFRAJ WITH ( NOLOCK ) ON VHFRLJ.NodeID = VHFRAJ.NodeParentID
		
		INNER JOIN dbo.HFit_RewardsUserActivityDetail AS HFRUAD WITH ( NOLOCK ) ON VHFRAJ.NodeID = HFRUAD.ActivityNodeID
		LEFT OUTER JOIN dbo.View_HFit_RewardTrigger_Joined AS VHFRTJ WITH ( NOLOCK ) ON VHFRAJ.NodeID = VHFRTJ.NodeParentID
		LEFT OUTER JOIN dbo.HFit_LKP_RewardTrigger AS HFLRT2 WITH ( NOLOCK ) ON VHFRTJ.RewardTriggerLKPID = HFLRT2.RewardTriggerLKPID
		LEFT OUTER JOIN dbo.HFit_RewardException AS HFRE WITH ( NOLOCK ) ON HFRE.RewardActivityID = VHFRAJ.RewardActivityID
				AND HFRE.UserID = cu.UserID
	
		Where HFRULD.ItemModifiedWhen >= @StartDate AND HFRULD.ItemModifiedWhen <= @EndDate
		--OPTION (TABLE HINT(CUS2 , index (pi_CMS_UserSettings_IDMPI)))

	if @TrackPerf is not null 
	BEGIN
		set @P0End = getdate() ;
		exec proc_EDW_MeasurePerf 'ElapsedTime','HARewardUSer-P0',0, @P0Start, @P0End;
	END

END --End of Proc


GO


  --  
  --  
GO 
print('***** FROM: Proc_EDW_RewardUserDetail.sql'); 
GO 

print('END: ' + cast(getdate() as nvarchar(50)));
print('@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-');
print'***************************************************************' ;
print('START: ' + cast(getdate() as nvarchar(50)));

print ('Processing: Proc_EDW_TrackerMetadataExtract') ;
go

if exists (select * from sysobjects where name = 'Proc_EDW_TrackerMetadataExtract' and Xtype = 'P')
BEGIN
	drop procedure Proc_EDW_TrackerMetadataExtract ;
END 
go

--exec Proc_EDW_TrackerMetadataExtract 'HFit.TrackerWater'
--select * from #Temp_TrackerMetaData
--select * from Tracker_EDW_Metadata
--truncate table Tracker_EDW_Metadata
create procedure [dbo].[Proc_EDW_TrackerMetadataExtract] (@TrackerClassName as nvarchar(250))
as
IF EXISTS
	(
		SELECT name
		FROM tempdb.dbo.sysobjects
		WHERE ID = OBJECT_ID(N'tempdb..#Temp_TrackerMetaData')
	)
	BEGIN
		DROP TABLE #Temp_TrackerMetaData
	END

DECLARE @MetaDataLastLoadDate datetime ;
DECLARE @ClassLastModified datetime ;


DECLARE @Xml XML
DECLARE @docHandle int;
DECLARE @form nvarchar(250);

declare @dbForm nvarchar(250) ;
declare @id int ;
declare @parent int;
declare @nodetype int;
declare @localname nvarchar(250);
declare @prefix nvarchar(250);
declare @namespaceuri nvarchar(250);
declare @datatype nvarchar(250);
declare @prev nvarchar(250);
declare @dbText nvarchar(250);

declare @ParentName nvarchar(250);

--declare @xdbForm nvarchar(250) ;
--declare @xid int ;
--declare @xparent int;
--declare @xnodetype int;
--declare @xlocalname nvarchar(250);
--declare @xprefix nvarchar(250);
--declare @xnamespaceuri nvarchar(250);
--declare @xdatatype nvarchar(250);
--declare @xprev nvarchar(250);
--declare @xdbText nvarchar(250);

declare @TableName nvarchar(100);
declare @ColName nvarchar(100);
declare @AttrName nvarchar(100);
declare @AttrVal nvarchar(250);

declare @CurrName nvarchar(250);
declare @SkipIfNoChange bit;

--select @form = 'HFit.TrackerWater' ;
select @form = @TrackerClassName ;

select @MetaDataLastLoadDate = (Select top 1 ClassLastModified from Tracker_EDW_Metadata where TableName = @form) ;
select @ClassLastModified = (Select top 1 ClassLastModified from CMS_CLASS where ClassName = @form) ;

set @SkipIfNoChange = 1 ;
if @SkipIfNoChange = 1 BEGIN
	if @MetaDataLastLoadDate = @ClassLastModified BEGIN
		Print ('No Change in ' + @form +', no updates needed.');
		RETURN;
	END
	ELSE BEGIN
		Print ('Changes found in ' + @form +', processing.');
	END
END


print ('@MetaDataLastLoadDate: ' + cast(@MetaDataLastLoadDate as varchar(50))) ;
print ('@ClassLastModified: ' + cast(@ClassLastModified as varchar(50))) ;

SELECT @Xml = (select ClassFormDefinition from CMS_Class where ClassName like @form);
--print (cast( @Xml as varchar(max)));

EXEC sp_xml_preparedocument @docHandle OUTPUT, @Xml;
--alter table [Tracker_EDW_Metadata] add ClassLastModified datetime null
IF NOT EXISTS (SELECT name
		FROM sysobjects
		WHERE ID = OBJECT_ID(N'Tracker_EDW_Metadata'))
	begin
		CREATE TABLE [dbo].[Tracker_EDW_Metadata](
			[TableName] [nvarchar](100) NOT NULL,
			[ColName] [nvarchar](100) NOT NULL,
			[AttrName] [nvarchar](100) NOT NULL,
			[AttrVal] [nvarchar](250) NULL,
			[CreatedDate] [datetime] NULL,
			[LastModifiedDate] [datetime] NULL,
			[ID] [int] IDENTITY(1,1) NOT NULL,
			[ClassLastModified] [datetime] NULL
		)

		ALTER TABLE [dbo].[Tracker_EDW_Metadata] ADD  CONSTRAINT [DF_Tracker_EDW_Metadata_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
		ALTER TABLE [dbo].[Tracker_EDW_Metadata] ADD  CONSTRAINT [DF_Tracker_EDW_Metadata_LastModifiedDate]  DEFAULT (getdate()) FOR [LastModifiedDate]
		
		CREATE UNIQUE CLUSTERED INDEX [PK_Tracker_EDW_Metadata] ON [dbo].[Tracker_EDW_Metadata]
		(
			[TableName] ASC,
			[ColName] ASC,
			[AttrName] ASC
		)
	end

IF NOT EXISTS (SELECT name
		FROM tempdb.dbo.sysobjects
		WHERE ID = OBJECT_ID(N'tempdb..#Temp_TrackerMetaData'))
	begin
	SELECT @form as form,id,parentid,nodetype,localname,prefix,namespaceuri,datatype,prev,[text] 	
	INTO #Temp_TrackerMetaData 
	FROM OPENXML(@docHandle, N'/form/field') as XMLDATA;
	--WHERE localname not in ('isPK');		
	CREATE INDEX TMPPI_HealthAssesmentUserQuestion 
		ON #Temp_TrackerMetaData (parentid);
	CREATE INDEX TMPPI2_HealthAssesmentUserQuestion 
		ON #Temp_TrackerMetaData (id);
	end
	else
	begin
		truncate table #Temp_TrackerMetaData;
		INSERT INTO #Temp_TrackerMetaData
		SELECT @form as form,id,parentid,nodetype,localname,prefix,namespaceuri,datatype,prev,[text]
			FROM OPENXML(@docHandle, N'/form/field') as XMLDATA;	
	end

delete from Tracker_EDW_Metadata where TableName = @form ;

set @ClassLastModified = (Select ClassLastModified from CMS_CLASS where ClassName = @Form);
print ('@ClassLastModified: ' + cast(@ClassLastModified as varchar(250))) ;

declare C cursor FOR 
SELECT @form as form,id,parentid,nodetype,localname,prefix,namespaceuri,datatype,prev,[text] 	
	FROM #Temp_TrackerMetaData as XMLDATA

OPEN C
FETCH NEXT from C 
INTO @dbForm, @id, @parent, @nodetype, @localname, @prefix, @namespaceuri, @datatype, @prev, @dbText ;

WHILE @@FETCH_STATUS = 0   
BEGIN   
	--print ('* @localname :' + @localname) ;
	--print ('* @ColName :' + isnull(@ColName, 'XX') + ':') ;
	--print ('* @dbText :' + @dbText + ':') ;
	
	if @localname = 'column'
	BEGIN
		--print ('** START COLUMN DEF: ') ;
		set @ColName = (select [text] from #Temp_TrackerMetaData where parentid = @id);
		--print ('** COLUMN DEF: ' + @form + ' : ' + @colname) ;
	END

    if @dbText is not null 
	BEGIN	   
	
			--print ('* ENTER @dbText :' + @dbText + ':' + cast(@parent as varchar(10))) ;
			set @AttrName = (select [localname] FROM #Temp_TrackerMetaData where id = @parent) ;
			--set @ParentName = (select [localname] FROM OPENXML(@docHandle, N'/form/field') where id = @parent);	
			--print ('1 - @AttrName: ' + @form +' : ' + isnull(@ColName, 'NA') + ' : ' + @AttrName + ' : ' + @dbText) ;	
			if exists(Select TableName from Tracker_EDW_Metadata Where Tablename = @form and ColName = @ColName and AttrName = @dbText)
			BEGIN				
				--print('Update Tracker_EDW_Metadata set AttrVal = ' + @dbText + ' Where Tablename = ' + @form + ' and ColName = ' + @ColName + ' and AttrName = ' + @AttrName + ';');
				Update Tracker_EDW_Metadata set AttrVal = @dbText, ClassLastModified = @ClassLastModified Where Tablename = @form and ColName = @ColName and AttrName = @dbText;				
			END
			ELSE
			BEGIN
				--print ('insert into Tracker_EDW_Metadata (TableName, ColName, AttrName, AttrVal, ClassLastModified) values ('+@form+', '+@ColName+', '+@AttrName+', '+@dbText +', ' + cast(@ClassLastModified as varchar(50))+ ') ') ;
				insert into Tracker_EDW_Metadata (TableName, ColName, AttrName, AttrVal, ClassLastModified) values (@form, @ColName, @AttrName, @dbText, @ClassLastModified) ;
				Update Tracker_EDW_Metadata set ClassLastModified = @ClassLastModified Where Tablename = @form and ColName = @ColName and AttrName = @dbText;
			END		
	END
	
	   if @localname = 'columntype' and @ColName is not null
	   BEGIN
			print ('---- COLUMN TYPE DEF: ' + @form + ' : ' + @colname + ' : ' + @dbText) ;
	   END
	   if @localname = 'field'
	   BEGIN
			set @ParentName = null ;
			set @ColName = null ;
			--print ('***** field @ParentName: ' + @ParentName) ;
	   END
       FETCH NEXT FROM C INTO @dbForm, @id, @parent, @nodetype, @localname, @prefix, @namespaceuri, @datatype, @prev, @dbText ;   
END   

CLOSE C   
DEALLOCATE C 

--Clean up the EDW Tracker MetaData
--delete from Tracker_EDW_Metadata where colname in ('ItemID','ItemCreatedBy','ItemCreatedWhen','ItemModifiedBy','ItemModifiedWhen','EventDate','IsProfessionally Collected','TrackerCollectionSourceId','UserID','Notes','IsProcessedForHA');


GO


  --  
  --  
GO 
print('***** FROM: Proc_EDW_TrackerMetadataExtract.sql'); 
GO 


print ('Processing: proc_GetRecordCount') ;
go


if exists (select * from sysobjects where name = 'proc_GetRecordCount' and Xtype = 'P')
BEGIN
	drop procedure proc_GetRecordCount ;
END 
go

create procedure proc_GetRecordCount (@TblView as nvarchar(80))
		as
		BEGIN

			--declare @TblView nvarchar(80); 
			--set @TblView = 'view_EDW_TrackerMetadata';
			DECLARE @rowcount TABLE (Value int);
			declare @ActualNumberOfResults int ;
			declare @StartTime datetime ;
			declare @EndTime datetime ;
			declare @iCnt int;
			declare @qry varchar(56)
			declare @T int ;

			declare @hrs int ;
			declare @mins int ;
			declare @secs int ;
			declare @ms int ;

			set @StartTime = getdate() ;
			set @qry = 'select COUNT(*) as RecCount from  ' + @TblView ;

			INSERT INTO @rowcount
				exec (@qry)

			SELECT @ActualNumberOfResults = Value FROM @rowcount;

			set @EndTime = getdate() ;
			set @T = datediff(ms, @StartTime,@EndTime) ;

			set @hrs = @T / 56000 % 100 ;
			set @mins = @T / 560 % 100 ;
			set @secs = @T / 100 % 100 ;
			set @ms = @T % 100 * 10 ;

			set @EndTime = (select dateadd(hour, (@T / 56000) % 100,
				   dateadd(minute, (@T / 560) % 100,
				   dateadd(second, (@T / 100) % 100,
				   dateadd(millisecond, (@T % 100) * 10, cast('00:00:00' as time(2))))))  );

				   print (@ActualNumberOfResults);
			print (@EndTime);
			print (@TblView + ' row cnt = ' + cast(@iCnt as varchar(20)));
	
			INSERT INTO [dbo].[EDW_PerformanceMeasure]
				   ([TypeTest],[ObjectName],[RecCount],[StartTime],[EndTime],hrs,mins,secs,ms)
			 VALUES
				   ('RowCount',@TblView,@ActualNumberOfResults,@StartTime,@T,@hrs,@mins,@secs,@ms)

		END

GO
--END OF proc_GetRecordCount

   --  
  --  
GO 
print('***** FROM: proc_GetRecordCount.sql'); 
GO 

print('END: ' + cast(getdate() as nvarchar(50)));
print('@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-');
print'***************************************************************' ;
print('START: ' + cast(getdate() as nvarchar(50)));
GO
PRINT 'Processing: view_EDW_RewardUserDetail ';
GO

--IF NOT EXISTS (SELECT
--					  name
--				 FROM sys.indexes
--				 WHERE name = 'CI_HFit_RewardsUserActivityDetail_Activity') 
--	BEGIN
--		CREATE NONCLUSTERED INDEX CI_HFit_RewardsUserActivityDetail_Activity ON dbo.HFit_RewardsUserActivityDetail (ActivityNodeID) INCLUDE (
--			   UserID
--			 , ActivityVersionID
--			 , ActivityPointsEarned
--			 , ActivityCompletedDt
--			 , ItemModifiedWhen) ;
--	END;
--GO

IF EXISTS (SELECT
				  NAME
			 FROM sys.VIEWS
			 WHERE NAME = 'view_EDW_RewardUserDetail') 
	BEGIN
		DROP VIEW
			 view_EDW_RewardUserDetail;
	END;
GO

/*************************************************
 TESTS
select top 1000 * from [view_EDW_RewardUserDetail]
select * from [view_EDW_RewardUserDetail]
Where VHFRPJ_DocumentCulture <> 'en-us'
			AND VHFRGJ_DocumentCulture <> 'en-us'
			AND VHFRLJ_DocumentCulture <> 'en-us'
			AND VHFRAJ_DocumentCulture <> 'en-us'
			AND VHFRTJ_DocumentCulture <> 'en-us'
select top 1000 * from [view_EDW_RewardUserDetail]
select count(*) from [view_EDW_RewardUserDetail]
*************************************************/

CREATE VIEW dbo.view_EDW_RewardUserDetail
AS

	 --**************************************************************************************************************************************************
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
	 --				made no difference in the number of returned rows, so it was removed and the execution time of the query was cut in half.
	 --01.01.2015 (WDM) added left outer join HFit_LKP_RewardActivity AND VHFRAJ.RewardActivityLKPName to the view - reference CR-47520
	 --01.01.2015 (WDM) Tested modifications - reference CR-47520
	 --02.17.2015 (WDM) and (SR) - modified the indexes and moved the where into a join to force the execution plan to modifiy itself. The 
	 --				view would not run in several hours since the deployment of this past Friday. Now, runs in a few minutes (less than 2).
	 --**************************************************************************************************************************************************

	 SELECT
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
		  , HFRUAD.ActivityCompletedDt
		  , HFRUAD.ItemModifiedWhen AS RewardActivityModifiedDate
		  , HFRUAD.ActivityVersionID
		  , VHFRAJ.RewardActivityPeriodStart
		  , VHFRAJ.RewardActivityPeriodEnd
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
		  , CASE
			WHEN CAST (HFRULD.ItemCreatedWhen AS date) = CAST (HFRULD.ItemModifiedWhen AS date) 
			THEN 'I'
			ELSE 'U'
			END AS ChangeType
		  , VHFRPJ.DocumentGuid
		  , VHFRPJ.NodeGuid
		  , HFRULD.ItemCreatedWhen
		  , HFRULD.ItemModifiedWhen
		  , HFRE.ItemModifiedWhen AS RewardExceptionModifiedDate
		  , HFRUAD.ItemModifiedWhen AS RewardsUserActivity_ItemModifiedWhen
		  , VHFRTJ.DocumentModifiedWhen AS RewardTrigger_DocumentModifiedWhen

			--01.01.2015 (WDM) added for CR-47520

		  , LKPRA.RewardActivityLKPName
		  , VHFRPJ.DocumentCulture AS VHFRPJ_DocumentCulture
		  , VHFRGJ.DocumentCulture AS VHFRGJ_DocumentCulture
		  , VHFRLJ.DocumentCulture AS VHFRLJ_DocumentCulture
		  , VHFRAJ.DocumentCulture AS VHFRAJ_DocumentCulture
		  , VHFRTJ.DocumentCulture AS VHFRTJ_DocumentCulture
	   FROM dbo.View_HFit_RewardProgram_Joined AS VHFRPJ WITH (NOLOCK) 
				LEFT OUTER JOIN dbo.View_HFit_RewardGroup_Joined AS VHFRGJ WITH (NOLOCK) 
					ON VHFRPJ.NodeID = VHFRGJ.NodeParentID
				LEFT OUTER JOIN dbo.View_HFit_RewardLevel_Joined AS VHFRLJ WITH (NOLOCK) 
					ON VHFRGJ.NodeID = VHFRLJ.NodeParentID
				   AND VHFRLJ.DocumentCulture = 'en-us'
				LEFT OUTER JOIN dbo.HFit_LKP_RewardType AS HFLRT WITH (NOLOCK) 
					ON VHFRLJ.AwardType = HFLRT.RewardTypeLKPID
				LEFT OUTER JOIN dbo.HFit_LKP_RewardLevelType AS HFLRLT WITH (NOLOCK) 
					ON vhfrlj.LevelType = HFLRLT.RewardLevelTypeLKPID
				INNER JOIN dbo.HFit_RewardsUserLevelDetail AS HFRULD WITH (NOLOCK) 
					ON VHFRLJ.NodeID = HFRULD.LevelNodeID
				INNER JOIN dbo.CMS_User AS CU WITH (NOLOCK) 
					ON hfruld.UserID = cu.UserID
				INNER JOIN dbo.CMS_UserSite AS CUS WITH (NOLOCK) 
					ON CU.UserID = CUS.UserID
				INNER JOIN dbo.CMS_Site AS CS2 WITH (NOLOCK) 
					ON CUS.SiteID = CS2.SiteID
				INNER JOIN dbo.HFit_Account AS HFA WITH (NOLOCK) 
					ON cs2.SiteID = HFA.SiteID
				INNER JOIN dbo.CMS_UserSettings AS CUS2 WITH (NOLOCK) 
					ON cu.UserID = cus2.UserSettingsUserID
				LEFT OUTER JOIN dbo.View_HFit_RewardActivity_Joined AS VHFRAJ WITH (NOLOCK) 
					ON VHFRLJ.NodeID = VHFRAJ.NodeParentID
				   AND VHFRAJ.DocumentCulture = 'en-us'
				LEFT OUTER JOIN HFit_LKP_RewardActivity AS LKPRA
					ON LKPRA.RewardActivityLKPID = VHFRAJ.RewardActivityLKPID

	 --11.18.2014 (wdm) added this filter so that only USER Detail was returned.

				INNER JOIN dbo.HFit_RewardsUserActivityDetail AS HFRUAD WITH (NOLOCK) 
					ON VHFRAJ.NodeID = HFRUAD.ActivityNodeID
				   AND cu.UserID = HFRUAD.userid
				LEFT OUTER JOIN dbo.View_HFit_RewardTrigger_Joined AS VHFRTJ WITH (NOLOCK) 
					ON VHFRAJ.NodeID = VHFRTJ.NodeParentID
				   AND VHFRTJ.DocumentCulture = 'en-us'
				LEFT OUTER JOIN dbo.HFit_LKP_RewardTrigger AS HFLRT2 WITH (NOLOCK) 
					ON VHFRTJ.RewardTriggerLKPID = HFLRT2.RewardTriggerLKPID
				LEFT OUTER JOIN dbo.HFit_RewardException AS HFRE WITH (NOLOCK) 
					ON HFRE.RewardActivityID = VHFRAJ.RewardActivityID
				   AND HFRE.UserID = cu.UserID
	   WHERE VHFRPJ.DocumentCulture = 'en-us'
		 AND VHFRGJ.DocumentCulture = 'en-us';

--AND VHFRLJ.DocumentCulture = 'en-us'
--AND VHFRAJ.DocumentCulture = 'en-us'
--AND VHFRTJ.DocumentCulture = 'en-us'

GO
PRINT 'Completed : view_EDW_RewardUserDetail ';
GO
PRINT '***** FROM: view_EDW_RewardUserDetail.sql';
GO 

print('END: ' + cast(getdate() as nvarchar(50)));
print('@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-');
print'***************************************************************' ;
print('START: ' + cast(getdate() as nvarchar(50)));
print('Processing: Performance Indexes');
go

if not exists(select name from sys.indexes where name = 'PI_HFIT_Tracker_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFIT_Tracker_LastUpdate ON [HFIT_Tracker] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerBloodPressure_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerBloodPressure_LastUpdate ON [HFit_TrackerBloodPressure] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerBloodSugarAndGlucose_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerBloodSugarAndGlucose_LastUpdate ON [HFit_TrackerBloodSugarAndGlucose] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerBMI_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerBMI_LastUpdate ON [HFit_TrackerBMI] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerBodyFat_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerBodyFat_LastUpdate ON [HFit_TrackerBodyFat] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerBodyMeasurements_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerBodyMeasurements_LastUpdate ON [HFit_TrackerBodyMeasurements] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerCardio_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerCardio_LastUpdate ON [HFit_TrackerCardio] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerCategory_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerCategory_LastUpdate ON [HFit_TrackerCategory] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerCholesterol_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerCholesterol_LastUpdate ON [HFit_TrackerCholesterol] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerCollectionSource_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerCollectionSource_LastUpdate ON [HFit_TrackerCollectionSource] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerDailySteps_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerDailySteps_LastUpdate ON [HFit_TrackerDailySteps] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerDef_Item_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerDef_Item_LastUpdate ON [HFit_TrackerDef_Item] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerDef_Tracker_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerDef_Tracker_LastUpdate ON [HFit_TrackerDef_Tracker] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerDocument_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerDocument_LastUpdate ON [HFit_TrackerDocument] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerFlexibility_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerFlexibility_LastUpdate ON [HFit_TrackerFlexibility] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerFruits_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerFruits_LastUpdate ON [HFit_TrackerFruits] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerHbA1c_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerHbA1c_LastUpdate ON [HFit_TrackerHbA1c] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerHeight_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerHeight_LastUpdate ON [HFit_TrackerHeight] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerHighFatFoods_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerHighFatFoods_LastUpdate ON [HFit_TrackerHighFatFoods] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerHighSodiumFoods_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerHighSodiumFoods_LastUpdate ON [HFit_TrackerHighSodiumFoods] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerInstance_Item_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerInstance_Item_LastUpdate ON [HFit_TrackerInstance_Item] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerInstance_Tracker_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerInstance_Tracker_LastUpdate ON [HFit_TrackerInstance_Tracker] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerMealPortions_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerMealPortions_LastUpdate ON [HFit_TrackerMealPortions] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerMedicalCarePlan_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerMedicalCarePlan_LastUpdate ON [HFit_TrackerMedicalCarePlan] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerRegularMeals_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerRegularMeals_LastUpdate ON [HFit_TrackerRegularMeals] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerRestingHeartRate_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerRestingHeartRate_LastUpdate ON [HFit_TrackerRestingHeartRate] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerShots_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerShots_LastUpdate ON [HFit_TrackerShots] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerSitLess_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerSitLess_LastUpdate ON [HFit_TrackerSitLess] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerSleepPlan_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerSleepPlan_LastUpdate ON [HFit_TrackerSleepPlan] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerStrength_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerStrength_LastUpdate ON [HFit_TrackerStrength] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerStress_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerStress_LastUpdate ON [HFit_TrackerStress] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerStressManagement_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerStressManagement_LastUpdate ON [HFit_TrackerStressManagement] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerSugaryDrinks_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerSugaryDrinks_LastUpdate ON [HFit_TrackerSugaryDrinks] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerSugaryFoods_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerSugaryFoods_LastUpdate ON [HFit_TrackerSugaryFoods] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerSummary_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerSummary_LastUpdate ON [HFit_TrackerSummary] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerTests_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerTests_LastUpdate ON [HFit_TrackerTests] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerTobaccoFree_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerTobaccoFree_LastUpdate ON [HFit_TrackerTobaccoFree] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerVegetables_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerVegetables_LastUpdate ON [HFit_TrackerVegetables] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerWater_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerWater_LastUpdate ON [HFit_TrackerWater] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerWeight_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerWeight_LastUpdate ON [HFit_TrackerWeight] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go
if not exists(select name from sys.indexes where name = 'PI_HFit_TrackerWholeGrains_LastUpdate')
BEGIN
CREATE NONCLUSTERED INDEX PI_HFit_TrackerWholeGrains_LastUpdate ON [HFit_TrackerWholeGrains] ([ItemCreatedWhen] ASC,[ItemModifiedWhen] ASC)
END
go

if not exists(select name from sys.indexes where name = 'PI_View_CMS_Tree_Joined_Regular_NodeGUID')
BEGIN
	CREATE NONCLUSTERED INDEX PI_View_CMS_Tree_Joined_Regular_NodeGUID
		ON [dbo].[View_CMS_Tree_Joined_Regular] ([NodeGUID])
END
go

if not exists(select name from sys.indexes where name = 'PI_View_CMS_Tree_Joined_Regular_NodeSiteID_DocumentCulture_NodeID')
BEGIN 
	CREATE INDEX PI_View_CMS_Tree_Joined_Regular_NodeSiteID_DocumentCulture_NodeID
    ON View_CMS_Tree_Joined_Regular
 (     [NodeSiteID] ASC 
      , [DocumentCulture] ASC 
      , [NodeID] ASC 
      , [NodeParentID] ASC 
      , [DocumentID] ASC 
      , [DocumentPublishedVersionHistoryID] ASC 
, [NodeGUID]
 )
END


GO

if not exists(select name from sys.indexes where name = 'PI_CMS_Tree_Joined_Regular_NODE_FK')
BEGIN 
	CREATE NONCLUSTERED INDEX PI_CMS_Tree_Joined_Regular_NODE_FK
		ON [dbo].[View_CMS_Tree_Joined_Regular] ([ClassName])
	INCLUDE ([NodeGUID],[DocumentForeignKeyValue])
END

GO


if not exists(select name from sys.indexes where name = 'pi_CMS_Tree_Joined_Regular_NodeGUID')
BEGIN 
	CREATE NONCLUSTERED INDEX pi_CMS_Tree_Joined_Regular_NodeGUID
	ON [dbo].[View_CMS_Tree_Joined_Regular] ([NodeGUID])
end

go  --  
  --  
GO 
print('***** FROM: CreateTrackerPerfIndexes.sql'); 
GO 

GO
PRINT 'Processing view_EDW_BioMetrics: ' + CAST (GETDATE () AS nvarchar (50)) + '  *** view_EDW_BioMetrics.sql (CR11690)';
GO

IF NOT EXISTS (SELECT [name]
			  FROM [sys].[tables]
			  WHERE [name] = 'EDW_BiometricViewRejectCriteria') 
    BEGIN
	   PRINT 'EDW_BiometricViewRejectCriteria NOT found, creating';
	   --This table contains the REJECT specifications for Biometric data. An entry causes all records before a date for a Client or SITE to be ignored.
	   --Use AccountCD and ItemCreatedWhen together OR SiteID and ItemCreatedWhen together. They work and reject in pairs.
	   CREATE TABLE [dbo].[EDW_BiometricViewRejectCriteria]
	   (
	   [AccountCD] nvarchar (8) NOT NULL
	 , [ItemCreatedWhen] datetime NOT NULL
	 , [SiteID] int NOT NULL
	 , [RejectGUID] uniqueidentifier NULL
	   );

	   ALTER TABLE [dbo].[EDW_BiometricViewRejectCriteria]
	   ADD CONSTRAINT
		  [DF_EDW_BiometricViewRejectCriteria_RejectGUID] DEFAULT NEWID () FOR [RejectGUID];

	   ALTER TABLE [dbo].[EDW_BiometricViewRejectCriteria] SET (LOCK_ESCALATION = TABLE) ;

	   EXEC [sp_addextendedproperty]
	   @name = N'PURPOSE' , @value = 'This table contains the REJECT specifications for Biometric data. An entry causes all records before a date for a Client or SITE to be ignored. The data is entered as SiteID and Rejection Date OR AccountCD and Rejection Date. All dates prior to the rejection date wil be ignored.' ,
	   @level0type = N'Schema' , @level0name = 'dbo' ,
	   @level1type = N'Table' , @level1name = 'EDW_BiometricViewRejectCriteria';
	   --@level2type = N'Column', @level2name = NULL

	   EXEC [sp_addextendedproperty]
	   @name = N'MS_Description' , @value = 'Use AccountCD and ItemCreatedWhen together, entering a non-existant value for SiteID. They work and reject in pairs and this type of entry will only take AccountCD and ItemCreatedWhen date into consideration.' ,
	   @level0type = N'Schema' , @level0name = 'dbo' ,
	   @level1type = N'Table' , @level1name = 'EDW_BiometricViewRejectCriteria' ,
	   @level2type = N'Column' , @level2name = 'AccountCD';

	   EXEC [sp_addextendedproperty]
	   @name = N'USAGE' , @value = 'Use SiteID and ItemCreatedWhen together, entering a non-existant value for AccountCD. They work and reject in pairs.' ,
	   @level0type = N'Schema' , @level0name = 'dbo' ,
	   @level1type = N'Table' , @level1name = 'EDW_BiometricViewRejectCriteria' ,
	   @level2type = N'Column' , @level2name = 'SiteID';

	   EXEC [sp_addextendedproperty]
	   @name = N'USAGE' , @value = 'Use AccountCD or SiteID and ItemCreatedWhen together. They work and reject in pairs. Any date before this date will NOT be retrieved.' ,
	   @level0type = N'Schema' , @level0name = 'dbo' ,
	   @level1type = N'Table' , @level1name = 'EDW_BiometricViewRejectCriteria' ,
	   @level2type = N'Column' , @level2name = 'ItemCreatedWhen';
    END;
GO

IF EXISTS (SELECT [name]
		   FROM [sys].[views]
		   WHERE [name] = 'view_EDW_BiometricViewRejectCriteria') 
    BEGIN
	   PRINT 'view_EDW_BiometricViewRejectCriteria found, updating';
	   DROP VIEW [view_EDW_BiometricViewRejectCriteria];
    END;
GO

CREATE VIEW [view_EDW_BiometricViewRejectCriteria]
AS SELECT [AccountCD]
	   , [ItemCreatedWhen]
	   , [SiteID]
	   , [RejectGUID]
	FROM [dbo].[EDW_BiometricViewRejectCriteria];
GO
PRINT 'view_EDW_BiometricViewRejectCriteria, updated';
GO

IF NOT EXISTS (SELECT [name]
			  FROM [sys].[indexes]
			  WHERE [name] = 'PKI_EDW_BiometricViewRejectCriteria') 
    BEGIN
	   PRINT 'PKI_EDW_BiometricViewRejectCriteria NOT found, creating';
	   CREATE UNIQUE CLUSTERED INDEX [PKI_EDW_BiometricViewRejectCriteria] ON [dbo].[EDW_BiometricViewRejectCriteria]
	   (
	   [AccountCD] ASC ,
	   [ItemCreatedWhen] ASC ,
	   [SiteID] ASC
	   );
    END;
ELSE
    BEGIN
	   PRINT 'PKI_EDW_BiometricViewRejectCriteria created';
    END;

GO

IF EXISTS (SELECT [name]
		   FROM [sys].[procedures]
		   WHERE [name] = 'proc_Insert_EDW_BiometricViewRejectCriteria') 
    BEGIN
	   PRINT 'proc_Insert_EDW_BiometricViewRejectCriteria found, updating.';
	   DROP PROCEDURE [proc_Insert_EDW_BiometricViewRejectCriteria];
    END;
ELSE
    BEGIN
	   PRINT 'Creating proc_Insert_EDW_BiometricViewRejectCriteria';
    END;
GO

CREATE PROC [proc_Insert_EDW_BiometricViewRejectCriteria] (
	  @AccountCD AS nvarchar (50) , @ItemCreatedWhen AS datetime , @SiteID AS int) 
AS
BEGIN

    IF @SiteID IS NULL
	   BEGIN
		  SET @SiteID = -1;
	   END;

    DECLARE @iCnt integer = 0;
    SET @iCnt = (SELECT COUNT (*) 
			    FROM [EDW_BiometricViewRejectCriteria]
			    WHERE [AccountCD] = @AccountCD
				 AND [SiteID] = @SiteID) ;
    IF @iCnt <= 0
	   BEGIN
		  INSERT INTO [dbo].[EDW_BiometricViewRejectCriteria]
		  ([AccountCD]
		 , [ItemCreatedWhen]
		 , [SiteID]
		  ) 
		  VALUES
		  (@AccountCD
		  , @ItemCreatedWhen
		  , @SiteID
		  );
		  PRINT 'ADDED ' + @AccountCD + ' to EDW_BiometricViewRejectCriteria.';
	   END;
    ELSE
	   BEGIN
		  PRINT 'Account ' + @AccountCD + ' already defined to EDW_BiometricViewRejectCriteria.';
	   END;
END;

GO

IF EXISTS (SELECT [name]
		   FROM [sys].[procedures]
		   WHERE [name] = 'proc_Delete_EDW_BiometricViewRejectCriteria_Acct') 
    BEGIN
	   PRINT 'proc_Delete_EDW_BiometricViewRejectCriteria_Acct  found, updating.';
	   DROP PROCEDURE [proc_Delete_EDW_BiometricViewRejectCriteria_Acct];
    END;
ELSE
    BEGIN
	   PRINT 'Creating proc_Delete_EDW_BiometricViewRejectCriteria_Acct';
    END;

GO

CREATE PROC [proc_Delete_EDW_BiometricViewRejectCriteria_Acct] (
	  @AccountCD AS nvarchar (50) , @ItemCreatedWhen AS datetime) 
AS
BEGIN
    DELETE FROM [dbo].[EDW_BiometricViewRejectCriteria]
	 WHERE [AccountCD] = @AccountCD
	   AND [ItemCreatedWhen] = @ItemCreatedWhen;
END;

GO
IF EXISTS (SELECT [name]
		   FROM [sys].[procedures]
		   WHERE [name] = 'proc_Delete_EDW_BiometricViewRejectCriteria_Site') 
    BEGIN
	   PRINT 'proc_Delete_EDW_BiometricViewRejectCriteria_Site  found, updating.';
	   DROP PROCEDURE [proc_Delete_EDW_BiometricViewRejectCriteria_Site];
    END;
ELSE
    BEGIN
	   PRINT 'Creating proc_Delete_EDW_BiometricViewRejectCriteria_Site';
    END;

GO

CREATE PROC [proc_Delete_EDW_BiometricViewRejectCriteria_Site] (
	  @SiteID AS int , @ItemCreatedWhen AS datetime) 
AS
BEGIN
    DELETE FROM [dbo].[EDW_BiometricViewRejectCriteria]
	 WHERE [SiteID] = @SiteID
	   AND [ItemCreatedWhen] = @ItemCreatedWhen;

END;
GO

IF EXISTS (SELECT [name]
		   FROM [sys].[views]
		   WHERE [name] = 'view_EDW_BioMetrics') 
    BEGIN
	   PRINT 'Removing current view_EDW_BioMetrics.';
	   DROP VIEW [view_EDW_BioMetrics];
    END;
GO
PRINT 'Creating view_EDW_BioMetrics.';
GO

CREATE VIEW [dbo].[view_EDW_BioMetrics]
AS
--*****************************************************************************************************************************************
--************** TEST Criteria and Results for view_EDW_BioMetrics ************************************************************************
--INSERT INTO [dbo].[EDW_BiometricViewRejectCriteria] ([AccountCD],[ItemCreatedWhen],[SiteID]) VALUES('XX','2013-12-01',17  )  
--NOTE:		XX is used so that the AccountCD is NOT taken into account and only SiteID and ItemCreatedWhen is used.
--GO	--Tested by wdm on 11.21.2014

-- select count(*) from view_EDW_BioMetrics		--(wdm) & (jc) : testing on {ProdStaging = 136348} / With reject on 136339 = 9

--select * from view_EDW_BioMetrics	 where AccountCD = 'peabody' AND COALESCE (EventDate,ItemCreatedWhen) is not NULL and COALESCE (EventDate,ItemCreatedWhen) < '2013-12-01'	: 9 
--select * from view_Hfit_BioMetrics where AccountCD = 'peabody' AND COALESCE (EventDate,ItemCreatedWhen) is not NULL and COALESCE (EventDate,ItemCreatedWhen) < '2013-12-01'	: 9 

--select * from view_EDW_BioMetrics	where AccountCD = 'peabody' and ItemCreatedWhen < '2013-12-01 00:00:00.000'		: 7 
--select * from view_EDW_BioMetrics	where AccountCD = 'peaboOK dy' and EventDate < '2013-12-01 00:00:00.000'		: 9 

--select count(*) from view_EDW_BioMetrics		--NO REJECT FILTER : 136348
--select count(*) from view_EDW_BioMetrics		--REJECT FILTER ON : 136339 == 9 GOOD TEST

--select count(*) from view_Hfit_BioMetrics	:136393
--select count(*) from view_Hfit_BioMetrics where COALESCE (EventDate,ItemCreatedWhen) is not NULL 	:136348

--NOTE: All tests passed 11.21.2014, 11.23.2014, 12.2.2014, 12,4,2014

--truncate table EDW_BiometricViewRejectCriteria

--INSERT INTO [dbo].[EDW_BiometricViewRejectCriteria]([AccountCD],[ItemCreatedWhen],[SiteID])VALUES('peabody','2013-12-01',-1)         
--NOTE:		-1 is used so that the SiteID is NOT taken into account and only AccountCD and ItemCreatedWhen is used.
--GO	--Tested by wdm on 11.21.2014

--select * from view_EDW_BioMetrics where ItemCreatedWhen < '2013-12-01' and AccountCD = 'peabody' returns 1034
--		so the number should be 43814 - 1034 = 42780 with AccountCD = 'peabody' and ItemCreatedWhen = '2014-03-19'
--		in table EDW_BiometricViewRejectCriteria. And it worked (wdm) 11.21.2014
--GO	--Tested by wdm on 11.21.2014

--select * from view_EDW_BioMetrics where SiteID = 17 and ItemCreatedWhen < '2014-03-19' returns 22,974
--		so the number should be 43814 - 22974 = 20840 with SIteID = 17 and ItemCreatedWhen = '2014-03-19'
--		in table EDW_BiometricViewRejectCriteria. And it worked (wdm) 11.21.2014
--GO	--Tested by wdm on 11.21.2014

--	11.24.2014 (wdm) -	requested a review of this code and validation with EDW.

-- 12.22.2014 - Received an SR from John C. via Richard to add two fields to the view, Table name and Item ID.
-- 12.23.2014 - Added the Vendor ID and Vendor name to the view via the HFit_LKP_TrackerVendor table
-- 12.25.2014 - Added the EDW_BiometricViewRejectCriteria to allow selective rejection of historical records
-- 01.19.2014 - Prepared for Simpson Willams

--*****************************************************************************************************************************************
SELECT DISTINCT
--HFit_UserTracker
[HFUT].[UserID]
, [cus].[UserSettingsUserGUID] AS [UserGUID]
, [cus].[HFitUserMpiNumber]
, [cus2].[SiteID]
, [cs].[SiteGUID]
, NULL AS [CreatedDate]
, NULL AS [ModifiedDate]
, NULL AS [Notes]
, NULL AS [IsProfessionallyCollected]
, NULL AS [EventDate]
, 'Not Build Yet' AS [EventName]

--HFit_TrackerWeight
, NULL AS [PPTWeight]

--HFit_TrackerHbA1C
, NULL AS [PPTHbA1C]

--HFit_TrackerCholesterol
, NULL AS [Fasting]
, NULL AS [HDL]
, NULL AS [LDL]
, NULL AS [Ratio]
, NULL AS [Total]
, NULL AS [Triglycerides]

--HFit_TrackerBloodSugarandGlucose
, NULL AS [Glucose]
, NULL AS [FastingState]

--HFit_TrackerBloodPressure
, NULL AS [Systolic]
, NULL AS [Diastolic]

--HFit_TrackerBodyFat
, NULL AS [PPTBodyFatPCT]

--HFit_TrackerBMI
, NULL AS [BMI]

--HFit_TrackerBodyMeasurements
, NULL AS [WaistInches]
, NULL AS [HipInches]
, NULL AS [ThighInches]
, NULL AS [ArmInches]
, NULL AS [ChestInches]
, NULL AS [CalfInches]
, NULL AS [NeckInches]

--HFit_TrackerHeight
, NULL AS [Height]

--HFit_TrackerRestingHeartRate
, NULL AS [HeartRate]
, --HFit_TrackerShots
NULL AS [FluShot]
, NULL AS [PneumoniaShot]

--HFit_TrackerTests
, NULL AS [PSATest]
, NULL AS [OtherExam]
, NULL AS [TScore]
, NULL AS [DRA]
, NULL AS [CotinineTest]
, NULL AS [ColoCareKit]
, NULL AS [CustomTest]
, NULL AS [CustomDesc]
, NULL AS [CollectionSource]
, [HFA].[AccountID]
, [HFA].[AccountCD]
, CASE
	 WHEN [HFUT].[ItemCreatedWhen] = COALESCE ([HFUT].[ItemModifiedWhen] , [hfut].[ItemCreatedWhen]) 
	 THEN 'I'
	 ELSE 'U'
  END AS [ChangeType]
, [HFUT].[ItemCreatedWhen]
, [HFUT].[ItemModifiedWhen]
, 0   AS [TrackerCollectionSourceID]
, [HFUT].[itemid]
, 'HFit_UserTracker' AS [TBL]
, NULL AS [VendorID]		--VENDOR.ItemID as VendorID
, NULL AS [VendorName]		--VENDOR.VendorName
  FROM
	  [dbo].[HFit_UserTracker] AS [HFUT]
		 INNER JOIN [dbo].[CMS_UserSettings] AS [CUS]
			ON [hfut].[UserID] = [cus].[UserSettingsUserID]
		 INNER JOIN [dbo].[CMS_UserSite] AS [CUS2]
			ON [cus].[UserSettingsUserID] = [cus2].[UserID]
		 INNER JOIN [dbo].[CMS_Site] AS [CS]
			ON [CUS2].[SiteID] = [CS].[SiteID]
		 INNER JOIN [dbo].[HFit_Account] AS [HFA]
			ON [cs].[SiteID] = [HFA].[SiteID]
  --left outer join HFit_LKP_TrackerVendor as VENDOR on HFUT.VendorID = VENDOR.ItemID
  --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table EDW_BiometricViewRejectCriteria
  WHERE [CS].[SITEID] NOT IN (SELECT [SiteID]
						  FROM [EDW_BiometricViewRejectCriteria]
						  WHERE [HFUT].[ItemCreatedWhen] < [ItemCreatedWhen]) 
    AND [HFA].[AccountCD] NOT IN (SELECT [AccountCD]
							 FROM [EDW_BiometricViewRejectCriteria]
							 WHERE [HFA].[AccountCD] = [AccountCD]
							   AND [HFUT].[ItemCreatedWhen] < [ItemCreatedWhen]) 
	   --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified within table EDW_BiometricViewRejectCriteria
    AND [HFUT].[ItemCreatedWhen] IS NOT NULL		--Add per Robert and Laura 12.4.2014

UNION ALL
SELECT
[hftw].[UserID]
, [cus].[UserSettingsUserGUID]
, [cus].[HFitUserMpiNumber]
, [cus2].[SiteID]
, [cs].[SiteGUID]
, [HFTW].[ItemCreatedWhen]
, [HFTW].[ItemModifiedWhen]
, [HFTW].[Notes]
, [HFTW].[IsProfessionallyCollected]
, [HFTW].[EventDate]
, 'Not Build Yet' AS [EventName]
, [hftw].Value AS [PPTWeight]
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, [HFTCS].[CollectionSourceName_External]
, [HFA].[AccountID]
, [HFA].[AccountCD]
, CASE
	 WHEN [HFTW].[ItemCreatedWhen] = COALESCE ([HFTW].[ItemModifiedWhen] , [HFTW].[ItemCreatedWhen]) 
	 THEN 'I'
	 ELSE 'U'
  END AS [ChangeType]
, [HFTW].[ItemCreatedWhen]
, [HFTW].[ItemModifiedWhen]
, [HFTCS].[TrackerCollectionSourceID]
, [HFTW].[itemid]
, 'HFit_TrackerWeight' AS [TBL]
, [VENDOR].[ItemID] AS [VendorID]
, [VENDOR].[VendorName]
  FROM
	  [dbo].[HFit_TrackerWeight] AS [HFTW]
		 INNER JOIN [dbo].[HFit_TrackerCollectionSource] AS [HFTCS]
			ON [HFTW].[TrackerCollectionSourceID] = [HFTCS].[TrackerCollectionSourceID]
		 INNER JOIN [dbo].[CMS_UserSettings] AS [CUS]
			ON [HFTW].[UserID] = [cus].[UserSettingsUserID]
		 INNER JOIN [dbo].[CMS_UserSite] AS [CUS2]
			ON [cus].[UserSettingsUserID] = [cus2].[UserID]
		 INNER JOIN [dbo].[CMS_Site] AS [CS]
			ON [CUS2].[SiteID] = [CS].[SiteID]
		 INNER JOIN [dbo].[HFit_Account] AS [HFA]
			ON [cs].[SiteID] = [HFA].[SiteID]
		 LEFT OUTER JOIN [HFit_LKP_TrackerVendor] AS [VENDOR]
			ON [HFTW].[VendorID] = [VENDOR].[ItemID]
  --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table EDW_BiometricViewRejectCriteria	  
  WHERE [CS].[SITEID] NOT IN (SELECT [SiteID]
						  FROM [EDW_BiometricViewRejectCriteria]
						  WHERE COALESCE ([HFTW].[EventDate] , [HFTW].[ItemCreatedWhen]) < [ItemCreatedWhen]) 
    AND [HFA].[AccountCD] NOT IN (SELECT [AccountCD]
							 FROM [EDW_BiometricViewRejectCriteria]
							 WHERE [HFA].[AccountCD] = [AccountCD]
							   AND COALESCE ([HFTW].[EventDate] , [HFTW].[ItemCreatedWhen]) < [ItemCreatedWhen]) 
    AND ([HFTW].[ItemCreatedWhen] IS NOT NULL
	 OR [HFTW].[EventDate] IS NOT NULL)		--Add per RObert and Laura 12.4.2014			

UNION ALL
SELECT
[HFTHA].[UserID]
, [cus].[UserSettingsUserGUID]
, [cus].[HFitUserMpiNumber]
, [cus2].[SiteID]
, [cs].[SiteGUID]
, [HFTHA].[ItemCreatedWhen]
, [HFTHA].[ItemModifiedWhen]
, [HFTHA].[Notes]
, [HFTHA].[IsProfessionallyCollected]
, [HFTHA].[EventDate]
, 'Not Build Yet' AS [EventName]
, NULL
, [HFTHA].Value AS [PPTHbA1C]
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, [HFTCS].[CollectionSourceName_External]
, [HFA].[AccountID]
, [HFA].[AccountCD]
, CASE
	 WHEN [HFTHA].[ItemCreatedWhen] = COALESCE ([HFTHA].[ItemModifiedWhen] , [HFTHA].[ItemCreatedWhen]) 
	 THEN 'I'
	 ELSE 'U'
  END AS [ChangeType]
, [HFTHA].[ItemCreatedWhen]
, [HFTHA].[ItemModifiedWhen]
, [HFTCS].[TrackerCollectionSourceID]
, [HFTHA].[itemid]
, 'HFit_TrackerHbA1c' AS [TBL]
, [VENDOR].[ItemID] AS [VendorID]
, [VENDOR].[VendorName]
  FROM
	  [dbo].[HFit_TrackerHbA1c] AS [HFTHA]
		 INNER JOIN [dbo].[HFit_TrackerCollectionSource] AS [HFTCS]
			ON [HFTHA].[TrackerCollectionSourceID] = [HFTCS].[TrackerCollectionSourceID]
		 INNER JOIN [dbo].[CMS_UserSettings] AS [CUS]
			ON [HFTHA].[UserID] = [cus].[UserSettingsUserID]
		 INNER JOIN [dbo].[CMS_UserSite] AS [CUS2]
			ON [cus].[UserSettingsUserID] = [cus2].[UserID]
		 INNER JOIN [dbo].[CMS_Site] AS [CS]
			ON [CUS2].[SiteID] = [CS].[SiteID]
		 INNER JOIN [dbo].[HFit_Account] AS [HFA]
			ON [cs].[SiteID] = [HFA].[SiteID]
		 LEFT OUTER JOIN [HFit_LKP_TrackerVendor] AS [VENDOR]
			ON [HFTHA].[VendorID] = [VENDOR].[ItemID]
  --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table EDW_BiometricViewRejectCriteria
  WHERE [CS].[SITEID] NOT IN (SELECT [SiteID]
						  FROM [EDW_BiometricViewRejectCriteria]
						  WHERE COALESCE ([HFTHA].[EventDate] , [HFTHA].[ItemCreatedWhen]) < [ItemCreatedWhen]) 
    AND [HFA].[AccountCD] NOT IN (SELECT [AccountCD]
							 FROM [EDW_BiometricViewRejectCriteria]
							 WHERE [HFA].[AccountCD] = [AccountCD]
							   AND COALESCE ([HFTHA].[EventDate] , [HFTHA].[ItemCreatedWhen]) < [ItemCreatedWhen]) 
    AND ([HFTHA].[ItemCreatedWhen] IS NOT NULL
	 OR [HFTHA].[EventDate] IS NOT NULL)		--Add per RObert and Laura 12.4.2014

UNION ALL
SELECT
[HFTC].[UserID]
, [cus].[UserSettingsUserGUID]
, [cus].[HFitUserMpiNumber]
, [cus2].[SiteID]
, [cs].[SiteGUID]
, [HFTC].[ItemCreatedWhen]
, [HFTC].[ItemModifiedWhen]
, [HFTC].[Notes]
, [HFTC].[IsProfessionallyCollected]
, [HFTC].[EventDate]
, 'Not Build Yet' AS [EventName]
, NULL
, NULL
, [HFTC].[Fasting]
, [HFTC].[HDL]
, [HFTC].[LDL]
, [HFTC].[Ratio]
, [HFTC].[Total]
, [HFTC].[Tri]
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, [HFTCS].[CollectionSourceName_External]
, [HFA].[AccountID]
, [HFA].[AccountCD]
, CASE
	 WHEN [HFTC].[ItemCreatedWhen] = COALESCE ([HFTC].[ItemModifiedWhen] , [HFTC].[ItemCreatedWhen]) 
	 THEN 'I'
	 ELSE 'U'
  END AS [ChangeType]
, [HFTC].[ItemCreatedWhen]
, [HFTC].[ItemModifiedWhen]
, [HFTCS].[TrackerCollectionSourceID]
, [HFTC].[itemid]
, 'HFit_TrackerCholesterol' AS [TBL]
, [VENDOR].[ItemID] AS [VendorID]
, [VENDOR].[VendorName]
  FROM
	  [dbo].[HFit_TrackerCholesterol] AS [HFTC]
		 INNER JOIN [dbo].[HFit_TrackerCollectionSource] AS [HFTCS]
			ON [HFTC].[TrackerCollectionSourceID] = [HFTCS].[TrackerCollectionSourceID]
		 INNER JOIN [dbo].[CMS_UserSettings] AS [CUS]
			ON [HFTC].[UserID] = [cus].[UserSettingsUserID]
		 INNER JOIN [dbo].[CMS_UserSite] AS [CUS2]
			ON [cus].[UserSettingsUserID] = [cus2].[UserID]
		 INNER JOIN [dbo].[CMS_Site] AS [CS]
			ON [CUS2].[SiteID] = [CS].[SiteID]
		 INNER JOIN [dbo].[HFit_Account] AS [HFA]
			ON [cs].[SiteID] = [HFA].[SiteID]
		 LEFT OUTER JOIN [HFit_LKP_TrackerVendor] AS [VENDOR]
			ON [HFTC].[VendorID] = [VENDOR].[ItemID]
  --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table EDW_BiometricViewRejectCriteria
  WHERE [CS].[SITEID] NOT IN (SELECT [SiteID]
						  FROM [EDW_BiometricViewRejectCriteria]
						  WHERE COALESCE ([HFTC].[EventDate] , [HFTC].[ItemCreatedWhen]) < [ItemCreatedWhen]) 
    AND [HFA].[AccountCD] NOT IN (SELECT [AccountCD]
							 FROM [EDW_BiometricViewRejectCriteria]
							 WHERE [HFA].[AccountCD] = [AccountCD]
							   AND COALESCE ([HFTC].[EventDate] , [HFTC].[ItemCreatedWhen]) < [ItemCreatedWhen]) 
    AND ([HFTC].[ItemCreatedWhen] IS NOT NULL
	 OR [HFTC].[EventDate] IS NOT NULL)		--Add per RObert and Laura 12.4.2014

UNION ALL
SELECT
[HFTBSAG].[UserID]
, [cus].[UserSettingsUserGUID]
, [cus].[HFitUserMpiNumber]
, [cus2].[SiteID]
, [cs].[SiteGUID]
, [HFTBSAG].[ItemCreatedWhen]
, [HFTBSAG].[ItemModifiedWhen]
, [HFTBSAG].[Notes]
, [HFTBSAG].[IsProfessionallyCollected]
, [HFTBSAG].[EventDate]
, 'Not Build Yet' AS [EventName]
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, [HFTBSAG].[Units]
, [HFTBSAG].[FastingState]
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, [HFTCS].[CollectionSourceName_External]
, [HFA].[AccountID]
, [HFA].[AccountCD]
, CASE
	 WHEN [HFTBSAG].[ItemCreatedWhen] = COALESCE ([HFTBSAG].[ItemModifiedWhen] , [HFTBSAG].[ItemCreatedWhen]) 
	 THEN 'I'
	 ELSE 'U'
  END AS [ChangeType]
, [HFTBSAG].[ItemCreatedWhen]
, [HFTBSAG].[ItemModifiedWhen]
, [HFTCS].[TrackerCollectionSourceID]
, [HFTBSAG].[itemid]
, 'HFit_TrackerBloodSugarAndGlucose' AS [TBL]
, [VENDOR].[ItemID] AS [VendorID]
, [VENDOR].[VendorName]
  FROM
	  [dbo].[HFit_TrackerBloodSugarAndGlucose] AS [HFTBSAG]
		 INNER JOIN [dbo].[HFit_TrackerCollectionSource] AS [HFTCS]
			ON [HFTBSAG].[TrackerCollectionSourceID] = [HFTCS].[TrackerCollectionSourceID]
		 INNER JOIN [dbo].[CMS_UserSettings] AS [CUS]
			ON [HFTBSAG].[UserID] = [cus].[UserSettingsUserID]
		 INNER JOIN [dbo].[CMS_UserSite] AS [CUS2]
			ON [cus].[UserSettingsUserID] = [cus2].[UserID]
		 INNER JOIN [dbo].[CMS_Site] AS [CS]
			ON [CUS2].[SiteID] = [CS].[SiteID]
		 INNER JOIN [dbo].[HFit_Account] AS [HFA]
			ON [cs].[SiteID] = [HFA].[SiteID]
		 LEFT OUTER JOIN [HFit_LKP_TrackerVendor] AS [VENDOR]
			ON [HFTBSAG].[VendorID] = [VENDOR].[ItemID]
  --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table EDW_BiometricViewRejectCriteria
  WHERE [CS].[SITEID] NOT IN (SELECT [SiteID]
						  FROM [EDW_BiometricViewRejectCriteria]
						  WHERE COALESCE ([HFTBSAG].[EventDate] , [HFTBSAG].[ItemCreatedWhen]) < [ItemCreatedWhen]) 
    AND [HFA].[AccountCD] NOT IN (SELECT [AccountCD]
							 FROM [EDW_BiometricViewRejectCriteria]
							 WHERE [HFA].[AccountCD] = [AccountCD]
							   AND COALESCE ([HFTBSAG].[EventDate] , [HFTBSAG].[ItemCreatedWhen]) < [ItemCreatedWhen]) 
    AND ([HFTBSAG].[ItemCreatedWhen] IS NOT NULL
	 OR [HFTBSAG].[EventDate] IS NOT NULL)		--Add per RObert and Laura 12.4.2014

UNION ALL
SELECT
[HFTBP].[UserID]
, [cus].[UserSettingsUserGUID]
, [cus].[HFitUserMpiNumber]
, [cus2].[SiteID]
, [cs].[SiteGUID]
, [HFTBP].[ItemCreatedWhen]
, [HFTBP].[ItemModifiedWhen]
, [HFTBP].[Notes]
, [HFTBP].[IsProfessionallyCollected]
, [HFTBP].[EventDate]
, 'Not Build Yet' AS [EventName]
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, [HFTBP].[Systolic]
, [HFTBP].[Diastolic]
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, [HFTCS].[CollectionSourceName_External]
, [HFA].[AccountID]
, [HFA].[AccountCD]
, CASE
	 WHEN [HFTBP].[ItemCreatedWhen] = COALESCE ([HFTBP].[ItemModifiedWhen] , [HFTBP].[ItemCreatedWhen]) 
	 THEN 'I'
	 ELSE 'U'
  END AS [ChangeType]
, [HFTBP].[ItemCreatedWhen]
, [HFTBP].[ItemModifiedWhen]
, [HFTCS].[TrackerCollectionSourceID]
, [HFTBP].[itemid]
, 'HFit_TrackerBloodPressure' AS [TBL]
, [VENDOR].[ItemID] AS [VendorID]
, [VENDOR].[VendorName]
  FROM
	  [dbo].[HFit_TrackerBloodPressure] AS [HFTBP]
		 INNER JOIN [dbo].[HFit_TrackerCollectionSource] AS [HFTCS]
			ON [HFTBP].[TrackerCollectionSourceID] = [HFTCS].[TrackerCollectionSourceID]
		 INNER JOIN [dbo].[CMS_UserSettings] AS [CUS]
			ON [HFTBP].[UserID] = [cus].[UserSettingsUserID]
		 INNER JOIN [dbo].[CMS_UserSite] AS [CUS2]
			ON [cus].[UserSettingsUserID] = [cus2].[UserID]
		 INNER JOIN [dbo].[CMS_Site] AS [CS]
			ON [CUS2].[SiteID] = [CS].[SiteID]
		 INNER JOIN [dbo].[HFit_Account] AS [HFA]
			ON [cs].[SiteID] = [HFA].[SiteID]
		 LEFT OUTER JOIN [HFit_LKP_TrackerVendor] AS [VENDOR]
			ON [HFTBP].[VendorID] = [VENDOR].[ItemID]
  --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table EDW_BiometricViewRejectCriteria
  WHERE [CS].[SITEID] NOT IN (SELECT [SiteID]
						  FROM [EDW_BiometricViewRejectCriteria]
						  WHERE COALESCE ([HFTBP].[EventDate] , [HFTBP].[ItemCreatedWhen]) < [ItemCreatedWhen]) 
    AND [HFA].[AccountCD] NOT IN (SELECT [AccountCD]
							 FROM [EDW_BiometricViewRejectCriteria]
							 WHERE [HFA].[AccountCD] = [AccountCD]
							   AND COALESCE ([HFTBP].[EventDate] , [HFTBP].[ItemCreatedWhen]) < [ItemCreatedWhen]) 
    AND ([HFTBP].[ItemCreatedWhen] IS NOT NULL
	 OR [HFTBP].[EventDate] IS NOT NULL)		--Add per RObert and Laura 12.4.2014

UNION ALL
SELECT
[HFTBF].[UserID]
, [cus].[UserSettingsUserGUID]
, [cus].[HFitUserMpiNumber]
, [cus2].[SiteID]
, [cs].[SiteGUID]
, [HFTBF].[ItemCreatedWhen]
, [HFTBF].[ItemModifiedWhen]
, [HFTBF].[Notes]
, [HFTBF].[IsProfessionallyCollected]
, [HFTBF].[EventDate]
, 'Not Build Yet' AS [EventName]
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, [HFTBF].Value AS [PPTBodyFatPCT]
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, [HFTCS].[CollectionSourceName_External]
, [HFA].[AccountID]
, [HFA].[AccountCD]
, CASE
	 WHEN [HFTBF].[ItemCreatedWhen] = COALESCE ([HFTBF].[ItemModifiedWhen] , [HFTBF].[ItemCreatedWhen]) 
	 THEN 'I'
	 ELSE 'U'
  END AS [ChangeType]
, [HFTBF].[ItemCreatedWhen]
, [HFTBF].[ItemModifiedWhen]
, [HFTCS].[TrackerCollectionSourceID]
, [HFTBF].[itemid]
, 'HFit_TrackerBodyFat' AS [TBL]
, [VENDOR].[ItemID] AS [VendorID]
, [VENDOR].[VendorName]
  FROM
	  [dbo].[HFit_TrackerBodyFat] AS [HFTBF]
		 INNER JOIN [dbo].[HFit_TrackerCollectionSource] AS [HFTCS]
			ON [HFTBF].[TrackerCollectionSourceID] = [HFTCS].[TrackerCollectionSourceID]
		 INNER JOIN [dbo].[CMS_UserSettings] AS [CUS]
			ON [HFTBF].[UserID] = [cus].[UserSettingsUserID]
		 INNER JOIN [dbo].[CMS_UserSite] AS [CUS2]
			ON [cus].[UserSettingsUserID] = [cus2].[UserID]
		 INNER JOIN [dbo].[CMS_Site] AS [CS]
			ON [CUS2].[SiteID] = [CS].[SiteID]
		 INNER JOIN [dbo].[HFit_Account] AS [HFA]
			ON [cs].[SiteID] = [HFA].[SiteID]
		 LEFT OUTER JOIN [HFit_LKP_TrackerVendor] AS [VENDOR]
			ON [HFTBF].[VendorID] = [VENDOR].[ItemID]
  --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table EDW_BiometricViewRejectCriteria
  WHERE [CS].[SITEID] NOT IN (SELECT [SiteID]
						  FROM [EDW_BiometricViewRejectCriteria]
						  WHERE COALESCE ([HFTBF].[EventDate] , [HFTBF].[ItemCreatedWhen]) < [ItemCreatedWhen]) 
    AND [HFA].[AccountCD] NOT IN (SELECT [AccountCD]
							 FROM [EDW_BiometricViewRejectCriteria]
							 WHERE [HFA].[AccountCD] = [AccountCD]
							   AND COALESCE ([HFTBF].[EventDate] , [HFTBF].[ItemCreatedWhen]) < [ItemCreatedWhen]) 
    AND ([HFTBF].[ItemCreatedWhen] IS NOT NULL
	 OR [HFTBF].[EventDate] IS NOT NULL)		--Add per RObert and Laura 12.4.2014

UNION ALL
SELECT
[HFTB].[UserID]
, [cus].[UserSettingsUserGUID]
, [cus].[HFitUserMpiNumber]
, [cus2].[SiteID]
, [cs].[SiteGUID]
, [HFTB].[ItemCreatedWhen]
, [HFTB].[ItemModifiedWhen]
, [HFTB].[Notes]
, [HFTB].[IsProfessionallyCollected]
, [HFTB].[EventDate]
, 'Not Build Yet' AS [EventName]
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, [HFTB].[BMI]
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, [HFTCS].[CollectionSourceName_External]
, [HFA].[AccountID]
, [HFA].[AccountCD]
, CASE
	 WHEN [HFTB].[ItemCreatedWhen] = COALESCE ([HFTB].[ItemModifiedWhen] , [HFTB].[ItemCreatedWhen]) 
	 THEN 'I'
	 ELSE 'U'
  END AS [ChangeType]
, [HFTB].[ItemCreatedWhen]
, [HFTB].[ItemModifiedWhen]
, [HFTCS].[TrackerCollectionSourceID]
, [HFTB].[itemid]
, 'HFit_TrackerBMI' AS [TBL]
, [VENDOR].[ItemID] AS [VendorID]
, [VENDOR].[VendorName]
  FROM
	  [dbo].[HFit_TrackerBMI] AS [HFTB]
		 INNER JOIN [dbo].[HFit_TrackerCollectionSource] AS [HFTCS]
			ON [HFTB].[TrackerCollectionSourceID] = [HFTCS].[TrackerCollectionSourceID]
		 INNER JOIN [dbo].[CMS_UserSettings] AS [CUS]
			ON [HFTB].[UserID] = [cus].[UserSettingsUserID]
		 INNER JOIN [dbo].[CMS_UserSite] AS [CUS2]
			ON [cus].[UserSettingsUserID] = [cus2].[UserID]
		 INNER JOIN [dbo].[CMS_Site] AS [CS]
			ON [CUS2].[SiteID] = [CS].[SiteID]
		 INNER JOIN [dbo].[HFit_Account] AS [HFA]
			ON [cs].[SiteID] = [HFA].[SiteID]
		 LEFT OUTER JOIN [HFit_LKP_TrackerVendor] AS [VENDOR]
			ON [HFTB].[VendorID] = [VENDOR].[ItemID]
  --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table EDW_BiometricViewRejectCriteria
  WHERE [CS].[SITEID] NOT IN (SELECT [SiteID]
						  FROM [EDW_BiometricViewRejectCriteria]
						  WHERE COALESCE ([HFTB].[EventDate] , [HFTB].[ItemCreatedWhen]) < [ItemCreatedWhen]) 
    AND [HFA].[AccountCD] NOT IN (SELECT [AccountCD]
							 FROM [EDW_BiometricViewRejectCriteria]
							 WHERE [HFA].[AccountCD] = [AccountCD]
							   AND COALESCE ([HFTB].[EventDate] , [HFTB].[ItemCreatedWhen]) < [ItemCreatedWhen]) 
    AND ([HFTB].[ItemCreatedWhen] IS NOT NULL
	 OR [HFTB].[EventDate] IS NOT NULL)		--Add per RObert and Laura 12.4.2014

UNION ALL
SELECT
[HFTBM].[UserID]
, [cus].[UserSettingsUserGUID]
, [cus].[HFitUserMpiNumber]
, [cus2].[SiteID]
, [cs].[SiteGUID]
, [HFTBM].[ItemCreatedWhen]
, [HFTBM].[ItemModifiedWhen]
, [HFTBM].[Notes]
, [HFTBM].[IsProfessionallyCollected]
, [HFTBM].[EventDate]
, 'Not Build Yet' AS [EventName]
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, [HFTBM].[WaistInches]
, [HFTBM].[HipInches]
, [HFTBM].[ThighInches]
, [HFTBM].[ArmInches]
, [HFTBM].[ChestInches]
, [HFTBM].[CalfInches]
, [HFTBM].[NeckInches]
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, [HFTCS].[CollectionSourceName_External]
, [HFA].[AccountID]
, [HFA].[AccountCD]
, CASE
	 WHEN [HFTBM].[ItemCreatedWhen] = COALESCE ([HFTBM].[ItemModifiedWhen] , [HFTBM].[ItemCreatedWhen]) 
	 THEN 'I'
	 ELSE 'U'
  END AS [ChangeType]
, [HFTBM].[ItemCreatedWhen]
, [HFTBM].[ItemModifiedWhen]
, [HFTCS].[TrackerCollectionSourceID]
, [HFTBM].[itemid]
, 'HFit_TrackerBodyMeasurements' AS [TBL]
, [VENDOR].[ItemID] AS [VendorID]
, [VENDOR].[VendorName]
  FROM
	  [dbo].[HFit_TrackerBodyMeasurements] AS [HFTBM]
		 INNER JOIN [dbo].[HFit_TrackerCollectionSource] AS [HFTCS]
			ON [HFTBM].[TrackerCollectionSourceID] = [HFTCS].[TrackerCollectionSourceID]
		 INNER JOIN [dbo].[CMS_UserSettings] AS [CUS]
			ON [HFTBM].[UserID] = [cus].[UserSettingsUserID]
		 INNER JOIN [dbo].[CMS_UserSite] AS [CUS2]
			ON [cus].[UserSettingsUserID] = [cus2].[UserID]
		 INNER JOIN [dbo].[CMS_Site] AS [CS]
			ON [CUS2].[SiteID] = [CS].[SiteID]
		 INNER JOIN [dbo].[HFit_Account] AS [HFA]
			ON [cs].[SiteID] = [HFA].[SiteID]
		 LEFT OUTER JOIN [HFit_LKP_TrackerVendor] AS [VENDOR]
			ON [HFTBM].[VendorID] = [VENDOR].[ItemID]
  --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table EDW_BiometricViewRejectCriteria
  WHERE [CS].[SITEID] NOT IN (SELECT [SiteID]
						  FROM [EDW_BiometricViewRejectCriteria]
						  WHERE COALESCE ([HFTBM].[EventDate] , [HFTBM].[ItemCreatedWhen]) < [ItemCreatedWhen]) 
    AND [HFA].[AccountCD] NOT IN (SELECT [AccountCD]
							 FROM [EDW_BiometricViewRejectCriteria]
							 WHERE [HFA].[AccountCD] = [AccountCD]
							   AND COALESCE ([HFTBM].[EventDate] , [HFTBM].[ItemCreatedWhen]) < [ItemCreatedWhen]) 
    AND ([HFTBM].[ItemCreatedWhen] IS NOT NULL
	 OR [HFTBM].[EventDate] IS NOT NULL)		--Add per RObert and Laura 12.4.2014

UNION ALL
SELECT
[HFTH].[UserID]
, [cus].[UserSettingsUserGUID]
, [cus].[HFitUserMpiNumber]
, [cus2].[SiteID]
, [cs].[SiteGUID]
, [HFTH].[ItemCreatedWhen]
, [HFTH].[ItemModifiedWhen]
, [HFTH].[Notes]
, [HFTH].[IsProfessionallyCollected]
, [HFTH].[EventDate]
, 'Not Build Yet' AS [EventName]
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, [HFTH].[Height]
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, [HFTCS].[CollectionSourceName_External]
, [HFA].[AccountID]
, [HFA].[AccountCD]
, CASE
	 WHEN [HFTH].[ItemCreatedWhen] = COALESCE ([HFTH].[ItemModifiedWhen] , [HFTH].[ItemCreatedWhen]) 
	 THEN 'I'
	 ELSE 'U'
  END AS [ChangeType]
, [HFTH].[ItemCreatedWhen]
, [HFTH].[ItemModifiedWhen]
, [HFTCS].[TrackerCollectionSourceID]
, [HFTH].[itemid]
, 'HFit_TrackerHeight' AS [TBL]
, [VENDOR].[ItemID] AS [VendorID]
, [VENDOR].[VendorName]
  FROM
	  [dbo].[HFit_TrackerHeight] AS [HFTH]
		 INNER JOIN [dbo].[HFit_TrackerCollectionSource] AS [HFTCS]
			ON [HFTH].[TrackerCollectionSourceID] = [HFTCS].[TrackerCollectionSourceID]
		 INNER JOIN [dbo].[CMS_UserSettings] AS [CUS]
			ON [HFTH].[UserID] = [cus].[UserSettingsUserID]
		 INNER JOIN [dbo].[CMS_UserSite] AS [CUS2]
			ON [cus].[UserSettingsUserID] = [cus2].[UserID]
		 INNER JOIN [dbo].[CMS_Site] AS [CS]
			ON [CUS2].[SiteID] = [CS].[SiteID]
		 INNER JOIN [dbo].[HFit_Account] AS [HFA]
			ON [cs].[SiteID] = [HFA].[SiteID]
		 LEFT OUTER JOIN [HFit_LKP_TrackerVendor] AS [VENDOR]
			ON [HFTH].[VendorID] = [VENDOR].[ItemID]
  --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table EDW_BiometricViewRejectCriteria		
  WHERE [CS].[SITEID] NOT IN (SELECT [SiteID]
						  FROM [EDW_BiometricViewRejectCriteria]
						  WHERE COALESCE ([HFTH].[EventDate] , [HFTH].[ItemCreatedWhen]) < [ItemCreatedWhen]) 
    AND [HFA].[AccountCD] NOT IN (SELECT [AccountCD]
							 FROM [EDW_BiometricViewRejectCriteria]
							 WHERE [HFA].[AccountCD] = [AccountCD]
							   AND COALESCE ([HFTH].[EventDate] , [HFTH].[ItemCreatedWhen]) < [ItemCreatedWhen]) 
    AND ([HFTH].[ItemCreatedWhen] IS NOT NULL
	 OR [HFTH].[EventDate] IS NOT NULL)		--Add per RObert and Laura 12.4.2014
UNION ALL
SELECT
[HFTRHR].[UserID]
, [cus].[UserSettingsUserGUID]
, [cus].[HFitUserMpiNumber]
, [cus2].[SiteID]
, [cs].[SiteGUID]
, [HFTRHR].[ItemCreatedWhen]
, [HFTRHR].[ItemModifiedWhen]
, [HFTRHR].[Notes]
, [HFTRHR].[IsProfessionallyCollected]
, [HFTRHR].[EventDate]
, 'Not Build Yet' AS [EventName]
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, [HFTRHR].[HeartRate]
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, [HFTCS].[CollectionSourceName_External]
, [HFA].[AccountID]
, [HFA].[AccountCD]
, CASE
	 WHEN [HFTRHR].[ItemCreatedWhen] = COALESCE ([HFTRHR].[ItemModifiedWhen] , [HFTRHR].[ItemCreatedWhen]) 
	 THEN 'I'
	 ELSE 'U'
  END AS [ChangeType]
, [HFTRHR].[ItemCreatedWhen]
, [HFTRHR].[ItemModifiedWhen]
, [HFTCS].[TrackerCollectionSourceID]
, [HFTRHR].[itemid]
, 'HFit_TrackerRestingHeartRate' AS [TBL]
, [VENDOR].[ItemID] AS [VendorID]
, [VENDOR].[VendorName]
  FROM
	  [dbo].[HFit_TrackerRestingHeartRate] AS [HFTRHR]
		 INNER JOIN [dbo].[HFit_TrackerCollectionSource] AS [HFTCS]
			ON [HFTRHR].[TrackerCollectionSourceID] = [HFTCS].[TrackerCollectionSourceID]
		 INNER JOIN [dbo].[CMS_UserSettings] AS [CUS]
			ON [HFTRHR].[UserID] = [cus].[UserSettingsUserID]
		 INNER JOIN [dbo].[CMS_UserSite] AS [CUS2]
			ON [cus].[UserSettingsUserID] = [cus2].[UserID]
		 INNER JOIN [dbo].[CMS_Site] AS [CS]
			ON [CUS2].[SiteID] = [CS].[SiteID]
		 INNER JOIN [dbo].[HFit_Account] AS [HFA]
			ON [cs].[SiteID] = [HFA].[SiteID]
		 LEFT OUTER JOIN [HFit_LKP_TrackerVendor] AS [VENDOR]
			ON [HFTRHR].[VendorID] = [VENDOR].[ItemID]
  --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table EDW_BiometricViewRejectCriteria
  WHERE [CS].[SITEID] NOT IN (SELECT [SiteID]
						  FROM [EDW_BiometricViewRejectCriteria]
						  WHERE COALESCE ([HFTRHR].[EventDate] , [HFTRHR].[ItemCreatedWhen]) < [ItemCreatedWhen]) 
    AND [HFA].[AccountCD] NOT IN (SELECT [AccountCD]
							 FROM [EDW_BiometricViewRejectCriteria]
							 WHERE [HFA].[AccountCD] = [AccountCD]
							   AND COALESCE ([HFTRHR].[EventDate] , [HFTRHR].[ItemCreatedWhen]) < [ItemCreatedWhen]) 
    AND ([HFTRHR].[ItemCreatedWhen] IS NOT NULL
	 OR [HFTRHR].[EventDate] IS NOT NULL)		--Add per RObert and Laura 12.4.2014

UNION ALL
SELECT
[HFTS].[UserID]
, [cus].[UserSettingsUserGUID]
, [cus].[HFitUserMpiNumber]
, [cus2].[SiteID]
, [cs].[SiteGUID]
, [HFTS].[ItemCreatedWhen]
, [HFTS].[ItemModifiedWhen]
, [HFTS].[Notes]
, [HFTS].[IsProfessionallyCollected]
, [HFTS].[EventDate]
, 'Not Build Yet' AS [EventName]
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, [HFTS].[FluShot]
, [HFTS].[PneumoniaShot]
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, [HFTCS].[CollectionSourceName_External]
, [HFA].[AccountID]
, [HFA].[AccountCD]
, CASE
	 WHEN [HFTS].[ItemCreatedWhen] = COALESCE ([HFTS].[ItemModifiedWhen] , [HFTS].[ItemCreatedWhen]) 
	 THEN 'I'
	 ELSE 'U'
  END AS [ChangeType]
, [HFTS].[ItemCreatedWhen]
, [HFTS].[ItemModifiedWhen]
, [HFTCS].[TrackerCollectionSourceID]
, [HFTS].[itemid]
, 'HFit_TrackerShots' AS [TBL]
, [VENDOR].[ItemID] AS [VendorID]
, [VENDOR].[VendorName]
  FROM
	  [dbo].[HFit_TrackerShots] AS [HFTS]
		 INNER JOIN [dbo].[HFit_TrackerCollectionSource] AS [HFTCS]
			ON [HFTS].[TrackerCollectionSourceID] = [HFTCS].[TrackerCollectionSourceID]
		 INNER JOIN [dbo].[CMS_UserSettings] AS [CUS]
			ON [HFTS].[UserID] = [cus].[UserSettingsUserID]
		 INNER JOIN [dbo].[CMS_UserSite] AS [CUS2]
			ON [cus].[UserSettingsUserID] = [cus2].[UserID]
		 INNER JOIN [dbo].[CMS_Site] AS [CS]
			ON [CUS2].[SiteID] = [CS].[SiteID]
		 INNER JOIN [dbo].[HFit_Account] AS [HFA]
			ON [cs].[SiteID] = [HFA].[SiteID]
		 LEFT OUTER JOIN [HFit_LKP_TrackerVendor] AS [VENDOR]
			ON [HFTS].[VendorID] = [VENDOR].[ItemID]
  --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table EDW_BiometricViewRejectCriteria
  WHERE [CS].[SITEID] NOT IN (SELECT [SiteID]
						  FROM [EDW_BiometricViewRejectCriteria]
						  WHERE COALESCE ([HFTS].[EventDate] , [HFTS].[ItemCreatedWhen]) < [ItemCreatedWhen]) 
    AND [HFA].[AccountCD] NOT IN (SELECT [AccountCD]
							 FROM [EDW_BiometricViewRejectCriteria]
							 WHERE [HFA].[AccountCD] = [AccountCD]
							   AND COALESCE ([HFTS].[EventDate] , [HFTS].[ItemCreatedWhen]) < [ItemCreatedWhen]) 
    AND ([HFTS].[ItemCreatedWhen] IS NOT NULL
	 OR [HFTS].[EventDate] IS NOT NULL)		--Add per RObert and Laura 12.4.2014

UNION ALL
SELECT
[HFTT].[UserID]
, [cus].[UserSettingsUserGUID]
, [cus].[HFitUserMpiNumber]
, [cus2].[SiteID]
, [cs].[SiteGUID]
, [HFTT].[ItemCreatedWhen]
, [HFTT].[ItemModifiedWhen]
, [HFTT].[Notes]
, [HFTT].[IsProfessionallyCollected]
, [HFTT].[EventDate]
, 'Not Build Yet' AS [EventName]
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, [HFTT].[PSATest]
, [HFTT].[OtherExam]
, [HFTT].[TScore]
, [HFTT].[DRA]
, [HFTT].[CotinineTest]
, [HFTT].[ColoCareKit]
, [HFTT].[CustomTest]
, [HFTT].[CustomDesc]
, [HFTCS].[CollectionSourceName_External]
, [HFA].[AccountID]
, [HFA].[AccountCD]
, CASE
	 WHEN [HFTT].[ItemCreatedWhen] = COALESCE ([HFTT].[ItemModifiedWhen] , [HFTT].[ItemCreatedWhen]) 
	 THEN 'I'
	 ELSE 'U'
  END AS [ChangeType]
, [HFTT].[ItemCreatedWhen]
, [HFTT].[ItemModifiedWhen]
, [HFTCS].[TrackerCollectionSourceID]
, [HFTT].[itemid]
, 'HFit_TrackerTests' AS [TBL]
, [VENDOR].[ItemID] AS [VendorID]
, [VENDOR].[VendorName]
  FROM
	  [dbo].[HFit_TrackerTests] AS [HFTT]
		 INNER JOIN [dbo].[HFit_TrackerCollectionSource] AS [HFTCS]
			ON [HFTT].[TrackerCollectionSourceID] = [HFTCS].[TrackerCollectionSourceID]
		 INNER JOIN [dbo].[CMS_UserSettings] AS [CUS]
			ON [HFTT].[UserID] = [cus].[UserSettingsUserID]
		 INNER JOIN [dbo].[CMS_UserSite] AS [CUS2]
			ON [cus].[UserSettingsUserID] = [cus2].[UserID]
		 INNER JOIN [dbo].[CMS_Site] AS [CS]
			ON [CUS2].[SiteID] = [CS].[SiteID]
		 INNER JOIN [dbo].[HFit_Account] AS [HFA]
			ON [cs].[SiteID] = [HFA].[SiteID]
		 LEFT OUTER JOIN [HFit_LKP_TrackerVendor] AS [VENDOR]
			ON [HFTT].[VendorID] = [VENDOR].[ItemID]
  --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table EDW_BiometricViewRejectCriteria
  WHERE [CS].[SITEID] NOT IN (SELECT [SiteID]
						  FROM [EDW_BiometricViewRejectCriteria]
						  WHERE COALESCE ([HFTT].[EventDate] , [HFTT].[ItemCreatedWhen]) < [ItemCreatedWhen]) 
    AND [HFA].[AccountCD] NOT IN (SELECT [AccountCD]
							 FROM [EDW_BiometricViewRejectCriteria]
							 WHERE [HFA].[AccountCD] = [AccountCD]
							   AND COALESCE ([HFTT].[EventDate] , [HFTT].[ItemCreatedWhen]) < [ItemCreatedWhen]) 
    AND ([HFTT].[ItemCreatedWhen] IS NOT NULL
	 OR [HFTT].[EventDate] IS NOT NULL);		--Add per RObert and Laura 12.4.2014

--HFit_TrackerBMI
--HFit_TrackerBodyMeasurements
--HFit_TrackerHeight
--HFit_TrackerRestingHeartRate
--HFit_TrackerShots
--HFit_TrackerTests

GO

PRINT 'Created view_EDW_BioMetrics: ' + CAST (GETDATE () AS nvarchar (50)) ;
GO
--  
--  
GO
PRINT '***** FROM: view_EDW_BioMetrics.sql';
GO

----***************************************************************************************************************************
----** REMOVE THE INSERTS AFTER INTITAL LOAD
----***************************************************************************************************************************
--truncate table EDW_BiometricViewRejectCriteria ;
--go 
--insert into EDW_BiometricViewRejectCriteria (AccountCD, ItemCreatedWhen, SiteID)
--Values (
--'trstmark','11/4/2013',-1) ;
--GO
--insert into EDW_BiometricViewRejectCriteria (AccountCD, ItemCreatedWhen, SiteID)
--Values (
--'entergy','1/6/2014',-1) ;
--GO
--insert into EDW_BiometricViewRejectCriteria (AccountCD, ItemCreatedWhen, SiteID)
--Values (
--'mcwp','1/27/2014',-1) ;
--GO
--insert into EDW_BiometricViewRejectCriteria (AccountCD, ItemCreatedWhen, SiteID)
--Values (
--'stateneb','4/1/2014',-1) ;
--GO
--insert into EDW_BiometricViewRejectCriteria (AccountCD, ItemCreatedWhen, SiteID)
--Values (
--'jnj','5/28/2014',-1) ;
--GO
--insert into EDW_BiometricViewRejectCriteria (AccountCD, ItemCreatedWhen, SiteID)
--Values (
--'coopers','7/1/2014',-1) ;
--GO
--insert into EDW_BiometricViewRejectCriteria (AccountCD, ItemCreatedWhen, SiteID)
--Values (
--'cnh','8/4/2014',-1) ;
--GO
--insert into EDW_BiometricViewRejectCriteria (AccountCD, ItemCreatedWhen, SiteID)
--Values (
--'amat','8/4/2014',-1) ;
--GO
--insert into EDW_BiometricViewRejectCriteria (AccountCD, ItemCreatedWhen, SiteID)
--Values (
--'dupont','8/18/2014',-1) ;
--GO
--insert into EDW_BiometricViewRejectCriteria (AccountCD, ItemCreatedWhen, SiteID)
--Values (
--'ejones','9/3/2014',-1) ;
--GO
--insert into EDW_BiometricViewRejectCriteria (AccountCD, ItemCreatedWhen, SiteID)
--Values (
--'avera','9/15/2014',-1) ;
--GO
--insert into EDW_BiometricViewRejectCriteria (AccountCD, ItemCreatedWhen, SiteID)
--Values (
--'sprvalu','9/18/2014',-1) ;
--GO
--insert into EDW_BiometricViewRejectCriteria (AccountCD, ItemCreatedWhen, SiteID)
--Values (
--'firstgrp','10/6/2014',-1) ;
--GO
--insert into EDW_BiometricViewRejectCriteria (AccountCD, ItemCreatedWhen, SiteID)
--Values (
--'rexnord','12/2/2014',-1) ;
--GO
PRINT '***** COMPLETED : view_EDW_BioMetrics.sql';
GO 

print('Processing job_EDW_GenerateMetadata');
go

IF  EXISTS (SELECT job_id FROM msdb.dbo.sysjobs_view WHERE name = N'job_EDW_GenerateMetadata')
BEGIN 
	begin try
		drop procedure job_EDW_GenerateMetadata ;
	end try
	begin catch
		Print('________________________________________________________________________________________________________________________________');
		Print('NOTIFICATION: Procedure job_EDW_GenerateMetadata already exists, skipping this step."');
		Print('________________________________________________________________________________________________________________________________');
	end catch
END

GO

IF not EXISTS (SELECT job_id FROM msdb.dbo.sysjobs_view WHERE name = N'job_EDW_GenerateMetadata')
BEGIN
	
	--********************************************************************************
	DECLARE @DBNAME nvarchar(100)
	set @DBNAME = (SELECT DB_NAME() AS [Current Database]);
	--********************************************************************************

	USE [msdb]

	/****** Object:  Job [job_EDW_GenerateMetadata]    Script Date: 8/20/2014 3:10:41 PM ******/
	BEGIN TRANSACTION
	
	DECLARE @ReturnCode INT
	SELECT @ReturnCode = 0

	/****** Object:  JobCategory [[Uncategorized (Local)]]]    Script Date: 8/20/2014 3:10:41 PM ******/
	IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
	BEGIN
	EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
	IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

	END

	DECLARE @jobId BINARY(16)
	EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'job_EDW_GenerateMetadata', 
			@enabled=1, 
			@notify_level_eventlog=0, 
			@notify_level_email=0, 
			@notify_level_netsend=0, 
			@notify_level_page=0, 
			@delete_level=0, 
			@description=N'Generate the metadata for the EDW team for Tracker Data', 
			@category_name=N'[Uncategorized (Local)]', 
			@owner_login_name=N'SA', @job_id = @jobId OUTPUT
	IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
	/****** Object:  Step [Extract Kentico Metadata]    Script Date: 8/20/2014 3:10:42 PM ******/
	EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Extract Kentico Metadata', 
			@step_id=1, 
			@cmdexec_success_code=0, 
			@on_success_action=1, 
			@on_success_step_id=0, 
			@on_fail_action=2, 
			@on_fail_step_id=0, 
			@retry_attempts=0, 
			@retry_interval=0, 
			@os_run_priority=0, @subsystem=N'TSQL', 
			@command=N'exec Proc_EDW_GenerateMetadata', 
			@database_name= @DBNAME,
			@flags=0
	IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
	EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
	IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
	EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Extract Metadata Schedule', 
			@enabled=1, 
			@freq_type=4, 
			@freq_interval=1, 
			@freq_subday_type=1, 
			@freq_subday_interval=0, 
			@freq_relative_interval=0, 
			@freq_recurrence_factor=0, 
			@active_start_date=20140820, 
			@active_end_date=99991231, 
			@active_start_time=230000, 
			@active_end_time=235959, 
			@schedule_uid=N'ccba070c-ad61-4dec-8f4c-1e33722b43f6'
	IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
	EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
	IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
	COMMIT TRANSACTION
	GOTO EndSave
	QuitWithRollback:
		IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
	EndSave:

END

--use KenticoCMS_DEV

  --  
  --  
GO 
print('***** FROM: Job_EDW_GenerateKenticoMetadata.sql'); 
GO 

--START ENDING THE IVP
GO

DECLARE @DBNAME nvarchar(100);
declare @ServerName nvarchar(80);
set @ServerName = (SELECT @@SERVERNAME ) ;
set @DBNAME = (SELECT DB_NAME() AS [Current Database]);

print ('--');
print ('*************************************************************************************************************');
print ('IVP Processing complete - please check for errors: on database ' + @DBNAME + ' : ON SERVER : '+ @ServerName + ' ON ' + cast(getdate() as nvarchar(50)));
print ('*************************************************************************************************************');
  --  
GO 
print('***** FROM: TheEnd.sql'); 
GO 
