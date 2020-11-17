exec proc_ActivateTable BASE_CMS_UserSettings, 1
go
exec proc_ActivateTable BASE_CMS_UserSettings, 1
go
exec proc_ActivateTable BASE_CMS_User, 1
go
exec proc_ActivateTable BASE_CMS_Site, 1
go
exec proc_ActivateTable BASE_HFit_Account, 1
go
exec proc_ActivateTable BASE_HFit_HealthAssesmentUserModule, 0, 1
go

--** exec proc_ActivateTable BASE_View_HFit_HACampaign_Joined, 0
--	exec proc_ActivateTable BASE_View_CMS_Tree_Joined, 0

exec proc_ActivateTable BASE_CMS_Document, 0
go
exec proc_ActivateTable BASE_CMS_Site, 0
go
exec proc_ActivateTable BASE_CMS_Class, 0
go
exec proc_ActivateTable BASE_COM_SKU, 0
go
exec proc_ActivateTable BASE_CMS_User, 0
go
		--exec proc_ActivateTable BASE_View_CMS_Tree_Joined_Linked, 0
exec proc_ActivateTable BASE_CMS_Tree, 0
go
exec proc_ActivateTable BASE_CMS_Document, 0
go
exec proc_ActivateTable BASE_CMS_Site, 0
go
exec proc_ActivateTable BASE_CMS_Class, 0
go
exec proc_ActivateTable BASE_HFit_HACampaign, 0
go
exec proc_ActivateTable BASE_HFit_HealthAssesmentUserRiskCategory, 0
go
exec proc_ActivateTable BASE_HFit_HealthAssesmentUserRiskArea, 0
go
exec proc_ActivateTable BASE_HFit_HealthAssesmentUserQuestion, 0
go
exec proc_ActivateTable BASE_View_EDW_HealthAssesmentQuestions, 0
go
-- exec proc_ActivateTable BASE_HFit_HealthAssesmentUserQuestionGroupResults, 0
exec proc_ActivateTable BASE_HFit_HealthAssesmentUserAnswers, 0
go

proc_ChangeJobRunSetting