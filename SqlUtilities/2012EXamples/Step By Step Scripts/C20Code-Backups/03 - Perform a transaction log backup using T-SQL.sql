BACKUP LOG [AdventureWorks2012]
TO Disk
=
'C:\Program Files\Microsoft SQL
Server\MSSQL11.MSSQLSERVER\MSSQL\Backup\AdventureWorks2012TLogBackups.trn'
WITH
NOFORMAT, NOINIT, NAME = N'AdventureWorks2012-Transaction Log Backup',
SKIP, NOREWIND, NOUNLOAD, STATS = 10
GO