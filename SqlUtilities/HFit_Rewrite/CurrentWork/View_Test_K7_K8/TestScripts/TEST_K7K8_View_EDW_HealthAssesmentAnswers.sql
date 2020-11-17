use KenticoCMS_PRD_prod3K7
GO 
if exists (select name from sys.tables where name = 'TEST_K7K8_View_EDW_HealthAssesmentAnswers' )
BEGIN
    DROP Table TEST_K7K8_View_EDW_HealthAssesmentAnswers
END
GO


--****************************************************
Select DISTINCT top 150 
     AnswerType
    ,Value
    ,Points
    ,NodeGUID
    ,IsEnabled
    ,CodeName
    ,InputType
    ,UOM
    ,NodeAliasPath
    ,DocumentPublishedVersionHistoryID
    ,NodeID
    ,NodeOrder
    ,NodeLevel
    ,NodeParentID
    ,NodeLinkedNodeID
    ,DocumentCulture
    ,DocumentGuid
    ,DocumentModifiedWhen
INTO KenticoCMS_PRD_prod3K7.dbo.TEST_K7K8_View_EDW_HealthAssesmentAnswers
FROM
KenticoCMS_PRD_prod3K7.dbo.View_EDW_HealthAssesmentAnswers;
--****************************************************
use KenticoCMS_PRD_prod3K8
GO 
if exists (select name from sys.tables where name = 'TEST_K7K8_View_EDW_HealthAssesmentAnswers' )
BEGIN
    DROP Table TEST_K7K8_View_EDW_HealthAssesmentAnswers
END
GO


--****************************************************
Select DISTINCT top 150 
     AnswerType
    ,Value
    ,Points
    ,NodeGUID
    ,IsEnabled
    ,CodeName
    ,InputType
    ,UOM
    ,NodeAliasPath
    ,DocumentPublishedVersionHistoryID
    ,NodeID
    ,NodeOrder
    ,NodeLevel
    ,NodeParentID
    ,NodeLinkedNodeID
    ,DocumentCulture
    ,DocumentGuid
    ,DocumentModifiedWhen
INTO KenticoCMS_PRD_prod3K8.dbo.TEST_K7K8_View_EDW_HealthAssesmentAnswers
FROM
KenticoCMS_PRD_prod3K8.dbo.View_EDW_HealthAssesmentAnswers;
--****************************************************
GO

select top 100 * from KenticoCMS_PRD_prod3K7.dbo.TEST_K7K8_View_EDW_HealthAssesmentAnswers order by DocumentGuid;

select top 100 * from KenticoCMS_PRD_prod3K8.dbo.TEST_K7K8_View_EDW_HealthAssesmentAnswers order by DocumentGuid;

--update HFit_EDW_K7K8_TestDDL set Passed = 1 where VIEW_NAME = 'View_EDW_HealthAssesmentAnswers'; 