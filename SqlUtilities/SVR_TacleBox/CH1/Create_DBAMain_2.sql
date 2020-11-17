ALTER DATABASE [_DBAMain] SET COMPATIBILITY_LEVEL = 100
GO

-- Create Function to Parse Strings
USE [_DBAMain]
GO

/****** Object:  UserDefinedFunction [dbo].[fnuParseString]    Script Date: 02/05/2009 21:06:43 ******/
SET QUOTED_IDENTIFIER ON
GO

CREATE function
	  [dbo].[fnuParseString]
	(
	  @MyString	varchar(8000)
	, @Delimiter	varchar(100)
	)
Returns @tbl table
	(
	  FieldVal	varchar(8000)
	)
As

Begin
 
Declare
	  @iPos			int
	, @iDelimPos	int

If @Delimiter = ' '
Begin
	Select @MyString = Replace(@MyString, @Delimiter, '^^^')
 
	Select @Delimiter = '^^^'
End
 
Select  @iPos = 1
 
While @iPos < Len(@MyString)
Begin
	Select @iDelimPos = CharIndex(@Delimiter, @MyString, @iPos)

	If @iDelimPos = 0
	Begin
		Select @iDelimPos = Len(@MyString) + 1
	End

	Insert @tbl Select Substring(@MyString, @iPos, @iDelimPos - @iPos)

	Select @iPos = @iDelimPos + Len(@Delimiter)
End
 
return
 
end

GO

--Create Indexing Stored Procedure
USE [_DBAMain]
GO

/****** Object:  StoredProcedure [dbo].[spxGet2k5Fragmentation]    Script Date: 02/05/2009 21:14:30 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


/*
Exec spxGet2k5Fragmentation
	  7
	, 1
*/
Create Procedure
	  [dbo].[spxGet2k5Fragmentation]
	(
	  @dbid		int
	, @Debug	bit = 0
	)
As
Set NoCount On

Declare
	  @DatabaseName	varchar(75)
	, @tSQL		varchar(1000)
	, @CR		varchar(2)

Select @CR = char(13) + char(10)

Select @tSQL = 'Use ' + db_name(@dbid) + ';' + @CR
Select @tSQL = @tSQL + 'SELECT Distinct' + @CR
Select @tSQL = @tSQL + char(9) + space(2) + 'o.id		TableID' + @CR
Select @tSQL = @tSQL + char(9) + ', o.name	TableName' + @CR
Select @tSQL = @tSQL + char(9) + ', i.name	IndexName' + @CR
Select @tSQL = @tSQL + char(9) + ', s.avg_fragmentation_in_percent	LogicalFragmentation' + @CR
Select @tSQL = @tSQL + char(9) + ', s.page_count				Pages' + @CR
Select @tSQL = @tSQL + 'FROM' + @CR
Select @tSQL = @tSQL + char(9) + space(2) + 'sysobjects	o' + @CR
Select @tSQL = @tSQL + 'Inner Join' + @CR
Select @tSQL = @tSQL + char(9) + space(2) + 'sysindexes	i' + @CR
Select @tSQL = @tSQL + 'On' + @CR
Select @tSQL = @tSQL + char(9) + space(2) + 'o.id = i.id' + @CR
Select @tSQL = @tSQL + 'Inner Join' + @CR
Select @tSQL = @tSQL + char(9) + space(2) + 'sys.dm_db_index_physical_stats	(' + @CR
Select @tSQL = @tSQL + char(9) + char(9) + char(9) + char(9) + char(9) + char(9) + space(2) + cast(@dbid as varchar(10)) + @CR
Select @tSQL = @tSQL + char(9) + char(9) + char(9) + char(9) + char(9) + char(9) + ', Null' + @CR
Select @tSQL = @tSQL + char(9) + char(9) + char(9) + char(9) + char(9) + char(9) + ', NULL' + @CR
Select @tSQL = @tSQL + char(9) + char(9) + char(9) + char(9) + char(9) + char(9) + ', NULL' + @CR
Select @tSQL = @tSQL + char(9) + char(9) + char(9) + char(9) + char(9) + char(9) + ', NULL' + @CR
Select @tSQL = @tSQL + char(9) + char(9) + char(9) + char(9) + char(9) + char(9) + ')	s' + @CR
Select @tSQL = @tSQL + 'On' + @CR
Select @tSQL = @tSQL + char(9) + space(2) + 'o.id = s.object_id' + @CR
Select @tSQL = @tSQL + 'And' + @CR
Select @tSQL = @tSQL + char(9) + space(2) + 'i.indid = s.index_id' + @CR
Select @tSQL = @tSQL + 'WHERE' + @CR
Select @tSQL = @tSQL + char(9) + space(2) + 'o.type = ' + char(39) + 'U' + char(39) + @CR
Select @tSQL = @tSQL + 'And' + @CR
Select @tSQL = @tSQL + char(9) + space(2) + 'o.name <> ' + char(39) + 'dtproperties' + char(39) + @CR
Select @tSQL = @tSQL + 'And' + @CR
Select @tSQL = @tSQL + char(9) + space(2) + 'o.name not like ' + char(39) + 'sys%' + char(39) + @CR
Select @tSQL = @tSQL + 'And' + @CR
Select @tSQL = @tSQL + char(9) + space(2) + 'IndexProperty(i.id, i.name, ' + char(39) + 'isstatistics' + char(39) + ') = 0' + @CR
Select @tSQL = @tSQL + 'And' + @CR
Select @tSQL = @tSQL + char(9) + space(2) + 's.Page_Count > 0' + @CR
Select @tSQL = @tSQL + 'And' + @CR
Select @tSQL = @tSQL + char(9) + space(2) + 'object_id(i.name) is not null' + @CR

