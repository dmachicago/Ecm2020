UPDATE EmailAddress
SET LName=UPPER(LEFT(LName,1))+LOWER(SUBSTRING(LName,2,LEN(LName)))
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
