select * from 
INFORMATION_SCHEMA.VIEW_COLUMN_USAGE v inner join INFORMATION_SCHEMA.COLUMNS v1 
on v.VIEW_NAME=v1.TABLE_NAME and v.COLUMN_NAME=v1.COLUMN_NAME 
where v.VIEW_NAME='View_CMS_Tree_Joined'
order by v.COLUMN_NAME

with ViewLevels as
	(select name,type, type_desc, 1 as ObjLevel
	from sys.objects as SO
	where name = 'View_CMS_Tree_Joined'

	union all 

	select obj.name, obj.type, obj.type_desc, ObjLevel + 1
	from sys.objects as obj 
	inner join ViewLevels as VL
	on obj.name = VL.name
	where obj.type = 'U' or obj.type = 'V' and obj.name not like 'View_CMS_Tree_Joined'
	)
select * from ViewLevels VL 
option (maxrecursion 0)

where TYPE = 'V' or TYPE = 'T'
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
