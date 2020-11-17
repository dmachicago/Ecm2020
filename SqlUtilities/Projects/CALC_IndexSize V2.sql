select * from  sys.master_files

SELECT * FROM sys.fulltext_catalogs

SELECT * FROM sys.fulltext_indexes
SELECT * FROM sys.fulltext_document_types
SELECT * FROM sys.fulltext_index_catalog_usages
SELECT * FROM sys.fulltext_stoplists
SELECT * FROM sys.fulltext_stopwords
SELECT * FROM sys.fulltext_system_stopwords
SELECT * FROM sys.fulltext_stoplists
SELECT * FROM sys.fulltext_languages

SELECT document_type, version, manufacturer FROM sys.fulltext_document_types

SELECT * FROM sys.fulltext_languages ORDER BY lcid

SELECT top 1000 display_term, column_id, document_count 
FROM sys.dm_fts_index_keywords   (DB_ID('ECM.Library'), OBJECT_ID('DataSource'))
where display_term like 'dale'

/*
One of the advantages of SQL Server 2008 is that the index is now stored 
within the database. That means you can issue a query that lists the contents 
of the index, something you cannot do in SQL Server 2005. The following SELECT 
statement uses the sys.dm_fts_index_keywords dynamic management function to 
return the list of terms stored in the full-text index created on the ProductDocs table:
*/
SELECT top 100 *
FROM sys.dm_fts_index_keywords


SELECT stopword FROM sys.fulltext_stopwords 

/*
SQL Server 2008 also includes the sys.dm_fts_parser dynamic management function. 
The function lets you test how SQL Server will tokenize a string based on a 
specific language and stoplist. In the following SELECT statement, the function 
parses the phrase “testing for fruit and nuts, any type of nut.”
*/

SELECT special_term, display_term 
FROM sys.dm_fts_parser 
  (' "testing for fruit and nuts, any type of nut" ', 1033, 0, 0)
