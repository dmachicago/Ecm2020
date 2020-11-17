

GO
PRINT 'Creating view_EDW_CoachingDefinition_STAGE';
GO
IF EXISTS( SELECT
                  name
             FROM sys.views
             WHERE name = 'view_EDW_CoachingDefinition_STAGE' )
    BEGIN
        DROP VIEW
             view_EDW_CoachingDefinition_STAGE;
    END; 
GO
CREATE VIEW view_EDW_CoachingDefinition_STAGE
AS SELECT
          GoalID , 
          DocumentGuid , 
          NodeSiteID , 
          SiteGUID , 
          GoalImage , 
          Goal , 
          GoalText , 
          GoalSummary , 
          TrackerAssociation , 
          GoalFrequency , 
          FrequencySingular , 
          FrequencyPlural , 
          GoalUnitOfMeasure , 
          UnitOfMeasure , 
          GoalDirection , 
          GoalPrecision , 
          GoalAbsoluteMin , 
          GoalAbsoluteMax , 
          SetGoalText , 
          HelpText , 
          EvaluationType , 
          CatalogDisplay , 
          AllowModification , 
          ActivityText , 
          SetgoalModifyText , 
          IsLifestyleGoal , 
          CodeName , 
          ChangeType , 
          DocumentCreatedWhen , 
          DocumentModifiedWhen , 
          DocumentCulture , 
          HashCode , 
          LastModifiedDate , 
          RowNbr , 
          DeletedFlg
     FROM dbo.STAGING_EDW_CoachingDefinition;
GO
PRINT 'CREATED view_EDW_CoachingDefinition_STAGE';
GO
