--CREATE NONCLUSTERED COLUMNSTORE INDEX idx_HFIT_Tracker_CreateDate ON HFIT_Tracker (ItemCreatedWhen , ItemModifiedWhen) WITH (DROP_EXISTING = OFF) ON [PRIMARY] ;

select 'CREATE NONCLUSTERED INDEX idx_' + name +'_CreateDate ON ' + name + ' (ItemCreatedWhen DESC, ItemModifiedWhen DESC) WITH (DROP_EXISTING = OFF) ON [PRIMARY] ;' from sys.tables where name like 'HFIT_tracker%'
--DROP INDEX HFIT_Tracker.idx_HFIT_Tracker__CreateDate
--select 'DROP INDEX ' + name +'.idx_' + name + '_CreateDate' from sys.tables where name like 'HFIT_tracker%'


  --  
  --  
GO 
print('***** FROM: HFIT_CreateTrackerDateIndexes.sql'); 
GO 
