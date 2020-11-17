/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP 1000 [TaskID]
      ,[TaskName]
      ,[StartTime]
      ,[EndTime]
      ,[SuccessFlg]
      ,[ActiveFLg]
      ,[NbrRows]
      ,[TotalMin]
      ,[NewRows]
      ,[RunID]
      ,[AddedRows]
  FROM [SMART].[dbo].[StaticMigrationLog]
  order by RunID desc, TaskID asc
  