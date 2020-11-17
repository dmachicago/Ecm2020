print('Processing: EDW_HealthAssessmentDefinition');
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
