select 
    i.name as IndexName, 
    o.name as TableName, 
    ic.key_ordinal as ColumnOrder,
    ic.is_included_column as IsIncluded, 
    co.[name] as ColumnName,
	i.[type],
	i.[is_unique]
from sys.indexes i 
join sys.objects o on i.object_id = o.object_id
join sys.index_columns ic on ic.object_id = i.object_id 
    and ic.index_id = i.index_id
join sys.columns co on co.object_id = i.object_id 
    and co.column_id = ic.column_id
where i.name = 'IX_View_CMS_Tree_Joined_Regular_NodeSiteID_DocumentCulture_NodeID'	
order by o.[name], i.[name], ic.is_included_column, ic.key_ordinal
