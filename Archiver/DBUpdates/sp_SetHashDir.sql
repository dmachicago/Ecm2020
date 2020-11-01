IF EXISTS (SELECT 1 FROM SYS.PROCEDURES where name = 'sp_SetHashDir')
	drop procedure sp_SetHashDir
go

create procedure sp_SetHashDir (@SourceGuid nvarchar(50), @dirname nvarchar(MAX))
as
Begin
	set @dirname = upper(@dirname);
	declare @Hash nvarchar(128) = '';

	set @Hash = (select UPPER(convert(char(128), HASHBYTES('sha2_512', @dirname), 1)));
	
	if not exists (select 1 from DataSourceFQN where FqnHASH = @Hash)
		insert into DataSourceFQN(FqnHASH, fqn) values (@Hash, @dirname);

	update DataSource set FqnHASH = @Hash where SourceGuid = @SourceGuid;
	
END

