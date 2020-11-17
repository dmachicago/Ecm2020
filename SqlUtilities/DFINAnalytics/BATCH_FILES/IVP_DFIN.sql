

/****************** PROCESSING FILE *************************************/

GO  
PRINT 'ID# 3'  
print 'D:\dev\SQL\DFINAnalytics\UTIL_ADD_DFS_QrysPlans.sql' 

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
USE [DFS]
go
-- drop TABLE [dbo].[DFS_CPU_BoundQry]
IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.tables
    WHERE TABLE_NAME = 'DFS_CPU_BoundQry'
)
begin
    CREATE TABLE [dbo].[DFS_CPU_BoundQry]
    ([SVRName]                [NVARCHAR](128) NULL, 
     [DBName]                 [NVARCHAR](128) NULL, 
     [text]                   [NVARCHAR](MAX) NULL, 
     [query_plan]             [XML] NULL, 
     [sql_handle]             [VARBINARY](64) NOT NULL, 
     [statement_start_offset] [INT] NOT NULL, 
     [statement_end_offset]   [INT] NOT NULL, 
     [plan_generation_num]    [BIGINT] NULL, 
     [plan_handle]            [VARBINARY](64) NOT NULL, 
     [creation_time]          [DATETIME] NULL, 
     [last_execution_time]    [DATETIME] NULL, 
     [execution_count]        [BIGINT] NOT NULL, 
     [total_worker_time]      [BIGINT] NOT NULL, 
     [last_worker_time]       [BIGINT] NOT NULL, 
     [min_worker_time]        [BIGINT] NOT NULL, 
     [max_worker_time]        [BIGINT] NOT NULL, 
     [total_physical_reads]   [BIGINT] NOT NULL, 
     [last_physical_reads]    [BIGINT] NOT NULL, 
     [min_physical_reads]     [BIGINT] NOT NULL, 
     [max_physical_reads]     [BIGINT] NOT NULL, 
     [total_logical_writes]   [BIGINT] NOT NULL, 
     [last_logical_writes]    [BIGINT] NOT NULL, 
     [min_logical_writes]     [BIGINT] NOT NULL, 
     [max_logical_writes]     [BIGINT] NOT NULL, 
     [total_logical_reads]    [BIGINT] NOT NULL, 
     [last_logical_reads]     [BIGINT] NOT NULL, 
     [min_logical_reads]      [BIGINT] NOT NULL, 
     [max_logical_reads]      [BIGINT] NOT NULL, 
     [total_clr_time]         [BIGINT] NOT NULL, 
     [last_clr_time]          [BIGINT] NOT NULL, 
     [min_clr_time]           [BIGINT] NOT NULL, 
     [max_clr_time]           [BIGINT] NOT NULL, 
     [total_elapsed_time]     [BIGINT] NOT NULL, 
     [last_elapsed_time]      [BIGINT] NOT NULL, 
     [min_elapsed_time]       [BIGINT] NOT NULL, 
     [max_elapsed_time]       [BIGINT] NOT NULL, 
     [query_hash]             [BINARY](8) NULL, 
     [query_plan_hash]        [BINARY](8) NULL, 
     [total_rows]             [BIGINT] NULL, 
     [last_rows]              [BIGINT] NULL, 
     [min_rows]               [BIGINT] NULL, 
     [max_rows]               [BIGINT] NULL, 
     [statement_sql_handle]   [VARBINARY](64) NULL, 
     [statement_context_id]   [BIGINT] NULL, 
     [total_dop]              [BIGINT] NULL, 
     [last_dop]               [BIGINT] NULL, 
     [min_dop]                [BIGINT] NULL, 
     [max_dop]                [BIGINT] NULL, 
     [total_grant_kb]         [BIGINT] NULL, 
     [last_grant_kb]          [BIGINT] NULL, 
     [min_grant_kb]           [BIGINT] NULL, 
     [max_grant_kb]           [BIGINT] NULL, 
     [total_used_grant_kb]    [BIGINT] NULL, 
     [last_used_grant_kb]     [BIGINT] NULL, 
     [min_used_grant_kb]      [BIGINT] NULL, 
     [max_used_grant_kb]      [BIGINT] NULL, 
     [total_ideal_grant_kb]   [BIGINT] NULL, 
     [last_ideal_grant_kb]    [BIGINT] NULL, 
     [min_ideal_grant_kb]     [BIGINT] NULL, 
     [max_ideal_grant_kb]     [BIGINT] NULL, 
     [total_reserved_threads] [BIGINT] NULL, 
     [last_reserved_threads]  [BIGINT] NULL, 
     [min_reserved_threads]   [BIGINT] NULL, 
     [max_reserved_threads]   [BIGINT] NULL, 
     [total_used_threads]     [BIGINT] NULL, 
     [last_used_threads]      [BIGINT] NULL, 
     [min_used_threads]       [BIGINT] NULL, 
     [max_used_threads]       [BIGINT] NULL, 
     [RunDate]                [DATETIME] NULL, 
     [RunID]                  [BIGINT] NULL,
	 [UID] uniqueidentifier default newid() not null,
	 [Processed] int default 0,     
    )
    ON [PRIMARY];

	CREATE INDEX piDFS_CPU_BoundQry ON DFS_CPU_BoundQry (query_hash, query_plan_hash);
	CREATE INDEX piDFS_CPU_BoundQry_Processed ON DFS_CPU_BoundQry (Processed, UID );
end
GO

