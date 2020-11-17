
CREATE VIEW [dbo].[view_EDW_CoachingPPTAvailable]
AS
	SELECT 
		U.UserID
		,U.UserGUID
		,US1.HFitUserMpiNumber
		,S.SiteGUID
		,A.AccountID
		,A.AccountCD
		,A.AccountName
		,LME.RoleDisplayName AS LMRoleName
		,LME.RoleGUID AS LMRoleGUID
		,CASE
			WHEN LME.UserID IS NOT NULL THEN 1
			ELSE 0
		END AS IsLMAvailable
		,CME.RoleDisplayName AS CMRoleName
		,CME.RoleGUID AS CMRoleGUID
		,CASE
			WHEN CME.UserID IS NOT NULL THEN 1
			ELSE 0
		END AS IsCMAvailable
		,HAE.RoleDisplayName AS HARoleName
		,HAE.RoleGUID AS HARoleGUID
		,CASE
			WHEN HAE.UserID IS NOT NULL THEN 1
			ELSE 0
		END AS IsHAAvailable
	FROM
		CMS_User AS U
		JOIN dbo.CMS_UserSettings AS US1 ON U.UserID = US1.UserSettingsUserID
		JOIN dbo.CMS_UserSite AS US2 ON U.UserID = US2.UserID
		JOIN dbo.CMS_Site AS S ON US2.SiteID = S.SiteID
		JOIN dbo.HFit_Account AS A ON S.SiteID = A.SiteID
		LEFT JOIN (SELECT DISTINCT
					MU.UserID
					,R.SiteID
					,R.RoleDisplayName
					,R.RoleGUID
				FROM
					CMS_MembershipUser AS MU
					JOIN CMS_MembershipRole AS MR ON MU.[MembershipID] = MR.[MembershipID]
					JOIN CMS_Role AS R ON MR.RoleID = R.RoleID
						AND R.RoleDisplayName = '.Coaching') AS LME ON US2.SiteID = LME.SiteID
			AND U.UserID = LME.UserID
		LEFT JOIN (SELECT DISTINCT
					MU.UserID
					,R.SiteID
					,R.RoleDisplayName
					,R.RoleGUID
				FROM
					CMS_MembershipUser AS MU
					JOIN CMS_MembershipRole AS MR ON MU.[MembershipID] = MR.[MembershipID]
					JOIN CMS_Role AS R ON MR.RoleID = R.RoleID
						AND R.RoleDisplayName = '.CMAvailable') AS CME ON US2.SiteID = CME.SiteID
			AND U.UserID = CME.UserID
		LEFT JOIN (SELECT DISTINCT
					MU.UserID
					,R.SiteID
					,R.RoleDisplayName
					,R.RoleGUID
				FROM
					CMS_MembershipUser AS MU
					JOIN CMS_MembershipRole AS MR ON MU.[MembershipID] = MR.[MembershipID]
					JOIN CMS_Role AS R ON MR.RoleID = R.RoleID
						AND R.RoleDisplayName = '.HealthAdvising') AS HAE ON US2.SiteID = HAE.SiteID
			AND U.UserID = HAE.UserID
	WHERE ISNULL(US1.HFitUserMpiNumber, 0) > 0



GO


