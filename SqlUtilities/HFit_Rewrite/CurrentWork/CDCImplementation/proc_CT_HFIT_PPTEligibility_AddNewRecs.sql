
GO
-- use KenticoCMS_PRD_1

PRINT 'Executing proc_CT_HFIT_PPTEligibility_AddNewRecs.sql';
GO
IF EXISTS (SELECT
                  name
                  FROM sys.procedures
                  WHERE name = 'proc_CT_HFIT_PPTEligibility_AddNewRecs') 
    BEGIN
        DROP PROCEDURE
             proc_CT_HFIT_PPTEligibility_AddNewRecs;
    END;
GO
-- exec proc_CT_HFIT_PPTEligibility_AddNewRecs
CREATE PROCEDURE proc_CT_HFIT_PPTEligibility_AddNewRecs (@SVR as nvarchar(100), @DBNAME as nvarchar(100))
AS
BEGIN

    --SET IDENTITY_INSERT STAGING_HFIT_PPTEligibility ON;

    WITH CTE (
         PPTID) 
        AS (SELECT
                   PPTID
                   FROM HFIT_PPTEligibility
            EXCEPT
            SELECT
                   PPTID
                   FROM STAGING_HFIT_PPTEligibility
                   WHERE DeletedFlg IS NULL) 
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
             , WorkInd
             , LastModifiedDate
               --,[RowNbr]
             , DeletedFlg
             , TimeZone
             , ConvertedToCentralTime
             , SVR
             , DBNAME
             , SYS_CHANGE_VERSION) 
        SELECT
               T.PPTID
             , T.ClientID
             , T.ClientCode
             , T.UserID
             , T.IDCard
             , T.FirstName
             , T.LastName
             , T.MiddleInit
             , T.BirthDate
             , T.Gender
             , T.AddressLine1
             , T.AddressLine2
             , T.City
             , T.State
             , T.PostalCode
             , T.HomePhoneNum
             , T.WorkPhoneNum
             , T.MobilePhoneNum
             , T.EmailAddress
             , T.MPI
             , T.MatchMethodCode
             , T.SSN
             , T.PrimarySSN
             , T.HireDate
             , T.TermDate
             , T.RetireeDate
             , T.PlanName
             , T.PlanDescription
             , T.PlanID
             , T.PlanStartDate
             , T.PlanEndDate
             , T.Company
             , T.CompanyCd
             , T.LocationName
             , T.LocationCd
             , T.DepartmentName
             , T.DepartmentCd
             , T.UnionCd
             , T.BenefitGrp
             , T.PayGrp
             , T.Division
             , T.JobTitle
             , T.JobCd
             , T.TeamName
             , T.MaritalStatus
             , T.PersonType
             , T.PersonStatus
             , T.EmployeeType
             , T.CoverageType
             , T.EmployeeStatus
             , T.PayCd
             , T.BenefitStatus
             , T.PlanType
             , T.ClientPlatformElig
             , T.ClientHRAElig
             , T.ClientLMElig
             , T.ClientIncentiveElig
             , T.ClientCMElig
             , T.ClientScreeningElig
             , T.Custom1
             , T.Custom2
             , T.Custom3
             , T.Custom4
             , T.Custom5
             , T.Custom6
             , T.Custom7
             , T.Custom8
             , T.Custom9
             , T.Custom10
             , T.Custom11
             , T.Custom12
             , T.Custom13
             , T.Custom14
             , T.Custom15
             , T.ChangeStatusFlag
             , T.Last_Update_Dt
             , T.FlatFileName
             , T.ItemGUID
             , T.Hashbyte_Checksum
             , T.Primary_MPI
             , T.MPI_Relationship_Type
             , T.WorkInd
             , GETDATE () AS LastModifiedDate
             , NULL AS DeletedFlg
             , NULL AS TimeZone
             , NULL AS ConvertedToCentralTime
             , @@SERVERNAME AS SVR
             , DB_NAME () AS DBNAME
             , NULL AS SYS_CHANGE_VERSION
               FROM
                   HFIT_PPTEligibility AS T
                       JOIN CTE AS S
                           ON S.PPTID = T.PPTID;
    DECLARE @iInserts AS int = @@ROWCOUNT;
    --SET IDENTITY_INSERT STAGING_HFIT_PPTEligibility OFF;
    PRINT 'NEW Insert Count: ' + CAST (@iInserts AS nvarchar (50)) ;
    EXEC proc_CT_HFIT_PPTEligibility_History 'I';

    RETURN @iInserts;
END;

GO
PRINT 'Executed proc_CT_HFIT_PPTEligibility_AddNewRecs.sql';
GO
