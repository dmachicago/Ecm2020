SELECT t.name AS TableName, c.name AS FTCatalogName  
FROM sys.tables t JOIN sys.fulltext_indexes i  
  ON t.object_id = i.object_id  
JOIN sys.fulltext_catalogs c  
  ON i.fulltext_catalog_id = c.fulltext_catalog_id