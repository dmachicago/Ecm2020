
-- use KenticoCMS_Datamart_2
-- SELECT * FROM TEMP_DROPFK;
go
print 'Executing dropAllForeignKeyCONSTRAINTS.sql'
go
if exists (select name from sys.procedures where name = 'dropAllForeignKeyCONSTRAINTS')
    drop procedure dropAllForeignKeyCONSTRAINTS;
go
-- exec dropAllForeignKeyCONSTRAINTS BASE_CMS_user
CREATE PROCEDURE dropAllForeignKeyCONSTRAINTS (
       @TblName AS NVARCHAR (250)) 
AS
BEGIN

/*----------------------------------------------------------------------
AUTHOR:	  W. Dale Miller
CONTACT:	  WDaleMiller@gmail.com
DATE:	  12/19/2015
USE:		  SCRIPT TO GENERATE THE DROP SCRIPTS OF ALL 
		  FOREIGN KEY CONSTRAINTS on a given table.
*/

    -- DECLARE @TblName AS NVARCHAR (250) = 'BASE_CMS_USer';

    BEGIN TRY
        DROP TABLE
             TEMP_DROPFK;
    END TRY
    BEGIN CATCH
        PRINT 'INIT TEMP_DROPFK ';
    END CATCH;

    CREATE TABLE TEMP_DROPFK
    (
                 ParentTableName NVARCHAR (250) NOT NULL
               , ChildTableName NVARCHAR (250) NOT NULL
               , ForeignKeyName NVARCHAR (250) NOT NULL
               , DropSql NVARCHAR (4000) NULL
    );

    DECLARE
           @ForeignKeyName NVARCHAR (4000) 
         , @ChildTableName NVARCHAR (4000) 
         , @ParentTableSchema NVARCHAR (4000) 
         , @TSQLDropFK NVARCHAR (MAX) 
         , @SqlCmd NVARCHAR (MAX) ;

    DECLARE CursorFK CURSOR
        FOR SELECT
                   fk.name AS ForeignKeyName
                 , schema_name (t.schema_id) AS ParentTableSchema
                 , t.name AS ChildTableName
            FROM sys.foreign_keys AS fk
                 INNER JOIN sys.tables AS t
                 ON
                   fk.parent_object_id = t.object_id;
    OPEN CursorFK;
    FETCH NEXT FROM CursorFK INTO  @ForeignKeyName , @ParentTableSchema , @ChildTableName;
    WHILE
           @@FETCH_STATUS = 0
        BEGIN
            SET @TSQLDropFK = 'ALTER TABLE ' + quotename (@ParentTableSchema) + '.' + quotename (@ChildTableName) + ' DROP CONSTRAINT ' + quotename (@ForeignKeyName) ;
            SET @SqlCmd = 'ALTER TABLE ' + quotename (@ParentTableSchema) + '.' + quotename (@ChildTableName) + ' DROP CONSTRAINT ' + quotename (@ForeignKeyName) ;
            --PRINT @TSQLDropFK;
            INSERT INTO TEMP_DROPFK (
                   ParentTableName
                 , ChildTableName
                 , ForeignKeyName
                 , DropSql) 
            VALUES (@TblName , @ChildTableName , @ForeignKeyName , @TSQLDropFK) ;
            FETCH NEXT FROM CursorFK INTO  @ForeignKeyName , @ParentTableSchema , @ChildTableName;
        END;
    CLOSE CursorFK;
    DEALLOCATE CursorFK;
END; 


go
print 'Executed dropAllForeignKeyCONSTRAINTS.sql'
go
