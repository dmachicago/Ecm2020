USE [Viper];
GO

-- truncate table VIPER_MPI
/******************************************************************************/

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

SET ANSI_PADDING ON;
GO

CREATE TABLE dbo.VIPER_MPI (
             RUNID VARCHAR (150) NULL
           , HASHKEY VARCHAR (150) NULL
           , ROWNBR BIGINT NULL
           , FILEID INT NULL
           , CLIENTID INT NULL
           , FILEMASK VARCHAR (150) NULL
           , CREATEDATE DATETIME NULL
           , MODIFIEDDATE DATETIME NULL
           , FILEDATE DATETIME NULL
           , [FILENAME] VARCHAR (150) NULL
           , MPI INT NULL
           , MATCH_METHOD_CODE VARCHAR (30) NULL
           , MEMBER_ID VARCHAR (15) NULL
           , FIRST_NAME_SOURCE VARCHAR (50) NULL
           , LAST_NAME_SOURCE VARCHAR (50) NULL
           , MIDDLE_INIT VARCHAR (15) NULL
           , SSN_SOURCE VARCHAR (15) NULL
           , SSN_STANDARDIZED VARCHAR (15) NULL
           , EMPLOYEE_SSN_SOURCE VARCHAR (15) NULL
           , EMPLOYEE_SSN_STANDARDIZED VARCHAR (15) NULL
           , HIRE_DATE DATETIME NULL
           , DOB DATETIME NULL
           , RELATIONSHIP_SOURCE VARCHAR (50) NULL
           , RELATIONSHIP_STANDARDIZED VARCHAR (15) NULL
           , PERSON_TYPE VARCHAR (50) NULL
           , GENDER_SOURCE VARCHAR (15) NULL
           , GENDER_STANDARDIZED VARCHAR (15) NULL
           , FIRST_NAME_A_STND VARCHAR (50) NULL
           , FIRST_NAME_B_STND VARCHAR (50) NULL
           , LAST_NAME_A_STND VARCHAR (50) NULL
           , LAST_NAME_B_STND VARCHAR (50) NULL
           , ADDRESS1_SOURCE VARCHAR (150) NULL
           , ADDRESS2_SOURCE VARCHAR (150) NULL
           , CITY_SOURCE VARCHAR (50) NULL
           , STATE_SOURCE VARCHAR (20) NULL
           , ZIP_SOURCE VARCHAR (50) NULL
           , ADDRESS1_STANDARDIZED VARCHAR (150) NULL
           , ADDRESS2_STANDARDIZED VARCHAR (150) NULL
           , CITY_STANDARDIZED VARCHAR (50) NULL
           , STATE_STANDARDIZED VARCHAR (5) NULL
           , ZIP_STANDARDIZED VARCHAR (15) NULL
           , ZIP_4_STANDARDIZED VARCHAR (15) NULL
           , EMAIL VARCHAR (150) NULL
           , HOME_PHONE_SOURCE VARCHAR (15) NULL
           , WORK_PHONE_SOURCE VARCHAR (15) NULL
           , HOME_PHONE_STANDARDIZED VARCHAR (15) NULL
           , WORK_PHONE_STANDARDIZED VARCHAR (15) NULL) 
ON [PRIMARY];

GO

SET ANSI_PADDING OFF;

GO

CREATE TYPE VIPER_MPI_Type AS TABLE (
                                    RUNID VARCHAR (150) NULL
                                  , HASHKEY VARCHAR (150) NULL
                                  , ROWNBR BIGINT NULL
                                  , FILEID INT NULL
                                  , CLIENTID INT NULL
                                  , FILEMASK VARCHAR (150) NULL
                                  , CREATEDATE DATETIME NULL
                                  , MODIFIEDDATE DATETIME NULL
                                  , FILEDATE DATETIME NULL
                                  , [FILENAME] VARCHAR (150) NULL
                                  , MPI INT NULL
                                  , MATCH_METHOD_CODE VARCHAR (30) NULL
                                  , MEMBER_ID VARCHAR (15) NULL
                                  , FIRST_NAME_SOURCE VARCHAR (50) NULL
                                  , LAST_NAME_SOURCE VARCHAR (50) NULL
                                  , MIDDLE_INIT VARCHAR (15) NULL
                                  , SSN_SOURCE VARCHAR (15) NULL
                                  , SSN_STANDARDIZED VARCHAR (15) NULL
                                  , EMPLOYEE_SSN_SOURCE VARCHAR (15) NULL
                                  , EMPLOYEE_SSN_STANDARDIZED VARCHAR (15) NULL
                                  , HIRE_DATE DATETIME NULL
                                  , DOB DATETIME NULL
                                  , RELATIONSHIP_SOURCE VARCHAR (50) NULL
                                  , RELATIONSHIP_STANDARDIZED VARCHAR (15) NULL
                                  , PERSON_TYPE VARCHAR (50) NULL
                                  , GENDER_SOURCE VARCHAR (15) NULL
                                  , GENDER_STANDARDIZED VARCHAR (15) NULL
                                  , FIRST_NAME_A_STND VARCHAR (50) NULL
                                  , FIRST_NAME_B_STND VARCHAR (50) NULL
                                  , LAST_NAME_A_STND VARCHAR (50) NULL
                                  , LAST_NAME_B_STND VARCHAR (50) NULL
                                  , ADDRESS1_SOURCE VARCHAR (150) NULL
                                  , ADDRESS2_SOURCE VARCHAR (150) NULL
                                  , CITY_SOURCE VARCHAR (50) NULL
                                  , STATE_SOURCE VARCHAR (20) NULL
                                  , ZIP_SOURCE VARCHAR (50) NULL
                                  , ADDRESS1_STANDARDIZED VARCHAR (150) NULL
                                  , ADDRESS2_STANDARDIZED VARCHAR (150) NULL
                                  , CITY_STANDARDIZED VARCHAR (50) NULL
                                  , STATE_STANDARDIZED VARCHAR (5) NULL
                                  , ZIP_STANDARDIZED VARCHAR (15) NULL
                                  , ZIP_4_STANDARDIZED VARCHAR (15) NULL
                                  , EMAIL VARCHAR (150) NULL
                                  , HOME_PHONE_SOURCE VARCHAR (15) NULL
                                  , WORK_PHONE_SOURCE VARCHAR (15) NULL
                                  , HOME_PHONE_STANDARDIZED VARCHAR (15) NULL
                                  , WORK_PHONE_STANDARDIZED VARCHAR (15) NULL) ;

