


/*************************************************************
select * from information_schema.columns 
where table_name = 'BASE_HFit_HealthAssesmentUserAnswers'
or column_name like '%AccountCD%'
or column_name like '%AccountID%'
or column_name like '%LastModifiedWHen%'
or column_name like '%LastModifiedDate%'
or column_name like '%LastModifiedDate%'
*************************************************************/

-- use KenticoCMS_Datamart_2

PRINT 'Executing proc_HA_Update_HFit_HealthAssesmentUserAnswers.sql';
GO

IF EXISTS (SELECT name
             FROM sys.procedures
             WHERE name = 'proc_HA_Update_HFit_HealthAssesmentUserAnswers') 
    BEGIN
        DROP PROCEDURE proc_HA_Update_HFit_HealthAssesmentUserAnswers;
    END;
GO

/************************************************************************************************************
Install DB: use KenticoCMS_Datamart_2
Author:	  W. Dale Miller
Date:	  03.21.2016
Contact:	  wdalemiller@gmail.com
Test Exec:  exec proc_MartTestTableDataPull 'KenticoCMS_1', 'BASE_HFit_HealthAssesmentUserAnswers', 2, 0
		  exec proc_MartTestTableDataPull 'KenticoCMS_2', 'BASE_HFit_HealthAssesmentUserAnswers', 2, 0
		  exec proc_MartTestTableDataPull 'KenticoCMS_3', 'BASE_HFit_HealthAssesmentUserAnswers', 2, 0
SYNC:	  proc_HFit_HealthAssesmentUserAnswers_KenticoCMS_1
		  proc_HFit_HealthAssesmentUserAnswers_KenticoCMS_2
		  proc_HFit_HealthAssesmentUserAnswers_KenticoCMS_3
Use:		  exec proc_HA_Update_HFit_HealthAssesmentUserAnswers
************************************************************************************************************/

/******************************************************************************************************************************************************
 TARGET Columns:
select * from information_schema.columns where table_name = 'BASE_MART_EDW_HealthAssesment' and column_name like '%CodeName%'
select * from information_schema.columns where table_name = 'BASE_HFit_HealthAssesmentUserAnswers' and column_name like '%CodeName%'

BASE_HFit_HealthAssesmentUserAnswers.CodeName
BASE_HFit_HealthAssesmentUserAnswers.CT_CodeName
BASE_HFit_HealthAssesmentUserAnswers.CT_ItemCreatedWhen
BASE_HFit_HealthAssesmentUserAnswers.CT_ItemModifiedWhen
BASE_HFit_HealthAssesmentUserAnswers.CT_UOMCode
BASE_HFit_HealthAssesmentUserAnswers.HAAnswerNodeGUID
BASE_HFit_HealthAssesmentUserAnswers.HAAnswerPoints
BASE_HFit_HealthAssesmentUserAnswers.HAAnswerValue
BASE_HFit_HealthAssesmentUserAnswers.ItemCreatedWhen
BASE_HFit_HealthAssesmentUserAnswers.ItemID
BASE_HFit_HealthAssesmentUserAnswers.ItemModifiedWhen
BASE_HFit_HealthAssesmentUserAnswers.LastModifiedDate
BASE_HFit_HealthAssesmentUserAnswers.SurrogateKey_HFit_HealthAssesmentUserAnswers
BASE_HFit_HealthAssesmentUserAnswers.UOMCode
******************************************************************************************************************************************************/

