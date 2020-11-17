
GO

PRINT 'Creating proc_EDW_RoleEligibilityExpired';
PRINT 'FROM proc_EDW_RoleEligibilityExpired.sql';

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

IF EXISTS (SELECT
                  name
                  FROM sys.procedures
             WHERE name = 'proc_EDW_RoleEligibilityExpired') 
    BEGIN
        DROP PROCEDURE
             proc_EDW_RoleEligibilityExpired;
    END;

GO
--select count(*) from EDW_RoleMemberHistory where RoleEndDate is null  --1364405
--EXEC proc_EDW_RoleEligibilityExpired;

CREATE PROCEDURE dbo.proc_EDW_RoleEligibilityExpired
AS
BEGIN

    --******************************************************************************************
    --proc_EDW_RoleEligibilityExpired looks for PPT ROLE memebers that existed previously and
    --    does not currently exist in the daily pull. If one is found missing from the daily,
    --    that PPT is maked with an END DATE indicating the participation within that ROLE
    --    for that PPT has ended. Every 1,000 records processed will generate a message and at
    --    the end, a total records closed count will be displayed.
    --    Step 1 - Call procedure proc_EDW_EligibilityDaily
    --    Step 2 - Call procedure proc_EDW_EligibilityStarted
    --    Step 3 - Call procedure proc_EDW_RoleEligibilityExpired
    --    Step 4 - Retrieve the PPT membership history using the view view_EDW_EligibilityHistory
    --******************************************************************************************

    SET NOCOUNT OFF;
    PRINT 'Starting [proc_EDW_RoleEligibilityExpired] NOW: ' + CAST (GETDATE () AS nvarchar (50)) ;
    
declare @iCnt as integer = 0 ;

    with CTE (RoleName, UserID) AS
	(SELECT
				   RoleName
				 , UserID
				   FROM EDW_RoleMemberHistory
			 EXCEPT
			 SELECT
				   RoleName
				 , UserID
				   FROM EDW_RoleMemberToday) 
    update HIST  
	   set HIST.RoleEndDate = getdate()	
    from EDW_RoleMemberHistory  as HIST
    inner join CTE 
    on CTE.RoleName = HIST.RoleName and CTE.UserID = HIST.UserID 


    SET @iCnt = @@ROWCOUNT ;

    IF @iCnt > 0
        BEGIN
            PRINT CAST (@iCnt AS nvarchar (50)) + ' Expired ROLE Eligibility FOUND: ' + CAST (GETDATE () AS nvarchar (50)) ;
        END;
    ELSE
        BEGIN
            PRINT 'NO EligibilityExpired PPTs: ' + CAST (GETDATE () AS nvarchar (50)) ;
        END;
    PRINT 'Completed proc_EDW_RoleEligibilityExpired: ' + CAST (GETDATE () AS nvarchar (50)) ;
    PRINT '*******************************************************';
    PRINT 'Ending NOW: ' + CAST (GETDATE () AS nvarchar (50)) ;
END;

GO
PRINT 'Created proc_EDW_RoleEligibilityExpired';

GO