create view vTxMonitorIDX
as
SELECT [database_id]
      ,[TableName]
      ,[UpdatedRows]
      ,[LastUpdateTime]
      ,[CreateDate]
      ,[ExecutionDate]
      ,[RowID]
      ,[RunID]
	  ,DB_NAME ( [database_id] )  as DBNAME
  FROM [DFSAnalytics].[dbo].[TxMonitorIDX]
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
