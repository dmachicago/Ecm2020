
/* Retrieve words form the full-Text Index that start with Liz */

SELECT *
FROM sys.dm_fts_index_keywords_by_document(DB_ID(), OBJECT_ID('dbo.datasource'))
WHERE display_term LIKE N'liz%';

/*Get current list of full text catalogs */

SELECT [name] AS CatalogName, 
       path, 
       is_default
FROM sys.fulltext_catalogs
ORDER BY [name];

/*Get the list of StopLists*/

SELECT stoplist_id, 
       name
FROM sys.fulltext_stoplists;

/*
This query returns a list of StopWords in the database. Note the linking to get the associated StopList name and language.

 – Get list of StopWords
*/

SELECT sl.name AS StopListName, 
       sw.stopword AS StopWord, 
       lg.alias AS LanguageAlias, 
       lg.name AS LanguageName, 
       lg.lcid AS LanguageLCID
FROM sys.fulltext_stopwords sw
     JOIN sys.fulltext_stoplists sl ON sl.stoplist_id = sw.stoplist_id
     JOIN master.sys.syslanguages lg ON lg.lcid = sw.language_id;

/*
This next query gets a list of all of the stopwords that ship with SQL Server 2008. This is a nice improvement, you can not do this in SQL Server 2005.

– Get a list of the System provided stopwords  
*/

SELECT ssw.stopword, 
       slg.name
FROM sys.fulltext_system_stopwords ssw
     JOIN sys.fulltext_languages slg ON slg.lcid = ssw.language_id;

--My next query returns a list of all the Full Text Indexes in the database.
-- List full text indexes

SELECT c.name AS CatalogName, 
       t.name AS TableName, 
       idx.name AS UniqueIndexName,
       CASE i.is_enabled
           WHEN 1
           THEN 'Enabled'
           ELSE 'Not Enabled'
       END AS IsEnabled, 
       i.change_tracking_state_desc, 
       sl.name AS StopListName
FROM sys.fulltext_indexes i
     JOIN sys.fulltext_catalogs c ON i.fulltext_catalog_id = c.fulltext_catalog_id
     JOIN sys.tables t ON i.object_id = t.object_id
     JOIN sys.indexes idx ON i.unique_index_id = idx.index_id
                             AND i.object_id = idx.object_id
     LEFT JOIN sys.fulltext_stoplists sl ON sl.stoplist_id = i.stoplist_id;

--This query returns a list of all the document types SQL Server 2008 understands when they are placed in a varbinary(max) field.
-- List all of the document types SQL Server 2008 will understand in varbinary(max) field

SELECT document_type, 
       path, 
       [version], 
       manufacturer
FROM sys.fulltext_document_types;

/*
If your full text performance begins to suffer over time, you might want to check and see how many fragments exist. 
- If you have multiple closed fragments, you should consider doing a REORGANIZE on the index (using alter fulltext 
- index). This query will tell you how many fragments exist for your full text index.
– See how many fragments exist for each full text index.
– If multiple closed fragments exist for a table do a REORGANIZE to help performance
*/

SELECT t.name AS TableName, 
       f.data_size, 
       f.row_count,
       CASE f.STATUS
           WHEN 0
           THEN 'Newly created and not yet used'
           WHEN 1
           THEN 'Being used for insert'
           WHEN 4
           THEN 'Closed ready for query'
           WHEN 6
           THEN 'Being used for merge inpurt and ready for query'
           WHEN 8
           THEN 'Marked for deletion. Will not be used for query and merge source'
           ELSE 'Unknown status code'
       END
FROM sys.fulltext_index_fragments f
     JOIN sys.tables t ON f.table_id = t.object_id;