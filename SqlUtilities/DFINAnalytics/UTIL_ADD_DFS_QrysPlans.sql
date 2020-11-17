
GO

if exists (select 1 from sys.tables where name = 'DFS_QryOptStatsHistory')
	DROP TABLE [dbo].[DFS_QryOptStatsHistory]
GO

CREATE TABLE [dbo].[DFS_QryOptStatsHistory](
	SvrName nvarchar(150) not null,
	DbName nvarchar(150) not null,
	[query_hash] [binary](8) NULL,
	[query_plan_hash] [binary](8) NULL,
	ExecutionDate datetime default getdate(),
	[UID] uniqueidentifier default newid(),
	AffectedRows int default 0 
) ON [PRIMARY]

create clustered index piDFS_QryOptStatsHistory on DFS_QryOptStatsHistory (SvrName,DbName,[query_hash],[query_plan_hash],ExecutionDate) ;
create index piDFS_QryOptStatsHistoryUID on DFS_QryOptStatsHistory ([UID]) ;

go

IF EXISTS ( SELECT 1
            FROM sys.tables
            WHERE name = 'DFS_QryPlanBridge'
          ) 
    BEGIN
        DROP TABLE [dbo].DFS_QryPlanBridge;
END;
GO

IF EXISTS ( SELECT 1
            FROM sys.tables
            WHERE name = 'DFS_QryOptStats'
          ) 
    BEGIN
        DROP TABLE [dbo].[DFS_QryOptStats];
END;
GO

CREATE TABLE [dbo].[DFS_QryOptStats] ( 
             SvrName                           [NVARCHAR](150) NULL , 
             [schemaname]                      [NVARCHAR](150) NULL , 
             [viewname]                        [SYSNAME] NOT NULL , 
             [viewid]                          [INT] NOT NULL , 
             [databasename]                    [NVARCHAR](150) NULL , 
             [databaseid]                      [SMALLINT] NULL , 
             [text]                            [NVARCHAR](MAX) NULL , 
             [query_plan]                      [XML] NULL , 
             [sql_handle]                      [VARBINARY](64) NOT NULL , 
             [statement_start_offset]          [INT] NOT NULL , 
             [statement_end_offset]            [INT] NOT NULL , 
             [plan_generation_num]             [BIGINT] NULL , 
             [plan_handle]                     [VARBINARY](64) NOT NULL , 
             [creation_time]                   [DATETIME] NULL , 
             [last_execution_time]             [DATETIME] NULL , 
             [execution_count]                 [BIGINT] NOT NULL , 
             [total_worker_time]               [BIGINT] NOT NULL , 
             [last_worker_time]                [BIGINT] NOT NULL , 
             [min_worker_time]                 [BIGINT] NOT NULL , 
             [max_worker_time]                 [BIGINT] NOT NULL , 
             [total_physical_reads]            [BIGINT] NOT NULL , 
             [last_physical_reads]             [BIGINT] NOT NULL , 
             [min_physical_reads]              [BIGINT] NOT NULL , 
             [max_physical_reads]              [BIGINT] NOT NULL , 
             [total_logical_writes]            [BIGINT] NOT NULL , 
             [last_logical_writes]             [BIGINT] NOT NULL , 
             [min_logical_writes]              [BIGINT] NOT NULL , 
             [max_logical_writes]              [BIGINT] NOT NULL , 
             [total_logical_reads]             [BIGINT] NOT NULL , 
             [last_logical_reads]              [BIGINT] NOT NULL , 
             [min_logical_reads]               [BIGINT] NOT NULL , 
             [max_logical_reads]               [BIGINT] NOT NULL , 
             [total_clr_time]                  [BIGINT] NOT NULL , 
             [last_clr_time]                   [BIGINT] NOT NULL , 
             [min_clr_time]                    [BIGINT] NOT NULL , 
             [max_clr_time]                    [BIGINT] NOT NULL , 
             [total_elapsed_time]              [BIGINT] NOT NULL , 
             [last_elapsed_time]               [BIGINT] NOT NULL , 
             [min_elapsed_time]                [BIGINT] NOT NULL , 
             [max_elapsed_time]                [BIGINT] NOT NULL , 
             [query_hash]                      [BINARY](8) NULL , 
             [query_plan_hash]                 [BINARY](8) NULL , 
             [total_rows]                      [BIGINT] NULL , 
             [last_rows]                       [BIGINT] NULL , 
             [min_rows]                        [BIGINT] NULL , 
             [max_rows]                        [BIGINT] NULL , 
             [statement_sql_handle]            [VARBINARY](64) NULL , 
             [statement_context_id]            [BIGINT] NULL , 
             [total_dop]                       [BIGINT] NULL , 
             [last_dop]                        [BIGINT] NULL , 
             [min_dop]                         [BIGINT] NULL , 
             [max_dop]                         [BIGINT] NULL , 
             [total_grant_kb]                  [BIGINT] NULL , 
             [last_grant_kb]                   [BIGINT] NULL , 
             [min_grant_kb]                    [BIGINT] NULL , 
             [max_grant_kb]                    [BIGINT] NULL , 
             [total_used_grant_kb]             [BIGINT] NULL , 
             [last_used_grant_kb]              [BIGINT] NULL , 
             [min_used_grant_kb]               [BIGINT] NULL , 
             [max_used_grant_kb]               [BIGINT] NULL , 
             [total_ideal_grant_kb]            [BIGINT] NULL , 
             [last_ideal_grant_kb]             [BIGINT] NULL , 
             [min_ideal_grant_kb]              [BIGINT] NULL , 
             [max_ideal_grant_kb]              [BIGINT] NULL , 
             [total_reserved_threads]          [BIGINT] NULL , 
             [last_reserved_threads]           [BIGINT] NULL , 
             [min_reserved_threads]            [BIGINT] NULL , 
             [max_reserved_threads]            [BIGINT] NULL , 
             [total_used_threads]              [BIGINT] NULL , 
             [last_used_threads]               [BIGINT] NULL , 
             [min_used_threads]                [BIGINT] NULL , 
             [max_used_threads]                [BIGINT] NULL , 
             [total_columnstore_segment_reads] [BIGINT] NULL , 
             [last_columnstore_segment_reads]  [BIGINT] NULL , 
             [min_columnstore_segment_reads]   [BIGINT] NULL , 
             [max_columnstore_segment_reads]   [BIGINT] NULL , 
             [total_columnstore_segment_skips] [BIGINT] NULL , 
             [last_columnstore_segment_skips]  [BIGINT] NULL , 
             [min_columnstore_segment_skips]   [BIGINT] NULL , 
             [max_columnstore_segment_skips]   [BIGINT] NULL , 
             [total_spills]                    [BIGINT] NULL , 
             [last_spills]                     [BIGINT] NULL , 
             [min_spills]                      [BIGINT] NULL , 
             [max_spills]                      [BIGINT] NULL , 
             [RunDate]                         [DATETIME] NULL , 
             [SSVER]                           [NVARCHAR](300) NULL , 
             [UID]                             [UNIQUEIDENTIFIER] NOT NULL
                                     ) 
