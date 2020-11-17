
GO
PRINT 'Executing proc_CT_CMS_UserSite_History.sql';
GO
IF EXISTS (SELECT
                  name
                  FROM sys.procedures
                  WHERE name = 'proc_CT_CMS_UserSite_History') 
    BEGIN
        DROP PROCEDURE
             proc_CT_CMS_UserSite_History;
    END;
GO

/*-------------------------------------------------------------------------
*************************************************************************

select tc.commit_time, *
from
    changetable(changes CMS_UserSite, 0) c
    join sys.dm_tran_commit_table tc on c.sys_change_version = tc.commit_ts


exec proc_CT_CMS_UserSite_History 'I'
exec proc_CT_CMS_UserSite_History 'D'
exec proc_CT_CMS_UserSite_History 'U'

truncate table STAGING_CMS_UserSite_Update_History
select * from STAGING_CMS_UserSite_Update_History

SELECT CHANGE_TRACKING_MIN_VALID_VERSION(OBJECT_ID('CMS_UserSite'))

SELECT * FROM CHANGETABLE (CHANGES CMS_UserSite, NULL) AS CT WHERE SYS_CHANGE_OPERATION = 'U'
SELECT * FROM STAGING_CMS_UserSite_Update_History
*************************************************************************
*/


CREATE PROCEDURE proc_CT_CMS_UserSite_History (
     @Typesave AS nchar (1)) 
AS
BEGIN
    WITH CTE (
         UserSiteID
       , SYS_CHANGE_VERSION
       , SYS_CHANGE_COLUMNS) 
        AS (SELECT
                   CT.UserSiteID
                 , CT.SYS_CHANGE_VERSION
                 , SYS_CHANGE_COLUMNS
                   FROM CHANGETABLE (CHANGES CMS_UserSite, NULL) AS CT
                   WHERE SYS_CHANGE_OPERATION = @Typesave
            EXCEPT
            SELECT
                   UserSiteID
                 , SYS_CHANGE_VERSION
                 , SYS_CHANGE_COLUMNS
                   FROM STAGING_CMS_UserSite_Update_History) 
        INSERT INTO STAGING_CMS_UserSite_Update_History
        (
		  UserSiteid
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
		  , UserSiteID_cg 
		  , UserID_cg 
		  , SiteID_cg 
		  , UserPreferredCurrencyID_cg 
		  , UserPreferredShippingOptionID_cg 
		  , UserPreferredPaymentOptionID_cg ) 
        SELECT
               CTE.UserSiteID
             , CTE.SYS_CHANGE_VERSION
             , @Typesave as SYS_CHANGE_OPERATION
             , CTE.SYS_CHANGE_COLUMNS
             --, CurrUser
             --, SysUser
             --, IPADDR
             , tc.commit_time
             , GETDATE () AS LastModifiedDate
             , @@Servername AS SVR
             , DB_NAME () AS DBNAME
               --********************************************     
			 , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_UserSite') , 'SiteID', 'columnid') , CTE.sys_change_columns) AS [SiteID_cg] 
			 , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_UserSite') , 'UserID', 'columnid') , CTE.sys_change_columns) AS [UserID_cg] 
			 , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_UserSite') , 'UserPreferredCurrencyID', 'columnid') , CTE.sys_change_columns) AS [UserPreferredCurrencyID_cg] 
			 , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_UserSite') , 'UserPreferredPaymentOptionID', 'columnid') , CTE.sys_change_columns) AS [UserPreferredPaymentOptionID_cg] 
			 , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_UserSite') , 'UserPreferredShippingOptionID', 'columnid') , CTE.sys_change_columns) AS [UserPreferredShippingOptionID_cg] 
			 , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_UserSite') , 'UserSiteID', 'columnid') , CTE.sys_change_columns) AS [UserSiteID_cg] 

        --********************************************    				  
               FROM
                   CTE
                       JOIN sys.dm_tran_commit_table AS tc
                           ON CTE.sys_change_version = tc.commit_ts;

END;

GO
PRINT 'Executed proc_CT_CMS_UserSite_History.sql';
GO
