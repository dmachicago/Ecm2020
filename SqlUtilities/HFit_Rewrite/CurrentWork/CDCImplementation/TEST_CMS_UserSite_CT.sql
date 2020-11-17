-- TEST_CMS_UserSite_CT.sql
--drop table TEMP_CMS_UserSite_1000
IF NOT EXISTS (SELECT
                      name
                      FROM sys.tables
                      WHERE
                      name = 'TEMP_CMS_UserSite_1000') 
    BEGIN
        SELECT
               * INTO
                      TEMP_CMS_UserSite_1000
               FROM CMS_UserSite;
        CREATE UNIQUE CLUSTERED INDEX PI_TEMP_CMS_UserSite_1000 ON dbo.TEMP_CMS_UserSite_1000
        (
        UserSiteID ASC
        );
    END;
GO

IF NOT EXISTS (SELECT
                      CurrencyName
                      FROM COM_Currency
                      WHERE
                      CurrencyCode = 'TEURO') 
    BEGIN
        INSERT INTO dbo.COM_Currency
        (
               CurrencyName
             , CurrencyDisplayName
             , CurrencyCode
             , CurrencyRoundTo
             , CurrencyEnabled
             , CurrencyFormatString
             , CurrencyIsMain
             , CurrencyGUID
             , CurrencyLastModified
             , CurrencySiteID) 
        VALUES
        (
        'TEST EUROS'
        , 'TEST EUROS'
        , 'TEURO'
        , 2
        , 1
        , '0,000,000,000.00'
        , 0
        , NEWID () 
        , GETDATE () 
        , NULL) ;
    END;
-- select top 100 * from [COM_Currency]
-- select top 100 * from CMS_UserSite
UPDATE CMS_UserSite
  SET
      UserPreferredCurrencyID = 2
       WHERE
             UserSiteID IN (SELECT TOP 1000
                                   UserSiteID
                                   FROM CMS_UserSite
                                   ORDER BY
                                            UserSiteID DESC) ;

SELECT
       COUNT (*) 
	   --,CT.UserSiteID
	   --, CT.SYS_CHANGE_VERSION
	   --, CT.SYS_CHANGE_OPERATION
       FROM CHANGETABLE (CHANGES CMS_UserSite , NULL) AS CT
       WHERE
       SYS_CHANGE_OPERATION = 'U';
SELECT
       COUNT (*) 
     , SYS_CHANGE_OPERATION
       FROM STAGING_CMS_UserSite_Audit
       GROUP BY
                SYS_CHANGE_OPERATION;

EXEC proc_STAGING_EDW_CMS_UserSite;

DELETE FROM CMS_UserSite
       WHERE
             UserSiteID IN (SELECT TOP 500
                                   UserSiteID
                                   FROM CMS_UserSite
                                   ORDER BY
                                            UserSiteID DESC) ;
SELECT
       COUNT (*) 
--,CT.UserSiteID
--, CT.SYS_CHANGE_VERSION
--, CT.SYS_CHANGE_OPERATION
       FROM CHANGETABLE (CHANGES CMS_UserSite , NULL) AS CT
       WHERE
       SYS_CHANGE_OPERATION = 'D';
SELECT
       COUNT (*) 
     , SYS_CHANGE_OPERATION
       FROM STAGING_CMS_UserSite_Audit
       GROUP BY
                SYS_CHANGE_OPERATION;

EXEC proc_STAGING_EDW_CMS_UserSite;

GO
SET IDENTITY_INSERT CMS_UserSite ON;
GO

WITH CTE (
     UserSiteID) 
    AS (
    SELECT
           UserSiteID
           FROM TEMP_CMS_UserSite_1000
    EXCEPT
    SELECT
           UserSiteID
           FROM CMS_UserSite
    ) 
INSERT INTO CMS_UserSite
(
     UserSiteID
      , UserID 
      , SiteID 
      , UserPreferredCurrencyID 
      , UserPreferredShippingOptionID 
      , UserPreferredPaymentOptionID )
 SELECT 
     CTE.UserSiteID
     , UserID 
     , SiteID 
     , UserPreferredCurrencyID 
     , UserPreferredShippingOptionID 
     , UserPreferredPaymentOptionID 
    FROM
                TEMP_CMS_UserSite_1000
                     JOIN CTE
                     ON
           CTE.UserSiteID = TEMP_CMS_UserSite_1000.UserSiteID;

GO

SET IDENTITY_INSERT CMS_UserSite OFF;
GO

SELECT
       COUNT (*) 
--,CT.UserSiteID
--, CT.SYS_CHANGE_VERSION
--, CT.SYS_CHANGE_OPERATION
       FROM CHANGETABLE (CHANGES CMS_UserSite , NULL) AS CT
       WHERE
       SYS_CHANGE_OPERATION = 'I';
SELECT
       COUNT (*) 
     , SYS_CHANGE_OPERATION
       FROM STAGING_CMS_UserSite_Audit
       GROUP BY
                SYS_CHANGE_OPERATION;

EXEC proc_STAGING_EDW_CMS_UserSite;

GO

UPDATE CMS_UserSite
  SET
      UserPreferredCurrencyID = null
       WHERE
             UserPreferredCurrencyID = 2 ;
EXEC proc_STAGING_EDW_CMS_UserSite;

SELECT
       *
       FROM view_AUDIT_CMS_UserSite
       WHERE UserSiteID IN (
       SELECT TOP 100
              UserSiteID
              FROM CMS_UserSite
              ORDER BY
                       UserSiteID DESC) 
       ORDER BY
                UserSiteID;


