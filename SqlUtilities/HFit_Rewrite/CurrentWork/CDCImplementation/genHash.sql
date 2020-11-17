

--SELECT COUNT(*) FROM DIM_EDW_HealthAssessment
DECLARE @Reloadall AS int = 1;
DECLARE @Startdate AS datetime = '2013-11-26';
DECLARE @Enddate AS datetime = '2013-11-27';

IF @Reloadall = 1
    BEGIN
	   PRINT 'RELOAD is ON: ' + CAST (@Reloadall AS nvarchar (50)) ;
    END;
ELSE
    BEGIN
	   PRINT 'RELOAD is OFF: ' + CAST (@Reloadall AS nvarchar (50)) ;
    END;

IF @Reloadall = 1
    BEGIN
	   IF EXISTS (SELECT
					 [NAME]
				 FROM [sys].[tables]
				 WHERE [name] = 'DIM_EDW_HealthAssessment') 
		  BEGIN
			 PRINT 'Dropping DIM_EDW_HealthAssessment for FULL reload.';
			 DROP TABLE
				 [DIM_EDW_HealthAssessment];
		  END;
	   ELSE
		  BEGIN
			 PRINT 'Reloading DIM_EDW_HealthAssessment.';
		  END;

	   PRINT 'Standby, performing initial load of the HA data - this could take several hours, Started at: ' + cast(getdate() as nvarchar(50));
	   /*
	   RELOAD ALL has been selected - the staging table will be dropped and reloaded with ALL the HA data.
	   KenticoCMS_prod2	   -	  06:08:50    -   3,711,962 rows
	   select top 100 * from [DIM_EDW_HealthAssessment]
	   select count(*) from [DIM_EDW_HealthAssessment]
	   */	   
	   SELECT * INTO [DIM_EDW_HealthAssessment]
		FROM view_EDW_HealthAssesmentCT ;
	   PRINT 'Completed , reloading at: ' + cast(getdate() as nvarchar(50));
    END;

