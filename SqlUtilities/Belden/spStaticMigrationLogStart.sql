--truncate table [dbo].[StaticMigrationLog]
--exec spStaticMigrationLogStart @TaskName = 'P1'
--exec spStaticMigrationLogStart @TaskName = 'P2'
--exec spStaticMigrationLogStart @TaskName = 'B1'

alter procedure spStaticMigrationLogStart (@TaskName as varchar(50))
as
	declare @RunID as int
	declare @TaskID as int
	declare @ExistingRows as int
	declare @NewRows as int
	declare @ControlChar as char(1)

	set @NewRows = 0
	set @ControlChar = SUBSTRING(@TaskName, 1, 1) 
	set @TaskID = 0
	set @RunID = (select max(Runid) from StaticRunId)

	if @TaskName = 'P1' 
	begin
		set @TaskID = 1
	end
	if @TaskName = 'P2' 
	begin
		set @TaskID = 2
	end
	if @TaskName = 'P3' 
	begin
		set @TaskID = 3
	end
	if @TaskName = 'P4' 
	begin
		set @TaskID = 4
	end
	if @TaskName = 'P5' 
	begin
		set @TaskID = 5
	end
	if @TaskName = 'B1' 
	begin
		set @TaskID = 6
	end
	if @TaskName = 'B2' 
	begin
		set @TaskID = 7
	end
	if @TaskName = 'B3' 
	begin
		set @TaskID = 8
	end

	if @ControlChar = 'P' 
	begin
		set @ExistingRows = (select count(*) from GLOBAL_Static_POS where Extract = @TaskName)
	end
	if @ControlChar = 'B' 
	begin
		set @ExistingRows = (select count(*) from GLOBAL_Static_BI where Extract = @TaskName)
	end

	INSERT INTO [dbo].[StaticMigrationLog]
			   ([TaskID]
			   ,[TaskName]
			   ,[StartTime]
			   ,[EndTime]
			   ,[SuccessFlg]
			   ,[ActiveFLg]
			   ,[NbrRows]
			   ,[TotalMin]
			   ,[NewRows]
			   ,RunId)
		 VALUES
			   (@TaskID
			   ,@TaskName
			   ,getdate()
			   ,getdate()
			   ,0
			   ,1
			   ,@ExistingRows
			   ,0
			   ,@NewRows
			   ,@RunID)
	GO


