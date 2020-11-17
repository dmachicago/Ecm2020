truncate table EDW_RoleMemberHistory

go 
print ('THIS IS A SERIES OF TESTS DESIGNED TO:');
print '- TEST executing proc_EDW_RoleEligibilityDaily - retrieve the existing ROLE eligibility records.';
print '- TEST executing proc_EDW_RoleEligibilityStarted - apply new PPT role eligibility';
print '- TEST executing proc_EDW_RoleEligibilityExpired - mark expired PPT eligibility';
print '- TEST finding and inserting new records from the daily pulled records:';
print ('- TEST marking a record in History as DELETED:');
print ('- TEST THE LastModifiedDate Trigger is operational:');
print ('- TEST finding and applying a NEW Role Eligibility Record - insert a new record:');
print ('- TEST that a record can be marked as INELIGIBLE or expired and then readded as eligible again.');

print '->->->->->->->->-> BEGIN TESTS ->->->->->->->->->->->->';

go
print '*** TEST executing proc_EDW_RoleEligibilityDaily';
go
exec proc_EDW_RoleEligibilityDaily;
go
print '*** TEST executing proc_EDW_RoleEligibilityStarted';
go
exec proc_EDW_RoleEligibilityStarted;
go
print '*** TEST executing proc_EDW_RoleEligibilityExpired';
go
EXEC proc_EDW_RoleEligibilityExpired;
go
print '>>>>>>>>>> DONE <<<<<<<<<<<<<';
go

declare @DailyRecCnt as int ;
declare @StartedRecCnt as int ;
declare @HistoryRecCnt as int ;
declare @TestID as int ;
declare @DeleteID as int ;
declare @TestIdCount as int; 
declare @iCnt as int ;

print ('---------------------------');
print ('Get the starting counts:');
set @DailyRecCnt = (select count(*) from EDW_RoleMemberToday) ;
print ('Daily records count: ' +  cast(@DailyRecCnt as nvarchar(50)));
set @StartedRecCnt = (select count(*) from EDW_RoleMembership) ;
print ('Changed or New records count: ' +  cast(@StartedRecCnt as nvarchar(50)));
set @HistoryRecCnt = (select count(*) from EDW_RoleMemberHistory) ;
print ('History records count: ' +  cast(@HistoryRecCnt as nvarchar(50)));

print ('---------------------------');
print ('Set the TEST IDs:');
set @TestID = (select top 1 UserID from EDW_RoleMemberToday);
print ('INSERT Test ID: ' +  cast(@TestID as nvarchar(50)));
set @DeleteID = (select top 1 UserID from EDW_RoleMemberToday order by UserID desc);
print ('DELETE Test ID: ' +  cast(@DeleteID as nvarchar(50)));
set @iCnt = (select count(*) from EDW_RoleMemberToday where UserID = @TestID) ;
print ('Test ID in Daily: ' +  cast(@iCnt as nvarchar(50)));
set @iCnt = (select count(*) from EDW_RoleMemberToday where UserID = @TestID) ;
print ('Test ID CNT in Start: ' +  cast(@iCnt as nvarchar(50)));
set @iCnt = (select count(*) from EDW_RoleMemberHistory where UserID = @TestID) ;
print ('Test ID CNT in History: ' +  cast(@iCnt as nvarchar(50)));

print ('---------------------------');
print('Delete user records from the EDW_RoleMemberHistory table');
print ('*** TEST finding and inserting new records from the daily pulled records:');
set @iCnt = (select count(*) from EDW_RoleMemberHistory where UserID = @TestID) ;
print ('Before delete - #Test Records in History: ' +  cast(@iCnt as nvarchar(50)) + ' for Test ID: ' + cast(@TestID as nvarchar(50)) );

delete from EDW_RoleMemberHistory where UserID = @TestID 

set @iCnt = (select count(*) from EDW_RoleMemberHistory where UserID = @TestID) ;
print ('After delete - #Test Records in History: ' +  cast(@iCnt as nvarchar(50)) + ' for Test ID: ' + cast(@TestID as nvarchar(50)));
print ('Total records deleted from History: ' +  cast(@HistoryRecCnt - @iCnt as nvarchar(50)));
set @iCnt = (select count(*) from EDW_RoleMemberHistory where UserID = @TestID) ;
print ('After delete - #Test ID found in History: ' +  cast(@iCnt as nvarchar(50)));
print ('** Rerun "started" procedure and verify record added back to History: ' +  cast(@iCnt as nvarchar(50)));

print ('+++++++++++++++++++++++++++');
exec proc_EDW_RoleEligibilityStarted;
print ('+++++++++++++++++++++++++++');

set @iCnt = (select count(*) from EDW_RoleMemberHistory) ;
print ('After reprocess - Records in History: ' +  cast(@iCnt as nvarchar(50)));
set @iCnt = (select count(*) from EDW_RoleMemberHistory where UserID = @TestID) ;
print ('After reprocess TEST ID count in History: ' +  cast(@iCnt as nvarchar(50)));
print ('---------------------------');

print('Delete user records from the DAILY pull table');
print ('*** TEST marking a record in History as DELETED:');
set @iCnt = (select count(*) from EDW_RoleMemberToday where UserID = @DeleteID) ;
print ('Record Count - deleted from DAILY pull: ' +  cast(@iCnt as nvarchar(50)));

delete from EDW_RoleMemberToday where UserID = @DeleteID  ;
declare @DeletedTodayRecords as int = (select @@ROWCOUNT) ;
set @iCnt = (select count(*) from EDW_RoleMemberHistory where RoleEndDate is not null) ;
print ('Missing Record Count in HISTORY before DELETE: ' +  cast(@iCnt as nvarchar(50)) +  ' > a good count should be zero.');


