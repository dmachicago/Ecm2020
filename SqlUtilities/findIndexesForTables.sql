select ST.name, SI.name from sys.indexes SI
	join sys.tables ST on ST.object_ID = SI.object_ID
where ST.name like '%tracker%' 
and SI.name not like 'PK%'

select SI.name from sys.indexes SI
where SI.name like 'pi%' 
OR SI.name like 'ci%' 
or SI.name like '%ci' 
or SI.name like '%pi' 
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
