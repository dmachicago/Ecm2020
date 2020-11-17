

go
print 'Executing view_AUDIT_CMS_UserSite.sql'
go
if exists (select name from sys.views where name = 'view_AUDIT_CMS_UserSite')
    drop view view_AUDIT_CMS_UserSite;

go

/*---------------------------------------------------
select * from STAGING_CMS_UserSite
select * from STAGING_CMS_UserSite_Update_History
select * from STAGING_CMS_UserSite_Audit
*/
-- select * from view_AUDIT_CMS_UserSite order by UserSiteID
/*
HOW TO USE:
    select * from view_AUDIT_CMS_UserSite order by UserSiteID
	   where CreateDate between '2015-09-18 14:55:33.000' and '2015-09-18 14:55:34'

    select * from view_AUDIT_CMS_UserSite
	   where SysUser = 'dmiller'
*/

CREATE VIEW view_AUDIT_CMS_UserSite
AS 
SELECT distinct
          A.SysUser
        , A.IPADDR
        , A.CreateDate
        , A.SYS_CHANGE_OPERATION
        , A.SYS_CHANGE_VERSION as SysChangeVersion
        , S.*
          FROM
		  STAGING_CMS_UserSite_Audit	as A
		  join STAGING_CMS_UserSite AS S
                      ON S.UserSiteID = A.UserSiteID ;
go
print 'Executed view_AUDIT_CMS_UserSite.sql'
go
