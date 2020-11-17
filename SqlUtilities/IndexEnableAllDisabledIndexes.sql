

ALTER INDEX [IX_StoreContact_ContactTypeID] ON Sales.StoreContact REBUILD

select 'ALTER INDEX [' + sys.indexes.name + ' ON ]' + sys.objects.name  + '] REBUILD ' AS DDL
from sys.indexes
    inner join sys.objects on sys.objects.object_id = sys.indexes.object_id
where sys.indexes.name is not null
and sys.indexes.is_disabled = 1
order by
    sys.objects.name,
    sys.indexes.name
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
