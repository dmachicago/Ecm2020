--* USEDFINAnalytics;
GO

/* Author: W. Dale Miller
 Date:   2011/07/26

 Description: Executes a statement against multiple databases
 Parameters:
    @statement:    The statement to execute
    @replacechar:  The character to replace with the database name
    @name_pattern: The pattern to select the databases
     It can be:
     * NULL     - Returns all databases
     * [USER]   - Returns users databases only
     * [SYSTEM] - Returns system databases only
     * A pattern to --* USEin a LIKE predicate against the database name*/

CREATE PROCEDURE [DMA_ForEachDB] @statement    NVARCHAR(MAX), 
     @replacechar  NCHAR(1) = N'?', 
     @name_pattern NVARCHAR(500) = NULL
AS
    BEGIN
 SET NOCOUNT ON;
 DECLARE @sql NVARCHAR(MAX);

/* LEVEL 3:
     Build an intermediate statement that replaces the '?' char*/

 SET @sql = 'SET @statement = REPLACE(@statement,''' + @replacechar + ''',DB_NAME()); EXEC(@statement);';
 SET @sql = REPLACE(@sql, '''', '''''');
 SET @sql = 'N''' + @sql + '''';

/* LEVEL 2:
     Build a statement to execute on each database context*/

 WITH dbs
 AS (SELECT *, 
   system_db = CASE
     WHEN name IN('master', 'model', 'msdb', 'tempdb')
     THEN 1
     ELSE 0
   END
   FROM sys.databases
   WHERE DATABASEPROPERTY(name, 'IsSingleUser') = 0
    AND HAS_DBACCESS(name) = 1
    AND state_desc = 'ONLINE')
 SELECT @sql =
 (
   SELECT 'EXEC ' + QUOTENAME(name) + '.sys.sp_executesql ' + @sql + ',' + 'N''@statement nvarchar(max)'',' + '@statement;' AS [text()]
   FROM dbs
   WHERE 1 = CASE

 /* No filter? Return all databases*/

     WHEN @name_pattern IS NULL
     THEN 1

 /* User databases*/

     WHEN @name_pattern = '[USER]'
     THEN system_db + 1

 /* System databases*/

     WHEN @name_pattern = '[SYSTEM]'
     THEN system_db

 /* LIKE filter*/

     WHEN name LIKE @name_pattern
     THEN 1
 END
   ORDER BY name FOR XML PATH('')
 );

/* LEVEL 1:
     Execute multi-db sql and pass in the actual statement*/

 EXEC sp_executeSQL 
 @sql, 
 N'@statement nvarchar(max)', 
 @statement;
    END;
GO

/***********************************************************************************
 exec [UTIL_MSforeachdb]*/

CREATE PROCEDURE [UTIL_MSforeachdb] @command1    NVARCHAR(2000), 
   @replacechar NCHAR(1)  = N'?', 
   @command2    NVARCHAR(2000) = NULL, 
   @command3    NVARCHAR(2000) = NULL, 
   @precommand  NVARCHAR(2000) = NULL, 
   @postcommand NVARCHAR(2000) = NULL
AS
    BEGIN
 SET DEADLOCK_PRIORITY low;

 /* This proc returns one or more rows for each accessible db, with each db defaulting to its own result set */
 /* @precommand and @postcommand may be used to force a single result set via a temp table. */
 /* Preprocessor won't replace within quotes so have to --* USEstr(). */
 DECLARE @inaccessible NVARCHAR(12), @invalidlogin NVARCHAR(12), @dbinaccessible NVARCHAR(12);
 SELECT @inaccessible = LTRIM(STR(CONVERT(INT, 0x03e0), 11));
 SELECT @invalidlogin = LTRIM(STR(CONVERT(INT, 0x40000000), 11));
 SELECT @dbinaccessible = N'0x80000000';

 /* SQLDMODbUserProf_InaccessibleDb; the negative number doesn't work in convert() */

 IF(@precommand IS NOT NULL)
     EXEC (@precommand);
 DECLARE @origdb NVARCHAR(150);
 SELECT @origdb = DB_NAME();

 /* If it's a single user db and there's an entry for it in sysprocesses who isn't us, we can't --* USEit. */
 /* Create the select */
 EXEC (N'declare hCForEachDatabase cursor global for select name from master.dbo.sysdatabases d '+N' where (d.status & '+@inaccessible+N' = 0)'+N' and (DATABASEPROPERTY(d.name, ''issingleuser'') = 0 and (has_dbaccess(d.name) = 1))');
 DECLARE @retval INT;
 SELECT @retval = @@error;
 IF
    (@retval = 0
    )
     EXEC @retval = sys.sp_MSforeach_worker 
   @command1, 
   @replacechar, 
   @command2, 
   @command3, 
   1;
 IF(@retval = 0
    AND @postcommand IS NOT NULL)
     EXEC (@postcommand);
 DECLARE @tempdb NVARCHAR(258);
 SELECT @tempdb = REPLACE(@origdb, N']', N']]');
 EXEC (N'--* USE'+N'['+@tempdb+N']');
 RETURN @retval;
    END;