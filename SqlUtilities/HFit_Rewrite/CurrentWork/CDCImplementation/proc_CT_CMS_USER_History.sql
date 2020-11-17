
GO
PRINT 'Executing proc_CT_CMS_USER_History.sql';
GO
IF EXISTS (SELECT
                  name
                  FROM sys.procedures
                  WHERE name = 'proc_CT_CMS_USER_History') 
    BEGIN
        DROP PROCEDURE
             proc_CT_CMS_USER_History;
    END;
GO

/*-------------------------------------------------------------------------
*************************************************************************

select tc.commit_time, *
from
    changetable(changes CMS_USER, 0) c
    join sys.dm_tran_commit_table tc on c.sys_change_version = tc.commit_ts


exec proc_CT_CMS_USER_History 'I'
exec proc_CT_CMS_USER_History 'D'
exec proc_CT_CMS_USER_History 'U'

truncate table STAGING_CMS_USER_Update_History
select * from STAGING_CMS_USER_Update_History

SELECT CHANGE_TRACKING_MIN_VALID_VERSION(OBJECT_ID('CMS_USER'))
*************************************************************************
*/

CREATE PROCEDURE proc_CT_CMS_USER_History (
     @Typesave AS nchar (1)) 
AS
BEGIN
    WITH CTE (
         UserID
       , SYS_CHANGE_VERSION
       , SYS_CHANGE_COLUMNS) 
        AS (SELECT
                   CT.UserID
                 , CT.SYS_CHANGE_VERSION
                 , SYS_CHANGE_COLUMNS
                   FROM CHANGETABLE (CHANGES CMS_USER, NULL) AS CT
                   WHERE SYS_CHANGE_OPERATION = @Typesave
            EXCEPT
            SELECT
                   UserID
                 , SYS_CHANGE_VERSION
                 , SYS_CHANGE_COLUMNS
                   FROM STAGING_CMS_USER_Update_History) 
        INSERT INTO STAGING_CMS_USER_Update_History
        (
               Userid
             , SYS_CHANGE_VERSION
             , SYS_CHANGE_OPERATION
             , SYS_CHANGE_COLUMNS
             --, CurrUser
             --, SysUser
             --, IPADDR
             , commit_time
             , LastModifiedDate
             , SVR
             , DBNAME
             , Email_cg
             , FirstName_cg
             , FullName_cg
             , LastLogon_cg
             , LastName_cg
             , MiddleName_cg
             , PreferredCultureCode_cg
             , PreferredUICultureCode_cg
             , UserCreated_cg
             , UserEnabled_cg
             , UserGUID_cg
             , UserHasAllowedCultures_cg
             , UserID_cg
             , UserIsDomain_cg
             , UserIsEditor_cg
             , UserIsExternal_cg
             , UserIsGlobalAdministrator_cg
             , UserIsHidden_cg
             , UserLastLogonInfo_cg
             , UserLastModified_cg
             , UserMFRequired_cg
             , UserName_cg
             , UserPassword_cg
             , UserPasswordBuffer_cg
             , UserPasswordFormat_cg
             , UserSiteManagerDisabled_cg
             , UserStartingAliasPath_cg
             , UserTokenID_cg
             , UserTokenIteration_cg
             , UserVisibility_cg) 
        SELECT
               CTE.Userid
             , CTE.SYS_CHANGE_VERSION
             , @Typesave as SYS_CHANGE_OPERATION
             , CTE.SYS_CHANGE_COLUMNS
             --, CurrUser
             --, SysUser
             --, IPADDR
             , isnull(tc.commit_time, getdate())
             , GETDATE () AS LastModifiedDate
             , @@Servername AS SVR
             , DB_NAME () AS DBNAME
               --********************************************     
             , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_User') , 'Email', 'columnid') , CTE.sys_change_columns) AS Email_cg
             , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_User') , 'FirstName', 'columnid') , CTE.sys_change_columns) AS FirstName_cg
             , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_User') , 'FullName', 'columnid') , CTE.sys_change_columns) AS FullName_cg
             , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_User') , 'LastLogon', 'columnid') , CTE.sys_change_columns) AS LastLogon_cg
             , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_User') , 'LastName', 'columnid') , CTE.sys_change_columns) AS LastName_cg
             , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_User') , 'MiddleName', 'columnid') , CTE.sys_change_columns) AS MiddleName_cg
             , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_User') , 'PreferredCultureCode', 'columnid') , CTE.sys_change_columns) AS PreferredCultureCode_cg
             , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_User') , 'PreferredUICultureCode', 'columnid') , CTE.sys_change_columns) AS PreferredUICultureCode_cg
             , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_User') , 'UserCreated', 'columnid') , CTE.sys_change_columns) AS UserCreated_cg
             , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_User') , 'UserEnabled', 'columnid') , CTE.sys_change_columns) AS UserEnabled_cg
             , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_User') , 'UserGUID', 'columnid') , CTE.sys_change_columns) AS UserGUID_cg
             , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_User') , 'UserHasAllowedCultures', 'columnid') , CTE.sys_change_columns) AS UserHasAllowedCultures_cg
             , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_User') , 'UserID', 'columnid') , CTE.sys_change_columns) AS UserID_cg
             , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_User') , 'UserIsDomain', 'columnid') , CTE.sys_change_columns) AS UserIsDomain_cg
             , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_User') , 'UserIsEditor', 'columnid') , CTE.sys_change_columns) AS UserIsEditor_cg
             , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_User') , 'UserIsExternal', 'columnid') , CTE.sys_change_columns) AS UserIsExternal_cg
             , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_User') , 'UserIsGlobalAdministrator', 'columnid') , CTE.sys_change_columns) AS UserIsGlobalAdministrator_cg
             , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_User') , 'UserIsHidden', 'columnid') , CTE.sys_change_columns) AS UserIsHidden_cg
             , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_User') , 'UserLastLogonInfo', 'columnid') , CTE.sys_change_columns) AS UserLastLogonInfo_cg
             , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_User') , 'UserLastModified', 'columnid') , CTE.sys_change_columns) AS UserLastModified_cg
             , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_User') , 'UserMFRequired', 'columnid') , CTE.sys_change_columns) AS UserMFRequired_cg
             , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_User') , 'UserName', 'columnid') , CTE.sys_change_columns) AS UserName_cg
             , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_User') , 'UserPassword', 'columnid') , CTE.sys_change_columns) AS UserPassword_cg
             , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_User') , 'UserPasswordBuffer', 'columnid') , CTE.sys_change_columns) AS UserPasswordBuffer_cg
             , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_User') , 'UserPasswordFormat', 'columnid') , CTE.sys_change_columns) AS UserPasswordFormat_cg
             , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_User') , 'UserSiteManagerDisabled', 'columnid') , CTE.sys_change_columns) AS UserSiteManagerDisabled_cg
             , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_User') , 'UserStartingAliasPath', 'columnid') , CTE.sys_change_columns) AS UserStartingAliasPath_cg
             , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_User') , 'UserTokenID', 'columnid') , CTE.sys_change_columns) AS UserTokenID_cg
             , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_User') , 'UserTokenIteration', 'columnid') , CTE.sys_change_columns) AS UserTokenIteration_cg
             , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_User') , 'UserVisibility', 'columnid') , CTE.sys_change_columns) AS UserVisibility_cg
        --********************************************    				  
               FROM
                   CTE
                       JOIN sys.dm_tran_commit_table AS tc
                           ON CTE.sys_change_version = tc.commit_ts;

END;

GO
PRINT 'Executed proc_CT_CMS_USER_History.sql';
GO
