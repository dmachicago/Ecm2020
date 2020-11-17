
/**********************************************************
***************************************
select * from information_schema.columns 
where table_name = 'BASE_View_EDW_HealthAssesmentQuestions'
or column_name like '%AccountCD%'
or column_name like '%AccountID%'
or column_name like '%LastModifiedWHen%'
or column_name like '%LastModifiedDate%'
or column_name like '%LastModifiedDate%'
***************************************
**********************************************************/

-- use KenticoCMS_Datamart_2

PRINT 'Executing proc_HA_Update_View_EDW_HealthAssesmentQuestions.sql';
GO

IF EXISTS (SELECT name
             FROM sys.procedures
             WHERE name = 'proc_HA_Update_View_EDW_HealthAssesmentQuestions') 
    BEGIN
        DROP PROCEDURE proc_HA_Update_View_EDW_HealthAssesmentQuestions;
    END;
GO

/******************************************************************************************************************
********************************************************************************************************
Install DB: use KenticoCMS_Datamart_2
Author:	  W. Dale Miller
Date:	  03.21.2016
Contact:	  wdalemiller@gmail.com
Test Exec:  exec proc_MartTestTableDataPull 'KenticoCMS_1', 'BASE_HFit_HealthAssesmentMultipleChoiceQuestion', 2, 0
		  exec proc_MartTestTableDataPull 'KenticoCMS_2', 'BASE_HFit_HealthAssesmentMultipleChoiceQuestion', 2, 0
		  exec proc_MartTestTableDataPull 'KenticoCMS_3', 'BASE_HFit_HealthAssesmentMultipleChoiceQuestion', 2, 0
SYNC:	  proc_View_EDW_HealthAssesmentQuestions_KenticoCMS_1
		  proc_View_EDW_HealthAssesmentQuestions_KenticoCMS_2
		  proc_View_EDW_HealthAssesmentQuestions_KenticoCMS_3
Use:		  exec proc_HA_Update_View_EDW_HealthAssesmentQuestions
********************************************************************************************************
******************************************************************************************************************/

/********************************************************************************************************************************************************
***********************************************************************************
 TARGET Columns:
--select * from information_schema.columns where table_name = 'BASE_MART_EDW_HealthAssesment' and column_name like '%LastModifiedDate%'
--select * from information_schema.columns where table_name = 'BASE_HFit_HealthAssesmentMultipleChoiceQuestion' and column_name like '%LastModifiedDate%'

BASE_View_EDW_HealthAssesmentQuestions.CT_Title
BASE_View_EDW_HealthAssesmentQuestions.DocumentCulture_HAQuestionsView
BASE_View_EDW_HealthAssesmentQuestions.SurrogateKey_View_EDW_HealthAssesmentQuestions
BASE_View_EDW_HealthAssesmentQuestions.Title
***********************************************************************************
********************************************************************************************************************************************************/

