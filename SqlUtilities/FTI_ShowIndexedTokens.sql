--LOCATION OF CRAWL LOGS
--C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\Log


--ID & Names are unique to the database context, so make sure your in the correct database.
    SELECT * FROM sys.fulltext_catalogs
--Once you have run this, make a note of the catalog name, we will need that in a moment.
--Refresh The Catalog
--Once executed, a new log file will be created in your log directory. After a period of time, mostly defined 
--by you, the old log files can be removed from disk.
EXEC sp_fulltext_recycle_crawl_log @ftcat = 'ftCatalog'


SELECT display_term, column_id, document_count 
	FROM sys.dm_fts_index_keywords  
		(DB_ID('ECM.Library.FS'), OBJECT_ID('DataSource'))

DECLARE @table_id int = OBJECT_ID(N'dbo.DataSource');
EXEC sp_fulltext_keymappings @table_id;


declare @varbinary varbinary(900)
set  @varbinary =0x506F776572706F696E7446696C652E707074 
select convert(varchar(50),@varbinary)