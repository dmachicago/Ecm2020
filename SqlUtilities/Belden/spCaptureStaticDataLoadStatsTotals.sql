USE [SMART]
GO
/****** Object:  StoredProcedure [dbo].[spCaptureStaticDataLoadStats]    Script Date: 11/03/2010 08:35:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--SELECT convert(decimal(5,2),datediff(ss,'2006-11-10 05:47:53.497','2006-11-10 05:48:10.498')/60.00)

--select count(*) from GLOBAL_Static_BI
--select count(*) from GLOBAL_Static_POS
--truncate table [dbo].[StaticMigrationLog]
--exec spCaptureStaticDataLoadStats
--select * from [dbo].[StaticMigrationLog] order by taskname, StartTime

--exec [dbo].[spCaptureStaticDataLoadStatsTotals]
alter procedure [dbo].[spCaptureStaticDataLoadStatsTotals]
as 
begin
	declare @RunID as int
	declare @SDate as datetime
	declare @EDate as datetime
	declare @iRows as decimal (18,0)
	declare @iRowsNew as decimal (18,0)
	declare @iRowsTot as decimal (18,0)
	declare @TaskID as int
	declare @TaskName as varchar(50)

	set @TaskID = 99
	set @RunID = (select max(RunID) from StaticRunID)
	set @TaskName = 'TOTAL'
	set @sdate = (Select min(StartTime) from dbo.StaticMigrationLog where RunID = @RunID)
	set @edate = (Select max(EndTime) from dbo.StaticMigrationLog where RunID = @RunID)
	set @iRows = (Select sum(NbrRows) as NbrRows from dbo.StaticMigrationLog where RunID = @RunID)
	set @iRowsNew = (Select sum(NewRows) as NewRows from dbo.StaticMigrationLog where RunID = @RunID)
	set @iRowsTot = (Select sum(AddedRows) as AddedRows from dbo.StaticMigrationLog where RunID = @RunID)
	
	delete from dbo.StaticMigrationLog where RunID = @RunID and TaskName = 'TOTAL'

	if @iRows > 0 
	begin
	INSERT INTO [dbo].[StaticMigrationLog]
			   ([TaskID]
			   ,[TaskName]
			   ,[StartTime]
			   ,[EndTime]
			   ,[SuccessFlg]
			   ,[ActiveFLg]
			   ,[NbrRows]
			   ,RunID
			   ,AddedRows)
		 VALUES
			   (1
			   ,@TaskName
			   ,@sDate
			   ,@eDate
			   ,1
			   ,0
			   ,@iRows
			   ,@RunID
			   ,@iRowsTot) ;
	end 
		
				   
end 
