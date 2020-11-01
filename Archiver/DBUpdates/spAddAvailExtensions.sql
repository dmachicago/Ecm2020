
IF EXISTS (select 1 from sys.procedures where name = 'spAddAvailExtensions')
	drop procedure spAddAvailExtensions
go

create procedure spAddAvailExtensions
as 
	begin
	CREATE TABLE #temp (
		componenttype nvarchar(100) null,
		componentname nvarchar(100) null,
		clsid nvarchar(100) null,
		fullpath nvarchar(500) null,
		version nvarchar(100) null,
		manufacturer nvarchar(100) null
	);

	INSERT INTO #temp
	EXEC sp_help_fulltext_system_components 'filter'; 

	--insert into [AvailFileTypes] (ExtCode, RepoSvrName, RowCreationDate, RowLastModDate, RowGuid)
	--select A.ExtCode,@@SERVERNAME, getdate(), getdate(), newID()
	--from #temp T, [AvailFileTypes] A
	--where ComponentName Not in (SELECT ExtCode FROM [AvailFileTypes])

	declare @name nvarchAR(50) = '';
	DECLARE db_cursor CURSOR FOR 
	SELECT componenttype 
	FROM #temp

	OPEN db_cursor  
	FETCH NEXT FROM db_cursor INTO @name  

	WHILE @@FETCH_STATUS = 0  
	BEGIN  
		  if not exists (select 1 from [AvailFileTypes] where ExtCode = @name)
		  begin
			insert into [AvailFileTypes] (ExtCode, RepoSvrName, RowCreationDate, RowLastModDate, RowGuid)
				values (@name,@@SERVERNAME, getdate(), getdate(), newID());
		  end
	  
		  FETCH NEXT FROM db_cursor INTO @name 
	END 

	CLOSE db_cursor  
	DEALLOCATE db_cursor 
end