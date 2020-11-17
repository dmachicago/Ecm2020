USE KenticoCMS_DataMart
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[HFit_LKP_EDW_RejectMPI](
	[ItemID] [int] IDENTITY(1,1) NOT NULL,
	[RejectMPICode] [int] NOT NULL,
	[RejectUserGUID] [uniqueidentifier] NULL,
	[ItemCreatedBy] [int] NULL,
	[ItemCreatedWhen] [datetime2](7) NULL,
	[ItemModifiedBy] [int] NULL,
	[ItemModifiedWhen] [datetime2](7) NULL,
	[ItemOrder] [int] NULL,
	[ItemGUID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_HFit_LKP_EDW_RejectMPI] PRIMARY KEY CLUSTERED 
(
	[ItemID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[HFit_LKP_EDW_RejectMPI] ADD  CONSTRAINT [DEFAULT_HFit_LKP_EDW_RejectMPI_ItemGUID]  DEFAULT (newid()) FOR [ItemGUID]
GO


