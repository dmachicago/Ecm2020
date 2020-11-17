SELECT 
    DB_NAME(dbid) as DBName, 
    COUNT(dbid) as NumberOfConnections,
    loginame as LoginName
FROM
    sys.sysprocesses
WHERE 
    dbid > 0
GROUP BY 
    dbid, loginame

-- select top 10 * from sys.sysprocesses
--And this gives the total:

SELECT 
    COUNT(dbid) as TotalConnections
FROM
    sys.sysprocesses
WHERE 
    dbid > 0