If @Debug <> 0
Begin
	Select @tSQL
End
Else
Begin
	Insert Into
		  ##tmpTables
		(
		  TableID
		, TableName
		, IndexName
		, LogicalFragmentation
		, Pages
		)
	Exec (@tSQL)
End

GO


--Create 2K fragmentation

USE [_DBAMain]
GO

/****** Object:  StoredProcedure [dbo].[spxGet2kFragmentation]    Script Date: 02/05/2009 21:15:39 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


/*
Exec spxGet2kFragmentation
	  7
	, 1
*/
Create Procedure
	  [dbo].[spxGet2kFragmentation]
	(
	  @dbid		int
	, @Debug	bit = 0
	)
As
Set NoCount On
Declare
	  @TableID	int
	, @TableName	varchar(255)
	, @IndexName	varchar(255)
	, @tSQL		varchar(4000)
	, @CR		varchar(2)

Select @CR = char(13) + char(10)

CREATE TABLE
	  #tmpIndexes
	(
	  ObjectName		NVARCHAR(256)
	, ObjectID		INT
	, IndexName		NVARCHAR(256)
	, IndexId		INT
	, Level			INT
	, Pages			INT
	, Rows			INT
	, MinimumRecordSize	INT
	, MaximumRecordSize	INT
	, AverageRecordSize	FLOAT
	, ForwardedRecords	INT
	, Extents		INT
	, ExtentSwitches	INT
	, AverageFreebytes	INT
	, AveragePageDensity	FLOAT
	, ScanDensity		INT
	, BestCount		INT
	, ActualCount		INT
	, LogicalFragmentation	INT
	, ExtentFragmentation	INT
	)

/*
Create Table
	  #tmpTables
	(
	  TableID	int
	, TableName	varchar(128)
	, IndexName	varchar(128)
	)
*/

Select @tSQL = 'Use ' + db_name(@dbID) + ';' + @CR
Select @tSQL = @tSQL + 'Select' + @CR
Select @tSQL = @tSQL + char(9) + space(2) + 'o.id	TableID' + @CR
Select @tSQL = @tSQL + char(9) + ', o.name	TableName' + @CR
Select @tSQL = @tSQL + char(9) + ', i.name	IndexName' + @CR
Select @tSQL = @tSQL + 'FROM' + @CR
Select @tSQL = @tSQL + char(9) + space(2) + 'sysobjects	o' + @CR
Select @tSQL = @tSQL + 'Inner Join' + @CR
Select @tSQL = @tSQL + char(9) + space(2) + 'sysindexes	i' + @CR
Select @tSQL = @tSQL + 'On' + @CR
Select @tSQL = @tSQL + char(9) + space(2) + 'o.id = i.id' + @CR
Select @tSQL = @tSQL + 'WHERE' + @CR
Select @tSQL = @tSQL + char(9) + space(2) + 'o.type = ' + char(39) + 'U' + char(39) + @CR
Select @tSQL = @tSQL + 'And' + @CR
Select @tSQL = @tSQL + char(9) + space(2) + 'o.name <> ' + char(39) + 'dtproperties' + char(39) + @CR
Select @tSQL = @tSQL + 'And' + @CR
Select @tSQL = @tSQL + char(9) + space(2) + 'o.name not like ' + char(39) + 'sys%' + char(39) + @CR
Select @tSQL = @tSQL + 'And' + @CR
Select @tSQL = @tSQL + char(9) + space(2) + 'i.dpages > 0' + @CR
Select @tSQL = @tSQL + 'And' + @CR
Select @tSQL = @tSQL + char(9) + space(2) + 'IndexProperty(i.id, i.name, ' + char(39) + 'isstatistics' + char(39) + ') = 0' + @CR
Select @tSQL = @tSQL + 'And' + @CR
Select @tSQL = @tSQL + char(9) + space(2) + 'object_id(i.name) is not null' + @CR

