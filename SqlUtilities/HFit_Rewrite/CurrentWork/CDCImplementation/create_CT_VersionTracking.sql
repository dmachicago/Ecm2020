

GO
print 'Executing create_CT_VersionTracking.sql ' ;
go
USE KenticoCMS_DataMart
GO

if exists (select name from sys.tables where name = 'CT_VersionTracking')
begin

ALTER TABLE [dbo].[CT_VersionTracking] DROP CONSTRAINT [DF_CT_VersionTracking_StartTime]
DROP TABLE [dbo].[CT_VersionTracking]

end ;
GO

/****** Object:  Table [dbo].[CT_VersionTracking]    Script Date: 11/29/2015 12:21:50 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[CT_VersionTracking](
	[SVRName] [nvarchar](100) NOT NULL,
	[DBName] [nvarchar](100) NOT NULL,
	[TgtView] [nvarchar](100) NOT NULL,
	[ExtractionDate] [datetime2](7) NOT NULL,
	[ExtractedVersion] [int] NOT NULL,
	[CurrentDbVersion] [int] NULL,
	[ExtractedRowCnt] [int] NOT NULL,
	[StartTime] [datetime2](7) NOT NULL,
	[EndTime] [datetime2](7) NULL,
	[CNT_Insert] [int] NULL,
	[CNT_Update] [int] NULL,
	[CNT_Delete] [int] NULL,
	[CNT_StagingTable] [bigint] NULL,
	[CNT_PulledRecords] [bigint] NULL,
	[RowNbr] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_CT_VersionTracking] PRIMARY KEY CLUSTERED 
(
	[SVRName] ASC,
	[DBName] ASC,
	[ExtractedVersion] ASC,
	[TgtView] ASC,
	[ExtractionDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[CT_VersionTracking] ADD  CONSTRAINT [DF_CT_VersionTracking_StartTime]  DEFAULT (getdate()) FOR [StartTime]
GO
print 'Executed create_CT_VersionTracking.sql ' ;
go