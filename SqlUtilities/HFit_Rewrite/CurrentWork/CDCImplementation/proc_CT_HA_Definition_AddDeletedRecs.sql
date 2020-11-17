
GO
-- use KenticoCMS_Prod1

GO
PRINT 'Executing proc_CT_HA_Definition_AddDeletedRecs.sql';
GO
IF EXISTS ( SELECT
                   name
                   FROM sys.procedures
                   WHERE name = 'proc_CT_HA_Definition_AddDeletedRecs') 
    BEGIN
        DROP PROCEDURE
             proc_CT_HA_Definition_AddDeletedRecs;
    END;
GO
-- exec proc_CT_HA_Definition_AddDeletedRecs
CREATE PROCEDURE proc_CT_HA_Definition_AddDeletedRecs
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
                            FROM STAGING_EDW_HA_Definition
                            WHERE DeletedFlg IS NULL
                     EXCEPT
                     SELECT
                            RCDocumentGuid
                          , RADocumentGuid
                          , RACodeName
                          , QuesDocumentGuid
                          , AnsDocumentGuid
                          , HANodeSiteID
                            FROM ##TEMP_EDW_HealthDefinition_DATA) 
                UPDATE S
                  SET
                      S.DeletedFlg = 1
                      FROM CTE AS T
                                JOIN STAGING_EDW_HA_Definition AS S
                                ON
                                S.RCDocumentGuid = T.RCDocumentGuid AND
                                S.RADocumentGuid = T.RADocumentGuid AND
                                S.RACodeName = T.RACodeName AND
                                S.QuesDocumentGuid = T.QuesDocumentGuid AND
                                S.AnsDocumentGuid = T.AnsDocumentGuid AND
                                S.HANodeSiteID = T.HANodeSiteID and S.DeletedFlg is null;

    DECLARE
    @iInserts AS int = @@ROWCOUNT;

    UPDATE STAGING_EDW_HA_Definition
      SET
          LastModifiedDate = GETDATE () 
           WHERE
                 LastModifiedDate IS NULL AND
                 DeletedFlg IS NOT NULL;

    PRINT 'Deleted Record Count: ' + CAST ( @iInserts AS nvarchar (50)) ;
    RETURN @iInserts;
END;

GO
PRINT 'Executed proc_CT_HA_Definition_AddDeletedRecs.sql';
GO
