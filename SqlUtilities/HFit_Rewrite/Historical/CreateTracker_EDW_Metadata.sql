
ALTER TABLE [dbo].[Tracker_EDW_Metadata] DROP CONSTRAINT [DF_Tracker_EDW_Metadata_LastModifiedDate]
GO

ALTER TABLE [dbo].[Tracker_EDW_Metadata] DROP CONSTRAINT [DF_Tracker_EDW_Metadata_CreatedDate]
GO

/****** Object:  Table [dbo].[Tracker_EDW_Metadata]    Script Date: 8/23/2014 4:28:58 PM ******/
DROP TABLE [dbo].[Tracker_EDW_Metadata]
GO

/****** Object:  Table [dbo].[Tracker_EDW_Metadata]    Script Date: 8/23/2014 4:28:58 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Tracker_EDW_Metadata](
	[TableName] [nvarchar](100) NOT NULL,
	[ColName] [nvarchar](100) NOT NULL,
	[AttrName] [nvarchar](100) NOT NULL,
	[AttrVal] [nvarchar](250) NULL,
	[CreatedDate] [datetime] NULL,
	[LastModifiedDate] [datetime] NULL,
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ClassLastModified] [datetime] NULL
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[Tracker_EDW_Metadata] ADD  CONSTRAINT [DF_Tracker_EDW_Metadata_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO

ALTER TABLE [dbo].[Tracker_EDW_Metadata] ADD  CONSTRAINT [DF_Tracker_EDW_Metadata_LastModifiedDate]  DEFAULT (getdate()) FOR [LastModifiedDate]
GO


