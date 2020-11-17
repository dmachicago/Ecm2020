
/***********************************************************
select * from information_schema.columns where table_name = 'BASE_HFit_HealthAssesmentUserModule'
***********************************************************/

-- use KenticoCMS_Datamart_2

PRINT 'Executing proc_HA_Update_HFit_HealthAssesmentUserModule.sql';
GO

IF EXISTS (SELECT name
             FROM sys.procedures
             WHERE name = 'proc_HA_Update_HFit_HealthAssesmentUserModule') 
    BEGIN
        DROP PROCEDURE proc_HA_Update_HFit_HealthAssesmentUserModule;
    END;
GO

/**********************************************************************************************************
Install DB: use KenticoCMS_Datamart_2
Author:	  W. Dale Miller
Date:	  03.23.2016
Contact:	  wdalemiller@gmail.com
Test Exec:  exec proc_MartTestTableDataPull 'KenticoCMS_1', 'BASE_HFit_HealthAssesmentUserModule', 2, 0
		  exec proc_MartTestTableDataPull 'KenticoCMS_2', 'BASE_HFit_HealthAssesmentUserModule', 2, 0
		  exec proc_MartTestTableDataPull 'KenticoCMS_3', 'BASE_HFit_HealthAssesmentUserModule', 2, 0
SYNC:	  proc_HFit_HealthAssesmentUserModule_KenticoCMS_1
		  proc_HFit_HealthAssesmentUserModule_KenticoCMS_2
		  proc_HFit_HealthAssesmentUserModule_KenticoCMS_3
Use:		  exec proc_HA_Update_HFit_HealthAssesmentUserModule
**********************************************************************************************************/

/****************************************************************************************************************************************************
 TARGET Columns:
select * from information_schema.columns where table_name = 'BASE_MART_EDW_HealthAssesment' and column_name like '%CodeName%'
select * from information_schema.columns where table_name = 'BASE_HFit_HealthAssesmentUserModule' and column_name like '%CodeName%'

BASE_HFit_HealthAssesmentUserModule.CodeName
BASE_HFit_HealthAssesmentUserModule.CT_PreWeightedScore
BASE_HFit_HealthAssesmentUserModule.HAModuleNodeGUID
BASE_HFit_HealthAssesmentUserModule.HAModuleScore
BASE_HFit_HealthAssesmentUserModule.ItemID
BASE_HFit_HealthAssesmentUserModule.LastModifiedDate
BASE_HFit_HealthAssesmentUserModule.PreWeightedScore
BASE_HFit_HealthAssesmentUserModule.SurrogateKey_HFit_HealthAssesmentUserModule
****************************************************************************************************************************************************/

