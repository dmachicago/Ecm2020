-- USE KenticoCMS_PRD_1

/*************************
------------------------
cms_user			    -> DONE
cms_usersettings	  -> DONE
CMS_UserSite	  -> DONE
HFIT_PPTEligibility
cms_usercontact
*************************/
GO
PRINT 'Executing create_table_STAGING_HFIT_PPTEligibility.sql';
GO

IF EXISTS (SELECT
                  name
                  FROM sys.tables
                  WHERE name = 'STAGING_HFIT_PPTEligibility_Audit') 
    BEGIN
        DROP TABLE
             STAGING_HFIT_PPTEligibility_Audit;
    END;
GO

CREATE TABLE dbo.STAGING_HFIT_PPTEligibility_Audit (
             PPTID int NOT NULL
           , SVR nvarchar (100) NOT NULL
           , DBNAME nvarchar (100) NOT NULL
           , SYS_CHANGE_VERSION int NULL
           , SYS_CHANGE_OPERATION nvarchar (10) NULL
           , SchemaName nvarchar (100) NULL
           , SysUser nvarchar (100) NULL
           , IPADDR nvarchar (50) NULL
           , Processed integer NULL
           , TBL nvarchar (100) NULL
           , CreateDate datetime NULL
           , commit_time datetime NULL) ;
GO
ALTER TABLE dbo.STAGING_HFIT_PPTEligibility_Audit
ADD
            CONSTRAINT DF_STAGING_HFIT_PPTEligibility_Audit_CreateDate DEFAULT GETDATE () FOR CreateDate;
GO

CREATE CLUSTERED INDEX PK_HFIT_PPTEligibility_Audit ON dbo.STAGING_HFIT_PPTEligibility_Audit (PPTID ASC, SVR ASC, SYS_CHANGE_VERSION ASC, SYS_CHANGE_OPERATION ASC) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];

GO

IF NOT EXISTS (SELECT
					  sys.tables.name AS Table_name
					  FROM
						   sys.change_tracking_tables
							   JOIN sys.tables
								   ON sys.tables.object_id = sys.change_tracking_tables.object_id
							   JOIN sys.schemas
								   ON sys.schemas.schema_id = sys.tables.schema_id
					  WHERE sys.tables.name = 'HFIT_PPTEligibility') 
	BEGIN
		PRINT 'ADDING Change Tracking to HFIT_PPTEligibility';
		ALTER TABLE dbo.HFIT_PPTEligibility ENABLE CHANGE_TRACKING
				WITH (TRACK_COLUMNS_UPDATED = ON) ;
	END;
ELSE
	BEGIN
		PRINT 'Change Tracking exists on HFIT_PPTEligibility';
	END;
GO
IF EXISTS (SELECT
				  name
				  FROM sys.procedures
				  WHERE name = 'proc_Create_Table_STAGING_HFIT_PPTEligibility') 
	BEGIN
		DROP PROCEDURE
			 proc_Create_Table_STAGING_HFIT_PPTEligibility;
	END;