IF EXISTS
(
    SELECT 1
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
        FOR SELECT query_hash, 
                   query_plan_hash, 
                   [UID], 
                   'C' AS PerfType, 
                   '2000' AS TBLID
            FROM [dbo].[DFS_CPU_BoundQry2000]
            WHERE Processed = 0
            UNION ALL
            SELECT query_hash, 
                   query_plan_hash, 
                   [UID], 
                   'I' AS PerfType, 
                   '2000' AS TBLID
            FROM [dbo].[DFS_IO_BoundQry2000]
            WHERE Processed = 0
            UNION ALL
            SELECT query_hash, 
                   query_plan_hash, 
                   [UID], 
                   'I' AS PerfType, 
                   NULL AS TBLID
            FROM [dbo].[DFS_IO_BoundQry]
            WHERE Processed = 0
            UNION ALL
            SELECT query_hash, 
                   query_plan_hash, 
                   [UID], 
                   'C' AS PerfType, 
                   NULL AS TBLID
            FROM [dbo].[DFS_CPU_BoundQry]
            WHERE Processed = 0;
        OPEN db_cursor;
        FETCH NEXT FROM db_cursor INTO @query_hash, @query_plan_hash, @UID, @PerfType, @TBLID;
        WHILE @@FETCH_STATUS = 0
            BEGIN
                SET @i = @i + 1;
                SET @msg = 'Processing: ' + CAST(@i AS NVARCHAR(15));
                EXEC PrintImmediate 
                     @msg;
                EXEC UTIL_ADD_DFS_QrysPlans 
                     @query_hash, 
                     @query_plan_hash, 
                     @UID, 
                     @PerfType, 
                     @TBLID;
                FETCH NEXT FROM db_cursor INTO @query_hash, @query_plan_hash, @UID, @PerfType, @TBLID;
            END;
        CLOSE db_cursor;
        DEALLOCATE db_cursor;
        IF
        (
            SELECT COUNT(*)
            FROM [dbo].[DFS_IO_BoundQry2000]
            WHERE Processed = 0
        ) > 0
            UPDATE [dbo].[DFS_IO_BoundQry2000]
              SET 
                  processed = 1
            WHERE Processed = 0;
        IF
        (
            SELECT COUNT(*)
            FROM [dbo].[DFS_CPU_BoundQry2000]
            WHERE Processed = 0
        ) > 0
            UPDATE [dbo].[DFS_CPU_BoundQry2000]
              SET 
                  processed = 1
            WHERE Processed = 0;
        IF
        (
            SELECT COUNT(*)
            FROM [dbo].[DFS_IO_BoundQry]
            WHERE Processed = 0
        ) > 0
            UPDATE [dbo].[DFS_IO_BoundQry]
              SET 
                  processed = 1
            WHERE Processed = 0;
        IF
        (
            SELECT COUNT(*)
            FROM [dbo].[DFS_CPU_BoundQry]
            WHERE Processed = 0
        ) > 0
            UPDATE [dbo].[DFS_CPU_BoundQry]
              SET 
                  processed = 1
            WHERE Processed = 0;
    END;
GO
IF EXISTS
(
    SELECT 1
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
CREATE PROCEDURE UTIL_ADD_DFS_QrysPlans
(@query_hash      BINARY(8), 
 @query_plan_hash BINARY(8), 
 @UID             UNIQUEIDENTIFIER, 
 @PerfType        CHAR(1), 
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
        IF(@PerfType = 'C'
           OR @PerfType = 'I')
            BEGIN
                SET @Success = 0;
        END;
            ELSE
            BEGIN
                PRINT 'FAILED @PerfType: must be C or I : "' + @PerfType + '"';
                RETURN @success;
        END;
        IF(@TBLID = '2000'
           OR @TBLID IS NULL)
            BEGIN
                SET @Success = 0;
        END;
            ELSE
            BEGIN
                PRINT 'FAILED @TBLID must be 2000 or NULL: ' + CAST(@success AS NVARCHAR(10));
                RETURN @success;
        END;
        SET @cnt =
        (
            SELECT COUNT(*)
            FROM dbo.DFS_QryPlanBridge
            WHERE query_hash = @query_hash
                  AND query_plan_hash = @query_plan_hash
        );
        IF
           (@cnt = 0
           )
            BEGIN
                SET @AddRec = 1;
        END;
        IF
           (@cnt = 1
           )
            BEGIN
                UPDATE [dbo].[DFS_QryPlanBridge]
                  SET 
                      NbrHits = NbrHits + 1, 
                      LastUpdate = GETDATE()
                WHERE query_hash = @query_hash
                      AND query_plan_hash = @query_plan_hash;
                SET @success = 1;
                RETURN @success;
        END;
        SET @success = 0;
        IF
           (@cnt = 0
           )
            BEGIN
                IF @PerfType = 'C'
                    BEGIN
                        IF @TBLID = '2000'
                            BEGIN
                                SET @PLAN =
                                (
                                    SELECT query_plan
                                    FROM [dbo].[DFS_CPU_BoundQry2000]
                                    WHERE [UID] = @UID
                                );
                                SET @SQL =
                                (
                                    SELECT [text]
                                    FROM [dbo].[DFS_CPU_BoundQry2000]
                                    WHERE [UID] = @UID
                                );
                                SET @success = 1;
                        END;
                            ELSE
                            BEGIN
                                SET @PLAN =
                                (
                                    SELECT query_plan
                                    FROM [dbo].[DFS_CPU_BoundQry]
                                    WHERE [UID] = @UID
                                );
                                SET @SQL =
                                (
                                    SELECT [text]
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
                                SET @PLAN =
                                (
                                    SELECT query_plan
                                    FROM [dbo].[DFS_IO_BoundQry2000]
                                    WHERE [UID] = @UID
                                );
                                SET @SQL =
                                (
                                    SELECT [text]
                                    FROM [dbo].[DFS_IO_BoundQry2000]
                                    WHERE [UID] = @UID
                                );
                                SET @success = 1;
                        END;
                            ELSE
                            BEGIN
                                SET @PLAN =
                                (
                                    SELECT query_plan
                                    FROM [dbo].[DFS_IO_BoundQry]
                                    WHERE [UID] = @UID
                                );
                                SET @SQL =
                                (
                                    SELECT [text]
                                    FROM [dbo].[DFS_IO_BoundQry]
                                    WHERE [UID] = @UID
                                );
                                SET @success = 1;
                        END;
                END;
        END;
        IF(@success <> 1
           OR @AddRec <> 1)
            BEGIN
                PRINT 'select * from XXX where [UID] = ''' + CAST(@UID AS NVARCHAR(60)) + ''';';
        END;
        IF(@success = 1
           AND @AddRec = 1)
            BEGIN
                INSERT INTO [dbo].[DFS_QryPlanBridge]
                ( [query_hash], 
                  [query_plan_hash], 
                  [PerfType], 
                  [TblType], 
                  [CreateDate], 
                  [LastUpdate], 
                  [NbrHits]
                ) 
                VALUES
                (
                       @query_hash
                     , @query_plan_hash
                     , @PerfType
                     , @TBLID
                     , GETDATE()
                     , GETDATE()
                     , 1
                );
                INSERT INTO [dbo].[DFS_QrysPlans]
                ( [query_hash], 
                  [query_plan_hash], 
                  [UID], 
                  [PerfType], 
                  [text], 
                  [query_plan], 
                  [CreateDate]
                ) 
                VALUES
                (
                       @query_hash
                     , @query_plan_hash
                     , NEWID()
                     , @PerfType
                     , @SQL
                     , @PLAN
                     , GETDATE()
                );
                IF @TBLID = '2000'
                   AND @PerfType = 'I'
                    BEGIN
                        UPDATE [dbo].[DFS_IO_BoundQry2000]
                          SET 
                              query_plan = 'SAVED', 
                              [text] = 'SAVED', 
                              Processed = 1
                        WHERE [UID] = @UID;
                        PRINT 'DFS_IO_BoundQry2000: ' + CAST(@i AS NVARCHAR(15)) + ' Processed set to 1';
                END;
                IF @TBLID = '2000'
                   AND @PerfType = 'C'
                    BEGIN
                        UPDATE [dbo].[DFS_CPU_BoundQry2000]
                          SET 
                              query_plan = 'SAVED', 
                              [text] = 'SAVED', 
                              Processed = 1
                        WHERE [UID] = @UID;
                        PRINT 'DFS_CPU_BoundQry2000: ' + CAST(@i AS NVARCHAR(15)) + ' Processed set to 1';
                END;
                IF @TBLID IS NULL
                   AND @PerfType = 'I'
                    BEGIN
                        UPDATE [dbo].[DFS_IO_BoundQry]
                          SET 
                              query_plan = 'SAVED', 
                              [text] = 'SAVED', 
                              Processed = 1
                        WHERE [UID] = @UID;
                        PRINT 'DFS_IO_BoundQry: ' + CAST(@i AS NVARCHAR(15)) + ' Processed set to 1';
                END;
                IF @TBLID IS NULL
                   AND @PerfType = 'C'
                    BEGIN
                        UPDATE [dbo].[DFS_cpu_BoundQry]
                          SET 
                              query_plan = 'SAVED', 
                              [text] = 'SAVED', 
                              Processed = 1
                        WHERE [UID] = @UID;
                        PRINT 'DFS_cpu_BoundQry: ' + CAST(@i AS NVARCHAR(15)) + ' Processed set to 1';
                END;
        END;
        RETURN @success;
    END;

/****************** PROCESSING FILE *************************************/

GO  
PRINT 'ID# 5'  
print 'FQN: D:\dev\SQL\DFINAnalytics\create_master_seq.sql' 
go
use master;
go
IF NOT EXISTS
(
    SELECT 1
    FROM sys.sequences
    WHERE name = 'master_seq'
)
    BEGIN
        CREATE SEQUENCE master_seq
             AS BIGINT
             START WITH 1
             INCREMENT BY 1
             MINVALUE 1
             MAXVALUE 999999999
             NO CYCLE
             CACHE 10;
END;
GO



/****************** PROCESSING FILE *************************************/

GO  
PRINT 'ID# 10'  
print 'FQN: D:\dev\SQL\DFINAnalytics\sp_UTIL_GetSeq.sql' 

USE [DFS];
GO

/*
select * from [SequenceTABLE]
*/

IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.TABLES
    WHERE TABLE_NAME = 'SequenceTABLE'
)
    BEGIN
        CREATE TABLE [dbo].[SequenceTABLE]
        ([ID] [BIGINT] IDENTITY(1, 1) NOT NULL,
        )
        ON [PRIMARY];
        CREATE UNIQUE INDEX pk_SequenceTABLE ON SequenceTABLE(id);
END;
GO
USE master;
GO
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'sp_UTIL_GetSeq'
)
    DROP PROCEDURE sp_UTIL_GetSeq;
GO

-- select * from dbo.SequenceTABLE
-- exec sp_UTIL_GetSeq
CREATE PROCEDURE sp_UTIL_GetSeq
AS
    BEGIN
        DECLARE @id BIGINT;
        INSERT INTO dbo.SequenceTABLE WITH(TABLOCKX)
        DEFAULT VALUES;
        --Return the latest IDENTITY value.
        SET @id =
        (
            SELECT MAX(id)
            FROM dbo.SequenceTABLE
        );
        RETURN @id;
    END;



/****************** PROCESSING FILE *************************************/

GO  
PRINT 'ID# 15'  


USE [DFS];
GO

IF NOT EXISTS
(
	SELECT 1
	FROM SYS.tables
	WHERE name = 'DFS_RecordCount'
)
-- drop TABLE DFS_RecordCount
-- select * from dbo.DFS_RecordCount
BEGIN
	CREATE TABLE DFS_RecordCount
	( 
				 ProcName nvarchar(150) NOT NULL, 
				 HitCount int NULL DEFAULT 0,
				 SvrName  nvarchar(150) NOT NULL, 
				 DBName  nvarchar(150) NOT NULL, 
				 LastUpdate datetime null
	);
END;
GO

IF EXISTS
(
	SELECT 1
	FROM SYS.procedures
	WHERE name = 'UTIL_RecordCount'
)
BEGIN
	DROP PROCEDURE UTIL_RecordCount;
END;
GO

-- truncate table DFS_RecordCount;
-- EXEC UTIL_RecordCount 'xx1';
-- SELECT * FROM DFS_RecordCount;
CREATE PROCEDURE UTIL_RecordCount
( 
				 @procname nvarchar(100)
)
AS
BEGIN
	DECLARE @cnt AS int= 0;
	DECLARE @SvrName nvarchar(150) = @@servername;
	DECLARE @DBName nvarchar(150) = db_name();
	SET @cnt =
	(
		SELECT COUNT(*)
		FROM DFS_RecordCount
		WHERE ProcName = @procname
		and SvrName = @SvrName
		and DBName  =@DBName
	);
	IF @cnt = 0
	BEGIN
		INSERT INTO DFS_RecordCount( ProcName , HitCount, SvrName , DBName, LastUpdate)
		VALUES( @procname, 1, @SvrName, @DBName, getdate() );
	END;
	IF @cnt > 0
	BEGIN
		UPDATE DFS_RecordCount
		  SET HitCount = HitCount + 1, LastUpdate = getdate()
		WHERE ProcName = @procname
		and SvrName = @SvrName
		and DBName  =@DBName;
	END;
END;

/****************** PROCESSING FILE *************************************/

GO  
PRINT 'ID# 20'  
print 'D:\dev\SQL\DFINAnalytics\PrintImmediate.sql' 
USE [DFS];
GO
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'PrintImmediate'
)
    DROP PROCEDURE PrintImmediate;
GO
CREATE PROCEDURE [dbo].[PrintImmediate](@MSG AS NVARCHAR(MAX))
AS
    BEGIN
        RAISERROR(@MSG, 10, 1) WITH NOWAIT;
    END;
GO
USE MASTER;
GO
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'sp_PrintImmediate'
)
    DROP PROCEDURE sp_PrintImmediate;
GO
CREATE PROCEDURE [dbo].[sp_PrintImmediate](@MSG AS NVARCHAR(MAX))
AS
    BEGIN
        RAISERROR(@MSG, 10, 1) WITH NOWAIT;
    END;


/****************** PROCESSING FILE *************************************/

GO  
PRINT 'ID# 30'  
print 'D:\dev\SQL\DFINAnalytics\CREATE_DFS_DB2Skip.sql' 
USE [DFS];
go

IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.tables
    WHERE TABLE_NAME = 'DFS_DB2Skip'
)
begin 
    CREATE TABLE dbo.[DFS_DB2Skip](DB NVARCHAR(100));
	create unique index PK_DFS_DB2Skip on DFS_DB2Skip (DB);
	insert into dbo.[DFS_DB2Skip] (DB) values ('master');
	insert into dbo.[DFS_DB2Skip] (DB) values ('DBA');
	insert into dbo.[DFS_DB2Skip] (DB) values ('model');
	insert into dbo.[DFS_DB2Skip] (DB) values ('msdb');
	insert into dbo.[DFS_DB2Skip] (DB) values ('tempdb');
end 


/****************** PROCESSING FILE *************************************/

GO  
PRINT 'ID# 40'  
print 'D:\dev\SQL\DFINAnalytics\sp_ckProcessDB.sql' 
USE master;
GO
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'sp_ckProcessDB'
)
    DROP PROCEDURE sp_ckProcessDB;
GO
CREATE PROCEDURE sp_ckProcessDB
AS
    BEGIN
        DECLARE @DBNAME NVARCHAR(100)= DB_NAME();
        IF @DBName = 'model'
            BEGIN
                PRINT 'SKIPPING: ' + @DBNAME;
                RETURN 0;
        END;
        IF @DBName = 'msdb'
            BEGIN
                PRINT 'SKIPPING: ' + @DBNAME;
                RETURN 0;
        END;
        IF @DBName = 'tempdb'
            BEGIN
                PRINT 'SKIPPING: ' + @DBNAME;
                RETURN 0;
        END;
        IF @DBName = 'master'
            BEGIN
                PRINT 'SKIPPING: ' + @DBNAME;
                RETURN 0;
        END;
        RETURN 1;
    END;

/****************** PROCESSING FILE *************************************/

GO  
PRINT 'ID# 50'  
print 'D:\dev\SQL\DFINAnalytics\DFS_DBVersion.sql' 
USE DFINAnalyticsFINAnalyticsFINAnalyticsFS;
GO
-- drop table DFS_DBVersion
IF NOT EXISTS
(
    SELECT name
    FROM   sys.tables
    WHERE  name = 'DFS_DBVersion'
)
    BEGIN
        CREATE TABLE DFS_DBVersion
        ([SVRName] [NVARCHAR](128) NULL, 
         [DBName]  [NVARCHAR](128) NULL, 
         [SSVER]   [NVARCHAR](250) NOT NULL, 
         [SSVERID] [NVARCHAR](60) NOT NULL
                                  DEFAULT NEWID(),
		Rownbr int identity (1,1) not null
        );
        CREATE UNIQUE INDEX PK_DFS_DBVersion
        ON DFS_DBVersion
        ([SSVERID]
        ) INCLUDE([SSVER]);
END;
GO
IF EXISTS
(
    SELECT name
    FROM   sys.procedures
    WHERE  name = 'UTIL_DFS_DBVersion'
)
    DROP PROCEDURE UTIL_DFS_DBVersion;
GO
-- exec UTIL_DFS_DBVersion
CREATE PROCEDURE UTIL_DFS_DBVersion
AS
    BEGIN
        DECLARE @SSVER NVARCHAR(250)= @@version;
        DECLARE @SSID NVARCHAR(60);
		DECLARE @ID int;

        IF EXISTS
        (
            SELECT RowNbr
            FROM   DFS_DBVersion
            WHERE  [SSVER] = @SSVER
        )
            BEGIN
			    SET @ID =
                (
                    SELECT RowNbr
                    FROM   DFS_DBVersion
                    WHERE  [SSVER] = @SSVER
                );
        END;
            ELSE
            BEGIN
                SET @SSID = NEWID();
                INSERT INTO DFS_DBVersion
                ([SVRName], 
                 [DBName], 
                 [SSVER], 
                 [SSVERID]
                )
                VALUES
                (@@servername, 
                 DB_NAME(), 
                 @@version, 
                 cast(@SSID as nvarchar(60))
                );
				 SET @ID =
                (
                    SELECT Rownbr
                    FROM   DFS_DBVersion
                    WHERE  [SSVER] = @SSVER
                );
        END;
		print @ID;
        RETURN @ID;
    END;PRINT '--- "D:\dev\SQL\DFINAnalytics\DFS_DBVersion.sql"' 
PRINT '--- "D:\dev\SQL\DFINAnalytics\DFS_DBVersion.sql"' 


/****************** PROCESSING FILE *************************************/

GO  
PRINT 'ID# 60'  
print 'D:\dev\SQL\DFINAnalytics\createSeq2008.sql' 
USE [DFS]
go
--Create a dummy TABLE to generate a SEQUENCE. No actual records will be stored.

if not exists (select 1 from INFORMATION_SCHEMA.TABLES where TABLE_NAME = 'DFS_SequenceTABLE')
CREATE TABLE dbo.DFS_SequenceTABLE
(
    ID BIGINT IDENTITY  
);
GO

if exists (select 1 from sys.procedures where name = 'GetSEQUENCE')
	drop procedure GetSEQUENCE;
go

--This procedure is for convenience in retrieving a sequence.
create PROCEDURE dbo.GetSEQUENCE ( @value BIGINT OUTPUT)
AS
    --Act like we are INSERTing a row to increment the IDENTITY
  
    INSERT DFS_SequenceTABLE WITH (TABLOCKX) DEFAULT VALUES;
    --Return the latest IDENTITY value.
    SELECT @value = SCOPE_IDENTITY();
GO

/*Example execution
DECLARE @value BIGINT;
EXECUTE dbo.GetSEQUENCE @value OUTPUT;
SELECT @value AS [@value];
*/


/****************** PROCESSING FILE *************************************/

GO  
PRINT 'ID# 70'  
print 'D:\dev\SQL\DFINAnalytics\create_DFS_WaitTypes_TableAndPopulate.sql' 

if @@version not like  'Microsoft SQL Azure%' USE [DFS];
GO
-- truncate table DFS_WaitTypes
-- select count(*) from DFS_WaitTypes
IF NOT EXISTS
(
    SELECT 1
    FROM sys.tables
    WHERE name = 'DFS_WaitTypes'
)
    BEGIN
        CREATE TABLE DFS_WaitTypes
        (typecode   NVARCHAR(50) NOT NULL, 
         definition NVARCHAR(MAX) NOT NULL,
        );
        CREATE INDEX pk_DFS_WaitTypes ON DFS_WaitTypes(typecode);
END;
GO
SET NOCOUNT ON;

INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('ABR', 
 'Identified for informational purposes only. Not supported. Future compatibility is not guaranteed.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('AM_INDBUILD_ALLOCATION', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('AM_SCHEMAMGR_UNSHARED_CACHE', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('ASSEMBLY_FILTER_HASHTABLE', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('ASSEMBLY_LOAD', 
 'Occurs during exclusive access to assembly loading.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('ASYNC_DISKPOOL_LOCK', 
 'Occurs when there is an attempt to synchronize parallel threads that are performing tasks such as creating or initializing a file.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('ASYNC_IO_COMPLETION', 
 'Occurs when a task is waiting for I/Os to finish.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('ASYNC_NETWORK_IO', 
 'Occurs on network writes when the task is blocked behind the network. Verify that the client is processing data from the server.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('ASYNC_OP_COMPLETION', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('ASYNC_OP_CONTEXT_READ', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('ASYNC_OP_CONTEXT_WRITE', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('ASYNC_SOCKETDUP_IO', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('AUDIT_GROUPCACHE_LOCK', 
 'Occurs when there is a wait on a lock that controls access to a special cache. The cache contains information about which audits are being used to audit each audit action group.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('AUDIT_LOGINCACHE_LOCK', 
 'Occurs when there is a wait on a lock that controls access to a special cache. The cache contains information about which audits are being used to audit login audit action groups.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('AUDIT_ON_DEMAND_TARGET_LOCK', 
 'Occurs when there is a wait on a lock that is used to ensure single initialization of audit related Extended Event targets.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('AUDIT_XE_SESSION_MGR', 
 'Occurs when there is a wait on a lock that is used to synchronize the starting and stopping of audit related Extended Events sessions.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('BACKUP', 
 'Occurs when a task is blocked as part of backup processing.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('BACKUP_OPERATOR', 
 'Occurs when a task is waiting for a tape mount. To view the tape status, query sys.dm_io_backup_tapes. If a mount operation is not pending, this wait type may indicate a hardware problem with the tape drive.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('BACKUPBUFFER', 
 'Occurs when a backup task is waiting for data, or is waiting for a buffer in which to store data. This type is not typical, except when a task is waiting for a tape mount.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('BACKUPIO', 
 'Occurs when a backup task is waiting for data, or is waiting for a buffer in which to store data. This type is not typical, except when a task is waiting for a tape mount.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('BACKUPTHREAD', 
 'Occurs when a task is waiting for a backup task to finish. Wait times may be long, from several minutes to several hours. If the task that is being waited on is in an I/O process, this type does not indicate a problem.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('BAD_PAGE_PROCESS', 
 'Occurs when the background suspect page logger is trying to avoid running more than every five seconds. Excessive suspect pages cause the logger to run frequently.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('BLOB_METADATA', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('BMPALLOCATION', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('BMPBUILD', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('BMPREPARTITION', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('BMPREPLICATION', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('BPSORT', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('BROKER_CONNECTION_RECEIVE_TASK', 
 'Occurs when waiting for access to receive a message on a connection endpoint. Receive access to the endpoint is serialized.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('BROKER_DISPATCHER', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('BROKER_ENDPOINT_STATE_MUTEX', 
 'Occurs when there is contention to access the state of a Service Broker connection endpoint. Access to the state for changes is serialized.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('BROKER_EVENTHANDLER', 
 'Occurs when a task is waiting in the primary event handler of the Service Broker. This should occur very briefly.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('BROKER_FORWARDER', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('BROKER_INIT', 
 'Occurs when initializing Service Broker in each active database. This should occur infrequently.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('BROKER_MASTERSTART', 
 'Occurs when a task is waiting for the primary event handler of the Service Broker to start. This should occur very briefly.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('BROKER_RECEIVE_WAITFOR', 
 'Occurs when the RECEIVE WAITFOR is waiting. This may mean that either no messages are ready to be received in the queue or a lock contention is preventing it from receiving messages from the queue.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('BROKER_REGISTERALLENDPOINTS', 
 'Occurs during the initialization of a Service Broker connection endpoint. This should occur very briefly.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('BROKER_SERVICE', 
 'Occurs when the Service Broker destination list that is associated with a target service is updated or re-prioritized.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('BROKER_SHUTDOWN', 
 'Occurs when there is a planned shutdown of Service Broker. This should occur very briefly, if at all.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('BROKER_START', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('BROKER_TASK_SHUTDOWN', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('BROKER_TASK_STOP', 
 'Occurs when the Service Broker queue task handler tries to shut down the task. The state check is serialized and must be in a running state beforehand.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('BROKER_TASK_SUBMIT', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('BROKER_TO_FLUSH', 
 'Occurs when the Service Broker lazy flusher flushes the in-memory transmission objects to a work table.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('BROKER_TRANSMISSION_OBJECT', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('BROKER_TRANSMISSION_TABLE', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('BROKER_TRANSMISSION_WORK', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('BROKER_TRANSMITTER', 
 'Occurs when the Service Broker transmitter is waiting for work. Service Broker has a component known as the Transmitter which schedules messages from multiple dialogs to be sent across the wire over one or more connection endpoints. The transmitter has 2 dedicated threads for this purpose. This wait type is charged when these transmitter threads are waiting for dialog messages to be sent using the transport connections. High values of waiting_tasks_count for this wait type point to intermittent work for these transmitter threads and are not indications of any performance problem. If service broker is not used at all, waiting_tasks_count should be 2 (for the 2 transmitter threads) and wait_time_ms should be twice the duration since instance startup. See Service broker wait stats.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('BUILTIN_HASHKEY_MUTEX', 
 'May occur after startup of instance, while internal data structures are initializing. Will not recur once data structures have initialized.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('CHANGE_TRACKING_WAITFORCHANGES', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('CHECK_PRINT_RECORD', 
 'Identified for informational purposes only. Not supported. Future compatibility is not guaranteed.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('CHECK_SCANNER_MUTEX', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('CHECK_TABLES_INITIALIZATION', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('CHECK_TABLES_SINGLE_SCAN', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('CHECK_TABLES_THREAD_BARRIER', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('CHECKPOINT_QUEUE', 
 'Occurs while the checkpoint task is waiting for the next checkpoint request.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('CHKPT', 
 'Occurs at server startup to tell the checkpoint thread that it can start.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('CLEAR_DB', 
 'Occurs during operations that change the state of a database, such as opening or closing a database.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('CLR_AUTO_EVENT', 
 'Occurs when a task is currently performing common language runtime (CLR) execution and is waiting for a particular autoevent to be initiated. Long waits are typical, and do not indicate a problem.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('CLR_CRST', 
 'Occurs when a task is currently performing CLR execution and is waiting to enter a critical section of the task that is currently being used by another task.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('CLR_JOIN', 
 'Occurs when a task is currently performing CLR execution and waiting for another task to end. This wait state occurs when there is a join between tasks.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('CLR_MANUAL_EVENT', 
 'Occurs when a task is currently performing CLR execution and is waiting for a specific manual event to be initiated.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('CLR_MEMORY_SPY', 
 'Occurs during a wait on lock acquisition for a data structure that is used to record all virtual memory allocations that come from CLR. The data structure is locked to maintain its integrity if there is parallel access.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('CLR_MONITOR', 
 'Occurs when a task is currently performing CLR execution and is waiting to obtain a lock on the monitor.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('CLR_RWLOCK_READER', 
 'Occurs when a task is currently performing CLR execution and is waiting for a reader lock.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('CLR_RWLOCK_WRITER', 
 'Occurs when a task is currently performing CLR execution and is waiting for a writer lock.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('CLR_SEMAPHORE', 
 'Occurs when a task is currently performing CLR execution and is waiting for a semaphore.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('CLR_TASK_START', 
 'Occurs while waiting for a CLR task to complete startup.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('CLRHOST_STATE_ACCESS', 
 'Occurs where there is a wait to acquire exclusive access to the CLR-hosting data structures. This wait type occurs while setting up or tearing down the CLR runtime.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('CMEMPARTITIONED', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('CMEMTHREAD', 
 'Occurs when a task is waiting on a thread-safe memory object. The wait time might increase when there is contention caused by multiple tasks trying to allocate memory from the same memory object.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('COLUMNSTORE_BUILD_THROTTLE', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('COLUMNSTORE_COLUMNDATASET_SESSION_LIST', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('COMMIT_TABLE', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('CONNECTION_ENDPOINT_LOCK', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('COUNTRECOVERYMGR', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('CREATE_DATINISERVICE', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('CXCONSUMER', 
 'Occurs with parallel query plans when a consumer thread waits for a producer thread to send rows. This is a normal part of parallel query execution.: Applies to: SQL Server (Starting with SQL Server 2016 (13.x) SP2, SQL Server 2017 (14.x) CU3), SQL Database'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('CXPACKET', 
 'Occurs with parallel query plans when synchronizing the query processor exchange iterator, and when producing and consuming rows. If waiting is excessive and cannot be reduced by tuning the query (such as adding indexes), consider adjusting the cost threshold for parallelism or lowering the degree of parallelism.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('CXROWSET_SYNC', 
 'Occurs during a parallel range scan.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('DAC_INIT', 
 'Occurs while the dedicated administrator connection is initializing.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('DBCC_SCALE_OUT_EXPR_CACHE', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('DBMIRROR_DBM_EVENT', 
 'Identified for informational purposes only. Not supported. Future compatibility is not guaranteed.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('DBMIRROR_DBM_MUTEX', 
 'Identified for informational purposes only. Not supported. Future compatibility is not guaranteed.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('DBMIRROR_EVENTS_QUEUE', 
 'Occurs when database mirroring waits for events to process.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('DBMIRROR_SEND', 
 'Occurs when a task is waiting for a communications backlog at the network layer to clear to be able to send messages. Indicates that the communications layer is starting to become overloaded and affect the database mirroring data throughput.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('DBMIRROR_WORKER_QUEUE', 
 'Indicates that the database mirroring worker task is waiting for more work.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('DBMIRRORING_CMD', 
 'Occurs when a task is waiting for log records to be flushed to disk. This wait state is expected to be held for long periods of time.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('DBSEEDING_FLOWCONTROL', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('DBSEEDING_OPERATION', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('DEADLOCK_ENUM_MUTEX', 
 'Occurs when the deadlock monitor and sys.dm_os_waiting_tasks try to make sure that SQL Server is not running multiple deadlock searches at the same time.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('DEADLOCK_TASK_SEARCH', 
 'Large waiting time on this resource indicates that the server is executing queries on top of sys.dm_os_waiting_tasks, and these queries are blocking deadlock monitor from running deadlock search. This wait type is used by deadlock monitor only. Queries on top of sys.dm_os_waiting_tasks use DEADLOCK_ENUM_MUTEX.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('DEBUG', 
 'Occurs during Transact-SQL and CLR debugging for internal synchronization.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('DIRECTLOGCONSUMER_LIST', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('DIRTY_PAGE_POLL', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('DIRTY_PAGE_SYNC', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('DIRTY_PAGE_TABLE_LOCK', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('DISABLE_VERSIONING', 
 'Occurs when SQL Server polls the version transaction manager to see whether the timestamp of the earliest active transaction is later than the timestamp of when the state started changing. If this is this case, all the snapshot transactions that were started before the ALTER DATABASE statement was run have finished. This wait state is used when SQL Server disables versioning by using the ALTER DATABASE statement.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('DISKIO_SUSPEND', 
 'Occurs when a task is waiting to access a file when an external backup is active. This is reported for each waiting user process. A count larger than five per user process may indicate that the external backup is taking too much time to finish.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('DISPATCHER_PRIORITY_QUEUE_SEMAPHORE', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('DISPATCHER_QUEUE_SEMAPHORE', 
 'Occurs when a thread from the dispatcher pool is waiting for more work to process. The wait time for this wait type is expected to increase when the dispatcher is idle.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('DLL_LOADING_MUTEX', 
 'Occurs once while waiting for the XML parser DLL to load.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('DPT_ENTRY_LOCK', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('DROP_DATABASE_TIMER_TASK', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('DROPTEMP', 
 'Occurs between attempts to drop a temporary object if the previous attempt failed. The wait duration grows exponentially with each failed drop attempt.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('DTC', 
 'Occurs when a task is waiting on an event that is used to manage state transition. This state controls when the recovery of Microsoft Distributed Transaction Coordinator (MS DTC) transactions occurs after SQL Server receives notification that the MS DTC service has become unavailable.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('DTC_ABORT_REQUEST', 
 'Occurs in a MS DTC worker session when the session is waiting to take ownership of a MS DTC transaction. After MS DTC owns the transaction, the session can roll back the transaction. Generally, the session will wait for another session that is using the transaction.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('DTC_RESOLVE', 
 'Occurs when a recovery task is waiting for the master database in a cross-database transaction so that the task can query the outcome of the transaction.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('DTC_STATE', 
 'Occurs when a task is waiting on an event that protects changes to the internal MS DTC global state object. This state should be held for very short periods of time.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('DTC_TMDOWN_REQUEST', 
 'Occurs in a MS DTC worker session when SQL Server receives notification that the MS DTC service is not available. First, the worker will wait for the MS DTC recovery process to start. Then, the worker waits to obtain the outcome of the distributed transaction that the worker is working on. This may continue until the connection with the MS DTC service has been reestablished.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('DTC_WAITFOR_OUTCOME', 
 'Occurs when recovery tasks wait for MS DTC to become active to enable the resolution of prepared transactions.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('DTCNEW_ENLIST', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('DTCNEW_PREPARE', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('DTCNEW_RECOVERY', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('DTCNEW_TM', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('DTCNEW_TRANSACTION_ENLISTMENT', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('DTCPNTSYNC', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('DUMP_LOG_COORDINATOR', 
 'Occurs when a main task is waiting for a subtask to generate data. Ordinarily, this state does not occur. A long wait indicates an unexpected blockage. The subtask should be investigated.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('DUMP_LOG_COORDINATOR_QUEUE', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('DUMPTRIGGER', 
 'Identified for informational purposes only. Not supported. Future compatibility is not guaranteed.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('EC', 
 'Identified for informational purposes only. Not supported. Future compatibility is not guaranteed.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('EE_PMOLOCK', 
 'Occurs during synchronization of certain types of memory allocations during statement execution.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('EE_SPECPROC_MAP_INIT', 
 'Occurs during synchronization of internal procedure hash table creation. This wait can only occur during the initial accessing of the hash table after the SQL Server instance starts.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('ENABLE_EMPTY_VERSIONING', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('ENABLE_VERSIONING', 
 'Occurs when SQL Server waits for all update transactions in this database to finish before declaring the database ready to transition to snapshot isolation allowed state. This state is used when SQL Server enables snapshot isolation by using the ALTER DATABASE statement.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('ERROR_REPORTING_MANAGER', 
 'Occurs during synchronization of multiple concurrent error log initializations.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('EXCHANGE', 
 'Occurs during synchronization in the query processor exchange iterator during parallel queries.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('EXECSYNC', 
 'Occurs during parallel queries while synchronizing in query processor in areas not related to the exchange iterator. Examples of such areas are bitmaps, large binary objects (LOBs), and the spool iterator. LOBs may frequently use this wait state.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('EXECUTION_PIPE_EVENT_INTERNAL', 
 'Occurs during synchronization between producer and consumer parts of batch execution that are submitted through the connection context.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('EXTERNAL_RG_UPDATE', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('EXTERNAL_SCRIPT_NETWORK_IO', 
 'TBD: Applies to: SQL Server 2017 (14.x) through current.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('EXTERNAL_SCRIPT_PREPARE_SERVICE', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('EXTERNAL_SCRIPT_SHUTDOWN', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('EXTERNAL_WAIT_ON_LAUNCHER,', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FABRIC_HADR_TRANSPORT_CONNECTION', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FABRIC_REPLICA_CONTROLLER_LIST', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FABRIC_REPLICA_CONTROLLER_STATE_AND_CONFIG', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FABRIC_REPLICA_PUBLISHER_EVENT_PUBLISH', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FABRIC_REPLICA_PUBLISHER_SUBSCRIBER_LIST', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FABRIC_WAIT_FOR_BUILD_REPLICA_EVENT_PROCESSING', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FAILPOINT', 
 'Identified for informational purposes only. Not supported. Future compatibility is not guaranteed.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FCB_REPLICA_READ', 
 'Occurs when the reads of a snapshot (or a temporary snapshot created by DBCC) sparse file are synchronized.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FCB_REPLICA_WRITE', 
 'Occurs when the pushing or pulling of a page to a snapshot (or a temporary snapshot created by DBCC) sparse file is synchronized.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FEATURE_SWITCHES_UPDATE', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FFT_NSO_DB_KILL_FLAG', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FFT_NSO_DB_LIST', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FFT_NSO_FCB', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FFT_NSO_FCB_FIND', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FFT_NSO_FCB_PARENT', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FFT_NSO_FCB_RELEASE_CACHED_ENTRIES', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FFT_NSO_FCB_STATE', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FFT_NSO_FILEOBJECT', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FFT_NSO_TABLE_LIST', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FFT_NTFS_STORE', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FFT_RECOVERY', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FFT_RSFX_COMM', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FFT_RSFX_WAIT_FOR_MEMORY', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FFT_STARTUP_SHUTDOWN', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FFT_STORE_DB', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FFT_STORE_ROWSET_LIST', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FFT_STORE_TABLE', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FILE_VALIDATION_THREADS', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FILESTREAM_CACHE', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FILESTREAM_CHUNKER', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FILESTREAM_CHUNKER_INIT', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FILESTREAM_FCB', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FILESTREAM_FILE_OBJECT', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FILESTREAM_WORKITEM_QUEUE', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FILETABLE_SHUTDOWN', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FOREIGN_REDO', 
 'TBD: Applies to: SQL Server 2017 (14.x) through current.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FORWARDER_TRANSITION', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FS_FC_RWLOCK', 
 'Occurs when there is a wait by the FILESTREAM garbage collector to do either of the following:'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FS_GARBAGE_COLLECTOR_SHUTDOWN', 
 'Occurs when the FILESTREAM garbage collector is waiting for cleanup tasks to be completed.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FS_HEADER_RWLOCK', 
 'Occurs when there is a wait to acquire access to the FILESTREAM header of a FILESTREAM data container to either read or update contents in the FILESTREAM header file (Filestream.hdr).'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FS_LOGTRUNC_RWLOCK', 
 'Occurs when there is a wait to acquire access to FILESTREAM log truncation to do either of the following:'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FSA_FORCE_OWN_XACT', 
 'Occurs when a FILESTREAM file I/O operation needs to bind to the associated transaction, but the transaction is currently owned by another session.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FSAGENT', 
 'Occurs when a FILESTREAM file I/O operation is waiting for a FILESTREAM agent resource that is being used by another file I/O operation.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FSTR_CONFIG_MUTEX', 
 'Occurs when there is a wait for another FILESTREAM feature reconfiguration to be completed.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FSTR_CONFIG_RWLOCK', 
 'Occurs when there is a wait to serialize access to the FILESTREAM configuration parameters.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FT_COMPROWSET_RWLOCK', 
 'Full-text is waiting on fragment metadata operation. Documented for informational purposes only. Not supported. Future compatibility is not guaranteed.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FT_IFTS_RWLOCK', 
 'Full-text is waiting on internal synchronization. Documented for informational purposes only. Not supported. Future compatibility is not guaranteed.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FT_IFTS_SCHEDULER_IDLE_WAIT', 
 'Full-text scheduler sleep wait type. The scheduler is idle.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FT_IFTSHC_MUTEX', 
 'Full-text is waiting on an fdhost control operation. Documented for informational purposes only. Not supported. Future compatibility is not guaranteed.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FT_IFTSISM_MUTEX', 
 'Full-text is waiting on communication operation. Documented for informational purposes only. Not supported. Future compatibility is not guaranteed.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FT_MASTER_MERGE', 
 'Full-text is waiting on master merge operation. Documented for informational purposes only. Not supported. Future compatibility is not guaranteed.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FT_MASTER_MERGE_COORDINATOR', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FT_METADATA_MUTEX', 
 'Documented for informational purposes only. Not supported. Future compatibility is not guaranteed.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FT_PROPERTYLIST_CACHE', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FT_RESTART_CRAWL', 
 'Occurs when a full-text crawl needs to restart from a last known good point to recover from a transient failure. The wait lets the worker tasks currently working on that population to complete or exit the current step.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FULLTEXT GATHERER', 
 'Occurs during synchronization of full-text operations.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('GDMA_GET_RESOURCE_OWNER', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('GHOSTCLEANUP_UPDATE_STATS', 
 'TBD: Applies to: SQL Server 2017 (14.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('GHOSTCLEANUPSYNCMGR', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('GLOBAL_QUERY_CANCEL', 
 'TBD: Applies to: SQL Server 2017 (14.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('GLOBAL_QUERY_CLOSE', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('GLOBAL_QUERY_CONSUMER', 
 'TBD: Applies to: SQL Server 2017 (14.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('GLOBAL_QUERY_PRODUCER', 
 'TBD: Applies to: SQL Server 2017 (14.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('GLOBAL_TRAN_CREATE', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('GLOBAL_TRAN_UCS_SESSION', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('GUARDIAN', 
 'Identified for informational purposes only. Not supported. Future compatibility is not guaranteed.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_AG_MUTEX', 
 'Occurs when an Always On DDL statement or Windows Server Failover Clustering command is waiting for exclusive read/write access to the configuration of an availability group.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_AR_CRITICAL_SECTION_ENTRY', 
 'Occurs when an Always On DDL statement or Windows Server Failover Clustering command is waiting for exclusive read/write access to the runtime state of the local replica of the associated availability group.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_AR_MANAGER_MUTEX', 
 'Occurs when an availability replica shutdown is waiting for startup to complete or an availability replica startup is waiting for shutdown to complete. Internal use only.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_AR_UNLOAD_COMPLETED', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_ARCONTROLLER_NOTIFICATIONS_SUBSCRIBER_LIST', 
 'The publisher for an availability replica event (such as a state change or configuration change) is waiting for exclusive read/write access to the list of event subscribers. Internal use only.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_BACKUP_BULK_LOCK', 
 'The Always On primary database received a backup request from a secondary database and is waiting for the background thread to finish processing the request on acquiring or releasing the BulkOp lock.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_BACKUP_QUEUE', 
 'The backup background thread of the Always On primary database is waiting for a new work request from the secondary database. (typically, this occurs when the primary database is holding the BulkOp log and is waiting for the secondary database to indicate that the primary database can release the lock).,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_CLUSAPI_CALL', 
 'A SQL Server thread is waiting to switch from non-preemptive mode (scheduled by SQL Server) to preemptive mode (scheduled by the operating system) in order to invoke Windows Server Failover Clustering APIs.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_COMPRESSED_CACHE_SYNC', 
 'Waiting for access to the cache of compressed log blocks that is used to avoid redundant compression of the log blocks sent to multiple secondary databases.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_CONNECTIVITY_INFO', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_DATABASE_FLOW_CONTROL', 
 'Waiting for messages to be sent to the partner when the maximum number of queued messages has been reached. Indicates that the log scans are running faster than the network sends. This is an issue only if network sends are slower than expected.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_DATABASE_VERSIONING_STATE', 
 'Occurs on the versioning state change of an Always On secondary database. This wait is for internal data structures and is usually is very short with no direct effect on data access.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_DATABASE_WAIT_FOR_RECOVERY', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_DATABASE_WAIT_FOR_RESTART', 
 'Waiting for the database to restart under Always On Availability Groups control. Under normal conditions, this is not a customer issue because waits are expected here.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_DATABASE_WAIT_FOR_TRANSITION_TO_VERSIONING', 
 'A query on object(s) in a readable secondary database of an Always On availability group is blocked on row versioning while waiting for commit or rollback of all transactions that were in-flight when the secondary replica was enabled for read workloads. This wait type guarantees that row versions are available before execution of a query under snapshot isolation.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_DB_COMMAND', 
 'Waiting for responses to conversational messages (which require an explicit response from the other side, using the Always On conversational message infrastructure). A number of different message types use this wait type.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_DB_OP_COMPLETION_SYNC', 
 'Waiting for responses to conversational messages (which require an explicit response from the other side, using the Always On conversational message infrastructure). A number of different message types use this wait type.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_DB_OP_START_SYNC', 
 'An Always On DDL statement or a Windows Server Failover Clustering command is waiting for serialized access to an availability database and its runtime state.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_DBR_SUBSCRIBER', 
 'The publisher for an availability replica event (such as a state change or configuration change) is waiting for exclusive read/write access to the runtime state of an event subscriber that corresponds to an availability database. Internal use only.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_DBR_SUBSCRIBER_FILTER_LIST', 
 'The publisher for an availability replica event (such as a state change or configuration change) is waiting for exclusive read/write access to the list of event subscribers that correspond to availability databases. Internal use only.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_DBSEEDING', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_DBSEEDING_LIST', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_DBSTATECHANGE_SYNC', 
 'Concurrency control wait for updating the internal state of the database replica.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_FABRIC_CALLBACK', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_FILESTREAM_BLOCK_FLUSH', 
 'The FILESTREAM Always On transport manager is waiting until processing of a log block is finished.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_FILESTREAM_FILE_CLOSE', 
 'The FILESTREAM Always On transport manager is waiting until the next FILESTREAM file gets processed and its handle gets closed.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_FILESTREAM_FILE_REQUEST', 
 'An Always On secondary replica is waiting for the primary replica to send all requested FILESTREAM files during UNDO.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_FILESTREAM_IOMGR', 
 'The FILESTREAM Always On transport manager is waiting for R/W lock that protects the FILESTREAM Always On I/O manager during startup or shutdown.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_FILESTREAM_IOMGR_IOCOMPLETION', 
 'The FILESTREAM Always On I/O manager is waiting for I/O completion.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_FILESTREAM_MANAGER', 
 'The FILESTREAM Always On transport manager is waiting for the R/W lock that protects the FILESTREAM Always On transport manager during startup or shutdown.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_FILESTREAM_PREPROC', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_GROUP_COMMIT', 
 'Transaction commit processing is waiting to allow a group commit so that multiple commit log records can be put into a single log block. This wait is an expected condition that optimizes the log I/O, capture, and send operations.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_LOGCAPTURE_SYNC', 
 'Concurrency control around the log capture or apply object when creating or destroying scans. This is an expected wait when partners change state or connection status.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_LOGCAPTURE_WAIT', 
 'Waiting for log records to become available. Can occur either when waiting for new log records to be generated by connections or for I/O completion when reading log not in the cache. This is an expected wait if the log scan is caught up to the end of log or is reading from disk.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_LOGPROGRESS_SYNC', 
 'Concurrency control wait when updating the log progress status of database replicas.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_NOTIFICATION_DEQUEUE', 
 'A background task that processes Windows Server Failover Clustering notifications is waiting for the next notification. Internal use only.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_NOTIFICATION_WORKER_EXCLUSIVE_ACCESS', 
 'The Always On availability replica manager is waiting for serialized access to the runtime state of a background task that processes Windows Server Failover Clustering notifications. Internal use only.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_NOTIFICATION_WORKER_STARTUP_SYNC', 
 'A background task is waiting for the completion of the startup of a background task that processes Windows Server Failover Clustering notifications. Internal use only.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_NOTIFICATION_WORKER_TERMINATION_SYNC', 
 'A background task is waiting for the termination of a background task that processes Windows Server Failover Clustering notifications. Internal use only.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_PARTNER_SYNC', 
 'Concurrency control wait on the partner list.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_READ_ALL_NETWORKS', 
 'Waiting to get read or write access to the list of WSFC networks. Internal use only. Note: The engine keeps a list of WSFC networks that is used in dynamic management views (such as sys.dm_hadr_cluster_networks) or to validate Always On Transact-SQL statements that reference WSFC network information. This list is updated upon engine startup, WSFC related notifications, and internal Always On restart (for example, losing and regaining of WSFC quorum). Tasks will usually be blocked when an update in that list is in progress. ,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_RECOVERY_WAIT_FOR_CONNECTION', 
 'Waiting for the secondary database to connect to the primary database before running recovery. This is an expected wait, which can lengthen if the connection to the primary is slow to establish.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_RECOVERY_WAIT_FOR_UNDO', 
 'Database recovery is waiting for the secondary database to finish the reverting and initializing phase to bring it back to the common log point with the primary database. This is an expected wait after failovers.Undo progress can be tracked through the Windows System Monitor (perfmon.exe) and dynamic management views.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_REPLICAINFO_SYNC', 
 'Waiting for concurrency control to update the current replica state.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_SEEDING_CANCELLATION', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_SEEDING_FILE_LIST', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_SEEDING_LIMIT_BACKUPS', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_SEEDING_SYNC_COMPLETION', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_SEEDING_TIMEOUT_TASK', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_SEEDING_WAIT_FOR_COMPLETION', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_SYNC_COMMIT', 
 'Waiting for transaction commit processing for the synchronized secondary databases to harden the log. This wait is also reflected by the Transaction Delay performance counter. This wait type is expected for synchronized availability groups and indicates the time to send, write, and acknowledge log to the secondary databases.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_SYNCHRONIZING_THROTTLE', 
 'Waiting for transaction commit processing to allow a synchronizing secondary database to catch up to the primary end of log in order to transition to the synchronized state. This is an expected wait when a secondary database is catching up.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_TDS_LISTENER_SYNC', 
 'Either the internal Always On system or the WSFC cluster will request that listeners are started or stopped. The processing of this request is always asynchronous, and there is a mechanism to remove redundant requests. There are also moments that this process is suspended because of configuration changes. All waits related with this listener synchronization mechanism use this wait type. Internal use only.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_TDS_LISTENER_SYNC_PROCESSING', 
 'Used at the end of an Always On Transact-SQL statement that requires starting and/or stopping anavailability group listener. Since the start/stop operation is done asynchronously, the user thread will block using this wait type until the situation of the listener is known.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_THROTTLE_LOG_RATE_GOVERNOR', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_THROTTLE_LOG_RATE_LOG_SIZE', 
 'TBD: Applies to: SQL Server 2017 (14.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_THROTTLE_LOG_RATE_SEEDING', 
 'TBD: Applies to: SQL Server 2017 (14.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_THROTTLE_LOG_RATE_SEND_RECV_QUEUE_SIZE', 
 'TBD: Applies to: SQL Server 2017 (14.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_TIMER_TASK', 
 'Waiting to get the lock on the timer task object and is also used for the actual waits between times that work is being performed. For example, for a task that runs every 10 seconds, after one execution, Always On Availability Groups waits about 10 seconds to reschedule the task, and the wait is included here.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_TRANSPORT_DBRLIST', 
 'Waiting for access to the transport layer`s database replica list. Used for the spinlock that grants access to it.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_TRANSPORT_FLOW_CONTROL', 
 'Waiting when the number of outstanding unacknowledged Always On messages is over the out flow control threshold. This is on an availability replica-to-replica basis (not on a database-to-database basis).,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_TRANSPORT_SESSION', 
 'Always On Availability Groups is waiting while changing or accessing the underlying transport state.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_WORK_POOL', 
 'Concurrency control wait on the Always On Availability Groups background work task object.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_WORK_QUEUE', 
 'Always On Availability Groups background worker thread waiting for new work to be assigned. This is an expected wait when there are ready workers waiting for new work, which is the normal state.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_XRF_STACK_ACCESS', 
 'Accessing (look up, add, and delete) the extended recovery fork stack for an Always On availability database.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HCCO_CACHE', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HK_RESTORE_FILEMAP', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HKCS_PARALLEL_MIGRATION', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HKCS_PARALLEL_RECOVERY', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HTBUILD', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HTDELETE', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HTMEMO', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HTREINIT', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HTREPARTITION', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HTTP_ENUMERATION', 
 'Occurs at startup to enumerate the HTTP endpoints to start HTTP.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HTTP_START', 
 'Occurs when a connection is waiting for HTTP to complete initialization.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HTTP_STORAGE_CONNECTION', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('IMPPROV_IOWAIT', 
 'Occurs when SQL Server waits for a bulkload I/O to finish.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('INSTANCE_LOG_RATE_GOVERNOR', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('INTERNAL_TESTING', 
 'Identified for informational purposes only. Not supported. Future compatibility is not guaranteed.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('IO_AUDIT_MUTEX', 
 'Occurs during synchronization of trace event buffers.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('IO_COMPLETION', 
 'Occurs while waiting for I/O operations to complete. This wait type generally represents non-data page I/Os. Data page I/O completion waits appear as PAGEIOLATCH_* waits.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('IO_QUEUE_LIMIT', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('IO_RETRY', 
 'Occurs when an I/O operation such as a read or a write to disk fails because of insufficient resources, and is then retried.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('IOAFF_RANGE_QUEUE', 
 'Identified for informational purposes only. Not supported. Future compatibility is not guaranteed.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('KSOURCE_WAKEUP', 
 'Used by the service control task while waiting for requests from the Service Control Manager. Long waits are expected and do not indicate a problem.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('KTM_ENLISTMENT', 
 'Identified for informational purposes only. Not supported. Future compatibility is not guaranteed.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('KTM_RECOVERY_MANAGER', 
 'Identified for informational purposes only. Not supported. Future compatibility is not guaranteed.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('KTM_RECOVERY_RESOLUTION', 
 'Identified for informational purposes only. Not supported. Future compatibility is not guaranteed.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LATCH_DT', 
 'Occurs when waiting for a DT (destroy) latch. This does not include buffer latches or transaction mark latches. A listing of LATCH_* waits is available in sys.dm_os_latch_stats. Note that sys.dm_os_latch_stats groups LATCH_NL, LATCH_SH, LATCH_UP, LATCH_EX, and LATCH_DT waits together.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LATCH_EX', 
 'Occurs when waiting for an EX (exclusive) latch. This does not include buffer latches or transaction mark latches. A listing of LATCH_* waits is available in sys.dm_os_latch_stats. Note that sys.dm_os_latch_stats groups LATCH_NL, LATCH_SH, LATCH_UP, LATCH_EX, and LATCH_DT waits together.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LATCH_KP', 
 'Occurs when waiting for a KP (keep) latch. This does not include buffer latches or transaction mark latches. A listing of LATCH_* waits is available in sys.dm_os_latch_stats. Note that sys.dm_os_latch_stats groups LATCH_NL, LATCH_SH, LATCH_UP, LATCH_EX, and LATCH_DT waits together.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LATCH_NL', 
 'Identified for informational purposes only. Not supported. Future compatibility is not guaranteed.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LATCH_SH', 
 'Occurs when waiting for an SH (share) latch. This does not include buffer latches or transaction mark latches. A listing of LATCH_* waits is available in sys.dm_os_latch_stats. Note that sys.dm_os_latch_stats groups LATCH_NL, LATCH_SH, LATCH_UP, LATCH_EX, and LATCH_DT waits together.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LATCH_UP', 
 'Occurs when waiting for an UP (update) latch. This does not include buffer latches or transaction mark latches. A listing of LATCH_* waits is available in sys.dm_os_latch_stats. Note that sys.dm_os_latch_stats groups LATCH_NL, LATCH_SH, LATCH_UP, LATCH_EX, and LATCH_DT waits together.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LAZYWRITER_SLEEP', 
 'Occurs when lazywriter tasks are suspended. This is a measure of the time spent by background tasks that are waiting. Do not consider this state when you are looking for user stalls.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_BU', 
 'Occurs when a task is waiting to acquire a Bulk Update (BU) lock.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_BU_ABORT_BLOCKERS', 
 'Occurs when a task is waiting to acquire a Bulk Update (BU) lock with Abort Blockers. (Related to the low priority wait option of ALTER TABLE and ALTER INDEX.),: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_BU_LOW_PRIORITY', 
 'Occurs when a task is waiting to acquire a Bulk Update (BU) lock with Low Priority. (Related to the low priority wait option of ALTER TABLE and ALTER INDEX.),: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_IS', 
 'Occurs when a task is waiting to acquire an Intent Shared (IS) lock.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_IS_ABORT_BLOCKERS', 
 'Occurs when a task is waiting to acquire an Intent Shared (IS) lock with Abort Blockers. (Related to the low priority wait option of ALTER TABLE and ALTER INDEX.),: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_IS_LOW_PRIORITY', 
 'Occurs when a task is waiting to acquire an Intent Shared (IS) lock with Low Priority. (Related to the low priority wait option of ALTER TABLE and ALTER INDEX.),: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_IU', 
 'Occurs when a task is waiting to acquire an Intent Update (IU) lock.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_IU_ABORT_BLOCKERS', 
 'Occurs when a task is waiting to acquire an Intent Update (IU) lock with Abort Blockers. (Related to the low priority wait option of ALTER TABLE and ALTER INDEX.),: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_IU_LOW_PRIORITY', 
 'Occurs when a task is waiting to acquire an Intent Update (IU) lock with Low Priority. (Related to the low priority wait option of ALTER TABLE and ALTER INDEX.),: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_IX', 
 'Occurs when a task is waiting to acquire an Intent Exclusive (IX) lock.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_IX_ABORT_BLOCKERS', 
 'Occurs when a task is waiting to acquire an Intent Exclusive (IX) lock with Abort Blockers. (Related to the low priority wait option of ALTER TABLE and ALTER INDEX.),: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_IX_LOW_PRIORITY', 
 'Occurs when a task is waiting to acquire an Intent Exclusive (IX) lock with Low Priority. (Related to the low priority wait option of ALTER TABLE and ALTER INDEX.),: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_RIn_NL', 
 'Occurs when a task is waiting to acquire a NULL lock on the current key value, and an Insert Range lock between the current and previous key. A NULL lock on the key is an instant release lock.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_RIn_NL_ABORT_BLOCKERS', 
 'Occurs when a task is waiting to acquire a NULL lock with Abort Blockers on the current key value, and an Insert Range lock with Abort Blockers between the current and previous key. A NULL lock on the key is an instant release lock. (Related to the low priority wait option of ALTER TABLE and ALTER INDEX.),: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_RIn_NL_LOW_PRIORITY', 
 'Occurs when a task is waiting to acquire a NULL lock with Low Priority on the current key value, and an Insert Range lock with Low Priority between the current and previous key. A NULL lock on the key is an instant release lock. (Related to the low priority wait option of ALTER TABLE and ALTER INDEX.),: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_RIn_S', 
 'Occurs when a task is waiting to acquire a shared lock on the current key value, and an Insert Range lock between the current and previous key.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_RIn_S_ABORT_BLOCKERS', 
 'Occurs when a task is waiting to acquire a shared lock with Abort Blockers on the current key value, and an Insert Range lock with Abort Blockers between the current and previous key. (Related to the low priority wait option of ALTER TABLE and ALTER INDEX.),: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_RIn_S_LOW_PRIORITY', 
 'Occurs when a task is waiting to acquire a shared lock with Low Priority on the current key value, and an Insert Range lock with Low Priority between the current and previous key. (Related to the low priority wait option of ALTER TABLE and ALTER INDEX.),: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_RIn_U', 
 'Task is waiting to acquire an Update lock on the current key value, and an Insert Range lock between the current and previous key.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_RIn_U_ABORT_BLOCKERS', 
 'Task is waiting to acquire an Update lock with Abort Blockers on the current key value, and an Insert Range lock with Abort Blockers between the current and previous key. (Related to the low priority wait option of ALTER TABLE and ALTER INDEX.),: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_RIn_U_LOW_PRIORITY', 
 'Task is waiting to acquire an Update lock with Low Priority on the current key value, and an Insert Range lock with Low Priority between the current and previous key. (Related to the low priority wait option of ALTER TABLE and ALTER INDEX.),: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_RIn_X', 
 'Occurs when a task is waiting to acquire an Exclusive lock on the current key value, and an Insert Range lock between the current and previous key.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_RIn_X_ABORT_BLOCKERS', 
 'Occurs when a task is waiting to acquire an Exclusive lock with Abort Blockers on the current key value, and an Insert Range lock with Abort Blockers between the current and previous key. (Related to the low priority wait option of ALTER TABLE and ALTER INDEX.),: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_RIn_X_LOW_PRIORITY', 
 'Occurs when a task is waiting to acquire an Exclusive lock with Low Priority on the current key value, and an Insert Range lock with Low Priority between the current and previous key. (Related to the low priority wait option of ALTER TABLE and ALTER INDEX.),: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_RS_S', 
 'Occurs when a task is waiting to acquire a Shared lock on the current key value, and a Shared Range lock between the current and previous key.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_RS_S_ABORT_BLOCKERS', 
 'Occurs when a task is waiting to acquire a Shared lock with Abort Blockers on the current key value, and a Shared Range lock with Abort Blockers between the current and previous key. (Related to the low priority wait option of ALTER TABLE and ALTER INDEX.),: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_RS_S_LOW_PRIORITY', 
 'Occurs when a task is waiting to acquire a Shared lock with Low Priority on the current key value, and a Shared Range lock with Low Priority between the current and previous key. (Related to the low priority wait option of ALTER TABLE and ALTER INDEX.),: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_RS_U', 
 'Occurs when a task is waiting to acquire an Update lock on the current key value, and an Update Range lock between the current and previous key.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_RS_U_ABORT_BLOCKERS', 
 'Occurs when a task is waiting to acquire an Update lock with Abort Blockers on the current key value, and an Update Range lock with Abort Blockers between the current and previous key. (Related to the low priority wait option of ALTER TABLE and ALTER INDEX.),: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_RS_U_LOW_PRIORITY', 
 'Occurs when a task is waiting to acquire an Update lock with Low Priority on the current key value, and an Update Range lock with Low Priority between the current and previous key. (Related to the low priority wait option of ALTER TABLE and ALTER INDEX.),: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_RX_S', 
 'Occurs when a task is waiting to acquire a Shared lock on the current key value, and an Exclusive Range lock between the current and previous key.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_RX_S_ABORT_BLOCKERS', 
 'Occurs when a task is waiting to acquire a Shared lock with Abort Blockers on the current key value, and an Exclusive Range with Abort Blockers lock between the current and previous key. (Related to the low priority wait option of ALTER TABLE and ALTER INDEX.),: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_RX_S_LOW_PRIORITY', 
 'Occurs when a task is waiting to acquire a Shared lock with Low Priority on the current key value, and an Exclusive Range with Low Priority lock between the current and previous key. (Related to the low priority wait option of ALTER TABLE and ALTER INDEX.),: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_RX_U', 
 'Occurs when a task is waiting to acquire an Update lock on the current key value, and an Exclusive range lock between the current and previous key.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_RX_U_ABORT_BLOCKERS', 
 'Occurs when a task is waiting to acquire an Update lock with Abort Blockers on the current key value, and an Exclusive range lock with Abort Blockers between the current and previous key. (Related to the low priority wait option of ALTER TABLE and ALTER INDEX.),: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_RX_U_LOW_PRIORITY', 
 'Occurs when a task is waiting to acquire an Update lock with Low Priority on the current key value, and an Exclusive range lock with Low Priority between the current and previous key. (Related to the low priority wait option of ALTER TABLE and ALTER INDEX.),: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_RX_X', 
 'Occurs when a task is waiting to acquire an Exclusive lock on the current key value, and an Exclusive Range lock between the current and previous key.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_RX_X_ABORT_BLOCKERS', 
 'Occurs when a task is waiting to acquire an Exclusive lock with Abort Blockers on the current key value, and an Exclusive Range lock with Abort Blockers between the current and previous key. (Related to the low priority wait option of ALTER TABLE and ALTER INDEX.),: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_RX_X_LOW_PRIORITY', 
 'Occurs when a task is waiting to acquire an Exclusive lock with Low Priority on the current key value, and an Exclusive Range lock with Low Priority between the current and previous key. (Related to the low priority wait option of ALTER TABLE and ALTER INDEX.),: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_S', 
 'Occurs when a task is waiting to acquire a Shared lock.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_S_ABORT_BLOCKERS', 
 'Occurs when a task is waiting to acquire a Shared lock with Abort Blockers. (Related to the low priority wait option of ALTER TABLE and ALTER INDEX.),: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_S_LOW_PRIORITY', 
 'Occurs when a task is waiting to acquire a Shared lock with Low Priority. (Related to the low priority wait option of ALTER TABLE and ALTER INDEX.),: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_SCH_M', 
 'Occurs when a task is waiting to acquire a Schema Modify lock.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_SCH_M_ABORT_BLOCKERS', 
 'Occurs when a task is waiting to acquire a Schema Modify lock with Abort Blockers. (Related to the low priority wait option of ALTER TABLE and ALTER INDEX.),: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_SCH_M_LOW_PRIORITY', 
 'Occurs when a task is waiting to acquire a Schema Modify lock with Low Priority. (Related to the low priority wait option of ALTER TABLE and ALTER INDEX.),: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_SCH_S', 
 'Occurs when a task is waiting to acquire a Schema Share lock.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_SCH_S_ABORT_BLOCKERS', 
 'Occurs when a task is waiting to acquire a Schema Share lock with Abort Blockers. (Related to the low priority wait option of ALTER TABLE and ALTER INDEX.),: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_SCH_S_LOW_PRIORITY', 
 'Occurs when a task is waiting to acquire a Schema Share lock with Low Priority. (Related to the low priority wait option of ALTER TABLE and ALTER INDEX.),: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_SIU', 
 'Occurs when a task is waiting to acquire a Shared With Intent Update lock.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_SIU_ABORT_BLOCKERS', 
 'Occurs when a task is waiting to acquire a Shared With Intent Update lock with Abort Blockers. (Related to the low priority wait option of ALTER TABLE and ALTER INDEX.),: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_SIU_LOW_PRIORITY', 
 'Occurs when a task is waiting to acquire a Shared With Intent Update lock with Low Priority. (Related to the low priority wait option of ALTER TABLE and ALTER INDEX.),: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_SIX', 
 'Occurs when a task is waiting to acquire a Shared With Intent Exclusive lock.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_SIX_ABORT_BLOCKERS', 
 'Occurs when a task is waiting to acquire a Shared With Intent Exclusive lock with Abort Blockers. (Related to the low priority wait option of ALTER TABLE and ALTER INDEX.),: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_SIX_LOW_PRIORITY', 
 'Occurs when a task is waiting to acquire a Shared With Intent Exclusive lock with Low Priority. (Related to the low priority wait option of ALTER TABLE and ALTER INDEX.),: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_U', 
 'Occurs when a task is waiting to acquire an Update lock.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_U_ABORT_BLOCKERS', 
 'Occurs when a task is waiting to acquire an Update lock with Abort Blockers. (Related to the low priority wait option of ALTER TABLE and ALTER INDEX.),: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_U_LOW_PRIORITY', 
 'Occurs when a task is waiting to acquire an Update lock with Low Priority. (Related to the low priority wait option of ALTER TABLE and ALTER INDEX.),: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_UIX', 
 'Occurs when a task is waiting to acquire an Update With Intent Exclusive lock.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_UIX_ABORT_BLOCKERS', 
 'Occurs when a task is waiting to acquire an Update With Intent Exclusive lock with Abort Blockers. (Related to the low priority wait option of ALTER TABLE and ALTER INDEX.),: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_UIX_LOW_PRIORITY', 
 'Occurs when a task is waiting to acquire an Update With Intent Exclusive lock with Low Priority. (Related to the low priority wait option of ALTER TABLE and ALTER INDEX.),: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_X', 
 'Occurs when a task is waiting to acquire an Exclusive lock.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_X_ABORT_BLOCKERS', 
 'Occurs when a task is waiting to acquire an Exclusive lock with Abort Blockers. (Related to the low priority wait option of ALTER TABLE and ALTER INDEX.),: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_X_LOW_PRIORITY', 
 'Occurs when a task is waiting to acquire an Exclusive lock with Low Priority. (Related to the low priority wait option of ALTER TABLE and ALTER INDEX.),: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LOG_POOL_SCAN', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LOG_RATE_GOVERNOR', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LOGBUFFER', 
 'Occurs when a task is waiting for space in the log buffer to store a log record. Consistently high values may indicate that the log devices cannot keep up with the amount of log being generated by the server.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LOGCAPTURE_LOGPOOLTRUNCPOINT', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LOGGENERATION', 
 'Identified for informational purposes only. Not supported. Future compatibility is not guaranteed.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LOGMGR', 
 'Occurs when a task is waiting for any outstanding log I/Os to finish before shutting down the log while closing the database.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LOGMGR_FLUSH', 
 'Identified for informational purposes only. Not supported. Future compatibility is not guaranteed.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LOGMGR_PMM_LOG', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LOGMGR_QUEUE', 
 'Occurs while the log writer task waits for work requests.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LOGMGR_RESERVE_APPEND', 
 'Occurs when a task is waiting to see whether log truncation frees up log space to enable the task to write a new log record. Consider increasing the size of the log file(s) for the affected database to reduce this wait.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LOGPOOL_CACHESIZE', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LOGPOOL_CONSUMER', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LOGPOOL_CONSUMERSET', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LOGPOOL_FREEPOOLS', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LOGPOOL_MGRSET', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LOGPOOL_REPLACEMENTSET', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LOGPOOLREFCOUNTEDOBJECT_REFDONE', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LOWFAIL_MEMMGR_QUEUE', 
 'Occurs while waiting for memory to be available for use.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('MD_AGENT_YIELD', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('MD_LAZYCACHE_RWLOCK', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('MEMORY_ALLOCATION_EXT', 
 'Occurs while allocating memory from either the internal SQL Server memory pool or the operation system.,: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('MEMORY_GRANT_UPDATE', 
 'TBD: Applies to: SQL Server 2017 (14.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('METADATA_LAZYCACHE_RWLOCK', 
 'TBD: Applies to: SQL Server 2008 R2 only.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('MIGRATIONBUFFER', 
 'TBD: Applies to: SQL Server 2017 (14.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('MISCELLANEOUS', 
 'Identified for informational purposes only. Not supported. Future compatibility is not guaranteed.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('MISCELLANEOUS', 
 'Identified for informational purposes only. Not supported. Future compatibility is not guaranteed.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('MSQL_DQ', 
 'Occurs when a task is waiting for a distributed query operation to finish. This is used to detect potential Multiple Active Result Set (MARS) application deadlocks. The wait ends when the distributed query call finishes.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('MSQL_XACT_MGR_MUTEX', 
 'Occurs when a task is waiting to obtain ownership of the session transaction manager to perform a session level transaction operation.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('MSQL_XACT_MUTEX', 
 'Occurs during synchronization of transaction usage. A request must acquire the mutex before it can use the transaction.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('MSQL_XP', 
 'Occurs when a task is waiting for an extended stored procedure to end. SQL Server uses this wait state to detect potential MARS application deadlocks. The wait stops when the extended stored procedure call ends.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('MSSEARCH', 
 'Occurs during Full-Text Search calls. This wait ends when the full-text operation completes. It does not indicate contention, but rather the duration of full-text operations.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('NET_WAITFOR_PACKET', 
 'Occurs when a connection is waiting for a network packet during a network read.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('NETWORKSXMLMGRLOAD', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('NODE_CACHE_MUTEX', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('OLEDB', 
 'Occurs when SQL Server calls the SQL Server Native Client OLE DB Provider. This wait type is not used for synchronization. Instead, it indicates the duration of calls to the OLE DB provider.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('ONDEMAND_TASK_QUEUE', 
 'Occurs while a background task waits for high priority system task requests. Long wait times indicate that there have been no high priority requests to process, and should not cause concern.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PAGEIOLATCH_DT', 
 'Occurs when a task is waiting on a latch for a buffer that is in an I/O request. The latch request is in Destroy mode. Long waits may indicate problems with the disk subsystem.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PAGEIOLATCH_EX', 
 'Occurs when a task is waiting on a latch for a buffer that is in an I/O request. The latch request is in Exclusive mode. Long waits may indicate problems with the disk subsystem.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PAGEIOLATCH_KP', 
 'Occurs when a task is waiting on a latch for a buffer that is in an I/O request. The latch request is in Keep mode. Long waits may indicate problems with the disk subsystem.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PAGEIOLATCH_NL', 
 'Identified for informational purposes only. Not supported. Future compatibility is not guaranteed.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PAGEIOLATCH_SH', 
 'Occurs when a task is waiting on a latch for a buffer that is in an I/O request. The latch request is in Shared mode. Long waits may indicate problems with the disk subsystem.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PAGEIOLATCH_UP', 
 'Occurs when a task is waiting on a latch for a buffer that is in an I/O request. The latch request is in Update mode. Long waits may indicate problems with the disk subsystem.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PAGELATCH_DT', 
 'Occurs when a task is waiting on a latch for a buffer that is not in an I/O request. The latch request is in Destroy mode.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PAGELATCH_EX', 
 'Occurs when a task is waiting on a latch for a buffer that is not in an I/O request. The latch request is in Exclusive mode.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PAGELATCH_KP', 
 'Occurs when a task is waiting on a latch for a buffer that is not in an I/O request. The latch request is in Keep mode.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PAGELATCH_NL', 
 'Identified for informational purposes only. Not supported. Future compatibility is not guaranteed.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PAGELATCH_SH', 
 'Occurs when a task is waiting on a latch for a buffer that is not in an I/O request. The latch request is in Shared mode.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PAGELATCH_UP', 
 'Occurs when a task is waiting on a latch for a buffer that is not in an I/O request. The latch request is in Update mode.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PARALLEL_BACKUP_QUEUE', 
 'Occurs when serializing output produced by RESTORE HEADERONLY, RESTORE FILELISTONLY, or RESTORE LABELONLY.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PARALLEL_REDO_DRAIN_WORKER', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PARALLEL_REDO_FLOW_CONTROL', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PARALLEL_REDO_LOG_CACHE', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PARALLEL_REDO_TRAN_LIST', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PARALLEL_REDO_TRAN_TURN', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PARALLEL_REDO_WORKER_SYNC', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PARALLEL_REDO_WORKER_WAIT_WORK', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PERFORMANCE_COUNTERS_RWLOCK', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PHYSICAL_SEEDING_DMV', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('POOL_LOG_RATE_GOVERNOR', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_ABR', 
 'Identified for informational purposes only. Not supported. Future compatibility is not guaranteed.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_AUDIT_ACCESS_EVENTLOG', 
 'Occurs when the SQL Server Operating System (SQLOS) scheduler switches to preemptive mode to write an audit event to the Windows event log.: Applies to: SQL Server 2008 R2 only.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_AUDIT_ACCESS_SECLOG', 
 'Occurs when the SQLOS scheduler switches to preemptive mode to write an audit event to the Windows Security log.: Applies to: SQL Server 2008 R2 only.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_CLOSEBACKUPMEDIA', 
 'Occurs when the SQLOS scheduler switches to preemptive mode to close backup media.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_CLOSEBACKUPTAPE', 
 'Occurs when the SQLOS scheduler switches to preemptive mode to close a tape backup device.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_CLOSEBACKUPVDIDEVICE', 
 'Occurs when the SQLOS scheduler switches to preemptive mode to close a virtual backup device.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_CLUSAPI_CLUSTERRESOURCECONTROL', 
 'Occurs when the SQLOS scheduler switches to preemptive mode to perform Windows failover cluster operations.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_COM_COCREATEINSTANCE', 
 'Occurs when the SQLOS scheduler switches to preemptive mode to create a COM object.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_COM_COGETCLASSOBJECT', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_COM_CREATEACCESSOR', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_COM_DELETEROWS', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_COM_GETCOMMANDTEXT', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_COM_GETDATA', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_COM_GETNEXTROWS', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_COM_GETRESULT', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_COM_GETROWSBYBOOKMARK', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_COM_LBFLUSH', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_COM_LBLOCKREGION', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_COM_LBREADAT', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_COM_LBSETSIZE', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_COM_LBSTAT', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_COM_LBUNLOCKREGION', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_COM_LBWRITEAT', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_COM_QUERYINTERFACE', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_COM_RELEASE', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_COM_RELEASEACCESSOR', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_COM_RELEASEROWS', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_COM_RELEASESESSION', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_COM_RESTARTPOSITION', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_COM_SEQSTRMREAD', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_COM_SEQSTRMREADANDWRITE', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_COM_SETDATAFAILURE', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_COM_SETPARAMETERINFO', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_COM_SETPARAMETERPROPERTIES', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_COM_STRMLOCKREGION', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_COM_STRMSEEKANDREAD', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_COM_STRMSEEKANDWRITE', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_COM_STRMSETSIZE', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_COM_STRMSTAT', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_COM_STRMUNLOCKREGION', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_CONSOLEWRITE', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_CREATEPARAM', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_DEBUG', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_DFSADDLINK', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_DFSLINKEXISTCHECK', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_DFSLINKHEALTHCHECK', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_DFSREMOVELINK', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_DFSREMOVEROOT', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_DFSROOTFOLDERCHECK', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_DFSROOTINIT', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_DFSROOTSHARECHECK', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_DTC_ABORT', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_DTC_ABORTREQUESTDONE', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_DTC_BEGINTRANSACTION', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_DTC_COMMITREQUESTDONE', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_DTC_ENLIST', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_DTC_PREPAREREQUESTDONE', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_FILESIZEGET', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_FSAOLEDB_ABORTTRANSACTION', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_FSAOLEDB_COMMITTRANSACTION', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_FSAOLEDB_STARTTRANSACTION', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_FSRECOVER_UNCONDITIONALUNDO', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_GETRMINFO', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_HADR_LEASE_MECHANISM', 
 'Always On Availability Groups lease manager scheduling for CSS diagnostics.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_HTTP_EVENT_WAIT', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_HTTP_REQUEST', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_LOCKMONITOR', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_MSS_RELEASE', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_ODBCOPS', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OLE_UNINIT', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OLEDB_ABORTORCOMMITTRAN', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OLEDB_ABORTTRAN', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OLEDB_GETDATASOURCE', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OLEDB_GETLITERALINFO', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OLEDB_GETPROPERTIES', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OLEDB_GETPROPERTYINFO', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OLEDB_GETSCHEMALOCK', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OLEDB_JOINTRANSACTION', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OLEDB_RELEASE', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OLEDB_SETPROPERTIES', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OLEDBOPS', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_ACCEPTSECURITYCONTEXT', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_ACQUIRECREDENTIALSHANDLE', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_AUTHENTICATIONOPS', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_AUTHORIZATIONOPS', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_AUTHZGETINFORMATIONFROMCONTEXT', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_AUTHZINITIALIZECONTEXTFROMSID', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_AUTHZINITIALIZERESOURCEMANAGER', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_BACKUPREAD', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_CLOSEHANDLE', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_CLUSTEROPS', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_COMOPS', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_COMPLETEAUTHTOKEN', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_COPYFILE', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_CREATEDIRECTORY', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_CREATEFILE', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_CRYPTACQUIRECONTEXT', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_CRYPTIMPORTKEY', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_CRYPTOPS', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_DECRYPTMESSAGE', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_DELETEFILE', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_DELETESECURITYCONTEXT', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_DEVICEIOCONTROL', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_DEVICEOPS', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_DIRSVC_NETWORKOPS', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_DISCONNECTNAMEDPIPE', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_DOMAINSERVICESOPS', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_DSGETDCNAME', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_DTCOPS', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_ENCRYPTMESSAGE', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_FILEOPS', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_FINDFILE', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_FLUSHFILEBUFFERS', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_FORMATMESSAGE', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_FREECREDENTIALSHANDLE', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_FREELIBRARY', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_GENERICOPS', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_GETADDRINFO', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_GETCOMPRESSEDFILESIZE', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_GETDISKFREESPACE', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_GETFILEATTRIBUTES', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_GETFILESIZE', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_GETFINALFILEPATHBYHANDLE', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_GETLONGPATHNAME', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_GETPROCADDRESS', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_GETVOLUMENAMEFORVOLUMEMOUNTPOINT', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_GETVOLUMEPATHNAME', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_INITIALIZESECURITYCONTEXT', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_LIBRARYOPS', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_LOADLIBRARY', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_LOGONUSER', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_LOOKUPACCOUNTSID', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_MESSAGEQUEUEOPS', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_MOVEFILE', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_NETGROUPGETUSERS', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_NETLOCALGROUPGETMEMBERS', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_NETUSERGETGROUPS', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_NETUSERGETLOCALGROUPS', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_NETUSERMODALSGET', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_NETVALIDATEPASSWORDPOLICY', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_NETVALIDATEPASSWORDPOLICYFREE', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_OPENDIRECTORY', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_PDH_WMI_INIT', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_PIPEOPS', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_PROCESSOPS', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_QUERYCONTEXTATTRIBUTES', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_QUERYREGISTRY', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_QUERYSECURITYCONTEXTTOKEN', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_REMOVEDIRECTORY', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_REPORTEVENT', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_REVERTTOSELF', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_RSFXDEVICEOPS', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_SECURITYOPS', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_SERVICEOPS', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_SETENDOFFILE', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_SETFILEPOINTER', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_SETFILEVALIDDATA', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_SETNAMEDSECURITYINFO', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_SQLCLROPS', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_SQMLAUNCH', 
 'TBD: Applies to: SQL Server 2008 R2 through SQL Server 2016 (13.x).'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_VERIFYSIGNATURE', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_VERIFYTRUST', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_VSSOPS', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_WAITFORSINGLEOBJECT', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_WINSOCKOPS', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_WRITEFILE', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_WRITEFILEGATHER', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_WSASETLASTERROR', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_REENLIST', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_RESIZELOG', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_ROLLFORWARDREDO', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_ROLLFORWARDUNDO', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_SB_STOPENDPOINT', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_SERVER_STARTUP', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_SETRMINFO', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_SHAREDMEM_GETDATA', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_SNIOPEN', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_SOSHOST', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_SOSTESTING', 
 'Identified for informational purposes only. Not supported. Future compatibility is not guaranteed.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_SP_SERVER_DIAGNOSTICS', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_STARTRM', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_STREAMFCB_CHECKPOINT', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_STREAMFCB_RECOVER', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_STRESSDRIVER', 
 'Identified for informational purposes only. Not supported. Future compatibility is not guaranteed.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_TESTING', 
 'Identified for informational purposes only. Not supported. Future compatibility is not guaranteed.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_TRANSIMPORT', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_UNMARSHALPROPAGATIONTOKEN', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_VSS_CREATESNAPSHOT', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_VSS_CREATEVOLUMESNAPSHOT', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_XE_CALLBACKEXECUTE', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_XE_CX_FILE_OPEN', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_XE_CX_HTTP_CALL', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_XE_DISPATCHER', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_XE_ENGINEINIT', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_XE_GETTARGETSTATE', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_XE_SESSIONCOMMIT', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_XE_TARGETFINALIZE', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_XE_TARGETINIT', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_XE_TIMERRUN', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_XETESTING', 
 'Identified for informational purposes only. Not supported. Future compatibility is not guaranteed.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PRINT_ROLLBACK_PROGRESS', 
 'Used to wait while user processes are ended in a database that has been transitioned by using the ALTER DATABASE termination clause. For more information, see ALTER DATABASE (Transact-SQL).'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PRU_ROLLBACK_DEFERRED', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PWAIT_ALL_COMPONENTS_INITIALIZED', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PWAIT_COOP_SCAN', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PWAIT_DIRECTLOGCONSUMER_GETNEXT', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PWAIT_EVENT_SESSION_INIT_MUTEX', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PWAIT_FABRIC_REPLICA_CONTROLLER_DATA_LOSS', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PWAIT_HADR_ACTION_COMPLETED', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PWAIT_HADR_CHANGE_NOTIFIER_TERMINATION_SYNC', 
 'Occurs when a background task is waiting for the termination of the background task that receives (via polling) Windows Server Failover Clustering notifications.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PWAIT_HADR_CLUSTER_INTEGRATION', 
 'An append, replace, and/or remove operation is waiting to grab a write lock on an Always On internal list (such as a list of networks, network addresses, or availability group listeners). Internal use only,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PWAIT_HADR_FAILOVER_COMPLETED', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PWAIT_HADR_JOIN', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PWAIT_HADR_OFFLINE_COMPLETED', 
 'An Always On drop availability group operation is waiting for the target availability group to go offline before destroying Windows Server Failover Clustering objects.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PWAIT_HADR_ONLINE_COMPLETED', 
 'An Always On create or failover availability group operation is waiting for the target availability group to come online.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PWAIT_HADR_POST_ONLINE_COMPLETED', 
 'An Always On drop availability group operation is waiting for the termination of any background task that was scheduled as part of a previous command. For example, there may be a background task that is transitioning availability databases to the primary role. The DROP AVAILABILITY GROUP DDL must wait for this background task to terminate in order to avoid race conditions.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PWAIT_HADR_SERVER_READY_CONNECTIONS', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PWAIT_HADR_WORKITEM_COMPLETED', 
 'Internal wait by a thread waiting for an async work task to complete. This is an expected wait and is for CSS use.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PWAIT_HADRSIM', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PWAIT_LOG_CONSOLIDATION_IO', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PWAIT_LOG_CONSOLIDATION_POLL', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PWAIT_MD_LOGIN_STATS', 
 'Occurs during internal synchronization in metadata on login stats.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PWAIT_MD_RELATION_CACHE', 
 'Occurs during internal synchronization in metadata on table or index.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PWAIT_MD_SERVER_CACHE', 
 'Occurs during internal synchronization in metadata on linked servers.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PWAIT_MD_UPGRADE_CONFIG', 
 'Occurs during internal synchronization in upgrading server wide configurations.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PWAIT_PREEMPTIVE_APP_USAGE_TIMER', 
 'TBD: Applies to: SQL Server 2017 (14.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PWAIT_PREEMPTIVE_AUDIT_ACCESS_WINDOWSLOG', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PWAIT_QRY_BPMEMORY', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PWAIT_REPLICA_ONLINE_INIT_MUTEX', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PWAIT_RESOURCE_SEMAPHORE_FT_PARALLEL_QUERY_SYNC', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PWAIT_SBS_FILE_OPERATION', 
 'TBD: Applies to: SQL Server 2017 (14.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PWAIT_XTP_FSSTORAGE_MAINTENANCE', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PWAIT_XTP_HOST_STORAGE_WAIT', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('QDS_ASYNC_CHECK_CONSISTENCY_TASK', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('QDS_ASYNC_PERSIST_TASK', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('QDS_ASYNC_PERSIST_TASK_START', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('QDS_ASYNC_QUEUE', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('QDS_BCKG_TASK', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('QDS_BLOOM_FILTER', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('QDS_CLEANUP_STALE_QUERIES_TASK_MAIN_LOOP_SLEEP', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('QDS_CTXS', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('QDS_DB_DISK', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('QDS_DYN_VECTOR', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('QDS_EXCLUSIVE_ACCESS', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('QDS_HOST_INIT', 
 'TBD: Applies to: SQL Server 2017 (14.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('QDS_LOADDB', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('QDS_PERSIST_TASK_MAIN_LOOP_SLEEP', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('QDS_QDS_CAPTURE_INIT', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('QDS_SHUTDOWN_QUEUE', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('QDS_STMT', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('QDS_STMT_DISK', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('QDS_TASK_SHUTDOWN', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('QDS_TASK_START', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('QE_WARN_LIST_SYNC', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('QPJOB_KILL', 
 'Indicates that an asynchronous automatic statistics update was canceled by a call to KILL as the update was starting to run. The terminating thread is suspended, waiting for it to start listening for KILL commands. A good value is less than one second.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('QPJOB_WAITFOR_ABORT', 
 'Indicates that an asynchronous automatic statistics update was canceled by a call to KILL when it was running. The update has now completed but is suspended until the terminating thread message coordination is complete. This is an ordinary but rare state, and should be very short. A good value is less than one second.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('QRY_MEM_GRANT_INFO_MUTEX', 
 'Occurs when Query Execution memory management tries to control access to static grant information list. This state lists information about the current granted and waiting memory requests. This state is a simple access control state. There should never be a long wait on this state. If this mutex is not released, all new memory-using queries will stop responding.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('QRY_PARALLEL_THREAD_MUTEX', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('QRY_PROFILE_LIST_MUTEX', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('QUERY_ERRHDL_SERVICE_DONE', 
 'Identified for informational purposes only. Not supported.: Applies to: SQL Server 2008 R2 only.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('QUERY_WAIT_ERRHDL_SERVICE', 
 'Identified for informational purposes only. Not supported.: Applies to: SQL Server 2008 R2 only.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('QUERY_EXECUTION_INDEX_SORT_EVENT_OPEN', 
 'Occurs in certain cases when offline create index build is run in parallel, and the different worker threads that are sorting synchronize access to the sort files.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('QUERY_NOTIFICATION_MGR_MUTEX', 
 'Occurs during synchronization of the garbage collection queue in the Query Notification Manager.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('QUERY_NOTIFICATION_SUBSCRIPTION_MUTEX', 
 'Occurs during state synchronization for transactions in Query Notifications.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('QUERY_NOTIFICATION_TABLE_MGR_MUTEX', 
 'Occurs during internal synchronization within the Query Notification Manager.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('QUERY_NOTIFICATION_UNITTEST_MUTEX', 
 'Identified for informational purposes only. Not supported. Future compatibility is not guaranteed.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('QUERY_OPTIMIZER_PRINT_MUTEX', 
 'Occurs during synchronization of query optimizer diagnostic output production. This wait type only occurs if diagnostic settings have been enabled under direction of Microsoft Product Support.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('QUERY_TASK_ENQUEUE_MUTEX', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('QUERY_TRACEOUT', 
 'Identified for informational purposes only. Not supported. Future compatibility is not guaranteed.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('RBIO_WAIT_VLF', 
 'TBD: Applies to: SQL Server 2017 (14.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('RECOVER_CHANGEDB', 
 'Occurs during synchronization of database status in warm standby database.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('RECOVERY_MGR_LOCK', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('REDO_THREAD_PENDING_WORK', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('REDO_THREAD_SYNC', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('REMOTE_BLOCK_IO', 
 'TBD: Applies to: SQL Server 2017 (14.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('REMOTE_DATA_ARCHIVE_MIGRATION_DMV', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('REMOTE_DATA_ARCHIVE_SCHEMA_DMV', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('REMOTE_DATA_ARCHIVE_SCHEMA_TASK_QUEUE', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('REPL_CACHE_ACCESS', 
 'Occurs during synchronization on a replication article cache. During these waits, the replication log reader stalls, and data definition language (DDL) statements on a published table are blocked.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('REPL_HISTORYCACHE_ACCESS', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('REPL_SCHEMA_ACCESS', 
 'Occurs during synchronization of replication schema version information. This state exists when DDL statements are executed on the replicated object, and when the log reader builds or consumes versioned schema based on DDL occurrence. Contention can be seen on this wait type if you have many published databases on a single publisher with transactional replication and the published databases are very active.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('REPL_TRANFSINFO_ACCESS', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('REPL_TRANHASHTABLE_ACCESS', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('REPL_TRANTEXTINFO_ACCESS', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('REPLICA_WRITES', 
 'Occurs while a task waits for completion of page writes to database snapshots or DBCC replicas.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('REQUEST_DISPENSER_PAUSE', 
 'Occurs when a task is waiting for all outstanding I/O to complete, so that I/O to a file can be frozen for snapshot backup.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('REQUEST_FOR_DEADLOCK_SEARCH', 
 'Occurs while the deadlock monitor waits to start the next deadlock search. This wait is expected between deadlock detections, and lengthy total waiting time on this resource does not indicate a problem.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('RESERVED_MEMORY_ALLOCATION_EXT', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('RESMGR_THROTTLED', 
 'Occurs when a new request comes in and is throttled based on the GROUP_MAX_REQUESTS setting.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('RESOURCE_GOVERNOR_IDLE', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('RESOURCE_QUEUE', 
 'Occurs during synchronization of various internal resource queues.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('RESOURCE_SEMAPHORE', 
 'Occurs when a query memory request cannot be granted immediately due to other concurrent queries. High waits and wait times may indicate excessive number of concurrent queries, or excessive memory request amounts.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('RESOURCE_SEMAPHORE_MUTEX', 
 'Occurs while a query waits for its request for a thread reservation to be fulfilled. It also occurs when synchronizing query compile and memory grant requests.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('RESOURCE_SEMAPHORE_QUERY_COMPILE', 
 'Occurs when the number of concurrent query compilations reaches a throttling limit. High waits and wait times may indicate excessive compilations, recompiles, or uncachable plans.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('RESOURCE_SEMAPHORE_SMALL_QUERY', 
 'Occurs when memory request by a small query cannot be granted immediately due to other concurrent queries. Wait time should not exceed more than a few seconds, because the server transfers the request to the main query memory pool if it fails to grant the requested memory within a few seconds. High waits may indicate an excessive number of concurrent small queries while the main memory pool is blocked by waiting queries.: Applies to: SQL Server 2008 R2 only.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('RESTORE_FILEHANDLECACHE_ENTRYLOCK', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('RESTORE_FILEHANDLECACHE_LOCK', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('RG_RECONFIG', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('ROWGROUP_OP_STATS', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('ROWGROUP_VERSION', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('RTDATA_LIST', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SATELLITE_CARGO', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SATELLITE_SERVICE_SETUP', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SATELLITE_TASK', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SBS_DISPATCH', 
 'TBD: Applies to: SQL Server 2017 (14.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SBS_RECEIVE_TRANSPORT', 
 'TBD: Applies to: SQL Server 2017 (14.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SBS_TRANSPORT', 
 'TBD: Applies to: SQL Server 2017 (14.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SCAN_CHAR_HASH_ARRAY_INITIALIZATION', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SEC_DROP_TEMP_KEY', 
 'Occurs after a failed attempt to drop a temporary security key before a retry attempt.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SECURITY_CNG_PROVIDER_MUTEX', 
 'TBD: Applies to: SQL Server 2017 (14.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SECURITY_CRYPTO_CONTEXT_MUTEX', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SECURITY_DBE_STATE_MUTEX', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SECURITY_KEYRING_RWLOCK', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SECURITY_MUTEX', 
 'Occurs when there is a wait for mutexes that control access to the global list of Extensible Key Management (EKM) cryptographic providers and the session-scoped list of EKM sessions.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SECURITY_RULETABLE_MUTEX', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SEMPLAT_DSI_BUILD', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SEQUENCE_GENERATION', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SEQUENTIAL_GUID', 
 'Occurs while a new sequential GUID is being obtained.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SERVER_IDLE_CHECK', 
 'Occurs during synchronization of SQL Server instance idle status when a resource monitor is attempting to declare a SQL Server instance as idle or trying to wake up.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SERVER_RECONFIGURE', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SESSION_WAIT_STATS_CHILDREN', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SHARED_DELTASTORE_CREATION', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SHUTDOWN', 
 'Occurs while a shutdown statement waits for active connections to exit.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SLEEP_BPOOL_FLUSH', 
 'Occurs when a checkpoint is throttling the issuance of new I/Os in order to avoid flooding the disk subsystem.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SLEEP_BUFFERPOOL_HELPLW', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SLEEP_DBSTARTUP', 
 'Occurs during database startup while waiting for all databases to recover.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SLEEP_DCOMSTARTUP', 
 'Occurs once at most during SQL Server instance startup while waiting for DCOM initialization to complete.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SLEEP_MASTERDBREADY', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SLEEP_MASTERMDREADY', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SLEEP_MASTERUPGRADED', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SLEEP_MEMORYPOOL_ALLOCATEPAGES', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SLEEP_MSDBSTARTUP', 
 'Occurs when SQL Trace waits for the msdb database to complete startup.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SLEEP_RETRY_VIRTUALALLOC', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SLEEP_SYSTEMTASK', 
 'Occurs during the start of a background task while waiting for tempdb to complete startup.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SLEEP_TASK', 
 'Occurs when a task sleeps while waiting for a generic event to occur.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SLEEP_TEMPDBSTARTUP', 
 'Occurs while a task waits for tempdb to complete startup.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SLEEP_WORKSPACE_ALLOCATEPAGE', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SLO_UPDATE', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SMSYNC', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SNI_CONN_DUP', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SNI_CRITICAL_SECTION', 
 'Occurs during internal synchronization within SQL Server networking components.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SNI_HTTP_WAITFOR_0_DISCON', 
 'Occurs during SQL Server shutdown, while waiting for outstanding HTTP connections to exit.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SNI_LISTENER_ACCESS', 
 'Occurs while waiting for non-uniform memory access (NUMA) nodes to update state change. Access to state change is serialized.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SNI_TASK_COMPLETION', 
 'Occurs when there is a wait for all tasks to finish during a NUMA node state change.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SNI_WRITE_ASYNC', 
 'TBD: Applies to: SQL Server 2017 (14.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SOAP_READ', 
 'Occurs while waiting for an HTTP network read to complete.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SOAP_WRITE', 
 'Occurs while waiting for an HTTP network write to complete.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SOCKETDUPLICATEQUEUE_CLEANUP', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SOS_CALLBACK_REMOVAL', 
 'Occurs while performing synchronization on a callback list in order to remove a callback. It is not expected for this counter to change after server initialization is completed.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SOS_DISPATCHER_MUTEX', 
 'Occurs during internal synchronization of the dispatcher pool. This includes when the pool is being adjusted.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SOS_LOCALALLOCATORLIST', 
 'Occurs during internal synchronization in the SQL Server memory manager.: Applies to: SQL Server 2008 R2 only.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SOS_MEMORY_TOPLEVELBLOCKALLOCATOR', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SOS_MEMORY_USAGE_ADJUSTMENT', 
 'Occurs when memory usage is being adjusted among pools.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SOS_OBJECT_STORE_DESTROY_MUTEX', 
 'Occurs during internal synchronization in memory pools when destroying objects from the pool.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SOS_PHYS_PAGE_CACHE', 
 'Accounts for the time a thread waits to acquire the mutex it must acquire before it allocates physical pages or before it returns those pages to the operating system. Waits on this type only appear if the instance of SQL Server uses AWE memory.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SOS_PROCESS_AFFINITY_MUTEX', 
 'Occurs during synchronizing of access to process affinity settings.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SOS_RESERVEDMEMBLOCKLIST', 
 'Occurs during internal synchronization in the SQL Server memory manager.: Applies to: SQL Server 2008 R2 only.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SOS_SCHEDULER_YIELD', 
 'Occurs when a task voluntarily yields the scheduler for other tasks to execute. During this wait the task is waiting for its quantum to be renewed.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SOS_SMALL_PAGE_ALLOC', 
 'Occurs during the allocation and freeing of memory that is managed by some memory objects.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SOS_STACKSTORE_INIT_MUTEX', 
 'Occurs during synchronization of internal store initialization.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SOS_SYNC_TASK_ENQUEUE_EVENT', 
 'Occurs when a task is started in a synchronous manner. Most tasks in SQL Server are started in an asynchronous manner, in which control returns to the starter immediately after the task request has been placed on the work queue.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SOS_VIRTUALMEMORY_LOW', 
 'Occurs when a memory allocation waits for a resource manager to free up virtual memory.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SOSHOST_EVENT', 
 'Occurs when a hosted component, such as CLR, waits on a SQL Server event synchronization object.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SOSHOST_INTERNAL', 
 'Occurs during synchronization of memory manager callbacks used by hosted components, such as CLR.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SOSHOST_MUTEX', 
 'Occurs when a hosted component, such as CLR, waits on a SQL Server mutex synchronization object.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SOSHOST_RWLOCK', 
 'Occurs when a hosted component, such as CLR, waits on a SQL Server reader-writer synchronization object.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SOSHOST_SEMAPHORE', 
 'Occurs when a hosted component, such as CLR, waits on a SQL Server semaphore synchronization object.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SOSHOST_SLEEP', 
 'Occurs when a hosted task sleeps while waiting for a generic event to occur. Hosted tasks are used by hosted components such as CLR.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SOSHOST_TRACELOCK', 
 'Occurs during synchronization of access to trace streams.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SOSHOST_WAITFORDONE', 
 'Occurs when a hosted component, such as CLR, waits for a task to complete.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SP_PREEMPTIVE_SERVER_DIAGNOSTICS_SLEEP', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SP_SERVER_DIAGNOSTICS_BUFFER_ACCESS', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SP_SERVER_DIAGNOSTICS_INIT_MUTEX', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SP_SERVER_DIAGNOSTICS_SLEEP', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SQLCLR_APPDOMAIN', 
 'Occurs while CLR waits for an application domain to complete startup.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SQLCLR_ASSEMBLY', 
 'Occurs while waiting for access to the loaded assembly list in the appdomain.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SQLCLR_DEADLOCK_DETECTION', 
 'Occurs while CLR waits for deadlock detection to complete.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SQLCLR_QUANTUM_PUNISHMENT', 
 'Occurs when a CLR task is throttled because it has exceeded its execution quantum. This throttling is done in order to reduce the effect of this resource-intensive task on other tasks.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SQLSORT_NORMMUTEX', 
 'Occurs during internal synchronization, while initializing internal sorting structures.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SQLSORT_SORTMUTEX', 
 'Occurs during internal synchronization, while initializing internal sorting structures.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SQLTRACE_BUFFER_FLUSH', 
 'Occurs when a task is waiting for a background task to flush trace buffers to disk every four seconds.: Applies to: SQL Server 2008 R2 only.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SQLTRACE_FILE_BUFFER', 
 'Occurs during synchronization on trace buffers during a file trace.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SQLTRACE_FILE_READ_IO_COMPLETION', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SQLTRACE_FILE_WRITE_IO_COMPLETION', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SQLTRACE_INCREMENTAL_FLUSH_SLEEP', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SQLTRACE_LOCK', 
 'TBD: APPLIES TO: SQL Server 2008 R2 only.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SQLTRACE_PENDING_BUFFER_WRITERS', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SQLTRACE_SHUTDOWN', 
 'Occurs while trace shutdown waits for outstanding trace events to complete.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SQLTRACE_WAIT_ENTRIES', 
 'Occurs while a SQL Trace event queue waits for packets to arrive on the queue.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SRVPROC_SHUTDOWN', 
 'Occurs while the shutdown process waits for internal resources to be released to shutdown cleanly.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('STARTUP_DEPENDENCY_MANAGER', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('TDS_BANDWIDTH_STATE', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('TDS_INIT', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
SET NOCOUNT OFF;PRINT '--- "D:\dev\SQL\DFINAnalytics\create_DFS_WaitTypes_TableAndPopulate.sql"' 
PRINT '--- "D:\dev\SQL\DFINAnalytics\create_DFS_WaitTypes_TableAndPopulate.sql"' 


/****************** PROCESSING FILE *************************************/

GO  
PRINT 'ID# 80'  
print 'D:\dev\SQL\DFINAnalytics\DMV_SuggestMissingIndexes.sql' 
/*
-- W. Dale Miller
-- @ July 26, 2016
--DMV_SuggestMissingIndexes.sql
--The indexing related DMVs store statistics that SQL Server uses recommend 
--indexes that could offer performance benefits, based on previously executed queries.
--Do not add these indexes blindly. I would review and question each index suggested. 
--Included column my come with a high cost of maintaining duplicate data.
-- Missing Indexes DMV Suggestions 
*/

/*
DECLARE @Command NVARCHAR(200);
set @Command = 'use ?; exec sp_DFS_SuggestMissingIndexes ;';
exec sp_msForEachDb @Command;
*/

USE [DFS];
GO
IF NOT EXISTS
(
    SELECT 1
    FROM sys.tables
    WHERE name = 'DFS_MissingIndexes'
)
    BEGIN
        CREATE TABLE [dbo].[DFS_MissingIndexes]
        ([ServerName]      [NVARCHAR](128) NULL, 
         [DBName]          [NVARCHAR](128) NULL, 
         [Affected_table]  [SYSNAME] NOT NULL, 
         [K]               [INT] NULL, 
         [Keys]            [NVARCHAR](4000) NULL, 
         [INCLUDE]         [NVARCHAR](4000) NULL, 
         [sql_statement]   [NVARCHAR](4000) NULL, 
         [user_seeks]      [BIGINT] NOT NULL, 
         [user_scans]      [BIGINT] NOT NULL, 
         [est_impact]      [BIGINT] NULL, 
         [avg_user_impact] [FLOAT] NULL, 
         [last_user_seek]  [DATETIME] NULL, 
         [SecondsUptime]   [INT] NULL, 
         CreateDate        DATETIME DEFAULT GETDATE(), 
         RowNbr            INT IDENTITY(1, 1) NOT NULL
        )
        ON [PRIMARY];
        CREATE INDEX idxDFS_SuggestMissingIndexes ON DFS_MissingIndexes(DBName, Affected_table);
END;
GO

USE master;
GO

IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'sp_DFS_SuggestMissingIndexes'
)
    DROP PROCEDURE sp_DFS_SuggestMissingIndexes;
GO
CREATE PROCEDURE sp_DFS_SuggestMissingIndexes
AS
    BEGIN
        PRINT 'INSIDE: ' + DB_NAME();
        INSERT INTO [dbo].[DFS_MissingIndexes]
        ([ServerName], 
         [DBName], 
         [Affected_table], 
         [K], 
         [Keys], 
         [INCLUDE], 
         [sql_statement], 
         [user_seeks], 
         [user_scans], 
         [est_impact], 
         [avg_user_impact], 
         [last_user_seek], 
         [SecondsUptime], 
         [CreateDate]
        )
               SELECT @@ServerName AS ServerName, 
                      DB_NAME() AS DBName, 
                      t.name AS 'Affected_table', 
                      LEN(ISNULL(ddmid.equality_columns, N'') + CASE
                                                                    WHEN ddmid.equality_columns IS NOT NULL
                                                                         AND ddmid.inequality_columns IS NOT NULL
                                                                    THEN ','
                                                                    ELSE ''
                                                                END) - LEN(REPLACE(ISNULL(ddmid.equality_columns, N'') + CASE
                                                                                                                             WHEN ddmid.equality_columns IS NOT NULL
                                                                                                                                  AND ddmid.inequality_columns IS NOT NULL
                                                                                                                             THEN ','
                                                                                                                             ELSE ''
                                                                                                                         END, ',', '')) + 1 AS K, 
                      COALESCE(ddmid.equality_columns, '') + CASE
                                                                 WHEN ddmid.equality_columns IS NOT NULL
                                                                      AND ddmid.inequality_columns IS NOT NULL
                                                                 THEN ','
                                                                 ELSE ''
                                                             END + COALESCE(ddmid.inequality_columns, '') AS Keys, 
                      COALESCE(ddmid.included_columns, '') AS INCLUDE, 
                      'Create NonClustered Index IX_' + t.name + '_missing_' + CAST(ddmid.index_handle AS VARCHAR(20)) + ' On ' + ddmid.[statement] COLLATE database_default + ' (' + ISNULL(ddmid.equality_columns, '') + CASE
                                                                                                                                                                                                                               WHEN ddmid.equality_columns IS NOT NULL
                                                                                                                                                                                                                                    AND ddmid.inequality_columns IS NOT NULL
                                                                                                                                                                                                                               THEN ','
                                                                                                                                                                                                                               ELSE ''
                                                                                                                                                                                                                           END + ISNULL(ddmid.inequality_columns, '') + ')' + ISNULL(' Include (' + ddmid.included_columns + ');', ';') AS sql_statement, 
                      ddmigs.user_seeks, 
                      ddmigs.user_scans, 
                      CAST((ddmigs.user_seeks + ddmigs.user_scans) * ddmigs.avg_user_impact AS BIGINT) AS 'est_impact', 
                      avg_user_impact, 
                      ddmigs.last_user_seek, 
               (
                   SELECT DATEDIFF(Second, create_date, GETDATE()) Seconds
                   FROM sys.databases
                   WHERE name = 'tempdb'
               ) SecondsUptime, 
                      GETDATE()
               FROM sys.dm_db_missing_index_groups ddmig
                    INNER JOIN sys.dm_db_missing_index_group_stats ddmigs ON ddmigs.group_handle = ddmig.index_group_handle
                    INNER JOIN sys.dm_db_missing_index_details ddmid ON ddmig.index_handle = ddmid.index_handle
                    INNER JOIN sys.tables t ON ddmid.OBJECT_ID = t.OBJECT_ID
               WHERE ddmid.database_id = DB_ID()
               ORDER BY est_impact DESC;
        DELETE FROM [dbo].[DFS_MissingIndexes]
        WHERE [DBName] IN('msdb', 'model', 'tempdb', 'master', 'dba');
    END;
	GO

--************************************************************************
-- select * from dbo.DFS_MissingIndexes ;
PRINT '--- "D:\dev\SQL\DFINAnalytics\DMV_SuggestMissingIndexes.sql"' 


/****************** PROCESSING FILE *************************************/

GO  
PRINT 'ID# 90'  
print 'D:\dev\SQL\DFINAnalytics\DMV_SuggestMissingFKIndexes.sql' 

/*
-- use BNYUK_ProductionAR_Port
-- W. Dale Miller
-- @ July 26, 2016
--As a general best practice, it is recommended to have an index associated 
--with each foreign key. This facilitates faster table joins, which are 
--typically joined on foreign key columns anyway. Indexes on foreign keys 
--also facilitate faster deletes. If these supporting indexes are missing, 
--SQL will perform a table scale on the related table each time a record in 
--the first table is deleted.
-- Foreign Keys missing indexes 
-- Note this script only works for creating single column indexes. 
-- Multiple FK columns are out of scope for this script. 
*/
/*
DECLARE @Command NVARCHAR(200);
SET @Command = 'use ?; exec sp_DFS_FindMissingFKIndexes ;';
EXEC sp_msForEachDb @Command;
GO
*/

USE DFINAnalyticsFINAnalyticsFINAnalyticsFS;
GO

/*
drop TABLE [dbo].[DFS_MissingFKIndexes];
*/

IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.tables
    WHERE table_name = 'DFS_MissingFKIndexes'
)
    BEGIN
        CREATE TABLE [dbo].[DFS_MissingFKIndexes]
        (SVR             [NVARCHAR](128) NULL, 
         [DBName]        [NVARCHAR](128) NULL, 
         SSVER           [NVARCHAR](250) NULL, 
         [FK_Constraint] [SYSNAME] NOT NULL, 
         [FK_Table]      [SYSNAME] NOT NULL, 
         [FK_Column]     [NVARCHAR](128) NULL, 
         [ParentTable]   [SYSNAME] NOT NULL, 
         [ParentColumn]  [NVARCHAR](128) NULL, 
         [IndexName]     [SYSNAME] NULL, 
         [SQL]           [NVARCHAR](1571) NULL, 
         [CreateDate]    [DATETIME] NOT NULL
        )
        ON [PRIMARY];
END;
USE master;
GO
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'sp_DFS_FindMissingFKIndexes'
)
    BEGIN
        DROP PROCEDURE sp_DFS_FindMissingFKIndexes;
END;
GO

/* drop table dbo..DFS_MissingFKIndexes*/

CREATE PROCEDURE sp_DFS_FindMissingFKIndexes
AS
    BEGIN
        PRINT 'INSIDE: ' + DB_NAME();
        INSERT INTO dbo.DFS_MissingFKIndexes
               SELECT @@servername AS SVR, 
                      DB_NAME() AS DBName, 
                      @@VERSION AS SSVER, 
                      rc.Constraint_Name AS FK_Constraint,
                      /* rc.Constraint_Catalog AS FK_Database, rc.Constraint_Schema AS FKSch, */
                      ccu.Table_Name AS FK_Table, 
                      ccu.Column_Name AS FK_Column, 
                      ccu2.Table_Name AS ParentTable, 
                      ccu2.Column_Name AS ParentColumn, 
                      I.Name AS IndexName,
                      CASE
                          WHEN I.Name IS NULL
                          THEN 'IF NOT EXISTS (SELECT * FROM sys.indexes
	                                    WHERE object_id = OBJECT_ID(N''' + RC.Constraint_Schema + '.' + ccu.Table_Name + ''') AND name = N''IX_' + ccu.Table_Name + '_' + ccu.Column_Name + ''') ' + 'CREATE NONCLUSTERED INDEX IX_' + ccu.Table_Name + '_' + ccu.Column_Name + ' ON ' + rc.Constraint_Schema + '.' + ccu.Table_Name + '( ' + ccu.Column_Name + ' ASC ) WITH (PAD_INDEX = OFF, 
	                                   STATISTICS_NORECOMPUTE = OFF,
	                                   SORT_IN_TEMPDB = ON, IGNORE_DUP_KEY = OFF,
	                                   DROP_EXISTING = OFF, ONLINE = ON);'
                          ELSE ''
                      END AS SQL, 
                      GETDATE() AS CreateDate
               FROM information_schema.referential_constraints AS RC
                         JOIN INFORMATION_SCHEMA.CONSTRAINT_COLUMN_USAGE AS ccu
                         ON rc.CONSTRAINT_NAME = ccu.CONSTRAINT_NAME
                              JOIN INFORMATION_SCHEMA.CONSTRAINT_COLUMN_USAGE AS ccu2
                         ON rc.UNIQUE_CONSTRAINT_NAME = ccu2.CONSTRAINT_NAME
                                   LEFT JOIN sys.columns AS c
                         ON ccu.Column_Name = C.name
                            AND ccu.Table_Name = OBJECT_NAME(C.OBJECT_ID)
                                        LEFT JOIN sys.index_columns AS ic
                         ON C.OBJECT_ID = IC.OBJECT_ID
                            AND c.column_id = ic.column_id
                            AND index_column_id = 1
                                             LEFT JOIN sys.indexes AS i
                         ON IC.OBJECT_ID = i.OBJECT_ID
                            AND ic.index_Id = i.index_Id
               WHERE I.name IS NULL
               ORDER BY FK_table, 
                        ParentTable, 
                        ParentColumn;
        DELETE FROM [dbo].DFS_MissingFKIndexes
        WHERE [DBName] IN('msdb', 'model', 'tempdb', 'master', 'dba');
    END;
GO

/****************** PROCESSING FILE *************************************/

GO  
PRINT 'ID# 100'  
print 'D:\dev\SQL\DFINAnalytics\DMV_TableReadsAndWrites.sql' 

/*
--DMV_TableReadsAndWrites.sql
Developed W. Dale Miller 
Copyright @DMA, Ltd, July 26, 2012 all rights reserved.
Licensed under the MIT Open Code License
Free to use as long as the copyright is retained in the code.
*/
/* exec sp_UTIL_TrackTblReadsWrites */
USE [DFS];
GO

/* drop table [DFS_TableReadWrites]*/

IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.TABLES
    WHERE TABLE_NAME = 'DFS_TableReadWrites'
)
    BEGIN
        CREATE TABLE [dbo].[DFS_TableReadWrites]
        ([ServerName]    [NVARCHAR](128) NULL, 
         [DBName]        [NVARCHAR](128) NULL, 
         [TableName]     [NVARCHAR](128) NULL, 
         [Reads]         [BIGINT] NULL, 
         [Writes]        [BIGINT] NULL, 
         [Reads&Writes]  [BIGINT] NULL, 
         [SampleDays]    [NUMERIC](18, 7) NULL, 
         [SampleSeconds] [INT] NULL, 
         [RunDate]       [DATETIME] NOT NULL, 
         [SSVER]         [NVARCHAR](250) NULL, 
         [RowID]         [BIGINT] IDENTITY(1, 1) NOT NULL, 
         [UID]           [UNIQUEIDENTIFIER] NULL, 
         [RunID]         [INT] NULL
        )
        ON [PRIMARY];
        CREATE INDEX idxDFS_TableReadWrites
        ON DFS_TableReadWrites
        ([DBName], [TableName]
        );
END;
GO
USE master;
GO
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'sp_UTIL_TrackTblReadsWrites'
)
    BEGIN
        DROP PROCEDURE sp_UTIL_TrackTblReadsWrites;
END;
GO

/*
-- Table Reads and Writes 
-- Heap tables out of scope for this query. Heaps do not have indexes. 
-- Only lists tables referenced since the last server restart 
-- exec sp_UTIL_TrackTblReadsWrites

--JOB_UTIL_TrackTblReadsWrites
DECLARE @RunID BIGINT;
EXEC @RunID = dbo.UTIL_GetSeq;
PRINT @RunID;
DECLARE @command VARCHAR(1000);
SELECT @command = 'USE ?; declare @DB as int = DB_ID() ; print db_name(); exec master.dbo.sp_UTIL_TrackTblReadsWrites ' + CAST(@RunID AS NVARCHAR(25)) + ' ;';
EXEC master.sys.sp_MSforeachdb @command;
*/
/* select * from DFS_TableReadWrites*/

USE master;
GO
CREATE PROCEDURE sp_UTIL_TrackTblReadsWrites(@RunID INT)
AS
     IF DB_NAME() IN('master', 'tempdb', 'msdb', 'model', 'DBA')
         BEGIN
             PRINT 'Skipping DB : ' + DB_NAME();
             RETURN;
     END;
    BEGIN
        EXEC DBO.UTIL_RecordCount 
             'sp_UTIL_TrackTblReadsWrites';
        PRINT 'Processing DB : ' + DB_NAME();
        DECLARE @i AS INT;
        SET @i =
        (
            SELECT COUNT(*)
            FROM dbo.[DFS_TableReadWrites]
        );
        PRINT 'Starting rows: ' + CAST(@i AS NVARCHAR(15));
        INSERT INTO dbo.[DFS_TableReadWrites]
        ( [ServerName], 
          [DBName], 
          [TableName], 
          [Reads], 
          [Writes], 
          [Reads&Writes], 
          [SampleDays], 
          [SampleSeconds], 
          [RunDate], 
          SSVER, 
          [UID], 
          RunID
        ) 
               SELECT @@ServerName AS ServerName, 
                      DB_NAME() AS DBName, 
                      OBJECT_NAME(ddius.object_id) AS TableName, 
                      SUM(ddius.user_seeks + ddius.user_scans + ddius.user_lookups) AS Reads, 
                      SUM(ddius.user_updates) AS Writes, 
                      SUM(ddius.user_seeks + ddius.user_scans + ddius.user_lookups + ddius.user_updates) AS [Reads&Writes], 
               (
                   SELECT DATEDIFF(s, create_date, GETDATE()) / 86400.0
                   FROM master.sys.databases
                   WHERE name = 'tempdb'
               ) AS SampleDays, 
               (
                   SELECT DATEDIFF(s, create_date, GETDATE()) AS SecoundsRunnig
                   FROM master.sys.databases
                   WHERE name = 'tempdb'
               ) AS SampleSeconds, 
                      GETDATE() AS RunDate, 
                      @@version AS SSVER, 
                      NEWID() AS [UID], 
                      @RunID AS RunID
               FROM sys.dm_db_index_usage_stats ddius
                         INNER JOIN sys.indexes i
                         ON ddius.object_id = i.object_id
                            AND i.index_id = ddius.index_id
               WHERE OBJECTPROPERTY(ddius.object_id, 'IsUserTable') = 1
                     AND ddius.database_id = DB_ID()
               GROUP BY OBJECT_NAME(ddius.object_id)
               ORDER BY [Reads&Writes] DESC;
        SET @i =
        (
            SELECT COUNT(*)
            FROM dbo.[DFS_TableReadWrites]
        );
        PRINT 'Ending rows: ' + CAST(@i AS NVARCHAR(15));
    END;
GO
USE [DFS];
GO
IF EXISTS
(
    SELECT table_name
    FROM INFORMATION_SCHEMA.tables
    WHERE TABLE_NAME = 'vTrackTblReadsWrites'
)
    BEGIN
        DROP VIEW dbo.vTrackTblReadsWrites;
END;
GO
CREATE VIEW dbo.vTrackTblReadsWrites
AS
     SELECT [ServerName], 
            [DBName], 
            [TableName], 
            [Reads], 
            [Writes], 
            [Reads&Writes], 
            [SampleDays], 
            [SampleSeconds], 
            [RunDate], 
            [UID], 
            [RowID]
     FROM [dbo].[DFS_TableReadWrites];

/*order BY TableName, 
       RunDate, 
       DBName, 
       ServerName;*/

GO

/* W. Dale Miller
 DMA, Limited
 Offered under GNU License
 July 26, 2016*/

/****************** PROCESSING FILE *************************************/

GO  
PRINT 'ID# 110'  
print 'D:\dev\SQL\DFINAnalytics\DVM_IdentifyQueriesCandidatesForOptimization.sql' 

/*
Developed W. Dale Miller 
Copyright @DMA, Ltd, July 26, 2012 all rights reserved.
Licensed under the MIT Open Code License
Free to use as long as the copyright is retained in the code.
*/
/*
-- exec UTIL_QryPlanStats

--The below CTE provides information about the number of executions, 
--total run time, and pages read from memory. The results can be used 
--to identify queries that may be candidates for optimization.
--Note: The results of this query can vary depending on the version of SQL Server.
--select * into QueryUseStats
IF OBJECT_ID('tempdb..#Results') IS NOT NULL
    DROP TABLE #FindUnusedViews;
*/

USE DFINAnalyticsFINAnalyticsFINAnalyticsFS;
GO
IF EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.TABLES
    WHERE TABLE_NAME = 'DFS_QryOptStats'
)
    DROP TABLE DFS_QryOptStats;
