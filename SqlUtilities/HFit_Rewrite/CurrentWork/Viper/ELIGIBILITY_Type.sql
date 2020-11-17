USE [Viper]
GO

/****** Object:  UserDefinedTableType [dbo].[ELIGIBILITY_Type]    Script Date: 6/14/2016 9:22:35 AM ******/
DROP TYPE [dbo].[ELIGIBILITY_Type]
GO

/****** Object:  UserDefinedTableType [dbo].[ELIGIBILITY_Type]    Script Date: 6/14/2016 9:22:35 AM ******/
CREATE TYPE [dbo].[ELIGIBILITY_Type] AS TABLE(
	[EligID] [bigint] NULL,
	[ClientID] [int] NULL,
	[Elig_GUID] [uniqueidentifier] NULL,
	[MPI] [int] NULL,
	[PRIMARY_MPI] [int] NULL,
	[MATCH_METHOD_CODE] [varchar](255) NULL,
	[IDCARD] [varchar](255) NULL,
	[MEMBER_ID] [varchar](255) NULL,
	[IMPORT_DATE] [datetime] NULL,
	[FILE_DATE] [datetime] NULL,
	[ISACTIVE] [bit] NULL,
	[HASHKEY] [varchar](255) NULL,
	[HASHDATA] [varchar](255) NULL,
	[LAST_NAME_SOURCE] [varchar](255) NULL,
	[LAST_NAME_A_STND] [varchar](255) NULL,
	[LAST_NAME_B_STND] [varchar](255) NULL,
	[NAME_SUFFIX_STND] [varchar](255) NULL,
	[FIRST_NAME_SOURCE] [varchar](255) NULL,
	[FIRST_NAME_A_STND] [varchar](255) NULL,
	[FIRST_NAME_B_STND] [varchar](255) NULL,
	[MIDDLE_INITIAL] [varchar](255) NULL,
	[RELATIONSHIP_SOURCE] [varchar](255) NULL,
	[RELATIONSHIP_STANDARDIZED] [varchar](255) NULL,
	[DOB] [varchar](255) NULL,
	[GENDER_SOURCE] [varchar](255) NULL,
	[GENDER_STANDARDIZED] [varchar](255) NULL,
	[ADDRESS1_SOURCE] [varchar](255) NULL,
	[ADDRESS1_STANDARDIZED] [varchar](255) NULL,
	[ADDRESS2_SOURCE] [varchar](255) NULL,
	[ADDRESS2_STANDARDIZED] [varchar](255) NULL,
	[CITY_SOURCE] [varchar](255) NULL,
	[CITY_STANDARDIZED] [varchar](255) NULL,
	[STATE_SOURCE] [varchar](255) NULL,
	[STATE_STANDARDIZED] [varchar](255) NULL,
	[ZIP_SOURCE] [varchar](255) NULL,
	[ZIP_STANDARDIZED] [varchar](255) NULL,
	[ZIP_4_STANDARDIZED] [varchar](255) NULL,
	[SSN_SOURCE] [varchar](255) NULL,
	[SSN_STANDARDIZED] [varchar](255) NULL,
	[EMPLOYEE_SSN_SOURCE] [varchar](255) NULL,
	[EMPLOYEE_SSN_STANDARDIZED] [varchar](255) NULL,
	[HOME_PHONE_SOURCE] [varchar](255) NULL,
	[HOME_PHONE_STANDARDIZED] [varchar](255) NULL,
	[WORK_PHONE_SOURCE] [varchar](255) NULL,
	[WORK_PHONE_STANDARDIZED] [varchar](255) NULL,
	[MOBILE_PHONE_SOURCE] [varchar](255) NULL,
	[MOBILE_PHONE_STANDARDIZED] [varchar](255) NULL,
	[EMAIL] [varchar](255) NULL,
	[DIVISION] [varchar](255) NULL,
	[LOCATION_CODE] [varchar](255) NULL,
	[LOCATION_NAME] [varchar](255) NULL,
	[COMPANY_CODE] [varchar](255) NULL,
	[COMPANY_NAME] [varchar](255) NULL,
	[DEPARTMENT_CODE] [varchar](255) NULL,
	[DEPARTMENT_NAME] [varchar](255) NULL,
	[CLIENT_NAME] [varchar](255) NULL,
	[PLATFORM_ELIGIBLE] [varchar](255) NULL,
	[PLATFORM_INELIGIBLE_REASON] [varchar](255) NULL,
	[HRA_ELIGIBLE] [varchar](255) NULL,
	[HRA_INELIGIBLE_REASON] [varchar](255) NULL,
	[LM_ELIGIBLE] [varchar](255) NULL,
	[LM_INELIGIBLE_REASON] [varchar](255) NULL,
	[INCENTIVE_ELIGIBLE] [varchar](255) NULL,
	[INCENTIVE_INELIGIBLE_REASON] [varchar](255) NULL,
	[CM_ELIGIBLE] [varchar](255) NULL,
	[CM_INELIGIBLE_REASON] [varchar](255) NULL,
	[ADVOCACY_ELIGIBLE] [varchar](255) NULL,
	[ADVOCACY_INELIGIBLE_REASON] [varchar](255) NULL,
	[MAIL_UNIT] [varchar](255) NULL,
	[PAYGROUP] [varchar](255) NULL,
	[PAY_CODE] [varchar](255) NULL,
	[FILE_NUM] [varchar](255) NULL,
	[HOURLYSALARY] [varchar](255) NULL,
	[EXEMPT] [varchar](255) NULL,
	[UNION_CODE] [varchar](255) NULL,
	[ADJUSTED_HIRE_DATE] [varchar](255) NULL,
	[HIRE_DATE] [varchar](255) NULL,
	[TERM_DATE] [varchar](255) NULL,
	[RETIREE_DATE] [varchar](255) NULL,
	[PLAN_START_DATE] [varchar](255) NULL,
	[PLAN_END_DATE] [varchar](255) NULL,
	[PLAN_ID] [varchar](255) NULL,
	[PLAN_NAME] [varchar](255) NULL,
	[PLAN_DESC] [varchar](255) NULL,
	[PLAN_TYPE] [varchar](255) NULL,
	[BENEFIT_GROUP] [varchar](255) NULL,
	[BENEFIT_STATUS] [varchar](255) NULL,
	[JOB_CODE] [varchar](255) NULL,
	[JOB_TITLE] [varchar](255) NULL,
	[TEAM_NAME] [varchar](255) NULL,
	[MARITAL_STATUS] [varchar](255) NULL,
	[PERSON_TYPE] [varchar](255) NULL,
	[PERSON_STATUS] [varchar](255) NULL,
	[EMPLOYEE_TYPE] [varchar](255) NULL,
	[EMPLOYEE_STATUS] [varchar](255) NULL,
	[COVERAGE_TYPE] [varchar](255) NULL,
	[COV_LIMIT_CODE] [varchar](255) NULL,
	[WORK_IND] [varchar](255) NULL,
	[CLAIM_BRANCH] [varchar](255) NULL,
	[REIMBURSEMENT] [varchar](255) NULL,
	[EARN_CODE] [varchar](255) NULL,
	[PHYSICAL_LOCATION] [varchar](255) NULL,
	[BARGAIN_NON_BARGAIN] [varchar](255) NULL,
	[BUSINESS_LEADER_1] [varchar](255) NULL,
	[BUSINESS_LEADER_2] [varchar](255) NULL,
	[BUSINESS_LEADER_3] [varchar](255) NULL,
	[BUSINESS_LEADER_4] [varchar](255) NULL,
	[BUSINESS_LEADER_5] [varchar](255) NULL,
	[WORK_STATE] [varchar](255) NULL,
	[ACCOUNT_NUM] [varchar](255) NULL,
	[SUBGROUP] [varchar](255) NULL,
	[GROUP_NAME] [varchar](255) NULL,
	[PACKAGE_NUM] [varchar](255) NULL,
	[CONTRACT_NUM] [varchar](255) NULL,
	[LINE_OF_BUSINESS] [varchar](255) NULL,
	[PCP_NUM] [varchar](255) NULL,
	[RENEWAL_MONTH] [varchar](255) NULL,
	[RESET_MONTH] [varchar](255) NULL,
	[RISK_CLASS] [varchar](255) NULL,
	[MEDICARE_IND] [varchar](255) NULL,
	[DM_IND] [varchar](255) NULL,
	[TOP_3PERCENT_DM] [varchar](255) NULL,
	[SEC_COVERAGE] [varchar](255) NULL,
	[TOBACCO_IND] [varchar](255) NULL,
	[CUSTOM1_DESC] [varchar](255) NULL,
	[CUSTOM1] [varchar](255) NULL,
	[CUSTOM2_DESC] [varchar](255) NULL,
	[CUSTOM2] [varchar](255) NULL,
	[CUSTOM3_DESC] [varchar](255) NULL,
	[CUSTOM3] [varchar](255) NULL,
	[CUSTOM4_DESC] [varchar](255) NULL,
	[CUSTOM4] [varchar](255) NULL,
	[CUSTOM5_DESC] [varchar](255) NULL,
	[CUSTOM5] [varchar](255) NULL,
	[LastModifiedDate] [datetime] NULL,
	[CreateDate] [datetime] NULL
)
GO


