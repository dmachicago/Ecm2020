if exists ( select name from sys.tables where name = 'TEMPCOMPARE_view_EDW_Awards') BEGIN 
 DROP TABLE TEMPCOMPARE_view_EDW_Awards
 END ;
select * into TEMPCOMPARE_view_EDW_Awards FROM view_EDW_Awards;


if exists ( select name from sys.tables where name = 'TEMPCOMPARE_view_EDW_BioMetrics') BEGIN 
 DROP TABLE TEMPCOMPARE_view_EDW_BioMetrics
 END ;
select * into TEMPCOMPARE_view_EDW_BioMetrics FROM view_EDW_BioMetrics;


if exists ( select name from sys.tables where name = 'TEMPCOMPARE_view_EDW_ClientCompany') BEGIN 
 DROP TABLE TEMPCOMPARE_view_EDW_ClientCompany
 END ;
select * into TEMPCOMPARE_view_EDW_ClientCompany FROM view_EDW_ClientCompany;


if exists ( select name from sys.tables where name = 'TEMPCOMPARE_view_EDW_Coaches') BEGIN 
 DROP TABLE TEMPCOMPARE_view_EDW_Coaches
 END ;
select * into TEMPCOMPARE_view_EDW_Coaches FROM view_EDW_Coaches;


if exists ( select name from sys.tables where name = 'TEMPCOMPARE_view_EDW_CoachingDefinition') BEGIN 
 DROP TABLE TEMPCOMPARE_view_EDW_CoachingDefinition
 END ;
select * into TEMPCOMPARE_view_EDW_CoachingDefinition FROM view_EDW_CoachingDefinition;


if exists ( select name from sys.tables where name = 'TEMPCOMPARE_view_EDW_CoachingDetail') BEGIN 
 DROP TABLE TEMPCOMPARE_view_EDW_CoachingDetail
 END ;
select * into TEMPCOMPARE_view_EDW_CoachingDetail FROM view_EDW_CoachingDetail;


if exists ( select name from sys.tables where name = 'TEMPCOMPARE_view_EDW_Eligibility') BEGIN 
 DROP TABLE TEMPCOMPARE_view_EDW_Eligibility
 END ;
select * into TEMPCOMPARE_view_EDW_Eligibility FROM view_EDW_Eligibility;


if exists ( select name from sys.tables where name = 'TEMPCOMPARE_view_EDW_EligibilityHistory') BEGIN 
 DROP TABLE TEMPCOMPARE_view_EDW_EligibilityHistory
 END ;
select * into TEMPCOMPARE_view_EDW_EligibilityHistory FROM view_EDW_EligibilityHistory;


if exists ( select name from sys.tables where name = 'TEMPCOMPARE_view_EDW_HealthAssesment') BEGIN 
 DROP TABLE TEMPCOMPARE_view_EDW_HealthAssesment
 END ;
select * into TEMPCOMPARE_view_EDW_HealthAssesment FROM view_EDW_HealthAssesment;


if exists ( select name from sys.tables where name = 'TEMPCOMPARE_View_EDW_HealthAssesmentAnswers') BEGIN 
 DROP TABLE TEMPCOMPARE_View_EDW_HealthAssesmentAnswers
 END ;
select * into TEMPCOMPARE_View_EDW_HealthAssesmentAnswers FROM View_EDW_HealthAssesmentAnswers;


if exists ( select name from sys.tables where name = 'TEMPCOMPARE_view_EDW_HealthAssesmentClientView') BEGIN 
 DROP TABLE TEMPCOMPARE_view_EDW_HealthAssesmentClientView
 END ;
select * into TEMPCOMPARE_view_EDW_HealthAssesmentClientView FROM view_EDW_HealthAssesmentClientView;


if exists ( select name from sys.tables where name = 'TEMPCOMPARE_view_EDW_HealthAssesmentDeffinition') BEGIN 
 DROP TABLE TEMPCOMPARE_view_EDW_HealthAssesmentDeffinition
 END ;
select * into TEMPCOMPARE_view_EDW_HealthAssesmentDeffinition FROM view_EDW_HealthAssesmentDeffinition;


if exists ( select name from sys.tables where name = 'TEMPCOMPARE_view_EDW_HealthAssesmentDeffinitionCustom') BEGIN 
 DROP TABLE TEMPCOMPARE_view_EDW_HealthAssesmentDeffinitionCustom
 END ;
select * into TEMPCOMPARE_view_EDW_HealthAssesmentDeffinitionCustom FROM view_EDW_HealthAssesmentDeffinitionCustom;


if exists ( select name from sys.tables where name = 'TEMPCOMPARE_View_EDW_HealthAssesmentQuestions') BEGIN 
 DROP TABLE TEMPCOMPARE_View_EDW_HealthAssesmentQuestions
 END ;
select * into TEMPCOMPARE_View_EDW_HealthAssesmentQuestions FROM View_EDW_HealthAssesmentQuestions;


if exists ( select name from sys.tables where name = 'TEMPCOMPARE_view_EDW_HealthInterestDetail') BEGIN 
 DROP TABLE TEMPCOMPARE_view_EDW_HealthInterestDetail
 END ;