GO
IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.tables
    WHERE TABLE_NAME = 'DFS_QryOptStats'
)
    BEGIN
        CREATE TABLE [dbo].[DFS_QryOptStats]
        ([schemaname]             [NVARCHAR](128) NULL, 
         [viewname]               [SYSNAME] NOT NULL, 
         [viewid]                 [INT] NOT NULL, 
         [databasename]           [NVARCHAR](128) NULL, 
         [databaseid]             [SMALLINT] NULL, 
         [text]                   [NVARCHAR](MAX) NULL, 
         [query_plan]             [XML] NULL, 
         [sql_handle]             [VARBINARY](64) NOT NULL, 
         [statement_start_offset] [INT] NOT NULL, 
         [statement_end_offset]   [INT] NOT NULL, 
         [plan_generation_num]    [BIGINT] NULL, 
         [plan_handle]            [VARBINARY](64) NOT NULL, 
         [creation_time]          [DATETIME] NULL, 
         [last_execution_time]    [DATETIME] NULL, 
         [execution_count]        [BIGINT] NOT NULL, 
         [total_worker_time]      [BIGINT] NOT NULL, 
         [last_worker_time]       [BIGINT] NOT NULL, 
         [min_worker_time]        [BIGINT] NOT NULL, 
         [max_worker_time]        [BIGINT] NOT NULL, 
         [total_physical_reads]   [BIGINT] NOT NULL, 
         [last_physical_reads]    [BIGINT] NOT NULL, 
         [min_physical_reads]     [BIGINT] NOT NULL, 
         [max_physical_reads]     [BIGINT] NOT NULL, 
         [total_logical_writes]   [BIGINT] NOT NULL, 
         [last_logical_writes]    [BIGINT] NOT NULL, 
         [min_logical_writes]     [BIGINT] NOT NULL, 
         [max_logical_writes]     [BIGINT] NOT NULL, 
         [total_logical_reads]    [BIGINT] NOT NULL, 
         [last_logical_reads]     [BIGINT] NOT NULL, 
         [min_logical_reads]      [BIGINT] NOT NULL, 
         [max_logical_reads]      [BIGINT] NOT NULL, 
         [total_clr_time]         [BIGINT] NOT NULL, 
         [last_clr_time]          [BIGINT] NOT NULL, 
         [min_clr_time]           [BIGINT] NOT NULL, 
         [max_clr_time]           [BIGINT] NOT NULL, 
         [total_elapsed_time]     [BIGINT] NOT NULL, 
         [last_elapsed_time]      [BIGINT] NOT NULL, 
         [min_elapsed_time]       [BIGINT] NOT NULL, 
         [max_elapsed_time]       [BIGINT] NOT NULL, 
         [query_hash]             [BINARY](8) NULL, 
         [query_plan_hash]        [BINARY](8) NULL, 
         [total_rows]             [BIGINT] NULL, 
         [last_rows]              [BIGINT] NULL, 
         [min_rows]               [BIGINT] NULL, 
         [max_rows]               [BIGINT] NULL, 
         [statement_sql_handle]   [VARBINARY](64) NULL, 
         [statement_context_id]   [BIGINT] NULL, 
         [total_dop]              [BIGINT] NULL, 
         [last_dop]               [BIGINT] NULL, 
         [min_dop]                [BIGINT] NULL, 
         [max_dop]                [BIGINT] NULL, 
         [total_grant_kb]         [BIGINT] NULL, 
         [last_grant_kb]          [BIGINT] NULL, 
         [min_grant_kb]           [BIGINT] NULL, 
         [max_grant_kb]           [BIGINT] NULL, 
         [total_used_grant_kb]    [BIGINT] NULL, 
         [last_used_grant_kb]     [BIGINT] NULL, 
         [min_used_grant_kb]      [BIGINT] NULL, 
         [max_used_grant_kb]      [BIGINT] NULL, 
         [total_ideal_grant_kb]   [BIGINT] NULL, 
         [last_ideal_grant_kb]    [BIGINT] NULL, 
         [min_ideal_grant_kb]     [BIGINT] NULL, 
         [max_ideal_grant_kb]     [BIGINT] NULL, 
         [total_reserved_threads] [BIGINT] NULL, 
         [last_reserved_threads]  [BIGINT] NULL, 
         [min_reserved_threads]   [BIGINT] NULL, 
         [max_reserved_threads]   [BIGINT] NULL, 
         [total_used_threads]     [BIGINT] NULL, 
         [last_used_threads]      [BIGINT] NULL, 
         [min_used_threads]       [BIGINT] NULL, 
         [max_used_threads]       [BIGINT] NULL, 
         RunDate                  DATETIME DEFAULT GETDATE(), 
         SSVER                    NVARCHAR(250) NULL, 
         RowID                    BIGINT IDENTITY(1, 1) NOT NULL
        )
        ON [PRIMARY];
