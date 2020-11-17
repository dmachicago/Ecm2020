
EXEC sp_who2;

DECLARE @TotalAdded AS FLOAT = 0;
DECLARE @startcnt AS FLOAT = 0;
DECLARE @currcnt AS FLOAT = 0;
DECLARE @percnt AS FLOAT = 0;
DECLARE @i AS FLOAT = 0;
DECLARE @msg AS NVARCHAR (500) = '';
DECLARE @msg2 AS NVARCHAR (500) = '';
EXEC @startcnt = proc_QuickRowCount FACT_TrackerData;
WHILE @i < 1000
    BEGIN
        WAITFOR DELAY '00:00:05'; ---- 60 Second Delay
        SET @i = @i + 1;
        EXEC @currcnt = proc_QuickRowCount FACT_EDW_TrackerCompositeDetails;
        SET @percnt = (@currcnt - @startcnt) / @i;
	   set @TotalAdded = @currcnt - @startcnt
        SET @msg = CAST (@i AS NVARCHAR (50)) + ' of 1000 @ ' + CAST (GETDATE () AS NVARCHAR (50)) + ' / ' + CAST (@percnt AS NVARCHAR (50)) + ' every 1 minute ';
        SET @percnt = (@currcnt - @startcnt) / @i / 60;
        SET @msg2 = CAST (@percnt AS NVARCHAR (50)) + ' per sec. / TotalAdded: ' + cast(@TotalAdded as nvarchar(50));
        SET @msg = @msg + ' / ' + @msg2;
        EXEC PrintImmediate @msg;
    END;

SELECT
       ja.job_id
     ,j.name AS job_name
     ,ja.start_execution_date
     ,ISNULL (last_executed_step_id, 0) + 1 AS current_executed_step_id
     ,Js.step_name
       FROM msdb.dbo.sysjobactivity AS ja
                LEFT JOIN msdb.dbo.sysjobhistory AS jh
                    ON ja.job_history_id = jh.instance_id
                JOIN msdb.dbo.sysjobs AS j
                    ON ja.job_id = j.job_id
                JOIN msdb.dbo.sysjobsteps AS js
                    ON ja.job_id = js.job_id
                   AND ISNULL (ja.last_executed_step_id, 0) + 1 = js.step_id
       WHERE ja.session_id = (
    SELECT TOP 1
           session_id
           FROM msdb.dbo.syssessions
           ORDER BY
                    agent_start_date DESC) 
         AND start_execution_date IS NOT NULL
         AND stop_execution_date IS NULL;

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
