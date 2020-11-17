

USE KenticoCMS_Datamart_2;
GO

SELECT
       name
FROM sys.key_constraints
WHERE
      type = 'PK' AND
       OBJECT_NAME (parent_object_id) = 'CMS_User';

IF NOT EXISTS (
SELECT
       CONSTRAINT_NAME
FROM KenticoCMS_1.information_schema.TABLE_CONSTRAINTS
WHERE
       CONSTRAINT_TYPE = 'PRIMARY KEY' AND
       TABLE_NAME = 'CMS_User'
) 
    BEGIN
        ALTER TABLE CMS_User
        ADD
                    RowNbrIdent BIGINT IDENTITY (1 , 1) 
    END;
GO

PRINT 'Order of Execution: ';
PRINT 'NOTE: These statements will generate commands to run on Orange. So they have to be executed from TGT2';
PRINT '      The exception is Statement #0. It must be executed on the Orange server''s database needed to be "tracked". ' + char (10) ;

PRINT 'Statement #0 - Make certain Change Tracking is ON at the database level.';
PRINT 'Statement #2 - Make certain all targeted tables Change Tracking is OFF to start.';
PRINT 'Statement #1 - Make certain all targeted tables Change Tracking is OFF to start.';
PRINT 'Only if needed on the DATA Martserver:';
PRINT 'Statement #4 - Make certain all targeted tables Change Tracking is OFF to start.';
PRINT 'Statement #3 - Make certain all targeted tables Change Tracking is OFF to start.';

--*************************************************************************************************
--STMT:0  COPY THE FOLLOWING and insert the Change Tracking statements
--*************************************************************************************************
go
/*
CREATE PROCEDURE proc_TurnOnChangeTracking (
       @SVR AS NVARCHAR (250)) 
AS
BEGIN
    BEGIN TRY
        DECLARE
               @MySql AS NVARCHAR (MAX) = '';
        SET @MySql = ' ALTER DATABASE ' + @SVR + ' SET CHANGE_TRACKING = ON (CHANGE_RETENTION = 2 DAYS , AUTO_CLEANUP = ON) ';
        EXEC (@mYsql) ;
    END TRY
    BEGIN CATCH
        PRINT 'Verify change tracking is turned on for ' + @SVR;
    END CATCH;

    --*****************************************************************
    -- insert the Change Tracking statements HERE


    --*****************************************************************
end     
*/
go
--*************************************************************************************************
--STMT:1
--*************************************************************************************************
SELECT
       'Print ''Table: ' + table_name + '''' + char (10) 
    + 'if not exists ( ' + char (10) 
    + '    select sys.tables.name as Table_name from sys.change_tracking_tables ' + char (10) 
    + '    join sys.tables on sys.tables.object_id = sys.change_tracking_tables.object_id ' + char (10) 
    + '    join sys.schemas on sys.schemas.schema_id = sys.tables.schema_id ' + char (10) 
    + '    where sys.tables.name = '''+table_name+''' ' + char (10) 
    + '    and sys.schemas.name = ''dbo'' ' + char (10) 
    + ') ' + char (10) 
    + 'BEGIN ' + char (10) 
    + '    if not exists ( ' + char (10) 
    + '        select CONSTRAINT_NAME from information_schema.TABLE_CONSTRAINTS ' + char (10) 
    + '        where CONSTRAINT_TYPE = ''PRIMARY KEY'' ' + char (10) 
    + '        and TABLE_NAME = '''+table_name+'''' + char (10) 
    + '    ) ' + char (10) 
    + '    BEGIN ' + char (10) 
    + '        alter table ' + table_name + ' add SurrogateKey_'+table_name+' bigint identity (1,1) ;' + char (10) 
    + '	     CheckPoint ;' + char (10) 
    + '	     ALTER TABLE dbo.'+table_name + char (10) 
    + '	     ADD CONSTRAINT PKI_'+table_name+' PRIMARY KEY CLUSTERED (SurrogateKey_'+table_name+')' + char (10) 
    + '	     CheckPoint ;' + char (10) 
    + '    END' + char (10) 
    + '    ALTER TABLE DBO.' + table_name + '  ENABLE CHANGE_TRACKING WITH (TRACK_COLUMNS_UPDATED = ON) ;' + char (10) 
    + 'END' + char (10) 
+ 'GO' + char (10) 
FROM KenticoCMS_1.information_schema.tables
WHERE table_name IN (
SELECT
       substring (table_name , 6 , 999) AS table_name
FROM information_schema.tables
WHERE
      table_name LIKE 'BASE_%' AND
      table_name NOT LIKE '%view%') ;

--*************************************************************************************************
--STMT:2
--*************************************************************************************************
/*
if exists (Select name from sys.procedures where name = 'proc_TurnOffChangeTracking')
drop procedure proc_TurnOffChangeTracking
go
CREATE PROCEDURE proc_TurnOffChangeTracking (
       @SVR AS NVARCHAR (250)) 
AS
BEGIN
    --*****************************************************************
    -- insert the Change Tracking statements HERE
    --*****************************************************************
END
*/
SELECT
       'Print ''Table: ' + table_name + '''' + char (10) 
    + 'if exists ( ' + char (10) 
    + '    select sys.tables.name as Table_name from sys.change_tracking_tables ' + char (10) 
    + '    join sys.tables on sys.tables.object_id = sys.change_tracking_tables.object_id ' + char (10) 
    + '    join sys.schemas on sys.schemas.schema_id = sys.tables.schema_id ' + char (10) 
    + '    where sys.tables.name = '''+table_name+''' ' + char (10) 
    + '    and sys.schemas.name = ''dbo'' ' + char (10) 
    + ') ' + char (10) 
    + '    BEGIN ' + char (10) 
    + '        BEGIN TRY ' + char(10)
    + '            ALTER TABLE DBO.' + table_name + '  DISABLE CHANGE_TRACKING' + char (10) + '--GO' + char(10)
    + '        END TRY ' + char(10)
    + '        BEGIN catch ' + char(10)
    + '            Print ''ERROR: ' + table_name  + '''' + char (10) + '--GO' + char(10)
    + '        END catch ' + char(10)
    + '    END' + char (10) 
    + '--GO' + char(10)
FROM KenticoCMS_1.information_schema.tables
WHERE table_name IN (SELECT
                            substring (table_name , 6 , 999) AS table_name
                     FROM information_schema.tables
                     WHERE
                           table_name LIKE 'BASE_%' AND
                           table_name NOT LIKE '%view%') ;

--*************************************************************************************************
--STMT:3
--*************************************************************************************************
SELECT
       'Print ''Table: ' + table_name + '''' + char (10) + 'ALTER TABLE DBO.' + table_name + '  ENABLE CHANGE_TRACKING WITH (TRACK_COLUMNS_UPDATED = ON) ' + char (10) + 'GO'
FROM information_schema.tables
WHERE
      table_name LIKE 'BASE_%' AND
      table_name NOT LIKE '%view%' AND
      table_name NOT LIKE '%VerHIST' AND
      table_name NOT LIKE '%_DEL';

--*************************************************************************************************
--STMT:4
--*************************************************************************************************
SELECT
       'Print ''Table: ' + table_name + '''' + char (10) + 'ALTER TABLE DBO.' + table_name + '  DISABLE CHANGE_TRACKING' + char (10) + 'GO'
FROM information_schema.tables
WHERE
      table_name LIKE 'BASE_%' AND
      table_name NOT LIKE '%view%' AND
      table_name NOT LIKE '%VerHIST' AND
      table_name NOT LIKE '%_DEL';
