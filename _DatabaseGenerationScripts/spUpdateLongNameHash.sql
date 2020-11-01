
if exists (select 1 from sys.procedures where name = 'spUpdateLongNameHash')
	drop procedure spUpdateLongNameHash
GO

CREATE procedure spUpdateLongNameHash(@FQN varchar(8000), @SourceGuid nvarchar(50))
as
begin
	declare @hash varchar(128) = '';
	set @FQN = upper(@FQN);

	set @hash = (SELECT convert(char(125), HASHBYTES('sha2_512', @FQN), 2) )

	update DataSource set [FqnHASH] = @hash where SourceGuid = @SourceGuid ;

	if not exists (select 1 from DataSourceFQN where FqnHASH = @hash)
		insert into DataSourceFQN (FQN, FqnHASH) values (@FQN,@hash);
	
end

declare @dir varchar(50) = 'C:\DEV\ECM2020';
set @dir = upper(@dir);

SELECT convert(char(125), HASHBYTES('sha2_512', @dir), 2) as XHASH; 
--SELECT convert(char(128), HASHBYTES('sha2_512', 'C:\DEV\ECM2020'), 2) as XHASH; 

/*
A092BFA223DDD155C6292F87DCDF74E840AC5DAAF7055366D8092336A4F179944D1D7DA226D5FDEFD2DEB39E979EE15086FDB6541F05B17D7F1BCA3ACD9B 
A092BFA223DDD155C6292F87DCDF74E840AC5DAAF7055366D8092336A4F179944D1D7DA226D5FDEFD2DEB39E979EE15086FDB6541F05B17D7F1BCA3ACD9B2EB8
A092BFA223DDD155C6292F87DCDF74E840AC5DAAF7055366D8092336A4F179944D1D7DA226D5FDEFD2DEB39E979EE15086FDB6541F05B17D7F1BCA3ACD9B2EB8
*/