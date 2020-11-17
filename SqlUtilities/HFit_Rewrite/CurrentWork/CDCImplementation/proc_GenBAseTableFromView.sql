
-- use KenticoCMS_datamart_2
GO
PRINT 'executing proc_GenBaseTableFromView.sql';
GO

IF EXISTS (SELECT
                  name
           FROM sys.procedures
           WHERE
                  name = 'proc_GenBaseTableFromView') 
    BEGIN
        DROP PROCEDURE
             proc_GenBaseTableFromView;
    END;
GO

/****************************************************************************************************************************************
-----------------------------------------------------------------------------------------------------------------------------------------
--use KenticoCMS_Datamart_2
go
    exec proc_GenBaseTableFromView 
	   @DBNAME='KenticoCMS_3'
	   , @ViewName='View_CMS_Tree_Joined'
	   , @PreviewOnly = 'no'
	   , @GenJobToExecute = 1
	   , @SkipIfExists = 0
	   , @LinkedSvrName = null

    exec proc_GenBaseTableFromView 
	   @DBNAME='KenticoCMS_3'
	   , @ViewName='View_CMS_Tree_Joined'
	   , @PreviewOnly = 'no'
	   , @GenJobToExecute = 1
	   , @SkipIfExists = 1
	   , @LinkedSvrName = null

    exec proc_GenBaseTableFromView 
	   @DBNAME='KenticoCMS_3'
	   , @ViewName='View_CMS_Tree_Joined'
	   , @PreviewOnly = 'no'
	   , @GenJobToExecute = 1
	   , @SkipIfExists = 1
	   , @LinkedSvrName = null

 exec proc_GenBaseTableFromView 'KenticoCMS_1', 'View_CMS_Tree_Joined', 'no', 0, 0, null
 exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_CMS_Tree_Joined', 'no', 0, 0, null
 exec proc_GenBaseTableFromView 'KenticoCMS_3', 'View_CMS_Tree_Joined', 'no', 0, 0, null
****************************************************************************************************************************************/

CREATE PROCEDURE proc_GenBaseTableFromView (
       @DBNAME AS NVARCHAR (250) 
     ,@ViewName AS NVARCHAR (250) 
     ,@PreviewOnly AS NVARCHAR (5) = 'no'
     ,@GenJobToExecute AS INT = 1
     ,@SkipIfExists AS INT = 0
	,@LinkedSvrName as nvarchar(100) = null) 
AS
BEGIN

