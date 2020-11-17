SELECT
	   'EXEC sp_refreshview ' + name + ' ; '
  FROM sys.views
  WHERE name LIKE '%EDW%';
DROP PROCEDURE
	 dbo.RefreshAllEDWViews;

--EXEC RefreshAllEDWViews;

GO
ALTER PROCEDURE dbo.RefreshAllEDWViews
AS
	 BEGIN
		 DECLARE @ViewName nvarchar (max) ;
		 DECLARE @SQL nvarchar (max) ;
		 DECLARE extensionViews CURSOR
			 FOR SELECT
						name AS ViewName
				   FROM sys.views
				   WHERE name LIKE '%EDW%';
		 OPEN extensionViews;
		 FETCH NEXT FROM extensionViews INTO @ViewName;

		 -- Check @@FETCH_STATUS to see if there are any more rows to fetch.

		 WHILE @@FETCH_STATUS = 0
			 BEGIN
				 BEGIN TRY
					 PRINT 'REBUILD ' + @ViewName;
					 SET @SQL = 'IF EXISTS (SELECT * FROM sysobjects WHERE type = ''V'' AND name = ''' + @ViewName + ''')
					BEGIN
					exec sp_refreshview N''dbo.' + @ViewName + '''END';
					 EXEC (@SQL) ;
				 END TRY
				 BEGIN CATCH
					 PRINT 'XXX   FAILED REBUILD ' + @ViewName;
				 END CATCH;

				 -- This is executed as long as the previous fetch succeeds.

				 FETCH NEXT FROM extensionViews INTO @ViewName;
			 END;
		 CLOSE extensionViews;
		 DEALLOCATE extensionViews;
	 END;
GO
EXEC RefreshAllEDWViewsview_EDW_SmallStepResponses;
EXEC RefreshAllEDWViewsview_EDW_EDW_TEST_DEL_DelAudit;
EXEC RefreshAllEDWViewsview_EDW_HealthAssesment;
EXEC RefreshAllEDWViewsview_EDW_CoachingDetail;
EXEC RefreshAllEDWViewsview_EDW_HealthAssesmentDeffinition;
EXEC RefreshAllEDWViewsview_EDW_RewardUserDetail;
EXEC RefreshAllEDWViewsview_EDW_RewardsDefinition;
EXEC RefreshAllEDWViewsview_EDW_BiometricViewRejectCriteria;
EXEC RefreshAllEDWViewsview_EDW_BioMetrics;
EXEC RefreshAllEDWViewsview_EDW_TrackerCompositeDetails;
EXEC RefreshAllEDWViewsview_EDW_ClientCompany;
EXEC RefreshAllEDWViewsview_EDW_HealthInterestDetail;
EXEC RefreshAllEDWViewsview_EDW_Coaches;
EXEC RefreshAllEDWViewsview_EDW_HealthInterestList;
EXEC RefreshAllEDWViewsView_EDW_HealthAssesmentAnswers;
EXEC RefreshAllEDWViewsView_EDW_HealthAssesmentQuestions;
EXEC RefreshAllEDWViewsview_EDW_HealthAssesmentDeffinitionCustom;
EXEC RefreshAllEDWViewsview_EDW_HealthAssessmentDefinition_Staged;
EXEC RefreshAllEDWViewsview_EDW_HealthAssessment_Staged;
EXEC RefreshAllEDWViewsview_EDW_Participant;
EXEC RefreshAllEDWViewsview_EDW_CoachingDefinition;
EXEC RefreshAllEDWViewsview_EDW_ScreeningsFromTrackers;
EXEC RefreshAllEDWViewsview_EDW_TrackerMetadata;
EXEC RefreshAllEDWViewsview_EDW_TrackerShots;
EXEC RefreshAllEDWViewsview_EDW_TrackerTests;
EXEC RefreshAllEDWViewsview_EDW_RewardAwardDetail;
EXEC RefreshAllEDWViewsview_EDW_RewardTriggerParameters;
EXEC RefreshAllEDWViewsview_EDW_RewardUserLevel;
EXEC RefreshAllEDWViewsview_EDW_HealthAssesmentClientView;
EXEC RefreshAllEDWViewsview_EDW_Awards;
EXEC RefreshAllEDWViewsView_EDW_RewardProgram_Joined;
EXEC RefreshAllEDWViewsview_EDW_EligibilityHistory;
EXEC RefreshAllEDWViewsview_EDW_Eligibility;
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