ON [PRIMARY];
GO

ALTER TABLE [dbo].[DFS_QryOptStats]
ADD DEFAULT(GETDATE()) FOR [RunDate];
GO

ALTER TABLE [dbo].[DFS_QryOptStats]
ADD DEFAULT(NEWID()) FOR [UID];
GO

IF NOT EXISTS ( SELECT 1
                FROM sys.indexes
                WHERE name = 'pi_DFS_QryOptStats_UID'
              ) 
    BEGIN
        PRINT 'Creating index pi_DFS_QryOptStats_UID';
        CREATE NONCLUSTERED INDEX [pi_DFS_QryOptStats_UID] ON [dbo].[DFS_QryOptStats] ( [UID] ASC
                                                                                      );
END;

IF NOT EXISTS ( SELECT 1
                FROM sys.indexes
                WHERE name = 'pi_DFS_QryOptStats_Hash'
              ) 
    BEGIN
        PRINT 'Creating index pi_DFS_QryOptStats_Hash';
        CREATE NONCLUSTERED INDEX [pi_DFS_QryOptStats_Hash] ON [dbo].[DFS_QryOptStats] ( [query_hash] , [query_plan_hash]
                                                                                       );
END;
GO

CREATE TABLE [dbo].[DFS_QryPlanBridge] ( 
             [query_hash]      [BINARY](8) NULL , 
             [query_plan_hash] [BINARY](8) NULL , 
             [PerfType]        [CHAR](1) NOT NULL , 
             [TblType]         [NVARCHAR](10) NOT NULL , 
             [CreateDate]      [DATETIME] NOT NULL , 
             [LastUpdate]      [DATETIME] NOT NULL , 
             [NbrHits]         [INT] NULL
                                       ) 
