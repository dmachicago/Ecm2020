
GO

/*
drop TABLE DFS_SSIS_RunStats
*/

IF EXISTS
(
    SELECT 1
    FROM sys.tables
    WHERE name = 'DFS_SSIS_RunStats'
)
    DROP TABLE DFS_SSIS_RunStats;
GO
BEGIN
    CREATE TABLE DFS_SSIS_RunStats
    (SVRNAME        NVARCHAR(150) NOT NULL, 
     DBNAME         NVARCHAR(150) NOT NULL, 
     STEP_Name      NVARCHAR(150) NOT NULL, 
     StartTime      DATETIME DEFAULT GETDATE() NOT NULL, 
     EndTime        DATETIME, 
     ElapsedSeconds INT NULL, 
     RowsProcessed  INT NULL
                        DEFAULT 0, 
     [UID]          UNIQUEIDENTIFIER NOT NULL
    );
    CREATE INDEX piDFS_SSIS_RunStats ON DFS_SSIS_RunStats(UID);
END;
GO
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'UTIL_SSIS_RunStats'
)
    BEGIN
        DROP PROCEDURE UTIL_SSIS_RunStats;
END;
GO

/*

delete from DFS_SSIS_RunStats;

exec UTIL_SSIS_RunStats 'TEST_ENTRY3', 0, 'DFS_QryOptStats' ;
exec UTIL_SSIS_RunStats 'TEST_ENTRY3', 0, 'DFS_QryOptStats' ;

select * from DFS_SSIS_RunStats order by EndTime desc, Step_NAme, SvrName, DBNAME,starttime ;

update DFS_SSIS_RunStats set ElapsedSeconds = datediff(second, StartTime,EndTime) where ElapsedSeconds is null;
select *, datediff(second, StartTime,EndTime) as ET from DFS_SSIS_RunStats ;

select SvrName, DBName, count(*) as cnt 
	from DFS_SSIS_RunStats group by SvrName, DBNAME;

*/

CREATE PROCEDURE UTIL_SSIS_RunStats
(@StepName      NVARCHAR(150), 
 @RowsProcessed INT, 
 @TableToTrack  NVARCHAR(150) = NULL
)
AS
    BEGIN
        IF(DB_NAME() = 'DFINAnalytics')
            BEGIN
                PRINT 'CANNOT RUN proc UTIL_SSIS_RunStats against database DFINAnalytics, returning';
                RETURN;
        END;
        DECLARE @i INT= 0;
        SET @i =
        (
            SELECT COUNT(1)
            FROM DFS_SSIS_RunStats
            WHERE STEP_Name = @StepName
                  AND EndTime IS NULL
        );
        IF(@i = 0)
            BEGIN
                DECLARE @cnt INT= 0;
                IF(@TableToTrack IS NOT NULL)
                    BEGIN
                        DECLARE @sqlBody VARCHAR(500), @TableCount INT, @SQL NVARCHAR(1000);
                        SELECT @sqlBody = 'from ' + @TableToTrack;
                        SELECT @SQL = N'SELECT @TableCount = COUNT(*) ' + @sqlBody;
                        EXEC sp_executesql 
                             @SQL, 
                             N'@TableCount INT OUTPUT', 
                             @TableCount OUTPUT;
                        SET @cnt = @TableCount;
                        PRINT 'Rows in' + '@cnt = ' + CAST(@cnt AS NVARCHAR(50));
                        INSERT INTO DFS_SSIS_RunStats
                        (SVRNAME, 
                         DBNAME, 
                         STEP_Name, 
                         StartTime, 
                         EndTime, 
                         RowsProcessed, 
                         [UID]
                        )
                        VALUES
                        (@@SERVERNAME, 
                         DB_NAME(), 
                         @StepName, 
                         GETDATE(), 
                         NULL, 
                         @cnt, 
                         NEWID()
                        );
                END;
                    ELSE
                    BEGIN
                        SET @cnt = @RowsProcessed;
                        INSERT INTO DFS_SSIS_RunStats
                        (SVRNAME, 
                         DBNAME, 
                         STEP_Name, 
                         StartTime, 
                         EndTime, 
                         RowsProcessed, 
                         [UID]
                        )
                        VALUES
                        (@@SERVERNAME, 
                         DB_NAME(), 
                         @StepName, 
                         GETDATE(), 
                         NULL, 
                         @cnt, 
                         NEWID()
                        );
                END;
        END;
            ELSE
            BEGIN
                IF(@TableToTrack IS NULL)
                    BEGIN
                        UPDATE DFS_SSIS_RunStats
                          SET 
                              EndTime = GETDATE(), 
                              RowsProcessed = @RowsProcessed
                        WHERE STEP_Name = @StepName
                              AND EndTime IS NULL;
                END;
                    ELSE
                    BEGIN
                        UPDATE DFS_SSIS_RunStats
                          SET 
                              EndTime = GETDATE()
                        WHERE STEP_Name = @StepName
                              AND EndTime IS NULL;
                END;
        END;
    END;
