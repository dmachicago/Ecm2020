
GO 
print 'Creating view view_EDW_CoachingPPTEnrolled';
print 'FROM view_EDW_CoachingPPTEnrolled.sql';
GO
if exists (select name from sys.views where name = 'view_EDW_CoachingPPTEnrolled')
    drop view view_EDW_CoachingPPTEnrolled
go

-- select count(*) from view_EDW_CoachingPPTEnrolled
CREATE VIEW [dbo].[view_EDW_CoachingPPTEnrolled]
AS
       SELECT
              U.UserID
              ,U.UserGUID
              ,US1.HFitUserMpiNumber
              ,S.SiteGUID
              ,A.AccountID
              ,A.AccountCD
              ,A.AccountName
              ,R.RoleGUID
              ,R.RoleDisplayName
		    ,R.RoleName
              ,CASE
                     WHEN CSL.IsConditionManagement = 0 THEN 'LM'
                     WHEN CSL.IsConditionManagement = 1 THEN 'CM'
                     ELSE NULL
              END AS CoachingDescription
              ,CSL.Description AS ServiceLevelDescription
       FROM
              CMS_User AS U
              JOIN dbo.CMS_UserSettings AS US1 ON U.UserID = US1.UserSettingsUserID
              JOIN dbo.CMS_UserSite AS US2 ON U.UserID = US2.UserID
              JOIN dbo.CMS_Site AS S ON US2.SiteID = S.SiteID
              JOIN dbo.HFit_Account AS A ON S.SiteID = A.SiteID
              JOIN CMS_UserRole AS UR ON U.UserID = UR.UserID
              JOIN CMS_Role AS R ON UR.RoleID = R.RoleID
                     AND R.RoleDisplayName = 'SYSTEM.Coaching Enrollment' -- Enrolled (BOTH LM and CM)
              LEFT JOIN HFit_CoachingUserServiceLevel AS CUSL ON U.UserID = CUSL.UserID
                     AND CUSL.ServiceLevelStatusItemID = 1 -- Enrolled
              LEFT JOIN HFit_LKP_CoachingServiceLevel AS CSL ON CUSL.ServiceLevelItemID = CSL.ItemID
       WHERE ISNULL(US1.HFitUserMpiNumber, 0) > 0
GO
print 'Created view view_EDW_CoachingPPTEnrolled';
print 'FROM view_EDW_CoachingPPTEnrolled.sql';
GO
