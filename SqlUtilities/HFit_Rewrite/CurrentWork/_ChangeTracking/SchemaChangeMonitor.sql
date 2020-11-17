
GO
PRINT 'FQN: SchemaChangeMonitor.SQL';
PRINT 'Creating SchemaChangeMonitor table';
GO
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
SET ARITHABORT ON
SET CONCAT_NULL_YIELDS_NULL ON
SET NUMERIC_ROUNDABORT OFF
SET QUOTED_IDENTIFIER ON

IF EXISTS (SELECT
				  name
			 FROM sys.tables
			 WHERE name = 'SchemaChangeMonitor') 
	BEGIN
		PRINT 'DROP SchemaChangeMonitor table';
		DROP TABLE
			 dbo.SchemaChangeMonitor;
	END;

IF NOT EXISTS (SELECT
					  name
				 FROM sys.tables
				 WHERE name = 'SchemaChangeMonitor') 
	BEGIN
		
CREATE TABLE [dbo].[SchemaChangeMonitor](
	[PostTime] [datetime2](7) NULL,
	[DB_User] [nvarchar](254) NULL,
	[IP_Address] [nvarchar](254) NULL,
	[CUR_User] [nvarchar](254) NULL,
	[Event] [nvarchar](254) NULL,
	[TSQL] [nvarchar](max) NULL,
	[OBJ] [nvarchar](254) NULL,
	[RowNbr] [int] IDENTITY(1,1) NOT NULL,
	[ServerName] [nvarchar](254) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY] ;

ALTER TABLE [dbo].[SchemaChangeMonitor] ADD  CONSTRAINT [DF_SchemaChangeMonitor_ServerName]  DEFAULT (@@servername) FOR [ServerName];

	END;
GO
GO
PRINT 'Created SchemaChangeMonitor table';
GO

