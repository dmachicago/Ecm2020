USE [KenticoCMS_QA]
GO

ALTER TABLE [dbo].[EDW_ViewBaseColumns] DROP CONSTRAINT [DF_EDW_ViewBaseColumns_CreateDate]
GO

/****** Object:  Table [dbo].[EDW_ViewBaseColumns]    Script Date: 3/13/2015 9:46:26 AM ******/
DROP TABLE [dbo].[EDW_ViewBaseColumns]
GO

/****** Object:  Table [dbo].[EDW_ViewBaseColumns]    Script Date: 3/13/2015 9:46:26 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[EDW_ViewBaseColumns](
	[OwnerView] [nvarchar](101) NOT NULL,
    [OwnerObj] [nvarchar](101) NOT NULL,  
	[DepObj] [nvarchar](101) NOT NULL,
	[ColumnName] [nvarchar](101) NOT NULL,
	[TypeObj] [nvarchar](5) not null,
	[ObjLevel] int null,
	[CreateDate] [datetime2](7) NULL,
	[RowNbr] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_EDW_ViewBaseColumns] PRIMARY KEY CLUSTERED 
(
	[OwnerView] ASC,
	[OwnerObj] ASC,
	[DepObj] ASC,
	[ColumnName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[EDW_ViewBaseColumns] ADD  CONSTRAINT [DF_EDW_ViewBaseColumns_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
GO


