SELECT
       sj.name
     , sja.*
       FROM
            msdb.dbo.sysjobactivity AS sja
                 INNER JOIN msdb.dbo.sysjobs AS sj
                 ON sja.job_id = sj.job_id
       WHERE
       sja.start_execution_date IS NOT NULL AND
       sja.stop_execution_date IS NULL
and sj.name like 'JOB_EDW%' and NAme like '%stag%'  ;


SELECT 'EXEC dbo.sp_stop_job ' + '''' + sj.name + ''''
       FROM
            msdb.dbo.sysjobactivity AS sja
                 INNER JOIN msdb.dbo.sysjobs AS sj
                 ON sja.job_id = sj.job_id
       WHERE
       sja.start_execution_date IS NOT NULL AND
       sja.stop_execution_date IS NULL
and sj.name like 'JOB_EDW%' and NAme like '%stag%'  ;


USE msdb ;
GO

/*
EXEC dbo.sp_stop_job
    N'job_EDW_GetStagingData_RewardUserLevel_KenticoCMS_Prod3' ;
GO
*/

--EXEC dbo.sp_stop_job 'job_EDW_GetStagingData_HA_KenticoCMS_Prod1'
--EXEC dbo.sp_stop_job 'job_EDW_GetStagingData_HA_KenticoCMS_Prod3'
--EXEC dbo.sp_stop_job 'job_EDW_GetStagingData_SmallSteps_KenticoCMS_Prod1'
--EXEC dbo.sp_stop_job 'job_EDW_GetStagingData_RewardUserLevel_KenticoCMS_Prod1'


-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