IF NOT EXISTS (SELECT
				  [name]
			  FROM [sys].[indexes]
			  WHERE [name] = 'PI_EDW_HealthAssessment_Dates') 
    BEGIN
	   PRINT 'Adding INDEX PI_EDW_HealthAssessment_Dates';
	   CREATE NONCLUSTERED INDEX [PI_EDW_HealthAssessment_Dates] ON [dbo].[DIM_EDW_HealthAssessment] ([ItemCreatedWhen] ASC , [ItemModifiedWhen] ASC , [HARiskCategory_ItemModifiedWhen] ASC , [HAUserRiskArea_ItemModifiedWhen] ASC , [HAUserQuestion_ItemModifiedWhen] ASC , [HAUserAnswers_ItemModifiedWhen] ASC) WITH (PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , SORT_IN_TEMPDB = OFF , DROP_EXISTING = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ;
    END;

IF NOT EXISTS (SELECT
				  [name]
			  FROM [sys].[indexes]
			  WHERE [name] = 'PI_EDW_HealthAssessment_IDs') 
    BEGIN
	   PRINT 'Adding INDEX PI_EDW_HealthAssessment_IDs';
	   CREATE CLUSTERED INDEX [PI_EDW_HealthAssessment_IDs] ON [dbo].[DIM_EDW_HealthAssessment] ([UserStartedItemID] , [UserModuleItemId] , [UserRiskCategoryItemID] , [UserRiskAreaItemID] , [UserQuestionItemID] , [UserAnswerItemID] , [AccountID] , [UserGUID] , [HFitUserMpiNumber]) WITH (PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , SORT_IN_TEMPDB = OFF , DROP_EXISTING = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ;
    END;

IF NOT EXISTS (SELECT
				  [NAME]
			  FROM [sys].[tables]
			  WHERE [name] = 'DIM_EDW_HealthAssessment') 
    BEGIN
	   PRINT '****************************************************************************';
	   PRINT 'FATAL ERROR: table DIM_EDW_HealthAssessment was NOT found, aborting.';
	   PRINT '****************************************************************************';
    END;
ELSE
    BEGIN
	   /*
	   The staging table exists, CHANGES will be determined and applied.
	   */
	   IF EXISTS (SELECT
					 [name]
				 FROM [tempdb].[dbo].[sysobjects]
				 WHERE [id] = OBJECT_ID (N'tempdb..#DIM_EDW_HealthAssessment')) 
		  BEGIN
			 PRINT 'Dropping #DIM_EDW_HealthAssessment';
			 DROP TABLE
				 [#DIM_EDW_HealthAssessment];

		  END;

	   --DECLARE @Startdate AS datetime = '2013-11-26';
	   --DECLARE @Enddate AS datetime = '2013-11-27';
	   PRINT 'Standby, performing HA changed data PULL- this could take several hours, Started at: ' + cast(getdate() as nvarchar(50));
	   SELECT * INTO [#DIM_EDW_HealthAssessment]
		FROM [view_EDW_HealthAssesmentCT]
WHERE 
 [CT_CMS_User].[UserID] IS NOT NULL
	 OR [CT_CMS_UserSettings].[UserSettingsID] IS NOT NULL
	 OR [CT_CMS_Site].[SiteID] IS NOT NULL
	 OR [CT_CMS_UserSite].[UserSiteID] IS NOT NULL
	 OR [CT_HFit_Account].[AccountID] IS NOT NULL
	 OR [CT_HFit_HealthAssesmentUserModule].[ItemID] IS NOT NULL
	 OR [CT_HFit_HealthAssesmentUserModule].[ItemID] IS NOT NULL
	 OR [CT_HFit_HealthAssesmentUserQuestion].[ItemID] IS NOT NULL
	 OR [CT_HFit_HealthAssesmentUserQuestionGroupResults].[ItemID] IS NOT NULL
	 OR [CT_HFit_HealthAssesmentUserRiskArea].[ItemID] IS NOT NULL
	 OR [CT_HFit_HealthAssesmentUserRiskCategory].[ItemID] IS NOT NULL
	 OR [CT_HFit_HealthAssesmentUserStarted].[ItemID] IS NOT NULL
	 OR [CT_CMS_User].[UserID] IS NOT NULL
	 OR [CT_CMS_UserSettings].[UserSettingsID] IS NOT NULL
	 OR [CT_CMS_Site].[SiteID] IS NOT NULL
	 OR [CT_CMS_UserSite].[UserSiteID] IS NOT NULL
	 OR [CT_HFit_Account].[AccountID] IS NOT NULL
	 OR [CT_HFit_HealthAssesmentUserAnswers].[ItemID] IS NOT NULL
	 OR [CT_HFit_HealthAssesmentUserModule].[ItemID] IS NOT NULL
	 OR [CT_HFit_HealthAssesmentUserQuestion].[ItemID] IS NOT NULL
	 OR [CT_HFit_HealthAssesmentUserQuestionGroupResults].[ItemID] IS NOT NULL
	 OR [CT_HFit_HealthAssesmentUserRiskArea].[ItemID] IS NOT NULL
	 OR [CT_HFit_HealthAssesmentUserRiskCategory].[ItemID] IS NOT NULL
	 OR [CT_HFit_HealthAssesmentUserStarted].[ItemID] IS NOT NULL;

    PRINT 'Completed at: ' + cast(getdate() as nvarchar(50));
/*
ADD THE PI to the temp table
*/
	   CREATE CLUSTERED INDEX [temp_PI_EDW_HealthAssessment_IDs] ON [dbo].[#DIM_EDW_HealthAssessment] ([UserStartedItemID] , [UserModuleItemId] , [UserRiskCategoryItemID] , [UserRiskAreaItemID] , [UserQuestionItemID] , [UserAnswerItemID] , [AccountID] , [UserGUID] , [HFitUserMpiNumber]) WITH (PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , SORT_IN_TEMPDB = OFF , DROP_EXISTING = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ;
/*
The temp table is loaded.
Check to see if NEW records exist and if so, insert them into the staging table
*/
	   INSERT INTO [dbo].[DIM_EDW_HealthAssessment] (
			[UserStartedItemID]
		   , [HAQuestionNodeGUID]
		   , [UserID]
		   , [UserGUID]
		   , [HFitUserMpiNumber]
		   , [SiteGUID]
		   , [AccountID]
		   , [AccountCD]
		   , [HAStartedDt]
		   , [HACompletedDt]
		   , [UserModuleItemId]
		   , [UserModuleCodeName]
		   , [HAModuleNodeGUID]
		   , [CMSNodeGuid]
		   , [HAModuleVersionID]
		   , [UserRiskCategoryItemID]
		   , [UserRiskCategoryCodeName]
		   , [HARiskCategoryNodeGUID]
		   , [HARiskCategoryVersionID]
		   , [UserRiskAreaItemID]
		   , [UserRiskAreaCodeName]
		   , [HARiskAreaNodeGUID]
		   , [HARiskAreaVersionID]
		   , [UserQuestionItemID]
		   , [Title]
		   , [UserQuestionCodeName]
		   , [HAQuestionVersionID]
		   , [UserAnswerItemID]
		   , [HAAnswerNodeGUID]
		   , [HAAnswerVersionID]
		   , [UserAnswerCodeName]
		   , [HAAnswerValue]
		   , [HAModuleScore]
		   , [HARiskCategoryScore]
		   , [HARiskAreaScore]
		   , [HAQuestionScore]
		   , [HAAnswerPoints]
		   , [PointResults]
		   , [UOMCode]
		   , [HAScore]
		   , [ModulePreWeightedScore]
		   , [RiskCategoryPreWeightedScore]
		   , [RiskAreaPreWeightedScore]
		   , [QuestionPreWeightedScore]
		   , [QuestionGroupCodeName]
		   , [ChangeType]
		   , [IsProfessionallyCollected]
		   , [ItemCreatedWhen]
		   , [ItemModifiedWhen]
		   , [HARiskCategory_ItemModifiedWhen]
		   , [HAUserRiskArea_ItemModifiedWhen]
		   , [HAUserQuestion_ItemModifiedWhen]
		   , [HAUserAnswers_ItemModifiedWhen]
		   , [HashCode]
		   , [LastModifiedDate]
		   , [DeleteFlg]) 
	   SELECT
			[T1].[UserStartedItemID]
		   , [T1].[HAQuestionNodeGUID]
		   , [T1].[UserID]
		   , [T1].[UserGUID]
		   , [T1].[HFitUserMpiNumber]
		   , [T1].[SiteGUID]
		   , [T1].[AccountID]
		   , [T1].[AccountCD]
		   , [T1].[HAStartedDt]
		   , [T1].[HACompletedDt]
		   , [T1].[UserModuleItemId]
		   , [T1].[UserModuleCodeName]
		   , [T1].[HAModuleNodeGUID]
		   , [T1].[CMSNodeGuid]
		   , [T1].[HAModuleVersionID]
		   , [T1].[UserRiskCategoryItemID]
		   , [T1].[UserRiskCategoryCodeName]
		   , [T1].[HARiskCategoryNodeGUID]
		   , [T1].[HARiskCategoryVersionID]
		   , [T1].[UserRiskAreaItemID]
		   , [T1].[UserRiskAreaCodeName]
		   , [T1].[HARiskAreaNodeGUID]
		   , [T1].[HARiskAreaVersionID]
		   , [T1].[UserQuestionItemID]
		   , [T1].[Title]
		   , [T1].[UserQuestionCodeName]
		   , [T1].[HAQuestionVersionID]
		   , [T1].[UserAnswerItemID]
		   , [T1].[HAAnswerNodeGUID]
		   , [T1].[HAAnswerVersionID]
		   , [T1].[UserAnswerCodeName]
		   , [T1].[HAAnswerValue]
		   , [T1].[HAModuleScore]
		   , [T1].[HARiskCategoryScore]
		   , [T1].[HARiskAreaScore]
		   , [T1].[HAQuestionScore]
		   , [T1].[HAAnswerPoints]
		   , [T1].[PointResults]
		   , [T1].[UOMCode]
		   , [T1].[HAScore]
		   , [T1].[ModulePreWeightedScore]
		   , [T1].[RiskCategoryPreWeightedScore]
		   , [T1].[RiskAreaPreWeightedScore]
		   , [T1].[QuestionPreWeightedScore]
		   , [T1].[QuestionGroupCodeName]
		   , [T1].[ChangeType]
		   , [T1].[IsProfessionallyCollected]
		   , [T1].[ItemCreatedWhen]
		   , [T1].[ItemModifiedWhen]
		   , [T1].[HARiskCategory_ItemModifiedWhen]
		   , [T1].[HAUserRiskArea_ItemModifiedWhen]
		   , [T1].[HAUserQuestion_ItemModifiedWhen]
		   , [T1].[HAUserAnswers_ItemModifiedWhen]
		   , [T1].[HashCode]
		   , [T1].[LastModifiedDate]
		   , [T1].[DeleteFlg]
		FROM
			[#DIM_EDW_HealthAssessment] AS [T1] 
			    --The below needs attention to ensure 3NF access
			    LEFT JOIN [DIM_EDW_HealthAssessment] AS [T2]
				   ON [T1].[UserStartedItemID] = [T2]. [UserStartedItemID]
				  AND [T1].[UserModuleItemId] = [T2]. [UserModuleItemId]
				  AND [T1].[UserRiskCategoryItemID] = [T2]. [UserRiskCategoryItemID]
				  AND [T1].[UserRiskAreaItemID] = [T2]. [UserRiskAreaItemID]
				  AND [T1].[UserQuestionItemID] = [T2]. [UserQuestionItemID]
				  AND [T1].[UserAnswerItemID] = [T2]. [UserAnswerItemID]
				  AND [T1].[AccountID] = [T2]. [AccountID]
				  AND [T1].[UserGUID] = [T2]. [UserGUID]
				  AND [T1].[HFitUserMpiNumber] = [T2]. [HFitUserMpiNumber];

	   /*	   
	   Check to see if CURRENT records have differnet HASH codes and if so, update the staging table
	   */
	   UPDATE [T2]
		SET
		    [T2].[UserStartedItemID] = [T1].[UserStartedItemID]
		  ,[T2].[HAQuestionNodeGUID] = [T1].[HAQuestionNodeGUID]
		  ,[T2].[UserID] = [T1].[UserID]
		  ,[T2].[UserGUID] = [T1].[UserGUID]
		  ,[T2].[HFitUserMpiNumber] = [T1].[HFitUserMpiNumber]
		  ,[T2].[SiteGUID] = [T1].[SiteGUID]
		  ,[T2].[AccountID] = [T1].[AccountID]
		  ,[T2].[AccountCD] = [T1].[AccountCD]
		  ,[T2].[HAStartedDt] = [T1].[HAStartedDt]
		  ,[T2].[HACompletedDt] = [T1].[HACompletedDt]
		  ,[T2].[UserModuleItemId] = [T1].[UserModuleItemId]
		  ,[T2].[UserModuleCodeName] = [T1].[UserModuleCodeName]
		  ,[T2].[HAModuleNodeGUID] = [T1].[HAModuleNodeGUID]
		  ,[T2].[CMSNodeGuid] = [T1].[CMSNodeGuid]
		  ,[T2].[HAModuleVersionID] = [T1].[HAModuleVersionID]
		  ,[T2].[UserRiskCategoryItemID] = [T1].[UserRiskCategoryItemID]
		  ,[T2].[UserRiskCategoryCodeName] = [T1].[UserRiskCategoryCodeName]
		  ,[T2].[HARiskCategoryNodeGUID] = [T1].[HARiskCategoryNodeGUID]
		  ,[T2].[HARiskCategoryVersionID] = [T1].[HARiskCategoryVersionID]
		  ,[T2].[UserRiskAreaItemID] = [T1].[UserRiskAreaItemID]
		  ,[T2].[UserRiskAreaCodeName] = [T1].[UserRiskAreaCodeName]
		  ,[T2].[HARiskAreaNodeGUID] = [T1].[HARiskAreaNodeGUID]
		  ,[T2].[HARiskAreaVersionID] = [T1].[HARiskAreaVersionID]
		  ,[T2].[UserQuestionItemID] = [T1].[UserQuestionItemID]
		  ,[T2].[Title] = [T1].[Title]
		  ,[T2].[UserQuestionCodeName] = [T1].[UserQuestionCodeName]
		  ,[T2].[HAQuestionVersionID] = [T1].[HAQuestionVersionID]
		  ,[T2].[UserAnswerItemID] = [T1].[UserAnswerItemID]
		  ,[T2].[HAAnswerNodeGUID] = [T1].[HAAnswerNodeGUID]
		  ,[T2].[HAAnswerVersionID] = [T1].[HAAnswerVersionID]
		  ,[T2].[UserAnswerCodeName] = [T1].[UserAnswerCodeName]
		  ,[T2].[HAAnswerValue] = [T1].[HAAnswerValue]
		  ,[T2].[HAModuleScore] = [T1].[HAModuleScore]
		  ,[T2].[HARiskCategoryScore] = [T1].[HARiskCategoryScore]
		  ,[T2].[HARiskAreaScore] = [T1].[HARiskAreaScore]
		  ,[T2].[HAQuestionScore] = [T1].[HAQuestionScore]
		  ,[T2].[HAAnswerPoints] = [T1].[HAAnswerPoints]
		  ,[T2].[PointResults] = [T1].[PointResults]
		  ,[T2].[UOMCode] = [T1].[UOMCode]
		  ,[T2].[HAScore] = [T1].[HAScore]
		  ,[T2].[ModulePreWeightedScore] = [T1].[ModulePreWeightedScore]
		  ,[T2].[RiskCategoryPreWeightedScore] = [T1].[RiskCategoryPreWeightedScore]
		  ,[T2].[RiskAreaPreWeightedScore] = [T1].[RiskAreaPreWeightedScore]
		  ,[T2].[QuestionPreWeightedScore] = [T1].[QuestionPreWeightedScore]
		  ,[T2].[QuestionGroupCodeName] = [T1].[QuestionGroupCodeName]
		  ,[T2].[ChangeType] = [T1].[ChangeType]
		  ,[T2].[IsProfessionallyCollected] = [T1].[IsProfessionallyCollected]
		  ,[T2].[ItemCreatedWhen] = [T1].[ItemCreatedWhen]
		  ,[T2].[ItemModifiedWhen] = [T1].[ItemModifiedWhen]
		  ,[T2].[HARiskCategory_ItemModifiedWhen] = [T1].[HARiskCategory_ItemModifiedWhen]
		  ,[T2].[HAUserRiskArea_ItemModifiedWhen] = [T1].[HAUserRiskArea_ItemModifiedWhen]
		  ,[T2].[HAUserQuestion_ItemModifiedWhen] = [T1].[HAUserQuestion_ItemModifiedWhen]
		  ,[T2].[HAUserAnswers_ItemModifiedWhen] = [T1].[HAUserAnswers_ItemModifiedWhen]
		  ,[T2].[HashCode] = [T1].[HashCode]
		  ,[T2].[LastModifiedDate] = [T1].[LastModifiedDate]
		  ,[T2].[DeleteFlg] = [T1].[DeleteFlg]
		FROM [DIM_EDW_HealthAssessment] AS [T2]
			    JOIN [#DIM_EDW_HealthAssessment] AS [T1]
				   ON [T1].[UserStartedItemID] = [T2]. [UserStartedItemID]
				  AND [T1].[UserModuleItemId] = [T2]. [UserModuleItemId]
				  AND [T1].[UserRiskCategoryItemID] = [T2]. [UserRiskCategoryItemID]
				  AND [T1].[UserRiskAreaItemID] = [T2]. [UserRiskAreaItemID]
				  AND [T1].[UserQuestionItemID] = [T2]. [UserQuestionItemID]
				  AND [T1].[UserAnswerItemID] = [T2]. [UserAnswerItemID]
				  AND [T1].[AccountID] = [T2]. [AccountID]
				  AND [T1].[UserGUID] = [T2]. [UserGUID]
				  AND [T1].[HFitUserMpiNumber] = [T2]. [HFitUserMpiNumber]
				  AND [T1].[HashCode] != [T2].[HashCode];

	   --Check to see if records exist in the Staging Table and not in the Temp Table and if so, update the DeleteFlg in the staging table
	   --REVIEW THIS CODE CAREFULLY WITH A SECOND PAIR OF EYES.
			 --UPDATE employees
			 --LEFT JOIN merit ON employees.perf = merits.perf
			 --SET salary = salary + salary * 0.015;
			 --WHERE merit.percent IS NULL

	   UPDATE StagedData
		SET
		    [DeleteFlg] = 1
		FROM [#DIM_EDW_HealthAssessment] AS ChangedData
			    LEFT JOIN [DIM_EDW_HealthAssessment] AS StagedData
				   ON ChangedData.[UserStartedItemID] = StagedData. [UserStartedItemID]
				  AND ChangedData.[UserModuleItemId] = StagedData. [UserModuleItemId]
				  AND ChangedData.[UserRiskCategoryItemID] = StagedData. [UserRiskCategoryItemID]
				  AND ChangedData.[UserRiskAreaItemID] = StagedData. [UserRiskAreaItemID]
				  AND ChangedData.[UserQuestionItemID] = StagedData. [UserQuestionItemID]
				  AND ChangedData.[UserAnswerItemID] = StagedData. [UserAnswerItemID]
				  AND ChangedData.[AccountID] = StagedData. [AccountID]
				  AND ChangedData.[UserGUID] = StagedData. [UserGUID]
				  AND ChangedData.[HFitUserMpiNumber] = StagedData. [HFitUserMpiNumber];

    END;

--SELECT TOP 100
--	  *
--  FROM [DIM_EDW_HealthAssessment];

--SELECT
--	  COUNT (*) 
--  FROM [DIM_EDW_HealthAssessment]; 