CREATE PROCEDURE proc_HA_Update_HFit_HealthAssesmentUserModule
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
                     WHERE name = 'BASE_HFit_HealthAssesmentUserModule_HA_LastPullDate') 
        BEGIN
            -- select * from BASE_HFit_HealthAssesmentUserModule_HA_LastPullDate		  
            CREATE TABLE BASE_HFit_HealthAssesmentUserModule_HA_LastPullDate (LastPullDate datetime NOT NULL , 
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
                                 FROM BASE_HFit_HealthAssesmentUserModule) ;

            INSERT INTO BASE_HFit_HealthAssesmentUserModule_HA_LastPullDate (LastPullDate , 
                                                                               RowGUID) 
            VALUES (@lastupdate , 
                    @RowGUID) ;
            CREATE INDEX PI_BASE_HFit_HealthAssesmentUserModule_HA_LastPullDate ON BASE_HFit_HealthAssesmentUserModule_HA_LastPullDate (LastPullDate DESC) ;
            CREATE INDEX GUID_BASE_HFit_HealthAssesmentUserModule_HA_LastPullDate ON BASE_HFit_HealthAssesmentUserModule_HA_LastPullDate (RowGUID DESC) ;
        END;
    ELSE
        BEGIN

            UPDATE BASE_HFit_HealthAssesmentUserModule_HA_LastPullDate
              SET SuccessfulExecution = -1
              WHERE SuccessfulExecution = 0;
            SET @i = @@ROWCOUNT;
            PRINT CAST (@i AS nvarchar (50)) + ' : Incomplete rows flagged.';

            SET @lastupdate = (SELECT MAX (LastPullDate)
                                 FROM BASE_HFit_HealthAssesmentUserModule_HA_LastPullDate
                                 WHERE SuccessfulExecution = 1) ;

            IF @lastupdate IS NULL
                BEGIN
                    SET @lastupdate = (SELECT MAX (LastModifiedDate)
                                         FROM BASE_HFit_HealthAssesmentUserModule) ;
                END;

            IF @lastupdate IS NULL
                BEGIN
                    SET @lastupdate = GETDATE () - 2;
                END;

            INSERT INTO BASE_HFit_HealthAssesmentUserModule_HA_LastPullDate (LastPullDate , 
                                                                               RowGUID) 
            VALUES (@lastupdate , 
                    @RowGUID) ;
        END;

    --set @lastupdate = cast('03-20-2016' as datetime) ;
    SET @Msg = '@lastupdate: ' + CAST (@lastupdate AS nvarchar (50)) ;
    EXEC PrintImmediate @Msg;

    SET @ProcessCnt = (SELECT COUNT (1)
                         FROM
                              BASE_MART_EDW_HealthAssesment AS HA JOIN BASE_HFit_HealthAssesmentUserModule AS UsrMOD
                              ON HA.SurrogateKey_HFit_HealthAssesmentUserModule = UsrMOD.SurrogateKey_HFit_HealthAssesmentUserModule
                         WHERE UsrMOD.LastModifiedDate > @lastupdate
                           AND (UsrMOD.CT_CodeName = 1
	   OR UsrMOD.CT_HAModuleScore = 1
          OR UsrMOD.CT_PreWeightedScore = 1)) ;

    SET @Msg = 'Number of records to be processed: ' + CAST (@ProcessCnt AS nvarchar (50)) ;
    EXEC PrintImmediate @Msg;

/****************************************************************************************************************************************
    use KenticoCMS_Datamart_2
    select * from information_schema.columns where table_name = 'BASE_MART_EDW_HealthAssesment' and column_name like '%CodeName%'
    select * from information_schema.columns where table_name = 'BASE_HFit_HealthAssesmentUserModule' and column_name like '%CodeName%'
****************************************************************************************************************************************/

    UPDATE HA
      SET HA.UserModuleCodeName = CASE WHEN UsrMOD.CT_CodeName = 1
                                        THEN UsrMOD.CodeName
                                    END , 
          HA.HAModuleScore = CASE WHEN UsrMOD.CT_HAModuleScore = 1
                                             THEN UsrMOD.HAModuleScore
                                         END , 
          HA.ModulePreWeightedScore = CASE WHEN UsrMOD.CT_PreWeightedScore = 1
                                            THEN UsrMOD.PreWeightedScore
                                        END , 
          HA.LastModifiedDate = UsrMOD.LastModifiedDate , 
          HA.HAUserModule_LastModifiedDate = UsrMOD.LastModifiedDate
      FROM BASE_MART_EDW_HealthAssesment HA JOIN BASE_HFit_HealthAssesmentUserModule UsrMOD
           ON HA.SurrogateKey_HFit_HealthAssesmentUserModule = UsrMOD.SurrogateKey_HFit_HealthAssesmentUserModule
      WHERE UsrMOD.LastModifiedDate > @lastupdate
        AND (UsrMOD.CT_CodeName = 1
	   OR UsrMOD.CT_HAModuleScore = 1
          OR UsrMOD.CT_PreWeightedScore = 1);

    SET @recs = @@ROWCOUNT;

    SET @lastupdate = (SELECT MAX (LASTMODIFIEDDATE)
                         FROM BASE_HFit_HealthAssesmentUserModule) ;

    UPDATE BASE_HFit_HealthAssesmentUserModule_HA_LastPullDate
      SET LastPullDate = @lastupdate , 
          StartTime = @StartTime , 
          EndTime = GETDATE () , 
          ElapsedSeconds = DATEDIFF (second , @StartTime , GETDATE ()) , 
          SuccessfulExecution = 1;
    -- select * from BASE_HFit_HealthAssesmentUserModule_HA_LastPullDate 

    PRINT 'proc_HA_Update_HFit_HealthAssesmentUserModule RECS processed: ' + CAST (@recs AS nvarchar (50)) ;

END;

GO
PRINT 'Executed proc_HA_Update_HFit_HealthAssesmentUserModule.sql';
GO
