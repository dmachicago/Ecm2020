

/*
AUTHOR:	  W. Dale Miller
CONTACT:	  dm@DmaChicago.com
DATE:	  03/14/2009
Purpose:	  Finds indexes that have no stats recording their use and generates DROP dml.
*/

DECLARE @dbid INT;
SELECT @dbid = DB_ID (DB_NAME ()) ;
SELECT OBJECTNAME = OBJECT_NAME (I.OBJECT_ID) 
     ,INDEXNAME = I.NAME
     ,I.INDEX_ID
     ,'DROP Index [' + I.NAME + '] ON [' + OBJECT_NAME (I.OBJECT_ID)+']' + char(10) + 'GO' as DDL
       FROM
            SYS.INDEXES AS I
                 JOIN SYS.OBJECTS AS O
                 ON
       I.OBJECT_ID = O.OBJECT_ID
       WHERE
       OBJECTPROPERTY (O.OBJECT_ID , 'IsUserTable') = 1 
	   and I.is_primary_key = 0
	   and I.is_unique = 0
	   and I.name is not null
	   AND I.INDEX_ID NOT IN (
       SELECT
              S.INDEX_ID
              FROM SYS.DM_DB_INDEX_USAGE_STATS AS S
              WHERE
              S.OBJECT_ID = I.OBJECT_ID AND
              I.INDEX_ID = S.INDEX_ID AND
              DATABASE_ID = @dbid) 
       ORDER BY
                OBJECTNAME ,
                I.INDEX_ID ,
                INDEXNAME ASC;


-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
