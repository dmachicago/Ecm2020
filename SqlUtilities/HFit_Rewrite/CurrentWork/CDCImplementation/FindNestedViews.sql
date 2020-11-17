
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
-- select * from TEMP_NestedViewObjects
-- Use KenticoCMS_Datamart_2
--drop procedure proc_getViewsNestedObjects
--view_EDW_BioMetrics_CT
--EXEC proc_getViewsNestedObjects view_EDW_BioMetrics_CT, 1;
--EXEC proc_getViewsNestedObjects view_EDW_HealthAssesment, 1;
--EXEC proc_getViewsNestedObjects view_EDW_SmallStepResponses, 1;
--EXEC proc_getViewsNestedObjects View_EDW_HealthAssesmentQuestions;
--EXEC proc_getViewsNestedObjects view_EDW_HAassessment, 1;
--EXEC proc_getViewsNestedObjects view_EDW_Participant;
--EXEC proc_getViewsNestedObjects view_EDW_HealthAssesmentDeffinitionCustom, 1;
--EXEC proc_getViewsNestedObjects view_EDW_RewardsDefinition, 1;
--EXEC proc_getViewsNestedObjects view_EDW_ScreeningsFromTrackers;
--EXEC proc_getViewsNestedObjects view_EDW_TrackerTests;
--EXEC proc_getViewsNestedObjects view_EDW_TrackerShots, 1;
--EXEC proc_getViewsNestedObjects view_EDW_CoachingDefinition;
--EXEC proc_getViewsNestedObjects view_EDW_HealthAssesmentDeffinition, 1;
--EXEC proc_getViewsNestedObjects view_EDW_CoachingDetail_MART;
--EXEC proc_getViewsNestedObjects view_EDW_TrackerMetadata;
--EXEC proc_getViewsNestedObjects view_EDW_Coaches;
--EXEC proc_getViewsNestedObjects view_EDW_ClientCompany;
--EXEC proc_getViewsNestedObjects view_EDW_HealthAssesmentClientView;
--EXEC proc_getViewsNestedObjects view_EDW_RewardAwardDetail;
--EXEC proc_getViewsNestedObjects view_EDW_RewardUserDetail;
--EXEC proc_getViewsNestedObjects View_EDW_HealthAssesmentAnswers;
--EXEC proc_getViewsNestedObjects view_EDW_HealthAssessment_Staged;
--EXEC proc_getViewsNestedObjects view_EDW_HADefinition;
--EXEC proc_getViewsNestedObjects view_EDW_HealthAssessmentDefinition_Staged;
--EXEC proc_getViewsNestedObjects view_EDW_TrackerCompositeDetails;
--EXEC proc_getViewsNestedObjects view_EDW_HealthAssesment, 1;
--EXEC proc_getViewsNestedObjects view_EDW_RewardUserDetail, 1 ;
-- SELECT * FROM temp_ViewObjects;
-- select * from viewHierarchyColumns where TypeObject = 'USER_TABLE' and OwnerObject = 'view_EDW_HealthAssesment'
/*
EXEC proc_getViewsNestedObjects view_EDW_RewardTriggerParameters, 1;
EXEC proc_getViewsNestedObjects View_HFit_RewardTrigger_Joined, 1 

select * from information_schema.views where table_name = 'view_EDW_RewardTriggerParameters'

exec sp_depends view_EDW_RewardTriggerParameters
exec sp_depends View_HFit_RewardTrigger_Joined
exec sp_depends View_HFit_RewardTriggerParameter_Joined
exec sp_depends View_CMS_Tree_Joined

exec sp_depends View_COM_SKU
exec sp_depends View_CMS_Tree_Joined_Linked
exec sp_depends View_CMS_Tree_Joined_Regular

dbo.View_BookingSystem_Joined
dbo.View_CMS_Tree_Joined_Attachments
dbo.View_CMS_UserDocuments
dbo.View_CONTENT_Article_Joined


SELECT 'ViewObjects' as  Temp_Table, * FROM #ViewObjects WHERE ObjType = 'table';
select * from viewHierarchyColumns where OwnerObject = 'view_EDW_RewardTriggerParameters' --and TypeObject = 'USER_TABLE'
SELECT * FROM temp_ViewObjects WHERE OwnerObject = 'view_EDW_RewardTriggerParameters';
*/
IF EXISTS (SELECT
                  name
           FROM sysobjects
           WHERE
                  name = 'proc_getViewsNestedObjects') 
    BEGIN
        DROP PROCEDURE
             proc_getViewsNestedObjects;
    END;
GO

CREATE PROCEDURE proc_getViewsNestedObjects (
       @TgtView AS NVARCHAR (100) 
     , @DisplayOutput AS BIT = 0) 
