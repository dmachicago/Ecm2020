select 'ECMServer' as Location, column_name, DATA_TYPE,CHARACTER_MAXIMUM_LENGTH, NUMERIC_PRECISION, NUMERIC_PRECISION_RADIX, DATETIME_PRECISION from INFORMATION_SCHEMA.columns where table_name = 'DataSource' order by column_name

alter table DataSource alter column FileDirectory nvarchar(1000) null;	--300
alter table DataSource alter column FileDirectoryName nvarchar(1000) null;	--300
alter table DataSource alter column SourceName nvarchar(1000) null;	--254
alter table DataSource alter column FQN varchar(2000) null; --712
