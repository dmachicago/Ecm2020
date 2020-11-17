
GO
USE KenticoCMS_DataMart;

GO
--exec proc_PullEDW_HealthAssesment_CT null,1
PRINT ' FROM proc_PullEDW_HealthAssesment_CT.sql';
PRINT 'Processing proc_PullEDW_HealthAssesment_CT';
GO

SET ANSI_NULLS ON;
SET ANSI_PADDING ON;
SET ANSI_WARNINGS ON;
SET ARITHABORT ON;
SET CONCAT_NULL_YIELDS_NULL ON;
SET NUMERIC_ROUNDABORT OFF;
SET QUOTED_IDENTIFIER ON;

IF NOT EXISTS (SELECT name
					  FROM sys.indexes
					  WHERE name = 'CI_HFit_HealthAssesmentUserRiskArea_HARiskCategoryItemID') 
	BEGIN
		CREATE NONCLUSTERED INDEX CI_HFit_HealthAssesmentUserRiskArea_HARiskCategoryItemID ON dbo.BASE_HFIT_HEALTHASSESMENTUSERRISKAREA (HARiskCategoryItemID) INCLUDE (ItemID
																																									  , HARiskAreaScore
																																									  , ItemModifiedWhen
																																									  , CodeName
																																									  , PreWeightedScore
																																									  , HARiskAreaNodeGUID) ;
	END;
GO

IF EXISTS (SELECT name
				  FROM sys.procedures
				  WHERE name = 'proc_PullEDW_HealthAssesment_CT') 
	BEGIN
		PRINT 'Dropping procedure proc_PullEDW_HealthAssesment_CT';
		DROP PROCEDURE proc_PullEDW_HealthAssesment_CT;
	END;
GO
--exec proc_PullEDW_HealthAssesment_CT 7
CREATE PROCEDURE proc_PullEDW_HealthAssesment_CT
	   @VersionNBR AS bigint = NULL
	 , @Reloadall AS int = 0
