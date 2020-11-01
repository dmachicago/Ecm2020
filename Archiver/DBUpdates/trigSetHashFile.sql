

IF EXISTS (SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[trigSetHashFile]')
               AND [type] = 'TR')
BEGIN
      DROP TRIGGER trigSetHashFile;
END;
GO

create TRIGGER [dbo].[trigSetHashFile]
ON [dbo].[DataSource]
AFTER insert
AS 
BEGIN
  SET NOCOUNT ON;

  UPDATE DataSource 
  set HashFile = convert(char(130), HASHBYTES('sha2_512', DataSource.SourceImage), 1), SourceImageOrigin = 'SRCIMG', RowLastModDate = getdate()
  from Inserted I
	where DataSource.SourceGuid = I.SourceGuid

END
go

IF EXISTS (SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[trigSetHashFileOnUpdt]')
               AND [type] = 'TR')
BEGIN
      DROP TRIGGER trigSetHashFileOnUpdt;
END;
GO

create TRIGGER trigSetHashFileOnUpdt
   ON [dbo].DataSource
   AFTER UPDATE
AS BEGIN
    SET NOCOUNT ON;
    IF UPDATE (SourceImage) 
    BEGIN
        UPDATE DataSource 
		set HashFile = convert(char(130), HASHBYTES('sha2_512', DataSource.SourceImage), 1), SourceImageOrigin = 'SRCIMG', RowLastModDate = getdate()
		from Inserted I
		where DataSource.SourceGuid = I.SourceGuid;
    END 
END