AS
BEGIN
    BEGIN
        SET NOCOUNT ON;

/*--------------------------------------------------------------------------------------------------------
Author:	  W. Dale Miller
Date:	  August 12, 2007
Purpose:	  Track thru a view and find all nested views and tables and correlate each to its parent entity.
*/

        --A temp table can be used if only interested in 1 view at a time.
        --Using a perm table allows multiple views to be analyzed as a set.
        --drop table temp_ViewObjects

        IF NOT EXISTS (SELECT
                              name
                       FROM sys.tables
                       WHERE
                              name = 'temp_ViewObjects') 
            BEGIN
                SET ANSI_NULLS ON;
                CREATE TABLE dbo.temp_ViewObjects (
                             OwnerObject NVARCHAR (100) NOT NULL
                           , ObjectName NVARCHAR (100) NOT NULL
                           , CONSTRAINT PK_temp_ViewObjects PRIMARY KEY CLUSTERED (OwnerObject ASC , ObjectName ASC) 
                                 WITH (PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , IGNORE_DUP_KEY = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]) 
                ON [PRIMARY];
            END;

        -- Create a temp table to hold the view/table hierarchy
        DELETE FROM temp_ViewObjects
        WHERE
               OwnerObject = @TgtView;
        IF EXISTS (SELECT
                          name
                   FROM tempdb.dbo.sysobjects
                   WHERE
                          ID = OBJECT_ID (N'tempdb..#viewHierarchy')) 
            BEGIN
                DROP TABLE
                     #viewHierarchy;
            END;
        IF EXISTS (SELECT
                          name
                   FROM tempdb.dbo.sysobjects
                   WHERE
                          ID = OBJECT_ID (N'tempdb..#ViewObjects')) 
            BEGIN
                DROP TABLE
                     #ViewObjects;
            END;
        CREATE TABLE #viewHierarchy (
				 OwnerObject nvarchar(250)
                   , id INT IDENTITY (1 , 1) 
                   , parent_view_id INT
                   , referenced_schema_name NVARCHAR (255) 
                   , referenced_entity_name NVARCHAR (255) 
                   , join_clause NVARCHAR (MAX) 
                   , LEVEL TINYINT
                   , lineage NVARCHAR (MAX) 
                   , ObjType NVARCHAR (50)) ;
        DECLARE
               @viewname NVARCHAR (1000) 
             , @count INT
             , -- Current ID

               @maxCount INT;

        -- Max ID of the temp table
        -- Set the name of the top level view you want to detangle

        SELECT
               @viewName = @TgtView
             , @count = 1;

        ----------------------------------------------------------------------------
        -- Seed the table with the root view, and the root view's referenced tables.
        ----------------------------------------------------------------------------

        INSERT INTO #viewHierarchy
        SELECT
		   @TgtView
             , NULL AS parent_view_id
             , 'dbo' AS referenced_schema_name
             , @viewName AS referenced_entity_name
             , NULL AS join_clause
             , 0 AS LEVEL
             , '/' AS lineage
             , 'View';

        INSERT INTO #viewHierarchy
        SELECT DISTINCT
			 @TgtView
             , @count AS parent_view_id
             , referenced_schema_name
             , referenced_entity_name
             , '' AS join_clause
             , 1 AS LEVEL
             , '/1/' AS lineage
             , 'View'
        FROM sys.dm_sql_referenced_entities (N'dbo.' + @viewName , 'OBJECT') ;
        SELECT
               @maxCount = MAX (id) 
        FROM #viewHierarchy;

        ----------------------------------------------------------------------------
        -- Loop through the nested views.
        ----------------------------------------------------------------------------

        WHILE
               @count < @maxCount
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
                           WHERE
                           name = @viewName AND
                           TYPE IS NOT NULL) 
                    BEGIN
                        INSERT INTO #viewHierarchy
                        SELECT DISTINCT
					      @TgtView
                             , @count AS parent_view_id
                             , referenced_schema_name
                             , referenced_entity_name
                             , '' AS     join_clause
                             , NULL AS   LEVEL
                             , '' AS     lineage
                             , 'View'
                        FROM sys.dm_sql_referenced_entities (N'dbo.' + @viewName , 'OBJECT') ;
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
                  ,T.Lineage = P.Lineage + LTRIM (STR (T.parent_view_id , 6 , 0)) + '/'
            FROM #viewHierarchy AS T
                 INNER JOIN #viewHierarchy AS P
                 ON
                   T.parent_view_id = P.ID
            WHERE
                  P.Level >= 0 AND
                  P.Lineage IS NOT NULL AND
                  T.Level IS NULL;
        UPDATE #viewHierarchy
            SET
                ObjType = 'Table'
        WHERE
              referenced_entity_name IN (SELECT
                                                name
                                         FROM sys.tables) ;
        SELECT
               parent.*
             , child.id AS ChildID
             , child.referenced_entity_name AS ChildName INTO
                                                              #ViewObjects
        FROM #viewHierarchy AS parent
             RIGHT OUTER JOIN #viewHierarchy AS child
             ON
               child.parent_view_id = parent.id
        ORDER BY
                 parent.id , child.id;
        UPDATE #ViewObjects
            SET
                ObjType = 'Table'
        WHERE
              ChildName IN (SELECT
                                   name
                            FROM sys.tables) ;
        IF
               @DisplayOutput = 1
            BEGIN
                SELECT
                       'ViewObjects' as  Temp_Table
                     , *
                FROM #ViewObjects
                WHERE
                       ObjType = 'table';

                SELECT DISTINCT
                       'ViewObjects' as  Temp_Table, ChildName
                FROM #ViewObjects
                WHERE
                       ObjTYpe = 'Table'
                ORDER BY
                         ChildName;

            END;

        DECLARE
               @name NVARCHAR (100) ;
        DECLARE db_cursor CURSOR
            FOR SELECT DISTINCT
                       ChildName
                FROM #ViewObjects
                ORDER BY
                         ChildName;
        OPEN db_cursor;
        FETCH NEXT FROM db_cursor INTO @name;
        WHILE
               @@FETCH_STATUS = 0
            BEGIN
                IF NOT EXISTS (SELECT
                                      ObjectName
                               FROM temp_ViewObjects
                               WHERE
                                      ObjectName = @name AND
                                      OwnerObject = @TgtView) 
                    BEGIN
                        --PRINT 'Inserting: ' + @name + ' : ' + @TgtView;
                        INSERT INTO temp_ViewObjects (
                               OwnerObject
                             , ObjectName) 
                        VALUES
                        (
                        @TgtView , @name) ;
                    END;
                FETCH NEXT FROM db_cursor INTO @name;
            END;
        CLOSE db_cursor;
        DEALLOCATE db_cursor;
        PRINT 'Check table temp_ViewObjects for objects';
        IF
               @DisplayOutput = 1
            BEGIN
                SELECT 'temp_ViewObjects' as  Temp_Table, *
                FROM temp_ViewObjects
			 where OwnerObject = @TgtView
                ORDER BY
                         OwnerObject , ObjectName;
            END;
    END;
    --drop table viewHierarchyColumns
    IF NOT EXISTS (SELECT
                          name
                   FROM sys.tables
                   WHERE
                          name = 'viewHierarchyColumns') 
        BEGIN
            CREATE TABLE viewHierarchyColumns (
                         OwnerObject NVARCHAR (101) 
                       , DependentObject NVARCHAR (101) 
                       , ColumnName NVARCHAR (101)
				    , TypeObject NVARCHAR (50)) 
        END;

    IF EXISTS (SELECT
                      name
               FROM tempdb.dbo.sysobjects
               WHERE
                      ID = OBJECT_ID (N'tempdb..#viewHierarchy')) 
        BEGIN
            DELETE FROM viewHierarchyColumns
            WHERE
                   OwnerObject = @TgtView;
        END;

    INSERT INTO viewHierarchyColumns
    SELECT
           OwnerObject = SUBSTRING (OBJECT_NAME (d.id) , 1 , 100) 
         , DependentObject = SUBSTRING (OBJECT_NAME (d.depid) , 1 , 100) 
         , ColumnName = SUBSTRING (name , 1 , 100)
	    , TypeObject = (select type_desc from sys.objects where name = SUBSTRING (OBJECT_NAME (d.depid) , 1 , 100))
    FROM sysdepends AS d
         JOIN syscolumns AS c
         ON
            d.depid = c.id AND
           d.depnumber = c.colid
    WHERE
           OBJECT_NAME (d.id) = @TgtView;
    IF
           @DisplayOutput = 1
        BEGIN
            SELECT 'viewHierarchyColumns' as TEMP_Table, * FROM viewHierarchyColumns WHERE OwnerObject = @TgtView;
            SELECT 'temp_ViewObjects' as TEMP_Table, * FROM temp_ViewObjects WHERE OwnerObject = @TgtView;
            SELECT distinct 'JoinedTables' as TEMP_Table, OBJS.ObjectName, COLS.ColumnName
            FROM temp_ViewObjects AS OBJS
                 JOIN viewHierarchyColumns AS COLS
                 ON COLS.DependentObject = OBJS.ObjectName
            WHERE
            ObjectName IN (SELECT name FROM sys.tables WHERE type = 'U') AND COLS.OwnerObject = @TgtView
		  group by OBJS.ObjectName, COLS.ColumnName
            ORDER BY ObjectName , COLS.ColumnName;
        END;

END;