CREATE PROCEDURE proc_HA_Update_View_EDW_HealthAssesmentQuestions
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
                     WHERE name = 'BASE_View_EDW_HealthAssesmentQuestions_HA_LastPullDate') 
        BEGIN
            -- select * from BASE_View_EDW_HealthAssesmentQuestions_HA_LastPullDate		  
            CREATE TABLE BASE_View_EDW_HealthAssesmentQuestions_HA_LastPullDate (LastPullDate datetime NOT NULL , 
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
                                 FROM BASE_View_EDW_HealthAssesmentQuestions) ;

            INSERT INTO BASE_View_EDW_HealthAssesmentQuestions_HA_LastPullDate (LastPullDate , 
                                                                                RowGUID) 
            VALUES (@lastupdate , 
                    @RowGUID) ;
            CREATE INDEX PI_BASE_View_EDW_HealthAssesmentQuestions_HA_LastPullDate ON BASE_View_EDW_HealthAssesmentQuestions_HA_LastPullDate (LastPullDate DESC) ;
            CREATE INDEX GUID_BASE_View_EDW_HealthAssesmentQuestions_HA_LastPullDate ON BASE_View_EDW_HealthAssesmentQuestions_HA_LastPullDate (RowGUID DESC) ;
        END;
    ELSE
        BEGIN

            UPDATE BASE_View_EDW_HealthAssesmentQuestions_HA_LastPullDate
              SET SuccessfulExecution = -1
              WHERE SuccessfulExecution = 0;
            SET @i = @@ROWCOUNT;
            PRINT CAST (@i AS nvarchar (50)) + ' : Incomplete rows flagged.';

            SET @lastupdate = (SELECT MAX (LastPullDate)
                                 FROM BASE_View_EDW_HealthAssesmentQuestions_HA_LastPullDate
                                 WHERE SuccessfulExecution = 1) ;

            IF @lastupdate IS NULL
                BEGIN
                    SET @lastupdate = (SELECT MAX (LastModifiedDate)
                                         FROM BASE_View_EDW_HealthAssesmentQuestions) ;
                END;

            IF @lastupdate IS NULL
                BEGIN
                    SET @lastupdate = GETDATE () - 2;
                END;

            INSERT INTO BASE_View_EDW_HealthAssesmentQuestions_HA_LastPullDate (LastPullDate , 
                                                                                RowGUID) 
            VALUES (@lastupdate , 
                    @RowGUID) ;
        END;

    --set @lastupdate = cast('03-20-2016' as datetime) ;
    SET @Msg = '@lastupdate: ' + CAST (@lastupdate AS nvarchar (50)) ;
    EXEC PrintImmediate @Msg;
    SET @ProcessCnt = (SELECT COUNT (1)
                         FROM
                              BASE_MART_EDW_HealthAssesment AS HA
                              JOIN BASE_View_EDW_HealthAssesmentQuestions AS QUES
                              ON HA.SurrogateKey_View_EDW_HealthAssesmentQuestions = QUES.SurrogateKey_View_EDW_HealthAssesmentQuestions
                         WHERE QUES.LastModifiedDate > @lastupdate
                           AND CT_Title = 1) ;

    SET @Msg = 'Number of records to be processed: ' + CAST (@ProcessCnt AS nvarchar (50)) ;
    EXEC PrintImmediate @Msg;
    --select * from information_schema.columns where table_name = 'BASE_MART_EDW_HealthAssesment' and column_name like '%Culture%'
    UPDATE HA
      SET HA.DocumentCulture_HAQuestionsView = CASE
                                                   WHEN QUES.CT_DocumentCulture = 1
                                                       THEN QUES.DocumentCulture
                                               END , 
          HA.Title = CASE
                         WHEN QUES.CT_Title = 1
                             THEN QUES.Title
                     END , 
          HA.LastModifiedDate = QUES.LastModifiedDate , 
          HA.HAUserQuestion_LastModifiedDate = QUES.LastModifiedDate
      FROM BASE_MART_EDW_HealthAssesment HA
           JOIN BASE_View_EDW_HealthAssesmentQuestions QUES
           ON HA.SurrogateKey_View_EDW_HealthAssesmentQuestions = QUES.SurrogateKey_View_EDW_HealthAssesmentQuestions
      WHERE QUES.LastModifiedDate > @lastupdate
        AND (CT_DocumentCulture = 1
          OR CT_Title = 1);

    SET @recs = @@ROWCOUNT;

    SET @lastupdate = (SELECT MAX (LASTMODIFIEDDATE)
                         FROM BASE_View_EDW_HealthAssesmentQuestions) ;

    UPDATE BASE_View_EDW_HealthAssesmentQuestions_HA_LastPullDate
      SET LastPullDate = @lastupdate , 
          StartTime = @StartTime , 
          EndTime = GETDATE () , 
          ElapsedSeconds = DATEDIFF (second , @StartTime , GETDATE ()) , 
          SuccessfulExecution = 1;

    PRINT 'proc_HA_Update_View_EDW_HealthAssesmentQuestions RECS processed: ' + CAST (@recs AS nvarchar (50)) ;

END;

GO
PRINT 'Executed proc_HA_Update_View_EDW_HealthAssesmentQuestions.sql';
GO
