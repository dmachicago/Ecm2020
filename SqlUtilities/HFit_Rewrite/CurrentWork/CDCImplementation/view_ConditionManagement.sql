
-- use KenticoCMS_Datamart_2
-- select top 100 * from view_ConditionManagement
GO
PRINT 'Executing view_ConditionManagement.sql';
GO
IF EXISTS (SELECT
                  name
           FROM sys.views
           WHERE
                  name = 'view_ConditionManagement') 
    BEGIN
        DROP VIEW
             view_ConditionManagement
    END;
GO

CREATE VIEW view_ConditionManagement
AS SELECT
          cusl.ItemCreatedWhen AS ConditionManagementStartDate
        , cusl.ItemID
        , cusl.UserId
        , cusl.ServiceLevelItemID
        , cusl.ServiceLevelStatusItemID
        , cusl.ItemCreatedBy
        , cusl.ItemCreatedWhen
        , cusl.ItemModifiedBy
        , cusl.ItemModifiedWhen
        , cusl.ItemOrder
        , cusl.ItemGUID
        , csls.[Description] AS CoachingServiceLevel
        , cusl.HashCode        
        , cusl.LastModifiedDate
        , cusl.[ACTION]
        , cusl.SYS_CHANGE_VERSION
        , cusl.SVR
        , cusl.DBNAME
	   , cusl.SurrogateKey_HFit_CoachingUserServiceLevel
	   , csls.SurrogateKey_HFit_LKP_CoachingServiceLevelStatus
        , CMSUSER.SurrogateKey_CMS_User
   FROM BASE_HFit_CoachingUserServiceLevel AS cusl ---This is coaching service level for the user
        INNER JOIN BASE_HFit_LKP_CoachingServiceLevel AS csl
        ON
          cusl.ServiceLevelItemID = csl.ItemID AND
          cusl.SVR = csl.SVR AND
          cusl.DBNAME = csl.DBNAME
        INNER JOIN BASE_CMS_user AS CMSUSER
        ON
          CMSUSER.SVR = cusl.SVR AND
          CMSUSER.DBNAME = cusl.DBNAME AND
          CMSUSER.UserID = cusl.UserID
        INNER JOIN BASE_HFit_LKP_CoachingServiceLevelStatus AS csls
        ON
          cusl.ServiceLevelStatusItemID = csls.ItemID AND
          cusl.SVR = csls.SVR AND
          cusl.DBNAME = csls.DBNAME
   WHERE
          csl.IsConditionManagement = 1 AND
          csls.[Description] = 'Enrolled';
GO
PRINT 'Executed view_ConditionManagement.sql';
GO

-- Service Levels
-- LM  = Lifestyle Management
-- AP  = Advanced Practice (Condition Management)
-- RN  = Registered Nurse (Condition Management)
-- select * from [BASE_HFit_LKP_CoachingServiceLevel]