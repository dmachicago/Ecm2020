
--exec sp_getViewBaseTableColumns 'view_EDW_Eligibility'
--exec sp_getViewBaseTableColumns 'view_EDW_RewardUserDetail'
--exec sp_getViewBaseTableColumns 'view_EDW_RewardsDefinition'
--exec sp_getViewBaseTableColumns 'view_EDW_TrackerCompositeDetails'
--exec sp_getViewBaseTableColumns 'View_EDW_RewardProgram_Joined'
--exec sp_getViewBaseTableColumns 'view_EDW_RewardTriggerParameters'
--exec sp_getViewBaseTableColumns 'view_EDW_RewardUserLevel'
--exec sp_getViewBaseTableColumns 'view_EDW_RewardAwardDetail'
--exec sp_getViewBaseTableColumns 'view_EDW_HealthAssessmentDefinition_Staged'
--exec sp_getViewBaseTableColumns 'view_EDW_EDW_TEST_DEL_DelAudit'
--exec sp_getViewBaseTableColumns 'view_EDW_CoachingDetail'
--exec sp_getViewBaseTableColumns 'view_EDW_HealthAssesmentDeffinition'
--exec sp_getViewBaseTableColumns 'view_EDW_BiometricViewRejectCriteria'
--exec sp_getViewBaseTableColumns 'view_EDW_BioMetrics'
--exec sp_getViewBaseTableColumns 'view_EDW_HealthAssesmentClientView'
--exec sp_getViewBaseTableColumns 'view_EDW_Awards'
--exec sp_getViewBaseTableColumns 'view_EDW_TrackerMetadata'
--exec sp_getViewBaseTableColumns 'view_EDW_SmallStepResponses'
--exec sp_getViewBaseTableColumns 'view_EDW_HealthAssesment'
--exec sp_getViewBaseTableColumns 'view_EDW_ClientCompany'
--exec sp_getViewBaseTableColumns 'view_EDW_Coaches'
--exec sp_getViewBaseTableColumns 'View_EDW_HealthAssesmentAnswers'
--exec sp_getViewBaseTableColumns 'view_EDW_CoachingDefinition'
--exec sp_getViewBaseTableColumns 'View_EDW_HealthAssesmentQuestions'
--exec sp_getViewBaseTableColumns 'view_EDW_HealthAssessment_Staged'
--exec sp_getViewBaseTableColumns 'view_EDW_HealthAssesmentDeffinitionCustom'
--exec sp_getViewBaseTableColumns 'view_EDW_HealthInterestDetail'
--exec sp_getViewBaseTableColumns 'view_EDW_Participant'
--exec sp_getViewBaseTableColumns 'view_EDW_HealthInterestList'
--exec sp_getViewBaseTableColumns 'view_EDW_ScreeningsFromTrackers'
--exec sp_getViewBaseTableColumns 'view_EDW_TrackerShots'
--exec sp_getViewBaseTableColumns 'view_EDW_TrackerTests'
--exec sp_getViewBaseTableColumns 'view_EDW_EligibilityHistory'
--select 'exec sp_getViewBaseTableColumns ''' + table_name + '''' from information_schema.tables where table_name like '%EDW%' and table_type = 'VIEW'
--go

create PROCEDURE sp_getviewbasetablecolumns (
	  @Tgtview AS nvarchar (100)) 
AS
BEGIN
	BEGIN
		WITH mycte
			AS (SELECT vcu.view_name
					 , vcu.table_name
					 , vcu.column_name
					   FROM
							information_schema.view_column_usage AS vcu
								JOIN information_schema.columns AS col
									ON col.table_schema = vcu.table_schema
								   AND col.table_catalog = vcu.table_catalog
								   AND col.table_name = vcu.table_name
								   AND col.column_name = vcu.column_name
					   WHERE vcu.view_name = @Tgtview
				UNION ALL
				SELECT vcu2.view_name
					 , vcu2.table_name
					 , vcu2.column_name
					   FROM
							information_schema.view_column_usage AS vcu2
								JOIN information_schema.columns AS col
									ON col.table_schema = vcu2.table_schema
								   AND col.table_catalog = vcu2.table_catalog
								   AND col.table_name = vcu2.table_name
								   AND col.column_name = vcu2.column_name
								INNER JOIN mycte
									ON vcu2.view_name = mycte.table_name
								   AND mycte.column_name = vcu2.column_name) 
			
				SELECT DISTINCT column_name
						  , table_name						
				   FROM mycte
				   WHERE table_name IN (
										SELECT table_name
											   FROM information_schema.tables
											   WHERE table_type = 'BASE TABLE') 
			UNION

			--select column_name, '*** ' + table_name from information_schema.view_column_usage 

			SELECT column_name
				 , '*** ' + table_name
				   FROM information_schema.columns
				   WHERE table_name = @Tgtview
				   ORDER BY column_name, table_name;
	END;

--SELECT *
--	   FROM
--			information_schema.view_column_usage AS vcu
--				JOIN information_schema.columns AS col
--					ON col.table_schema = vcu.table_schema
--				   AND col.table_catalog = vcu.table_catalog
--				   AND col.table_name = vcu.table_name
--				   AND col.column_name = vcu.column_name
--	   WHERE vcu.view_name = 'view_EDW_SmallStepResponses';
--SELECT *
--	   FROM
--			information_schema.view_column_usage AS vcu
--				JOIN information_schema.columns AS col
--					ON col.table_schema = vcu.table_schema
--				   AND col.table_catalog = vcu.table_catalog
--				   AND col.table_name = vcu.table_name
--				   AND col.column_name = vcu.column_name
--	   WHERE vcu.view_name = 'View_HFit_OutComeMessages_Joined'
--		 AND vcu.column_name IN ('NodeGUID', 'DocumentCulture', 'Message') ;
--SELECT *
--	   FROM
--			information_schema.view_column_usage AS vcu
--				JOIN information_schema.columns AS col
--					ON col.table_schema = vcu.table_schema
--				   AND col.table_catalog = vcu.table_catalog
--				   AND col.table_name = vcu.table_name
--				   AND col.column_name = vcu.column_name
--	   WHERE vcu.view_name = 'View_HFit_HACampaign_Joined'
--		 AND vcu.column_name IN ('NodeGUID', 'DocumentCulture', 'Name', 'CampaignStartDate', 'CampaignEndDate') ;
--SELECT *
--	   FROM
--			information_schema.view_column_usage AS vcu
--				JOIN information_schema.columns AS col
--					ON col.table_schema = vcu.table_schema
--				   AND col.table_catalog = vcu.table_catalog
--				   AND col.table_name = vcu.table_name
--				   AND col.column_name = vcu.column_name
--	   WHERE vcu.view_name = 'View_CMS_Tree_Joined'
--		 AND vcu.column_name IN ('NodeGUID', 'DocumentCulture') ;
--SELECT *
--	   FROM
--			information_schema.view_column_usage AS vcu
--				JOIN information_schema.columns AS col
--					ON col.table_schema = vcu.table_schema
--				   AND col.table_catalog = vcu.table_catalog
--				   AND col.table_name = vcu.table_name
--				   AND col.column_name = vcu.column_name
--	   WHERE vcu.view_name = 'View_CMS_Tree_Joined_Regular'
--		 AND vcu.column_name IN ('NodeGUID', 'DocumentCulture') ;
--SELECT *
--	   FROM
--			information_schema.view_column_usage AS vcu
--				JOIN information_schema.columns AS col
--					ON col.table_schema = vcu.table_schema
--				   AND col.table_catalog = vcu.table_catalog
--				   AND col.table_name = vcu.table_name
--				   AND col.column_name = vcu.column_name
--	   WHERE vcu.view_name = 'View_CMS_Tree_Joined_Linked'
--		 AND vcu.column_name IN ('NodeGUID', 'DocumentCulture') ;

END;