create procedure UTIL_ListAllForeignKeyRelationships (@TblName nvarchar(80))
as
--*************************************************************************
--WDM : Pass in a table name and get all FK Rels both up and down the chain
--USE:	exec UTIL_ListAllForeignKeyRelationships 'CMS_TREE'
--*************************************************************************
SELECT 
	  KP.TABLE_SCHEMA PK_Schema
	, KP.TABLE_NAME PK_Table
	, KP.COLUMN_NAME PK_Column
	, KF.TABLE_SCHEMA FK_Schema
	, KF.TABLE_NAME FK_Table
	, KF.COLUMN_NAME FK_Column
	, RC.CONSTRAINT_NAME FK_CONSTRAINT_Name
	, RC.UNIQUE_CONSTRAINT_NAME PK_Name
	, RC.MATCH_OPTION MatchOption
	, RC.UPDATE_RULE UpdateRule
	, RC.DELETE_RULE DeleteRule
FROM INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS RC
JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE KF ON RC.CONSTRAINT_NAME = KF.CONSTRAINT_NAME
JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE KP ON RC.UNIQUE_CONSTRAINT_NAME = KP.CONSTRAINT_NAME

where KP.TABLE_NAME = @TblName or  KF.TABLE_NAME = @TblName

order by KP.TABLE_SCHEMA
, KP.TABLE_NAME 
, KP.COLUMN_NAME

--GRANT EXECUTE ON OBJECT::dbo.UTIL_ListAllForeignKeyRelationships TO public;