/**********************************************************************************************************************
---------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
@Copyright  D. Miller & Associates, Ltd., Highland Park, IL, 1.1.1960 allrights reserved.
License:	  This procedure can be used freely as long as the copyright and this header
		  are preserved.

Author:	  W. Dale Miller
Date:	  4-2-2013
Purpose:	  Generate a set of change tracking routines and BASE table based on a view. 
		  This is advantageous when views' performance is an issue or views have multiple 
		  levels of nesting.

		  Based on the DMA, Ltd. SQL Server Gen Utilities(tm) 

Parms:	  @DBNAME - the instance name containing the view and from which to PULL the data.
		  @ViewName - name of view to be processed.
		  @PreviewOnly - set to 1 if all that is wanted is to view the generated code and 
					  specifically NOT to execute it.
		  @GenJobToExecute - Must be set to 1 to create the JOB thats runs this procedure
					   on a schedule
		  @SkipIfExists - IF set to 1 and the tgt view has been previously processed and 
					   the BASE table already exists, the proc will immediately exit.
		  @LinkedSvrName - If the view is pulled from a Linked Server, provide the linked 
					    server's name here.

Usage:
    USE THIS TO CONVERT INDIVIDUAL VIEWS:
    exec proc_GenBaseTableFromView 'KenticoCMS_1', 'View_EDW_HealthAssesmentQuestions', 'no', @GenJobToExecute = 0, @SkipIfExists = 1
    exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_EDW_HealthAssesmentQuestions', 'no', @GenJobToExecute = 1, @SkipIfExists = 1
    exec proc_GenBaseTableFromView 'KenticoCMS_3', 'View_EDW_HealthAssesmentQuestions', 'no', @GenJobToExecute = 1, @SkipIfExists = 1
**********************************************************************************************************************/

    --Uncomment to troubleshoot
    --DECLARE @DBNAME AS NVARCHAR (250) = 'KenticoCMS_2', @ViewName AS NVARCHAR (250) = 'View_CMS_Tree_Joined', @PreviewOnly AS NVARCHAR (5) = 'YES'

    IF
       CURSOR_STATUS ('global' , 'CursorHashCols') >= -1
        BEGIN
            CLOSE CursorHashCols;
            DEALLOCATE CursorHashCols;
        END;
    IF
           CURSOR_STATUS ('global' , 'CursorViewCols') >= -1
        BEGIN
            CLOSE CursorViewCols;
            DEALLOCATE CursorViewCols;
        END;
    IF
           CURSOR_STATUS ('global' , 'CursorCreateTable') >= -1
        BEGIN
            CLOSE CursorCreateTable;
            DEALLOCATE CursorCreateTable;
        END;
    IF
           CURSOR_STATUS ('global' , 'InsertIntoCols') >= -1
        BEGIN
            CLOSE InsertIntoCols;
            DEALLOCATE InsertIntoCols;
        END;

    DECLARE
    @TABLE_CATALOG NVARCHAR (250) 
  ,@TABLE_SCHEMA AS NVARCHAR (250) 
  ,@TABLE_NAME AS NVARCHAR (250) 
  ,@COLUMN_NAME AS NVARCHAR (250) 
  ,@ORDINAL_POSITION AS INT
  ,@IS_NULLABLE AS NVARCHAR (50) 
  ,@DATA_TYPE AS NVARCHAR (250) 
  ,@CHARACTER_MAXIMUM_LENGTH AS INT
  ,@NUMERIC_PRECISION AS INT
  ,@NUMERIC_SCALE AS INT
  ,@MySql AS NVARCHAR (MAX) = ''
  ,@InsertNewDDL AS NVARCHAR (MAX) = ''
  ,@InsertIntoDDL AS NVARCHAR (MAX) = ''
  ,@DeleteDDL AS NVARCHAR (MAX) = ''
  ,@SelectCols AS NVARCHAR (MAX) = ''
  ,@ViewCols AS NVARCHAR (MAX) = ''
  ,@Tbl_DLL AS NVARCHAR (MAX) = ''
  ,@HashCols AS NVARCHAR (MAX) = ''
  ,@HashStmt AS NVARCHAR (MAX) = '     CAST (HASHBYTES (''SHA1'', XX '
  ,@COLS AS NVARCHAR (MAX) = ''
  ,@BTCOLS AS NVARCHAR (MAX) = ''
  ,@BaseTblName AS NVARCHAR (100) = 'BASE_' + @ViewName
  ,@TrigName AS NVARCHAR (250) 
  ,@TempTbl AS NVARCHAR (250) 
  ,@MasterDB AS NVARCHAR (250) = DB_NAME () 
  ,@ParentTable AS NVARCHAR (250) = ''
  ,@ChildTable AS NVARCHAR (250) = '';

    IF
           @SkipIfExists = 1
        BEGIN
            IF EXISTS (SELECT
                              table_name
                       FROM information_schema.tables
                       WHERE
                              table_name = @BaseTblName) 
                BEGIN
                    PRINT @BaseTblName + ' already exists, will NOT re-create. ';
                END;
        END;
    ELSE
        BEGIN
            IF
                   @SkipIfExists = 0
                BEGIN
                    IF EXISTS (SELECT
                                      table_name
                               FROM information_schema.tables
                               WHERE
                                      table_name = @BaseTblName) 
                        BEGIN
                            PRINT 'DROPPING and recreating ' + @BaseTblName;
                            SET @MySql = 'drop table ' + @BaseTblName;
                            EXEC (@MySql) ;
                        END;
                    IF EXISTS (SELECT
                                      table_name
                               FROM information_schema.tables
                               WHERE
                                      table_name = @BaseTblName + '_DEL') 
                        BEGIN
                            PRINT 'DROPPING and recreating ' + @BaseTblName + '_DEL';
                            SET @MySql = 'drop table ' + @BaseTblName + '_DEL';
                            EXEC (@MySql) ;
                        END;
                END;
        END;

    SET @TempTbl = '#TEMP_' + @ViewName + '_' + @Dbname;

    SET @MySql = 'declare CursorHashCols CURSOR ' + CHAR (10) ;
    SET @MySql = @MySql + '    FOR  ' + CHAR (10) ;
    SET @MySql = @MySql + '            SELECT ' + CHAR (10) ;
    SET @MySql = @MySql + '                   TABLE_CATALOG ' + CHAR (10) ;
    SET @MySql = @MySql + '                 , TABLE_SCHEMA ' + CHAR (10) ;
    SET @MySql = @MySql + '                 , TABLE_NAME ' + CHAR (10) ;
    SET @MySql = @MySql + '                 , COLUMN_NAME ' + CHAR (10) ;
    SET @MySql = @MySql + '                 , ORDINAL_POSITION ' + CHAR (10) ;
    SET @MySql = @MySql + '                 , IS_NULLABLE ' + CHAR (10) ;
    SET @MySql = @MySql + '                 , DATA_TYPE ' + CHAR (10) ;
    SET @MySql = @MySql + '                 , CHARACTER_MAXIMUM_LENGTH ' + CHAR (10) ;
    SET @MySql = @MySql + '                 , NUMERIC_PRECISION ' + CHAR (10) ;
    SET @MySql = @MySql + '                 , NUMERIC_SCALE ' + CHAR (10) ;
    if @LinkedSvrName is not null
	   SET @MySql = @MySql + '            FROM ' + @LinkedSvrName+'.'+@DBNAME + '.information_schema.columns ' + CHAR (10) ;   
    else
	   SET @MySql = @MySql + '            FROM ' + @DBNAME + '.information_schema.columns ' + CHAR (10) ;
    SET @MySql = @MySql + '            WHERE ' + CHAR (10) ;
    SET @MySql = @MySql + '                   table_name = ''' + @ViewName + ''' and TABLE_CATALOG = ''' + @DBNAME + '''' + CHAR (10) ;

    --Get ALL columns from Parent DB Table
    EXEC (@MySql) ;

    OPEN CursorHashCols;

    FETCH NEXT FROM CursorHashCols INTO @TABLE_CATALOG , @TABLE_SCHEMA , @TABLE_NAME , @COLUMN_NAME , @ORDINAL_POSITION , @IS_NULLABLE , @DATA_TYPE , @CHARACTER_MAXIMUM_LENGTH , @NUMERIC_PRECISION , @NUMERIC_SCALE;

    WHILE
           @@FETCH_STATUS = 0
        BEGIN
            IF
                   @DATA_TYPE = 'datetime' OR
                   @DATA_TYPE = 'datetime2'
                BEGIN
                    SET @HashCols = @HashCols + '       ISNULL (CAST ([' + @COLUMN_NAME + '] AS nvarchar (250)) , ''01-01-1960'') + ' + CHAR (10) ;
                END;
            ELSE
                BEGIN
                    IF
                           @DATA_TYPE = 'varbinary'
                        BEGIN
                            PRINT 'Found varbinary, skipping ' + @COLUMN_NAME;
                        END;
                    ELSE
                        BEGIN
                            IF
                                   @DATA_TYPE = 'uniqueidentifier'
                                BEGIN
                                    SET @HashCols = @HashCols + '       ISNULL (CAST ([' + @COLUMN_NAME + '] AS nvarchar (250)) , ''00000000-0000-0000-0000-000000000000'') + ' + CHAR (10) ;
                                END;
                            ELSE
                                BEGIN
                                    IF
                                           @DATA_TYPE = 'nvarchar' OR
                                           @DATA_TYPE = 'varchar' OR
                                           @DATA_TYPE = 'char' OR
                                           @DATA_TYPE = 'nchar'
                                        BEGIN
                                            -- COALESCE (substring(Bio,1,1000), '-') +   
                                            IF
                                                   @CHARACTER_MAXIMUM_LENGTH < 0
                                                BEGIN
                                                    SET @HashCols = @HashCols + '       COALESCE (substring([' + @COLUMN_NAME + '],1,1000), ''-'') + ' + CHAR (10) ;
                                                END;
                                            ELSE
                                                BEGIN
                                                    SET @HashCols = @HashCols + '       ISNULL ([' + @COLUMN_NAME + '], ''-'') + ' + CHAR (10) ;
                                                END;
                                        END;
                                    ELSE
                                        BEGIN
                                            SET @HashCols = @HashCols + '       ISNULL (CAST ([' + @COLUMN_NAME + '] AS nvarchar (250)) , ''-'') + ' + CHAR (10) ;
                                        END;
                                END;
                        END;
                END;
            FETCH NEXT FROM CursorHashCols INTO @TABLE_CATALOG , @TABLE_SCHEMA , @TABLE_NAME , @COLUMN_NAME , @ORDINAL_POSITION , @IS_NULLABLE , @DATA_TYPE , @CHARACTER_MAXIMUM_LENGTH , @NUMERIC_PRECISION , @NUMERIC_SCALE;

        END;

    SET @HashCols = REVERSE (@HashCols) ;
    SET @HashCols = LTRIM (RTRIM (@HashCols)) ;

    DECLARE
    @i AS BIGINT = 0;

    SET @i = CHARINDEX ('+' , @HashCols) ;
    SET @HashCols = SUBSTRING (@HashCols , @i + 1 , DATALENGTH (@HashCols)) ;
    SET @HashCols = REVERSE (@HashCols) ;

    --ISNULL (ClassDisplayName, '-')) as nvarchar(100)) as XX
    SET @HashCols = @HashCols + ' ) as nvarchar(100)) as HashCode ' + CHAR (10) ;
    CLOSE CursorHashCols;
    DEALLOCATE CursorHashCols;
    SET @HashStmt = REPLACE (@HashStmt , 'XX' , @HashCols) ;

    IF
           @PreviewOnly = 'YES'
        BEGIN
            SELECT
                   @HashStmt AS HashStmt;
        END;
    --***********************************************************************************
    SET @MySql = 'declare InsertIntoCols CURSOR ' + CHAR (10) ;
    SET @MySql = @MySql + '    FOR  ' + CHAR (10) ;
    SET @MySql = @MySql + '            SELECT ' + CHAR (10) ;
    SET @MySql = @MySql + '                   TABLE_CATALOG ' + CHAR (10) ;
    SET @MySql = @MySql + '                 , TABLE_SCHEMA ' + CHAR (10) ;
    SET @MySql = @MySql + '                 , TABLE_NAME ' + CHAR (10) ;
    SET @MySql = @MySql + '                 , COLUMN_NAME ' + CHAR (10) ;
    SET @MySql = @MySql + '                 , ORDINAL_POSITION ' + CHAR (10) ;
    SET @MySql = @MySql + '                 , IS_NULLABLE ' + CHAR (10) ;
    SET @MySql = @MySql + '                 , DATA_TYPE ' + CHAR (10) ;
    SET @MySql = @MySql + '                 , CHARACTER_MAXIMUM_LENGTH ' + CHAR (10) ;
    SET @MySql = @MySql + '                 , NUMERIC_PRECISION ' + CHAR (10) ;
    SET @MySql = @MySql + '                 , NUMERIC_SCALE ' + CHAR (10) ;
    if @LinkedSvrName is not null
	   SET @MySql = @MySql + '            FROM ' + @LinkedSvrName+'.'+@DBNAME + '.information_schema.columns ' + CHAR (10) ;   
    else	  
	   SET @MySql = @MySql + '            FROM ' + @DBNAME + '.information_schema.columns ' + CHAR (10) ;
    SET @MySql = @MySql + '            WHERE ' + CHAR (10) ;
    SET @MySql = @MySql + '                   table_name = ''' + @ViewName + ''' and TABLE_CATALOG = ''' + @DBNAME + '''' + CHAR (10) ;
    EXEC (@MySql) ;

    OPEN InsertIntoCols;

    FETCH NEXT FROM InsertIntoCols INTO @TABLE_CATALOG , @TABLE_SCHEMA , @TABLE_NAME , @COLUMN_NAME , @ORDINAL_POSITION , @IS_NULLABLE , @DATA_TYPE , @CHARACTER_MAXIMUM_LENGTH , @NUMERIC_PRECISION , @NUMERIC_SCALE;

    SET @InsertIntoDDL = '';
    SET @InsertIntoDDL = @InsertIntoDDL + 'Declare @NbrRecs bigint = 0 ;' + CHAR (10) ;
    SET @InsertIntoDDL = @InsertIntoDDL + 'If @ReloadAll = 1 ' + CHAR (10) ;
    SET @InsertIntoDDL = @InsertIntoDDL + 'BEGIN' + CHAR (10) ;
    SET @InsertIntoDDL = @InsertIntoDDL + 'DELETE from ' + @BaseTblName + ' where DBNAME = ''' + @DBNAME + ''' ;' + CHAR (10) ;

    SET @InsertNewDDL = @InsertNewDDL + 'SET @NbrRecs = @@ROWCOUNT; ';
    SET @InsertNewDDL = @InsertNewDDL + 'PRINT ''#DELETED: '' + CAST (@NbrRecs AS NVARCHAR (50)) + '' records in ' + @BaseTblName + ' ''; ' + CHAR (10) ;

    SET @InsertIntoDDL = @InsertIntoDDL + 'INSERT INTO ' + @BaseTblName + ' (' + CHAR (10) ;
    SET @SelectCols = '  SELECT ' + CHAR (10) ;

    WHILE
           @@FETCH_STATUS = 0
        BEGIN
            SET @InsertIntoDDL = @InsertIntoDDL + '       ' + '[' + @COLUMN_NAME + '], ' + CHAR (10) ;
            SET @COLS = @COLS + '       [' + @COLUMN_NAME + '], ' + CHAR (10) ;
            SET @BTCOLS = @BTCOLS + 'BT.[' + @COLUMN_NAME + '], ' + CHAR (10) ;

            FETCH NEXT FROM InsertIntoCols INTO @TABLE_CATALOG , @TABLE_SCHEMA , @TABLE_NAME , @COLUMN_NAME , @ORDINAL_POSITION , @IS_NULLABLE , @DATA_TYPE , @CHARACTER_MAXIMUM_LENGTH , @NUMERIC_PRECISION , @NUMERIC_SCALE;

        END;

    if @LinkedSvrName is not null	  
	   SET @SelectCols = @SelectCols + @COLS + ' @@Servername as SVR, ''' + @DBNAME + ''' as DBNAME, ' + @hashStmt + ' FROM ' + @LinkedSvrName + '.' + @DBNAME + '.dbo.' + @ViewName + CHAR (10) ;
    else	   
	   SET @SelectCols = @SelectCols + @COLS + ' @@Servername as SVR, ''' + @DBNAME + ''' as DBNAME, ' + @hashStmt + ' FROM ' + @DBNAME + '.dbo.' + @ViewName + CHAR (10) ;

    IF
           @PreviewOnly = 'YES'
        BEGIN
            SELECT
                   @SelectCols AS SelectCols;
            SELECT
                   @COLS AS COLS;
        END;

    SET @InsertIntoDDL = REVERSE (@InsertIntoDDL) ;
    SET @InsertIntoDDL = LTRIM (RTRIM (@InsertIntoDDL)) ;
    SET @i = CHARINDEX (',' , @InsertIntoDDL) ;
    SET @InsertIntoDDL = SUBSTRING (@InsertIntoDDL , @i + 1 , DATALENGTH (@InsertIntoDDL)) ;
    SET @InsertIntoDDL = REVERSE (@InsertIntoDDL) ;

    SET @InsertIntoDDL = @InsertIntoDDL + ', SVR, DBNAME, HashCode' + CHAR (10) ;
    SET @InsertIntoDDL = @InsertIntoDDL + ')' + CHAR (10) ;

    SET @InsertIntoDDL = @InsertIntoDDL + @SelectCols + CHAR (10) ;
    SET @InsertIntoDDL = @InsertIntoDDL + 'RETURN ;';
    SET @InsertIntoDDL = @InsertIntoDDL + 'END ;    --Begin';
    CLOSE InsertIntoCols;
    DEALLOCATE InsertIntoCols;

    IF
           @PreviewOnly = 'YES'
        BEGIN
            SELECT
                   @InsertIntoDDL AS InsertIntoDDL;
        END;
    --***********************************************************************************
    SET @DeleteDDL = '-- Remove all records from the BASE table that are not in or are different than the CURRENT records in the view ' + CHAR (10) ;
    --SET @DeleteDDL = @DeleteDDL + 'delete from ' + @BaseTblName + char (10) ;
    --SET @DeleteDDL = @DeleteDDL + 'where DBNAME = ''' + @DBNAME + '''' + char (10) ;
    --SET @DeleteDDL = @DeleteDDL + 'and HashCode not in (Select HashCode from ' + @TempTbl + ') ;' + char (10) ;

    SET @DeleteDDL = @DeleteDDL + 'WITH CTE (DBNAME , ' + CHAR (10) ;
    SET @DeleteDDL = @DeleteDDL + '   HashCode)  ' + CHAR (10) ;
    SET @DeleteDDL = @DeleteDDL + '   AS (SELECT DBNAME , HashCode  ' + CHAR (10) ;
    SET @DeleteDDL = @DeleteDDL + '         FROM ' + @BaseTblName + CHAR (10) ;
    SET @DeleteDDL = @DeleteDDL + '         where DBNAME  = ''' + @DBNAME + '''' + CHAR (10) ;
    SET @DeleteDDL = @DeleteDDL + '   EXCEPT' + CHAR (10) ;
    SET @DeleteDDL = @DeleteDDL + '   SELECT DBNAME , HashCode ' + CHAR (10) ;
    SET @DeleteDDL = @DeleteDDL + '   FROM ' + @TempTbl + ')  ' + CHAR (10) ;
    SET @DeleteDDL = @DeleteDDL + 'delete B ' + CHAR (10) ;
    SET @DeleteDDL = @DeleteDDL + 'FROM ' + @BaseTblName + ' as B ' + CHAR (10) ;
    SET @DeleteDDL = @DeleteDDL + 'inner join CTE as C	    ' + CHAR (10) ;
    SET @DeleteDDL = @DeleteDDL + 'on C.DBNAME = B.DBNAME ' + CHAR (10) ;
    SET @DeleteDDL = @DeleteDDL + 'and B.HashCode = C.HashCode ;' + CHAR (10) ;
    SET @DeleteDDL = @DeleteDDL + 'SET @NbrRecs = @@ROWCOUNT; ';
    SET @DeleteDDL = @DeleteDDL + 'PRINT ''#REMOVED: '' + CAST (@NbrRecs AS NVARCHAR (50)) + '' records in ' + @BaseTblName + ' ''; ' + CHAR (10) ;

    IF
           @PreviewOnly = 'YES'
        BEGIN
            SELECT
                   @DeleteDDL AS DeleteDDL;
        END;
    --***********************************************************************************
    SET @MySql = 'declare CursorViewCols CURSOR ' + CHAR (10) ;
    SET @MySql = @MySql + '    FOR  ' + CHAR (10) ;
    SET @MySql = @MySql + '            SELECT ' + CHAR (10) ;
    SET @MySql = @MySql + '                   TABLE_CATALOG ' + CHAR (10) ;
    SET @MySql = @MySql + '                 , TABLE_SCHEMA ' + CHAR (10) ;
    SET @MySql = @MySql + '                 , TABLE_NAME ' + CHAR (10) ;
    SET @MySql = @MySql + '                 , COLUMN_NAME ' + CHAR (10) ;
    SET @MySql = @MySql + '                 , ORDINAL_POSITION ' + CHAR (10) ;
    SET @MySql = @MySql + '                 , IS_NULLABLE ' + CHAR (10) ;
    SET @MySql = @MySql + '                 , DATA_TYPE ' + CHAR (10) ;
    SET @MySql = @MySql + '                 , CHARACTER_MAXIMUM_LENGTH ' + CHAR (10) ;
    SET @MySql = @MySql + '                 , NUMERIC_PRECISION ' + CHAR (10) ;
    SET @MySql = @MySql + '                 , NUMERIC_SCALE ' + CHAR (10) ;
    if @LinkedSvrName is not null	  
	   SET @MySql = @MySql + '            FROM ' + @LinkedSvrName + '.' + @DBNAME + '.information_schema.columns ' + CHAR (10) ;
    else	   	   
	   SET @MySql = @MySql + '            FROM ' + @DBNAME + '.information_schema.columns ' + CHAR (10) ;
    SET @MySql = @MySql + '            WHERE ' + CHAR (10) ;
    SET @MySql = @MySql + '                   table_name = ''' + @ViewName + ''' and TABLE_CATALOG = ''' + @DBNAME + '''' + CHAR (10) ;
    EXEC (@MySql) ;

    OPEN CursorViewCols;

    FETCH NEXT FROM CursorViewCols INTO @TABLE_CATALOG , @TABLE_SCHEMA , @TABLE_NAME , @COLUMN_NAME , @ORDINAL_POSITION , @IS_NULLABLE , @DATA_TYPE , @CHARACTER_MAXIMUM_LENGTH , @NUMERIC_PRECISION , @NUMERIC_SCALE;

    SET @InsertNewDDL = 'SELECT ' + CHAR (10) ;

    WHILE
           @@FETCH_STATUS = 0
        BEGIN
            --ISNULL (CAST (HAUSERSTARTED.ITEMID AS NVARCHAR (250)) , '-') + ISNULL (CAST (VHAJ.NODEGUID AS NVARCHAR (250)) , '-') 

            SET @SelectCols = @SelectCols + '       [' + @COLUMN_NAME + '], ' + CHAR (10) ;
            SET @InsertNewDDL = @InsertNewDDL + '       [' + @COLUMN_NAME + '], ' + CHAR (10) ;

            FETCH NEXT FROM CursorViewCols INTO @TABLE_CATALOG , @TABLE_SCHEMA , @TABLE_NAME , @COLUMN_NAME , @ORDINAL_POSITION , @IS_NULLABLE , @DATA_TYPE , @CHARACTER_MAXIMUM_LENGTH , @NUMERIC_PRECISION , @NUMERIC_SCALE;

        END;

    SET @InsertNewDDL = @InsertNewDDL + @HashStmt + CHAR (10) ;
    SET @InsertNewDDL = @InsertNewDDL + ', ''' + @DBNAME + ''' as DBNAME ' + CHAR (10) ;

    --SET @InsertNewDDL = @InsertNewDDL + ', getdate() as LastModifiedDate ' + char (10) ;

    SET @InsertNewDDL = @InsertNewDDL + 'into ' + @TempTbl + CHAR (10) ;
    if @LinkedSvrName is not null 
	   SET @InsertNewDDL = @InsertNewDDL + 'FROM ' + @LinkedSvrName + '.' + @DBNAME + '.dbo.' + @ViewName + CHAR (10) ;
    else
	   SET @InsertNewDDL = @InsertNewDDL + 'FROM ' + @DBNAME + '.dbo.' + @ViewName + CHAR (10) ;

    SET @InsertNewDDL = @InsertNewDDL + 'SET @NbrRecs = @@ROWCOUNT; ';
    SET @InsertNewDDL = @InsertNewDDL + 'PRINT ''PULLED: '' + CAST (@NbrRecs AS NVARCHAR (50)) + '' records from ' + @ViewName + ' ''; ' + CHAR (10) ;

    SET @InsertNewDDL = @InsertNewDDL + 'create index [IDX_' + @TempTbl + '_Hash] on ' + @TempTbl + CHAR (10) ;
    SET @InsertNewDDL = @InsertNewDDL + '( ' + CHAR (10) ;
    SET @InsertNewDDL = @InsertNewDDL + '	HashCode ' + CHAR (10) ;
    SET @InsertNewDDL = @InsertNewDDL + ') include (DBNAME) ;' + CHAR (10) + CHAR (10) ;

    SET @InsertNewDDL = @InsertNewDDL + CHAR (10) + 'INSERT DELETE DDL HERE' + CHAR (10) ;

    --SET @InsertNewDDL = @InsertNewDDL + 'Declare @NbrRecs as int = 0 ; ' + char (10) ;
    SET @InsertNewDDL = @InsertNewDDL + 'with CTE (DBNAME , HashCode ) ' + CHAR (10) ;
    SET @InsertNewDDL = @InsertNewDDL + 'as ( ' + CHAR (10) ;
    SET @InsertNewDDL = @InsertNewDDL + '    select DBNAME, HashCode ' + CHAR (10) ;
    SET @InsertNewDDL = @InsertNewDDL + '    from  ' + CHAR (10) ;
    SET @InsertNewDDL = @InsertNewDDL + '        ' + @TempTbl + CHAR (10) ;
    SET @InsertNewDDL = @InsertNewDDL + '    except  ' + CHAR (10) ;
    SET @InsertNewDDL = @InsertNewDDL + '    select DBNAME, HashCode ' + CHAR (10) ;
    SET @InsertNewDDL = @InsertNewDDL + '    from  ' + CHAR (10) ;

    SET @InsertNewDDL = @InsertNewDDL + '        ' + @BaseTblName + CHAR (10) ;

    SET @InsertNewDDL = @InsertNewDDL + ') ' + CHAR (10) ;
    SET @InsertNewDDL = @InsertNewDDL + 'INSERT INTO ' + @BaseTblName + CHAR (10) ;
    SET @InsertNewDDL = @InsertNewDDL + '( ' + CHAR (10) ;

    SET @InsertNewDDL = @InsertNewDDL + @cols + 'DBNAME, HashCode' + CHAR (10) ;

    SET @InsertNewDDL = @InsertNewDDL + ') ' + CHAR (10) ;
    SET @InsertNewDDL = @InsertNewDDL + 'SELECT' + CHAR (10) ;

    SET @InsertNewDDL = @InsertNewDDL + @BTCOLS + 'BT.DBNAME,BT.HashCode ';

    SET @InsertNewDDL = @InsertNewDDL + '               FROM ' + @TempTbl + ' AS BT ' + CHAR (10) ;
    SET @InsertNewDDL = @InsertNewDDL + '                    JOIN CTE ON ' + CHAR (10) ;
    SET @InsertNewDDL = @InsertNewDDL + '                                CTE.DBNAME = BT.DBNAME AND ' + CHAR (10) ;
    SET @InsertNewDDL = @InsertNewDDL + '               CTE.HashCode = BT.HashCode; ' + CHAR (10) ;
    SET @InsertNewDDL = @InsertNewDDL + '    SET @NbrRecs = @@ROWCOUNT; ' + CHAR (10) ;
    SET @InsertNewDDL = @InsertNewDDL + '    PRINT ''INSERTED: '' + CAST (@NbrRecs AS NVARCHAR (50)) + '' records into ' + @BaseTblName + ' ''; ' + CHAR (10) ;

    CLOSE CursorViewCols;
    DEALLOCATE CursorViewCols;

    IF
           @PreviewOnly = 'YES'
        BEGIN
            SELECT
                   @InsertNewDDL AS InsertNewDDL;
        END;

    SET @Tbl_DLL = 'if NOT Exists (select name from sys.tables where name = ''' + @BaseTblName + ''') ' + CHAR (10) ;
    SET @Tbl_DLL = @Tbl_DLL + 'BEGIN ' + CHAR (10) ;
    SET @Tbl_DLL = @Tbl_DLL + 'Create TABLE ' + @BaseTblName + ' ( ' + CHAR (10) ;
    SET @MySql = 'declare CursorCreateTable CURSOR ' + CHAR (10) ;
    SET @MySql = @MySql + '    FOR  ' + CHAR (10) ;
    SET @MySql = @MySql + '            SELECT ' + CHAR (10) ;
    SET @MySql = @MySql + '                   TABLE_CATALOG ' + CHAR (10) ;
    SET @MySql = @MySql + '                 , TABLE_SCHEMA ' + CHAR (10) ;
    SET @MySql = @MySql + '                 , TABLE_NAME ' + CHAR (10) ;
    SET @MySql = @MySql + '                 , COLUMN_NAME ' + CHAR (10) ;
    SET @MySql = @MySql + '                 , ORDINAL_POSITION ' + CHAR (10) ;
    SET @MySql = @MySql + '                 , IS_NULLABLE ' + CHAR (10) ;
    SET @MySql = @MySql + '                 , DATA_TYPE ' + CHAR (10) ;
    SET @MySql = @MySql + '                 , CHARACTER_MAXIMUM_LENGTH ' + CHAR (10) ;
    SET @MySql = @MySql + '                 , NUMERIC_PRECISION ' + CHAR (10) ;
    SET @MySql = @MySql + '                 , NUMERIC_SCALE ' + CHAR (10) ;
    if @LinkedSvrName is not null 
	   SET @MySql = @MySql + '            FROM ' + @LinkedSvrName + '.' + @DBNAME + '.information_schema.columns ' + CHAR (10) ;
    else	   
	   SET @MySql = @MySql + '            FROM ' + @DBNAME + '.information_schema.columns ' + CHAR (10) ;
    SET @MySql = @MySql + '            WHERE ' + CHAR (10) ;
    SET @MySql = @MySql + '                   table_name = ''' + @ViewName + ''' and TABLE_CATALOG = ''' + @DBNAME + '''' + CHAR (10) ;
    EXEC (@MySql) ;

    OPEN CursorCreateTable;

    FETCH NEXT FROM CursorCreateTable INTO @TABLE_CATALOG , @TABLE_SCHEMA , @TABLE_NAME , @COLUMN_NAME , @ORDINAL_POSITION , @IS_NULLABLE , @DATA_TYPE , @CHARACTER_MAXIMUM_LENGTH , @NUMERIC_PRECISION , @NUMERIC_SCALE;

    --Build the VIEW columns here
    WHILE
           @@FETCH_STATUS = 0
        BEGIN
            SET @COLUMN_NAME = '[' + @COLUMN_NAME + ']';
            SET @Tbl_DLL = @Tbl_DLL + '       ' + @COLUMN_NAME + ' ' + @DATA_TYPE;
            SET @ViewCols = @ViewCols + '       ' + @COLUMN_NAME + ' ' + @DATA_TYPE;

            --exec PrintImmediate @ViewCols ;
            IF
                   @DATA_TYPE = 'datetime' OR
                   @DATA_TYPE = 'datetime2'
                BEGIN
                    SET @Tbl_DLL = @Tbl_DLL + ', ' + CHAR (10) ;
                    SET @ViewCols = @ViewCols + ', ' + CHAR (10) ;
                END;
            ELSE
                BEGIN
                    IF
                           @DATA_TYPE = 'varbinary'
                        BEGIN
                            SET @Tbl_DLL = @Tbl_DLL + '(' + CAST (@CHARACTER_MAXIMUM_LENGTH AS NVARCHAR (50)) + '), ' + CHAR (10) ;
                            SET @ViewCols = @ViewCols + '(' + CAST (@CHARACTER_MAXIMUM_LENGTH AS NVARCHAR (50)) + '), ' + CHAR (10) ;
                        END;
                    ELSE
                        BEGIN
                            IF
                                   @DATA_TYPE = 'uniqueidentifier'
                                BEGIN
                                    SET @ViewCols = @ViewCols + ',' + CHAR (10) ;
                                    SET @Tbl_DLL = @Tbl_DLL + ',' + CHAR (10) ;
                                END;
                            ELSE
                                BEGIN
                                    IF
                                           @DATA_TYPE = 'nvarchar' OR
                                           @DATA_TYPE = 'varchar' OR
                                           @DATA_TYPE = 'char' OR
                                           @DATA_TYPE = 'nchar'
                                        BEGIN
                                            IF
                                               @CHARACTER_MAXIMUM_LENGTH IS NULL OR
                                                   @CHARACTER_MAXIMUM_LENGTH <= 0
                                                BEGIN
                                                    SET @ViewCols = @ViewCols + '(MAX), ' + CHAR (10) ;
                                                    SET @Tbl_DLL = @Tbl_DLL + '(MAX), ' + CHAR (10) ;
                                                END;
                                            ELSE
                                                BEGIN
                                                    SET @ViewCols = @ViewCols + '(' + CAST (@CHARACTER_MAXIMUM_LENGTH AS NVARCHAR (50)) + '), ' + CHAR (10) ;
                                                    SET @Tbl_DLL = @Tbl_DLL + '(' + CAST (@CHARACTER_MAXIMUM_LENGTH AS NVARCHAR (50)) + '), ' + CHAR (10) ;
                                                END;
                                        END;
                                    ELSE
                                        BEGIN
                                            SET @ViewCols = @ViewCols + ',' + CHAR (10) ;
                                            SET @Tbl_DLL = @Tbl_DLL + ',' + CHAR (10) ;
                                        END;
                                END;
                        END;
                END;
            FETCH NEXT FROM CursorCreateTable INTO @TABLE_CATALOG , @TABLE_SCHEMA , @TABLE_NAME , @COLUMN_NAME , @ORDINAL_POSITION , @IS_NULLABLE , @DATA_TYPE , @CHARACTER_MAXIMUM_LENGTH , @NUMERIC_PRECISION , @NUMERIC_SCALE;

        END;

    IF
           @PreviewOnly = 'YES'
        BEGIN
            SELECT
                   @ViewCols AS ViewCols2;
        END;

    --SET @Tbl_DLL = reverse (@Tbl_DLL) ;
    --SET @Tbl_DLL = ltrim (rtrim (@Tbl_DLL)) ;
    --SET @i = charindex (',' , @Tbl_DLL) ;
    --SET @Tbl_DLL = substring (@Tbl_DLL , @i + 1 , datalength (@Tbl_DLL)) ;
    --SET @Tbl_DLL = reverse (@Tbl_DLL) ;

    SET @Tbl_DLL = @Tbl_DLL + '  HashCode nvarchar(100) ' + CHAR (10) ;
    SET @Tbl_DLL = @Tbl_DLL + ', SVR nvarchar(100) ' + CHAR (10) ;
    SET @Tbl_DLL = @Tbl_DLL + ', DBNAME nvarchar(100) ' + CHAR (10) ;
    SET @Tbl_DLL = @Tbl_DLL + ', SurrogateKey_' + @viewname + ' bigint identity (1,1) not null ' + CHAR (10) ;
    SET @Tbl_DLL = @Tbl_DLL + ')' + CHAR (10) + CHAR (10) ;
    SET @Tbl_DLL = @Tbl_DLL + 'Create Index IHash_' + @ViewName + ' on ' + @BaseTblName + ' (' + CHAR (10) ;
    SET @Tbl_DLL = @Tbl_DLL + '    HashCode' + CHAR (10) ;
    SET @Tbl_DLL = @Tbl_DLL + ') include (DBNAME) ;' + CHAR (10) ;
    SET @Tbl_DLL = @Tbl_DLL + 'Create Index SKey_' + @ViewName + ' on ' + @BaseTblName + ' (' + CHAR (10) ;
    SET @Tbl_DLL = @Tbl_DLL + '    SurrogateKey_' + @ViewName + CHAR (10) ;
    SET @Tbl_DLL = @Tbl_DLL + ');' + CHAR (10) ;
    SET @Tbl_DLL = @Tbl_DLL + 'END ;    --begin' + CHAR (10) ;

    CLOSE CursorCreateTable;
    DEALLOCATE CursorCreateTable;

    IF
           @PreviewOnly = 'YES'
        BEGIN
            SELECT
                   @Tbl_DLL AS Tbl_DLL;
        END;
    ELSE
        BEGIN
            IF NOT EXISTS (SELECT
                                  table_name
                           FROM information_schema.tables
                           WHERE
                                  table_name = @BaseTblName) 
                BEGIN EXEC (@Tbl_DLL) ;
                    PRINT 'TABLE: ' + @BaseTblName + ' - created.';
                END;
            IF EXISTS (SELECT
                              table_name
                       FROM information_schema.tables
                       WHERE
                              table_name = @BaseTblName) 
                BEGIN
                    PRINT 'TABLE: ' + @BaseTblName + ' - verified and exists.';
                END;
            ELSE
                BEGIN
                    PRINT 'TABLE: ' + @BaseTblName + ' - FAILED verification and dies no exist.';
                END;
        END;

    DECLARE
    @ProcDDL AS NVARCHAR (MAX) = ''
  ,@DropDDL AS NVARCHAR (MAX) = ''
  ,@ProcedureName AS NVARCHAR (MAX) = 'proc_' + @ViewName + '_' + @DBNAME;

    SET @DropDDL = @DropDDL + 'if exists (select name from sys.procedures where name = ''' + @ProcedureName + ''')' + CHAR (10) ;
    SET @DropDDL = @DropDDL + '     drop procedure ' + @ProcedureName + ';' + CHAR (10) ;

    SET @ProcDDL = @ProcDDL + 'CREATE procedure ' + @ProcedureName + ' (@ReloadALL as int = 0) ' + CHAR (10) ;
    SET @ProcDDL = @ProcDDL + 'AS ' + CHAR (10) ;
    SET @ProcDDL = @ProcDDL + 'BEGIN ' + CHAR (10) + CHAR (10) ;
    SET @ProcDDL = @ProcDDL + '   -- This procedure, ' + @ProcedureName + ', is generated by proc_GenBaseTableFromView. On ' + CAST (GETDATE () AS NVARCHAR (50)) + '.' + CHAR (10) ;
    SET @ProcDDL = @ProcDDL + '   -- For changes to this procedure, please change the generator and regen the proc(s).' + CHAR (10) ;
    SET @ProcDDL = @ProcDDL + '   -- Author:    W. Dale Miller' + CHAR (10) ;
    SET @ProcDDL = @ProcDDL + '   -- Contact:   WDaleMiller@gmail.com' + CHAR (10) + CHAR (10) ;
    SET @ProcDDL = @ProcDDL + '   SET NOCOUNT ON; ' + char(10);
    SET @ProcDDL = @ProcDDL + '   IF OBJECT_ID(''' + @TempTbl + ''') IS NOT NULL DROP TABLE ' + @TempTbl + ' ; ' + CHAR (10) + CHAR (10) ;

    SET @ProcDDL = @ProcDDL + '-- from @Tbl_DLL' + CHAR (10) ;
    SET @ProcDDL = @ProcDDL + @Tbl_DLL + CHAR (10) + CHAR (10) ;

    SET @InsertNewDDL = REPLACE (@InsertNewDDL , 'INSERT DELETE DDL HERE' , @DeleteDDL) ;

    SET @ProcDDL = @ProcDDL + '-- from @InsertIntoDDL' + CHAR (10) ;
    SET @ProcDDL = @ProcDDL + @InsertIntoDDL + CHAR (10) + CHAR (10) ;
    --SET @ProcDDL = @ProcDDL + '-- from @DeleteDDL' + char (10) ;
    --SET @ProcDDL = @ProcDDL + @DeleteDDL + char (10) + char (10) ;
    SET @ProcDDL = @ProcDDL + '-- from @InsertNewDDL' + CHAR (10) ;
    SET @ProcDDL = @ProcDDL + @InsertNewDDL + CHAR (10) + CHAR (10) ;

    SET @ProcDDL = @ProcDDL + 'END --Create Procedure';

    IF
           @PreviewOnly = 'YES'
        BEGIN
            SELECT
                   @ProcDDL AS ProcDDL;
        END;
    IF
           @PreviewOnly != 'YES'
        BEGIN
            --PRINT @DropDDL;
            EXEC (@DropDDL) ;
            --PRINT @ProcDDL;
            EXEC (@ProcDDL) ;
            PRINT 'CREATED Procedure: ' + @ProcedureName;
        END;

    --***************************************************************************
    IF
           @GenJobToExecute = 1
        BEGIN
            DECLARE
            @Random INT
          ,@Upper INT
          ,@Lower INT
          ,@pName NVARCHAR (100) = @ProcedureName;

            SET @Lower = 0; ---- The lowest random number
            SET @Upper = 10; ---- The highest random number
            SELECT
                   @Random = ROUND ((@Upper - @Lower - 1) * RAND () + @Lower , 0) ;

            IF
                   @PreviewOnly != 'YES'
                BEGIN
                    DECLARE
                    @JobFullName NVARCHAR (250) = 'job_' + @pName
                  ,@StepName NVARCHAR (250) = 'Step2_' + @pName
                  ,@CMD NVARCHAR (250) = 'EXEC proc_RemoveHashCodeDuplicateRows ''' + @BaseTblName + ''',0 ';

                    --PRINT '@CMD: ' + @CMD;

                    EXEC proc_GenJobTrackerTableSync @Interval = @Random , @ProcName = @pName;
                    PRINT 'CREATED Sync Job: ' + @JobFullName;

                    -- CREATE PROCEDURE proc_RemoveHashCodeDuplicateRows (@BaseTblName AS NVARCHAR (250), @ShowSQL as bit = 0 )                     
                    DECLARE
                    @jobid NVARCHAR (250) ;

                    SELECT
                           @jobid = job_id
                    FROM msdb.dbo.sysjobs
                    WHERE
                           name = @JobFullName;
                    EXEC msdb..sp_add_jobstep @database_name = @MasterDB , @job_name = @JobFullName , @step_name = @StepName , @subsystem = 'TSQL' , @command = @CMD , @on_fail_action = 3 , @retry_attempts = 2 , @retry_interval = 5;
                    PRINT 'ADDED Job Step: ' + @StepName;
                    EXEC msdb.dbo.sp_update_jobstep @job_id = @jobid , @step_id = 1 , @on_success_action = 4 , @on_success_step_id = 2;
                    PRINT 'Set Next Step action to CONTINUE: ' + @StepName;

                END;
            ELSE
                BEGIN
                    PRINT 'SKIPPED Creating Sync Job';
                END;

            DECLARE
            @Tbl_DLL_DEL AS NVARCHAR (MAX) = ''
          ,@HistoryTblName AS NVARCHAR (MAX) = @BaseTblName + '_DEL'
          ,@SKeyBad AS NVARCHAR (250) = 'SurrogateKey_' + @ViewName + '_DEL'
          ,@SKeyGood AS NVARCHAR (250) = 'SurrogateKey_' + @ViewName;

            SET @Tbl_DLL_DEL = REPLACE (@Tbl_DLL , @ViewName , @HistoryTblName) ;
            SET @Tbl_DLL_DEL = REPLACE (@Tbl_DLL_DEL , 'bigint identity (1,1)' , 'bigint') ;
            SET @Tbl_DLL_DEL = REPLACE (@Tbl_DLL_DEL , '' , '') ;
            SET @Tbl_DLL_DEL = REPLACE (@Tbl_DLL_DEL , 'SurrogateKey_' , 'SurrogateKey_') ;
            SET @Tbl_DLL_DEL = REPLACE (@Tbl_DLL_DEL , @SKeyBad , @SKeyGood) ;
            SET @Tbl_DLL_DEL = REPLACE (@Tbl_DLL_DEL , 'BASE_BASE_' , 'BASE_') ;

            --print '@ViewName: '  + @ViewName ;
            --print '@HistoryTblName: '  + @HistoryTblName ;
            --print '@Tbl_DLL_DEL: '  + @Tbl_DLL_DEL ;

            IF
                   @PreviewOnly = 'YES'
                BEGIN
                    SELECT
                           @Tbl_DLL_DEL AS Tbl_DLL_DEL;
                END;
            ELSE
                BEGIN
                    IF EXISTS (SELECT
                                      table_name
                               FROM information_schema.tables
                               WHERE
                                      table_name = @BaseTblName + '_DEL') 
                        BEGIN
                            --The History table already exists
                            --if @KeepHistoryData =1 
                            --begin 						  
                            --exec proc_MatchChildToParentTable 
                            --set @ParentTable = @ViewName ;
                            --set @ChildTable = @ViewName + '_DEL' ;
                            --exec proc_MatchChildToParentTable @DBNAME , @ParentTable , @ChildTable , 0 ;
                            --end 
                            IF
                                   @SkipIfExists = 0
                                BEGIN
                                    PRINT 'DROPPING and recreating ' + @BaseTblName + '_DEL';
                                    SET @MySql = 'drop table ' + @BaseTblName + '_DEL';
                                    EXEC (@MySql) ;
                                    EXEC (@Tbl_DLL_DEL) ;
                                END;
                        END;
                    ELSE
                        BEGIN
                            --The History table DOES NOT exist. Create it.
                            EXEC (@Tbl_DLL_DEL) ;
                        END;
                    PRINT 'CREATED The History Table: ' + @HistoryTblName;
                END;

            DECLARE
            @OUT AS NVARCHAR (MAX) = ''
          ,@DDL AS NVARCHAR (MAX) = '';

            PRINT 'CALLING: proc_genBaseDelTrigger - ' + @BaseTblName;
            IF EXISTS (SELECT
                              table_name
                       FROM information_schema.tables
                       WHERE
                              table_name = @HistoryTblName) 
                BEGIN
                    PRINT 'TABLE: ' + @HistoryTblName + ' - verified and exists.';
                    IF EXISTS (SELECT
                                      table_name
                               FROM information_schema.columns
                               WHERE
                                      table_name = @HistoryTblName AND
                                      column_name = @SKeyBad) 
                        BEGIN
                            --Change the Surrogate Key name.
                            DECLARE
                            @OldCOL AS NVARCHAR (250) = @HistoryTblName + '.' + @SKeyBad;
                            --PRINT '@OldCOL: ' + @OldCOL;
                            --PRINT '@SKeyGood: ' + @SKeyGood;
                            EXEC sp_RENAME @OldCOL , @SKeyGood , 'COLUMN';
                        END;

                END;
            ELSE
                BEGIN
                    PRINT 'TABLE: ' + @HistoryTblName + ' - FAILED verification and does no exist.';
                END;

            --Generate the History DEL tracking trigger.
            EXEC proc_genBaseDelTrigger @BaseTblName , @DDL OUTPUT;
            SET @OUT = (SELECT
                               @DDL) ;
            IF
                   @PreviewOnly != 'YES'
                BEGIN

                    SET @TrigName = 'TRIG_DEL_' + @BaseTblName;
                    IF NOT EXISTS (SELECT
                                          *
                                   FROM sys.triggers
                                   WHERE
                                          object_id = OBJECT_ID (N'[dbo].[' + @TrigName + ']')) 
                        BEGIN EXEC (@OUT) ;
                        END;
                    PRINT 'CREATED History DEL Tracking Trigger.';
                END;

            IF
                   @PreviewOnly = 'YES'
                BEGIN
                    SELECT
                           @OUT AS DelTriggerDDL;
                END;

            --Generate the History UPDT Tracking Trigger
            EXEC proc_genBaseUpdtTrigger @BaseTblName , @DDL OUTPUT;
            SET @OUT = (SELECT
                               @DDL) ;
            IF
                   @PreviewOnly != 'YES'
                BEGIN
                    SET @TrigName = 'TRIG_UPDT_' + @BaseTblName;
                    IF NOT EXISTS (SELECT
                                          *
                                   FROM sys.triggers
                                   WHERE
                                          object_id = OBJECT_ID (N'[dbo].[' + @TrigName + ']')) 
                        BEGIN EXEC (@OUT) ;
                        END;
                    PRINT 'CREATED History UPDT Tracking Trigger.';
                END;

            IF
                   @PreviewOnly = 'YES'
                BEGIN
                    SELECT
                           @OUT AS UpdtTriggerDDL;
                END;

            --DECLARE
            --       @SetAsNotNUll AS INT = 0;
            --EXEC proc_RemoveIdentityCols @BaseTblName , @SetAsNotNUll;

            --Check EntryDate exists in HISTORY table
            IF EXISTS (SELECT
                              name
                       FROM sys.tables
                       WHERE
                              name = @HistoryTblName) 
                BEGIN
                    IF NOT EXISTS (SELECT
                                          column_name
                                   FROM information_schema.columns
                                   WHERE
                                          table_name = @HistoryTblName AND
                                          column_name = 'Action_Date') 
                        BEGIN
                            SET @MySql = 'alter table ' + @HistoryTblName + ' add Action_Date datetime not null default getdate() ';
                            EXEC (@MySql) ;
                            PRINT 'Added Action_Date to: ' + @HistoryTblName;
                        END;
                END;

            --Check LastModifiedDate exists in HISTORY table
            IF EXISTS (SELECT
                              table_name
                       FROM information_schema.tables
                       WHERE
                              table_name = @HistoryTblName) 
                BEGIN
                    IF NOT EXISTS (SELECT
                                          column_name
                                   FROM information_schema.columns
                                   WHERE
                                          table_name = @HistoryTblName AND
                                          column_name = 'LastModifiedDate') 
                        BEGIN
                            SET @MySql = 'alter table ' + @HistoryTblName + ' add LastModifiedDate datetime null default getdate()';
                            EXEC (@MySql) ;
                            PRINT 'Added LastModifiedDate to: ' + @HistoryTblName;
                        END;
                END;
            ELSE
                BEGIN
                    PRINT @BaseTblName + ' FAILED TO CREATE.';
                END;

		  --**********************************************************************
		  --**** GENERATE THE INSERT TRIGGER ON THE BASE TABLE
		  exec proc_GenInsertTrigger @HistoryTblName ;
		  --**********************************************************************

            --Check LastModifiedDate exists in BASE table
            IF EXISTS (SELECT
                              table_name
                       FROM information_schema.tables
                       WHERE
                              table_name = @BaseTblName) 
                BEGIN
                    IF NOT EXISTS (SELECT
                                          column_name
                                   FROM information_schema.columns
                                   WHERE
                                          table_name = @BaseTblName AND
                                          column_name = 'LastModifiedDate') 
                        BEGIN
                            SET @MySql = 'alter table ' + @BaseTblName + ' add LastModifiedDate datetime null default getdate()';
                            EXEC (@MySql) ;
                            PRINT 'Added LastModifiedDate to: ' + @BaseTblName;
                        END;
                END;
            ELSE
                BEGIN
                    PRINT @BaseTblName + ' FAILED TO CREATE.';
                END;
            DECLARE
            @PKName AS NVARCHAR (250) = 'PK_' + @BaseTblName;
            DECLARE
            @SKname AS NVARCHAR (250) = 'SurrogateKey_' + @ViewName;

            IF NOT EXISTS (SELECT
                                  COLUMN_NAME
                           FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
                           WHERE
                                  OBJECTPROPERTY (OBJECT_ID (CONSTRAINT_SCHEMA + '.' + CONSTRAINT_NAME) , 'IsPrimaryKey') = 1 AND
                                  TABLE_NAME = @BaseTblName AND
                                  TABLE_SCHEMA = 'dbo') 
                BEGIN
                    SET @MySQl = 'ALTER TABLE ' + @BaseTblName + ' ADD CONSTRAINT ' + @PKName + ' PRIMARY KEY (' + @SKname + ') ';
                    PRINT 'Created primary key on : ' + @BaseTblName;
                    EXEC (@MySql) ;
                END;

            DECLARE
            @JobName NVARCHAR (250) = 'job_' + @ProcedureName;
            IF EXISTS (SELECT
                              job_id
                       FROM msdb.dbo.sysjobs_view
                       WHERE name = @JobName) 
                BEGIN
                    PRINT 'Verified: JOB ' + @JobName + ', exists.';
                END;
            ELSE
                BEGIN
                    PRINT 'FAILED Verification: JOB ' + @JobName + ' does not exist.';
                END;

		  --**************************** POPULATE THE INITAL DELTA DATA *****************************************
		  exec proc_InitializeDelTableData @BaseTblName, 0
		  --************************************************************************

            PRINT 'COMPLETED... ' + @ViewName;
            PRINT '*********************';
        END;
--***************************************************************************

END;

GO
PRINT 'executed proc_GenBaseTableFromView.sql';
GO
