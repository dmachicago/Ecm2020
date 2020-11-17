
-- find_ColumnDifferencesBetweenMartTables

select 'MART_X' as LOC, * from INFORMATION_SCHEMA.columns D
left join KenticoCMS_DataMart_X.INFORMATION_SCHEMA.columns X
on D.column_name = X.column_name
and D.table_name = X.table_name
and D.table_name = 'BASE_EDW_BiometricViewRejectCriteria'
union
select 'MART_PlatForm' as LOC,* from DataMartPlatform.INFORMATION_SCHEMA.columns D
where table_name in
('BASE_View_HFit_RewardLevel_Joined')
and D.column_name not in 
(select column_name from KenticoCMS_DataMart_X.INFORMATION_SCHEMA.columns 
where table_name = 'BASE_View_HFit_RewardLevel_Joined')

