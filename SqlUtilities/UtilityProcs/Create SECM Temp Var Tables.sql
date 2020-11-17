CREATE TABLE [dbo].[UserSearchState](
	[ScreenName] [nvarchar](50) NOT NULL,
	[UserID] [nvarchar](50) NOT NULL,
	[ParmName] [nvarchar](50) NOT NULL,
	[ParmVal] [nvarchar](2000) NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL
)

GO

CREATE NONCLUSTERED INDEX [PI_UserSearchState] ON [dbo].[UserSearchState] 
(
	[ScreenName] ASC,
	[UserID] ASC,
	[ParmName] ASC
)
GO

CREATE TABLE [dbo].[UserScreenState](
	[ScreenName] [nvarchar](50) NOT NULL,
	[UserID] [nvarchar](50) NOT NULL,
	[ParmName] [nvarchar](50) NOT NULL,
	[ParmVal] [nvarchar](2000) NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL
)

GO

CREATE NONCLUSTERED INDEX [PI_UserScreenState] ON [dbo].[UserScreenState] 
(
	[ScreenName] ASC,
	[UserID] ASC,
	[ParmName] ASC
)
GO

CREATE TABLE [dbo].[UserGridState](
	[ScreenName] [nvarchar](50) NOT NULL,
	[GridName] [nvarchar](50) NOT NULL,
	[UserID] [nvarchar](50) NOT NULL,
	[ColName] [nvarchar](50) NOT NULL,
	[ColOrder] int NULL,
	[ColWidth] int NULL,
	[ColHeight] int NULL,
	[ColVisible] bit NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL
)
GO

CREATE NONCLUSTERED INDEX [PI_UserGridState] ON [dbo].[UserGridState] 
([ScreenName] ASC, [GridName] ASC, [ColName] ASC, [UserID] ASC)
GO




