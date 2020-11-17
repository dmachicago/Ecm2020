--select * from [dbo].[StaticMigrationLog]
--exec spStaticMigrationLogEnd @TaskName = 'P5'
--exec spStaticMigrationLogEnd @TaskName = 'P1'
--exec spStaticMigrationLogEnd @TaskName = 'P2'
--exec spStaticMigrationLogEnd @TaskName = 'B1'
--exec spStaticMigrationLogCalcTotals
ALTER procedure spStaticMigrationLogCalcTotals
AS
	update dbo.StaticMigrationLog 
	set AddedRows = NewRows - NbrRows 
	where AddedRows is null
		and successFlg = 1 ;
	
	update dbo.StaticMigrationLog 
		set TotalMin = convert(decimal(5,2),datediff(ss,StartTime,EndTime)/60.00)
		where AddedRows is null
			and successFlg = 1;
GO
alter procedure spStaticMigrationLogEnd (@TaskName as varchar(50))
as
	declare @ControlChar as char(1)
	declare @TaskID as int
	declare @RunID as int
	declare @ExistingRows as int
	set @RunID = (select max(Runid) from StaticRunId)
	set @ControlChar = SUBSTRING(@TaskName, 1, 1) 

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

	Update [dbo].[StaticMigrationLog]
		set [EndTime] = getdate()
			,[SuccessFlg] = 1 
			,[ActiveFLg] = 0
			,NewRows = @ExistingRows 
	where TaskName = @TaskName and RunID = @RunID
	
