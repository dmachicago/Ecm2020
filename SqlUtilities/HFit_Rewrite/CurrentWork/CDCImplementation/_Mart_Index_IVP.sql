If Not Exists (select name from sys.indexes where name = 'IHash_View_HFit_CoachingEvalHAQA_Joined') 
 CREATE CLUSTERED INDEX IHash_View_HFit_CoachingEvalHAQA_Joined ON dbo.BASE_View_HFit_CoachingEvalHAQA_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_HFit_RewardActivity_Joined') 
 CREATE CLUSTERED INDEX IHash_View_HFit_RewardActivity_Joined ON dbo.BASE_View_HFit_RewardActivity_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_BASE_cms_user') 
 CREATE NONCLUSTERED INDEX CI_BASE_cms_user ON dbo.BASE_cms_user (  SVR ASC  , DBNAME ASC  , UserID ASC  )   INCLUDE ( HashCode , LASTMODIFIEDDATE )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_DBPK_CMS_User') 
 CREATE NONCLUSTERED INDEX CI_DBPK_CMS_User ON dbo.BASE_cms_user (  UserID ASC  )   INCLUDE ( DBNAME )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_BASE_HFit_UserCoachingAlert_NotMet_Step2_DEL') 
 CREATE CLUSTERED INDEX IHash_BASE_HFit_UserCoachingAlert_NotMet_Step2_DEL ON dbo.BASE_HFit_UserCoachingAlert_NotMet_Step2_DEL (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_HFit_HSBiometricChart_Joined') 
 CREATE CLUSTERED INDEX IHash_View_HFit_HSBiometricChart_Joined ON dbo.BASE_View_HFit_HSBiometricChart_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'GUID_BASE_CMS_Site_HA_LastPullDate') 
 CREATE NONCLUSTERED INDEX GUID_BASE_CMS_Site_HA_LastPullDate ON dbo.BASE_CMS_Site_HA_LastPullDate (  RowGUID DESC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_HFit_ChallengeRegistrationSettings_Joined') 
 CREATE CLUSTERED INDEX IHash_View_HFit_ChallengeRegistrationSettings_Joined ON dbo.BASE_View_HFit_ChallengeRegistrationSettings_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_view_EDW_CoachingDefinition') 
 CREATE CLUSTERED INDEX IHash_view_EDW_CoachingDefinition ON dbo.BASE_view_EDW_CoachingDefinition (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_HFit_UserCoachingAlert_NotMet_Step3') 
 CREATE CLUSTERED INDEX IHash_HFit_UserCoachingAlert_NotMet_Step3 ON dbo.BASE_HFit_UserCoachingAlert_NotMet_Step3 (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'PI_CMS_Document_ClassName') 
 CREATE NONCLUSTERED INDEX PI_CMS_Document_ClassName ON dbo.BASE_CMS_Class (  ClassName ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_DBPK_CMS_TranslationService') 
 CREATE NONCLUSTERED INDEX CI_DBPK_CMS_TranslationService ON dbo.BASE_CMS_TranslationService (  TranslationServiceID ASC  )   INCLUDE ( DBNAME )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_CONTENT_BookingEvent_Joined') 
 CREATE CLUSTERED INDEX IHash_View_CONTENT_BookingEvent_Joined ON dbo.BASE_View_CONTENT_BookingEvent_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_HFit_ClientContact_Joined') 
 CREATE CLUSTERED INDEX IHash_View_HFit_ClientContact_Joined ON dbo.BASE_View_HFit_ClientContact_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'temp_PI_EDW_HealthAssessment_IDs') 
 CREATE CLUSTERED INDEX temp_PI_EDW_HealthAssessment_IDs ON dbo.TEMP_EDW_HealthDefinition_DATA (  RCDocumentGUID ASC  , RADocumentGuid ASC  , RACodeName ASC  , QuesDocumentGuid ASC  , AnsDocumentGuid ASC  , HANodeSiteID ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_view_EDW_HealthInterestList') 
 CREATE CLUSTERED INDEX IHash_view_EDW_HealthInterestList ON dbo.BASE_view_EDW_HealthInterestList (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_HFit_Configuration_LMCoaching') 
 CREATE CLUSTERED INDEX IHash_HFit_Configuration_LMCoaching ON dbo.BASE_HFit_Configuration_LMCoaching (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_HFit_EmailTemplate_Joined') 
 CREATE CLUSTERED INDEX IHash_View_HFit_EmailTemplate_Joined ON dbo.BASE_View_HFit_EmailTemplate_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_HFit_LKP_CoachingCMExclusions') 
 CREATE CLUSTERED INDEX IHash_HFit_LKP_CoachingCMExclusions ON dbo.BASE_HFit_LKP_CoachingCMExclusions (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_DBPK_CMS_SearchIndexCulture') 
 CREATE NONCLUSTERED INDEX CI_DBPK_CMS_SearchIndexCulture ON dbo.BASE_CMS_SearchIndexCulture (  IndexCultureID ASC  , IndexID ASC  )   INCLUDE ( DBNAME )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_BASE_MART_EDW_HealthAssesment') 
 CREATE NONCLUSTERED INDEX CI_BASE_MART_EDW_HealthAssesment ON dbo.BASE_MART_EDW_HealthAssesment (  SVR ASC  , DBNAME ASC  , AccountID ASC  )   INCLUDE ( AccountCD , AccountName )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'PI_BASE_MART_EDW_HealthAssesment_UserStartedItemID') 
 CREATE NONCLUSTERED INDEX PI_BASE_MART_EDW_HealthAssesment_UserStartedItemID ON dbo.BASE_MART_EDW_HealthAssesment (  DBNAME ASC  , UserStartedItemID ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'PI_MART_HA_CMSUser_LastModifiedDate') 
 CREATE NONCLUSTERED INDEX PI_MART_HA_CMSUser_LastModifiedDate ON dbo.BASE_MART_EDW_HealthAssesment (  CMSUser_LastModifiedDate ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'PI_MART_HA_HARiskCategory_LastModifiedDate') 
 CREATE NONCLUSTERED INDEX PI_MART_HA_HARiskCategory_LastModifiedDate ON dbo.BASE_MART_EDW_HealthAssesment (  HARiskCategory_LastModifiedDate ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'PI_MART_HA_HAUserQuestion_LastModifiedDate') 
 CREATE NONCLUSTERED INDEX PI_MART_HA_HAUserQuestion_LastModifiedDate ON dbo.BASE_MART_EDW_HealthAssesment (  HAUserQuestion_LastModifiedDate ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'PI_MART_HA_LastModifiedDate') 
 CREATE NONCLUSTERED INDEX PI_MART_HA_LastModifiedDate ON dbo.BASE_MART_EDW_HealthAssesment (  LastModifiedDate ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'PI_MART_HA_UserSettings_LastModifiedDate') 
 CREATE NONCLUSTERED INDEX PI_MART_HA_UserSettings_LastModifiedDate ON dbo.BASE_MART_EDW_HealthAssesment (  UserSettings_LastModifiedDate ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IDX_BASE_MART_EDW_HealthAssesment_VerHist') 
 CREATE NONCLUSTERED INDEX IDX_BASE_MART_EDW_HealthAssesment_VerHist ON dbo.BASE_MART_EDW_HealthAssesment_VerHist (  DBNAME ASC  , VerNo ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_BASE_HFit_RewardsUserActivityDetail') 
 CREATE NONCLUSTERED INDEX CI_BASE_HFit_RewardsUserActivityDetail ON dbo.BASE_HFit_RewardsUserActivityDetail (  SVR ASC  , DBNAME ASC  , ItemID ASC  )   INCLUDE ( HashCode , LASTMODIFIEDDATE )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_HFit_UserCoachingAlert_NotMet_Step4') 
 CREATE CLUSTERED INDEX IHash_HFit_UserCoachingAlert_NotMet_Step4 ON dbo.BASE_HFit_UserCoachingAlert_NotMet_Step4 (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_Boards_BoardMessage_Joined') 
 CREATE CLUSTERED INDEX IHash_View_Boards_BoardMessage_Joined ON dbo.BASE_View_Boards_BoardMessage_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_CMS_UserRole_MembershipRole_ValidOnly_Joined') 
 CREATE CLUSTERED INDEX IHash_View_CMS_UserRole_MembershipRole_ValidOnly_Joined ON dbo.BASE_View_CMS_UserRole_MembershipRole_ValidOnly_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_DBPK_CMS_SearchIndexSite') 
 CREATE NONCLUSTERED INDEX CI_DBPK_CMS_SearchIndexSite ON dbo.BASE_CMS_SearchIndexSite (  IndexID ASC  , IndexSiteID ASC  )   INCLUDE ( DBNAME )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_view_EDW_Eligibility') 
 CREATE CLUSTERED INDEX IHash_view_EDW_Eligibility ON dbo.BASE_view_EDW_Eligibility (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_HFit_CoachingUserServiceLevel') 
 CREATE CLUSTERED INDEX IHash_HFit_CoachingUserServiceLevel ON dbo.BASE_HFit_CoachingUserServiceLevel (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_BASE_HFit_HealthAssesmentModule') 
 CREATE NONCLUSTERED INDEX CI_BASE_HFit_HealthAssesmentModule ON dbo.BASE_HFit_HealthAssesmentModule (  SVR ASC  , DBNAME ASC  , HealthAssesmentModuleID ASC  )   INCLUDE ( HashCode , LASTMODIFIEDDATE )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_Hfit_HACampaigns_Joined') 
 CREATE CLUSTERED INDEX IHash_View_Hfit_HACampaigns_Joined ON dbo.BASE_View_Hfit_HACampaigns_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_HFIT_SsoConfiguration_Joined') 
 CREATE CLUSTERED INDEX IHash_View_HFIT_SsoConfiguration_Joined ON dbo.BASE_View_HFIT_SsoConfiguration_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_DBPK_CMS_EmailUser') 
 CREATE NONCLUSTERED INDEX CI_DBPK_CMS_EmailUser ON dbo.BASE_CMS_EmailUser (  EmailID ASC  , UserID ASC  )   INCLUDE ( DBNAME )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_BASE_HFit_UserCoachingAlert_NotMet_Step5_DEL') 
 CREATE CLUSTERED INDEX IHash_BASE_HFit_UserCoachingAlert_NotMet_Step5_DEL ON dbo.BASE_HFit_UserCoachingAlert_NotMet_Step5_DEL (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_DBPK_CMS_AttachmentForEmail') 
 CREATE NONCLUSTERED INDEX CI_DBPK_CMS_AttachmentForEmail ON dbo.BASE_CMS_AttachmentForEmail (  AttachmentID ASC  , EmailID ASC  )   INCLUDE ( DBNAME )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_DBPK_CMS_SearchTask') 
 CREATE NONCLUSTERED INDEX CI_DBPK_CMS_SearchTask ON dbo.BASE_CMS_SearchTask (  SearchTaskID ASC  )   INCLUDE ( DBNAME )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_BASE_CMS_AllowedChildClasses ') 
 CREATE NONCLUSTERED INDEX CI_BASE_CMS_AllowedChildClasses  ON dbo.BASE_CMS_AllowedChildClasses (  SVR ASC  , DBNAME ASC  , SurrogateKey_CMS_AllowedChildClasses ASC  )   INCLUDE ( HashCode , LASTMODIFIEDDATE )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_CMS_ResourceString_Joined') 
 CREATE CLUSTERED INDEX IHash_View_CMS_ResourceString_Joined ON dbo.BASE_View_CMS_ResourceString_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_HFit_TrackerDocument_Joined') 
 CREATE CLUSTERED INDEX IHash_View_HFit_TrackerDocument_Joined ON dbo.BASE_View_HFit_TrackerDocument_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_CONTENT_Cellphone_Joined') 
 CREATE CLUSTERED INDEX IHash_View_CONTENT_Cellphone_Joined ON dbo.BASE_View_CONTENT_Cellphone_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_HFit_CoachingNotAssignedSettings') 
 CREATE CLUSTERED INDEX IHash_HFit_CoachingNotAssignedSettings ON dbo.BASE_HFit_CoachingNotAssignedSettings (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_DBPK_CMS_EventLog') 
 CREATE NONCLUSTERED INDEX CI_DBPK_CMS_EventLog ON dbo.BASE_CMS_EventLog (  EventID ASC  , EventTime ASC  )   INCLUDE ( DBNAME )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'UK00_BASE_HFit_TrackerHbA1c') 
 CREATE  UNIQUE NONCLUSTERED INDEX UK00_BASE_HFit_TrackerHbA1c ON dbo.BASE_HFit_TrackerHbA1c (  SurrogateKey_HFit_TrackerHbA1c ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_CONTENT_Job_Joined') 
 CREATE CLUSTERED INDEX IHash_View_CONTENT_Job_Joined ON dbo.BASE_View_CONTENT_Job_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_DBPK_CMS_Country') 
 CREATE NONCLUSTERED INDEX CI_DBPK_CMS_Country ON dbo.BASE_CMS_Country (  CountryID ASC  )   INCLUDE ( DBNAME )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_CMS_Tree_Joined_Attachments') 
 CREATE CLUSTERED INDEX IHash_View_CMS_Tree_Joined_Attachments ON dbo.BASE_View_CMS_Tree_Joined_Attachments (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_BASE_View_CMS_Tree_Joined_Attachments_DEL') 
 CREATE CLUSTERED INDEX IHash_BASE_View_CMS_Tree_Joined_Attachments_DEL ON dbo.BASE_BASE_View_CMS_Tree_Joined_Attachments_DEL (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_PM_ProjectStatus_Joined') 
 CREATE CLUSTERED INDEX IHash_View_PM_ProjectStatus_Joined ON dbo.BASE_View_PM_ProjectStatus_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_BASE_View_HFit_Coach_Bio_DEL') 
 CREATE CLUSTERED INDEX IHash_BASE_View_HFit_Coach_Bio_DEL ON dbo.BASE_BASE_View_HFit_Coach_Bio_DEL (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_DBPK_Board_Board') 
 CREATE NONCLUSTERED INDEX CI_DBPK_Board_Board ON dbo.BASE_Board_Board (  BoardID ASC  )   INCLUDE ( DBNAME )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_DBPK_CMS_SiteDomainAlias') 
 CREATE NONCLUSTERED INDEX CI_DBPK_CMS_SiteDomainAlias ON dbo.BASE_CMS_SiteDomainAlias (  SiteDomainAliasID ASC  )   INCLUDE ( DBNAME )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_HFit_PLPPackageContent_Joined') 
 CREATE CLUSTERED INDEX IHash_View_HFit_PLPPackageContent_Joined ON dbo.BASE_View_HFit_PLPPackageContent_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_BASE_HFit_Screening_QST_DB_ItemID') 
 CREATE NONCLUSTERED INDEX CI_BASE_HFit_Screening_QST_DB_ItemID ON dbo.BASE_HFit_Screening_QST (  DBNAME ASC  )   INCLUDE ( ItemID )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_CONTENT_Office_Joined') 
 CREATE CLUSTERED INDEX IHash_View_CONTENT_Office_Joined ON dbo.BASE_View_CONTENT_Office_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_BASE_HFit_HealthAssesmentUserRiskCategory') 
 CREATE NONCLUSTERED INDEX CI_BASE_HFit_HealthAssesmentUserRiskCategory ON dbo.BASE_HFit_HealthAssesmentUserRiskCategory (  SVR ASC  , DBNAME ASC  , ItemID ASC  )   INCLUDE ( HashCode , LASTMODIFIEDDATE )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'PI_index_BASE_HFit_HealthAssesmentUserRis_8_1423421682__K11_K25_K18_5_10_12_13_15') 
 CREATE NONCLUSTERED INDEX PI_index_BASE_HFit_HealthAssesmentUserRis_8_1423421682__K11_K25_K18_5_10_12_13_15 ON dbo.BASE_HFit_HealthAssesmentUserRiskCategory (  HAModuleItemID ASC  , DBNAME ASC  , ItemID ASC  )   INCLUDE ( CodeName , HARiskCategoryNodeGUID , HARiskCategoryScore , ItemModifiedWhen , PreWeightedScore )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_HFit_HealthAssesmentRiskArea_Joined') 
 CREATE CLUSTERED INDEX IHash_View_HFit_HealthAssesmentRiskArea_Joined ON dbo.BASE_View_HFit_HealthAssesmentRiskArea_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_HFit_CoachingEvalHAOverall') 
 CREATE CLUSTERED INDEX IHash_HFit_CoachingEvalHAOverall ON dbo.BASE_HFit_CoachingEvalHAOverall (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'UK00_BASE_HFit_TrackerBloodSugarAndGlucose') 
 CREATE  UNIQUE NONCLUSTERED INDEX UK00_BASE_HFit_TrackerBloodSugarAndGlucose ON dbo.BASE_HFit_TrackerBloodSugarAndGlucose (  SurrogateKey_HFit_TrackerBloodSugarAndGlucose ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_HFit_GoalCategory_Joined') 
 CREATE CLUSTERED INDEX IHash_View_HFit_GoalCategory_Joined ON dbo.BASE_View_HFit_GoalCategory_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_hfit_ChallengeFAQ_Joined') 
 CREATE CLUSTERED INDEX IHash_View_hfit_ChallengeFAQ_Joined ON dbo.BASE_View_hfit_ChallengeFAQ_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_DBPK_CMS_Form') 
 CREATE NONCLUSTERED INDEX CI_DBPK_CMS_Form ON dbo.BASE_CMS_Form (  FormID ASC  )   INCLUDE ( DBNAME )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'BASE_EDW_GroupMemberToday_DBNAME') 
 CREATE NONCLUSTERED INDEX BASE_EDW_GroupMemberToday_DBNAME ON dbo.BASE_EDW_RoleMemberToday (  DBNAME ASC  )   INCLUDE ( CTKey_EDW_RoleMemberToday )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'PI_BASE_EDW_RoleMemberToday_CTK') 
 CREATE NONCLUSTERED INDEX PI_BASE_EDW_RoleMemberToday_CTK ON dbo.BASE_EDW_RoleMemberToday (  CTKey_EDW_RoleMemberToday ASC  , DBNAME ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_DBPK_CMS_SMTPServer') 
 CREATE NONCLUSTERED INDEX CI_DBPK_CMS_SMTPServer ON dbo.BASE_CMS_SMTPServer (  ServerID ASC  )   INCLUDE ( DBNAME )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_HFit_CoachingCallLogTemporalContainer_Joined') 
 CREATE CLUSTERED INDEX IHash_View_HFit_CoachingCallLogTemporalContainer_Joined ON dbo.BASE_View_HFit_CoachingCallLogTemporalContainer_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_EDW_HealthAssesmentAnswers') 
 CREATE CLUSTERED INDEX IHash_View_EDW_HealthAssesmentAnswers ON dbo.BASE_View_EDW_HealthAssesmentAnswers (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_HFit_CoachingWelcomeSettings') 
 CREATE CLUSTERED INDEX IHash_HFit_CoachingWelcomeSettings ON dbo.BASE_HFit_CoachingWelcomeSettings (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_BASE_HFit_HealthAssesmentUserAnswers') 
 CREATE NONCLUSTERED INDEX CI_BASE_HFit_HealthAssesmentUserAnswers ON dbo.BASE_HFit_HealthAssesmentUserAnswers (  SVR ASC  , DBNAME ASC  , ItemID ASC  )   INCLUDE ( HashCode , LASTMODIFIEDDATE )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'PI_index_BASE_HFit_HealthAssesmentUserAns_8_1042896324__K25_K11_3_5_7_10_12_13_14_18') 
 CREATE NONCLUSTERED INDEX PI_index_BASE_HFit_HealthAssesmentUserAns_8_1042896324__K25_K11_3_5_7_10_12_13_14_18 ON dbo.BASE_HFit_HealthAssesmentUserAnswers (  DBNAME ASC  , HAQuestionItemID ASC  )   INCLUDE ( CodeName , HAAnswerNodeGUID , HAAnswerPoints , HAAnswerValue , ItemCreatedWhen , ItemID , ItemModifiedWhen , UOMCode )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_BASE_HFit_TrackerRegularMeals') 
 CREATE NONCLUSTERED INDEX CI_BASE_HFit_TrackerRegularMeals ON dbo.BASE_HFit_TrackerRegularMeals (  SVR ASC  , DBNAME ASC  , ItemID ASC  )   INCLUDE ( HashCode , LASTMODIFIEDDATE )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'UK00_BASE_HFit_TrackerRegularMeals') 
 CREATE  UNIQUE NONCLUSTERED INDEX UK00_BASE_HFit_TrackerRegularMeals ON dbo.BASE_HFit_TrackerRegularMeals (  SurrogateKey_HFit_TrackerRegularMeals ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = '_dta_index_BASE_CMS_Role_8_601769201__K4_K10_2_3_5_14_27_30_32') 
 CREATE NONCLUSTERED INDEX _dta_index_BASE_CMS_Role_8_601769201__K4_K10_2_3_5_14_27_30_32 ON dbo.BASE_CMS_Role (  SiteID ASC  , RoleID ASC  )   INCLUDE ( CT_RoleDescription , CT_RoleGUID , CT_RoleID , LASTMODIFIEDDATE , RoleDescription , RoleGUID , RoleName )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_DBPK_CMS_Role') 
 CREATE NONCLUSTERED INDEX CI_DBPK_CMS_Role ON dbo.BASE_CMS_Role (  RoleID ASC  )   INCLUDE ( DBNAME )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'SKey_View_hFit_ChallengePPTEligiblePostTemplate_Joined_KenticoCMS_2') 
 CREATE NONCLUSTERED INDEX SKey_View_hFit_ChallengePPTEligiblePostTemplate_Joined_KenticoCMS_2 ON dbo.BASE_View_hFit_ChallengePPTEligiblePostTemplate_Joined_KenticoCMS_2 (  SurrogateKey_View_hFit_ChallengePPTEligiblePostTemplate_Joined_KenticoCMS_2 ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_DBPK_CMS_CssStylesheet') 
 CREATE NONCLUSTERED INDEX CI_DBPK_CMS_CssStylesheet ON dbo.BASE_CMS_CssStylesheet (  StylesheetID ASC  )   INCLUDE ( DBNAME )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'SKey_View_hFit_ChallengePPTEligiblePostTemplate_Joined_KenticoCMS_3') 
 CREATE NONCLUSTERED INDEX SKey_View_hFit_ChallengePPTEligiblePostTemplate_Joined_KenticoCMS_3 ON dbo.BASE_View_hFit_ChallengePPTEligiblePostTemplate_Joined_KenticoCMS_3 (  SurrogateKey_View_hFit_ChallengePPTEligiblePostTemplate_Joined_KenticoCMS_3 ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'pi_BASE_EDW_GroupMemberToday') 
 CREATE NONCLUSTERED INDEX pi_BASE_EDW_GroupMemberToday ON dbo.BASE_EDW_GroupMemberToday (  CTKey_EDW_GroupMemberToday ASC  , DBNAME ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_HFit_CoachingGetStarted_Joined') 
 CREATE CLUSTERED INDEX IHash_View_HFit_CoachingGetStarted_Joined ON dbo.BASE_View_HFit_CoachingGetStarted_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_view_EDW_HealthInterestDetail') 
 CREATE CLUSTERED INDEX IHash_view_EDW_HealthInterestDetail ON dbo.BASE_view_EDW_HealthInterestDetail (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_DBPK_CMS_UserRole') 
 CREATE NONCLUSTERED INDEX CI_DBPK_CMS_UserRole ON dbo.BASE_CMS_UserRole (  UserRoleID ASC  )   INCLUDE ( DBNAME )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_Hfit_Client_Joined') 
 CREATE CLUSTERED INDEX IHash_View_Hfit_Client_Joined ON dbo.BASE_View_Hfit_Client_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'SKey_BASE_View_HFit_ChallengePPTEligibleCDPostTemplate_Joined_DEL') 
 CREATE NONCLUSTERED INDEX SKey_BASE_View_HFit_ChallengePPTEligibleCDPostTemplate_Joined_DEL ON dbo.BASE_View_HFit_ChallengePPTEligibleCDPostTemplate_Joined_DEL (  SurrogateKey_BASE_View_HFit_ChallengePPTEligibleCDPostTemplate_Joined_DEL ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_DBPK_CMS_State') 
 CREATE NONCLUSTERED INDEX CI_DBPK_CMS_State ON dbo.BASE_CMS_State (  StateID ASC  )   INCLUDE ( DBNAME )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_BASE_cms_usersite') 
 CREATE NONCLUSTERED INDEX CI_BASE_cms_usersite ON dbo.BASE_cms_usersite (  SVR ASC  , DBNAME ASC  , UserSiteID ASC  )   INCLUDE ( HashCode , LASTMODIFIEDDATE )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'SKI_base_CMS_UserSite_SurrogateKey_CMS_User') 
 CREATE NONCLUSTERED INDEX SKI_base_CMS_UserSite_SurrogateKey_CMS_User ON dbo.BASE_cms_usersite (  SurrogateKey_cms_user ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'PI05_BASE_cms_usersite') 
 CREATE NONCLUSTERED INDEX PI05_BASE_cms_usersite ON dbo.BASE_cms_usersite (  UserID ASC  , SiteID ASC  , SVR ASC  , DBNAME ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_BASE_HFit_HealthAssesmentMultipleChoiceQuestion') 
 CREATE NONCLUSTERED INDEX CI_BASE_HFit_HealthAssesmentMultipleChoiceQuestion ON dbo.BASE_HFit_HealthAssesmentMultipleChoiceQuestion (  SVR ASC  , DBNAME ASC  , HealthAssesmentMultipleChoiceQuestionID ASC  )   INCLUDE ( HashCode , LASTMODIFIEDDATE )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_BASE_HFit_TrackerWater') 
 CREATE NONCLUSTERED INDEX CI_BASE_HFit_TrackerWater ON dbo.BASE_HFit_TrackerWater (  SVR ASC  , DBNAME ASC  , ItemID ASC  )   INCLUDE ( HashCode , LASTMODIFIEDDATE )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'UK00_BASE_HFit_TrackerWater') 
 CREATE  UNIQUE NONCLUSTERED INDEX UK00_BASE_HFit_TrackerWater ON dbo.BASE_HFit_TrackerWater (  SurrogateKey_HFit_TrackerWater ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_view_EDW_Participant') 
 CREATE CLUSTERED INDEX IHash_view_EDW_Participant ON dbo.BASE_view_EDW_Participant (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_HFit_CoachingSessionCompleted') 
 CREATE CLUSTERED INDEX IHash_HFit_CoachingSessionCompleted ON dbo.BASE_HFit_CoachingSessionCompleted (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_DBPK_CMS_TranslationSubmissionItem') 
 CREATE NONCLUSTERED INDEX CI_DBPK_CMS_TranslationSubmissionItem ON dbo.BASE_CMS_TranslationSubmissionItem (  SubmissionItemID ASC  )   INCLUDE ( DBNAME )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_view_hfit_CoachingGetUserDaysSinceActivity') 
 CREATE CLUSTERED INDEX IHash_view_hfit_CoachingGetUserDaysSinceActivity ON dbo.BASE_view_hfit_CoachingGetUserDaysSinceActivity (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_BASE_View_hfit_ChallengeTeam_Joined_DEL_DEL') 
 CREATE CLUSTERED INDEX IHash_BASE_View_hfit_ChallengeTeam_Joined_DEL_DEL ON dbo.BASE_View_hfit_ChallengeTeam_Joined_DEL_DEL (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'PI_OrphanUserIds') 
 CREATE  UNIQUE NONCLUSTERED INDEX PI_OrphanUserIds ON dbo.OrphanUserIds (  DBNAME ASC  , TableName ASC  , UserID ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_HFit_RewardTriggerTobaccoParameter_Joined') 
 CREATE CLUSTERED INDEX IHash_View_HFit_RewardTriggerTobaccoParameter_Joined ON dbo.BASE_View_HFit_RewardTriggerTobaccoParameter_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'SKey_view_EDW_CoachingPPTAvailable') 
 CREATE NONCLUSTERED INDEX SKey_view_EDW_CoachingPPTAvailable ON dbo.BASE_view_EDW_CoachingPPTAvailable (  SurrogateKey_view_EDW_CoachingPPTAvailable ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'PI_EDW_HealthAssesmentClientView') 
 CREATE CLUSTERED INDEX PI_EDW_HealthAssesmentClientView ON dbo.DIM_EDW_HealthAssesmentClientView (  AccountID ASC  , AccountCD ASC  , AccountName ASC  , ClientGuid ASC  , SiteGUID ASC  , NodeSiteID ASC  , CampaignNodeGuid ASC  , HACampaignID ASC  , CodeName ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'PI_EDW_HealthAssesmentClientView_RowNbrCDate') 
 CREATE NONCLUSTERED INDEX PI_EDW_HealthAssesmentClientView_RowNbrCDate ON dbo.DIM_EDW_HealthAssesmentClientView (  RowNbr ASC  , LastModifiedDate ASC  , DeletedFlg ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_view_hfit_CoachingReadyForNotification') 
 CREATE CLUSTERED INDEX IHash_view_hfit_CoachingReadyForNotification ON dbo.BASE_view_hfit_CoachingReadyForNotification (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'PI_EDW_HealthAssessment_NATKEY') 
 CREATE CLUSTERED INDEX PI_EDW_HealthAssessment_NATKEY ON dbo.DIM_EDW_HealthAssessment (  USERSTARTEDITEMID ASC  , USERGUID ASC  , PKHASHCODE ASC  , HASHCODE ASC  , DELETEDFLG ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'PI_EDW_HealthAssessment_Dates') 
 CREATE NONCLUSTERED INDEX PI_EDW_HealthAssessment_Dates ON dbo.DIM_EDW_HealthAssessment (  ITEMCREATEDWHEN ASC  , ITEMMODIFIEDWHEN ASC  , HARISKCATEGORY_ITEMMODIFIEDWHEN ASC  , HAUSERRISKAREA_ITEMMODIFIEDWHEN ASC  , HAUSERQUESTION_ITEMMODIFIEDWHEN ASC  , HAUSERANSWERS_ITEMMODIFIEDWHEN ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_BASE_HFit_TrackerSugaryDrinks') 
 CREATE NONCLUSTERED INDEX CI_BASE_HFit_TrackerSugaryDrinks ON dbo.BASE_HFit_TrackerSugaryDrinks (  SVR ASC  , DBNAME ASC  , ItemID ASC  )   INCLUDE ( HashCode , LASTMODIFIEDDATE )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'cmsUser_SugaryDrinks') 
 CREATE NONCLUSTERED INDEX cmsUser_SugaryDrinks ON dbo.BASE_HFit_TrackerSugaryDrinks (  UserID ASC  )   INCLUDE ( DBNAME )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_view_EDW_HAassessment') 
 CREATE CLUSTERED INDEX IHash_view_EDW_HAassessment ON dbo.BASE_view_EDW_HAassessment (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_view_EDW_CoachingPPTEligible') 
 CREATE CLUSTERED INDEX IHash_view_EDW_CoachingPPTEligible ON dbo.BASE_view_EDW_CoachingPPTEligible (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'SKey_view_EDW_CoachingPPTEligible') 
 CREATE NONCLUSTERED INDEX SKey_view_EDW_CoachingPPTEligible ON dbo.BASE_view_EDW_CoachingPPTEligible (  SurrogateKey_view_EDW_CoachingPPTEligible ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_DBPK_Chat_User') 
 CREATE NONCLUSTERED INDEX CI_DBPK_Chat_User ON dbo.BASE_Chat_User (  ChatUserID ASC  )   INCLUDE ( DBNAME )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_BASE_hfit_PPTEligibility') 
 CREATE NONCLUSTERED INDEX CI_BASE_hfit_PPTEligibility ON dbo.BASE_hfit_PPTEligibility (  SVR ASC  , DBNAME ASC  , PPTID ASC  )   INCLUDE ( HashCode , LASTMODIFIEDDATE )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'PI00_BASE_hfit_PPTEligibility') 
 CREATE NONCLUSTERED INDEX PI00_BASE_hfit_PPTEligibility ON dbo.BASE_hfit_PPTEligibility (  DBNAME ASC  , SVR ASC  , UserID ASC  )   INCLUDE ( BenefitGrp , BenefitStatus , BirthDate , City , ClientCMElig , ClientHRAElig , ClientIncentiveElig , ClientLMElig , ClientPlatformElig , ClientScreeningElig , Company , CompanyCd , CoverageType , DepartmentCd , DepartmentName , Division , EmployeeStatus , EmployeeType , FirstName , Gender , HireDate , JobCd , JobTitle , LastName , LocationCd , LocationName , MaritalStatus , MiddleInit , PayCd , PayGrp , PersonStatus , PersonType , PlanEndDate , PlanName , PlanStartDate , PlanType , PostalCode , PPTID , State , TeamName , UnionCd )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_CONTENT_MenuItem_Joined') 
 CREATE CLUSTERED INDEX IHash_View_CONTENT_MenuItem_Joined ON dbo.BASE_View_CONTENT_MenuItem_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_CONTENT_ImageGallery_Joined') 
 CREATE CLUSTERED INDEX IHash_View_CONTENT_ImageGallery_Joined ON dbo.BASE_View_CONTENT_ImageGallery_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_HFit_CoachingEvalHARiskArea') 
 CREATE CLUSTERED INDEX IHash_HFit_CoachingEvalHARiskArea ON dbo.BASE_HFit_CoachingEvalHARiskArea (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_HFit_HACampaign_Joined') 
 CREATE CLUSTERED INDEX IHash_View_HFit_HACampaign_Joined ON dbo.BASE_View_HFit_HACampaign_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_HFit_CoachingAuditLog') 
 CREATE CLUSTERED INDEX IHash_HFit_CoachingAuditLog ON dbo.BASE_HFit_CoachingAuditLog (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'PI_EDW_HealthInterestDetail_RowNbrCDate') 
 CREATE NONCLUSTERED INDEX PI_EDW_HealthInterestDetail_RowNbrCDate ON dbo.DIM_EDW_HealthInterestDetail (  LastModifiedDate ASC  , DeletedFlg ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_view_EDW_RewardUserDetail') 
 CREATE CLUSTERED INDEX IHash_view_EDW_RewardUserDetail ON dbo.BASE_view_EDW_RewardUserDetail (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_view_EDW_RewardAwardDetail') 
 CREATE CLUSTERED INDEX IHash_view_EDW_RewardAwardDetail ON dbo.BASE_view_EDW_RewardAwardDetail (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'PI_EDW_RewardAwardDetail_IDs') 
 CREATE CLUSTERED INDEX PI_EDW_RewardAwardDetail_IDs ON dbo.DIM_EDW_RewardAwardDetail (  UserGUID ASC  , SiteGUID ASC  , HFitUserMpiNumber ASC  , RewardLevelGUID ASC  , AwardType ASC  , AwardDisplayName ASC  , RewardValue ASC  , ThresholdNumber ASC  , UserNotified ASC  , IsFulfilled ASC  , AccountID ASC  , AccountCD ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_BASE_HFit_HealthAssesmentUserStarted') 
 CREATE NONCLUSTERED INDEX CI_BASE_HFit_HealthAssesmentUserStarted ON dbo.BASE_HFit_HealthAssesmentUserStarted (  SVR ASC  , DBNAME ASC  , ItemID ASC  )   INCLUDE ( HashCode , LASTMODIFIEDDATE )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'PI_BASE_HFit_HealthAssesmentUserStarted00') 
 CREATE NONCLUSTERED INDEX PI_BASE_HFit_HealthAssesmentUserStarted00 ON dbo.BASE_HFit_HealthAssesmentUserStarted (  HACampaignNodeGUID ASC  , SVR ASC  , DBNAME ASC  )   INCLUDE ( ItemID , UserID )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_hFit_ChallengePPTEligiblePostTemplate_Joined') 
 CREATE CLUSTERED INDEX IHash_View_hFit_ChallengePPTEligiblePostTemplate_Joined ON dbo.BASE_View_hFit_ChallengePPTEligiblePostTemplate_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_CMS_Relationship_Joined') 
 CREATE CLUSTERED INDEX IHash_View_CMS_Relationship_Joined ON dbo.BASE_View_CMS_Relationship_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'PI_EDW_RewardTriggerParameters_IDs') 
 CREATE CLUSTERED INDEX PI_EDW_RewardTriggerParameters_IDs ON dbo.DIM_EDW_RewardTriggerParameters (  SiteGUID ASC  , RewardTriggerID ASC  , ParameterDisplayName ASC  , RewardTriggerParameterOperator ASC  , Value ASC  , AccountID ASC  , AccountCD ASC  , DocumentGuid ASC  , NodeGuid ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_DBPK_CMS_CssStylesheetSite') 
 CREATE NONCLUSTERED INDEX CI_DBPK_CMS_CssStylesheetSite ON dbo.BASE_CMS_CssStylesheetSite (  SiteID ASC  , StylesheetID ASC  )   INCLUDE ( DBNAME )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_CONTENT_SimpleArticle_Joined') 
 CREATE CLUSTERED INDEX IHash_View_CONTENT_SimpleArticle_Joined ON dbo.BASE_View_CONTENT_SimpleArticle_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'GUID_BASE_HFit_HealthAssesmentUserAnswers_HA_LastPullDate') 
 CREATE NONCLUSTERED INDEX GUID_BASE_HFit_HealthAssesmentUserAnswers_HA_LastPullDate ON dbo.BASE_HFit_HealthAssesmentUserAnswers_HA_LastPullDate (  RowGUID DESC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_HFit_HealthAssessment_Joined') 
 CREATE CLUSTERED INDEX IHash_View_HFit_HealthAssessment_Joined ON dbo.View_HFit_HealthAssessment_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'PI_EDW_RewardUserLevel_IDs') 
 CREATE CLUSTERED INDEX PI_EDW_RewardUserLevel_IDs ON dbo.DIM_EDW_RewardUserLevel (  UserId ASC  , LevelCompletedDt ASC  , LevelName ASC  , SiteName ASC  , nodeguid ASC  , SiteGuid ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_DBPK_CMS_Tag') 
 CREATE NONCLUSTERED INDEX CI_DBPK_CMS_Tag ON dbo.BASE_CMS_Tag (  TagID ASC  )   INCLUDE ( DBNAME )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_HFit_PrivacyPolicy_Joined') 
 CREATE CLUSTERED INDEX IHash_View_HFit_PrivacyPolicy_Joined ON dbo.BASE_View_HFit_PrivacyPolicy_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'PI_EDW_SmallSteps') 
 CREATE CLUSTERED INDEX PI_EDW_SmallSteps ON dbo.DIM_EDW_SmallSteps (  AccountCD ASC  , SiteGUID ASC  , SSItemID ASC  , SSItemGUID ASC  , SSHealthAssesmentUserStartedItemID ASC  , SSOutcomeMessageGuid ASC  , HFitUserMPINumber ASC  , HACampaignNodeGUID ASC  , HAStartedMode ASC  , HACompletedMode ASC  , HaCodeName ASC  , HACampaignStartDate ASC  , HACampaignEndDate ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_view_EDW_RewardUserLevel') 
 CREATE CLUSTERED INDEX IHash_view_EDW_RewardUserLevel ON dbo.BASE_view_EDW_RewardUserLevel (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_HFit_HealthAssesmentModule_Joined') 
 CREATE CLUSTERED INDEX IHash_View_HFit_HealthAssesmentModule_Joined ON dbo.BASE_View_HFit_HealthAssesmentModule_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_view_EDW_BiometricViewRejectCriteria') 
 CREATE CLUSTERED INDEX IHash_view_EDW_BiometricViewRejectCriteria ON dbo.BASE_view_EDW_BiometricViewRejectCriteria (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_BASE_HFit_HealthAssesmentUserModule') 
 CREATE NONCLUSTERED INDEX CI_BASE_HFit_HealthAssesmentUserModule ON dbo.BASE_HFit_HealthAssesmentUserModule (  SVR ASC  , DBNAME ASC  , ItemID ASC  )   INCLUDE ( HashCode , LASTMODIFIEDDATE )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_DBPK_CMS_FormRole') 
 CREATE NONCLUSTERED INDEX CI_DBPK_CMS_FormRole ON dbo.BASE_CMS_FormRole (  FormID ASC  , RoleID ASC  )   INCLUDE ( DBNAME )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_OM_Account_MembershipJoined') 
 CREATE CLUSTERED INDEX IHash_View_OM_Account_MembershipJoined ON dbo.BASE_View_OM_Account_MembershipJoined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_HFit_PostHealthEducation_Joined') 
 CREATE CLUSTERED INDEX IHash_View_HFit_PostHealthEducation_Joined ON dbo.BASE_View_HFit_PostHealthEducation_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_HFit_ConsentAndRelease_Joined') 
 CREATE CLUSTERED INDEX IHash_View_HFit_ConsentAndRelease_Joined ON dbo.BASE_View_HFit_ConsentAndRelease_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_BASE_View_HFit_RewardsAboutInfoItem_Joined_DEL_DEL') 
 CREATE CLUSTERED INDEX IHash_BASE_View_HFit_RewardsAboutInfoItem_Joined_DEL_DEL ON dbo.BASE_View_HFit_RewardsAboutInfoItem_Joined_DEL_DEL (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'PKI_EDW_BiometricViewRejectCriteria') 
 CREATE  UNIQUE CLUSTERED INDEX PKI_EDW_BiometricViewRejectCriteria ON dbo.EDW_BiometricViewRejectCriteria (  AccountCD ASC  , ItemCreatedWhen ASC  , SiteID ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_OM_ContactGroupMember_User_ContactJoined') 
 CREATE CLUSTERED INDEX IHash_View_OM_ContactGroupMember_User_ContactJoined ON dbo.BASE_View_OM_ContactGroupMember_User_ContactJoined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_HFit_CoachingLibraryResource') 
 CREATE CLUSTERED INDEX IHash_HFit_CoachingLibraryResource ON dbo.BASE_HFit_CoachingLibraryResource (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_BASE_HFit_LKP_RewardTrigger') 
 CREATE NONCLUSTERED INDEX CI_BASE_HFit_LKP_RewardTrigger ON dbo.BASE_HFit_LKP_RewardTrigger (  SVR ASC  , DBNAME ASC  , RewardTriggerLKPID ASC  )   INCLUDE ( HashCode , LASTMODIFIEDDATE )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_BASE_HFit_TrackerWeight') 
 CREATE NONCLUSTERED INDEX CI_BASE_HFit_TrackerWeight ON dbo.BASE_HFit_TrackerWeight (  SVR ASC  , DBNAME ASC  , ItemID ASC  )   INCLUDE ( HashCode , LASTMODIFIEDDATE )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'UK00_BASE_HFit_TrackerWeight') 
 CREATE  UNIQUE NONCLUSTERED INDEX UK00_BASE_HFit_TrackerWeight ON dbo.BASE_HFit_TrackerWeight (  SurrogateKey_HFit_TrackerWeight ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_BASE_HFit_TrackerShots') 
 CREATE NONCLUSTERED INDEX CI_BASE_HFit_TrackerShots ON dbo.BASE_HFit_TrackerShots (  SVR ASC  , DBNAME ASC  , ItemID ASC  )   INCLUDE ( HashCode , LASTMODIFIEDDATE )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'UK00_BASE_HFit_TrackerShots') 
 CREATE  UNIQUE NONCLUSTERED INDEX UK00_BASE_HFit_TrackerShots ON dbo.BASE_HFit_TrackerShots (  SurrogateKey_HFit_TrackerShots ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_CMS_Tree_Joined_Versions_Attachments') 
 CREATE CLUSTERED INDEX IHash_View_CMS_Tree_Joined_Versions_Attachments ON dbo.BASE_View_CMS_Tree_Joined_Versions_Attachments (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IDX_DBNAME_SurrogateKey_CMS_user') 
 CREATE NONCLUSTERED INDEX IDX_DBNAME_SurrogateKey_CMS_user ON dbo.FACT_TrackerData (  TrackerName ASC  )   INCLUDE ( DBNAME , SurrogateKey_CMS_user )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IDX_DBNAME_SurrogateKey_HFIT_Tracker') 
 CREATE NONCLUSTERED INDEX IDX_DBNAME_SurrogateKey_HFIT_Tracker ON dbo.FACT_TrackerData (  TrackerName ASC  )   INCLUDE ( DBNAME , SurrogateKey_HFIT_Tracker )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IDX_DBNAME_SurrogateKey_HFit_TrackerBloodSugarAndGlucose') 
 CREATE NONCLUSTERED INDEX IDX_DBNAME_SurrogateKey_HFit_TrackerBloodSugarAndGlucose ON dbo.FACT_TrackerData (  TrackerName ASC  )   INCLUDE ( DBNAME , SurrogateKey_HFit_TrackerBloodSugarAndGlucose )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IDX_DBNAME_SurrogateKey_HFit_TrackerBMI') 
 CREATE NONCLUSTERED INDEX IDX_DBNAME_SurrogateKey_HFit_TrackerBMI ON dbo.FACT_TrackerData (  TrackerName ASC  )   INCLUDE ( DBNAME , SurrogateKey_HFit_TrackerBMI )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IDX_DBNAME_SurrogateKey_HFit_TrackerCardio') 
 CREATE NONCLUSTERED INDEX IDX_DBNAME_SurrogateKey_HFit_TrackerCardio ON dbo.FACT_TrackerData (  TrackerName ASC  )   INCLUDE ( DBNAME , SurrogateKey_HFit_TrackerCardio )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IDX_DBNAME_SurrogateKey_HFit_TrackerCotinine') 
 CREATE NONCLUSTERED INDEX IDX_DBNAME_SurrogateKey_HFit_TrackerCotinine ON dbo.FACT_TrackerData (  TrackerName ASC  )   INCLUDE ( DBNAME , SurrogateKey_HFit_TrackerCotinine )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IDX_DBNAME_SurrogateKey_HFit_TrackerDailySteps') 
 CREATE NONCLUSTERED INDEX IDX_DBNAME_SurrogateKey_HFit_TrackerDailySteps ON dbo.FACT_TrackerData (  TrackerName ASC  )   INCLUDE ( DBNAME , SurrogateKey_HFit_TrackerDailySteps )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IDX_DBNAME_SurrogateKey_HFit_TrackerFlexibility') 
 CREATE NONCLUSTERED INDEX IDX_DBNAME_SurrogateKey_HFit_TrackerFlexibility ON dbo.FACT_TrackerData (  TrackerName ASC  )   INCLUDE ( DBNAME , SurrogateKey_HFit_TrackerFlexibility )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IDX_DBNAME_SurrogateKey_HFit_TrackerFruits') 
 CREATE NONCLUSTERED INDEX IDX_DBNAME_SurrogateKey_HFit_TrackerFruits ON dbo.FACT_TrackerData (  TrackerName ASC  )   INCLUDE ( DBNAME , SurrogateKey_HFit_TrackerFruits )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IDX_DBNAME_SurrogateKey_HFit_TrackerHighFatFoods') 
 CREATE NONCLUSTERED INDEX IDX_DBNAME_SurrogateKey_HFit_TrackerHighFatFoods ON dbo.FACT_TrackerData (  TrackerName ASC  )   INCLUDE ( DBNAME , SurrogateKey_HFit_TrackerHighFatFoods )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IDX_DBNAME_SurrogateKey_HFit_TrackerMealPortions') 
 CREATE NONCLUSTERED INDEX IDX_DBNAME_SurrogateKey_HFit_TrackerMealPortions ON dbo.FACT_TrackerData (  TrackerName ASC  )   INCLUDE ( DBNAME , SurrogateKey_HFit_TrackerMealPortions )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IDX_DBNAME_SurrogateKey_HFit_TrackerRegularMeals') 
 CREATE NONCLUSTERED INDEX IDX_DBNAME_SurrogateKey_HFit_TrackerRegularMeals ON dbo.FACT_TrackerData (  TrackerName ASC  )   INCLUDE ( DBNAME , SurrogateKey_HFit_TrackerRegularMeals )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IDX_DBNAME_SurrogateKey_HFit_TrackerRestingHeartRate') 
 CREATE NONCLUSTERED INDEX IDX_DBNAME_SurrogateKey_HFit_TrackerRestingHeartRate ON dbo.FACT_TrackerData (  TrackerName ASC  )   INCLUDE ( DBNAME , SurrogateKey_HFit_TrackerRestingHeartRate )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IDX_DBNAME_SurrogateKey_HFit_TrackerSitLess') 
 CREATE NONCLUSTERED INDEX IDX_DBNAME_SurrogateKey_HFit_TrackerSitLess ON dbo.FACT_TrackerData (  TrackerName ASC  )   INCLUDE ( DBNAME , SurrogateKey_HFit_TrackerSitLess )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IDX_DBNAME_SurrogateKey_HFit_TrackerSleepPlan') 
 CREATE NONCLUSTERED INDEX IDX_DBNAME_SurrogateKey_HFit_TrackerSleepPlan ON dbo.FACT_TrackerData (  TrackerName ASC  )   INCLUDE ( DBNAME , SurrogateKey_HFit_TrackerSleepPlan )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IDX_DBNAME_SurrogateKey_HFit_TrackerStressManagement') 
 CREATE NONCLUSTERED INDEX IDX_DBNAME_SurrogateKey_HFit_TrackerStressManagement ON dbo.FACT_TrackerData (  TrackerName ASC  )   INCLUDE ( DBNAME , SurrogateKey_HFit_TrackerStressManagement )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IDX_DBNAME_SurrogateKey_HFit_TrackerTests') 
 CREATE NONCLUSTERED INDEX IDX_DBNAME_SurrogateKey_HFit_TrackerTests ON dbo.FACT_TrackerData (  TrackerName ASC  )   INCLUDE ( DBNAME , SurrogateKey_HFit_TrackerTests )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IDX_DBNAME_SurrogateKey_HFit_TrackerTobaccoAttestation') 
 CREATE NONCLUSTERED INDEX IDX_DBNAME_SurrogateKey_HFit_TrackerTobaccoAttestation ON dbo.FACT_TrackerData (  TrackerName ASC  )   INCLUDE ( DBNAME , SurrogateKey_HFit_TrackerTobaccoAttestation )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IDX_DBNAME_SurrogateKey_HFit_TrackerVegetables') 
 CREATE NONCLUSTERED INDEX IDX_DBNAME_SurrogateKey_HFit_TrackerVegetables ON dbo.FACT_TrackerData (  TrackerName ASC  )   INCLUDE ( DBNAME , SurrogateKey_HFit_TrackerVegetables )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IDX_DBNAME_SurrogateKey_HFit_TrackerWater') 
 CREATE NONCLUSTERED INDEX IDX_DBNAME_SurrogateKey_HFit_TrackerWater ON dbo.FACT_TrackerData (  TrackerName ASC  )   INCLUDE ( DBNAME , SurrogateKey_HFit_TrackerWater )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_DBPK_CMS_Culture') 
 CREATE NONCLUSTERED INDEX CI_DBPK_CMS_Culture ON dbo.BASE_CMS_Culture (  CultureID ASC  )   INCLUDE ( DBNAME )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'PI_BASE_CMS_Document_NodeClassID_SVR') 
 CREATE NONCLUSTERED INDEX PI_BASE_CMS_Document_NodeClassID_SVR ON dbo.BASE_CMS_Tree (  NodeClassID ASC  , SVR ASC  )   INCLUDE ( NodeGUID , NodeLinkedNodeID , NodeSiteID )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_DBPK_CMS_Tree') 
 CREATE NONCLUSTERED INDEX CI_DBPK_CMS_Tree ON dbo.BASE_CMS_Tree (  NodeID ASC  )   INCLUDE ( DBNAME )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_DBPK_CMS_FormUserControl') 
 CREATE NONCLUSTERED INDEX CI_DBPK_CMS_FormUserControl ON dbo.BASE_CMS_FormUserControl (  UserControlID ASC  )   INCLUDE ( DBNAME )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'SKey_View_HFit_ChallengePPTRegisteredRDPostTemplate_Joined') 
 CREATE NONCLUSTERED INDEX SKey_View_HFit_ChallengePPTRegisteredRDPostTemplate_Joined ON dbo.BASE_View_HFit_ChallengePPTRegisteredRDPostTemplate_Joined (  SurrogateKey_View_HFit_ChallengePPTRegisteredRDPostTemplate_Joined ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_HFit_HealthAssessmentConfiguration_Joined') 
 CREATE CLUSTERED INDEX IHash_View_HFit_HealthAssessmentConfiguration_Joined ON dbo.BASE_View_HFit_HealthAssessmentConfiguration_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_DBPK_CMS_DocumentAlias') 
 CREATE NONCLUSTERED INDEX CI_DBPK_CMS_DocumentAlias ON dbo.BASE_CMS_DocumentAlias (  AliasID ASC  )   INCLUDE ( DBNAME )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_HFit_CoachingEvalHARiskCategory') 
 CREATE CLUSTERED INDEX IHash_HFit_CoachingEvalHARiskCategory ON dbo.BASE_HFit_CoachingEvalHARiskCategory (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_CMS_User_With_HFitCoachingSettings') 
 CREATE CLUSTERED INDEX IHash_View_CMS_User_With_HFitCoachingSettings ON dbo.BASE_View_CMS_User_With_HFitCoachingSettings (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_view_EDW_ClientCompany') 
 CREATE CLUSTERED INDEX IHash_view_EDW_ClientCompany ON dbo.BASE_view_EDW_ClientCompany (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_DBPK_CMS_PageTemplate') 
 CREATE NONCLUSTERED INDEX CI_DBPK_CMS_PageTemplate ON dbo.BASE_CMS_PageTemplate (  PageTemplateID ASC  )   INCLUDE ( DBNAME )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_HFit_ScreeningEvent_Joined') 
 CREATE CLUSTERED INDEX IHash_View_HFit_ScreeningEvent_Joined ON dbo.BASE_View_HFit_ScreeningEvent_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'PKI_Keywords') 
 CREATE CLUSTERED INDEX PKI_Keywords ON dbo.keywords (  kw ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_DBPK_CMS_VersionHistory') 
 CREATE NONCLUSTERED INDEX CI_DBPK_CMS_VersionHistory ON dbo.BASE_CMS_VersionHistory (  VersionHistoryID ASC  )   INCLUDE ( DBNAME )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_HFit_RewardLevel_Joined') 
 CREATE CLUSTERED INDEX IHash_View_HFit_RewardLevel_Joined ON dbo.BASE_View_HFit_RewardLevel_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_CONTENT_BlogMonth_Joined') 
 CREATE CLUSTERED INDEX IHash_View_CONTENT_BlogMonth_Joined ON dbo.BASE_View_CONTENT_BlogMonth_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_TEMPEdwHAHashkeys') 
 CREATE CLUSTERED INDEX CI_TEMPEdwHAHashkeys ON dbo.LKUP_UpdatedEdwHAHashkeys (  HAUSERSTARTED_ITEMID ASC  , PKHASHCODE ASC  , HASHCODE ASC  , USERGUID ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_HFit_CoachingEnrollmentSettings_Joined') 
 CREATE CLUSTERED INDEX IHash_View_HFit_CoachingEnrollmentSettings_Joined ON dbo.BASE_View_HFit_CoachingEnrollmentSettings_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'UK00_BASE_HFit_TrackerBodyMeasurements') 
 CREATE  UNIQUE NONCLUSTERED INDEX UK00_BASE_HFit_TrackerBodyMeasurements ON dbo.BASE_HFit_TrackerBodyMeasurements (  SurrogateKey_HFit_TrackerBodyMeasurements ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_HFit_SsoRequestAttributes_Joined') 
 CREATE CLUSTERED INDEX IHash_View_HFit_SsoRequestAttributes_Joined ON dbo.BASE_View_HFit_SsoRequestAttributes_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_DBPK_CMS_RoleUIElement') 
 CREATE NONCLUSTERED INDEX CI_DBPK_CMS_RoleUIElement ON dbo.BASE_CMS_RoleUIElement (  ElementID ASC  , RoleID ASC  )   INCLUDE ( DBNAME )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_view_EDW_CoachingPPTAvailable') 
 CREATE CLUSTERED INDEX IHash_view_EDW_CoachingPPTAvailable ON dbo.view_EDW_CoachingPPTAvailable (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_DBPK_CMS_ACLItem') 
 CREATE NONCLUSTERED INDEX CI_DBPK_CMS_ACLItem ON dbo.BASE_CMS_ACLItem (  ACLItemID ASC  )   INCLUDE ( DBNAME )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_HFit_HSLearnMoreDocument_Joined') 
 CREATE CLUSTERED INDEX IHash_View_HFit_HSLearnMoreDocument_Joined ON dbo.BASE_View_HFit_HSLearnMoreDocument_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_HFit_ChallengeRegistrationEmail_Joined') 
 CREATE CLUSTERED INDEX IHash_View_HFit_ChallengeRegistrationEmail_Joined ON dbo.BASE_View_HFit_ChallengeRegistrationEmail_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_HFit_RewardTriggerParameter_Joined') 
 CREATE CLUSTERED INDEX IHash_View_HFit_RewardTriggerParameter_Joined ON dbo.BASE_View_HFit_RewardTriggerParameter_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = '_dta_index_BASE_CMS_MembershipRole_8_1252199511__K2_K9_K1_6_10_11_8066') 
 CREATE NONCLUSTERED INDEX _dta_index_BASE_CMS_MembershipRole_8_1252199511__K2_K9_K1_6_10_11_8066 ON dbo.BASE_CMS_MembershipRole (  RoleID ASC  , DBNAME ASC  , MembershipID ASC  )   INCLUDE ( CT_MembershipID , CT_RoleID , LASTMODIFIEDDATE )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = '_dta_index_BASE_CMS_MembershipRole_8_1252199511__K1_K2_K9_6_10_11') 
 CREATE NONCLUSTERED INDEX _dta_index_BASE_CMS_MembershipRole_8_1252199511__K1_K2_K9_6_10_11 ON dbo.BASE_CMS_MembershipRole (  MembershipID ASC  , RoleID ASC  , DBNAME ASC  )   INCLUDE ( CT_MembershipID , CT_RoleID , LASTMODIFIEDDATE )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'PKI_MART_CT_Test_History') 
 CREATE  UNIQUE CLUSTERED INDEX PKI_MART_CT_Test_History ON dbo.MART_CT_Test_History (  TblName ASC  , RowID ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_HFit_CoachingEvalHARiskModule_Joined') 
 CREATE CLUSTERED INDEX IHash_View_HFit_CoachingEvalHARiskModule_Joined ON dbo.BASE_View_HFit_CoachingEvalHARiskModule_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_HFit_Goal_Joined') 
 CREATE CLUSTERED INDEX IHash_View_HFit_Goal_Joined ON dbo.BASE_View_HFit_Goal_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IX_TEMP_CoachingHealthInterest_UserID') 
 CREATE NONCLUSTERED INDEX IX_TEMP_CoachingHealthInterest_UserID ON dbo.TEMP_CoachingHealthInterest (  UserID ASC  , DBNAME ASC  )   INCLUDE ( HealthInterestCategoryName , HealthInterestSelectionName , ItemCreatedWhen , RowNum )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_CMS_EventLog') 
 CREATE CLUSTERED INDEX IHash_View_CMS_EventLog ON dbo.BASE_View_CMS_EventLog (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'SKey_View_CMS_EventLog') 
 CREATE NONCLUSTERED INDEX SKey_View_CMS_EventLog ON dbo.BASE_View_CMS_EventLog (  SurrogateKey_View_CMS_EventLog ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'UI_MART_Job_History') 
 CREATE  UNIQUE NONCLUSTERED INDEX UI_MART_Job_History ON dbo.MART_Job_Execution_History (  job_id ASC  , step_id ASC  , date_created ASC  , date_modified ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_NewsletterSubscriberUserRole_Joined') 
 CREATE CLUSTERED INDEX IHash_View_NewsletterSubscriberUserRole_Joined ON dbo.BASE_View_NewsletterSubscriberUserRole_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_BASE_View_CMS_EventLog_DEL') 
 CREATE CLUSTERED INDEX IHash_BASE_View_CMS_EventLog_DEL ON dbo.BASE_View_CMS_EventLog_DEL (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'GUID_BASE_HFit_HealthAssesmentUserModule_HA_LastPullDate') 
 CREATE NONCLUSTERED INDEX GUID_BASE_HFit_HealthAssesmentUserModule_HA_LastPullDate ON dbo.BASE_HFit_HealthAssesmentUserModule_HA_LastPullDate (  RowGUID DESC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_DBPK_CMS_Badge') 
 CREATE NONCLUSTERED INDEX CI_DBPK_CMS_Badge ON dbo.BASE_CMS_Badge (  BadgeID ASC  )   INCLUDE ( DBNAME )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CG_IX_BASE_View_HFit_CoachingHealthAre_8_1322044787__K54_5_39_178') 
 CREATE NONCLUSTERED INDEX CG_IX_BASE_View_HFit_CoachingHealthAre_8_1322044787__K54_5_39_178 ON dbo.BASE_View_HFit_CoachingHealthArea_Joined (  DocumentCulture ASC  )   INCLUDE ( DBNAME , DocumentName , NodeID )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_OM_ContactGroupMember_AccountJoined') 
 CREATE CLUSTERED INDEX IHash_View_OM_ContactGroupMember_AccountJoined ON dbo.BASE_View_OM_ContactGroupMember_AccountJoined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_BASE_HFit_HealthAssesmentRiskCategory') 
 CREATE NONCLUSTERED INDEX CI_BASE_HFit_HealthAssesmentRiskCategory ON dbo.BASE_HFit_HealthAssesmentRiskCategory (  SVR ASC  , DBNAME ASC  , HealthAssesmentRiskCategoryID ASC  )   INCLUDE ( HashCode , LASTMODIFIEDDATE )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_BASE_HFit_TrackerDef_Tracker') 
 CREATE NONCLUSTERED INDEX CI_BASE_HFit_TrackerDef_Tracker ON dbo.BASE_HFit_TrackerDef_Tracker (  SVR ASC  , DBNAME ASC  , TrackerID ASC  )   INCLUDE ( HashCode , LASTMODIFIEDDATE )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_HFit_SmallSteps_Joined') 
 CREATE CLUSTERED INDEX IHash_View_HFit_SmallSteps_Joined ON dbo.BASE_View_HFit_SmallSteps_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_view_EDW_RewardTriggerParameters') 
 CREATE CLUSTERED INDEX IHash_view_EDW_RewardTriggerParameters ON dbo.BASE_view_EDW_RewardTriggerParameters (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = '_dta_index_BASE_OM_ContactGroup_8_1352495997__K17_K10_1_2_14') 
 CREATE NONCLUSTERED INDEX _dta_index_BASE_OM_ContactGroup_8_1352495997__K17_K10_1_2_14 ON dbo.BASE_OM_ContactGroup (  DBNAME ASC  , ContactGroupID ASC  )   INCLUDE ( ContactGroupDisplayName , ContactGroupName , LASTMODIFIEDDATE )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_HFit_CoachingLMTemporalContainer_Joined') 
 CREATE CLUSTERED INDEX IHash_View_HFit_CoachingLMTemporalContainer_Joined ON dbo.BASE_View_HFit_CoachingLMTemporalContainer_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'SKey_view_EDW_CoachingPPTEnrolled') 
 CREATE NONCLUSTERED INDEX SKey_view_EDW_CoachingPPTEnrolled ON dbo.BASE_view_EDW_CoachingPPTEnrolled (  SurrogateKey_view_EDW_CoachingPPTEnrolled ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI05_BASE_HFit_HealthAssesmentUserQuestion') 
 CREATE NONCLUSTERED INDEX CI05_BASE_HFit_HealthAssesmentUserQuestion ON dbo.BASE_HFit_HealthAssesmentUserQuestion (  HARiskAreaItemID ASC  , SVR ASC  , DBNAME ASC  )   INCLUDE ( CodeName , HAQuestionNodeGUID , HAQuestionScore , IsProfessionallyCollected , ItemID , ItemModifiedWhen , PreWeightedScore )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_hfit_TemporalConfigurationContainer_Joined') 
 CREATE CLUSTERED INDEX IHash_View_hfit_TemporalConfigurationContainer_Joined ON dbo.BASE_View_hfit_TemporalConfigurationContainer_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_HFit_CoachingEvalHARiskModule') 
 CREATE CLUSTERED INDEX IHash_HFit_CoachingEvalHARiskModule ON dbo.BASE_HFit_CoachingEvalHARiskModule (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_HFit_CoachingEnrollment') 
 CREATE CLUSTERED INDEX IHash_View_HFit_CoachingEnrollment ON dbo.BASE_View_HFit_CoachingEnrollment (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'PI_MART_SYNC_Table_FKRels') 
 CREATE  UNIQUE CLUSTERED INDEX PI_MART_SYNC_Table_FKRels ON dbo.MART_SYNC_Table_FKRels (  ParentTable ASC  , ParentSurrogateKeyName ASC  , ChildTable ASC  , ParentColumn ASC  , ChildColumn ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = '_dta_index_BASE_CMS_MembershipUser_8_1412200081__K2_K17_K16_K1_3') 
 CREATE NONCLUSTERED INDEX _dta_index_BASE_CMS_MembershipUser_8_1412200081__K2_K17_K16_K1_3 ON dbo.BASE_CMS_MembershipUser (  UserID ASC  , CT_ValidTo ASC  , CT_UserID ASC  , MembershipID ASC  )   INCLUDE ( ValidTo )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_BASE_HFit_RewardException') 
 CREATE NONCLUSTERED INDEX CI_BASE_HFit_RewardException ON dbo.BASE_HFit_RewardException (  SVR ASC  , DBNAME ASC  , RewardExceptionID ASC  )   INCLUDE ( HashCode , LASTMODIFIEDDATE )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_HFit_ChallengeNewsletter_Joined') 
 CREATE CLUSTERED INDEX IHash_View_HFit_ChallengeNewsletter_Joined ON dbo.BASE_View_HFit_ChallengeNewsletter_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_CONTENT_Product_Joined') 
 CREATE CLUSTERED INDEX IHash_View_CONTENT_Product_Joined ON dbo.BASE_View_CONTENT_Product_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_hfit_WellnessGoalPostTemplate_Joined') 
 CREATE CLUSTERED INDEX IHash_View_hfit_WellnessGoalPostTemplate_Joined ON dbo.BASE_View_hfit_WellnessGoalPostTemplate_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'UK00_BASE_HFit_TrackerSummary') 
 CREATE  UNIQUE NONCLUSTERED INDEX UK00_BASE_HFit_TrackerSummary ON dbo.BASE_HFit_TrackerSummary (  SurrogateKey_HFit_TrackerSummary ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_BASE_HFit_TrackerSitLess') 
 CREATE NONCLUSTERED INDEX CI_BASE_HFit_TrackerSitLess ON dbo.BASE_HFit_TrackerSitLess (  SVR ASC  , DBNAME ASC  , ItemID ASC  )   INCLUDE ( HashCode , LASTMODIFIEDDATE )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'SKey_BASE_View_CMS_Tree_Joined_DEL') 
 CREATE NONCLUSTERED INDEX SKey_BASE_View_CMS_Tree_Joined_DEL ON dbo.BASE_View_CMS_Tree_Joined_DEL (  SurrogateKey_BASE_View_CMS_Tree_Joined_DEL ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_DBPK_CMS_SettingsKey') 
 CREATE NONCLUSTERED INDEX CI_DBPK_CMS_SettingsKey ON dbo.BASE_CMS_SettingsKey (  KeyID ASC  )   INCLUDE ( DBNAME )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_HFit_PostReminder_Joined') 
 CREATE CLUSTERED INDEX IHash_View_HFit_PostReminder_Joined ON dbo.BASE_View_HFit_PostReminder_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_OM_Account_Joined') 
 CREATE CLUSTERED INDEX IHash_View_OM_Account_Joined ON dbo.BASE_View_OM_Account_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_HFit_CoachingLibrarySettings') 
 CREATE CLUSTERED INDEX IHash_HFit_CoachingLibrarySettings ON dbo.BASE_HFit_CoachingLibrarySettings (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_HFit_RewardParameter_Joined') 
 CREATE CLUSTERED INDEX IHash_View_HFit_RewardParameter_Joined ON dbo.BASE_View_HFit_RewardParameter_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_HFit_RewardParameterBase_Joined') 
 CREATE CLUSTERED INDEX IHash_View_HFit_RewardParameterBase_Joined ON dbo.BASE_View_HFit_RewardParameterBase_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_view_EDW_BioMetrics') 
 CREATE CLUSTERED INDEX IHash_view_EDW_BioMetrics ON dbo.BASE_view_EDW_BioMetrics (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_view_EDW_HealthAssesmentDeffinition') 
 CREATE CLUSTERED INDEX IHash_view_EDW_HealthAssesmentDeffinition ON dbo.BASE_view_EDW_HealthAssesmentDeffinition (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = '_dta_index_BASE_OM_ContactGroupMember_8_1528496624__K14_K3_K1_2_11') 
 CREATE NONCLUSTERED INDEX _dta_index_BASE_OM_ContactGroupMember_8_1528496624__K14_K3_K1_2_11 ON dbo.BASE_OM_ContactGroupMember (  DBNAME ASC  , ContactGroupMemberRelatedID ASC  , ContactGroupMemberContactGroupID ASC  )   INCLUDE ( ContactGroupMemberType , LASTMODIFIEDDATE )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_DBPK_CMS_DocumentTag') 
 CREATE NONCLUSTERED INDEX CI_DBPK_CMS_DocumentTag ON dbo.BASE_CMS_DocumentTag (  DocumentID ASC  , TagID ASC  )   INCLUDE ( DBNAME )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_BASE_Hfit_SmallStepResponses') 
 CREATE NONCLUSTERED INDEX CI_BASE_Hfit_SmallStepResponses ON dbo.BASE_Hfit_SmallStepResponses (  SVR ASC  , DBNAME ASC  , ItemID ASC  )   INCLUDE ( HashCode , LASTMODIFIEDDATE )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'PI_BASE_Hfit_SmallStepResponses') 
 CREATE NONCLUSTERED INDEX PI_BASE_Hfit_SmallStepResponses ON dbo.BASE_Hfit_SmallStepResponses (  UserID ASC  , HealthAssesmentUserStartedItemID ASC  )   INCLUDE ( ItemCreatedBy , ItemCreatedWhen , ItemGUID , ItemID , ItemModifiedBy , ItemModifiedWhen , ItemOrder , OutComeMessageGUID )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_BASE_View_HFit_CoachingTermsAndConditionsSettings_Joined') 
 CREATE CLUSTERED INDEX IHash_BASE_View_HFit_CoachingTermsAndConditionsSettings_Joined ON dbo.BASE_BASE_View_HFit_CoachingTermsAndConditionsSettings_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_DBPK_CMS_BannedIP') 
 CREATE NONCLUSTERED INDEX CI_DBPK_CMS_BannedIP ON dbo.BASE_CMS_BannedIP (  IPAddressID ASC  )   INCLUDE ( DBNAME )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_hfit_challengeBase_Joined') 
 CREATE CLUSTERED INDEX IHash_View_hfit_challengeBase_Joined ON dbo.BASE_View_hfit_challengeBase_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_HFit_RewardDefaultSettings_Joined') 
 CREATE CLUSTERED INDEX IHash_View_HFit_RewardDefaultSettings_Joined ON dbo.BASE_View_HFit_RewardDefaultSettings_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'PI_EligStartEndDate') 
 CREATE NONCLUSTERED INDEX PI_EligStartEndDate ON dbo.BASE_EDW_GroupMemberHistory (  StartedDate ASC  , EndedDate ASC  )   INCLUDE ( UserMpiNumber )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_HFIT_Configuration_Screening_Joined') 
 CREATE CLUSTERED INDEX IHash_View_HFIT_Configuration_Screening_Joined ON dbo.BASE_View_HFIT_Configuration_Screening_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_view_EDW_CoachingDetail') 
 CREATE CLUSTERED INDEX IHash_view_EDW_CoachingDetail ON dbo.BASE_view_EDW_CoachingDetail (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_HFit_HealthAssesmentQuestions') 
 CREATE CLUSTERED INDEX IHash_View_HFit_HealthAssesmentQuestions ON dbo.BASE_View_HFit_HealthAssesmentQuestions (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_view_EDW_TrackerTests') 
 CREATE CLUSTERED INDEX IHash_view_EDW_TrackerTests ON dbo.BASE_view_EDW_TrackerTests (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_HFit_RewardsAboutInfoItem_Joined') 
 CREATE CLUSTERED INDEX IHash_View_HFit_RewardsAboutInfoItem_Joined ON dbo.BASE_View_HFit_RewardsAboutInfoItem_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_CMS_Tree_Joined') 
 CREATE CLUSTERED INDEX IHash_View_CMS_Tree_Joined ON dbo.BASE_View_CMS_Tree_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_CMS_Tree_Joined_Versions') 
 CREATE CLUSTERED INDEX IHash_View_CMS_Tree_Joined_Versions ON dbo.BASE_View_CMS_Tree_Joined_Versions (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_DBPK_CMS_DeviceProfileLayout') 
 CREATE NONCLUSTERED INDEX CI_DBPK_CMS_DeviceProfileLayout ON dbo.BASE_CMS_DeviceProfileLayout (  DeviceProfileLayoutID ASC  )   INCLUDE ( DBNAME )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_HFit_Coach_Bio') 
 CREATE CLUSTERED INDEX IHash_View_HFit_Coach_Bio ON dbo.BASE_View_HFit_Coach_Bio (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_HFit_CoachingGetStarted') 
 CREATE CLUSTERED INDEX IHash_HFit_CoachingGetStarted ON dbo.BASE_HFit_CoachingGetStarted (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_DBPK_CMS_WebFarmServer') 
 CREATE NONCLUSTERED INDEX CI_DBPK_CMS_WebFarmServer ON dbo.BASE_CMS_WebFarmServer (  ServerID ASC  )   INCLUDE ( DBNAME )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_DBPK_CMS_UIElement') 
 CREATE NONCLUSTERED INDEX CI_DBPK_CMS_UIElement ON dbo.BASE_CMS_UIElement (  ElementID ASC  )   INCLUDE ( DBNAME )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_HFit_Event_Joined') 
 CREATE CLUSTERED INDEX IHash_View_HFit_Event_Joined ON dbo.BASE_View_HFit_Event_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_HFit_ScheduledNotification_Joined') 
 CREATE CLUSTERED INDEX IHash_View_HFit_ScheduledNotification_Joined ON dbo.BASE_View_HFit_ScheduledNotification_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_DBPK_CMS_DocumentTypeScope') 
 CREATE NONCLUSTERED INDEX CI_DBPK_CMS_DocumentTypeScope ON dbo.BASE_CMS_DocumentTypeScope (  ScopeID ASC  )   INCLUDE ( DBNAME )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_HFit_CoachingNotAssignedSettings_Joined') 
 CREATE CLUSTERED INDEX IHash_View_HFit_CoachingNotAssignedSettings_Joined ON dbo.BASE_View_HFit_CoachingNotAssignedSettings_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_HFit_CoachingLMTemporalContainer') 
 CREATE CLUSTERED INDEX IHash_HFit_CoachingLMTemporalContainer ON dbo.BASE_HFit_CoachingLMTemporalContainer (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_BASE_HFit_TrackerMealPortions') 
 CREATE NONCLUSTERED INDEX CI_BASE_HFit_TrackerMealPortions ON dbo.BASE_HFit_TrackerMealPortions (  SVR ASC  , DBNAME ASC  , ItemID ASC  )   INCLUDE ( HashCode , LASTMODIFIEDDATE )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'PI01_BASE_HFit_TrackerMealPortions') 
 CREATE NONCLUSTERED INDEX PI01_BASE_HFit_TrackerMealPortions ON dbo.BASE_HFit_TrackerMealPortions (  TrackerCollectionSourceID ASC  , SVR ASC  , DBNAME ASC  )   INCLUDE ( UserID )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'UK00_BASE_HFit_TrackerMealPortions') 
 CREATE  UNIQUE NONCLUSTERED INDEX UK00_BASE_HFit_TrackerMealPortions ON dbo.BASE_HFit_TrackerMealPortions (  SurrogateKey_HFit_TrackerMealPortions ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_HFit_SsoRequest_Joined') 
 CREATE CLUSTERED INDEX IHash_View_HFit_SsoRequest_Joined ON dbo.BASE_View_HFit_SsoRequest_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_HFit_Coach_Bio_HISTORY') 
 CREATE CLUSTERED INDEX IHash_View_HFit_Coach_Bio_HISTORY ON dbo.BASE_View_HFit_Coach_Bio_HISTORY (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_HFit_TipOfTheDay_Joined') 
 CREATE CLUSTERED INDEX IHash_View_HFit_TipOfTheDay_Joined ON dbo.BASE_View_HFit_TipOfTheDay_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_DBPK_CMS_DocumentTypeScopeClass') 
 CREATE NONCLUSTERED INDEX CI_DBPK_CMS_DocumentTypeScopeClass ON dbo.BASE_CMS_DocumentTypeScopeClass (  ClassID ASC  , ScopeID ASC  )   INCLUDE ( DBNAME )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_DBPK_CMS_PageTemplateCategory') 
 CREATE NONCLUSTERED INDEX CI_DBPK_CMS_PageTemplateCategory ON dbo.BASE_CMS_PageTemplateCategory (  CategoryID ASC  )   INCLUDE ( DBNAME )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'PKI_SchemaMonitorObjectName') 
 CREATE  UNIQUE CLUSTERED INDEX PKI_SchemaMonitorObjectName ON dbo.SchemaMonitorObjectName (  ObjectName ASC  , ObjectType ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_HFit_CoachingEvalHARiskCategory_Joined') 
 CREATE CLUSTERED INDEX IHash_View_HFit_CoachingEvalHARiskCategory_Joined ON dbo.BASE_View_HFit_CoachingEvalHARiskCategory_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_HFit_UserSearch_Joined') 
 CREATE CLUSTERED INDEX IHash_View_HFit_UserSearch_Joined ON dbo.BASE_View_HFit_UserSearch_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'PCI_SchemaMonitorObjectNotify') 
 CREATE  UNIQUE CLUSTERED INDEX PCI_SchemaMonitorObjectNotify ON dbo.SchemaMonitorObjectNotify (  EmailAddr ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_DBPK_CMS_Category') 
 CREATE NONCLUSTERED INDEX CI_DBPK_CMS_Category ON dbo.BASE_CMS_Category (  CategoryID ASC  )   INCLUDE ( DBNAME )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_CMS_ResourceTranslated_Joined') 
 CREATE CLUSTERED INDEX IHash_View_CMS_ResourceTranslated_Joined ON dbo.BASE_View_CMS_ResourceTranslated_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_Newsletter_Subscriptions_Joined') 
 CREATE CLUSTERED INDEX IHash_View_Newsletter_Subscriptions_Joined ON dbo.BASE_View_Newsletter_Subscriptions_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_BASE_CMS_Document_Culture_NodeID_SVR') 
 CREATE NONCLUSTERED INDEX CI_BASE_CMS_Document_Culture_NodeID_SVR ON dbo.BASE_CMS_Document (  DocumentCulture ASC  , DocumentNodeID ASC  , SVR ASC  )   INCLUDE ( DBNAME , DocumentForeignKeyValue )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_CMS_Document_Culture_NodeID_SVR') 
 CREATE NONCLUSTERED INDEX CI_CMS_Document_Culture_NodeID_SVR ON dbo.BASE_CMS_Document (  DocumentCulture ASC  , DocumentNodeID ASC  , SVR ASC  )   INCLUDE ( DBNAME , DocumentForeignKeyValue )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'PI_CMS_Document_DocumentCulture') 
 CREATE NONCLUSTERED INDEX PI_CMS_Document_DocumentCulture ON dbo.BASE_CMS_Document (  DocumentCulture ASC  )   INCLUDE ( DBNAME , DocumentForeignKeyValue , DocumentNodeID , SVR )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'PI_EDW_CMS_USERSITE') 
 CREATE CLUSTERED INDEX PI_EDW_CMS_USERSITE ON dbo.STAGED_EDW_CMS_USERSITE (  USERSITEID ASC  , USERID ASC  , SITEID ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_HFit_CoachingHealthActionPlan_Joined') 
 CREATE CLUSTERED INDEX IHash_View_HFit_CoachingHealthActionPlan_Joined ON dbo.BASE_View_HFit_CoachingHealthActionPlan_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'PI_index_BASE_CMS_Site_8_1988279680__K15_K22_10') 
 CREATE NONCLUSTERED INDEX PI_index_BASE_CMS_Site_8_1988279680__K15_K22_10 ON dbo.BASE_CMS_Site (  SiteID ASC  , DBNAME ASC  )   INCLUDE ( SiteGUID )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = '_dta_index_BASE_CMS_Site_8_1878297751__K14_K21_1_2_9_18_90_91_98') 
 CREATE NONCLUSTERED INDEX _dta_index_BASE_CMS_Site_8_1878297751__K14_K21_1_2_9_18_90_91_98 ON dbo.BASE_CMS_Site (  SiteID ASC  , DBNAME ASC  )   INCLUDE ( CT_SiteDisplayName , CT_SiteGUID , CT_SiteName , LASTMODIFIEDDATE , SiteDisplayName , SiteGUID , SiteName )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_DBPK_CMS_Site') 
 CREATE NONCLUSTERED INDEX CI_DBPK_CMS_Site ON dbo.BASE_CMS_Site (  SiteID ASC  )   INCLUDE ( DBNAME )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_DBPK_CMS_Email') 
 CREATE NONCLUSTERED INDEX CI_DBPK_CMS_Email ON dbo.BASE_CMS_Email (  EmailID ASC  )   INCLUDE ( DBNAME )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_HFit_LKP_CoachingCMConditions') 
 CREATE CLUSTERED INDEX IHash_HFit_LKP_CoachingCMConditions ON dbo.BASE_HFit_LKP_CoachingCMConditions (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_BASE_CMS_WebFarmServerTask_SvrTaskDB') 
 CREATE NONCLUSTERED INDEX CI_BASE_CMS_WebFarmServerTask_SvrTaskDB ON dbo.BASE_CMS_WebFarmServerTask (  ServerID ASC  , TaskID ASC  , DBNAME ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'PI_HFIT_HealthAssesmentUserAnswers_LASTUPDATEID') 
 CREATE NONCLUSTERED INDEX PI_HFIT_HealthAssesmentUserAnswers_LASTUPDATEID ON dbo.STAGED_EDW_HFIT_HealthAssesmentUserAnswers (  ITEMID ASC  , LASTUPDATEID ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_Hfit_MyHealthSettings_Joined') 
 CREATE CLUSTERED INDEX IHash_View_Hfit_MyHealthSettings_Joined ON dbo.BASE_View_Hfit_MyHealthSettings_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_HFit_ChallengePostTemplate_Joined') 
 CREATE CLUSTERED INDEX IHash_View_HFit_ChallengePostTemplate_Joined ON dbo.BASE_View_HFit_ChallengePostTemplate_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_OM_AccountContact_ContactJoined') 
 CREATE CLUSTERED INDEX IHash_View_OM_AccountContact_ContactJoined ON dbo.BASE_View_OM_AccountContact_ContactJoined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'PI_EDW_HFIT_HEALTHASSESMENTUSERMODULE') 
 CREATE NONCLUSTERED INDEX PI_EDW_HFIT_HEALTHASSESMENTUSERMODULE ON dbo.STAGED_EDW_HFIT_HEALTHASSESMENTUSERMODULE (  ITEMID ASC  , HASTARTEDITEMID ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'PI01_STAGED_EDW_HFIT_HEALTHASSESMENTUSERQUESTION') 
 CREATE NONCLUSTERED INDEX PI01_STAGED_EDW_HFIT_HEALTHASSESMENTUSERQUESTION ON dbo.STAGED_EDW_HFit_HealthAssesmentUserQuestion (  HARISKAREAITEMID ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_CONTENT_KBArticle_Joined') 
 CREATE CLUSTERED INDEX IHash_View_CONTENT_KBArticle_Joined ON dbo.BASE_View_CONTENT_KBArticle_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_HFit_CoachingLibrarySettings_Joined') 
 CREATE CLUSTERED INDEX IHash_View_HFit_CoachingLibrarySettings_Joined ON dbo.BASE_View_HFit_CoachingLibrarySettings_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_HFit_CoachingMyGoalsSettings') 
 CREATE CLUSTERED INDEX IHash_HFit_CoachingMyGoalsSettings ON dbo.BASE_HFit_CoachingMyGoalsSettings (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'PI_HEALTHASSESMENTUSERRISKAREA_Category') 
 CREATE NONCLUSTERED INDEX PI_HEALTHASSESMENTUSERRISKAREA_Category ON dbo.STAGED_EDW_HFit_HealthAssesmentUserRiskArea (  HARISKCATEGORYITEMID ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_HFit_CustomSettingsTemporalContainer_Joined') 
 CREATE CLUSTERED INDEX IHash_View_HFit_CustomSettingsTemporalContainer_Joined ON dbo.BASE_View_HFit_CustomSettingsTemporalContainer_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_DBPK_CMS_Attachment') 
 CREATE NONCLUSTERED INDEX CI_DBPK_CMS_Attachment ON dbo.BASE_CMS_Attachment (  AttachmentID ASC  )   INCLUDE ( DBNAME )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'PI_EDW_HEALTHASSESMENTUSERRISKCATEGORY_HAMODID') 
 CREATE NONCLUSTERED INDEX PI_EDW_HEALTHASSESMENTUSERRISKCATEGORY_HAMODID ON dbo.STAGED_EDW_HFIT_HEALTHASSESMENTUSERRISKCATEGORY (  HAMODULEITEMID ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'PI_HFIT_HEALTHASSESMENTUSERSTARTED') 
 CREATE NONCLUSTERED INDEX PI_HFIT_HEALTHASSESMENTUSERSTARTED ON dbo.STAGED_EDW_HFIT_HEALTHASSESMENTUSERSTARTED (  ITEMID ASC  , USERID ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_hfit_Post_Joined') 
 CREATE CLUSTERED INDEX IHash_View_hfit_Post_Joined ON dbo.BASE_View_hfit_Post_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_HFit_HealthAssesmentRiskCategory_Joined') 
 CREATE CLUSTERED INDEX IHash_View_HFit_HealthAssesmentRiskCategory_Joined ON dbo.BASE_View_HFit_HealthAssesmentRiskCategory_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_Hierarchy') 
 CREATE CLUSTERED INDEX IHash_View_Hierarchy ON dbo.BASE_View_Hierarchy (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'PI_VIEW_HFIT_HACAMPAIGN_JOINED') 
 CREATE CLUSTERED INDEX PI_VIEW_HFIT_HACAMPAIGN_JOINED ON dbo.STAGED_EDW_TEMP_VIEW_HFIT_HACAMPAIGN_JOINED (  DOCUMENTCULTURE ASC  , HACAMPAIGNID ASC  , NODEGUID ASC  , NODESITEID ASC  , HEALTHASSESSMENTID ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'PI_VIEW_HFIT_HACAMPAIGN_JOINED_CULTURE') 
 CREATE NONCLUSTERED INDEX PI_VIEW_HFIT_HACAMPAIGN_JOINED_CULTURE ON dbo.STAGED_EDW_TEMP_VIEW_HFIT_HACAMPAIGN_JOINED (  NODEGUID ASC  , DOCUMENTCULTURE ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_HFit_Calculator_Joined') 
 CREATE CLUSTERED INDEX IHash_View_HFit_Calculator_Joined ON dbo.BASE_View_HFit_Calculator_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_CONTENT_PressRelease_Joined') 
 CREATE CLUSTERED INDEX IHash_View_CONTENT_PressRelease_Joined ON dbo.BASE_View_CONTENT_PressRelease_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_HFit_CoachingWelcomeSettings_Joined') 
 CREATE CLUSTERED INDEX IHash_View_HFit_CoachingWelcomeSettings_Joined ON dbo.BASE_View_HFit_CoachingWelcomeSettings_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_BASE_HFit_HealthAssesmentMatrixQuestion') 
 CREATE NONCLUSTERED INDEX CI_BASE_HFit_HealthAssesmentMatrixQuestion ON dbo.BASE_HFit_HealthAssesmentMatrixQuestion (  SVR ASC  , DBNAME ASC  , HealthAssesmentMultipleChoiceQuestionID ASC  )   INCLUDE ( HashCode , LASTMODIFIEDDATE )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_CMS_UserRole_Joined') 
 CREATE CLUSTERED INDEX IHash_View_CMS_UserRole_Joined ON dbo.BASE_View_CMS_UserRole_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'PI_STAGING_EDW_HealthAssessment_CDT') 
 CREATE NONCLUSTERED INDEX PI_STAGING_EDW_HealthAssessment_CDT ON dbo.STAGING_EDW_HealthAssessment (  ConvertedToCentralTime ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_DBPK_CMS_ResourceLibrary') 
 CREATE NONCLUSTERED INDEX CI_DBPK_CMS_ResourceLibrary ON dbo.BASE_CMS_ResourceLibrary (  ResourceLibraryID ASC  )   INCLUDE ( DBNAME )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_CMS_RoleResourcePermission_Joined') 
 CREATE CLUSTERED INDEX IHash_View_CMS_RoleResourcePermission_Joined ON dbo.BASE_View_CMS_RoleResourcePermission_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_BASE_HFit_UserCoachingAlert_NotMet_Step1_DEL') 
 CREATE CLUSTERED INDEX IHash_BASE_HFit_UserCoachingAlert_NotMet_Step1_DEL ON dbo.BASE_HFit_UserCoachingAlert_NotMet_Step1_DEL (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_HFit_HealthAssessmentModuleConfiguration_Joined') 
 CREATE CLUSTERED INDEX IHash_View_HFit_HealthAssessmentModuleConfiguration_Joined ON dbo.BASE_View_HFit_HealthAssessmentModuleConfiguration_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'UK00_BASE_HFit_TrackerTobaccoAttestation') 
 CREATE  UNIQUE NONCLUSTERED INDEX UK00_BASE_HFit_TrackerTobaccoAttestation ON dbo.BASE_HFit_TrackerTobaccoAttestation (  SurrogateKey_HFit_TrackerTobaccoAttestation ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_view_EDW_HealthAssesmentClientView') 
 CREATE CLUSTERED INDEX IHash_view_EDW_HealthAssesmentClientView ON dbo.BASE_view_EDW_HealthAssesmentClientView (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_DBPK_CMS_PageTemplateScope') 
 CREATE NONCLUSTERED INDEX CI_DBPK_CMS_PageTemplateScope ON dbo.BASE_CMS_PageTemplateScope (  PageTemplateScopeID ASC  )   INCLUDE ( DBNAME )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_EDW_HealthAssesmentQuestions_HA_LastPullDate') 
 CREATE CLUSTERED INDEX IHash_View_EDW_HealthAssesmentQuestions_HA_LastPullDate ON dbo.BASE_View_EDW_HealthAssesmentQuestions_HA_LastPullDate (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_HFit_CoachingHealthActionPlan') 
 CREATE CLUSTERED INDEX IHash_HFit_CoachingHealthActionPlan ON dbo.BASE_HFit_CoachingHealthActionPlan (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_DBPK_CMS_SearchIndex') 
 CREATE NONCLUSTERED INDEX CI_DBPK_CMS_SearchIndex ON dbo.BASE_CMS_SearchIndex (  IndexID ASC  )   INCLUDE ( DBNAME )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_Hfit_CoachingUserCMExclusion') 
 CREATE CLUSTERED INDEX IHash_Hfit_CoachingUserCMExclusion ON dbo.BASE_Hfit_CoachingUserCMExclusion (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'PI_Staging_EDW_HealthAssessment_Dates') 
 CREATE NONCLUSTERED INDEX PI_Staging_EDW_HealthAssessment_Dates ON dbo.STAGING_EDW_HealthAssessment (  ITEMMODIFIEDWHEN ASC  , HAUSERSTARTED_LASTMODIFIED ASC  , CMSUSER_LASTMODIFIED ASC  , USERSETTINGS_LASTMODIFIED ASC  , USERSITE_LASTMODIFIED ASC  , CMSSITE_LASTMODIFIED ASC  , ACCT_LASTMODIFIED ASC  , HAUSERMODULE_LASTMODIFIED ASC  , VHCJ_LASTMODIFIED ASC  , VHAJ_LASTMODIFIED ASC  , HARISKCATEGORY_LASTMODIFIED ASC  , HAUSERRISKAREA_LASTMODIFIED ASC  , HAUSERQUESTION_LASTMODIFIED ASC  , HAQUESTIONSVIEW_LASTMODIFIED ASC  , HAUSERQUESTIONGROUPRESULTS_LASTMODIFIED ASC  , HAUSERANSWERS_LASTMODIFIED ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_HFit_HealthAssesmentAnswers') 
 CREATE CLUSTERED INDEX IHash_View_HFit_HealthAssesmentAnswers ON dbo.BASE_View_HFit_HealthAssesmentAnswers (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_DBPK_CMS_ObjectSettings') 
 CREATE NONCLUSTERED INDEX CI_DBPK_CMS_ObjectSettings ON dbo.BASE_CMS_ObjectSettings (  ObjectSettingsID ASC  )   INCLUDE ( DBNAME )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_BASE_HFit_TrackerTobaccoAttestation') 
 CREATE NONCLUSTERED INDEX CI_BASE_HFit_TrackerTobaccoAttestation ON dbo.BASE_HFit_TrackerTobaccoAttestation (  SVR ASC  , DBNAME ASC  , ItemID ASC  )   INCLUDE ( HashCode , LASTMODIFIEDDATE )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_COM_SKUOptionCategory_OptionCategory_Joined') 
 CREATE CLUSTERED INDEX IHash_View_COM_SKUOptionCategory_OptionCategory_Joined ON dbo.BASE_View_COM_SKUOptionCategory_OptionCategory_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'temp_PI_EDW_CoachingDetail_IDs') 
 CREATE CLUSTERED INDEX temp_PI_EDW_CoachingDetail_IDs ON dbo.TEMP_EDW_CoachingDetail_DATA (  ItemID ASC  , ItemGUID ASC  , GoalID ASC  , UserID ASC  , UserGUID ASC  , HFitUserMpiNumber ASC  , SiteGUID ASC  , AccountID ASC  , AccountCD ASC  , WeekendDate ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_DBPK_CMS_Layout') 
 CREATE NONCLUSTERED INDEX CI_DBPK_CMS_Layout ON dbo.BASE_CMS_Layout (  LayoutID ASC  )   INCLUDE ( DBNAME )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_HFit_CoachingLibraryResource_Joined') 
 CREATE CLUSTERED INDEX IHash_View_HFit_CoachingLibraryResource_Joined ON dbo.BASE_View_HFit_CoachingLibraryResource_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'PI_JOB_RUN_TIMES') 
 CREATE NONCLUSTERED INDEX PI_JOB_RUN_TIMES ON dbo.JOB_RUN_TIMES (  runid ASC  , job_id ASC  , step_id ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_HFit_CoachingMyHealthInterestsSettings_Joined') 
 CREATE CLUSTERED INDEX IHash_View_HFit_CoachingMyHealthInterestsSettings_Joined ON dbo.BASE_View_HFit_CoachingMyHealthInterestsSettings_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_view_HFit_HealthAssesmentUserResponses') 
 CREATE CLUSTERED INDEX IHash_view_HFit_HealthAssesmentUserResponses ON dbo.BASE_view_HFit_HealthAssesmentUserResponses (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_DBPK_CMS_ResourceString') 
 CREATE NONCLUSTERED INDEX CI_DBPK_CMS_ResourceString ON dbo.BASE_CMS_ResourceString (  StringID ASC  )   INCLUDE ( DBNAME )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_BASE_HFit_UserCoachingAlert_NotMet_Step4_DEL') 
 CREATE CLUSTERED INDEX IHash_BASE_HFit_UserCoachingAlert_NotMet_Step4_DEL ON dbo.BASE_HFit_UserCoachingAlert_NotMet_Step4_DEL (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_Hfit_CoachingSystemSettings_Joined') 
 CREATE CLUSTERED INDEX IHash_View_Hfit_CoachingSystemSettings_Joined ON dbo.BASE_View_Hfit_CoachingSystemSettings_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_HFit_UserCoachingAlert_NotMet_Step5') 
 CREATE CLUSTERED INDEX IHash_HFit_UserCoachingAlert_NotMet_Step5 ON dbo.BASE_HFit_UserCoachingAlert_NotMet_Step5 (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_BASE_HFit_TrackerCollectionSource') 
 CREATE NONCLUSTERED INDEX CI_BASE_HFit_TrackerCollectionSource ON dbo.BASE_HFit_TrackerCollectionSource (  SVR ASC  , DBNAME ASC  , TrackerCollectionSourceID ASC  , ItemID ASC  )   INCLUDE ( HashCode )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_DBPK_CMS_ClassSite') 
 CREATE NONCLUSTERED INDEX CI_DBPK_CMS_ClassSite ON dbo.BASE_CMS_ClassSite (  ClassID ASC  , SiteID ASC  )   INCLUDE ( DBNAME )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_HFit_HSGraphRangeSetting_Joined') 
 CREATE CLUSTERED INDEX IHash_View_HFit_HSGraphRangeSetting_Joined ON dbo.BASE_View_HFit_HSGraphRangeSetting_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_HFIT_Configuration_HACoaching_Joined') 
 CREATE CLUSTERED INDEX IHash_View_HFIT_Configuration_HACoaching_Joined ON dbo.BASE_View_HFIT_Configuration_HACoaching_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_EDW_RewardProgram_Joined') 
 CREATE CLUSTERED INDEX IHash_View_EDW_RewardProgram_Joined ON dbo.BASE_View_EDW_RewardProgram_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_DBPK_CMS_Permission') 
 CREATE NONCLUSTERED INDEX CI_DBPK_CMS_Permission ON dbo.BASE_CMS_Permission (  PermissionID ASC  )   INCLUDE ( DBNAME )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_HFit_ContentBlock_Joined') 
 CREATE CLUSTERED INDEX IHash_View_HFit_ContentBlock_Joined ON dbo.BASE_View_HFit_ContentBlock_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_HFit_CoachingPrivacyPolicy') 
 CREATE CLUSTERED INDEX IHash_HFit_CoachingPrivacyPolicy ON dbo.BASE_HFit_CoachingPrivacyPolicy (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_BASE_BASE_HFIT_HEALTHASSESMENTUSERANSWERS00') 
 CREATE NONCLUSTERED INDEX CI_BASE_BASE_HFIT_HEALTHASSESMENTUSERANSWERS00 ON dbo.BASE_HFit_HealthAssesmentUserAnswers (  SVR ASC  , DBNAME ASC  , HAQuestionItemID ASC  )   INCLUDE ( CodeName , HAAnswerNodeGUID , HAAnswerPoints , HAAnswerValue , ItemCreatedWhen , ItemID , ItemModifiedWhen , UOMCode )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = '_dta_index_BASE_CMS_Role_8_601769201__K17_K4_K10_2_3_5_14_27_30_32') 
 CREATE NONCLUSTERED INDEX _dta_index_BASE_CMS_Role_8_601769201__K17_K4_K10_2_3_5_14_27_30_32 ON dbo.BASE_CMS_Role (  DBNAME ASC  , SiteID ASC  , RoleID ASC  )   INCLUDE ( CT_RoleDescription , CT_RoleGUID , CT_RoleID , LASTMODIFIEDDATE , RoleDescription , RoleGUID , RoleName )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_view_EDW_Coaches') 
 CREATE CLUSTERED INDEX IHash_view_EDW_Coaches ON dbo.BASE_view_EDW_Coaches (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'BASE_EDW_GroupMemberToday_CTE') 
 CREATE NONCLUSTERED INDEX BASE_EDW_GroupMemberToday_CTE ON dbo.BASE_EDW_GroupMemberToday (  DBNAME ASC  )   INCLUDE ( CTKey_EDW_GroupMemberToday )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'UK00_BASE_HFit_TrackerBMI') 
 CREATE  UNIQUE NONCLUSTERED INDEX UK00_BASE_HFit_TrackerBMI ON dbo.BASE_HFit_TrackerBMI (  SurrogateKey_HFit_TrackerBMI ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'PI_CT_TEST_DATA') 
 CREATE NONCLUSTERED INDEX PI_CT_TEST_DATA ON dbo.CT_TEST_DATA (  SVR ASC  , DBNAME ASC  , TBLNAME ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'PI_index_BASE_cms_usersite_8_1837327147__K14_K3_K2') 
 CREATE NONCLUSTERED INDEX PI_index_BASE_cms_usersite_8_1837327147__K14_K3_K2 ON dbo.BASE_cms_usersite (  DBNAME ASC  , SiteID ASC  , UserID ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_HFit_CoachingLibraryHealthArea_Joined') 
 CREATE CLUSTERED INDEX IHash_View_HFit_CoachingLibraryHealthArea_Joined ON dbo.BASE_View_HFit_CoachingLibraryHealthArea_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_view_hfit_challenge_Joined_KenticoCMS_2') 
 CREATE CLUSTERED INDEX IHash_view_hfit_challenge_Joined_KenticoCMS_2 ON dbo.BASE_view_hfit_challenge_Joined_KenticoCMS_2 (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = '_dta_index_BASE_hfit_PPTEligibility_8_816110048__K82_K182') 
 CREATE NONCLUSTERED INDEX _dta_index_BASE_hfit_PPTEligibility_8_816110048__K82_K182 ON dbo.BASE_hfit_PPTEligibility (  PPTID ASC  , ItemModifiedWhen ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'PI_BASE_HFit_HealthAssesmentUserRiskCategory_HA_LastPullDate') 
 CREATE NONCLUSTERED INDEX PI_BASE_HFit_HealthAssesmentUserRiskCategory_HA_LastPullDate ON dbo.BASE_HFit_HealthAssesmentUserRiskCategory_HA_LastPullDate (  LastPullDate DESC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_view_EDW_SmallStepResponses') 
 CREATE CLUSTERED INDEX IHash_view_EDW_SmallStepResponses ON dbo.BASE_view_EDW_SmallStepResponses (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'SKey_View_hFit_ChallengePPTEligiblePostTemplate_Joined') 
 CREATE NONCLUSTERED INDEX SKey_View_hFit_ChallengePPTEligiblePostTemplate_Joined ON dbo.BASE_View_hFit_ChallengePPTEligiblePostTemplate_Joined (  SurrogateKey_View_hFit_ChallengePPTEligiblePostTemplate_Joined ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_HFit_TrackerCategory_Joined') 
 CREATE CLUSTERED INDEX IHash_View_HFit_TrackerCategory_Joined ON dbo.BASE_View_HFit_TrackerCategory_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_HFIT_Configuration_CMCoaching_Joined') 
 CREATE CLUSTERED INDEX IHash_View_HFIT_Configuration_CMCoaching_Joined ON dbo.BASE_View_HFIT_Configuration_CMCoaching_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'PI_EDW_SmallSteps_RowNbrCDate') 
 CREATE NONCLUSTERED INDEX PI_EDW_SmallSteps_RowNbrCDate ON dbo.DIM_EDW_SmallSteps (  RowNbr ASC  , LastModifiedDate ASC  , DeletedFlg ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_BASE_BASE_HFIT_HEALTHASSESMENTUSERANSWERS03') 
 CREATE NONCLUSTERED INDEX CI_BASE_BASE_HFIT_HEALTHASSESMENTUSERANSWERS03 ON dbo.BASE_HFit_HealthAssesmentUserModule (  HAStartedItemID ASC  , SVR ASC  , DBNAME ASC  )   INCLUDE ( CodeName , HAModuleNodeGUID , HAModuleScore , ItemID , PreWeightedScore )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_HFit_ChallengePPTRegisteredPostTemplate_Joined') 
 CREATE CLUSTERED INDEX IHash_View_HFit_ChallengePPTRegisteredPostTemplate_Joined ON dbo.BASE_View_HFit_ChallengePPTRegisteredPostTemplate_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'UK00_BASE_HFit_TrackerBodyFat') 
 CREATE  UNIQUE NONCLUSTERED INDEX UK00_BASE_HFit_TrackerBodyFat ON dbo.BASE_HFit_TrackerBodyFat (  SurrogateKey_HFit_TrackerBodyFat ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IDX_DBNAME_SurrogateKey_HFit_TrackerBodyMeasurements') 
 CREATE NONCLUSTERED INDEX IDX_DBNAME_SurrogateKey_HFit_TrackerBodyMeasurements ON dbo.FACT_TrackerData (  TrackerName ASC  )   INCLUDE ( DBNAME , SurrogateKey_HFit_TrackerBodyMeasurements )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IDX_DBNAME_SurrogateKey_HFit_TrackerCollectionSource') 
 CREATE NONCLUSTERED INDEX IDX_DBNAME_SurrogateKey_HFit_TrackerCollectionSource ON dbo.FACT_TrackerData (  TrackerName ASC  )   INCLUDE ( DBNAME , SurrogateKey_HFit_TrackerCollectionSource )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IDX_DBNAME_SurrogateKey_HFit_TrackerDef_Tracker') 
 CREATE NONCLUSTERED INDEX IDX_DBNAME_SurrogateKey_HFit_TrackerDef_Tracker ON dbo.FACT_TrackerData (  TrackerName ASC  )   INCLUDE ( DBNAME , SurrogateKey_HFit_TrackerDef_Tracker )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IDX_DBNAME_SurrogateKey_HFit_TrackerStress') 
 CREATE NONCLUSTERED INDEX IDX_DBNAME_SurrogateKey_HFit_TrackerStress ON dbo.FACT_TrackerData (  TrackerName ASC  )   INCLUDE ( DBNAME , SurrogateKey_HFit_TrackerStress )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IDX_DBNAME_SurrogateKey_HFit_TrackerSugaryFoods') 
 CREATE NONCLUSTERED INDEX IDX_DBNAME_SurrogateKey_HFit_TrackerSugaryFoods ON dbo.FACT_TrackerData (  TrackerName ASC  )   INCLUDE ( DBNAME , SurrogateKey_HFit_TrackerSugaryFoods )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_BASE_CMS_Tree') 
 CREATE NONCLUSTERED INDEX CI_BASE_CMS_Tree ON dbo.BASE_CMS_Tree (  SVR ASC  , DBNAME ASC  , NodeID ASC  )   INCLUDE ( HashCode , LASTMODIFIEDDATE )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_HFit_LKP_CoachingServiceLevelStatus') 
 CREATE CLUSTERED INDEX IHash_HFit_LKP_CoachingServiceLevelStatus ON dbo.BASE_HFit_LKP_CoachingServiceLevelStatus (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_HFit_ChallengePPTRegisteredRDPostTemplate_Joined') 
 CREATE CLUSTERED INDEX IHash_View_HFit_ChallengePPTRegisteredRDPostTemplate_Joined ON dbo.BASE_View_HFit_ChallengePPTRegisteredRDPostTemplate_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_BASE_HFit_TrackerSugaryFoods') 
 CREATE NONCLUSTERED INDEX CI_BASE_HFit_TrackerSugaryFoods ON dbo.BASE_HFit_TrackerSugaryFoods (  SVR ASC  , DBNAME ASC  , ItemID ASC  )   INCLUDE ( HashCode , LASTMODIFIEDDATE )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'UK00_BASE_HFit_TrackerSugaryFoods') 
 CREATE  UNIQUE NONCLUSTERED INDEX UK00_BASE_HFit_TrackerSugaryFoods ON dbo.BASE_HFit_TrackerSugaryFoods (  SurrogateKey_HFit_TrackerSugaryFoods ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_hfit_challengeJoined') 
 CREATE CLUSTERED INDEX IHash_View_hfit_challengeJoined ON dbo.BASE_View_hfit_challengeJoined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_DBPK_CMS_TagGroup') 
 CREATE NONCLUSTERED INDEX CI_DBPK_CMS_TagGroup ON dbo.BASE_CMS_TagGroup (  TagGroupID ASC  )   INCLUDE ( DBNAME )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_HFit_HRA_Joined') 
 CREATE CLUSTERED INDEX IHash_View_HFit_HRA_Joined ON dbo.BASE_View_HFit_HRA_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_HFit_CoachingLibraryResources') 
 CREATE CLUSTERED INDEX IHash_HFit_CoachingLibraryResources ON dbo.BASE_HFit_CoachingLibraryResources (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_CONTENT_FAQ_Joined') 
 CREATE CLUSTERED INDEX IHash_View_CONTENT_FAQ_Joined ON dbo.BASE_View_CONTENT_FAQ_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CG_IX_BASE_View_HFit_CoachingHealthAre_8_1322044787__K54_K5_K178_39') 
 CREATE NONCLUSTERED INDEX CG_IX_BASE_View_HFit_CoachingHealthAre_8_1322044787__K54_K5_K178_39 ON dbo.BASE_View_HFit_CoachingHealthArea_Joined (  DocumentCulture ASC  , NodeID ASC  , DBNAME ASC  )   INCLUDE ( DocumentName )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_BASE_HFit_HealthAssesmentUserQuestion') 
 CREATE NONCLUSTERED INDEX CI_BASE_HFit_HealthAssesmentUserQuestion ON dbo.BASE_HFit_HealthAssesmentUserQuestion (  SVR ASC  , DBNAME ASC  , ItemID ASC  )   INCLUDE ( HashCode , LASTMODIFIEDDATE )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_DBPK_CMS_TemplateDeviceLayout') 
 CREATE NONCLUSTERED INDEX CI_DBPK_CMS_TemplateDeviceLayout ON dbo.BASE_CMS_TemplateDeviceLayout (  TemplateDeviceLayoutID ASC  )   INCLUDE ( DBNAME )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_HFit_PostChallenge_Joined') 
 CREATE CLUSTERED INDEX IHash_View_HFit_PostChallenge_Joined ON dbo.BASE_View_HFit_PostChallenge_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_BASE_HFit_TrackerWholeGrains') 
 CREATE NONCLUSTERED INDEX CI_BASE_HFit_TrackerWholeGrains ON dbo.BASE_HFit_TrackerWholeGrains (  SVR ASC  , DBNAME ASC  , ItemID ASC  )   INCLUDE ( HashCode , LASTMODIFIEDDATE )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'UK00_BASE_HFit_TrackerWholeGrains') 
 CREATE  UNIQUE NONCLUSTERED INDEX UK00_BASE_HFit_TrackerWholeGrains ON dbo.BASE_HFit_TrackerWholeGrains (  SurrogateKey_HFit_TrackerWholeGrains ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = '_dta_index_BASE_CMS_MembershipUser_8_1412200081__K2_K1_K12_3_16_17') 
 CREATE NONCLUSTERED INDEX _dta_index_BASE_CMS_MembershipUser_8_1412200081__K2_K1_K12_3_16_17 ON dbo.BASE_CMS_MembershipUser (  UserID ASC  , MembershipID ASC  , DBNAME ASC  )   INCLUDE ( CT_UserID , CT_ValidTo , ValidTo )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_DBPK_CMS_MembershipUser') 
 CREATE NONCLUSTERED INDEX CI_DBPK_CMS_MembershipUser ON dbo.BASE_CMS_MembershipUser (  MembershipUserID ASC  )   INCLUDE ( DBNAME )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_view_EDW_TrackerMetadata') 
 CREATE CLUSTERED INDEX IHash_view_EDW_TrackerMetadata ON dbo.BASE_view_EDW_TrackerMetadata (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = '_dta_index_BASE_OM_ContactGroupMember_8_1528496624__K1_K3_2_11') 
 CREATE NONCLUSTERED INDEX _dta_index_BASE_OM_ContactGroupMember_8_1528496624__K1_K3_2_11 ON dbo.BASE_OM_ContactGroupMember (  ContactGroupMemberContactGroupID ASC  , ContactGroupMemberRelatedID ASC  )   INCLUDE ( ContactGroupMemberType , LASTMODIFIEDDATE )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_view_ToDoCoachingEnrollment') 
 CREATE CLUSTERED INDEX IHash_view_ToDoCoachingEnrollment ON dbo.BASE_view_ToDoCoachingEnrollment (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_DBPK_CMS_HelpTopic') 
 CREATE NONCLUSTERED INDEX CI_DBPK_CMS_HelpTopic ON dbo.BASE_CMS_HelpTopic (  HelpTopicID ASC  )   INCLUDE ( DBNAME )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_HFit_CoachingHATemporalContainer_Joined') 
 CREATE CLUSTERED INDEX IHash_View_HFit_CoachingHATemporalContainer_Joined ON dbo.BASE_View_HFit_CoachingHATemporalContainer_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_view_CMS_USER') 
 CREATE CLUSTERED INDEX IHash_view_CMS_USER ON dbo.BASE_view_CMS_USER (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_DBPK_CMS_MetaFile') 
 CREATE NONCLUSTERED INDEX CI_DBPK_CMS_MetaFile ON dbo.BASE_CMS_MetaFile (  MetaFileID ASC  )   INCLUDE ( DBNAME )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_BASE_HFit_LKP_RewardTriggerParameterOperator') 
 CREATE NONCLUSTERED INDEX CI_BASE_HFit_LKP_RewardTriggerParameterOperator ON dbo.BASE_HFit_LKP_RewardTriggerParameterOperator (  SVR ASC  , DBNAME ASC  , RewardTriggerParameterOperatorLKPID ASC  )   INCLUDE ( HashCode , LASTMODIFIEDDATE )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_HFit_CoachingLibraryResources_Joined') 
 CREATE CLUSTERED INDEX IHash_View_HFit_CoachingLibraryResources_Joined ON dbo.BASE_View_HFit_CoachingLibraryResources_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_view_EDW_TrackerShots') 
 CREATE CLUSTERED INDEX IHash_view_EDW_TrackerShots ON dbo.BASE_view_EDW_TrackerShots (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_hfit_ChallengeAbout_Joined') 
 CREATE CLUSTERED INDEX IHash_View_hfit_ChallengeAbout_Joined ON dbo.BASE_View_hfit_ChallengeAbout_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_BookingSystem_Joined') 
 CREATE CLUSTERED INDEX IHash_View_BookingSystem_Joined ON dbo.BASE_View_BookingSystem_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_BASE_HFit_TrackerSleepPlan') 
 CREATE NONCLUSTERED INDEX CI_BASE_HFit_TrackerSleepPlan ON dbo.BASE_HFit_TrackerSleepPlan (  SVR ASC  , DBNAME ASC  , ItemID ASC  )   INCLUDE ( HashCode , LASTMODIFIEDDATE )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'UK00_BASE_HFit_TrackerSleepPlan') 
 CREATE  UNIQUE NONCLUSTERED INDEX UK00_BASE_HFit_TrackerSleepPlan ON dbo.BASE_HFit_TrackerSleepPlan (  SurrogateKey_HFit_TrackerSleepPlan ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_CONTENT_Blog_Joined') 
 CREATE CLUSTERED INDEX IHash_View_CONTENT_Blog_Joined ON dbo.BASE_View_CONTENT_Blog_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_BASE_HFit_RewardActivity') 
 CREATE NONCLUSTERED INDEX CI_BASE_HFit_RewardActivity ON dbo.BASE_HFit_RewardActivity (  SVR ASC  , DBNAME ASC  , RewardActivityID ASC  )   INCLUDE ( HashCode , LASTMODIFIEDDATE )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'PI_BASE_CMS_Document_DocumentCulture') 
 CREATE NONCLUSTERED INDEX PI_BASE_CMS_Document_DocumentCulture ON dbo.BASE_CMS_Document (  DocumentCulture ASC  )   INCLUDE ( DBNAME , DocumentForeignKeyValue , DocumentNodeID , SVR )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_BASE_CMS_WebFarmServerTask_DBNAME') 
 CREATE NONCLUSTERED INDEX CI_BASE_CMS_WebFarmServerTask_DBNAME ON dbo.BASE_CMS_WebFarmServerTask (  DBNAME ASC  )   INCLUDE ( ServerID , TaskID )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'PI_HFIT_HealthAssesmentUserAnswers') 
 CREATE CLUSTERED INDEX PI_HFIT_HealthAssesmentUserAnswers ON dbo.STAGED_EDW_HFIT_HealthAssesmentUserAnswers (  ITEMID ASC  , HAQUESTIONITEMID ASC  , HAANSWERNODEGUID ASC  , CODENAME ASC  , HAANSWERVALUE ASC  , HAANSWERPOINTS ASC  , UOMCODE ASC  , ITEMCREATEDWHEN ASC  , ITEMMODIFIEDWHEN ASC  , LASTUPDATEID ASC  , LASTLOADEDDATE ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_HFit_HealthAssesmentPageBreaks') 
 CREATE CLUSTERED INDEX IHash_View_HFit_HealthAssesmentPageBreaks ON dbo.BASE_View_HFit_HealthAssesmentPageBreaks (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'UK_STAGED_EDW_HFIT_HEALTHASSESMENTUSERQUESTION') 
 CREATE NONCLUSTERED INDEX UK_STAGED_EDW_HFIT_HEALTHASSESMENTUSERQUESTION ON dbo.STAGED_EDW_HFit_HealthAssesmentUserQuestion (  ITEMID ASC  , LASTUPDATEID ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_BASE_HFit_TrackerCholesterol') 
 CREATE NONCLUSTERED INDEX CI_BASE_HFit_TrackerCholesterol ON dbo.BASE_HFit_TrackerCholesterol (  SVR ASC  , DBNAME ASC  , ItemID ASC  )   INCLUDE ( HashCode , LASTMODIFIEDDATE )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'UK00_BASE_HFit_TrackerCholesterol') 
 CREATE  UNIQUE NONCLUSTERED INDEX UK00_BASE_HFit_TrackerCholesterol ON dbo.BASE_HFit_TrackerCholesterol (  SurrogateKey_HFit_TrackerCholesterol ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_CMS_Tree_Joined_Linked') 
 CREATE CLUSTERED INDEX IHash_View_CMS_Tree_Joined_Linked ON dbo.BASE_View_CMS_Tree_Joined_Linked (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'PI_HealthAssesmentUserQuestionGroupResults') 
 CREATE NONCLUSTERED INDEX PI_HealthAssesmentUserQuestionGroupResults ON dbo.STAGED_EDW_HFit_HealthAssesmentUserQuestionGroupResults (  ITEMID ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_view_EDW_RewardsDefinition') 
 CREATE CLUSTERED INDEX IHash_view_EDW_RewardsDefinition ON dbo.BASE_view_EDW_RewardsDefinition (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'PI_EDW_HEALTHASSESMENTUSERRISKCATEGORY') 
 CREATE NONCLUSTERED INDEX PI_EDW_HEALTHASSESMENTUSERRISKCATEGORY ON dbo.STAGED_EDW_HFIT_HEALTHASSESMENTUSERRISKCATEGORY (  ITEMID ASC  , HAMODULEITEMID ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_DBPK_CMS_ObjectRelationship') 
 CREATE NONCLUSTERED INDEX CI_DBPK_CMS_ObjectRelationship ON dbo.BASE_CMS_ObjectRelationship (  RelationshipID ASC  )   INCLUDE ( DBNAME )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_CMS_ObjectVersionHistoryUser_Joined') 
 CREATE CLUSTERED INDEX IHash_View_CMS_ObjectVersionHistoryUser_Joined ON dbo.BASE_View_CMS_ObjectVersionHistoryUser_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_BASE_HFit_RewardTrigger') 
 CREATE NONCLUSTERED INDEX CI_BASE_HFit_RewardTrigger ON dbo.BASE_HFit_RewardTrigger (  SVR ASC  , DBNAME ASC  , RewardTriggerID ASC  )   INCLUDE ( HashCode , LASTMODIFIEDDATE )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'PI01_BASE_cms_user') 
 CREATE NONCLUSTERED INDEX PI01_BASE_cms_user ON dbo.BASE_cms_user (  UserID ASC  , SVR ASC  , DBNAME ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'temp_PI_EDW_Coaches_IDs') 
 CREATE CLUSTERED INDEX temp_PI_EDW_Coaches_IDs ON dbo.TEMP_EDW_Coaches_DATA (  UserGUID ASC  , SiteGUID ASC  , AccountID ASC  , AccountCD ASC  , CoachID ASC  , email ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_BASE_HFit_TrackerFruits') 
 CREATE NONCLUSTERED INDEX CI_BASE_HFit_TrackerFruits ON dbo.BASE_HFit_TrackerFruits (  SVR ASC  , DBNAME ASC  , ItemID ASC  )   INCLUDE ( HashCode , LASTMODIFIEDDATE )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'UK00_BASE_HFit_TrackerFruits') 
 CREATE  UNIQUE NONCLUSTERED INDEX UK00_BASE_HFit_TrackerFruits ON dbo.BASE_HFit_TrackerFruits (  SurrogateKey_HFit_TrackerFruits ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'temp_PI_EDW_HealthAssessment_IDs') 
 CREATE CLUSTERED INDEX temp_PI_EDW_HealthAssessment_IDs ON dbo.TEMP_EDW_RewardAwardDetail_DATA (  UserGUID ASC  , SiteGUID ASC  , HFitUserMpiNumber ASC  , RewardLevelGUID ASC  , AwardType ASC  , AwardDisplayName ASC  , RewardValue ASC  , ThresholdNumber ASC  , UserNotified ASC  , IsFulfilled ASC  , AccountID ASC  , AccountCD ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'PI_MART_HA_HAUserModule_LastModifiedDate') 
 CREATE NONCLUSTERED INDEX PI_MART_HA_HAUserModule_LastModifiedDate ON dbo.BASE_MART_EDW_HealthAssesment (  HAUserModule_LastModifiedDate ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'PI_MART_HA_HAUserStarted_LastModifiedDate') 
 CREATE NONCLUSTERED INDEX PI_MART_HA_HAUserStarted_LastModifiedDate ON dbo.BASE_MART_EDW_HealthAssesment (  HAUserStarted_LastModifiedDate ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'PI_MART_HA_UserSite_LastModifiedDate') 
 CREATE NONCLUSTERED INDEX PI_MART_HA_UserSite_LastModifiedDate ON dbo.BASE_MART_EDW_HealthAssesment (  UserSite_LastModifiedDate ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_DBPK_CMS_SiteCulture') 
 CREATE NONCLUSTERED INDEX CI_DBPK_CMS_SiteCulture ON dbo.BASE_CMS_SiteCulture (  CultureID ASC  , SiteID ASC  )   INCLUDE ( DBNAME )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'temp_PI_EDW_HealthAssessment_IDs') 
 CREATE CLUSTERED INDEX temp_PI_EDW_HealthAssessment_IDs ON dbo.TEMP_EDW_RewardTriggerParameters_DATA (  SiteGUID ASC  , RewardTriggerID ASC  , ParameterDisplayName ASC  , RewardTriggerParameterOperator ASC  , Value ASC  , AccountID ASC  , AccountCD ASC  , DocumentGuid ASC  , NodeGuid ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_HFit_RewardProgram_Joined') 
 CREATE CLUSTERED INDEX IHash_View_HFit_RewardProgram_Joined ON dbo.BASE_View_HFit_RewardProgram_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'temp_PI_EDW_RewardUserLevel_IDs') 
 CREATE CLUSTERED INDEX temp_PI_EDW_RewardUserLevel_IDs ON dbo.TEMP_EDW_RewardUserLevel_DATA (  UserId ASC  , LevelCompletedDt ASC  , LevelName ASC  , SiteName ASC  , nodeguid ASC  , SiteGuid ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_HFit_RightsResponsibilities_Joined') 
 CREATE CLUSTERED INDEX IHash_View_HFit_RightsResponsibilities_Joined ON dbo.BASE_View_HFit_RightsResponsibilities_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_BASE_HFit_TrackerStress') 
 CREATE NONCLUSTERED INDEX CI_BASE_HFit_TrackerStress ON dbo.BASE_HFit_TrackerStress (  SVR ASC  , DBNAME ASC  , ItemID ASC  )   INCLUDE ( HashCode , LASTMODIFIEDDATE )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'UK00_BASE_HFit_TrackerStress') 
 CREATE  UNIQUE NONCLUSTERED INDEX UK00_BASE_HFit_TrackerStress ON dbo.BASE_HFit_TrackerStress (  SurrogateKey_HFit_TrackerStress ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_HFit_ScreeningTemporalContainer_Joined') 
 CREATE CLUSTERED INDEX IHash_View_HFit_ScreeningTemporalContainer_Joined ON dbo.BASE_View_HFit_ScreeningTemporalContainer_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_BASE_HFit_HACampaign') 
 CREATE NONCLUSTERED INDEX CI_BASE_HFit_HACampaign ON dbo.BASE_HFit_HACampaign (  SVR ASC  , DBNAME ASC  , HACampaignID ASC  )   INCLUDE ( HashCode , LASTMODIFIEDDATE )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_BASE_HFit_RewardTriggerParameter') 
 CREATE NONCLUSTERED INDEX CI_BASE_HFit_RewardTriggerParameter ON dbo.BASE_HFit_RewardTriggerParameter (  SVR ASC  , DBNAME ASC  , RewardTriggerParameterID ASC  )   INCLUDE ( HashCode , LASTMODIFIEDDATE )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_Membership_MembershipUser_Joined') 
 CREATE CLUSTERED INDEX IHash_View_Membership_MembershipUser_Joined ON dbo.BASE_View_Membership_MembershipUser_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_HFit_HealthAssesmentMultipleChoiceQuestion_Joined') 
 CREATE CLUSTERED INDEX IHash_View_HFit_HealthAssesmentMultipleChoiceQuestion_Joined ON dbo.BASE_View_HFit_HealthAssesmentMultipleChoiceQuestion_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_OM_AccountContact_AccountJoined') 
 CREATE CLUSTERED INDEX IHash_View_OM_AccountContact_AccountJoined ON dbo.BASE_View_OM_AccountContact_AccountJoined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_DBPK_CMS_LicenseKey') 
 CREATE NONCLUSTERED INDEX CI_DBPK_CMS_LicenseKey ON dbo.BASE_CMS_LicenseKey (  LicenseKeyID ASC  )   INCLUDE ( DBNAME )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_BASE_HFit_TrackerVegetables') 
 CREATE NONCLUSTERED INDEX CI_BASE_HFit_TrackerVegetables ON dbo.BASE_HFit_TrackerVegetables (  SVR ASC  , DBNAME ASC  , ItemID ASC  )   INCLUDE ( HashCode , LASTMODIFIEDDATE )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'UK00_BASE_HFit_TrackerVegetables') 
 CREATE  UNIQUE NONCLUSTERED INDEX UK00_BASE_HFit_TrackerVegetables ON dbo.BASE_HFit_TrackerVegetables (  SurrogateKey_HFit_TrackerVegetables ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'GUID_BASE_HFit_HealthAssesmentUserRiskArea_HA_LastPullDate') 
 CREATE NONCLUSTERED INDEX GUID_BASE_HFit_HealthAssesmentUserRiskArea_HA_LastPullDate ON dbo.BASE_HFit_HealthAssesmentUserRiskArea_HA_LastPullDate (  RowGUID DESC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_ToDoHealthAssesment') 
 CREATE CLUSTERED INDEX IHash_View_ToDoHealthAssesment ON dbo.BASE_View_ToDoHealthAssesment (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_BASE_BASE_HFIT_HEALTHASSESMENTUSERANSWERS01') 
 CREATE NONCLUSTERED INDEX CI_BASE_BASE_HFIT_HEALTHASSESMENTUSERANSWERS01 ON dbo.BASE_HFit_HealthAssesmentUserRiskCategory (  HAModuleItemID ASC  , SVR ASC  , DBNAME ASC  )   INCLUDE ( CodeName , HARiskCategoryNodeGUID , HARiskCategoryScore , ItemID , ItemModifiedWhen , PreWeightedScore )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_HFit_HealthAssessmentFreeForm_Joined') 
 CREATE CLUSTERED INDEX IHash_View_HFit_HealthAssessmentFreeForm_Joined ON dbo.BASE_View_HFit_HealthAssessmentFreeForm_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'SKey_View_hFit_ChallengePPTEligiblePostTemplate_Joined_KenticoCMS_1') 
 CREATE NONCLUSTERED INDEX SKey_View_hFit_ChallengePPTEligiblePostTemplate_Joined_KenticoCMS_1 ON dbo.BASE_View_hFit_ChallengePPTEligiblePostTemplate_Joined_KenticoCMS_1 (  SurrogateKey_View_hFit_ChallengePPTEligiblePostTemplate_Joined_KenticoCMS_1 ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_HFit_HSAbout_Joined') 
 CREATE CLUSTERED INDEX IHash_View_HFit_HSAbout_Joined ON dbo.BASE_View_HFit_HSAbout_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_hFit_ChallengePPTEligiblePostTemplate_Joined_KenticoCMS_2') 
 CREATE CLUSTERED INDEX IHash_View_hFit_ChallengePPTEligiblePostTemplate_Joined_KenticoCMS_2 ON dbo.BASE_View_hFit_ChallengePPTEligiblePostTemplate_Joined_KenticoCMS_2 (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_CONTENT_BlogPost_Joined') 
 CREATE CLUSTERED INDEX IHash_View_CONTENT_BlogPost_Joined ON dbo.BASE_View_CONTENT_BlogPost_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_HFit_ChallengeRegistrationPostTemplate_Joined') 
 CREATE CLUSTERED INDEX IHash_View_HFit_ChallengeRegistrationPostTemplate_Joined ON dbo.BASE_View_HFit_ChallengeRegistrationPostTemplate_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_BASE_HFit_TrackerBMI') 
 CREATE NONCLUSTERED INDEX CI_BASE_HFit_TrackerBMI ON dbo.BASE_HFit_TrackerBMI (  SVR ASC  , DBNAME ASC  , ItemID ASC  )   INCLUDE ( HashCode , LASTMODIFIEDDATE )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_HFit_LoginPageSettings_Joined') 
 CREATE CLUSTERED INDEX IHash_View_HFit_LoginPageSettings_Joined ON dbo.BASE_View_HFit_LoginPageSettings_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'SKey_View_HFit_ChallengePPTEligibleCDPostTemplate_Joined') 
 CREATE NONCLUSTERED INDEX SKey_View_HFit_ChallengePPTEligibleCDPostTemplate_Joined ON dbo.BASE_View_HFit_ChallengePPTEligibleCDPostTemplate_Joined (  SurrogateKey_View_HFit_ChallengePPTEligibleCDPostTemplate_Joined ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_view_hfit_challenge_Joined') 
 CREATE CLUSTERED INDEX IHash_view_hfit_challenge_Joined ON dbo.BASE_view_hfit_challenge_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_DBPK_CMS_MacroRule') 
 CREATE NONCLUSTERED INDEX CI_DBPK_CMS_MacroRule ON dbo.BASE_CMS_MacroRule (  MacroRuleID ASC  )   INCLUDE ( DBNAME )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_BASE_View_HFit_ChallengePPTEligibleCDPostTemplate_Joined_DEL') 
 CREATE NONCLUSTERED INDEX IHash_BASE_View_HFit_ChallengePPTEligibleCDPostTemplate_Joined_DEL ON dbo.BASE_View_HFit_ChallengePPTEligibleCDPostTemplate_Joined_DEL (  HashCode ASC  )   INCLUDE ( DBNAME )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_DBPK_CMS_UserSite') 
 CREATE NONCLUSTERED INDEX CI_DBPK_CMS_UserSite ON dbo.BASE_cms_usersite (  UserSiteID ASC  )   INCLUDE ( DBNAME )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_view_EDW_CoachingPPTAvailable') 
 CREATE CLUSTERED INDEX IHash_view_EDW_CoachingPPTAvailable ON dbo.BASE_view_EDW_CoachingPPTAvailable (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_HFit_CoachingLibraryHealthArea') 
 CREATE CLUSTERED INDEX IHash_HFit_CoachingLibraryHealthArea ON dbo.BASE_HFit_CoachingLibraryHealthArea (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_BASE_CMS_WebFarmTask_TaskID') 
 CREATE NONCLUSTERED INDEX CI_BASE_CMS_WebFarmTask_TaskID ON dbo.BASE_CMS_WebFarmTask (  DBNAME ASC  )   INCLUDE ( TaskID )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_BASE_view_hfit_challenge_Joined_KenticoCMS_2_DEL') 
 CREATE CLUSTERED INDEX IHash_BASE_view_hfit_challenge_Joined_KenticoCMS_2_DEL ON dbo.BASE_view_hfit_challenge_Joined_KenticoCMS_2_DEL (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = '_dta_index_BASE_hfit_PPTEligibility_8_816110048__K3_2_5_6_12_13_14_82_86_92_95_97_98_104_105_106') 
 CREATE NONCLUSTERED INDEX _dta_index_BASE_hfit_PPTEligibility_8_816110048__K3_2_5_6_12_13_14_82_86_92_95_97_98_104_105_106 ON dbo.BASE_hfit_PPTEligibility (  UserID ASC  )   INCLUDE ( City , ClientCode , CT_City , CT_FirstName , CT_LastName , CT_PostalCode , CT_PPTID , CT_State , CT_UserID , FirstName , LASTMODIFIEDDATE , LastName , PostalCode , PPTID , State )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'PI_BASE_hfit_PPTEligibility_ModDate') 
 CREATE NONCLUSTERED INDEX PI_BASE_hfit_PPTEligibility_ModDate ON dbo.BASE_hfit_PPTEligibility (  DBNAME ASC  )   INCLUDE ( ItemModifiedWhen , PPTID )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_hfit_SocialProof_Joined') 
 CREATE CLUSTERED INDEX IHash_View_hfit_SocialProof_Joined ON dbo.BASE_View_hfit_SocialProof_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'PI_EDW_HealthInterestDetail') 
 CREATE CLUSTERED INDEX PI_EDW_HealthInterestDetail ON dbo.DIM_EDW_HealthInterestDetail (  UserID ASC  , UserGUID ASC  , HFitUserMpiNumber ASC  , SiteGUID ASC  , CoachingHealthInterestID ASC  , FirstNodeID ASC  , SecondNodeGuid ASC  , ThirdNodeGuid ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'PI_EDW_HealthInterestList_RowNbrCDate') 
 CREATE NONCLUSTERED INDEX PI_EDW_HealthInterestList_RowNbrCDate ON dbo.DIM_EDW_HealthInterestList (  RowNbr ASC  , LastModifiedDate ASC  , DeletedFlg ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_HFit_PostEmptyFeed_Joined') 
 CREATE CLUSTERED INDEX IHash_View_HFit_PostEmptyFeed_Joined ON dbo.BASE_View_HFit_PostEmptyFeed_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_BASE_View_OM_ContactGroupMember_AccountJoined_DEL_DEL') 
 CREATE CLUSTERED INDEX IHash_BASE_View_OM_ContactGroupMember_AccountJoined_DEL_DEL ON dbo.BASE_View_OM_ContactGroupMember_AccountJoined_DEL_DEL (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = '_dta_index_BASE_HFit_ContactGroupMembership_8_887726265__K18_K1_15') 
 CREATE NONCLUSTERED INDEX _dta_index_BASE_HFit_ContactGroupMembership_8_887726265__K18_K1_15 ON dbo.BASE_HFit_ContactGroupMembership (  DBNAME ASC  , cmsMembershipID ASC  )   INCLUDE ( LASTMODIFIEDDATE )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_DBPK_CMS_RoleApplication') 
 CREATE NONCLUSTERED INDEX CI_DBPK_CMS_RoleApplication ON dbo.BASE_CMS_RoleApplication (  ElementID ASC  , RoleID ASC  )   INCLUDE ( DBNAME )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_CMS_EventLog_Joined') 
 CREATE CLUSTERED INDEX IHash_View_CMS_EventLog_Joined ON dbo.BASE_View_CMS_EventLog_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'PI_EDW_RewardUserDetail') 
 CREATE CLUSTERED INDEX PI_EDW_RewardUserDetail ON dbo.DIM_EDW_RewardUserDetail (  UserGUID ASC  , AccountID ASC  , AccountCD ASC  , SiteGUID ASC  , HFitUserMpiNumber ASC  , RewardActivityGUID ASC  , RewardTriggerGUID ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_CONTENT_News_Joined') 
 CREATE CLUSTERED INDEX IHash_View_CONTENT_News_Joined ON dbo.BASE_View_CONTENT_News_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_Integration_Task_Joined') 
 CREATE CLUSTERED INDEX IHash_View_Integration_Task_Joined ON dbo.BASE_View_Integration_Task_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'PI_EDW_Tracker_Dates') 
 CREATE NONCLUSTERED INDEX PI_EDW_Tracker_Dates ON dbo.DIM_EDW_Trackers (  TrackerNameAggregateTable ASC  , ItemID ASC  , ItemModifiedWhen ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'PI_index_BASE_HFit_HealthAssesmentUserMod_8_1570898205__K25_K11_K18_10_12_13_15') 
 CREATE NONCLUSTERED INDEX PI_index_BASE_HFit_HealthAssesmentUserMod_8_1570898205__K25_K11_K18_10_12_13_15 ON dbo.BASE_HFit_HealthAssesmentUserModule (  DBNAME ASC  , HAStartedItemID ASC  , ItemID ASC  )   INCLUDE ( CodeName , HAModuleNodeGUID , HAModuleScore , PreWeightedScore )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_view_EDW_HealthAssesmentDeffinitionCustom') 
 CREATE CLUSTERED INDEX IHash_view_EDW_HealthAssesmentDeffinitionCustom ON dbo.BASE_view_EDW_HealthAssesmentDeffinitionCustom (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_DBPK_CMS_Membership') 
 CREATE NONCLUSTERED INDEX CI_DBPK_CMS_Membership ON dbo.BASE_CMS_Membership (  MembershipID ASC  )   INCLUDE ( DBNAME )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_CONTENT_Smartphone_Joined') 
 CREATE CLUSTERED INDEX IHash_View_CONTENT_Smartphone_Joined ON dbo.BASE_View_CONTENT_Smartphone_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_BASE_HFit_RewardProgram') 
 CREATE NONCLUSTERED INDEX CI_BASE_HFit_RewardProgram ON dbo.BASE_HFit_RewardProgram (  SVR ASC  , DBNAME ASC  , RewardProgramID ASC  )   INCLUDE ( HashCode , LASTMODIFIEDDATE )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IDX_DBNAME_SurrogateKey_HFit_TrackerHbA1c') 
 CREATE NONCLUSTERED INDEX IDX_DBNAME_SurrogateKey_HFit_TrackerHbA1c ON dbo.FACT_TrackerData (  TrackerName ASC  )   INCLUDE ( DBNAME , SurrogateKey_HFit_TrackerHbA1c )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IDX_DBNAME_SurrogateKey_HFit_TrackerHighSodiumFoods') 
 CREATE NONCLUSTERED INDEX IDX_DBNAME_SurrogateKey_HFit_TrackerHighSodiumFoods ON dbo.FACT_TrackerData (  TrackerName ASC  )   INCLUDE ( DBNAME , SurrogateKey_HFit_TrackerHighSodiumFoods )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IDX_DBNAME_SurrogateKey_HFit_TrackerMedicalCarePlan') 
 CREATE NONCLUSTERED INDEX IDX_DBNAME_SurrogateKey_HFit_TrackerMedicalCarePlan ON dbo.FACT_TrackerData (  TrackerName ASC  )   INCLUDE ( DBNAME , SurrogateKey_HFit_TrackerMedicalCarePlan )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IDX_DBNAME_SurrogateKey_HFit_TrackerTobaccoFree') 
 CREATE NONCLUSTERED INDEX IDX_DBNAME_SurrogateKey_HFit_TrackerTobaccoFree ON dbo.FACT_TrackerData (  TrackerName ASC  )   INCLUDE ( DBNAME , SurrogateKey_HFit_TrackerTobaccoFree )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IDX_DBNAME_SurrogateKey_HFit_TrackerWeight') 
 CREATE NONCLUSTERED INDEX IDX_DBNAME_SurrogateKey_HFit_TrackerWeight ON dbo.FACT_TrackerData (  TrackerName ASC  )   INCLUDE ( DBNAME , SurrogateKey_HFit_TrackerWeight )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'UK00_BASE_HFit_TrackerHighSodiumFoods') 
 CREATE  UNIQUE NONCLUSTERED INDEX UK00_BASE_HFit_TrackerHighSodiumFoods ON dbo.BASE_HFit_TrackerHighSodiumFoods (  SurrogateKey_HFit_TrackerHighSodiumFoods ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_DBPK_CMS_UserSettings') 
 CREATE NONCLUSTERED INDEX CI_DBPK_CMS_UserSettings ON dbo.BASE_CMS_UserSettings (  UserSettingsID ASC  )   INCLUDE ( DBNAME )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_HFit_RewardTrigger_Joined') 
 CREATE CLUSTERED INDEX IHash_View_HFit_RewardTrigger_Joined ON dbo.BASE_View_HFit_RewardTrigger_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_TEMPEDWHAHASHKEYS') 
 CREATE CLUSTERED INDEX CI_TEMPEDWHAHASHKEYS ON dbo.LKUP_DELETEDEDWHAHASHKEYS (  SVR ASC  , DBNAME ASC  , HAUSERSTARTED_ITEMID ASC  , USERGUID ASC  , PKHASHCODE ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_HFit_CoachingAuditLog') 
 CREATE CLUSTERED INDEX IHash_View_HFit_CoachingAuditLog ON dbo.BASE_View_HFit_CoachingAuditLog (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_Hfit_SecurityQuestionSettings_Joined') 
 CREATE CLUSTERED INDEX IHash_View_Hfit_SecurityQuestionSettings_Joined ON dbo.BASE_View_Hfit_SecurityQuestionSettings_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'GUID_BASE_HFit_Account_HA_LastPullDate') 
 CREATE NONCLUSTERED INDEX GUID_BASE_HFit_Account_HA_LastPullDate ON dbo.BASE_HFit_Account_HA_LastPullDate (  RowGUID DESC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_HFit_Class_Joined') 
 CREATE CLUSTERED INDEX IHash_View_HFit_Class_Joined ON dbo.BASE_View_HFit_Class_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_HFit_Configuration_CallLogCoaching') 
 CREATE CLUSTERED INDEX IHash_HFit_Configuration_CallLogCoaching ON dbo.BASE_HFit_Configuration_CallLogCoaching (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'UK00_BASE_HFit_TrackerCardio') 
 CREATE  UNIQUE NONCLUSTERED INDEX UK00_BASE_HFit_TrackerCardio ON dbo.BASE_HFit_TrackerCardio (  SurrogateKey_HFit_TrackerCardio ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_BASE_HFit_LKP_TrackerVendor') 
 CREATE NONCLUSTERED INDEX CI_BASE_HFit_LKP_TrackerVendor ON dbo.BASE_HFit_LKP_TrackerVendor (  SVR ASC  , DBNAME ASC  , ItemID ASC  )   INCLUDE ( HashCode , LASTMODIFIEDDATE )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_HFit_HA_UseAndDisclosure_Joined') 
 CREATE CLUSTERED INDEX IHash_View_HFit_HA_UseAndDisclosure_Joined ON dbo.BASE_View_HFit_HA_UseAndDisclosure_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_hfit_CoachingCMTemporalContainer') 
 CREATE CLUSTERED INDEX IHash_hfit_CoachingCMTemporalContainer ON dbo.BASE_hfit_CoachingCMTemporalContainer (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = '_dta_index_BASE_CMS_MembershipUser_8_1412200081__K1_K2_3_16_17') 
 CREATE NONCLUSTERED INDEX _dta_index_BASE_CMS_MembershipUser_8_1412200081__K1_K2_3_16_17 ON dbo.BASE_CMS_MembershipUser (  MembershipID ASC  , UserID ASC  )   INCLUDE ( CT_UserID , CT_ValidTo , ValidTo )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'PI_MART_TableRowCounts') 
 CREATE CLUSTERED INDEX PI_MART_TableRowCounts ON dbo.MART_TableRowCounts (  TblName ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'UK00_BASE_HFit_TrackerSitLess') 
 CREATE  UNIQUE NONCLUSTERED INDEX UK00_BASE_HFit_TrackerSitLess ON dbo.BASE_HFit_TrackerSitLess (  SurrogateKey_HFit_TrackerSitLess ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_CMS_PageTemplateCategoryPageTemplate_Joined') 
 CREATE CLUSTERED INDEX IHash_View_CMS_PageTemplateCategoryPageTemplate_Joined ON dbo.BASE_View_CMS_PageTemplateCategoryPageTemplate_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_HFit_Configuration_CallLogCoaching_Joined') 
 CREATE CLUSTERED INDEX IHash_View_HFit_Configuration_CallLogCoaching_Joined ON dbo.BASE_View_HFit_Configuration_CallLogCoaching_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = '_dta_index_BASE_OM_ContactGroupMember_8_1528496624__K3_K1_2_11') 
 CREATE NONCLUSTERED INDEX _dta_index_BASE_OM_ContactGroupMember_8_1528496624__K3_K1_2_11 ON dbo.BASE_OM_ContactGroupMember (  ContactGroupMemberRelatedID ASC  , ContactGroupMemberContactGroupID ASC  )   INCLUDE ( ContactGroupMemberType , LASTMODIFIEDDATE )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_DBPK_CMS_RelationshipNameSite') 
 CREATE NONCLUSTERED INDEX CI_DBPK_CMS_RelationshipNameSite ON dbo.BASE_CMS_RelationshipNameSite (  RelationshipNameID ASC  , SiteID ASC  )   INCLUDE ( DBNAME )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_BASE_HFit_TrackerTests') 
 CREATE NONCLUSTERED INDEX CI_BASE_HFit_TrackerTests ON dbo.BASE_HFit_TrackerTests (  SVR ASC  , DBNAME ASC  , ItemID ASC  )   INCLUDE ( HashCode , LASTMODIFIEDDATE )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_HFit_CoachingCommitToQuit') 
 CREATE CLUSTERED INDEX IHash_HFit_CoachingCommitToQuit ON dbo.BASE_HFit_CoachingCommitToQuit (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_DBPK_CMS_Banner') 
 CREATE NONCLUSTERED INDEX CI_DBPK_CMS_Banner ON dbo.BASE_CMS_Banner (  BannerID ASC  )   INCLUDE ( DBNAME )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_view_EDW_EligibilityHistory') 
 CREATE CLUSTERED INDEX IHash_view_EDW_EligibilityHistory ON dbo.BASE_view_EDW_EligibilityHistory (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_HFit_HealthAssessment_Joined') 
 CREATE CLUSTERED INDEX IHash_View_HFit_HealthAssessment_Joined ON dbo.BASE_View_HFit_HealthAssessment_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_HFit_SecurityQuestion_Joined') 
 CREATE CLUSTERED INDEX IHash_View_HFit_SecurityQuestion_Joined ON dbo.BASE_View_HFit_SecurityQuestion_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_BASE_HFit_HealthAssesmentUserQuestionGroupResults') 
 CREATE NONCLUSTERED INDEX CI_BASE_HFit_HealthAssesmentUserQuestionGroupResults ON dbo.BASE_HFit_HealthAssesmentUserQuestionGroupResults (  SVR ASC  , DBNAME ASC  , ItemID ASC  )   INCLUDE ( HashCode , LASTMODIFIEDDATE )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'PI_index_BASE_HFit_HealthAssesmentUserQue_8_447418205__K19_K9_3_11') 
 CREATE NONCLUSTERED INDEX PI_index_BASE_HFit_HealthAssesmentUserQue_8_447418205__K19_K9_3_11 ON dbo.BASE_HFit_HealthAssesmentUserQuestionGroupResults (  DBNAME ASC  , HARiskAreaItemID ASC  )   INCLUDE ( CodeName , PointResults )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_DBPK_CMS_BannerCategory') 
 CREATE NONCLUSTERED INDEX CI_DBPK_CMS_BannerCategory ON dbo.BASE_CMS_BannerCategory (  BannerCategoryID ASC  )   INCLUDE ( DBNAME )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_DBPK_CMS_InlineControl') 
 CREATE NONCLUSTERED INDEX CI_DBPK_CMS_InlineControl ON dbo.BASE_CMS_InlineControl (  ControlID ASC  )   INCLUDE ( DBNAME )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_HFit_HESChallenge_Joined') 
 CREATE CLUSTERED INDEX IHash_View_HFit_HESChallenge_Joined ON dbo.BASE_View_HFit_HESChallenge_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_BASE_HFIT_LKP_EDW_REJECTMPI') 
 CREATE NONCLUSTERED INDEX CI_BASE_HFIT_LKP_EDW_REJECTMPI ON dbo.BASE_HFIT_LKP_EDW_REJECTMPI (  SVR ASC  , DBNAME ASC  , ItemID ASC  )   INCLUDE ( HashCode , LASTMODIFIEDDATE )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_BASE_HFit_RewardGroup') 
 CREATE NONCLUSTERED INDEX CI_BASE_HFit_RewardGroup ON dbo.BASE_HFit_RewardGroup (  SVR ASC  , DBNAME ASC  , RewardGroupID ASC  )   INCLUDE ( HashCode , LASTMODIFIEDDATE )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_BASE_CMS_Document') 
 CREATE NONCLUSTERED INDEX CI_BASE_CMS_Document ON dbo.BASE_CMS_Document (  SVR ASC  , DBNAME ASC  , DocumentID ASC  )   INCLUDE ( HashCode , LASTMODIFIEDDATE )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_BASE_CMS_Site') 
 CREATE NONCLUSTERED INDEX CI_BASE_CMS_Site ON dbo.BASE_CMS_Site (  SVR ASC  , DBNAME ASC  , SiteID ASC  )   INCLUDE ( HashCode , LASTMODIFIEDDATE )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_DBPK_CMS_SearchEngine') 
 CREATE NONCLUSTERED INDEX CI_DBPK_CMS_SearchEngine ON dbo.BASE_CMS_SearchEngine (  SearchEngineID ASC  )   INCLUDE ( DBNAME )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_BASE_HFIT_Tracker') 
 CREATE NONCLUSTERED INDEX CI_BASE_HFIT_Tracker ON dbo.BASE_HFIT_Tracker (  SVR ASC  , DBNAME ASC  , ItemID ASC  )   INCLUDE ( HashCode , LASTMODIFIEDDATE )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_PM_ProjectTaskStatus_Joined') 
 CREATE CLUSTERED INDEX IHash_View_PM_ProjectTaskStatus_Joined ON dbo.BASE_View_PM_ProjectTaskStatus_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'SKey_BASE_view_EDW_BioMetrics_DEL') 
 CREATE NONCLUSTERED INDEX SKey_BASE_view_EDW_BioMetrics_DEL ON dbo.BASE_view_EDW_BioMetrics_DEL (  SurrogateKey_BASE_view_EDW_BioMetrics_DEL ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_ToDoHealthAssesmentCompleted') 
 CREATE CLUSTERED INDEX IHash_View_ToDoHealthAssesmentCompleted ON dbo.BASE_View_ToDoHealthAssesmentCompleted (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_HFit_UserCoachingAlert_NotMet_Step1') 
 CREATE CLUSTERED INDEX IHash_HFit_UserCoachingAlert_NotMet_Step1 ON dbo.BASE_HFit_UserCoachingAlert_NotMet_Step1 (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_DBPK_CMS_InlineControlSite') 
 CREATE NONCLUSTERED INDEX CI_DBPK_CMS_InlineControlSite ON dbo.BASE_CMS_InlineControlSite (  ControlID ASC  , SiteID ASC  )   INCLUDE ( DBNAME )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_HFit_UserCoachingAlert_NotMet_Step2') 
 CREATE CLUSTERED INDEX IHash_HFit_UserCoachingAlert_NotMet_Step2 ON dbo.BASE_HFit_UserCoachingAlert_NotMet_Step2 (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_HFit_HealthAssesmentPredefinedAnswer_Joined') 
 CREATE CLUSTERED INDEX IHash_View_HFit_HealthAssesmentPredefinedAnswer_Joined ON dbo.BASE_View_HFit_HealthAssesmentPredefinedAnswer_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'PK00_BASE_cms_user') 
 CREATE  UNIQUE NONCLUSTERED INDEX PK00_BASE_cms_user ON dbo.BASE_cms_user (  UserID ASC  , SVR ASC  , DBNAME ASC  )   INCLUDE ( HashCode , LASTMODIFIEDDATE )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'PI_BASE_CMS_Site_HA_LastPullDate') 
 CREATE NONCLUSTERED INDEX PI_BASE_CMS_Site_HA_LastPullDate ON dbo.BASE_CMS_Site_HA_LastPullDate (  LastPullDate DESC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_CMS_Tree_Joined_Regular') 
 CREATE CLUSTERED INDEX IHash_View_CMS_Tree_Joined_Regular ON dbo.BASE_View_CMS_Tree_Joined_Regular (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_BASE_HFit_TrackerTobaccoFree') 
 CREATE NONCLUSTERED INDEX CI_BASE_HFit_TrackerTobaccoFree ON dbo.BASE_HFit_TrackerTobaccoFree (  SVR ASC  , DBNAME ASC  , ItemID ASC  )   INCLUDE ( HashCode , LASTMODIFIEDDATE )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'UK00_BASE_HFit_TrackerTobaccoFree') 
 CREATE  UNIQUE NONCLUSTERED INDEX UK00_BASE_HFit_TrackerTobaccoFree ON dbo.BASE_HFit_TrackerTobaccoFree (  SurrogateKey_HFit_TrackerTobaccoFree ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_HFit_CoachingEnrollmentSyncStaging') 
 CREATE CLUSTERED INDEX IHash_HFit_CoachingEnrollmentSyncStaging ON dbo.BASE_HFit_CoachingEnrollmentSyncStaging (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'PI_MART_HA_ACCT_LastModifiedDate') 
 CREATE NONCLUSTERED INDEX PI_MART_HA_ACCT_LastModifiedDate ON dbo.BASE_MART_EDW_HealthAssesment (  ACCT_LastModifiedDate ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'PI_MART_HA_HAUserAnswers_LastModifiedDate') 
 CREATE NONCLUSTERED INDEX PI_MART_HA_HAUserAnswers_LastModifiedDate ON dbo.BASE_MART_EDW_HealthAssesment (  HAUserAnswers_LastModifiedDate ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'PI_MART_HA_HAUserRiskArea_LastModifiedDate') 
 CREATE NONCLUSTERED INDEX PI_MART_HA_HAUserRiskArea_LastModifiedDate ON dbo.BASE_MART_EDW_HealthAssesment (  HAUserRiskArea_LastModifiedDate ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_view_EDW_RoleEligibility') 
 CREATE CLUSTERED INDEX IHash_view_EDW_RoleEligibility ON dbo.BASE_view_EDW_RoleEligibility (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_BASE_HFit_UserCoachingAlert_NotMet_Step3_DEL') 
 CREATE CLUSTERED INDEX IHash_BASE_HFit_UserCoachingAlert_NotMet_Step3_DEL ON dbo.BASE_HFit_UserCoachingAlert_NotMet_Step3_DEL (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'temp_PI_EDW_Tracker_IDs') 
 CREATE CLUSTERED INDEX temp_PI_EDW_Tracker_IDs ON dbo.TEMP_EDW_Tracker_DATA (  TrackerNameAggregateTable ASC  , ItemID ASC  , ItemModifiedWhen ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_BASE_HFit_CoachingHealthArea') 
 CREATE NONCLUSTERED INDEX CI_BASE_HFit_CoachingHealthArea ON dbo.BASE_HFit_CoachingHealthArea (  SVR ASC  , DBNAME ASC  , CoachingHealthAreaID ASC  )   INCLUDE ( HashCode , LASTMODIFIEDDATE )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_CONTENT_Article_Joined') 
 CREATE CLUSTERED INDEX IHash_View_CONTENT_Article_Joined ON dbo.BASE_View_CONTENT_Article_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_DBPK_CMS_PageTemplateSite') 
 CREATE NONCLUSTERED INDEX CI_DBPK_CMS_PageTemplateSite ON dbo.BASE_CMS_PageTemplateSite (  PageTemplateID ASC  , SiteID ASC  )   INCLUDE ( DBNAME )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_Hfit_TimezoneConfiguration_Joined') 
 CREATE CLUSTERED INDEX IHash_View_Hfit_TimezoneConfiguration_Joined ON dbo.BASE_View_Hfit_TimezoneConfiguration_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_DBPK_CMS_AttachmentHistory') 
 CREATE NONCLUSTERED INDEX CI_DBPK_CMS_AttachmentHistory ON dbo.BASE_CMS_AttachmentHistory (  AttachmentHistoryID ASC  )   INCLUDE ( DBNAME )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_DBPK_CMS_TranslationSubmission') 
 CREATE NONCLUSTERED INDEX CI_DBPK_CMS_TranslationSubmission ON dbo.BASE_CMS_TranslationSubmission (  SubmissionID ASC  )   INCLUDE ( DBNAME )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'PI_BASE_HFit_HealthAssesmentUserRiskArea_HA_LastPullDate') 
 CREATE NONCLUSTERED INDEX PI_BASE_HFit_HealthAssesmentUserRiskArea_HA_LastPullDate ON dbo.BASE_HFit_HealthAssesmentUserRiskArea_HA_LastPullDate (  LastPullDate DESC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_Reporting_CategoryReport_Joined') 
 CREATE CLUSTERED INDEX IHash_View_Reporting_CategoryReport_Joined ON dbo.BASE_View_Reporting_CategoryReport_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_BASE_HFit_CoachingHealthInterest') 
 CREATE NONCLUSTERED INDEX CI_BASE_HFit_CoachingHealthInterest ON dbo.BASE_HFit_CoachingHealthInterest (  SVR ASC  , DBNAME ASC  , CoachingHealthInterestID ASC  )   INCLUDE ( HashCode , LASTMODIFIEDDATE )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'UK00_BASE_HFit_TrackerStressManagement') 
 CREATE  UNIQUE NONCLUSTERED INDEX UK00_BASE_HFit_TrackerStressManagement ON dbo.BASE_HFit_TrackerStressManagement (  SurrogateKey_HFit_TrackerStressManagement ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_Forums_GroupForumPost_Joined') 
 CREATE CLUSTERED INDEX IHash_View_Forums_GroupForumPost_Joined ON dbo.BASE_View_Forums_GroupForumPost_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'UK00_BASE_HFit_TrackerCotinine') 
 CREATE  UNIQUE NONCLUSTERED INDEX UK00_BASE_HFit_TrackerCotinine ON dbo.BASE_HFit_TrackerCotinine (  SurrogateKey_HFit_TrackerCotinine ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_DBPK_Board_Message') 
 CREATE NONCLUSTERED INDEX CI_DBPK_Board_Message ON dbo.BASE_Board_Message (  MessageID ASC  )   INCLUDE ( DBNAME )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'PI_BASE_EDW_RoleMemberToday_LAstMod') 
 CREATE NONCLUSTERED INDEX PI_BASE_EDW_RoleMemberToday_LAstMod ON dbo.BASE_EDW_RoleMemberToday (  DBNAME ASC  )   INCLUDE ( CTKey_EDW_RoleMemberToday )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_BASE_HFit_TrackerHeight') 
 CREATE NONCLUSTERED INDEX CI_BASE_HFit_TrackerHeight ON dbo.BASE_HFit_TrackerHeight (  SVR ASC  , DBNAME ASC  , ItemID ASC  )   INCLUDE ( HashCode , LASTMODIFIEDDATE )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'UK00_BASE_HFit_TrackerHeight') 
 CREATE  UNIQUE NONCLUSTERED INDEX UK00_BASE_HFit_TrackerHeight ON dbo.BASE_HFit_TrackerHeight (  SurrogateKey_HFit_TrackerHeight ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_CMS_WidgetCategoryWidget_Joined') 
 CREATE CLUSTERED INDEX IHash_View_CMS_WidgetCategoryWidget_Joined ON dbo.BASE_View_CMS_WidgetCategoryWidget_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_BASE_CMS_ResourceSite ') 
 CREATE NONCLUSTERED INDEX CI_BASE_CMS_ResourceSite  ON dbo.BASE_CMS_ResourceSite (  SVR ASC  , DBNAME ASC  , SurrogateKey_CMS_ResourceSite ASC  )   INCLUDE ( HashCode , LASTMODIFIEDDATE )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_hFit_ChallengePPTEligiblePostTemplate_Joined_KenticoCMS_1') 
 CREATE CLUSTERED INDEX IHash_View_hFit_ChallengePPTEligiblePostTemplate_Joined_KenticoCMS_1 ON dbo.BASE_View_hFit_ChallengePPTEligiblePostTemplate_Joined_KenticoCMS_1 (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_HFit_CoachingEvalHAOverall_Joined') 
 CREATE CLUSTERED INDEX IHash_View_HFit_CoachingEvalHAOverall_Joined ON dbo.BASE_View_HFit_CoachingEvalHAOverall_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_hFit_ChallengePPTEligiblePostTemplate_Joined_KenticoCMS_3') 
 CREATE CLUSTERED INDEX IHash_View_hFit_ChallengePPTEligiblePostTemplate_Joined_KenticoCMS_3 ON dbo.BASE_View_hFit_ChallengePPTEligiblePostTemplate_Joined_KenticoCMS_3 (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_HFit_ChallengePPTEligibleCDPostTemplate_Joined') 
 CREATE NONCLUSTERED INDEX IHash_View_HFit_ChallengePPTEligibleCDPostTemplate_Joined ON dbo.BASE_View_HFit_ChallengePPTEligibleCDPostTemplate_Joined (  HashCode ASC  )   INCLUDE ( DBNAME )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_CONTENT_File_Joined') 
 CREATE CLUSTERED INDEX IHash_View_CONTENT_File_Joined ON dbo.BASE_View_CONTENT_File_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_DBPK_CMS_Personalization') 
 CREATE NONCLUSTERED INDEX CI_DBPK_CMS_Personalization ON dbo.BASE_CMS_Personalization (  PersonalizationID ASC  )   INCLUDE ( DBNAME )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_view_hfit_challengeOffering_Joined') 
 CREATE CLUSTERED INDEX IHash_view_hfit_challengeOffering_Joined ON dbo.BASE_view_hfit_challengeOffering_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_BASE_HFit_LKP_RewardLevelType') 
 CREATE NONCLUSTERED INDEX CI_BASE_HFit_LKP_RewardLevelType ON dbo.BASE_HFit_LKP_RewardLevelType (  SVR ASC  , DBNAME ASC  , RewardLevelTypeLKPID ASC  )   INCLUDE ( HashCode , LASTMODIFIEDDATE )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_HFit_CoachingEvalHAQA') 
 CREATE CLUSTERED INDEX IHash_HFit_CoachingEvalHAQA ON dbo.BASE_HFit_CoachingEvalHAQA (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_Hfit_MarketplaceProduct_Joined') 
 CREATE CLUSTERED INDEX IHash_View_Hfit_MarketplaceProduct_Joined ON dbo.BASE_View_Hfit_MarketplaceProduct_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_HFit_OutComeMessages_Joined') 
 CREATE CLUSTERED INDEX IHash_View_HFit_OutComeMessages_Joined ON dbo.BASE_View_HFit_OutComeMessages_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_HFit_CoachingMyGoalsSettings_Joined') 
 CREATE CLUSTERED INDEX IHash_View_HFit_CoachingMyGoalsSettings_Joined ON dbo.BASE_View_HFit_CoachingMyGoalsSettings_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_DBPK_CMS_AutomationHistory') 
 CREATE NONCLUSTERED INDEX CI_DBPK_CMS_AutomationHistory ON dbo.BASE_CMS_AutomationHistory (  HistoryID ASC  )   INCLUDE ( DBNAME )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_BASE_HFit_UserTracker') 
 CREATE NONCLUSTERED INDEX CI_BASE_HFit_UserTracker ON dbo.BASE_HFit_UserTracker (  SVR ASC  , DBNAME ASC  , ItemID ASC  )   INCLUDE ( HashCode , LASTMODIFIEDDATE )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_view_hfit_HealthSummarySettings_Joined') 
 CREATE CLUSTERED INDEX IHash_view_hfit_HealthSummarySettings_Joined ON dbo.BASE_view_hfit_HealthSummarySettings_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = '<Name of Missing Index, sysname,>') 
 CREATE NONCLUSTERED INDEX <Name of Missing Index, sysname,> ON dbo.BASE_CMS_Document (  DocumentCulture ASC  )   INCLUDE ( DBNAME , DocumentForeignKeyValue , DocumentNodeID , SVR )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_DBPK_CMS_Transformation') 
 CREATE NONCLUSTERED INDEX CI_DBPK_CMS_Transformation ON dbo.BASE_CMS_Transformation (  TransformationID ASC  )   INCLUDE ( DBNAME )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_HFit_CoachingHATemporalContainer') 
 CREATE CLUSTERED INDEX IHash_HFit_CoachingHATemporalContainer ON dbo.BASE_HFit_CoachingHATemporalContainer (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_BASE_view_EDW_BioMetrics_DEL') 
 CREATE NONCLUSTERED INDEX IHash_BASE_view_EDW_BioMetrics_DEL ON dbo.BASE_view_EDW_BioMetrics_DEL (  HashCode ASC  )   INCLUDE ( DBNAME )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_hfit_challengeGeneralSettings_Joined') 
 CREATE CLUSTERED INDEX IHash_View_hfit_challengeGeneralSettings_Joined ON dbo.BASE_View_hfit_challengeGeneralSettings_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_BASE_HFit_TrackerMedicalCarePlan') 
 CREATE NONCLUSTERED INDEX CI_BASE_HFit_TrackerMedicalCarePlan ON dbo.BASE_HFit_TrackerMedicalCarePlan (  SVR ASC  , DBNAME ASC  , ItemID ASC  )   INCLUDE ( HashCode , LASTMODIFIEDDATE )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'UK00_BASE_HFit_TrackerMedicalCarePlan') 
 CREATE  UNIQUE NONCLUSTERED INDEX UK00_BASE_HFit_TrackerMedicalCarePlan ON dbo.BASE_HFit_TrackerMedicalCarePlan (  SurrogateKey_HFit_TrackerMedicalCarePlan ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_HFit_GoalSubCategory_Joined') 
 CREATE CLUSTERED INDEX IHash_View_HFit_GoalSubCategory_Joined ON dbo.BASE_View_HFit_GoalSubCategory_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_hfit_CoachingCMTemporalContainer_Joined') 
 CREATE CLUSTERED INDEX IHash_View_hfit_CoachingCMTemporalContainer_Joined ON dbo.BASE_View_hfit_CoachingCMTemporalContainer_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_HFit_Configuration_LMCoaching_Joined') 
 CREATE CLUSTERED INDEX IHash_View_HFit_Configuration_LMCoaching_Joined ON dbo.BASE_View_HFit_Configuration_LMCoaching_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_BASE_HFit_HealthAssesmentRiskArea') 
 CREATE NONCLUSTERED INDEX CI_BASE_HFit_HealthAssesmentRiskArea ON dbo.BASE_HFit_HealthAssesmentRiskArea (  SVR ASC  , DBNAME ASC  , HealthAssesmentRiskAreaID ASC  )   INCLUDE ( HashCode , LASTMODIFIEDDATE )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'PI_EDW_HealthInterestList') 
 CREATE CLUSTERED INDEX PI_EDW_HealthInterestList ON dbo.DIM_EDW_HealthInterestList (  HealthAreaID ASC  , NodeID ASC  , NodeGuid ASC  , AccountCD ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_DBPK_CMS_AutomationState') 
 CREATE NONCLUSTERED INDEX CI_DBPK_CMS_AutomationState ON dbo.BASE_CMS_AutomationState (  StateID ASC  )   INCLUDE ( DBNAME )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'PI_index_BASE_HFit_HealthAssesmentUserSta_8_1935423506__K16_K34_K33_K27_K2_3_11_12_13_15_19_25_26') 
 CREATE NONCLUSTERED INDEX PI_index_BASE_HFit_HealthAssesmentUserSta_8_1935423506__K16_K34_K33_K27_K2_3_11_12_13_15_19_25_26 ON dbo.BASE_HFit_HealthAssesmentUserStarted (  HACampaignNodeGUID ASC  , DBNAME ASC  , SVR ASC  , ItemID ASC  , UserID ASC  )   INCLUDE ( HACompletedDt , HACompletedMode , HADocumentConfigID , HAPaperFlg , HAScore , HAStartedDt , HAStartedMode , HATelephonicFlg )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'UK00_BASE_HFit_TrackerRestingHeartRate') 
 CREATE  UNIQUE NONCLUSTERED INDEX UK00_BASE_HFit_TrackerRestingHeartRate ON dbo.BASE_HFit_TrackerRestingHeartRate (  SurrogateKey_HFit_TrackerRestingHeartRate ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = '_dta_index_BASE_HFit_ContactGroupMembership_8_887726265__K1_15') 
 CREATE NONCLUSTERED INDEX _dta_index_BASE_HFit_ContactGroupMembership_8_887726265__K1_15 ON dbo.BASE_HFit_ContactGroupMembership (  cmsMembershipID ASC  )   INCLUDE ( LASTMODIFIEDDATE )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'UK00_BASE_HFit_TrackerHighFatFoods') 
 CREATE  UNIQUE NONCLUSTERED INDEX UK00_BASE_HFit_TrackerHighFatFoods ON dbo.BASE_HFit_TrackerHighFatFoods (  SurrogateKey_HFit_TrackerHighFatFoods ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_HFit_Pillar_Joined') 
 CREATE CLUSTERED INDEX IHash_View_HFit_Pillar_Joined ON dbo.BASE_View_HFit_Pillar_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_DBPK_CMS_OpenIDUser') 
 CREATE NONCLUSTERED INDEX CI_DBPK_CMS_OpenIDUser ON dbo.BASE_CMS_OpenIDUser (  OpenIDUserID ASC  )   INCLUDE ( DBNAME )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'PI_EDW_RewardUserDetail_RowNbrCDate') 
 CREATE NONCLUSTERED INDEX PI_EDW_RewardUserDetail_RowNbrCDate ON dbo.DIM_EDW_RewardUserDetail (  RowNbr ASC  , LastModifiedDate ASC  , DeletedFlg ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_DBPK_CMS_ACL') 
 CREATE NONCLUSTERED INDEX CI_DBPK_CMS_ACL ON dbo.BASE_CMS_ACL (  ACLID ASC  )   INCLUDE ( DBNAME )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_HFit_RewardGroup_Joined') 
 CREATE CLUSTERED INDEX IHash_View_HFit_RewardGroup_Joined ON dbo.BASE_View_HFit_RewardGroup_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_view_ToDoCoachingEnrollmentCompleted') 
 CREATE CLUSTERED INDEX IHash_view_ToDoCoachingEnrollmentCompleted ON dbo.BASE_view_ToDoCoachingEnrollmentCompleted (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_view_EDW_HealthAssesment') 
 CREATE CLUSTERED INDEX IHash_view_EDW_HealthAssesment ON dbo.BASE_view_EDW_HealthAssesment (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_FACT_TrackerData_LastModifiedDate') 
 CREATE NONCLUSTERED INDEX CI_FACT_TrackerData_LastModifiedDate ON dbo.FACT_TrackerData (  DBNAME ASC  , TrackerName ASC  )   INCLUDE ( LASTMODIFIEDDATE , UserID )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IDX_DBNAME_SurrogateKey_HFit_TrackerBloodPressure') 
 CREATE NONCLUSTERED INDEX IDX_DBNAME_SurrogateKey_HFit_TrackerBloodPressure ON dbo.FACT_TrackerData (  TrackerName ASC  )   INCLUDE ( DBNAME , SurrogateKey_HFit_TrackerBloodPressure )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IDX_DBNAME_SurrogateKey_HFit_TrackerHeight') 
 CREATE NONCLUSTERED INDEX IDX_DBNAME_SurrogateKey_HFit_TrackerHeight ON dbo.FACT_TrackerData (  TrackerName ASC  )   INCLUDE ( DBNAME , SurrogateKey_HFit_TrackerHeight )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IDX_DBNAME_SurrogateKey_HFit_TrackerInstance_Tracker') 
 CREATE NONCLUSTERED INDEX IDX_DBNAME_SurrogateKey_HFit_TrackerInstance_Tracker ON dbo.FACT_TrackerData (  TrackerName ASC  )   INCLUDE ( DBNAME , SurrogateKey_HFit_TrackerInstance_Tracker )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IDX_DBNAME_SurrogateKey_HFit_TrackerPreventiveCare') 
 CREATE NONCLUSTERED INDEX IDX_DBNAME_SurrogateKey_HFit_TrackerPreventiveCare ON dbo.FACT_TrackerData (  TrackerName ASC  )   INCLUDE ( DBNAME , SurrogateKey_HFit_TrackerPreventiveCare )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IDX_DBNAME_SurrogateKey_HFit_TrackerWholeGrains') 
 CREATE NONCLUSTERED INDEX IDX_DBNAME_SurrogateKey_HFit_TrackerWholeGrains ON dbo.FACT_TrackerData (  TrackerName ASC  )   INCLUDE ( DBNAME , SurrogateKey_HFit_TrackerWholeGrains )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'PI000_FACT_TrackerData') 
 CREATE NONCLUSTERED INDEX PI000_FACT_TrackerData ON dbo.FACT_TrackerData (  SVR ASC  )   INCLUDE ( RowNumber )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_BASE_HFit_Account') 
 CREATE NONCLUSTERED INDEX CI_BASE_HFit_Account ON dbo.BASE_HFIT_Account (  SVR ASC  , DBNAME ASC  , AccountID ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_HFit_ProgramFeedNotificationSettings_Joined') 
 CREATE CLUSTERED INDEX IHash_View_HFit_ProgramFeedNotificationSettings_Joined ON dbo.BASE_View_HFit_ProgramFeedNotificationSettings_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_DBPK_CMS_SettingsCategory') 
 CREATE NONCLUSTERED INDEX CI_DBPK_CMS_SettingsCategory ON dbo.BASE_CMS_SettingsCategory (  CategoryID ASC  )   INCLUDE ( DBNAME )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'PKI_HFITUSERMPINUMBER') 
 CREATE CLUSTERED INDEX PKI_HFITUSERMPINUMBER ON dbo.HFIT_LKP_EDW_ALLOWED_MPI (  HFITUSERMPINUMBER ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_CMS_WebPartCategoryWebpart_Joined') 
 CREATE CLUSTERED INDEX IHash_View_CMS_WebPartCategoryWebpart_Joined ON dbo.BASE_View_CMS_WebPartCategoryWebpart_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_EDW_HealthAssesmentQuestions') 
 CREATE CLUSTERED INDEX IHash_View_EDW_HealthAssesmentQuestions ON dbo.BASE_View_EDW_HealthAssesmentQuestions (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_Hfit_CoachingSystemSettings') 
 CREATE CLUSTERED INDEX IHash_Hfit_CoachingSystemSettings ON dbo.BASE_Hfit_CoachingSystemSettings (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_HFit_CoachingCallLogTemporalContainer') 
 CREATE CLUSTERED INDEX IHash_HFit_CoachingCallLogTemporalContainer ON dbo.BASE_HFit_CoachingCallLogTemporalContainer (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_TEMPEdwNewHAHashkeys') 
 CREATE CLUSTERED INDEX CI_TEMPEdwNewHAHashkeys ON dbo.LKUP_NewEdwHAHashkeys (  PKHASHCODE ASC  , HAUSERSTARTED_ITEMID ASC  , HASHCODE ASC  , USERGUID ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_Hfit_TipOfTheDayCategory_Joined') 
 CREATE CLUSTERED INDEX IHash_View_Hfit_TipOfTheDayCategory_Joined ON dbo.BASE_View_Hfit_TipOfTheDayCategory_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'PI_BASE_HFit_Account_HA_LastPullDate') 
 CREATE NONCLUSTERED INDEX PI_BASE_HFit_Account_HA_LastPullDate ON dbo.BASE_HFit_Account_HA_LastPullDate (  LastPullDate DESC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_HFit_Newsletter_Joined') 
 CREATE CLUSTERED INDEX IHash_View_HFit_Newsletter_Joined ON dbo.BASE_View_HFit_Newsletter_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'PI_BASE_HFit_HealthAssesmentUserModule_HA_LastPullDate') 
 CREATE NONCLUSTERED INDEX PI_BASE_HFit_HealthAssesmentUserModule_HA_LastPullDate ON dbo.BASE_HFit_HealthAssesmentUserModule_HA_LastPullDate (  LastPullDate DESC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_HFit_CoachingHealthArea_Joined') 
 CREATE CLUSTERED INDEX IHash_View_HFit_CoachingHealthArea_Joined ON dbo.BASE_View_HFit_CoachingHealthArea_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = '_dta_index_BASE_OM_ContactGroup_8_1352495997__K10_1_2_14') 
 CREATE NONCLUSTERED INDEX _dta_index_BASE_OM_ContactGroup_8_1352495997__K10_1_2_14 ON dbo.BASE_OM_ContactGroup (  ContactGroupID ASC  )   INCLUDE ( ContactGroupDisplayName , ContactGroupName , LASTMODIFIEDDATE )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_DBPK_CMS_ScheduledTask') 
 CREATE NONCLUSTERED INDEX CI_DBPK_CMS_ScheduledTask ON dbo.BASE_CMS_ScheduledTask (  TaskID ASC  )   INCLUDE ( DBNAME )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_HFit_Tobacco_Goal_Joined') 
 CREATE CLUSTERED INDEX IHash_View_HFit_Tobacco_Goal_Joined ON dbo.BASE_View_HFit_Tobacco_Goal_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_view_EDW_ScreeningsFromTrackers') 
 CREATE CLUSTERED INDEX IHash_view_EDW_ScreeningsFromTrackers ON dbo.BASE_view_EDW_ScreeningsFromTrackers (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_HFit_CoachingTermsAndConditionsSettings') 
 CREATE CLUSTERED INDEX IHash_HFit_CoachingTermsAndConditionsSettings ON dbo.BASE_HFit_CoachingTermsAndConditionsSettings (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_BASE_HFit_ToDoSmallSteps') 
 CREATE NONCLUSTERED INDEX CI_BASE_HFit_ToDoSmallSteps ON dbo.BASE_HFit_ToDoSmallSteps (  SVR ASC  , DBNAME ASC  , ItemID ASC  )   INCLUDE ( HashCode , LASTMODIFIEDDATE )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_DBPK_CMS_DocumentCategory') 
 CREATE NONCLUSTERED INDEX CI_DBPK_CMS_DocumentCategory ON dbo.BASE_CMS_DocumentCategory (  CategoryID ASC  , DocumentID ASC  )   INCLUDE ( DBNAME )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_HFit_RewardParameterJoined') 
 CREATE CLUSTERED INDEX IHash_View_HFit_RewardParameterJoined ON dbo.BASE_View_HFit_RewardParameterJoined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'PKIDX_MART_View_Hierarchy') 
 CREATE  UNIQUE CLUSTERED INDEX PKIDX_MART_View_Hierarchy ON dbo.MART_View_Hierarchy (  ParentName ASC  , RowID ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'Pkey_MART_ViewColumns') 
 CREATE  UNIQUE CLUSTERED INDEX Pkey_MART_ViewColumns ON dbo.MART_ViewColumns (  name ASC  , column ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_HFit_HealthAssesmentMatrixQuestion_Joined') 
 CREATE CLUSTERED INDEX IHash_View_HFit_HealthAssesmentMatrixQuestion_Joined ON dbo.BASE_View_HFit_HealthAssesmentMatrixQuestion_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'UK_MASTER_LKP_CTVersion') 
 CREATE  UNIQUE NONCLUSTERED INDEX UK_MASTER_LKP_CTVersion ON dbo.MASTER_LKP_CTVersion (  ProcedureID ASC  , SYS_CHANGE_VERSION ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_CMS_SiteRoleResourceUIElement_Joined') 
 CREATE CLUSTERED INDEX IHash_View_CMS_SiteRoleResourceUIElement_Joined ON dbo.BASE_View_CMS_SiteRoleResourceUIElement_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_HFit_LKP_CoachingAuditLogType') 
 CREATE CLUSTERED INDEX IHash_HFit_LKP_CoachingAuditLogType ON dbo.BASE_HFit_LKP_CoachingAuditLogType (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'UK00_BASE_HFit_TrackerTests') 
 CREATE  UNIQUE NONCLUSTERED INDEX UK00_BASE_HFit_TrackerTests ON dbo.BASE_HFit_TrackerTests (  SurrogateKey_HFit_TrackerTests ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_EDW_HFIT_HealthAssesmentUserRiskArea_Joined') 
 CREATE CLUSTERED INDEX IHash_View_EDW_HFIT_HealthAssesmentUserRiskArea_Joined ON dbo.BASE_View_EDW_HFIT_HealthAssesmentUserRiskArea_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_DBPK_CMS_AlternativeForm') 
 CREATE NONCLUSTERED INDEX CI_DBPK_CMS_AlternativeForm ON dbo.BASE_CMS_AlternativeForm (  FormID ASC  )   INCLUDE ( DBNAME )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_BASE_View_EDW_HFIT_HealthAssesmentUserRiskArea_Joined_DEL') 
 CREATE CLUSTERED INDEX IHash_BASE_View_EDW_HFIT_HealthAssesmentUserRiskArea_Joined_DEL ON dbo.BASE_View_EDW_HFIT_HealthAssesmentUserRiskArea_Joined_DEL (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_HFIT_Configuration_CMCoaching') 
 CREATE CLUSTERED INDEX IHash_HFIT_Configuration_CMCoaching ON dbo.BASE_HFIT_Configuration_CMCoaching (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_DBPK_CMS_TimeZone') 
 CREATE NONCLUSTERED INDEX CI_DBPK_CMS_TimeZone ON dbo.BASE_CMS_TimeZone (  TimeZoneID ASC  )   INCLUDE ( DBNAME )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_BASE_view_CMS_USER_DEL') 
 CREATE CLUSTERED INDEX IHash_BASE_view_CMS_USER_DEL ON dbo.BASE_view_CMS_USER_DEL (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_DBPK_CMS_Resource') 
 CREATE NONCLUSTERED INDEX CI_DBPK_CMS_Resource ON dbo.BASE_CMS_Resource (  ResourceID ASC  )   INCLUDE ( DBNAME )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_HFit_HSHealthMeasuresSettings_Joined') 
 CREATE CLUSTERED INDEX IHash_View_HFit_HSHealthMeasuresSettings_Joined ON dbo.BASE_View_HFit_HSHealthMeasuresSettings_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_DBPK_CMS_AbuseReport') 
 CREATE NONCLUSTERED INDEX CI_DBPK_CMS_AbuseReport ON dbo.BASE_CMS_AbuseReport (  ReportID ASC  )   INCLUDE ( DBNAME )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'PI_BASE_HFit_HealthAssesmentUserAnswers_HA_LastPullDate') 
 CREATE NONCLUSTERED INDEX PI_BASE_HFit_HealthAssesmentUserAnswers_HA_LastPullDate ON dbo.BASE_HFit_HealthAssesmentUserAnswers_HA_LastPullDate (  LastPullDate DESC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_HFit_HealthAssessment_Joined_DEL') 
 CREATE CLUSTERED INDEX IHash_View_HFit_HealthAssessment_Joined_DEL ON dbo.View_HFit_HealthAssessment_Joined_DEL (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_DBPK_CMS_Avatar') 
 CREATE NONCLUSTERED INDEX CI_DBPK_CMS_Avatar ON dbo.BASE_CMS_Avatar (  AvatarID ASC  )   INCLUDE ( DBNAME )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'SKey_View_HFit_ChallengePPTRegisteredPostTemplate_Joined') 
 CREATE NONCLUSTERED INDEX SKey_View_HFit_ChallengePPTRegisteredPostTemplate_Joined ON dbo.BASE_View_HFit_ChallengePPTRegisteredPostTemplate_Joined (  SurrogateKey_View_HFit_ChallengePPTRegisteredPostTemplate_Joined ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_DBPK_CMS_VersionAttachment') 
 CREATE NONCLUSTERED INDEX CI_DBPK_CMS_VersionAttachment ON dbo.BASE_CMS_VersionAttachment (  AttachmentHistoryID ASC  , VersionHistoryID ASC  )   INCLUDE ( DBNAME )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_DBPK_CMS_Query') 
 CREATE NONCLUSTERED INDEX CI_DBPK_CMS_Query ON dbo.BASE_CMS_Query (  QueryID ASC  )   INCLUDE ( DBNAME )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_HFit_HealthAssesmentQuestionTitleIDX') 
 CREATE CLUSTERED INDEX IHash_View_HFit_HealthAssesmentQuestionTitleIDX ON dbo.BASE_View_HFit_HealthAssesmentQuestionTitleIDX (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_DBPK_CMS_RolePermission') 
 CREATE NONCLUSTERED INDEX CI_DBPK_CMS_RolePermission ON dbo.BASE_CMS_RolePermission (  PermissionID ASC  , RoleID ASC  )   INCLUDE ( DBNAME )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IDX_DBNAME_SurrogateKey_HFit_TrackerBodyFat') 
 CREATE NONCLUSTERED INDEX IDX_DBNAME_SurrogateKey_HFit_TrackerBodyFat ON dbo.FACT_TrackerData (  TrackerName ASC  )   INCLUDE ( DBNAME , SurrogateKey_HFit_TrackerBodyFat )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IDX_DBNAME_SurrogateKey_HFit_TrackerCholesterol') 
 CREATE NONCLUSTERED INDEX IDX_DBNAME_SurrogateKey_HFit_TrackerCholesterol ON dbo.FACT_TrackerData (  TrackerName ASC  )   INCLUDE ( DBNAME , SurrogateKey_HFit_TrackerCholesterol )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IDX_DBNAME_SurrogateKey_HFit_TrackerShots') 
 CREATE NONCLUSTERED INDEX IDX_DBNAME_SurrogateKey_HFit_TrackerShots ON dbo.FACT_TrackerData (  TrackerName ASC  )   INCLUDE ( DBNAME , SurrogateKey_HFit_TrackerShots )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IDX_DBNAME_SurrogateKey_HFit_TrackerStrength') 
 CREATE NONCLUSTERED INDEX IDX_DBNAME_SurrogateKey_HFit_TrackerStrength ON dbo.FACT_TrackerData (  TrackerName ASC  )   INCLUDE ( DBNAME , SurrogateKey_HFit_TrackerStrength )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IDX_DBNAME_SurrogateKey_HFit_TrackerSugaryDrinks') 
 CREATE NONCLUSTERED INDEX IDX_DBNAME_SurrogateKey_HFit_TrackerSugaryDrinks ON dbo.FACT_TrackerData (  TrackerName ASC  )   INCLUDE ( DBNAME , SurrogateKey_HFit_TrackerSugaryDrinks )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'PI_CMS_Document_NodeClassID_SVR') 
 CREATE NONCLUSTERED INDEX PI_CMS_Document_NodeClassID_SVR ON dbo.BASE_CMS_Tree (  NodeClassID ASC  , SVR ASC  )   INCLUDE ( NodeGUID , NodeLinkedNodeID , NodeSiteID )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_view_EDW_CoachingPPTAvailable_DEL') 
 CREATE CLUSTERED INDEX IHash_view_EDW_CoachingPPTAvailable_DEL ON dbo.view_EDW_CoachingPPTAvailable_DEL (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = '_dta_index_BASE_CMS_MembershipRole_8_1252199511__K1_K2_6_10_11') 
 CREATE NONCLUSTERED INDEX _dta_index_BASE_CMS_MembershipRole_8_1252199511__K1_K2_6_10_11 ON dbo.BASE_CMS_MembershipRole (  MembershipID ASC  , RoleID ASC  )   INCLUDE ( CT_MembershipID , CT_RoleID , LASTMODIFIEDDATE )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_DBPK_CMS_MembershipRole') 
 CREATE NONCLUSTERED INDEX CI_DBPK_CMS_MembershipRole ON dbo.BASE_CMS_MembershipRole (  MembershipID ASC  , RoleID ASC  )   INCLUDE ( DBNAME )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_DBPK_CMS_Relationship') 
 CREATE NONCLUSTERED INDEX CI_DBPK_CMS_Relationship ON dbo.BASE_CMS_Relationship (  RelationshipID ASC  )   INCLUDE ( DBNAME )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_HFit_WellnessGoal_Joined') 
 CREATE CLUSTERED INDEX IHash_View_HFit_WellnessGoal_Joined ON dbo.BASE_View_HFit_WellnessGoal_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_BASE_HFit_LKP_RewardActivity') 
 CREATE NONCLUSTERED INDEX CI_BASE_HFit_LKP_RewardActivity ON dbo.BASE_HFit_LKP_RewardActivity (  SVR ASC  , DBNAME ASC  , RewardActivityLKPID ASC  )   INCLUDE ( HashCode , LASTMODIFIEDDATE )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'SKey_BASE_View_CMS_EventLog_DEL') 
 CREATE NONCLUSTERED INDEX SKey_BASE_View_CMS_EventLog_DEL ON dbo.BASE_View_CMS_EventLog_DEL (  SurrogateKey_BASE_View_CMS_EventLog_DEL ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_HFit_ScreeningEventCategory_Joined') 
 CREATE CLUSTERED INDEX IHash_View_HFit_ScreeningEventCategory_Joined ON dbo.BASE_View_HFit_ScreeningEventCategory_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_DBPK_CMS_DeviceProfile') 
 CREATE NONCLUSTERED INDEX CI_DBPK_CMS_DeviceProfile ON dbo.BASE_CMS_DeviceProfile (  ProfileID ASC  )   INCLUDE ( DBNAME )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_CONTENT_Laptop_Joined') 
 CREATE CLUSTERED INDEX IHash_View_CONTENT_Laptop_Joined ON dbo.BASE_View_CONTENT_Laptop_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_view_EDW_CoachingPPTEnrolled') 
 CREATE CLUSTERED INDEX IHash_view_EDW_CoachingPPTEnrolled ON dbo.BASE_view_EDW_CoachingPPTEnrolled (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_DBPK_CMS_RelationshipName') 
 CREATE NONCLUSTERED INDEX CI_DBPK_CMS_RelationshipName ON dbo.BASE_CMS_RelationshipName (  RelationshipNameID ASC  )   INCLUDE ( DBNAME )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_BASE_HFit_HealthAssessment') 
 CREATE NONCLUSTERED INDEX CI_BASE_HFit_HealthAssessment ON dbo.BASE_HFit_HealthAssessment (  SVR ASC  , DBNAME ASC  , HealthAssessmentID ASC  )   INCLUDE ( HashCode , LASTMODIFIEDDATE )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_BASE_HFit_TrackerInstance_Tracker') 
 CREATE NONCLUSTERED INDEX CI_BASE_HFit_TrackerInstance_Tracker ON dbo.BASE_HFit_TrackerInstance_Tracker (  SVR ASC  , DBNAME ASC  , ItemID ASC  )   INCLUDE ( HashCode , LASTMODIFIEDDATE )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'UK00_BASE_HFit_TrackerInstance_Tracker') 
 CREATE  UNIQUE NONCLUSTERED INDEX UK00_BASE_HFit_TrackerInstance_Tracker ON dbo.BASE_HFit_TrackerInstance_Tracker (  SurrogateKey_HFit_TrackerInstance_Tracker ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_HFit_CoachingCommitToQuit_Joined') 
 CREATE CLUSTERED INDEX IHash_View_HFit_CoachingCommitToQuit_Joined ON dbo.BASE_View_HFit_CoachingCommitToQuit_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_BASE_View_CMS_Tree_Joined_DEL') 
 CREATE CLUSTERED INDEX IHash_BASE_View_CMS_Tree_Joined_DEL ON dbo.BASE_View_CMS_Tree_Joined_DEL (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'PKIDX_MART_Tests_Criteria') 
 CREATE  UNIQUE CLUSTERED INDEX PKIDX_MART_Tests_Criteria ON dbo.MART_Tests_Criteria (  ParentName ASC  , RowID ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_OM_ContactGroupMember_ContactJoined') 
 CREATE CLUSTERED INDEX IHash_View_OM_ContactGroupMember_ContactJoined ON dbo.BASE_View_OM_ContactGroupMember_ContactJoined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_HFit_CoachingEvalHARiskArea_Joined') 
 CREATE CLUSTERED INDEX IHash_View_HFit_CoachingEvalHARiskArea_Joined ON dbo.BASE_View_HFit_CoachingEvalHARiskArea_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_hfit_ChallengeTeam_Joined') 
 CREATE CLUSTERED INDEX IHash_View_hfit_ChallengeTeam_Joined ON dbo.BASE_View_hfit_ChallengeTeam_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_BASE_View_HFit_ChallengePostTemplate_Joined') 
 CREATE CLUSTERED INDEX IHash_BASE_View_HFit_ChallengePostTemplate_Joined ON dbo.BASE_BASE_View_HFit_ChallengePostTemplate_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_BASE_HFit_HealthAssessmentFreeForm') 
 CREATE NONCLUSTERED INDEX CI_BASE_HFit_HealthAssessmentFreeForm ON dbo.BASE_HFit_HealthAssessmentFreeForm (  SVR ASC  , DBNAME ASC  , HealthAssesmentMultipleChoiceQuestionID ASC  )   INCLUDE ( HashCode , LASTMODIFIEDDATE )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_Hfit_CoachingUserCMCondition') 
 CREATE CLUSTERED INDEX IHash_Hfit_CoachingUserCMCondition ON dbo.BASE_Hfit_CoachingUserCMCondition (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_HFit_CoachingEnrollmentReport') 
 CREATE CLUSTERED INDEX IHash_HFit_CoachingEnrollmentReport ON dbo.BASE_HFit_CoachingEnrollmentReport (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_CMS_UserSettingsRole_Joined') 
 CREATE CLUSTERED INDEX IHash_View_CMS_UserSettingsRole_Joined ON dbo.BASE_View_CMS_UserSettingsRole_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_HFit_CoachingTermsAndConditionsSettings_Joined') 
 CREATE CLUSTERED INDEX IHash_View_HFit_CoachingTermsAndConditionsSettings_Joined ON dbo.BASE_View_HFit_CoachingTermsAndConditionsSettings_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_HFit_HAWelcomeSettings_Joined') 
 CREATE CLUSTERED INDEX IHash_View_HFit_HAWelcomeSettings_Joined ON dbo.BASE_View_HFit_HAWelcomeSettings_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'PI_STAGED_EDW_CMS_USER') 
 CREATE CLUSTERED INDEX PI_STAGED_EDW_CMS_USER ON dbo.STAGED_EDW_CMS_USER (  USERID ASC  , USERGUID ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_hfit_ChallengeTeams_Joined') 
 CREATE CLUSTERED INDEX IHash_View_hfit_ChallengeTeams_Joined ON dbo.BASE_View_hfit_ChallengeTeams_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_DBPK_CMS_Document') 
 CREATE NONCLUSTERED INDEX CI_DBPK_CMS_Document ON dbo.BASE_CMS_Document (  DocumentID ASC  )   INCLUDE ( DBNAME )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'PI_EDW_CMS_USERSITE_UID') 
 CREATE NONCLUSTERED INDEX PI_EDW_CMS_USERSITE_UID ON dbo.STAGED_EDW_CMS_USERSITE (  USERID ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_CONTENT_Event_Joined') 
 CREATE CLUSTERED INDEX IHash_View_CONTENT_Event_Joined ON dbo.BASE_View_CONTENT_Event_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_HFit_Configuration_Joined') 
 CREATE CLUSTERED INDEX IHash_View_HFit_Configuration_Joined ON dbo.BASE_View_HFit_Configuration_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = '_dta_index_BASE_CMS_Site_8_1878297751__K14_1_2_9_18_90_91_98') 
 CREATE NONCLUSTERED INDEX _dta_index_BASE_CMS_Site_8_1878297751__K14_1_2_9_18_90_91_98 ON dbo.BASE_CMS_Site (  SiteID ASC  )   INCLUDE ( CT_SiteDisplayName , CT_SiteGUID , CT_SiteName , LASTMODIFIEDDATE , SiteDisplayName , SiteGUID , SiteName )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'PI_STAGED_EDW_CombinedHAViews') 
 CREATE CLUSTERED INDEX PI_STAGED_EDW_CombinedHAViews ON dbo.STAGED_EDW_CombinedHAViews (  USERRISKCATEGORYITEMID ASC  , USERRISKAREAITEMID ASC  , HARISKAREANODEGUID ASC  , USERQUESTIONITEMID ASC  , HAQUESTIONGUID ASC  , HAQUESTIONNODEGUID ASC  , HAANSWERNODEGUID ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'PI_HFIT_HealthAssesmentUserAnswers_HAQUESTIONITEMID') 
 CREATE NONCLUSTERED INDEX PI_HFIT_HealthAssesmentUserAnswers_HAQUESTIONITEMID ON dbo.STAGED_EDW_HFIT_HealthAssesmentUserAnswers (  HAQUESTIONITEMID ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'PI_EDW_HFIT_HEALTHASSESMENTUSERMODULE_HASITEMID') 
 CREATE NONCLUSTERED INDEX PI_EDW_HFIT_HEALTHASSESMENTUSERMODULE_HASITEMID ON dbo.STAGED_EDW_HFIT_HEALTHASSESMENTUSERMODULE (  HASTARTEDITEMID ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'PI_HFit_HealthAssesmentUserQuestion') 
 CREATE CLUSTERED INDEX PI_HFit_HealthAssesmentUserQuestion ON dbo.STAGED_EDW_HFit_HealthAssesmentUserQuestion (  ITEMID ASC  , HARISKAREAITEMID ASC  , HAQUESTIONNODEGUID ASC  , CODENAME ASC  , HAQUESTIONSCORE ASC  , PREWEIGHTEDSCORE ASC  , ISPROFESSIONALLYCOLLECTED ASC  , ITEMMODIFIEDWHEN ASC  , LASTUPDATEID ASC  , LASTLOADEDDATE ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'PI_Staged_HAUserQuestionGroupResults') 
 CREATE NONCLUSTERED INDEX PI_Staged_HAUserQuestionGroupResults ON dbo.STAGED_EDW_HFit_HealthAssesmentUserQuestionGroupResults (  HARISKAREAITEMID ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_HFit_CoachingPrivacyPolicy_Joined') 
 CREATE CLUSTERED INDEX IHash_View_HFit_CoachingPrivacyPolicy_Joined ON dbo.BASE_View_HFit_CoachingPrivacyPolicy_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_DBPK_CMS_EmailAttachment') 
 CREATE NONCLUSTERED INDEX CI_DBPK_CMS_EmailAttachment ON dbo.BASE_CMS_EmailAttachment (  AttachmentID ASC  )   INCLUDE ( DBNAME )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_HFit_CoachingEnrollmentSettings') 
 CREATE CLUSTERED INDEX IHash_HFit_CoachingEnrollmentSettings ON dbo.BASE_HFit_CoachingEnrollmentSettings (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'PI_VIEW_HFIT_HEALTHASSESSMENT_JOINED') 
 CREATE CLUSTERED INDEX PI_VIEW_HFIT_HEALTHASSESSMENT_JOINED ON dbo.STAGED_EDW_TEMP_VIEW_HFIT_HEALTHASSESSMENT_JOINED (  NODEGUID ASC  , DOCUMENTID ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'PI_Staging_EDW_HealthAssessment_NATKEY') 
 CREATE CLUSTERED INDEX PI_Staging_EDW_HealthAssessment_NATKEY ON dbo.STAGING_EDW_HealthAssessment (  USERSTARTEDITEMID ASC  , USERGUID ASC  , PKHASHCODE ASC  , DELETEDFLG ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'PI_STAGING_EDW_HealthAssessment_DelFLG') 
 CREATE NONCLUSTERED INDEX PI_STAGING_EDW_HealthAssessment_DelFLG ON dbo.STAGING_EDW_HealthAssessment (  LASTMODIFIEDDATE ASC  , DELETEDFLG ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_HFit_PostQuote_Joined') 
 CREATE CLUSTERED INDEX IHash_View_HFit_PostQuote_Joined ON dbo.BASE_View_HFit_PostQuote_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_DBPK_CMS_EmailTemplate') 
 CREATE NONCLUSTERED INDEX CI_DBPK_CMS_EmailTemplate ON dbo.BASE_CMS_EmailTemplate (  EmailTemplateID ASC  )   INCLUDE ( DBNAME )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_view_EDW_Awards') 
 CREATE CLUSTERED INDEX IHash_view_EDW_Awards ON dbo.BASE_view_EDW_Awards (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_DBPK_CMS_settingkeybak') 
 CREATE NONCLUSTERED INDEX CI_DBPK_CMS_settingkeybak ON dbo.BASE_CMS_settingkeybak (  KeyID ASC  )   INCLUDE ( DBNAME )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'cmsUser_db_UID') 
 CREATE NONCLUSTERED INDEX cmsUser_db_UID ON dbo.BASE_cms_user (  UserID ASC  )   INCLUDE ( DBNAME )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_DBPK_CMS_Class') 
 CREATE NONCLUSTERED INDEX CI_DBPK_CMS_Class ON dbo.BASE_CMS_Class (  ClassID ASC  )   INCLUDE ( DBNAME )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_HFit_CoachingMyHealthInterestsSettings') 
 CREATE CLUSTERED INDEX IHash_HFit_CoachingMyHealthInterestsSettings ON dbo.BASE_HFit_CoachingMyHealthInterestsSettings (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_BASE_COM_SKU') 
 CREATE NONCLUSTERED INDEX CI_BASE_COM_SKU ON dbo.BASE_COM_SKU (  SVR ASC  , DBNAME ASC  , SKUID ASC  )   INCLUDE ( HashCode , LASTMODIFIEDDATE )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_BASE_HFit_TrackerPreventiveCare') 
 CREATE NONCLUSTERED INDEX CI_BASE_HFit_TrackerPreventiveCare ON dbo.BASE_HFit_TrackerPreventiveCare (  SVR ASC  , DBNAME ASC  , ItemID ASC  )   INCLUDE ( HashCode , LASTMODIFIEDDATE )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'UK00_BASE_HFit_TrackerPreventiveCare') 
 CREATE  UNIQUE NONCLUSTERED INDEX UK00_BASE_HFit_TrackerPreventiveCare ON dbo.BASE_HFit_TrackerPreventiveCare (  SurrogateKey_HFit_TrackerPreventiveCare ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_view_EDW_TrackerCompositeDetails') 
 CREATE CLUSTERED INDEX IHash_view_EDW_TrackerCompositeDetails ON dbo.BASE_view_EDW_TrackerCompositeDetails (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_DBPK_CMS_ObjectVersionHistory') 
 CREATE NONCLUSTERED INDEX CI_DBPK_CMS_ObjectVersionHistory ON dbo.BASE_CMS_ObjectVersionHistory (  VersionID ASC  )   INCLUDE ( DBNAME )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_HFit_Message_Joined') 
 CREATE CLUSTERED INDEX IHash_View_HFit_Message_Joined ON dbo.BASE_View_HFit_Message_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_DBPK_CMS_ResourceTranslation') 
 CREATE NONCLUSTERED INDEX CI_DBPK_CMS_ResourceTranslation ON dbo.BASE_CMS_ResourceTranslation (  TranslationID ASC  )   INCLUDE ( DBNAME )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_HFit_LKP_CoachingOptOutReason') 
 CREATE CLUSTERED INDEX IHash_HFit_LKP_CoachingOptOutReason ON dbo.BASE_HFit_LKP_CoachingOptOutReason (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_BASE_HFit_TrackerStressManagement') 
 CREATE NONCLUSTERED INDEX CI_BASE_HFit_TrackerStressManagement ON dbo.BASE_HFit_TrackerStressManagement (  SVR ASC  , DBNAME ASC  , ItemID ASC  )   INCLUDE ( HashCode , LASTMODIFIEDDATE )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_HFit_PostMessage_Joined') 
 CREATE CLUSTERED INDEX IHash_View_HFit_PostMessage_Joined ON dbo.BASE_View_HFit_PostMessage_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_BASE_HFit_TrackerCotinine') 
 CREATE NONCLUSTERED INDEX CI_BASE_HFit_TrackerCotinine ON dbo.BASE_HFit_TrackerCotinine (  SVR ASC  , DBNAME ASC  , ItemID ASC  )   INCLUDE ( HashCode , LASTMODIFIEDDATE )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_CONTENT_Wireframe_Joined') 
 CREATE CLUSTERED INDEX IHash_View_CONTENT_Wireframe_Joined ON dbo.BASE_View_CONTENT_Wireframe_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_DBPK_CMS_Session') 
 CREATE NONCLUSTERED INDEX CI_DBPK_CMS_Session ON dbo.BASE_CMS_Session (  SessionIdentificator ASC  )   INCLUDE ( DBNAME )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_HFit_RegistrationWelcome_Joined') 
 CREATE CLUSTERED INDEX IHash_View_HFit_RegistrationWelcome_Joined ON dbo.BASE_View_HFit_RegistrationWelcome_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_DBPK_CMS_UserCulture') 
 CREATE NONCLUSTERED INDEX CI_DBPK_CMS_UserCulture ON dbo.BASE_CMS_UserCulture (  CultureID ASC  , SiteID ASC  , UserID ASC  )   INCLUDE ( DBNAME )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_DBPK_CMS_ObjectWorkflowTrigger') 
 CREATE NONCLUSTERED INDEX CI_DBPK_CMS_ObjectWorkflowTrigger ON dbo.BASE_CMS_ObjectWorkflowTrigger (  TriggerID ASC  )   INCLUDE ( DBNAME )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_DBPK_Chat_Message') 
 CREATE NONCLUSTERED INDEX CI_DBPK_Chat_Message ON dbo.BASE_Chat_Message (  ChatMessageID ASC  )   INCLUDE ( DBNAME )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_DBPK_CMS_SMTPServerSite') 
 CREATE NONCLUSTERED INDEX CI_DBPK_CMS_SMTPServerSite ON dbo.BASE_CMS_SMTPServerSite (  ServerID ASC  , SiteID ASC  )   INCLUDE ( DBNAME )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_DBPK_Chat_Room') 
 CREATE NONCLUSTERED INDEX CI_DBPK_Chat_Room ON dbo.BASE_Chat_Room (  ChatRoomID ASC  )   INCLUDE ( DBNAME )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_HFit_LKP_CoachingServiceLevel') 
 CREATE CLUSTERED INDEX IHash_HFit_LKP_CoachingServiceLevel ON dbo.BASE_HFit_LKP_CoachingServiceLevel (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'CI_BASE_HFit_RewardsUserLevelDetail') 
 CREATE NONCLUSTERED INDEX CI_BASE_HFit_RewardsUserLevelDetail ON dbo.BASE_HFit_RewardsUserLevelDetail (  SVR ASC  , DBNAME ASC  , ItemID ASC  )   INCLUDE ( HashCode , LASTMODIFIEDDATE )  WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'PI_EDW_Coaches_IDs') 
 CREATE CLUSTERED INDEX PI_EDW_Coaches_IDs ON dbo.DIM_EDW_Coaches (  UserGUID ASC  , SiteGUID ASC  , AccountID ASC  , AccountCD ASC  , CoachID ASC  , email ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'PI_EDW_CoachingDetail_IDs') 
 CREATE CLUSTERED INDEX PI_EDW_CoachingDetail_IDs ON dbo.DIM_EDW_CoachingDetail (  ItemID ASC  , ItemGUID ASC  , GoalID ASC  , UserID ASC  , UserGUID ASC  , HFitUserMpiNumber ASC  , SiteGUID ASC  , AccountID ASC  , AccountCD ASC  , WeekendDate ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_HFit_ScreeningEventDate_Joined') 
 CREATE CLUSTERED INDEX IHash_View_HFit_ScreeningEventDate_Joined ON dbo.BASE_View_HFit_ScreeningEventDate_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'UK00_BASE_HFit_TrackerSugaryDrinks') 
 CREATE  UNIQUE NONCLUSTERED INDEX UK00_BASE_HFit_TrackerSugaryDrinks ON dbo.BASE_HFit_TrackerSugaryDrinks (  DBNAME ASC  , ItemID ASC  , SVR ASC  , UserID ASC  , TrackerName ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_HFit_CoachingServiceLevelProgramDates') 
 CREATE CLUSTERED INDEX IHash_View_HFit_CoachingServiceLevelProgramDates ON dbo.BASE_View_HFit_CoachingServiceLevelProgramDates (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'GUID_BASE_HFit_HealthAssesmentUserRiskCategory_HA_LastPullDate') 
 CREATE NONCLUSTERED INDEX GUID_BASE_HFit_HealthAssesmentUserRiskCategory_HA_LastPullDate ON dbo.BASE_HFit_HealthAssesmentUserRiskCategory_HA_LastPullDate (  RowGUID DESC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'IHash_View_HFit_TermsConditions_Joined') 
 CREATE CLUSTERED INDEX IHash_View_HFit_TermsConditions_Joined ON dbo.BASE_View_HFit_TermsConditions_Joined (  DBNAME ASC  , HashCode ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 80   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO
If Not Exists (select name from sys.indexes where name = 'PI_EDW_HealthAssessment_IDs') 
 CREATE NONCLUSTERED INDEX PI_EDW_HealthAssessment_IDs ON dbo.DIM_EDW_RewardAwardDetail (  UserGUID ASC  , SiteGUID ASC  , HFitUserMpiNumber ASC  , RewardLevelGUID ASC  , AwardType ASC  , AwardDisplayName ASC  , RewardValue ASC  , ThresholdNumber ASC  , UserNotified ASC  , IsFulfilled ASC  , AccountID ASC  , AccountCD ASC  )   WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , DROP_EXISTING = ON , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY ] 
GO