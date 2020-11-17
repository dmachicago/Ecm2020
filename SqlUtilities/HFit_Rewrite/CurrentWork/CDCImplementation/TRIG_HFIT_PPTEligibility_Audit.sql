

GO
PRINT 'Executing TRIG_HFIT_PPTEligibility_Audit.SQL';
GO
-- select count(*) from STAGING_HFIT_PPTEligibility_Audit
-- select * from STAGING_HFIT_PPTEligibility_Audit
-- truncate table STAGING_HFIT_PPTEligibility_Audit

IF EXISTS (SELECT
                  name
                  FROM sys.tables
                  WHERE name = 'STAGING_HFIT_PPTEligibility_Audit') 
    BEGIN
        DROP TABLE
             STAGING_HFIT_PPTEligibility_Audit;
    END;
GO

CREATE TABLE dbo.STAGING_HFIT_PPTEligibility_Audit (
             PPTID int NOT NULL
           , SVR nvarchar (100) NOT NULL
           , DBNAME nvarchar (100) NOT NULL
           , SYS_CHANGE_VERSION int NULL
           , SYS_CHANGE_OPERATION nvarchar (10) NULL
           , SchemaName nvarchar (100) NULL
           , SysUser nvarchar (100) NULL
           , IPADDR nvarchar (50) NULL
           , Processed integer NULL
           , TBL nvarchar (100) NULL
           , CreateDate datetime NULL
           , commit_time datetime NULL) ;
GO
ALTER TABLE dbo.STAGING_HFIT_PPTEligibility_Audit
ADD
            CONSTRAINT DF_STAGING_HFIT_PPTEligibility_Audit_CreateDate DEFAULT GETDATE () FOR CreateDate;
GO

CREATE CLUSTERED INDEX PK_HFIT_PPTEligibility_Audit ON dbo.STAGING_HFIT_PPTEligibility_Audit (PPTID ASC, SVR ASC, SYS_CHANGE_VERSION ASC, SYS_CHANGE_OPERATION ASC) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];

GO

/*----------------------------------------------------------------------------------------------------------------------------------
**********************************************************************************************************************************
-- TROUBLESHOOTING AND TESTING QRYS
	select count(*) from HFIT_PPTEligibility where UserID = 53 and SiteID = 36
	INSERT INTO HFIT_PPTEligibility (UserID, SiteID) VALUES (53, 36) ;
	delete from HFIT_PPTEligibility where UserID = 53 and SiteID = 36
	select top 1000 * from CMS_User
	select top 1000 * from HFIT_PPTEligibility
	update HFIT_PPTEligibility set FirstName = FirstName where PPTID in (Select top 100 PPTID from HFIT_PPTEligibility order by PPTID )
	select * from STAGING_HFIT_PPTEligibility_Audit
	truncate table  STAGING_HFIT_PPTEligibility_Audit
**********************************************************************************************************************************
*/

IF EXISTS (SELECT
                  name
                  FROM sys.triggers
                  WHERE name = 'trig_INS_HFIT_PPTEligibility_Audit') 
    BEGIN
        DROP TRIGGER
             trig_INS_HFIT_PPTEligibility_Audit;
    END;
GO

CREATE TRIGGER trig_INS_HFIT_PPTEligibility_Audit ON HFIT_PPTEligibility
    AFTER INSERT
AS
BEGIN

    DECLARE @Svr nvarchar (100) = (SELECT
                                          @@Servername);
    DECLARE @Db nvarchar (100) = (SELECT
                                         DB_NAME ());
    DECLARE @CurrChg_Ver int = (SELECT
                                       MAX (CT.SYS_CHANGE_VERSION) 
                                       FROM CHANGETABLE (CHANGES HFIT_PPTEligibility, NULL) AS CT);

    DECLARE @Chg_Ver int = @CurrChg_Ver - 1;

    DECLARE @Ipaddr nvarchar (50) = (SELECT
                                            CAST (CONNECTIONPROPERTY ('client_net_address') AS nvarchar (50)));
    DECLARE @Userid nvarchar (50) = (SELECT
                                            USER_NAME ());
    DECLARE @Sysuser nvarchar (50) = (SELECT
                                             SYSTEM_USER);

    DECLARE @Commit_Time datetime = (SELECT TOP 1
                                            tc.commit_time
                                            FROM
                                                CHANGETABLE (CHANGES HFIT_PPTEligibility, @Chg_Ver) c
                                                    JOIN sys.dm_tran_commit_table AS tc
                                                        ON c.sys_change_version = tc.commit_ts);

    INSERT INTO STAGING_HFIT_PPTEligibility_Audit (
           PPTID
         , SVR
         , DBNAME
         , SYS_CHANGE_VERSION
         , SYS_CHANGE_OPERATION
         , SchemaName
         , SysUser
         , IPADDR
         , Processed
         , TBL
         , commit_time) 
    SELECT
           PPTID
         , @Svr
         , @Db
         , @Chg_Ver
         , 'I'
         , @Userid
         , @Sysuser
         , @Ipaddr
         , 0 AS Processed
         , 'HFIT_PPTEligibility'
         , @Commit_Time
           FROM Inserted;
END;

GO

