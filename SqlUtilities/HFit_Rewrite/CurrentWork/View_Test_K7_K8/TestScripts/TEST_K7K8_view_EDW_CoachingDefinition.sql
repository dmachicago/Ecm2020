use KenticoCMS_PRD_prod3K7
GO 
if exists (select name from sys.tables where name = 'TEST_K7K8_view_EDW_CoachingDefinition' )
BEGIN
    DROP Table TEST_K7K8_view_EDW_CoachingDefinition
END
GO


--****************************************************
Select distinct top 100 
     GoalID
    ,DocumentGuid
    ,NodeSiteID
    ,SiteGUID
    ,GoalImage
    ,Goal
    ,GoalText
    ,GoalSummary
    ,TrackerAssociation
    ,GoalFrequency
    ,FrequencySingular
    ,FrequencyPlural
    ,GoalUnitOfMeasure
    ,UnitOfMeasure
    ,GoalDirection
    ,GoalPrecision
    ,GoalAbsoluteMin
    ,GoalAbsoluteMax
    ,SetGoalText
    ,HelpText
    ,EvaluationType
    ,CatalogDisplay
    ,AllowModification
    ,ActivityText
    ,SetgoalModifyText
    ,IsLifestyleGoal
    ,CodeName
    ,ChangeType
    ,DocumentCreatedWhen
    ,DocumentModifiedWhen
    ,DocumentCulture
INTO KenticoCMS_PRD_prod3K7.dbo.TEST_K7K8_view_EDW_CoachingDefinition
FROM
view_EDW_CoachingDefinition;
--****************************************************
use KenticoCMS_PRD_prod3K8
GO 
if exists (select name from sys.tables where name = 'TEST_K7K8_view_EDW_CoachingDefinition' )
BEGIN
    DROP Table TEST_K7K8_view_EDW_CoachingDefinition
END
GO


--****************************************************
Select distinct top 100 
     GoalID
    ,DocumentGuid
    ,NodeSiteID
    ,SiteGUID
    ,GoalImage
    ,Goal
    ,GoalText
    ,GoalSummary
    ,TrackerAssociation
    ,GoalFrequency
    ,FrequencySingular
    ,FrequencyPlural
    ,GoalUnitOfMeasure
    ,UnitOfMeasure
    ,GoalDirection
    ,GoalPrecision
    ,GoalAbsoluteMin
    ,GoalAbsoluteMax
    ,SetGoalText
    ,HelpText
    ,EvaluationType
    ,CatalogDisplay
    ,AllowModification
    ,ActivityText
    ,SetgoalModifyText
    ,IsLifestyleGoal
    ,CodeName
    ,ChangeType
    ,DocumentCreatedWhen
    ,DocumentModifiedWhen
    ,DocumentCulture
INTO KenticoCMS_PRD_prod3K8.dbo.TEST_K7K8_view_EDW_CoachingDefinition
FROM
view_EDW_CoachingDefinition;
--****************************************************
GO

select top 100 * from KenticoCMS_PRD_prod3K7.dbo.TEST_K7K8_view_EDW_CoachingDefinition order by DocumentGuid;

select top 100 * from KenticoCMS_PRD_prod3K8.dbo.TEST_K7K8_view_EDW_CoachingDefinition order by DocumentGuid;

--update HFit_EDW_K7K8_TestDDL set Passed = 1 where VIEW_NAME = 'view_EDW_CoachingDefinition'; 