

GO
PRINT 'Executing _TriggerToUpdateAuditRecordForCT.SQL';
GO
-- select count(*) from STAGING_CMS_UserSite_Audit
-- select * from STAGING_CMS_UserSite_Audit
-- truncate table STAGING_CMS_UserSite_Audit

IF EXISTS (SELECT
                  name
                  FROM sys.tables
                  WHERE name = 'STAGING_CMS_UserSite_Audit') 
    BEGIN
        DROP TABLE
             STAGING_CMS_UserSite_Audit
    END;
GO

CREATE TABLE dbo.STAGING_CMS_UserSite_Audit (
             UserSiteID int NOT NULL
           , SVR nvarchar (100) NOT NULL
           , DBNAME nvarchar (100) NOT NULL
           , SYS_CHANGE_VERSION int NULL
           , SYS_CHANGE_OPERATION nvarchar (10) NULL
           , SchemaName nvarchar (100) NULL
           , SysUser nvarchar (100) NULL
           , IPADDR  nvarchar (50) NULL
           , Processed integer NULL
           , TBL nvarchar (100) NULL
);

GO

-- select count(*) from CMS_UserSite where UserID = 53 and SiteID = 36
-- INSERT INTO CMS_UserSite (UserID, SiteID) VALUES (53, 36) ;
-- delete from CMS_UserSite where UserID = 53 and SiteID = 36
-- select top 1000 * from CMS_User
-- select top 1000 * from CMS_UserSite
-- update CMS_UserSite set SiteID = SiteID where UserSiteID in (Select top 100 UserSiteID from CMS_UserSite order by UserSiteID desc)
-- select * from STAGING_CMS_UserSite_Audit
-- truncate table  STAGING_CMS_UserSite_Audit

IF EXISTS (SELECT
                  name
                  FROM sys.triggers
                  WHERE name = 'trig_INS_CMS_UserSite_Audit') 
    BEGIN
        DROP TRIGGER
             trig_CMS_UserSite_Audit
    END;
GO

CREATE TRIGGER trig_INS_CMS_UserSite_Audit ON CMS_UserSite
    AFTER INSERT
AS
BEGIN

    DECLARE @svr nvarchar (100) = (SELECT
                                          @@SERVERNAME);
    DECLARE @db nvarchar (100) = (SELECT
                                         DB_NAME ());
    DECLARE @CHG_VER int = (SELECT
                                   MAX (CT.SYS_CHANGE_VERSION) 
                                   FROM CHANGETABLE (CHANGES CMS_UserSite, NULL) AS CT);
    DECLARE @ipaddr nvarchar (50) = (SELECT
                                            CAST (CONNECTIONPROPERTY ('client_net_address') AS nvarchar (50)) );
    DECLARE @userid nvarchar (50) = (SELECT
                                            USER_NAME () );
    DECLARE @sysuser nvarchar (50) = (SELECT
                                             SYSTEM_USER);

    INSERT INTO STAGING_CMS_UserSite_Audit
    (
           UserSiteID
         , SVR
         , DBNAME
         , SYS_CHANGE_VERSION
         , SYS_CHANGE_OPERATION
         , SchemaName
         , SysUser
         , IPADDR
         , Processed
         , TBL
    ) 
    SELECT
           UserSiteID
         , @svr
         , @db
         , @CHG_VER
         , 'I'
         , @userid
         , @sysuser
         , @ipaddr
         , 0 AS Processed
         , 'CMS_UserSite'
           FROM Inserted;
END;

IF EXISTS (SELECT
                  name
                  FROM sys.triggers
                  WHERE name = 'trig_UPDT_CMS_UserSite_Audit') 
    BEGIN
        DROP TRIGGER
             trig_UPDT_CMS_UserSite_Audit
    END;
GO

CREATE TRIGGER trig_UPDT_CMS_UserSite_Audit ON CMS_UserSite
    AFTER UPDATE
AS
BEGIN

    DECLARE @svr nvarchar (100) = (SELECT @@SERVERNAME);
    DECLARE @db nvarchar (100) = (SELECT DB_NAME ());
    DECLARE @CHG_VER int = (SELECT MAX (CT.SYS_CHANGE_VERSION) FROM CHANGETABLE (CHANGES CMS_UserSite, NULL) AS CT);
    DECLARE @ipaddr nvarchar (50) = (SELECT CAST (CONNECTIONPROPERTY ('client_net_address') AS nvarchar (50)) );
    DECLARE @userid nvarchar (50) = (SELECT USER_NAME () );
    DECLARE @sysuser nvarchar (50) = (SELECT SYSTEM_USER);

    INSERT INTO STAGING_CMS_UserSite_Audit
    (
           UserSiteID
         , SVR
         , DBNAME
         , SYS_CHANGE_VERSION
         , SYS_CHANGE_OPERATION
         , SchemaName
         , SysUser
         , IPADDR
         , Processed
         , TBL
    ) 
    SELECT
           UserSiteID
         , @svr
         , @db
         , @CHG_VER
         , 'U'
         , @userid
         , @sysuser
         , @ipaddr
         , 0 AS Processed
         , 'CMS_UserSite'
           FROM Inserted;
END;


IF EXISTS (SELECT
                  name
                  FROM sys.triggers
                  WHERE name = 'trig_DEL_CMS_UserSite_Audit') 
    BEGIN
        DROP TRIGGER
             trig_DEL_CMS_UserSite_Audit
    END;
GO

CREATE TRIGGER trig_DEL_CMS_UserSite_Audit ON CMS_UserSite
    AFTER delete
AS
BEGIN

    DECLARE @svr nvarchar (100) = (SELECT @@SERVERNAME);
    DECLARE @db nvarchar (100) = (SELECT DB_NAME ());
    DECLARE @CHG_VER int = (SELECT MAX (CT.SYS_CHANGE_VERSION) FROM CHANGETABLE (CHANGES CMS_UserSite, NULL) AS CT);
    DECLARE @ipaddr nvarchar (50) = (SELECT CAST (CONNECTIONPROPERTY ('client_net_address') AS nvarchar (50)) );
    DECLARE @userid nvarchar (50) = (SELECT USER_NAME () );
    DECLARE @sysuser nvarchar (50) = (SELECT SYSTEM_USER);

    INSERT INTO STAGING_CMS_UserSite_Audit
    (
           UserSiteID
         , SVR
         , DBNAME
         , SYS_CHANGE_VERSION
         , SYS_CHANGE_OPERATION
         , SchemaName
         , SysUser
         , IPADDR
         , Processed
         , TBL
    ) 
    SELECT
           UserSiteID
         , @svr
         , @db
         , @CHG_VER
         , 'D'
         , @userid
         , @sysuser
         , @ipaddr
         , 0 AS Processed
         , 'CMS_UserSite'
           FROM DELETED;
END;

GO
PRINT 'EXECUTED _TriggerToUpdateAuditRecordForCT.SQL';
GO
