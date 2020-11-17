

declare @TblName as nvarchar(250)
,@ConstraintName as nvarchar(250)
,@SchemaName as nvarchar(250)  ;

set @SchemaName = 'dbo'; 
set @TblName = 'HFit_HealthAssesmentUserRiskCategory' ;
set @ConstraintName  = 'DEFAULT_HFit_HealthAssesmentUserRiskCategory_HARiskCategoryNodeGUID' ;

SELECT 
count(*)
    FROM sys.objects
    WHERE type_desc LIKE '%CONSTRAINT'
	   and SCHEMA_NAME(schema_id) = @SchemaName
	   and OBJECT_NAME(OBJECT_ID) = @ConstraintName
        AND OBJECT_NAME(parent_object_id)= @TblName 


SELECT 
    OBJECT_NAME(OBJECT_ID) AS NameofConstraint
        ,SCHEMA_NAME(schema_id) AS SchemaName
        ,OBJECT_NAME(parent_object_id) AS TableName
        ,type_desc AS ConstraintType
    FROM sys.objects
    WHERE type_desc LIKE '%CONSTRAINT'
	   and SCHEMA_NAME(schema_id) = @SchemaName
	   and OBJECT_NAME(OBJECT_ID) = @ConstraintName
        AND OBJECT_NAME(parent_object_id)= @TblName 
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
