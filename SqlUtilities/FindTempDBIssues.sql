--Determining the Amount of Free Space in tempdb
--The following query returns the total number of free pages and total free space in megabytes (MB) available in all files in tempdb.
SELECT SUM(unallocated_extent_page_count) AS [free pages], 
(SUM(unallocated_extent_page_count)*1.0/128) AS [free space in MB]
FROM sys.dm_db_file_space_usage;

--Determining the Amount Space Used by the Version Store
--The following query returns the total number of pages used by the version store and the total space in MB used by the version store in tempdb.
SELECT SUM(version_store_reserved_page_count) AS [version store pages used],
(SUM(version_store_reserved_page_count)*1.0/128) AS [version store space in MB]
FROM sys.dm_db_file_space_usage;

--Determining the Longest Running Transaction
--If the version store is using a lot of space in tempdb, you must determine what is the longest running transaction. Use this query to list the active transactions in order, by longest running transaction.
SELECT transaction_id
FROM sys.dm_tran_active_snapshot_database_transactions 
ORDER BY elapsed_time_seconds DESC;

--A long running transaction that is not related to an online index operation requires a large version store. This version store keeps all the versions generated since the transaction started. Online index build transactions can take a long time to finish, but a separate version store dedicated to online index operations is used. Therefore, these operations do not prevent the versions from other transactions from being removed. For more information, see Row Versioning Resource Usage.
--Determining the Amount of Space Used by Internal Objects
--The following query returns the total number of pages used by internal objects and the total space in MB used by internal objects in tempdb.
SELECT SUM(internal_object_reserved_page_count) AS [internal object pages used],
(SUM(internal_object_reserved_page_count)*1.0/128) AS [internal object space in MB]
FROM sys.dm_db_file_space_usage;

--Determining the Amount of Space Used by User Objects
--The following query returns the total number of pages used by user objects and the total space used by user objects in tempdb.
SELECT SUM(user_object_reserved_page_count) AS [user object pages used],
(SUM(user_object_reserved_page_count)*1.0/128) AS [user object space in MB]
FROM sys.dm_db_file_space_usage;

--Determining the Total Amount of Space (Free and Used)
--The following query returns the total amount of disk space used by all files in tempdb.
SELECT SUM(size)*1.0/128 AS [size in MB]
FROM tempdb.sys.database_files
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
