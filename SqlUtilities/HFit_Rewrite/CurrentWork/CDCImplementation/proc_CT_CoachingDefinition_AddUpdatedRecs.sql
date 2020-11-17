
GO
PRINT 'Executing proc_CT_CoachingDefinition_AddUpdatedRecs.sql';
GO
IF EXISTS ( SELECT
                   name
              FROM sys.procedures
              WHERE name = 'proc_CT_CoachingDefinition_AddUpdatedRecs' )
    BEGIN
        DROP PROCEDURE
             proc_CT_CoachingDefinition_AddUpdatedRecs;
    END;
GO
CREATE PROCEDURE proc_CT_CoachingDefinition_AddUpdatedRecs
AS
BEGIN
    UPDATE S
      SET
          S.GoalID = T.GoalID
          ,S.DocumentGuid = T.DocumentGuid
          ,S.NodeSiteID = T.NodeSiteID
          ,S.SiteGUID = T.SiteGUID
          ,S.GoalImage = T.GoalImage
          ,S.Goal = T.Goal
          ,S.GoalText = T.GoalText
          ,S.GoalSummary = T.GoalSummary
          ,S.TrackerAssociation = T.TrackerAssociation
          ,S.GoalFrequency = T.GoalFrequency
          ,S.FrequencySingular = T.FrequencySingular
          ,S.FrequencyPlural = T.FrequencyPlural
          ,S.GoalUnitOfMeasure = T.GoalUnitOfMeasure
          ,S.UnitOfMeasure = T.UnitOfMeasure
          ,S.GoalDirection = T.GoalDirection
          ,S.GoalPrecision = T.GoalPrecision
          ,S.GoalAbsoluteMin = T.GoalAbsoluteMin
          ,S.GoalAbsoluteMax = T.GoalAbsoluteMax
          ,S.SetGoalText = T.SetGoalText
          ,S.HelpText = T.HelpText
          ,S.EvaluationType = T.EvaluationType
          ,S.CatalogDisplay = T.CatalogDisplay
          ,S.AllowModification = T.AllowModification
          ,S.ActivityText = T.ActivityText
          ,S.SetgoalModifyText = T.SetgoalModifyText
          ,S.IsLifestyleGoal = T.IsLifestyleGoal
          ,S.CodeName = T.CodeName
          ,S.ChangeType = 'U'
          ,S.DocumentCreatedWhen = T.DocumentCreatedWhen
          ,S.DocumentModifiedWhen = T.DocumentModifiedWhen
          ,S.DocumentCulture = T.DocumentCulture
          ,S.HashCode = T.HashCode
          ,S.LastModifiedDate = GETDATE( )
          ,S.DeletedFlg = NULL
      FROM
      STAGING_EDW_CoachingDefinition AS S JOIN
           ##TEMP_STAGING_EDW_CoachingDefinition_DATA AS T
                                          ON
           S.GoalID = T.GoalID
       AND S.DocumentGuid = T.DocumentGuid
       AND S.NodeSiteID = T.NodeSiteID
       AND S.SiteGUID = T.SiteGUID
       AND S.HashCode != T.HashCode
       AND S.DeletedFlg IS NULL;

    DECLARE
       @iCnt AS int = @@ROWCOUNT;
    PRINT 'Updated Count: ' + CAST ( @iCnt AS nvarchar( 50 ));
    RETURN @iCnt;
END;

GO
PRINT 'Executed proc_CT_CoachingDefinition_AddUpdatedRecs.sql';
GO
