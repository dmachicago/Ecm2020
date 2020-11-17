Exec sp_fulltext_service 'ft_timeout', 600000; -- ten minutes 
Exec sp_fulltext_service 'ism_size',@value=16;-- the max 

DECLARE @table_id int = OBJECT_ID(N'dbo.DataSource');
EXEC sp_fulltext_keymappings @table_id;



SELECT * FROM sys.fulltext_catalogs
EXEC sp_fulltext_recycle_crawl_log @ftcat = 'ftDataSource'

select * from DataSource where SourceGuid = '00681e21-23da-4f8c-b619-80fb2b60d849'