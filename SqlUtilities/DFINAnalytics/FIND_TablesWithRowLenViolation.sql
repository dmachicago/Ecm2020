DROP TABLE IF EXISTS #ROWSIZE;

Select TABLE_NAME, column_name, DATA_TYPE,
sum(
case when DATA_TYPE in ('datetime', 'double', 'bigint', 'decimal', 'float', 'Smallint', 'Datetime2') then 8
        when DATA_TYPE in ('Datetimeoffset') then 10
		when DATA_TYPE in ('int') then 4
		when data_type in ('bit') then 4
		when data_type in ('tinyint') then 1
		when data_type in ('Uniqueidentifier') then 16		
       Else CHARACTER_OCTET_LENGTH 
	   end) AS [ROW_LEN],
--column_name
count(*) as OCCURS
into #ROWSIZE
From INFORMATION_SCHEMA.columns 
group by TABLE_NAME, column_name, DATA_TYPE ;

select * from #ROWSIZE
select TABLE_NAME, sum(row_len) ROWLEN from #ROWSIZE group by TABLE_NAME order by ROWLEN desc ;
