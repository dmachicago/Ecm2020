use KenticoCMS_PRD_prod3K7
GO 
if exists (select name from sys.tables where name = 'TEST_K7K8_view_EDW_HealthAssesmentDeffinitionCustom' )
BEGIN
    DROP Table TEST_K7K8_view_EDW_HealthAssesmentDeffinitionCustom
END
GO


--****************************************************
Select DISTINCT top 150 
     SiteGUID
    ,AccountCD
    ,HANodeID
    ,HANodeName
    ,HADocumentID
    ,HANodeSiteID
    ,HADocPubVerID
    ,ModTitle
    ,IntroText
    ,ModDocGuid
    ,ModWeight
    ,ModIsEnabled
    ,ModCodeName
    ,ModDocPubVerID
    ,RCTitle
    ,RCWeight
    ,RCDocumentGUID
    ,RCIsEnabled
    ,RCCodeName
    ,RCDocPubVerID
    ,RATytle
    ,RAWeight
    ,RADocumentGuid
    ,RAIsEnabled
    ,RACodeName
    ,RAScoringStrategyID
    ,RADocPubVerID
    ,QuestionType
    ,QuesTitle
    ,QuesWeight
    ,QuesIsRequired
    ,QuesDocumentGuid
    ,QuesIsEnabled
    ,QuesIsVisible
    ,QuesIsSTaging
    ,QuestionCodeName
    ,QuesDocPubVerID
    ,AnsValue
    ,AnsPoints
    ,AnsDocumentGuid
    ,AnsIsEnabled
    ,AnsCodeName
    ,AnsUOM
    ,AnsDocPUbVerID
    ,ChangeType
    ,DocumentCreatedWhen
    ,DocumentModifiedWhen
    ,CmsTreeNodeGuid
    ,SiteLastModified
    ,Account_ItemModifiedWhen
    ,Campaign_DocumentModifiedWhen
    ,Assessment_DocumentModifiedWhen
    ,Module_DocumentModifiedWhen
    ,RiskCategory_DocumentModifiedWhen
    ,RiskArea_DocumentModifiedWhen
    ,Question_DocumentModifiedWhen
    ,Answer_DocumentModifiedWhen
INTO KenticoCMS_PRD_prod3K7.dbo.TEST_K7K8_view_EDW_HealthAssesmentDeffinitionCustom
FROM
KenticoCMS_PRD_prod3K7.dbo.view_EDW_HealthAssesmentDeffinitionCustom;
--****************************************************
use KenticoCMS_PRD_prod3K8
GO 
if exists (select name from sys.tables where name = 'TEST_K7K8_view_EDW_HealthAssesmentDeffinitionCustom' )
BEGIN
    DROP Table TEST_K7K8_view_EDW_HealthAssesmentDeffinitionCustom
END
GO


--****************************************************
Select DISTINCT top 150 
     SiteGUID
    ,AccountCD
    ,HANodeID
    ,HANodeName
    ,HADocumentID
    ,HANodeSiteID
    ,HADocPubVerID
    ,ModTitle
    ,IntroText
    ,ModDocGuid
    ,ModWeight
    ,ModIsEnabled
    ,ModCodeName
    ,ModDocPubVerID
    ,RCTitle
    ,RCWeight
    ,RCDocumentGUID
    ,RCIsEnabled
    ,RCCodeName
    ,RCDocPubVerID
    ,RATytle
    ,RAWeight
    ,RADocumentGuid
    ,RAIsEnabled
    ,RACodeName
    ,RAScoringStrategyID
    ,RADocPubVerID
    ,QuestionType
    ,QuesTitle
    ,QuesWeight
    ,QuesIsRequired
    ,QuesDocumentGuid
    ,QuesIsEnabled
    ,QuesIsVisible
    ,QuesIsSTaging
    ,QuestionCodeName
    ,QuesDocPubVerID
    ,AnsValue
    ,AnsPoints
    ,AnsDocumentGuid
    ,AnsIsEnabled
    ,AnsCodeName
    ,AnsUOM
    ,AnsDocPUbVerID
    ,ChangeType
    ,DocumentCreatedWhen
    ,DocumentModifiedWhen
    ,CmsTreeNodeGuid
    ,SiteLastModified
    ,Account_ItemModifiedWhen
    ,Campaign_DocumentModifiedWhen
    ,Assessment_DocumentModifiedWhen
    ,Module_DocumentModifiedWhen
    ,RiskCategory_DocumentModifiedWhen
    ,RiskArea_DocumentModifiedWhen
    ,Question_DocumentModifiedWhen
    ,Answer_DocumentModifiedWhen
INTO KenticoCMS_PRD_prod3K8.dbo.TEST_K7K8_view_EDW_HealthAssesmentDeffinitionCustom
FROM
KenticoCMS_PRD_prod3K8.dbo.view_EDW_HealthAssesmentDeffinitionCustom;
--****************************************************
GO

select top 100 * from KenticoCMS_PRD_prod3K7.dbo.TEST_K7K8_view_EDW_HealthAssesmentDeffinitionCustom;

select top 100 * from KenticoCMS_PRD_prod3K8.dbo.TEST_K7K8_view_EDW_HealthAssesmentDeffinitionCustom;

--update HFit_EDW_K7K8_TestDDL set Passed = 1 where VIEW_NAME = 'view_EDW_HealthAssesmentDeffinitionCustom'; 