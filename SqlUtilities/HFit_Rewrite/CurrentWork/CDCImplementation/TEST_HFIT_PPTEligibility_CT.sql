

--drop table TEMP_HFIT_PPTEligibility_1000
if not exists (select name from sys.tables where name = 'TEMP_HFIT_PPTEligibility_1000')
begin
    select * into TEMP_HFIT_PPTEligibility_1000 from HFIT_PPTEligibility ;
    CREATE UNIQUE CLUSTERED INDEX [PI_TEMP_HFIT_PPTEligibility_1000] ON [dbo].[TEMP_HFIT_PPTEligibility_1000]
    (
	   [PPTID] ASC
    )
end 

update HFIT_PPTEligibility set FirstName = lower(FirstName) where PPTID in (select top 2000 PPTID from HFIT_PPTEligibility order by PPTID desc )

SELECT count(*)	--,CT.PPTID, CT.SYS_CHANGE_VERSION, CT.SYS_CHANGE_OPERATION
				FROM CHANGETABLE (CHANGES HFIT_PPTEligibility, NULL) AS CT
				WHERE SYS_CHANGE_OPERATION = 'U'
select count(*), SYS_CHANGE_OPERATION from STAGING_HFIT_PPTEligibility_Audit group by SYS_CHANGE_OPERATION

exec proc_STAGING_EDW_HFIT_PPTEligibility

delete from HFIT_PPTEligibility where PPTID in (select top 3000 PPTID from HFIT_PPTEligibility order by PPTID desc )
SELECT count(*)	--,CT.PPTID, CT.SYS_CHANGE_VERSION, CT.SYS_CHANGE_OPERATION
						FROM CHANGETABLE (CHANGES HFIT_PPTEligibility, NULL) AS CT
						WHERE SYS_CHANGE_OPERATION = 'D'
select count(*), SYS_CHANGE_OPERATION from STAGING_HFIT_PPTEligibility_Audit group by SYS_CHANGE_OPERATION

exec proc_STAGING_EDW_HFIT_PPTEligibility

go
SET IDENTITY_INSERT HFIT_PPTEligibility ON;
GO

with CTE (PPTID)
as(
    select PPTID from TEMP_HFIT_PPTEligibility_1000
    except 
    select PPTID from HFit_PPTEligibility
)
INSERT INTO HFit_PPTEligibility
(
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
      , WorkInd )
 SELECT 
     CTE.PPTID
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
FROM TEMP_HFIT_PPTEligibility_1000
    join CTE on CTE.PPTID = TEMP_HFIT_PPTEligibility_1000.PPTID

go

SET IDENTITY_INSERT HFIT_PPTEligibility OFF;
GO

SELECT count(*)	--,CT.PPTID, CT.SYS_CHANGE_VERSION, CT.SYS_CHANGE_OPERATION
						FROM CHANGETABLE (CHANGES HFIT_PPTEligibility, NULL) AS CT
						WHERE SYS_CHANGE_OPERATION = 'I'
select count(*), SYS_CHANGE_OPERATION from STAGING_HFIT_PPTEligibility_Audit group by SYS_CHANGE_OPERATION

exec proc_STAGING_EDW_HFIT_PPTEligibility

go

select * from view_AUDIT_HFit_PPTEligibility
    where PPTID in (select top 10 PPTID from HFIT_PPTEligibility order by PPTID desc)
	   order by PPTID
/*
select top 50 * from STAGING_HFIT_PPTEligibility_Audit order by PPTID
select top 50 * from STAGING_HFIT_PPTEligibility_Update_History order by PPTID
select top 50 * from STAGING_HFIT_PPTEligibility_Update_History where AddressLine1_cg <> 1 order by PPTID
*/