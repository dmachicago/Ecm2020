cd "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork"

del IVP.RELEASE.3.4.sql 

copy spacer.txt IVP.RELEASE.3.4.sql

rem **************************************************************************************************
rem cd "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\_Eligibility"
rem call  _Build.Eligibility.bat
rem cd "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork"
rem **************************************************************************************************
copy /A /Y IVP.RELEASE.3.4.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\_Eligibility\IVP.Eligibility.sql"

copy /A /Y IVP.RELEASE.3.4.sql + spacer.txt
copy /A /Y IVP.RELEASE.3.4.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_Participant.sql"


copy /A /Y IVP.RELEASE.3.4.sql + spacer.txt
copy /A /Y IVP.RELEASE.3.4.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_RewardUserDetail.sql"

copy /A /Y IVP.RELEASE.3.4.sql + spacer.txt
copy /A /Y IVP.RELEASE.3.4.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\IVP.RELEASE.3.4.sql"

copy  /A /Y IVP.RELEASE.3.4.sql + spacer.txt
copy  /A /Y IVP.RELEASE.3.4.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_RewardAwardDetail.sql"

rem copy  /A /Y IVP.RELEASE.3.4.sql + spacer.txt
rem copy  /A /Y IVP.RELEASE.3.4.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\DropUnNeededIndexes.sql"

copy  /A /Y IVP.RELEASE.3.4.sql + spacer.txt
copy  /A /Y IVP.RELEASE.3.4.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\_Eligibility\view_EDW_RoleEligibility.sql"

copy  /A /Y IVP.RELEASE.3.4.sql + spacer.txt
copy  /A /Y IVP.RELEASE.3.4.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_CoachingPPTEnrolled.sql"

copy  /A /Y IVP.RELEASE.3.4.sql + spacer.txt
copy  /A /Y IVP.RELEASE.3.4.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_CoachingPPTEligible.sql"

copy  /A /Y IVP.RELEASE.3.4.sql + spacer.txt
copy  /A /Y IVP.RELEASE.3.4.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_TrackerCompositeDetails.sql"

copy  /A /Y IVP.RELEASE.3.4.sql + spacer.txt
copy  /A /Y IVP.RELEASE.3.4.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_SmallStepResponses.sql"

copy  /A /Y IVP.RELEASE.3.4.sql + spacer.txt
copy  /A /Y IVP.RELEASE.3.4.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_BioMetrics.sql"

copy  /A /Y IVP.RELEASE.3.4.sql + spacer.txt
copy  /A /Y IVP.RELEASE.3.4.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_RewardTriggerParameters.sql"

copy  /A /Y IVP.RELEASE.3.4.sql + spacer.txt
copy  /A /Y IVP.RELEASE.3.4.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_HealthAssesmentClientView.sql"


copy /A /Y IVP.RELEASE.3.4.sql + spacer.txt
copy /A /Y IVP.RELEASE.3.4.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_RewardUserLevel.sql

copy /A /Y IVP.RELEASE.3.4.sql + spacer.txt
copy /A /Y IVP.RELEASE.3.4.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_HealthInterestList.sql

copy /A /Y IVP.RELEASE.3.4.sql + spacer.txt
copy /A /Y IVP.RELEASE.3.4.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_Awards.sql

copy /A /Y IVP.RELEASE.3.4.sql + spacer.txt
copy /A /Y IVP.RELEASE.3.4.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_ClientCompany.sql

copy /A /Y IVP.RELEASE.3.4.sql + spacer.txt
copy /A /Y IVP.RELEASE.3.4.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_Coaches.sql

copy /A /Y IVP.RELEASE.3.4.sql + spacer.txt
copy /A /Y IVP.RELEASE.3.4.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_CoachingDefinition.sql

copy /A /Y IVP.RELEASE.3.4.sql + spacer.txt
copy /A /Y IVP.RELEASE.3.4.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_CoachingDetail.sql

copy /A /Y IVP.RELEASE.3.4.sql + spacer.txt
copy /A /Y IVP.RELEASE.3.4.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\View_EDW_HealthAssesmentQuestions.sql

copy /A /Y IVP.RELEASE.3.4.sql + spacer.txt
copy /A /Y IVP.RELEASE.3.4.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_HealthAssesment.sql

copy /A /Y IVP.RELEASE.3.4.sql + spacer.txt
copy /A /Y IVP.RELEASE.3.4.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\View_EDW_HealthAssesmentAnswers.sql

copy /A /Y IVP.RELEASE.3.4.sql + spacer.txt
copy /A /Y IVP.RELEASE.3.4.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_HealthAssesmentClientView.sql

copy /A /Y IVP.RELEASE.3.4.sql + spacer.txt
copy /A /Y IVP.RELEASE.3.4.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_HealthAssesmentDeffinition.sql

copy /A /Y IVP.RELEASE.3.4.sql + spacer.txt
copy /A /Y IVP.RELEASE.3.4.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_HealthAssesmentDeffinitionCustom.sql

copy /A /Y IVP.RELEASE.3.4.sql + spacer.txt
copy /A /Y IVP.RELEASE.3.4.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_HealthInterestDetail.sql

copy /A /Y IVP.RELEASE.3.4.sql + spacer.txt
copy /A /Y IVP.RELEASE.3.4.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\View_EDW_RewardProgram_Joined.sql AS 

copy /A /Y IVP.RELEASE.3.4.sql + spacer.txt
copy /A /Y IVP.RELEASE.3.4.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_ScreeningsFromTrackers.sql

copy /A /Y IVP.RELEASE.3.4.sql + spacer.txt
copy /A /Y IVP.RELEASE.3.4.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_TrackerMetadata.sql

copy /A /Y IVP.RELEASE.3.4.sql + spacer.txt
copy /A /Y IVP.RELEASE.3.4.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_TrackerShots.sql

copy /A /Y IVP.RELEASE.3.4.sql + spacer.txt
copy /A /Y IVP.RELEASE.3.4.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_TrackerTests.sql

copy /A /Y IVP.RELEASE.3.4.sql + spacer.txt
copy /A /Y IVP.RELEASE.3.4.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_TrackerCompositeDetails.sql

copy /A /Y IVP.RELEASE.3.4.sql + spacer.txt
copy /A /Y IVP.RELEASE.3.4.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\PrintNow.sql"

copy /A /Y IVP.RELEASE.3.4.sql + spacer.txt
copy /A /Y IVP.RELEASE.3.4.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\Proc_EDW_TrackerMetadataExtract.SQL"


rem **************************************************************************************************
copy /A /Y IVP.RELEASE.3.4.sql + TheEnd.sql
