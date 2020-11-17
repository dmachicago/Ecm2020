
select count(*) from fn_dblog(NULL, NULL) ;

SELECT count(*) CNT, objects.name, Operation
FROM sys.allocation_units allocunits
INNER JOIN sys.partitions partitions ON (allocunits.type IN (1, 3) 
 AND partitions.hobt_id = allocunits.container_id)
 OR (allocunits.type = 2 and partitions.partition_id = allocunits.container_id)
INNER JOIN sysobjects objects ON partitions.object_id = objects.id
 AND objects.type IN ('U', 'u')
inner join fn_dblog(NULL, NULL)
on  AllocUnitId = 72057594047561728
WHERE partitions.index_id IN (0, 1)
group by objects.name, Operation

select allocation_unit_id from sys.allocation_units;

SELECT count(*) CNT, objects.name, Operation, allocunits.allocation_unit_id, AllocUnitId
FROM sys.allocation_units allocunits
INNER JOIN sys.partitions partitions ON (allocunits.type IN (1, 3) 
 AND partitions.hobt_id = allocunits.container_id)
 OR (allocunits.type = 2 and partitions.partition_id = allocunits.container_id)
INNER JOIN sysobjects objects ON partitions.object_id = objects.id
 AND objects.type IN ('U', 'u')
inner join fn_dblog(NULL, NULL)
on  AllocUnitId = 72057594047561728
WHERE partitions.index_id IN (0, 1)
group by objects.name, Operation, allocunits.allocation_unit_id, AllocUnitId


SELECT allocunits.allocation_unit_id, objects.name, objects.id, Operation
FROM sys.allocation_units allocunits
INNER JOIN sys.partitions partitions ON (allocunits.type IN (1, 3) 
 AND partitions.hobt_id = allocunits.container_id)
 OR (allocunits.type = 2 and partitions.partition_id = allocunits.container_id)
INNER JOIN sysobjects objects ON partitions.object_id = objects.id
 AND objects.type IN ('U', 'u')
WHERE partitions.index_id IN (0, 1)

SELECT Operation, * FROM fn_dblog(NULL, NULL)
WHERE AllocUnitId = 72057594047561728
AND Operation = 'LOP_INSERT_ROWS'

SELECT top 50 * FROM fn_dblog(NULL, NULL);

SELECT distinct Operation, AllocUnitID, count(*) CNT FROM fn_dblog(NULL, NULL) group by AllocUnitID, Operation;

select top 50 * from sys.partitions P

SELECT OBJ.name, count(*) CNT, Operation FROM fn_dblog(NULL, NULL) 
inner join sys.allocation_units allocunits
on  allocunits.allocation_unit_id = AllocUnitId
INNER JOIN sys.partitions partitions ON (allocunits.type IN (1, 3) 
 AND partitions.hobt_id = allocunits.container_id)
 OR (allocunits.type = 2 and partitions.partition_id = allocunits.container_id)
INNER JOIN sysobjects OBJ ON partitions.object_id = OBJ.id
 AND OBJ.type IN ('U', 'u')
group by OBJ.name, Operation

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
