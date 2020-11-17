-- KDF9's concise index list for SQL Server 2005+  (see below for 2000)
--   includes schemas and primary keys, in easy to read format
--   with unique, clustered, and all ascending/descendings in a single column
-- Needs simple manual add or delete to change maximum number of key columns
--   but is easy to understand and modify, with no UDFs or complex logic
--
SELECT
  schema_name(schema_id) as SchemaName, OBJECT_NAME(si.object_id) as TableName, si.name as IndexName,
  (CASE is_primary_key WHEN 1 THEN 'PK' ELSE '' END) as PK,
  (CASE is_unique WHEN 1 THEN '1' ELSE '0' END)+' '+
  (CASE si.type WHEN 1 THEN 'C' WHEN 3 THEN 'X' ELSE 'B' END)+' '+  -- B=basic, C=Clustered, X=XML
  (CASE INDEXKEY_PROPERTY(si.object_id,index_id,1,'IsDescending') WHEN 0 THEN 'A' WHEN 1 THEN 'D' ELSE '' END)+
  (CASE INDEXKEY_PROPERTY(si.object_id,index_id,2,'IsDescending') WHEN 0 THEN 'A' WHEN 1 THEN 'D' ELSE '' END)+
  (CASE INDEXKEY_PROPERTY(si.object_id,index_id,3,'IsDescending') WHEN 0 THEN 'A' WHEN 1 THEN 'D' ELSE '' END)+
  (CASE INDEXKEY_PROPERTY(si.object_id,index_id,4,'IsDescending') WHEN 0 THEN 'A' WHEN 1 THEN 'D' ELSE '' END)+
  (CASE INDEXKEY_PROPERTY(si.object_id,index_id,5,'IsDescending') WHEN 0 THEN 'A' WHEN 1 THEN 'D' ELSE '' END)+
  (CASE INDEXKEY_PROPERTY(si.object_id,index_id,6,'IsDescending') WHEN 0 THEN 'A' WHEN 1 THEN 'D' ELSE '' END)+
  '' as 'Type',
  INDEX_COL(schema_name(schema_id)+'.'+OBJECT_NAME(si.object_id),index_id,1) as Key1,
  INDEX_COL(schema_name(schema_id)+'.'+OBJECT_NAME(si.object_id),index_id,2) as Key2,
  INDEX_COL(schema_name(schema_id)+'.'+OBJECT_NAME(si.object_id),index_id,3) as Key3,
  INDEX_COL(schema_name(schema_id)+'.'+OBJECT_NAME(si.object_id),index_id,4) as Key4,
  INDEX_COL(schema_name(schema_id)+'.'+OBJECT_NAME(si.object_id),index_id,5) as Key5,
  INDEX_COL(schema_name(schema_id)+'.'+OBJECT_NAME(si.object_id),index_id,6) as Key6
FROM sys.indexes as si
LEFT JOIN sys.objects as so on so.object_id=si.object_id
WHERE index_id>0 -- omit the default heap
  and OBJECTPROPERTY(si.object_id,'IsMsShipped')=0 -- omit system tables
  and not (schema_name(schema_id)='dbo' and OBJECT_NAME(si.object_id)='sysdiagrams') -- omit sysdiagrams
ORDER BY SchemaName,TableName,IndexName

