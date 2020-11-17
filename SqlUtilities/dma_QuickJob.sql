

-- use KenticoCMS_Datamart_2

GO
PRINT 'Executing dma_QuickJob.sql';
GO
IF EXISTS (SELECT
                  name
           FROM sys.procedures
           WHERE
                  name = 'dma_QuickJob') 
    BEGIN
        DROP PROCEDURE
             dma_QuickJob;
    END;
GO

CREATE PROCEDURE dbo.dma_QuickJob
       @JobName NVARCHAR (128) 
     , @mycommand NVARCHAR (MAX) 
     , @servername NVARCHAR (28) 
     , @startdate NVARCHAR (8) 
     , @starttime NVARCHAR (8) 
AS
BEGIN
/*
@Copyright D. Miller & Associates, Ltd., Highland Park, IL, 1.1.1999 allrights reserved.
License:	  This procedure can be used freely as long as the copyright and this header
		  are preserved.

Author:	  W. Dale Miller
Date:	  1-1-2001
Purpose:	  Add new job

Parms:	  
exec dbo.dma_QuickJob 
    @JobName = 'myjob', -- The job name
    @mycommand = 'sp_who', -- The T-SQL command to run in the step
    @servername = 'serverName', -- SQL Server name. If running localy, you can use @servername=@@Servername
    @startdate = '08-29-2013', -- The date August 29th, 2013
    @starttime = '16:00:00' -- The time, 16:00:00

*/
    SET @starttime = replace (@starttime , ':' , '') ;

    DECLARE
           @MyJobSchedule AS NVARCHAR (250) = @JobName + '_Schedule'
         , @MyJobStep AS NVARCHAR (250) = @JobName + '_Step0'
         , @sdate AS NVARCHAR (10) = (SELECT CONVERT (VARCHAR (10) , @startdate , 112)) ;

    --Add the job
    EXEC msdb.dbo.sp_add_job
	   @job_name = @JobName;
    --Add a job step named process step. This step runs the stored procedure
    EXEC msdb.dbo.sp_add_jobstep
	   @job_name = @JobName ,
	   @step_name = @MyJobStep ,
	   @subsystem = N'TSQL' ,
	   @command = @mycommand;
    --Schedule the job at a specified date and time
    EXEC msdb.dbo.sp_add_jobschedule @job_name = @JobName ,
	   @name = @MyJobSchedule ,
	   @freq_type = 1 ,
	   @active_start_date = @startdate ,
	   @active_start_time = @starttime;
    -- Add the job to the SQL Server Server
    EXEC msdb.dbo.sp_add_jobserver
	   @job_name = @JobName ,
	   @server_name = @servername;
END;
GO
PRINT 'Executed dma_QuickJob.sql';
GO

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
