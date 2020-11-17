BACKUP DATABASE [AdventureWorks2012]
TO DISK
=
N'C:\Program Files\Microsoft SQL
Server\MSSQL11.MSSQLServer\MSSQL\Backup\AdventureWorks2012DiffBackups.bak'
WITH
DIFFERENTIAL ,
NOFORMAT, NOINIT,
NAME = N'AdventureWorks2012-Differential Database Backup',
SKIP, NOREWIND, NOUNLOAD, STATS = 10
GO