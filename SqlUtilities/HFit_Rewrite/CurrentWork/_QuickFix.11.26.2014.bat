del IVP.ViewDatetime2Fix.sql 

copy /B spacer.txt IVP.ViewDatetime2Fix.sql

rem copy /B /Y IVP.ViewDatetime2Fix.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\_Eligibility\IVP.Eligibility.sql"
copy /B /Y IVP.ViewDatetime2Fix.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\_Eligibility\view_EDW_RoleEligibility.sql"
copy /B /Y IVP.ViewDatetime2Fix.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\_Eligibility\view_EDW_Eligibility.sql"

copy /B /Y IVP.ViewDatetime2Fix.sql + view_EDW_Awards.sql

copy /B /Y IVP.ViewDatetime2Fix.sql + view_EDW_BioMetrics.sql

copy /B /Y IVP.ViewDatetime2Fix.sql + view_EDW_BiometricViewRejectCriteria.sql

copy /B /Y IVP.ViewDatetime2Fix.sql + view_EDW_ClientCompany.sql

copy /B /Y IVP.ViewDatetime2Fix.sql + view_EDW_Coaches.sql

copy /B /Y IVP.ViewDatetime2Fix.sql + view_EDW_CoachingDefinition.sql

copy /B /Y IVP.ViewDatetime2Fix.sql + view_EDW_CoachingDetail.sql

copy /B /Y IVP.ViewDatetime2Fix.sql + view_EDW_HealthAssesment.sql

copy /B /Y IVP.ViewDatetime2Fix.sql + View_EDW_HealthAssesmentAnswers.sql

copy /B /Y IVP.ViewDatetime2Fix.sql + view_EDW_HealthAssesmentClientView.sql

copy /B /Y IVP.ViewDatetime2Fix.sql + view_EDW_HealthAssesmentDeffinition.sql

copy /B /Y IVP.ViewDatetime2Fix.sql + view_EDW_HealthAssesmentDeffinitionCustom.SQL

copy /B /Y IVP.ViewDatetime2Fix.sql + View_EDW_HealthAssesmentQuestions.sql

rem ******************************************************************************
rem copy /B /Y IVP.ViewDatetime2Fix.sql + view_EDW_HealthAssessment_Staged.sql
rem ******************************************************************************

copy /B /Y IVP.ViewDatetime2Fix.sql + view_EDW_HealthInterestDetail.sql

copy /B /Y IVP.ViewDatetime2Fix.sql + view_EDW_HealthInterestList

copy /B /Y IVP.ViewDatetime2Fix.sql + view_EDW_Participant.sql

copy /B /Y IVP.ViewDatetime2Fix.sql + View_EDW_RewardProgram_Joined.sql

copy /B /Y IVP.ViewDatetime2Fix.sql + view_EDW_RewardsDefinition.sql

copy /B /Y IVP.ViewDatetime2Fix.sql + view_EDW_RewardTriggerParameters.sql

copy /B /Y IVP.ViewDatetime2Fix.sql + view_EDW_RewardUserDetail.sql


copy /B /Y IVP.ViewDatetime2Fix.sql + view_EDW_ScreeningsFromTrackers.sql

copy /B /Y IVP.ViewDatetime2Fix.sql + view_EDW_SmallStepResponses.sql

copy /B /Y IVP.ViewDatetime2Fix.sql + view_EDW_TrackerCompositeDetails.sql

copy /B /Y IVP.ViewDatetime2Fix.sql + view_EDW_TrackerMetadata.sql

copy /B /Y IVP.ViewDatetime2Fix.sql + view_EDW_TrackerShots.sql

copy /B /Y IVP.ViewDatetime2Fix.sql + view_EDW_TrackerTests.sql

copy /B /Y IVP.ViewDatetime2Fix.sql + TheEnd.sql
