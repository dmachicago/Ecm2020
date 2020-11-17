


/*
drop procedure proc_getViewsNestedObjects
view_EDW_BioMetrics_CT
EXEC proc_getViewsNestedObjects View_CMS_UserRole_MembershipRole_ValidOnly_Joined, 1;
EXEC proc_getViewsNestedObjects view_EDW_SmallStepResponses, 0;
EXEC proc_getViewsNestedObjects view_EDW_SmallStepResponses, 1;
EXEC proc_getViewsNestedObjects View_EDW_HealthAssesmentQuestions;
EXEC proc_getViewsNestedObjects view_EDW_HAassessment, 1;
EXEC proc_getViewsNestedObjects view_EDW_Participant;
EXEC proc_getViewsNestedObjects view_EDW_HealthAssesmentDeffinitionCustom;
EXEC proc_getViewsNestedObjects view_EDW_RewardsDefinition, 1;
EXEC proc_getViewsNestedObjects view_EDW_ScreeningsFromTrackers;
EXEC proc_getViewsNestedObjects view_EDW_TrackerTests;
EXEC proc_getViewsNestedObjects view_EDW_TrackerShots, 1;
EXEC proc_getViewsNestedObjects view_EDW_CoachingDefinition;
EXEC proc_getViewsNestedObjects view_EDW_HealthAssesmentDeffinition, 1;
EXEC proc_getViewsNestedObjects view_EDW_CoachingDetail;
EXEC proc_getViewsNestedObjects view_EDW_TrackerMetadata;
EXEC proc_getViewsNestedObjects view_EDW_Coaches;
EXEC proc_getViewsNestedObjects view_EDW_ClientCompany;
EXEC proc_getViewsNestedObjects view_EDW_RewardTriggerParameters;
EXEC proc_getViewsNestedObjects view_EDW_HealthAssesmentClientView;
EXEC proc_getViewsNestedObjects view_EDW_RewardAwardDetail;
EXEC proc_getViewsNestedObjects view_EDW_RewardUserDetail;
EXEC proc_getViewsNestedObjects View_EDW_HealthAssesmentAnswers;
EXEC proc_getViewsNestedObjects view_EDW_HealthAssessment_Staged;
EXEC proc_getViewsNestedObjects view_EDW_HADefinition;
EXEC proc_getViewsNestedObjects view_EDW_HealthAssessmentDefinition_Staged;
EXEC proc_getViewsNestedObjects view_EDW_TrackerCompositeDetails;
EXEC proc_getViewsNestedObjects view_EDW_HealthAssesment, 1;
EXEC proc_getViewsNestedObjects view_EDW_RewardUserDetail, 1 ;
*/
go
print 'EXECUTING FindNestedViews.sql';
go

IF EXISTS (SELECT
                  name
                  FROM sysobjects
                  WHERE name = 'proc_getViewsNestedObjects') 
    BEGIN
        DROP PROCEDURE
             proc_getViewsNestedObjects;
    END;
GO
CREATE PROCEDURE proc_getViewsNestedObjects (
     @_ViewName AS nvarchar (100) 
   , @DisplayOutput AS bit) 
AS
BEGIN
    BEGIN
        SET NOCOUNT ON;


/*
@Copyright D. Miller & Associates, Ltd., Highland Park, IL, 7.26.2009 allrights reserved.

License:	  This procedure can be used freely as long as the copyright and this header
		  are preserved.

Author:	  W. Dale Miller
Date:	  1-1-1960
Purpose:	  Analyze Nested Views - they will sooner or later cause great pain.
		  Track thru a view and find all nested views and tables and correlate each 
		  to its parent entity.
		  --A temp table can be used if only interested in 1 view at a time.
		  --Using a perm table allows multiple views to be analyzed as a set.
		  --drop table TEMP_NestedViewObjects
Note:	  If starting a new run, truncate the table TEMP_NestedViewObjects.

Use:		  Run the procedure against one or more views and the associated views and 
		  tables will be entered into the table TEMP_NestedViewObjects.
		  select * from TEMP_NestedViewObjects 
Parms:	  @_ViewName - the view to be analyzed.
		  @DisplayOutput - whether to display outout or not.
*/

        IF NOT EXISTS (SELECT
                              name
                              FROM sys.tables
                              WHERE name = 'TEMP_NestedViewObjects') 
            BEGIN
                SET ANSI_NULLS ON;
                CREATE TABLE dbo.TEMP_NestedViewObjects (
                             OwnerObject nvarchar (100) NOT NULL
                           , ObjectName nvarchar (100) NOT NULL
				       , ObjectType nvarchar (100) NULL
                           , CONSTRAINT PKTEMP_NestedViewObjects PRIMARY KEY CLUSTERED (OwnerObject ASC, ObjectName ASC) 
                                 WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]) 
                ON [PRIMARY];
            END;

        -- Create a temp table to hold the view/table hierarchy

        DELETE FROM TEMP_NestedViewObjects
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
              , -- Current ID

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
               NULL AS parent_view_id
             , 'dbo' AS referenced_schema_name
             , @viewName AS referenced_entity_name
             , NULL AS join_clause
             , 0 AS LEVEL
             , '/' AS lineage
             , 'View';
        INSERT INTO #viewHierarchy
        SELECT DISTINCT
               @count AS parent_view_id
             , referenced_schema_name
             , referenced_entity_name
             , '' AS join_clause
             , 1 AS LEVEL
             , '/1/' AS lineage
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
                                  WHERE
                                  name = @viewName
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
                     ,T.Lineage = P.Lineage + LTRIM (STR (T.parent_view_id, 6, 0)) + '/'
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
             , child.id AS ChildID
             , child.referenced_entity_name AS ChildName INTO
                                                              #ViewObjects
               FROM
                   #viewHierarchy AS parent
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
                       FROM #ViewObjects
                       WHERE ObjType = 'table';

                SELECT DISTINCT
                       ChildName
                       FROM #ViewObjects
                       WHERE ObjTYpe = 'Table'
                       ORDER BY
                                ChildName;

            END;

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
                                      FROM TEMP_NestedViewObjects
                                      WHERE
                                      ObjectName = @name
                                  AND OwnerObject = @_ViewName) 
                    BEGIN
                        --PRINT 'Inserting: ' + @name + ' : ' + @_ViewName;
                        INSERT INTO TEMP_NestedViewObjects (
                               OwnerObject
                             , ObjectName) 
                        VALUES
                               (
                               @_ViewName, @name) ;
                    END;
                FETCH NEXT FROM db_cursor INTO @name;
            END;
        CLOSE db_cursor;
        DEALLOCATE db_cursor;
        PRINT 'Check table TEMP_NestedViewObjects for objects';
	   --select top 100 * from information_schema.tables
	   update TEMP_NestedViewObjects set ObjectType = (select TABLE_TYPE from information_schema.tables where TABLE_NAME = ObjectName) ;
        IF @DisplayOutput = 1
            BEGIN
                SELECT
                       *
                       FROM TEMP_NestedViewObjects
                       ORDER BY
                                OwnerObject, ObjectName;
            END;
    END;
END;
go
print 'EXECUTed FindNestedViews.sql';
go


-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
