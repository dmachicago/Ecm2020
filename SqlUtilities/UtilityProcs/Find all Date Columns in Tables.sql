select distinct c.TABLE_NAME, c.COLUMN_NAME      
    from INFORMATION_SCHEMA.COLUMNS as c 
    where c.DATA_TYPE like 'date%'
    and c.COLUMN_NAME != 'RowLastModDate'
    and c.COLUMN_NAME != 'RowCreationDate'
   
