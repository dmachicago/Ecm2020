
-- use KenticoCMS_1
GO
PRINT 'Executing ScriptAllForeignKeyConstraints.sql';
GO
IF EXISTS (SELECT
                  name
           FROM sys.procedures
           WHERE
                  name = 'ScriptAllForeignKeyConstraints') 
    BEGIN
        DROP PROCEDURE
             ScriptAllForeignKeyConstraints
    END;
GO
-- exec ScriptAllForeignKeyConstraints
-- select * from TEMP_FK_Constraints
-- select * from PERM_FK_Constraints
CREATE PROCEDURE ScriptAllForeignKeyConstraints
AS
BEGIN
    SET NOCOUNT ON;

/*----------------------------------------------------------------------------------
AUTHOR:	  W. Dale Miller
CONTACT:	  WDaleMiller@gmail.com
DATE:	  12/19/2015
USE:		  All foreign keys' DDL will be scripted and stored in table TEMP_FK_Constraints.

		  exec ScriptAllForeignKeyConstraints
		  SELECT *  FROM TEMP_FK_Constraints; 
	   if not exists (select ForeignKeyName from TEMP_FK_Constraints where ParentTableName = 'BASE_HFit_TrackerMealPortions' and ForeignKeyName = 'FK_BASE_HFit_TrackerMealPortions_BASE_cms_user' and SchemaNAme = 'dbo')
	   ALTER TABLE dbo.FACT_TrackerData DROP CONSTRAINT FK_FACT_TrackerData_BASE_HFit_TrackerMealPortions
*/

    --- SCRIPT ALL FOREIGN KEY CONSTRAINTS
    -- select OBJECT_ID('TEMP_FK_Constraints')
    IF OBJECT_ID ('TEMP_FK_Constraints') IS NOT NULL
        BEGIN
            DROP TABLE
                 TEMP_FK_Constraints;
        END;

    CREATE TABLE TEMP_FK_Constraints (
                 ForeignKeyID INT NULL
               , ForeignKeyName NVARCHAR (150) NOT NULL
               , ParentTableName NVARCHAR (150) NOT NULL
               , ParentColumn NVARCHAR (150) NOT NULL
               , ReferencedTable NVARCHAR (150) NOT NULL
               , ReferencedColumn NVARCHAR (150) NOT NULL
               , GenSql NVARCHAR (4000) NULL
               , SchemaName NVARCHAR (150) NULL) ;

    DECLARE
           @ForeignKeyID INT
         , @ForeignKeyName VARCHAR (4000) 
         , @ParentTableName VARCHAR (4000) 
         , @ParentColumn VARCHAR (4000) 
         , @ReferencedTable VARCHAR (4000) 
         , @ReferencedColumn VARCHAR (4000) 
         , @StrParentColumn VARCHAR (MAX) 
         , @StrReferencedColumn VARCHAR (MAX) 
         , @ParentTableSchema VARCHAR (4000) 
         , @ReferencedTableSchema VARCHAR (4000) 
         , @TSQLCreationFK VARCHAR (MAX) 
         , @SqlCmd VARCHAR (MAX) ;

    DECLARE CursorFK CURSOR
        FOR SELECT
                   object_id--, name, object_name( parent_object_id) 
            FROM sys.foreign_keys;
    OPEN CursorFK;
    FETCH NEXT FROM CursorFK INTO @ForeignKeyID;
    WHILE
           @@FETCH_STATUS = 0
        BEGIN
            SET @StrParentColumn = '';
            SET @StrReferencedColumn = '';
            DECLARE CursorFKDetails CURSOR
                FOR SELECT
                           fk.name AS ForeignKeyName
                         , SCHEMA_NAME (t1.schema_id) AS ParentTableSchema
                         , OBJECT_NAME (fkc.parent_object_id) AS ParentTable
                         , c1.name AS ParentColumn
                         , SCHEMA_NAME (t2.schema_id) AS ReferencedTableSchema
                         , OBJECT_NAME (fkc.referenced_object_id) AS ReferencedTable
                         , c2.name AS ReferencedColumn
                    FROM
                         --sys.tables t inner join 
                         sys.foreign_keys AS fk
                         INNER JOIN sys.foreign_key_columns AS fkc
                         ON
                           fk.object_id = fkc.constraint_object_id
                         INNER JOIN sys.columns AS c1
                         ON
                           c1.object_id = fkc.parent_object_id AND
                           c1.column_id = fkc.parent_column_id
                         INNER JOIN sys.columns AS c2
                         ON
                           c2.object_id = fkc.referenced_object_id AND
                           c2.column_id = fkc.referenced_column_id
                         INNER JOIN sys.tables AS t1
                         ON
                           t1.object_id = fkc.parent_object_id
                         INNER JOIN sys.tables AS t2
                         ON
                           t2.object_id = fkc.referenced_object_id
                    WHERE
                           fk.object_id = @ForeignKeyID;

            OPEN CursorFKDetails;
            FETCH NEXT FROM CursorFKDetails INTO @ForeignKeyName , @ParentTableSchema , @ParentTableName , @ParentColumn , @ReferencedTableSchema , @ReferencedTable , @ReferencedColumn;

            WHILE
                   @@FETCH_STATUS = 0
                BEGIN
                    SET @StrParentColumn = @StrParentColumn + ', ' + QUOTENAME (@ParentColumn) ;
                    SET @StrReferencedColumn = @StrReferencedColumn + ', ' + QUOTENAME (@ReferencedColumn) ;

                    FETCH NEXT FROM CursorFKDetails INTO @ForeignKeyName , @ParentTableSchema , @ParentTableName , @ParentColumn , @ReferencedTableSchema , @ReferencedTable , @ReferencedColumn;
                END;

            CLOSE CursorFKDetails;
            DEALLOCATE CursorFKDetails;

            SET @StrParentColumn = SUBSTRING (@StrParentColumn , 2 , LEN (@StrParentColumn) - 1) ;
            SET @StrReferencedColumn = SUBSTRING (@StrReferencedColumn , 2 , LEN (@StrReferencedColumn) - 1) ;
            SET @TSQLCreationFK = 'ALTER TABLE ' + QUOTENAME (@ParentTableSchema) + '.' + QUOTENAME (@ParentTableName) + ' WITH CHECK ADD CONSTRAINT ' + QUOTENAME (@ForeignKeyName) + ' FOREIGN KEY(' + LTRIM (@StrParentColumn) + ') ' + CHAR (13) + 'REFERENCES ' + QUOTENAME (@ReferencedTableSchema) + '.' + QUOTENAME (@ReferencedTable) + ' (' + LTRIM (@StrReferencedColumn) + ') ' + CHAR (13) + 'GO';

            SET @SqlCmd = 'ALTER TABLE ' + QUOTENAME (@ParentTableSchema) + '.' + QUOTENAME (@ParentTableName) + ' WITH CHECK ADD CONSTRAINT ' + QUOTENAME (@ForeignKeyName) + ' FOREIGN KEY(' + LTRIM (@StrParentColumn) + ') ' + CHAR (13) + 'REFERENCES ' + QUOTENAME (@ReferencedTableSchema) + '.' + QUOTENAME (@ReferencedTable) + ' (' + LTRIM (@StrReferencedColumn) + ') ';

            --PRINT @TSQLCreationFK;

            INSERT INTO TEMP_FK_Constraints (
                   ForeignKeyID
                 , ForeignKeyName
                 , ParentTableName
                 , ParentColumn
                 , ReferencedTable
                 , ReferencedColumn
                 , GenSql
                 , SchemaName) 
            VALUES (@ForeignKeyID , @ForeignKeyName , @ParentTableName , @ParentColumn , @ReferencedTable , @ReferencedColumn , @SqlCmd , 'dbo') ;

            FETCH NEXT FROM CursorFK INTO @ForeignKeyID;
        END;
    CLOSE CursorFK;
    DEALLOCATE CursorFK;
    SET NOCOUNT OFF;

	if not exists (select name from sys.tables where name = 'PERM_FK_Constraints')
    begin
	   select * into PERM_FK_Constraints from TEMP_FK_Constraints ;
    end 
else
     with CTE (ForeignKeyId) AS (
			 select ForeignKeyId from TEMP_FK_Constraints
			 except 
			 select ForeignKeyId from PERM_FK_Constraints
		  )
		  insert into PERM_FK_Constraints 
		  select T.ForeignKeyID, T.ForeignKeyName, T.ParentTableName, T.ParentColumn
				, T.ReferencedTable, T.ReferencedColumn, T.GenSql, T.SchemaName
		  from TEMP_FK_Constraints T
		  join CTE C on
		  T.ForeignKeyID = C.ForeignKeyID
    
END;
GO
PRINT 'Executed ScriptAllForeignKeyConstraints.sql';
GO