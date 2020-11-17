CREATE WORKLOAD GROUP [sbsSSMSgroup] WITH(group_max_requests=0,
importance=Medium,
request_max_cpu_time_sec=50,
request_max_memory_grant_percent=50,
request_memory_grant_timeout_sec=0,
max_dop=0) USING [sbsPool]
GO
ALTER RESOURCE GOVERNOR RECONFIGURE;
GO