create view [vTxMonitorTableStats]
as
SELECT [TableName]
      ,[IndexName]
      ,[IndexID]
      ,[user_seeks]
      ,[user_scans]
      ,[user_lookups]
      ,[user_updates]
      ,[last_user_seek]
      ,[last_user_scan]
      ,[last_user_lookup]
      ,[last_user_update]
      ,[DBID]
      ,[CreateDate]
      ,[ExecutionDate]
      ,[RunID]
      ,[RowNbr]
	  ,DB_NAME ( DBID )  as DBNAME
  FROM [DFSAnalytics].[dbo].[TxMonitorTableStats]
 
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
