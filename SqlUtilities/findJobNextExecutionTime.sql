USE msdb;
WITH CTE
    AS (SELECT
               schedule_id
             , job_id
             , RIGHT ('0' + CAST (next_run_time AS varchar (6)) , 6) AS next_run_time
             , next_run_date
               FROM sysjobschedules) 
    SELECT
           A.name AS Job_Name
         ,'Next Start Time: ' + SUBSTRING (CONVERT (varchar (10) , CASE
                                                                               WHEN SUBSTRING (CONVERT (varchar (10) , next_run_time) , 1 , 2) > 12
                                                                                   THEN SUBSTRING (CONVERT (varchar (10) , next_run_time) , 1 , 2) - 0
                                                                               ELSE SUBSTRING (CONVERT (varchar (10) , next_run_time) , 1 , 2) 
                                                                           END) , 1 , 2) + ':' + SUBSTRING (CONVERT (varchar (10) , next_run_time) , 3 , 2) + ':' + SUBSTRING (CONVERT (varchar (10) , next_run_time) , 5 , 2) AS 'NextRun'
           FROM sysjobs AS A , CTE AS B
           WHERE
                 A.job_id = B.job_id AND
                 SUBSTRING (CONVERT (varchar (10) , next_run_date) , 5 , 2) + '/' + SUBSTRING (CONVERT (varchar (10) , next_run_date) , 7 , 2) + '/' + SUBSTRING (CONVERT (varchar (10) , next_run_date) , 1 , 4) = CONVERT (varchar (10) , GETDATE () , 101) AND
                 SUBSTRING ( CONVERT (varchar (10) ,
                 CASE
                     WHEN SUBSTRING (CONVERT (varchar (10) , next_run_time) , 1 , 2) > 12
                         THEN SUBSTRING (CONVERT (varchar (10) , next_run_time) , 1 , 2) - 12
                     ELSE SUBSTRING (CONVERT (varchar (10) , next_run_time) , 1 , 2) 
                 END) , 1 , 2) + ':' + SUBSTRING (CONVERT (varchar (10) , next_run_time) , 3 , 2) + ':' + SUBSTRING (CONVERT (varchar (10) , next_run_time) , 5 , 2) > SUBSTRING (CONVERT ( varchar (30) , GETDATE () , 9) , 13 , 7) ; 
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
