
go
USE [TDR]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Admin]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Admin](
	[EmailAddr] [nvarchar](50) NOT NULL,
	[password] [nvarchar](100) NOT NULL,
	[bRead] [bit] NULL,
	[bWrite] [bit] NULL,
	[bDelete] [bit] NULL,
	[bCreateAdmin] [bit] NULL
) ON [PRIMARY]
END
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Admin]') AND name = N'PK_Admin')
CREATE UNIQUE CLUSTERED INDEX [PK_Admin] ON [dbo].[Admin]
(
	[EmailAddr] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AnalyticClassDetail]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[AnalyticClassDetail](
	[ClassCode] [nvarchar](50) NOT NULL,
	[AnalyticGUID] [uniqueidentifier] NOT NULL,
	[SystemCode] [nvarchar](15) NOT NULL,
	[RowIdentifier] [uniqueidentifier] NULL,
 CONSTRAINT [PK2] PRIMARY KEY CLUSTERED 
(
	[ClassCode] ASC,
	[AnalyticGUID] ASC,
	[SystemCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AnalyticClassText]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[AnalyticClassText](
	[ClassCode] [nvarchar](50) NOT NULL,
	[AnalyticGUID] [uniqueidentifier] NOT NULL,
	[SystemCode] [nvarchar](15) NOT NULL,
	[RowIdentifier] [uniqueidentifier] NULL,
 CONSTRAINT [PK2_2] PRIMARY KEY CLUSTERED 
(
	[ClassCode] ASC,
	[AnalyticGUID] ASC,
	[SystemCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AnalyticDetail]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[AnalyticDetail](
	[AnalyticGUID] [uniqueidentifier] NOT NULL,
	[Location] [nvarchar](50) NULL,
	[AnalyticValue] [nvarchar](2000) NULL,
	[AnalyticDatatype] [nvarchar](50) NULL,
	[AnalyticCode] [nvarchar](50) NULL,
	[CreateDate] [datetime] NULL,
	[RowNbr] [int] IDENTITY(1,1) NOT NULL,
	[Plane] [int] NULL,
	[Radial] [int] NULL,
	[VectorMagnitude] [decimal](18, 4) NULL,
	[VectorPower] [int] NULL,
	[OwnerGUID] [uniqueidentifier] NULL,
	[MonitoredSystemCode] [nvarchar](50) NULL,
	[SystemCode] [nvarchar](15) NOT NULL,
	[RowIdentifier] [uniqueidentifier] NULL,
 CONSTRAINT [PK1] PRIMARY KEY CLUSTERED 
(
	[AnalyticGUID] ASC,
	[SystemCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AnalyticText]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[AnalyticText](
	[AnalyticGUID] [uniqueidentifier] NOT NULL,
	[Location] [nvarchar](50) NULL,
	[AnalyticValue] [nvarchar](max) NULL,
	[AnalyticDatatype] [nvarchar](50) NULL,
	[AnalyticCode] [nvarchar](50) NULL,
	[CreateDate] [datetime] NULL,
	[RowNbr] [int] IDENTITY(1,1) NOT NULL,
	[Plane] [int] NULL,
	[Radial] [int] NULL,
	[VectorMagnitude] [decimal](18, 4) NULL,
	[VectorPower] [int] NULL,
	[OwnerGUID] [uniqueidentifier] NULL,
	[MonitoredSystemCode] [nvarchar](50) NULL,
	[SystemCode] [nvarchar](15) NOT NULL,
	[RowIdentifier] [uniqueidentifier] NULL,
 CONSTRAINT [PK1_1] PRIMARY KEY CLUSTERED 
(
	[AnalyticGUID] ASC,
	[SystemCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Classification]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Classification](
	[ClassCode] [nvarchar](50) NOT NULL,
	[ClassDesc] [nvarchar](500) NULL,
	[RowIdentifier] [uniqueidentifier] NULL,
 CONSTRAINT [PK2_1] PRIMARY KEY CLUSTERED 
(
	[ClassCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Control]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Control](
	[ControlID] [uniqueidentifier] NOT NULL,
	[ControlDesc] [nvarchar](250) NOT NULL,
 CONSTRAINT [PK_Control] PRIMARY KEY CLUSTERED 
(
	[ControlID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EmailAddress]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[EmailAddress](
	[email] [varchar](50) NULL,
	[FNAME] [varchar](50) NULL,
	[LNAME] [varchar](50) NULL,
	[ADDRESS] [varchar](50) NULL,
	[CITY] [varchar](50) NULL,
	[STATE] [varchar](50) NULL,
	[ZIP] [varchar](50) NULL,
	[AGE] [varchar](50) NULL,
	[DOB] [varchar](50) NULL,
	[GENDER] [varchar](50) NULL,
	[MARRIED] [varchar](50) NULL,
	[CHILDREN] [varchar](50) NULL,
	[VETERAN] [varchar](50) NULL,
	[INCOME] [varchar](50) NULL,
	[MALEOCCCODE] [varchar](50) NULL,
	[FEMALEOCCCODE] [varchar](50) NULL,
	[HOMEOWNER] [varchar](50) NULL,
	[LANGUAGE] [varchar](50) NULL,
	[ETHNICITY] [varchar](50) NULL,
	[GOLF] [varchar](50) NULL,
	[OUTDOOR] [varchar](50) NULL,
	[TRAVEL_ARTS] [varchar](50) NULL,
	[POLITICAL] [varchar](50) NULL,
	[HEALTH] [varchar](50) NULL,
	[IPADDRESS] [varchar](50) NULL,
	[OPTDATE] [varchar](50) NULL,
	[SOURCE] [varchar](50) NULL,
	[HiTech] [varchar](50) NULL,
	[Bankcard] [varchar](50) NULL,
	[StockBonds] [varchar](50) NULL,
	[PremiumBankcard] [varchar](50) NULL,
	[OilCard] [varchar](50) NULL,
	[FinanceCard] [varchar](50) NULL,
	[RetailCard] [varchar](50) NULL,
	[ID] [varchar](50) NULL,
	[EID] [varchar](50) NULL,
	[RowNbr] [int] IDENTITY(1,1) NOT NULL
) ON [PRIMARY]
END
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[EmailAddress]') AND name = N'PI_EADDR')
CREATE CLUSTERED INDEX [PI_EADDR] ON [dbo].[EmailAddress]
(
	[STATE] ASC,
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[IdentCodes]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[IdentCodes](
	[Identifier] [nvarchar](50) NOT NULL,
	[Desc] [nvarchar](250) NULL,
 CONSTRAINT [PK_IdentCodes] PRIMARY KEY CLUSTERED 
(
	[Identifier] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MonitoredSystem]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[MonitoredSystem](
	[SystemCode] [nvarchar](15) NOT NULL,
	[SystemName] [nvarchar](50) NULL,
	[SystemDesc] [nvarchar](2000) NULL,
	[RowIdentifier] [uniqueidentifier] NULL,
 CONSTRAINT [PK6] PRIMARY KEY NONCLUSTERED 
(
	[SystemCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UI_System] UNIQUE NONCLUSTERED 
(
	[SystemName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PgmTrace]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[PgmTrace](
	[StmtID] [nvarchar](50) NULL,
	[PgmName] [nvarchar](50) NULL,
	[Stmt] [nvarchar](max) NULL,
	[CreateDate] [datetime] NULL,
	[RowNbr] [int] IDENTITY(1,1) NOT NULL,
	[RowIdentifier] [uniqueidentifier] NULL,
	[IDGUID] [uniqueidentifier] NULL,
	[LastModDate] [datetime] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SphericalData]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[SphericalData](
	[Identifier] [nvarchar](50) NOT NULL,
	[Octant] [int] NOT NULL,
	[Radial] [int] NOT NULL,
	[Plane] [int] NOT NULL,
	[Magnitude] [int] NOT NULL,
	[ControlID] [uniqueidentifier] NULL,
	[GeoLoc] [nvarchar](50) NULL,
	[NbrHits] [int] NULL,
	[SDID] [uniqueidentifier] NOT NULL,
	[LinkEmail] [nvarchar](80) NULL,
 CONSTRAINT [PK_SphericalData] PRIMARY KEY CLUSTERED 
(
	[SDID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Tracking]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Tracking](
	[SystemCode] [nvarchar](15) NOT NULL,
	[EventID] [nvarchar](50) NOT NULL,
	[email] [nvarchar](50) NOT NULL,
	[identifier] [nvarchar](50) NOT NULL,
	[DT] [varchar](50) NOT NULL,
	[amt] [nvarchar](50) NULL,
	[qty] [nvarchar](50) NULL,
	[EntryDate] [datetime] NULL,
	[RowNbr] [int] IDENTITY(1,1) NOT NULL,
	[LocID] [nvarchar](50) NULL
) ON [PRIMARY]
END
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[EmailAddress]') AND name = N'PI_EmailAddress')
CREATE NONCLUSTERED INDEX [PI_EmailAddress] ON [dbo].[EmailAddress]
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[EmailAddress]') AND name = N'PI_RID')
CREATE UNIQUE NONCLUSTERED INDEX [PI_RID] ON [dbo].[EmailAddress]
(
	[RowNbr] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[EmailAddress]') AND name = N'PI_RowNbr')
CREATE NONCLUSTERED INDEX [PI_RowNbr] ON [dbo].[EmailAddress]
(
	[RowNbr] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[EmailAddress]') AND name = N'PI_State')
CREATE NONCLUSTERED INDEX [PI_State] ON [dbo].[EmailAddress]
(
	[STATE] ASC
)
INCLUDE ( 	[ZIP],
	[CITY]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[EmailAddress]') AND name = N'PI_Zip')
CREATE NONCLUSTERED INDEX [PI_Zip] ON [dbo].[EmailAddress]
(
	[ZIP] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_Admin_bRead]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Admin] ADD  CONSTRAINT [DF_Admin_bRead]  DEFAULT ((1)) FOR [bRead]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_Admin_bWrite]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Admin] ADD  CONSTRAINT [DF_Admin_bWrite]  DEFAULT ((1)) FOR [bWrite]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_Admin_bDelete]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Admin] ADD  CONSTRAINT [DF_Admin_bDelete]  DEFAULT ((1)) FOR [bDelete]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_Admin_bCreateAdmin]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Admin] ADD  CONSTRAINT [DF_Admin_bCreateAdmin]  DEFAULT ((0)) FOR [bCreateAdmin]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__AnalyticC__RowId__2D27B809]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AnalyticClassDetail] ADD  CONSTRAINT [DF__AnalyticC__RowId__2D27B809]  DEFAULT (newid()) FOR [RowIdentifier]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__AnalyticC__RowId__2E1BDC42]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AnalyticClassText] ADD  CONSTRAINT [DF__AnalyticC__RowId__2E1BDC42]  DEFAULT (newid()) FOR [RowIdentifier]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__AnalyticD__Creat__286302EC]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AnalyticDetail] ADD  CONSTRAINT [DF__AnalyticD__Creat__286302EC]  DEFAULT (getdate()) FOR [CreateDate]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__AnalyticD__RowId__29572725]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AnalyticDetail] ADD  CONSTRAINT [DF__AnalyticD__RowId__29572725]  DEFAULT (newid()) FOR [RowIdentifier]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__AnalyticT__Creat__060DEAE8]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AnalyticText] ADD  CONSTRAINT [DF__AnalyticT__Creat__060DEAE8]  DEFAULT (getdate()) FOR [CreateDate]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__AnalyticT__RowId__2A4B4B5E]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AnalyticText] ADD  CONSTRAINT [DF__AnalyticT__RowId__2A4B4B5E]  DEFAULT (newid()) FOR [RowIdentifier]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__Classific__RowId__2B3F6F97]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Classification] ADD  CONSTRAINT [DF__Classific__RowId__2B3F6F97]  DEFAULT (newid()) FOR [RowIdentifier]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_Control_ControlID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Control] ADD  CONSTRAINT [DF_Control_ControlID]  DEFAULT (newid()) FOR [ControlID]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_IdentCodes_Desc]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[IdentCodes] ADD  CONSTRAINT [DF_IdentCodes_Desc]  DEFAULT (newid()) FOR [Desc]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__Monitored__RowId__2C3393D0]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[MonitoredSystem] ADD  CONSTRAINT [DF__Monitored__RowId__2C3393D0]  DEFAULT (newid()) FOR [RowIdentifier]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_PgmTrace_CreateDate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[PgmTrace] ADD  CONSTRAINT [DF_PgmTrace_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__PgmTrace__RowIde__4A8310C6]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[PgmTrace] ADD  CONSTRAINT [DF__PgmTrace__RowIde__4A8310C6]  DEFAULT (newid()) FOR [RowIdentifier]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__PgmTrace__IDGUID__5BE2A6F2]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[PgmTrace] ADD  CONSTRAINT [DF__PgmTrace__IDGUID__5BE2A6F2]  DEFAULT (newid()) FOR [IDGUID]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__PgmTrace__LastMo__5CD6CB2B]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[PgmTrace] ADD  CONSTRAINT [DF__PgmTrace__LastMo__5CD6CB2B]  DEFAULT (getdate()) FOR [LastModDate]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_SphericalData_NbrHits]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SphericalData] ADD  CONSTRAINT [DF_SphericalData_NbrHits]  DEFAULT ((0)) FOR [NbrHits]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_SphericalData_SDID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SphericalData] ADD  CONSTRAINT [DF_SphericalData_SDID]  DEFAULT (newid()) FOR [SDID]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_Tracking_amt]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Tracking] ADD  CONSTRAINT [DF_Tracking_amt]  DEFAULT ((0)) FOR [amt]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_Tracking_qty]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Tracking] ADD  CONSTRAINT [DF_Tracking_qty]  DEFAULT ((0)) FOR [qty]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__Tracking__EntryD__4CA06362]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Tracking] ADD  CONSTRAINT [DF__Tracking__EntryD__4CA06362]  DEFAULT (getdate()) FOR [EntryDate]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefAnalyticDetail5]') AND parent_object_id = OBJECT_ID(N'[dbo].[AnalyticClassDetail]'))
