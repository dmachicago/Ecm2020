
exec sp_who2
--  EXEC dbo.FETCH_ACTIVE_JOB_NAME @SPID = 53
--  EXEC dbo.FETCH_ACTIVE_JOB_NAME @SPID = 69
go

set ansi_nulls on
go
set quoted_identifier on
go
alter procedure fetch_active_job_name
@spid int
as
begin
    --W. Dale Miller
    declare @jobid_derived varchar(32)
    declare @spid_var int

    set nocount on;

    select @jobid_derived=substring((cast([program_name] as varchar(75))),32,32) from master.sys.sysprocesses where spid=@spid

    select @spid as spid, [name] as SQL_Job_name from msdb.dbo.sysjobs sj
	   where substring ((cast(sj.job_id as varchar(36))),7,2) +
		   substring ((cast(sj.job_id as varchar(36))),5,2)+
		   substring ((cast(sj.job_id as varchar(36))),3,2)+
		   substring ((cast(sj.job_id as varchar(36))),1,2)+
		   substring ((cast(sj.job_id as varchar(36))),12,2)+
		   substring ((cast(sj.job_id as varchar(36))),10,2)+
		   substring ((cast(sj.job_id as varchar(36))),17,2)+
		   substring ((cast(sj.job_id as varchar(36))),15,2)+
		   substring ((cast(sj.job_id as varchar(36))),20,4)+
		   substring ((cast(sj.job_id as varchar(36))),25,12)=@jobid_derived
 end
 go
 

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
