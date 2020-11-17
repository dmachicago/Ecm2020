

GO
PRINT 'Executing TRIG_CMS_UserSettings_Audit.SQL';
GO
-- select count(*) from STAGING_CMS_UserSettings_Audit
-- select * from STAGING_CMS_UserSettings_Audit
-- truncate table STAGING_CMS_UserSettings_Audit

IF EXISTS (SELECT
                  name
                  FROM sys.tables
                  WHERE name = 'STAGING_CMS_UserSettings_Audit') 
    BEGIN
        DROP TABLE
             STAGING_CMS_UserSettings_Audit;
    END;
GO

-- select * from [STAGING_CMS_UserSettings_Audit]
CREATE TABLE dbo.STAGING_CMS_UserSettings_Audit (
             UserSettingsID int NOT NULL
           ,SVR nvarchar (100) NOT NULL
           ,DBNAME nvarchar (100) NOT NULL
           ,SYS_CHANGE_VERSION int NULL
           ,SYS_CHANGE_OPERATION nvarchar (10) NULL
           ,SchemaName nvarchar (100) NULL
           ,SysUser nvarchar (100) NULL
           ,IPADDR nvarchar (50) NULL
           ,Processed int NULL
           ,TBL nvarchar (100) NULL
           ,CreateDate datetime NULL
	   ,commit_time datetime NULL
) 
ON [PRIMARY];

GO

ALTER TABLE dbo.STAGING_CMS_UserSettings_Audit
ADD
            CONSTRAINT DF_STAGING_CMS_UserSettings_Audit_CreateDate  DEFAULT GETDATE () FOR CreateDate;
GO

