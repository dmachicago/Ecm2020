
-- drop table MPI_PreValidation
go

create table MPI_PreValidation
(
     [HASHKEY] [nvarchar](75) NULL,
	CLIENTID int not null ,
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

	[MATCH_METHOD_CODE] [varchar](30) NULL,	
	[MPI] int not null,	

	LastValidationDate datetime default getdate()
)

create clustered index PI_MPI_PreValidation on MPI_PreValidation ([HASHKEY], CLIENTID)
