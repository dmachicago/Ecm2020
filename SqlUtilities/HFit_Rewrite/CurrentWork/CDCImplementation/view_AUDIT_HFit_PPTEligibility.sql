

GO
PRINT 'Executing view_AUDIT_HFit_PPTEligibility.sql';
GO
IF EXISTS (SELECT
                  name
                  FROM sys.views
                  WHERE name = 'view_AUDIT_HFit_PPTEligibility') 
    BEGIN
        DROP VIEW
             view_AUDIT_HFit_PPTEligibility;
    END;

GO

/*------------------------------------------------------
    select top 100 * from STAGING_HFit_PPTEligibility
    select top 1000 * from STAGING_HFit_PPTEligibility_Update_History
    select top 1000 * from STAGING_HFit_PPTEligibility_Audit
*/

-- select top 1000 * from view_AUDIT_HFit_PPTEligibility order by PPTID
/*------------------------------------------------------------------------------
HOW TO USE:
    select * from view_AUDIT_HFit_PPTEligibility
	   where CreateDate between '2015-09-18 14:55:33.000' and '2015-09-18 14:55:34'

    select * from view_AUDIT_HFit_PPTEligibility
	   where SysUser = 'dmiller'
*/

CREATE VIEW view_AUDIT_HFit_PPTEligibility
AS SELECT
          A.SysUser
        , A.IPADDR
        , A.CreateDate as DateModified
        , A.SYS_CHANGE_OPERATION
        , A.SYS_CHANGE_VERSION as SysChangeVersion
        , S.*
          FROM
              STAGING_HFit_PPTEligibility_Audit AS A
                  JOIN STAGING_HFit_PPTEligibility AS S
                      ON S.PPTID = A.PPTID;
GO
PRINT 'Executed view_AUDIT_HFit_PPTEligibility.sql';
GO
