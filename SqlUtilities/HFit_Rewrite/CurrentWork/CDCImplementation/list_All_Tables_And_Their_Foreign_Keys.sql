
select * from MART_SYNC_Table_FKRels

SELECT
	   OBJECT_NAME (f.referenced_object_id) AS ParentTable
     , COL_NAME (fc.referenced_object_id, fc.referenced_column_id) AS ParentColumnName
     ,  OBJECT_NAME (f.parent_object_id) AS ChildTable
     , COL_NAME (fc.parent_object_id , fc.parent_column_id) AS ChildColumnName     
     , f.name AS ForeignKey
FROM sys.foreign_keys AS f
     INNER JOIN sys.foreign_key_columns AS fc
     ON
       f.OBJECT_ID = fc.constraint_object_id
order by 1,2,3,4

exec proc_SetPrimaryKeyToSurrogateKey BASE_HFit_HealthAssesmentUserRiskCategory
exec proc_SetPrimaryKeyToSurrogateKey BASE_HFit_HealthAssesmentUserAnswers
exec proc_SetPrimaryKeyToSurrogateKey BASE_HFit_HealthAssesmentUserQuestionGroupResults
exec proc_SetPrimaryKeyToSurrogateKey BASE_HFit_HealthAssesmentUserRiskArea
exec proc_SetPrimaryKeyToSurrogateKey BASE_HFit_HealthAssesmentUserModule
