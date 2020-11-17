
GO
PRINT 'Executing proc_CT_CMS_UserSite_AddUpdatedRecs.sql';
GO
IF EXISTS ( SELECT
                   name
                   FROM sys.procedures
                   WHERE name = 'proc_CT_CMS_UserSite_AddUpdatedRecs') 
    BEGIN
        DROP PROCEDURE
             proc_CT_CMS_UserSite_AddUpdatedRecs;
    END;
GO
/*--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
select * from COM_Currency
select top 1000 * from CMS_UserSite

update CMS_UserSite set UserPreferredCurrencyID = NULL where UserSiteID in (select top 50 UserSiteID from CMS_UserSite order by UserSiteID ) and UserPreferredCurrencyID is null

 exec proc_CT_CMS_UserSite_AddUpdatedRecs
 select * from STAGING_CMS_UserSite where SYS_CHANGE_VERSION is not null
*/

CREATE PROCEDURE proc_CT_CMS_UserSite_AddUpdatedRecs
AS
BEGIN
    WITH CTE (
         UserSiteID
       , SYS_CHANGE_VERSION
       , SYS_CHANGE_OPERATION
       , SYS_CHANGE_COLUMNS) 
        AS ( SELECT
                    CT.UserSiteID
                  , CT.SYS_CHANGE_VERSION
                  , CT.SYS_CHANGE_OPERATION
                  , SYS_CHANGE_COLUMNS
                    FROM CHANGETABLE (CHANGES CMS_UserSite, NULL) AS CT
                    WHERE SYS_CHANGE_OPERATION = 'U') 
        UPDATE S
               SET
                   S.UserSiteID = T.UserSiteID
                 ,S.UserID = T.UserID
                 ,S.SiteID = T.SiteID
                 ,S.UserPreferredCurrencyID = T.UserPreferredCurrencyID
                 ,S.UserPreferredShippingOptionID = T.UserPreferredShippingOptionID
                 ,S.UserPreferredPaymentOptionID = T.UserPreferredPaymentOptionID

                 ,S.LastModifiedDate = GETDATE () 
                 ,S.DeletedFlg = NULL
                 ,S.ConvertedToCentralTime = NULL
                 ,S.SYS_CHANGE_VERSION = CTE.SYS_CHANGE_VERSION
                   FROM STAGING_CMS_UserSite AS S
                            JOIN
                            CMS_UserSite AS T
                                ON
                                S.UserSiteID = T.UserSiteID
                            AND S.DeletedFlg IS NULL
                            JOIN CTE
                                ON CTE.UserSiteID = T.UserSiteID
                               AND (CTE.SYS_CHANGE_VERSION != S.SYS_CHANGE_VERSION
                                 OR S.SYS_CHANGE_VERSION IS NULL);

    DECLARE
    @iCnt AS int = @@ROWCOUNT;
    PRINT 'Updated Count: ' + CAST ( @iCnt AS nvarchar (50)) ;

    exec proc_CT_CMS_UserSite_History 'U';

    --WITH CTE (
    --     UserSiteID
    --   , SYS_CHANGE_VERSION
    --   , SYS_CHANGE_COLUMNS) 
    --    AS ( SELECT
    --                CT.UserSiteID
    --              , CT.SYS_CHANGE_VERSION
    --              , SYS_CHANGE_COLUMNS
    --                FROM CHANGETABLE (CHANGES CMS_UserSite, NULL) AS CT
    --                WHERE SYS_CHANGE_OPERATION = 'U'
    --         EXCEPT
    --         SELECT
    --                UserSiteID
    --              , SYS_CHANGE_VERSION
    --              , SYS_CHANGE_COLUMNS
    --                FROM STAGING_CMS_UserSite_Update_History
    --    ) 
    --    INSERT INTO STAGING_CMS_UserSite_Update_History
    --    (
    --           UserSiteID
    --         , LastModifiedDate
    --         , SVR
    --         , DBNAME
    --         , SYS_CHANGE_VERSION
    --         , SYS_CHANGE_COLUMNS
    --         , commit_time) 
    --    SELECT
    --           CTE.UserSiteID
    --         , GETDATE () AS LastModifiedDate
    --         , @@SERVERNAME AS SVR
    --         , DB_NAME () AS DBNAME
    --         , CTE.SYS_CHANGE_VERSION
    --         , CTE.SYS_CHANGE_COLUMNS
    --         , tc.commit_time
    --           FROM
    --               CTE
    --                   JOIN sys.dm_tran_commit_table AS tc
    --                       ON CTE.sys_change_version = tc.commit_ts;

    RETURN @iCnt;
END;

GO
PRINT 'Executed proc_CT_CMS_UserSite_AddUpdatedRecs.sql';
GO
 