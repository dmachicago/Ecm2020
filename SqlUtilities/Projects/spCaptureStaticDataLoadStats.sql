--SELECT convert(decimal(5,2),datediff(ss,'2006-11-10 05:47:53.497','2006-11-10 05:48:10.498')/60.00)

--select count(*) from GLOBAL_Static_BI
--select count(*) from GLOBAL_Static_POS
--truncate table [dbo].[StaticMigrationLog]
--exec spCaptureStaticDataLoadStats
--select * from [dbo].[StaticMigrationLog] order by taskname, StartTime

alter procedure spCaptureStaticDataLoadStats
as 
begin
	declare @SDate as datetime
	declare @EDate as datetime
	declare @iRows as decimal (18,0)
	declare @eCode as varchar(5)

	set @eCode = 'P1'
	set @sdate = (Select min(EntryDate) from dbo.GLOBAL_Static_POS where Extract = @eCode)
	set @edate = (Select max(EntryDate) from dbo.GLOBAL_Static_POS where Extract = @eCode)
	set @iRows = (Select count(*) from dbo.GLOBAL_Static_POS where Extract = @eCode)

	if @iRows > 0 
	begin
	INSERT INTO [dbo].[StaticMigrationLog]
			   ([TaskID]
			   ,[TaskName]
			   ,[StartTime]
			   ,[EndTime]
			   ,[SuccessFlg]
			   ,[ActiveFLg]
			   ,[NbrRows])
		 VALUES
			   (1
			   ,@eCode
			   ,@sDate
			   ,@eDate
			   ,1
			   ,0
			   ,@iRows) ;
	end 
	
	set @eCode = 'P2'
	set @sdate = (Select min(EntryDate) from dbo.GLOBAL_Static_POS where Extract = @eCode)
	set @edate = (Select max(EntryDate) from dbo.GLOBAL_Static_POS where Extract = @eCode)
	set @iRows = (Select count(*) from dbo.GLOBAL_Static_POS where Extract = @eCode)

	if @iRows > 0 
	begin
	INSERT INTO [dbo].[StaticMigrationLog]
			   ([TaskID]
			   ,[TaskName]
			   ,[StartTime]
			   ,[EndTime]
			   ,[SuccessFlg]
			   ,[ActiveFLg]
			   ,[NbrRows])
		 VALUES
			   (1
			   ,@eCode
			   ,@sDate
			   ,@eDate
			   ,1
			   ,0
			   ,@iRows) ;
	end 
	
	set @eCode = 'P3'
	set @sdate = (Select min(EntryDate) from dbo.GLOBAL_Static_POS where Extract = @eCode)
	set @edate = (Select max(EntryDate) from dbo.GLOBAL_Static_POS where Extract = @eCode)
	set @iRows = (Select count(*) from dbo.GLOBAL_Static_POS where Extract = @eCode)
	
	if @iRows > 0 
	begin
	INSERT INTO [dbo].[StaticMigrationLog]
			   ([TaskID]
			   ,[TaskName]
			   ,[StartTime]
			   ,[EndTime]
			   ,[SuccessFlg]
			   ,[ActiveFLg]
			   ,[NbrRows])
		 VALUES
			   (1
			   ,@eCode
			   ,@sDate
			   ,@eDate
			   ,1
			   ,0
			   ,@iRows) ;
	end 
	
	set @eCode = 'P4'
	set @sdate = (Select min(EntryDate) from dbo.GLOBAL_Static_POS where Extract = @eCode)
	set @edate = (Select max(EntryDate) from dbo.GLOBAL_Static_POS where Extract = @eCode)
	set @iRows = (Select count(*) from dbo.GLOBAL_Static_POS where Extract = @eCode)

