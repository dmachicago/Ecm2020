SELECT DISTINCT so.name 
FROM sysobjects so 
INNER JOIN syscomments sc ON so.id = sc.id
WHERE sc.text LIKE '%drop table%' AND sc.text LIKE '%STAGING_EDW_HealthAssessment%'
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
