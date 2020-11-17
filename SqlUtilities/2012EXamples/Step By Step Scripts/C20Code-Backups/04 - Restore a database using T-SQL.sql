RESTORE DATABASE [AdventureWorks2012]
FROM
DISK
=
' C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLServer\MSSQL\Backup\AdventureWorks2012.bak'
WITH
FILE = 1,
NORECOVERY,
NOUNLOAD,
STATS = 5
GO