END;
GO

/* exec UTIL_QryPlanStats*/

IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'UTIL_QryPlanStats'
)
    BEGIN
        DROP PROCEDURE UTIL_QryPlanStats;
END;
GO
CREATE PROCEDURE UTIL_QryPlanStats
AS
    BEGIN
        WITH CTE_VW_STATS
             AS (SELECT SCHEMA_NAME(vw.schema_id) AS schemaname, 
                        vw.name AS viewname, 
                        vw.object_id AS viewid
                 FROM sys.views AS vw
                 WHERE
                       (vw.is_ms_shipped = 0
                       )
                 INTERSECT
                 SELECT SCHEMA_NAME(o.schema_id) AS schemaname, 
                        o.Name AS name, 
                        st.objectid AS viewid
                 FROM sys.dm_exec_cached_plans cp
                           CROSS APPLY sys.dm_exec_sql_text(cp.plan_handle) st
                                INNER JOIN sys.objects o
                                            ON st.[objectid] = o.[object_id]
                 WHERE st.dbid = DB_ID())
             INSERT INTO DFS_QryOptStats
             ( [schemaname], 
               [viewname], 
               [viewid], 
               [databasename], 
               [databaseid], 
               [text], 
               [query_plan], 
               [sql_handle], 
               [statement_start_offset], 
               [statement_end_offset], 
               [plan_generation_num], 
               [plan_handle], 
               [creation_time], 
               [last_execution_time], 
               [execution_count], 
               [total_worker_time], 
               [last_worker_time], 
               [min_worker_time], 
               [max_worker_time], 
               [total_physical_reads], 
               [last_physical_reads], 
               [min_physical_reads], 
               [max_physical_reads], 
               [total_logical_writes], 
               [last_logical_writes], 
               [min_logical_writes], 
               [max_logical_writes], 
               [total_logical_reads], 
               [last_logical_reads], 
               [min_logical_reads], 
               [max_logical_reads], 
               [total_clr_time], 
               [last_clr_time], 
               [min_clr_time], 
               [max_clr_time], 
               [total_elapsed_time], 
               [last_elapsed_time], 
               [min_elapsed_time], 
               [max_elapsed_time], 
               [query_hash], 
               [query_plan_hash], 
               [total_rows], 
               [last_rows], 
               [min_rows], 
               [max_rows], 
               [statement_sql_handle], 
               [statement_context_id], 
               [total_dop], 
               [last_dop], 
               [min_dop], 
               [max_dop], 
               [total_grant_kb], 
               [last_grant_kb], 
               [min_grant_kb], 
               [max_grant_kb], 
               [total_used_grant_kb], 
               [last_used_grant_kb], 
               [min_used_grant_kb], 
               [max_used_grant_kb], 
               [total_ideal_grant_kb], 
               [last_ideal_grant_kb], 
               [min_ideal_grant_kb], 
               [max_ideal_grant_kb], 
               [total_reserved_threads], 
               [last_reserved_threads], 
               [min_reserved_threads], 
               [max_reserved_threads], 
               [total_used_threads], 
               [last_used_threads], 
               [min_used_threads], 
               [max_used_threads]
             ) 
                    SELECT vw.schemaname, 
                           vw.viewname, 
                           vw.viewid, 
                           DB_NAME(t.databaseid) AS databasename,

                           /*t.databaseid, */

                           t.*
                    FROM CTE_VW_STATS AS vw
                              CROSS APPLY
                    (
                        SELECT st.dbid AS databaseid, 
                               st.text, 
                               qp.query_plan, 
                               qs.*
                        FROM sys.dm_exec_query_stats AS qs
                                  CROSS APPLY sys.dm_exec_sql_text(qs.plan_handle) AS st
                                       CROSS APPLY sys.dm_exec_query_plan(qs.plan_handle) AS qp
                        WHERE
                              (CHARINDEX(vw.schemaname, st.text, 1) > 0
                              )
                              AND
                              (st.dbid = DB_ID()
                              )
                    ) AS t;
    END;

/* W. Dale Miller
 DMA, Limited
 Offered under GNU License
 July 26, 2016*/

/****************** PROCESSING FILE *************************************/

GO  
PRINT 'ID# 120'  
print 'D:\dev\SQL\DFINAnalytics\find_Blocking_History.sql' 

/*select * from sys.databases where name like 'BNYUK%'
use [BNYSA_Production_Data]
use BNYUK_ProductionAR_data*/

USE [DFS];
GO
DECLARE @runnow INT= 0;
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'sp_UTIL_GetIndexStats'
)
   AND @runnow = 1
    BEGIN

        /*declare @RunID BIGINT = NEXT VALUE FOR master_seq;
		truncate TABLE [dbo].[DFS_IndexStats];
		select top 100 * from [dbo].[DFS_IndexStats];
		*/
        DECLARE @RunID BIGINT;
        DECLARE @MaxWaitMS INT= 30;
        DECLARE @MaxWaitCount INT= 3;
        EXEC @RunID = dbo.UTIL_GetSeq;
        DECLARE @command VARCHAR(1000);
        SELECT @command = 'USE ?; exec sp_UTIL_GetIndexStats ' + CAST(@RunID AS NVARCHAR(25)) + ', ' + CAST(@MaxWaitMS AS NVARCHAR(15)) + ';';
        EXEC sp_MSforeachdb 
             @command;
END;
GO

/* drop table [dbo].[DFS_IndexStats]*/

IF NOT EXISTS
(
    SELECT 1
    FROM sys.tables
    WHERE name = 'DFS_IndexStats'
)
    CREATE TABLE [dbo].[DFS_IndexStats]
    ([SvrName]                [NVARCHAR](128) NULL, 
     [DB]                     [NVARCHAR](128) NULL, 
     [Obj]                    [NVARCHAR](128) NULL, 
     [IdxName]                [SYSNAME] NULL, 
     [range_scan_count]       [BIGINT] NOT NULL, 
     [singleton_lookup_count] [BIGINT] NOT NULL, 
     [row_lock_count]         [BIGINT] NOT NULL, 
     [page_lock_count]        [BIGINT] NOT NULL, 
     [TotNo_Of_Locks]         [BIGINT] NULL, 
     [row_lock_wait_count]    [BIGINT] NOT NULL, 
     [page_lock_wait_count]   [BIGINT] NOT NULL, 
     [TotNo_Of_Blocks]        [BIGINT] NULL, 
     [row_lock_wait_in_ms]    [BIGINT] NOT NULL, 
     [page_lock_wait_in_ms]   [BIGINT] NOT NULL, 
     [TotBlock_Wait_TimeMS]   [BIGINT] NULL, 
     [index_id]               [INT] NOT NULL, 
     [CreateDate]             [DATETIME] NULL, 
     SSVER                    NVARCHAR(250) NULL, 
     RunID                    BIGINT NULL, 
     [RowNbr]                 [INT] IDENTITY(1, 1) NOT NULL
    )
    ON [PRIMARY];

/*ALTER TABLE [dbo].[DFS_IndexStats] ADD  DEFAULT (getdate()) FOR [CreateDate]*/

GO
USE master;
GO
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'sp_UTIL_GetIndexStats'
)
    DROP PROCEDURE sp_UTIL_GetIndexStats;
GO

/* select top 100 * from [DFINAnalytics_IndexStats] order by Rownbr desc
 exec sp_UTIL_GetIndexStats -1, 5*/

CREATE PROCEDURE sp_UTIL_GetIndexStats
(@RunID        BIGINT, 
 @MaxWaitMS    INT    = 30, 
 @MaxWaitCount INT    = 2
)
AS
    BEGIN

		/*declare @RunID     BIGINT = -50 ;
		declare @MaxWaitMS INT = 0;
		declare @MaxWaitCount INT = 0 ;*/

        INSERT INTO [dbo].[DFS_IndexStats]
        ( [SvrName], 
          [DB], 
          [Obj], 
          [IdxName], 
          [range_scan_count], 
          [singleton_lookup_count], 
          [row_lock_count], 
          [page_lock_count], 
          [TotNo_Of_Locks], 
          [row_lock_wait_count], 
          [page_lock_wait_count], 
          [TotNo_Of_Blocks], 
          [row_lock_wait_in_ms], 
          [page_lock_wait_in_ms], 
          [TotBlock_Wait_TimeMS], 
          [index_id], 
          [CreateDate], 
          [SSVER], 
          RunID
        ) 
               SELECT @@ServerName AS SvrName, 
                      DB_NAME() AS DB, 
                      OBJECT_NAME(IOS.object_id) AS Obj, 
                      i.Name AS IdxName, 
                      range_scan_count, 
                      singleton_lookup_count, 
                      row_lock_count, 
                      page_lock_count, 
                      row_lock_count + page_lock_count AS TotNo_Of_Locks, 
                      row_lock_wait_count, 
                      page_lock_wait_count, 
                      row_lock_wait_count + page_lock_wait_count AS TotNo_Of_Blocks, 
                      row_lock_wait_in_ms, 
                      page_lock_wait_in_ms, 
                      row_lock_wait_in_ms + page_lock_wait_in_ms AS TotBlock_Wait_TimeMS, 
                      IOS.index_id, 
                      GETDATE() AS CreateDate, 
                      @@version AS SSVER, 
                      @RunID AS RunID
               FROM sys.dm_db_index_operational_stats(NULL, NULL, NULL, NULL) IOS
                         JOIN sys.indexes I
                         ON I.index_id = IOS.index_id
               WHERE DB_NAME() NOT IN('master', 'model', 'msdb', 'tempdb', 'DBA')
               AND OBJECT_NAME(IOS.object_id) IS NOT NULL
               AND (row_lock_wait_count >= 0
                    OR page_lock_wait_count >= 0)
               AND (page_lock_wait_in_ms >= @MaxWaitMS
                    OR row_lock_wait_in_ms >= @MaxWaitMS);
    END;

/****************** PROCESSING FILE *************************************/

GO  
PRINT 'ID# 130'  
print 'D:\dev\SQL\DFINAnalytics\UTIL_WorstPerformingQuerries2008.sql' 

/*
-- W. Dale Miller
-- wdalemiller@gmail.com

declare @cmd nvarchar(1000) ;
set @cmd = 'use ?; exec sp_UTIL_IO_BoundQry2000 ; exec sp_UTIL_CPU_BoundQry2000 ;'
exec sp_msForEachDB @cmd ;
*/