ON [PRIMARY];
GO

ALTER TABLE [dbo].[DFS_QryPlanBridge]
ADD DEFAULT(GETDATE()) FOR [CreateDate];
GO

ALTER TABLE [dbo].[DFS_QryPlanBridge]
ADD DEFAULT(GETDATE()) FOR [LastUpdate];
GO

ALTER TABLE [dbo].[DFS_QryPlanBridge]
ADD DEFAULT( ( 0 ) ) FOR [NbrHits];
GO

/*ALTER TABLE [dbo].[DFS_QryPlanBridge]  WITH CHECK ADD  CONSTRAINT [FK_DFS_QryPlanBridge_DFS_QrysPlans] FOREIGN KEY([query_hash], [query_plan_hash])
REFERENCES [dbo].[DFS_QrysPlans] ([query_hash], [query_plan_hash])*/

GO

/****** Object:  Table [dbo].[DFS_QrysPlans]    Script Date: 2/18/2019 12:07:36 PM ******/

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

IF NOT EXISTS ( SELECT 1
                FROM sys.tables
                WHERE name = 'DFS_QrysPlans'
              ) 
    BEGIN
        CREATE TABLE [dbo].[DFS_QrysPlans] ( 
                     [query_hash]      [BINARY](8) NULL , 
                     [query_plan_hash] [BINARY](8) NULL , 
                     [UID]             [UNIQUEIDENTIFIER] NOT NULL , 
                     [PerfType]        [NVARCHAR](10) NOT NULL , 
                     [text]            [NVARCHAR](MAX) NULL , 
                     [query_plan]      [XML] NULL , 
                     [CreateDate]      [DATETIME] NOT NULL
                                           ) 
        ON [PRIMARY];
        ALTER TABLE [dbo].[DFS_QrysPlans]
        ADD DEFAULT(NEWID()) FOR [UID];
        ALTER TABLE [dbo].[DFS_QrysPlans]
        ADD DEFAULT(GETDATE()) FOR [CreateDate];
        CREATE NONCLUSTERED INDEX [pi_DFS_QrysPlans_UID] ON [dbo].[DFS_QrysPlans] ( [UID] ASC
                                                                                  ) 
               WITH ( PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , SORT_IN_TEMPDB = OFF , DROP_EXISTING = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON
                    ) ON [PRIMARY];
        CREATE NONCLUSTERED INDEX [pkDFS_QrysPlans] ON [dbo].[DFS_QrysPlans] ( [query_hash] ASC , [query_plan_hash] ASC
                                                                             ) 
               WITH ( PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , DROP_EXISTING = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON
                    ) ON [PRIMARY];
END;
GO

/*
delete from [dbo].[DFS_QrysPlans] 
delete from [dbo].[DFS_QryPlanBridge] 
select * from [dbo].[DFS_QryPlanBridge] 
update [DFS_CPU_BoundQry2000] set processed = 0 
*/
/*

update [dbo].[DFS_CPU_BoundQry2000] set processed = 0 ;
update [dbo].[DFS_IO_BoundQry2000] set processed = 0 ;
update [dbo].[DFS_CPU_BoundQry] set processed = 0 ;
update [dbo].[DFS_CPU_BoundQry] set processed = 0 ;


select count(*) from [dbo].[DFS_CPU_BoundQry2000] where processed = 1 ;
select count(*) from [dbo].[DFS_IO_BoundQry2000] where processed  = 1 ;
select count(*) from [dbo].[DFS_CPU_BoundQry] where processed  = 1 ;
select count(*) from [dbo].[DFS_CPU_BoundQry] where processed  = 1 ;

select count(*) from [dbo].[DFS_CPU_BoundQry2000] where processed = 0 ;
select count(*) from [dbo].[DFS_IO_BoundQry2000] where processed  = 0 ;
select count(*) from [dbo].[DFS_CPU_BoundQry] where processed  = 0 ;
select count(*) from [dbo].[DFS_CPU_BoundQry] where processed  = 0 ;
*/
/** USEDFINAnalytics;*/

GO

/* drop TABLE [dbo].[DFS_CPU_BoundQry]*/

IF EXISTS ( SELECT 1
            FROM sys.tables
            WHERE NAME = 'DFS_CPU_BoundQry'
          ) 
    BEGIN
        DROP TABLE [dbo].[DFS_CPU_BoundQry];
