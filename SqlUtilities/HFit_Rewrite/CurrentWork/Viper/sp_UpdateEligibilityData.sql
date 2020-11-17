USE [Viper];
GO

/********************************************************************************************************
***** Object:  StoredProcedure [dbo].[sp_InsertMpiFileDetails]    Script Date: 6/13/2016 3:10:26 PM *****
********************************************************************************************************/
SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO

CREATE PROCEDURE dbo.sp_UpdateEligibilityData (
       @ELIGIBILITY_VirtualTable ELIGIBILITY_TYPE READONLY) 
AS
BEGIN

/***************************************************************************************************
Author:	  W. Dale Miller
Date:	  06.06.2016
Original:	  02.15.2012
Purpose:	  Use a defined TABLE TYPE and allow a table to be 
		  updated to a ".net dataset" using a combination of 
		  SYBASE and C#.

		  The call is issued thru the control program, this time 
		  written in C# as:
			 SqlParameter param = cmd.Parameters.AddWithValue("@ELIGIBILITY_VirtualTable", ViperDataTable);
			 AND ViperDataTable on the C# side is defined as var ViperDataTable = new DataTable("VIPER_MPI");

		  @ELIGIBILITY_VirtualTable is a User Defined Table Type.		  
***************************************************************************************************/

    --Any ROWS that already exist, UPDATE them.
    UPDATE V
        SET
          V.EligID = T.EligID
          ,V.ClientID = T.ClientID
          ,V.Elig_GUID = T.Elig_GUID
          ,V.MPI = T.MPI
          ,V.PRIMARY_MPI = T.PRIMARY_MPI
          ,V.MATCH_METHOD_CODE = T.MATCH_METHOD_CODE
          ,V.IDCARD = T.IDCARD
          ,V.MEMBER_ID = T.MEMBER_ID
          ,V.IMPORT_DATE = T.IMPORT_DATE
          ,V.FILE_DATE = T.FILE_DATE
          ,V.LAST_DELTA = T.LAST_DELTA
          ,V.ORIGINALLOADDATE = T.ORIGINALLOADDATE
          ,V.ISACTIVE = T.ISACTIVE
          ,V.HASHKEY = T.HASHKEY
          ,V.HASHDATA = T.HASHDATA
          ,V.LAST_NAME_SOURCE = T.LAST_NAME_SOURCE
          ,V.LAST_NAME_A_STND = T.LAST_NAME_A_STND
          ,V.LAST_NAME_B_STND = T.LAST_NAME_B_STND
          ,V.NAME_SUFFIX_STND = T.NAME_SUFFIX_STND
          ,V.FIRST_NAME_SOURCE = T.FIRST_NAME_SOURCE
          ,V.FIRST_NAME_A_STND = T.FIRST_NAME_A_STND
          ,V.FIRST_NAME_B_STND = T.FIRST_NAME_B_STND
          ,V.MIDDLE_INITIAL = T.MIDDLE_INITIAL
          ,V.RELATIONSHIP_SOURCE = T.RELATIONSHIP_SOURCE
          ,V.RELATIONSHIP_STANDARDIZED = T.RELATIONSHIP_STANDARDIZED
          ,V.DOB = T.DOB
          ,V.GENDER_SOURCE = T.GENDER_SOURCE
          ,V.GENDER_STANDARDIZED = T.GENDER_STANDARDIZED
          ,V.ADDRESS1_SOURCE = T.ADDRESS1_SOURCE
          ,V.ADDRESS1_STANDARDIZED = T.ADDRESS1_STANDARDIZED
          ,V.ADDRESS2_SOURCE = T.ADDRESS2_SOURCE
          ,V.ADDRESS2_STANDARDIZED = T.ADDRESS2_STANDARDIZED
          ,V.CITY_SOURCE = T.CITY_SOURCE
          ,V.CITY_STANDARDIZED = T.CITY_STANDARDIZED
          ,V.STATE_SOURCE = T.STATE_SOURCE
          ,V.STATE_STANDARDIZED = T.STATE_STANDARDIZED
          ,V.ZIP_SOURCE = T.ZIP_SOURCE
          ,V.ZIP_STANDARDIZED = T.ZIP_STANDARDIZED
          ,V.ZIP_4_STANDARDIZED = T.ZIP_4_STANDARDIZED
          ,V.SSN_SOURCE = T.SSN_SOURCE
          ,V.SSN_STANDARDIZED = T.SSN_STANDARDIZED
          ,V.EMPLOYEE_SSN_SOURCE = T.EMPLOYEE_SSN_SOURCE
          ,V.EMPLOYEE_SSN_STANDARDIZED = T.EMPLOYEE_SSN_STANDARDIZED
          ,V.HOME_PHONE_SOURCE = T.HOME_PHONE_SOURCE
          ,V.HOME_PHONE_STANDARDIZED = T.HOME_PHONE_STANDARDIZED
          ,V.WORK_PHONE_SOURCE = T.WORK_PHONE_SOURCE
          ,V.WORK_PHONE_STANDARDIZED = T.WORK_PHONE_STANDARDIZED
          ,V.MOBILE_PHONE_SOURCE = T.MOBILE_PHONE_SOURCE
          ,V.MOBILE_PHONE_STANDARDIZED = T.MOBILE_PHONE_STANDARDIZED
          ,V.EMAIL = T.EMAIL
          ,V.DIVISION = T.DIVISION
          ,V.LOCATION_CODE = T.LOCATION_CODE
          ,V.LOCATION_NAME = T.LOCATION_NAME
          ,V.COMPANY_CODE = T.COMPANY_CODE
          ,V.COMPANY_NAME = T.COMPANY_NAME
          ,V.DEPARTMENT_CODE = T.DEPARTMENT_CODE
          ,V.DEPARTMENT_NAME = T.DEPARTMENT_NAME
          ,V.CLIENT_NAME = T.CLIENT_NAME
          ,V.PLATFORM_ELIGIBLE = T.PLATFORM_ELIGIBLE
          ,V.PLATFORM_INELIGIBLE_REASON = T.PLATFORM_INELIGIBLE_REASON
          ,V.HRA_ELIGIBLE = T.HRA_ELIGIBLE
          ,V.HRA_INELIGIBLE_REASON = T.HRA_INELIGIBLE_REASON
          ,V.LM_ELIGIBLE = T.LM_ELIGIBLE
          ,V.LM_INELIGIBLE_REASON = T.LM_INELIGIBLE_REASON
          ,V.INCENTIVE_ELIGIBLE = T.INCENTIVE_ELIGIBLE
          ,V.INCENTIVE_INELIGIBLE_REASON = T.INCENTIVE_INELIGIBLE_REASON
          ,V.CM_ELIGIBLE = T.CM_ELIGIBLE
          ,V.CM_INELIGIBLE_REASON = T.CM_INELIGIBLE_REASON
          ,V.ADVOCACY_ELIGIBLE = T.ADVOCACY_ELIGIBLE
          ,V.ADVOCACY_INELIGIBLE_REASON = T.ADVOCACY_INELIGIBLE_REASON
          ,V.MAIL_UNIT = T.MAIL_UNIT
          ,V.PAYGROUP = T.PAYGROUP
          ,V.PAY_CODE = T.PAY_CODE
          ,V.FILE_NUM = T.FILE_NUM
          ,V.HOURLYSALARY = T.HOURLYSALARY
          ,V.EXEMPT = T.EXEMPT
          ,V.UNION_CODE = T.UNION_CODE
          ,V.ADJUSTED_HIRE_DATE = T.ADJUSTED_HIRE_DATE
          ,V.HIRE_DATE = T.HIRE_DATE
          ,V.TERM_DATE = T.TERM_DATE
          ,V.RETIREE_DATE = T.RETIREE_DATE
          ,V.PLAN_START_DATE = T.PLAN_START_DATE
          ,V.PLAN_END_DATE = T.PLAN_END_DATE
          ,V.PLAN_ID = T.PLAN_ID
          ,V.PLAN_NAME = T.PLAN_NAME
          ,V.PLAN_DESC = T.PLAN_DESC
          ,V.PLAN_TYPE = T.PLAN_TYPE
          ,V.BENEFIT_GROUP = T.BENEFIT_GROUP
          ,V.BENEFIT_STATUS = T.BENEFIT_STATUS
          ,V.JOB_CODE = T.JOB_CODE
          ,V.JOB_TITLE = T.JOB_TITLE
          ,V.TEAM_NAME = T.TEAM_NAME
          ,V.MARITAL_STATUS = T.MARITAL_STATUS
          ,V.PERSON_TYPE = T.PERSON_TYPE
          ,V.PERSON_STATUS = T.PERSON_STATUS
          ,V.EMPLOYEE_TYPE = T.EMPLOYEE_TYPE
          ,V.EMPLOYEE_STATUS = T.EMPLOYEE_STATUS
          ,V.COVERAGE_TYPE = T.COVERAGE_TYPE
          ,V.COV_LIMIT_CODE = T.COV_LIMIT_CODE
          ,V.WORK_IND = T.WORK_IND
          ,V.CLAIM_BRANCH = T.CLAIM_BRANCH
          ,V.REIMBURSEMENT = T.REIMBURSEMENT
          ,V.EARN_CODE = T.EARN_CODE
          ,V.PHYSICAL_LOCATION = T.PHYSICAL_LOCATION
          ,V.BARGAIN_NON_BARGAIN = T.BARGAIN_NON_BARGAIN
          ,V.BUSINESS_LEADER_1 = T.BUSINESS_LEADER_1
          ,V.BUSINESS_LEADER_2 = T.BUSINESS_LEADER_2
          ,V.BUSINESS_LEADER_3 = T.BUSINESS_LEADER_3
          ,V.BUSINESS_LEADER_4 = T.BUSINESS_LEADER_4
          ,V.BUSINESS_LEADER_5 = T.BUSINESS_LEADER_5
          ,V.WORK_STATE = T.WORK_STATE
          ,V.ACCOUNT_NUM = T.ACCOUNT_NUM
          ,V.SUBGROUP = T.SUBGROUP
          ,V.GROUP_NAME = T.GROUP_NAME
          ,V.PACKAGE_NUM = T.PACKAGE_NUM
          ,V.CONTRACT_NUM = T.CONTRACT_NUM
          ,V.LINE_OF_BUSINESS = T.LINE_OF_BUSINESS
          ,V.PCP_NUM = T.PCP_NUM
          ,V.RENEWAL_MONTH = T.RENEWAL_MONTH
          ,V.RESET_MONTH = T.RESET_MONTH
          ,V.RISK_CLASS = T.RISK_CLASS
          ,V.MEDICARE_IND = T.MEDICARE_IND
          ,V.DM_IND = T.DM_IND
          ,V.TOP_3PERCENT_DM = T.TOP_3PERCENT_DM
          ,V.SEC_COVERAGE = T.SEC_COVERAGE
          ,V.TOBACCO_IND = T.TOBACCO_IND
          ,V.CUSTOM1_DESC = T.CUSTOM1_DESC
          ,V.CUSTOM1 = T.CUSTOM1
          ,V.CUSTOM2_DESC = T.CUSTOM2_DESC
          ,V.CUSTOM2 = T.CUSTOM2
          ,V.CUSTOM3_DESC = T.CUSTOM3_DESC
          ,V.CUSTOM3 = T.CUSTOM3
          ,V.CUSTOM4_DESC = T.CUSTOM4_DESC
          ,V.CUSTOM4 = T.CUSTOM4
          ,V.CUSTOM5_DESC = T.CUSTOM5_DESC
          ,V.CUSTOM5 = T.CUSTOM5
          ,V.LastModifiedDate = T.LastModifiedDate
          ,V.CreateDate = T.CreateDate
    FROM
    ELIGIBILITY V
         JOIN
         @ELIGIBILITY_VirtualTable T
         ON
       V.ClientID = T.ClientID AND
       V.HashKEY = T.HashKEY;

    --Any ROWS that DO NOT exist, UPDATE them.
    WITH cte (
         ClientID
       , HashKey) 
        AS (
        SELECT
               ClientID
       , HashKey
        FROM @ELIGIBILITY_VirtualTable
        EXCEPT
        SELECT
               ClientID
       , HashKey
        FROM VIPER_MPI
        ) 
        INSERT INTO VIPER_MPI (
               EligID
             , ClientID
             , Elig_GUID
             , MPI
             , PRIMARY_MPI
             , MATCH_METHOD_CODE
             , IDCARD
             , MEMBER_ID
             , IMPORT_DATE
             , FILE_DATE
             , LAST_DELTA
             , ORIGINALLOADDATE
             , ISACTIVE
             , HASHKEY
             , HASHDATA
             , LAST_NAME_SOURCE
             , LAST_NAME_A_STND
             , LAST_NAME_B_STND
             , NAME_SUFFIX_STND
             , FIRST_NAME_SOURCE
             , FIRST_NAME_A_STND
             , FIRST_NAME_B_STND
             , MIDDLE_INITIAL
             , RELATIONSHIP_SOURCE
             , RELATIONSHIP_STANDARDIZED
             , DOB
             , GENDER_SOURCE
             , GENDER_STANDARDIZED
             , ADDRESS1_SOURCE
             , ADDRESS1_STANDARDIZED
             , ADDRESS2_SOURCE
             , ADDRESS2_STANDARDIZED
             , CITY_SOURCE
             , CITY_STANDARDIZED
             , STATE_SOURCE
             , STATE_STANDARDIZED
             , ZIP_SOURCE
             , ZIP_STANDARDIZED
             , ZIP_4_STANDARDIZED
             , SSN_SOURCE
             , SSN_STANDARDIZED
             , EMPLOYEE_SSN_SOURCE
             , EMPLOYEE_SSN_STANDARDIZED
             , HOME_PHONE_SOURCE
             , HOME_PHONE_STANDARDIZED
             , WORK_PHONE_SOURCE
             , WORK_PHONE_STANDARDIZED
             , MOBILE_PHONE_SOURCE
             , MOBILE_PHONE_STANDARDIZED
             , EMAIL
             , DIVISION
             , LOCATION_CODE
             , LOCATION_NAME
             , COMPANY_CODE
             , COMPANY_NAME
             , DEPARTMENT_CODE
             , DEPARTMENT_NAME
             , CLIENT_NAME
             , PLATFORM_ELIGIBLE
             , PLATFORM_INELIGIBLE_REASON
             , HRA_ELIGIBLE
             , HRA_INELIGIBLE_REASON
             , LM_ELIGIBLE
             , LM_INELIGIBLE_REASON
             , INCENTIVE_ELIGIBLE
             , INCENTIVE_INELIGIBLE_REASON
             , CM_ELIGIBLE
             , CM_INELIGIBLE_REASON
             , ADVOCACY_ELIGIBLE
             , ADVOCACY_INELIGIBLE_REASON
             , MAIL_UNIT
             , PAYGROUP
             , PAY_CODE
             , FILE_NUM
             , HOURLYSALARY
             , EXEMPT
             , UNION_CODE
             , ADJUSTED_HIRE_DATE
             , HIRE_DATE
             , TERM_DATE
             , RETIREE_DATE
             , PLAN_START_DATE
             , PLAN_END_DATE
             , PLAN_ID
             , PLAN_NAME
             , PLAN_DESC
             , PLAN_TYPE
             , BENEFIT_GROUP
             , BENEFIT_STATUS
             , JOB_CODE
             , JOB_TITLE
             , TEAM_NAME
             , MARITAL_STATUS
             , PERSON_TYPE
             , PERSON_STATUS
             , EMPLOYEE_TYPE
             , EMPLOYEE_STATUS
             , COVERAGE_TYPE
             , COV_LIMIT_CODE
             , WORK_IND
             , CLAIM_BRANCH
             , REIMBURSEMENT
             , EARN_CODE
             , PHYSICAL_LOCATION
             , BARGAIN_NON_BARGAIN
             , BUSINESS_LEADER_1
             , BUSINESS_LEADER_2
             , BUSINESS_LEADER_3
             , BUSINESS_LEADER_4
             , BUSINESS_LEADER_5
             , WORK_STATE
             , ACCOUNT_NUM
             , SUBGROUP
             , GROUP_NAME
             , PACKAGE_NUM
             , CONTRACT_NUM
             , LINE_OF_BUSINESS
             , PCP_NUM
             , RENEWAL_MONTH
             , RESET_MONTH
             , RISK_CLASS
             , MEDICARE_IND
             , DM_IND
             , TOP_3PERCENT_DM
             , SEC_COVERAGE
             , TOBACCO_IND
             , CUSTOM1_DESC
             , CUSTOM1
             , CUSTOM2_DESC
             , CUSTOM2
             , CUSTOM3_DESC
             , CUSTOM3
             , CUSTOM4_DESC
             , CUSTOM4
             , CUSTOM5_DESC
             , CUSTOM5
             , LastModifiedDate
             , CreateDate) 
        SELECT
               V.EligID
             , V.ClientID
             , V.Elig_GUID
             , V.MPI
             , V.PRIMARY_MPI
             , V.MATCH_METHOD_CODE
             , V.IDCARD
             , V.MEMBER_ID
             , V.IMPORT_DATE
             , V.FILE_DATE
             , V.LAST_DELTA
             , V.ORIGINALLOADDATE
             , V.ISACTIVE
             , V.HASHKEY
             , V.HASHDATA
             , V.LAST_NAME_SOURCE
             , V.LAST_NAME_A_STND
             , V.LAST_NAME_B_STND
             , V.NAME_SUFFIX_STND
             , V.FIRST_NAME_SOURCE
             , V.FIRST_NAME_A_STND
             , V.FIRST_NAME_B_STND
             , V.MIDDLE_INITIAL
             , V.RELATIONSHIP_SOURCE
             , V.RELATIONSHIP_STANDARDIZED
             , V.DOB
             , V.GENDER_SOURCE
             , V.GENDER_STANDARDIZED
             , V.ADDRESS1_SOURCE
             , V.ADDRESS1_STANDARDIZED
             , V.ADDRESS2_SOURCE
             , V.ADDRESS2_STANDARDIZED
             , V.CITY_SOURCE
             , V.CITY_STANDARDIZED
             , V.STATE_SOURCE
             , V.STATE_STANDARDIZED
             , V.ZIP_SOURCE
             , V.ZIP_STANDARDIZED
             , V.ZIP_4_STANDARDIZED
             , V.SSN_SOURCE
             , V.SSN_STANDARDIZED
             , V.EMPLOYEE_SSN_SOURCE
             , V.EMPLOYEE_SSN_STANDARDIZED
             , V.HOME_PHONE_SOURCE
             , V.HOME_PHONE_STANDARDIZED
             , V.WORK_PHONE_SOURCE
             , V.WORK_PHONE_STANDARDIZED
             , V.MOBILE_PHONE_SOURCE
             , V.MOBILE_PHONE_STANDARDIZED
             , V.EMAIL
             , V.DIVISION
             , V.LOCATION_CODE
             , V.LOCATION_NAME
             , V.COMPANY_CODE
             , V.COMPANY_NAME
             , V.DEPARTMENT_CODE
             , V.DEPARTMENT_NAME
             , V.CLIENT_NAME
             , V.PLATFORM_ELIGIBLE
             , V.PLATFORM_INELIGIBLE_REASON
             , V.HRA_ELIGIBLE
             , V.HRA_INELIGIBLE_REASON
             , V.LM_ELIGIBLE
             , V.LM_INELIGIBLE_REASON
             , V.INCENTIVE_ELIGIBLE
             , V.INCENTIVE_INELIGIBLE_REASON
             , V.CM_ELIGIBLE
             , V.CM_INELIGIBLE_REASON
             , V.ADVOCACY_ELIGIBLE
             , V.ADVOCACY_INELIGIBLE_REASON
             , V.MAIL_UNIT
             , V.PAYGROUP
             , V.PAY_CODE
             , V.FILE_NUM
             , V.HOURLYSALARY
             , V.EXEMPT
             , V.UNION_CODE
             , V.ADJUSTED_HIRE_DATE
             , V.HIRE_DATE
             , V.TERM_DATE
             , V.RETIREE_DATE
             , V.PLAN_START_DATE
             , V.PLAN_END_DATE
             , V.PLAN_ID
             , V.PLAN_NAME
             , V.PLAN_DESC
             , V.PLAN_TYPE
             , V.BENEFIT_GROUP
             , V.BENEFIT_STATUS
             , V.JOB_CODE
             , V.JOB_TITLE
             , V.TEAM_NAME
             , V.MARITAL_STATUS
             , V.PERSON_TYPE
             , V.PERSON_STATUS
             , V.EMPLOYEE_TYPE
             , V.EMPLOYEE_STATUS
             , V.COVERAGE_TYPE
             , V.COV_LIMIT_CODE
             , V.WORK_IND
             , V.CLAIM_BRANCH
             , V.REIMBURSEMENT
             , V.EARN_CODE
             , V.PHYSICAL_LOCATION
             , V.BARGAIN_NON_BARGAIN
             , V.BUSINESS_LEADER_1
             , V.BUSINESS_LEADER_2
             , V.BUSINESS_LEADER_3
             , V.BUSINESS_LEADER_4
             , V.BUSINESS_LEADER_5
             , V.WORK_STATE
             , V.ACCOUNT_NUM
             , V.SUBGROUP
             , V.GROUP_NAME
             , V.PACKAGE_NUM
             , V.CONTRACT_NUM
             , V.LINE_OF_BUSINESS
             , V.PCP_NUM
             , V.RENEWAL_MONTH
             , V.RESET_MONTH
             , V.RISK_CLASS
             , V.MEDICARE_IND
             , V.DM_IND
             , V.TOP_3PERCENT_DM
             , V.SEC_COVERAGE
             , V.TOBACCO_IND
             , V.CUSTOM1_DESC
             , V.CUSTOM1
             , V.CUSTOM2_DESC
             , V.CUSTOM2
             , V.CUSTOM3_DESC
             , V.CUSTOM3
             , V.CUSTOM4_DESC
             , V.CUSTOM4
             , V.CUSTOM5_DESC
             , V.CUSTOM5
             , V.LastModifiedDate
             , V.CreateDate
        FROM
             @ELIGIBILITY_VirtualTable AS V
                  JOIN CTE AS CT
                  ON
               V.ClientID = T.ClientID AND
               V.HashKEY = T.HashKEY;
END;

