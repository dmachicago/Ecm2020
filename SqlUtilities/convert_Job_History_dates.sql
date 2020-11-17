DECLARE @job_id binary(16)
SELECT @job_id = job_id FROM msdb.dbo.sysjobs WHERE (name like N'job_proc_BASE_HFit_Tracker%')

SELECT TOP 1
    CONVERT(DATETIME, RTRIM(run_date))
    + ((run_time / 10000 * 3600) 
    + ((run_time % 10000) / 100 * 60) 
    + (run_time % 10000) % 100) / (86399.9964) AS run_datetime
    , *
FROM
    msdb..sysjobhistory sjh
WHERE
    sjh.step_id = 0 
    AND sjh.run_status = 1 
    AND sjh.job_id = @job_id
ORDER BY
    run_datetime DESC
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