END;

BEGIN
    CREATE TABLE [dbo].[DFS_CPU_BoundQry] ( 
                 [SVRName]                [NVARCHAR](150) NULL , 
                 [DBName]                 [NVARCHAR](150) NULL , 
                 [text]                   [NVARCHAR](MAX) NULL , 
                 [query_plan]             [XML] NULL , 
                 [sql_handle]             [VARBINARY](64) NOT NULL , 
                 [statement_start_offset] [INT] NOT NULL , 
                 [statement_end_offset]   [INT] NOT NULL , 
                 [plan_generation_num]    [BIGINT] NULL , 
                 [plan_handle]            [VARBINARY](64) NOT NULL , 
                 [creation_time]          [DATETIME] NULL , 
                 [last_execution_time]    [DATETIME] NULL , 
                 [execution_count]        [BIGINT] NOT NULL , 
                 [total_worker_time]      [BIGINT] NOT NULL , 
                 [last_worker_time]       [BIGINT] NOT NULL , 
                 [min_worker_time]        [BIGINT] NOT NULL , 
                 [max_worker_time]        [BIGINT] NOT NULL , 
                 [total_physical_reads]   [BIGINT] NOT NULL , 
                 [last_physical_reads]    [BIGINT] NOT NULL , 
                 [min_physical_reads]     [BIGINT] NOT NULL , 
                 [max_physical_reads]     [BIGINT] NOT NULL , 
                 [total_logical_writes]   [BIGINT] NOT NULL , 
                 [last_logical_writes]    [BIGINT] NOT NULL , 
                 [min_logical_writes]     [BIGINT] NOT NULL , 
                 [max_logical_writes]     [BIGINT] NOT NULL , 
                 [total_logical_reads]    [BIGINT] NOT NULL , 
                 [last_logical_reads]     [BIGINT] NOT NULL , 
                 [min_logical_reads]      [BIGINT] NOT NULL , 
                 [max_logical_reads]      [BIGINT] NOT NULL , 
                 [total_clr_time]         [BIGINT] NOT NULL , 
                 [last_clr_time]          [BIGINT] NOT NULL , 
                 [min_clr_time]           [BIGINT] NOT NULL , 
                 [max_clr_time]           [BIGINT] NOT NULL , 
                 [total_elapsed_time]     [BIGINT] NOT NULL , 
                 [last_elapsed_time]      [BIGINT] NOT NULL , 
                 [min_elapsed_time]       [BIGINT] NOT NULL , 
                 [max_elapsed_time]       [BIGINT] NOT NULL , 
                 [query_hash]             [BINARY](8) NULL , 
                 [query_plan_hash]        [BINARY](8) NULL , 
                 [total_rows]             [BIGINT] NULL , 
                 [last_rows]              [BIGINT] NULL , 
                 [min_rows]               [BIGINT] NULL , 
                 [max_rows]               [BIGINT] NULL , 
                 [statement_sql_handle]   [VARBINARY](64) NULL , 
                 [statement_context_id]   [BIGINT] NULL , 
                 [total_dop]              [BIGINT] NULL , 
                 [last_dop]               [BIGINT] NULL , 
                 [min_dop]                [BIGINT] NULL , 
                 [max_dop]                [BIGINT] NULL , 
                 [total_grant_kb]         [BIGINT] NULL , 
                 [last_grant_kb]          [BIGINT] NULL , 
                 [min_grant_kb]           [BIGINT] NULL , 
                 [max_grant_kb]           [BIGINT] NULL , 
                 [total_used_grant_kb]    [BIGINT] NULL , 
                 [last_used_grant_kb]     [BIGINT] NULL , 
                 [min_used_grant_kb]      [BIGINT] NULL , 
                 [max_used_grant_kb]      [BIGINT] NULL , 
                 [total_ideal_grant_kb]   [BIGINT] NULL , 
                 [last_ideal_grant_kb]    [BIGINT] NULL , 
                 [min_ideal_grant_kb]     [BIGINT] NULL , 
                 [max_ideal_grant_kb]     [BIGINT] NULL , 
                 [total_reserved_threads] [BIGINT] NULL , 
                 [last_reserved_threads]  [BIGINT] NULL , 
                 [min_reserved_threads]   [BIGINT] NULL , 
                 [max_reserved_threads]   [BIGINT] NULL , 
                 [total_used_threads]     [BIGINT] NULL , 
                 [last_used_threads]      [BIGINT] NULL , 
                 [min_used_threads]       [BIGINT] NULL , 
                 [max_used_threads]       [BIGINT] NULL , 
                 [RunDate]                [DATETIME] NULL , 
                 [RunID]                  [BIGINT] NULL , 
                 [UID]                    UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL , 
                 [Processed]              INT DEFAULT 0 ,
                                          ) 
    ON [PRIMARY];
    CREATE INDEX piDFS_CPU_BoundQry ON DFS_CPU_BoundQry ( query_hash , query_plan_hash
                                                        );
    CREATE INDEX piDFS_CPU_BoundQry_Processed ON DFS_CPU_BoundQry ( Processed , UID
                                                                  );
    CREATE INDEX pkDFS_CPU_BoundQry ON DFS_CPU_BoundQry ( SvrName , DBName , query_hash , query_plan_hash
                                                        );
