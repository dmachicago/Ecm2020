

GO
PRINT 'Executing TRIG_CMS_User_Audit.SQL';
GO
-- select count(*) from DIM_CMS_User_Audit
-- select * from DIM_CMS_User_Audit
-- truncate table DIM_CMS_User_Audit

IF EXISTS (SELECT
                  name
                  FROM sys.tables
                  WHERE name = 'DIM_CMS_User_Audit') 
    BEGIN
        DROP TABLE
             DIM_CMS_User_Audit;
    END;
GO

CREATE TABLE dbo.DIM_CMS_User_Audit (
             UserID int NOT NULL
           , SVR nvarchar (100) NOT NULL
           , DBNAME nvarchar (100) NOT NULL
           , SYS_CHANGE_VERSION int NULL
           , SYS_CHANGE_OPERATION nvarchar (10) NULL
           , SchemaName nvarchar (100) NULL
           , SysUser nvarchar (100) NULL
           , IPADDR  nvarchar (50) NULL
           , Processed integer NULL
           , TBL nvarchar (100) NULL
           , CreateDate datetime NULL
           , commit_time datetime NULL
);
GO
ALTER TABLE dbo.DIM_CMS_User_Audit
ADD
            CONSTRAINT DF_STAGING_CMS_User_Audit_CreateDate  DEFAULT GETDATE () FOR CreateDate;
GO
CREATE CLUSTERED INDEX PK_CMS_User_Audit ON dbo.DIM_CMS_User_Audit
(
UserID ASC,
SVR ASC, DBNAME ASC,
SYS_CHANGE_VERSION ASC,
SYS_CHANGE_OPERATION ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];

GO

/*---------------------------------------------------------------------------------------------------------------
-- TROUBLESHOOTING AND TESTING QRYS
	select count(*) from CMS_User where UserID = 53 and SiteID = 36
	INSERT INTO CMS_User (UserID, SiteID) VALUES (53, 36) ;
	delete from CMS_User where UserID = 53 and SiteID = 36
	select top 1000 * from CMS_User
	select top 1000 * from CMS_User
	update CMS_User set FirstName = FirstName where UserID in (Select top 100 UserID from CMS_User order by UserID )
	select * from DIM_CMS_User_Audit
	truncate table  DIM_CMS_User_Audit
*/

IF EXISTS (SELECT
                  name
                  FROM sys.triggers
                  WHERE name = 'trig_INS_CMS_User_Audit') 
    BEGIN
        DROP TRIGGER
             trig_INS_CMS_User_Audit;
    END;
GO

CREATE TRIGGER trig_INS_CMS_User_Audit ON CMS_User
    AFTER INSERT
