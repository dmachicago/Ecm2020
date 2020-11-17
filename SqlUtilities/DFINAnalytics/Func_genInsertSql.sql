--* USEDFINAnalytics
GO

IF EXISTS ( SELECT *
     FROM sys.objects
     WHERE object_id = OBJECT_ID(N'[dbo].[genInsertSql]')
    AND 
    type IN ( N'FN' , N'IF' , N'TF' , N'FS' , N'FT'
     )
   ) 
    BEGIN
 DROP FUNCTION [dbo].[genInsertSql];
END;
GO

--DROP PROCEDURE genInsertSql;
--GO

CREATE function genInsertSql ( 
   @FromTBL NVARCHAR(150) , 
   @IntoTBL NVARCHAR(150)
    )
RETURNS VARCHAR(max)
AS
    BEGIN
 DECLARE @colx NVARCHAR(MAX) = '';
		DECLARE @stmt VARCHAR(MAX) = '';
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
 SET @stmt = 'INSERT INTO ' + @IntoTBL + ' (' + CHAR(10) + @colx +char(10) +')' + CHAR(10) + 'Select ' +char(10) + @stmtcopy + CHAR(10) + ' From ' + @FromTBL + ';';

 RETURN @stmt;
    END;
GO

/*************  USAGE  *************/
/*
IF OBJECT_ID('tempdb..#DFS_IO_BoundQry2000') IS NOT NULL
    BEGIN
 DROP TABLE #DFS_IO_BoundQry2000;
END;

SELECT TOP 10 @@SERVERNAME AS SVRName , 'DBNAME' AS DBName , st.text , qp.query_plan , qs.* , GETDATE() AS RunDate , @@version AS SSVER , 333 AS RunID , NEWID() AS [UID] , 0 AS processed
INTO [#DFS_IO_BoundQry2000]
FROM sys.dm_exec_query_stats AS qs CROSS APPLY sys.dm_exec_sql_text ( qs.plan_handle
  ) AS st
  CROSS APPLY sys.dm_exec_query_plan ( qs.plan_handle
    ) AS qp
ORDER BY total_logical_reads DESC;

DECLARE @FromTable NVARCHAR(150) = ;
DECLARE @IntoTable NVARCHAR(150);

DECLARE @s NVARCHAR(MAX);

set @s = dbo.genInsertSql ('#DFS_IO_BoundQry2000' , 'dbo.DFS_IO_BoundQry2000');

PRINT @s;

*/