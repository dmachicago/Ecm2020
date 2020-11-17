USE [Viper];
GO

/****** Object:  StoredProcedure [dbo].[sp_InsertMpiFileDetails]    Script Date: 6/13/2016 3:10:26 PM ******/

SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO

if exists (select name from sys.procedures where name = 'sp_InsertMpiFileDetails')
    drop PROCEDURE dbo.sp_InsertMpiFileDetails 
go
create PROCEDURE dbo.sp_InsertMpiFileDetails (@RunID nvarchar(75), @VIPER_VirtualTable viper_mpi_type READONLY) 
AS
BEGIN

/*
Author:	  W. Dale Miller
Date:	  06.06.2016
Original:	  02.15.2012
Purpose:	  Use a SYBASE defined TYPE and allow a table to be 
		  updated to a ".net dataset" using a combination of 
		  SYBASE and C#.

		  The call is issued thru the control program, this time 
		  written in C# as:
			 SqlParameter param = cmd.Parameters.AddWithValue("@VIPER_VirtualTable", ViperDataTable);
			 AND ViperDataTable on the C# side is defined as var ViperDataTable = new DataTable("VIPER_MPI");

		  @VIPER_VirtualTable is a User Defined Table Type.	
		 
	select ',V.' + column_name + ' = T.' + column_name from information_schema.columns where table_name = 'VIPER_MPI'	  
	select ',' + column_name from information_schema.columns where table_name = 'VIPER_MPI'	  	  
	select ',V.' + column_name from information_schema.columns where table_name = 'VIPER_MPI'	  	  

	   truncate table TEMP_TRACK
	   select * from TEMP_TRACK
	   select * from VIPER_LOG
	   select count(*) from VIPER_MPI
		  
*/

    --Any ROWS that already exist, UPDATE them.

    if not exists (select name from sys.tables where name = 'TEMP_TRACK')
	   create table TEMP_TRACK (RunID nvarchar(75), CNT int, CreateDate datetime, Action char(1));
    if not exists (select name from sys.tables where name = 'VIPER_LOG')
	   create table VIPER_LOG (RunID nvarchar(75), LogEntry nvarchar(max), CreateDate datetime, RowNbr int identity (1,1) not null);

    DECLARE
      @TotMods int = 0;

    --set  @TotMods = (select count(*) FROM VIPER_MPI V
    --       JOIN @VIPER_VirtualTable T
    --       ON V.RUNID = T.RUNID
    --      AND V.ROWNBR = T.ROWNBR
    --      AND V.MODIFIEDDATE < T.MODIFIEDDATE) ;

    --insert into TEMP_TRACK (RunID , CNT , CreateDate , [Action] ) values (@RunID, @TotMods, getdate(), 'U') ;


    UPDATE V
      SET V.RUNID = T.RUNID , 
          V.HASHKEY = T.HASHKEY , 
          V.ROWNBR = T.ROWNBR , 
          V.FILEID = T.FILEID , 
          V.CLIENTID = T.CLIENTID , 
          V.FILEMASK = T.FILEMASK , 
          V.CREATEDATE = T.CREATEDATE , 
          V.MODIFIEDDATE = T.MODIFIEDDATE , 
          V.FILEDATE = T.FILEDATE , 
          V.[FILENAME] = T.[FILENAME] , 
          V.MPI = T.MPI , 
          V.MATCH_METHOD_CODE = T.MATCH_METHOD_CODE , 
          V.MEMBER_ID = T.MEMBER_ID , 
          V.FIRST_NAME_SOURCE = T.FIRST_NAME_SOURCE , 
          V.LAST_NAME_SOURCE = T.LAST_NAME_SOURCE , 
          V.MIDDLE_INIT = T.MIDDLE_INIT , 
          V.SSN_SOURCE = T.SSN_SOURCE , 
          V.SSN_STANDARDIZED = T.SSN_STANDARDIZED , 
          V.EMPLOYEE_SSN_SOURCE = T.EMPLOYEE_SSN_SOURCE , 
          V.EMPLOYEE_SSN_STANDARDIZED = T.EMPLOYEE_SSN_STANDARDIZED , 
          V.HIRE_DATE = T.HIRE_DATE , 
          V.DOB = T.DOB , 
          V.RELATIONSHIP_SOURCE = T.RELATIONSHIP_SOURCE , 
          V.RELATIONSHIP_STANDARDIZED = T.RELATIONSHIP_STANDARDIZED , 
          V.PERSON_TYPE = T.PERSON_TYPE , 
          V.GENDER_SOURCE = T.GENDER_SOURCE , 
          V.GENDER_STANDARDIZED = T.GENDER_STANDARDIZED , 
          V.FIRST_NAME_A_STND = T.FIRST_NAME_A_STND , 
          V.FIRST_NAME_B_STND = T.FIRST_NAME_B_STND , 
          V.LAST_NAME_A_STND = T.LAST_NAME_A_STND , 
          V.LAST_NAME_B_STND = T.LAST_NAME_B_STND , 
          V.ADDRESS1_SOURCE = T.ADDRESS1_SOURCE , 
          V.ADDRESS2_SOURCE = T.ADDRESS2_SOURCE , 
          V.CITY_SOURCE = T.CITY_SOURCE , 
          V.STATE_SOURCE = T.STATE_SOURCE , 
          V.ZIP_SOURCE = T.ZIP_SOURCE , 
          V.ADDRESS1_STANDARDIZED = T.ADDRESS1_STANDARDIZED , 
          V.ADDRESS2_STANDARDIZED = T.ADDRESS2_STANDARDIZED , 
          V.CITY_STANDARDIZED = T.CITY_STANDARDIZED , 
          V.STATE_STANDARDIZED = T.STATE_STANDARDIZED , 
          V.ZIP_STANDARDIZED = T.ZIP_STANDARDIZED , 
          V.ZIP_4_STANDARDIZED = T.ZIP_4_STANDARDIZED , 
          V.EMAIL = T.EMAIL , 
          V.HOME_PHONE_SOURCE = T.HOME_PHONE_SOURCE , 
          V.WORK_PHONE_SOURCE = T.WORK_PHONE_SOURCE , 
          V.HOME_PHONE_STANDARDIZED = T.HOME_PHONE_STANDARDIZED , 
          V.WORK_PHONE_STANDARDIZED = T.WORK_PHONE_STANDARDIZED , 
          V.PROCESSCNT = T.PROCESSCNT , 
          V.ROWVALIDATED = T.ROWVALIDATED
      FROM VIPER_MPI V
           JOIN @VIPER_VirtualTable T
           ON V.RUNID = T.RUNID
          AND V.ROWNBR = T.ROWNBR
          AND V.MODIFIEDDATE < T.MODIFIEDDATE;
    SET @TotMods = @@ROWCOUNT; 

    --INSERT INTO VIPER_LOG
    --SELECT top 2 @RunID, cast(V.ModifiedDate as nvarchar(50)) + ' : ' +  cast(T.ModifiedDate as nvarchar(50)), getdate()
    --FROM viper_mpi V
    -- JOIN @VIPER_VirtualTable T
    --    ON V.RUNID = T.RUNID
    --      AND V.ROWNBR = T.ROWNBR
    --      AND V.MODIFIEDDATE > T.MODIFIEDDATE;

    insert into TEMP_TRACK (RunID , CNT , CreateDate , [Action] ) values (@RunID, @TotMods, getdate(), 'U') ;

    --Any ROWS that DO NOT exist, ADD them.
    WITH cte (RUNID , 
              ROWNBR) 
        AS (SELECT RUNID , 
                   ROWNBR
              FROM @VIPER_VirtualTable
            EXCEPT
            SELECT RUNID , 
                   ROWNBR
              FROM VIPER_MPI) 
        INSERT INTO VIPER_MPI (RUNID , 
                               HASHKEY , 
                               ROWNBR , 
                               FILEID , 
                               CLIENTID , 
                               FILEMASK , 
                               CREATEDATE , 
                               MODIFIEDDATE , 
                               FILEDATE , 
                               [FILENAME], 
                               MPI , 
                               MATCH_METHOD_CODE , 
                               MEMBER_ID , 
                               FIRST_NAME_SOURCE , 
                               LAST_NAME_SOURCE , 
                               MIDDLE_INIT , 
                               SSN_SOURCE , 
                               SSN_STANDARDIZED , 
                               EMPLOYEE_SSN_SOURCE , 
                               EMPLOYEE_SSN_STANDARDIZED , 
                               HIRE_DATE , 
                               DOB , 
                               RELATIONSHIP_SOURCE , 
                               RELATIONSHIP_STANDARDIZED , 
                               PERSON_TYPE , 
                               GENDER_SOURCE , 
                               GENDER_STANDARDIZED , 
                               FIRST_NAME_A_STND , 
                               FIRST_NAME_B_STND , 
                               LAST_NAME_A_STND , 
                               LAST_NAME_B_STND , 
                               ADDRESS1_SOURCE , 
                               ADDRESS2_SOURCE , 
                               CITY_SOURCE , 
                               STATE_SOURCE , 
                               ZIP_SOURCE , 
                               ADDRESS1_STANDARDIZED , 
                               ADDRESS2_STANDARDIZED , 
                               CITY_STANDARDIZED , 
                               STATE_STANDARDIZED , 
                               ZIP_STANDARDIZED , 
                               ZIP_4_STANDARDIZED , 
                               EMAIL , 
                               HOME_PHONE_SOURCE , 
                               WORK_PHONE_SOURCE , 
                               HOME_PHONE_STANDARDIZED , 
                               WORK_PHONE_STANDARDIZED , 
                               PROCESSCNT , 
                               ROWVALIDATED) 
        SELECT V.RUNID , 
               V.HASHKEY , 
               V.ROWNBR , 
               V.FILEID , 
               V.CLIENTID , 
               V.FILEMASK , 
               GETDATE () , 
               GETDATE () , 
               V.FILEDATE , 
               V.[FILENAME] , 
               V.MPI , 
               V.MATCH_METHOD_CODE , 
               V.MEMBER_ID , 
               V.FIRST_NAME_SOURCE , 
               V.LAST_NAME_SOURCE , 
               V.MIDDLE_INIT , 
               V.SSN_SOURCE , 
               V.SSN_STANDARDIZED , 
               V.EMPLOYEE_SSN_SOURCE , 
               V.EMPLOYEE_SSN_STANDARDIZED , 
               V.HIRE_DATE , 
               V.DOB , 
               V.RELATIONSHIP_SOURCE , 
               V.RELATIONSHIP_STANDARDIZED , 
               V.PERSON_TYPE , 
               V.GENDER_SOURCE , 
               V.GENDER_STANDARDIZED , 
               V.FIRST_NAME_A_STND , 
               V.FIRST_NAME_B_STND , 
               V.LAST_NAME_A_STND , 
               V.LAST_NAME_B_STND , 
               V.ADDRESS1_SOURCE , 
               V.ADDRESS2_SOURCE , 
               V.CITY_SOURCE , 
               V.STATE_SOURCE , 
               V.ZIP_SOURCE , 
               V.ADDRESS1_STANDARDIZED , 
               V.ADDRESS2_STANDARDIZED , 
               V.CITY_STANDARDIZED , 
               V.STATE_STANDARDIZED , 
               V.ZIP_STANDARDIZED , 
               V.ZIP_4_STANDARDIZED , 
               V.EMAIL , 
               V.HOME_PHONE_SOURCE , 
               V.WORK_PHONE_SOURCE , 
               V.HOME_PHONE_STANDARDIZED , 
               V.WORK_PHONE_STANDARDIZED , 
               V.PROCESSCNT , 
               V.ROWVALIDATED
          FROM
               @VIPER_VirtualTable AS V
               JOIN CTE AS CT
               ON V.RUNID = CT.RUNID
              AND V.ROWNBR = CT.ROWNBR;
    SET @TotMods = @@ROWCOUNT;    
    insert into TEMP_TRACK (RunID , CNT , CreateDate , [Action] ) values (@RunID, @TotMods, getdate(), 'I') ;

    RETURN @TotMods;