END; 
GO

IF EXISTS ( SELECT 1
            FROM sys.procedures
            WHERE name = 'UTIL_Process_QrysPlans'
          ) 
    BEGIN
        DROP PROCEDURE UTIL_Process_QrysPlans;
END;
GO

/* exec dbo.UTIL_Process_QrysPlans */

CREATE PROCEDURE UTIL_Process_QrysPlans
AS
    BEGIN
		declare @SvrName nvarchar(150) = @@servername ;
		declare @DBName nvarchar(150) = db_name() ;
        DECLARE @query_hash BINARY(8);
        DECLARE @query_plan_hash BINARY(8);
        DECLARE @UID UNIQUEIDENTIFIER;
        DECLARE @PerfType CHAR(1);
        DECLARE @TBLID NVARCHAR(10);
        DECLARE @stmt NVARCHAR(1000);
        DECLARE @msg NVARCHAR(1000);
        DECLARE @i INT= 0;
        DECLARE @rc INT= 0;
        DECLARE db_cursor CURSOR
        FOR SELECT query_hash , query_plan_hash , [UID] , 'C' AS PerfType , '2000' AS TBLID
            FROM [dbo].[DFS_CPU_BoundQry2000]
            WHERE Processed = 0
            UNION ALL
            SELECT query_hash , query_plan_hash , [UID] , 'I' AS PerfType , '2000' AS TBLID
            FROM [dbo].[DFS_IO_BoundQry2000]
            WHERE Processed = 0
            UNION ALL
            SELECT query_hash , query_plan_hash , [UID] , 'I' AS PerfType , NULL AS TBLID
            FROM [dbo].[DFS_IO_BoundQry]
            WHERE Processed = 0
            UNION ALL
            SELECT query_hash , query_plan_hash , [UID] , 'C' AS PerfType , NULL AS TBLID
            FROM [dbo].[DFS_CPU_BoundQry]
            WHERE Processed = 0;
        OPEN db_cursor;
        FETCH NEXT FROM db_cursor INTO @query_hash , @query_plan_hash , @UID , @PerfType , @TBLID;
        WHILE @@FETCH_STATUS = 0
            BEGIN
                SET @i = @i + 1;
                SET @msg = 'Processing: ' + CAST(@i AS NVARCHAR(15));
                EXEC PrintImmediate @msg;
                EXEC UTIL_ADD_DFS_QrysPlans @query_hash , @query_plan_hash , @UID , @PerfType , @TBLID;

				--exec UTIL_QryOptStatsHistory  @SvrName,@DbName,@query_hash,@query_plan_hash ;

                FETCH NEXT FROM db_cursor INTO @query_hash , @query_plan_hash , @UID , @PerfType , @TBLID;
            END;
        CLOSE db_cursor;
        DEALLOCATE db_cursor;
        IF ( SELECT COUNT(*)
             FROM [dbo].[DFS_IO_BoundQry2000]
             WHERE Processed = 0
           ) > 0
            BEGIN
                UPDATE [dbo].[DFS_IO_BoundQry2000]
                       SET processed = 1
                WHERE Processed = 0;
        END;
        IF ( SELECT COUNT(*)
             FROM [dbo].[DFS_CPU_BoundQry2000]
             WHERE Processed = 0
           ) > 0
            BEGIN
                UPDATE [dbo].[DFS_CPU_BoundQry2000]
                       SET processed = 1
                WHERE Processed = 0;
        END;
        IF ( SELECT COUNT(*)
             FROM [dbo].[DFS_IO_BoundQry]
             WHERE Processed = 0
           ) > 0
            BEGIN
                UPDATE [dbo].[DFS_IO_BoundQry]
                       SET processed = 1
                WHERE Processed = 0;
        END;
        IF ( SELECT COUNT(*)
             FROM [dbo].[DFS_CPU_BoundQry]
             WHERE Processed = 0
           ) > 0
            BEGIN
                UPDATE [dbo].[DFS_CPU_BoundQry]
                       SET processed = 1
                WHERE Processed = 0;
        END;
    END;
