

GO
PRINT 'Executing UTIL_ListAllForeignKeyRelationships.sql';
GO
IF EXISTS (SELECT
                  name
           FROM sys.procedures
           WHERE
                  name = 'UTIL_ListAllForeignKeyRelationships') 
    BEGIN
        DROP PROCEDURE
             UTIL_ListAllForeignKeyRelationships
    END;
GO
-- exec UTIL_ListAllForeignKeyRelationships 'BASE_CMS_user'
CREATE PROCEDURE UTIL_ListAllForeignKeyRelationships (
       @TblName NVARCHAR (80)) 
AS
BEGIN
    --*************************************************************************
    --WDM : Pass in a table name and get all FK Rels both up and down the chain
    --USE:	exec UTIL_ListAllForeignKeyRelationships 'CMS_TREE'
    --*************************************************************************
    SELECT
           KP.TABLE_SCHEMA AS PK_Schema
         , KP.TABLE_NAME AS PK_Table
         , KP.COLUMN_NAME AS PK_Column
         , KF.TABLE_SCHEMA AS FK_Schema
         , KF.TABLE_NAME AS FK_Table
         , KF.COLUMN_NAME AS FK_Column
         , RC.CONSTRAINT_NAME AS FK_CONSTRAINT_Name
         , RC.UNIQUE_CONSTRAINT_NAME AS PK_Name
         , RC.MATCH_OPTION AS MatchOption
         , RC.UPDATE_RULE AS UpdateRule
         , RC.DELETE_RULE AS DeleteRule
    FROM INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS AS RC
         JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE AS KF
         ON
           RC.CONSTRAINT_NAME = KF.CONSTRAINT_NAME
         JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE AS KP
         ON
           RC.UNIQUE_CONSTRAINT_NAME = KP.CONSTRAINT_NAME

    WHERE
           KP.TABLE_NAME = @TblName OR
           KF.TABLE_NAME = @TblName

    ORDER BY
             KP.TABLE_SCHEMA
             , KP.TABLE_NAME
             , KP.COLUMN_NAME;
END;

--GRANT EXECUTE ON OBJECT::dbo.UTIL_ListAllForeignKeyRelationships TO public;

GO
PRINT 'Executed UTIL_ListAllForeignKeyRelationships.sql';
GO
