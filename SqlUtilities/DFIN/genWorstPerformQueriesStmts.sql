
DECLARE @ReviewOnly INT= 1;

/*
SELECT TOP 100 'CPU' as TypeRun,  *
  FROM [master].[dbo].[DFS_CPU_BoundQry2000]
union ALL
SELECT TOP 100 'IO' as TypeRun, *
  FROM [master].[dbo].[DFS_IO_BoundQry2000]
  where RunID = 87
  and DBName like 'BNYUK%'
  order by TypeRun, [RunDate] desc
*/

SET NOCOUNT ON;
DECLARE @value BIGINT;
EXEC @value = sp_UTIL_GetSeq;
PRINT 'RUNID: ' + CAST(@value AS NVARCHAR(10));
DECLARE @CmdTable TABLE(cmd NVARCHAR(4000));
DECLARE @DB NVARCHAR(250);
DECLARE @stmt NVARCHAR(4000);
DECLARE C CURSOR
FOR SELECT name
    FROM   sys.databases
    WHERE  name NOT IN('master', 'model', 'msdb', 'tempdb', 'DBA', 'Logging')
    --and (name like 'BNY_%' or name like 'BNYUK_%')
    AND state_desc = 'ONLINE';
OPEN C;
FETCH NEXT FROM C INTO @DB;
WHILE @@FETCH_STATUS = 0
    BEGIN
        SET @stmt = 'PRINT ''USING: ' + @DB + ''';';
        INSERT INTO          @CmdTable(cmd)
        VALUES               (@stmt);
        SET @stmt = 'USE ' + @DB;
        INSERT INTO          @CmdTable(cmd)
        VALUES               (@stmt);
		SET @stmt = 'GO';
		INSERT INTO          @CmdTable(cmd) VALUES (@stmt);
        SET @stmt = 'exec DFINAnalytics.dbo.UTIL_IO_BoundQry2000 ''' + @DB + ''',' + CAST(@value AS NVARCHAR(10)) + ';';
        INSERT INTO          @CmdTable(cmd)
        VALUES               (@stmt);
        SET @stmt = 'GO';
		INSERT INTO          @CmdTable(cmd) VALUES (@stmt);
        SET @stmt = 'exec DFINAnalytics.dbo.UTIL_CPU_BoundQry2000 ''' + @DB + ''',' + CAST(@value AS NVARCHAR(10)) + ';';
        INSERT INTO          @CmdTable(cmd)
        VALUES               (@stmt);
        SET @stmt = 'GO';
        INSERT INTO          @CmdTable(cmd)
        VALUES               (@stmt);
        FETCH NEXT FROM C INTO @DB;
    END;
CLOSE C;
DEALLOCATE C;
IF @ReviewOnly = 1
    SELECT *
    FROM   @CmdTable;
ELSE
    BEGIN
        DECLARE @CMD NVARCHAR(4000);
        DECLARE C CURSOR
        FOR SELECT cmd
            FROM   @CmdTable;
        OPEN C;
        FETCH NEXT FROM C INTO @CMD;
        WHILE @@FETCH_STATUS = 0
            BEGIN
                IF @CMD <> 'GO'
                    BEGIN
                        PRINT 'EXECUTING: ' + @CMD;
                        EXEC sp_executesql @CMD;
                END;
                FETCH NEXT FROM C INTO @CMD;
END;
        CLOSE C;
        DEALLOCATE C;
END;
SET NOCOUNT OFF;