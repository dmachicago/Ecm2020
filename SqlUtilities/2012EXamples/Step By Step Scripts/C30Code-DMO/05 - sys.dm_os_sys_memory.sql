select total_physical_memory_gb = total_physical_memory_kb / 1024. / 1024.
, available_physical_memory_gb = available_physical_memory_kb / 1024. / 1024.
from sys.dm_os_sys_memory;