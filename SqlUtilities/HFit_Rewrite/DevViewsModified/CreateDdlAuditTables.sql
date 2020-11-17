
go
print ('Creating the AUDIT tables.') ;
go
--CreateDdlAuditTables
	IF NOT EXISTS
	(
		SELECT name
		--FROM tempdb.dbo.sysobjects
		FROM sysobjects
		WHERE ID = OBJECT_ID(N'TBL_DIFF1')
	)
	BEGIN
		CREATE TABLE [dbo].[TBL_DIFF1](
		[table_name] [sysname] NOT NULL,
		[COLUMN_NAME] [sysname] NULL,
		[DATA_TYPE] [nvarchar](128) NULL,
		[CHARACTER_MAXIMUM_LENGTH] [nvarchar](50) NULL,
		[table_name2] [sysname] NULL,
		[DATA_TYPE2] [nvarchar](128) NULL,
		[COLUMN_NAME2] [sysname] NULL,
		[CHARACTER_MAXIMUM_LENGTH2] [int] NULL,
		[NOTE] [varchar](500) NULL,
		[CreateDate] [datetime] NULL default getdate(),
		RowNbr int identity
	)

	END

	IF NOT EXISTS
	(
		SELECT name
		--FROM tempdb.dbo.sysobjects
		FROM sysobjects
		WHERE ID = OBJECT_ID(N'TBL_DIFF2')
	)
	BEGIN

		CREATE TABLE [dbo].[TBL_DIFF2](
		[table_name] [sysname] NOT NULL,
		[COLUMN_NAME] [sysname] NULL,
		[DATA_TYPE] [nvarchar](128) NULL,
		[CHARACTER_MAXIMUM_LENGTH] [nvarchar](50) NULL,
		[table_name2] [sysname] NULL,
		[DATA_TYPE2] [nvarchar](128) NULL,
		[COLUMN_NAME2] [sysname] NULL,
		[CHARACTER_MAXIMUM_LENGTH2] [int] NULL,
		[NOTE] [varchar](500) NULL,
		[CreateDate] [datetime] NULL default getdate(),
		RowNbr int identity
	)

	END
	
		IF NOT EXISTS
	(
		SELECT name
		--FROM tempdb.dbo.sysobjects
		FROM sysobjects
		WHERE ID = OBJECT_ID(N'TBL_DIFF3')
	)
	BEGIN

		CREATE TABLE [dbo].[TBL_DIFF3](
		[table_name] [sysname] NOT NULL,
		[COLUMN_NAME] [sysname] NULL,
		[DATA_TYPE] [nvarchar](128) NULL,
		[CHARACTER_MAXIMUM_LENGTH] [nvarchar](50) NULL,
		[table_name2] [sysname] NULL,
		[DATA_TYPE2] [nvarchar](128) NULL,
		[COLUMN_NAME2] [sysname] NULL,
		[CHARACTER_MAXIMUM_LENGTH2] [int] NULL
		,[NOTE] varchar(500)
		,CreateDate datetime default getdate() ,
		RowNbr int identity
	)

	END

	IF NOT EXISTS
	(
		SELECT name
		--FROM tempdb.dbo.sysobjects
		FROM sysobjects
		WHERE ID = OBJECT_ID(N'TBL_DIFF4')
	)
	BEGIN

		CREATE TABLE [dbo].[TBL_DIFF4](
		[table_name] [sysname] NOT NULL,
		[COLUMN_NAME] [sysname] NULL,
		[DATA_TYPE] [nvarchar](128) NULL,
		[CHARACTER_MAXIMUM_LENGTH] [nvarchar](50) NULL,
		[table_name2] [sysname] NULL,
		[DATA_TYPE2] [nvarchar](128) NULL,
		[COLUMN_NAME2] [sysname] NULL,
		[CHARACTER_MAXIMUM_LENGTH2] [int] NULL
		,[NOTE] varchar(500)
		,CreateDate datetime default getdate() ,
		RowNbr int identity
	)

	END

GO
if exists(select name from sys.views where name = 'view_SchemaDiff')
BEGIN
	drop view view_SchemaDiff
	print ('Removed view_SchemaDiff.') ;
END

GO
print ('Created view_SchemaDiff.') ;
GO

Create view view_SchemaDiff AS 
Select * from TBL_DIFF1 
union 
Select * from TBL_DIFF2  
union 
Select * from TBL_DIFF3

go
print ('Created the AUDIT tables.') ;
go