Insert Into
	  ##tmpTables
	(
	  TableID
	, TableName
	, IndexName
	)
Exec (@tSQL)

Declare MyCrsr Cursor
For
Select
	  TableID
	, TableName
	, IndexName
From
	  ##tmpTables

Open MyCrsr

Fetch Next From
	  MyCrsr
Into
	  @TableID
	, @TableName
	, @IndexName

While @@Fetch_Status = 0
Begin
	Select @tSQL = 'Use ' + db_name(@dbid) + '; DBCC SHOWCONTIG(' + QuoteName(@TableName) + ') WITH TABLERESULTS, FAST, ALL_INDEXES, NO_INFOMSGS'

	Insert Into
		  #tmpIndexes
		(
		  ObjectName
		, ObjectID
		, IndexName
		, IndexID
		, Level
		, Pages
		, Rows
		, MinimumRecordSize
		, MaximumRecordSize
		, AverageRecordSize
		, ForwardedRecords
		, Extents
		, ExtentSwitches
		, AverageFreeBytes
		, AveragePageDensity
		, ScanDensity
		, BestCount
		, ActualCount
		, LogicalFragmentation
		, ExtentFragmentation
		)
	Exec (@tSQL)

	Fetch Next From
		  MyCrsr
	Into
		  @TableID
		, @TableName
		, @IndexName
End

Close MyCrsr
Deallocate MyCrsr

Update
	  ##tmpTables
Set
	  LogicalFragmentation = i.LogicalFragmentation
	, Pages = i.Pages
From
	  ##tmpTables	t
Inner Join
	  #tmpIndexes	i
On
	  t.TableName = i.ObjectName
And
	  t.IndexName = i.IndexName

Drop Table #tmpIndexes

GO




USE [_DBAMain]
GO

/****** Object:  StoredProcedure [dbo].[spxIDXMaint]    Script Date: 02/05/2009 20:55:51 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


/*

exec spxIDXMaint
	  'Sunday'
	, ''
	, 1	--Debug 1 = Debug ONLY, 0 or NULL = No-Debug
*/
Create PROCEDURE
	  [dbo].[spxIDXMaint]
	(
	  @WeekdayToRebuild	varchar(10) = 'Sunday'
	, @OnlyDatabase		varchar(75) = null	--Single Database Defrag or Re-Index
	, @Debug			bit = 0
	)
AS
Set NoCount On

-- Declare variables and temp tables
DECLARE
	  @DatabaseName	NVARCHAR(255)
	, @ExecDBCC		NVARCHAR(255)
	, @TableName	NVARCHAR(255)
	, @IndexName	NVARCHAR(255)
	, @ObjectName	NVARCHAR(255)
	, @tSQL			NVARCHAR(512)
	, @DatabaseID	INT
	, @indexCount	INT
	, @indexUnique	INT
	, @tableID		INT
	, @IndexID		INT
	, @ObjectID		INT
	, @Row_ID		INT
	, @avgFragPerc	FLOAT
	, @Pages		int
	, @CR			nvarchar(2)
	, @ReorgIndex	bit

Select @CR = char(13) + char(10)

-- Holds user table names of the current DB and sets ID for them
If Exists	(
			Select
				  name
			From
				  TempDB.dbo.sysobjects where name = '##tmpTables'
			)
Begin
	DROP TABLE ##tmpTables
