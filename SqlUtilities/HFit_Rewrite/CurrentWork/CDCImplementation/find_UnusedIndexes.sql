
-- select *  FROM SYS.DM_DB_INDEX_USAGE_STATS

/*-----------------
use KenticoCMSDebug
use KenticoCMSDev
use KenticoCMSTest
*/

/*------------------------------
AUTHOR:	  W. Dale Miller
CONTACT:	  dm@DmaChicago.com
DATE:	  07/10/2010
Purpose:	  Finds unused indexes.
*/

/*-----------------------------------
use KenticoCMSDebug	    --2192 / 2090
use KenticoCMSDev	    --2170 / 2112
use KenticoCMSTest	    --2166 / 2105
*/
-- exec find_UnusedIndexes
GO
PRINT 'Executing find_UnusedIndexes.sql';
GO
IF EXISTS (SELECT
                  name
           FROM sys.procedures
           WHERE
                  name = 'find_UnusedIndexes') 
    BEGIN
        DROP PROCEDURE
             find_UnusedIndexes
    END;
GO
CREATE PROCEDURE find_UnusedIndexes
AS
BEGIN
    DECLARE
           @i AS BIGINT = 0
         , @j AS BIGINT = 0
         , @k AS BIGINT = 0;

    SET @i = (SELECT
                     count (*) 
              FROM sys.indexes) ;
    SET @j = (SELECT
                     count (*) 
              FROM sys.DM_DB_INDEX_USAGE_STATS) ;

    DECLARE
           @dbid INT;
    SELECT
           @dbid = DB_ID (DB_NAME ()) ;
    SELECT
           DB_NAME () AS DBNAME
         ,OBJECTNAME = OBJECT_NAME (I.OBJECT_ID) 
         , INDEXNAME = I.NAME
         , I.INDEX_ID
         , 'DROP Index [' + I.NAME + '] ON [' + OBJECT_NAME (I.OBJECT_ID) + ']' + CHAR (10) + 'GO' AS DDL
    FROM SYS.INDEXES AS I
         JOIN SYS.OBJECTS AS O
         ON
           I.OBJECT_ID = O.OBJECT_ID
    WHERE
           OBJECTPROPERTY (O.OBJECT_ID , 'IsUserTable') = 1 AND
           I.is_primary_key = 0 AND
           I.is_unique = 0 AND
           I.name IS NOT NULL AND
           I.INDEX_ID NOT IN (
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
    SET @k = @@ROWCOUNT;

    PRINT 'Total Indexes Evaluated: ' + cast (@i AS NVARCHAR (50)) ;
    PRINT 'Total UNUSED Indexes   : ' + cast (@k AS NVARCHAR (50)) ;
    PRINT 'Index Stats Evaluated  : ' + cast (@j AS NVARCHAR (50)) ;
    PRINT ' '  ;
    PRINT 'The DDL column contains the DROP statements.' ;
END;
GO
PRINT 'Executed find_UnusedIndexes.sql';
PRINT 'USE: exec find_UnusedIndexes';
GO
