

go
print '->->->->->->->->-> BEGIN LOADS ->->->->->->->->->->->->';
go
print '*** REMOVE all existing HISTORY';
truncate table EDW_RoleMemberHistory
go
print '*** LOADING proc_EDW_RoleEligibilityDaily';
go
exec proc_EDW_RoleEligibilityDaily;
go
print '*** LOADING proc_EDW_RoleEligibilityStarted';
go
exec proc_EDW_RoleEligibilityStarted;
go
print '*** LOADING proc_EDW_RoleEligibilityExpired';
go
EXEC proc_EDW_RoleEligibilityExpired;
go
print '>>>>>>>>>> DONE <<<<<<<<<<<<<';
go