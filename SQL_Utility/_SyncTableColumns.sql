
DECLARE @name VARCHAR(50) ;
DECLARE @TABLE_NAME varchar(250) ; 
DECLARE @COLUMN_NAME varchar(250) ;
DECLARE @IS_NULLABLE varchar(10) ;
DECLARE @DATA_TYPE varchar(50) ;
DECLARE @CHARACTER_MAXIMUM_LENGTH int;
DECLARE @NUMERIC_PRECISION int;
DECLARE @NUMERIC_PRECISION_RADIX int;
DECLARE @NUMERIC_SCALE int;
DECLARE @DATETIME_PRECISION int;
declare @sql nvarchar(max) = '' ;

DECLARE db_cursor CURSOR FOR 
select TABLE_NAME, COLUMN_NAME, IS_NULLABLE, DATA_TYPE,
	CHARACTER_MAXIMUM_LENGTH, NUMERIC_PRECISION, NUMERIC_PRECISION_RADIX, NUMERIC_SCALE,
	DATETIME_PRECISION
from INFORMATION_SCHEMA.COLUMNS order by TABLE_NAME, COLUMN_NAME;

OPEN db_cursor  
FETCH NEXT FROM db_cursor INTO @TABLE_NAME, @COLUMN_NAME, @IS_NULLABLE, @DATA_TYPE,
				@CHARACTER_MAXIMUM_LENGTH, @NUMERIC_PRECISION, @NUMERIC_PRECISION_RADIX, @NUMERIC_SCALE,
				@DATETIME_PRECISION;

WHILE @@FETCH_STATUS = 0  
BEGIN  

      FETCH NEXT FROM db_cursor INTO @TABLE_NAME, @COLUMN_NAME, @IS_NULLABLE, @DATA_TYPE,
				@CHARACTER_MAXIMUM_LENGTH, @NUMERIC_PRECISION, @NUMERIC_PRECISION_RADIX, @NUMERIC_SCALE,
				@DATETIME_PRECISION;

				set @sql = 'If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = ''' + @COLUMN_NAME + '''' + ' and table_name = ''' + @TABLE_NAME +'''' + char(10) ;
				set @sql = @sql + 'BEGIN' + CHAR(10)
				set @sql = @sql + '    alter table ''' + @TABLE_NAME +'''' + ' add ' + @COLUMN_NAME + ' ' 
				set @sql = @sql + ' ' + @DATA_TYPE ;
				if @data_type = 'nvarchar'
				begin 
						if (@CHARACTER_MAXIMUM_LENGTH >0 )
							set @sql = @sql + ' (' + cast(@CHARACTER_MAXIMUM_LENGTH as nvarchar(20)) + ')' ;
						else 
							set @sql = @sql + ' (max)' ;
				end
				else if @data_type = 'varchar'
				begin 
						if (@CHARACTER_MAXIMUM_LENGTH >0 )
							set @sql = @sql + ' (' + cast(@CHARACTER_MAXIMUM_LENGTH as nvarchar(20)) + ')' ;
						else 
							set @sql = @sql + ' (max)' ;
				end
				else if @data_type = 'nchar'
				begin
						if (@CHARACTER_MAXIMUM_LENGTH >0 )
							set @sql = @sql + ' (' + cast(@CHARACTER_MAXIMUM_LENGTH as nvarchar(20)) + ')' ;
						else 
							set @sql = @sql + ' (max)' ;
				end;
				else if @data_type = 'char'
				begin
						if (@CHARACTER_MAXIMUM_LENGTH >0 )
							set @sql = @sql + ' (' + cast(@CHARACTER_MAXIMUM_LENGTH as nvarchar(20)) + ')' ;
						else 
							set @sql = @sql + ' (max)' ;
				end;
				else if @data_type = 'bit'
				begin
					set @sql = @sql + ' ;'
				end;
				else if @data_type = 'datetime'
				begin
					set @sql = @sql + ' ;'
				end;
				else if @data_type = 'uniqueidentifier'
				begin
					set @sql = @sql + ' ;'
				end;
				else if @data_type = 'image'
				begin
					set @sql = @sql + ' ;'
				end;
				else if @data_type = 'binary'
				begin
						if (@CHARACTER_MAXIMUM_LENGTH >0 )
							set @sql = @sql + ' (' + cast(@CHARACTER_MAXIMUM_LENGTH as nvarchar(20)) + ')' ;
						else 
							set @sql = @sql + ' (max)' ;
					set @sql = @sql + ' ;'
				end;
				else 
				begin
					set @sql = @sql + '; -- Unspecified Datatype' ;
				end;
				
				set @sql = @sql + CHAR(10)
				set @sql = @sql + 'END' + CHAR(10)
				set @sql = @sql + 'GO' + CHAR(10)
	  print @sql;

END 

CLOSE db_cursor  
DEALLOCATE db_cursor 