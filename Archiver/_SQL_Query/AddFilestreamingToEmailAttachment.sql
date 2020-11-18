
EXEC dbo.sp_fulltext_table @tabname=N'[dbo].[EmailAttachment]', @action=N'deactivate'
GO


ALTER TABLE EmailAttachment ALTER COLUMN RowGuid Add ROWGUIDCOL 
go

--The Directory MUST exist
--Add a file for storing database files to FILEGROUP
ALTER DATABASE [ECM.Library.FS]
ADD FILE
(
  NAME= '_ContentFS',
  FILENAME = 'D:\ECMContentFS\FSEmailAttach.dat'
)
TO FILEGROUP fgfsContent;
go

ALTER DATABASE [ECM.Library.FS] SET FILESTREAM( DIRECTORY_NAME = 'fgfsContent' ) WITH NO_WAIT;
GO

ALTER DATABASE [ECM.Library.FS] SET FILESTREAM( NON_TRANSACTED_ACCESS = FULL ) WITH NO_WAIT;
GO

sp_RENAME 'EmailAttachment.Attachment', 'AttachmentBak' , 'COLUMN'
go
ALTER TABLE EmailAttachment ADD Attachment varbinary(max) FILESTREAM NULL
go
UPDATE EmailAttachment SET Attachment = AttachmentBak
GO

ALTER FULLTEXT INDEX ON EmailAttachment DROP (AttachmentBak)
go
-- ALTER COLUMN OR MORE STATEMENT --
ALTER FULLTEXT INDEX ON EmailAttachment add (Attachment TYPE COLUMN AttachmentCode)
go
/* drop the xx<ColumnName> column */
ALTER TABLE EmailAttachment DROP COLUMN AttachmentBak

EXEC dbo.sp_fulltext_table @tabname=N'[dbo].[EmailAttachment]', @action=N'activate'
GO
