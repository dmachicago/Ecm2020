

---- use KenticoCMS_Datamart_2;
-- select top 100 * from view_CoachEnrolledPPTCondition
GO
PRINT 'Executing view_CoachEnrolledPPTCondition.sql';
GO
IF EXISTS (SELECT
                  name
           FROM sys.views
           WHERE
                  name = 'view_CoachEnrolledPPTCondition') 
    BEGIN
        DROP VIEW
             view_CoachEnrolledPPTCondition;
    END;
GO
-- exec proc_UpdateSurrogateKeyDataBetweenParentAndChild "BASE_CMS_User", "SurrogateKey_CMS_User","BASE_HFit_LKP_CoachingCMConditions","UserID", "UserID",1

-- select top 100 * from view_CoachEnrolledPPTCondition
--Conditions assigned to user
--IsPrimary = Primary CM Condition (assigned by triage process)
--IsEnrolled = Coach must enroll PPT in Condition
CREATE VIEW view_CoachEnrolledPPTCondition
AS SELECT  
          usr.ItemModifiedWhen AS CoachEnrolledPPTConditionDate
        , USR.ItemID
        , USR.UserId
        , USR.ConditionItemID
        , USR.IsPrimary
        , USR.IsEnrolled
        , USR.ItemCreatedBy
        , USR.ItemCreatedWhen
        , USR.ItemModifiedBy
        , USR.ItemModifiedWhen
        , USR.ItemOrder
        , USR.ItemGUID
        , USR.HashCode
        , USR.SVR
        , USR.DBNAME
        , USR.LastModifiedDate
        , USR.[Action]
        , USR.SYS_CHANGE_VERSION
        , cond.[description] as CoachingCondition
	   , USR.SurrogateKey_Hfit_CoachingUserCMCondition        
        , CMSUSER.SurrogateKey_CMS_User
        , PPTEligibility.SurrogateKey_hfit_PPTEligibility
   FROM dbo.BASE_Hfit_CoachingUserCMCondition AS USR
        INNER JOIN BASE_HFit_LKP_CoachingCMConditions AS cond
        ON
          usr.ConditionItemID = cond.ItemID AND
          usr.SVR = cond.SVR AND
          usr.DBNAME = cond.DBNAME
        INNER JOIN BASE_CMS_User AS CMSUSER
        ON
          CMSUSER.SVR = CMSUSER.SVR AND
          CMSUSER.DBNAME = CMSUSER.DBNAME AND
          CMSUSER.UserId = CMSUSER.UserId
        inner JOIN BASE_hfit_PPTEligibility AS PPTEligibility
        ON
          PPTEligibility.SurrogateKey_CMS_User = CMSUSER.SurrogateKey_CMS_User;

GO
PRINT 'Executed CoachEnrolledPPTConditionDate.sql';
GO

