
DECLARE
   @DBNAME AS nvarchar (100) = DB_NAME () ;
DECLARE
   @ViewName nvarchar (100) = 'view_EDW_BioMetrics_CT';
DECLARE
   @synchronization_version AS int = 0;
PRINT 'Preparing the view NESTING levels';

/******************************
GET THE NESTED VIEWS AND TABLES
*****************************
*/

EXEC proc_getViewsNestedObjects @ViewName, 0;
PRINT 'NESTING levels complete';

/*******************************************
TURN CHANGE TRACKING ON FOR THE DB IF NEEDED
******************************************
*/

IF NOT EXISTS (SELECT
                      database_id
                      FROM sys.change_tracking_databases
                 WHERE database_id = (
                   SELECT
                          database_id
                          FROM sys.databases
                     WHERE name = @DBNAME)) 
    BEGIN
        PRINT 'TURNING CHANGE_TRACKING ON';
        DECLARE
           @MySQL AS nvarchar (100) = 'ALTER DATABASE ' + @DBNAME + ' SET CHANGE_TRACKING = ON (CHANGE_RETENTION = 7 DAYS , AUTO_CLEANUP = ON) ';
        EXEC (@MySQL) ;
    END;
ELSE
    BEGIN
        PRINT 'SET CHANGE_TRACKING ON';
    END;

/*********************************
*********************************
Create the TEMP View Columns table
*********************************
*/

IF EXISTS (SELECT
                  name
                  FROM tempdb.dbo.sysobjects
             WHERE ID = OBJECT_ID (N'tempdb..#ViewCols')) 
    BEGIN
        PRINT 'Dropping #ViewCols';
        DROP TABLE
             #ViewCols;
    END;
CREATE TABLE #ViewCols (
             obj_name nvarchar (101) 
           , dep_obj nvarchar (101) 
           , col_name nvarchar (101)) ;

/************************************************
Get the BASE VIEW columns and store in temp table
***********************************************
*/

INSERT INTO #ViewCols
SELECT
       obj_name = SUBSTRING (OBJECT_NAME (d.id) , 1 , 100) 
     , dep_obj = SUBSTRING (OBJECT_NAME (d.depid) , 1 , 100) 
     , col_name = SUBSTRING (name , 1 , 100) 
       FROM
            sysdepends AS d
                JOIN syscolumns AS c
                ON d.depid = c.id
               AND d.depnumber = c.colid
  WHERE OBJECT_NAME (d.id) = @ViewName;

/************************************************************************
SELECT * FROM #ViewCols;
DECLARE @ViewName nvarchar (100) = 'view_EDW_HealthAssesmentDeffinition';
SELECT * FROM temp_ViewObjects WHERE OwnerObject = @ViewName;
*/

IF EXISTS (SELECT
                  name
                  FROM tempdb.dbo.sysobjects
             WHERE ID = OBJECT_ID (N'tempdb..#BaseCols')) 
    BEGIN
        PRINT 'Dropping #ViewCols';
        DROP TABLE
             #BaseCols;
    END;
CREATE TABLE #BaseCols (
             OwnerObject nvarchar (101) 
           , Objectname nvarchar (101)) ;

/************************************************************************************************
select * from temp_ViewObjects where OwnerObject = 'view_EDW_HealthAssesmentDeffinition'
select * from #ViewCols
select * from #BaseCols		
SELECT * FROM INFORMATION_SCHEMA.TABLES where table_name = 'view_EDW_HealthAssesmentDeffinition';
DECLARE @ViewName nvarchar (100) = 'view_EDW_HealthAssesmentDeffinition';
*/

INSERT INTO #BaseCols
SELECT
       OBJS.ObjectName
     , COLS.col_name
       FROM
            temp_ViewObjects AS OBJS
                JOIN #ViewCols AS COLS
                ON COLS.obj_name = OBJS.ObjectName
               AND OBJS.OwnerObject = 'view_EDW_HealthAssesmentDeffinition'

/****************************
where OwnerObject = @ViewName
*/

  WHERE OBJS.ObjectName IN (
    SELECT
           name
    FROM sys.tables
        ) 
    AND OwnerObject = @ViewName
  ORDER BY
           ObjectName , col_name;

