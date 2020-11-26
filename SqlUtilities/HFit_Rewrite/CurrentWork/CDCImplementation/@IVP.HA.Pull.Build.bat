

echo off
echo Author: W. Dale Miller
cd\
cd C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\CDCImplementation

del @IVP.HA.Pull.Build.sql

copy spacer.txt @IVP.HA.Pull.Build.sql

call CheckFileHA_IVP proc_QuickRowCount.sql
call CheckFileHA_IVP PrintImmediate.sql
call CheckFileHA_IVP createOperators.sql

call CheckFileHA_IVP Create_BASE_MART_EDW_HealthAssesment.sql
call CheckFileHA_IVP Create_BASE_MART_EDW_HealthAssesment_DEL.sql
call CheckFileHA_IVP create_BASE_MART_EDW_HealthAssesment_VerHist.sql
call CheckFileHA_IVP Create_BASE_View_EDW_HealthAssesmentQuestions_HA_LastPullDate.sql

call CheckFileHA_IVP TRIG_DEL_BASE_MART_EDW_HealthAssesment.sql
call CheckFileHA_IVP TRIG_UPDT_BASE_MART_EDW_HealthAssesment.sql

call CheckFileHA_IVP view_EDW_HealthAssesment_MART_V2.sql
call CheckFileHA_IVP view_EDW_HealthAssessment_MART_Pull_CMS1.sql
call CheckFileHA_IVP view_EDW_HealthAssessment_MART_Pull_CMS2.sql
call CheckFileHA_IVP view_EDW_HealthAssessment_MART_Pull_CMS3.sql

call CheckFileHA_IVP proc_HA_Update_CMS_Site.sql
call CheckFileHA_IVP proc_HA_Update_HFit_HealthAssesmentUserAnswers.sql
call CheckFileHA_IVP proc_HA_Update_HFit_HealthAssesmentUserModule.sql
call CheckFileHA_IVP proc_HA_Update_HFit_HealthAssesmentUserQuestion.sql
call CheckFileHA_IVP proc_HA_Update_HFit_HealthAssesmentUserRiskArea.sql
call CheckFileHA_IVP proc_HA_Update_HFit_HealthAssesmentUserRiskCategory.sql
call CheckFileHA_IVP proc_HA_Update_View_EDW_HealthAssesmentQuestions.sql


call CheckFileHA_IVP proc_HA_MasterUpdate.sql 
call CheckFileHA_IVP JOB_proc_HA_MasterUpdate.sql

call CheckFileHA_IVP TRIG_DEL_BASE_HFit_HealthAssesmentUserStarted_HA_Sync.sql

call CheckFileHA_IVP IVP_HA_Instructions.sql

call CheckFileHA_IVP JobDDL.SQL

Echo IVP GEN Complete - please review for errors.
Echo For assistance call Dale Miller 847-274-6622
pause