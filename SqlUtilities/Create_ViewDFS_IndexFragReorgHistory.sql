USE [master]
GO
if exists (select 1 from information_schema.tables where table_name = 'viewDFS_IndexFragProgress')
drop view viewDFS_IndexFragProgress;

go
	create view dbo.viewDFS_IndexFragProgress
	as 
		SELECT [DBNAME]
      ,[StartTime]
      ,[EndTime]
	  ,cast([EndTime]-[StartTime] as time) as ElapsedTime,
	  RowNbr
  FROM [dbo].[DFS_IndexFragProgress]
  
go

select * from viewDFS_IndexFragProgress order by [RowNbr] desc ;
--SSCAI_ProductionAR_Port
GO