GO
IF EXISTS
(
    SELECT *
    FROM sys.objects
    WHERE [name] = N'trgUpdate_DFS_SSIS_RunStats'
          AND [type] = 'TR'
)
    BEGIN
        DROP TRIGGER [trgUpdate_DFS_SSIS_RunStats];
END;
GO
CREATE TRIGGER [dbo].[trgUpdate_DFS_SSIS_RunStats] ON [DFS_SSIS_RunStats]
FOR UPDATE
AS
     BEGIN
         UPDATE DFS_SSIS_RunStats
           SET 
               DFS_SSIS_RunStats.ElapsedSeconds = DATEDIFF(second, DFS_SSIS_RunStats.StartTime, DFS_SSIS_RunStats.EndTime)
         FROM inserted
         WHERE DFS_SSIS_RunStats.[uid] = inserted.[UID];
     END;
GO
GO
INSERT INTO [dbo].[DFS_QryOptStatsExistingHashes]
       SELECT DISTINCT 
              [query_hash], 
              [query_plan_hash]
       FROM [dbo].[DFS_QryOptStats];
IF EXISTS
(
    SELECT 1
    FROM sys.tables
    WHERE name = 'DFS_QryOptStatsExistingHashes'
)
    DROP TABLE [dbo].[DFS_QryOptStatsExistingHashes];
GO
CREATE TABLE [dbo].[DFS_QryOptStatsExistingHashes]
([query_hash]      [BINARY](8) NULL, 
 [query_plan_hash] [BINARY](8) NULL
)
ON [PRIMARY];
CREATE UNIQUE INDEX pkDFS_QryOptStatsExistingHashes ON DFS_QryOptStatsExistingHashes([query_hash], [query_plan_hash]);
GO
IF EXISTS
(
    SELECT 1
    FROM sys.views
    WHERE name = 'viewQryOptStatsWOExistingHashes'
)
    DROP VIEW viewQryOptStatsWOExistingHashes;
GO

/*
insert into DFS_QryOptStatsExistingHashes
	select distinct [query_hash],[query_plan_hash] from [dbo].[DFS_QryOptStats];
		
select count(*) from [dbo].[DFS_QryOptStats]
select * from viewQryOptStatsWOExistingHashes
*/

