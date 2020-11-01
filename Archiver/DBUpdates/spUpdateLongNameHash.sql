if exists (select 1 from sys.procedures where name = 'spUpdateLongNameHash')
	drop procedure spUpdateLongNameHash
GO

CREATE procedure spUpdateLongNameHash(@FQN varchar(8000), @SourceGuid nvarchar(50))
as
begin
	declare @hash varchar(128) = '';
	declare @i as int = 0 ;

	set @FQN = upper(@FQN);
	set @hash = (SELECT convert(char(128), HASHBYTES('sha2_512', @FQN), 1) )

	update DataSource set [FqnHASH] = @hash where SourceGuid = @SourceGuid ;

	set @i = (select count(*) from DataSourceFQN where FqnHASH = @hash);

	IF @i = 0
		BEGIN
			insert into DataSourceFQN (FQN, FqnHASH) values (@FQN,@hash);
		END
	ELSE IF @i = 1
		update DataSourceFQN set FqnHASH= @hash where FQN = @FQN;
	ELSE IF @i > 1
	begin
		delete from DataSourceFQN where FQN = @FQN ;
		insert into DataSourceFQN (FQN, FqnHASH) values (@FQN,@hash);
	end
  
end
