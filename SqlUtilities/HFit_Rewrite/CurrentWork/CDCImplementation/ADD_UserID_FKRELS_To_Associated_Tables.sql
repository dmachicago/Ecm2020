

--exec proc_UpdateSurrogateKeyDataBetweenParentAndChild "BASE_CMS_User", "SurrogateKey_cms_user","BASE_CMS_Class","UserID", "UserSettingsUserID",1
-- USe KenticoCMS_Datamart_2
select  'IF not EXISTS (SELECT name FROM sys.foreign_keys ' + char(10)
    + ' WHERE name = ''FK_BASE_CMS_User_'+C.Table_Name+''' )' + char(10)
    + 'BEGIN ' + char(10) 
    --+ 'if not exists (Select column_name from INFORMATION_SCHEMA.COLUMNS ' + char(10)
    --+ '   where table_name = '''+C.Table_name+'''' + char(10) 
    --+ '   and column_name = ''SurrogateKey_cms_user'')  ' + char(10) 
    + '  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild '  + char(10)
    + '    @ParentTable = "BASE_CMS_User", ' + char(10)
    + '    @ParentSurrogateKeyName = "SurrogateKey_cms_user",' + char(10)
    + '    @ChildTable = "'+C.Table_Name+'",' + char(10)
    + '    @ParentColumn = "UserID",' + char(10)
    + '    @ChildColumn = "'+C.Column_name+'",' + char(10)
    + '    @PreviewOnly = 0 '  + char(10)
    + 'END'  + char(10) 
    + 'GO' as CMD
    from INFORMATION_SCHEMA.columns C
    join INFORMATION_SCHEMA.tables T
	   on C.Table_name = T.table_name 
		  and T.Table_type != 'VIEW'
where column_name like '%UserID' 
and T.Table_name not like '%_DEL'

-- select * from MART_SYNC_Table_FKRels

IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_CoachingEvalHAQA_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_CoachingEvalHAQA_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_CoachingEvalHAQA_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_CoachingEvalHAQA_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_CoachingEvalHAQA_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_CoachingEvalHAQA_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO

IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_CoachingNotAssignedSettings_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_CoachingNotAssignedSettings_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_CoachingNotAssignedSettings_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_CoachingNotAssignedSettings_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_CoachingNotAssignedSettings_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_CoachingNotAssignedSettings_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_HFit_CoachingHealthInterest' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_HFit_CoachingHealthInterest",
    @ParentColumn = "UserID",
    @ChildColumn = "UserId",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_HFit_TrackerSugaryDrinks' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_HFit_TrackerSugaryDrinks",
    @ParentColumn = "UserID",
    @ChildColumn = "UserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_Event_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_Event_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_Event_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_Event_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_Event_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_Event_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_hfit_Post_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_hfit_Post_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_hfit_Post_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_hfit_Post_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_hfit_Post_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_hfit_Post_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_HFit_RewardsReprocessQueue' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_HFit_RewardsReprocessQueue",
    @ParentColumn = "UserID",
    @ChildColumn = "UserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_HFit_TrackerFlexibility' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_HFit_TrackerFlexibility",
    @ParentColumn = "UserID",
    @ChildColumn = "UserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_RewardProgram_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_RewardProgram_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_RewardProgram_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_RewardProgram_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_RewardProgram_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_RewardProgram_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_HealthAssessmentFreeForm_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_HealthAssessmentFreeForm_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_HealthAssessmentFreeForm_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_HealthAssessmentFreeForm_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_HealthAssessmentFreeForm_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_HealthAssessmentFreeForm_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_hfit_ChallengeAbout_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_hfit_ChallengeAbout_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_hfit_ChallengeAbout_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_hfit_ChallengeAbout_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_hfit_ChallengeAbout_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_hfit_ChallengeAbout_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFIT_SsoConfiguration_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFIT_SsoConfiguration_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFIT_SsoConfiguration_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFIT_SsoConfiguration_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFIT_SsoConfiguration_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFIT_SsoConfiguration_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_Membership_MembershipUser_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_Membership_MembershipUser_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "UserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_HFit_HealthAssesmentUserQuestionImport' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_HFit_HealthAssesmentUserQuestionImport",
    @ParentColumn = "UserID",
    @ChildColumn = "UserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_Hfit_Client_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_Hfit_Client_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_Hfit_Client_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_Hfit_Client_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_Hfit_Client_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_Hfit_Client_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_HFit_UserRewardPoints' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_HFit_UserRewardPoints",
    @ParentColumn = "UserID",
    @ChildColumn = "UserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_view_EDW_HAassessment' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_view_EDW_HAassessment",
    @ParentColumn = "UserID",
    @ChildColumn = "UserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_CMS_ObjectVersionHistory' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_CMS_ObjectVersionHistory",
    @ParentColumn = "UserID",
    @ChildColumn = "VersionDeletedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_CMS_ObjectVersionHistory' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_CMS_ObjectVersionHistory",
    @ParentColumn = "UserID",
    @ChildColumn = "VersionModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_HFit_RewardsUserSummaryArchive' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_HFit_RewardsUserSummaryArchive",
    @ParentColumn = "UserID",
    @ChildColumn = "UserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_CONTENT_BookingEvent_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_CONTENT_BookingEvent_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_CONTENT_BookingEvent_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_CONTENT_BookingEvent_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_CONTENT_BookingEvent_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_CONTENT_BookingEvent_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_HFit_CoachingAuditLog' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_HFit_CoachingAuditLog",
    @ParentColumn = "UserID",
    @ChildColumn = "UserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_view_EDW_HealthInterestDetail' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_view_EDW_HealthInterestDetail",
    @ParentColumn = "UserID",
    @ChildColumn = "UserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_CoachingEvalHARiskArea_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_CoachingEvalHARiskArea_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_CoachingEvalHARiskArea_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_CoachingEvalHARiskArea_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_CoachingEvalHARiskArea_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_CoachingEvalHARiskArea_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_Class_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_Class_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_Class_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_Class_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_Class_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_Class_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_HFit_UserTracker' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_HFit_UserTracker",
    @ParentColumn = "UserID",
    @ChildColumn = "UserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_HFit_UserCoachingAlert_NotMet' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_HFit_UserCoachingAlert_NotMet",
    @ParentColumn = "UserID",
    @ChildColumn = "UserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_HFit_HealthAssesmentStarted' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_HFit_HealthAssesmentStarted",
    @ParentColumn = "UserID",
    @ChildColumn = "UserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_CoachingPrivacyPolicy_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_CoachingPrivacyPolicy_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_CoachingPrivacyPolicy_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_CoachingPrivacyPolicy_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_CoachingPrivacyPolicy_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_CoachingPrivacyPolicy_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_Goal_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_Goal_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_Goal_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_Goal_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_Goal_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_Goal_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_PostChallenge_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_PostChallenge_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_PostChallenge_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_PostChallenge_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_PostChallenge_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_PostChallenge_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_RewardsAboutInfoItem_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_RewardsAboutInfoItem_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_RewardsAboutInfoItem_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_RewardsAboutInfoItem_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_RewardsAboutInfoItem_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_RewardsAboutInfoItem_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_HealthAssessmentModuleConfiguration_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_HealthAssessmentModuleConfiguration_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_HealthAssessmentModuleConfiguration_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_HealthAssessmentModuleConfiguration_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_HealthAssessmentModuleConfiguration_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_HealthAssessmentModuleConfiguration_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_hfit_challengeBase_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_hfit_challengeBase_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_hfit_challengeBase_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_hfit_challengeBase_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_hfit_challengeBase_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_hfit_challengeBase_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_SsoRequest_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_SsoRequest_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_SsoRequest_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_SsoRequest_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_SsoRequest_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_SsoRequest_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_HFit_CoachingUserServiceLevel' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_HFit_CoachingUserServiceLevel",
    @ParentColumn = "UserID",
    @ChildColumn = "UserId",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_HFit_UserCoachingAlert_MeetNotModify' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_HFit_UserCoachingAlert_MeetNotModify",
    @ParentColumn = "UserID",
    @ChildColumn = "UserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_HFit_RewardOverrideLog' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_HFit_RewardOverrideLog",
    @ParentColumn = "UserID",
    @ChildColumn = "ForUserId",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_HFit_TrackerSleepPlan' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_HFit_TrackerSleepPlan",
    @ParentColumn = "UserID",
    @ChildColumn = "UserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_HFit_RewardsUserTrigger' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_HFit_RewardsUserTrigger",
    @ParentColumn = "UserID",
    @ChildColumn = "UserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_CONTENT_Cellphone_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_CONTENT_Cellphone_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_CONTENT_Cellphone_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_CONTENT_Cellphone_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_CONTENT_Cellphone_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_CONTENT_Cellphone_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_HFit_TrackerHighSodiumFoods' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_HFit_TrackerHighSodiumFoods",
    @ParentColumn = "UserID",
    @ChildColumn = "UserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_Chat_Message' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_Chat_Message",
    @ParentColumn = "UserID",
    @ChildColumn = "ChatMessageUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_CoachingEvalHARiskCategory_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_CoachingEvalHARiskCategory_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_CoachingEvalHARiskCategory_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_CoachingEvalHARiskCategory_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_CoachingEvalHARiskCategory_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_CoachingEvalHARiskCategory_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_HFit_HealthAssessmentImportStagingMaster' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_HFit_HealthAssessmentImportStagingMaster",
    @ParentColumn = "UserID",
    @ChildColumn = "UserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_HFit_TrackerBMI' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_HFit_TrackerBMI",
    @ParentColumn = "UserID",
    @ChildColumn = "UserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_GoalCategory_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_GoalCategory_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_GoalCategory_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_GoalCategory_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_GoalCategory_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_GoalCategory_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_PostEmptyFeed_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_PostEmptyFeed_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_PostEmptyFeed_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_PostEmptyFeed_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_PostEmptyFeed_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_PostEmptyFeed_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_RewardTrigger_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_RewardTrigger_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_RewardTrigger_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_RewardTrigger_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_RewardTrigger_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_RewardTrigger_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_CoachingAuditLog' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_CoachingAuditLog",
    @ParentColumn = "UserID",
    @ChildColumn = "UserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_HFit_RewardsUserActivityDetail' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_HFit_RewardsUserActivityDetail",
    @ParentColumn = "UserID",
    @ChildColumn = "UserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_HealthSummarySettings_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_HealthSummarySettings_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_HealthSummarySettings_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_HealthSummarySettings_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_HealthSummarySettings_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_HealthSummarySettings_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_hfit_ChallengeFAQ_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_hfit_ChallengeFAQ_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_hfit_ChallengeFAQ_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_hfit_ChallengeFAQ_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_hfit_ChallengeFAQ_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_hfit_ChallengeFAQ_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_SsoRequestAttributes_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_SsoRequestAttributes_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_SsoRequestAttributes_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_SsoRequestAttributes_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_SsoRequestAttributes_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_SsoRequestAttributes_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_CONTENT_Job_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_CONTENT_Job_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_CONTENT_Job_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_CONTENT_Job_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_CONTENT_Job_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_CONTENT_Job_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_NewsletterSubscriberUserRole_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_NewsletterSubscriberUserRole_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "UserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_ChallengeRegistrationEmail_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_ChallengeRegistrationEmail_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_ChallengeRegistrationEmail_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_ChallengeRegistrationEmail_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_ChallengeRegistrationEmail_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_ChallengeRegistrationEmail_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_CMS_WorkflowUser' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_CMS_WorkflowUser",
    @ParentColumn = "UserID",
    @ChildColumn = "UserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_CMS_Session' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_CMS_Session",
    @ParentColumn = "UserID",
    @ChildColumn = "SessionUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_HFit_HealthAssessmentImportStagingMaster_Archive' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_HFit_HealthAssessmentImportStagingMaster_Archive",
    @ParentColumn = "UserID",
    @ChildColumn = "UserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_CMS_Document' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_CMS_Document",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_CMS_Document' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_CMS_Document",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_CMS_Document' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_CMS_Document",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_HFit_HealthAssesmentUserQuestionStaging' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_HFit_HealthAssesmentUserQuestionStaging",
    @ParentColumn = "UserID",
    @ChildColumn = "UserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_CONTENT_Event_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_CONTENT_Event_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_CONTENT_Event_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_CONTENT_Event_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_CONTENT_Event_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_CONTENT_Event_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_HFit_TrackerVegetables' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_HFit_TrackerVegetables",
    @ParentColumn = "UserID",
    @ChildColumn = "UserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_Messaging_Message' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_Messaging_Message",
    @ParentColumn = "UserID",
    @ChildColumn = "MessageRecipientUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_Messaging_Message' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_Messaging_Message",
    @ParentColumn = "UserID",
    @ChildColumn = "MessageSenderUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_Coach_Bio_HISTORY' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_Coach_Bio_HISTORY",
    @ParentColumn = "UserID",
    @ChildColumn = "CoachUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_view_EDW_Participant' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_view_EDW_Participant",
    @ParentColumn = "UserID",
    @ChildColumn = "UserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_CoachingEvalHARiskModule_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_CoachingEvalHARiskModule_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_CoachingEvalHARiskModule_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_CoachingEvalHARiskModule_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_CoachingEvalHARiskModule_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_CoachingEvalHARiskModule_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_Coach_Bio' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_Coach_Bio",
    @ParentColumn = "UserID",
    @ChildColumn = "CoachUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_HFit_HealthAssesmentUserQuestionGroupResults' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_HFit_HealthAssesmentUserQuestionGroupResults",
    @ParentColumn = "UserID",
    @ChildColumn = "UserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_CoachingTermsAndConditionsSettings_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_CoachingTermsAndConditionsSettings_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_CoachingTermsAndConditionsSettings_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_CoachingTermsAndConditionsSettings_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_CoachingTermsAndConditionsSettings_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_CoachingTermsAndConditionsSettings_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_GoalSubCategory_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_GoalSubCategory_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_GoalSubCategory_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_GoalSubCategory_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_GoalSubCategory_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_GoalSubCategory_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_PostHealthEducation_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_PostHealthEducation_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_PostHealthEducation_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_PostHealthEducation_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_PostHealthEducation_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_PostHealthEducation_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_HFit_TrackerRegularMeals' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_HFit_TrackerRegularMeals",
    @ParentColumn = "UserID",
    @ChildColumn = "UserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_RewardTriggerParameter_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_RewardTriggerParameter_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_RewardTriggerParameter_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_RewardTriggerParameter_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_RewardTriggerParameter_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_RewardTriggerParameter_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_HRA_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_HRA_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_HRA_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_HRA_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_HRA_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_HRA_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_hfit_challengeGeneralSettings_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_hfit_challengeGeneralSettings_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_hfit_challengeGeneralSettings_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_hfit_challengeGeneralSettings_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_hfit_challengeGeneralSettings_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_hfit_challengeGeneralSettings_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_hfit_TemporalConfigurationContainer_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_hfit_TemporalConfigurationContainer_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_hfit_TemporalConfigurationContainer_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_hfit_TemporalConfigurationContainer_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_hfit_TemporalConfigurationContainer_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_hfit_TemporalConfigurationContainer_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_HFit_TrackerSugaryFoods' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_HFit_TrackerSugaryFoods",
    @ParentColumn = "UserID",
    @ChildColumn = "UserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_CONTENT_KBArticle_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_CONTENT_KBArticle_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_CONTENT_KBArticle_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_CONTENT_KBArticle_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_CONTENT_KBArticle_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_CONTENT_KBArticle_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_OM_Account_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_OM_Account_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "AccountOwnerUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_STAGED_EDW_CMS_USER' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "STAGED_EDW_CMS_USER",
    @ParentColumn = "UserID",
    @ChildColumn = "USERID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_HFit_RewardException' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_HFit_RewardException",
    @ParentColumn = "UserID",
    @ChildColumn = "UserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_hfit_PPTEligibility' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_hfit_PPTEligibility",
    @ParentColumn = "UserID",
    @ChildColumn = "UserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_CMS_WorkflowHistory' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_CMS_WorkflowHistory",
    @ParentColumn = "UserID",
    @ChildColumn = "ApprovedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_STAGED_EDW_CMS_USERSETTINGS' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "STAGED_EDW_CMS_USERSETTINGS",
    @ParentColumn = "UserID",
    @ChildColumn = "USERSETTINGSUSERID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_HFit_TrackerFruits' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_HFit_TrackerFruits",
    @ParentColumn = "UserID",
    @ChildColumn = "UserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_view_EDW_HealthAssesment' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_view_EDW_HealthAssesment",
    @ParentColumn = "UserID",
    @ChildColumn = "UserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_ToDoHealthAssesment' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_ToDoHealthAssesment",
    @ParentColumn = "UserID",
    @ChildColumn = "UserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_STAGED_EDW_CMS_USERSITE' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "STAGED_EDW_CMS_USERSITE",
    @ParentColumn = "UserID",
    @ChildColumn = "USERID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_HFit_TrackerCardio' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_HFit_TrackerCardio",
    @ParentColumn = "UserID",
    @ChildColumn = "UserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_CMS_MembershipUser' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_CMS_MembershipUser",
    @ParentColumn = "UserID",
    @ChildColumn = "MembershipUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_CMS_MembershipUser' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_CMS_MembershipUser",
    @ParentColumn = "UserID",
    @ChildColumn = "UserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_CONTENT_FAQ_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_CONTENT_FAQ_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_CONTENT_FAQ_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_CONTENT_FAQ_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_CONTENT_FAQ_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_CONTENT_FAQ_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_CMS_Personalization' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_CMS_Personalization",
    @ParentColumn = "UserID",
    @ChildColumn = "PersonalizationUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_CoachingGetStarted_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_CoachingGetStarted_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_CoachingGetStarted_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_CoachingGetStarted_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_CoachingGetStarted_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_CoachingGetStarted_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_PostMessage_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_PostMessage_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_PostMessage_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_PostMessage_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_PostMessage_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_PostMessage_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_HA_UseAndDisclosure_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_HA_UseAndDisclosure_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_HA_UseAndDisclosure_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_HA_UseAndDisclosure_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_HA_UseAndDisclosure_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_HA_UseAndDisclosure_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_HFit_Coaches' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_HFit_Coaches",
    @ParentColumn = "UserID",
    @ChildColumn = "KenticoUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_HFit_Coaches' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_HFit_Coaches",
    @ParentColumn = "UserID",
    @ChildColumn = "UserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_RewardTriggerTobaccoParameter_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_RewardTriggerTobaccoParameter_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_RewardTriggerTobaccoParameter_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_RewardTriggerTobaccoParameter_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_RewardTriggerTobaccoParameter_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_RewardTriggerTobaccoParameter_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_EDW_RewardProgram_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_EDW_RewardProgram_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_EDW_RewardProgram_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_EDW_RewardProgram_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_EDW_RewardProgram_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_EDW_RewardProgram_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_HSAbout_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_HSAbout_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_HSAbout_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_HSAbout_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_HSAbout_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_HSAbout_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_ChallengeNewsletter_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_ChallengeNewsletter_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_ChallengeNewsletter_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_ChallengeNewsletter_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_ChallengeNewsletter_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_ChallengeNewsletter_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_TermsConditions_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_TermsConditions_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_TermsConditions_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_TermsConditions_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_TermsConditions_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_TermsConditions_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_CONTENT_Laptop_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_CONTENT_Laptop_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_CONTENT_Laptop_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_CONTENT_Laptop_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_CONTENT_Laptop_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_CONTENT_Laptop_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_OM_Account_MembershipJoined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_OM_Account_MembershipJoined",
    @ParentColumn = "UserID",
    @ChildColumn = "AccountOwnerUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_CMS_ScheduledTask' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_CMS_ScheduledTask",
    @ParentColumn = "UserID",
    @ChildColumn = "TaskUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_CMS_Tree_Joined_Versions' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_CMS_Tree_Joined_Versions",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_CMS_Tree_Joined_Versions' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_CMS_Tree_Joined_Versions",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_CMS_Tree_Joined_Versions' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_CMS_Tree_Joined_Versions",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_STAGED_EDW_HFIT_HEALTHASSESMENTUSERSTARTED' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "STAGED_EDW_HFIT_HEALTHASSESMENTUSERSTARTED",
    @ParentColumn = "UserID",
    @ChildColumn = "USERID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_DIM_TEMP_EDW_Tracker_DATA' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "DIM_TEMP_EDW_Tracker_DATA",
    @ParentColumn = "UserID",
    @ChildColumn = "UserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_CONTENT_File_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_CONTENT_File_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_CONTENT_File_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_CONTENT_File_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_CONTENT_File_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_CONTENT_File_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_CoachingGetUserDaysSinceActivity' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_CoachingGetUserDaysSinceActivity",
    @ParentColumn = "UserID",
    @ChildColumn = "UserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_CoachingHATemporalContainer_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_CoachingHATemporalContainer_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_CoachingHATemporalContainer_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_CoachingHATemporalContainer_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_CoachingHATemporalContainer_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_CoachingHATemporalContainer_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_Hfit_CoachingSystemSettings_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_Hfit_CoachingSystemSettings_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_Hfit_CoachingSystemSettings_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_Hfit_CoachingSystemSettings_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_Hfit_CoachingSystemSettings_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_Hfit_CoachingSystemSettings_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_Configuration_CallLogCoaching_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_Configuration_CallLogCoaching_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_Configuration_CallLogCoaching_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_Configuration_CallLogCoaching_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_Configuration_CallLogCoaching_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_Configuration_CallLogCoaching_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_HFit_TrackerInstance_Tracker' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_HFit_TrackerInstance_Tracker",
    @ParentColumn = "UserID",
    @ChildColumn = "UserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_Board_Board' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_Board_Board",
    @ParentColumn = "UserID",
    @ChildColumn = "BoardUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_HFit_TrackerCotinine' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_HFit_TrackerCotinine",
    @ParentColumn = "UserID",
    @ChildColumn = "UserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_HFit_TrackerStrength' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_HFit_TrackerStrength",
    @ParentColumn = "UserID",
    @ChildColumn = "UserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_Community_Group' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_Community_Group",
    @ParentColumn = "UserID",
    @ChildColumn = "GroupApprovedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_Community_Group' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_Community_Group",
    @ParentColumn = "UserID",
    @ChildColumn = "GroupCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_PostQuote_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_PostQuote_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_PostQuote_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_PostQuote_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_PostQuote_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_PostQuote_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_HACampaign_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_HACampaign_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_HACampaign_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_HACampaign_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_HACampaign_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_HACampaign_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_RightsResponsibilities_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_RightsResponsibilities_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_RightsResponsibilities_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_RightsResponsibilities_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_RightsResponsibilities_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_RightsResponsibilities_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_CMS_OpenIDUser' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_CMS_OpenIDUser",
    @ParentColumn = "UserID",
    @ChildColumn = "OpenIDUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_CMS_OpenIDUser' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_CMS_OpenIDUser",
    @ParentColumn = "UserID",
    @ChildColumn = "UserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_HFit_HAAgreement' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_HFit_HAAgreement",
    @ParentColumn = "UserID",
    @ChildColumn = "HAAcceptanceUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_HSBiometricChart_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_HSBiometricChart_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_HSBiometricChart_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_HSBiometricChart_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_HSBiometricChart_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_HSBiometricChart_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_hfit_challengeOffering_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_hfit_challengeOffering_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_hfit_challengeOffering_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_hfit_challengeOffering_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_hfit_challengeOffering_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_hfit_challengeOffering_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_Hfit_TimezoneConfiguration_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_Hfit_TimezoneConfiguration_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_Hfit_TimezoneConfiguration_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_Hfit_TimezoneConfiguration_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_Hfit_TimezoneConfiguration_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_Hfit_TimezoneConfiguration_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_CONTENT_MenuItem_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_CONTENT_MenuItem_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_CONTENT_MenuItem_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_CONTENT_MenuItem_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_CONTENT_MenuItem_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_CONTENT_MenuItem_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_CMS_UserCulture' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_CMS_UserCulture",
    @ParentColumn = "UserID",
    @ChildColumn = "UserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_HFit_TrackerBodyFat' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_HFit_TrackerBodyFat",
    @ParentColumn = "UserID",
    @ChildColumn = "UserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_HFit_RewardsUserInterfaceState' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_HFit_RewardsUserInterfaceState",
    @ParentColumn = "UserID",
    @ChildColumn = "UserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_CMS_Tree_Joined_Versions_Attachments' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_CMS_Tree_Joined_Versions_Attachments",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_CMS_Tree_Joined_Versions_Attachments' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_CMS_Tree_Joined_Versions_Attachments",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_CMS_Tree_Joined_Versions_Attachments' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_CMS_Tree_Joined_Versions_Attachments",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_CMS_EmailUser' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_CMS_EmailUser",
    @ParentColumn = "UserID",
    @ChildColumn = "UserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_CoachingWelcomeSettings_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_CoachingWelcomeSettings_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_CoachingWelcomeSettings_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_CoachingWelcomeSettings_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_CoachingWelcomeSettings_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_CoachingWelcomeSettings_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_FACT_TrackerData' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "FACT_TrackerData",
    @ParentColumn = "UserID",
    @ChildColumn = "UserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_HFit_RewardsUserLevelDetail' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_HFit_RewardsUserLevelDetail",
    @ParentColumn = "UserID",
    @ChildColumn = "UserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_CONTENT_ImageGallery_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_CONTENT_ImageGallery_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_CONTENT_ImageGallery_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_CONTENT_ImageGallery_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_CONTENT_ImageGallery_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_CONTENT_ImageGallery_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_CoachingReadyForNotification' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_CoachingReadyForNotification",
    @ParentColumn = "UserID",
    @ChildColumn = "UserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_CoachingHealthActionPlan_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_CoachingHealthActionPlan_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_CoachingHealthActionPlan_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_CoachingHealthActionPlan_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_CoachingHealthActionPlan_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_CoachingHealthActionPlan_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFIT_Configuration_CMCoaching_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFIT_Configuration_CMCoaching_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFIT_Configuration_CMCoaching_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFIT_Configuration_CMCoaching_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFIT_Configuration_CMCoaching_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFIT_Configuration_CMCoaching_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_HFit_TrackerWater' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_HFit_TrackerWater",
    @ParentColumn = "UserID",
    @ChildColumn = "UserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_PostReminder_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_PostReminder_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_PostReminder_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_PostReminder_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_PostReminder_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_PostReminder_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_HFit_HealthAssesmentUserRiskArea' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_HFit_HealthAssesmentUserRiskArea",
    @ParentColumn = "UserID",
    @ChildColumn = "UserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_Hfit_HACampaigns_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_Hfit_HACampaigns_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_Hfit_HACampaigns_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_Hfit_HACampaigns_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_Hfit_HACampaigns_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_Hfit_HACampaigns_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_ScheduledNotification_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_ScheduledNotification_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_ScheduledNotification_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_ScheduledNotification_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_ScheduledNotification_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_ScheduledNotification_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_HFit_Screening_PPT_Archive' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_HFit_Screening_PPT_Archive",
    @ParentColumn = "UserID",
    @ChildColumn = "UserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_CoachingEnrollmentSettings_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_CoachingEnrollmentSettings_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_CoachingEnrollmentSettings_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_CoachingEnrollmentSettings_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_CoachingEnrollmentSettings_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_CoachingEnrollmentSettings_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_HSGraphRangeSetting_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_HSGraphRangeSetting_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_HSGraphRangeSetting_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_HSGraphRangeSetting_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_HSGraphRangeSetting_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_HSGraphRangeSetting_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_ChallengePostTemplate_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_ChallengePostTemplate_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_ChallengePostTemplate_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_ChallengePostTemplate_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_ChallengePostTemplate_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_ChallengePostTemplate_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_TipOfTheDay_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_TipOfTheDay_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_TipOfTheDay_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_TipOfTheDay_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_TipOfTheDay_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_TipOfTheDay_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_CONTENT_News_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_CONTENT_News_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_CONTENT_News_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_CONTENT_News_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_CONTENT_News_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_CONTENT_News_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_CMS_Tree_Joined_Linked' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_CMS_Tree_Joined_Linked",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_CMS_Tree_Joined_Linked' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_CMS_Tree_Joined_Linked",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_CMS_Tree_Joined_Linked' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_CMS_Tree_Joined_Linked",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_HFit_TrackerRestingHeartRate' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_HFit_TrackerRestingHeartRate",
    @ParentColumn = "UserID",
    @ChildColumn = "UserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_Hfit_HAHealthCheckLog' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_Hfit_HAHealthCheckLog",
    @ParentColumn = "UserID",
    @ChildColumn = "UserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_HFit_TrackerTests' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_HFit_TrackerTests",
    @ParentColumn = "UserID",
    @ChildColumn = "UserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_CMS_UserRole_MembershipRole_ValidOnly_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_CMS_UserRole_MembershipRole_ValidOnly_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "UserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_HFit_TrackerHbA1c' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_HFit_TrackerHbA1c",
    @ParentColumn = "UserID",
    @ChildColumn = "UserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_CMS_User_With_HFitCoachingSettings' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_CMS_User_With_HFitCoachingSettings",
    @ParentColumn = "UserID",
    @ChildColumn = "UserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_CoachingHealthArea_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_CoachingHealthArea_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_CoachingHealthArea_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_CoachingHealthArea_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_CoachingHealthArea_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_CoachingHealthArea_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_CoachingServiceLevelProgramDates' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_CoachingServiceLevelProgramDates",
    @ParentColumn = "UserID",
    @ChildColumn = "UserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFIT_Configuration_HACoaching_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFIT_Configuration_HACoaching_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFIT_Configuration_HACoaching_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFIT_Configuration_HACoaching_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFIT_Configuration_HACoaching_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFIT_Configuration_HACoaching_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_HSLearnMoreDocument_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_HSLearnMoreDocument_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_HSLearnMoreDocument_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_HSLearnMoreDocument_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_HSLearnMoreDocument_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_HSLearnMoreDocument_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_HFit_HealthAssesmentUserAnswers' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_HFit_HealthAssesmentUserAnswers",
    @ParentColumn = "UserID",
    @ChildColumn = "UserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_PrivacyPolicy_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_PrivacyPolicy_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_PrivacyPolicy_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_PrivacyPolicy_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_PrivacyPolicy_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_PrivacyPolicy_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_HESChallenge_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_HESChallenge_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_HESChallenge_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_HESChallenge_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_HESChallenge_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_HESChallenge_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_HAWelcomeSettings_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_HAWelcomeSettings_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_HAWelcomeSettings_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_HAWelcomeSettings_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_HAWelcomeSettings_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_HAWelcomeSettings_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_CONTENT_Product_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_CONTENT_Product_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_CONTENT_Product_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_CONTENT_Product_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_CONTENT_Product_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_CONTENT_Product_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_ScreeningEvent_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_ScreeningEvent_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_ScreeningEvent_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_ScreeningEvent_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_ScreeningEvent_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_ScreeningEvent_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_CMS_Tree_Joined_Regular' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_CMS_Tree_Joined_Regular",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_CMS_Tree_Joined_Regular' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_CMS_Tree_Joined_Regular",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_CMS_Tree_Joined_Regular' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_CMS_Tree_Joined_Regular",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_Chat_Room' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_Chat_Room",
    @ParentColumn = "UserID",
    @ChildColumn = "ChatRoomCreatedByChatUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_HSHealthMeasuresSettings_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_HSHealthMeasuresSettings_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_HSHealthMeasuresSettings_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_HSHealthMeasuresSettings_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_HSHealthMeasuresSettings_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_HSHealthMeasuresSettings_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_ChallengePPTEligibleCDPostTemplate_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_ChallengePPTEligibleCDPostTemplate_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_ChallengePPTEligibleCDPostTemplate_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_ChallengePPTEligibleCDPostTemplate_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_ChallengePPTEligibleCDPostTemplate_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_ChallengePPTEligibleCDPostTemplate_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_CMS_TranslationSubmission' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_CMS_TranslationSubmission",
    @ParentColumn = "UserID",
    @ChildColumn = "SubmissionSubmittedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_Hfit_TipOfTheDayCategory_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_Hfit_TipOfTheDayCategory_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_Hfit_TipOfTheDayCategory_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_Hfit_TipOfTheDayCategory_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_Hfit_TipOfTheDayCategory_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_Hfit_TipOfTheDayCategory_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_OM_Contact' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_OM_Contact",
    @ParentColumn = "UserID",
    @ChildColumn = "ContactOwnerUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_CMS_UserRole' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_CMS_UserRole",
    @ParentColumn = "UserID",
    @ChildColumn = "UserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_CONTENT_Office_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_CONTENT_Office_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_CONTENT_Office_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_CONTENT_Office_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_CONTENT_Office_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_CONTENT_Office_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_view_EDW_CoachingDetail' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_view_EDW_CoachingDetail",
    @ParentColumn = "UserID",
    @ChildColumn = "UserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_OM_ContactGroupMember_AccountJoined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_OM_ContactGroupMember_AccountJoined",
    @ParentColumn = "UserID",
    @ChildColumn = "AccountOwnerUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_CMS_EventLog' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_CMS_EventLog",
    @ParentColumn = "UserID",
    @ChildColumn = "UserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_cms_user' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_cms_user",
    @ParentColumn = "UserID",
    @ChildColumn = "UserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_view_EDW_TrackerCompositeDetails' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_view_EDW_TrackerCompositeDetails",
    @ParentColumn = "UserID",
    @ChildColumn = "UserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_EDW_HealthAssessment' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_EDW_HealthAssessment",
    @ParentColumn = "UserID",
    @ChildColumn = "UserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_CMS_UserSettingsRole_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_CMS_UserSettingsRole_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "UserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_HFit_UserCoachingAlert_NotMet_Step1' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_HFit_UserCoachingAlert_NotMet_Step1",
    @ParentColumn = "UserID",
    @ChildColumn = "UserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_view_EDW_RewardUserLevel' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_view_EDW_RewardUserLevel",
    @ParentColumn = "UserID",
    @ChildColumn = "UserId",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_CoachingLibraryHealthArea_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_CoachingLibraryHealthArea_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_CoachingLibraryHealthArea_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_CoachingLibraryHealthArea_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_CoachingLibraryHealthArea_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_CoachingLibraryHealthArea_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_Configuration_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_Configuration_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_Configuration_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_Configuration_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_Configuration_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_Configuration_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_LoginPageSettings_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_LoginPageSettings_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_LoginPageSettings_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_LoginPageSettings_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_LoginPageSettings_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_LoginPageSettings_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_ProgramFeedNotificationSettings_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_ProgramFeedNotificationSettings_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_ProgramFeedNotificationSettings_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_ProgramFeedNotificationSettings_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_ProgramFeedNotificationSettings_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_ProgramFeedNotificationSettings_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_HealthAssesmentMatrixQuestion_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_HealthAssesmentMatrixQuestion_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_HealthAssesmentMatrixQuestion_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_HealthAssesmentMatrixQuestion_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_HealthAssesmentMatrixQuestion_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_HealthAssesmentMatrixQuestion_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_CONTENT_SimpleArticle_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_CONTENT_SimpleArticle_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_CONTENT_SimpleArticle_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_CONTENT_SimpleArticle_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_CONTENT_SimpleArticle_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_CONTENT_SimpleArticle_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_ScreeningEventCategory_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_ScreeningEventCategory_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_ScreeningEventCategory_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_ScreeningEventCategory_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_ScreeningEventCategory_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_ScreeningEventCategory_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_HFit_TrackerMealPortions' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_HFit_TrackerMealPortions",
    @ParentColumn = "UserID",
    @ChildColumn = "UserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_HealthAssesmentRiskCategory_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_HealthAssesmentRiskCategory_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_HealthAssesmentRiskCategory_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_HealthAssesmentRiskCategory_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_HealthAssesmentRiskCategory_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_HealthAssesmentRiskCategory_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_hFit_ChallengePPTEligiblePostTemplate_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_hFit_ChallengePPTEligiblePostTemplate_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_hFit_ChallengePPTEligiblePostTemplate_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_hFit_ChallengePPTEligiblePostTemplate_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_hFit_ChallengePPTEligiblePostTemplate_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_hFit_ChallengePPTEligiblePostTemplate_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_Tobacco_Goal_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_Tobacco_Goal_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_Tobacco_Goal_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_Tobacco_Goal_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_Tobacco_Goal_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_Tobacco_Goal_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_CONTENT_PressRelease_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_CONTENT_PressRelease_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_CONTENT_PressRelease_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_CONTENT_PressRelease_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_CONTENT_PressRelease_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_CONTENT_PressRelease_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_view_EDW_CoachingPPTAvailable' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_view_EDW_CoachingPPTAvailable",
    @ParentColumn = "UserID",
    @ChildColumn = "UserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_OM_ContactGroupMember_ContactJoined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_OM_ContactGroupMember_ContactJoined",
    @ParentColumn = "UserID",
    @ChildColumn = "ContactOwnerUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_HFit_TrackerDailySteps' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_HFit_TrackerDailySteps",
    @ParentColumn = "UserID",
    @ChildColumn = "UserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_HFit_TrackerStress' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_HFit_TrackerStress",
    @ParentColumn = "UserID",
    @ChildColumn = "UserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_Newsletter_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_Newsletter_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_Newsletter_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_Newsletter_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_Newsletter_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_Newsletter_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_HFit_TrackerBodyMeasurements' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_HFit_TrackerBodyMeasurements",
    @ParentColumn = "UserID",
    @ChildColumn = "UserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_ClientContact_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_ClientContact_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_ClientContact_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_ClientContact_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_ClientContact_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_ClientContact_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_HFit_UserCoachingAlert_NotMet_Step2' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_HFit_UserCoachingAlert_NotMet_Step2",
    @ParentColumn = "UserID",
    @ChildColumn = "UserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_HFit_Staging_Coach' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_HFit_Staging_Coach",
    @ParentColumn = "UserID",
    @ChildColumn = "KenticoUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_HFit_Staging_Coach' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_HFit_Staging_Coach",
    @ParentColumn = "UserID",
    @ChildColumn = "UserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_view_EDW_RoleEligibility' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_view_EDW_RoleEligibility",
    @ParentColumn = "UserID",
    @ChildColumn = "UserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_CoachingLibraryResource_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_CoachingLibraryResource_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_CoachingLibraryResource_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_CoachingLibraryResource_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_CoachingLibraryResource_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_CoachingLibraryResource_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_HealthAssesmentMultipleChoiceQuestion_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_HealthAssesmentMultipleChoiceQuestion_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_HealthAssesmentMultipleChoiceQuestion_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_HealthAssesmentMultipleChoiceQuestion_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_HealthAssesmentMultipleChoiceQuestion_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_HealthAssesmentMultipleChoiceQuestion_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_Configuration_LMCoaching_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_Configuration_LMCoaching_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_Configuration_LMCoaching_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_Configuration_LMCoaching_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_Configuration_LMCoaching_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_Configuration_LMCoaching_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_Hfit_MarketplaceProduct_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_Hfit_MarketplaceProduct_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_Hfit_MarketplaceProduct_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_Hfit_MarketplaceProduct_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_Hfit_MarketplaceProduct_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_Hfit_MarketplaceProduct_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_RegistrationWelcome_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_RegistrationWelcome_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_RegistrationWelcome_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_RegistrationWelcome_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_RegistrationWelcome_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_RegistrationWelcome_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_Hfit_CoachingUserCMCondition' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_Hfit_CoachingUserCMCondition",
    @ParentColumn = "UserID",
    @ChildColumn = "UserId",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_CONTENT_Smartphone_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_CONTENT_Smartphone_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_CONTENT_Smartphone_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_CONTENT_Smartphone_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_CONTENT_Smartphone_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_CONTENT_Smartphone_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_ScreeningEventDate_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_ScreeningEventDate_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_ScreeningEventDate_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_ScreeningEventDate_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_ScreeningEventDate_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_ScreeningEventDate_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_CMS_UserRole_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_CMS_UserRole_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "UserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_Board_Message' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_Board_Message",
    @ParentColumn = "UserID",
    @ChildColumn = "MessageApprovedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_Board_Message' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_Board_Message",
    @ParentColumn = "UserID",
    @ChildColumn = "MessageUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_HFit_TrackerWeight' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_HFit_TrackerWeight",
    @ParentColumn = "UserID",
    @ChildColumn = "UserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_ChallengePPTRegisteredPostTemplate_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_ChallengePPTRegisteredPostTemplate_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_ChallengePPTRegisteredPostTemplate_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_ChallengePPTRegisteredPostTemplate_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_ChallengePPTRegisteredPostTemplate_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_ChallengePPTRegisteredPostTemplate_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_TrackerCategory_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_TrackerCategory_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_TrackerCategory_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_TrackerCategory_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_TrackerCategory_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_TrackerCategory_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_CMS_Tree_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_CMS_Tree_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_CMS_Tree_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_CMS_Tree_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_CMS_Tree_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_CMS_Tree_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_view_EDW_CoachingPPTEligible' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_view_EDW_CoachingPPTEligible",
    @ParentColumn = "UserID",
    @ChildColumn = "UserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_HFit_CoachingSessionCompleted' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_HFit_CoachingSessionCompleted",
    @ParentColumn = "UserID",
    @ChildColumn = "UserId",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_CMS_Tree_Joined_Attachments' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_CMS_Tree_Joined_Attachments",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_CMS_Tree_Joined_Attachments' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_CMS_Tree_Joined_Attachments",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_CMS_Tree_Joined_Attachments' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_CMS_Tree_Joined_Attachments",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_HealthAssesmentModule_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_HealthAssesmentModule_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_HealthAssesmentModule_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_HealthAssesmentModule_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_HealthAssesmentModule_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_HealthAssesmentModule_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_view_HFit_HealthAssesmentUserResponses' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_view_HFit_HealthAssesmentUserResponses",
    @ParentColumn = "UserID",
    @ChildColumn = "UserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_view_EDW_ScreeningsFromTrackers' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_view_EDW_ScreeningsFromTrackers",
    @ParentColumn = "UserID",
    @ChildColumn = "userid",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_HFit_TrackerShots' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_HFit_TrackerShots",
    @ParentColumn = "UserID",
    @ChildColumn = "UserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_HFit_HealthAssesmentUserRiskCategory' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_HFit_HealthAssesmentUserRiskCategory",
    @ParentColumn = "UserID",
    @ChildColumn = "UserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_CoachingCallLogTemporalContainer_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_CoachingCallLogTemporalContainer_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_CoachingCallLogTemporalContainer_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_CoachingCallLogTemporalContainer_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_CoachingCallLogTemporalContainer_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_CoachingCallLogTemporalContainer_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_Chat_User' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_Chat_User",
    @ParentColumn = "UserID",
    @ChildColumn = "ChatUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_Chat_User' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_Chat_User",
    @ParentColumn = "UserID",
    @ChildColumn = "ChatUserUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_HFit_UserCoachingAlert_NotMet_Step3' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_HFit_UserCoachingAlert_NotMet_Step3",
    @ParentColumn = "UserID",
    @ChildColumn = "UserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_HFit_HealthAssessmentImportStaging' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_HFit_HealthAssessmentImportStaging",
    @ParentColumn = "UserID",
    @ChildColumn = "UserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_CoachingLibraryResources_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_CoachingLibraryResources_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_CoachingLibraryResources_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_CoachingLibraryResources_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_CoachingLibraryResources_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_CoachingLibraryResources_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFIT_Configuration_Screening_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFIT_Configuration_Screening_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFIT_Configuration_Screening_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFIT_Configuration_Screening_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFIT_Configuration_Screening_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFIT_Configuration_Screening_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_OM_ContactGroupMember_User_ContactJoined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_OM_ContactGroupMember_User_ContactJoined",
    @ParentColumn = "UserID",
    @ChildColumn = "ContactOwnerUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_OM_ContactGroupMember_User_ContactJoined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_OM_ContactGroupMember_User_ContactJoined",
    @ParentColumn = "UserID",
    @ChildColumn = "UserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_Message_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_Message_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_Message_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_Message_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_Message_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_Message_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_HFIt_PptEligibility_mosbrun' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_HFIt_PptEligibility_mosbrun",
    @ParentColumn = "UserID",
    @ChildColumn = "UserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_STAGED_View_CMS_Tree_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "STAGED_View_CMS_Tree_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_STAGED_View_CMS_Tree_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "STAGED_View_CMS_Tree_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_STAGED_View_CMS_Tree_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "STAGED_View_CMS_Tree_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_HFit_TrackerHeight' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_HFit_TrackerHeight",
    @ParentColumn = "UserID",
    @ChildColumn = "UserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_RewardActivity_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_RewardActivity_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_RewardActivity_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_RewardActivity_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_RewardActivity_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_RewardActivity_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_HFit_TrackerBloodPressure' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_HFit_TrackerBloodPressure",
    @ParentColumn = "UserID",
    @ChildColumn = "UserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_CONTENT_Wireframe_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_CONTENT_Wireframe_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_CONTENT_Wireframe_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_CONTENT_Wireframe_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_CONTENT_Wireframe_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_CONTENT_Wireframe_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_ScreeningTemporalContainer_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_ScreeningTemporalContainer_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_ScreeningTemporalContainer_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_ScreeningTemporalContainer_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_ScreeningTemporalContainer_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_ScreeningTemporalContainer_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_HealthAssesmentRiskArea_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_HealthAssesmentRiskArea_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_HealthAssesmentRiskArea_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_HealthAssesmentRiskArea_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_HealthAssesmentRiskArea_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_HealthAssesmentRiskArea_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_ChallengePPTRegisteredRDPostTemplate_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_ChallengePPTRegisteredRDPostTemplate_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_ChallengePPTRegisteredRDPostTemplate_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_ChallengePPTRegisteredRDPostTemplate_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_ChallengePPTRegisteredRDPostTemplate_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_ChallengePPTRegisteredRDPostTemplate_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_TrackerDocument_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_TrackerDocument_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_TrackerDocument_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_TrackerDocument_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_TrackerDocument_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_TrackerDocument_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_HFit_Ref_RewardTrackerValidation' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_HFit_Ref_RewardTrackerValidation",
    @ParentColumn = "UserID",
    @ChildColumn = "UserId",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_view_EDW_CoachingPPTEnrolled' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_view_EDW_CoachingPPTEnrolled",
    @ParentColumn = "UserID",
    @ChildColumn = "UserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_GroupRewardLevel_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_GroupRewardLevel_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_GroupRewardLevel_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_GroupRewardLevel_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_GroupRewardLevel_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_GroupRewardLevel_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_view_EDW_SmallStepResponses' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_view_EDW_SmallStepResponses",
    @ParentColumn = "UserID",
    @ChildColumn = "UserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_view_EDW_BioMetrics' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_view_EDW_BioMetrics",
    @ParentColumn = "UserID",
    @ChildColumn = "UserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_HFit_HealthAssesmentUserModule' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_HFit_HealthAssesmentUserModule",
    @ParentColumn = "UserID",
    @ChildColumn = "UserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_HFit_RewardsUserRepeatableTriggerDetail' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_HFit_RewardsUserRepeatableTriggerDetail",
    @ParentColumn = "UserID",
    @ChildColumn = "UserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_hfit_CoachingCMTemporalContainer_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_hfit_CoachingCMTemporalContainer_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_hfit_CoachingCMTemporalContainer_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_hfit_CoachingCMTemporalContainer_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_hfit_CoachingCMTemporalContainer_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_hfit_CoachingCMTemporalContainer_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_CMS_AutomationHistory' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_CMS_AutomationHistory",
    @ParentColumn = "UserID",
    @ChildColumn = "HistoryApprovedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_HFit_UserCoachingAlert_NotMet_Step4' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_HFit_UserCoachingAlert_NotMet_Step4",
    @ParentColumn = "UserID",
    @ChildColumn = "UserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_CoachingLibrarySettings_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_CoachingLibrarySettings_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_CoachingLibrarySettings_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_CoachingLibrarySettings_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_CoachingLibrarySettings_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_CoachingLibrarySettings_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_HFit_TrackerTobaccoAttestation' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_HFit_TrackerTobaccoAttestation",
    @ParentColumn = "UserID",
    @ChildColumn = "UserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_ConsentAndRelease_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_ConsentAndRelease_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_ConsentAndRelease_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_ConsentAndRelease_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_ConsentAndRelease_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_ConsentAndRelease_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_Hfit_MyHealthSettings_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_Hfit_MyHealthSettings_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_Hfit_MyHealthSettings_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_Hfit_MyHealthSettings_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_Hfit_MyHealthSettings_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_Hfit_MyHealthSettings_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_RewardDefaultSettings_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_RewardDefaultSettings_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_RewardDefaultSettings_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_RewardDefaultSettings_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_RewardDefaultSettings_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_RewardDefaultSettings_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_HealthAssesmentPredefinedAnswer_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_HealthAssesmentPredefinedAnswer_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_HealthAssesmentPredefinedAnswer_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_HealthAssesmentPredefinedAnswer_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_HealthAssesmentPredefinedAnswer_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_HealthAssesmentPredefinedAnswer_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_SecurityQuestion_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_SecurityQuestion_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_SecurityQuestion_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_SecurityQuestion_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_SecurityQuestion_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_SecurityQuestion_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_ChallengeRegistrationPostTemplate_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_ChallengeRegistrationPostTemplate_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_ChallengeRegistrationPostTemplate_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_ChallengeRegistrationPostTemplate_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_ChallengeRegistrationPostTemplate_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_ChallengeRegistrationPostTemplate_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_UserSearch_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_UserSearch_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_UserSearch_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_UserSearch_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_UserSearch_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_UserSearch_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_CMS_AbuseReport' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_CMS_AbuseReport",
    @ParentColumn = "UserID",
    @ChildColumn = "ReportUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_view_EDW_Eligibility' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_view_EDW_Eligibility",
    @ParentColumn = "UserID",
    @ChildColumn = "MemberShipUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_view_EDW_Eligibility' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_view_EDW_Eligibility",
    @ParentColumn = "UserID",
    @ChildColumn = "PPTUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_PM_ProjectTaskStatus_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_PM_ProjectTaskStatus_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "ProjectTaskAssignedToUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_HFit_TrackerMedicalCarePlan' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_HFit_TrackerMedicalCarePlan",
    @ParentColumn = "UserID",
    @ChildColumn = "UserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_HFit_RewardsAwardUserDetail' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_HFit_RewardsAwardUserDetail",
    @ParentColumn = "UserID",
    @ChildColumn = "UserId",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_ToDoHealthAssesmentCompleted' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_ToDoHealthAssesmentCompleted",
    @ParentColumn = "UserID",
    @ChildColumn = "UserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_HFit_TrackerStressManagement' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_HFit_TrackerStressManagement",
    @ParentColumn = "UserID",
    @ChildColumn = "UserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_HFit_HA_IPadExceptionLog' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_HFit_HA_IPadExceptionLog",
    @ParentColumn = "UserID",
    @ChildColumn = "UserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_CONTENT_Article_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_CONTENT_Article_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_CONTENT_Article_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_CONTENT_Article_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_CONTENT_Article_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_CONTENT_Article_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_CoachingCommitToQuit_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_CoachingCommitToQuit_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_CoachingCommitToQuit_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_CoachingCommitToQuit_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_CoachingCommitToQuit_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_CoachingCommitToQuit_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_HFit_UserCoachingAlert_NotMet_Step5' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_HFit_UserCoachingAlert_NotMet_Step5",
    @ParentColumn = "UserID",
    @ChildColumn = "UserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_CoachingLMTemporalContainer_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_CoachingLMTemporalContainer_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_CoachingLMTemporalContainer_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_CoachingLMTemporalContainer_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_CoachingLMTemporalContainer_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_CoachingLMTemporalContainer_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_ContentBlock_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_ContentBlock_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_ContentBlock_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_ContentBlock_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_ContentBlock_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_ContentBlock_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_Boards_BoardMessage_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_Boards_BoardMessage_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "BoardUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_Boards_BoardMessage_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_Boards_BoardMessage_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "GroupApprovedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_Boards_BoardMessage_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_Boards_BoardMessage_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "GroupCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_Boards_BoardMessage_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_Boards_BoardMessage_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "MessageApprovedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_Boards_BoardMessage_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_Boards_BoardMessage_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "MessageUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_OutComeMessages_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_OutComeMessages_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_OutComeMessages_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_OutComeMessages_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_OutComeMessages_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_OutComeMessages_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_OM_Account' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_OM_Account",
    @ParentColumn = "UserID",
    @ChildColumn = "AccountOwnerUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_RewardGroup_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_RewardGroup_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_RewardGroup_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_RewardGroup_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_RewardGroup_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_RewardGroup_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_Forums_GroupForumPost_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_Forums_GroupForumPost_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "PostApprovedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_Forums_GroupForumPost_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_Forums_GroupForumPost_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "PostUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_Hfit_SecurityQuestionSettings_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_Hfit_SecurityQuestionSettings_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_Hfit_SecurityQuestionSettings_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_Hfit_SecurityQuestionSettings_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_Hfit_SecurityQuestionSettings_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_Hfit_SecurityQuestionSettings_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_HFit_Screening_PPT' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_HFit_Screening_PPT",
    @ParentColumn = "UserID",
    @ChildColumn = "UserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_CMS_Category' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_CMS_Category",
    @ParentColumn = "UserID",
    @ChildColumn = "CategoryUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_ChallengeRegistrationSettings_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_ChallengeRegistrationSettings_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_ChallengeRegistrationSettings_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_ChallengeRegistrationSettings_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_ChallengeRegistrationSettings_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_ChallengeRegistrationSettings_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_WellnessGoal_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_WellnessGoal_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_WellnessGoal_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_WellnessGoal_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_WellnessGoal_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_WellnessGoal_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_cms_usersite' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_cms_usersite",
    @ParentColumn = "UserID",
    @ChildColumn = "UserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_HFit_TrackerWholeGrains' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_HFit_TrackerWholeGrains",
    @ParentColumn = "UserID",
    @ChildColumn = "UserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_cms_usersettings' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_cms_usersettings",
    @ParentColumn = "UserID",
    @ChildColumn = "UserActivatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_cms_usersettings' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_cms_usersettings",
    @ParentColumn = "UserID",
    @ChildColumn = "UserSettingsUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_CMS_ACLItem' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_CMS_ACLItem",
    @ParentColumn = "UserID",
    @ChildColumn = "LastModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_CMS_ACLItem' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_CMS_ACLItem",
    @ParentColumn = "UserID",
    @ChildColumn = "UserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_CONTENT_Blog_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_CONTENT_Blog_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_CONTENT_Blog_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_CONTENT_Blog_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_CONTENT_Blog_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_CONTENT_Blog_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_HFit_HealthAssesmentAnswers' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_HFit_HealthAssesmentAnswers",
    @ParentColumn = "UserID",
    @ChildColumn = "UserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_CMS_WorkflowStepUser' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_CMS_WorkflowStepUser",
    @ParentColumn = "UserID",
    @ChildColumn = "UserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_CMS_WorkflowStepUser' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_CMS_WorkflowStepUser",
    @ParentColumn = "UserID",
    @ChildColumn = "WorkflowStepUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_view_ToDoCoachingEnrollment' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_view_ToDoCoachingEnrollment",
    @ParentColumn = "UserID",
    @ChildColumn = "UserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_HFit_TrackerCholesterol' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_HFit_TrackerCholesterol",
    @ParentColumn = "UserID",
    @ChildColumn = "UserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_CoachingMyGoalsSettings_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_CoachingMyGoalsSettings_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_CoachingMyGoalsSettings_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_CoachingMyGoalsSettings_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_CoachingMyGoalsSettings_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_CoachingMyGoalsSettings_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_HealthAssessment_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_HealthAssessment_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_HealthAssessment_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_HealthAssessment_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_HealthAssessment_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_HealthAssessment_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_view_EDW_Awards' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_view_EDW_Awards",
    @ParentColumn = "UserID",
    @ChildColumn = "UserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_CustomSettingsTemporalContainer_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_CustomSettingsTemporalContainer_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_CustomSettingsTemporalContainer_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_CustomSettingsTemporalContainer_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_CustomSettingsTemporalContainer_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_CustomSettingsTemporalContainer_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_Pillar_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_Pillar_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_Pillar_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_Pillar_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_Pillar_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_Pillar_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_HFit_LKP_TrackerCardioActivity' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_HFit_LKP_TrackerCardioActivity",
    @ParentColumn = "UserID",
    @ChildColumn = "UserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_RewardLevel_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_RewardLevel_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_RewardLevel_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_RewardLevel_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_RewardLevel_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_RewardLevel_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_CMS_EventLog_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_CMS_EventLog_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "UserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_CMS_ObjectSettings' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_CMS_ObjectSettings",
    @ParentColumn = "UserID",
    @ChildColumn = "ObjectCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_HFit_RewardsUserSummary' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_HFit_RewardsUserSummary",
    @ParentColumn = "UserID",
    @ChildColumn = "UserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_CMS_AutomationState' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_CMS_AutomationState",
    @ParentColumn = "UserID",
    @ChildColumn = "StateUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_Hfit_CoachingUserCMExclusion' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_Hfit_CoachingUserCMExclusion",
    @ParentColumn = "UserID",
    @ChildColumn = "UserId",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_Calculator_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_Calculator_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_Calculator_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_Calculator_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_Calculator_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_Calculator_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_SmallSteps_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_SmallSteps_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_SmallSteps_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_SmallSteps_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_SmallSteps_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_SmallSteps_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_HFit_HealthAssesmentUserStarted' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_HFit_HealthAssesmentUserStarted",
    @ParentColumn = "UserID",
    @ChildColumn = "UserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_hfit_ChallengeTeam_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_hfit_ChallengeTeam_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_hfit_ChallengeTeam_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_hfit_ChallengeTeam_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_hfit_ChallengeTeam_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_hfit_ChallengeTeam_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_hfit_WellnessGoalPostTemplate_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_hfit_WellnessGoalPostTemplate_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_hfit_WellnessGoalPostTemplate_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_hfit_WellnessGoalPostTemplate_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_hfit_WellnessGoalPostTemplate_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_hfit_WellnessGoalPostTemplate_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_HFit_TrackerSitLess' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_HFit_TrackerSitLess",
    @ParentColumn = "UserID",
    @ChildColumn = "UserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_view_EDW_TrackerShots' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_view_EDW_TrackerShots",
    @ParentColumn = "UserID",
    @ChildColumn = "UserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_HFit_TrackerBloodSugarAndGlucose' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_HFit_TrackerBloodSugarAndGlucose",
    @ParentColumn = "UserID",
    @ChildColumn = "UserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_HFit_TrackerHighFatFoods' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_HFit_TrackerHighFatFoods",
    @ParentColumn = "UserID",
    @ChildColumn = "UserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_CONTENT_BlogMonth_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_CONTENT_BlogMonth_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_CONTENT_BlogMonth_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_CONTENT_BlogMonth_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_CONTENT_BlogMonth_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_CONTENT_BlogMonth_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_STAGING_EDW_HealthAssessment' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "STAGING_EDW_HealthAssessment",
    @ParentColumn = "UserID",
    @ChildColumn = "USERID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_CoachingEvalHAOverall_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_CoachingEvalHAOverall_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_CoachingEvalHAOverall_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_CoachingEvalHAOverall_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_CoachingEvalHAOverall_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_CoachingEvalHAOverall_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_HFit_RewardsAwardUserDetailArchive' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_HFit_RewardsAwardUserDetailArchive",
    @ParentColumn = "UserID",
    @ChildColumn = "UserId",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_view_ToDoCoachingEnrollmentCompleted' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_view_ToDoCoachingEnrollmentCompleted",
    @ParentColumn = "UserID",
    @ChildColumn = "UserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_CoachingMyHealthInterestsSettings_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_CoachingMyHealthInterestsSettings_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_CoachingMyHealthInterestsSettings_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_CoachingMyHealthInterestsSettings_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_CoachingMyHealthInterestsSettings_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_CoachingMyHealthInterestsSettings_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_EmailTemplate_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_EmailTemplate_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_EmailTemplate_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_EmailTemplate_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_EmailTemplate_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_EmailTemplate_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_CMS_ObjectVersionHistoryUser_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_CMS_ObjectVersionHistoryUser_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "UserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_CMS_ObjectVersionHistoryUser_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_CMS_ObjectVersionHistoryUser_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "VersionDeletedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_CMS_ObjectVersionHistoryUser_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_CMS_ObjectVersionHistoryUser_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "VersionModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_PLPPackageContent_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_PLPPackageContent_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_PLPPackageContent_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_PLPPackageContent_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_PLPPackageContent_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_PLPPackageContent_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_HFit_HA_IPadLog' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_HFit_HA_IPadLog",
    @ParentColumn = "UserID",
    @ChildColumn = "UserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_RewardParameterBase_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_RewardParameterBase_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_RewardParameterBase_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_RewardParameterBase_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_RewardParameterBase_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_RewardParameterBase_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_HealthAssessmentConfiguration_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_HealthAssessmentConfiguration_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_HealthAssessmentConfiguration_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_HealthAssessmentConfiguration_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_HFit_HealthAssessmentConfiguration_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_HFit_HealthAssessmentConfiguration_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_HFit_HealthAssesmentUserQuestion' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_HFit_HealthAssesmentUserQuestion",
    @ParentColumn = "UserID",
    @ChildColumn = "UserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_hfit_challenge_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_hfit_challenge_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_hfit_challenge_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_hfit_challenge_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_hfit_challenge_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_hfit_challenge_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_hfit_SocialProof_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_hfit_SocialProof_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_hfit_SocialProof_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_hfit_SocialProof_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_hfit_SocialProof_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_hfit_SocialProof_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_hfit_ChallengeTeams_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_hfit_ChallengeTeams_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_hfit_ChallengeTeams_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_hfit_ChallengeTeams_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_hfit_ChallengeTeams_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_hfit_ChallengeTeams_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_HFit_TrackerTobaccoFree' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_HFit_TrackerTobaccoFree",
    @ParentColumn = "UserID",
    @ChildColumn = "UserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_HFit_HealthAdvisingSessionCompleted' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_HFit_HealthAdvisingSessionCompleted",
    @ParentColumn = "UserID",
    @ChildColumn = "UserId",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_view_EDW_TrackerTests' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_view_EDW_TrackerTests",
    @ParentColumn = "UserID",
    @ChildColumn = "UserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_SM_TwitterAccount' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_SM_TwitterAccount",
    @ParentColumn = "UserID",
    @ChildColumn = "TwitterAccountUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_CMS_VersionHistory' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_CMS_VersionHistory",
    @ParentColumn = "UserID",
    @ChildColumn = "ModifiedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_CMS_VersionHistory' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_CMS_VersionHistory",
    @ParentColumn = "UserID",
    @ChildColumn = "VersionDeletedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_Hfit_SmallStepResponses' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_Hfit_SmallStepResponses",
    @ParentColumn = "UserID",
    @ChildColumn = "UserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_HFit_TrackerPreventiveCare' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_HFit_TrackerPreventiveCare",
    @ParentColumn = "UserID",
    @ChildColumn = "UserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_CONTENT_BlogPost_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_CONTENT_BlogPost_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCheckedOutByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_CONTENT_BlogPost_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_CONTENT_BlogPost_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentCreatedByUserID",
    @PreviewOnly = 0 
END
GO
IF not EXISTS (SELECT name FROM sys.foreign_keys 
 WHERE name = 'FK_BASE_CMS_User_BASE_View_CONTENT_BlogPost_Joined' )
BEGIN 
  exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 
    @ParentTable = "BASE_CMS_User", 
    @ParentSurrogateKeyName = "SurrogateKey_cms_user",
    @ChildTable = "BASE_View_CONTENT_BlogPost_Joined",
    @ParentColumn = "UserID",
    @ChildColumn = "DocumentModifiedByUserID",
    @PreviewOnly = 0 
END
GO