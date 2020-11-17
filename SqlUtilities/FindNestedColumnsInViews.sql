
----------------------------------------------------------------------------
-- Create temp table, variables
-- Analyze Nested Views - they will sooner or later cause great pain.
-- Copyright @ DMA Limited, Chicago, IL - 7/26/2009
-- Author: D. Miller 
-- USAGE:
-- If starting a new run, truncate the table temp_ViewObjects.
-- Run the procedure against one or more views and the associated views and 
--    tables will be entered into the table temp_ViewObjects.
----------------------------------------------------------------------------
--drop procedure proc_getViewsNestedColumns
--EXEC proc_getViewsNestedColumns view_EDW_SmallStepResponses, 0;
--EXEC proc_getViewsNestedColumns view_EDW_SmallStepResponses, 1;
--EXEC proc_getViewsNestedColumns View_EDW_HealthAssesmentQuestions;
--EXEC proc_getViewsNestedColumns view_EDW_HAassessment;
--EXEC proc_getViewsNestedColumns view_EDW_Participant;
--EXEC proc_getViewsNestedColumns view_EDW_HealthAssesmentDeffinitionCustom;
--EXEC proc_getViewsNestedColumns view_EDW_RewardsDefinition;
--EXEC proc_getViewsNestedColumns view_EDW_ScreeningsFromTrackers;
--EXEC proc_getViewsNestedColumns view_EDW_TrackerTests;
--EXEC proc_getViewsNestedColumns view_EDW_TrackerShots;
--EXEC proc_getViewsNestedColumns view_EDW_CoachingDefinition;
--EXEC proc_getViewsNestedColumns view_EDW_HealthAssesmentDeffinition, 1;
--EXEC proc_getViewsNestedColumns view_EDW_CoachingDetail;
--EXEC proc_getViewsNestedColumns view_EDW_TrackerMetadata;
--EXEC proc_getViewsNestedColumns view_EDW_Coaches;
--EXEC proc_getViewsNestedColumns view_EDW_ClientCompany;
--EXEC proc_getViewsNestedColumns view_EDW_RewardTriggerParameters;
--EXEC proc_getViewsNestedColumns view_EDW_HealthAssesmentClientView;
--EXEC proc_getViewsNestedColumns view_EDW_RewardAwardDetail;
--EXEC proc_getViewsNestedColumns view_EDW_RewardUserDetail;
--EXEC proc_getViewsNestedColumns View_EDW_HealthAssesmentAnswers;
--EXEC proc_getViewsNestedColumns view_EDW_HealthAssessment_Staged;
--EXEC proc_getViewsNestedColumns view_EDW_HADefinition;
--EXEC proc_getViewsNestedColumns view_EDW_HealthAssessmentDefinition_Staged;
--EXEC proc_getViewsNestedColumns view_EDW_TrackerCompositeDetails;
--EXEC proc_getViewsNestedColumns; view_EDW_HealthAssesment;

IF EXISTS (SELECT
				  name
				  FROM sysobjects
				  WHERE name = 'proc_getViewsNestedColumns') 
	BEGIN
		DROP PROCEDURE
			 proc_getViewsNestedColumns;
	END;
GO
CREATE PROCEDURE proc_getViewsNestedColumns (
	   @_ViewName AS nvarchar (100) 
	 , @DisplayOutput AS bit
      , @ColName as nvarchar(100)) 
