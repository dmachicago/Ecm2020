

GO
PRINT 'Executing proc_CT_CoachingDefinition_AddDeletedRecs.sql';
GO
IF EXISTS ( SELECT
                   name
              FROM sys.procedures
              WHERE name = 'proc_CT_CoachingDefinition_AddDeletedRecs' )
    BEGIN
        DROP PROCEDURE
             proc_CT_CoachingDefinition_AddDeletedRecs;
    END;
GO
CREATE PROCEDURE proc_CT_CoachingDefinition_AddDeletedRecs
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
               FROM STAGING_EDW_CoachingDefinition
             EXCEPT
             SELECT
                    GoalID
                    ,DocumentGuid
                    ,NodeSiteID
                    ,SiteGUID
               FROM ##TEMP_STAGING_EDW_CoachingDefinition_DATA )
        UPDATE S
          SET
              S.DeletedFlg = 1
          FROM CTE AS T JOIN
                    STAGING_EDW_CoachingDefinition AS S
                        ON
               S.GoalID = T.GoalID
           AND S.DocumentGuid = T.DocumentGuid
           AND S.NodeSiteID = T.NodeSiteID
           AND S.SiteGUID = T.SiteGUID;

    DECLARE
       @iCnt AS int = @@ROWCOUNT;
    PRINT 'Updated Count: ' + CAST ( @iCnt AS nvarchar( 50 ));
    RETURN @iCnt;
END;

GO
PRINT 'Executed proc_CT_CoachingDefinition_AddDeletedRecs.sql';
GO
