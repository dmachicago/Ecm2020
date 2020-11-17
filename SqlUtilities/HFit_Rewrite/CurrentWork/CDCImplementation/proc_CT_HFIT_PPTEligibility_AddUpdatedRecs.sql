
-- use KenticoCMS_PRD_1

GO
PRINT 'Executing proc_CT_HFIT_PPTEligibility_AddUpdatedRecs.sql';
GO
IF EXISTS ( SELECT
                   name
                   FROM sys.procedures
                   WHERE name = 'proc_CT_HFIT_PPTEligibility_AddUpdatedRecs') 
    BEGIN
        DROP PROCEDURE
             proc_CT_HFIT_PPTEligibility_AddUpdatedRecs;
    END;
GO

/*----------------------------------------------------------
    exec proc_CT_HFIT_PPTEligibility_AddUpdatedRecs
    select * from STAGING_HFIT_PPTEligibility where SYS_CHANGE_VERSION is not null
*/

CREATE PROCEDURE proc_CT_HFIT_PPTEligibility_AddUpdatedRecs  (@SVR as nvarchar(100), @DBNAME as nvarchar(100))
AS
BEGIN
    WITH CTE (
         PPTID
       , SYS_CHANGE_VERSION
       , SYS_CHANGE_OPERATION
       , SYS_CHANGE_COLUMNS) 
        AS ( SELECT
                    CT.PPTID
                  , CT.SYS_CHANGE_VERSION
                  , CT.SYS_CHANGE_OPERATION
                  , SYS_CHANGE_COLUMNS
                    FROM CHANGETABLE (CHANGES HFIT_PPTEligibility, NULL) AS CT
                    WHERE SYS_CHANGE_OPERATION = 'U') 
        UPDATE S
               SET
                   S.PPTID = T.PPTID
                 ,S.ClientID = T.ClientID
                 ,S.ClientCode = T.ClientCode
                 ,S.UserID = T.UserID
                 ,S.IDCard = T.IDCard
                 ,S.FirstName = T.FirstName
                 ,S.LastName = T.LastName
                 ,S.MiddleInit = T.MiddleInit
                 ,S.BirthDate = T.BirthDate
                 ,S.Gender = T.Gender
                 ,S.AddressLine1 = T.AddressLine1
                 ,S.AddressLine2 = T.AddressLine2
                 ,S.City = T.City
                 ,S.State = T.State
                 ,S.PostalCode = T.PostalCode
                 ,S.HomePhoneNum = T.HomePhoneNum
                 ,S.WorkPhoneNum = T.WorkPhoneNum
                 ,S.MobilePhoneNum = T.MobilePhoneNum
                 ,S.EmailAddress = T.EmailAddress
                 ,S.MPI = T.MPI
                 ,S.MatchMethodCode = T.MatchMethodCode
                 ,S.SSN = T.SSN
                 ,S.PrimarySSN = T.PrimarySSN
                 ,S.HireDate = T.HireDate
                 ,S.TermDate = T.TermDate
                 ,S.RetireeDate = T.RetireeDate
                 ,S.PlanName = T.PlanName
                 ,S.PlanDescription = T.PlanDescription
                 ,S.PlanID = T.PlanID
                 ,S.PlanStartDate = T.PlanStartDate
                 ,S.PlanEndDate = T.PlanEndDate
                 ,S.Company = T.Company
                 ,S.CompanyCd = T.CompanyCd
                 ,S.LocationName = T.LocationName
                 ,S.LocationCd = T.LocationCd
                 ,S.DepartmentName = T.DepartmentName
                 ,S.DepartmentCd = T.DepartmentCd
                 ,S.UnionCd = T.UnionCd
                 ,S.BenefitGrp = T.BenefitGrp
                 ,S.PayGrp = T.PayGrp
                 ,S.Division = T.Division
                 ,S.JobTitle = T.JobTitle
                 ,S.JobCd = T.JobCd
                 ,S.TeamName = T.TeamName
                 ,S.MaritalStatus = T.MaritalStatus
                 ,S.PersonType = T.PersonType
                 ,S.PersonStatus = T.PersonStatus
                 ,S.EmployeeType = T.EmployeeType
                 ,S.CoverageType = T.CoverageType
                 ,S.EmployeeStatus = T.EmployeeStatus
                 ,S.PayCd = T.PayCd
                 ,S.BenefitStatus = T.BenefitStatus
                 ,S.PlanType = T.PlanType
                 ,S.ClientPlatformElig = T.ClientPlatformElig
                 ,S.ClientHRAElig = T.ClientHRAElig
                 ,S.ClientLMElig = T.ClientLMElig
                 ,S.ClientIncentiveElig = T.ClientIncentiveElig
                 ,S.ClientCMElig = T.ClientCMElig
                 ,S.ClientScreeningElig = T.ClientScreeningElig
                 ,S.Custom1 = T.Custom1
                 ,S.Custom2 = T.Custom2
                 ,S.Custom3 = T.Custom3
                 ,S.Custom4 = T.Custom4
                 ,S.Custom5 = T.Custom5
                 ,S.Custom6 = T.Custom6
                 ,S.Custom7 = T.Custom7
                 ,S.Custom8 = T.Custom8
                 ,S.Custom9 = T.Custom9
                 ,S.Custom10 = T.Custom10
                 ,S.Custom11 = T.Custom11
                 ,S.Custom12 = T.Custom12
                 ,S.Custom13 = T.Custom13
                 ,S.Custom14 = T.Custom14
                 ,S.Custom15 = T.Custom15
                 ,S.ChangeStatusFlag = T.ChangeStatusFlag
                 ,S.Last_Update_Dt = T.Last_Update_Dt
                 ,S.FlatFileName = T.FlatFileName
                 ,S.ItemGUID = T.ItemGUID
                 ,S.Hashbyte_Checksum = T.Hashbyte_Checksum
                 ,S.Primary_MPI = T.Primary_MPI
                 ,S.MPI_Relationship_Type = T.MPI_Relationship_Type
                 ,S.WorkInd = T.WorkInd

                 ,S.LastModifiedDate = GETDATE () 
                 ,S.DeletedFlg = NULL
                 ,S.ConvertedToCentralTime = NULL
                 ,S.SYS_CHANGE_VERSION = CTE.SYS_CHANGE_VERSION

                   FROM STAGING_HFIT_PPTEligibility AS S
                            JOIN
                            HFIT_PPTEligibility AS T
                                ON
                                S.PPTID = T.PPTID
                            AND S.DeletedFlg IS NULL
                            JOIN CTE
                                ON CTE.PPTID = T.PPTID
                               AND (CTE.SYS_CHANGE_VERSION != S.SYS_CHANGE_VERSION
                                 OR S.SYS_CHANGE_VERSION IS NULL);

    DECLARE
    @iCnt AS int = @@ROWCOUNT;
    PRINT 'Updated Count: ' + CAST ( @iCnt AS nvarchar (50)) ;

	exec proc_CT_HFIT_PPTEligibility_History 'U' ;
    
    RETURN @iCnt;
END;

GO
PRINT 'Executed proc_CT_HFIT_PPTEligibility_AddUpdatedRecs.sql';
GO
 