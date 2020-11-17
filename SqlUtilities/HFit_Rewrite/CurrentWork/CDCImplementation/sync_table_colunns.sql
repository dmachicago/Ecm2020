
select 'Alter table ' +table_name + ' add ' + column_name + ' ' + data_type + ' null ' + char(10) + 'GO'
from KenticoCMS_DataMart_X.information_schema.columns where table_name = 'BASE_View_EDW_HealthAssesmentQuestions'
and column_name not in
(
select column_name from DataMartPlatform.information_schema.columns where table_name = 'BASE_View_EDW_HealthAssesmentQuestions'
)
