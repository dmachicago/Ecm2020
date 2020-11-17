--SELECT TABLE_CATALOG, TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, COLUMN_DEFAULT
--SELECT TABLE_NAME, COLUMN_NAME, ORDINAL_POSITION
SELECT *
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = N'View_Community_Friend_Friends'
--WHERE TABLE_NAME = N'TestAlias'
order by ORDINAL_POSITION
GO


--select V.name, C.column_id, C.name, V.type_desc
select C.*, V.*
from sys.all_columns C
inner join sys.views V on V.object_id = C.object_id
and V.name = 'TestAlias'
--and V.name = 'View_Community_Friend_Friends'

select * from
	INFORMATION_SCHEMA.VIEW_COLUMN_USAGE
where view_name = N'TestAlias'
--where view_name = N'View_Community_Friend_Friends'

select * from
	INFORMATION_SCHEMA.VIEW_TABLE_USAGE
--where view_name = N'TestAlias'
where view_name = N'View_Community_Friend_Friends'

select * from
	INFORMATION_SCHEMA.VIEW_TABLE_USAGE V1
join INFORMATION_SCHEMA.VIEW_TABLE_USAGE V2 on V1.VIEW_NAME = V2.VIEW_NAME
	and V1.TABLE_NAME = V2.TABLE_NAME
--where view_name = N'TestAlias'
where V1.view_name = N'View_Community_Friend_Friends'


SELECT * FROM 
	INFORMATION_SCHEMA.views
WHERE TABLE_NAME = N'TestAlias'
GO


-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