print ('+++++++++++++++++++++++++++');
exec proc_EDW_RoleEligibilityExpired;
print ('+++++++++++++++++++++++++++');

set @iCnt = (select count(*) from EDW_RoleMemberHistory where RoleEndDate is not null) ;
print ('Missing Record Count in HISTORY AFTER DELETE: ' +  cast(@iCnt as nvarchar(50)) + ' > a good count should be ' + cast(@DeletedTodayRecords as nvarchar(50)));
print ('---------------------------');

print('*** TEST THE LastModifiedDate Trigger is operational:');
declare @DateNow as datetime = getdate();
set @iCnt = (select count(*) from EDW_RoleMemberHistory where LastModifiedDate > @DateNow);
print('Number of records updated since:');
print (@DateNow) ;
print(' ');
print('Rows Found:' + cast(@iCnt as nvarchar(50)));
update EDW_RoleMemberHistory set ValidTo = getdate() where RowNbr in (select top 10 RowNbr from EDW_RoleMemberHistory order by RoleID, UserID desc)

set @iCnt = (select count(*) from EDW_RoleMemberHistory where LastModifiedDate > @DateNow);
print('Number of records updated since:');
print (@DateNow) ;
print(' ');
set @iCnt = (select count(*) from EDW_RoleMemberHistory where LastModifiedDate > @DateNow);
print(' ');
print('Rows Found:' + cast(@iCnt as nvarchar(50)));

print ('---------------------------');
print ('*** TEST finding and applying a NEW Role Eligibility Record - insert a new record:');
set @iCnt = (select count(*) from EDW_RoleMemberToday) ;
print ('DAILY Pull Record Count:' + cast(@iCnt as nvarchar(50)));

INSERT INTO [dbo].[EDW_RoleMemberToday]
           ([UserID]
           ,[RoleID]
           ,[RoleGUID]
           ,[RoleName]
           ,[ValidTo]
           ,[HFitUserMPINumber]
           ,[AccountCD]
           ,[AccountID]
           ,[SiteGUID]
           ,[RoleStartDate]
           ,[RoleEndDate]
           ,[LastModifiedDate])
     VALUES
           (1111
           ,2222
           ,newid()
           ,'NO ROLE NAME'
           ,null
           ,1111
           ,'TEST REC'
           ,1111
           ,newid()
           ,getdate() -1 
           ,null
           ,null);

INSERT INTO [dbo].[EDW_RoleMemberToday]
           ([UserID]
           ,[RoleID]
           ,[RoleGUID]
           ,[RoleName]
           ,[ValidTo]
           ,[HFitUserMPINumber]
           ,[AccountCD]
           ,[AccountID]
           ,[SiteGUID]
           ,[RoleStartDate]
           ,[RoleEndDate]
           ,[LastModifiedDate])
     VALUES
           (2222
           ,3333
           ,newid()
           ,'NO ROLE NAME'
           ,null
           ,1111
           ,'TEST REC'
           ,1111
           ,newid()
           ,getdate() -1 
           ,null
           ,null);

set @iCnt = (select count(*) from EDW_RoleMemberToday) ;
print ('DAILY Pull Record Count after new records added :' + cast(@iCnt as nvarchar(50)));
print (' ') ;
set @iCnt = (select count(*) from EDW_RoleMemberHistory) ;
print ('HISTORY Count BEFORE new records added :' + cast(@iCnt as nvarchar(50)));

exec proc_EDW_RoleEligibilityStarted;

set @iCnt = (select count(*) from EDW_RoleMemberHistory) ;
print ('HISTORY Count AFTER new records added :' + cast(@iCnt as nvarchar(50)));

delete from EDW_RoleMemberHistory where [RoleName] = 'NO ROLE NAME' ;
print ('Removed '+cast(@@ROWCOUNT as nvarchar(50))+' test INSERTS from HISTORY ');
delete from EDW_RoleMemberToday where [RoleName] = 'NO ROLE NAME' ;
print ('Removed '+cast(@@ROWCOUNT as nvarchar(50))+' test INSERTS from DAILY ');

print ('---------------------------');
print ('*** TEST that a record can be marked as INELIGIBLE or expired and then readded as eligible again.');
update EDW_RoleMemberHistory set RoleEndDate = getdate()-1 where RowNbr in (Select top 1000 RowNbr from EDW_RoleMemberHistory where RowNbr between 10000 and 20000);
declare @ExpiredCnt as int = (Select count(*) from EDW_RoleMemberHistory where RoleEndDate is not null) ;
print ('Record CNT tagged as expired: ' + cast(@ExpiredCnt as nvarchar(50))) ;
declare @xCnt as int = (select count(*) from EDW_RoleMemberHistory) ;
print ('Total HISTORY Records = ' + cast(@xCnt as nvarchar(50))) ;
print ('** REAPPLY updates from today and the expired records should be reapplied.') ;

exec proc_EDW_RoleEligibilityStarted;

set @xCnt = (select count(*) from EDW_RoleMemberHistory) ;
print ('Total HISTORY Records AFTER reapply = ' + cast(@xCnt as nvarchar(50))) ;

set @ExpiredCnt = (Select count(*) from EDW_RoleMemberHistory where RoleEndDate is not null) ;
print ('Expired HISTORY Records AFTER reapply = ' + cast(@ExpiredCnt as nvarchar(50))) ;

print ('---------------------------');
print ('END OF TEST');
print ('PLEASE REMEMBER TO TRUNCATE THE DATA SO THAT A FRESH LOAD WILL POPULATE ALL TABLES.');
--truncate table EDW_RoleMemberHistory