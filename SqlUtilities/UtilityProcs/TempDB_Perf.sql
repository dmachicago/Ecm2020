--WDM - 03.13.2010
--This query hits the dynamic management function (DMF) sys.dm_io_virtual_file_stats for all of the TempDB data --files and lists out how fast they’re responding to write (and read) requests:

SELECT files.physical_name, files.name,
    stats.num_of_writes, (1.0 * stats.io_stall_write_ms / stats.num_of_writes) AS avg_write_stall_ms,
    stats.num_of_reads, (1.0 * stats.io_stall_read_ms / stats.num_of_reads) AS avg_read_stall_ms
FROM sys.dm_io_virtual_file_stats(2, NULL) as stats
INNER JOIN master.sys.master_files AS files
    ON stats.database_id = files.database_id
    AND stats.file_id = files.file_id
WHERE files.type_desc = 'ROWS'