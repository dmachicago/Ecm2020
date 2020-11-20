--select top 20 * from DataSource;
--select FQN, RetentionCode from directory order by RetentionCode
--select * from retention

DROP PROCEDURE IF EXISTS sp_SetRetentionDates;
go

create procedure sp_SetRetentionDates as
begin

	DECLARE @TempDirName VARCHAR(750) = '';
	DECLARE @DirName VARCHAR(750) = '';	
	DECLARE @RetentionCode VARCHAR(50) = ''; 
	DECLARE @RetentionUnits int = 0 ;
	DECLARE @fileDate VARCHAR(20) = '' ;
	
	DECLARE db_cursor CURSOR FOR 
	select FQN, RetentionCode from directory order by RetentionCode

	OPEN db_cursor  
	FETCH NEXT FROM db_cursor INTO @DirName, @RetentionCode

	WHILE @@FETCH_STATUS = 0  
	BEGIN  
			set @TempDirName = @DirName + '%';
			SET @RetentionUnits = (select RetentionUnits from retention where RetentionCode = @RetentionCode)
			update DataSource set RetentionCode = @RetentionCode, 
					RetentionDate = DATEADD(year, @RetentionUnits, RowCreationDate), 
					RepoSvrName = @@SERVERNAME ,
					 CreateDate = RowCreationDate
			where Fqn like @TempDirName;
			print 'Updated: ' + @DirName ;
			FETCH NEXT FROM db_cursor INTO @DirName, @RetentionCode
	END 

	CLOSE db_cursor  
	DEALLOCATE db_cursor 
end
go
exec sp_SetRetentionDates