AS
BEGIN
	BEGIN
		SET NOCOUNT ON;

		--A temp table can be used if only interested in 1 view at a time.
		--Using a perm table allows multiple views to be analyzed as a set.
		--drop table temp_ViewObjects

		IF NOT EXISTS (SELECT
							  name
							  FROM sys.tables
							  WHERE name = 'temp_ViewObjects') 
			BEGIN
				SET ANSI_NULLS ON;
				CREATE TABLE dbo.temp_ViewObjects (
							 OwnerObject nvarchar (100) NOT NULL
						   , ObjectName nvarchar (100) NOT NULL
						   , CONSTRAINT PK_temp_ViewObjects PRIMARY KEY CLUSTERED (OwnerObject ASC, ObjectName ASC) 
								 WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]) 
				ON [PRIMARY];
			END;

		-- Create a temp table to hold the view/table hierarchy

		DELETE FROM temp_ViewObjects
		WHERE
			  OwnerObject = @_ViewName;
		IF EXISTS (SELECT
						  name
						  FROM tempdb.dbo.sysobjects
						  WHERE ID = OBJECT_ID (N'tempdb..#viewHierarchy')) 
			BEGIN
				DROP TABLE
					 #viewHierarchy;
			END;
		IF EXISTS (SELECT
						  name
						  FROM tempdb.dbo.sysobjects
						  WHERE ID = OBJECT_ID (N'tempdb..#ViewObjects')) 
			BEGIN
				DROP TABLE
					 #ViewObjects;
			END;
		CREATE TABLE #viewHierarchy (
					 id int IDENTITY (1, 1) 
				   , parent_view_id int
				   , referenced_schema_name nvarchar (255) 
				   , referenced_entity_name nvarchar (255) 
				   , join_clause nvarchar (max) 
				   , LEVEL tinyint
				   , lineage nvarchar (max) 
				   , ObjType nvarchar (50)) ;
		DECLARE @viewname nvarchar (1000) 
			  , @count int
			  ,

				-- Current ID

				@maxCount int;

		-- Max ID of the temp table
		-- Set the name of the top level view you want to detangle

		SELECT
			   @viewName = @_ViewName
			 , @count = 1;

		----------------------------------------------------------------------------
		-- Seed the table with the root view, and the root view's referenced tables.
		----------------------------------------------------------------------------

		INSERT INTO #viewHierarchy
		SELECT
			   NULL AS      parent_view_id
			 , 'dbo' AS     referenced_schema_name
			 , @viewName AS referenced_entity_name
			 , NULL AS      join_clause
			 , 0 AS         LEVEL
			 , '/' AS       lineage
			 , 'View';
		INSERT INTO #viewHierarchy
		SELECT DISTINCT
			   @count AS parent_view_id
			 , referenced_schema_name
			 , referenced_entity_name
			 , '' AS     join_clause
			 , 1 AS      LEVEL
			 , '/1/' AS  lineage
			 , 'View'
			   FROM sys.dm_sql_referenced_entities (N'dbo.' + @viewName, 'OBJECT') ;
		SELECT
			   @maxCount = MAX (id) 
			   FROM #viewHierarchy;

		----------------------------------------------------------------------------
		-- Loop through the nested views.
		----------------------------------------------------------------------------

		WHILE @count < @maxCount

			-- While there are still rows to process...

			BEGIN
				SELECT
					   @count = @count + 1;

				-- Get the name of the current view (that we'd like references for)

				SELECT
					   @viewName = referenced_entity_name
					   FROM #viewHierarchy
					   WHERE id = @count;

				-- If it's a view (not a table), insert referenced objects into temp table.
				--IF EXISTS (SELECT name FROM sys.objects WHERE name = @viewName AND TYPE = 'v')

				IF EXISTS (SELECT
								  name
								  FROM sys.objects
								  WHERE name = @viewName
									AND TYPE IS NOT NULL) 
					BEGIN
						INSERT INTO #viewHierarchy
						SELECT DISTINCT
							   @count AS parent_view_id
							 , referenced_schema_name
							 , referenced_entity_name
							 , '' AS     join_clause
							 , NULL AS   LEVEL
							 , '' AS     lineage
							 , 'View'
							   FROM sys.dm_sql_referenced_entities (N'dbo.' + @viewName, 'OBJECT') ;
						SELECT
							   @maxCount = MAX (id) 
							   FROM #viewHierarchy;
					END;

			--IF EXISTS (SELECT name FROM sys.objects WHERE name = @viewName AND TYPE = 'U')
			--BEGIN
			--	INSERT INTO #viewHierarchy
			--	SELECT DISTINCT @count parent_view_id
			--	, referenced_schema_name
			--	, referenced_entity_name
			--	, '' join_clause
			--	, NULL [LEVEL]
			--	, '' lineage
			--	, 'Table'
			--	FROM sys.dm_sql_referenced_entities(N'dbo.' + @viewName,'OBJECT')
			--	SELECT @maxCount = MAX(id)
			--	FROM #viewHierarchy
			--	if exists(select name from sys.tables where name = @viewName)
			--	BEGIN
			--		update #viewHierarchy 
			--			set ObjType = 'Table' where referenced_entity_name = @viewName
			--	END
			--END

			END;

		--------------------------------------
		--------------------------------------

		WHILE EXISTS (SELECT
							 1
							 FROM #viewHierarchy
							 WHERE LEVEL IS NULL) 
			UPDATE T
			SET
				T.Level = P.Level + 1
			  ,
				T.Lineage = P.Lineage + LTRIM (STR (T.parent_view_id, 6, 0)) + '/'
				FROM #viewHierarchy AS T
						 INNER JOIN #viewHierarchy AS P
							 ON T.parent_view_id = P.ID
				WHERE
					  P.Level >= 0
				  AND P.Lineage IS NOT NULL
				  AND T.Level IS NULL;
		UPDATE #viewHierarchy
		SET
			ObjType = 'Table'
		WHERE
			  referenced_entity_name IN (SELECT
												name
												FROM sys.tables) ;
		SELECT
			   parent.*
			 , child.id AS                     ChildID
			 , child.referenced_entity_name AS ChildName INTO
															  #ViewObjects
			   FROM #viewHierarchy AS parent
						RIGHT OUTER JOIN #viewHierarchy AS child
							ON child.parent_view_id = parent.id
			   ORDER BY
						parent.id, child.id;
		UPDATE #ViewObjects
		SET
			ObjType = 'Table'
		WHERE
			  ChildName IN (SELECT
								   name
								   FROM sys.tables) ;
		IF @DisplayOutput = 1
			BEGIN
				SELECT
					   'ViewObjects'
					 , *
					   FROM #ViewObjects;
			END;

		--select distinct ChildName from #ViewObjects where ObjTYpe = 'Table' order by ChildName

		DECLARE @name nvarchar (100) ;
		DECLARE db_cursor CURSOR
			FOR SELECT DISTINCT
					   ChildName
					   FROM #ViewObjects
					   ORDER BY
								ChildName;
		OPEN db_cursor;
		FETCH NEXT FROM db_cursor INTO @name;
		WHILE @@FETCH_STATUS = 0
			BEGIN
				IF NOT EXISTS (SELECT
									  ObjectName
									  FROM temp_ViewObjects
									  WHERE ObjectName = @name
										AND OwnerObject = @_ViewName) 
					BEGIN
						--PRINT 'Inserting: ' + @name + ' : ' + @_ViewName;
						INSERT INTO temp_ViewObjects (
									OwnerObject
								  , ObjectName) 
						VALUES
							 (@_ViewName, @name) ;
					END;
				FETCH NEXT FROM db_cursor INTO @name;
			END;
		CLOSE db_cursor;
		DEALLOCATE db_cursor;
		PRINT 'Check table temp_ViewObjects for objects';
		IF @DisplayOutput = 1
			BEGIN
				SELECT
					   *
					   FROM temp_ViewObjects
					   ORDER BY
								OwnerObject, ObjectName;
			END;
	END;

	--IF EXISTS (SELECT
	--					  name
	--					  FROM tempdb.dbo.sysobjects
	--					  WHERE ID = OBJECT_ID (N'tempdb..#viewHierarchy')) 
	--		BEGIN
	--			DROP TABLE
	--				 #ViewCols;
	--		END;
	--CREATE TABLE #ViewCols (
	--	obj_name nvarchar(101)			 
	--			   , dep_obj nvarchar (101) 
	--			   , col_name nvarchar (101) );
	--insert into #ViewCols
	-- SELECT 
	-- obj_name = SUBSTRING (OBJECT_NAME (d.id) , 1, 100) 
	-- , dep_obj = SUBSTRING (OBJECT_NAME (d.depid) , 1, 100) 
	-- , col_name = SUBSTRING (name, 1, 100) 
	--   FROM sysdepends AS d 
	-- 			JOIN syscolumns AS c 
	-- 				ON d.depid = c.id 
	-- 			   AND d.depnumber = c.colid 
	--   WHERE OBJECT_NAME (d.id) = 'view_EDW_SmallStepResponses' 
	--select* from #ViewCols
	--select* from temp_ViewObjects WHERE OwnerObject = 'view_EDW_SmallStepResponses' 
	--	SELECT
	--				   OBJS.ObjectName,
	--					COLS.[col_name]
	--				   FROM temp_ViewObjects as OBJS
	--			join #ViewCols as COLS
	--				on COLS.dep_obj = OBJS.ObjectName
	--			where ObjectName in (select name from sys.tables where type = 'U')
	--			AND  OwnerObject = 'view_EDW_SmallStepResponses'
	--				   ORDER BY
	--							ObjectName, col_name;
END;

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
