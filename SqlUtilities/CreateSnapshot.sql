CREATE DATABASE Snapshot365 ON
(Name ='Data365',
FileName='c:\DBBAK\DB365.ss1')
AS SNAPSHOT OF Data365;

CREATE DATABASE KenticoCMS_Prod2_ss20140701_1237 ON
( NAME = KenticoCMS_Prd, FILENAME = 
'X:\data\KenticoCMS_Prod2_20140701_1237.ss' )
AS SNAPSHOT OF KenticoCMS_Prod2;
GO
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
