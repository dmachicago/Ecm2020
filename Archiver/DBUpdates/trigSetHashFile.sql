
DROP TRIGGER [dbo].[trigSetHashFile];
GO

/****** Object:  Trigger [dbo].[trigSetHashFile]    Script Date: 11/19/2020 9:23:22 PM ******/

SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO
CREATE TRIGGER [dbo].[trigSetHashFile] ON [dbo].[DataSource]
AFTER INSERT
AS
     BEGIN
         SET NOCOUNT ON;
         UPDATE DataSource
           SET 
               CreateDate = GETDATE()
         FROM Inserted I
         WHERE DataSource.SourceGuid = I.RowGuid;
     END;
GO
ALTER TABLE [dbo].[DataSource] DISABLE TRIGGER [trigSetHashFile];
GO