GO

IF EXISTS ( SELECT 1
            FROM sys.procedures
            WHERE name = 'UTIL_ADD_DFS_QrysPlans'
          ) 
    BEGIN
        DROP PROCEDURE UTIL_ADD_DFS_QrysPlans;
END;
GO

/*
delete from [dbo].[DFS_QryPlanBridge];
delete from [dbo].[DFS_QrysPlans];

select top 100 * from [dbo].[DFS_QryPlanBridge];
select top 100 * from [dbo].[DFS_QrysPlans];
select top 10 query_hash, query_plan_hash, [UID], 'C' as PerfType, '2000' TBLID from [dbo].[DFS_CPU_BoundQry2000] 

exec UTIL_ADD_DFS_QrysPlans 0x8FF8B9B49B3D4D91, 0x23760A4951D12752,'BEE20640-A8B2-4414-9531-32BE9CA6CE11', 'C', '2000'

exec UTIL_ADD_DFS_QrysPlans 0xFFEA84560B343DC3, 0x8B1212D7E6280FBC,'13171F02-82B6-424B-82C9-C9B0F82E3981', 'C', '2000'
exec UTIL_ADD_DFS_QrysPlans 0x8FF8B9B49B3D4D91, 0x23760A4951D12752,'BEE20640-A8B2-4414-9531-32BE9CA6CE11', 'C', '2000'

*/

GO

CREATE PROCEDURE UTIL_ADD_DFS_QrysPlans ( 
                 @query_hash      BINARY(8) , 
                 @query_plan_hash BINARY(8) , 
                 @UID             UNIQUEIDENTIFIER , 
                 @PerfType        CHAR(1) , 
                 @TBLID           NVARCHAR(10)
                                        ) 
