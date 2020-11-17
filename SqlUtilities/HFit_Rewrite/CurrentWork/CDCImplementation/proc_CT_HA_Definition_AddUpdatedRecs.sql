

go
-- use KenticoCMS_Prod1
GO
PRINT 'Executing proc_CT_HA_Definition_AddUpdatedRecs.sql';
GO
IF EXISTS ( SELECT
                   name
                   FROM sys.procedures
                   WHERE name = 'proc_CT_HA_Definition_AddUpdatedRecs') 
    BEGIN
        DROP PROCEDURE
             proc_CT_HA_Definition_AddUpdatedRecs;
    END;
GO
CREATE PROCEDURE proc_CT_HA_Definition_AddUpdatedRecs
AS
BEGIN

    DECLARE
       @RUNDATE AS  datetime2 ( 7 ) = GETDATE ( );

            UPDATE S
              SET
                  S.SiteGUID = T.SiteGUID
                ,S.AccountCD = T.AccountCD
                ,S.HANodeID = T.HANodeID
                ,S.HANodeName = T.HANodeName
                ,S.HADocumentID = T.HADocumentID
                ,S.HANodeSiteID = T.HANodeSiteID
                ,S.HADocPubVerID = T.HADocPubVerID
                ,S.ModTitle = T.ModTitle
                ,S.IntroText = T.IntroText
                ,S.ModDocGuid = T.ModDocGuid
                ,S.ModWeight = T.ModWeight
                ,S.ModIsEnabled = T.ModIsEnabled
                ,S.ModCodeName = T.ModCodeName
                ,S.ModDocPubVerID = T.ModDocPubVerID
                ,S.RCTitle = T.RCTitle
                ,S.RCWeight = T.RCWeight
                ,S.RCDocumentGUID = T.RCDocumentGUID
                ,S.RCIsEnabled = T.RCIsEnabled
                ,S.RCCodeName = T.RCCodeName
                ,S.RCDocPubVerID = T.RCDocPubVerID
                ,S.RATytle = T.RATytle
                ,S.RAWeight = T.RAWeight
                ,S.RADocumentGuid = T.RADocumentGuid
                ,S.RAIsEnabled = T.RAIsEnabled
                ,S.RACodeName = T.RACodeName
                ,S.RAScoringStrategyID = T.RAScoringStrategyID
                ,S.RADocPubVerID = T.RADocPubVerID
                ,S.QuestionType = T.QuestionType
                ,S.QuesTitle = T.QuesTitle
                ,S.QuesWeight = T.QuesWeight
                ,S.QuesIsRequired = T.QuesIsRequired
                ,S.QuesDocumentGuid = T.QuesDocumentGuid
                ,S.QuesIsEnabled = T.QuesIsEnabled
                ,S.QuesIsVisible = T.QuesIsVisible
                ,S.QuesIsSTaging = T.QuesIsSTaging
                ,S.QuestionCodeName = T.QuestionCodeName
                ,S.QuesDocPubVerID = T.QuesDocPubVerID
                ,S.AnsValue = T.AnsValue
                ,S.AnsPoints = T.AnsPoints
                ,S.AnsDocumentGuid = T.AnsDocumentGuid
                ,S.AnsIsEnabled = T.AnsIsEnabled
                ,S.AnsCodeName = T.AnsCodeName
                ,S.AnsUOM = T.AnsUOM
                ,S.AnsDocPUbVerID = T.AnsDocPUbVerID
                ,S.ChangeType = T.ChangeType
                ,S.DocumentCreatedWhen = T.DocumentCreatedWhen
                ,S.DocumentModifiedWhen = T.DocumentModifiedWhen
                ,S.CmsTreeNodeGuid = T.CmsTreeNodeGuid
                ,S.HANodeGUID = T.HANodeGUID
                ,S.SiteLastModified = T.SiteLastModified
                ,S.Account_ItemModifiedWhen = T.Account_ItemModifiedWhen
                ,S.Campaign_DocumentModifiedWhen = T.Campaign_DocumentModifiedWhen
                ,S.Assessment_DocumentModifiedWhen = T.Assessment_DocumentModifiedWhen
                ,S.Module_DocumentModifiedWhen = T.Module_DocumentModifiedWhen
                ,S.RiskCategory_DocumentModifiedWhen = T.RiskCategory_DocumentModifiedWhen
                ,S.RiskArea_DocumentModifiedWhen = T.RiskArea_DocumentModifiedWhen
                ,S.Question_DocumentModifiedWhen = T.Question_DocumentModifiedWhen
                ,S.Answer_DocumentModifiedWhen = T.Answer_DocumentModifiedWhen
                ,S.AllowMultiSelect = T.AllowMultiSelect
                ,S.LocID = T.LocID
                ,S.CMS_Class_CtID = T.CMS_Class_CtID
                ,S.CMS_Class_SCV = T.CMS_Class_SCV
                ,S.CMS_Document_CtID = T.CMS_Document_CtID
                ,S.CMS_Document_SCV = T.CMS_Document_SCV
                ,S.CMS_Site_CtID = T.CMS_Site_CtID
                ,S.CMS_Site_SCV = T.CMS_Site_SCV
                ,S.CMS_Tree_CtID = T.CMS_Tree_CtID
                ,S.CMS_Tree_SCV = T.CMS_Tree_SCV
                ,S.CMS_User_CtID = T.CMS_User_CtID
                ,S.CMS_User_SCV = T.CMS_User_SCV
                ,S.COM_SKU_CtID = T.COM_SKU_CtID
                ,S.COM_SKU_SCV = T.COM_SKU_SCV
                ,S.HFit_HealthAssesmentMatrixQuestion_CtID = T.HFit_HealthAssesmentMatrixQuestion_CtID
                ,S.HFit_HealthAssesmentMatrixQuestion_SCV = T.HFit_HealthAssesmentMatrixQuestion_SCV
                ,S.HFit_HealthAssesmentModule_CtID = T.HFit_HealthAssesmentModule_CtID
                ,S.HFit_HealthAssesmentModule_SCV = T.HFit_HealthAssesmentModule_SCV
                ,S.HFit_HealthAssesmentMultipleChoiceQuestion_CtID = T.HFit_HealthAssesmentMultipleChoiceQuestion_CtID
                ,S.HFit_HealthAssesmentMultipleChoiceQuestion_SCV = T.HFit_HealthAssesmentMultipleChoiceQuestion_SCV
                ,S.HFit_HealthAssesmentRiskArea_CtID = T.HFit_HealthAssesmentRiskArea_CtID
                ,S.HFit_HealthAssesmentRiskArea_SCV = T.HFit_HealthAssesmentRiskArea_SCV
                ,S.HFit_HealthAssesmentRiskCategory_CtID = T.HFit_HealthAssesmentRiskCategory_CtID
                ,S.HFit_HealthAssesmentRiskCategory_SCV = T.HFit_HealthAssesmentRiskCategory_SCV
                ,S.HFit_HealthAssessment_CtID = T.HFit_HealthAssessment_CtID
                ,S.HFit_HealthAssessment_SCV = T.HFit_HealthAssessment_SCV
                ,S.HFit_HealthAssessmentFreeForm_CtID = T.HFit_HealthAssessmentFreeForm_CtID
                ,S.HFit_HealthAssessmentFreeForm_SCV = T.HFit_HealthAssessmentFreeForm_SCV
                ,S.CMS_Class_CHANGE_OPERATION = T.CMS_Class_CHANGE_OPERATION
                ,S.CMS_Document_CHANGE_OPERATION = T.CMS_Document_CHANGE_OPERATION
                ,S.CMS_Site_CHANGE_OPERATION = T.CMS_Site_CHANGE_OPERATION
                ,S.CMS_Tree_CHANGE_OPERATION = T.CMS_Tree_CHANGE_OPERATION
                ,S.CMS_User_CHANGE_OPERATION = T.CMS_User_CHANGE_OPERATION
                ,S.COM_SKU_CHANGE_OPERATION = T.COM_SKU_CHANGE_OPERATION
                ,S.HFit_HealthAssesmentMatrixQuestion_CHANGE_OPERATION = T.HFit_HealthAssesmentMatrixQuestion_CHANGE_OPERATION
                ,S.HFit_HealthAssesmentModule_CHANGE_OPERATION = T.HFit_HealthAssesmentModule_CHANGE_OPERATION
                ,S.HFit_HealthAssesmentMultipleChoiceQuestion_CHANGE_OPERATION = T.HFit_HealthAssesmentMultipleChoiceQuestion_CHANGE_OPERATION
                ,S.HFit_HealthAssesmentRiskArea_CHANGE_OPERATION = T.HFit_HealthAssesmentRiskArea_CHANGE_OPERATION
                ,S.HFit_HealthAssesmentRiskCategory_CHANGE_OPERATION = T.HFit_HealthAssesmentRiskCategory_CHANGE_OPERATION
                ,S.HFit_HealthAssessment_CHANGE_OPERATION = T.HFit_HealthAssessment_CHANGE_OPERATION
                ,S.HFit_HealthAssessmentFreeForm_CHANGE_OPERATION = T.HFit_HealthAssessmentFreeForm_CHANGE_OPERATION
                ,S.CHANGED_FLG = T.CHANGED_FLG
                ,S.CHANGE_TYPE_CODE = T.CHANGE_TYPE_CODE
                ,S.HashCode = T.HashCode
                ,S.LastModifiedDate = GETDATE () 
                ,S.DeletedFlg = NULL
                ,S.ConvertedToCentralTime = NULL
                  FROM STAGING_EDW_HA_Definition AS S
                            JOIN ##TEMP_EDW_HealthDefinition_DATA AS T
                            ON
                            S.RCDocumentGuid = T.RCDocumentGuid AND
                            S.RADocumentGuid = T.RADocumentGuid AND
                            S.RACodeName = T.RACodeName AND
                            S.QuesDocumentGuid = T.QuesDocumentGuid AND
                            S.AnsDocumentGuid = T.AnsDocumentGuid AND
                            S.HANodeSiteID = T.HANodeSiteID
              WHERE
                            S.HashCode != T.HashCode and S.DeletedFlg is null;

    DECLARE
    @iInserts AS int = @@ROWCOUNT;
    PRINT 'Updated Record Count: ' + CAST ( @iInserts AS nvarchar (50)) ;
    RETURN @iInserts;
END;

GO
PRINT 'Executed proc_CT_HA_Definition_AddUpdatedRecs.sql';
GO
