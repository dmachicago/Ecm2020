use KenticoCMS_PRD_prod3K7
GO 
if exists (select name from sys.tables where name = 'TEST_K7K8_View_EDW_HealthAssesmentQuestions' )
BEGIN
    DROP Table TEST_K7K8_View_EDW_HealthAssesmentQuestions
END
GO


--****************************************************
Select DISTINCT top 100 
     QuestionType
    ,Title
    ,Weight
    ,IsRequired
    ,QuestionImageLeft
    ,QuestionImageRight
    ,NodeGUID
    ,DocumentCulture
    ,IsEnabled
    ,IsVisible
    ,IsStaging
    ,CodeName
    ,QuestionGroupCodeName
    ,NodeAliasPath
    ,DocumentPublishedVersionHistoryID
    ,NodeLevel
    ,NodeOrder
    ,NodeID
    ,NodeParentID
    ,NodeLinkedNodeID
    ,DontKnowEnabled
    ,DontKnowLabel
    ,ParentNodeOrder
    ,DocumentGuid
    ,DocumentModifiedWhen
INTO KenticoCMS_PRD_prod3K7.dbo.TEST_K7K8_View_EDW_HealthAssesmentQuestions
FROM
View_EDW_HealthAssesmentQuestions;
--****************************************************
use KenticoCMS_PRD_prod3K8
GO 
if exists (select name from sys.tables where name = 'TEST_K7K8_View_EDW_HealthAssesmentQuestions' )
BEGIN
    DROP Table TEST_K7K8_View_EDW_HealthAssesmentQuestions
END
GO


--****************************************************
Select DISTINCT top 100 
     QuestionType
    ,Title
    ,Weight
    ,IsRequired
    ,QuestionImageLeft
    ,QuestionImageRight
    ,NodeGUID
    ,DocumentCulture
    ,IsEnabled
    ,IsVisible
    ,IsStaging
    ,CodeName
    ,QuestionGroupCodeName
    ,NodeAliasPath
    ,DocumentPublishedVersionHistoryID
    ,NodeLevel
    ,NodeOrder
    ,NodeID
    ,NodeParentID
    ,NodeLinkedNodeID
    ,DontKnowEnabled
    ,DontKnowLabel
    ,ParentNodeOrder
    ,DocumentGuid
    ,DocumentModifiedWhen
INTO KenticoCMS_PRD_prod3K8.dbo.TEST_K7K8_View_EDW_HealthAssesmentQuestions
FROM
View_EDW_HealthAssesmentQuestions;
--****************************************************
GO

select top 100 * from KenticoCMS_PRD_prod3K7.dbo.TEST_K7K8_View_EDW_HealthAssesmentQuestions order by DocumentGuid;

select top 100 * from KenticoCMS_PRD_prod3K8.dbo.TEST_K7K8_View_EDW_HealthAssesmentQuestions order by DocumentGuid;

--update HFit_EDW_K7K8_TestDDL set Passed = 1 where VIEW_NAME = 'View_EDW_HealthAssesmentQuestions'; 