End

CREATE TABLE
	  ##tmpTables
	(
	  [Id]					int IDENTITY(1, 1) NOT NULL
	, TableID				INT
	, TableName				NVARCHAR(256)
	, IndexID				int
	, IndexName				varchar(256)
	, LogicalFragmentation	Float
	, Pages					int
	)

	-- Get list of online databases for iteration
	SELECT
		  @DatabaseID = MIN(db.dbid)
	FROM
		  DFINAnalytics.dbo.sysdatabases		db
	Left Join
		  _DBAMain.dbo.fnuParseString	(
						  'master,model,tempdb,msdb'
						, ','
						)	x
	On
		  db.name = x.FieldVal
	WHERE
		  x.FieldVal is null
	AND
		  DATABASEPROPERTYEX(name, 'Status') = 'Online'
	And
		  db.name not like '(new database)'

	WHILE @DatabaseID IS NOT NULL
	BEGIN
		-- Get database name
		SELECT
			  @DatabaseName = QUOTENAME(name)
		FROM
			  DFINAnalytics.dbo.sysdatabases
		WHERE
			  dbid = @DatabaseID

		If
			  QuoteName(@OnlyDatabase) = @DatabaseName
		Or
			  IsNull(@OnlyDatabase, '') = ''
		Begin
			If @@microsoftversion / power(2, 24) > 8
			Begin
				--Inserts into ##tmpTables
				Exec _DBAMain.dbo.spxGet2k5Fragmentation @DatabaseID
			End
			Else
			Begin
				--Inserts into ##tmpTables
				Exec _DBAMain.dbo.spxGet2kFragmentation @DatabaseID
			End

			Update
				  ##tmpTables
			Set
				  IndexID = i.indid
			From
				  ##tmpTables	t
			Inner Join