-------------------------------------------------------------------
-- or to generate creation scripts put a simple wrapper around that
SELECT SchemaName, TableName, IndexName,
  (CASE pk
    WHEN 'PK' THEN 'ALTER '+
     'TABLE '+SchemaName+'.'+TableName+' ADD CONSTRAINT '+IndexName+' PRIMARY KEY'+
     (CASE substring(Type,3,1) WHEN 'C' THEN ' CLUSTERED' ELSE '' END)
    ELSE 'CREATE '+
     (CASE substring(Type,1,1) WHEN '1' THEN 'UNIQUE ' ELSE '' END)+
     (CASE substring(Type,3,1) WHEN 'C' THEN 'CLUSTERED ' ELSE '' END)+
     'INDEX '+IndexName+' ON '+SchemaName+'.'+TableName
    END)+
  ' ('+
    (CASE WHEN Key1 is null THEN '' ELSE      Key1+(CASE substring(Type,4+1,1) WHEN 'D' THEN ' DESC' ELSE '' END) END)+
    (CASE WHEN Key2 is null THEN '' ELSE ', '+Key2+(CASE substring(Type,4+2,1) WHEN 'D' THEN ' DESC' ELSE '' END) END)+
    (CASE WHEN Key3 is null THEN '' ELSE ', '+Key3+(CASE substring(Type,4+3,1) WHEN 'D' THEN ' DESC' ELSE '' END) END)+
    (CASE WHEN Key4 is null THEN '' ELSE ', '+Key4+(CASE substring(Type,4+4,1) WHEN 'D' THEN ' DESC' ELSE '' END) END)+
    (CASE WHEN Key5 is null THEN '' ELSE ', '+Key5+(CASE substring(Type,4+5,1) WHEN 'D' THEN ' DESC' ELSE '' END) END)+
    (CASE WHEN Key6 is null THEN '' ELSE ', '+Key6+(CASE substring(Type,4+6,1) WHEN 'D' THEN ' DESC' ELSE '' END) END)+
    ')' as CreateIndex
FROM (
SELECT
  schema_name(schema_id) as SchemaName, OBJECT_NAME(si.object_id) as TableName, si.name as IndexName,
  (CASE is_primary_key WHEN 1 THEN 'PK' ELSE '' END) as PK,
  (CASE is_unique WHEN 1 THEN '1' ELSE '0' END)+' '+
  (CASE si.type WHEN 1 THEN 'C' WHEN 3 THEN 'X' ELSE 'B' END)+' '+  -- B=basic, C=Clustered, X=XML
  (CASE INDEXKEY_PROPERTY(si.object_id,index_id,1,'IsDescending') WHEN 0 THEN 'A' WHEN 1 THEN 'D' ELSE '' END)+
  (CASE INDEXKEY_PROPERTY(si.object_id,index_id,2,'IsDescending') WHEN 0 THEN 'A' WHEN 1 THEN 'D' ELSE '' END)+
  (CASE INDEXKEY_PROPERTY(si.object_id,index_id,3,'IsDescending') WHEN 0 THEN 'A' WHEN 1 THEN 'D' ELSE '' END)+
  (CASE INDEXKEY_PROPERTY(si.object_id,index_id,4,'IsDescending') WHEN 0 THEN 'A' WHEN 1 THEN 'D' ELSE '' END)+
  (CASE INDEXKEY_PROPERTY(si.object_id,index_id,5,'IsDescending') WHEN 0 THEN 'A' WHEN 1 THEN 'D' ELSE '' END)+
  (CASE INDEXKEY_PROPERTY(si.object_id,index_id,6,'IsDescending') WHEN 0 THEN 'A' WHEN 1 THEN 'D' ELSE '' END)+
  '' as 'Type',
  INDEX_COL(schema_name(schema_id)+'.'+OBJECT_NAME(si.object_id),index_id,1) as Key1,
  INDEX_COL(schema_name(schema_id)+'.'+OBJECT_NAME(si.object_id),index_id,2) as Key2,
  INDEX_COL(schema_name(schema_id)+'.'+OBJECT_NAME(si.object_id),index_id,3) as Key3,
  INDEX_COL(schema_name(schema_id)+'.'+OBJECT_NAME(si.object_id),index_id,4) as Key4,
  INDEX_COL(schema_name(schema_id)+'.'+OBJECT_NAME(si.object_id),index_id,5) as Key5,
  INDEX_COL(schema_name(schema_id)+'.'+OBJECT_NAME(si.object_id),index_id,6) as Key6
FROM sys.indexes as si
LEFT JOIN sys.objects as so on so.object_id=si.object_id
WHERE index_id>0 -- omit the default heap
  and OBJECTPROPERTY(si.object_id,'IsMsShipped')=0 -- omit system tables
  and not (schema_name(schema_id)='dbo' and OBJECT_NAME(si.object_id)='sysdiagrams') -- omit sysdiagrams
  ) as indexes
ORDER BY SchemaName,TableName,IndexName


-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
