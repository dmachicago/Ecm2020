
/****************************************
select * from information_schema.columns 
where table_name = 'BASE_CMS_Site'
or column_name like '%AccountCD%'
or column_name like '%AccountID%'
or column_name like '%LastModifiedWHen%'
or column_name like '%LastModifiedDate%'
or column_name like '%LastModifiedDate%'
****************************************/

-- use KenticoCMS_Datamart_2

PRINT 'Executing proc_HA_Update_CMS_Site.sql';
GO

IF EXISTS (SELECT
                  name
           FROM sys.procedures
           WHERE
                  name = 'proc_HA_Update_CMS_Site') 
    BEGIN
        DROP PROCEDURE
             proc_HA_Update_CMS_Site;
    END;
GO

/********************************************************************************
Install DB: use KenticoCMS_Datamart_2
Author:	  W. Dale Miller
Date:	  03.21.2016
Contact:	  wdalemiller@gmail.com
Test Exec:  exec proc_MartTestTableDataPull 'KenticoCMS_3', 'BASE_CMS_Site', 2, 0
SYNC:	  proc_BASE_CMS_Site_KenticoCMS_1_ApplyCT
		  proc_BASE_CMS_Site_KenticoCMS_2_ApplyCT
		  proc_BASE_CMS_Site_KenticoCMS_3_ApplyCT
Use:		  exec proc_HA_Update_CMS_Site
********************************************************************************/

CREATE PROCEDURE proc_HA_Update_CMS_Site
AS
BEGIN

    DECLARE
    @RowGUID AS UNIQUEIDENTIFIER = NEWID () 
  , @lastupdate AS DATETIME = NULL
  , @recs AS BIGINT = 0
  , @StartTime AS DATETIME = GETDATE () 
  , @EndTime AS DATETIME = GETDATE () 
  , @i INT = 0
  , @ProcessCnt AS BIGINT = 0
  , @Msg AS NVARCHAR (MAX) = '';

    IF NOT EXISTS (SELECT
                          name
                   FROM sys.tables
                   WHERE
                          name = 'BASE_CMS_Site_HA_LastPullDate') 
        BEGIN
            -- select * from BASE_CMS_Site_HA_LastPullDate		  
            CREATE TABLE BASE_CMS_Site_HA_LastPullDate (
                         LastPullDate DATETIME NOT NULL
                       , CreateDate DATETIME NOT NULL
                                             DEFAULT GETDATE () 
                       , RowNumber INT IDENTITY (1 , 1) 
                                       NOT NULL
                       , StartTime DATETIME NULL
                       , EndTime DATETIME NULL
                       , ElapsedSeconds DECIMAL (10 , 3) NULL
                       , RowsAffected INT NULL
                       , RowGUID UNIQUEIDENTIFIER NOT NULL
                       , SuccessfulExecution INT NULL
                                                 DEFAULT 0) ;

            SET @lastupdate = (SELECT
                                      MAX (LastModifiedDate) 
                               FROM BASE_CMS_Site) ;

            INSERT INTO BASE_CMS_Site_HA_LastPullDate (
                   LastPullDate
                 , RowGUID) 
            VALUES (@lastupdate ,
                   @RowGUID) ;
            CREATE INDEX PI_BASE_CMS_Site_HA_LastPullDate ON BASE_CMS_Site_HA_LastPullDate (LastPullDate DESC) ;
            CREATE INDEX GUID_BASE_CMS_Site_HA_LastPullDate ON BASE_CMS_Site_HA_LastPullDate (RowGUID DESC) ;
        END;
    ELSE
        BEGIN

            UPDATE BASE_CMS_Site_HA_LastPullDate
                SET
                    SuccessfulExecution = -1
            WHERE
                   SuccessfulExecution = 0;
            SET @i = @@ROWCOUNT;
            PRINT CAST (@i AS NVARCHAR (50)) + ' : Incomplete rows flagged.';

            SET @lastupdate = (SELECT
                                      MAX (LastPullDate) 
                               FROM BASE_CMS_Site_HA_LastPullDate
                               WHERE
                                      SuccessfulExecution = 1) ;

            IF @lastupdate IS NULL
                BEGIN
                    SET @lastupdate = (SELECT
                                              MAX (LastModifiedDate) 
                                       FROM BASE_CMS_Site) 
                END;

            IF @lastupdate IS NULL
                BEGIN
                    SET @lastupdate = GETDATE () - 2
                END;

            INSERT INTO BASE_CMS_Site_HA_LastPullDate (
                   LastPullDate
                 , RowGUID) 
            VALUES (@lastupdate ,
                   @RowGUID) ;
        END;

    --set @lastupdate = cast('03-20-2016' as datetime) ;
    SET @Msg = '@lastupdate: ' + CAST (@lastupdate AS NVARCHAR (50)) ;
    EXEC PrintImmediate @Msg;
    SET @ProcessCnt = (SELECT
                              COUNT (1) 
                       FROM
                            BASE_MART_EDW_HealthAssesment AS HA
                                 JOIN BASE_CMS_Site AS ACCT
                                 ON
                              HA.SurrogateKey_CMS_Site = ACCT.SurrogateKey_CMS_Site
                       WHERE
                              ACCT.LastModifiedDate > @lastupdate AND CT_SiteGUID = 1
                      );

    SET @Msg = 'Number of records to be processed: ' + CAST (@ProcessCnt AS NVARCHAR (50)) ;
    EXEC PrintImmediate @Msg;

    UPDATE HA
        SET
            HA.SiteGUID = CASE
                          WHEN
           ACCT.CT_SiteGUID = 1
                              THEN ACCT.SiteGUID
                          END
          ,HA.LastModifiedDate = ACCT.LastModifiedDate
          ,HA.UserSite_LastModifiedDate = ACCT.LastModifiedDate
    FROM BASE_MART_EDW_HealthAssesment HA
              JOIN BASE_CMS_Site ACCT
              ON
           HA.SurrogateKey_CMS_Site = ACCT.SurrogateKey_CMS_Site
    WHERE
           ACCT.LastModifiedDate > @lastupdate AND CT_SiteGUID = 1;

    SET @recs = @@ROWCOUNT;

    SET @lastupdate = (SELECT
                              MAX (LASTMODIFIEDDATE) 
                       FROM BASE_CMS_Site) ;

    UPDATE BASE_CMS_Site_HA_LastPullDate
        SET
            LastPullDate = @lastupdate
          ,StartTime = @StartTime
          ,EndTime = GETDATE () 
          ,ElapsedSeconds = DATEDIFF (second , @StartTime , GETDATE ()) 
          ,SuccessfulExecution = 1;

    PRINT 'proc_HA_Update_CMS_Site RECS processed: ' + CAST (@recs AS NVARCHAR (50)) ;

END;

GO
PRINT 'Executed proc_HA_Update_CMS_Site.sql';
GO
