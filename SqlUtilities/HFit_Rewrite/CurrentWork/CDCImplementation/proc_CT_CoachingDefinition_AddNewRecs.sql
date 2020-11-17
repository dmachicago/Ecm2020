

GO
PRINT 'Executing proc_CT_CoachingDefinition_AddNewRecs.sql';
GO
IF EXISTS ( SELECT
                   name
              FROM sys.procedures
              WHERE name = 'proc_CT_CoachingDefinition_AddNewRecs' )
    BEGIN
        DROP PROCEDURE
             proc_CT_CoachingDefinition_AddNewRecs;
    END;
GO
CREATE PROCEDURE proc_CT_CoachingDefinition_AddNewRecs
AS
BEGIN

    WITH CTE (
         GoalID
         ,DocumentGuid
         ,NodeSiteID
         ,SiteGUID )
        AS ( SELECT
                    GoalID
                    ,DocumentGuid
                    ,NodeSiteID
                    ,SiteGUID
               FROM ##TEMP_STAGING_EDW_CoachingDefinition_DATA
             EXCEPT
             SELECT
                    GoalID
                    ,DocumentGuid
                    ,NodeSiteID
                    ,SiteGUID
               FROM STAGING_EDW_CoachingDefinition )
        INSERT INTO STAGING_EDW_CoachingDefinition
        (
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
               ,HashCode
               ,LastModifiedDate
               ,RowNbr
               ,DeletedFlg
               ,TimeZone
               ,ConvertedToCentralTime
        )
        SELECT
               T.GoalID
               ,T.DocumentGuid
               ,T.NodeSiteID
               ,T.SiteGUID
               ,T.GoalImage
               ,T.Goal
               ,T.GoalText
               ,T.GoalSummary
               ,T.TrackerAssociation
               ,T.GoalFrequency
               ,T.FrequencySingular
               ,T.FrequencyPlural
               ,T.GoalUnitOfMeasure
               ,T.UnitOfMeasure
               ,T.GoalDirection
               ,T.GoalPrecision
               ,T.GoalAbsoluteMin
               ,T.GoalAbsoluteMax
               ,T.SetGoalText
               ,T.HelpText
               ,T.EvaluationType
               ,T.CatalogDisplay
               ,T.AllowModification
               ,T.ActivityText
               ,T.SetgoalModifyText
               ,T.IsLifestyleGoal
               ,T.CodeName
               ,T.ChangeType
               ,T.DocumentCreatedWhen
               ,T.DocumentModifiedWhen
               ,T.DocumentCulture
               ,T.HashCode
               ,NULL as LastModifiedDate
               ,NULL as RowNbr
               ,NULL as DeletedFlg
               ,NULL as TimeZone
               ,NULL as ConvertedToCentralTime
          FROM
               ##TEMP_STAGING_EDW_CoachingDefinition_DATA AS T JOIN
                    CTE AS S
                                                               ON
               S.GoalID = T.GoalID
           AND S.DocumentGuid = T.DocumentGuid
           AND S.NodeSiteID = T.NodeSiteID
           AND S.SiteGUID = T.SiteGUID;

    DECLARE
       @iCnt AS int = @@ROWCOUNT;
    PRINT 'Inserted Count: ' + CAST ( @iCnt AS nvarchar( 50 ));
    RETURN @iCnt;
END;

GO
PRINT 'Executed proc_CT_CoachingDefinition_AddNewRecs.sql';
GO
