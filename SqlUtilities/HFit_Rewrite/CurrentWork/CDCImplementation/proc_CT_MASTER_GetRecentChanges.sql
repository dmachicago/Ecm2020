

select DBNAME, UserID, UserGUID,LastModifiedDate,CT_UserGUID
--into #BASE_CMS_user_Updates
from BASE_CMS_user 
where CT_UserGUID = 1 and LastModifiedDate >= '2016-08-09 11:46:52.2630000'

select DBNAME, UserSettingsUserID, HFitUserMpiNumber,LastModifiedDate,CT_HFitUserMpiNumber
--into #BASE_CMS_UserSettings_Updates
from BASE_CMS_UserSettings
where CT_HFitUserMpiNumber = 1 and LastModifiedDate >= '2016-08-09 11:46:52.2630000'



select DBNAME, SiteID, SiteGUID,LastModifiedDate,CT_HFitUserMpiNumber
--into #BASE_CMS_UserSettings_Updates
from BASE_CMS_UserSite
where (CT_SiteID = 1 or CT_SiteGUID = 1)
and LastModifiedDate >= '2016-08-09 11:46:52.2630000'

    SELECT U.SVR
         , U.DBNAME
         , U.UserID
         , SiteGuid
         , U.SiteID 	    
	    , CMSSite.CT_SiteGuid
	    , CMSSite.CT_SiteID
	    , CMSSite.LastModifiedDate as Site_LastModifiedDate
	    , U.LastModifiedDate as User_LastModifiedDate
	 INTO ##TEMP_HA_SiteData
      FROM dbo.BASE_CMS_UserSite AS U
           INNER JOIN
           dbo.BASE_CMS_Site AS CMSSite
           ON U.SiteID = CMSSite.SiteID
          AND U.SVR = CMSSite.SVR
          AND U.DBNAME = CMSSite.DBNAME;
