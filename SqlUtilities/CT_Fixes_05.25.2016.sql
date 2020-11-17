
--Turn change tracking on for:


go
alter table KenticoCMS_2.dbo.EDW_BiometricViewRejectCriteria  add EDW_BiometricViewRejectCriteria_GuidID uniqueidentifier not null default newid()
go

ALTER TABLE KenticoCMS_2.dbo.EDW_BiometricViewRejectCriteria  ADD  CONSTRAINT [PKey_CT_EDW_BiometricViewRejectCriteria] PRIMARY KEY NONCLUSTERED 
(
	[EDW_BiometricViewRejectCriteria_GuidID] ASC
)
GO
ALTER TABLE KenticoCMS_2.dbo.EDW_BiometricViewRejectCriteria ENABLE CHANGE_TRACKING WITH (TRACK_COLUMNS_UPDATED = ON)
--Change tracking is not enabled on table 'KenticoCMS_2.dbo.EDW_BiometricViewRejectCriteria'. 
--Change tracking is not enabled on table 'KenticoCMS_2.dbo.EDW_BiometricViewRejectCriteria'. 
--Change tracking is not enabled on table 'KenticoCMS_2.dbo.EDW_BiometricViewRejectCriteria'. 
ALTER TABLE KenticoCMS_2.dbo.HFit_ChallengePostTemplate ENABLE CHANGE_TRACKING WITH (TRACK_COLUMNS_UPDATED = ON)
--Change tracking is not enabled on table 'KenticoCMS_2.dbo.HFit_ChallengePostTemplate'. 
--Change tracking is not enabled on table 'KenticoCMS_2.dbo.HFit_ChallengePostTemplate'. 
--Change tracking is not enabled on table 'KenticoCMS_2.dbo.HFit_ChallengePostTemplate'. 
ALTER TABLE KenticoCMS_2.dbo.HFit_ChallengeRegistrationPostTemplate ENABLE CHANGE_TRACKING WITH (TRACK_COLUMNS_UPDATED = ON)
--Change tracking is not enabled on table 'KenticoCMS_2.dbo.HFit_ChallengeRegistrationPostTemplate'. 
--Change tracking is not enabled on table 'KenticoCMS_2.dbo.HFit_ChallengeRegistrationPostTemplate'. 
--Change tracking is not enabled on table 'KenticoCMS_2.dbo.HFit_ChallengeRegistrationPostTemplate'. 
ALTER TABLE KenticoCMS_2.dbo.HFit_ChallengeRegistrationTempData ENABLE CHANGE_TRACKING WITH (TRACK_COLUMNS_UPDATED = ON)
--Change tracking is not enabled on table 'KenticoCMS_2.dbo.HFit_ChallengeRegistrationTempData'. 
--Change tracking is not enabled on table 'KenticoCMS_2.dbo.HFit_ChallengeRegistrationTempData'. 
--Change tracking is not enabled on table 'KenticoCMS_2.dbo.HFit_ChallengeRegistrationTempData'. 
ALTER TABLE KenticoCMS_2.dbo.HFit_CustomSettingsTemporalContainer ENABLE CHANGE_TRACKING WITH (TRACK_COLUMNS_UPDATED = ON)
--Change tracking is not enabled on table 'KenticoCMS_2.dbo.HFit_CustomSettingsTemporalContainer'. 
--Change tracking is not enabled on table 'KenticoCMS_2.dbo.HFit_CustomSettingsTemporalContainer'. 
--Change tracking is not enabled on table 'KenticoCMS_2.dbo.HFit_CustomSettingsTemporalContainer'. 
ALTER TABLE KenticoCMS_2.dbo.HFit_EmailTemplate ENABLE CHANGE_TRACKING WITH (TRACK_COLUMNS_UPDATED = ON)
--Change tracking is not enabled on table 'KenticoCMS_2.dbo.HFit_EmailTemplate'. 
--Change tracking is not enabled on table 'KenticoCMS_2.dbo.HFit_EmailTemplate'. 
--Change tracking is not enabled on table 'KenticoCMS_2.dbo.HFit_EmailTemplate'. 
ALTER TABLE KenticoCMS_1.dbo.HFit_LKP_CoachViewTimeZone ENABLE CHANGE_TRACKING WITH (TRACK_COLUMNS_UPDATED = ON)
--Change tracking is not enabled on table 'KenticoCMS_1.dbo.HFit_LKP_CoachViewTimeZone'. 
--Change tracking is not enabled on table 'KenticoCMS_1.dbo.HFit_LKP_CoachViewTimeZone'. 
--Change tracking is not enabled on table 'KenticoCMS_1.dbo.HFit_LKP_CoachViewTimeZone'. 
ALTER TABLE KenticoCMS_1.dbo.HFit_PostEmptyFeed ENABLE CHANGE_TRACKING WITH (TRACK_COLUMNS_UPDATED = ON)
--Change tracking is not enabled on table 'KenticoCMS_1.dbo.HFit_PostEmptyFeed'. 
--Change tracking is not enabled on table 'KenticoCMS_1.dbo.HFit_PostEmptyFeed'. 
--Change tracking is not enabled on table 'KenticoCMS_1.dbo.HFit_PostEmptyFeed'. 
ALTER TABLE KenticoCMS_1.dbo.HFit_ScreeningTemporalContainer ENABLE CHANGE_TRACKING WITH (TRACK_COLUMNS_UPDATED = ON)
--Change tracking is not enabled on table 'KenticoCMS_1.dbo.HFit_ScreeningTemporalContainer'. 
--Change tracking is not enabled on table 'KenticoCMS_1.dbo.HFit_ScreeningTemporalContainer'. 
--Change tracking is not enabled on table 'KenticoCMS_1.dbo.HFit_ScreeningTemporalContainer'. 
ALTER TABLE KenticoCMS_1.dbo.hfit_TemporalConfigurationContainer ENABLE CHANGE_TRACKING WITH (TRACK_COLUMNS_UPDATED = ON)
--Change tracking is not enabled on table 'KenticoCMS_1.dbo.hfit_TemporalConfigurationContainer'. 
--Change tracking is not enabled on table 'KenticoCMS_1.dbo.hfit_TemporalConfigurationContainer'. 
--Change tracking is not enabled on table 'KenticoCMS_1.dbo.hfit_TemporalConfigurationContainer'. 
ALTER TABLE KenticoCMS_1.dbo.hfit_WellnessGoalPostTemplate ENABLE CHANGE_TRACKING WITH (TRACK_COLUMNS_UPDATED = ON)
--Change tracking is not enabled on table 'KenticoCMS_1.dbo.hfit_WellnessGoalPostTemplate'. 
--Change tracking is not enabled on table 'KenticoCMS_1.dbo.hfit_WellnessGoalPostTemplate'. 
--Change tracking is not enabled on table 'KenticoCMS_1.dbo.hfit_WellnessGoalPostTemplate'. 
ALTER TABLE KenticoCMS_1.dbo.OM_ABTest ENABLE CHANGE_TRACKING WITH (TRACK_COLUMNS_UPDATED = ON)
--Change tracking is not enabled on table 'KenticoCMS_1.dbo.OM_ABTest'. 
--Change tracking is not enabled on table 'KenticoCMS_1.dbo.OM_ABTest'. 
--Change tracking is not enabled on table 'KenticoCMS_1.dbo.OM_ABTest'. 
--Change tracking is not enabled on table 'KenticoCMS_1.dbo.OM_ABTest'. 
--Change tracking is not enabled on table 'KenticoCMS_1.dbo.OM_ABTest'. 
ALTER TABLE KenticoCMS_1.dbo.OM_MVTest ENABLE CHANGE_TRACKING WITH (TRACK_COLUMNS_UPDATED = ON)
--Change tracking is not enabled on table 'KenticoCMS_1.dbo.OM_MVTest'. 
--Change tracking is not enabled on table 'KenticoCMS_1.dbo.OM_MVTest'. 
--Change tracking is not enabled on table 'KenticoCMS_1.dbo.OM_MVTest'. 
--Change tracking is not enabled on table 'KenticoCMS_1.dbo.OM_MVTest'. 
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
