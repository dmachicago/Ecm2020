

IF EXISTS (SELECT 1 FROM SYS.PROCEDURES where name = 'sp_SetHashDir')
	drop procedure sp_SetHashDir
go

create procedure sp_SetHashDir (@SourceGuid nvarchar(50), @dirname nvarchar(MAX))
as
Begin
	set @dirname = upper(@dirname);
	declare @Hash nvarchar(125) = '';
	declare @i int = 0 ;

	set @Hash = (select UPPER(convert(char(128), HASHBYTES('sha2_512', @dirname), 1)));
	
	set @i = (select count(1) from DataSourceFQN where FqnHASH = @Hash)
	if @i = 0 
		insert into DataSourceFQN(FqnHASH, fqn) values (@Hash, @dirname);
	if @i > 0
		update DataSourceFQN set FqnHASH = @Hash where FQN = @dirname;

	update DataSource set FqnHASH = @Hash where SourceGuid = @SourceGuid;
	
END