AS
	 BEGIN
		 PRINT 'proc_PullEDW_HealthAssesment_CT started at: ' + CAST (GETDATE () AS nvarchar (50)) ;

		 IF @Reloadall = 1
			 BEGIN
				 PRINT 'RELOADING ALL EDW HA Data.';
				 IF EXISTS (SELECT name
								   FROM sys.tables
								   WHERE name = 'FACT_MART_EDW_HealthAssesment') 
					 BEGIN
						 PRINT 'Full reload, dropping FACT_MART_EDW_HealthAssesment...';
						 truncate TABLE FACT_MART_EDW_HealthAssesment;
					 END;
				 INSERT INTO FACT_MART_EDW_HealthAssesment (USERSTARTEDITEMID
														  , HEALTHASSESMENTUSERSTARTEDNODEGUID
														  , USERID
														  , USERGUID
														  , HFITUSERMPINUMBER
														  , SITEGUID
														  , ACCOUNTID
														  , ACCOUNTCD
														  , ACCOUNTNAME
														  , HASTARTEDDT
														  , HACOMPLETEDDT
														  , USERMODULEITEMID
														  , USERMODULECODENAME
														  , HAMODULENODEGUID
														  , CMSNODEGUID
														  , HAMODULEVERSIONID
														  , USERRISKCATEGORYITEMID
														  , USERRISKCATEGORYCODENAME
														  , HARISKCATEGORYNODEGUID
														  , HARISKCATEGORYVERSIONID
														  , USERRISKAREAITEMID
														  , USERRISKAREACODENAME
														  , HARISKAREANODEGUID
														  , HARISKAREAVERSIONID
														  , USERQUESTIONITEMID
														  , TITLE
														  , HAQUESTIONGUID
														  , USERQUESTIONCODENAME
														  , HAQUESTIONDOCUMENTID
														  , HAQUESTIONVERSIONID
														  , HAQUESTIONNODEGUID
														  , USERANSWERITEMID
														  , HAANSWERNODEGUID
														  , HAANSWERVERSIONID
														  , USERANSWERCODENAME
														  , HAANSWERVALUE
														  , HAMODULESCORE
														  , HARISKCATEGORYSCORE
														  , HARISKAREASCORE
														  , HAQUESTIONSCORE
														  , HAANSWERPOINTS
														  , POINTRESULTS
														  , UOMCODE
														  , HASCORE
														  , MODULEPREWEIGHTEDSCORE
														  , RISKCATEGORYPREWEIGHTEDSCORE
														  , RISKAREAPREWEIGHTEDSCORE
														  , QUESTIONPREWEIGHTEDSCORE
														  , QUESTIONGROUPCODENAME
														  , CHANGETYPE
														  , ITEMCREATEDWHEN
														  , ITEMMODIFIEDWHEN
														  , ISPROFESSIONALLYCOLLECTED
														  , HARISKCATEGORY_ITEMMODIFIEDWHEN
														  , HAUSERRISKAREA_ITEMMODIFIEDWHEN
														  , HAUSERQUESTION_ITEMMODIFIEDWHEN
														  , HAUSERANSWERS_ITEMMODIFIEDWHEN
														  , HAPAPERFLG
														  , HATELEPHONICFLG
														  , HASTARTEDMODE
														  , HACOMPLETEDMODE
														  , DOCUMENTCULTURE_VHCJ
														  , DOCUMENTCULTURE_HAQUESTIONSVIEW
														  , CAMPAIGNNODEGUID
														  , HACAMPAIGNID
														  , HASHCODE
														  , PKHASHCODE
														  , CHANGED_FLG
														  , CT_CMS_USER_USERID
														  , CT_CMS_USER_CHANGE_OPERATION
														  , CT_USERSETTINGSID
														  , CT_USERSETTINGSID_CHANGE_OPERATION
														  , SITEID_CTID
														  , SITEID_CHANGE_OPERATION
														  , USERSITEID_CTID
														  , USERSITEID_CHANGE_OPERATION
														  , ACCOUNTID_CTID
														  , ACCOUNTID__CHANGE_OPERATION
														  , HAUSERANSWERS_CTID
														  , HAUSERANSWERS_CHANGE_OPERATION
														  , HFIT_HEALTHASSESMENTUSERMODULE_CTID
														  , HFIT_HEALTHASSESMENTUSERMODULE_CHANGE_OPERATION
														  , HFIT_HEALTHASSESMENTUSERQUESTION_CTID
														  , HFIT_HEALTHASSESMENTUSERQUESTION_CHANGE_OPERATION
														  , HFIT_HealthAssesmentUserQuestionGroupResults_CTID
														  , HFIT_HealthAssesmentUserQuestionGroupResults_CHANGE_OPERATION
														  , HFIT_HEALTHASSESMENTUSERRISKAREA_CTID
														  , HFIT_HEALTHASSESMENTUSERRISKAREA_CHANGE_OPERATION
														  , HFIT_HEALTHASSESMENTUSERRISKCATEGORY_CTID
														  , HFIT_HEALTHASSESMENTUSERRISKCATEGORY_CHANGE_OPERATION
														  , HFIT_HEALTHASSESMENTUSERSTARTED_CTID
														  , HFIT_HEALTHASSESMENTUSERSTARTED_CHANGE_OPERATION
														  , CT_CMS_USER_SCV
														  , CT_CMS_USERSETTINGS_SCV
														  , CT_CMS_SITE_SCV
														  , CT_CMS_USERSITE_SCV
														  , CT_HFIT_ACCOUNT_SCV
														  , CT_HFIT_HealthAssesmentUserAnswers_SCV
														  , CT_HFIT_HEALTHASSESMENTUSERMODULE_SCV
														  , CT_HFIT_HEALTHASSESMENTUSERQUESTION_SCV
														  , CT_HFIT_HealthAssesmentUserQuestionGroupResults_SCV
														  , CT_HFIT_HEALTHASSESMENTUSERRISKAREA_SCV
														  , CT_HFIT_HEALTHASSESMENTUSERRISKCATEGORY_SCV
														  , CT_HFIT_HEALTHASSESMENTUSERSTARTED_SCV
														  , LastModifiedDATE
														  , DELETEFLG
														  , HealthAssessmentType
														  , LASTUPDATEID
														  , SVR
														  , DBNAME
														  , DeletedFlg
														  , LASTLOADEDDATE) 
				 SELECT USERSTARTEDITEMID
					  , HEALTHASSESMENTUSERSTARTEDNODEGUID
					  , USERID
					  , USERGUID
					  , HFITUSERMPINUMBER
					  , SITEGUID
					  , ACCOUNTID
					  , ACCOUNTCD
					  , ACCOUNTNAME
					  , HASTARTEDDT
					  , HACOMPLETEDDT
					  , USERMODULEITEMID
					  , USERMODULECODENAME
					  , HAMODULENODEGUID
					  , CMSNODEGUID
					  , HAMODULEVERSIONID
					  , USERRISKCATEGORYITEMID
					  , USERRISKCATEGORYCODENAME
					  , HARISKCATEGORYNODEGUID
					  , HARISKCATEGORYVERSIONID
					  , USERRISKAREAITEMID
					  , USERRISKAREACODENAME
					  , HARISKAREANODEGUID
					  , HARISKAREAVERSIONID
					  , USERQUESTIONITEMID
					  , TITLE
					  , HAQUESTIONGUID
					  , USERQUESTIONCODENAME
					  , HAQUESTIONDOCUMENTID
					  , HAQUESTIONVERSIONID
					  , HAQUESTIONNODEGUID
					  , USERANSWERITEMID
					  , HAANSWERNODEGUID
					  , HAANSWERVERSIONID
					  , USERANSWERCODENAME
					  , HAANSWERVALUE
					  , HAMODULESCORE
					  , HARISKCATEGORYSCORE
					  , HARISKAREASCORE
					  , HAQUESTIONSCORE
					  , HAANSWERPOINTS
					  , POINTRESULTS
					  , UOMCODE
					  , HASCORE
					  , MODULEPREWEIGHTEDSCORE
					  , RISKCATEGORYPREWEIGHTEDSCORE
					  , RISKAREAPREWEIGHTEDSCORE
					  , QUESTIONPREWEIGHTEDSCORE
					  , QUESTIONGROUPCODENAME
					  , CHANGETYPE
					  , ITEMCREATEDWHEN
					  , ITEMMODIFIEDWHEN
					  , ISPROFESSIONALLYCOLLECTED
					  , HARISKCATEGORY_ITEMMODIFIEDWHEN
					  , HAUSERRISKAREA_ITEMMODIFIEDWHEN
					  , HAUSERQUESTION_ITEMMODIFIEDWHEN
					  , HAUSERANSWERS_ITEMMODIFIEDWHEN
					  , HAPAPERFLG
					  , HATELEPHONICFLG
					  , HASTARTEDMODE
					  , HACOMPLETEDMODE
					  , DOCUMENTCULTURE_VHCJ
					  , DOCUMENTCULTURE_HAQUESTIONSVIEW
					  , CAMPAIGNNODEGUID
					  , HACAMPAIGNID
					  , HASHCODE
					  , PKHASHCODE
					  , CHANGED_FLG
					  , CT_CMS_USER_USERID
					  , CT_CMS_USER_CHANGE_OPERATION
					  , CT_USERSETTINGSID
					  , CT_USERSETTINGSID_CHANGE_OPERATION
					  , SITEID_CTID
					  , SITEID_CHANGE_OPERATION
					  , USERSITEID_CTID
					  , USERSITEID_CHANGE_OPERATION
					  , ACCOUNTID_CTID
					  , ACCOUNTID__CHANGE_OPERATION
					  , HAUSERANSWERS_CTID
					  , HAUSERANSWERS_CHANGE_OPERATION
					  , HFIT_HEALTHASSESMENTUSERMODULE_CTID
					  , HFIT_HEALTHASSESMENTUSERMODULE_CHANGE_OPERATION
					  , HFIT_HEALTHASSESMENTUSERQUESTION_CTID
					  , HFIT_HEALTHASSESMENTUSERQUESTION_CHANGE_OPERATION
					  , HFIT_HealthAssesmentUserQuestionGroupResults_CTID
					  , HFIT_HealthAssesmentUserQuestionGroupResults_CHANGE_OPERATION
					  , HFIT_HEALTHASSESMENTUSERRISKAREA_CTID
					  , HFIT_HEALTHASSESMENTUSERRISKAREA_CHANGE_OPERATION
					  , HFIT_HEALTHASSESMENTUSERRISKCATEGORY_CTID
					  , HFIT_HEALTHASSESMENTUSERRISKCATEGORY_CHANGE_OPERATION
					  , HFIT_HEALTHASSESMENTUSERSTARTED_CTID
					  , HFIT_HEALTHASSESMENTUSERSTARTED_CHANGE_OPERATION
					  , CT_CMS_USER_SCV
					  , CT_CMS_USERSETTINGS_SCV
					  , CT_CMS_SITE_SCV
					  , CT_CMS_USERSITE_SCV
					  , CT_HFIT_ACCOUNT_SCV
					  , CT_HFIT_HealthAssesmentUserAnswers_SCV
					  , CT_HFIT_HEALTHASSESMENTUSERMODULE_SCV
					  , CT_HFIT_HEALTHASSESMENTUSERQUESTION_SCV
					  , CT_HFIT_HealthAssesmentUserQuestionGroupResults_SCV
					  , CT_HFIT_HEALTHASSESMENTUSERRISKAREA_SCV
					  , CT_HFIT_HEALTHASSESMENTUSERRISKCATEGORY_SCV
					  , CT_HFIT_HEALTHASSESMENTUSERSTARTED_SCV
					  , LastModifiedDATE
					  , DELETEFLG
					  , HealthAssessmentType
					  , LASTUPDATEID
					  , SVR
					  , DBNAME
					  , DeletedFlg
					  , LASTLOADEDDATE
						FROM view_MART_HealthAssesment_CT;

				 IF NOT EXISTS (SELECT name
									   FROM sys.indexes
									   WHERE name = 'PI_EDW_HealthAssessment_Dates') 
					 BEGIN
						 PRINT 'Adding INDEX PI_EDW_HealthAssessment_Dates at: ' + CAST (GETDATE () AS nvarchar (50)) ;
						 CREATE NONCLUSTERED INDEX PI_EDW_HealthAssessment_Dates ON dbo.FACT_MART_EDW_HealthAssesment (ItemCreatedWhen ASC, ItemModifiedWhen ASC, HARiskCategory_ItemModifiedWhen ASC, HAUserRiskArea_ItemModifiedWhen ASC, HAUserQuestion_ItemModifiedWhen ASC, HAUserAnswers_ItemModifiedWhen ASC) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ;
					 END;
				 PRINT 'Completed , RELOAD at: ' + CAST (GETDATE () AS nvarchar (50)) ;

			 END;
		 ELSE
			 BEGIN
				 PRINT 'Pulling only data that has changed.';

				 IF EXISTS (SELECT name
								   FROM tempdb.dbo.sysobjects
								   WHERE id = OBJECT_ID (N'tempdb..#FACT_MART_EDW_HealthAssesment')) 
					 BEGIN
						 PRINT 'Dropping #FACT_MART_EDW_HealthAssesment';
						 DROP TABLE #FACT_MART_EDW_HealthAssesment;
					 END;

				 SELECT HAUserStarted.ItemID AS UserStartedItemID
					  , VHAJ.NodeGUID AS HealthAssesmentUserStartedNodeGUID
					  , HAUserStarted.UserID
					  , CMSUser.UserGUID
					  , UserSettings.HFitUserMpiNumber
					  , CMSSite.SiteGUID
					  , ACCT.AccountID
					  , ACCT.AccountCD
					  , ACCT.AccountName
					  , HAUserStarted.HAStartedDt
					  , HAUserStarted.HACompletedDt
					  , HAUserModule.ItemID AS UserModuleItemId
					  , HAUserModule.CodeName AS UserModuleCodeName
					  , HAUserModule.HAModuleNodeGUID
					  , VHAJ.NodeGUID AS CMSNodeGuid
					  , NULL AS HAModuleVersionID
					  , HARiskCategory.ItemID AS UserRiskCategoryItemID
					  , HARiskCategory.CodeName AS UserRiskCategoryCodeName
					  , HARiskCategory.HARiskCategoryNodeGUID
					  , NULL AS HARiskCategoryVersionID
					  , HAUserRiskArea.ItemID AS UserRiskAreaItemID
					  , HAUserRiskArea.CodeName AS UserRiskAreaCodeName
					  , HAUserRiskArea.HARiskAreaNodeGUID
					  , NULL AS HARiskAreaVersionID
					  , HAUserQuestion.ItemID AS UserQuestionItemID
					  , dbo.udf_StripHTML (HAQuestionsView.Title) AS Title
					  , HAUserQuestion.HAQuestionNodeGUID AS HAQuestionGuid
					  , HAUserQuestion.CodeName AS UserQuestionCodeName
					  , NULL AS HAQuestionDocumentID
					  , NULL AS HAQuestionVersionID
					  , HAUserQuestion.HAQuestionNodeGUID
					  , HAUserAnswers.ItemID AS UserAnswerItemID
					  , HAUserAnswers.HAAnswerNodeGUID
					  , NULL AS HAAnswerVersionID
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
						--, CASE
						--  WHEN [HAUserAnswers].[ItemCreatedWhen] = [HAUserAnswers].[ItemModifiedWhen]
						--  THEN 'I'
						--  ELSE 'U'
						--  END AS [ChangeType]
					  , COALESCE (CT_CMS_User.SYS_CHANGE_OPERATION, CT_CMS_UserSettings.SYS_CHANGE_OPERATION, CT_CMS_Site.SYS_CHANGE_OPERATION, CT_CMS_UserSite.SYS_CHANGE_OPERATION, CT_HFit_Account.SYS_CHANGE_OPERATION, CT_HFit_HealthAssesmentUserAnswers.SYS_CHANGE_OPERATION, CT_HFit_HealthAssesmentUserModule.SYS_CHANGE_OPERATION, CT_HFit_HealthAssesmentUserQuestion.SYS_CHANGE_OPERATION, CT_HFit_HealthAssesmentUserQuestionGroupResults.SYS_CHANGE_OPERATION, CT_HFit_HealthAssesmentUserRiskArea.SYS_CHANGE_OPERATION, CT_HFit_HealthAssesmentUserRiskCategory.SYS_CHANGE_OPERATION, CT_HFit_HealthAssesmentUserStarted.SYS_CHANGE_OPERATION) AS ChangeType
					  , HAUserAnswers.ItemCreatedWhen
					  , HAUserAnswers.ItemModifiedWhen
					  , HAUserQuestion.IsProfessionallyCollected
					  , HARiskCategory.ItemModifiedWhen AS HARiskCategory_ItemModifiedWhen
					  , HAUserRiskArea.ItemModifiedWhen AS HAUserRiskArea_ItemModifiedWhen
					  , HAUserQuestion.ItemModifiedWhen AS HAUserQuestion_ItemModifiedWhen
					  , HAUserAnswers.ItemModifiedWhen AS HAUserAnswers_ItemModifiedWhen
					  , HAUserStarted.HAPaperFlg
					  , HAUserStarted.HATelephonicFlg
					  , HAUserStarted.HAStartedMode
					  , HAUserStarted.HACompletedMode
					  , VHCJ.DocumentCulture AS DocumentCulture_VHCJ
					  , HAQuestionsView.DocumentCulture AS DocumentCulture_HAQuestionsView
					  , HAUserStarted.HACampaignNodeGUID AS CampaignNodeGUID
					  , VHCJ.HACampaignID
					  , HASHBYTES ('sha1', ISNULL (LEFT (Title, 2000) , 'X') + ISNULL (CAST (HAUserStarted.HACompletedMode AS nvarchar (50)) , 'X') + ISNULL (CAST (HAUserStarted.HAStartedMode AS nvarchar (50)) , 'X') + ISNULL (CAST (HAUserStarted.HATelephonicFlg AS nvarchar (50)) , 'X') + ISNULL (CAST (HAUserStarted.HAPaperFlg AS nvarchar (50)) , 'X') + ISNULL (CAST (HAUserAnswers.ItemModifiedWhen AS nvarchar (50)) , 'X') + ISNULL (CAST (HAUserQuestion.ItemModifiedWhen AS nvarchar (50)) , 'X') + ISNULL (CAST (HAUserRiskArea.ItemModifiedWhen AS nvarchar (50)) , 'X') + ISNULL (CAST (HARiskCategory.ItemModifiedWhen AS nvarchar (50)) , 'X') + ISNULL (CAST (HAUserQuestion.IsProfessionallyCollected AS nvarchar (50)) , 'X') + ISNULL (CAST (HAUserAnswers.ItemModifiedWhen AS nvarchar (50)) , 'X') + ISNULL (CAST (HAUserAnswers.ItemCreatedWhen AS nvarchar (50)) , 'X') + ISNULL (CAST (HAUserStarted.HAStartedDt AS nvarchar (50)) , 'X') + ISNULL (CAST (HAUserStarted.HACompletedDt AS nvarchar (50)) , 'X') + ISNULL (CAST (AccountCD AS nvarchar (50)) , 'X') + ISNULL (HAUserModule.CodeName, 'X') + ISNULL (HARiskCategory.CodeName, 'X') + ISNULL (HAUserRiskArea.CodeName, 'X') + ISNULL (HAUserAnswers.CodeName, 'X') + ISNULL (HAUserAnswers.HAAnswerValue, 'X') + ISNULL (CAST (HAModuleScore AS nvarchar (20)) , 'X') + ISNULL (CAST (HARiskCategoryScore AS nvarchar (20)) , 'X') + ISNULL (CAST (HAAnswerPoints AS nvarchar (20)) , 'X') + ISNULL (CAST (PointResults AS nvarchar (20)) , 'X') + ISNULL (UOMCode, 'X') + ISNULL (CAST (HAScore AS nvarchar (20)) , 'X') + ISNULL (CAST (HAUserModule.PreWeightedScore AS nvarchar (20)) , 'X') + ISNULL (CAST (HARiskCategory.PreWeightedScore AS nvarchar (20)) , 'X') + ISNULL (CAST (HAUserRiskArea.PreWeightedScore AS nvarchar (20)) , 'X') + ISNULL (CAST (HAUserQuestion.PreWeightedScore AS nvarchar (20)) , 'X') + ISNULL (QuestionGroupCodeName, 'X')) AS HashCode
					  , HAUserAnswers.ItemModifiedWhen AS LastModifiedDate
					  , 0 AS DeleteFlg
					  , COALESCE (CT_CMS_User.UserID, CT_CMS_UserSettings.UserSettingsID, CT_CMS_Site.SiteID, CT_CMS_UserSite.UserSiteID, CT_HFit_Account.AccountID, CT_HFit_HealthAssesmentUserAnswers.ItemID, CT_HFit_HealthAssesmentUserModule.ItemID, CT_HFit_HealthAssesmentUserQuestion.ItemID, CT_HFit_HealthAssesmentUserQuestionGroupResults.ItemID, CT_HFit_HealthAssesmentUserRiskArea.ItemID, CT_HFit_HealthAssesmentUserRiskCategory.ItemID, CT_HFit_HealthAssesmentUserStarted.ItemID) AS CHANGED_FLG
					  , CT_CMS_User.UserID AS CT_CMS_User_UserID
					  , CT_CMS_User.SYS_CHANGE_OPERATION AS CT_CMS_User_CHANGE_OPERATION
					  , CT_CMS_UserSettings.UserSettingsID AS CT_UserSettingsID
					  , CT_CMS_UserSettings.SYS_CHANGE_OPERATION AS CT_UserSettingsID_CHANGE_OPERATION
					  , CT_CMS_Site.SiteID AS SiteID_CtID
					  , CT_CMS_Site.SYS_CHANGE_OPERATION AS SiteID_CHANGE_OPERATION
					  , CT_CMS_UserSite.UserSiteID AS UserSiteID_CtID
					  , CT_CMS_UserSite.SYS_CHANGE_OPERATION AS UserSiteID_CHANGE_OPERATION
					  , CT_HFit_Account.AccountID AS AccountID_CtID
					  , CT_HFit_Account.SYS_CHANGE_OPERATION AS AccountID__CHANGE_OPERATION
					  , CT_HFit_HealthAssesmentUserAnswers.ItemID AS HAUserAnswers_CtID
					  , CT_HFit_HealthAssesmentUserAnswers.SYS_CHANGE_OPERATION AS HAUserAnswers_CHANGE_OPERATION
					  , CT_HFit_HealthAssesmentUserModule.ItemID AS HFit_HealthAssesmentUserModule_CtID
					  , CT_HFit_HealthAssesmentUserModule.SYS_CHANGE_OPERATION AS HFit_HealthAssesmentUserModule_CHANGE_OPERATION
					  , CT_HFit_HealthAssesmentUserQuestion.ItemID AS HFit_HealthAssesmentUserQuestion_CtID
					  , CT_HFit_HealthAssesmentUserQuestion.SYS_CHANGE_OPERATION AS HFit_HealthAssesmentUserQuestion_CHANGE_OPERATION
					  , CT_HFit_HealthAssesmentUserQuestionGroupResults.ItemID AS HFit_HealthAssesmentUserQuestionGroupResults_CtID
					  , CT_HFit_HealthAssesmentUserQuestionGroupResults.SYS_CHANGE_OPERATION AS HFit_HealthAssesmentUserQuestionGroupResults_CHANGE_OPERATION
					  , CT_HFit_HealthAssesmentUserRiskArea.ItemID AS HFit_HealthAssesmentUserRiskArea_CtID
					  , CT_HFit_HealthAssesmentUserRiskArea.SYS_CHANGE_OPERATION AS HFit_HealthAssesmentUserRiskArea_CHANGE_OPERATION
					  , CT_HFit_HealthAssesmentUserRiskCategory.ItemID AS HFit_HealthAssesmentUserRiskCategory_CtID
					  , CT_HFit_HealthAssesmentUserRiskCategory.SYS_CHANGE_OPERATION AS HFit_HealthAssesmentUserRiskCategory_CHANGE_OPERATION
					  , CT_HFit_HealthAssesmentUserStarted.ItemID AS HFit_HealthAssesmentUserStarted_CtID
					  , CT_HFit_HealthAssesmentUserStarted.SYS_CHANGE_OPERATION AS HFit_HealthAssesmentUserStarted_CHANGE_OPERATION
						--Get the TYPE of change 
					  , CT_CMS_User.SYS_CHANGE_VERSION AS CT_CMS_User_SCV
					  , CT_CMS_UserSettings.SYS_CHANGE_VERSION AS CT_CMS_UserSettings_SCV
					  , CT_CMS_Site.SYS_CHANGE_VERSION AS CT_CMS_Site_SCV
					  , CT_CMS_UserSite.SYS_CHANGE_VERSION AS CT_CMS_UserSite_SCV
					  , CT_HFit_Account.SYS_CHANGE_VERSION AS CT_HFit_Account_SCV
					  , CT_HFit_HealthAssesmentUserAnswers.SYS_CHANGE_VERSION AS CT_HFit_HealthAssesmentUserAnswers_SCV
					  , CT_HFit_HealthAssesmentUserModule.SYS_CHANGE_VERSION AS CT_HFit_HealthAssesmentUserModule_SCV
					  , CT_HFit_HealthAssesmentUserQuestion.SYS_CHANGE_VERSION AS CT_HFit_HealthAssesmentUserQuestion_SCV
					  , CT_HFit_HealthAssesmentUserQuestionGroupResults.SYS_CHANGE_VERSION AS CT_HFit_HealthAssesmentUserQuestionGroupResults_SCV
					  , CT_HFit_HealthAssesmentUserRiskArea.SYS_CHANGE_VERSION AS CT_HFit_HealthAssesmentUserRiskArea_SCV
					  , CT_HFit_HealthAssesmentUserRiskCategory.SYS_CHANGE_VERSION AS CT_HFit_HealthAssesmentUserRiskCategory_SCV
					  , CT_HFit_HealthAssesmentUserStarted.SYS_CHANGE_VERSION AS CT_HFit_HealthAssesmentUserStarted_SCV INTO #FACT_MART_EDW_HealthAssesment

				 --declare @VersionNBR as int = null;
				 --select count(*)
						FROM
							 dbo.BASE_HFit_HealthAssesmentUserStarted AS HAUserStarted
								 INNER JOIN dbo.BASE_CMS_User AS CMSUser
									 ON HAUserStarted.UserID = CMSUser.UserID
								 INNER JOIN dbo.BASE_CMS_UserSettings AS UserSettings
									 ON UserSettings.UserSettingsUserID = CMSUser.UserID
									AND HFitUserMpiNumber >= 0
									AND HFitUserMpiNumber IS NOT NULL
								 INNER JOIN dbo.BASE_CMS_UserSite AS UserSite
									 ON CMSUser.UserID = UserSite.UserID
								 INNER JOIN dbo.BASE_CMS_Site AS CMSSite
									 ON UserSite.SiteID = CMSSite.SiteID
								 INNER JOIN dbo.BASE_HFit_Account AS ACCT
									 ON ACCT.SiteID = CMSSite.SiteID
								 INNER JOIN dbo.BASE_HFit_HealthAssesmentUserModule AS HAUserModule
									 ON HAUserStarted.ItemID = HAUserModule.HAStartedItemID
								 INNER JOIN View_HFit_HACampaign_Joined AS VHCJ
									 ON VHCJ.NodeGUID = HAUserStarted.HACampaignNodeGUID
									AND VHCJ.NodeSiteID = UserSite.SiteID
									AND VHCJ.DocumentCulture = 'en-US'
								 INNER JOIN View_HFit_HealthAssessment_Joined AS VHAJ
									 ON VHAJ.DocumentID = VHCJ.HealthAssessmentID
								 INNER JOIN dbo.BASE_HFit_HealthAssesmentUserRiskCategory AS HARiskCategory
									 ON HAUserModule.ItemID = HARiskCategory.HAModuleItemID
								 INNER JOIN dbo.BASE_HFIT_HEALTHASSESMENTUSERRISKAREA AS HAUserRiskArea
									 ON HARiskCategory.ItemID = HAUserRiskArea.HARiskCategoryItemID
								 INNER JOIN dbo.BASE_HFIT_HEALTHASSESMENTUSERQUESTION AS HAUserQuestion
									 ON HAUserRiskArea.ItemID = HAUserQuestion.HARiskAreaItemID
								 INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS HAQuestionsView
									 ON HAUserQuestion.HAQuestionNodeGUID = HAQuestionsView.NodeGUID
									AND HAQuestionsView.DocumentCulture = 'en-US'
								 LEFT OUTER JOIN dbo.FACT_EDW_HFit_HealthAssesmentUserQuestionGroupResults AS HAUserQuestionGroupResults
									 ON HAUserRiskArea.ItemID = HAUserQuestionGroupResults.HARiskAreaItemID
								 INNER JOIN dbo.BASE_HFit_HealthAssesmentUserAnswers AS HAUserAnswers
									 ON HAUserQuestion.ItemID = HAUserAnswers.HAQuestionItemID --ADD THE Changed Data Flags
								 LEFT JOIN CHANGETABLE (CHANGES BASE_CMS_UserSettings, @VersionNBR) AS CT_CMS_UserSettings
									 ON UserSettings.UserSettingsID = CT_CMS_UserSettings.UserSettingsID
								 LEFT JOIN CHANGETABLE (CHANGES BASE_CMS_User, @VersionNBR) AS CT_CMS_User
									 ON CMSUser.UserID = CT_CMS_User.UserID
								 LEFT OUTER JOIN CHANGETABLE (CHANGES BASE_CMS_Site, @VersionNBR) AS CT_CMS_Site
									 ON CMSSite.SiteID = CT_CMS_Site.SiteID
								 LEFT OUTER JOIN CHANGETABLE (CHANGES BASE_CMS_UserSite, @VersionNBR) AS CT_CMS_UserSite
									 ON UserSite.UserSiteID = CT_CMS_UserSite.UserSiteID
								 LEFT OUTER JOIN CHANGETABLE (CHANGES BASE_HFit_Account, @VersionNBR) AS CT_HFit_Account
									 ON ACCT.AccountID = CT_HFit_Account.AccountID
								 LEFT OUTER JOIN CHANGETABLE (CHANGES BASE_HFit_HACampaign, @VersionNBR) AS CT_HFit_HACampaign
									 ON VHCJ.HACampaignID = CT_HFit_HACampaign.HACampaignID
								 LEFT OUTER JOIN CHANGETABLE (CHANGES BASE_HFit_HealthAssesmentUserAnswers, @VersionNBR) AS CT_HFit_HealthAssesmentUserAnswers
									 ON HAUserAnswers.ItemID = CT_HFit_HealthAssesmentUserAnswers.ItemID
								 LEFT OUTER JOIN CHANGETABLE (CHANGES BASE_HFit_HealthAssesmentUserModule, @VersionNBR) AS CT_HFit_HealthAssesmentUserModule
									 ON HAUserModule.ItemID = CT_HFit_HealthAssesmentUserModule.ItemID
								 LEFT OUTER JOIN CHANGETABLE (CHANGES BASE_HFIT_HEALTHASSESMENTUSERQUESTION, @VersionNBR) AS CT_HFit_HealthAssesmentUserQuestion
									 ON HAUserQuestion.ItemID = CT_HFit_HealthAssesmentUserQuestion.ItemID
								 LEFT OUTER JOIN CHANGETABLE (CHANGES FACT_EDW_HFit_HealthAssesmentUserQuestionGroupResults, @VersionNBR) AS CT_HFit_HealthAssesmentUserQuestionGroupResults
									 ON HAUserQuestionGroupResults.ItemID = CT_HFit_HealthAssesmentUserQuestionGroupResults.ItemID
								 LEFT OUTER JOIN CHANGETABLE (CHANGES BASE_HFIT_HEALTHASSESMENTUSERRISKAREA, @VersionNBR) AS CT_HFit_HealthAssesmentUserRiskArea
									 ON HAUserRiskArea.ItemID = CT_HFit_HealthAssesmentUserRiskArea.ItemID
								 LEFT OUTER JOIN CHANGETABLE (CHANGES BASE_HFit_HealthAssesmentUserRiskCategory, @VersionNBR) AS CT_HFit_HealthAssesmentUserRiskCategory
									 ON HARiskCategory.ItemID = CT_HFit_HealthAssesmentUserRiskCategory.ItemID
								 LEFT OUTER JOIN CHANGETABLE (CHANGES BASE_HFit_HealthAssesmentUserStarted, @VersionNBR) AS CT_HFit_HealthAssesmentUserStarted
									 ON HAUserStarted.ItemID = CT_HFit_HealthAssesmentUserStarted.ItemID
						WHERE UserSettings.HFitUserMpiNumber NOT IN (
																	 SELECT RejectMPICode
																			FROM BASE_HFIT_LKP_EDW_REJECTMPI) 
						  AND (CT_CMS_User.UserID IS NOT NULL
							OR CT_CMS_UserSettings.UserSettingsID IS NOT NULL
							OR CT_CMS_Site.SiteID IS NOT NULL
							OR CT_CMS_UserSite.UserSiteID IS NOT NULL
							OR CT_HFit_Account.AccountID IS NOT NULL
							OR CT_HFit_HealthAssesmentUserAnswers.ItemID IS NOT NULL
							OR CT_HFit_HealthAssesmentUserModule.ItemID IS NOT NULL
							OR CT_HFit_HealthAssesmentUserQuestion.ItemID IS NOT NULL
							OR CT_HFit_HealthAssesmentUserQuestionGroupResults.ItemID IS NOT NULL
							OR CT_HFit_HealthAssesmentUserRiskArea.ItemID IS NOT NULL
							OR CT_HFit_HealthAssesmentUserRiskCategory.ItemID IS NOT NULL
							OR CT_HFit_HealthAssesmentUserStarted.ItemID IS NOT NULL) ;
				 --AND COALESCE( [CT_CMS_User].[UserID] , [CT_CMS_UserSettings].[UserSettingsID] , [CT_CMS_Site].[SiteID] , [CT_CMS_UserSite].[UserSiteID] , [CT_HFit_Account].[AccountID] , [CT_HFit_HealthAssesmentUserAnswers].[ItemID] , [CT_HFit_HealthAssesmentUserModule].[ItemID] , [CT_HFit_HealthAssesmentUserQuestion].[ItemID] , [CT_HFit_HealthAssesmentUserQuestionGroupResults].[ItemID] , [CT_HFit_HealthAssesmentUserRiskArea].[ItemID] , [CT_HFit_HealthAssesmentUserRiskCategory].[ItemID] , [CT_HFit_HealthAssesmentUserStarted].[ItemID]
				 --) IS NOT NULL;

				 CREATE CLUSTERED INDEX temp_PI_EDW_HealthAssessment_IDs ON dbo.#FACT_MART_EDW_HealthAssesment (UserStartedItemID, UserModuleItemId, UserRiskCategoryItemID, UserRiskAreaItemID, UserQuestionItemID, UserAnswerItemID, AccountID, UserGUID, HFitUserMpiNumber) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ;

			 END;
		 PRINT 'proc_PullEDW_HealthAssesment_CT ended at: ' + CAST (GETDATE () AS nvarchar (50)) ;
	 END;

GO

PRINT 'COMPLETE: Processed proc_PullEDW_HealthAssesment_CT';
GO
GO
PRINT ' FROM proc_PullEDW_HealthAssesment_CT.sql';
GO



