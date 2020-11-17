--W. Dale Miller
--Feb. 17, 2011
--Find Index Overlaps
CREATE FUNCTION dbo.INDEX_COL_PROPERTIES (@TabName nvarchar(128), @IndexId INT, @ColId INT)
RETURNS INT
WITH EXECUTE AS CALLER
AS
BEGIN
       DECLARE @IsDescending INT;
       SELECT @IsDescending = is_descending_key
       FROM sys.index_columns SYSIDXCOLS
       WHERE OBJECT_ID(@TabName) = SYSIDXCOLS.object_id
       AND @IndexId = SYSIDXCOLS.index_id
       AND @ColId = SYSIDXCOLS.key_ordinal;
 
       -- Return the value of @IsDescending as the property
       RETURN(@IsDescending);
END;
GO
 
-- Find Duplicate Indexes in SQL Server Database
CREATE VIEW IndexList_VW AS
SELECT
       SYSSCH.[name] AS SchemaName,
       SYSOBJ.[name] AS TableName,
       SYSIDX.[name] AS IndexName,
       SYSIDX.[is_unique] AS IndexIsUnique,
       SYSIDX.[type_desc] AS IndexType,
       SYSIDX.[is_disabled] AS IsDisabled,
       INDEX_COL( SCHEMA_NAME(SYSOBJ.SCHEMA_ID)+'.'+SYSOBJ.[name], SYSIDX.index_id, 1 ) AS Column1,
       INDEX_COL( SCHEMA_NAME(SYSOBJ.SCHEMA_ID)+'.'+SYSOBJ.[name], SYSIDX.index_id, 2 ) AS Column2,
       INDEX_COL( SCHEMA_NAME(SYSOBJ.SCHEMA_ID)+'.'+SYSOBJ.[name], SYSIDX.index_id, 3 ) AS Column3,
       INDEX_COL( SCHEMA_NAME(SYSOBJ.SCHEMA_ID)+'.'+SYSOBJ.[name], SYSIDX.index_id, 4 ) AS Column4,
       INDEX_COL( SCHEMA_NAME(SYSOBJ.SCHEMA_ID)+'.'+SYSOBJ.[name], SYSIDX.index_id, 5 ) AS Column5,
       INDEX_COL( SCHEMA_NAME(SYSOBJ.SCHEMA_ID)+'.'+SYSOBJ.[name], SYSIDX.index_id, 6 ) AS Column6,
       INDEX_COL( SCHEMA_NAME(SYSOBJ.SCHEMA_ID)+'.'+SYSOBJ.[name], SYSIDX.index_id, 7 ) AS Column7,
       INDEX_COL( SCHEMA_NAME(SYSOBJ.SCHEMA_ID)+'.'+SYSOBJ.[name], SYSIDX.index_id, 8 ) AS Column8,
       INDEX_COL( SCHEMA_NAME(SYSOBJ.SCHEMA_ID)+'.'+SYSOBJ.[name], SYSIDX.index_id, 9 ) AS Column9,
       INDEX_COL( SCHEMA_NAME(SYSOBJ.SCHEMA_ID)+'.'+SYSOBJ.[name], SYSIDX.index_id, 10 ) AS Column10,
       INDEX_COL( SCHEMA_NAME(SYSOBJ.SCHEMA_ID)+'.'+SYSOBJ.[name], SYSIDX.index_id, 11 ) AS Column11,
       INDEX_COL( SCHEMA_NAME(SYSOBJ.SCHEMA_ID)+'.'+SYSOBJ.[name], SYSIDX.index_id, 12 ) AS Column12,
       INDEX_COL( SCHEMA_NAME(SYSOBJ.SCHEMA_ID)+'.'+SYSOBJ.[name], SYSIDX.index_id, 13 ) AS Column13,
       INDEX_COL( SCHEMA_NAME(SYSOBJ.SCHEMA_ID)+'.'+SYSOBJ.[name], SYSIDX.index_id, 14 ) AS Column14,
       INDEX_COL( SCHEMA_NAME(SYSOBJ.SCHEMA_ID)+'.'+SYSOBJ.[name], SYSIDX.index_id, 15 ) AS Column15,
       INDEX_COL( SCHEMA_NAME(SYSOBJ.SCHEMA_ID)+'.'+SYSOBJ.[name], SYSIDX.index_id, 16 ) AS Column16,
       dbo.INDEX_COL_PROPERTIES( SCHEMA_NAME(SYSOBJ.SCHEMA_ID)+'.'+SYSOBJ.[name], SYSIDX.index_id, 1 ) AS Column1_Prop,
       dbo.INDEX_COL_PROPERTIES( SCHEMA_NAME(SYSOBJ.SCHEMA_ID)+'.'+SYSOBJ.[name], SYSIDX.index_id, 2 ) AS Column2_Prop,
       dbo.INDEX_COL_PROPERTIES( SCHEMA_NAME(SYSOBJ.SCHEMA_ID)+'.'+SYSOBJ.[name], SYSIDX.index_id, 3 ) AS Column3_Prop,
       dbo.INDEX_COL_PROPERTIES( SCHEMA_NAME(SYSOBJ.SCHEMA_ID)+'.'+SYSOBJ.[name], SYSIDX.index_id, 4 ) AS Column4_Prop,
       dbo.INDEX_COL_PROPERTIES( SCHEMA_NAME(SYSOBJ.SCHEMA_ID)+'.'+SYSOBJ.[name], SYSIDX.index_id, 5 ) AS Column5_Prop,
       dbo.INDEX_COL_PROPERTIES( SCHEMA_NAME(SYSOBJ.SCHEMA_ID)+'.'+SYSOBJ.[name], SYSIDX.index_id, 6 ) AS Column6_Prop,
       dbo.INDEX_COL_PROPERTIES( SCHEMA_NAME(SYSOBJ.SCHEMA_ID)+'.'+SYSOBJ.[name], SYSIDX.index_id, 7 ) AS Column7_Prop,
       dbo.INDEX_COL_PROPERTIES( SCHEMA_NAME(SYSOBJ.SCHEMA_ID)+'.'+SYSOBJ.[name], SYSIDX.index_id, 8 ) AS Column8_Prop,
       dbo.INDEX_COL_PROPERTIES( SCHEMA_NAME(SYSOBJ.SCHEMA_ID)+'.'+SYSOBJ.[name], SYSIDX.index_id, 9 ) AS Column9_Prop,
       dbo.INDEX_COL_PROPERTIES( SCHEMA_NAME(SYSOBJ.SCHEMA_ID)+'.'+SYSOBJ.[name], SYSIDX.index_id, 10 ) AS Column10_Prop,
       dbo.INDEX_COL_PROPERTIES( SCHEMA_NAME(SYSOBJ.SCHEMA_ID)+'.'+SYSOBJ.[name], SYSIDX.index_id, 11 ) AS Column11_Prop,
       dbo.INDEX_COL_PROPERTIES( SCHEMA_NAME(SYSOBJ.SCHEMA_ID)+'.'+SYSOBJ.[name], SYSIDX.index_id, 12 ) AS Column12_Prop,
       dbo.INDEX_COL_PROPERTIES( SCHEMA_NAME(SYSOBJ.SCHEMA_ID)+'.'+SYSOBJ.[name], SYSIDX.index_id, 13 ) AS Column13_Prop,
       dbo.INDEX_COL_PROPERTIES( SCHEMA_NAME(SYSOBJ.SCHEMA_ID)+'.'+SYSOBJ.[name], SYSIDX.index_id, 14 ) AS Column14_Prop,
       dbo.INDEX_COL_PROPERTIES( SCHEMA_NAME(SYSOBJ.SCHEMA_ID)+'.'+SYSOBJ.[name], SYSIDX.index_id, 15 ) AS Column15_Prop,
       dbo.INDEX_COL_PROPERTIES( SCHEMA_NAME(SYSOBJ.SCHEMA_ID)+'.'+SYSOBJ.[name], SYSIDX.index_id, 16 ) AS Column16_Prop
