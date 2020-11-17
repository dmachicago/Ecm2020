SELECT * 
FROM   INFORMATION_SCHEMA.VIEWS 
WHERE  VIEW_DEFINITION like '%HFit_RewardActivity%'
and TABLE_NAME like'%EDW%'


SELECT * 
FROM   INFORMATION_SCHEMA.columns
WHERE TABLE_NAME like'%EDW%'
and (COLUMN_NAME like 'ActivityPoints' OR COLUMN_NAME like '%MaxRewardLimit%')


SELECT * 
FROM   INFORMATION_SCHEMA.VIEWS 
WHERE  VIEW_DEFINITION like '%EDW_RewardUserDetail%'
and TABLE_NAME like'%EDW%'
  --  
  --  
GO 
print('***** FROM: FindViewsThatUseTable.sql'); 
GO 