USE [DFS];
if not exists (select 1 from sys.tables where name = 'DFS_IO_BoundQry2000')
begin
CREATE TABLE [dbo].[DFS_IO_BoundQry2000](
	[SVRName] [nvarchar](128) NULL,
	[DBName] [varchar](6) NOT NULL,
	[text] [nvarchar](max) NULL,
	[query_plan] [xml] NULL,
	[sql_handle] [varbinary](64) NOT NULL,
	[statement_start_offset] [int] NOT NULL,
	[statement_end_offset] [int] NOT NULL,
	[plan_generation_num] [bigint] NULL,
	[plan_handle] [varbinary](64) NOT NULL,
	[creation_time] [datetime] NULL,
	[last_execution_time] [datetime] NULL,
	[execution_count] [bigint] NOT NULL,
	[total_worker_time] [bigint] NOT NULL,
	[last_worker_time] [bigint] NOT NULL,
	[min_worker_time] [bigint] NOT NULL,
	[max_worker_time] [bigint] NOT NULL,
	[total_physical_reads] [bigint] NOT NULL,
	[last_physical_reads] [bigint] NOT NULL,
	[min_physical_reads] [bigint] NOT NULL,
	[max_physical_reads] [bigint] NOT NULL,
	[total_logical_writes] [bigint] NOT NULL,
	[last_logical_writes] [bigint] NOT NULL,
	[min_logical_writes] [bigint] NOT NULL,
	[max_logical_writes] [bigint] NOT NULL,
	[total_logical_reads] [bigint] NOT NULL,
	[last_logical_reads] [bigint] NOT NULL,
	[min_logical_reads] [bigint] NOT NULL,
	[max_logical_reads] [bigint] NOT NULL,
	[total_clr_time] [bigint] NOT NULL,
	[last_clr_time] [bigint] NOT NULL,
	[min_clr_time] [bigint] NOT NULL,
	[max_clr_time] [bigint] NOT NULL,
	[total_elapsed_time] [bigint] NOT NULL,
	[last_elapsed_time] [bigint] NOT NULL,
	[min_elapsed_time] [bigint] NOT NULL,
	[max_elapsed_time] [bigint] NOT NULL,
	[query_hash] [binary](8) NULL,
	[query_plan_hash] [binary](8) NULL,
	[total_rows] [bigint] NULL,
	[last_rows] [bigint] NULL,
	[min_rows] [bigint] NULL,
	[max_rows] [bigint] NULL,
	[statement_sql_handle] [varbinary](64) NULL,
	[statement_context_id] [bigint] NULL,
	[total_dop] [bigint] NULL,
	[last_dop] [bigint] NULL,
	[min_dop] [bigint] NULL,
	[max_dop] [bigint] NULL,
	[total_grant_kb] [bigint] NULL,
	[last_grant_kb] [bigint] NULL,
	[min_grant_kb] [bigint] NULL,
	[max_grant_kb] [bigint] NULL,
	[total_used_grant_kb] [bigint] NULL,
	[last_used_grant_kb] [bigint] NULL,
	[min_used_grant_kb] [bigint] NULL,
	[max_used_grant_kb] [bigint] NULL,
	[total_ideal_grant_kb] [bigint] NULL,
	[last_ideal_grant_kb] [bigint] NULL,
	[min_ideal_grant_kb] [bigint] NULL,
	[max_ideal_grant_kb] [bigint] NULL,
	[total_reserved_threads] [bigint] NULL,
	[last_reserved_threads] [bigint] NULL,
	[min_reserved_threads] [bigint] NULL,
	[max_reserved_threads] [bigint] NULL,
	[total_used_threads] [bigint] NULL,
	[last_used_threads] [bigint] NULL,
	[min_used_threads] [bigint] NULL,
	[max_used_threads] [bigint] NULL,
	[RunDate] [datetime] NOT NULL,
	[SSVER] [nvarchar](300) NULL,
	[RunID] [int] NOT NULL,
	[UID] [uniqueidentifier] NOT NULL,
	[Processed] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

ALTER TABLE [dbo].[DFS_IO_BoundQry2000] ADD  DEFAULT (newid()) FOR [UID]

ALTER TABLE [dbo].[DFS_IO_BoundQry2000] ADD  DEFAULT ((0)) FOR [Processed]
end

--drop table DFS_CPU_BoundQry2000
if not exists (select 1 from sys.tables where name = 'DFS_CPU_BoundQry2000')
begin
CREATE TABLE [dbo].[DFS_CPU_BoundQry2000](
	[SVRName] [nvarchar](128) NULL,
	[DBName] [nvarchar](128) NULL,
	[text] [nvarchar](max) NULL,
	[query_plan] [xml] NULL,
	[sql_handle] [varbinary](64) NOT NULL,
	[statement_start_offset] [int] NOT NULL,
	[statement_end_offset] [int] NOT NULL,
	[plan_generation_num] [bigint] NULL,
	[plan_handle] [varbinary](64) NOT NULL,
	[creation_time] [datetime] NULL,
	[last_execution_time] [datetime] NULL,
	[execution_count] [bigint] NOT NULL,
	[total_worker_time] [bigint] NOT NULL,
	[last_worker_time] [bigint] NOT NULL,
	[min_worker_time] [bigint] NOT NULL,
	[max_worker_time] [bigint] NOT NULL,
	[total_physical_reads] [bigint] NOT NULL,
	[last_physical_reads] [bigint] NOT NULL,
	[min_physical_reads] [bigint] NOT NULL,
	[max_physical_reads] [bigint] NOT NULL,
	[total_logical_writes] [bigint] NOT NULL,
	[last_logical_writes] [bigint] NOT NULL,
	[min_logical_writes] [bigint] NOT NULL,
	[max_logical_writes] [bigint] NOT NULL,
	[total_logical_reads] [bigint] NOT NULL,
	[last_logical_reads] [bigint] NOT NULL,
	[min_logical_reads] [bigint] NOT NULL,
	[max_logical_reads] [bigint] NOT NULL,
	[total_clr_time] [bigint] NOT NULL,
	[last_clr_time] [bigint] NOT NULL,
	[min_clr_time] [bigint] NOT NULL,
	[max_clr_time] [bigint] NOT NULL,
	[total_elapsed_time] [bigint] NOT NULL,
	[last_elapsed_time] [bigint] NOT NULL,
	[min_elapsed_time] [bigint] NOT NULL,
	[max_elapsed_time] [bigint] NOT NULL,
	[query_hash] [binary](8) NULL,
	[query_plan_hash] [binary](8) NULL,
	[total_rows] [bigint] NULL,
	[last_rows] [bigint] NULL,
	[min_rows] [bigint] NULL,
	[max_rows] [bigint] NULL,
	[statement_sql_handle] [varbinary](64) NULL,
	[statement_context_id] [bigint] NULL,
	[total_dop] [bigint] NULL,
	[last_dop] [bigint] NULL,
	[min_dop] [bigint] NULL,
	[max_dop] [bigint] NULL,
	[total_grant_kb] [bigint] NULL,
	[last_grant_kb] [bigint] NULL,
	[min_grant_kb] [bigint] NULL,
	[max_grant_kb] [bigint] NULL,
	[total_used_grant_kb] [bigint] NULL,
	[last_used_grant_kb] [bigint] NULL,
	[min_used_grant_kb] [bigint] NULL,
	[max_used_grant_kb] [bigint] NULL,
	[total_ideal_grant_kb] [bigint] NULL,
	[last_ideal_grant_kb] [bigint] NULL,
	[min_ideal_grant_kb] [bigint] NULL,
	[max_ideal_grant_kb] [bigint] NULL,
	[total_reserved_threads] [bigint] NULL,
	[last_reserved_threads] [bigint] NULL,
	[min_reserved_threads] [bigint] NULL,
	[max_reserved_threads] [bigint] NULL,
	[total_used_threads] [bigint] NULL,
	[last_used_threads] [bigint] NULL,
	[min_used_threads] [bigint] NULL,
	[max_used_threads] [bigint] NULL,
	[RunDate] [datetime] NOT NULL,
	[SSVer] [nvarchar](300) NULL,
	[RunID] [int] NOT NULL,
	[UID] [uniqueidentifier] NOT NULL,
	[Processed] [int] NULL,
	[RowNbr] [int] IDENTITY(1,1) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

ALTER TABLE [dbo].[DFS_CPU_BoundQry2000] ADD  DEFAULT (newid()) FOR [UID]

ALTER TABLE [dbo].[DFS_CPU_BoundQry2000] ADD  DEFAULT ((0)) FOR [Processed]
end 

--SELECT '[' + column_name + '],' FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'DFS_CPU_BoundQry2000';
-- drop table dbo.[DFS_CPU_BoundQry2000]
--performance bottleneck
--is it CPU or I/O bound? If your performance bottleneck is CPU bound, Find trhe top 5 worst 
--performing queries regarding CPU consumption with the following query:
-- Worst performing CPU bound queries

USE master;
GO
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'sp_UTIL_CPU_BoundQry2000'
)
    BEGIN
        DROP PROCEDURE sp_UTIL_CPU_BoundQry2000;
END;
GO
-- exec sp_UTIL_CPU_BoundQry2000 1
CREATE PROCEDURE sp_UTIL_CPU_BoundQry2000
AS
    BEGIN
        DECLARE @msg VARCHAR(100);
        DECLARE @DBNAME VARCHAR(100)= DB_NAME();
        DECLARE @NextID BIGINT= 0;
        EXEC @NextID = dbo.UTIL_GetSeq;
        IF EXISTS
        (
            SELECT 1
            FROM dbo.[DFS_DB2Skip]
            WHERE @DBNAME = [DB]
        )
            BEGIN
                SET @msg = 'SKIPPING: ' + @DBNAME;
                EXEC sp_printimmediate 
                     @msg;
                RETURN;
        END;
        SET @msg = 'UTIL CPU DB: ' + @DBNAME;
        EXEC sp_printimmediate 
             @msg;
        DECLARE @RunDate AS DATETIME= GETDATE();
        INSERT INTO [dbo].[DFS_CPU_BoundQry2000]
        ([SVRName], 
         [DBName], 
         [text], 
         [query_plan], 
         [sql_handle], 
         [statement_start_offset], 
         [statement_end_offset], 
         [plan_generation_num], 
         [plan_handle], 
         [creation_time], 
         [last_execution_time], 
         [execution_count], 
         [total_worker_time], 
         [last_worker_time], 
         [min_worker_time], 
         [max_worker_time], 
         [total_physical_reads], 
         [last_physical_reads], 
         [min_physical_reads], 
         [max_physical_reads], 
         [total_logical_writes], 
         [last_logical_writes], 
         [min_logical_writes], 
         [max_logical_writes], 
         [total_logical_reads], 
         [last_logical_reads], 
         [min_logical_reads], 
         [max_logical_reads], 
         [total_clr_time], 
         [last_clr_time], 
         [min_clr_time], 
         [max_clr_time], 
         [total_elapsed_time], 
         [last_elapsed_time], 
         [min_elapsed_time], 
         [max_elapsed_time], 
         [query_hash], 
         [query_plan_hash], 
         [total_rows], 
         [last_rows], 
         [min_rows], 
         [max_rows], 
         [statement_sql_handle], 
         [statement_context_id], 
         [total_dop], 
         [last_dop], 
         [min_dop], 
         [max_dop], 
         [total_grant_kb], 
         [last_grant_kb], 
         [min_grant_kb], 
         [max_grant_kb], 
         [total_used_grant_kb], 
         [last_used_grant_kb], 
         [min_used_grant_kb], 
         [max_used_grant_kb], 
         [total_ideal_grant_kb], 
         [last_ideal_grant_kb], 
         [min_ideal_grant_kb], 
         [max_ideal_grant_kb], 
         [total_reserved_threads], 
         [last_reserved_threads], 
         [min_reserved_threads], 
         [max_reserved_threads], 
         [total_used_threads], 
         [last_used_threads], 
         [min_used_threads], 
         [max_used_threads], 
         [RunDate], 
         [SSVer], 
         [RunID], 
         [UID]
        )
               SELECT TOP 10 @@SERVERNAME AS SVRName, 
                             DB_NAME() AS DBName, 
                             st.text, 
                             qp.query_plan, 
                             qs.*, 
                             GETDATE() AS RunDate, 
                             @@VERSION AS SSVer, 
                             @NextID AS RunID, 
                             NEWID() AS [UID]
               FROM sys.dm_exec_query_stats qs
                    CROSS APPLY sys.dm_exec_sql_text(qs.plan_handle) st
                    CROSS APPLY sys.dm_exec_query_plan(qs.plan_handle) qp;
        --ORDER BY total_worker_time DESC;
    END;
GO
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'sp_UTIL_IO_BoundQry2000'
)
    BEGIN
        DROP PROCEDURE sp_UTIL_IO_BoundQry2000;
END;
GO
CREATE PROCEDURE sp_UTIL_IO_BoundQry2000
WITH RECOMPILE
AS
    BEGIN
        DECLARE @msg VARCHAR(100);
        DECLARE @DBNAME VARCHAR(100)= DB_NAME();
        DECLARE @NextID BIGINT= 0;
        EXEC @NextID = dbo.UTIL_GetSeq;
        DECLARE @RunDate AS DATETIME= GETDATE();
        IF EXISTS
        (
            SELECT 1
            FROM dbo.[DFS_DB2Skip]
            WHERE @DBNAME = [DB]
        )
            BEGIN
                SET @msg = 'SKIPPING: ' + @DBNAME;
                EXEC sp_printimmediate 
                     @msg;
                RETURN;
        END;
        SET @msg = 'UTIL IO DB: ' + @DBNAME;
        EXEC sp_printimmediate 
             @msg;
        INSERT INTO [dbo].[DFS_IO_BoundQry2000]
        ([SVRName], 
         [DBName], 
         [text], 
         [query_plan], 
         [sql_handle], 
         [statement_start_offset], 
         [statement_end_offset], 
         [plan_generation_num], 
         [plan_handle], 
         [creation_time], 
         [last_execution_time], 
         [execution_count], 
         [total_worker_time], 
         [last_worker_time], 
         [min_worker_time], 
         [max_worker_time], 
         [total_physical_reads], 
         [last_physical_reads], 
         [min_physical_reads], 
         [max_physical_reads], 
         [total_logical_writes], 
         [last_logical_writes], 
         [min_logical_writes], 
         [max_logical_writes], 
         [total_logical_reads], 
         [last_logical_reads], 
         [min_logical_reads], 
         [max_logical_reads], 
         [total_clr_time], 
         [last_clr_time], 
         [min_clr_time], 
         [max_clr_time], 
         [total_elapsed_time], 
         [last_elapsed_time], 
         [min_elapsed_time], 
         [max_elapsed_time], 
         [query_hash], 
         [query_plan_hash], 
         [total_rows], 
         [last_rows], 
         [min_rows], 
         [max_rows], 
         [statement_sql_handle], 
         [statement_context_id], 
         [total_dop], 
         [last_dop], 
         [min_dop], 
         [max_dop], 
         [total_grant_kb], 
         [last_grant_kb], 
         [min_grant_kb], 
         [max_grant_kb], 
         [total_used_grant_kb], 
         [last_used_grant_kb], 
         [min_used_grant_kb], 
         [max_used_grant_kb], 
         [total_ideal_grant_kb], 
         [last_ideal_grant_kb], 
         [min_ideal_grant_kb], 
         [max_ideal_grant_kb], 
         [total_reserved_threads], 
         [last_reserved_threads], 
         [min_reserved_threads], 
         [max_reserved_threads], 
         [total_used_threads], 
         [last_used_threads], 
         [min_used_threads], 
         [max_used_threads], 
         [RunDate], 
         [SSVER], 
         [RunID]
        )
               SELECT TOP 100 @@SERVERNAME AS SVRName, 
                              'DBNAME' AS DBName, 
                              st.text, 
                              qp.query_plan, 
                              qs.*, 
                              GETDATE() AS RunDate, 
                              @@version AS SSVER, 
                              0 AS RunID
               FROM sys.dm_exec_query_stats qs
                    CROSS APPLY sys.dm_exec_sql_text(qs.plan_handle) st
                    CROSS APPLY sys.dm_exec_query_plan(qs.plan_handle) qp;
    END;
GO
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'sp_UTIL_MSTR_BoundQry2000'
)
    BEGIN
        DROP PROCEDURE sp_UTIL_MSTR_BoundQry2000;
END;
GO
CREATE PROCEDURE sp_UTIL_MSTR_BoundQry2000
AS
    BEGIN
        EXEC sp_UTIL_IO_BoundQry2000;
        EXEC sp_UTIL_CPU_BoundQry2000;
    END;
GO

-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016PRINT '--- "D:\dev\SQL\DFINAnalytics\UTIL_WorstPerformingQuerries2008.sql"' 

/****************** PROCESSING FILE *************************************/

GO  
PRINT 'ID# 140'  
print 'D:\dev\SQL\DFINAnalytics\FindBlockingDetail.sql' 

USE [DFS];
GO
DECLARE @runnow INT= 0;
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'UTIL_TxMonitorTableIndexStats'
)
   AND @runnow = 1
    BEGIN

        /*declare @RunID BIGINT = NEXT VALUE FOR master_seq;*/

        DECLARE @RunID BIGINT;
        EXEC @RunID = dbo.UTIL_GetSeq;
        PRINT @RunID;
        DECLARE @command VARCHAR(1000);
        SELECT @command = 'USE ?; declare @DB as int = DB_ID() ; exec sp_DFS_MonitorLocks ' + CAST(@RunID AS NVARCHAR(25)) + ' ;';
        EXEC sp_MSforeachdb @command;
END;
go
/* drop TABLE [dbo].[DFS_TranLocks]*/

IF NOT EXISTS
(
    SELECT 1
    FROM sys.tables
    WHERE name = 'DFS_TranLocks'
)
    CREATE TABLE [dbo].[DFS_TranLocks]
    ([SPID]                 [INT] NOT NULL, 
     [SvrName]              [NVARCHAR](128) NULL, 
     [DatabaseName]         [NVARCHAR](128) NULL, 
     [LockedObjectName]     [SYSNAME] NOT NULL, 
     [LockedObjectId]       [INT] NOT NULL, 
     [LockedResource]       [NVARCHAR](60) NOT NULL, 
     [LockType]             [NVARCHAR](60) NOT NULL, 
     [SqlStatementText]     [NVARCHAR](MAX) NULL, 
     [LoginName]            [NVARCHAR](128) NOT NULL, 
     [HostName]             [NVARCHAR](128) NULL, 
     [IsUserTransaction]    [BIT] NOT NULL, 
     [TransactionName]      [NVARCHAR](32) NOT NULL, 
     [AuthenticationMethod] [NVARCHAR](40) NOT NULL, 
     RunID                  INT NULL, 
     CreateDate             DATETIME DEFAULT GETDATE(), 
     [UID]                  UNIQUEIDENTIFIER DEFAULT NEWID()
    )
    ON [PRIMARY];
GO

use master 
go
/* Select * from DFS_TranLocks
DECLARE @RunID BIGINT;
EXEC @RunID = dbo.UTIL_GetSeq;
PRINT @RunID;
exec sp_DFS_MonitorLocks @RunID
*/

IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'sp_DFS_MonitorLocks '
)
    DROP PROCEDURE sp_DFS_MonitorLocks;
GO

/*
 exec dbo.sp_DFS_MonitorLocks
 select * from [dbo].[DFS_TranLocks]
 */
 
CREATE PROCEDURE sp_DFS_MonitorLocks (@RunID INT)
AS
    BEGIN

        INSERT INTO [dbo].[DFS_TranLocks]
        ( [SPID], 
          [SvrName], 
          [DatabaseName], 
          [LockedObjectName], 
          [LockedObjectId], 
          [LockedResource], 
          [LockType], 
          [SqlStatementText], 
          [LoginName], 
          [HostName], 
          [IsUserTransaction], 
          [TransactionName], 
          [AuthenticationMethod], 
          [RunID], 
          [CreateDate], 
          [UID]
        ) 
               SELECT LOCKS.request_session_id AS SPID, 
                      @@SERVERNAME, 
                      DB_NAME(LOCKS.resource_database_id) AS DatabaseName, 
                      OBJ.Name AS LockedObjectName, 
                      P.object_id AS LockedObjectId, 
                      LOCKS.resource_type AS LockedResource, 
                      LOCKS.request_mode AS LockType, 
                      ST.text AS SqlStatementText, 
                      ES.login_name AS LoginName, 
                      ES.host_name AS HostName, 
                      SESSIONTX.is_user_transaction AS IsUserTransaction, 
                      ATX.name AS TransactionName, 
                      CN.auth_scheme AS AuthenticationMethod, 
                      @RunID, 
                      GETDATE(), 
                      NEWID()
               FROM sys.dm_tran_locks LOCKS
                         JOIN sys.partitions P
                         ON P.hobt_id = LOCKS.resource_associated_entity_id
                              JOIN sys.objects OBJ
                         ON OBJ.object_id = P.object_id
                                   JOIN sys.dm_exec_sessions ES
                         ON ES.session_id = LOCKS.request_session_id
                                        JOIN sys.dm_tran_session_transactions SESSIONTX
                         ON ES.session_id = SESSIONTX.session_id
                                             JOIN sys.dm_tran_active_transactions ATX
                         ON SESSIONTX.transaction_id = ATX.transaction_id
                                                  JOIN sys.dm_exec_connections CN
                         ON CN.session_id = ES.session_id
                                                       CROSS APPLY sys.dm_exec_sql_text(CN.most_recent_sql_handle) AS ST
               WHERE resource_database_id = DB_ID()
               ORDER BY LOCKS.request_session_id;

/* W. Dale Miller
         DMA, Limited
         Offered under GNU License
         July 26, 2016*/

    END;

/****************** PROCESSING FILE *************************************/

GO  
PRINT 'ID# 150'  
print 'D:\dev\SQL\DFINAnalytics\UTIL_RebuildAllDbIndexUsingDBCC.sql' 
USE master;
GO
IF EXISTS
(
    SELECT 1
    FROM   sys.procedures
    WHERE  name = 'sp_UTIL_RebuildAllDbIndexUsingDBCC'
)
    DROP PROCEDURE sp_UTIL_RebuildAllDbIndexUsingDBCC;
	GO
CREATE PROCEDURE sp_UTIL_RebuildAllDbIndexUsingDBCC
AS
    BEGIN
        DECLARE @tblname VARCHAR(250);
        DECLARE tbl CURSOR
        FOR SELECT table_name
            FROM   information_schema.tables
            WHERE  table_type = 'base table';
        OPEN tbl;
        DECLARE @msg VARCHAR(1000);
        FETCH NEXT FROM tbl INTO @tblname;
        WHILE @@FETCH_STATUS = 0
            BEGIN
                SET @msg = 'Processing: ' + @tblname;
                EXEC sp_printimmediate 
                     @msg;
                DBCC DBREINDEX(@tblname, ' ', 80);
                FETCH NEXT FROM tbl INTO @tblname;
            END;
        CLOSE tbl;
        DEALLOCATE tbl;
    END;PRINT '--- "D:\dev\SQL\DFINAnalytics\UTIL_RebuildAllDbIndexUsingDBCC.sql"' 


/****************** PROCESSING FILE *************************************/

GO  
PRINT 'ID# 160'  
print 'D:\dev\SQL\DFINAnalytics\UTIL_MonitorWorkload.sql' 
-- W. Dale Miller @ 1/1/2019
USE [DFS];
go

/*
DECLARE @RunID BIGINT;
EXEC @RunID = dbo.UTIL_GetSeq;
PRINT 'RUN ID: ' + cast(@RunID as nvarchar(10));
DECLARE @command NVARCHAR(1000);
SELECT @command = 'USE ?; exec dbo.UTIL_MonitorWorkload ' + CAST(@RunID AS NVARCHAR(10)) ;
EXEC sp_MSforeachdb @command;
*/


/*
--select '[' + column_name +'],' from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'DFS_Workload'
--go
--drop table DFS_Workload;
--go
--ALTER TABLE DFS_Workload
--ADD RowID BIGINT IDENTITY(1, 1) NOT NULL;
--ALTER TABLE DFS_Workload
--ADD RunDate DATETIME DEFAULT GETDATE() NOT NULL;
--exec dbo.UTIL_MonitorWorkload
--select * from DFS_Workload
--GO
*/

IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.TABLES
    WHERE TABLE_NAME = 'DFS_Workload'
)
    BEGIN
        CREATE TABLE dbo.[DFS_Workload]
        (Svrname nvarchar(150) null,
		[OptimizationPct]             [DECIMAL](5, 2) NULL, 
         [TrivialPlanPct]              [DECIMAL](5, 2) NULL, 
         [NoPlanPct]                   [DECIMAL](5, 2) NULL, 
         [Search0Pct]                  [DECIMAL](5, 2) NULL, 
         [Search1Pct]                  [DECIMAL](5, 2) NULL, 
         [Search2Pct]                  [DECIMAL](5, 2) NULL, 
         [TimeoutPct]                  [DECIMAL](5, 2) NULL, 
         [MemoryLimitExceededPct]      [DECIMAL](5, 2) NULL, 
         [InsertStmtPct]               [DECIMAL](5, 2) NULL, 
         [DeleteStmt]                  [DECIMAL](5, 2) NULL, 
         [UpdateStmt]                  [DECIMAL](5, 2) NULL, 
         [MergeStmt]                   [DECIMAL](5, 2) NULL, 
         [ContainsSubqueryPct]         [DECIMAL](5, 2) NULL, 
         [ViewReferencePct]            [DECIMAL](5, 2) NULL, 
         [RemoteQueryPct]              [DECIMAL](5, 2) NULL, 
         [DynamicCursorRequestPct]     [DECIMAL](5, 2) NULL, 
         [FastForwardCursorRequestPct] [DECIMAL](5, 2) NULL,
		 [UID] uniqueidentifier default newid(), 
         RowID                         BIGINT IDENTITY(1, 1) NOT NULL, 
         RunDate                       DATETIME DEFAULT GETDATE() NOT NULL
        )
        ON [PRIMARY];
END;

go
--use master;
go
--The below common_table_expression (CTE) uses this DMV to provide 
--information about the workload, such as the percentage of queries 
--that reference a view. The results returned by this query do not 
--indicate a performance problem by themselves, but can expose 
--underlying issues when combined with users' complaints of slow-performing 
--queries.
--exec dbo.UTIL_MonitorWorkload
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'UTIL_MonitorWorkload'
)
    BEGIN
        DROP PROCEDURE UTIL_MonitorWorkload;
END;
GO

-- exec dbo.UTIL_MonitorWorkload 
IF EXISTS (SELECT 1 FROM sys.procedures WHERE name = 'UTIL_MonitorWorkload')
	drop PROCEDURE UTIL_MonitorWorkload 
go
CREATE PROCEDURE UTIL_MonitorWorkload 
AS
	--UTIL_MonitorWorkload.sql
    BEGIN
		declare @DBname nvarchar(100) = db_name();
		declare @msg nvarchar(1000);
		set @msg = 'WORKLOAD Processing: ' + @DBname;
		exec dbo.printimmediate @msg;
        IF OBJECT_ID('tempdb..#TMP_WorkLoad') IS NOT NULL
            DROP TABLE #TMP_WorkLoad;
        WITH CTE_QO
             AS (SELECT occurrence
                 FROM sys.dm_exec_query_optimizer_info
                 WHERE([counter] = 'optimizations')),
             QOInfo
             AS (SELECT [counter], 
                        [%] = CAST((occurrence * 100.00) /
                 (
                     SELECT occurrence
                     FROM CTE_QO
                 ) AS DECIMAL(5, 2))
                 FROM sys.dm_exec_query_optimizer_info
                 WHERE [counter] IN('optimizations', 'trivial plan', 'no plan', 'search 0', 'search 1', 'search 2', 'timeout', 'memory limit exceeded', 'insert stmt', 'delete stmt', 'update stmt', 'merge stmt', 'contains subquery', 'view reference', 'remote query', 'dynamic cursor request', 'fast forward cursor request'))
             SELECT @@servername as SvrName,
					[optimizations] AS [OptimizationPct], 
                    [trivial plan] AS [TrivialPlanPct], 
                    [no plan] AS [NoPlanPct], 
                    [search 0] AS [Search0Pct], 
                    [search 1] AS [Search1Pct], 
                    [search 2] AS [Search2Pct], 
                    [timeout] AS [TimeoutPct], 
                    [memory limit exceeded] AS [MemoryLimitExceededPct], 
                    [insert stmt] AS [InsertStmtPct], 
                    [delete stmt] AS [DeleteStmt], 
                    [update stmt] AS [UpdateStmt], 
                    [merge stmt] AS [MergeStmt], 
                    [contains subquery] AS [ContainsSubqueryPct], 
                    [view reference] AS [ViewReferencePct], 
                    [remote query] AS [RemoteQueryPct], 
                    [dynamic cursor request] AS [DynamicCursorRequestPct], 
                    [fast forward cursor request] AS [FastForwardCursorRequestPct],
					newid() as [UID] 
             INTO #TMP_WorkLoad
             FROM QOInfo PIVOT(MAX([%]) FOR [counter] IN([optimizations], 
                                                         [trivial plan], 
                                                         [no plan], 
                                                         [search 0], 
                                                         [search 1], 
                                                         [search 2], 
                                                         [timeout], 
                                                         [memory limit exceeded], 
                                                         [insert stmt], 
                                                         [delete stmt], 
                                                         [update stmt], 
                                                         [merge stmt], 
                                                         [contains subquery], 
                                                         [view reference], 
                                                         [remote query], 
                                                         [dynamic cursor request], 
                                                         [fast forward cursor request])) AS p;
        INSERT INTO dbo.DFS_Workload
        ([SvrName]
           ,[OptimizationPct]
           ,[TrivialPlanPct]
           ,[NoPlanPct]
           ,[Search0Pct]
           ,[Search1Pct]
           ,[Search2Pct]
           ,[TimeoutPct]
           ,[MemoryLimitExceededPct]
           ,[InsertStmtPct]
           ,[DeleteStmt]
           ,[UpdateStmt]
           ,[MergeStmt]
           ,[ContainsSubqueryPct]
           ,[ViewReferencePct]
           ,[RemoteQueryPct]
           ,[DynamicCursorRequestPct]
           ,[FastForwardCursorRequestPct],
		   [UID]
        )
               SELECT *
               FROM #TMP_WorkLoad;

    END;
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016


/****************** PROCESSING FILE *************************************/

GO  
PRINT 'ID# 170'  
print 'D:\dev\SQL\DFINAnalytics\FindBlockedSPIDS.sql' 
USE [DFS];
GO

/*EXEC sp_who2;
EXEC sp_who;
GO*/

IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'UTIL_ListQryTextBySpid'
)
    DROP PROCEDURE UTIL_ListQryTextBySpid;
	GO
CREATE PROC UTIL_ListQryTextBySpid(@SPID INT)
AS

/*Exec UTIL_ListQryBySpid 306  
     To see the last statement sent from a client to an SQL Server instance run: (for example for the blocking session ID)*/

     DBCC INPUTBUFFER(@SPID);
GO
GRANT EXECUTE ON OBJECT ::dbo.UTIL_ListQryTextBySpid TO public;
GO
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'UTIL_getRunningQueryText'
)
    DROP PROCEDURE UTIL_getRunningQueryText;
GO
CREATE PROC UTIL_getRunningQueryText(@SPID INT)
AS

     /*Lists query by @SPID in SQL Server and the text*/

     SELECT r.session_id, 
            s.host_name, 
            s.login_name, 
            s.original_login_name, 
            r.STATUS, 
            r.command, 
            r.cpu_time, 
            r.total_elapsed_time, 
            t.text AS Query_Text
     FROM sys.dm_exec_requests r
               CROSS APPLY sys.dm_exec_sql_text(sql_handle) t
                    INNER JOIN sys.dm_exec_sessions s
                                ON r.session_id = s.session_id
     WHERE r.session_id = @SPID;
GO
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'UTIL_ListCurrentRunningQueries'
)
    DROP PROCEDURE UTIL_ListCurrentRunningQueries;
	GO
CREATE PROC UTIL_ListCurrentRunningQueries
AS

     /*Lists all currently running queries in SQL Server and their text*/

     SELECT r.session_id, 
            s.host_name, 
            s.login_name, 
            s.original_login_name, 
            r.STATUS, 
            r.command, 
            r.cpu_time, 
            r.total_elapsed_time, 
            t.text AS Query_Text
     FROM sys.dm_exec_requests r
               CROSS APPLY sys.dm_exec_sql_text(sql_handle) t
                    INNER JOIN sys.dm_exec_sessions s
                                ON r.session_id = s.session_id;
GO
GRANT EXECUTE ON OBJECT ::dbo.UTIL_ListCurrentRunningQueries TO public;
GO

/* drop TABLE [dbo].[DFS_BlockingHistory]*/

IF NOT EXISTS
(
    SELECT 1
    FROM sys.tables
    WHERE name = 'DFS_BlockingHistory'
)
    CREATE TABLE [dbo].[DFS_BlockingHistory]
    ([session_id]          [SMALLINT] NOT NULL, 
     [blocking_session_id] [SMALLINT] NULL, 
     [cpu_time]            [INT] NOT NULL, 
     [total_elapsed_time]  [INT] NOT NULL, 
     [Database_Name]       [NVARCHAR](128) NULL, 
     [host_name]           [NVARCHAR](128) NULL, 
     [login_name]          [NVARCHAR](128) NOT NULL, 
     [original_login_name] [NVARCHAR](128) NOT NULL, 
     [STATUS]              [NVARCHAR](30) NOT NULL, 
     [command]             [NVARCHAR](16) NOT NULL, 
     [Query_Text]          [NVARCHAR](MAX) NULL, 
     CreateDate            DATETIME NULL, 
     RunID                 INT NULL, 
     RowNbr                INT IDENTITY(1, 1) NOT NULL
    )
    ON [PRIMARY];
GO
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'UTIL_ListQueryAndBlocks'
)
    DROP PROCEDURE UTIL_ListQueryAndBlocks;
	GO

/*Lists database name that requests are executing against and blocking session ID for blocked queries:
 select top 1000 * from [dbo].[DFS_BlockingHistory]
 truncate table [dbo].[DFS_BlockingHistory]*/
/*
declare @msg nvarchar(250);
declare @i int = 1 ;
while (@i <60)
begin
	set @msg = '@I = ' + cast(@i as nvarchar(10));
	exec sp_printimmediate @msg;
	waitfor delay '00:00:10'
	exec UTIL_ListQueryAndBlocks
	set @i = @i + 1;	
end
select top 20 * from [dbo].[DFS_BlockingHistory] order by RowNbr desc;

select Count(*) SpidCnt, RunID from [dbo].[DFS_BlockingHistory] Group by RunID order by RunID;

exec UTIL_ListQueryAndBlocks
select top 25 * from [dbo].[DFS_BlockingHistory] order by RowNbr desc
*/

