/****** Script for SelectTopNRows command from SSMS  ******/
SELECT *
  FROM [dbo].[EDW_Proc_Performance_Monitor]
--where TraceName = 'proc_STAGING_EDW_HA_Changes'
order by TraceName, Rownbr

