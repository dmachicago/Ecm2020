
--select top 1000 * from HFit_HealthAssesmentUserAnswers
--update HFit_HealthAssesmentUserAnswers set CodeName = lower(CodeName) where UserID = 710 and CodeName = 'Sometimes'
--update HFit_HealthAssesmentUserAnswers set CodeName = Upper(CodeName) where UserID = 711 and CodeName = 'Sometimes'
--update HFit_HealthAssesmentUserAnswers set CodeName = 'Sometimes' where UserID = 710 and CodeName = 'Sometimes'

--update HFit_HealthAssesmentUserAnswers set CodeName = 'hdl' where UserID = 1132 and CodeName = 'HDL'
--update HFit_HealthAssesmentUserAnswers set CodeName = 'Hdl' where UserID = 1132 and CodeName = 'HDL'

DROP TABLE ##XXXX;
go
print 'STARTING: ' ;
print getdate() ;

DECLARE
   @ST AS datetime = GETDATE( );

DECLARE
   @EID AS bigint = ( SELECT
                             CHANGE_TRACKING_CURRENT_VERSION ( ));

declare @SEC as float = 0 ; 

DECLARE
   @SID AS bigint = ( SELECT
                             MAX ( CurrentDbVersion )
                        FROM CT_VersionTracking
                        WHERE
                             SVRname = @@ServerName
                         AND DBName = DB_NAME ( )
                         AND TgtView = 'view_EDW_HealthAssesment' );
if @Sid is null
    set @SID = 0;

SELECT
       UserStartedItemID
       ,HealthAssesmentUserStartedNodeGUID
       ,UserID
       ,UserGUID
       ,HFitUserMpiNumber
       ,SiteGUID
       ,AccountID
       ,AccountCD
       ,AccountName
       ,HAStartedDt
       ,HACompletedDt
       ,UserModuleItemId
       ,UserModuleCodeName
       ,HAModuleNodeGUID
       ,CMSNodeGuid
       ,HAModuleVersionID
       ,UserRiskCategoryItemID
       ,UserRiskCategoryCodeName
       ,HARiskCategoryNodeGUID
       ,HARiskCategoryVersionID
       ,UserRiskAreaItemID
       ,UserRiskAreaCodeName
       ,HARiskAreaNodeGUID
       ,HARiskAreaVersionID
       ,UserQuestionItemID
       ,Title
       ,HAQuestionGuid
       ,UserQuestionCodeName
       ,HAQuestionDocumentID
       ,HAQuestionVersionID
       ,HAQuestionNodeGUID
       ,UserAnswerItemID
       ,HAAnswerNodeGUID
       ,HAAnswerVersionID
       ,UserAnswerCodeName
       ,HAAnswerValue
       ,HAModuleScore
       ,HARiskCategoryScore
       ,HARiskAreaScore
       ,HAQuestionScore
       ,HAAnswerPoints
       ,PointResults
       ,UOMCode
       ,HAScore
       ,ModulePreWeightedScore
       ,RiskCategoryPreWeightedScore
       ,RiskAreaPreWeightedScore
       ,QuestionPreWeightedScore
       ,QuestionGroupCodeName
       ,ChangeType
       ,ItemCreatedWhen
       ,ItemModifiedWhen
       ,IsProfessionallyCollected
       ,HARiskCategory_ItemModifiedWhen
       ,HAUserRiskArea_ItemModifiedWhen
       ,HAUserQuestion_ItemModifiedWhen
       ,HAUserAnswers_ItemModifiedWhen
       ,HAPaperFlg
       ,HATelephonicFlg
       ,HAStartedMode
       ,HACompletedMode
       ,DocumentCulture_VHCJ
       ,DocumentCulture_HAQuestionsView
       ,CampaignNodeGUID
       ,HACampaignID
       ,HashCode
       ,PKHashCode
       ,CHANGED_FLG
       ,CT_CMS_User_UserID
       ,CT_CMS_User_CHANGE_OPERATION
       ,CT_UserSettingsID
       ,CT_UserSettingsID_CHANGE_OPERATION
       ,SiteID_CtID
       ,SiteID_CHANGE_OPERATION
       ,UserSiteID_CtID
       ,UserSiteID_CHANGE_OPERATION
       ,AccountID_CtID
       ,AccountID__CHANGE_OPERATION
       ,HAUserAnswers_CtID
       ,HAUserAnswers_CHANGE_OPERATION
       ,HFit_HealthAssesmentUserModule_CtID
       ,HFit_HealthAssesmentUserModule_CHANGE_OPERATION
       ,HFit_HealthAssesmentUserQuestion_CtID
       ,HFit_HealthAssesmentUserQuestion_CHANGE_OPERATION
       ,HFit_HealthAssesmentUserQuestionGroupResults_CtID
       ,HFit_HealthAssesmentUserQuestionGroupResults_CHANGE_OPERATION
       ,HFit_HealthAssesmentUserRiskArea_CtID
       ,HFit_HealthAssesmentUserRiskArea_CHANGE_OPERATION
       ,HFit_HealthAssesmentUserRiskCategory_CtID
       ,HFit_HealthAssesmentUserRiskCategory_CHANGE_OPERATION
       ,HFit_HealthAssesmentUserStarted_CtID
       ,HFit_HealthAssesmentUserStarted_CHANGE_OPERATION
       ,CT_CMS_User_SCV
       ,CT_CMS_UserSettings_SCV
       ,CT_CMS_Site_SCV
       ,CT_CMS_UserSite_SCV
       ,CT_HFit_Account_SCV
       ,CT_HFit_HealthAssesmentUserAnswers_SCV
       ,CT_HFit_HealthAssesmentUserModule_SCV
       ,CT_HFit_HealthAssesmentUserQuestion_SCV
       ,CT_HFit_HealthAssesmentUserQuestionGroupResults_SCV
       ,CT_HFit_HealthAssesmentUserRiskArea_SCV
       ,CT_HFit_HealthAssesmentUserRiskCategory_SCV
       ,CT_HFit_HealthAssesmentUserStarted_SCV
       ,NULL AS LastModifiedDate
       ,NULL AS DeleteFlg