CREATE PROC UTIL_ListQueryAndBlocks
AS
    BEGIN
        DECLARE @RunID INT= 0;
        DECLARE @cnt INT= 0;
        SET @cnt =
        (
            SELECT COUNT(*)
            FROM sys.dm_exec_requests
            WHERE [blocking_session_id] > 0
        );
        IF @cnt > 0
            BEGIN
                EXEC @RunID = dbo.UTIL_GetSeq;
                PRINT 'RUNID: ' + CAST(@RunID AS NVARCHAR(10)) + '->Blocked Count: ' + CAST(@cnt AS NVARCHAR(10));
                WITH BlockedSpids
                     AS (SELECT [blocking_session_id] AS SID
                         FROM sys.dm_exec_requests
                         WHERE [blocking_session_id] > 0
                         UNION ALL
                         SELECT [session_id]
                         FROM sys.dm_exec_requests
                         WHERE [blocking_session_id] > 0)
                     INSERT INTO [dbo].[DFS_BlockingHistory]
                     ( [session_id], 
                       [blocking_session_id], 
                       [cpu_time], 
                       [total_elapsed_time], 
                       [Database_Name], 
                       [host_name], 
                       [login_name], 
                       [original_login_name], 
                       [STATUS], 
                       [command], 
                       [Query_Text], 
                       [CreateDate], 
                       RunID
                     ) 
                            SELECT r.session_id, 
                                   r.blocking_session_id, 
                                   r.cpu_time, 
                                   r.total_elapsed_time, 
                                   DB_NAME(r.database_id) AS Database_Name, 
                                   s.host_name, 
                                   s.login_name, 
                                   s.original_login_name, 
                                   r.STATUS, 
                                   r.command, 
                                   t.text AS Query_Text, 
                                   GETDATE(), 
                                   @RunID
                            FROM sys.dm_exec_requests r
                                      CROSS APPLY sys.dm_exec_sql_text(sql_handle) t
                                           INNER JOIN sys.dm_exec_sessions s
                                                       ON r.session_id = s.session_id
                                                JOIN BlockedSpids B
                                                       ON r.session_id = B.sid;
        END;
    END;
GO
GRANT EXECUTE ON OBJECT ::dbo.UTIL_ListQueryAndBlocks TO public;
GO
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'UTIL_ListBlocks'
)
    DROP PROCEDURE UTIL_ListBlocks;
	GO
CREATE PROC UTIL_ListBlocks
AS

     /*Only running queries that are blocked and session ID of blocking queries:*/

     SELECT r.session_id, 
            r.blocking_session_id, 
            DB_NAME(r.database_id) AS Database_Name, 
            s.host_name, 
            s.login_name, 
            s.original_login_name, 
            r.STATUS, 
            r.command, 
            r.cpu_time, 
            r.total_elapsed_time, 
            t.text AS Query_Text
     FROM sys.dm_exec_requests r
               CROSS APPLY sys.dm_exec_sql_text(sql_handle) t
                    INNER JOIN sys.dm_exec_sessions s
                                ON r.session_id = s.session_id
     WHERE r.blocking_session_id <> 0;
GO
GRANT EXECUTE ON OBJECT ::dbo.UTIL_ListBlocks TO public;
GO
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'UTIL_ListMostCommonWaits'
)
    DROP PROCEDURE UTIL_ListMostCommonWaits;
	GO
CREATE PROC UTIL_ListMostCommonWaits
AS

     /*Display the top 10 most frequent WAITS occuring in the DB*/

     SELECT TOP 10 wait_type, 
                   wait_time_ms, 
                   Percentage = 100. * wait_time_ms / SUM(wait_time_ms) OVER()
     FROM sys.dm_os_wait_stats wt
     WHERE wt.wait_type NOT LIKE '%SLEEP%'
     ORDER BY Percentage DESC;
GO
GRANT EXECUTE ON OBJECT ::dbo.UTIL_ListMostCommonWaits TO public;

/* W. Dale Miller
 DMA, Limited
 Offered under GNU License
 July 26, 2016PRINT '--- "D:\dev\SQL\DFINAnalytics\FindBlockedSPIDS.sql"' */

/****************** PROCESSING FILE *************************************/

GO  
PRINT 'ID# 180'  
print 'D:\dev\SQL\DFINAnalytics\findLocks.sql' 
USE [DFS]
go

/* IF NEEDED, RUN THIS
go
sp_configure 'Show Advanced Options', 1
GO
RECONFIGURE
GO
sp_configure 'Ad Hoc Distributed Queries', 1
GO
RECONFIGURE
*/
/*
exec sp_who2 

select spid, status, Blocked,  open_tran, waitresource, waittype, waittime, cmd, lastwaittype
from dbo.sysprocesses
where Blocked <> 0

dbcc inputbuffer (21)
dbcc inputbuffer (64)

exec sp_lock 56
exec sp_lock 
*/

-- UTIL_findLocks;
GO

IF EXISTS ( SELECT name
            FROM sys.procedures
            WHERE name = 'UTIL_findLocks'
          ) 
    BEGIN
        DROP PROCEDURE UTIL_findLocks;
END;
GO

