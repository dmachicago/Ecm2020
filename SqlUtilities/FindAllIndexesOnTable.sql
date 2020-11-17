select 
     o.name as TableName, 
	 i.name as IndexName,    
    ic.key_ordinal as ColumnOrder,
    ic.is_included_column as IsIncluded, 
    co.[name] as ColumnName
from sys.indexes i 
join sys.objects o on i.object_id = o.object_id
join sys.index_columns ic on ic.object_id = i.object_id 
    and ic.index_id = i.index_id
join sys.columns co on co.object_id = i.object_id 
    and co.column_id = ic.column_id
where i.[type] = 2 
and i.is_unique = 0 
and i.is_primary_key = 0
and o.[type] = 'U'
and o.name in ('HFit_HealthAssesmentUserStarted',
'HFit_HealthAssesmentUserModule',
'HFit_HealthAssesmentUserRiskCategory',
'HFit_HealthAssesmentUserRiskArea',
'HFit_HealthAssesmentUserQuestion',
'HFit_HealthAssesmentUserQuestionGroupResults',
'HFit_HealthAssesmentUserAnswers',
'CMS_Class',
'CMS_Document',
'CMS_Site',
'CMS_Tree',
'CMS_User',
'CMS_UserSettings',
'CMS_UserSite',
'COM_SKU',
'HFit_Account',
'HFit_HACampaign',
'HFit_HealthAssesmentMatrixQuestion',
'HFit_HealthAssesmentMultipleChoiceQuestion',
'HFit_HealthAssesmentUserAnswers',
'HFit_HealthAssesmentUserModule',
'HFit_HealthAssesmentUserQuestion',
'HFit_HealthAssesmentUserQuestionGroupResults',
'HFit_HealthAssesmentUserRiskArea',
'HFit_HealthAssesmentUserRiskCategory',
'HFit_HealthAssesmentUserStarted',
'HFit_HealthAssessment',
'HFit_HealthAssessmentFreeForm')

AND (i.name like '%_PI' or i.name like 'PI%' or i.name like '%_CI' or i.name like 'CI%')

--and ic.is_included_column = 0
order by o.[name], i.[name], ic.is_included_column, ic.key_ordinal
;
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
