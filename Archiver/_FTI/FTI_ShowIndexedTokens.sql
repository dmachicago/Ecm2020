SELECT display_term, column_id, document_count 
FROM sys.dm_fts_index_keywords  
  (DB_ID('ECM.Library.FS'), OBJECT_ID('DataSOurce'))