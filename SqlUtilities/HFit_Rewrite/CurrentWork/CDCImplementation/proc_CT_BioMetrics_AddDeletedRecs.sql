
GO
-- Use KenticoCMS_Datamart_2
-- select * from information_schema.columns where table_name like '%BioMetrics%'

PRINT 'Executing proc_CT_BioMetrics_AddDeletedRecs.sql';
GO
IF EXISTS ( SELECT
                   name
                   FROM sys.procedures
                   WHERE name = 'proc_CT_BioMetrics_AddDeletedRecs') 
    BEGIN
        DROP PROCEDURE
             proc_CT_BioMetrics_AddDeletedRecs;
    END;
GO
CREATE PROCEDURE proc_CT_BioMetrics_AddDeletedRecs
AS
BEGIN
/*
select 
*/
    --FIND AND MARK DELETED ROWS
    WITH CTE (
         UserID
       , UserGUID
       , SiteID
       , SiteGUID
       , itemid
       , TBL) 
        AS ( SELECT
                    UserID
                  , UserGUID
                  , SiteID
                  , SiteGUID
                  , itemid
                  , TBL
                    FROM DIM_EDW_BioMetrics
             EXCEPT
             SELECT
                    UserID
                  , UserGUID
                  , SiteID
                  , SiteGUID
                  , itemid
                  , TBL
                    FROM ##Temp_BioMetrics) 
        UPDATE S
          SET
              S.DeletedFlg = 1
              FROM CTE AS T
                        JOIN DIM_EDW_BioMetrics AS S
                        ON
                        S.UserID = T.UserID AND
                        S.UserGUID = T.UserGUID AND
                        S.SiteID = T.SiteID AND
                        S.SiteGUID = T.SiteGUID AND
                        S.itemid = T.itemid AND
                        S.TBL = T.TBL AND
                        S.DeletedFlg IS NULL;

    DECLARE
    @iInserts AS int = @@ROWCOUNT;

    UPDATE DIM_EDW_BioMetrics
      SET
          LastModifiedDate = GETDATE () 
           WHERE
                 LastModifiedDate IS NULL AND
                 DeletedFlg IS NOT NULL;

    PRINT 'Deleted Record Count: ' + CAST ( @iInserts AS nvarchar (50)) ;
    RETURN @iInserts;
END;

GO
PRINT 'Executed proc_CT_BioMetrics_AddDeletedRecs.sql';
GO