select * into TEMPCOMPARE_view_EDW_HealthInterestDetail FROM view_EDW_HealthInterestDetail;


if exists ( select name from sys.tables where name = 'TEMPCOMPARE_view_EDW_HealthInterestList') BEGIN 
 DROP TABLE TEMPCOMPARE_view_EDW_HealthInterestList
 END ;
select * into TEMPCOMPARE_view_EDW_HealthInterestList FROM view_EDW_HealthInterestList;


if exists ( select name from sys.tables where name = 'TEMPCOMPARE_view_EDW_Participant') BEGIN 
 DROP TABLE TEMPCOMPARE_view_EDW_Participant
 END ;
select * into TEMPCOMPARE_view_EDW_Participant FROM view_EDW_Participant;


if exists ( select name from sys.tables where name = 'TEMPCOMPARE_view_EDW_RewardAwardDetail') BEGIN 
 DROP TABLE TEMPCOMPARE_view_EDW_RewardAwardDetail
 END ;
select * into TEMPCOMPARE_view_EDW_RewardAwardDetail FROM view_EDW_RewardAwardDetail;


if exists ( select name from sys.tables where name = 'TEMPCOMPARE_View_EDW_RewardProgram_Joined') BEGIN 
 DROP TABLE TEMPCOMPARE_View_EDW_RewardProgram_Joined
 END ;
select * into TEMPCOMPARE_View_EDW_RewardProgram_Joined FROM View_EDW_RewardProgram_Joined;


if exists ( select name from sys.tables where name = 'TEMPCOMPARE_view_EDW_RewardsDefinition') BEGIN 
 DROP TABLE TEMPCOMPARE_view_EDW_RewardsDefinition
 END ;
select * into TEMPCOMPARE_view_EDW_RewardsDefinition FROM view_EDW_RewardsDefinition;


if exists ( select name from sys.tables where name = 'TEMPCOMPARE_view_EDW_RewardTriggerParameters') BEGIN 
 DROP TABLE TEMPCOMPARE_view_EDW_RewardTriggerParameters
 END ;
select * into TEMPCOMPARE_view_EDW_RewardTriggerParameters FROM view_EDW_RewardTriggerParameters;


if exists ( select name from sys.tables where name = 'TEMPCOMPARE_view_EDW_RewardUserDetail') BEGIN 
 DROP TABLE TEMPCOMPARE_view_EDW_RewardUserDetail
 END ;
select * into TEMPCOMPARE_view_EDW_RewardUserDetail FROM view_EDW_RewardUserDetail;


if exists ( select name from sys.tables where name = 'TEMPCOMPARE_view_EDW_RewardUserLevel') BEGIN 
 DROP TABLE TEMPCOMPARE_view_EDW_RewardUserLevel
 END ;
select * into TEMPCOMPARE_view_EDW_RewardUserLevel FROM view_EDW_RewardUserLevel;


if exists ( select name from sys.tables where name = 'TEMPCOMPARE_view_EDW_ScreeningsFromTrackers') BEGIN 
 DROP TABLE TEMPCOMPARE_view_EDW_ScreeningsFromTrackers
 END ;
select * into TEMPCOMPARE_view_EDW_ScreeningsFromTrackers FROM view_EDW_ScreeningsFromTrackers;


if exists ( select name from sys.tables where name = 'TEMPCOMPARE_view_EDW_SmallStepResponses') BEGIN 
 DROP TABLE TEMPCOMPARE_view_EDW_SmallStepResponses
 END ;
select * into TEMPCOMPARE_view_EDW_SmallStepResponses FROM view_EDW_SmallStepResponses;


if exists ( select name from sys.tables where name = 'TEMPCOMPARE_view_EDW_TrackerCompositeDetails') BEGIN 
 DROP TABLE TEMPCOMPARE_view_EDW_TrackerCompositeDetails
 END ;
select * into TEMPCOMPARE_view_EDW_TrackerCompositeDetails FROM view_EDW_TrackerCompositeDetails;


if exists ( select name from sys.tables where name = 'TEMPCOMPARE_view_EDW_TrackerMetadata') BEGIN 
 DROP TABLE TEMPCOMPARE_view_EDW_TrackerMetadata
 END ;
select * into TEMPCOMPARE_view_EDW_TrackerMetadata FROM view_EDW_TrackerMetadata;


if exists ( select name from sys.tables where name = 'TEMPCOMPARE_view_EDW_TrackerShots') BEGIN 
 DROP TABLE TEMPCOMPARE_view_EDW_TrackerShots
 END ;
select * into TEMPCOMPARE_view_EDW_TrackerShots FROM view_EDW_TrackerShots;


if exists ( select name from sys.tables where name = 'TEMPCOMPARE_view_EDW_TrackerTests') BEGIN 
 DROP TABLE TEMPCOMPARE_view_EDW_TrackerTests
 END ;
select * into TEMPCOMPARE_view_EDW_TrackerTests FROM view_EDW_TrackerTests;

