select s.*, r.*
from sys.dm_exec_sessions s
left outer join sys.dm_exec_requests r on r.session_id = s.session_id
where s.session_id >= 50 --retrieve only user spids
order by host_name, program_name