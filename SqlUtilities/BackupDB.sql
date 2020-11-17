BACKUP DATABASE [dod.dc.xref.trklist.j01] 
	TO  DISK = N'H:\DB\Backup\dod.dc.xref.trklist.j01.bak' 
	WITH NOFORMAT, NOINIT,  
	NAME = N'dod.dc.xref.trklist.j01-FullDBBackup', 
	NOSKIP, NOREWIND, NOUNLOAD, COMPRESSION,  STATS = 10
GO

declare @backupSetId as int

select @backupSetId = position from msdb..backupset 
where database_name=N'dod.dc.xref.trklist.j01' 
	and backup_set_id=(select max(backup_set_id) 
from msdb..backupset where database_name=N'dod.dc.xref.trklist.j01' )

if @backupSetId is null 
begin 
	raiserror(N'SEVERE ERROR: Verify failed for launch locations. Backup information for database ''dod.dc.xref.trklist.j01'' not found.', 16, 1) 
end

RESTORE VERIFYONLY FROM  DISK = N'H:\DB\Backup\dod.dc.xref.trklist.j01.bak' 
	WITH  FILE = @backupSetId,  
	NOUNLOAD,  NOREWIND
GO

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
