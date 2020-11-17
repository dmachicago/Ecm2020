-- SCRIPT TO GENERATE THE DROP SCRIPT OF ALL FOREIGN KEY CONSTRAINTS


if object_id('tempdb..##DropFK') is not null
    drop table ##DropFK ;

create table ##DropFK
(
    ParentTableName nvarchar(150) not null
    , ForeignKeyName nvarchar(150) not null
    , DropSql nvarchar(4000) null
)

declare @ForeignKeyName nvarchar(4000)
declare @ParentTableName nvarchar(4000)
declare @ParentTableSchema nvarchar(4000)
declare @TSQLDropFK nvarchar(max)
declare @SqlCmd nvarchar(max)

declare CursorFK cursor for select fk.name ForeignKeyName, schema_name(t.schema_id) ParentTableSchema, t.name ParentTableName
from sys.foreign_keys fk  inner join sys.tables t on fk.parent_object_id=t.object_id
open CursorFK
fetch next from CursorFK into  @ForeignKeyName, @ParentTableSchema, @ParentTableName
while (@@FETCH_STATUS=0)
begin
 set @TSQLDropFK ='ALTER TABLE '+quotename(@ParentTableSchema)+'.'+quotename(@ParentTableName)+' DROP CONSTRAINT '+quotename(@ForeignKeyName)+ char(13) + 'GO'
 set @SqlCmd ='ALTER TABLE '+quotename(@ParentTableSchema)+'.'+quotename(@ParentTableName)+' DROP CONSTRAINT '+quotename(@ForeignKeyName)
 print @TSQLDropFK
insert into ##DropFK (ParentTableName,ForeignKeyName,DropSql) values (@ParentTableName, @ForeignKeyName,@TSQLDropFK);
fetch next from CursorFK into  @ForeignKeyName, @ParentTableSchema, @ParentTableName
end
close CursorFK
deallocate CursorFK

select * from ##DropFK
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
