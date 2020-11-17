/*
exec dbo.sp_add_job_quick 
@job = 'myjob', -- The job name
@mycommand = 'sp_who', -- The T-SQL command to run in the step
@servername = 'serverName', -- SQL Server name. If running localy, you can --* USE@servername=@@Servername
@startdate = '20130829', -- The date August 29th, 2013
@starttime = '160000' -- The time, 16:00:00
*/

--* USEmsdb;
GO
CREATE PROCEDURE [dbo].[sp_add_job_quick] @job NVARCHAR(150), 
  @mycommand  NVARCHAR(MAX), 
  @servername NVARCHAR(28), 
  @startdate  NVARCHAR(8), 
  @starttime  NVARCHAR(8)
AS
     --Add a job
     EXEC dbo.sp_add_job 
   @job_name = @job;
     --Add a job step named process step. This step runs the stored procedure
     EXEC sp_add_jobstep 
   @job_name = @job, 
   @step_name = N'process step', 
   @subsystem = N'TSQL', 
   @command = @mycommand;
     --Schedule the job at a specified date and time
     EXEC sp_add_jobschedule 
   @job_name = @job, 
   @name = 'MySchedule', 
   @freq_type = 1, 
   @active_start_date = @startdate, 
   @active_start_time = @starttime;
     -- Add the job to the SQL Server Server
     EXEC dbo.sp_add_jobserver 
   @job_name = @job, 
   @server_name = @servername;