IF EXISTS (SELECT
                  name
                  FROM sys.triggers
                  WHERE name = 'trig_UPDT_HFIT_PPTEligibility_Audit') 
    BEGIN
        DROP TRIGGER
             trig_UPDT_HFIT_PPTEligibility_Audit;
    END;
GO

CREATE TRIGGER trig_UPDT_HFIT_PPTEligibility_Audit ON HFIT_PPTEligibility
    AFTER UPDATE
AS
BEGIN
    DECLARE @Next_Baseline bigint;
    SET @Next_Baseline = CHANGE_TRACKING_CURRENT_VERSION () ;
    DECLARE @Svr nvarchar (100) = (SELECT
                                          @@Servername);
    DECLARE @Db nvarchar (100) = (SELECT
                                         DB_NAME ());
    DECLARE @CurrChg_Ver int = (SELECT
                                       MAX (CT.SYS_CHANGE_VERSION) 
                                       FROM CHANGETABLE (CHANGES HFIT_PPTEligibility, NULL) AS CT);

    DECLARE @Chg_Ver int = @CurrChg_Ver - 1;
    DECLARE @Ipaddr nvarchar (50) = (SELECT
                                            CAST (CONNECTIONPROPERTY ('client_net_address') AS nvarchar (50)));
    DECLARE @Userid nvarchar (50) = (SELECT
                                            USER_NAME ());
    DECLARE @Sysuser nvarchar (50) = (SELECT
                                             SYSTEM_USER);

    --exec @Chg_Ver = proc_CT_getPrevVer 'HFIT_PPTEligibility' ;
    --print @Chg_Ver ;

    DECLARE @Commit_Time datetime = (SELECT TOP 1
                                            tc.commit_time
                                            FROM
                                                CHANGETABLE (CHANGES HFIT_PPTEligibility, @Chg_Ver) c
                                                    JOIN sys.dm_tran_commit_table AS tc
                                                        ON c.sys_change_version = tc.commit_ts);
    SET @Chg_Ver = @Chg_Ver - 1;

    INSERT INTO STAGING_HFIT_PPTEligibility_Audit (
           PPTID
         , SVR
         , DBNAME
         , SYS_CHANGE_VERSION
         , SYS_CHANGE_OPERATION
         , SchemaName
         , SysUser
         , IPADDR
         , Processed
         , TBL
         , commit_time) 
    SELECT
           PPTID
         , @Svr
         , @Db
         , @Chg_Ver
         , 'U'
         , @Userid
         , @Sysuser
         , @Ipaddr
         , 0 AS Processed
         , 'HFIT_PPTEligibility'
         , @Commit_Time
           FROM Inserted;
END;

GO

IF EXISTS (SELECT
                  name
                  FROM sys.triggers
                  WHERE name = 'trig_DEL_HFIT_PPTEligibility_Audit') 
    BEGIN
        DROP TRIGGER
             trig_DEL_HFIT_PPTEligibility_Audit;
    END;
GO

CREATE TRIGGER trig_DEL_HFIT_PPTEligibility_Audit ON HFIT_PPTEligibility
    AFTER DELETE
AS
BEGIN

    DECLARE @Svr nvarchar (100) = (SELECT
                                          @@Servername);
    DECLARE @Db nvarchar (100) = (SELECT
                                         DB_NAME ());
    DECLARE @CurrChg_Ver int = (SELECT
                                       MAX (CT.SYS_CHANGE_VERSION) 
                                       FROM CHANGETABLE (CHANGES HFIT_PPTEligibility, NULL) AS CT);

    DECLARE @Chg_Ver int = @CurrChg_Ver - 1;

    DECLARE @Ipaddr nvarchar (50) = (SELECT
                                            CAST (CONNECTIONPROPERTY ('client_net_address') AS nvarchar (50)));
    DECLARE @Userid nvarchar (50) = (SELECT
                                            USER_NAME ());
    DECLARE @Sysuser nvarchar (50) = (SELECT
                                             SYSTEM_USER);
    EXEC @Chg_Ver = proc_CT_getPrevVer 'HFIT_PPTEligibility';
    PRINT @Chg_Ver;

    DECLARE @Commit_Time datetime = (SELECT TOP 1
                                            tc.commit_time
                                            FROM
                                                CHANGETABLE (CHANGES HFIT_PPTEligibility, @Chg_Ver) c
                                                    JOIN sys.dm_tran_commit_table AS tc
                                                        ON c.sys_change_version = tc.commit_ts);

    SET @Chg_Ver = @Chg_Ver - 1;

    INSERT INTO STAGING_HFIT_PPTEligibility_Audit (
           PPTID
         , SVR
         , DBNAME
         , SYS_CHANGE_VERSION
         , SYS_CHANGE_OPERATION
         , SchemaName
         , SysUser
         , IPADDR
         , Processed
         , TBL
         , commit_time) 
    SELECT
           PPTID
         , @Svr
         , @Db
         , @Chg_Ver
         , 'D'
         , @Userid
         , @Sysuser
         , @Ipaddr
         , 0 AS Processed
         , 'HFIT_PPTEligibility'
         , @Commit_Time
           FROM DELETED;
END;

GO
PRINT 'EXECUTED TRIG_HFIT_PPTEligibility_Audit.SQL';
GO
