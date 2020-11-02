
BACKUP LOG [ECM.Library.FS] TO DISK='NUL:';
go
ALTER TABLE Datasource ALTER COLUMN RowGuid Add ROWGUIDCOL 
go

--The Directory MUST exist
--Add a file for storing database files to FILEGROUP
ALTER DATABASE [ECM.Library.FS]
ADD FILE
(
  NAME= '_ContentFS',
  FILENAME = 'D:\ECMContentFS\FSEmailAttach.dat'
)
TO FILEGROUP FG_ECM_FileStream;
go

ALTER DATABASE [ECM.Library.FS] SET FILESTREAM( DIRECTORY_NAME = 'FG_ECM_FileStream' ) WITH NO_WAIT;
GO

ALTER DATABASE [ECM.Library.FS] SET FILESTREAM( NON_TRANSACTED_ACCESS = FULL ) WITH NO_WAIT;
GO

SP_RENAME 'DataSource.SourceImage', 'SourceImageBAK' , 'COLUMN'
go
ALTER TABLE DataSource ADD SourceImage varbinary(max) FILESTREAM NULL
go
UPDATE DataSource SET SourceImage = SourceImageBAK
GO

ALTER FULLTEXT INDEX ON DataSource DROP (SourceImageBAK)
go
-- ALTER COLUMN OR MORE STATEMENT --
ALTER FULLTEXT INDEX ON DataSource add (SourceImage TYPE COLUMN SourceTypeCode)
go
/* drop the xx<ColumnName> column */
ALTER TABLE DataSOurce DROP COLUMN SourceImageBAK
go
ALTER FULLTEXT INDEX ON DataSource START FULL POPULATION;  

-- exec spFtiStatus