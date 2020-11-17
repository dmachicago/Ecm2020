
--WDM
--Generate alter statements to modify datetime to datetime2
select 'alter table ' + table_name + ' alter column ' + column_name + ' datetime2 (7)' as MSQL from information_schema.columns as COLS
where COLS.table_name not in (Select table_name from information_schema.views as VIEWS)
and data_type = 'datetime' and table_name like '%EDW%'

