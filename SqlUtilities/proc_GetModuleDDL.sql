

--NOTE: LIKE '%[_]d'

select object_name(m.object_id) as ObjName, m.*
  from sys.sql_modules m
 where m.definition like N'%FACT[_]%'
--where object_name(m.object_id) like N'%FACT_%'



-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