AS
    BEGIN
        DECLARE @debug INT= 0;
        DECLARE @cnt INT;
        DECLARE @i INT= 0;
        DECLARE @SQL NVARCHAR(MAX);
        DECLARE @PLAN XML;
        DECLARE @Success BIT= 0;
        DECLARE @AddRec BIT= 0;
        IF @debug = 1
            BEGIN
                PRINT '@query_hash: ' + CAST(@query_hash AS NVARCHAR(MAX));
                PRINT '@query_plan_hash: ' + CAST(@query_plan_hash AS NVARCHAR(MAX));
                PRINT '@UID: ' + CAST(@UID AS NVARCHAR(MAX));
                PRINT '@PerfType:' + @PerfType;
                PRINT '@TBLID: ' + @TBLID;
        END;
        IF ( @PerfType = 'C'
             OR 
             @PerfType = 'I' ) 
            BEGIN
                SET @Success = 0;
        END;
            ELSE
            BEGIN
                PRINT 'FAILED @PerfType: must be C or I : "' + @PerfType + '"';
                RETURN @success;
        END;
        IF ( @TBLID = '2000'
             OR 
             @TBLID IS NULL ) 
            BEGIN
                SET @Success = 0;
        END;
            ELSE
            BEGIN
                PRINT 'FAILED @TBLID must be 2000 or NULL: ' + CAST(@success AS NVARCHAR(10));
                RETURN @success;
        END;
        SET @cnt = ( SELECT COUNT(*)
                     FROM dbo.DFS_QryPlanBridge
                     WHERE query_hash = @query_hash
                           AND 
                           query_plan_hash = @query_plan_hash
                   );
        IF ( @cnt = 0 ) 
            BEGIN
                SET @AddRec = 1;
        END;
        IF ( @cnt = 1 ) 
            BEGIN
                UPDATE [dbo].[DFS_QryPlanBridge]
                       SET NbrHits = NbrHits + 1 , LastUpdate = GETDATE()
                WHERE query_hash = @query_hash
                      AND 
                      query_plan_hash = @query_plan_hash;
                SET @success = 1;
                RETURN @success;
        END;
        SET @success = 0;
        IF ( @cnt = 0 ) 
            BEGIN
                IF @PerfType = 'C'
                    BEGIN
                        IF @TBLID = '2000'
                            BEGIN
                                SET @PLAN = ( SELECT query_plan
                                              FROM [dbo].[DFS_CPU_BoundQry2000]
                                              WHERE [UID] = @UID
                                            );
                                SET @SQL = ( SELECT [text]
                                             FROM [dbo].[DFS_CPU_BoundQry2000]
                                             WHERE [UID] = @UID
                                           );
                                SET @success = 1;
                        END;
                            ELSE
                            BEGIN
                                SET @PLAN = ( SELECT query_plan
                                              FROM [dbo].[DFS_CPU_BoundQry]
                                              WHERE [UID] = @UID
                                            );
                                SET @SQL = ( SELECT [text]
                                             FROM [dbo].[DFS_CPU_BoundQry]
                                             WHERE [UID] = @UID
                                           );
                                SET @success = 1;
                        END;
                END;
                IF @PerfType = 'I'
                    BEGIN
                        IF @TBLID = '2000'
                            BEGIN
                                SET @PLAN = ( SELECT query_plan
                                              FROM [dbo].[DFS_IO_BoundQry2000]
                                              WHERE [UID] = @UID
                                            );
                                SET @SQL = ( SELECT [text]
                                             FROM [dbo].[DFS_IO_BoundQry2000]
                                             WHERE [UID] = @UID
                                           );
                                SET @success = 1;
                        END;
                            ELSE
                            BEGIN
                                SET @PLAN = ( SELECT query_plan
                                              FROM [dbo].[DFS_IO_BoundQry]
                                              WHERE [UID] = @UID
                                            );
                                SET @SQL = ( SELECT [text]
                                             FROM [dbo].[DFS_IO_BoundQry]
                                             WHERE [UID] = @UID
                                           );
                                SET @success = 1;
                        END;
                END;
        END;
        IF ( @success <> 1
             OR 
             @AddRec <> 1 ) 
            BEGIN
                PRINT 'select * from XXX where [UID] = ''' + CAST(@UID AS NVARCHAR(60)) + ''';';
        END;
        IF ( @success = 1
             AND 
             @AddRec = 1 ) 
            BEGIN
                INSERT INTO [dbo].[DFS_QryPlanBridge] ( [query_hash] , [query_plan_hash] , [PerfType] , [TblType] , [CreateDate] , [LastUpdate] , [NbrHits]
                                                      ) 
                VALUES ( @query_hash , @query_plan_hash , @PerfType , @TBLID , GETDATE() , GETDATE() , 1
                       );
                INSERT INTO [dbo].[DFS_QrysPlans] ( [query_hash] , [query_plan_hash] , [UID] , [PerfType] , [text] , [query_plan] , [CreateDate]
                                                  ) 
                VALUES ( @query_hash , @query_plan_hash , NEWID() , @PerfType , @SQL , @PLAN , GETDATE()
                       );
                IF @TBLID = '2000'
                   AND 
                   @PerfType = 'I'
                    BEGIN
                        UPDATE [dbo].[DFS_IO_BoundQry2000]
                               SET query_plan = 'SAVED' , [text] = 'SAVED' , Processed = 1
                        WHERE [UID] = @UID;
                        PRINT 'DFS_IO_BoundQry2000: ' + CAST(@i AS NVARCHAR(15)) + ' Processed set to 1';
                END;
                IF @TBLID = '2000'
                   AND 
                   @PerfType = 'C'
                    BEGIN
                        UPDATE [dbo].[DFS_CPU_BoundQry2000]
                               SET query_plan = 'SAVED' , [text] = 'SAVED' , Processed = 1
                        WHERE [UID] = @UID;
                        PRINT 'DFS_CPU_BoundQry2000: ' + CAST(@i AS NVARCHAR(15)) + ' Processed set to 1';
                END;
                IF @TBLID IS NULL
                   AND 
                   @PerfType = 'I'
                    BEGIN
                        UPDATE [dbo].[DFS_IO_BoundQry]
                               SET query_plan = 'SAVED' , [text] = 'SAVED' , Processed = 1
                        WHERE [UID] = @UID;
                        PRINT 'DFS_IO_BoundQry: ' + CAST(@i AS NVARCHAR(15)) + ' Processed set to 1';
                END;
                IF @TBLID IS NULL
                   AND 
                   @PerfType = 'C'
                    BEGIN
                        UPDATE [dbo].[DFS_cpu_BoundQry]
                               SET query_plan = 'SAVED' , [text] = 'SAVED' , Processed = 1
                        WHERE [UID] = @UID;
                        PRINT 'DFS_cpu_BoundQry: ' + CAST(@i AS NVARCHAR(15)) + ' Processed set to 1';
                END;
        END;
        RETURN @success;
    END;

GO

IF EXISTS ( SELECT 1
            FROM sys.procedures
            WHERE name = 'UTIL_QryOptStatsHistory'
          ) 
    BEGIN
        DROP PROCEDURE UTIL_QryOptStatsHistory;
END;
GO

/* exec UTIL_QryOptStatsHistory */

CREATE PROCEDURE UTIL_QryOptStatsHistory 
AS
    BEGIN

		declare @cnt as int = 0 ;

		insert into DFS_QryOptStatsHistory
		SELECT T1.[SVRName]
			  ,T1.[DBName]
			  ,T1.[query_hash]
			  ,T1.[query_plan_hash] 
			  ,T1.RunDate
			  ,t1.[UID]
			  ,t1.total_rows
		  FROM [dbo].[DFS_CPU_BoundQry2000] T1
		left join DFS_QryOptStatsHistory T2
		on T1.SvrName = T2.SvrName 
		and T1.DbName = T2.DbName 
		and T1.query_hash = T2.query_hash
		and T1.query_plan_hash = T2.query_plan_hash
		where T2.SvrName is null

		set @cnt = @@rowcount ;
		print 'UTIL_QryOptStatsHistory added ' + cast(@cnt as nvarchar(50)) + ' new records.';

		insert into DFS_QryOptStatsHistory
		SELECT T1.[SVRName]
			  ,T1.[DBName]
			  ,T1.[query_hash]
			  ,T1.[query_plan_hash] 
			  ,T1.RunDate
			  ,t1.[UID]
			  ,t1.total_rows
		  FROM [dbo].[DFS_CPU_BoundQry] T1
		left join DFS_QryOptStatsHistory T2
		on T1.SvrName = T2.SvrName 
		and T1.DbName = T2.DbName 
		and T1.query_hash = T2.query_hash
		and T1.query_plan_hash = T2.query_plan_hash
		where T2.SvrName is null

		insert into DFS_QryOptStatsHistory
		SELECT T1.[SVRName]
			  ,T1.[DBName]
			  ,T1.[query_hash]
			  ,T1.[query_plan_hash] 
			  ,T1.RunDate
			  ,t1.[UID]
			  ,t1.total_rows
		  FROM [dbo].[DFS_IO_BoundQry2000] T1
		left join DFS_QryOptStatsHistory T2
		on T1.SvrName = T2.SvrName 
		and T1.DbName = T2.DbName 
		and T1.query_hash = T2.query_hash
		and T1.query_plan_hash = T2.query_plan_hash
		where T2.SvrName is null

		set @cnt = @@rowcount ;
		print 'UTIL_QryOptStatsHistory added ' + cast(@cnt as nvarchar(50)) + ' new records.';

		insert into DFS_QryOptStatsHistory
		SELECT T1.[SVRName]
			  ,T1.[DBName]
			  ,T1.[query_hash]
			  ,T1.[query_plan_hash] 
			  ,T1.RunDate
			  ,t1.[UID]
			  ,t1.total_rows
		  FROM [dbo].[DFS_IO_BoundQry] T1
		left join DFS_QryOptStatsHistory T2
		on T1.SvrName = T2.SvrName 
		and T1.DbName = T2.DbName 
		and T1.query_hash = T2.query_hash
		and T1.query_plan_hash = T2.query_plan_hash
		where T2.SvrName is null

		set @cnt = @@rowcount ;
		print 'UTIL_QryOptStatsHistory added ' + cast(@cnt as nvarchar(50)) + ' new records.';

		--DELETE t1 
		--FROM [DFS_IO_BoundQry] t1
		--JOIN DFS_QryOptStatsHistory t2 
		--on T1.SvrName = T2.SvrName 
		--and T1.DbName = T2.DbName 
		--and T1.query_hash = T2.query_hash
		--and T1.query_plan_hash = T2.query_plan_hash;

	end
go