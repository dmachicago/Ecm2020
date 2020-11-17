--use AdventureWorks2012;
select df.physical_name
, vs.file_id
, vs.file_system_type
, total_mb = vs.total_bytes / 1024. / 1024.
, available_mb = vs.available_bytes / 1024. / 1024.
from sys.database_files df
cross apply sys.dm_os_volume_stats (db_id(),df.file_id) vs;