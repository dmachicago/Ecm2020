-- select column_name from information_schema.columns where table_name = 'ELIGIBILITY_MPI_TEMP'
GO
PRINT 'Executing MERGE_ELIGIBILITY_MPI_TEMP.sql';
GO
IF EXISTS (SELECT
                  name
           FROM sys.procedures
           WHERE
                  name = 'MERGE_ELIGIBILITY_MPI_TEMP') 
    BEGIN
        DROP PROCEDURE
             MERGE_ELIGIBILITY_MPI_TEMP;
    END;
GO
-- select top 100 * from ELIGIBILITY_MPI_TEMP
-- select distinct RunID from VIPER_MPI
-- exec MERGE_ELIGIBILITY_MPI_TEMP '244643A9-830A-4CDE-B477-ECD4C8074C2E'
CREATE PROCEDURE MERGE_ELIGIBILITY_MPI_TEMP (
       @RunID AS NVARCHAR (75)) 
AS
BEGIN
    declare @NOW as datetime = getdate() ;

    MERGE into ELIGIBILITY_MPI_TEMP AS TGT
    USING VIPER_MPI AS SRC
    ON
           TGT.RunID = SRC.RunID AND
           TGT.RowNbr = SRC.ROWNBR AND
           TGT.RunID = @RunID
    WHEN NOT MATCHED BY TARGET
          THEN INSERT (
                      RUNID
                    ,RowNbr
                    ,ClientID
                    ,MPI
                    ,MATCH_METHOD_CODE
                    ,MEMBER_ID
                    ,HashKEY
                    ,LAST_NAME_SOURCE
                    ,LAST_NAME_A_STND
                    ,LAST_NAME_B_STND
                    ,FIRST_NAME_SOURCE
                    ,FIRST_NAME_A_STND
                    ,FIRST_NAME_B_STND
                    ,RELATIONSHIP_SOURCE
                    ,RELATIONSHIP_STANDARDIZED
                    ,DOB
                    ,GENDER_SOURCE
                    ,GENDER_STANDARDIZED
                    ,ADDRESS1_SOURCE
                    ,ADDRESS1_STANDARDIZED
                    ,ADDRESS2_SOURCE
                    ,ADDRESS2_STANDARDIZED
                    ,CITY_SOURCE
                    ,CITY_STANDARDIZED
                    ,STATE_SOURCE
                    ,STATE_STANDARDIZED
                    ,ZIP_SOURCE
                    ,ZIP_STANDARDIZED
                    ,ZIP_4_STANDARDIZED
                    ,SSN_SOURCE
                    ,SSN_STANDARDIZED
                    ,EMPLOYEE_SSN_SOURCE
                    ,EMPLOYEE_SSN_STANDARDIZED
                    ,HOME_PHONE_SOURCE
                    ,HOME_PHONE_STANDARDIZED
                    ,WORK_PHONE_SOURCE
                    ,WORK_PHONE_STANDARDIZED
                    ,EMAIL
                    ,HIRE_DATE
                    ,PERSON_TYPE
                    ,CreateDate
				,LastModifiedDate
                    ,RowHasBeenProcessed) VALUES (SRC.RUNID ,
          SRC.RowNbr ,
          SRC.ClientID ,
          SRC.MPI ,
          SRC.MATCH_METHOD_CODE ,
          SRC.MEMBER_ID ,
          SRC.HashKEY ,
          SRC.LAST_NAME_SOURCE ,
          SRC.LAST_NAME_A_STND ,
          SRC.LAST_NAME_B_STND ,
          SRC.FIRST_NAME_SOURCE ,
          SRC.FIRST_NAME_A_STND ,
          SRC.FIRST_NAME_B_STND ,
          SRC.RELATIONSHIP_SOURCE ,
          SRC.RELATIONSHIP_STANDARDIZED ,
          SRC.DOB ,
          SRC.GENDER_SOURCE ,
          SRC.GENDER_STANDARDIZED ,
          SRC.ADDRESS1_SOURCE ,
          SRC.ADDRESS1_STANDARDIZED ,
          SRC.ADDRESS2_SOURCE ,
          SRC.ADDRESS2_STANDARDIZED ,
          SRC.CITY_SOURCE ,
          SRC.CITY_STANDARDIZED ,
          SRC.STATE_SOURCE ,
          SRC.STATE_STANDARDIZED ,
          SRC.ZIP_SOURCE ,
          SRC.ZIP_STANDARDIZED ,
          SRC.ZIP_4_STANDARDIZED ,
          SRC.SSN_SOURCE ,
          SRC.SSN_STANDARDIZED ,
          SRC.EMPLOYEE_SSN_SOURCE ,
          SRC.EMPLOYEE_SSN_STANDARDIZED ,
          SRC.HOME_PHONE_SOURCE ,
          SRC.HOME_PHONE_STANDARDIZED ,
          SRC.WORK_PHONE_SOURCE ,
          SRC.WORK_PHONE_STANDARDIZED ,
          SRC.EMAIL ,
          SRC.HIRE_DATE ,
          SRC.PERSON_TYPE ,
          SRC.CreateDate ,
		@NOW,
          1) 
    WHEN MATCHED
          THEN UPDATE SET
                          TGT.RUNID = SRC.RUNID
                        ,TGT.RowNbr = SRC.RowNbr
                        ,TGT.ClientID = SRC.ClientID
                        ,TGT.MPI = SRC.MPI
                        ,TGT.MATCH_METHOD_CODE = SRC.MATCH_METHOD_CODE
                        ,TGT.MEMBER_ID = SRC.MEMBER_ID
                        ,TGT.HashKEY = SRC.HashKEY
                        ,TGT.LAST_NAME_SOURCE = SRC.LAST_NAME_SOURCE
                        ,TGT.LAST_NAME_A_STND = SRC.LAST_NAME_A_STND
                        ,TGT.LAST_NAME_B_STND = SRC.LAST_NAME_B_STND
                        ,TGT.FIRST_NAME_SOURCE = SRC.FIRST_NAME_SOURCE
                        ,TGT.FIRST_NAME_A_STND = SRC.FIRST_NAME_A_STND
                        ,TGT.FIRST_NAME_B_STND = SRC.FIRST_NAME_B_STND
                        ,TGT.RELATIONSHIP_SOURCE = SRC.RELATIONSHIP_SOURCE
                        ,TGT.RELATIONSHIP_STANDARDIZED = SRC.RELATIONSHIP_STANDARDIZED
                        ,TGT.DOB = SRC.DOB
                        ,TGT.GENDER_SOURCE = SRC.GENDER_SOURCE
                        ,TGT.GENDER_STANDARDIZED = SRC.GENDER_STANDARDIZED
                        ,TGT.ADDRESS1_SOURCE = SRC.ADDRESS1_SOURCE
                        ,TGT.ADDRESS1_STANDARDIZED = SRC.ADDRESS1_STANDARDIZED
                        ,TGT.ADDRESS2_SOURCE = SRC.ADDRESS2_SOURCE
                        ,TGT.ADDRESS2_STANDARDIZED = SRC.ADDRESS2_STANDARDIZED
                        ,TGT.CITY_SOURCE = SRC.CITY_SOURCE
                        ,TGT.CITY_STANDARDIZED = SRC.CITY_STANDARDIZED
                        ,TGT.STATE_SOURCE = SRC.STATE_SOURCE
                        ,TGT.STATE_STANDARDIZED = SRC.STATE_STANDARDIZED
                        ,TGT.ZIP_SOURCE = SRC.ZIP_SOURCE
                        ,TGT.ZIP_STANDARDIZED = SRC.ZIP_STANDARDIZED
                        ,TGT.ZIP_4_STANDARDIZED = SRC.ZIP_4_STANDARDIZED
                        ,TGT.SSN_SOURCE = SRC.SSN_SOURCE
                        ,TGT.SSN_STANDARDIZED = SRC.SSN_STANDARDIZED
                        ,TGT.EMPLOYEE_SSN_SOURCE = SRC.EMPLOYEE_SSN_SOURCE
                        ,TGT.EMPLOYEE_SSN_STANDARDIZED = SRC.EMPLOYEE_SSN_STANDARDIZED
                        ,TGT.HOME_PHONE_SOURCE = SRC.HOME_PHONE_SOURCE
                        ,TGT.HOME_PHONE_STANDARDIZED = SRC.HOME_PHONE_STANDARDIZED
                        ,TGT.WORK_PHONE_SOURCE = SRC.WORK_PHONE_SOURCE
                        ,TGT.WORK_PHONE_STANDARDIZED = SRC.WORK_PHONE_STANDARDIZED
                        ,TGT.EMAIL = SRC.EMAIL
                        --,TGT.HIRE_DATE = SRC.HIRE_DATE
                        ,TGT.PERSON_TYPE = SRC.PERSON_TYPE
                        ,TGT.CreateDate = SRC.CreateDate
				    ,TGT.LastModifiedDate = @NOW
                        ,TGT.RowHasBeenProcessed = 1
    WHEN NOT MATCHED BY SOURCE
          THEN UPDATE SET
					   TGT.LastModifiedDate = null,
                          TGT.RowHasBeenProcessed = -1;
    --OUTPUT
    --       $action
    --     ,inserted.*
    --     ,deleted.*;
END;
GO
PRINT 'Executed MERGE_ELIGIBILITY_MPI_TEMP.sql';
GO