ALTER TABLE [dbo].[AnalyticClassDetail]  WITH CHECK ADD  CONSTRAINT [RefAnalyticDetail5] FOREIGN KEY([AnalyticGUID], [SystemCode])
REFERENCES [dbo].[AnalyticDetail] ([AnalyticGUID], [SystemCode])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefAnalyticDetail5]') AND parent_object_id = OBJECT_ID(N'[dbo].[AnalyticClassDetail]'))
ALTER TABLE [dbo].[AnalyticClassDetail] CHECK CONSTRAINT [RefAnalyticDetail5]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefClassification3]') AND parent_object_id = OBJECT_ID(N'[dbo].[AnalyticClassDetail]'))
ALTER TABLE [dbo].[AnalyticClassDetail]  WITH CHECK ADD  CONSTRAINT [RefClassification3] FOREIGN KEY([ClassCode])
REFERENCES [dbo].[Classification] ([ClassCode])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefClassification3]') AND parent_object_id = OBJECT_ID(N'[dbo].[AnalyticClassDetail]'))
ALTER TABLE [dbo].[AnalyticClassDetail] CHECK CONSTRAINT [RefClassification3]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefAnalyticText6]') AND parent_object_id = OBJECT_ID(N'[dbo].[AnalyticClassText]'))
ALTER TABLE [dbo].[AnalyticClassText]  WITH CHECK ADD  CONSTRAINT [RefAnalyticText6] FOREIGN KEY([AnalyticGUID], [SystemCode])
REFERENCES [dbo].[AnalyticText] ([AnalyticGUID], [SystemCode])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefAnalyticText6]') AND parent_object_id = OBJECT_ID(N'[dbo].[AnalyticClassText]'))
ALTER TABLE [dbo].[AnalyticClassText] CHECK CONSTRAINT [RefAnalyticText6]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefClassification4]') AND parent_object_id = OBJECT_ID(N'[dbo].[AnalyticClassText]'))
ALTER TABLE [dbo].[AnalyticClassText]  WITH CHECK ADD  CONSTRAINT [RefClassification4] FOREIGN KEY([ClassCode])
REFERENCES [dbo].[Classification] ([ClassCode])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefClassification4]') AND parent_object_id = OBJECT_ID(N'[dbo].[AnalyticClassText]'))
ALTER TABLE [dbo].[AnalyticClassText] CHECK CONSTRAINT [RefClassification4]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefMonitoredSystem8]') AND parent_object_id = OBJECT_ID(N'[dbo].[AnalyticDetail]'))
ALTER TABLE [dbo].[AnalyticDetail]  WITH CHECK ADD  CONSTRAINT [RefMonitoredSystem8] FOREIGN KEY([SystemCode])
REFERENCES [dbo].[MonitoredSystem] ([SystemCode])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefMonitoredSystem8]') AND parent_object_id = OBJECT_ID(N'[dbo].[AnalyticDetail]'))
ALTER TABLE [dbo].[AnalyticDetail] CHECK CONSTRAINT [RefMonitoredSystem8]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefMonitoredSystem7]') AND parent_object_id = OBJECT_ID(N'[dbo].[AnalyticText]'))
ALTER TABLE [dbo].[AnalyticText]  WITH CHECK ADD  CONSTRAINT [RefMonitoredSystem7] FOREIGN KEY([SystemCode])
REFERENCES [dbo].[MonitoredSystem] ([SystemCode])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefMonitoredSystem7]') AND parent_object_id = OBJECT_ID(N'[dbo].[AnalyticText]'))
ALTER TABLE [dbo].[AnalyticText] CHECK CONSTRAINT [RefMonitoredSystem7]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SphericalData_Control]') AND parent_object_id = OBJECT_ID(N'[dbo].[SphericalData]'))
ALTER TABLE [dbo].[SphericalData]  WITH CHECK ADD  CONSTRAINT [FK_SphericalData_Control] FOREIGN KEY([ControlID])
REFERENCES [dbo].[Control] ([ControlID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SphericalData_Control]') AND parent_object_id = OBJECT_ID(N'[dbo].[SphericalData]'))
ALTER TABLE [dbo].[SphericalData] CHECK CONSTRAINT [FK_SphericalData_Control]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SphericalData_IdentCodes]') AND parent_object_id = OBJECT_ID(N'[dbo].[SphericalData]'))
ALTER TABLE [dbo].[SphericalData]  WITH CHECK ADD  CONSTRAINT [FK_SphericalData_IdentCodes] FOREIGN KEY([Identifier])
REFERENCES [dbo].[IdentCodes] ([Identifier])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SphericalData_IdentCodes]') AND parent_object_id = OBJECT_ID(N'[dbo].[SphericalData]'))
ALTER TABLE [dbo].[SphericalData] CHECK CONSTRAINT [FK_SphericalData_IdentCodes]
GO