CREATE PROCEDURE proc_HA_Update_HFit_HealthAssesmentUserAnswers
AS
BEGIN

    DECLARE
          @RowGUID AS uniqueidentifier = NEWID () , 
          @lastupdate AS datetime = NULL , 
          @recs AS bigint = 0 , 
          @StartTime AS datetime = GETDATE () , 
          @EndTime AS datetime = GETDATE () , 
          @i int = 0 , 
          @ProcessCnt AS bigint = 0 , 
          @Msg AS nvarchar (max) = '';

    IF NOT EXISTS (SELECT name
                     FROM sys.tables
                     WHERE name = 'BASE_HFit_HealthAssesmentUserAnswers_HA_LastPullDate') 
        BEGIN
            -- select * from BASE_HFit_HealthAssesmentUserAnswers_HA_LastPullDate		  
            CREATE TABLE BASE_HFit_HealthAssesmentUserAnswers_HA_LastPullDate (LastPullDate datetime NOT NULL , 
                                                                                    CreateDate datetime NOT NULL
                                                                                                        DEFAULT GETDATE () , 
                                                                                    RowNumber int IDENTITY (1 , 1) 
                                                                                                  NOT NULL , 
                                                                                    StartTime datetime NULL , 
                                                                                    EndTime datetime NULL , 
                                                                                    ElapsedSeconds decimal (10 , 3) NULL , 
                                                                                    RowsAffected int NULL , 
                                                                                    RowGUID uniqueidentifier NOT NULL , 
                                                                                    SuccessfulExecution int NULL
                                                                                                            DEFAULT 0) ;

            SET @lastupdate = (SELECT MAX (LastModifiedDate)
                                 FROM BASE_HFit_HealthAssesmentUserAnswers) ;

            INSERT INTO BASE_HFit_HealthAssesmentUserAnswers_HA_LastPullDate (LastPullDate , 
                                                                                   RowGUID) 
            VALUES (@lastupdate , 
                    @RowGUID) ;
            CREATE INDEX PI_BASE_HFit_HealthAssesmentUserAnswers_HA_LastPullDate ON BASE_HFit_HealthAssesmentUserAnswers_HA_LastPullDate (LastPullDate DESC) ;
            CREATE INDEX GUID_BASE_HFit_HealthAssesmentUserAnswers_HA_LastPullDate ON BASE_HFit_HealthAssesmentUserAnswers_HA_LastPullDate (RowGUID DESC) ;
        END;
    ELSE
        BEGIN

            UPDATE BASE_HFit_HealthAssesmentUserAnswers_HA_LastPullDate
              SET SuccessfulExecution = -1
              WHERE SuccessfulExecution = 0;
            SET @i = @@ROWCOUNT;
            PRINT CAST (@i AS nvarchar (50)) + ' : Incomplete rows flagged.';

            SET @lastupdate = (SELECT MAX (LastPullDate)
                                 FROM BASE_HFit_HealthAssesmentUserAnswers_HA_LastPullDate
                                 WHERE SuccessfulExecution = 1) ;

            IF @lastupdate IS NULL
                BEGIN
                    SET @lastupdate = (SELECT MAX (LastModifiedDate)
                                         FROM BASE_HFit_HealthAssesmentUserAnswers) ;
                END;

            IF @lastupdate IS NULL
                BEGIN
                    SET @lastupdate = GETDATE () - 2;
                END;

            INSERT INTO BASE_HFit_HealthAssesmentUserAnswers_HA_LastPullDate (LastPullDate , 
                                                                                   RowGUID) 
            VALUES (@lastupdate , 
                    @RowGUID) ;
        END;

    --set @lastupdate = cast('03-20-2016' as datetime) ;
    SET @Msg = '@lastupdate: ' + CAST (@lastupdate AS nvarchar (50)) ;
    EXEC PrintImmediate @Msg;

    SET @ProcessCnt = (SELECT COUNT (1)
                         FROM
                              BASE_MART_EDW_HealthAssesment AS HA JOIN BASE_HFit_HealthAssesmentUserAnswers AS ANS
                              ON HA.SurrogateKey_HFit_HealthAssesmentUserAnswers = ANS.SurrogateKey_HFit_HealthAssesmentUserAnswers
                         WHERE ANS.LastModifiedDate > @lastupdate
                           AND ( CT_UOMCode = 1 or ANS.CT_UOMCode = 1  or ANS.CT_HAAnswerNodeGUID = 1  or ANS.CT_HAAnswerValue = 1 or ANS.CT_HAAnswerPoints = 1 or ANS.CT_HAAnswerPoints = 1 )) ;

    SET @Msg = 'Number of records to be processed: ' + CAST (@ProcessCnt AS nvarchar (50)) ;
    EXEC PrintImmediate @Msg;

    -- use KenticoCMS_Datamart_2
    -- select * from information_schema.columns where table_name = 'BASE_MART_EDW_HealthAssesment' and column_name like '%LastModifiedDate%'
    UPDATE HA
      SET HA.UserAnswerCodeName = CASE WHEN ANS.CT_CodeName = 1 THEN ANS.CodeName END , 
          HA.UOMCode = CASE WHEN ANS.CT_UOMCode = 1 THEN ANS.UOMCode END ,
		HA.HAAnswerNodeGUID = CASE WHEN ANS.CT_HAAnswerNodeGUID = 1 THEN ANS.HAAnswerNodeGUID END ,
		HA.HAAnswerValue = CASE WHEN ANS.CT_HAAnswerValue = 1 THEN ANS.HAAnswerValue END ,
		HA.HAAnswerPoints = CASE WHEN ANS.CT_HAAnswerPoints = 1 THEN ANS.HAAnswerPoints END ,
		HA.LastModifiedDate = ANS.LastModifiedDate , 
          HA.HAUserAnswers_LastModifiedDate = ANS.LastModifiedDate
      FROM BASE_MART_EDW_HealthAssesment HA JOIN BASE_HFit_HealthAssesmentUserAnswers ANS
           ON HA.SurrogateKey_HFit_HealthAssesmentUserAnswers = ANS.SurrogateKey_HFit_HealthAssesmentUserAnswers
      WHERE ANS.LastModifiedDate > @lastupdate
        AND (CT_UOMCode = 1 or ANS.CT_UOMCode = 1  or ANS.CT_HAAnswerNodeGUID = 1  or ANS.CT_HAAnswerValue = 1 or ANS.CT_HAAnswerPoints = 1 or ANS.CT_HAAnswerPoints = 1 );

    SET @recs = @@ROWCOUNT;

    SET @lastupdate = (SELECT MAX (LASTMODIFIEDDATE)
                         FROM BASE_HFit_HealthAssesmentUserAnswers) ;

    UPDATE BASE_HFit_HealthAssesmentUserAnswers_HA_LastPullDate
      SET LastPullDate = @lastupdate , 
          StartTime = @StartTime , 
          EndTime = GETDATE () , 
          ElapsedSeconds = DATEDIFF (second , @StartTime , GETDATE ()) , 
          SuccessfulExecution = 1;
    -- select * from BASE_HFit_HealthAssesmentUserAnswers_HA_LastPullDate 

    PRINT 'proc_HA_Update_HFit_HealthAssesmentUserAnswers RECS processed: ' + CAST (@recs AS nvarchar (50)) ;

END;

GO
PRINT 'Executed proc_HA_Update_HFit_HealthAssesmentUserAnswers.sql';
GO