INTO
     ##XXXX
  FROM view_EDW_HealthAssesment_CT
  WHERE
  ChangeType IS NOT NULL;

DECLARE
   @PULLRECS AS bigint = @@ROWCOUNT;

print getdate() ;
set @SEC = datediff(second, @ST , getdate()) ;
print cast(@PULLRECS as nvarchar(50)) + ' Records Pulled in : ' + cast((@SEC / 60) as nvarchar(50)) + ' minutes.'  ;

declare @IPULLSTART as datetime = getdate() ;

CREATE NONCLUSTERED INDEX TEMP_PI_EDW_HA_CT ON ##XXXX
(
CT_CMS_User_SCV
, CT_CMS_UserSettings_SCV
, CT_CMS_Site_SCV
, CT_CMS_UserSite_SCV
, CT_HFit_Account_SCV
, CT_HFit_HealthAssesmentUserAnswers_SCV
, CT_HFit_HealthAssesmentUserModule_SCV
, CT_HFit_HealthAssesmentUserQuestion_SCV
, CT_HFit_HealthAssesmentUserQuestionGroupResults_SCV
, CT_HFit_HealthAssesmentUserRiskArea_SCV
, CT_HFit_HealthAssesmentUserRiskCategory_SCV
, CT_HFit_HealthAssesmentUserStarted_SCV
);


print 'INDEX COMPLETE: ' ;
print getdate() ;
set @SEC = datediff(second, @IPULLSTART , getdate()) ;
print ' Records Indexed in : ' + cast((@SEC / 60) as nvarchar(50)) + ' minutes.'  ;

declare @DELSTART as datetime = getdate() ;
DELETE FROM ##XXXX
  WHERE
       CT_CMS_User_SCV  NOT BETWEEN @SID AND @EID
    OR CT_CMS_UserSettings_SCV  NOT BETWEEN @SID AND @EID
    OR CT_CMS_Site_SCV  NOT BETWEEN @SID AND @EID
    OR CT_CMS_UserSite_SCV  NOT BETWEEN @SID AND @EID
    OR CT_HFit_Account_SCV  NOT BETWEEN @SID AND @EID
    OR CT_HFit_HealthAssesmentUserAnswers_SCV  NOT BETWEEN @SID AND @EID
    OR CT_HFit_HealthAssesmentUserModule_SCV  NOT BETWEEN @SID AND @EID
    OR CT_HFit_HealthAssesmentUserQuestion_SCV  NOT BETWEEN @SID AND @EID
    OR CT_HFit_HealthAssesmentUserQuestionGroupResults_SCV  NOT BETWEEN @SID AND @EID
    OR CT_HFit_HealthAssesmentUserRiskArea_SCV  NOT BETWEEN @SID AND @EID
    OR CT_HFit_HealthAssesmentUserRiskCategory_SCV  NOT BETWEEN @SID AND @EID
    OR CT_HFit_HealthAssesmentUserStarted_SCV  NOT BETWEEN @SID AND @EID;

print 'DELETE COMPLETE: ' ;
print getdate() ;
set @SEC = datediff(second, @DELSTART , getdate()) ;
print ' Records Deleted in : ' + cast((@SEC / 60) as nvarchar(50)) + ' minutes.'  ;


DECLARE
   @RejectedRecs AS bigint = @@ROWCOUNT;
DECLARE
   @CNT AS bigint = ( SELECT
                             COUNT( * )
                        FROM ##XXXX );
DECLARE
   @ET AS datetime = GETDATE( );
set @SEC = DATEDIFF( millisecond , @ST , @ET ) / 1000;
DECLARE
   @MIN AS float = @SEC / 60;
DECLARE
   @HR AS float = @MIN / 60;

PRINT 'START TIME: ' + CAST( @ST AS nvarchar( 50 ));
PRINT 'END TIME: ' + CAST( @ET AS nvarchar( 50 ));
PRINT 'Total Seconds: ' + CAST( @SEC AS nvarchar( 50 ));
PRINT 'Total Minutes: ' + CAST( @MIN AS nvarchar( 50 ));
PRINT 'Total Hours: ' + CAST( @HR AS nvarchar( 50 ));
PRINT 'Records Pulled: ' + CAST( @CNT AS nvarchar( 50 ));
PRINT '@PULLRECS: ' + CAST( @PULLRECS AS nvarchar( 50 ));
PRINT '@RejectedRecs: ' + CAST( @RejectedRecs AS nvarchar( 50 ));