GO
-- exec proc_Create_Table_STAGING_HFIT_PPTEligibility
-- select top 100 * from [STAGING_HFIT_PPTEligibility]
CREATE PROCEDURE proc_Create_Table_STAGING_HFIT_PPTEligibility
AS
	 BEGIN

		 IF EXISTS (SELECT
						   name
						   FROM sys.tables
						   WHERE name = 'STAGING_HFIT_PPTEligibility') 
			 BEGIN
				 DROP TABLE
					  dbo.STAGING_HFIT_PPTEligibility;
			 END;

		 SET ANSI_NULLS ON;
		 SET QUOTED_IDENTIFIER ON;

		 CREATE TABLE dbo.STAGING_HFIT_PPTEligibility (
					  PPTID int NOT NULL
					, ClientID varchar (27) NULL
					, ClientCode varchar (12) NULL
					, UserID int NULL
					, IDCard nvarchar (25) NULL
					, FirstName varchar (50) NOT NULL
					, LastName varchar (50) NOT NULL
					, MiddleInit varchar (2) NULL
					, BirthDate datetime2 (7) NULL
					, Gender nvarchar (1) NULL
					, AddressLine1 varchar (50) NULL
					, AddressLine2 varchar (50) NULL
					, City varchar (30) NULL
					, State varchar (2) NULL
					, PostalCode varchar (10) NULL
					, HomePhoneNum varchar (12) NULL
					, WorkPhoneNum varchar (12) NULL
					, MobilePhoneNum varchar (12) NULL
					, EmailAddress varchar (50) NULL
					, MPI varchar (50) NOT NULL
					, MatchMethodCode nvarchar (25) NULL
					, SSN varchar (11) NULL
					, PrimarySSN varchar (11) NULL
					, HireDate datetime2 (7) NULL
					, TermDate datetime2 (7) NULL
					, RetireeDate datetime2 (7) NULL
					, PlanName varchar (50) NULL
					, PlanDescription varchar (50) NULL
					, PlanID varchar (25) NULL
					, PlanStartDate datetime2 (7) NULL
					, PlanEndDate datetime2 (7) NULL
					, Company varchar (50) NULL
					, CompanyCd varchar (20) NULL
					, LocationName varchar (50) NULL
					, LocationCd varchar (20) NULL
					, DepartmentName varchar (50) NULL
					, DepartmentCd varchar (20) NULL
					, UnionCd varchar (30) NULL
					, BenefitGrp varchar (20) NULL
					, PayGrp varchar (20) NULL
					, Division varchar (30) NULL
					, JobTitle varchar (50) NULL
					, JobCd varchar (20) NULL
					, TeamName varchar (30) NULL
					, MaritalStatus varchar (30) NULL
					, PersonType varchar (30) NULL
					, PersonStatus varchar (30) NULL
					, EmployeeType varchar (30) NULL
					, CoverageType varchar (30) NULL
					, EmployeeStatus varchar (30) NULL
					, PayCd varchar (30) NULL
					, BenefitStatus varchar (30) NULL
					, PlanType varchar (20) NULL
					, ClientPlatformElig bit NULL
					, ClientHRAElig bit NULL
					, ClientLMElig bit NULL
					, ClientIncentiveElig bit NULL
					, ClientCMElig bit NULL
					, ClientScreeningElig bit NULL
					, Custom1 varchar (50) NULL
					, Custom2 varchar (50) NULL
					, Custom3 varchar (50) NULL
					, Custom4 varchar (50) NULL
					, Custom5 varchar (50) NULL
					, Custom6 varchar (50) NULL
					, Custom7 varchar (50) NULL
					, Custom8 varchar (50) NULL
					, Custom9 varchar (50) NULL
					, Custom10 varchar (50) NULL
					, Custom11 varchar (50) NULL
					, Custom12 varchar (50) NULL
					, Custom13 varchar (50) NULL
					, Custom14 varchar (50) NULL
					, Custom15 varchar (50) NULL
					, ChangeStatusFlag nvarchar (1) NULL
					, Last_Update_Dt datetime2 (7) NULL
					, FlatFileName nvarchar (500) NULL
					, ItemGUID uniqueidentifier NOT NULL
					, Hashbyte_Checksum varchar (32) NULL
					, Primary_MPI nvarchar (50) NULL
					, MPI_Relationship_Type varchar (50) NULL
					, WorkInd bit NULL
					, LastModifiedDate datetime NULL
					, RowNbr int NULL
					, DeletedFlg bit NULL
					, TimeZone nvarchar (10) NULL
					, ConvertedToCentralTime bit NULL
					, SVR nvarchar (100) NOT NULL
					, DBNAME nvarchar (100) NOT NULL
					, SYS_CHANGE_VERSION int NULL) 
		 ON [PRIMARY];

		 ALTER TABLE dbo.STAGING_HFIT_PPTEligibility
		 ADD
					 DEFAULT @@Servername FOR SVR;
		 ALTER TABLE dbo.STAGING_HFIT_PPTEligibility
		 ADD
					 DEFAULT DB_NAME () FOR DBNAME;

		 CREATE CLUSTERED INDEX PI_STAGING_HFIT_PPTEligibility ON dbo.STAGING_HFIT_PPTEligibility (PPTID ASC, SVR ASC, DBNAME ASC, SYS_CHANGE_VERSION ASC) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];

		 --SET IDENTITY_INSERT STAGING_HFIT_PPTEligibility ON;

		 INSERT INTO STAGING_HFIT_PPTEligibility (
					 PPTID
				   , ClientID
				   , ClientCode
				   , UserID
				   , IDCard
				   , FirstName
				   , LastName
				   , MiddleInit
				   , BirthDate
				   , Gender
				   , AddressLine1
				   , AddressLine2
				   , City
				   , State
				   , PostalCode
				   , HomePhoneNum
				   , WorkPhoneNum
				   , MobilePhoneNum
				   , EmailAddress
				   , MPI
				   , MatchMethodCode
				   , SSN
				   , PrimarySSN
				   , HireDate
				   , TermDate
				   , RetireeDate
				   , PlanName
				   , PlanDescription
				   , PlanID
				   , PlanStartDate
				   , PlanEndDate
				   , Company
				   , CompanyCd
				   , LocationName
				   , LocationCd
				   , DepartmentName
				   , DepartmentCd
				   , UnionCd
				   , BenefitGrp
				   , PayGrp
				   , Division
				   , JobTitle
				   , JobCd
				   , TeamName
				   , MaritalStatus
				   , PersonType
				   , PersonStatus
				   , EmployeeType
				   , CoverageType
				   , EmployeeStatus
				   , PayCd
				   , BenefitStatus
				   , PlanType
				   , ClientPlatformElig
				   , ClientHRAElig
				   , ClientLMElig
				   , ClientIncentiveElig
				   , ClientCMElig
				   , ClientScreeningElig
				   , Custom1
				   , Custom2
				   , Custom3
				   , Custom4
				   , Custom5
				   , Custom6
				   , Custom7
				   , Custom8
				   , Custom9
				   , Custom10
				   , Custom11
				   , Custom12
				   , Custom13
				   , Custom14
				   , Custom15
				   , ChangeStatusFlag
				   , Last_Update_Dt
				   , FlatFileName
				   , ItemGUID
				   , Hashbyte_Checksum
				   , Primary_MPI
				   , MPI_Relationship_Type
				   , WorkInd) 
		 SELECT
				PPTID
			  , ClientID
			  , ClientCode
			  , UserID
			  , IDCard
			  , FirstName
			  , LastName
			  , MiddleInit
			  , BirthDate
			  , Gender
			  , AddressLine1
			  , AddressLine2
			  , City
			  , State
			  , PostalCode
			  , HomePhoneNum
			  , WorkPhoneNum
			  , MobilePhoneNum
			  , EmailAddress
			  , MPI
			  , MatchMethodCode
			  , SSN
			  , PrimarySSN
			  , HireDate
			  , TermDate
			  , RetireeDate
			  , PlanName
			  , PlanDescription
			  , PlanID
			  , PlanStartDate
			  , PlanEndDate
			  , Company
			  , CompanyCd
			  , LocationName
			  , LocationCd
			  , DepartmentName
			  , DepartmentCd
			  , UnionCd
			  , BenefitGrp
			  , PayGrp
			  , Division
			  , JobTitle
			  , JobCd
			  , TeamName
			  , MaritalStatus
			  , PersonType
			  , PersonStatus
			  , EmployeeType
			  , CoverageType
			  , EmployeeStatus
			  , PayCd
			  , BenefitStatus
			  , PlanType
			  , ClientPlatformElig
			  , ClientHRAElig
			  , ClientLMElig
			  , ClientIncentiveElig
			  , ClientCMElig
			  , ClientScreeningElig
			  , Custom1
			  , Custom2
			  , Custom3
			  , Custom4
			  , Custom5
			  , Custom6
			  , Custom7
			  , Custom8
			  , Custom9
			  , Custom10
			  , Custom11
			  , Custom12
			  , Custom13
			  , Custom14
			  , Custom15
			  , ChangeStatusFlag
			  , Last_Update_Dt
			  , FlatFileName
			  , ItemGUID
			  , Hashbyte_Checksum
			  , Primary_MPI
			  , MPI_Relationship_Type
			  , WorkInd
				FROM HFIT_PPTEligibility;

		 --SET IDENTITY_INSERT STAGING_HFIT_PPTEligibility OFF;

		 IF EXISTS (SELECT
						   name
						   FROM sys.tables
						   WHERE name = 'STAGING_HFIT_PPTEligibility_Update_History') 
			 BEGIN
				 PRINT 'dropping and recreating STAGING_HFIT_PPTEligibility_Update_History';
				 DROP TABLE
					  STAGING_HFIT_PPTEligibility_Update_History;
			 END;

		 CREATE TABLE dbo.STAGING_HFIT_PPTEligibility_Update_History (
					  PPTID int NOT NULL
					, AddressLine1_cg int NULL
					, AddressLine2_cg int NULL
					, BenefitGrp_cg int NULL
					, BenefitStatus_cg int NULL
					, BirthDate_cg int NULL
					, ChangeStatusFlag_cg int NULL
					, City_cg int NULL
					, ClientCMElig_cg int NULL
					, ClientCode_cg int NULL
					, ClientHRAElig_cg int NULL
					, ClientID_cg int NULL
					, ClientIncentiveElig_cg int NULL
					, ClientLMElig_cg int NULL
					, ClientPlatformElig_cg int NULL
					, ClientScreeningElig_cg int NULL
					, Company_cg int NULL
					, CompanyCd_cg int NULL
					, CoverageType_cg int NULL
					, Custom1_cg int NULL
					, Custom10_cg int NULL
					, Custom11_cg int NULL
					, Custom12_cg int NULL
					, Custom13_cg int NULL
					, Custom14_cg int NULL
					, Custom15_cg int NULL
					, Custom2_cg int NULL
					, Custom3_cg int NULL
					, Custom4_cg int NULL
					, Custom5_cg int NULL
					, Custom6_cg int NULL
					, Custom7_cg int NULL
					, Custom8_cg int NULL
					, Custom9_cg int NULL
					, DepartmentCd_cg int NULL
					, DepartmentName_cg int NULL
					, Division_cg int NULL
					, EmailAddress_cg int NULL
					, EmployeeStatus_cg int NULL
					, EmployeeType_cg int NULL
					, FirstName_cg int NULL
					, FlatFileName_cg int NULL
					, Gender_cg int NULL
					, Hashbyte_Checksum_cg int NULL
					, HireDate_cg int NULL
					, HomePhoneNum_cg int NULL
					, IDCard_cg int NULL
					, ItemGUID_cg int NULL
					, JobCd_cg int NULL
					, JobTitle_cg int NULL
					, Last_Update_Dt_cg int NULL
					, LastName_cg int NULL
					, LocationCd_cg int NULL
					, LocationName_cg int NULL
					, MaritalStatus_cg int NULL
					, MatchMethodCode_cg int NULL
					, MiddleInit_cg int NULL
					, MobilePhoneNum_cg int NULL
					, MPI_cg int NULL
					, MPI_Relationship_Type_cg int NULL
					, PayCd_cg int NULL
					, PayGrp_cg int NULL
					, PersonStatus_cg int NULL
					, PersonType_cg int NULL
					, PlanDescription_cg int NULL
					, PlanEndDate_cg int NULL
					, PlanID_cg int NULL
					, PlanName_cg int NULL
					, PlanStartDate_cg int NULL
					, PlanType_cg int NULL
					, PostalCode_cg int NULL
					, PPTID_cg int NULL
					, Primary_MPI_cg int NULL
					, PrimarySSN_cg int NULL
					, RetireeDate_cg int NULL
					, SSN_cg int NULL
					, State_cg int NULL
					, TeamName_cg int NULL
					, TermDate_cg int NULL
					, UnionCd_cg int NULL
					, UserID_cg int NULL
					, WorkInd_cg int NULL
					, WorkPhoneNum_cg int NULL
					, LastModifiedDate datetime DEFAULT GETDATE () 
					, SVR nvarchar (100) NOT NULL
										 DEFAULT @@Servername
					, DBNAME nvarchar (100) NOT NULL
											DEFAULT DB_NAME () 
					, SYS_CHANGE_VERSION int NULL
					, SYS_CHANGE_COLUMNS varbinary (4000) NULL
					, SYS_CHANGE_OPERATION nchar (1) NULL
					, CurrUser nvarchar (100) NULL
											  CONSTRAINT DF_STAGING_HFIT_PPTEligibility_Update_History_CurrUser DEFAULT USER_NAME () 
					, SysUser nvarchar (100) NULL
											 CONSTRAINT DF_STAGING_HFIT_PPTEligibility_Update_History_SysUser DEFAULT SUSER_SNAME () 
					, IPADDR nvarchar (50) NULL
										   CONSTRAINT DF_STAGING_HFIT_PPTEligibility_Update_History_IPADDR DEFAULT CAST (CONNECTIONPROPERTY ('client_net_address') AS nvarchar (50))
					,commit_time datetime)
		 ON [PRIMARY];

		 CREATE CLUSTERED INDEX PI_STAGING_HFIT_PPTEligibility_Update_History ON dbo.STAGING_HFIT_PPTEligibility_Update_History (PPTID ASC, SVR ASC, SYS_CHANGE_VERSION ASC) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];

	 -- select * from STAGING_HFIT_PPTEligibility_Update_History
	 --ALTER TABLE dbo.STAGING_HFIT_PPTEligibility_Update_History
	 --ADD
	 --            DEFAULT @@servername FOR SVR;
	 --ALTER TABLE dbo.STAGING_HFIT_PPTEligibility_Update_History
	 --ADD
	 --            DEFAULT DB_NAME () FOR DBNAME;

	 END;

GO
PRINT 'Executed create_table_STAGING_HFIT_PPTEligibility.sql';
GO
EXEC proc_Create_Table_STAGING_HFIT_PPTEligibility;
GO
--SELECT * FROM STAGING_HFIT_PPTEligibility_Update_History;
