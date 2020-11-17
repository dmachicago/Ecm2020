
GO
PRINT 'Executing proc_CT_HFIT_PPTEligibility_History.sql';
GO
IF EXISTS (SELECT
				  name
				  FROM sys.procedures
				  WHERE name = 'proc_CT_HFIT_PPTEligibility_History') 
	BEGIN
		DROP PROCEDURE
			 proc_CT_HFIT_PPTEligibility_History;
	END;
GO

/**************************************************************************

select tc.commit_time, *
from
    changetable(changes HFIT_PPTEligibility, 0) c
    join sys.dm_tran_commit_table tc on c.sys_change_version = tc.commit_ts


exec proc_CT_HFIT_PPTEligibility_History 'I'
exec proc_CT_HFIT_PPTEligibility_History 'D'
exec proc_CT_HFIT_PPTEligibility_History 'U'

truncate table STAGING_HFIT_PPTEligibility_Update_History
select * from STAGING_HFIT_PPTEligibility_Update_History

SELECT CHANGE_TRACKING_MIN_VALID_VERSION(OBJECT_ID('HFIT_PPTEligibility'))
**************************************************************************/

CREATE PROCEDURE proc_CT_HFIT_PPTEligibility_History (@Typesave AS nchar (1)) 
AS
	 BEGIN
		 WITH CTE (
			  PPTID
			, SYS_CHANGE_VERSION
			, SYS_CHANGE_COLUMNS) 
			 AS (SELECT
						CT.PPTID
					  , CT.SYS_CHANGE_VERSION
					  , SYS_CHANGE_COLUMNS
						FROM CHANGETABLE (CHANGES HFIT_PPTEligibility, NULL) AS CT
						WHERE SYS_CHANGE_OPERATION = @Typesave
				 EXCEPT
				 SELECT
						PPTID
					  , SYS_CHANGE_VERSION
					  , SYS_CHANGE_COLUMNS
						FROM STAGING_HFIT_PPTEligibility_Update_History) 
			 INSERT INTO STAGING_HFIT_PPTEligibility_Update_History (
						 PPTID
					   , LastModifiedDate
					   , SVR
					   , DBNAME
					   , SYS_CHANGE_VERSION
					   , SYS_CHANGE_COLUMNS
					   , SYS_CHANGE_OPERATION
					   , AddressLine1_cg
					   , AddressLine2_cg
					   , BenefitGrp_cg
					   , BenefitStatus_cg
					   , BirthDate_cg
					   , ChangeStatusFlag_cg
					   , City_cg
					   , ClientCMElig_cg
					   , ClientCode_cg
					   , ClientHRAElig_cg
					   , ClientID_cg
					   , ClientIncentiveElig_cg
					   , ClientLMElig_cg
					   , ClientPlatformElig_cg
					   , ClientScreeningElig_cg
					   , Company_cg
					   , CompanyCd_cg
					   , CoverageType_cg
					   , Custom1_cg
					   , Custom10_cg
					   , Custom11_cg
					   , Custom12_cg
					   , Custom13_cg
					   , Custom14_cg
					   , Custom15_cg
					   , Custom2_cg
					   , Custom3_cg
					   , Custom4_cg
					   , Custom5_cg
					   , Custom6_cg
					   , Custom7_cg
					   , Custom8_cg
					   , Custom9_cg
					   , DepartmentCd_cg
					   , DepartmentName_cg
					   , Division_cg
					   , EmailAddress_cg
					   , EmployeeStatus_cg
					   , EmployeeType_cg
					   , FirstName_cg
					   , FlatFileName_cg
					   , Gender_cg
					   , Hashbyte_Checksum_cg
					   , HireDate_cg
					   , HomePhoneNum_cg
					   , IDCard_cg
					   , ItemGUID_cg
					   , JobCd_cg
					   , JobTitle_cg
					   , Last_Update_Dt_cg
					   , LastName_cg
					   , LocationCd_cg
					   , LocationName_cg
					   , MaritalStatus_cg
					   , MatchMethodCode_cg
					   , MiddleInit_cg
					   , MobilePhoneNum_cg
					   , MPI_cg
					   , MPI_Relationship_Type_cg
					   , PayCd_cg
					   , PayGrp_cg
					   , PersonStatus_cg
					   , PersonType_cg
					   , PlanDescription_cg
					   , PlanEndDate_cg
					   , PlanID_cg
					   , PlanName_cg
					   , PlanStartDate_cg
					   , PlanType_cg
					   , PostalCode_cg
					   , PPTID_cg
					   , Primary_MPI_cg
					   , PrimarySSN_cg
					   , RetireeDate_cg
					   , SSN_cg
					   , State_cg
					   , TeamName_cg
					   , TermDate_cg
					   , UnionCd_cg
					   , UserID_cg
					   , WorkInd_cg
					   , WorkPhoneNum_cg,commit_time) 
			 SELECT
					CTE.PPTID
				  , GETDATE () AS LastModifiedDate
				  , @@Servername AS SVR
				  , DB_NAME () AS DBNAME
				  , CTE.SYS_CHANGE_VERSION
				  , CTE.SYS_CHANGE_COLUMNS
				  , @Typesave AS SYS_CHANGE_OPERATION
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'AddressLine1', 'columnid') , CTE.sys_change_columns) AS AddressLine1_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'AddressLine2', 'columnid') , CTE.sys_change_columns) AS AddressLine2_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'BenefitGrp', 'columnid') , CTE.sys_change_columns) AS BenefitGrp_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'BenefitStatus', 'columnid') , CTE.sys_change_columns) AS BenefitStatus_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'BirthDate', 'columnid') , CTE.sys_change_columns) AS BirthDate_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'ChangeStatusFlag', 'columnid') , CTE.sys_change_columns) AS ChangeStatusFlag_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'City', 'columnid') , CTE.sys_change_columns) AS City_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'ClientCMElig', 'columnid') , CTE.sys_change_columns) AS ClientCMElig_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'ClientCode', 'columnid') , CTE.sys_change_columns) AS ClientCode_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'ClientHRAElig', 'columnid') , CTE.sys_change_columns) AS ClientHRAElig_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'ClientID', 'columnid') , CTE.sys_change_columns) AS ClientID_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'ClientIncentiveElig', 'columnid') , CTE.sys_change_columns) AS ClientIncentiveElig_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'ClientLMElig', 'columnid') , CTE.sys_change_columns) AS ClientLMElig_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'ClientPlatformElig', 'columnid') , CTE.sys_change_columns) AS ClientPlatformElig_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'ClientScreeningElig', 'columnid') , CTE.sys_change_columns) AS ClientScreeningElig_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'Company', 'columnid') , CTE.sys_change_columns) AS Company_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'CompanyCd', 'columnid') , CTE.sys_change_columns) AS CompanyCd_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'CoverageType', 'columnid') , CTE.sys_change_columns) AS CoverageType_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'Custom1', 'columnid') , CTE.sys_change_columns) AS Custom1_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'Custom10', 'columnid') , CTE.sys_change_columns) AS Custom10_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'Custom11', 'columnid') , CTE.sys_change_columns) AS Custom11_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'Custom12', 'columnid') , CTE.sys_change_columns) AS Custom12_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'Custom13', 'columnid') , CTE.sys_change_columns) AS Custom13_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'Custom14', 'columnid') , CTE.sys_change_columns) AS Custom14_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'Custom15', 'columnid') , CTE.sys_change_columns) AS Custom15_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'Custom2', 'columnid') , CTE.sys_change_columns) AS Custom2_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'Custom3', 'columnid') , CTE.sys_change_columns) AS Custom3_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'Custom4', 'columnid') , CTE.sys_change_columns) AS Custom4_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'Custom5', 'columnid') , CTE.sys_change_columns) AS Custom5_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'Custom6', 'columnid') , CTE.sys_change_columns) AS Custom6_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'Custom7', 'columnid') , CTE.sys_change_columns) AS Custom7_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'Custom8', 'columnid') , CTE.sys_change_columns) AS Custom8_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'Custom9', 'columnid') , CTE.sys_change_columns) AS Custom9_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'DepartmentCd', 'columnid') , CTE.sys_change_columns) AS DepartmentCd_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'DepartmentName', 'columnid') , CTE.sys_change_columns) AS DepartmentName_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'Division', 'columnid') , CTE.sys_change_columns) AS Division_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'EmailAddress', 'columnid') , CTE.sys_change_columns) AS EmailAddress_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'EmployeeStatus', 'columnid') , CTE.sys_change_columns) AS EmployeeStatus_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'EmployeeType', 'columnid') , CTE.sys_change_columns) AS EmployeeType_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'FirstName', 'columnid') , CTE.sys_change_columns) AS FirstName_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'FlatFileName', 'columnid') , CTE.sys_change_columns) AS FlatFileName_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'Gender', 'columnid') , CTE.sys_change_columns) AS Gender_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'Hashbyte_Checksum', 'columnid') , CTE.sys_change_columns) AS Hashbyte_Checksum_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'HireDate', 'columnid') , CTE.sys_change_columns) AS HireDate_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'HomePhoneNum', 'columnid') , CTE.sys_change_columns) AS HomePhoneNum_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'IDCard', 'columnid') , CTE.sys_change_columns) AS IDCard_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'ItemGUID', 'columnid') , CTE.sys_change_columns) AS ItemGUID_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'JobCd', 'columnid') , CTE.sys_change_columns) AS JobCd_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'JobTitle', 'columnid') , CTE.sys_change_columns) AS JobTitle_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'Last_Update_Dt', 'columnid') , CTE.sys_change_columns) AS Last_Update_Dt_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'LastName', 'columnid') , CTE.sys_change_columns) AS LastName_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'LocationCd', 'columnid') , CTE.sys_change_columns) AS LocationCd_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'LocationName', 'columnid') , CTE.sys_change_columns) AS LocationName_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'MaritalStatus', 'columnid') , CTE.sys_change_columns) AS MaritalStatus_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'MatchMethodCode', 'columnid') , CTE.sys_change_columns) AS MatchMethodCode_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'MiddleInit', 'columnid') , CTE.sys_change_columns) AS MiddleInit_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'MobilePhoneNum', 'columnid') , CTE.sys_change_columns) AS MobilePhoneNum_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'MPI', 'columnid') , CTE.sys_change_columns) AS MPI_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'MPI_Relationship_Type', 'columnid') , CTE.sys_change_columns) AS MPI_Relationship_Type_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'PayCd', 'columnid') , CTE.sys_change_columns) AS PayCd_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'PayGrp', 'columnid') , CTE.sys_change_columns) AS PayGrp_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'PersonStatus', 'columnid') , CTE.sys_change_columns) AS PersonStatus_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'PersonType', 'columnid') , CTE.sys_change_columns) AS PersonType_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'PlanDescription', 'columnid') , CTE.sys_change_columns) AS PlanDescription_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'PlanEndDate', 'columnid') , CTE.sys_change_columns) AS PlanEndDate_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'PlanID', 'columnid') , CTE.sys_change_columns) AS PlanID_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'PlanName', 'columnid') , CTE.sys_change_columns) AS PlanName_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'PlanStartDate', 'columnid') , CTE.sys_change_columns) AS PlanStartDate_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'PlanType', 'columnid') , CTE.sys_change_columns) AS PlanType_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'PostalCode', 'columnid') , CTE.sys_change_columns) AS PostalCode_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'PPTID', 'columnid') , CTE.sys_change_columns) AS PPTID_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'Primary_MPI', 'columnid') , CTE.sys_change_columns) AS Primary_MPI_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'PrimarySSN', 'columnid') , CTE.sys_change_columns) AS PrimarySSN_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'RetireeDate', 'columnid') , CTE.sys_change_columns) AS RetireeDate_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'SSN', 'columnid') , CTE.sys_change_columns) AS SSN_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'State', 'columnid') , CTE.sys_change_columns) AS State_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'TeamName', 'columnid') , CTE.sys_change_columns) AS TeamName_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'TermDate', 'columnid') , CTE.sys_change_columns) AS TermDate_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'UnionCd', 'columnid') , CTE.sys_change_columns) AS UnionCd_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'UserID', 'columnid') , CTE.sys_change_columns) AS UserID_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'WorkInd', 'columnid') , CTE.sys_change_columns) AS WorkInd_cg
				  , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('HFit_PPTEligibility') , 'WorkPhoneNum', 'columnid') , CTE.sys_change_columns) AS WorkPhoneNum_cg
				  ,tc.commit_time
					FROM
						 CTE
							 JOIN sys.dm_tran_commit_table AS tc
								 ON CTE.sys_change_version = tc.commit_ts;

	 END;

GO
PRINT 'Executed proc_CT_HFIT_PPTEligibility_History.sql';
GO
