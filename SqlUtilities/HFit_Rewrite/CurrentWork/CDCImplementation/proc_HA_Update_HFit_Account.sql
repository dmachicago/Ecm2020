
/****************************************
select * from information_schema.columns 
where table_name = 'BASE_HFit_account'
or column_name like '%AccountCD%'
or column_name like '%AccountID%'
or column_name like '%LastModifiedWHen%'
or column_name like '%LastModifiedDate%'
or column_name like '%LastModifiedDate%'
****************************************/

-- use KenticoCMS_Datamart_2
GO
PRINT 'Executing proc_HA_Update_HFit_Account.sql';
GO

IF EXISTS (SELECT
                  name
           FROM sys.procedures
           WHERE
                  name = 'proc_HA_Update_HFit_Account') 
    BEGIN
        DROP PROCEDURE
             proc_HA_Update_HFit_Account;
    END;
GO

/********************************************
Install DB: use KenticoCMS_Datamart_2
Author:	  W. Dale Miller
Date:	  03.21.2016
Contact:	  wdalemiller@gmail.com
Test Exec:  exec proc_MartTestTableDataPull 'KenticoCMS_3', 'BASE_HFit_Account', 2, 0
SYNC:	  proc_BASE_HFIT_Account_KenticoCMS_1_ApplyCT
		  proc_BASE_HFIT_Account_KenticoCMS_2_ApplyCT
		  proc_BASE_HFIT_Account_KenticoCMS_3_ApplyCT
Use:		  exec proc_HA_Update_HFit_Account
********************************************/

CREATE PROCEDURE proc_HA_Update_HFit_Account
AS
BEGIN

    DECLARE
    @RowGUID AS UNIQUEIDENTIFIER = NEWID () 
  ,@lastupdate AS DATETIME = NULL
  ,@recs AS BIGINT = 0
  ,@StartTime AS DATETIME = GETDATE () 
  ,@EndTime AS DATETIME = GETDATE ()
  ,@i int = 0 , @ProcessCnt as bigint = 0 , @Msg as nvarchar(max) = '' ;

    IF NOT EXISTS (SELECT
                          name
                   FROM sys.tables
                   WHERE
                          name = 'BASE_HFit_Account_HA_LastPullDate') 
        BEGIN
            -- select * from BASE_HFit_Account_HA_LastPullDate		  
		  CREATE TABLE BASE_HFit_Account_HA_LastPullDate (
                         LastPullDate DATETIME NOT NULL
                       ,CreateDate DATETIME NOT NULL DEFAULT GETDATE () 
                       ,RowNumber INT IDENTITY (1 , 1) NOT NULL
                       ,StartTime DATETIME NULL
                       ,EndTime DATETIME NULL
                       ,ElapsedSeconds DECIMAL (10 , 3) NULL
                       ,RowsAffected INT NULL
                       ,RowGUID UNIQUEIDENTIFIER NOT NULL
				   ,SuccessfulExecution int null default 0) ;

            SET @lastupdate = (SELECT
                                      MAX (LastModifiedDate) 
                               FROM BASE_HFIT_Account) ;

            INSERT INTO BASE_HFit_Account_HA_LastPullDate (
                   LastPullDate
                 ,RowGUID) 
            VALUES (@lastupdate ,
                   @RowGUID) ;
            CREATE INDEX PI_BASE_HFit_Account_HA_LastPullDate ON BASE_HFit_Account_HA_LastPullDate (LastPullDate DESC) ;
            CREATE INDEX GUID_BASE_HFit_Account_HA_LastPullDate ON BASE_HFit_Account_HA_LastPullDate (RowGUID DESC) ;
        END;
    ELSE
        BEGIN
	   
		  update BASE_HFit_Account_HA_LastPullDate set SuccessfulExecution = -1 where SuccessfulExecution = 0 ;
		  set @i = @@ROWCOUNT ;
		  print cast(@i as nvarchar(50)) + ' : Incomplete rows flagged.';

            SET @lastupdate = (SELECT
                                      MAX (LastPullDate) 
                               FROM BASE_HFit_Account_HA_LastPullDate where SuccessfulExecution = 1) ;

            SET @lastupdate = (SELECT
                                      MAX (LastPullDate) 
                               FROM BASE_HFit_Account_HA_LastPullDate where SuccessfulExecution = 1) ;

		  if LastPullDate is null
			 SET @lastupdate = (SELECT
                                      MAX (LastModifiedDate) 
                               FROM BASE_HFit_Account) ;

		  if LastPullDate is null
			 SET @lastupdate = getdate() -2 ;

            INSERT INTO BASE_HFit_Account_HA_LastPullDate (
                   LastPullDate
                 ,RowGUID) 
            VALUES (@lastupdate ,
                   @RowGUID) ;
        END;

    
    --set @lastupdate = cast('03-20-2016' as datetime) ;
    set @ProcessCnt = (Select count(1) FROM BASE_MART_EDW_HealthAssesment HA
              JOIN BASE_HFit_account ACCT
              ON HA.SurrogateKey_HFit_Account = ACCT.SurrogateKey_HFit_Account
			 WHERE ACCT.LastModifiedDate > @lastupdate 
			 AND (CT_AccountCD = 1 OR CT_AccountID = 1 OR CT_AccountName = 1)
    )

    set @Msg = 'Number of records to be processed: ' + cast(@ProcessCnt as nvarchar(50)) ;
    exec PrintImmediate @Msg ;

    UPDATE HA
        SET
            HA.AccountName = CASE
                             WHEN ACCT.CT_AccountName = 1
                                 THEN ACCT.AccountName
                             END
          ,HA.AccountCD = CASE
                          WHEN ACCT.CT_AccountCD = 1
                              THEN ACCT.AccountCD
                          END
          ,HA.LastModifiedDate = ACCT.LastModifiedDate
          ,HA.ACCT_LastModifiedDate = ACCT.LastModifiedDate
    FROM BASE_MART_EDW_HealthAssesment HA
              JOIN BASE_HFit_account ACCT
              ON
           HA.SurrogateKey_HFit_Account = ACCT.SurrogateKey_HFit_Account
    WHERE
           ACCT.LastModifiedDate > @lastupdate AND (
                                                   CT_AccountCD = 1 OR CT_AccountID = 1 OR
           CT_AccountName = 1);

    SET @recs = @@ROWCOUNT;

    SET @lastupdate = (SELECT
                              MAX (LASTMODIFIEDDATE) 
                       FROM BASE_HFIT_Account) ;

    UPDATE BASE_HFit_Account_HA_LastPullDate
        SET
            LastPullDate = @lastupdate
          ,StartTime = @StartTime
          ,EndTime = GETDATE () 
          ,ElapsedSeconds = DATEDIFF (second , @StartTime , GETDATE ())
		,SuccessfulExecution = 1 ;

    PRINT 'proc_HA_Update_HFit_Account RECS processed: ' + CAST (@recs AS NVARCHAR (50)) ;

END;

GO
PRINT 'Executed proc_HA_Update_HFit_Account.sql';
GO
