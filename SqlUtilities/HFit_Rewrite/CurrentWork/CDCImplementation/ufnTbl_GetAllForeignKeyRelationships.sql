

GO
PRINT 'Executing ufnTbl_GetAllForeignKeyRelationships.sql';
GO

IF  EXISTS
(
SELECT
       *
FROM sys.objects
WHERE
       object_id = OBJECT_ID ('dbo.ufnTbl_GetAllForeignKeyRelationships') AND
       type IN ('FN', 'IF', 'TF') 
) 
    BEGIN
        PRINT 'function found... Dropping ufnTbl_GetAllForeignKeyRelationships';
        DROP FUNCTION
             dbo.ufnTbl_GetAllForeignKeyRelationships;
    END;

GO

/*------------------------------------------------------------------------
select * from ufnTbl_GetAllForeignKeyRelationships ('BASE_CMS_user') 
    where PK_Table = 'BASE_cms_user' 
    and FK_Table = 'BASE_cms_usersite' 
    and FK_Column = 'SurrogateKey_cms_user' 
*/
CREATE FUNCTION ufnTbl_GetAllForeignKeyRelationships (
                @TblName NVARCHAR (80), @PreviewOnly as bit = 1) 
RETURNS @FKEY TABLE
(
                    PK_Schema NVARCHAR (50) NULL
                  , PK_Table NVARCHAR (150) NULL
                  , PK_Column NVARCHAR (250) NULL
                  , FK_Schema NVARCHAR (50) NULL
                  , FK_Table NVARCHAR (250) NULL
                  , FK_Column NVARCHAR (250) NULL
                  , FK_CONSTRAINT_Name NVARCHAR (250) NULL
                  , PK_Name NVARCHAR (250) NULL
                  , MatchOption NVARCHAR (4000) NULL
                  , UpdateRule NVARCHAR (4000) NULL
                  , DeleteRule NVARCHAR (4000) NULL
) 
AS
BEGIN
    --*************************************************************************
    --WDM :	 Pass in a table name and get all FK Rels both up and down the chain
    --USE:	 exec ufnTbl_GetAllForeignKeyRelationships 'CMS_TREE'
    --*************************************************************************
    INSERT INTO @FKEY (
           PK_Schema
         , PK_Table
         , PK_Column
         , FK_Schema
         , FK_Table
         , FK_Column
         , FK_CONSTRAINT_Name
         , PK_Name
         , MatchOption
         , UpdateRule
         , DeleteRule
    ) 
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

    RETURN;
END;
--GRANT EXECUTE ON OBJECT::dbo.ufnTbl_GetAllForeignKeyRelationships TO public;

GO
PRINT 'Executed ufnTbl_GetAllForeignKeyRelationships.sql';
GO
