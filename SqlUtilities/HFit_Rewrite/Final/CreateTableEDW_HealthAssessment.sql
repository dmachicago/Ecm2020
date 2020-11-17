
print ('Creating EDW_HealthAssessment');
GO

if exists (select * from sysobjects where name = 'EDW_HealthAssessment' and Xtype = 'U')
BEGIN
	drop table EDW_HealthAssessment
END

go

if exists(select name from sys.tables where name = 'EDW_HealthAssessment')
BEGIN	
	truncate table EDW_HealthAssessment ;
END
ELSE
BEGIN
	CREATE TABLE [dbo].[EDW_HealthAssessment]
	(
		[UserStartedItemID] [int] NOT NULL,
		[HAQuestionNodeGUID] [uniqueidentifier] NOT NULL,
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
		[UserQuestionCodeName] [nvarchar](100) NOT NULL,
		[HAQuestionVersionID] [int] NULL,
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
		[IsProfessionallyCollected] bit NULL
				 
	   ,ItemCreatedWhen datetime
       ,ItemModifiedWhen  datetime
	   ,HARiskCategory_ItemModifiedWhen datetime
	   ,HAUserRiskArea_ItemModifiedWhen datetime
	   ,HAUserQuestion_ItemModifiedWhen datetime
	   ,HAUserAnswers_ItemModifiedWhen datetime
	)
END
GO
print ('Created EDW_HealthAssessment');
GO