print ('Processing: UTIL_ViewAnalysis ') ;
go


if exists (select * from sysobjects where name = 'UTIL_ViewAnalysis' and Xtype = 'P')
BEGIN
	drop procedure UTIL_ViewAnalysis ;
END 
go



CREATE procedure [dbo].[UTIL_ViewAnalysis] @TargetView nvarchar(80) 
as
BEGIN
----------------------------------------------------------------------------
-- Analyze Nested Views - they will sooner or later cause great pain.
-- Created: 7/26/2008
-- DMA Limited, Chicago, IL
-- W. Dale Miller
-- dm@DmaChicago.com
----------------------------------------------------------------------------
-- Create a temp table to hold the combination view/table hierarchy
	IF EXISTS
		(
			SELECT name
			FROM tempdb.dbo.sysobjects
			WHERE ID = OBJECT_ID(N'tempdb..#NestedViews')
		)
		BEGIN
			DROP TABLE #NestedViews
		END

	CREATE TABLE #NestedViews
		( id INT IDENTITY(1,1)
		, parent_view_id INT
		, referenced_schema_name NVARCHAR(255)
		, referenced_entity_name NVARCHAR(255)
		, join_clause NVARCHAR(MAX)
		, [LEVEL] TINYINT
		, lineage NVARCHAR(MAX)
		)
	DECLARE @viewname NVARCHAR(1000),
	@count INT,        -- Current ID
	@maxCount INT    -- Max ID of the temp table

	-- Set the name of the view you want to analyze
	-- This is generally the TOP Level View, but can be one that is contained within another.
	SELECT @viewName = @TargetView,
	@count = 1
	----------------------------------------------------------------------------
	-- Seed the table with the root view, and the root view's referenced tables.
	----------------------------------------------------------------------------
	INSERT INTO #NestedViews
	SELECT NULL parent_view_id
		, 'dbo' referenced_schema_name
		, @viewName referenced_entity_name
		, NULL join_clause
		, 0 [LEVEL]
		, '/' lineage

	INSERT INTO #NestedViews
	SELECT DISTINCT @count parent_view_id
		, referenced_schema_name
		, referenced_entity_name
		, '' join_clause
		, 1 [LEVEL]
		, '/1/' lineage
		FROM sys.dm_sql_referenced_entities(N'dbo.' + @viewName,'OBJECT')

	SELECT @maxCount = MAX(id)
		FROM #NestedViews
	----------------------------------------------------------------------------
	-- Loop through the nested views and process ALL rows.
	----------------------------------------------------------------------------
	WHILE (@count < @maxCount)
	BEGIN
		SELECT @count = @count + 1

		-- Get the name of the current view (that one of interest where references are desired)
		SELECT @viewName = referenced_entity_name
		FROM #NestedViews
		WHERE id = @count

			-- If it's a view (not a table), insert referenced objects into temp table.
		IF EXISTS (SELECT name FROM sys.objects WHERE name = @viewName AND TYPE = 'v')
		BEGIN
			INSERT INTO #NestedViews
			SELECT DISTINCT @count parent_view_id
			, referenced_schema_name
			, referenced_entity_name
			, '' join_clause
			, NULL [LEVEL]
			, '' lineage
			FROM sys.dm_sql_referenced_entities(N'dbo.' + @viewName,'OBJECT')
			SELECT @maxCount = MAX(id)
			FROM #NestedViews
		END
	END
	--------------------------------------
	--------------------------------------
	WHILE EXISTS (SELECT 1 FROM #NestedViews WHERE [LEVEL] IS NULL)
		UPDATE NVHL2
		SET NVHL2.[Level] = NVHL1.[Level] + 1, NVHL2.Lineage = NVHL1.Lineage + LTRIM(STR(NVHL2.parent_view_id,6,0)) + '/'
	FROM #NestedViews AS NVHL2
		INNER JOIN #NestedViews AS NVHL1 ON (NVHL2.parent_view_id=NVHL1.ID)
	WHERE NVHL1.[Level]>=0
		AND NVHL1.Lineage IS NOT NULL
		AND NVHL2.[Level] IS NULL

	SELECT parent.*, child.id, child.referenced_entity_name ChildName
	FROM #NestedViews parent
		RIGHT OUTER JOIN #NestedViews child ON child.parent_view_id = parent.id
	ORDER BY parent.id, child.id

END

GO


