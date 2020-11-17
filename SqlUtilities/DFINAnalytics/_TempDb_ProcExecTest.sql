IF object_id('tempdb..#genInsertSql') IS NOT NULL
drop procedure #genInsertSql
go
CREATE procedure #genInsertSql ( 
                 @FromTBL NVARCHAR(250) , 
                 @IntoTBL NVARCHAR(250),
				 @stmt nvarchar(max) OUTPUT
                              )
AS
    BEGIN
        DECLARE @colx NVARCHAR(MAX) = '';
		/*DECLARE @stmt VARCHAR(MAX) = '';*/
        DECLARE @stmtcopy VARCHAR(MAX) = '';
        DECLARE @colname VARCHAR(250) = '';
        DECLARE @tempname VARCHAR(250) = '';

        SET @tempname = SUBSTRING(@FromTBL , 2 , 999);
        SET @stmt = 'INSERT INTO ' + @IntoTBL + ' (' ;

        DECLARE db_cursor CURSOR
        FOR SELECT c.name + ',' + CHAR(10) AS ColName
            FROM tempdb.sys.tables AS t INNER JOIN tempdb.sys.columns AS c ON t.object_id = c.object_id
            WHERE t.Name LIKE '%' + @tempname + '%';
        OPEN db_cursor;
        
        FETCH NEXT FROM db_cursor INTO @colname;
        WHILE @@FETCH_STATUS = 0
            BEGIN
                set @colx = @colx + '    ' + @colname ;
                FETCH NEXT FROM db_cursor INTO @colname;
            END;
        CLOSE db_cursor;
        DEALLOCATE db_cursor;

        SET @colx = RTRIM(@colx);
        SET @colx = CASE @colx
                        WHEN NULL
                        THEN NULL
                        ELSE ( CASE LEN(@colx)
                                   WHEN 0
                                   THEN @colx
                                   ELSE LEFT(@colx , LEN(@colx) - 2)
                               END )
                    END;
        --SET @stmtcopy = REPLACE(@colx , 'B.' , 'A.');
		SET @stmtcopy = @colx;
        SET @stmt = @stmt + CHAR(10) + @colx +char(10) +')' + CHAR(10) + 'Select ' +char(10) + @stmtcopy + CHAR(10) + ' From ' + @FromTBL + ';';
		return ;
        --RETURN @stmt;
    END;
GO
go
IF object_id('tempdb..#proc_DFS_DB2Skip') IS NOT NULL
drop procedure #proc_DFS_DB2Skip
go
create procedure #proc_DFS_DB2Skip(@DB nvarchar(100))
as
begin 
declare @rc int = 0 ;

if @Db in ('model','master','DBA','msdb')
	return 1
else 
	return 0

end 
go
IF object_id('tempdb..#sp_PrintImmediate') IS NOT NULL
drop procedure #sp_PrintImmediate
go
-- DROP PROCEDURE #sp_PrintImmediate;
CREATE PROCEDURE #sp_PrintImmediate (@MSG AS NVARCHAR(MAX))
AS
    BEGIN
        RAISERROR(@MSG, 10, 1) WITH NOWAIT;
    END;
go
IF object_id('tempdb..#sp_UTIL_CPU_BoundQry2000') IS NOT NULL
drop procedure #sp_UTIL_CPU_BoundQry2000
go
-- DROP PROCEDURE #sp_UTIL_CPU_BoundQry2000
CREATE PROCEDURE #sp_UTIL_CPU_BoundQry2000(@NextID BIGINT = NULL)
AS
    BEGIN
		print 'USING DB: ' + db_name();
        DECLARE @RunDate AS DATETIME= GETDATE();
        DECLARE @msg VARCHAR(100);
        DECLARE @DBNAME VARCHAR(100)= DB_NAME();
		set @NextID = (select DATEDIFF(SECOND, '20000101', getdate()));
		declare @validdb int = 0;
		declare @db as nvarchar(150) = db_name();
		exec @validdb = #proc_DFS_DB2Skip @db;
        IF @validdb = 1
            BEGIN
                SET @msg = 'SKIPPING: ' + @DBNAME;
                EXEC #sp_printimmediate 
                     @msg;
                RETURN;
        END;
        SET @msg = 'UTIL CPU DB: ' + @DBNAME;
        EXEC #sp_printimmediate 
             @msg;
        IF OBJECT_ID('tempdb..#DFS_IO_BoundQry2000') IS NOT NULL
            BEGIN
                DROP TABLE #DFS_IO_BoundQry2000;
        END;
        SELECT TOP 10 @@SERVERNAME AS SVRName, 
                      DB_NAME() AS DBName, 
                      st.text, 
                      qp.query_plan, 
                      qs.*, 
                      GETDATE() AS RunDate, 
                      @@VERSION AS SSVer, 
                      15 AS RunID, 
                      NEWID() AS [UID], 
                      0 AS Processed
        INTO [#DFS_CPU_BoundQry2000]
        FROM sys.dm_exec_query_stats AS qs
                  CROSS APPLY sys.dm_exec_sql_text(qs.plan_handle) AS st
                       CROSS APPLY sys.dm_exec_query_plan(qs.plan_handle) AS qp
        ORDER BY total_worker_time DESC;
		select * from [#DFS_CPU_BoundQry2000];
		/*
        DECLARE @s NVARCHAR(MAX);
        exec #genInsertSql '#DFS_CPU_BoundQry2000', 'DFINAnalytics.dbo.DFS_CPU_BoundQry2000', @stmt = @s OUTPUT;
		select  @s;
        EXECUTE sp_executesql @s;
		*/
    END;
GO
exec #sp_UTIL_CPU_BoundQry2000 -99;