-- exec UTIL_findLocks
CREATE PROCEDURE UTIL_findLocks
AS
    BEGIN
        SET NOCOUNT ON;
        IF OBJECT_ID('TempDB.dbo.#TempLocks') IS NOT NULL
		DROP TABLE #TempLocks;

        --declare @tsql as nvarchar(1000) = '' ;
        --declare @tcmd as nvarchar(1000) = 'exec sp_lock 63' ;
        --set  @tsql = @tsql + ' SELECT * INTO #TempLocks ' + char(10) ;
        --set  @tsql = @tsql + '        FROM OPENROWSET (''SQLNCLI'', ''Server=localhost;Trusted_Connection=yes;'', '''+@tcmd+''' ) ;' ;
        --exec (@tsql) ;

        IF OBJECT_ID('TempDB.dbo.#TEmpBlocked') IS NOT NULL
            DROP TABLE #TEmpBlocked;
        
        SELECT spid , STATUS , blocked , open_tran , waitresource , waittype , waittime , cmd , lastwaittype
        INTO #TempBlocked
        FROM dbo.sysprocesses
        WHERE blocked <> 0;
        IF ( SELECT COUNT(*)
             FROM #TempBlocked
           ) = 0
            BEGIN
                PRINT 'NO Blocks found.';
                RETURN;
        END;

        --    SELECT
        --           * INTO
        --                  #TempBlocked
        --           FROM OPENROWSET ('SQLNCLI', 'Server=localhost;Trusted_Connection=yes;', 'select spid, status, Blocked, open_tran, waitresource, waittype, waittime, cmd, lastwaittype
        --from dbo.sysprocesses
        --where Blocked <> 0') ;
        --select * from #TempBlocked

        DECLARE @lastwaittype NVARCHAR(1000)= '';
        DECLARE @CMD NVARCHAR(1000)= '';
        DECLARE @waitresource NVARCHAR(1000)= '';
        DECLARE @waittype BINARY(2)= NULL;
        DECLARE @waittime BIGINT= NULL;
        DECLARE @open_tran INT= 0;
        DECLARE @Blocked INT= 0;
        DECLARE @spid INT= 0;
        DECLARE @status AS NVARCHAR(100)= '';
        DECLARE @spid2 AS INT= NULL;
        DECLARE @dbid AS INT= NULL;
        DECLARE @txtObjId AS NVARCHAR(100)= NULL;
        DECLARE @ObjId AS INT= NULL;
        DECLARE @InDid AS INT= NULL;
        DECLARE @Type AS NVARCHAR(100)= NULL;
        DECLARE @Resource AS NVARCHAR(100)= NULL;
        DECLARE @Mode AS NVARCHAR(100)= NULL;
        DECLARE @Status2 AS NVARCHAR(100)= NULL;
        DECLARE @MyParm AS NVARCHAR(100)= NULL;
        DECLARE @MySql AS NVARCHAR(4000)= NULL;
        DECLARE C CURSOR
        FOR SELECT spid , STATUS , Blocked , open_tran , waitresource , waittype , waittime , cmd , lastwaittype
            FROM #TEmpBlocked;
        OPEN C;
        FETCH NEXT FROM C INTO @spid , @status , @Blocked , @open_tran , @waitresource , @waittype , @waittime , @cmd , @lastwaittype;
        PRINT '@spid';
        PRINT @spid;
        WHILE @@FETCH_STATUS = 0
            BEGIN

                --print 'SPID: ' + cast(@spid as nvarchar(50)) ;
                SET @waitresource = LTRIM(@waitresource);
                SET @waitresource = RTRIM(@waitresource);
                --print '-' + @waitresource + '-'
                SET @MyParm = 'EXEC SP_LOCK ' + CAST(@Blocked AS NVARCHAR(50));
                PRINT '@MyParm: ' + @MyParm;
                BEGIN TRY
                    DROP TABLE #TempLocks;
                END TRY
                BEGIN CATCH
                    EXEC sp_PrintImmediate 'filling table #TempLocks ';
                END CATCH;

                --declare @MySql nvarchar(1000) = '' ;
                --declare @Blocked as int = 50 ;
                --declare @MyParm nvarchar(1000) = 'EXEC SP_LOCK ' + cast(@Blocked as nvarchar(50)) ;

                SET @MySql = 'SELECT * INTO #TempLocks ';
                SET @MySql = @MySql + '   FROM OPENROWSET (''SQLNCLI'', ''Server=localhost;Trusted_Connection=yes;'', ''' + @MyParm + ''' ) '; 
                --print @MySql ;
                EXEC (@MySql);
                DECLARE C2 CURSOR
                FOR SELECT spid , dbid , ObjId , InDid , Type , resource , Mode , STATUS
                    FROM #TempLocks;
                OPEN C2;
                FETCH NEXT FROM C2 INTO @spid2 , @dbid , @ObjId , @InDid , @Type , @resource , @Mode , @Status2;
                WHILE @@FETCH_STATUS = 0
                    BEGIN
                        SET @txtObjId = CAST(@ObjId AS NVARCHAR(50));
                        --print @txtObjId +',' + @Status2 ;
                        IF CHARINDEX(@txtObjId , @waitresource) > 0
                           AND 
                           @txtObjId <> '0'
                            BEGIN
                                PRINT 'SPID ' + CAST(@spid AS NVARCHAR(50)) + ' is blocking ' + CAST(@Blocked AS NVARCHAR(50)) + ', at the ' + @Type + ' Level, with a Mode of ' + @mode + ' and a status of ' + @Status2 + ' / from COMMAND: ' + @cmd;
                        END;
                        FETCH NEXT FROM C2 INTO @spid2 , @dbid , @ObjId , @InDid , @Type , @resource , @Mode , @status2;
                    END;
                CLOSE C2;
                DEALLOCATE C2;
                FETCH NEXT FROM C INTO @spid , @status , @Blocked , @open_tran , @waitresource , @waittype , @waittime , @cmd , @lastwaittype;
            END;
        CLOSE C;
        DEALLOCATE C;
        SET NOCOUNT OFF;
    END;
GO

PRINT 'Executed findLocks.sql';
GO

/*
SELECT * INTO #TempLocks    FROM OPENROWSET ('SQLNCLI', 'Server=localhost;Trusted_Connection=yes;', 'EXEC SP_LOCK 53' ) 
select * from #TempLocks
*/

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016PRINT '--- "D:\dev\SQL\DFINAnalytics\findLocks.sql"' 


/****************** PROCESSING FILE *************************************/

GO  
PRINT 'ID# 190'  
print 'D:\dev\SQL\DFINAnalytics\MonitorBlockingDetail.sql' 

/*
REPLACED BY FindBlockingDetail.sql
*/
USE DFINAnalyticsFINAnalyticsFINAnalyticsFS;
GO
-- drop table [dbo].[DFS_TranLocks]
IF NOT EXISTS
(
    SELECT 1
    FROM   sys.tables
    WHERE  name = 'DFS_TranLocks'
)
    CREATE TABLE [dbo].[DFS_TranLocks]
    ([SPID]                 [INT] NOT NULL, 
     [DatabaseName]         [NVARCHAR](128) NULL, 
     [LockedObjectName]     [SYSNAME] NOT NULL, 
     [LockedObjectId]       [INT] NOT NULL, 
     [LockedResource]       [NVARCHAR](60) NOT NULL, 
     [LockType]             [NVARCHAR](60) NOT NULL, 
     [SqlStatementText]     [NVARCHAR](MAX) NULL, 
     [LoginName]            [NVARCHAR](128) NOT NULL, 
     [HostName]             [NVARCHAR](128) NULL, 
     [IsUserTransaction]    [BIT] NOT NULL, 
     [TransactionName]      [NVARCHAR](32) NOT NULL, 
     [AuthenticationMethod] [NVARCHAR](40) NOT NULL, 
     RunID                  INT NULL, 
     CreateDate             DATETIME DEFAULT GETDATE(), 
     RowNbr                 INT IDENTITY(1, 1)
    )
    ON [PRIMARY] TEXTIMAGE_ON [PRIMARY];
GO

USE MASTER;
GO
-- Select top 20 * from DFS_TranLocks order by RowNbr desc
-- exec sp_DFS_MonitorLocks 
IF EXISTS
(
    SELECT 1
    FROM   sys.procedures
    WHERE  name = 'sp_DFS_MonitorLocks '
)
    DROP PROCEDURE sp_DFS_MonitorLocks;
GO

USE master;
go
-- exec sp_DFS_MonitorLocks
-- select top 20 * from [DFS_TranLocks] order by RowNbr desc;
IF EXISTS (SELECT 1 FROM sys.procedures WHERE name = 'sp_DFS_MonitorLocks')
drop PROCEDURE sp_DFS_MonitorLocks;
go
CREATE PROCEDURE sp_DFS_MonitorLocks
AS
begin
     DECLARE @RunID INT;
     EXEC @RunID = dbo.UTIL_GetSeq;
     INSERT INTO dbo.[DFS_TranLocks]
     ([SPID], 
      [DatabaseName], 
      [LockedObjectName], 
      [LockedObjectId], 
      [LockedResource], 
      [LockType], 
      [SqlStatementText], 
      [LoginName], 
      [HostName], 
      [IsUserTransaction], 
      [TransactionName], 
      [AuthenticationMethod], 
      [RunID], 
      [CreateDate]
     )
     SELECT LOCKS.request_session_id AS SPID, 
            DB_NAME(LOCKS.resource_database_id) AS DatabaseName, 
            OBJ.Name AS LockedObjectName, 
            P.object_id AS LockedObjectId, 
            LOCKS.resource_type AS LockedResource, 
            LOCKS.request_mode AS LockType, 
            ST.text AS SqlStatementText, 
            ES.login_name AS LoginName, 
            ES.host_name AS HostName, 
            SESSIONTX.is_user_transaction AS IsUserTransaction, 
            ATX.name AS TransactionName, 
            CN.auth_scheme AS AuthenticationMethod, 
            @RunID, 
            GETDATE()
     FROM   sys.dm_tran_locks LOCKS
     JOIN sys.partitions P
                ON P.hobt_id = LOCKS.resource_associated_entity_id
     JOIN sys.objects OBJ
                ON OBJ.object_id = P.object_id
     JOIN sys.dm_exec_sessions ES
                ON ES.session_id = LOCKS.request_session_id
     JOIN sys.dm_tran_session_transactions SESSIONTX
                ON ES.session_id = SESSIONTX.session_id
     JOIN sys.dm_tran_active_transactions ATX
                ON SESSIONTX.transaction_id = ATX.transaction_id
     JOIN sys.dm_exec_connections CN
                ON CN.session_id = ES.session_id
     CROSS APPLY sys.dm_exec_sql_text(CN.most_recent_sql_handle) AS ST
     WHERE  resource_database_id = DB_ID()
     ORDER BY LOCKS.request_session_id;

	 update dbo.[DFS_TranLocks] set RunID = @RunID, CreateDate = getdate() where RunID is null

     -- W. Dale Miller
     -- DMA, Limited
     -- Offered under GNU License
     -- July 26, 2016
end


/****************** PROCESSING FILE *************************************/

GO  
PRINT 'ID# 200'  
print 'D:\dev\SQL\DFINAnalytics\UTIL_MonitorDeadlocks.sql' 

/*
exec sp_UTIL_DFS_DeadlockStats
go
SELECT *
FROM dbo.DFS_DeadlockStats
*/

USE master;
GO
DECLARE @runnow INT= 0;
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'sp_UTIL_DFS_DeadlockStats'
)
   AND @runnow = 1
    BEGIN
        /*declare @RunID BIGINT = NEXT VALUE FOR master_seq;*/

        DECLARE @RunID BIGINT;
        EXEC @RunID = dbo.UTIL_GetSeq;
        PRINT @RunID;
        DECLARE @command VARCHAR(1000);
        SELECT @command = 'USE ?; exec sp_UTIL_DFS_DeadlockStats ' + CAST(@RunID AS NVARCHAR(25)) + ' ;';
        EXEC sp_MSforeachdb 
             @command;
END;
go

USE DFINAnalyticsFINAnalyticsFINAnalyticsFS;
go
--drop table dbo.DFS_DeadlockStats
IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.tables
    WHERE table_name = 'DFS_DeadlockStats'
)
begin
    CREATE TABLE DFS_DeadlockStats
    (SPID        INT, 
     STATUS      VARCHAR(1000) NULL, 
     Login       SYSNAME NULL, 
     HostName    SYSNAME NULL, 
     BlkBy       SYSNAME NULL, 
     DBName      SYSNAME NULL, 
     Command     VARCHAR(1000) NULL, 
     CPUTime     INT NULL, 
     DiskIO      INT NULL, 
     LastBatch   VARCHAR(1000) NULL, 
     ProgramName VARCHAR(1000) NULL, 
     SPID2       INT, 
     REQUESTID   INT NULL, 
     RunDate     DATETIME DEFAULT GETDATE(), 
     RunID       INT, 
     [UID] uniqueidentifier default newid()
    );
	create index PI_DFS_DeadlockStats on DFS_DeadlockStats (RunID, [UID]) ;
	create index PI_DFS_DeadlockStatsUID on DFS_DeadlockStats ([UID]) ;
	end
GO
use master
go
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'sp_UTIL_DFS_DeadlockStats'
)
    DROP PROCEDURE sp_UTIL_DFS_DeadlockStats;
GO
-- exec sp_UTIL_DFS_DeadlockStats
CREATE PROCEDURE sp_UTIL_DFS_DeadlockStats (@RunID int)
AS
    BEGIN
        IF OBJECT_ID('tempdb..#tempDFS_DeadlockStats') IS NOT NULL
            DROP TABLE #tempDFS_DeadlockStats;
        CREATE TABLE #tempDFS_DeadlockStats
        (SPID        INT, 
         STATUS      VARCHAR(1000) NULL, 
         Login       SYSNAME NULL, 
         HostName    SYSNAME NULL, 
         BlkBy       SYSNAME NULL, 
         DBName      SYSNAME NULL, 
         Command     VARCHAR(1000) NULL, 
         CPUTime     INT NULL, 
         DiskIO      INT NULL, 
         LastBatch   VARCHAR(1000) NULL, 
         ProgramName VARCHAR(1000) NULL, 
         SPID2       INT, 
         REQUESTID   INT NULL --comment out for SQL 2000 databases
        );
        -- select * from #tempDFS_DeadlockStats
        INSERT INTO #tempDFS_DeadlockStats
        EXEC sp_who2;
        
        --SET @RUNID = 78;
        INSERT INTO dbo.DFS_DeadlockStats
               SELECT SPID, 
                      STATUS, 
                      Login, 
                      HostName, 
                      BlkBy, 
                      DBName, 
                      Command, 
                      CPUTime, 
                      DiskIO, 
                      LastBatch, 
                      ProgramName, 
                      SPID2, 
                      REQUESTID, 
                      GETDATE(), 
                      RunID = @RUNID,
					  NEWID() AS [UID]
               FROM #tempDFS_DeadlockStats;
        --WHERE DBName = 'DFINAnalytics';
        UPDATE dbo.DFS_DeadlockStats
          SET 
              BlkBy = NULL
        WHERE LTRIM(blkby) = '.';

        --SELECT * FROM dbo.DFS_DeadlockStats;
        --update dbo.DFS_DeadlockStats set BlkBy = 264 where RowID = 260

        DECLARE @BlockedSPIDS TABLE(BlockedSpid uniqueidentifier);
        INSERT INTO @BlockedSPIDS(BlockedSpid)
        (
            --select cast(blkby as int) as BlockedSpid from dbo.DFS_DeadlockStats where blkby is not null
            SELECT [UID] AS BlockedSpid
            FROM dbo.DFS_DeadlockStats
            WHERE blkby IS NOT NULL
                  AND RunID = @RUNID
        );
        --select * from @BlockedSPIDS;

        DECLARE @BlockingSPIDS TABLE(BlockedingSpid uniqueidentifier);
        INSERT INTO @BlockingSPIDS(BlockedingSpid)
        (
            --select cast(blkby as int) as BlockedSpid from dbo.DFS_DeadlockStats where blkby is not null
            SELECT [UID] AS BlockedingSpid
            FROM dbo.DFS_DeadlockStats
            WHERE [UID] IN
            (
                SELECT BlockedSpid
                FROM @BlockedSPIDS
            )
        );
        --select * from @BlockingSPIDS;

        UPDATE dbo.DFS_DeadlockStats
          SET 
              BlkBy = 'X'
        WHERE dbo.DFS_DeadlockStats.[UID] IN
        (
            SELECT BlockedingSpid
            FROM @BlockingSPIDS
        );
        DELETE FROM dbo.DFS_DeadlockStats
        WHERE BlkBy IS NULL
              AND RUNID = @RUNID;
    END;
GO



-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016


/****************** PROCESSING FILE *************************************/

GO  
PRINT 'ID# 210'  
print 'D:\dev\SQL\DFINAnalytics\UTIL_ReorgFragmentedIndexes.sql' 

/* W. Dale Miller
 wdalemiller@gmail.com*/

USE DFINAnalyticsFINAnalyticsFINAnalyticsFS;
GO
DECLARE @runnow INT= 0;
IF @runnow = 1
    BEGIN

/*declare @RunID BIGINT = NEXT VALUE FOR master_seq;
		truncate TABLE [dbo].[DFS_IndexStats];
		select top 100 * from [dbo].[DFS_IndexStats];
		*/
        DECLARE @command VARCHAR(1000);
        SELECT @command = 'USE ?; exec sp_UTIL_ReorgFragmentedIndexes 0;';
        EXEC sp_MSforeachdb 
             @command;
END;
GO

/*drop TABLE [dbo].DFS_IndexFragReorgHistory*/

IF NOT EXISTS
(
    SELECT 1
    FROM information_schema.tables
    WHERE table_name = 'DFS_IndexFragReorgHistory'
)
    BEGIN
        CREATE TABLE [dbo].DFS_IndexFragReorgHistory
        ([DBName]      [NVARCHAR](128) NULL, 
         [Schema]      NVARCHAR(254) NOT NULL, 
         [Table]       NVARCHAR(254) NOT NULL, 
         [Index]       NVARCHAR(254) NULL, 
         [OnlineReorg] [VARCHAR](10) NULL, 
         [Success]     [VARCHAR](10) NULL, 
         Rundate       DATETIME NULL, 
         RunID         NVARCHAR(60) NULL, 
         Stmt          VARCHAR(MAX) NULL, 
         RowNbr        INT IDENTITY(1, 1) NOT NULL
        )
        ON [PRIMARY];
        ALTER TABLE [dbo].DFS_IndexFragReorgHistory
        ADD DEFAULT(GETDATE()) FOR [RunDate];
END;

/****** Object:  StoredProcedure [dbo].[sp_UTIL_ReorgFragmentedIndexes]    Script Date: 1/10/2019 4:27:24 PM ******/

GO

/* select * FROM dbo.DFS_IndexFragHist 
 exec sp_UTIL_ReorgFragmentedIndexes 'B5E6A690-F150-44E2-BF57-AB4765A94357', 0*/

USE master;
GO
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'sp_UTIL_ReorgFragmentedIndexes'
)
    BEGIN
        DROP PROCEDURE sp_UTIL_ReorgFragmentedIndexes;
END;
GO

/* EXEC sp_UTIL_ReorgFragmentedIndexes 0;*/

CREATE PROCEDURE [dbo].[sp_UTIL_ReorgFragmentedIndexes](@PreviewOnly INT = 1)
AS
    BEGIN
	IF CURSOR_STATUS('global','CursorReorg')>=-1
	BEGIN
	 DEALLOCATE CursorReorg
	END
        /********************CLEAN UP THE INDEXES TO BE PROCESSED *****************		                */

        DELETE FROM [dbo].[DFS_IndexFragHist]
        WHERE [Index] IS NULL;
        DELETE FROM [dbo].[DFS_IndexFragHist]
        WHERE EXISTS
        (
            SELECT *
            FROM [dbo].[DFS_IndexFragHist] AS b
            WHERE b.[DBName] = [dbo].[DFS_IndexFragHist].[DBName]
                  AND b.[Schema] = [dbo].[DFS_IndexFragHist].[Schema]
                  AND b.[Table] = [dbo].[DFS_IndexFragHist].[Table]
                  AND b.[Index] = [dbo].[DFS_IndexFragHist].[Index]
                  AND b.IndexProcessed = [dbo].[DFS_IndexFragHist].[IndexProcessed]
            GROUP BY b.[DBName], 
                     b.[Schema], 
                     b.[Table], 
                     b.[Index], 
                     b.IndexProcessed
            HAVING [dbo].[DFS_IndexFragHist].[RowNbr] > MIN(b.[RowNbr])
        );

        /********************************************************************************/

        DECLARE @msg NVARCHAR(2000);
        DECLARE @RunID VARCHAR(60);
        DECLARE @stmt NVARCHAR(2000);
        DECLARE @Rownbr INT;
        DECLARE @TotCnt INT;
        DECLARE @i INT= 0;
        DECLARE @dbname NVARCHAR(100);
        DECLARE @Schema NVARCHAR(100), @Table NVARCHAR(100), @Index NVARCHAR(100);
        SET @TotCnt =
        (
            SELECT COUNT(*)
            FROM [dbo].[DFS_IndexFragHist]
            WHERE IndexProcessed = 0
        );
        DELETE FROM [dbo].[DFS_IndexFragHist]
        WHERE DBNAME IN
        (
            SELECT DB
            FROM dbo.[DFS_DB2Skip]
        );
        DECLARE CursorReorg CURSOR
        FOR SELECT DBName, 
                   [Schema], 
                   [Table], 
                   [Index], 
                   Rownbr, 
                   RunID
            FROM dbo.DFS_IndexFragHist
            WHERE IndexProcessed != 1
                  AND [index] IS NOT NULL;
        OPEN CursorReorg;
        FETCH NEXT FROM CursorReorg INTO @DBName, @Schema, @Table, @Index, @Rownbr, @RunID;
        WHILE @@FETCH_STATUS = 0
            BEGIN
                SET @i = @i + 1;
                SET @msg = '#' + CAST(@i AS NVARCHAR(10)) + ' of ' + CAST(@TotCnt AS NVARCHAR(10));
                SET @msg = 'REORGANIZE: ' + @DBName + '.' + @Schema + '.' + @Table + ' / ' + @Index;
                EXEC sp_PrintImmediate 
                     @msg;
                SET @stmt = 'ALTER Index ' + @Index + ' ON ' + @DBName + '.' + @Schema + '.' + @Table;

                /*SET @stmt = @stmt + ' REORGANIZE ';*/

                SET @stmt = @stmt + ' REBUILD WITH ';
                SET @stmt = @stmt + '(';
                SET @stmt = @stmt + '  FILLFACTOR = 80 ';
                SET @stmt = @stmt + '  ,ONLINE = ON ';
                SET @stmt = @stmt + ');';
                IF @PreviewOnly = 1
                    BEGIN
                        PRINT('Preview: ' + @stmt);
                END;
                IF @PreviewOnly = 0
                    BEGIN
                        BEGIN TRY
                            SET @msg = 'Starting the REBUILD: ON ' + @DBName + '.' + @Schema + '.' + @Table;
                            EXEC sp_PrintImmediate 
                                 @msg;
                            EXECUTE sp_executesql 
                                    @stmt;
                            BEGIN TRY
                                INSERT INTO [dbo].[DFS_IndexFragReorgHistory]
                                ( [DBName], 
                                  [Schema], 
                                  [Table], 
                                  [Index], 
                                  [OnlineReorg], 
                                  [Success], 
                                  [Rundate], 
                                  [RunID], 
                                  [Stmt]
                                ) 
                                VALUES
                                (
                                       @DBName
                                     , @Schema
                                     , @Table
                                     , @Index
                                     , 'YES'
                                     , 'YES'
                                     , GETDATE()
                                     , @RunID
                                     , @stmt
                                );
                END TRY
                            BEGIN CATCH
                                SET @msg = 'FAILED TO SAVE HISTORY:';
                                SET @msg = @msg + '|' + @DBName;
                                SET @msg = @msg + '.' + @Schema;
                                SET @msg = @msg + '.' + @Table;
                                SET @msg = @msg + '.' + @Index;
                                SET @msg = @msg + ' @' + @stmt;
                                SET @msg = @msg + '@';
                                EXEC sp_PrintImmediate 
                                     @msg;
                                SET @msg = 'ERR MSG @0: ' +
                                (
                                    SELECT ERROR_MESSAGE()
                                );
                                EXEC sp_PrintImmediate 
                                     @msg;
                END CATCH;
                END TRY
                        BEGIN CATCH
                            SET @msg = '-- **************************************';
                            EXEC sp_PrintImmediate 
                                 @msg;
                            SET @msg = 'ERR MSG @1: ' +
                            (
                                SELECT ERROR_MESSAGE()
                            );
                            EXEC sp_PrintImmediate 
                                 @msg;
                            SET @msg = 'CURRENT DB: ' + @dbname;
                            EXEC sp_PrintImmediate 
                                 @msg;
                            SET @msg = 'ERROR: ' + @stmt;
                            EXEC sp_PrintImmediate 
                                 @msg;
                            BEGIN TRY
                                SET @stmt = 'ALTER Index ' + @Index + ' ON ' + @DBName + '.' + @Schema + '.' + @Table;
                                SET @stmt = @stmt + ' reorganize;';

/*SET @stmt = 'ALTER Index ' + @Index + ' ON ' + @DBName + '.' + @Schema + '.' + @Table;
                                SET @stmt = @stmt + ' reorganize;';*/

                                EXECUTE sp_executesql 
                                        @stmt;
                                PRINT '-- **************************************';
                                SET @msg = 'Reorganize : ' + @stmt;
                                EXEC sp_PrintImmediate 
                                     @msg;
                                PRINT '-- **************************************';
                                INSERT INTO [dbo].[DFS_IndexFragReorgHistory]
                                ( [DBName], 
                                  [Schema], 
                                  [Table], 
                                  [Index], 
                                  [OnlineReorg], 
                                  [Success], 
                                  [Rundate], 
                                  [RunID], 
                                  [Stmt]
                                ) 
                                VALUES
                                (
                                       @DBName
                                     , @Schema
                                     , @Table
                                     , @Index
                                     , 'NO @1'
                                     , 'YES'
                                     , GETDATE()
                                     , @RunID
                                     , @stmt
                                );
                END TRY
                            BEGIN CATCH
                                SET @msg = 'ERR MSG: ' +
                                (
                                    SELECT ERROR_MESSAGE()
                                );
                                EXEC sp_PrintImmediate 
                                     @msg;
                                INSERT INTO [dbo].[DFS_IndexFragErrors]
                                ( [SqlCmd], 
                                  DBNAME
                                ) 
                                VALUES
                                (
                                       @stmt
                                     , @DBName
                                );
                                INSERT INTO [dbo].[DFS_IndexFragReorgHistory]
                                ( [DBName], 
                                  [Schema], 
                                  [Table], 
                                  [Index], 
                                  [OnlineReorg], 
                                  [Success], 
                                  [Rundate], 
                                  [RunID], 
                                  [Stmt]
                                ) 
                                VALUES
                                (
                                       @DBName
                                     , @Schema
                                     , @Table
                                     , @Index
                                     , 'NO @2'
                                     , 'NO'
                                     , GETDATE()
                                     , @RunID
                                     , @stmt
                                );
                END CATCH;
                END CATCH;
                END;
                IF @PreviewOnly = 0
                    BEGIN
                        UPDATE [dbo].[DFS_IndexFragHist]
                          SET 
                              IndexProcessed = 1
                        WHERE RowNbr = @Rownbr;
                END;
                FETCH NEXT FROM CursorReorg INTO @DBName, @Schema, @Table, @Index, @Rownbr, @RunID;
            END;
        CLOSE CursorReorg;
        DEALLOCATE CursorReorg;
    END;

/****************** PROCESSING FILE *************************************/

GO  
PRINT 'ID# 220'  
print 'D:\dev\SQL\DFINAnalytics\UTIL_TableGrowthHistory.sql' 
-- W. Dale Miller @ 2016
USE [DFS]; -- replace your dbname
GO

-- drop table DFS_TableGrowthHistory
-- select top 1000 * from DFS_TableGrowthHistory order by DBname, TableName, Rownbr desc;
-- select count(*) from DFS_TableGrowthHistory ;
IF NOT EXISTS
(
    SELECT 1
    FROM   information_schema.tables
    WHERE  table_name = 'DFS_TableGrowthHistory'
)
begin
    CREATE TABLE [dbo].[DFS_TableGrowthHistory]
    ([SvrName]    [SYSNAME] NOT NULL, 
     [DBName]     [SYSNAME] NOT NULL, 
     [SchemaName] [SYSNAME] NOT NULL, 
     [TableName]  [SYSNAME] NOT NULL, 
     [RowCounts]  [BIGINT] NOT NULL, 
     [Used_MB]    [NUMERIC](36, 2) NULL, 
     [Unused_MB]  [NUMERIC](36, 2) NULL, 
     [Total_MB]   [NUMERIC](36, 2) NULL, 
     RunID        NVARCHAR(60) NULL, 
     CreateDate   DATETIME DEFAULT GETDATE(), 
     RowNbr       INT IDENTITY(1, 1) NOT NULL
    )
    ON [PRIMARY];


CREATE INDEX pidx_DFS_TableGrowthHistory
ON DFS_TableGrowthHistory
(DBname, TableName, Rownbr
);
END

-- select * from viewTableGrowthStats
IF EXISTS
(
    SELECT 1
    FROM   information_schema.tables
    WHERE  table_name = 'viewTableGrowthStats'
)
    DROP VIEW viewTableGrowthStats;
GO
CREATE VIEW viewTableGrowthStats
AS
     SELECT DBName, 
            SchemaName, 
            TableName, 
            MIN(RowCounts) StartRowCnt, 
            MAX(RowCounts) EndRowCnt, 
            MAX(RowCounts) - MIN(RowCounts) AS RowGrowth, 
            MIN(Used_MB) StartMB, 
            MAX(Used_MB) EndMB, 
            MAX(Used_MB) - MIN(Used_MB) AS MBGrowth, 
            DATEDIFF(DAY, MIN(CreateDate), MAX(CreateDate)) AS OverNbrDays
     FROM   DFS_TableGrowthHistory
     GROUP BY DBName, 
              SchemaName, 
              TableName;
GO

USE master;
go

IF EXISTS
(
    SELECT 1
    FROM   sys.procedures
    WHERE  name = 'sp_UTIL_TableGrowthHistory'
)
    DROP PROCEDURE sp_UTIL_TableGrowthHistory;
GO
/*
DECLARE @RunID BIGINT;
EXEC @RunID = dbo.UTIL_GetSeq;
PRINT 'RUN ID: ' + cast(@RunID as nvarchar(10));
DECLARE @command NVARCHAR(1000);
SELECT @command = 'USE ?; exec sp_UTIL_TableGrowthHistory ' + CAST(@RunID AS NVARCHAR(10)) ;
print @command;
EXEC sp_MSforeachdb @command;
*/
create PROCEDURE dbo.sp_UTIL_TableGrowthHistory (@RunID int )
AS
    BEGIN
		DECLARE @DBNAME NVARCHAR(100)= DB_NAME();
        DECLARE @x INT;
        EXEC @x = sp_ckProcessDB;
        IF(@x < 1)
            RETURN;
        DECLARE @msg NVARCHAR(1000);
        SET @msg = 'Processing DB: ' + @DBNAME;
        EXEC [dbo].[printimmediate] 
             @msg;
        DECLARE @stmt NVARCHAR(4000);
        INSERT INTO [dbo].[DFS_TableGrowthHistory]
        ([SvrName], 
         [DBName], 
         [SchemaName], 
         [TableName], 
         [RowCounts], 
         [Used_MB], 
         [Unused_MB], 
         [Total_MB], 
         [RunID], 
         [CreateDate]
        )
        SELECT @@ServerName, 
               [DBNAME] = DB_NAME(), 
               s.Name AS SchemaName, 
               t.Name AS TableName, 
               p.rows AS RowCounts, 
               CAST(ROUND((SUM(a.used_pages) / 128.00), 2) AS NUMERIC(36, 2)) AS Used_MB, 
               CAST(ROUND((SUM(a.total_pages) - SUM(a.used_pages)) / 128.00, 2) AS NUMERIC(36, 2)) AS Unused_MB, 
               CAST(ROUND((SUM(a.total_pages) / 128.00), 2) AS NUMERIC(36, 2)) AS Total_MB, 
               RunId = cast(@RunId as nvarchar(10)), 
               CreateDate = GETDATE()
        FROM   sys.tables t
        INNER JOIN sys.indexes i
                   ON t.OBJECT_ID = i.object_id
        INNER JOIN sys.partitions p
                   ON i.object_id = p.OBJECT_ID
                      AND i.index_id = p.index_id
        INNER JOIN sys.allocation_units a
                   ON p.partition_id = a.container_id
        INNER JOIN sys.schemas s
                   ON t.schema_id = s.schema_id
        GROUP BY t.Name, 
                 s.Name, 
                 p.Rows;
        --ORDER BY s.Name, t.Name ';
    END;
GO

-- Unmodified source:
--SELECT
--s.Name AS SchemaName,
--t.Name AS TableName,
--p.rows AS RowCounts,
--CAST(ROUND((SUM(a.used_pages) / 128.00), 2) AS NUMERIC(36, 2)) AS Used_MB,
--CAST(ROUND((SUM(a.total_pages) - SUM(a.used_pages)) / 128.00, 2) AS NUMERIC(36, 2)) AS Unused_MB,
--CAST(ROUND((SUM(a.total_pages) / 128.00), 2) AS NUMERIC(36, 2)) AS Total_MB
--into DFS_TableGrowthHistory
--FROM sys.tables t
--INNER JOIN sys.indexes i ON t.OBJECT_ID = i.object_id
--INNER JOIN sys.partitions p ON i.object_id = p.OBJECT_ID AND i.index_id = p.index_id
--INNER JOIN sys.allocation_units a ON p.partition_id = a.container_id
--INNER JOIN sys.schemas s ON t.schema_id = s.schema_id
--GROUP BY t.Name, s.Name, p.Rows
--ORDER BY s.Name, t.Name
--GOPRINT '--- "D:\dev\SQL\DFINAnalytics\UTIL_TableGrowthHistory.sql"' 


/****************** PROCESSING FILE *************************************/

GO  
PRINT 'ID# 230'  


/****************** PROCESSING FILE *************************************/

GO  
PRINT 'ID# 240'  
print 'D:\dev\SQL\DFINAnalytics\DFS_CleanDFSTables.sql' 

USE [DFS];
GO
IF NOT EXISTS
(
    SELECT 1
    FROM information_schema.tables
    WHERE table_name = 'DFS_CleanedDFSTables'
          AND TABLE_TYPE = 'BASE TABLE'
)
    BEGIN
        CREATE TABLE DFS_CleanedDFSTables
        (SvrName    NVARCHAR(150) NOT NULL, 
         DBName     NVARCHAR(150) NOT NULL, 
         TBLName    NVARCHAR(150) NOT NULL, 
         RowCNT     INT NULL, 
         DropRowCNT INT NULL, 
         CreateDate DATETIME DEFAULT GETDATE(), 
         [UID]      UNIQUEIDENTIFIER DEFAULT NEWID()
        );
        CREATE INDEX pi_DFS_CleanedDFSTables
        ON DFS_CleanedDFSTables
        (TBLName
        );
END;
GO
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'UTIL_CleanUpOneTable'
)
    BEGIN
        DROP PROCEDURE UTIL_CleanUpOneTable;
END;
GO
create procedure UTIL_CleanUpOneTable (@tbl nvarchar(150), @DateColumn nvarchar(50), @DaysToDelete int)
as
begin
		DECLARE @Acnt int   
		DECLARE @Bcnt int   
		DECLARE @retval int   
		DECLARE @sSQL nvarchar(500);
		DECLARE @ParmDefinition nvarchar(500);
		declare @i int ;
		DECLARE @tablename nvarchar(50)  
		SELECT @tablename = @tbl

		SELECT @sSQL = N'SELECT @retvalOUT = count(*) FROM ' + @tablename;  
		SET @ParmDefinition = N'@retvalOUT int OUTPUT';
		EXEC sp_executesql @sSQL, @ParmDefinition, @retvalOUT=@retval OUTPUT;
		set @Acnt = (SELECT @retval);
		print @tbl + ' @Bcnt = ' + cast(@Bcnt as nvarchar(50));

		SELECT @sSQL = 'delete from dbo.' + @tbl + ' where ' + @DateColumn + ' <= getdate() - ' + cast(@DaysToDelete as nvarchar(10)); 
		print @sSQL ;

		SELECT @sSQL = N'SELECT @retvalOUT = count(*) FROM ' + @tablename;  
		SET @ParmDefinition = N'@retvalOUT int OUTPUT';
		EXEC sp_executesql @sSQL, @ParmDefinition, @retvalOUT=@retval OUTPUT;
		set @Bcnt = (SELECT @retval);
		print @tbl + ' @Bcnt = ' + cast(@Bcnt as nvarchar(50));

        INSERT INTO [dbo].[DFS_CleanedDFSTables]
        ( [SvrName], 
          [DBName], 
          [TBLName], 
          [RowCNT], 
          [DropRowCNT], 
          [CreateDate], 
          [UID]
        ) 
        VALUES
        (
               @@servername
             , DB_NAME()
             , @tbl
             , @Acnt
             , @Bcnt
             , GETDATE()
             , NEWID()
        );
end

go
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'UTIL_CleanDFSTables'
)
    BEGIN
        DROP PROCEDURE UTIL_CleanDFSTables;
END;
GO

/* exec UTIL_CleanDFSTables @DaysToDelete = 2 */

CREATE PROCEDURE UTIL_CleanDFSTables(@DaysToDelete INT = 3)
AS
    BEGIN
        exec UTIL_CleanUpOneTable 'DFS_SequenceTABLE', 'CreateDate', @DaysToDelete  ;
        exec UTIL_CleanUpOneTable 'DFS_MissingIndexes','CreateDate',@DaysToDelete;
        exec UTIL_CleanUpOneTable 'DFS_MissingFKIndexes','CreateDate',@DaysToDelete;
        exec UTIL_CleanUpOneTable 'DFS_MissingFKIndexes','CreateDate',@DaysToDelete;
        exec UTIL_CleanUpOneTable 'DFS_TableReadWrites','RunDate',@DaysToDelete;
        exec UTIL_CleanUpOneTable 'DFS_IndexStats','CreateDate',@DaysToDelete;
        exec UTIL_CleanUpOneTable 'DFS_BlockingHistory','CreateDate',@DaysToDelete;
        exec UTIL_CleanUpOneTable 'DFS_SEQ','GenDate',@DaysToDelete;
        exec UTIL_CleanUpOneTable 'DFS_CPU_BoundQry2000','RunDate',@DaysToDelete;
        exec UTIL_CleanUpOneTable 'DFS_IO_BoundQry2000','RunDate',@DaysToDelete;
        exec UTIL_CleanUpOneTable 'DFS_TranLocks','CreateDate',@DaysToDelete;
        exec UTIL_CleanUpOneTable 'DFS_QryOptStats','RunDate',@DaysToDelete;
        exec UTIL_CleanUpOneTable 'DFS_Workload','RunDate',@DaysToDelete;
        exec UTIL_CleanUpOneTable 'DFS_PerfMonitor','CreateDate',@DaysToDelete;
        exec UTIL_CleanUpOneTable 'DFS_TxMonitorTableStats','CreateDate',@DaysToDelete;
        exec UTIL_CleanUpOneTable 'DFS_TxMonitorTblUpdates','CreateDate',@DaysToDelete;
        exec UTIL_CleanUpOneTable 'DFS_DbFileSizing','CreateDate',@DaysToDelete;
        exec UTIL_CleanUpOneTable 'DFS_TxMonitorIDX','CreateDate',@DaysToDelete;
        exec UTIL_CleanUpOneTable 'DFS_DeadlockStats','RunDate',@DaysToDelete;
        exec UTIL_CleanUpOneTable 'DFS_IndexFragReorgHistory','RunDate',@DaysToDelete;
        exec UTIL_CleanUpOneTable 'DFS_TableGrowthHistory','CreateDate',@DaysToDelete;
        exec UTIL_CleanUpOneTable 'DFS_IO_BoundQry','RunDate',@DaysToDelete;
        exec UTIL_CleanUpOneTable 'DFS_CPU_BoundQry','RunDate',@DaysToDelete;
    END;
       

/****************** PROCESSING FILE *************************************/

GO  
PRINT 'ID# 250'  
print 'D:\dev\SQL\DFINAnalytics\UTIL_Monitor_TPS.sql' 
/* D:\dev\SQL\DFINAnalytics\UTIL_Monitor_TPS.sql */
USE [DFS];
GO
DECLARE @runnow INT= 0;
IF  @runnow = 1
    BEGIN

        /*declare @RunID BIGINT = NEXT VALUE FOR master_seq;
		truncate TABLE [dbo].[DFS_IndexStats];
		select top 100 * from [dbo].[DFS_IndexStats];
		*/
        DECLARE @RunID BIGINT;
        EXEC @RunID = dbo.UTIL_GetSeq;
        DECLARE @command VARCHAR(1000);
        SELECT @command = 'USE ?; exec sp_UTIL_TxMonitorIDX '+cast(@RunID as nvarchar(50))+' ; exec sp_UTIL_TxMonitorTableStats ' + CAST(@RunID AS NVARCHAR(25)) + ';' ;
        EXEC sp_MSforeachdb 
             @command;
END;
GO

/*
-- JOB NAME
JOB_DFS_TxMonitorIDX
-- JOB STEP
exec sp_UTIL_TxMonitorIDX
*/

/*
-- JOB NAME
JOB_UTIL_TxMonitorTableStats
-- JOB STEP
exec dbo.sp_UTIL_TxMonitorTableStats
*/

/*
-- =======================================================
DECLARE @command VARCHAR(1000);
SELECT @command = 'USE ?; declare @DB as int = DB_ID() ; exec dbo.sp_UTIL_TxMonitorIDX @DB';
EXEC sp_MSforeachdb @command;
-- =======================================================
*/

USE [DFS];
GO
-- DROP TABLE [DFS_TxMonitorTableStats];
IF NOT EXISTS
(
    SELECT 1
    FROM sys.tables
    WHERE name = 'DFS_TxMonitorTableStats'
)
begin
    CREATE TABLE [dbo].[DFS_TxMonitorTableStats]
    ([SvrName]          [NVARCHAR](128) NULL, 
     [DBName]           [NVARCHAR](128) NULL, 
	 [SchemaName]           [NVARCHAR](128) NULL, 
     [TableName]        [NVARCHAR](128) NULL, 
     [IndexName]        [NVARCHAR](250) NULL, 
     [IndexID]          [INT] NULL, 
     [user_seeks]       [BIGINT] NULL, 
     [user_scans]       [BIGINT] NULL, 
     [user_lookups]     [BIGINT] NULL, 
     [user_updates]     [BIGINT] NULL, 
     [last_user_seek]   [DATETIME] NULL, 
     [last_user_scan]   [DATETIME] NULL, 
     [last_user_lookup] [DATETIME] NULL, 
     [last_user_update] [DATETIME] NULL, 
     [DBID]             [INT] NULL, 
     CreateDate         DATETIME NULL DEFAULT GETDATE(), 
     ExecutionDate      DATETIME NOT NULL, 
	 [UID] uniqueidentifier not null,
	 RunID int null,
     RowNbr INT IDENTITY(1, 1) NOT NULL
    )
    ON [PRIMARY];

	end
GO
-- drop		TABLE [dbo].[DFS_TxMonitorIDX]
IF NOT EXISTS
(
    SELECT 1
    FROM sys.tables
    WHERE name = 'DFS_TxMonitorIDX'
)
    CREATE TABLE [dbo].[DFS_TxMonitorIDX]
    ([SvrName]        [NVARCHAR](128) NULL, 
     [DBName]         [NVARCHAR](128) NULL, 
     [database_id]    [INT] NOT NULL, 
     [TableName]      [NVARCHAR](128) NULL, 
     [UpdatedRows]    [BIGINT] NOT NULL, 
     [LastUpdateTime] [DATETIME] NULL, 
     CreateDate       DATETIME NULL
                               DEFAULT GETDATE(), 
     ExecutionDate    DATETIME NOT NULL, 
	 [UID] uniqueidentifier not null,
	 RunID int null,
     Rownbr           INT IDENTITY(1, 1) NOT NULL
    )
    ON [PRIMARY];
GO

/******************************************
Using sys.dm_db_index_usage_stats:
There's a handy dynamic management view called sys.dm_db_index_usage_stats that shows you
number of rows in both SELECT and DML statements against all the tables and indexes in your
database, either since the object was created or since the database instance was last restarted:
SELECT *
FROM sys.dm_db_index_usage_stats
******************************************/

USE master;
GO
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'sp_UTIL_TxMonitorIDX'
)
    DROP PROCEDURE sp_UTIL_TxMonitorIDX;
GO
/*
exec sp_UTIL_TxMonitorIDX
*/
CREATE PROCEDURE sp_UTIL_TxMonitorIDX (@RunID int)
AS
    BEGIN
        SET NOCOUNT ON;
        DECLARE @ExecutionDate DATETIME= GETDATE();
        -- Collect our working data
        INSERT INTO dbo.DFS_TxMonitorIDX
               SELECT @@SERVERNAME, 
                      DB_NAME(), 
                      database_id, 
                      OBJECT_NAME(us.object_id) AS TableName, 
                      user_updates AS UpdatedRows, 
                      last_user_update AS LastUpdateTime, 
                      GETDATE() AS CreateDate, 
                      ExecutionDate = getdate(),
					  [UID] = newid(),
					  RunID = @RunID
               FROM sys.dm_db_index_usage_stats us
                    JOIN sys.indexes si ON us.object_id = si.object_id
                                           AND us.index_id = si.index_id
               --where database_id =  @DBID
               WHERE user_seeks + user_scans + user_lookups + user_updates > 0
                     AND si.index_id IN(0, 1)
               ORDER BY OBJECT_NAME(us.object_id);
    END;
go
-- drop procedure sp_UTIL_TxMonitorTableStats
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'sp_UTIL_TxMonitorTableStats'
)
    DROP PROCEDURE sp_UTIL_TxMonitorTableStats;
	GO
/*
exec dbo.sp_UTIL_TxMonitorTableStats
*/
CREATE PROCEDURE dbo.sp_UTIL_TxMonitorTableStats  (@RunID int)
AS
    BEGIN
		
        DECLARE @DBID AS INT= DB_ID();
        DECLARE @ExecutionDate DATETIME= GETDATE();
        INSERT INTO [dbo].[DFS_TxMonitorTableStats]
               SELECT @@SERVERNAME, 
                      DB_NAME(), 
					  OBJECT_SCHEMA_NAME ( ius.object_id ) as SchemaName,  
                      OBJECT_NAME(ius.object_id) AS TableName, 
                      si.name AS IndexName, 
                      si.index_id AS IndexID, 
                      ius.user_seeks, 
                      ius.user_scans, 
                      ius.user_lookups, 
                      ius.user_updates, 
                      ius.last_user_seek, 
                      ius.last_user_scan, 
                      ius.last_user_lookup, 
                      ius.last_user_update, 
                      DBID = db_id(), 
					  GETDATE(), 
                      ExecutionDate = getdate(),
					  [UID] = newid(),
					  RunID = -1
               FROM sys.dm_db_index_usage_stats ius
                    JOIN sys.indexes si ON ius.object_id = si.object_id
                                           AND ius.index_id = si.index_id;
    END;
/*
 In the results, you'll have the following columns:
 TableName - The name of the table (the easiest column)
 IndexName - when populated, the name of the index. When it's NULL, it refers to a HEAP - a table without a clustered index IndexID -
  If this is 0, it's a HEAP (IndexName should also be NULL in these cases). When 1, this refers to a clustered index (meaning that the activity columns still all refer to the table data itself). When 2 or greater, this is a standard non-clustered index.
  User activity (the number of times each type of operation has been performed on the index/table):
  User Seeks - searched for a small number of rows - this is the most effecient index operation.
  User Scans - scanned through the whole index looking for rows that meet the WHERE criteria.
  User Lookups - query used the index to find a row number, then pulled data from the table itself to satisfy the query.
  User Updates - number of times the data in this index/table has been updated. Note that not every table update will update every query - if an update modifies a column that's not part of an index, the table
  update
     counter will increment
    , but the index counter will not User activity timestamps - these show the most recent occurance of each of the four types of "User" events 
*/

GO
--**********************************************************************************************
--Making the leap to "transactions per second"
--**********************************************************************************************
--**********************************************************************************************
--Making the leap to "transactions per second"
--**********************************************************************************************


/****************** PROCESSING FILE *************************************/

GO  
PRINT 'ID# 260'  
print 'D:\dev\SQL\DFINAnalytics\UTIL_DefragAllIndexes.sql' 

/* W. Dale Miller
 wdalemiller@gmail.com*/

USE [DFS];
GO

/* DROP TABLE dbo.DFS_IndexFragProgress*/

IF NOT EXISTS
(
    SELECT 1
    FROM information_schema.tables
    WHERE table_name = 'DFS_IndexFragProgress'
)
    BEGIN
        PRINT 'Creating TABLE dbo.DFS_IndexFragProgress';
        CREATE TABLE dbo.DFS_IndexFragProgress
        (SqlCmd    VARCHAR(MAX) NULL, 
         DBNAME    NVARCHAR(100), 
         StartTime DATETIME NULL, 
         EndTime   DATETIME NULL, 
         RunID     NVARCHAR(60) NULL, 
         RowNbr    INT IDENTITY(1, 1) NOT NULL,
        )
        ON [PRIMARY];
        CREATE INDEX idxDFS_DFS_IndexFragProgress
        ON dbo.DFS_IndexFragProgress
        (DBNAME
        );
END;
GO

/* DROP TABLE dbo.DFS_IndexFragErrors*/

IF NOT EXISTS
(
    SELECT 1
    FROM information_schema.tables
    WHERE table_name = 'DFS_IndexFragErrors'
)
    BEGIN
        CREATE TABLE dbo.DFS_IndexFragErrors
        (SqlCmd VARCHAR(MAX) NULL, 
         DBNAME NVARCHAR(100), 
         RunID  NVARCHAR(60) NULL, 
         RowNbr INT IDENTITY(1, 1) NOT NULL,
        )
        ON [PRIMARY];
        CREATE INDEX idxDFS_IndexFragErrors
        ON dbo.DFS_IndexFragErrors
        (DBNAME
        );
        CREATE INDEX pxDFS_IndexFragErrors
        ON dbo.DFS_IndexFragErrors
        (RowNbr
        );
END;
GO

/* select top 100 * from DFS_IndexFragHist
 drop TABLE dbo.DFS_IndexFragHist*/

IF NOT EXISTS
(
    SELECT 1
    FROM information_schema.tables
    WHERE table_name = 'DFS_IndexFragHist'
)
    BEGIN
        CREATE TABLE dbo.DFS_IndexFragHist
        (DBName               NVARCHAR(254) NULL, 
         [Schema]             NVARCHAR(254) NOT NULL, 
         [Table]              NVARCHAR(254) NOT NULL, 
         [Index]              NVARCHAR(254) NULL, 
         alloc_unit_type_desc NVARCHAR(60) NULL, 
         IndexProcessed       INTEGER NULL
                                      DEFAULT 0, 
         AvgPctFrag           DECIMAL(8, 2) NULL, 
         page_count           BIGINT NULL, 
         RunDate              DATETIME DEFAULT GETDATE(), 
         RunID                NVARCHAR(60) NULL, 
         Success              INT NULL, 
         RowNbr               INT IDENTITY(1, 1) NOT NULL
        )
        ON [PRIMARY];
        CREATE INDEX idxRUNIdentifier
        ON dbo.DFS_IndexFragHist
        (RunID
        );
        CREATE INDEX idxIndexPorcessed
        ON dbo.DFS_IndexFragHist
        (IndexProcessed
        );
END;
GO
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'UTIL_DefragAllIndexes'
)
    BEGIN
        DROP PROCEDURE UTIL_DefragAllIndexes;
END;
GO

/* exec UTIL_DefragAllIndexes 'BNY_Production_NMFP_Data', 'BNYUK_ProductionAR_Port', 30, 0, 1;
exec UTIL_DefragAllIndexes null, null, 30, 0, 1, -1;
*/

CREATE PROCEDURE UTIL_DefragAllIndexes
(@StartingDB   NVARCHAR(100), 
 @EndingDB     NVARCHAR(100), 
 @MaxPct       DECIMAL(6, 2)  = 30, 
 @PreviewOnly  INT           = 1, 
 @ReorgIndexes INT           = 0, 
 @RunID        VARCHAR(60)   = NULL
)
AS

/*IF @EndingDB IS NULL and @StartingDB is null ALL databases are processed
	IF @EndingDB IS NULL and @StartingDB is NOT null only database @StartingDB is processed*/

    BEGIN
        DECLARE @msg NVARCHAR(2000);
        DECLARE @DBNAME NVARCHAR(250);
        IF @RunID IS NULL
            BEGIN
                SET @RunID = '-1';
        END;
        DECLARE @RUNDATE DATETIME= GETDATE();
        DECLARE @Schema NVARCHAR(100), @Table NVARCHAR(100), @Index NVARCHAR(100);
        IF OBJECT_ID('tempdb..#TEMP_CMDS') IS NOT NULL
            BEGIN
                DROP TABLE #TEMP_CMDS;
        END;
        CREATE TABLE #TEMP_CMDS(CMD NVARCHAR(MAX) NOT NULL);
        IF OBJECT_ID('tempdb..#TEMP_DBS2PROCESS') IS NOT NULL
            BEGIN
                DROP TABLE #TEMP_DBS2PROCESS;
        END;
        CREATE TABLE #TEMP_DBS2PROCESS(DBNAME NVARCHAR(100) NOT NULL);
        IF @EndingDB IS NULL
           AND @StartingDB IS NULL
            BEGIN
                INSERT INTO #TEMP_DBS2PROCESS
                       SELECT name
                       FROM sys.databases;
                DELETE FROM #TEMP_DBS2PROCESS
                WHERE DBNAME IN
                (
                    SELECT DB
                    FROM dbo.[DFS_DB2Skip]
                );
        END;
        IF @EndingDB IS NOT NULL
           AND @StartingDB IS NOT NULL
            BEGIN
                INSERT INTO #TEMP_DBS2PROCESS
                       SELECT name
                       FROM sys.databases
                       WHERE name >= @StartingDB
                             AND name <= @EndingDB;
                SELECT *
                FROM #TEMP_DBS2PROCESS;
        END;
        IF @EndingDB IS NOT NULL
           AND @StartingDB IS NULL
            BEGIN
                PRINT 'FATAL ERROR: @StartingDB is null and @EndingDB IS NOT NULL, this is not ALLOWED, aborting';
                RETURN;
        END;
        DELETE FROM #TEMP_DBS2PROCESS
        WHERE DBNAME IN
        (
            SELECT DB
            FROM dbo.[DFS_DB2Skip]
        );
        DECLARE @RowCnt INT;
        SET @RowCnt =
        (
            SELECT COUNT(*) AS #TEMP_DBS2PROCESS
        );
        IF @RowCnt > 0
            BEGIN

                /* DO NOT PROCESS DATABASES CURRENTLY AWAITING PROCESSING*/

                DELETE FROM #TEMP_DBS2PROCESS
                WHERE DBNAME IN
                (
                    SELECT DISTINCT 
                           [DBName]
                    FROM [dbo].[DFS_IndexFragHist]
                    WHERE [IndexProcessed] = 0
                );
                DELETE FROM #TEMP_DBS2PROCESS
                WHERE DBNAME IN
                (
                    SELECT DB
                    FROM dbo.[DFS_DB2Skip]
                );
        END;
        DECLARE @tempstmt NVARCHAR(2000);
        DECLARE xcursor CURSOR
        FOR SELECT DBNAME
            FROM #TEMP_DBS2PROCESS;
        DECLARE @stmt NVARCHAR(2000);
        OPEN xcursor;
        FETCH NEXT FROM xcursor INTO @dbname;
        WHILE @@FETCH_STATUS = 0
            BEGIN
                SET @msg = 'PROCESSING DB: ' + @dbname;
                EXEC sp_printimmediate 
                     @msg;
                SET @msg = 'ReorgIndexes: ' + CAST(@ReorgIndexes AS NVARCHAR(10));
                EXEC sp_printimmediate 
                     @msg;
                SET @stmt = 'INSERT INTO dbo.[DFS_IndexFragProgress] ';
                SET @stmt = @stmt + ' (';
                SET @stmt = @stmt + ' [DBNAME] ';
                SET @stmt = @stmt + ' ,[StartTime] ';
                SET @stmt = @stmt + ' ,[EndTime] ';
                SET @stmt = @stmt + ' ,[RunID]) ';
                SET @stmt = @stmt + ' VALUES ';
                SET @stmt = @stmt + ' (';
                SET @stmt = @stmt + ' ''' + @dbname + '''';
                SET @stmt = @stmt + ' ,getdate() ';
                SET @stmt = @stmt + ' ,null';
                SET @stmt = @stmt + ' ,''' + @RunID + ''');  ';
                SET @stmt = @stmt + 'INSERT INTO dbo.DFS_IndexFragHist ' + CHAR(10) + 'SELECT DB_NAME() AS DBName,
				dbschemas.[name] AS ''Schema'', 
				dbtables.[name] AS ''Table'', 
				dbindexes.[name] AS ''Index'', 
				indexstats.alloc_unit_type_desc,
				0, 
				CAST(indexstats.avg_fragmentation_in_percent AS DECIMAL(6, 2)) AS AvgPctFrag, 
				indexstats.page_count, getdate(), ''' + @RunID + ''',0
				FROM sys.dm_db_index_physical_stats(DB_ID(), NULL, NULL, NULL, NULL) AS indexstats
				INNER JOIN sys.tables dbtables ON dbtables.[object_id] = indexstats.[object_id]
				INNER JOIN sys.schemas dbschemas ON dbtables.[schema_id] = dbschemas.[schema_id]
				INNER JOIN sys.indexes AS dbindexes ON dbindexes.[object_id] = indexstats.[object_id]
												AND indexstats.index_id = dbindexes.index_id
				WHERE indexstats.database_id = DB_ID()
				AND indexstats.avg_fragmentation_in_percent >= ' + CAST(@MaxPct AS VARCHAR(50)) + '
				ORDER BY indexstats.avg_fragmentation_in_percent DESC; ';
                SET @stmt = @stmt + 'update dbo.[DFS_IndexFragProgress] ';
                SET @stmt = @stmt + '  set EndTime = getdate() where EndTime is null';
                SET @stmt = RTRIM(@stmt);
                IF @PreviewOnly = 0
                    BEGIN
                        SET @stmt = 'USE ' + @dbname + ';' + @stmt;
                        INSERT INTO #TEMP_CMDS ( cmd ) 
                        VALUES
                        (
                               @stmt
                        );
                END;
                IF @PreviewOnly = 1
                    BEGIN
                        INSERT INTO #TEMP_CMDS ( cmd ) 
                    VALUES
                        (
                           'USE ' + @dbname + ' ; '
                        );
                        INSERT INTO #TEMP_CMDS ( cmd ) 
                        VALUES
                        (
                               @stmt
                        );
                        INSERT INTO #TEMP_CMDS ( cmd ) 
                        VALUES
                        (
                               'GO'
                        );
                END;
                FETCH NEXT FROM xcursor INTO @dbname;
            END;
        CLOSE xcursor;
        DEALLOCATE xcursor;
        DECLARE @ii INT= 0;
        DECLARE @ix INT= 0;
        DECLARE @using NVARCHAR(100);
        DECLARE @CntTot INT=
        (
            SELECT COUNT(*)
            FROM #TEMP_CMDS
        );
        DECLARE xcmd CURSOR
        FOR SELECT CMD
            FROM #TEMP_CMDS;
        OPEN xcmd;
        FETCH NEXT FROM xcmd INTO @stmt;
        WHILE @@FETCH_STATUS = 0
            BEGIN
                SET @ii = @ii + 1;
                SET @stmt = LTRIM(@stmt);
                SET @stmt = RTRIM(@stmt);
                SET @ix = CHARINDEX(';', @stmt);
                SET @using = SUBSTRING(@stmt, 1, @ix);
                SET @msg = 'ANALYZING #' + CAST(@ii AS VARCHAR(10)) + ' of ' + CAST(@CntTot AS VARCHAR(10)) + ' : ' + @using;
                EXEC sp_printimmediate 
                     @msg;
                IF @PreviewOnly = 1
                    BEGIN
                        PRINT @stmt;
                END;
                    ELSE
                    BEGIN
                        BEGIN TRY
                            EXECUTE sp_executesql 
                                    @stmt;
                END TRY
                        BEGIN CATCH
                            SET @msg = '-- **************************************';
                            EXEC sp_printimmediate 
                                 @msg;
                            SET @msg = 'ERR MSG @1: ' +
                            (
                                SELECT ERROR_MESSAGE()
                            );
                            EXEC sp_printimmediate 
                                 @msg;
                            SET @msg = 'ERROR DB: ' + @dbname;
                            EXEC sp_printimmediate 
                                 @msg;
                            SET @msg = 'ERROR: ' + @stmt;
                            EXEC sp_printimmediate 
                                 @msg;
                            PRINT '***********************************************';
                END CATCH;
                END;
                FETCH NEXT FROM xcmd INTO @stmt;
            END;
        CLOSE xcmd;
        DEALLOCATE xcmd;
        DELETE FROM dbo.DFS_IndexFragHist
        WHERE DBName IN
        (
            SELECT name
            FROM sys.databases
            WHERE [state] != 0
        )
              AND IndexProcessed = 0;
        IF @PreviewOnly = 1
            BEGIN
                INSERT INTO #TEMP_CMDS ( cmd ) 
            VALUES
                (
                   'SELECT * FROM dbo.DFS_IndexFragHist where IndexProcessed != 1;'
                );
        END;
        IF @ReorgIndexes = 1
            BEGIN
                EXEC sp_UTIL_ReorgFragmentedIndexes 
                     @PreviewOnly;
        END;
    END;

/****************** PROCESSING FILE *************************************/

GO  
PRINT 'ID# 270'  
print 'D:\dev\SQL\DFINAnalytics\sp_MeasurePerformanceInSP.sql' 
USE [DFS];
GO

/****** Object:  StoredProcedure [dbo].[sp_MeasurePerformanceInSP]    Script Date: 12/31/2018 7:50:02 AM ******/

SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'sp_MeasurePerformanceInSP'
)
    DROP PROCEDURE sp_MeasurePerformanceInSP;
GO
CREATE PROCEDURE [dbo].[sp_MeasurePerformanceInSP]
(@action   VARCHAR(10), 
 @RunID    INT, 
 @UKEY     VARCHAR(50), 
 @ProcName VARCHAR(50) = NULL, 
 @LocID    VARCHAR(50) = NULL
)
AS
    -- DMA, Limited July 26, 2014
    -- Developer:	W. Dale Miller
    -- License MIT Open Source
    BEGIN
        IF(@action = 'start')
            BEGIN
                INSERT INTO [dbo].[PerfMonitor]
                ([RunID], 
                 [ProcName], 
                 [LocID], 
                 [UKEY], 
                 [StartTime], 
                 [EndTime], 
                 [ElapsedTime]
                )
                VALUES
                (@RunID, 
                 @ProcName, 
                 @LocID, 
                 @UKEY, 
                 GETDATE(), 
                 NULL, 
                 NULL
                );
        END;
        IF(@action = 'end')
            BEGIN
                UPDATE [dbo].[PerfMonitor]
                  SET 
                      [EndTime] = GETDATE()
                WHERE UKEY = @UKEY;
                UPDATE [dbo].[PerfMonitor]
                  SET 
                      [ElapsedTime] = DATEDIFF(MILLISECOND, [StartTime], [EndTime])
                WHERE UKEY = @UKEY;
                UPDATE [dbo].[PerfMonitor]
                  SET 
                      ExecutionTime =
                (
                    SELECT CONVERT(CHAR(13), DATEADD(ms, [ElapsedTime], '01/01/00'), 14)
                )
                WHERE UKEY = @UKEY;
        END;
    END;
GO

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

/****************** PROCESSING FILE *************************************/

GO  
PRINT 'ID# 280'  
print 'D:\dev\SQL\DFINAnalytics\sp_UTIL_RebuildAllDbIndexes.sql' 

USE [DFS];
GO
USE master;
GO
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'sp_UTIL_RebuildAllDbIndexes'
)
    DROP PROCEDURE sp_UTIL_RebuildAllDbIndexes;
	GO

/*
use [AW2016]
USE [DFS]
exec sp_UTIL_RebuildAllDbIndexes
*/

CREATE PROCEDURE sp_UTIL_RebuildAllDbIndexes
AS
    BEGIN
        PRINT 'USING: ' + DB_NAME();
		DECLARE @DBName VARCHAR(250);
        DECLARE @tblName VARCHAR(250);
        DECLARE @schemaName VARCHAR(250);
        DECLARE @idxName VARCHAR(250);
        
		DECLARE @Tables TABLE
        (DatabaseName SYSNAME, 
         SchemaName   SYSNAME, 
         TableName    SYSNAME
        );
        INSERT INTO @Tables
        (DatabaseName, 
         SchemaName, 
         TableName
        )
        EXEC sp_msforeachdb 
             'select ''?'', s.name, t.name from [?].sys.tables t inner join [?].sys.schemas s on t.schema_id = s.schema_id';
        
		--SELECT * FROM @Tables where DatabaseName not in ('msdb','tempdb','DBA','model', 'master', 'ReportServer', 'ReportServerTempDB') ORDER BY 1, 2, 3;

		delete from @Tables where DatabaseName in ('msdb','tempdb','DBA','model', 'master', 'ReportServer', 'ReportServerTempDB')

        --SELECT 'ALTER INDEX ALL ON ' + TABLE_SCHEMA + '.' + TABLE_NAME + ' rebuild;' AS cmd
        --INTO #CMDS
        
		DECLARE tbl CURSOR
        FOR SELECT DatabaseName, SchemaName, TableName
            FROM @Tables where DatabaseName not in ('msdb','tempdb','DBA','model');
        OPEN tbl;
        
		DECLARE @msg NVARCHAR(1000);
        DECLARE @stmt NVARCHAR(1000);
        FETCH NEXT FROM tbl INTO @DBName,@schemaName, @tblName ;
        WHILE @@FETCH_STATUS = 0
            BEGIN
				set @stmt = 'ALTER INDEX ALL ON ' +@DBName+'.' + @schemaName + '.' + @tblName + ' rebuild;' 
                --SET @msg = 'Processing: ' + DB_NAME() + '.' + @schemaName + '.' + @tblname;
                --EXEC sp_printimmediate @msg;
                EXEC sp_printimmediate @stmt;
                BEGIN TRY
                    EXEC sp_executesql 
                         @stmt;
                END TRY
                BEGIN CATCH
                    SET @msg = 'ERROR Processing: ' + @stmt;
                    EXEC sp_printimmediate 
                         @msg;
                END CATCH;
                FETCH NEXT FROM tbl INTO @DBName,@schemaName, @tblName ;
            END;
        CLOSE tbl;
        DEALLOCATE tbl;
    END;

/****************** PROCESSING FILE *************************************/

GO  
PRINT 'ID# 281'  
print 'D:\dev\SQL\DFINAnalytics\DFS_IO_BoundQry2000_ProcessTable.sql' 

USE DFINAnalyticsFINAnalyticsFINAnalyticsFS
go

if not exists (select 1 from sys.tables where name = 'DFS_IO_BoundQry2000')
begin
CREATE TABLE [dbo].[DFS_IO_BoundQry2000](
	[SVRName] [nvarchar](128) NULL,
	[DBName] [varchar](6) NOT NULL,
	[text] [nvarchar](max) NULL,
	[query_plan] [xml] NULL,
	[sql_handle] [varbinary](64) NOT NULL,
	[statement_start_offset] [int] NOT NULL,
	[statement_end_offset] [int] NOT NULL,
	[plan_generation_num] [bigint] NULL,
	[plan_handle] [varbinary](64) NOT NULL,
	[creation_time] [datetime] NULL,
	[last_execution_time] [datetime] NULL,
	[execution_count] [bigint] NOT NULL,
	[total_worker_time] [bigint] NOT NULL,
	[last_worker_time] [bigint] NOT NULL,
	[min_worker_time] [bigint] NOT NULL,
	[max_worker_time] [bigint] NOT NULL,
	[total_physical_reads] [bigint] NOT NULL,
	[last_physical_reads] [bigint] NOT NULL,
	[min_physical_reads] [bigint] NOT NULL,
	[max_physical_reads] [bigint] NOT NULL,
	[total_logical_writes] [bigint] NOT NULL,
	[last_logical_writes] [bigint] NOT NULL,
	[min_logical_writes] [bigint] NOT NULL,
	[max_logical_writes] [bigint] NOT NULL,
	[total_logical_reads] [bigint] NOT NULL,
	[last_logical_reads] [bigint] NOT NULL,
	[min_logical_reads] [bigint] NOT NULL,
	[max_logical_reads] [bigint] NOT NULL,
	[total_clr_time] [bigint] NOT NULL,
	[last_clr_time] [bigint] NOT NULL,
	[min_clr_time] [bigint] NOT NULL,
	[max_clr_time] [bigint] NOT NULL,
	[total_elapsed_time] [bigint] NOT NULL,
	[last_elapsed_time] [bigint] NOT NULL,
	[min_elapsed_time] [bigint] NOT NULL,
	[max_elapsed_time] [bigint] NOT NULL,
	[query_hash] [binary](8) NULL,
	[query_plan_hash] [binary](8) NULL,
	[total_rows] [bigint] NULL,
	[last_rows] [bigint] NULL,
	[min_rows] [bigint] NULL,
	[max_rows] [bigint] NULL,
	[statement_sql_handle] [varbinary](64) NULL,
	[statement_context_id] [bigint] NULL,
	[total_dop] [bigint] NULL,
	[last_dop] [bigint] NULL,
	[min_dop] [bigint] NULL,
	[max_dop] [bigint] NULL,
	[total_grant_kb] [bigint] NULL,
	[last_grant_kb] [bigint] NULL,
	[min_grant_kb] [bigint] NULL,
	[max_grant_kb] [bigint] NULL,
	[total_used_grant_kb] [bigint] NULL,
	[last_used_grant_kb] [bigint] NULL,
	[min_used_grant_kb] [bigint] NULL,
	[max_used_grant_kb] [bigint] NULL,
	[total_ideal_grant_kb] [bigint] NULL,
	[last_ideal_grant_kb] [bigint] NULL,
	[min_ideal_grant_kb] [bigint] NULL,
	[max_ideal_grant_kb] [bigint] NULL,
	[total_reserved_threads] [bigint] NULL,
	[last_reserved_threads] [bigint] NULL,
	[min_reserved_threads] [bigint] NULL,
	[max_reserved_threads] [bigint] NULL,
	[total_used_threads] [bigint] NULL,
	[last_used_threads] [bigint] NULL,
	[min_used_threads] [bigint] NULL,
	[max_used_threads] [bigint] NULL,
	[RunDate] [datetime] NOT NULL,
	[SSVER] [nvarchar](300) NULL,
	[RunID] [int] NOT NULL,
	[UID] [uniqueidentifier] NOT NULL,
	[Processed] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

ALTER TABLE [dbo].[DFS_IO_BoundQry2000] ADD  DEFAULT (newid()) FOR [UID]

ALTER TABLE [dbo].[DFS_IO_BoundQry2000] ADD  DEFAULT ((0)) FOR [Processed]

End
go
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'DFS_IO_BoundQry2000_ProcessTable'
)
    DROP PROCEDURE DFS_IO_BoundQry2000_ProcessTable;
GO
/*
exec DFS_IO_BoundQry2000_ProcessTable
*/
CREATE PROCEDURE DFS_IO_BoundQry2000_ProcessTable
AS
    BEGIN
        DECLARE @query_hash BINARY(8);
        DECLARE @query_plan_hash BINARY(8);
        DECLARE @UID UNIQUEIDENTIFIER;
        DECLARE @cnt AS INT;
        DECLARE @i AS INT= 0;
        DECLARE @SQL AS NVARCHAR(MAX);
        DECLARE @plan AS XML;
        DECLARE db_cursor CURSOR
        FOR SELECT DISTINCT 
                   B.[query_hash], B.[query_plan_hash], MAX(uid) AS [UID], COUNT(*) AS cnt
            FROM
                 [dbo].[DFS_QryPlanBridge] AS A
                 JOIN [dbo].[DFS_IO_BoundQry2000] AS B
                      ON B.[query_hash] = A.[query_hash]
                         AND B.[query_plan_hash] = A.[query_plan_hash]
            WHERE B.processed = 0
            GROUP BY B.[query_hash], B.[query_plan_hash];
        OPEN db_cursor;
        FETCH NEXT FROM db_cursor INTO @query_hash, @query_plan_hash, @UID, @cnt;
        WHILE @@FETCH_STATUS = 0
            BEGIN
                SET @i = @i + 1;
                PRINT 'I: ' + CAST(@i AS NVARCHAR(15));
                SET @SQL =
                (
                    SELECT [text]
                    FROM [dbo].[DFS_IO_BoundQry2000]
                    WHERE [UID] = @uid
                );
                SET @plan =
                (
                    SELECT [query_plan]
                    FROM [dbo].[DFS_IO_BoundQry2000]
                    WHERE [UID] = @uid
                );
                SET @cnt =
                (
                    SELECT COUNT(*)
                    FROM [dbo].[DFS_QryPlanBridge]
                    WHERE [query_hash] = @query_hash
                          AND [query_plan_hash] = @query_plan_hash
                );
                IF(@cnt = 0)
                    BEGIN
                        INSERT INTO [dbo].[DFS_QryPlanBridge] ([query_hash], [query_plan_hash], [PerfType], [TblType], [CreateDate], [LastUpdate], NbrHits) 
                    VALUES
                        (
                           @query_hash, 
                           @query_plan_hash, 
                           'C', 
                           '2000', 
                           GETDATE(), 
                           GETDATE(), 
                           1
                        );
                END;
                SET @cnt =
                (
                    SELECT COUNT(*)
                    FROM [dbo].[DFS_QrysPlans]
                    WHERE [query_hash] = @query_hash
                          AND [query_plan_hash] = @query_plan_hash
                );
                IF(@cnt = 0)
                    BEGIN
                        INSERT INTO [dbo].[DFS_QrysPlans] ([query_hash], [query_plan_hash], [UID], [PerfType], [text], [query_plan], [CreateDate]) 
                    VALUES
                        (
                           @query_hash, 
                           @query_plan_hash, 
                           @UID, 
                           'C', 
                           @SQL, 
                           @plan, 
                           GETDATE()
                        );
                END;
                UPDATE [dbo].[DFS_IO_BoundQry2000]
                  SET Processed = 1
                WHERE [query_hash] = @query_hash
                      AND [query_plan_hash] = @query_plan_hash;
                FETCH NEXT FROM db_cursor INTO @query_hash, @query_plan_hash, @UID, @cnt;
            END;
        CLOSE db_cursor;
        DEALLOCATE db_cursor;
        UPDATE [dbo].[DFS_IO_BoundQry2000]
          SET Processed = 1
        WHERE [UID] IN
        (
            SELECT B.[UID]
            FROM
                 [dbo].[DFS_QryPlanBridge] AS A
                 JOIN [dbo].[DFS_IO_BoundQry2000] AS B
                      ON B.[query_hash] = A.[query_hash]
                         AND B.[query_plan_hash] = A.[query_plan_hash]
            WHERE B.processed = 0
        );
    END;

/****************** PROCESSING FILE *************************************/

GO  
PRINT 'ID# 282'  
print 'D:\dev\SQL\DFINAnalytics\DFS_CPU_BoundQry2000_ProcessTable.sql' 
USE [DFS];
GO
IF NOT EXISTS
(
    SELECT 1
    FROM sys.tables
    WHERE name = 'DFS_CPU_BoundQry2000'
)
    BEGIN
        CREATE TABLE [dbo].[DFS_CPU_BoundQry2000]
        ([SVRName]                [NVARCHAR](128) NULL, 
         [DBName]                 [NVARCHAR](128) NULL, 
         [text]                   [NVARCHAR](MAX) NULL, 
         [query_plan]             [XML] NULL, 
         [sql_handle]             [VARBINARY](64) NOT NULL, 
         [statement_start_offset] [INT] NOT NULL, 
         [statement_end_offset]   [INT] NOT NULL, 
         [plan_generation_num]    [BIGINT] NULL, 
         [plan_handle]            [VARBINARY](64) NOT NULL, 
         [creation_time]          [DATETIME] NULL, 
         [last_execution_time]    [DATETIME] NULL, 
         [execution_count]        [BIGINT] NOT NULL, 
         [total_worker_time]      [BIGINT] NOT NULL, 
         [last_worker_time]       [BIGINT] NOT NULL, 
         [min_worker_time]        [BIGINT] NOT NULL, 
         [max_worker_time]        [BIGINT] NOT NULL, 
         [total_physical_reads]   [BIGINT] NOT NULL, 
         [last_physical_reads]    [BIGINT] NOT NULL, 
         [min_physical_reads]     [BIGINT] NOT NULL, 
         [max_physical_reads]     [BIGINT] NOT NULL, 
         [total_logical_writes]   [BIGINT] NOT NULL, 
         [last_logical_writes]    [BIGINT] NOT NULL, 
         [min_logical_writes]     [BIGINT] NOT NULL, 
         [max_logical_writes]     [BIGINT] NOT NULL, 
         [total_logical_reads]    [BIGINT] NOT NULL, 
         [last_logical_reads]     [BIGINT] NOT NULL, 
         [min_logical_reads]      [BIGINT] NOT NULL, 
         [max_logical_reads]      [BIGINT] NOT NULL, 
         [total_clr_time]         [BIGINT] NOT NULL, 
         [last_clr_time]          [BIGINT] NOT NULL, 
         [min_clr_time]           [BIGINT] NOT NULL, 
         [max_clr_time]           [BIGINT] NOT NULL, 
         [total_elapsed_time]     [BIGINT] NOT NULL, 
         [last_elapsed_time]      [BIGINT] NOT NULL, 
         [min_elapsed_time]       [BIGINT] NOT NULL, 
         [max_elapsed_time]       [BIGINT] NOT NULL, 
         [query_hash]             [BINARY](8) NULL, 
         [query_plan_hash]        [BINARY](8) NULL, 
         [total_rows]             [BIGINT] NULL, 
         [last_rows]              [BIGINT] NULL, 
         [min_rows]               [BIGINT] NULL, 
         [max_rows]               [BIGINT] NULL, 
         [statement_sql_handle]   [VARBINARY](64) NULL, 
         [statement_context_id]   [BIGINT] NULL, 
         [total_dop]              [BIGINT] NULL, 
         [last_dop]               [BIGINT] NULL, 
         [min_dop]                [BIGINT] NULL, 
         [max_dop]                [BIGINT] NULL, 
         [total_grant_kb]         [BIGINT] NULL, 
         [last_grant_kb]          [BIGINT] NULL, 
         [min_grant_kb]           [BIGINT] NULL, 
         [max_grant_kb]           [BIGINT] NULL, 
         [total_used_grant_kb]    [BIGINT] NULL, 
         [last_used_grant_kb]     [BIGINT] NULL, 
         [min_used_grant_kb]      [BIGINT] NULL, 
         [max_used_grant_kb]      [BIGINT] NULL, 
         [total_ideal_grant_kb]   [BIGINT] NULL, 
         [last_ideal_grant_kb]    [BIGINT] NULL, 
         [min_ideal_grant_kb]     [BIGINT] NULL, 
         [max_ideal_grant_kb]     [BIGINT] NULL, 
         [total_reserved_threads] [BIGINT] NULL, 
         [last_reserved_threads]  [BIGINT] NULL, 
         [min_reserved_threads]   [BIGINT] NULL, 
         [max_reserved_threads]   [BIGINT] NULL, 
         [total_used_threads]     [BIGINT] NULL, 
         [last_used_threads]      [BIGINT] NULL, 
         [min_used_threads]       [BIGINT] NULL, 
         [max_used_threads]       [BIGINT] NULL, 
         [RunDate]                [DATETIME] NOT NULL, 
         [SSVer]                  [NVARCHAR](300) NULL, 
         [RunID]                  [INT] NOT NULL, 
         [UID]                    [UNIQUEIDENTIFIER] NOT NULL, 
         [Processed]              [INT] NULL, 
         [RowNbr]                 [INT] IDENTITY(1, 1) NOT NULL
        )
        ON [PRIMARY];
        TEXTIMAGE_ON 
          [PRIMARY];
        ALTER TABLE [dbo].[DFS_CPU_BoundQry2000]
        ADD DEFAULT(NEWID()) FOR [UID];
        ALTER TABLE [dbo].[DFS_CPU_BoundQry2000]
        ADD DEFAULT((0)) FOR [Processed];
END;
GO
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'DFS_CPU_BoundQry2000_ProcessTable'
)
    DROP PROCEDURE DFS_CPU_BoundQry2000_ProcessTable;
GO

/*
exec DFS_CPU_BoundQry2000_ProcessTable
*/

CREATE PROCEDURE DFS_CPU_BoundQry2000_ProcessTable
AS
    BEGIN
        DECLARE @query_hash BINARY(8);
        DECLARE @query_plan_hash BINARY(8);
        DECLARE @UID UNIQUEIDENTIFIER;
        DECLARE @cnt AS INT;
        DECLARE @i AS INT= 0;
        DECLARE @SQL AS NVARCHAR(MAX);
        DECLARE @plan AS XML;
        DECLARE db_cursor CURSOR
        FOR SELECT DISTINCT 
                   B.[query_hash], 
                   B.[query_plan_hash], 
                   MAX(uid) AS [UID], 
                   COUNT(*) AS cnt
            FROM [dbo].[DFS_QryPlanBridge] AS A
                      JOIN [dbo].[DFS_CPU_BoundQry2000] AS B
                      ON B.[query_hash] = A.[query_hash]
                         AND B.[query_plan_hash] = A.[query_plan_hash]
            WHERE B.processed = 0
            GROUP BY B.[query_hash], 
                     B.[query_plan_hash];
        OPEN db_cursor;
        FETCH NEXT FROM db_cursor INTO @query_hash, @query_plan_hash, @UID, @cnt;
        WHILE @@FETCH_STATUS = 0
            BEGIN
                SET @i = @i + 1;
                PRINT 'I: ' + CAST(@i AS NVARCHAR(15));
                SET @SQL =
                (
                    SELECT [text]
                    FROM [dbo].[DFS_CPU_BoundQry2000]
                    WHERE [UID] = @uid
                );
                SET @plan =
                (
                    SELECT [query_plan]
                    FROM [dbo].[DFS_CPU_BoundQry2000]
                    WHERE [UID] = @uid
                );
                SET @cnt =
                (
                    SELECT COUNT(*)
                    FROM [dbo].[DFS_QryPlanBridge]
                    WHERE [query_hash] = @query_hash
                          AND [query_plan_hash] = @query_plan_hash
                );
                IF
                   (@cnt = 0
                   )
                    BEGIN
                        INSERT INTO [dbo].[DFS_QryPlanBridge]
                        ( [query_hash], 
                          [query_plan_hash], 
                          [PerfType], 
                          [TblType], 
                          [CreateDate], 
                          [LastUpdate], 
                          NbrHits
                        ) 
                        VALUES
                        (
                               @query_hash
                             , @query_plan_hash
                             , 'C'
                             , '2000'
                             , GETDATE()
                             , GETDATE()
                             , 1
                        );
                END;
                SET @cnt =
                (
                    SELECT COUNT(*)
                    FROM [dbo].[DFS_QrysPlans]
                    WHERE [query_hash] = @query_hash
                          AND [query_plan_hash] = @query_plan_hash
                );
                IF
                   (@cnt = 0
                   )
                    BEGIN
                        INSERT INTO [dbo].[DFS_QrysPlans]
                        ( [query_hash], 
                          [query_plan_hash], 
                          [UID], 
                          [PerfType], 
                          [text], 
                          [query_plan], 
                          [CreateDate]
                        ) 
                        VALUES
                        (
                               @query_hash
                             , @query_plan_hash
                             , @UID
                             , 'C'
                             , @SQL
                             , @plan
                             , GETDATE()
                        );
                END;
                UPDATE [dbo].[DFS_CPU_BoundQry2000]
                  SET 
                      Processed = 1
                WHERE [query_hash] = @query_hash
                      AND [query_plan_hash] = @query_plan_hash
                      AND processed = 0;
                FETCH NEXT FROM db_cursor INTO @query_hash, @query_plan_hash, @UID, @cnt;
            END;
        CLOSE db_cursor;
        DEALLOCATE db_cursor;
        UPDATE [dbo].[DFS_CPU_BoundQry2000]
          SET 
              Processed = 1
        WHERE [UID] IN
        (
            SELECT B.[UID]
            FROM [dbo].[DFS_QryPlanBridge] AS A
                      JOIN [dbo].[DFS_CPU_BoundQry2000] AS B
                      ON B.[query_hash] = A.[query_hash]
                         AND B.[query_plan_hash] = A.[query_plan_hash]
            WHERE B.processed = 0
        );
    END;

/****************** PROCESSING FILE *************************************/

GO  
PRINT 'ID# 283'  
print 'D:\dev\SQL\DFINAnalytics\DFS_CPU_BoundQry_ProcessTable.sql' 

IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'DFS_CPU_BoundQry'
)
    DROP PROCEDURE DFS_CPU_BoundQry;
GO

/*
exec DFS_CPU_BoundQry
*/

CREATE PROCEDURE DFS_CPU_BoundQry
AS
    BEGIN
        DECLARE @query_hash BINARY(8);
        DECLARE @query_plan_hash BINARY(8);
        DECLARE @UID UNIQUEIDENTIFIER;
        DECLARE @cnt AS INT;
        DECLARE @i AS INT= 0;
        DECLARE @SQL AS NVARCHAR(MAX);
        DECLARE @plan AS XML;
        DECLARE db_cursor CURSOR
        FOR SELECT DISTINCT 
                   B.[query_hash], 
                   B.[query_plan_hash], 
                   MAX(uid) AS [UID], 
                   COUNT(*) AS cnt
            FROM [dbo].[DFS_QryPlanBridge] AS A
                 JOIN [dbo].[DFS_CPU_BoundQry] AS B ON B.[query_hash] = A.[query_hash]
                                                       AND B.[query_plan_hash] = A.[query_plan_hash]
            WHERE B.processed = 0
            GROUP BY B.[query_hash], 
                     B.[query_plan_hash];
        OPEN db_cursor;
        FETCH NEXT FROM db_cursor INTO @query_hash, @query_plan_hash, @UID, @cnt;
        WHILE @@FETCH_STATUS = 0
            BEGIN
                SET @i = @i + 1;
                PRINT 'I: ' + CAST(@i AS NVARCHAR(15));
                SET @SQL =
                (
                    SELECT [text]
                    FROM [dbo].[DFS_CPU_BoundQry]
                    WHERE [UID] = @uid
                );
                SET @plan =
                (
                    SELECT [query_plan]
                    FROM [dbo].[DFS_CPU_BoundQry]
                    WHERE [UID] = @uid
                );
                SET @cnt =
                (
                    SELECT COUNT(*)
                    FROM [dbo].[DFS_QryPlanBridge]
                    WHERE [query_hash] = @query_hash
                          AND [query_plan_hash] = @query_plan_hash
                );
                IF(@cnt = 0)
                    BEGIN
                        INSERT INTO [dbo].[DFS_QryPlanBridge]
                        ([query_hash], 
                         [query_plan_hash], 
                         [PerfType], 
                         [TblType], 
                         [CreateDate], 
                         [LastUpdate], 
                         NbrHits
                        )
                        VALUES
                        (@query_hash, 
                         @query_plan_hash, 
                         'C', 
                         '2000', 
                         GETDATE(), 
                         GETDATE(), 
                         1
                        );
                END;
                SET @cnt =
                (
                    SELECT COUNT(*)
                    FROM [dbo].[DFS_QrysPlans]
                    WHERE [query_hash] = @query_hash
                          AND [query_plan_hash] = @query_plan_hash
                );
                IF(@cnt = 0)
                    BEGIN
                        INSERT INTO [dbo].[DFS_QrysPlans]
                        ([query_hash], 
                         [query_plan_hash], 
                         [UID], 
                         [PerfType], 
                         [text], 
                         [query_plan], 
                         [CreateDate]
                        )
                        VALUES
                        (@query_hash, 
                         @query_plan_hash, 
                         @UID, 
                         'C', 
                         @SQL, 
                         @plan, 
                         GETDATE()
                        );
                END;
                UPDATE [dbo].[DFS_CPU_BoundQry]
                  SET 
                      Processed = 1
                WHERE [query_hash] = @query_hash
                      AND [query_plan_hash] = @query_plan_hash
                      AND processed = 0;
                FETCH NEXT FROM db_cursor INTO @query_hash, @query_plan_hash, @UID, @cnt;
            END;
        CLOSE db_cursor;
        DEALLOCATE db_cursor;
        UPDATE [dbo].[DFS_CPU_BoundQry]
          SET 
              Processed = 1
        WHERE [UID] IN
        (
            SELECT B.[UID]
            FROM [dbo].[DFS_QryPlanBridge] AS A
                 JOIN [dbo].[DFS_CPU_BoundQry] AS B ON B.[query_hash] = A.[query_hash]
                                                       AND B.[query_plan_hash] = A.[query_plan_hash]
            WHERE B.processed = 0
        );
    END;

/****************** PROCESSING FILE *************************************/

GO  
PRINT 'ID# 284'  
print 'D:\dev\SQL\DFINAnalytics\DFS_IO_BoundQry_ProcessTable.sql' 

IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'DFS_IO_BoundQry'
)
    DROP PROCEDURE DFS_IO_BoundQry;
GO

/*
exec DFS_IO_BoundQry
*/

CREATE PROCEDURE DFS_IO_BoundQry
AS
    BEGIN
        DECLARE @query_hash BINARY(8);
        DECLARE @query_plan_hash BINARY(8);
        DECLARE @UID UNIQUEIDENTIFIER;
        DECLARE @cnt AS INT;
        DECLARE @i AS INT= 0;
        DECLARE @SQL AS NVARCHAR(MAX);
        DECLARE @plan AS XML;
        DECLARE db_cursor CURSOR
        FOR SELECT DISTINCT 
                   B.[query_hash], B.[query_plan_hash], MAX(uid) AS [UID], COUNT(*) AS cnt
            FROM
                 [dbo].[DFS_QryPlanBridge] AS A
                 JOIN [dbo].[DFS_IO_BoundQry] AS B
                      ON B.[query_hash] = A.[query_hash]
                         AND B.[query_plan_hash] = A.[query_plan_hash]
            WHERE B.processed = 0
            GROUP BY B.[query_hash], B.[query_plan_hash];
        OPEN db_cursor;
        FETCH NEXT FROM db_cursor INTO @query_hash, @query_plan_hash, @UID, @cnt;
        WHILE @@FETCH_STATUS = 0
            BEGIN
                SET @i = @i + 1;
                PRINT 'I: ' + CAST(@i AS NVARCHAR(15));
                SET @SQL =
                (
                    SELECT [text]
                    FROM [dbo].[DFS_IO_BoundQry]
                    WHERE [UID] = @uid
                );
                SET @plan =
                (
                    SELECT [query_plan]
                    FROM [dbo].[DFS_IO_BoundQry]
                    WHERE [UID] = @uid
                );
                SET @cnt =
                (
                    SELECT COUNT(*)
                    FROM [dbo].[DFS_QryPlanBridge]
                    WHERE [query_hash] = @query_hash
                          AND [query_plan_hash] = @query_plan_hash
                );
                IF(@cnt = 0)
                    BEGIN
                        INSERT INTO [dbo].[DFS_QryPlanBridge] ([query_hash], [query_plan_hash], [PerfType], [TblType], [CreateDate], [LastUpdate], NbrHits) 
                    VALUES
                        (
                           @query_hash, 
                           @query_plan_hash, 
                           'C', 
                           '2000', 
                           GETDATE(), 
                           GETDATE(), 
                           1
                        );
                END;
                SET @cnt =
                (
                    SELECT COUNT(*)
                    FROM [dbo].[DFS_QrysPlans]
                    WHERE [query_hash] = @query_hash
                          AND [query_plan_hash] = @query_plan_hash
                );
                IF(@cnt = 0)
                    BEGIN
                        INSERT INTO [dbo].[DFS_QrysPlans] ([query_hash], [query_plan_hash], [UID], [PerfType], [text], [query_plan], [CreateDate]) 
                    VALUES
                        (
                           @query_hash, 
                           @query_plan_hash, 
                           @UID, 
                           'C', 
                           @SQL, 
                           @plan, 
                           GETDATE()
                        );
                END;
                UPDATE [dbo].[DFS_IO_BoundQry]
                  SET Processed = 1
                WHERE [query_hash] = @query_hash
                      AND [query_plan_hash] = @query_plan_hash
                      AND processed = 0;
                FETCH NEXT FROM db_cursor INTO @query_hash, @query_plan_hash, @UID, @cnt;
            END;
        CLOSE db_cursor;
        DEALLOCATE db_cursor;
        UPDATE [dbo].[DFS_IO_BoundQry]
          SET Processed = 1
        WHERE [UID] IN
        (
            SELECT B.[UID]
            FROM
                 [dbo].[DFS_QryPlanBridge] AS A
                 JOIN [dbo].[DFS_IO_BoundQry] AS B
                      ON B.[query_hash] = A.[query_hash]
                         AND B.[query_plan_hash] = A.[query_plan_hash]
            WHERE B.processed = 0
        );
    END;

/****************** PROCESSING FILE *************************************/

GO  
PRINT 'ID# 284'  
print 'D:\dev\SQL\DFINAnalytics\dm_exec_session_wait_stats.sql' 
USE [DFS];
GO

/* 
truncate TABLE [dbo].[DFS_WaitStats]
*/

/*
declare @MaxWaitMS int = 0;
DECLARE @RunID INT= 0;
EXEC @RunID = sp_UTIL_GetSeq;
declare @stmt nvarchar(100) = 'use ?; exec sp_UTIL_DFS_WaitStats '+cast(@RunID as nvarchar(15))+', '+cast(@MaxWaitMS as nvarchar(15))+' ; '
exec sp_msForEachDB @stmt ;
select * from dbo.DFS_WaitStats order by DBName,session_id, wait_type;
*/


/* DROP TABLE [dbo].[DFS_WaitStats]*/

IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.TABLES
    WHERE TABLE_NAME = 'DFS_WaitStats'
          AND TABLE_TYPE = 'BASE TABLE'
)
    BEGIN
        CREATE TABLE [dbo].[DFS_WaitStats]
        (SvrName               NVARCHAR(150) NOT NULL
                                             DEFAULT @@servername, 
         DBName                NVARCHAR(150) NOT NULL
                                             DEFAULT DB_NAME(), 
         [session_id]          [SMALLINT] NOT NULL, 
         [wait_type]           [NVARCHAR](60) NOT NULL, 
         [waiting_tasks_count] [BIGINT] NOT NULL, 
         [wait_time_ms]        [BIGINT] NOT NULL, 
         [max_wait_time_ms]    [BIGINT] NOT NULL, 
         [signal_wait_time_ms] [BIGINT] NOT NULL, 
         RunID                 INT NULL, 
         CreateDate            DATETIME NOT NULL
                                        DEFAULT GETDATE(), 
         [UID]                 UNIQUEIDENTIFIER NOT NULL
                                                DEFAULT NEWID()
        )
        ON [PRIMARY];

		create index pi_DFS_WaitStatsSVR on DFS_WaitStats (SvrName,DBName,[session_id]);
		create index pi_DFS_WaitStatsUID on DFS_WaitStats ([UID]);

END;
GO
USE master;
GO
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'sp_UTIL_DFS_WaitStats'
)
    DROP PROCEDURE sp_UTIL_DFS_WaitStats;
GO
CREATE PROCEDURE sp_UTIL_DFS_WaitStats
(@RunID     INT, 
 @MaxWaitMS BIGINT
)
AS

/*DECLARE @RunID INT= 0;
EXEC @RunID = sp_UTIL_GetSeq;*/

    BEGIN
        INSERT INTO dbo.DFS_WaitStats
               SELECT @@servername AS [SvrName], 
                      DB_NAME() AS [DBName], 
                      WS.[session_id], 
                      WS.[wait_type], 
                      WS.[waiting_tasks_count], 
                      WS.[wait_time_ms], 
                      WS.[max_wait_time_ms], 
                      WS.[signal_wait_time_ms], 
                      @RunID, 
                      GETDATE(), 
                      NEWID()
               FROM sys.dm_exec_session_wait_stats WS
               WHERE WS.wait_time_ms >= @MaxWaitMS;
    END;

/****************** PROCESSING FILE *************************************/

GO  
PRINT 'ID# 290'  
print 'D:\dev\SQL\DFINAnalytics\create_view_SessionStatus.sql' 
USE [DFS];
go
-- drop view view_SessionStatus
-- select top 100 * from sys.dm_exec_connections
-- select * from view_SessionStatus where SPID = 60

if exists (select 1 from INFORMATION_SCHEMA.TABLES where TABLE_NAME = 'view_SessionStatus')
drop VIEW view_SessionStatus;
go
CREATE VIEW view_SessionStatus
AS
     SELECT S.Session_id AS [SPID], 
            S.STATUS, 
			SP.blocked,
			SP.waittime,
			SP.LastWaitType,
			S.cpu_time, 
            S.reads AS SessionReads, 
            S.writes AS SessionWrites, 
            S.total_elapsed_time, 
            C.num_reads AS ConnectionReads, 
            C.num_writes AS ConnectionWrites, 
            U.database_id, 
            U.user_objects_alloc_page_count, 
            U.user_objects_dealloc_page_count, 
            U.internal_objects_alloc_page_count, 
            U.internal_objects_dealloc_page_count, 
            SP.cmd AS CmdState, 
			db_name(SP.dbid) AS DBNAME,
			WT.[definition] AS LastWaitTypeDEF,
            st.[text] AS CmdSQL
     /*,p.[query_plan] */
     FROM   sys.dm_exec_sessions S
     JOIN sys.dm_exec_connections C
                ON C.session_id = S.session_id
     JOIN sys.dm_db_session_space_usage U
                ON U.session_id = S.session_id
     JOIN sys.sysprocesses SP
                ON SP.spid = S.session_id
     CROSS APPLY sys.dm_exec_sql_text(SP.sql_handle) st
	 left outer join [dbo].[DFS_WaitTypes] WT on SP.LastWaitType = WT.typecode
	 /*
	 SELECT TOP 100 * FROM  sys.dm_exec_sessions
	 SELECT TOP 100 * FROM  sys.sysprocesses
	 */
/*CROSS APPLY sys.dm_exec_query_plan(SP.sql_handle) p*/


/****************** PROCESSING FILE *************************************/

GO  
PRINT 'ID# 291'  
print 'D:\dev\SQL\DFINAnalytics\DFS_GetAllTableSizesAndRowCnt.sql' 
USE [DFS];
IF NOT EXISTS
(
    SELECT 1
    FROM sys.tables
    WHERE name = 'DFS_TableSizeAndRowCnt'
)
    BEGIN

        /* drop TABLE [dbo].[DFS_TableSizeAndRowCnt];*/

        CREATE TABLE [dbo].[DFS_TableSizeAndRowCnt]
        (SvrName         NVARCHAR(150) NOT NULL, 
         DBName          NVARCHAR(150) NOT NULL, 
         [TableName]     [SYSNAME] NOT NULL, 
         [SchemaName]    [SYSNAME] NULL, 
         [RowCounts]     [BIGINT] NULL, 
         [TotalSpaceKB]  [BIGINT] NULL, 
         [UsedSpaceKB]   [BIGINT] NULL, 
         [UnusedSpaceKB] [BIGINT] NULL, 
         [UID]           UNIQUEIDENTIFIER NOT NULL
                                          DEFAULT NEWID(), 
         CreateDate      DATETIME DEFAULT GETDATE() NOT NULL
        )
        ON [PRIMARY];
END;
GO
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'DFS_GetAllTableSizesAndRowCnt'
)
    DROP PROCEDURE DFS_GetAllTableSizesAndRowCnt;
GO
-- exec DFS_GetAllTableSizesAndRowCnt
CREATE PROCEDURE DFS_GetAllTableSizesAndRowCnt
AS
    BEGIN
        INSERT INTO [dbo].[DFS_TableSizeAndRowCnt]
        ( SvrName, 
          DBName, 
          [TableName], 
          [SchemaName], 
          [RowCounts], 
          [TotalSpaceKB], 
          [UsedSpaceKB], 
          [UnusedSpaceKB], 
          [UID], 
          CreateDate
        ) 
               SELECT @@servername AS SvrName, 
                      DB_NAME() AS DBName, 
                      t.NAME AS TableName, 
                      s.Name AS SchemaName, 
                      p.rows AS RowCounts, 
                      SUM(a.total_pages) * 8 AS TotalSpaceKB, 
                      SUM(a.used_pages) * 8 AS UsedSpaceKB, 
                      (SUM(a.total_pages) - SUM(a.used_pages)) * 8 AS UnusedSpaceKB, 
                      NEWID() AS [UID], 
                      GETDATE() AS createDate
               FROM sys.tables t
                         INNER JOIN sys.indexes i
                         ON t.OBJECT_ID = i.object_id
                              INNER JOIN sys.partitions p
                         ON i.object_id = p.OBJECT_ID
                            AND i.index_id = p.index_id
                                   INNER JOIN sys.allocation_units a
                         ON p.partition_id = a.container_id
                                        LEFT OUTER JOIN sys.schemas s
                         ON t.schema_id = s.schema_id
               WHERE t.NAME NOT LIKE 'dt%'
                     AND t.is_ms_shipped = 0
                     AND i.OBJECT_ID > 255
               GROUP BY t.Name, 
                        s.Name, 
                        p.Rows
               ORDER BY t.Name;
    END;