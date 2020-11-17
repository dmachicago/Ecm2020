/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP 1000 [DBName]
      ,[Schema]
      ,[Table]
      ,[Index]
      ,[OnlineReorg]
      ,[Success]
      ,[Rundate]
      ,[RunID]
      ,[Stmt]
      ,[RowNbr]
  FROM [master].[dbo].[DFS_IndexFragReorgHistory]
  order by [RowNbr] desc

  select 'Update statistics ' + [DBName] +'.' + [Schema] + '.' + [Table] 
  FROM [master].[dbo].[DFS_IndexFragReorgHistory] 
  where RunID = 1;

  select 'DBCC SHOW_STATISTICS (' + [DBName] +'.' + [Schema] + '.' + [Table] + ') ;'
  FROM [master].[dbo].[DFS_IndexFragReorgHistory] 
  where RunID = 1;

  select 'DBCC SHOW_STATISTICS (' + [DBName] +'.' + [Schema] + '.' + [Table] + ') ;'
  FROM [master].[dbo].[DFS_IndexFragReorgHistory] 
  where RunID = 1;

use [AP_ProductionAF_Data];

  select top 1000 
  OBJECT_NAME(object_id) as TblName, [name] as StatName, 
	STATS_DATE([object_id], [stats_id]) as Lastupdate
  from sys.stats;

  select count(*) from FT_ProductionLUX_Port.dbo.DocumentInstanceOutput

  Update statistics FT_ProductionLUX_Port.dbo.DocumentInstanceOutput
  with sample 10 percent;

  DBCC SHOW_STATISTICS ("AP_ProductionAF_Data.dbo.NativeClassBalance_ImportArchive",AccountPeriodEnd) ;