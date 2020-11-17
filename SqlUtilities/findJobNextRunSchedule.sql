USE MSDB;
WITH CTE
    AS ( SELECT
                SCHEDULE_ID
              , JOB_ID
              , RIGHT ( '0' + CAST ( NEXT_RUN_TIME AS varchar(6)) , 6 ) AS NEXT_RUN_TIME
              , CAST ( CAST ( NEXT_RUN_DATE AS nvarchar(50)) AS nvarchar(50)) AS NEXT_RUN_DATE
           FROM SYSJOBSCHEDULES )
    SELECT
           A.NAME AS JOB_NAME
         , 'NEXT Run@ ' + SUBSTRING ( CONVERT ( varchar(10) , CASE
                                                              WHEN SUBSTRING ( CONVERT ( varchar(10) , B.NEXT_RUN_TIME ) , 1 , 2 ) > 12
                                                                  THEN SUBSTRING ( CONVERT ( varchar(10) , B.NEXT_RUN_TIME ) , 1 , 2 ) - 0
                                                                  ELSE SUBSTRING ( CONVERT ( varchar(10) , B.NEXT_RUN_TIME ) , 1 , 2 )
                                                              END ) , 1 , 2 ) + ':' + SUBSTRING ( CONVERT ( varchar(10) , B.NEXT_RUN_TIME ) , 3 , 2 ) + ':' + SUBSTRING ( CONVERT ( varchar(10) , B.NEXT_RUN_TIME ) , 5 , 2 ) AS 'NextRunTime'
         , CAST ( CAST ( B.NEXT_RUN_DATE AS nvarchar(50)) AS datetime ) AS NEXT_RUN_DATE
         , GETDATE ( ) AS CURRSSERVERDATE
      FROM SYSJOBS AS A , CTE AS B
      WHERE
      A.JOB_ID = B.JOB_ID
  AND A.NAME LIKE 'TEST%'
  AND SUBSTRING ( CONVERT ( varchar(10) , B.NEXT_RUN_DATE ) , 5 , 2 ) + '/' + SUBSTRING ( CONVERT ( varchar(10) , B.NEXT_RUN_DATE ) , 7 , 2 ) + '/' + SUBSTRING ( CONVERT ( varchar(10) , B.NEXT_RUN_DATE ) , 1 , 4 ) = CONVERT ( varchar(10) , GETDATE ( ) , 101 )
  AND SUBSTRING ( CONVERT ( varchar(10) ,
      CASE
      WHEN SUBSTRING ( CONVERT ( varchar(10) , B.NEXT_RUN_TIME ) , 1 , 2 ) > 12
          THEN SUBSTRING ( CONVERT ( varchar(10) , B.NEXT_RUN_TIME ) , 1 , 2 ) - 12
          ELSE SUBSTRING ( CONVERT ( varchar(10) , B.NEXT_RUN_TIME ) , 1 , 2 )
      END ) , 1 , 2 ) + ':' + SUBSTRING ( CONVERT ( varchar(10) , B.NEXT_RUN_TIME ) , 3 , 2 ) + ':' + SUBSTRING ( CONVERT ( varchar(10) , B.NEXT_RUN_TIME ) , 5 , 2 ) > SUBSTRING ( CONVERT ( varchar(30) , GETDATE ( ) , 9 ) , 13 , 7 );

--*******************************
-- LIST ALL EXECUTIONG JOBS
--*******************************
SELECT
       SJ.NAME
     , SJA.*
  FROM
       MSDB.DBO.SYSJOBACTIVITY AS SJA
       INNER JOIN MSDB.DBO.SYSJOBS AS SJ
           ON SJA.JOB_ID = SJ.JOB_ID
  WHERE
  SJA.START_EXECUTION_DATE IS NOT NULL
AND SJA.STOP_EXECUTION_DATE IS NULL;


-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
