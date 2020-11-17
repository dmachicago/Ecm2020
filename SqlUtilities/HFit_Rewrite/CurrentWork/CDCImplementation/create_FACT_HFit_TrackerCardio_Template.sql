USE [KenticoCMS_DataMart]
GO

/****** Object:  Table [dbo].[FACT_HFit_TrackerCardio]    Script Date: 12/10/2015 2:04:50 PM ******/
DROP TABLE [dbo].[FACT_HFit_TrackerCardio]
GO

/****** Object:  Table [dbo].[FACT_HFit_TrackerCardio]    Script Date: 12/10/2015 2:04:50 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[FACT_HFit_TrackerCardio](
	[TrackerNameAggregateTable] [nvarchar](100) NULL,
	[ItemID] [int] NULL,
	[EventDate] [datetime] NULL,
	[IsProfessionallyCollected] [bit] NULL,
	[TrackerCollectionSourceID] [int] NULL,
	[Notes] [nvarchar](1000) NULL,
	[UserID] [int] NULL,
	[CollectionSourceName_Internal] [nvarchar](100) NULL,
	[CollectionSourceName_External] [nvarchar](100) NULL,
	[EventName] [nvarchar](100) NULL,
	[UOM] [nvarchar](100) NULL,
	[KEY1] [nvarchar](100) NULL,
	[VAL1] [float] NULL,
	[KEY2] [nvarchar](8) NULL,
	[VAL2] [float] NULL,
	[KEY3] [nvarchar](100) NULL,
	[VAL3] [float] NULL,
	[KEY4] [nvarchar](100) NULL,
	[VAL4] [float] NULL,
	[KEY5] [nvarchar](100) NULL,
	[VAL5] [float] NULL,
	[KEY6] [nvarchar](100) NULL,
	[VAL6] [int] NULL,
	[KEY7] [nvarchar](100) NULL,
	[VAL7] [int] NULL,
	[KEY8] [nvarchar](100) NULL,
	[VAL8] [int] NULL,
	[KEY9] [nvarchar](100) NULL,
	[VAL9] [int] NULL,
	[KEY10] [nvarchar](100) NULL,
	[VAL10] [int] NULL,
	[ItemCreatedBy] [int] NULL,
	[ItemCreatedWhen] [datetime] NULL,
	[ItemModifiedBy] [int] NULL,
	[ItemModifiedWhen] [datetime] NULL,
	[IsProcessedForHa] [int] NULL,
	[TXTKEY1] [nvarchar](100) NULL,
	[TXTVAL1] [int] NULL,
	[TXTKEY2] [nvarchar](100) NULL,
	[TXTVAL2] [int] NULL,
	[TXTKEY3] [nvarchar](100) NULL,
	[TXTVAL3] [int] NULL,
	[ItemOrder] [int] NULL,
	[ItemGuid] [int] NULL,
	[UserGuid] [uniqueidentifier] NULL,
	[MPI] [nvarchar](100) NULL,
	[ClientCode] [nvarchar](100) NULL,
	[SiteGUID] [uniqueidentifier] NULL,
	[AccountID] [int] NULL,
	[AccountCD] [nvarchar](100) NULL,
	[IsAvailable] [bit] NULL,
	[IsCustom] [bit] NULL,
	[UniqueName] [nvarchar](100) NULL,
	[ColDesc] [nvarchar](100) NULL,
	[VendorID] [int] NULL,
	[VendorName] [int] NULL,
	[LastModifiedDate] [datetime] NULL,
	[SVR] [nvarchar](100) NULL,
	[DBNAME] [nvarchar](100) NULL
) ON [PRIMARY]

GO
CREATE UNIQUE CLUSTERED INDEX [PKEY_FACT_HFit_TrackerCardio] ON [dbo].[FACT_HFit_TrackerCardio]
(
	[TrackerNameAggregateTable] ASC,
	[ItemID] ASC,
	[SVR] ASC,
	[DBNAME] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