--				  sysindexes	i	(NoLock)
				(
				Select
					  i2.name
					, i2.id
					, i2.indid
				From
					  sysindexes	i2	(NoLock)
				Where
					  IsNull(i2.indid, 0) <> 0
				And
					  IsNull(i2.indid, 255) < 255
				)				i
			On
				  t.IndexName = i.name
			And
				  t.TableID = i.id
			And
				  IsNull(i.indid, 0) <> 0

			-- Get first table and loop through all tables
			SELECT
				  @Row_ID = MIN(ID)
			FROM
				  ##tmpTables

			WHILE @Row_ID IS NOT NULL
			BEGIN
				-- Set index count
				SELECT
					  @indexCount = @indexCount + 1
					, @ReorgIndex = 0

				Select
					  @ObjectName = TableName
					, @ObjectID = TableID
					, @IndexName = IndexName
					, @IndexID = IndexID
					, @avgFragPerc = LogicalFragmentation
					, @Pages = Pages
				From
					  ##tmpTables
				Where
					  ID = @Row_ID

				--Now start implementing the Defrag/Rebuild Rules
				--To determine which method is appropriate.
				Select @ExecDBCC = 'Use ' + @DatabaseName + @CR

				If @@microsoftversion / power(2, 24) > 8
				Begin
					If
						DateName(dw, GetDate()) = @WeekdayToRebuild
					Or
						IsNull(@avgFragPerc, 0) > 30
					BEGIN
						If IsNull(@IndexName, '') <> ''
						Begin
							Select @ExecDBCC = @ExecDBCC + 'Alter Index ' + QuoteName(RTrim(@IndexName)) + ' on ' + QuoteName(RTrim(@ObjectName)) + ' REBUILD'
							/**** Maybe check Partition Count for next partition (Need:  @PartitionCount, @PartitionNum)
							If @partitionCount > 1
							Begin
								Select @ExecDBCC = @ExecDBCC + ' Partition = ' + Cast(@Partitionnum as nvarchar(10))
							End
							*****/
						End
						Else
						Begin
							Select 'Table: ' + @TableName + ', Index Number: ' + Cast(@IndexID as varchar(10)) + ' was null.'
						End
					End
					Else
					Begin
						If IsNull(@IndexName, '') <> ''
						Begin
							Select @ReorgIndex = 1

							Select @ExecDBCC = @ExecDBCC + 'Alter Index ' + QuoteName(RTrim(@IndexName)) + ' on ' + QuoteName(RTrim(@ObjectName)) + ' REORGANIZE'
	
							/**** Maybe check Partition Count for next partition (Need:  @PartitionCount, @PartitionNum)
							If @partitionCount > 1
							Begin
								Select @ExecDBCC = @ExecDBCC + ' Partition = ' + Cast(@Partitionnum as nvarchar(10))
							End
							*****/
						End
						Else
						Begin
							Select 'Table: ' + @TableName + ', Index Number: ' + Cast(@IndexID as varchar(10)) + ' was null.'
						End
					End
				End
				Else
				Begin
					-- On @WeekdayToRebuild, we will be rebuilding indexes for all tables
					-- in the current database. This will trigger the auto update stats
					If
						  DateName(dw, GetDate()) = @WeekdayToRebuild
					Or
						  IsNull(@avgFragPerc, 0) > 30
					BEGIN
						SELECT @ExecDBCC = @ExecDBCC + 'DBCC DBREINDEX(' + QuoteName(RTRIM(@ObjectName)) + ', ' + QuoteName(RTRIM(@IndexName)) + ', 90)'
					End
					Else
					Begin
						Select @ReorgIndex = 1

						SELECT @ExecDBCC = @ExecDBCC + 'DBCC INDEXDEFRAG (' + @DatabaseName + ', ' + RTRIM(@ObjectID) + ', ' + RTRIM(@IndexName) + ')'
					End
				End

				If IsNull(@IndexName, '') <> ''
				Begin
					If @Debug <> 0
					Begin
						Select
							  Cast(@DatabaseName as varchar(30))	DBName
							, Cast(@ObjectName as varchar(30))		ObjectName
							, Cast(@IndexName as varchar(75))		IndexName
							, @ObjectID								ObjectID
							, @IndexID								IndexID
						Select @ExecDBCC		ExecDBCC
					End
					Else
					Begin
						Select
							  Cast(@DatabaseName as varchar(30))	DBName
							, Cast(@ObjectName as varchar(30))		ObjectName
							, Cast(@IndexName as varchar(75))		IndexName
							, @ObjectID								ObjectID
							, @IndexID								IndexID
						Select @ExecDBCC		ExecDBCC

						EXEC (@ExecDBCC)
					End
				End

				IF
					  @indexCount > 0
				And
					  @ReorgIndex <> 0
				BEGIN
					-- Update the stats for the table that had indexes defragged
					SELECT @ExecDBCC = 'USE ' + @DatabaseName + '; UPDATE STATISTICS ' + QUOTENAME(@ObjectName) + ' WITH SAMPLE 50 PERCENT'
					--                                              SELECT 'This table: ' + @ObjectName + ' will have statistics updated' AS "Update Stats"
					--                                              SELECT @ExecDBCC AS "Update Stats Script"

					If @Debug <> 0
					Begin
						Select
							  Cast(@DatabaseName as varchar(30))	DBName
							, Cast(@ObjectName as varchar(30))		ObjectName
							, Cast(@IndexName as varchar(75))		IndexName
							, @ObjectID								ObjectID
							, @IndexID								IndexID
						Select @ExecDBCC		ExecDBCC
					End
					Else
					Begin
						Select
							  Cast(@DatabaseName as varchar(30))	DBName
							, Cast(@ObjectName as varchar(30))		ObjectName
							, Cast(@IndexName as varchar(75))		IndexName
							, @ObjectID								ObjectID
							, @IndexID								IndexID
						Select @ExecDBCC		ExecDBCC

						EXEC (@ExecDBCC)
					End
				END

				SELECT
					  @Row_ID = MIN(ID)
				FROM
					  ##tmpTables
				Where
					  ID > @Row_ID
			END
	 
			-- Truncate the #tmpTables Temp Table
			TRUNCATE TABLE ##tmpTables
		End

		-- Get next database
		Select
			  @DatabaseID = min(db.dbid)
		FROM
			  DFINAnalytics.dbo.sysdatabases		db
		Left Join
			  _DBAMain.dbo.fnuParseString	(
										  'master,model,tempdb,msdb'
										, ','
										)	x
		On
			  db.name = x.FieldVal
		WHERE
			  x.FieldVal is null
		AND
			  DATABASEPROPERTYEX(name, 'Status') = 'Online'
		And
			  dbid > @DatabaseID
      END

-- Clean up Temp objects
DROP TABLE ##tmpTables

GO