FROM sys.indexes SYSIDX INNER JOIN sys.objects SYSOBJ ON SYSIDX.[object_id] = SYSOBJ.[object_id]
       INNER JOIN sys.schemas SYSSCH ON SYSOBJ.schema_id = SYSSCH.schema_id
WHERE SYSIDX.index_id > 0
       AND INDEXPROPERTY(SYSOBJ.[object_id], SYSIDX.[name], 'IsStatistics') = 0
GO
 
SELECT
       vwA.SchemaName,
       vwA.TableName,
       vwA.IndexIsUnique,
       vwA.IndexType,
       vwA.IndexName,
       vwB.IndexName AS OverlappingIndex,
       vwA.Column1, vwA.Column2, vwA.Column3, vwA.Column4, vwA.Column5, vwA.Column6, vwA.Column7, vwA.Column8,
       vwA.Column9, vwA.Column10, vwA.Column11, vwA.Column12, vwA.Column13, vwA.Column14, vwA.Column15, vwA.Column16    
FROM IndexList_VW vwA INNER JOIN IndexList_VW vwB ON vwA.TableName=vwB.TableName
       AND vwA.IndexName <> vwB.IndexName
       AND vwA.IsDisabled = 0
       AND vwB.IsDisabled = 0
       AND  (vwA.Column1=vwB.Column1 AND vwA.Column1_Prop=vwB.Column1_Prop)
       AND ((vwA.Column2=vwB.Column2 AND vwA.Column2_Prop=vwB.Column2_Prop) OR vwA.Column2 IS NULL OR vwB.Column2 IS NULL)
       AND ((vwA.Column3=vwB.Column3 AND vwA.Column3_Prop=vwB.Column3_Prop) OR vwA.Column3 IS NULL OR vwB.Column3 IS NULL)
       AND ((vwA.Column4=vwB.Column4 AND vwA.Column4_Prop=vwB.Column4_Prop) OR vwA.Column4 IS NULL OR vwB.Column4 IS NULL)
       AND ((vwA.Column5=vwB.Column5 AND vwA.Column5_Prop=vwB.Column5_Prop) OR vwA.Column5 IS NULL OR vwB.Column5 IS NULL)
       AND ((vwA.Column6=vwB.Column6 AND vwA.Column6_Prop=vwB.Column6_Prop) OR vwA.Column6 IS NULL OR vwB.Column6 IS NULL)
       AND ((vwA.Column7=vwB.Column7 AND vwA.Column7_Prop=vwB.Column7_Prop) OR vwA.Column7 IS NULL OR vwB.Column7 IS NULL)
       AND ((vwA.Column8=vwB.Column8 AND vwA.Column8_Prop=vwB.Column8_Prop) OR vwA.Column8 IS NULL OR vwB.Column8 IS NULL)
       AND ((vwA.Column9=vwB.Column9 AND vwA.Column9_Prop=vwB.Column9_Prop) OR vwA.Column9 IS NULL OR vwB.Column9 IS NULL)
       AND ((vwA.Column10=vwB.Column10 AND vwA.Column10_Prop=vwB.Column10_Prop) OR vwA.Column10 IS NULL OR vwB.Column10 IS NULL)
       AND ((vwA.Column11=vwB.Column11 AND vwA.Column11_Prop=vwB.Column11_Prop) OR vwA.Column11 IS NULL OR vwB.Column11 IS NULL)
       AND ((vwA.Column12=vwB.Column12 AND vwA.Column12_Prop=vwB.Column12_Prop) OR vwA.Column12 IS NULL OR vwB.Column12 IS NULL)
       AND ((vwA.Column13=vwB.Column13 AND vwA.Column13_Prop=vwB.Column13_Prop) OR vwA.Column13 IS NULL OR vwB.Column13 IS NULL)
       AND ((vwA.Column14=vwB.Column14 AND vwA.Column14_Prop=vwB.Column14_Prop) OR vwA.Column14 IS NULL OR vwB.Column14 IS NULL)
       AND ((vwA.Column15=vwB.Column15 AND vwA.Column15_Prop=vwB.Column15_Prop) OR vwA.Column15 IS NULL OR vwB.Column15 IS NULL)
       AND ((vwA.Column16=vwB.Column16 AND vwA.Column16_Prop=vwB.Column16_Prop) OR vwA.Column16 IS NULL OR vwB.Column16 IS NULL)
ORDER BY
       vwA.TableName, vwA.IndexName
GO
 
-- Drop function and view created above.
DROP FUNCTION dbo.INDEX_COL_PROPERTIES
GO
DROP VIEW IndexList_VW
GO
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
