

echo off
cd\
cd C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\CDCImplementation

rem call _CkFileExists "@IVP.MART_Build.sql"
del @IVP.MART_Build.sql

copy spacer.txt @IVP.MART_Build.sql


call CheckFile view_MART_HealthAssesment.SQL
call CheckFile view_MART_HealthAssesment_CT.sql
call CheckFile view_CoachEnrolledPPTCondition.sql
call CheckFile view_ConditionManagement.sql
call CheckFile VIEW_DIM_HA.sql
call CheckFile view_HealthAssesment_MART.sql
call CheckFile View_HFit_HealthAssessment_Joined_MART.sql
call CheckFile view_MART_HealthAssesment_CT.sql
call CheckFile view_UserExcludedCondition.sql
call CheckFile view_EDW_HealthAssesment_MART.sql

call CheckFile view_EDW_HealthAssessment_MART_Pull_CMS1.sql
call CheckFile view_EDW_HealthAssessment_MART_Pull_CMS2.sql
call CheckFile view_EDW_HealthAssessment_MART_Pull_CMS3.sql

Echo IVP GEN Complete - please review for errors.
Echo For assistance call Dale Miller 847-274-6622