/************************************************************************
Setup to build the CHANGE TRACKING alter statements

***********************************************************************
DECLARE @ViewName nvarchar (100) = 'view_EDW_HealthAssesmentDeffinition';
select distinct objectname from temp_ViewObjects
join sys.tables on name = objectname
where OwnerObject = @ViewName ;
***********************************************************************
*/

DECLARE
   @stxt AS nvarchar (2000) = '';
DECLARE DB_CURSOR CURSOR LOCAL
    FOR SELECT DISTINCT
               objectname
               FROM
        temp_ViewObjects
            JOIN sys.tables
            ON name = objectname;
--WHERE [OwnerObject] = @ViewName;

/***********************
Process the base columns
**********************
*/

DECLARE
   @prevobj AS nvarchar (200) = '';
DECLARE
   @DepObj AS nvarchar (200) ;
DECLARE
   @stext AS nvarchar (2000) ;
DECLARE
   @ckText AS nvarchar (2000) = '';
OPEN db_cursor;
FETCH NEXT FROM db_cursor INTO @DepObj;
WHILE @@FETCH_STATUS = 0
    BEGIN
        SET @ckText = '';
        SET @ckText = @ckText + 'IF not EXISTS (SELECT ' + CHAR (10) ;
        SET @ckText = @ckText + '     [sys].[tables].[name] AS [Table_name] ' + CHAR (10) ;
        SET @ckText = @ckText + '     FROM ' + CHAR (10) ;
        SET @ckText = @ckText + '        [sys].[change_tracking_tables] ' + CHAR (10) ;
        SET @ckText = @ckText + '                JOIN [sys].[tables] ' + CHAR (10) ;
        SET @ckText = @ckText + '                    ON [sys].[tables].object_id = [sys].[change_tracking_tables].object_id ' + CHAR (10) ;
        SET @ckText = @ckText + '				JOIN [sys].[schemas] ' + CHAR (10) ;
        SET @ckText = @ckText + '				    ON [sys].[schemas].schema_id = [sys].[tables].schema_id ' + CHAR (10) ;
        SET @ckText = @ckText + '		 WHERE [sys].[tables].[name] = ''' + @DepObj + ''') ' + CHAR (10) ;
        SET @ckText = @ckText + '  BEGIN ' + CHAR (10) ;
        SET @ckText = @ckText + '     PRINT (''ADDING Change Tracking to ' + @DepObj + ''' ) ;' + CHAR (10) ;
        SET @ckText = @ckText + '        alter table dbo.' + @DepObj + ' ' + CHAR (10) ;
        SET @ckText = @ckText + '              ENABLE CHANGE_TRACKING ' + CHAR (10) ;
        SET @ckText = @ckText + '                  WITH (TRACK_COLUMNS_UPDATED = ON) ; ' + CHAR (10) ;
        SET @ckText = @ckText + '  END; ' + CHAR (10) ;

        PRINT @ckText;

        SET @stext = 'alter table dbo.' + @DepObj + ' ';
        SET @stext = @stext + 'ENABLE CHANGE_TRACKING ';
        SET @stext = @stext + 'WITH (TRACK_COLUMNS_UPDATED = ON) ; ';
        SET @stext = @stext + 'PRINT ''Change Tracking turned on for ''' + @DepObj + ' ; ';

        IF EXISTS (SELECT
                          sys.tables.name AS Table_name
                          FROM
                   sys.change_tracking_tables
                       JOIN sys.tables
                       ON sys.tables.object_id = sys.change_tracking_tables.object_id
                       JOIN sys.schemas
                       ON sys.schemas.schema_id = sys.tables.schema_id
                     WHERE sys.tables.name = @DepObj) 
            BEGIN
                PRINT
                '--** CHANGE TRACKING ALREADY in place for ' + @DepObj;
            END;
        ELSE
            BEGIN
                PRINT
                '--ENABLING change tracking for ' + @DepObj;
            --PRINT @stext;
            END;
        FETCH NEXT FROM db_cursor INTO @DepObj;
    END;
CLOSE db_cursor;
DEALLOCATE db_cursor;

DECLARE DB_CURSOR2 CURSOR LOCAL
    FOR SELECT DISTINCT
               objectname
               FROM
        temp_ViewObjects
            JOIN sys.tables
            ON name = objectname;
--WHERE [OwnerObject] = @ViewName;

/***************************************************
SET @stext = 'AND ( ' ; -- + CHAR (10) + CHAR (13) ;
*/

