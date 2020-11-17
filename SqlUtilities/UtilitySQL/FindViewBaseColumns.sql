alter proc wdmFindViewBaseColumns @SchemaName nvarchar(50), @VIEWNAME nvarchar(80)
as
--*********************************************************************
--W. Dale Miller - find the associated table columns used within a view
--July 2005 - Developed to decompress nested views
--USE: exec wdmFindViewBaseColumns 'dbo', 'view_EDW_HealthAssesment'
--*********************************************************************
SELECT cu.VIEW_NAME, c.TABLE_NAME, c.COLUMN_NAME, c.DATA_TYPE, c.IS_NULLABLE
	FROM    INFORMATION_SCHEMA.VIEW_COLUMN_USAGE AS cu
			JOIN    INFORMATION_SCHEMA.COLUMNS AS c
			ON      c.TABLE_SCHEMA  = cu.TABLE_SCHEMA
			AND     c.TABLE_CATALOG = cu.TABLE_CATALOG
			AND     c.TABLE_NAME    = cu.TABLE_NAME
			AND     c.COLUMN_NAME   = cu.COLUMN_NAME
	WHERE   cu.VIEW_NAME = @VIEWNAME
			AND cu.VIEW_SCHEMA = @SchemaName
go

SELECT view_name, Table_Name
FROM INFORMATION_SCHEMA.VIEW_TABLE_USAGE
WHERE View_Name = 'view_EDW_HealthAssesment'
--ORDER BY view_name, table_name
union
SELECT view_name, Table_Name
FROM INFORMATION_SCHEMA.VIEW_TABLE_USAGE
WHERE View_Name = 'View_HFit_HealthAssesmentQuestions'
--ORDER BY view_name, table_name
union
SELECT view_name, Table_Name
FROM INFORMATION_SCHEMA.VIEW_TABLE_USAGE
WHERE View_Name in ('View_HFit_HealthAssesmentMatrixQuestion_Joined'
,'View_HFit_HealthAssesmentMultipleChoiceQuestion_Joined'
,'View_HFit_HealthAssessmentFreeForm_Joined')
--ORDER BY view_name, table_name
union
SELECT view_name, Table_Name
FROM INFORMATION_SCHEMA.VIEW_TABLE_USAGE
WHERE View_Name in ('View_CMS_Tree_Joined',
'View_CMS_Tree_Joined',
'View_CMS_Tree_Joined')
--ORDER BY view_name, table_name
union
SELECT view_name, Table_Name
FROM INFORMATION_SCHEMA.VIEW_TABLE_USAGE
WHERE View_Name in ('View_CMS_Tree_Joined_Linked',
'View_CMS_Tree_Joined_Regular',
'View_COM_SKU')
ORDER BY view_name, table_name
