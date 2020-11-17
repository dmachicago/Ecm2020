
GO 
print 'Creating view view_EDW_CoachingPPTEligible';
print 'FROM view_EDW_CoachingPPTEnrolled.sql';
GO
-- select top 100 * from view_EDW_CoachingPPTEligible
-- select count(*) from view_EDW_CoachingPPTEligible
if not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RoleDisplayName' and TABLE_NAME = 'CMS_Role')
    alter table CMS_Role add RoleDisplayName nvarchar(100) null ;

go
if exists (select name from sys.views where name = 'view_EDW_CoachingPPTEligible')
    drop view view_EDW_CoachingPPTEligible
go
CREATE VIEW [dbo].[view_EDW_CoachingPPTEligible]
AS
       SELECT
              U.UserID
              ,U.UserGUID
              ,US1.HFitUserMpiNumber
              ,S.SiteGUID
              ,A.AccountID
              ,A.AccountCD
              ,A.AccountName
              ,TMP.RoleGUID
              --,TMP.RoleDisplayName
		, 'SYSTEM.Coaching Eligible'  as RoleDisplayName
		    ,TMP.RoleName
              ,TMP.CoachingDescription
              ,TMP.ServiceLevelDescription
       FROM
              CMS_User AS U
              JOIN dbo.CMS_UserSettings AS US1 ON U.UserID = US1.UserSettingsUserID
              JOIN dbo.CMS_UserSite AS US2 ON U.UserID = US2.UserID
              JOIN dbo.CMS_Site AS S ON US2.SiteID = S.SiteID
              JOIN dbo.HFit_Account AS A ON S.SiteID = A.SiteID
              JOIN (SELECT
                                  CUSL.UserID
                                  ,NULL AS RoleGUID
                                  --,NULL AS RoleDisplayName
							 ,NULL AS RoleName
                                  ,CSL.Description AS ServiceLevelDescription
                                  ,'CM' AS CoachingDescription
                           FROM
                                  HFit_CoachingUserServiceLevel AS CUSL
                                  JOIN HFit_LKP_CoachingServiceLevel AS CSL ON CUSL.ServiceLevelItemID = CSL.ItemID
                                         AND CSL.IsConditionManagement = 1 -- CM
                           WHERE CUSL.ServiceLevelStatusItemID = 2 -- Recommended (Eligible ONLY CM)
                           UNION
                           SELECT
                                  MU.UserID
                                  ,R.RoleGUID
                                  --,R.RoleDisplayName
							 ,R.RoleName
                                  ,'LM' AS ServiceLevelDescription
                                  ,'LM' AS CoachingDescription
                           FROM
                                  CMS_MembershipUser AS MU
                                  JOIN CMS_MembershipRole AS MR ON MU.[MembershipID] = MR.[MembershipID]
                                  JOIN CMS_Role AS R ON MR.RoleID = R.RoleID
                                         AND R.RoleDisplayName = 'SYSTEM.Coaching Eligible') AS TMP ON U.UserID = TMP.UserID -- Eligible (ONLY LM)
       WHERE ISNULL(US1.HFitUserMpiNumber, 0) > 0
GO
print 'Created view view_EDW_CoachingPPTEligible';
print 'FROM view_EDW_CoachingPPTEnrolled.sql';
GO
