--* USEDFINAnalytics;
go

IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.tables
    WHERE TABLE_NAME = 'DFS_DB2Skip'
)
begin 
    CREATE TABLE dbo.[DFS_DB2Skip](DB NVARCHAR(100));
	create unique index PK_DFS_DB2Skip on DFS_DB2Skip (DB);
	insert into dbo.[DFS_DB2Skip] (DB) values ('master');
	insert into dbo.[DFS_DB2Skip] (DB) values ('DBA');
	insert into dbo.[DFS_DB2Skip] (DB) values ('model');
	insert into dbo.[DFS_DB2Skip] (DB) values ('msdb');
	insert into dbo.[DFS_DB2Skip] (DB) values ('tempdb');
end 
