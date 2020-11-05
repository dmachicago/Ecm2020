--**************************************************
--Check if a schema exists…then create it
IF NOT EXISTS (SELECT 0
               FROM information_schema.schemata 
               WHERE schema_name='name_of_schema')
BEGIN
  EXEC sp_executesql N'CREATE SCHEMA name_of_schema';
END

--Check if a regular table exists…and drop it
IF EXISTS (SELECT 0 
           FROM INFORMATION_SCHEMA.TABLES 
           WHERE TABLE_SCHEMA = 'name_of_schema' 
           AND TABLE_NAME = 'name_of_table')
 BEGIN
     DROP TABLE [name_of_schema].[name_of_table];
 END

--Check if a local temp table exists…then drop it
IF OBJECT_ID('tempdb..#name_of_table') IS NOT NULL
 BEGIN
     DROP TABLE #name_of_table;
 END

--Check if a Global temp table exists…then drop it
IF OBJECT_ID('tempdb..##name_of_table') IS NOT NULL
 BEGIN
     DROP TABLE ##name_of_table;
 END

--Check if a column exists in a table…then add it
IF NOT EXISTS(SELECT 0
              FROM INFORMATION_SCHEMA.COLUMNS
              WHERE 
                TABLE_NAME = 'name_of_table'
                AND COLUMN_NAME = 'name_of_column')
BEGIN
    ALTER TABLE [name_of_schema].[name_of_table] 
    ADD [name_of_column] data_type NULL
END;

--Check if a synonym exists…then create it
IF NOT EXISTS (SELECT 0 
               FROM [sys].[synonyms] 
               WHERE 
               [name]=N'name_of_synonym')
BEGIN
     CREATE SYNONYM [name_of_schema].[name_of_synonym] 
     FOR [name_of_db].[name_of_schema].[name_of_synonym];
END

--Check if a view exists…then drop it
IF EXISTS (SELECT 0 
           FROM sys.views V 
           INNER JOIN sys.[schemas] S on v.schema_id = s.schema_id 
           WHERE 
           s.name='name_of_schema' 
           AND v.name = 'name_of_view' 
           AND v.type = 'V')
BEGIN
   DROP VIEW [name_of_schema].[name_of_view];
END

--Check if an index exists…then drop it
IF EXISTS (SELECT 0 
           FROM sys.indexes 
           WHERE object_id = OBJECT_ID('name_of_schema.name_of_table') 
           AND name='name_of_index')
BEGIN
  DROP INDEX [name_of_index] ON [name_of_schema].[name_of_table];
END

--Check if a statistic exists…then drop it
IF EXISTS (SELECT name 
           FROM sys.stats 
           WHERE name = N'name_of_stat' 
           AND object_id = OBJECT_ID(N'name_of_schema.name_of_table'))
BEGIN
   DROP STATISTICS [name_of_schema].[name_of_table].[name_of_stat]
END

--**************************************************
--Programmability
--Check if a procedure exists…then drop it
IF EXISTS ( SELECT *
            FROM   sys.objects
            WHERE  object_id = OBJECT_ID(N'name_of_schema.name_of_proc')
                   AND type IN ( N'P', N'PC' ) )
BEGIN
   DROP PROCEDURE [name_of_schema].[name_of_proc];
END

--Check if a function exists…then drop it
IF EXISTS (SELECT 0
            FROM sys.objects 
            WHERE object_id = OBJECT_ID(N'name_of_schema.name_of_function')
            AND type in (N'IF',N'FN',N'TF',N'FS',N'FT')
            )
 BEGIN
    DROP FUNCTION [name_of_schema].[name_of_function];
 END

 --**************************************************
--Jobs, Steps, Schedules
--Check if a Job Category exists…then create it
IF NOT EXISTS (SELECT 0 FROM msdb.dbo.syscategories 
               WHERE 
               name=N'name_of_category' AND category_class=1)
BEGIN
    EXEC msdb.dbo.sp_add_category 
    @class=N'JOB', 
    @type=N'LOCAL', 
    @name=N'name_of_category'
END

--Check if a Job exists…then delete it
DECLARE @jobId binary(16);
SELECT @jobId = job_id FROM msdb.dbo.sysjobs WHERE (name = N'name_of_job')
IF (@jobId IS NOT NULL)
    EXEC msdb.dbo.sp_delete_job @jobId

--Databases, Filegroups, Files
--Check if filegroup does not exist…then add it
IF NOT EXISTS (SELECT name 
               FROM sys.filegroups 
               WHERE name = N'name_of_filegroup') 
BEGIN
    ALTER DATABASE [name_of_db] ADD FILEGROUP [name_of_filegroup]
END

--**************************************************
--Logins, Users
--Check if Windows login exists…then create it
IF NOT EXISTS(SELECT [name] 
              FROM sys.syslogins 
              WHERE name]='name_of_login'
                    AND isntuser=1)
BEGIN
    CREATE LOGIN [name_of_login] FROM WINDOWS
END

--Check if native login exists…then create it
IF NOT EXISTS(SELECT [name] 
               FROM sys.syslogins 
               WHERE name]='name_of_login'
                     AND isntuser=0)
 BEGIN
     CREATE LOGIN [name_of_login] WITH PASSWORD = 'strong_password'
 END

--Check if a user exists in a database…then create it.
IF NOT EXISTS (SELECT name 
               FROM [sys].[database_principals] 
               WHERE name = N'name_of_user')
BEGIN
   CREATE USER [name_of_user] FOR LOGIN [name_of_login] 
   WITH DEFAULT_SCHEMA=[default_schema]
END