SELECT * 
FROM INFORMATION_SCHEMA.VIEW_COLUMN_USAGE AS UsedColumns 
WHERE UsedColumns.VIEW_NAME='view_EDW_RewardsDefinition'

SELECT * 
FROM INFORMATION_SCHEMA.VIEW_TABLE_USAGE AS UsedTables 
WHERE UsedTables.VIEW_NAME='view_EDW_RewardsDefinition'

select * 
from INFORMATION_SCHEMA.VIEW_COLUMN_USAGE v
    inner join INFORMATION_SCHEMA.COLUMNS v1
        on  v.VIEW_NAME=v1.TABLE_NAME and v.COLUMN_NAME=v1.COLUMN_NAME
where v.VIEW_NAME='view_EDW_RewardsDefinition'

select * 
from INFORMATION_SCHEMA.VIEWS
where TABLE_NAME like '%view_EDW_RewardsDefinition%'
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
