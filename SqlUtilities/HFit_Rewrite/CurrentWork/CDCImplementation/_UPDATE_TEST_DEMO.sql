 
drop table dbo.TEMP06

declare @synchronization_version as bigint = null ;
SET @synchronization_version = CHANGE_TRACKING_CURRENT_VERSION();
print @synchronization_version ;
--2787

create table dbo.TEMP06
(id int identity(1,1) primary key--cannot track without it
, c1 int
, c2 varchar(100));
go

-- pre ct
insert TEMP06 values (10, 'Yo ho, yo ho')
insert TEMP06 values (11, 'We pillage, we plunder, rifle and loot.')
insert TEMP06 values (12, 'Drink up me ''earties, yo ho.')
insert TEMP06 values (13, 'We kidnap and ravage and do not give a hoot.')
insert TEMP06 values (14, 'Run away.')
go
insert TEMP06 values (20, 'Yo ho, yo ho')
insert TEMP06 values (21, 'We pillage, we plunder, rifle and loot.')
insert TEMP06 values (22, 'Drink up me ''earties, yo ho.')
insert TEMP06 values (23, 'We kidnap and ravage and do not give a hoot.')
insert TEMP06 values (24, 'Run away.')
go
insert TEMP06 values (30, 'Yo ho, yo ho')
insert TEMP06 values (31, 'We pillage, we plunder, rifle and loot.')
insert TEMP06 values (32, 'Drink up me ''earties, yo ho.')
insert TEMP06 values (33, 'We kidnap and ravage and do not give a hoot.')
insert TEMP06 values (34, 'Run away.')
go
insert TEMP06 values (40, 'Yo ho, yo ho')
insert TEMP06 values (41, 'We pillage, we plunder, rifle and loot.')
insert TEMP06 values (42, 'Drink up me ''earties, yo ho.')
insert TEMP06 values (43, 'We kidnap and ravage and do not give a hoot.')
insert TEMP06 values (44, 'Run away.')

-- check the table 
select * from TEMP06;
go

--If the table is fully populated after CT is on, is that a BUG

alter table dbo.TEMP06 enable change_tracking with (track_columns_updated=on);
go


select id,* from  CHANGETABLE (CHANGES TEMP06, null) AS C order by C.SYS_CHANGE_VERSION desc

select * from  CHANGETABLE (CHANGES TEMP06, null) AS C 
where C.SYS_CHANGE_OPERATION = 'U' 

update TEMP06 set C2 = 'YO YO' where C1 =10
update TEMP06 set C2 = 'NEW VAL 3' where id in (4,5)
update TEMP06 set C2 = 'VAL 4' where id in (10,11)
update TEMP06 set C2 = 'VAL 4' where id in (8,13)
update TEMP06 set C2 = 'VAL 0' where id in (1,2)
update TEMP06 set c1 = 50 where id in (18,19)
update TEMP06 set c2 = 'XX' where id in (18,19)
delete from TEMP06 where C1 = 50


SELECT * FROM sys.change_tracking_databases 
SELECT * FROM sys.change_tracking_tables
SELECT * FROM sys.internal_tables
WHERE parent_object_id = OBJECT_ID('TEMP06')


SELECT CHANGE_TRACKING_CURRENT_VERSION ()
SELECT CHANGE_TRACKING_MIN_VALID_VERSION(OBJECT_ID('TEMP06'))
SELECT * FROM CHANGETABLE 
(CHANGES TEMP06,0) as CT ORDER BY SYS_CHANGE_VERSION