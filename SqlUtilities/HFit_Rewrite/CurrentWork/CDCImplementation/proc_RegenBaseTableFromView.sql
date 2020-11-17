
-- exec proc_RegenBaseTableFromView view_CMS_USER
alter procedure proc_RegenBaseTableFromView (@ViewToRegen nvarchar(250), @LinkSvrName nvarchar(100) = null)
as
    exec proc_GenBaseTableFromView 
	   @DBNAME='KenticoCMS_1'
	   , @ViewName=@ViewToRegen
	   , @PreviewOnly = 'no'
	   , @GenJobToExecute = 1
	   , @SkipIfExists = 0
	   , @LinkedSvrName = @LinkSvrName

    exec proc_GenBaseTableFromView 
	   @DBNAME='KenticoCMS_2'
	   , @ViewName=@ViewToRegen
	   , @PreviewOnly = 'no'
	   , @GenJobToExecute = 1
	   , @SkipIfExists = 1
	   , @LinkedSvrName = @LinkSvrName

    exec proc_GenBaseTableFromView 
	   @DBNAME='KenticoCMS_3'
	   , @ViewName=@ViewToRegen
	   , @PreviewOnly = 'no'
	   , @GenJobToExecute = 1
	   , @SkipIfExists = 1
	   , @LinkedSvrName = @LinkSvrName

    declare @JOB as nvarchar(500) = 'job_proc_' + @ViewToRegen + '_KenticoCMS_1';
    exec combine_Job_Steps_Into_Single_Job 'job_proc_view_EDW_CoachingPPTAvailable_KenticoCMS_1'