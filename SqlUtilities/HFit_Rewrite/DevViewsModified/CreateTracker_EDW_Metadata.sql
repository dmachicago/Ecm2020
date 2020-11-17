
print('Processing: Tracker_EDW_Metadata');
go


--create proc CreateTracker_EDW_Metadata
--as
GO 

if not exists(Select name from sys.tables where name = 'Tracker_EDW_Metadata')
BEGIN
	print ('Creating the Tracker_EDW_Metadata table');
	CREATE TABLE [dbo].[Tracker_EDW_Metadata] (
			[TableName]             [nvarchar](100) NOT NULL,
			[ColName]               [nvarchar](100) NOT NULL,
			[AttrName]              [nvarchar](100) NOT NULL,
			[AttrVal]               [nvarchar](250) NULL,
			[CreatedDate]           [datetime] NULL,
			[LastModifiedDate]      [datetime] NULL,
			[ID]                    [int] IDENTITY(1, 1) NOT NULL,
			[ClassLastModified]     [datetime] NULL
	) ON [PRIMARY]

	ALTER TABLE [dbo].[Tracker_EDW_Metadata]
	ADD
	CONSTRAINT [DF_Tracker_EDW_Metadata_CreatedDate]
	DEFAULT (getdate()) FOR [CreatedDate]

	ALTER TABLE [dbo].[Tracker_EDW_Metadata]
		ADD
		CONSTRAINT [DF_Tracker_EDW_Metadata_LastModifiedDate]
		DEFAULT (getdate()) FOR [LastModifiedDate]

	CREATE UNIQUE CLUSTERED INDEX [PK_Tracker_EDW_Metadata]
		ON [dbo].[Tracker_EDW_Metadata] ([TableName], [ColName], [AttrName]) ON [PRIMARY]

	ALTER TABLE [dbo].[Tracker_EDW_Metadata] SET (LOCK_ESCALATION = TABLE)

END
GO