AS
BEGIN

    DECLARE @svr nvarchar (100) = (SELECT
                                          @@SERVERNAME);
    DECLARE @db nvarchar (100) = (SELECT
                                         DB_NAME ());
    DECLARE @CHG_VER int = (SELECT
                                   MAX (CT.SYS_CHANGE_VERSION) 
                                   FROM CHANGETABLE (CHANGES CMS_User, NULL) AS CT);
    DECLARE @ipaddr nvarchar (50) = (SELECT
                                            CAST (CONNECTIONPROPERTY ('client_net_address') AS nvarchar (50)) );
    DECLARE @userid nvarchar (50) = (SELECT
                                            USER_NAME () );
    DECLARE @sysuser nvarchar (50) = (SELECT
                                             SYSTEM_USER);
    IF @CHG_VER IS NULL
        BEGIN
            SET @CHG_VER = 1
        END;

    SET @CHG_VER = @CHG_VER - 1;
    DECLARE @Commit_Time datetime = (SELECT TOP 1
                                            tc.commit_time
                                            FROM
                                                CHANGETABLE (CHANGES CMS_User, @Chg_Ver) c
                                                    JOIN sys.dm_tran_commit_table AS tc
                                                        ON c.sys_change_version = tc.commit_ts);

    INSERT INTO DIM_CMS_User_Audit
    (
           UserID
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
           UserID
         , @svr
         , @db
         , @CHG_VER
         , 'I'
         , @userid
         , @sysuser
         , @ipaddr
         , 0 AS Processed
         , 'CMS_User'
         , @Commit_Time
           FROM Inserted;
END;

GO

IF EXISTS (SELECT
                  name
                  FROM sys.triggers
                  WHERE name = 'trig_UPDT_CMS_User_Audit') 
    BEGIN
        DROP TRIGGER
             trig_UPDT_CMS_User_Audit;
    END;
GO

CREATE TRIGGER trig_UPDT_CMS_User_Audit ON CMS_User
    AFTER UPDATE
AS
BEGIN

    DECLARE @svr nvarchar (100) = (SELECT
                                          @@SERVERNAME);
    DECLARE @db nvarchar (100) = (SELECT
                                         DB_NAME ());
    DECLARE @CHG_VER int = (SELECT
                                   MAX (CT.SYS_CHANGE_VERSION) 
                                   FROM CHANGETABLE (CHANGES CMS_User, NULL) AS CT);
    DECLARE @ipaddr nvarchar (50) = (SELECT
                                            CAST (CONNECTIONPROPERTY ('client_net_address') AS nvarchar (50)) );
    DECLARE @userid nvarchar (50) = (SELECT
                                            USER_NAME () );
    DECLARE @sysuser nvarchar (50) = (SELECT
                                             SYSTEM_USER);

    IF @CHG_VER IS NULL
        BEGIN
            SET @CHG_VER = 1
        END;

    SET @CHG_VER = @CHG_VER - 1;
    DECLARE @Commit_Time datetime = (SELECT TOP 1
                                            tc.commit_time
                                            FROM
                                                CHANGETABLE (CHANGES CMS_User, @Chg_Ver) c
                                                    JOIN sys.dm_tran_commit_table AS tc
                                                        ON c.sys_change_version = tc.commit_ts);

    INSERT INTO DIM_CMS_User_Audit
    (
           UserID
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
           UserID
         , @svr
         , @db
         , @CHG_VER
         , 'U'
         , @userid
         , @sysuser
         , @ipaddr
         , 0 AS Processed
         , 'CMS_User'
         , @Commit_Time
           FROM Inserted;
END;

GO

IF EXISTS (SELECT
                  name
                  FROM sys.triggers
                  WHERE name = 'trig_DEL_CMS_User_Audit') 
    BEGIN
        DROP TRIGGER
             trig_DEL_CMS_User_Audit;
    END;
GO

CREATE TRIGGER trig_DEL_CMS_User_Audit ON CMS_User
    AFTER DELETE
AS
BEGIN

    DECLARE @svr nvarchar (100) = (SELECT
                                          @@SERVERNAME);
    DECLARE @db nvarchar (100) = (SELECT
                                         DB_NAME ());
    DECLARE @CHG_VER int = (SELECT
                                   MAX (CT.SYS_CHANGE_VERSION) 
                                   FROM CHANGETABLE (CHANGES CMS_User, NULL) AS CT);
    DECLARE @ipaddr nvarchar (50) = (SELECT
                                            CAST (CONNECTIONPROPERTY ('client_net_address') AS nvarchar (50)) );
    DECLARE @userid nvarchar (50) = (SELECT
                                            USER_NAME () );
    DECLARE @sysuser nvarchar (50) = (SELECT
                                             SYSTEM_USER);

    IF @CHG_VER IS NULL
        BEGIN
            SET @CHG_VER = 1
        END;

    SET @CHG_VER = @CHG_VER - 1;
    DECLARE @Commit_Time datetime = (SELECT TOP 1
                                            tc.commit_time
                                            FROM
                                                CHANGETABLE (CHANGES CMS_User, @Chg_Ver) c
                                                    JOIN sys.dm_tran_commit_table AS tc
                                                        ON c.sys_change_version = tc.commit_ts);

    INSERT INTO DIM_CMS_User_Audit
    (
           UserID
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
           UserID
         , @svr
         , @db
         , @CHG_VER
         , 'D'
         , @userid
         , @sysuser
         , @ipaddr
         , 0 AS Processed
         , 'CMS_User'
         , @Commit_Time
           FROM DELETED;
END;

GO
PRINT 'EXECUTED TRIG_CMS_User_Audit.SQL';
GO