SET @stext = '--***************************************************** ';

/**********************************
DECLARE @stext AS nvarchar (2000) ;
*/

PRINT @stext;
DECLARE
   @PKCOL AS nvarchar (200) ;
DECLARE
   @loopcnt AS int = 0;
OPEN DB_CURSOR2;
FETCH NEXT FROM DB_CURSOR2 INTO @DepObj;
WHILE @@FETCH_STATUS = 0
    BEGIN

/**********************************************************************************************************************
LEFT OUTER JOIN CHANGETABLE (CHANGES [CMS_User] , NULL) AS [CT_CMS_User] ON [CMSUser].[UserID] = [CT_CMS_User].[UserID]
*/

        SET @loopcnt = @loopcnt + 1;
        SET @PKCOL = (SELECT
                             column_name AS PK_COL
                             FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
                        WHERE OBJECTPROPERTY (OBJECT_ID (constraint_name) , 'IsPrimaryKey') = 1
                          AND table_name = @depObj) ;

/**************************************************************************************************************************************************************************
SET @stext = ' ' + @DepObj + '.' + @PKCOL + ' in (SELECT [CT].[' + @PKCOL + '] FROM CHANGETABLE (CHANGES [' + @depObj + '] , NULL) AS [CT])' ; -- + CHAR (10) + CHAR (13) ;
*/

        SET @stext = '    LEFT OUTER JOIN CHANGETABLE (CHANGES [' + @DepObj + '] , NULL) AS [CT_' + @DepObj + '] ' + CHAR (10) + '        ON XX_' + @DepObj + '.[' + @PKCOL + '] = [CT_' + @DepObj + '].[' + @PKCOL + ']';
        IF EXISTS (SELECT
                          sys.tables.name AS Table_name
                          FROM
                   sys.change_tracking_tables
                       JOIN sys.tables
                       ON sys.tables.object_id = sys.change_tracking_tables.object_id
                       JOIN sys.schemas
                       ON sys.schemas.schema_id = sys.tables.schema_id
                     WHERE sys.tables.name = @DepObj) 
            BEGIN
                PRINT @stext;
            END;
        FETCH NEXT FROM DB_CURSOR2 INTO @DepObj;
    END;

SET @stext = '--***************************************************** ';
PRINT @stext;

CLOSE DB_CURSOR2;
DEALLOCATE DB_CURSOR2;

DECLARE DB_CURSOR3 CURSOR LOCAL
    FOR SELECT DISTINCT
               objectname
               FROM
        temp_ViewObjects
            JOIN sys.tables
            ON name = objectname;
--WHERE [OwnerObject] = @ViewName;
SET @stext = '--********************************************';

/**********************************
DECLARE @stext AS nvarchar (2000) ;
*/

PRINT @stext;

/*********************************
DECLARE @PKCOL AS nvarchar (200) ;
*/

SET @loopcnt = 0;
OPEN DB_CURSOR3;
FETCH NEXT FROM DB_CURSOR3 INTO @DepObj;
WHILE @@FETCH_STATUS = 0
    BEGIN
        SET @loopcnt = @loopcnt + 1;
        SET @PKCOL = (SELECT
                             column_name AS PK_COL
                             FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
                        WHERE OBJECTPROPERTY (OBJECT_ID (constraint_name) , 'IsPrimaryKey') = 1
                          AND table_name = @depObj) ;
        SET @stext = '     ' + ', CT_' + @DepObj + '.' + @PKCOL + ' AS ' + @DepObj + '_CtID';

        IF EXISTS (SELECT
                          sys.tables.name AS Table_name
                          FROM
                   sys.change_tracking_tables
                       JOIN sys.tables
                       ON sys.tables.object_id = sys.change_tracking_tables.object_id
                       JOIN sys.schemas
                       ON sys.schemas.schema_id = sys.tables.schema_id
                     WHERE sys.tables.name = @DepObj) 
            BEGIN
                PRINT @stext;
                SET @stext = '        , CT_' + @depObj + '.SYS_CHANGE_VERSION AS ' + @depObj + '_SCV';
                PRINT @stext;
            END;
        FETCH NEXT FROM DB_CURSOR3 INTO @DepObj;
    END;

SET @stext = '--********************************************';
PRINT @stext;

