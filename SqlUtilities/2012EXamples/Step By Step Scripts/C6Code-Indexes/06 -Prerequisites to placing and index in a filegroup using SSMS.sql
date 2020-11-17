--Prerequisites to placing and index in a filegroup using SSMS
USE master;
ALTER DATABASE AdventureWorks2012
ADD FILEGROUP AW2012FileGroup2;
ALTER DATABASE AdventureWorks2012
ADD FILE
(
NAME = IndexFile,
FILENAME = 'C:\SQLData\IndexFile.ndf',
SIZE = 5MB,
MAXSIZE = 100MB,
FILEGROWTH = 5MB
)
TO FILEGROUP AW2012FileGroup2;