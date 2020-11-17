
SELECT top 100 INFORMATION_SCHEMA.VIEW_COLUMN_USAGE.TABLE_NAME, INFORMATION_SCHEMA.COLUMNS.COLUMN_NAME, 
INFORMATION_SCHEMA.COLUMNS.ORDINAL_POSITION, INFORMATION_SCHEMA.COLUMNS.COLUMN_DEFAULT, INFORMATION_SCHEMA.COLUMNS.DATA_TYPE, 
INFORMATION_SCHEMA.COLUMNS.CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.VIEW_COLUMN_USAGE INNER JOIN
INFORMATION_SCHEMA.COLUMNS ON INFORMATION_SCHEMA.VIEW_COLUMN_USAGE.VIEW_NAME = INFORMATION_SCHEMA.COLUMNS.TABLE_NAME AND 
INFORMATION_SCHEMA.VIEW_COLUMN_USAGE.COLUMN_NAME = INFORMATION_SCHEMA.COLUMNS.COLUMN_NAME

select * from INFORMATION_SCHEMA.VIEW_COLUMN_USAGE where view_name = 'view_EDW_HealthAssesment'

select * from INFORMATION_SCHEMA.VIEW_COLUMN_USAGE where view_name = 'View_EDW_HealthAssesmentQuestions'
select * from INFORMATION_SCHEMA.VIEW_COLUMN_USAGE where view_name = 'View_HFit_HealthAssesmentMultipleChoiceQuestion_Joined'
--Title / View_HFit_HealthAssesmentMultipleChoiceQuestion_Joined

View_HFit_HealthAssesmentMultipleChoiceQuestion_Joined

--NodeGUID / View_HFit_HealthAssesmentMatrixQuestion_Joined
--DocumentCulture / View_HFit_HealthAssesmentMatrixQuestion_Joined/
select * from INFORMATION_SCHEMA.VIEW_COLUMN_USAGE where view_name = 'View_HFit_HealthAssesmentMatrixQuestion_Joined'

select * from INFORMATION_SCHEMA.VIEW_COLUMN_USAGE where view_name = 'View_HFit_HACampaign_Joined' and column_name in(
'NodeSiteID'
,'NodeGUID'
,'DocumentCulture'
,'HealthAssessmentID')

select * from INFORMATION_SCHEMA.VIEW_COLUMN_USAGE where view_name = 'View_CMS_Tree_Joined' and column_name in(
'NodeSiteID'
,'NodeGUID'
,'DocumentCulture'
)
select * from INFORMATION_SCHEMA.VIEW_COLUMN_USAGE where view_name = 'View_CMS_Tree_Joined_Regular' and column_name in(
'NodeSiteID'
,'NodeGUID'
,'DocumentCulture'
)
select * from INFORMATION_SCHEMA.VIEW_COLUMN_USAGE where view_name = 'View_CMS_Tree_Joined_Linked' and column_name in(
'NodeSiteID'
,'NodeGUID'
,'DocumentCulture'
)