CLOSE DB_CURSOR3;
DEALLOCATE DB_CURSOR3;

DECLARE DB_CURSOR4 CURSOR LOCAL
    FOR SELECT DISTINCT
               objectname
               FROM
        temp_ViewObjects
            JOIN sys.tables
            ON name = objectname;
--WHERE [OwnerObject] = @ViewName;
SET @stext = '--********************************************';
PRINT @stext;
SET @stext = '    WHERE (';
PRINT @stext;
SET @loopcnt = 0;
OPEN DB_CURSOR4;
FETCH NEXT FROM DB_CURSOR4 INTO @DepObj;
WHILE @@FETCH_STATUS = 0
    BEGIN

        SET @loopcnt = @loopcnt + 1;
        SET @PKCOL = (SELECT
                             column_name AS PK_COL
                             FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
                        WHERE OBJECTPROPERTY (OBJECT_ID (constraint_name) , 'IsPrimaryKey') = 1
                          AND table_name = @depObj) ;

        IF @loopcnt = 1
            BEGIN
                SET @stext = '     CT_' + @DepObj + '.' + @PKCOL + '_CtID IS NOT NULL ';
            END;
        ELSE
            BEGIN
                SET @stext = '     OR CT_' + @DepObj + '.' + @PKCOL + '_CtID IS NOT NULL ';
            END;
        BEGIN

            IF EXISTS (SELECT
                              sys.tables.name AS Table_name
                              FROM
                       sys.change_tracking_tables
                           JOIN sys.tables
                           ON sys.tables.object_id = sys.change_tracking_tables.object_id
                           JOIN sys.schemas
                           ON sys.schemas.schema_id = sys.tables.schema_id
                         WHERE sys.tables.name = @DepObj) 
                BEGIN
                    PRINT @stext;
                END;
            FETCH NEXT FROM DB_CURSOR4 INTO @DepObj;
        END;
    END;
SET @stext = '    )';
PRINT @stext;
SET @stext = '--********************************************';
PRINT @stext;

CLOSE DB_CURSOR4;
DEALLOCATE DB_CURSOR4;

DECLARE DB_CURSOR5 CURSOR LOCAL
    FOR SELECT DISTINCT
               objectname
               FROM
        temp_ViewObjects
            JOIN sys.tables
            ON name = objectname;
--WHERE [OwnerObject] = @ViewName;

/***************************************
**********************
Process the base columns
**********************

DECLARE @prevobj AS nvarchar (200) = '';
DECLARE @DepObj AS nvarchar (200) ;
DECLARE @stext AS nvarchar (2000) ;
declare @ckText as nvarchar(2000) = '' ;
*/

OPEN DB_CURSOR5;
FETCH NEXT FROM DB_CURSOR5 INTO @DepObj;
WHILE @@FETCH_STATUS = 0
    BEGIN
        PRINT
        '-- PROCESSING: ' + @DepObj + CHAR (10) ;
        SET @PKCOL = (SELECT
                             column_name AS PK_COL
                             FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
                        WHERE OBJECTPROPERTY (OBJECT_ID (constraint_name) , 'IsPrimaryKey') = 1
                          AND table_name = @depObj) ;

        SET @ckText = '';
        SET @ckText = @ckText + 'if exists (select name from sys.tables where name = ''' + 'CT_' + @DepObj + ''') ' + CHAR (10) ;
        SET @ckText = @ckText + 'BEGIN ' + CHAR (10) ;
        SET @ckText = @ckText + '    drop table CT_' + @DepObj + '; ' + CHAR (10) ;
        SET @ckText = @ckText + 'END ' + CHAR (10) ;
        SET @ckText = @ckText + 'SELECT distinct CT.' + @PKCOL + ' into CT_' + @DepObj + ' FROM CHANGETABLE(CHANGES [' + @DepObj + '], NULL) AS CT; ' + CHAR (10) ;
        SET @ckText = @ckText + 'ALTER TABLE [CT_' + @DepObj + '] ADD  CONSTRAINT [PK_CT_' + @DepObj + '] PRIMARY KEY CLUSTERED (	[' + @PKCOL + '] ASC ); ' + CHAR (10) ;

        PRINT @ckText;

        FETCH NEXT FROM DB_CURSOR5 INTO @DepObj;
    END;
CLOSE DB_CURSOR5;
DEALLOCATE DB_CURSOR5;

