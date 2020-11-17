
GO
Print ('Building Tracker_EDW_Metadata process') ;
drop view [dbo].[view_EDW_TrackerMetadata] ;
go

ALTER TABLE [dbo].[Tracker_EDW_Metadata] DROP CONSTRAINT [DF_Tracker_EDW_Metadata_LastModifiedDate]
GO

ALTER TABLE [dbo].[Tracker_EDW_Metadata] DROP CONSTRAINT [DF_Tracker_EDW_Metadata_CreatedDate]
GO

/****** Object:  Table [dbo].[Tracker_EDW_Metadata]    Script Date: 7/30/2014 3:34:02 PM ******/
DROP TABLE [dbo].[Tracker_EDW_Metadata]
GO

/****** Object:  Table [dbo].[Tracker_EDW_Metadata]    Script Date: 7/30/2014 3:34:02 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Tracker_EDW_Metadata](
	[TableName] [nvarchar](100) NOT NULL,
	[ColName] [nvarchar](100) NOT NULL,
	[AttrName] [nvarchar](100) NOT NULL,
	[AttrVal] [nvarchar](250) NULL,
	[CreatedDate] [datetime2] (7) NULL,
	[LastModifiedDate] [datetime2] (7) NULL,
	[ID] [int] IDENTITY(1,1) NOT NULL
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[Tracker_EDW_Metadata] ADD  CONSTRAINT [DF_Tracker_EDW_Metadata_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO

ALTER TABLE [dbo].[Tracker_EDW_Metadata] ADD  CONSTRAINT [DF_Tracker_EDW_Metadata_LastModifiedDate]  DEFAULT (getdate()) FOR [LastModifiedDate]
GO

/****** Object:  Index [PK_Tracker_EDW_Metadata]    Script Date: 7/30/2014 3:34:43 PM ******/
CREATE UNIQUE CLUSTERED INDEX [PK_Tracker_EDW_Metadata] ON [dbo].[Tracker_EDW_Metadata]
(
	[TableName] ASC,
	[ColName] ASC,
	[AttrName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

create View [dbo].[view_EDW_TrackerMetadata]
as
SELECT TableName, ColName, AttrName, AttrVal, CreatedDate, LastModifiedDate, ID
FROM     Tracker_EDW_Metadata

 GO
Print ('COMPLETED Tracker_EDW_Metadata process') ;
GO 
print('***** FROM: HFIT_Build_Tracker_Metadata_Environment.sql'); 
GO 
