
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

GO

