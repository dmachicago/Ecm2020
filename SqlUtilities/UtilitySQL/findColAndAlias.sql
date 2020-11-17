select name,* from syscolumns
where id in (select id from sysobjects
where name = 'view_EDW_HealthAssesmentDeffinition') 
inner join information_schema.view_column_usage VCU
	on VCU.

select *
from information_schema.view_column_usage
where view_name = 'view_EDW_HealthAssesmentDeffinition'

select *
from information_schema.view_column_usage
where view_name = 'View_HFit_HealthAssesmentAnswers'

select *
from information_schema.view_column_usage
where view_name = 'View_HFit_HealthAssesmentPredefinedAnswer_Joined'

select *
from information_schema.view_column_usage
where view_name = 'View_CMS_Tree_Joined'

select *
from information_schema.columns
where TABLE_NAME = 'CMS_TREE'