CREATE VIEW viewQryOptStatsWOExistingHashes
AS
     SELECT t1.[SvrName], 
            t1.[schemaname], 
            t1.[viewname], 
            t1.[viewid], 
            t1.[databasename], 
            t1.[databaseid], 
            t1.[text], 
            t1.[query_plan], 
            t1.[sql_handle], 
            t1.[statement_start_offset], 
            t1.[statement_end_offset], 
            t1.[plan_generation_num], 
            t1.[plan_handle], 
            t1.[creation_time], 
            t1.[last_execution_time], 
            t1.[execution_count], 
            t1.[total_worker_time], 
            t1.[last_worker_time], 
            t1.[min_worker_time], 
            t1.[max_worker_time], 
            t1.[total_physical_reads], 
            t1.[last_physical_reads], 
            t1.[min_physical_reads], 
            t1.[max_physical_reads], 
            t1.[total_logical_writes], 
            t1.[last_logical_writes], 
            t1.[min_logical_writes], 
            t1.[max_logical_writes], 
            t1.[total_logical_reads], 
            t1.[last_logical_reads], 
            t1.[min_logical_reads], 
            t1.[max_logical_reads], 
            t1.[total_clr_time], 
            t1.[last_clr_time], 
            t1.[min_clr_time], 
            t1.[max_clr_time], 
            t1.[total_elapsed_time], 
            t1.[last_elapsed_time], 
            t1.[min_elapsed_time], 
            t1.[max_elapsed_time], 
            t1.[query_hash], 
            t1.[query_plan_hash], 
            t1.[total_rows], 
            t1.[last_rows], 
            t1.[min_rows], 
            t1.[max_rows], 
            t1.[statement_sql_handle], 
            t1.[statement_context_id], 
            t1.[total_dop], 
            t1.[last_dop], 
            t1.[min_dop], 
            t1.[max_dop], 
            t1.[total_grant_kb], 
            t1.[last_grant_kb], 
            t1.[min_grant_kb], 
            t1.[max_grant_kb], 
            t1.[total_used_grant_kb], 
            t1.[last_used_grant_kb], 
            t1.[min_used_grant_kb], 
            t1.[max_used_grant_kb], 
            t1.[total_ideal_grant_kb], 
            t1.[last_ideal_grant_kb], 
            t1.[min_ideal_grant_kb], 
            t1.[max_ideal_grant_kb], 
            t1.[total_reserved_threads], 
            t1.[last_reserved_threads], 
            t1.[min_reserved_threads], 
            t1.[max_reserved_threads], 
            t1.[total_used_threads], 
            t1.[last_used_threads], 
            t1.[min_used_threads], 
            t1.[max_used_threads], 
            t1.[total_columnstore_segment_reads], 
            t1.[last_columnstore_segment_reads], 
            t1.[min_columnstore_segment_reads], 
            t1.[max_columnstore_segment_reads], 
            t1.[total_columnstore_segment_skips], 
            t1.[last_columnstore_segment_skips], 
            t1.[min_columnstore_segment_skips], 
            t1.[max_columnstore_segment_skips], 
            t1.[total_spills], 
            t1.[last_spills], 
            t1.[min_spills], 
            t1.[max_spills], 
            t1.[RunDate], 
            t1.[SSVER], 
            t1.[UID]
     FROM [dbo].[DFS_QryOptStats] T1
          LEFT JOIN [dbo].[DFS_QryOptStatsExistingHashes] T2 ON T1.query_hash = T2.query_hash
                                                                AND T1.query_plan_hash = T2.query_plan_hash
     WHERE T2.query_hash IS NULL;
GO
IF EXISTS
(
    SELECT 1
    FROM sys.views
    WHERE name = 'viewQrysPlansWOExistingHashes'
)
    DROP VIEW viewQrysPlansWOExistingHashes;
GO

/*
insert into DFS_QryOptStatsExistingHashes
	select distinct [query_hash],[query_plan_hash] from [dbo].[DFS_QryOptStats];
		
select count(*) from [DFS_QrysPlans]
select * from viewQrysPlansWOExistingHashes
*/

CREATE VIEW viewQrysPlansWOExistingHashes
AS
     SELECT T1.[query_hash], 
            t1.[query_plan_hash], 
            t1.[UID], 
            t1.[PerfType], 
            t1.[text], 
            t1.[query_plan], 
            t1.[CreateDate]
     FROM [dbo].[DFS_QrysPlans] T1
          LEFT JOIN [dbo].[DFS_QryOptStatsExistingHashes] T2 ON T1.query_hash = T2.query_hash
                                                                AND T1.query_plan_hash = T2.query_plan_hash
     WHERE T2.query_hash IS NULL;
GO