if @iRows > 0 
	begin	
	INSERT INTO [dbo].[StaticMigrationLog]
			   ([TaskID]
			   ,[TaskName]
			   ,[StartTime]
			   ,[EndTime]
			   ,[SuccessFlg]
			   ,[ActiveFLg]
			   ,[NbrRows])
		 VALUES
			   (1
			   ,@eCode
			   ,@sDate
			   ,@eDate
			   ,1
			   ,0
			   ,@iRows) ;
	End 
	
	set @eCode = 'P5'
	set @sdate = (Select min(EntryDate) from dbo.GLOBAL_Static_POS where Extract = @eCode)
	set @edate = (Select max(EntryDate) from dbo.GLOBAL_Static_POS where Extract = @eCode)
	set @iRows = (Select count(*) from dbo.GLOBAL_Static_POS where Extract = @eCode)

	if @iRows > 0 
	begin
	INSERT INTO [dbo].[StaticMigrationLog]
			   ([TaskID]
			   ,[TaskName]
			   ,[StartTime]
			   ,[EndTime]
			   ,[SuccessFlg]
			   ,[ActiveFLg]
			   ,[NbrRows])
		 VALUES
			   (1
			   ,@eCode
			   ,@sDate
			   ,@eDate
			   ,1
			   ,0
			   ,@iRows) ;
	end
	
	set @eCode = 'B1'
	set @sdate = (Select min(EntryDate) from dbo.GLOBAL_Static_BI where Extract = @eCode)
	set @edate = (Select max(EntryDate) from dbo.GLOBAL_Static_BI where Extract = @eCode)
	set @iRows = (Select count(*) from dbo.GLOBAL_Static_BI where Extract = @eCode)

	if @iRows > 0 
	begin
	INSERT INTO [dbo].[StaticMigrationLog]
			   ([TaskID]
			   ,[TaskName]
			   ,[StartTime]
			   ,[EndTime]
			   ,[SuccessFlg]
			   ,[ActiveFLg]
			   ,[NbrRows])
		 VALUES
			   (1
			   ,@eCode
			   ,@sDate
			   ,@eDate
			   ,1
			   ,0
			   ,@iRows) ;
	end 
	
	set @eCode = 'B2'
	set @sdate = (Select min(EntryDate) from dbo.GLOBAL_Static_BI where Extract = @eCode)
	set @edate = (Select max(EntryDate) from dbo.GLOBAL_Static_BI where Extract = @eCode)
	set @iRows = (Select count(*) from dbo.GLOBAL_Static_BI where Extract = @eCode)

	if @iRows > 0 
	begin
	INSERT INTO [dbo].[StaticMigrationLog]
			   ([TaskID]
			   ,[TaskName]
			   ,[StartTime]
			   ,[EndTime]
			   ,[SuccessFlg]
			   ,[ActiveFLg]
			   ,[NbrRows])
		 VALUES
			   (1
			   ,@eCode
			   ,@sDate
			   ,@eDate
			   ,1
			   ,0
			   ,@iRows) ;
	end 
	
	set @eCode = 'B3'
	set @sdate = (Select min(EntryDate) from dbo.GLOBAL_Static_BI where Extract = @eCode)
	set @edate = (Select max(EntryDate) from dbo.GLOBAL_Static_BI where Extract = @eCode)
	set @iRows = (Select count(*) from dbo.GLOBAL_Static_BI where Extract = @eCode)

	if @iRows > 0 
	begin
	INSERT INTO [dbo].[StaticMigrationLog]
			   ([TaskID]
			   ,[TaskName]
			   ,[StartTime]
			   ,[EndTime]
			   ,[SuccessFlg]
			   ,[ActiveFLg]
			   ,[NbrRows])
		 VALUES
			   (1
			   ,@eCode
			   ,@sDate
			   ,@eDate
			   ,1
			   ,0
			   ,@iRows) ;
	end 
	
	set @eCode = 'TOTAL'
	set @sdate = (Select min(EntryDate) from dbo.GLOBAL_Static_POS)
	set @edate = (Select max(EntryDate) from dbo.GLOBAL_Static_POS)
	set @iRows = (Select count(*) from dbo.GLOBAL_Static_POS)

	if @iRows > 0 
	begin
	INSERT INTO [dbo].[StaticMigrationLog]
			   ([TaskID]
			   ,[TaskName]
			   ,[StartTime]
			   ,[EndTime]
			   ,[SuccessFlg]
			   ,[ActiveFLg]
			   ,[NbrRows])
		 VALUES
			   (1
			   ,@eCode
			   ,@sDate
			   ,@eDate
			   ,1
			   ,0
			   ,@iRows) ;
	end 
	
	update [dbo].[StaticMigrationLog]
	set TotalMin = (convert(decimal(5,2),datediff(ss,StartTime,EndTime)/60.00))
	where TotalMin is null
				   
end 
go 

