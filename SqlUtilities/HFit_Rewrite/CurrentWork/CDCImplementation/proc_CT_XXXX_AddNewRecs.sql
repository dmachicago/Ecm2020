
GO
-- use KenticoCMS_Prod1

GO
PRINT 'Executing proc_CT_XXXX_AddNewRecs.sql';
GO
IF EXISTS ( SELECT
                   name
                   FROM sys.procedures
                   WHERE name = 'proc_CT_XXXX_AddNewRecs') 
    BEGIN
        DROP PROCEDURE
             proc_CT_XXXX_AddNewRecs;
    END;
GO
CREATE PROCEDURE proc_CT_XXXX_AddNewRecs
AS
BEGIN

WITH CTE (
                 RCDocumentGuid
               , RADocumentGuid
               , RACodeName
               , QuesDocumentGuid
               , AnsDocumentGuid
               , HANodeSiteID) 
                AS ( SELECT
                            RCDocumentGuid
                          , RADocumentGuid
                          , RACodeName
                          , QuesDocumentGuid
                          , AnsDocumentGuid
                          , HANodeSiteID
                            FROM ##TEMP_EDW_HealthDefinition_DATA
                     EXCEPT
                     SELECT
                            RCDocumentGuid
                          , RADocumentGuid
                          , RACodeName
                          , QuesDocumentGuid
                          , AnsDocumentGuid
                          , HANodeSiteID
                     --HANodeID
                     --HADocumentID
                     --RCDocPubVerID
                     --QuesDocPubVerID
                            FROM STAGING_EDW_XXXX
                            WHERE LastModifiedDate IS NULL) 
                INSERT INTO dbo.STAGING_EDW_XXXX (
                       SiteGUID
                     , AccountCD
                     , HANodeID
                     , HANodeName
                     , HADocumentID
                     , HANodeSiteID
                     , HADocPubVerID
                     , ModTitle
                     , IntroText
                     , ModDocGuid
                     , ModWeight
                     , ModIsEnabled
                     , ModCodeName
                     , ModDocPubVerID
                     , RCTitle
                     , RCWeight
                     , RCDocumentGUID
                     , RCIsEnabled
                     , RCCodeName
                     , RCDocPubVerID
                     , RATytle
                     , RAWeight
                     , RADocumentGuid
                     , RAIsEnabled
                     , RACodeName
                     , RAScoringStrategyID
                     , RADocPubVerID
                     , QuestionType
                     , QuesTitle
                     , QuesWeight
                     , QuesIsRequired
                     , QuesDocumentGuid
                     , QuesIsEnabled
                     , QuesIsVisible
                     , QuesIsSTaging
                     , QuestionCodeName
                     , QuesDocPubVerID
                     , AnsValue
                     , AnsPoints
                     , AnsDocumentGuid
                     , AnsIsEnabled
                     , AnsCodeName
                     , AnsUOM
                     , AnsDocPUbVerID
                     , ChangeType
                     , DocumentCreatedWhen
                     , DocumentModifiedWhen
                     , CmsTreeNodeGuid
                     , HANodeGUID
                     , SiteLastModified
                     , Account_ItemModifiedWhen
                     , Campaign_DocumentModifiedWhen
                     , Assessment_DocumentModifiedWhen
                     , Module_DocumentModifiedWhen
                     , RiskCategory_DocumentModifiedWhen
                     , RiskArea_DocumentModifiedWhen
                     , Question_DocumentModifiedWhen
                     , Answer_DocumentModifiedWhen
                     , AllowMultiSelect
                     , LocID
                     , CMS_Class_CtID
                     , CMS_Class_SCV
                     , CMS_Document_CtID
                     , CMS_Document_SCV
                     , CMS_Site_CtID
                     , CMS_Site_SCV
                     , CMS_Tree_CtID
                     , CMS_Tree_SCV
                     , CMS_User_CtID
                     , CMS_User_SCV
                     , COM_SKU_CtID
                     , COM_SKU_SCV
                     , HFit_HealthAssesmentMatrixQuestion_CtID
                     , HFit_HealthAssesmentMatrixQuestion_SCV
                     , HFit_HealthAssesmentModule_CtID
                     , HFit_HealthAssesmentModule_SCV
                     , HFit_HealthAssesmentMultipleChoiceQuestion_CtID
                     , HFit_HealthAssesmentMultipleChoiceQuestion_SCV
                     , HFit_HealthAssesmentRiskArea_CtID
                     , HFit_HealthAssesmentRiskArea_SCV
                     , HFit_HealthAssesmentRiskCategory_CtID
                     , HFit_HealthAssesmentRiskCategory_SCV
                     , HFit_HealthAssessment_CtID
                     , HFit_HealthAssessment_SCV
                     , HFit_HealthAssessmentFreeForm_CtID
                     , HFit_HealthAssessmentFreeForm_SCV
                     , CMS_Class_CHANGE_OPERATION
                     , CMS_Document_CHANGE_OPERATION
                     , CMS_Site_CHANGE_OPERATION
                     , CMS_Tree_CHANGE_OPERATION
                     , CMS_User_CHANGE_OPERATION
                     , COM_SKU_CHANGE_OPERATION
                     , HFit_HealthAssesmentMatrixQuestion_CHANGE_OPERATION
                     , HFit_HealthAssesmentModule_CHANGE_OPERATION
                     , HFit_HealthAssesmentMultipleChoiceQuestion_CHANGE_OPERATION
                     , HFit_HealthAssesmentRiskArea_CHANGE_OPERATION
                     , HFit_HealthAssesmentRiskCategory_CHANGE_OPERATION
                     , HFit_HealthAssessment_CHANGE_OPERATION
                     , HFit_HealthAssessmentFreeForm_CHANGE_OPERATION
                     , CHANGED_FLG
                     , CHANGE_TYPE_CODE
                     , LastModifiedDate
                       --,[RowNbr]
                     ,
                       DeletedFlg) 
                SELECT
                       T.SiteGUID
                     , T.AccountCD
                     , T.HANodeID
                     , T.HANodeName
                     , T.HADocumentID
                     , T.HANodeSiteID
                     , T.HADocPubVerID
                     , T.ModTitle
                     , T.IntroText
                     , T.ModDocGuid
                     , T.ModWeight
                     , T.ModIsEnabled
                     , T.ModCodeName
                     , T.ModDocPubVerID
                     , T.RCTitle
                     , T.RCWeight
                     , T.RCDocumentGUID
                     , T.RCIsEnabled
                     , T.RCCodeName
                     , T.RCDocPubVerID
                     , T.RATytle
                     , T.RAWeight
                     , T.RADocumentGuid
                     , T.RAIsEnabled
                     , T.RACodeName
                     , T.RAScoringStrategyID
                     , T.RADocPubVerID
                     , T.QuestionType
                     , T.QuesTitle
                     , T.QuesWeight
                     , T.QuesIsRequired
                     , T.QuesDocumentGuid
                     , T.QuesIsEnabled
                     , T.QuesIsVisible
                     , T.QuesIsSTaging
                     , T.QuestionCodeName
                     , T.QuesDocPubVerID
                     , T.AnsValue
                     , T.AnsPoints
                     , T.AnsDocumentGuid
                     , T.AnsIsEnabled
                     , T.AnsCodeName
                     , T.AnsUOM
                     , T.AnsDocPUbVerID
                     , T.ChangeType
                     , T.DocumentCreatedWhen
                     , T.DocumentModifiedWhen
                     , T.CmsTreeNodeGuid
                     , T.HANodeGUID
                     , T.SiteLastModified
                     , T.Account_ItemModifiedWhen
                     , T.Campaign_DocumentModifiedWhen
                     , T.Assessment_DocumentModifiedWhen
                     , T.Module_DocumentModifiedWhen
                     , T.RiskCategory_DocumentModifiedWhen
                     , T.RiskArea_DocumentModifiedWhen
                     , T.Question_DocumentModifiedWhen
                     , T.Answer_DocumentModifiedWhen
                     , T.AllowMultiSelect
                     , T.LocID
                     , T.CMS_Class_CtID
                     , T.CMS_Class_SCV
                     , T.CMS_Document_CtID
                     , T.CMS_Document_SCV
                     , T.CMS_Site_CtID
                     , T.CMS_Site_SCV
                     , T.CMS_Tree_CtID
                     , T.CMS_Tree_SCV
                     , T.CMS_User_CtID
                     , T.CMS_User_SCV
                     , T.COM_SKU_CtID
                     , T.COM_SKU_SCV
                     , T.HFit_HealthAssesmentMatrixQuestion_CtID
                     , T.HFit_HealthAssesmentMatrixQuestion_SCV
                     , T.HFit_HealthAssesmentModule_CtID
                     , T.HFit_HealthAssesmentModule_SCV
                     , T.HFit_HealthAssesmentMultipleChoiceQuestion_CtID
                     , T.HFit_HealthAssesmentMultipleChoiceQuestion_SCV
                     , T.HFit_HealthAssesmentRiskArea_CtID
                     , T.HFit_HealthAssesmentRiskArea_SCV
                     , T.HFit_HealthAssesmentRiskCategory_CtID
                     , T.HFit_HealthAssesmentRiskCategory_SCV
                     , T.HFit_HealthAssessment_CtID
                     , T.HFit_HealthAssessment_SCV
                     , T.HFit_HealthAssessmentFreeForm_CtID
                     , T.HFit_HealthAssessmentFreeForm_SCV
                     , T.CMS_Class_CHANGE_OPERATION
                     , T.CMS_Document_CHANGE_OPERATION
                     , T.CMS_Site_CHANGE_OPERATION
                     , T.CMS_Tree_CHANGE_OPERATION
                     , T.CMS_User_CHANGE_OPERATION
                     , T.COM_SKU_CHANGE_OPERATION
                     , T.HFit_HealthAssesmentMatrixQuestion_CHANGE_OPERATION
                     , T.HFit_HealthAssesmentModule_CHANGE_OPERATION
                     , T.HFit_HealthAssesmentMultipleChoiceQuestion_CHANGE_OPERATION
                     , T.HFit_HealthAssesmentRiskArea_CHANGE_OPERATION
                     , T.HFit_HealthAssesmentRiskCategory_CHANGE_OPERATION
                     , T.HFit_HealthAssessment_CHANGE_OPERATION
                     , T.HFit_HealthAssessmentFreeForm_CHANGE_OPERATION
                     , T.CHANGED_FLG
                     , T.CHANGE_TYPE_CODE
                     , NULL AS LastModifiedDate
                       --, T.[RowNbr]
                     ,
                       NULL AS DeletedFlg
                       FROM
                            ##TEMP_EDW_HealthDefinition_DATA AS T --JOIN TEMPXX AS S
                                 JOIN CTE AS S
                                 ON
                                 S.RCDocumentGuid = T.RCDocumentGuid AND
                                 S.RADocumentGuid = T.RADocumentGuid AND
                                 S.RACodeName = T.RACodeName AND
                                 S.QuesDocumentGuid = T.QuesDocumentGuid AND
                                 S.AnsDocumentGuid = T.AnsDocumentGuid AND
                                 S.HANodeSiteID = T.HANodeSiteID;

    DECLARE
    @iInserts AS int = @@ROWCOUNT;
    PRINT 'NEW Insert Count: ' + CAST ( @iInserts AS nvarchar (50)) ;
    RETURN @iInserts;
END;

GO
PRINT 'Executed proc_CT_XXXX_AddNewRecs.sql';
GO
