
GO
-- USe KenticoCMS_Prod1

PRINT 'Executing proc_CT_CMS_UserSite_AddNewRecs.sql';
GO
IF EXISTS ( SELECT
                   name
                   FROM sys.procedures
                   WHERE name = 'proc_CT_CMS_UserSite_AddNewRecs') 
    BEGIN
        DROP PROCEDURE
             proc_CT_CMS_UserSite_AddNewRecs;
    END;
GO
-- exec proc_CT_CMS_UserSite_AddNewRecs
CREATE PROCEDURE proc_CT_CMS_UserSite_AddNewRecs
AS
BEGIN

    -- SET IDENTITY_INSERT STAGING_CMS_UserSite ON;
 
    WITH CTE (
         UserSiteID
       ) 
        AS ( SELECT
                    UserSiteID
                    FROM CMS_UserSite
             EXCEPT
             SELECT
                    UserSiteID
                    FROM STAGING_CMS_UserSite
                    WHERE DeletedFlg IS NULL) 
        INSERT INTO STAGING_CMS_UserSite
        (
               UserSiteID
             , UserID
             , SiteID
             , UserPreferredCurrencyID
             , UserPreferredShippingOptionID
             , UserPreferredPaymentOptionID

             , LastModifiedDate
               --,[RowNbr]
             , DeletedFlg
             , TimeZone
             , ConvertedToCentralTime
             , SVR
             , DBNAME
             , SYS_CHANGE_VERSION) 
        SELECT
               T.UserSiteID
             , T.UserID
             , T.SiteID
             , T.UserPreferredCurrencyID
             , T.UserPreferredShippingOptionID
             , T.UserPreferredPaymentOptionID

             , GETDATE () AS LastModifiedDate
             , NULL AS DeletedFlg
             , NULL AS TimeZone
             , NULL AS ConvertedToCentralTime
             , @@SERVERNAME AS SVR
             , DB_NAME () AS DBNAME
             , null as SYS_CHANGE_VERSION
               FROM
                   CMS_UserSite AS T
                       JOIN CTE AS S
                           ON S.UserSiteID = T.UserSiteID;
    DECLARE
    @iInserts AS int = @@ROWCOUNT;
    --SET IDENTITY_INSERT STAGING_CMS_UserSite OFF;
    PRINT 'NEW Insert Count: ' + CAST ( @iInserts AS nvarchar (50)) ;

    if @iInserts > 0
	   exec proc_CT_CMS_UserSite_History 'I';

    RETURN @iInserts;
END;

GO
PRINT 'Executed proc_CT_CMS_UserSite_AddNewRecs.sql';
GO
