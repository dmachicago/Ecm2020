SELECT * FROM DataSource where SourceName like '%iso'

select * from DataSource where ParentGuid = 'aa9e24f9-5e7f-4e4f-9138-429b7e875c2a'

select * from DataSource where ParentGuid = '2778f8cf-a101-4bc0-8393-bf20c817b575'


Drop TABLE #MyTempTable
go
CREATE TABLE #MyTempTable 
   (
      docid INT PRIMARY KEY ,
      [key] INT NOT NULL
   );
DECLARE @db_id int = db_id('ECM.Library.FS');
DECLARE @table_id int = OBJECT_ID('DataSource');
INSERT INTO #MyTempTable EXEC sp_fulltext_keymappings @table_id;
SELECT * FROM sys.dm_fts_index_keywords_by_document 
   ( @db_id, @table_id ) kbd
   INNER JOIN #MyTempTable tt ON tt.[docid]=kbd.document_id;
GO

DECLARE @table_id int = OBJECT_ID(N'DataSource'); 
EXEC sp_fulltext_keymappings @table_id; 

SELECT * FROM sys.dm_fts_index_keywords_by_document(db_id('ECM.Library.FS'), 
object_id('DataSource'));
GO

select * from sys.dm_fts_parser('$12900', 1033, 0, 1)
select * from sys.dm_fts_parser('$12900', 1033, 0, 0)

select * FROM sys.dm_fts_index_keywords_by_document (DB_ID('ECM.Library.FS'),OBJECT_ID('DataSource')) 
WHERE Document_id = 2039468