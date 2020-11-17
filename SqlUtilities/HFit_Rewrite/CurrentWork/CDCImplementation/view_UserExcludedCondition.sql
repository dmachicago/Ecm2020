

-- use KenticoCMS_Datamart_2;
-- select top 100 * from view_UserExcludedCondition
GO
PRINT 'Executing view_UserExcludedCondition.sql';
GO
IF EXISTS (SELECT
                  name
           FROM sys.views
           WHERE
                  name = 'view_UserExcludedCondition') 
    BEGIN
        DROP VIEW
             view_UserExcludedCondition;
    END;
GO
-- exec proc_UpdateSurrogateKeyDataBetweenParentAndChild "BASE_CMS_User", "SurrogateKey_CMS_User","BASE_HFit_LKP_CoachingCMExclusions","UserID", "UserID",1
--select * from BASE_HFit_LKP_CoachingCMExclusions
--Excluding conditions assigned to user
CREATE VIEW view_UserExcludedCondition
AS 
    SELECT
          UserExclusion.ItemID
        , UserExclusion.UserId
        , UserExclusion.ExclusionItemID
        , UserExclusion.ItemCreatedBy
        , UserExclusion.ItemCreatedWhen
        , UserExclusion.ItemModifiedBy
        , UserExclusion.ItemModifiedWhen
        , UserExclusion.ItemOrder
        , UserExclusion.ItemGUID
        , exc.[Description] AS ExcludedCondition
        , UserExclusion.HashCode        
        , UserExclusion.LastModifiedDate
        , UserExclusion.[Action]
        , UserExclusion.SYS_CHANGE_VERSION
        , UserExclusion.SVR
        , UserExclusion.DBNAME
	   , UserExclusion.SurrogateKey_Hfit_CoachingUserCMExclusion
        , CMSUSER.SurrogateKey_CMS_User
   FROM dbo.BASE_Hfit_CoachingUserCMExclusion AS UserExclusion
        INNER JOIN BASE_HFit_LKP_CoachingCMExclusions AS exc
        ON
          UserExclusion.ExclusionItemID = exc.ItemID AND
          UserExclusion.SVR = exc.SVR AND
          UserExclusion.DBNAME = exc.DBNAME
        INNER JOIN BASE_CMS_User AS CMSUSER
        ON
          CMSUSER.SVR = UserExclusion.SVR AND
          CMSUSER.DBNAME = UserExclusion.DBNAME AND
          CMSUSER.UserId = UserExclusion.UserId;
GO
PRINT 'Executing view_UserExcludedCondition.sql';
GO
