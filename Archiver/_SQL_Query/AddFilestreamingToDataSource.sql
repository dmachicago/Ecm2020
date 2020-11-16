
--Use this command to backup the log to a NULL disk, basically truncating the log as needed. This is a dangerous command.
BACKUP LOG [ECM.Library.FS] TO DISK='NUL:';
go
ALTER TABLE Datasource ALTER COLUMN RowGuid Add ROWGUIDCOL 
go

DISABLE TRIGGER [TRG_DEL_DataSourceDelHist] ON DataSource;  
DISABLE TRIGGER [trgDataSourceDelete] ON DataSource;  
DISABLE TRIGGER [trigSetDataSourceOcr] ON DataSource;  
DISABLE TRIGGER [trigSetHashFile] ON DataSource;  
DISABLE TRIGGER [trigSetHashFileOnUpdt] ON DataSource;  
go

EXEC dbo.sp_fulltext_table @tabname=N'[dbo].[DataSource]', @action=N'deactivate'
GO


--A Directory MUST exist for storing files into from the file stream
--Modify the FILENAME as needed prior to running this command.
--Additionally, make certain the file group exists.
--Add a file for storing database files to FILEGROUP
--Check if filegroup does not exist…then add it
IF NOT EXISTS (SELECT name 
               FROM sys.filegroups 
               WHERE name = N'FG_ECM_FileStream') 
BEGIN
    ALTER DATABASE [name_of_db] ADD FILEGROUP FG_ECM_FileStream
END
go
ALTER DATABASE [ECM.Library.FS]
ADD FILE
(
  NAME= '_ContentFS',
  FILENAME = 'D:\ECMContentFS\FSEmailAttach.dat'
)
TO FILEGROUP FG_ECM_FileStream;
go
--Set the FileStream Directory
ALTER DATABASE [ECM.Library.FS] SET FILESTREAM( DIRECTORY_NAME = 'FG_ECM_FileStream' ) WITH NO_WAIT;
GO
--Set the FileStream
ALTER DATABASE [ECM.Library.FS] SET FILESTREAM( NON_TRANSACTED_ACCESS = FULL ) WITH NO_WAIT;
GO
--Simply rename the existing column to a backup column
SP_RENAME 'DataSource.SourceImage', 'SourceImageBAK' , 'COLUMN'
go
--Put the original column back as an empty column
ALTER TABLE DataSource ADD SourceImage varbinary(max) FILESTREAM NULL
go
--Copy the backup column back into the original
UPDATE DataSource SET SourceImage = SourceImageBAK
GO
--Remove the backup column
ALTER FULLTEXT INDEX ON DataSource DROP (SourceImageBAK)
go
-- ALTER COLUMN OR MORE STATEMENT --
ALTER FULLTEXT INDEX ON DataSource add (SourceImage TYPE COLUMN SourceTypeCode)
go
/* drop the Backup Columncolumn */
ALTER TABLE DataSOurce DROP COLUMN SourceImageBAK
go
--Repopulate the NEW index pointing to the FileStream data
ALTER FULLTEXT INDEX ON DataSource START FULL POPULATION;  

EXEC dbo.sp_fulltext_table @tabname=N'[dbo].[DataSource]', @action=N'activate'
GO

enable TRIGGER [TRG_DEL_DataSourceDelHist] ON DataSource;  
enable TRIGGER [trgDataSourceDelete] ON DataSource;  
enable TRIGGER [trigSetDataSourceOcr] ON DataSource;  
enable TRIGGER [trigSetHashFile] ON DataSource;  
enable TRIGGER [trigSetHashFileOnUpdt] ON DataSource;  
go

-- exec spFtiStatus