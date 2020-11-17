Use master;
CREATE RESOURCE POOL [sbsPool] WITH(min_cpu_percent=20,
max_cpu_percent=50,
min_memory_percent=20,
max_memory_percent=50)
GO
ALTER RESOURCE GOVERNOR RECONFIGURE;
GO