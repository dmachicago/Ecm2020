USE master
GO
--The following script creates a database and sets the recovery model to full
CREATE DATABASE [LSDemo]
GO
ALTER DATABASE [LSDemo] SET RECOVERY FULL
GO

--The following script backs the database up
USE master
GO
BACKUP DATABASE LSDemo
TO DISK = 'C:\LSDemo\LSDemo.bak'

--Use the script to restore the database to the secondary server
USE master
GO
RESTORE DATABASE LSDemo
FROM DISK = '\\alwayson1\lsdemo\lsdemo.bak'
WITH NORECOVERY