END;

GO

/****** Object:  UserDefinedTableType [dbo].[VIPER_MPI_Type]    Script Date: 6/22/2016 6:36:06 PM ******/
DROP TYPE [dbo].[VIPER_MPI_Type]
GO

/****** Object:  UserDefinedTableType [dbo].[VIPER_MPI_Type]    Script Date: 6/22/2016 6:36:06 PM ******/
CREATE TYPE [dbo].[VIPER_MPI_Type] AS TABLE(
	[RUNID] [varchar](150) NULL,
	[HASHKEY] [varchar](150) NULL,
	[ROWNBR] [bigint] NULL,
	[FILEID] [int] NULL,
	[CLIENTID] [int] NULL,
	[FILEMASK] [varchar](150) NULL,
	[CREATEDATE] [datetime] NULL,
	[MODIFIEDDATE] [datetime] NULL,
	[FILEDATE] [datetime] NULL,
	[FILENAME] [varchar](150) NULL,
	[MPI] [int] NULL,
	[MATCH_METHOD_CODE] [varchar](30) NULL,
	[MEMBER_ID] [varchar](15) NULL,
	[FIRST_NAME_SOURCE] [varchar](50) NULL,
	[LAST_NAME_SOURCE] [varchar](50) NULL,
	[MIDDLE_INIT] [varchar](15) NULL,
	[SSN_SOURCE] [varchar](15) NULL,
	[SSN_STANDARDIZED] [varchar](15) NULL,
	[EMPLOYEE_SSN_SOURCE] [varchar](15) NULL,
	[EMPLOYEE_SSN_STANDARDIZED] [varchar](15) NULL,
	[HIRE_DATE] [datetime] NULL,
	[DOB] [datetime] NULL,
	[RELATIONSHIP_SOURCE] [varchar](50) NULL,
	[RELATIONSHIP_STANDARDIZED] [varchar](15) NULL,
	[PERSON_TYPE] [varchar](50) NULL,
	[GENDER_SOURCE] [varchar](15) NULL,
	[GENDER_STANDARDIZED] [varchar](15) NULL,
	[FIRST_NAME_A_STND] [varchar](50) NULL,
	[FIRST_NAME_B_STND] [varchar](50) NULL,
	[LAST_NAME_A_STND] [varchar](50) NULL,
	[LAST_NAME_B_STND] [varchar](50) NULL,
	[ADDRESS1_SOURCE] [varchar](150) NULL,
	[ADDRESS2_SOURCE] [varchar](150) NULL,
	[CITY_SOURCE] [varchar](50) NULL,
	[STATE_SOURCE] [varchar](20) NULL,
	[ZIP_SOURCE] [varchar](50) NULL,
	[ADDRESS1_STANDARDIZED] [varchar](150) NULL,
	[ADDRESS2_STANDARDIZED] [varchar](150) NULL,
	[CITY_STANDARDIZED] [varchar](50) NULL,
	[STATE_STANDARDIZED] [varchar](5) NULL,
	[ZIP_STANDARDIZED] [varchar](15) NULL,
	[ZIP_4_STANDARDIZED] [varchar](15) NULL,
	[EMAIL] [varchar](150) NULL,
	[HOME_PHONE_SOURCE] [varchar](15) NULL,
	[WORK_PHONE_SOURCE] [varchar](15) NULL,
	[HOME_PHONE_STANDARDIZED] [varchar](15) NULL,
	[WORK_PHONE_STANDARDIZED] [varchar](15) NULL,
	[PROCESSCNT] [int] NULL,
	[ROWVALIDATED] [bit] NULL
)
GO
