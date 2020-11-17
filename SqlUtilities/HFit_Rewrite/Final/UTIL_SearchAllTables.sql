


if exists (select * from sysobjects where name = 'UTIL_SearchAllTables' and Xtype = 'P')
BEGIN
	drop procedure UTIL_SearchAllTables ;
END 
go

--EXEC UTIL_SearchAllTables 'View_HFit_UserGoals'
--GO 
--EXEC UTIL_SearchAllTables 'view_HFit_TrackerEvents'
--GO 
--EXEC UTIL_SearchAllTables 'view_EDW_Coaches'
--GO 
--EXEC UTIL_SearchAllTables 'View_EDW_HealthAssesmentQuestions'
--GO 
--select * from [dbo].[EDW_PerformanceMeasure]
--select * from [Staging_Task] where [TaskData] like '%view_HFit_TrackerEvents%'

create PROC UTIL_SearchAllTables
(
	@SearchStr nvarchar(100)
)
AS
BEGIN

--DECLARE @SearchStr NVARCHAR(100);
--SET @SearchStr = 'View_EDW_HealthAssesmentQuestions' ;

	-- Purpose: To search all columns of all tables for a given string
	-- Written by: WDM
	-- Site: http://www.dmachicago.com
	-- Tested on: SQL Server 7.0 and SQL Server 2000, 2005, 2008, 2012
	-- Date created:  26 July 2000
	-- Date modified: 26 July 2004
	-- Date modified: 20 Aug  2014

	--CREATE TABLE #Results (ColumnName nvarchar(370), ColumnValue nvarchar(3630), SearchTerm nvarchar(250))
	CREATE TABLE #Results (ColumnName nvarchar(370), ColumnValue nvarchar(3630))

	SET NOCOUNT ON

	DECLARE @TableName nvarchar(256), @ColumnName nvarchar(128), @SearchStr2 nvarchar(110), @SearchStrMain nvarchar(110)
	SET  @TableName = '' ;
	SET @SearchStr2 = QUOTENAME('%' + @SearchStr + '%','''') ;
	SET @SearchStrMain = @SearchStr ;

	WHILE @TableName IS NOT NULL
	BEGIN
		SET @ColumnName = ''
		SET @TableName = 
		(
			SELECT MIN(QUOTENAME(TABLE_SCHEMA) + '.' + QUOTENAME(TABLE_NAME))
			FROM 	INFORMATION_SCHEMA.TABLES
			WHERE 		TABLE_TYPE = 'BASE TABLE'
				AND	QUOTENAME(TABLE_SCHEMA) + '.' + QUOTENAME(TABLE_NAME) > @TableName
				AND	OBJECTPROPERTY(
						OBJECT_ID(
							QUOTENAME(TABLE_SCHEMA) + '.' + QUOTENAME(TABLE_NAME)
							 ), 'IsMSShipped'
						       ) = 0
		)

		WHILE (@TableName IS NOT NULL) AND (@ColumnName IS NOT NULL)
		BEGIN
			SET @ColumnName =
			(
				SELECT MIN(QUOTENAME(COLUMN_NAME))
				FROM 	INFORMATION_SCHEMA.COLUMNS
				WHERE 		TABLE_SCHEMA	= PARSENAME(@TableName, 2)
					AND	TABLE_NAME	= PARSENAME(@TableName, 1)
					AND	DATA_TYPE IN ('char', 'varchar', 'nchar', 'nvarchar')
					AND	QUOTENAME(COLUMN_NAME) > @ColumnName
			)
	
			IF @ColumnName IS NOT NULL
			BEGIN
				INSERT INTO #Results
				EXEC
				(
					'SELECT ''' + @TableName + '.' + @ColumnName + '.' +@SearchStrMain+  ''', LEFT(' + @ColumnName + ', 3630) 
					FROM ' + @TableName + ' (NOLOCK) ' +
					' WHERE ' + @ColumnName + ' LIKE ' + @SearchStr2
				)
			
				--update #Results set SearchTerm = @SearchStr where SearchTerm is null ;
				
				--INSERT INTO TempResults
				--EXEC
				--(
				--	'Select * from #Results ' 
				--)
				
			END
		END	
	END
				
	SELECT ColumnName, ColumnValue FROM #Results
END

GO

