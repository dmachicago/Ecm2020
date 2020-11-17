SELECT
       REPLICATE (' ', 4000) AS COLNAMES
     ,OBJECT_NAME (I.ID) AS TABLENAME
     ,I.ID AS TABLEID
     ,I.INDID AS INDEXID
     ,I.NAME AS INDEXNAME
     ,I.STATUS
     ,INDEXPROPERTY (I.ID, I.NAME, 'ISUNIQUE') AS ISUNIQUE
     ,INDEXPROPERTY (I.ID, I.NAME, 'ISCLUSTERED') AS ISCLUSTERED
     ,INDEXPROPERTY (I.ID, I.NAME, 'INDEXFILLFACTOR') AS INDEXFILLFACTOR
INTO
     #TMP
       FROM SYSINDEXES AS I
       WHERE I.INDID > 0
         AND I.INDID < 255
         AND I.STATUS & 64 = 0;
--uncomment below to eliminate PK or UNIQUE indexes;
--AND   INDEXPROPERTY (I.ID,I.NAME,'ISUNIQUE')       =0
--AND   INDEXPROPERTY (I.ID,I.NAME,'ISCLUSTERED') =0
-- and  OBJECT_NAME(I.ID) IN
-- (
--'HFit_Account',
--'HFit_HealthAssesmentUserQuestion',
--'syscommittab',
--'View_CMS_Tree_Joined_Regular'
-- )
-- and (i.name like 'CI%' 
--	OR i.name like '%CI'		
--)
DECLARE
@ISQL VARCHAR (4000) 
,@TABLEID INT
,@INDEXID INT
,@MAXTABLELENGTH INT
,@MAXINDEXLENGTH INT;
--USED FOR FORMATTING ONLY
SELECT
       @MAXTABLELENGTH = MAX (LEN (TABLENAME)) 
       FROM #TMP;
SELECT
       @MAXINDEXLENGTH = MAX (LEN (INDEXNAME)) 
       FROM #TMP;

DECLARE C1 CURSOR
    FOR
        SELECT
               TABLEID
             , INDEXID
               FROM #TMP;
OPEN C1;
FETCH NEXT FROM C1 INTO @TABLEID, @INDEXID;
WHILE @@FETCH_STATUS <> -1
    BEGIN
        SET @ISQL = '';
        SELECT
               @ISQL = @ISQL + ISNULL (SYSCOLUMNS.NAME, '') + ','
               FROM SYSINDEXES AS I
                        INNER JOIN SYSINDEXKEYS
                            ON I.ID = SYSINDEXKEYS.ID
                           AND I.INDID = SYSINDEXKEYS.INDID
                        INNER JOIN SYSCOLUMNS
                            ON SYSINDEXKEYS.ID = SYSCOLUMNS.ID
                           AND SYSINDEXKEYS.COLID = SYSCOLUMNS.COLID
               WHERE I.INDID > 0
                 AND I.INDID < 255
                 AND I.STATUS & 64 = 0
                 AND I.ID = @TABLEID
                 AND I.INDID = @INDEXID
               ORDER BY
                        SYSCOLUMNS.COLID;
        UPDATE #TMP
               SET
                   COLNAMES = @ISQL
        WHERE
              TABLEID = @TABLEID
          AND INDEXID = @INDEXID;

        FETCH NEXT FROM C1 INTO @TABLEID, @INDEXID;
    END;
CLOSE C1;
DEALLOCATE C1;
--AT THIS POINT, THE 'COLNAMES' COLUMN HAS A TRAILING COMMA
UPDATE #TMP
       SET
           COLNAMES = LEFT (COLNAMES, LEN (COLNAMES) - 1) ;
-- drop table #TMP
SELECT
       TABLENAME
     , INDEXNAME
     , 'CREATE ' + CASE WHEN ISUNIQUE = 1
                           THEN ' UNIQUE '
                       ELSE '        '
                   END + CASE WHEN ISCLUSTERED = 1
                                 THEN ' CLUSTERED '
                             ELSE '           '
                         END + ' INDEX [' + UPPER (INDEXNAME) + ']' + CHAR (10) + ' ON [' + UPPER (TABLENAME) + '] ' + CHAR (10) + '(' + UPPER (COLNAMES) + ')' + CASE WHEN INDEXFILLFACTOR = 0
                                                                                                                                                                          THEN ''
                                                                                                                                                                      ELSE  ' WITH FILLFACTOR = ' + CONVERT (VARCHAR (10) , INDEXFILLFACTOR) 
                                                                                                                                                                  END --AS SQL
       FROM #TMP;

--SELECT * FROM #TMP
DROP TABLE
     #TMP;
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