GO
IF EXISTS (SELECT
                  name
           FROM sys.procedures
           WHERE
                  name = 'sp_InsertMpiFileDetails') 
    BEGIN
        DROP PROCEDURE
             sp_InsertMpiFileDetails
    END;
GO

CREATE PROCEDURE sp_InsertMpiFileDetails (
       @VIPER_VirtualTable VIPER_MPI_TYPE READONLY) 
AS
BEGIN

    UPDATE V
        SET
            V.RUNID = T.RUNID
          ,V.HASHKEY = T.HASHKEY
          ,V.ROWNBR = T.ROWNBR
          ,V.FILEID = T.FILEID
          ,V.CLIENTID = T.CLIENTID
          ,V.FILEMASK = T.FILEMASK
          ,V.CREATEDATE = T.CREATEDATE
          ,V.MODIFIEDDATE = T.MODIFIEDDATE
          ,V.FILEDATE = T.FILEDATE
          ,V.[FILENAME] = T.[FILENAME]
          ,V.MPI = T.MPI
          ,V.MATCH_METHOD_CODE = T.MATCH_METHOD_CODE
          ,V.MEMBER_ID = T.MEMBER_ID
          ,V.FIRST_NAME_SOURCE = T.FIRST_NAME_SOURCE
          ,V.LAST_NAME_SOURCE = T.LAST_NAME_SOURCE
          ,V.MIDDLE_INIT = T.MIDDLE_INIT
          ,V.SSN_SOURCE = T.SSN_SOURCE
          ,V.SSN_STANDARDIZED = T.SSN_STANDARDIZED
          ,V.EMPLOYEE_SSN_SOURCE = T.EMPLOYEE_SSN_SOURCE
          ,V.EMPLOYEE_SSN_STANDARDIZED = T.EMPLOYEE_SSN_STANDARDIZED
          ,V.HIRE_DATE = T.HIRE_DATE
          ,V.DOB = T.DOB
          ,V.RELATIONSHIP_SOURCE = T.RELATIONSHIP_SOURCE
          ,V.RELATIONSHIP_STANDARDIZED = T.RELATIONSHIP_STANDARDIZED
          ,V.PERSON_TYPE = T.PERSON_TYPE
          ,V.GENDER_SOURCE = T.GENDER_SOURCE
          ,V.GENDER_STANDARDIZED = T.GENDER_STANDARDIZED
          ,V.FIRST_NAME_A_STND = T.FIRST_NAME_A_STND
          ,V.FIRST_NAME_B_STND = T.FIRST_NAME_B_STND
          ,V.LAST_NAME_A_STND = T.LAST_NAME_A_STND
          ,V.LAST_NAME_B_STND = T.LAST_NAME_B_STND
          ,V.ADDRESS1_SOURCE = T.ADDRESS1_SOURCE
          ,V.ADDRESS2_SOURCE = T.ADDRESS2_SOURCE
          ,V.CITY_SOURCE = T.CITY_SOURCE
          ,V.STATE_SOURCE = T.STATE_SOURCE
          ,V.ZIP_SOURCE = T.ZIP_SOURCE
          ,V.ADDRESS1_STANDARDIZED = T.ADDRESS1_STANDARDIZED
          ,V.ADDRESS2_STANDARDIZED = T.ADDRESS2_STANDARDIZED
          ,V.CITY_STANDARDIZED = T.CITY_STANDARDIZED
          ,V.STATE_STANDARDIZED = T.STATE_STANDARDIZED
          ,V.ZIP_STANDARDIZED = T.ZIP_STANDARDIZED
          ,V.ZIP_4_STANDARDIZED = T.ZIP_4_STANDARDIZED
          ,V.EMAIL = T.EMAIL
          ,V.HOME_PHONE_SOURCE = T.HOME_PHONE_SOURCE
          ,V.WORK_PHONE_SOURCE = T.WORK_PHONE_SOURCE
          ,V.HOME_PHONE_STANDARDIZED = T.HOME_PHONE_STANDARDIZED
          ,V.WORK_PHONE_STANDARDIZED = T.WORK_PHONE_STANDARDIZED
    FROM
    VIPER_MPI V
         JOIN
         @VIPER_VirtualTable T
         ON
           V.RUNID = T.RUNID AND
           V.ROWNBR = T.ROWNBR;

    WITH cte (
         RUNID
       , ROWNBR) 
        AS (
        SELECT
               RUNID
             , ROWNBR
        FROM @VIPER_VirtualTable
        EXCEPT
        SELECT
               RUNID
             , ROWNBR
        FROM VIPER_MPI
        ) 
        INSERT INTO VIPER_MPI (
               RUNID
             , HASHKEY
             , ROWNBR
             , FILEID
             , CLIENTID
             , FILEMASK
             , CREATEDATE
             , MODIFIEDDATE
             , FILEDATE
             , [FILENAME]
             , MPI
             , MATCH_METHOD_CODE
             , MEMBER_ID
             , FIRST_NAME_SOURCE
             , LAST_NAME_SOURCE
             , MIDDLE_INIT
             , SSN_SOURCE
             , SSN_STANDARDIZED
             , EMPLOYEE_SSN_SOURCE
             , EMPLOYEE_SSN_STANDARDIZED
             , HIRE_DATE
             , DOB
             , RELATIONSHIP_SOURCE
             , RELATIONSHIP_STANDARDIZED
             , PERSON_TYPE
             , GENDER_SOURCE
             , GENDER_STANDARDIZED
             , FIRST_NAME_A_STND
             , FIRST_NAME_B_STND
             , LAST_NAME_A_STND
             , LAST_NAME_B_STND
             , ADDRESS1_SOURCE
             , ADDRESS2_SOURCE
             , CITY_SOURCE
             , STATE_SOURCE
             , ZIP_SOURCE
             , ADDRESS1_STANDARDIZED
             , ADDRESS2_STANDARDIZED
             , CITY_STANDARDIZED
             , STATE_STANDARDIZED
             , ZIP_STANDARDIZED
             , ZIP_4_STANDARDIZED
             , EMAIL
             , HOME_PHONE_SOURCE
             , WORK_PHONE_SOURCE
             , HOME_PHONE_STANDARDIZED
             , WORK_PHONE_STANDARDIZED) 
        SELECT
               V.RUNID
             , V.HASHKEY
             , V.ROWNBR
             , V.FILEID
             , V.CLIENTID
             , V.FILEMASK
             , V.CREATEDATE
             , V.MODIFIEDDATE
             , V.FILEDATE
             , V.[FILENAME]
             , V.MPI
             , V.MATCH_METHOD_CODE
             , V.MEMBER_ID
             , V.FIRST_NAME_SOURCE
             , V.LAST_NAME_SOURCE
             , V.MIDDLE_INIT
             , V.SSN_SOURCE
             , V.SSN_STANDARDIZED
             , V.EMPLOYEE_SSN_SOURCE
             , V.EMPLOYEE_SSN_STANDARDIZED
             , V.HIRE_DATE
             , V.DOB
             , V.RELATIONSHIP_SOURCE
             , V.RELATIONSHIP_STANDARDIZED
             , V.PERSON_TYPE
             , V.GENDER_SOURCE
             , V.GENDER_STANDARDIZED
             , V.FIRST_NAME_A_STND
             , V.FIRST_NAME_B_STND
             , V.LAST_NAME_A_STND
             , V.LAST_NAME_B_STND
             , V.ADDRESS1_SOURCE
             , V.ADDRESS2_SOURCE
             , V.CITY_SOURCE
             , V.STATE_SOURCE
             , V.ZIP_SOURCE
             , V.ADDRESS1_STANDARDIZED
             , V.ADDRESS2_STANDARDIZED
             , V.CITY_STANDARDIZED
             , V.STATE_STANDARDIZED
             , V.ZIP_STANDARDIZED
             , V.ZIP_4_STANDARDIZED
             , V.EMAIL
             , V.HOME_PHONE_SOURCE
             , V.WORK_PHONE_SOURCE
             , V.HOME_PHONE_STANDARDIZED
             , V.WORK_PHONE_STANDARDIZED
        FROM
             @VIPER_VirtualTable AS V
                  JOIN CTE AS CT
                  ON
               V.RUNID = CT.RUNID AND
               V.ROWNBR = CT.ROWNBR;
END;

GO