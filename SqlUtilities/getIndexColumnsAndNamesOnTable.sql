

-- use KenticoCMS_DataMart
begin try 
    drop table #tidx ;
end try
begin catch
    print 'dropped table #tidx ';
end catch

declare @TblName nvarchar(250) = 'dbo.BASE_HFit_TrackerBloodPressure' ;
SELECT i.name AS index_name
    ,COL_NAME(ic.object_id,ic.column_id) AS column_name
    ,ic.index_column_id
    ,ic.key_ordinal
,ic.is_included_column
into #tidx
FROM sys.indexes AS i
INNER JOIN sys.index_columns AS ic 
    ON i.object_id = ic.object_id AND i.index_id = ic.index_id
WHERE i.object_id = OBJECT_ID(@TblName );


select * from #tidx
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
