
go
print 'Creating proc proc_build_EDW_Eligibility.sql'
go

if exists (select name from sys.procedures where name = 'proc_build_EDW_Eligibility')
    drop procedure proc_build_EDW_Eligibility;

go
CREATE PROCEDURE [dbo].[proc_build_EDW_Eligibility]
AS
BEGIN

	--*******************************************************************************************
	--Step 1 - Call procedure proc_EDW_EligibilityDaily
	--    Step 2 - Call procedure proc_EDW_EligibilityStarted
	--    Step 3 - Call procedure proc_EDW_EligibilityExpired
	--    Step 4 - Retrieve the PPT membership history using the view view_EDW_EligibilityHistory
	--    proc_build_EDW_Eligibility runs all three required procedures that are needed
	--    to apply current eligibility new, current, and expired (missing).
	--*******************************************************************************************

	SET NOCOUNT ON;
	EXEC proc_EDW_EligibilityDaily;
	EXEC proc_EDW_EligibilityStarted;
	EXEC proc_EDW_EligibilityExpired;
	SET NOCOUNT OFF;
END;

GO


print 'Created proc proc_build_EDW_Eligibility,sql'
go