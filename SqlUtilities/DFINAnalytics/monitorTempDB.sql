
/*
Monitor tempdb database files and gather other information
To monitor the SQL Server tempdb database statistics, you can 
execute the following query. The first part of the query reveals 
the currently allocated size of data file, log file and space used 
by log file:
*/

--First part of the script
SELECT    instance_name AS 'Database', 
   [Data File(s) Size (KB)] / 1024 AS [Data file (MB)], 
   [Log File(s) Size (KB)] / 1024 AS [Log file (MB)], 
   [Log File(s) Used Size (KB)] / 1024 AS [Log file space used (MB)]
FROM
(
    SELECT *
    FROM   sys.dm_os_performance_counters
    WHERE  counter_name IN('Data File(s) Size (KB)', 'Log File(s) Size (KB)', 'Log File(s) Used Size (KB)')
    AND instance_name = 'tempdb'
) AS A PIVOT(MAX(cntr_value) FOR counter_name IN([Data File(s) Size (KB)], 
  [LOG File(s) Size (KB)], 
  [Log File(s) Used Size (KB)])) AS B;
GO
--
--Second part of the script
SELECT create_date AS [Creation date], 
  recovery_model_desc [Recovery model]
FROM   sys.databases
WHERE  name = 'tempdb';
GO

--[#TEMP_IDX_FRAG]
--Monitor temporary tables space usage
--Additionally, if a large amount of data is stored in temporary 
--tables due to the higher SQL server activity, check the number 
--of rows, and used/reserved space of each of temporary tables 
--which had been created in a specific database:
SELECT tb.name AS [Temporary table name], 
  stt.row_count AS [Number of rows], 
  stt.used_page_count * 8 AS [Used space (KB)], 
  stt.reserved_page_count * 8 AS [Reserved space (KB)]
FROM   tempdb.sys.partitions AS prt
INNER JOIN tempdb.sys.dm_db_partition_stats AS stt
    ON prt.partition_id = stt.partition_id
  AND prt.partition_number = stt.partition_number
INNER JOIN tempdb.sys.tables AS tb
    ON stt.object_id = tb.object_id
ORDER BY tb.name;

----* USEthe following query to obtain information on space usage by specific tempdb objects:
SELECT(SUM(unallocated_extent_page_count) / 128) AS [Free space (MB)], 
 SUM(internal_object_reserved_page_count) * 8 AS [Internal objects (KB)], 
 SUM(user_object_reserved_page_count) * 8 AS [User objects (KB)], 
 SUM(version_store_reserved_page_count) * 8 AS [Version store (KB)]
FROM  sys.dm_db_file_space_usage
--database_id '2' represents tempdb
WHERE database_id = 2;

--To get the total database size without details, --* USEthis query:
SELECT SUM(size) / 128 AS [Total database size (MB)]
FROM   tempdb.sys.database_files;