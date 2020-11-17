
declare @table_name as nvarchar(100) = 'CMS_USER';
declare @COLUMN_NAME as nvarchar(100) = '';
declare @ORDINAL_POSITION as int  = 0 ;
declare @is_nullable as nvarchar(100) = '';
declare @DATA_TYPE as  nvarchar(100) = '';
declare @CHARACTER_MAXIMUM_LENGTH as int  = 0 ;
declare @s as nvarchar(max) = '';
 
DECLARE C CURSOR FOR 
SELECT COLUMN_NAME, ORDINAL_POSITION, is_nullable, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS
WHERE table_name = @table_name;

OPEN C;
 
FETCH NEXT FROM C
INTO @COLUMN_NAME, @ORDINAL_POSITION, @is_nullable, @DATA_TYPE, @CHARACTER_MAXIMUM_LENGTH

WHILE @@FETCH_STATUS = 0
BEGIN
    set @s = '' ;
    set @s = @s + 'if not exists (select column_name from information_schema.COLUMNS where table_name = ''' + @table_name + ''' and COLUMN_NAME = ''' + @COLUMN_NAME + ''')' ;
    set @s = @s + char(10) + 'begin ' ;
	   set @s = @s + char(10) + '     alter table ' + @table_name + ' add ' + @COLUMN_NAME + ' '  ;
	   if @DATA_TYPE = 'datetime' or @DATA_TYPE = 'datetime2' or @DATA_TYPE = 'time' 
		  set @s = @s + + @DATA_TYPE   ;
	   if @DATA_TYPE = 'int' or @DATA_TYPE = 'decimal' or @DATA_TYPE = 'float' or @DATA_TYPE = 'bit'  or @DATA_TYPE = 'uniqueidentifier'
		  set @s = @s + + @DATA_TYPE   ;
	   if @DATA_TYPE = 'nvarchar' or @DATA_TYPE = 'varchar' or @DATA_TYPE = 'nchar' or @DATA_TYPE = 'char'
		  if @CHARACTER_MAXIMUM_LENGTH < 0 
			 set @s = @s + + @DATA_TYPE  + '(max)' ;
			 else
		  set @s = @s + + @DATA_TYPE  + '(' + cast(@CHARACTER_MAXIMUM_LENGTH as nvarchar(50)) + ')' ;
	   if @is_nullable = 'YES'
		  set @s = @s + '  null ' ;
	   else 
		  set @s = @s + '  NOT null ' ;
    set @s = @s + char(10) + 'end ' + char(10) ;
    FETCH NEXT FROM C INTO @COLUMN_NAME, @ORDINAL_POSITION, @is_nullable, @DATA_TYPE, @CHARACTER_MAXIMUM_LENGTH
    print @s;
end

close C ;
deallocate C ;
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