GO
CREATE CLUSTERED INDEX PK_CMS_UserSettings_Audit ON dbo.STAGING_CMS_UserSettings_Audit
(
UserSettingsID ASC,
SVR ASC,
SYS_CHANGE_VERSION ASC,
SYS_CHANGE_OPERATION ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
GO

/*-------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TROUBLESHOOTING AND TESTING QRYS
	select count(*) from CMS_UserSettings where UserSettingsID = 53 and SiteID = 36
	INSERT INTO CMS_UserSettings (UserSettingsID, SiteID) VALUES (53, 36) ;
	delete from CMS_UserSettings where UserSettingsID = 53 and SiteID = 36
	select top 1000 * from CMS_UserSettings
	select top 1000 * from CMS_UserSettings
	update CMS_UserSettings set UserNickName = UserNickName where UserSettingsID in (Select top 100 UserSettingsID from CMS_UserSettings order by UserSettingsID )
	select * from STAGING_CMS_UserSettings_Audit
	truncate table  STAGING_CMS_UserSettings_Audit
*/

IF EXISTS (SELECT
                  name
                  FROM sys.triggers
                  WHERE name = 'trig_INS_CMS_UserSettings_Audit') 
    BEGIN
        DROP TRIGGER
             trig_INS_CMS_UserSettings_Audit;
    END;
GO

CREATE TRIGGER trig_INS_CMS_UserSettings_Audit ON CMS_UserSettings
    AFTER INSERT
AS
BEGIN

    DECLARE @svr nvarchar (100) = (SELECT
                                          @@SERVERNAME);
    DECLARE @db nvarchar (100) = (SELECT
                                         DB_NAME ());
    DECLARE @CHG_VER int = (SELECT
                                   MAX (CT.SYS_CHANGE_VERSION) 
                                   FROM CHANGETABLE (CHANGES CMS_UserSettings, NULL) AS CT);
    DECLARE @ipaddr nvarchar (50) = (SELECT
                                            CAST (CONNECTIONPROPERTY ('client_net_address') AS nvarchar (50)) );
    DECLARE @UserSettingsID nvarchar (50) = (SELECT
                                                    USER_NAME () );
    DECLARE @sysuser nvarchar (50) = (SELECT
                                             SYSTEM_USER);

    IF @CHG_VER IS NULL
        BEGIN
            SET @CHG_VER = 1;
        END;

    SET @CHG_VER = @CHG_VER - 1;
    DECLARE @Commit_Time datetime = (SELECT TOP 1
                                            tc.commit_time
                                            FROM
                                                CHANGETABLE (CHANGES CMS_UserSettings, @Chg_Ver) c
                                                    JOIN sys.dm_tran_commit_table AS tc
                                                        ON c.sys_change_version = tc.commit_ts);

    INSERT INTO STAGING_CMS_UserSettings_Audit
    (
           UserSettingsID
         , SVR
         , DBNAME
         , SYS_CHANGE_VERSION
         , SYS_CHANGE_OPERATION
         , SchemaName
         , SysUser
         , IPADDR
         , Processed
         , TBL
    , commit_time
    ) 
    SELECT
           UserSettingsID
         , @svr
         , @db
         , @CHG_VER
         , 'I'
         , @UserSettingsID
         , @sysuser
         , @ipaddr
         , 0 AS Processed
         , 'CMS_UserSettings'
     , @Commit_Time
           FROM Inserted;
END;

GO

IF EXISTS (SELECT
                  name
                  FROM sys.triggers
                  WHERE name = 'trig_UPDT_CMS_UserSettings_Audit') 
    BEGIN
        DROP TRIGGER
             trig_UPDT_CMS_UserSettings_Audit;
    END;
GO

CREATE TRIGGER trig_UPDT_CMS_UserSettings_Audit ON CMS_UserSettings
    AFTER UPDATE
AS
BEGIN

    DECLARE @svr nvarchar (100) = (SELECT
                                          @@SERVERNAME);
    DECLARE @db nvarchar (100) = (SELECT
                                         DB_NAME ());
    DECLARE @CHG_VER int = (SELECT
                                   MAX (CT.SYS_CHANGE_VERSION) 
                                   FROM CHANGETABLE (CHANGES CMS_UserSettings, NULL) AS CT);
    DECLARE @ipaddr nvarchar (50) = (SELECT
                                            CAST (CONNECTIONPROPERTY ('client_net_address') AS nvarchar (50)) );
    DECLARE @UserSettingsID nvarchar (50) = (SELECT
                                                    USER_NAME () );
    DECLARE @sysuser nvarchar (50) = (SELECT
                                             SYSTEM_USER);
    IF @CHG_VER IS NULL
        BEGIN
            SET @CHG_VER = 1;
        END;

    SET @CHG_VER = @CHG_VER - 1;
    DECLARE @Commit_Time datetime = (SELECT TOP 1
                                            tc.commit_time
                                            FROM
                                                CHANGETABLE (CHANGES CMS_UserSettings, @Chg_Ver) c
                                                    JOIN sys.dm_tran_commit_table AS tc
                                                        ON c.sys_change_version = tc.commit_ts);
    INSERT INTO STAGING_CMS_UserSettings_Audit
    (
           UserSettingsID
         , SVR
         , DBNAME
         , SYS_CHANGE_VERSION
         , SYS_CHANGE_OPERATION
         , SchemaName
         , SysUser
         , IPADDR
         , Processed
         , TBL, commit_time
    ) 
    SELECT
           UserSettingsID
         , @svr
         , @db
         , @CHG_VER
         , 'U'
         , @UserSettingsID
         , @sysuser
         , @ipaddr
         , 0 AS Processed
         , 'CMS_UserSettings' , @Commit_Time
           FROM Inserted;
END;

GO

IF EXISTS (SELECT
                  name
                  FROM sys.triggers
                  WHERE name = 'trig_DEL_CMS_UserSettings_Audit') 
    BEGIN
        DROP TRIGGER
             trig_DEL_CMS_UserSettings_Audit;
    END;
GO

CREATE TRIGGER trig_DEL_CMS_UserSettings_Audit ON CMS_UserSettings
    AFTER DELETE
AS
BEGIN

    DECLARE @svr nvarchar (100) = (SELECT
                                          @@SERVERNAME);
    DECLARE @db nvarchar (100) = (SELECT
                                         DB_NAME ());
    DECLARE @CHG_VER int = (SELECT
                                   MAX (CT.SYS_CHANGE_VERSION) 
                                   FROM CHANGETABLE (CHANGES CMS_UserSettings, NULL) AS CT);
    DECLARE @ipaddr nvarchar (50) = (SELECT
                                            CAST (CONNECTIONPROPERTY ('client_net_address') AS nvarchar (50)) );
    DECLARE @UserSettingsID nvarchar (50) = (SELECT
                                                    USER_NAME () );
    DECLARE @sysuser nvarchar (50) = (SELECT
                                             SYSTEM_USER);
    IF @CHG_VER IS NULL
        BEGIN
            SET @CHG_VER = 1;
        END;

    SET @CHG_VER = @CHG_VER - 1;
    DECLARE @Commit_Time datetime = (SELECT TOP 1
                                            tc.commit_time
                                            FROM
                                                CHANGETABLE (CHANGES CMS_UserSettings, @Chg_Ver) c
                                                    JOIN sys.dm_tran_commit_table AS tc
                                                        ON c.sys_change_version = tc.commit_ts);
    INSERT INTO STAGING_CMS_UserSettings_Audit
    (
           UserSettingsID
         , SVR
         , DBNAME
         , SYS_CHANGE_VERSION
         , SYS_CHANGE_OPERATION
         , SchemaName
         , SysUser
         , IPADDR
         , Processed
         , TBL , commit_time
    ) 
    SELECT
           UserSettingsID
         , @svr
         , @db
         , @CHG_VER
         , 'D'
         , @UserSettingsID
         , @sysuser
         , @ipaddr
         , 0 AS Processed
         , 'CMS_UserSettings' , @Commit_Time
           FROM DELETED;
END;

GO
PRINT 'EXECUTED TRIG_CMS_UserSettings_Audit.SQL';
GO
