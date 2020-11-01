
if exists (select 1 from sys.procedures where name = 'sp_DefaultExists')
	drop procedure sp_DefaultExists;
go

create procedure sp_DefaultExists (@TBL nvarchar(250), @COL nvarchar(250))
as
begin
	if not(exists(SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = @TBL 
			AND COLUMN_NAME = @COL
			AND COLUMN_DEFAULT IS NOT NULL))
		return 0
	else 
		return 1
end
go
create function fnDefaultExists (@TBL nvarchar(250), @COL nvarchar(250))
returns int
as
begin
	declare @b int = 0 ;
	if not(exists(SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = @TBL 
			AND COLUMN_NAME = @COL
			AND COLUMN_DEFAULT IS NOT NULL))
		set @b = 0;
	else 
		set @b = 1;
	return @b;
end