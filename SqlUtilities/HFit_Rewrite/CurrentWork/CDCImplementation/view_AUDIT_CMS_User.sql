

GO
PRINT 'Executing view_AUDIT_CMS_User.sql';
GO
IF EXISTS (SELECT
                  name
                  FROM sys.views
                  WHERE name = 'view_AUDIT_CMS_User') 
    BEGIN
        DROP VIEW
             view_AUDIT_CMS_User
    END;

GO

/*-------------------------------------------------
select * from STAGING_CMS_User
select * from STAGING_CMS_User_Update_History
select * from DIM_CMS_User_Audit
*/
-- select * from view_AUDIT_CMS_User order by UserID desc
/*------------------------------------------------------------------------------
HOW TO USE:
    select * from view_AUDIT_CMS_User
	   where CreateDate between '2015-09-18 14:55:33.000' and '2015-09-18 14:55:34'

    select * from view_AUDIT_CMS_User
	   where SysUser = 'dmiller'
*/

CREATE VIEW view_AUDIT_CMS_User
AS SELECT DISTINCT
          A.SysUser
        , A.IPADDR
        , A.CreateDate
        , A.SYS_CHANGE_OPERATION
        , A.SYS_CHANGE_VERSION as SysChangeVersion
        , S.*
          FROM
              DIM_CMS_User_Audit AS A
                  JOIN STAGING_CMS_User AS S
                      ON S.UserID = A.UserID;
GO
PRINT 'Executed view_AUDIT_CMS_User.sql';
GO
