
-- Use KenticoCMS_Datamart_2

-- EXEC sp_msForEachDB 'IF Object_ID(''[?].dbo.HFit_HealthAssesmentUserAnswers'') IS NOT NULL BEGIN SELECT ''HFit_HealthAssesmentUserAnswers'', Count(*) FROM [?].dbo.HFit_HealthAssesmentUserAnswers END';

IF EXISTS (SELECT
                  name
           FROM sys.tables
           WHERE
                  name = 'MART_TABLE_RowCounts') 
    BEGIN
        DROP TABLE
             MART_TABLE_RowCounts;
    END;
GO
SELECT
       'KenticoCMS_Datamart_2' AS DBNAME
     , substring(T.name,6,999) AS [TABLE NAME]
     , I.rows AS [ROWCOUNT]
INTO
     MART_TABLE_RowCounts
FROM
     sys.tables AS T
          INNER JOIN sys.sysindexes AS I
          ON
       T.object_id = I.id AND I.indid < 2
--ORDER  BY I.rows DESC 
UNION ALL
SELECT
       'KenticoCMS_1' AS DBNAME
     , T.name AS [TABLE NAME]
     , I.rows AS [ROWCOUNT]
FROM
     KenticoCMS_1.sys.tables AS T
          INNER JOIN KenticoCMS_1.sys.sysindexes AS I
          ON
       T.object_id = I.id AND I.indid < 2
--ORDER  BY I.rows DESC 
UNION ALL
SELECT
       'KenticoCMS_2' AS DBNAME
     , T.name AS [TABLE NAME]
     , I.rows AS [ROWCOUNT]
FROM
     KenticoCMS_2.sys.tables AS T
          INNER JOIN KenticoCMS_2.sys.sysindexes AS I
          ON
       T.object_id = I.id AND I.indid < 2
--ORDER  BY I.rows DESC 
UNION ALL
SELECT
       'KenticoCMS_3' AS DBNAME
     , T.name AS [TABLE NAME]
     , I.rows AS [ROWCOUNT]
FROM
     KenticoCMS_3.sys.tables AS T
          INNER JOIN KenticoCMS_3.sys.sysindexes AS I
          ON
       T.object_id = I.id AND I.indid < 2
--ORDER BY T.name, I.rows DESC;

GO

-- CREATE PIVOT TABLE TO PRESENT DATA
-- select top 500 * from MART_TABLE_RowCounts order by [RowCount] desc
-- drop table #TempPivot
SELECT
       *
INTO
     #TempPivot
FROM (SELECT
             [table name]
           , DBNAME
           , [rowcount]
      FROM MART_TABLE_RowCounts) AS s PIVOT (SUM ([rowcount]) FOR DBNAME IN (
                                                                  KenticoCMS_1
                                                                , KenticoCMS_2
                                                                , KenticoCMS_3
                                                                , KenticoCMS_Datamart_2)) AS pvt;

SELECT
       *
     --, ISNULL (KenticoCMS_1, 0) + ISNULL (KenticoCMS_2, 0) + ISNULL (KenticoCMS_3, 0) + ISNULL (KenticoCMS_Datamart_2, 0) AS TOTRECS
	, ISNULL (KenticoCMS_1, 0) + ISNULL (KenticoCMS_2, 0) + ISNULL (KenticoCMS_3, 0) AS TOTRECS
	, ISNULL (KenticoCMS_1, 0) + ISNULL (KenticoCMS_2, 0) + ISNULL (KenticoCMS_3, 0) -KenticoCMS_Datamart_2 AS MarginError
FROM #TempPivot
ORDER BY
         TOTRECS DESC;

--TrackerSugaryFoods
--EDW_BiometricViewRejectCriteria