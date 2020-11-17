

use KenticoCMS_Datamart_2
go
IF not EXISTS (SELECT name from sys.tables where name = 'MIGRATE_DataMart_Commands')
    create table MIGRATE_DataMart_Commands (cmd nvarchar(max) null) 
else
    truncate table MIGRATE_DataMart_Commands ;

declare @cmd as nvarchar(max) = '' ;

set @cmd = '
IF NOT EXISTS (SELECT
                      *
               FROM sys.change_tracking_databases
               WHERE
                      database_id = DB_ID (''KenticoCMS_1'')) 
    BEGIN
        ALTER DATABASE KenticoCMS_1 SET CHANGE_TRACKING = ON (CHANGE_RETENTION = 7 DAYS, AUTO_CLEANUP = ON) 
    END; ' ;  

insert into MIGRATE_DataMart_Commands (cmd) values (@cmd);

set @cmd = '
IF NOT EXISTS (SELECT
                      *
               FROM sys.change_tracking_databases
               WHERE
                      database_id = DB_ID (''KenticoCMS_2'')) 
    BEGIN
        ALTER DATABASE KenticoCMS_1 SET CHANGE_TRACKING = ON (CHANGE_RETENTION = 7 DAYS, AUTO_CLEANUP = ON) 
    END; ' ;  

insert into MIGRATE_DataMart_Commands (cmd) values (@cmd);

set @cmd = '
IF NOT EXISTS (SELECT
                      *
               FROM sys.change_tracking_databases
               WHERE
                      database_id = DB_ID (''KenticoCMS_3'')) 
    BEGIN
        ALTER DATABASE KenticoCMS_1 SET CHANGE_TRACKING = ON (CHANGE_RETENTION = 7 DAYS, AUTO_CLEANUP = ON) 
    END; ' ;  

insert into MIGRATE_DataMart_Commands (cmd) values (@cmd);

insert into MIGRATE_DataMart_Commands (cmd) values ('USE KenticoCms_1');

insert into MIGRATE_DataMart_Commands
select 'if not exists ( '
+char(10) + 'select sys.tables.name '
+char(10) + 'from sys.change_tracking_tables '
+char(10) + 'join sys.tables on sys.tables.object_id = sys.change_tracking_tables.object_id '
+char(10) + 'join sys.schemas on sys.schemas.schema_id = sys.tables.schema_id '
+char(10) + 'where sys.tables.name = '''+sys.tables.name+''' '
+char(10) + ') ' 
+char(10) + '    ALTER TABLE dbo.' + sys.tables.name 
+ ' ENABLE CHANGE_TRACKING WITH (TRACK_COLUMNS_UPDATED = ON)' + char(10) + 'GO' as CMD
from sys.change_tracking_tables
join sys.tables on sys.tables.object_id = sys.change_tracking_tables.object_id
join sys.schemas on sys.schemas.schema_id = sys.tables.schema_id
where sys.tables.name not like '%eventlog%'


insert into MIGRATE_DataMart_Commands (cmd) values ('USE KenticoCms_2');

insert into MIGRATE_DataMart_Commands
select 'if not exists ( '
+char(10) + 'select sys.tables.name '
+char(10) + 'from sys.change_tracking_tables '
+char(10) + 'join sys.tables on sys.tables.object_id = sys.change_tracking_tables.object_id '
+char(10) + 'join sys.schemas on sys.schemas.schema_id = sys.tables.schema_id '
+char(10) + 'where sys.tables.name = '''+sys.tables.name+''' '
+char(10) + ') ' 
+char(10) + '    ALTER TABLE dbo.' + sys.tables.name 
+ ' ENABLE CHANGE_TRACKING WITH (TRACK_COLUMNS_UPDATED = ON)' + char(10) + 'GO' as CMD
from sys.change_tracking_tables
join sys.tables on sys.tables.object_id = sys.change_tracking_tables.object_id
join sys.schemas on sys.schemas.schema_id = sys.tables.schema_id
where sys.tables.name not like '%eventlog%'


insert into MIGRATE_DataMart_Commands (cmd) values ('USE KenticoCms_3');

insert into MIGRATE_DataMart_Commands
select 'if not exists ( '
+char(10) + 'select sys.tables.name '
+char(10) + 'from sys.change_tracking_tables '
+char(10) + 'join sys.tables on sys.tables.object_id = sys.change_tracking_tables.object_id '
+char(10) + 'join sys.schemas on sys.schemas.schema_id = sys.tables.schema_id '
+char(10) + 'where sys.tables.name = '''+sys.tables.name+''' '
+char(10) + ') ' 
+char(10) + '    ALTER TABLE dbo.' + sys.tables.name 
+ ' ENABLE CHANGE_TRACKING WITH (TRACK_COLUMNS_UPDATED = ON)' + char(10) + 'GO' as CMD
from sys.change_tracking_tables
join sys.tables on sys.tables.object_id = sys.change_tracking_tables.object_id
join sys.schemas on sys.schemas.schema_id = sys.tables.schema_id
where sys.tables.name not like '%eventlog%'



-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
