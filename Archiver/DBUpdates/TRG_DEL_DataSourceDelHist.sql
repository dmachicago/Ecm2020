if not exists (SELECT 1 from sys.tables where name = 'DataSourceDelHist')
begin

CREATE TABLE [dbo].[DataSourceDelHist](
	[SourceGuid] [nvarchar](50) NOT NULL,
	[FQN] [nvarchar](max) NULL,
	DeletedDate datetime default getdate()
) 
end
go
IF EXISTS (SELECT 1 FROM sys.objects WHERE [name] = N'TRG_DEL_DataSourceDelHist' AND [type] = 'TR')
BEGIN
      DROP TRIGGER [dbo].[TRG_DEL_DataSourceDelHist];
END;
go
CREATE TRIGGER TRG_DEL_DataSourceDelHist
ON DataSource
FOR DELETE
AS
     INSERT INTO DataSourceDelHist (SourceGuid, FQN)
     SELECT SourceGuid, FQN
     FROM DELETED 
go