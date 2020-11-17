-- starts a job named Weekly Sales Data Backup.  
USE msdb ;
GO

EXEC dbo.sp_start_job N'job_EDW_GetStagingData_HA_KenticoCMS_Prod3' ;
GO


EXEC dbo.sp_update_job
    @job_name = N'NightlyBackups',
    @new_name = N'NightlyBackups -- Disabled',
    @description = N'Nightly backups disabled during server migration.',
    @enabled = 0 ;
GO
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
