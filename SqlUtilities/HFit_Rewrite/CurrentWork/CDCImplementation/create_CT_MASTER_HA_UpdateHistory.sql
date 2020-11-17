USE [DataMartPlatform]
GO

/****** Object:  Table [dbo].[CT_MASTER_HA_UpdateHistory]    Script Date: 8/11/2016 10:38:07 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[CT_MASTER_HA_UpdateHistory](
	LastUpdate datetime not null,
	RowID bigint identity(1,1) not null
 CONSTRAINT [PK_CT_MASTER_HA_UpdateHistory] PRIMARY KEY CLUSTERED 
(
	LastUpdate desc, RowID
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


