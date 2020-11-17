USE [AP_ProductionAF_Data]
GO

/****** Object:  Table [dbo].[TEMP_IDX_FRAG]    Script Date: 1/9/2019 10:05:03 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
IF OBJECT_ID('tempdb..#TEMP_IDX_FRAG') IS NOT NULL 
	DROP TABLE #TEMP_IDX_FRAG;

CREATE TABLE #TEMP_IDX_FRAG (
	[DBName] [nvarchar](128) NULL,
	[SchemaName] [sysname] NOT NULL,
	[TblName] [nvarchar](128) NULL,
	[IdxName] [sysname] NULL,
	[user_seeks] [bigint] NOT NULL,
	[user_scans] [bigint] NOT NULL,
	[user_lookups] [bigint] NOT NULL,
	[user_updates] [bigint] NOT NULL
) ON [PRIMARY]


declare @DBN nvarchar(100) = '';
set @DBN = DB_NAME();
insert into #TEMP_IDX_FRAG
SELECT
	DB_NAME(ius.database_id) DBName,
	SCH.name as SchemaName,
	OBJECT_NAME(ius.object_id) TblName,
	i.name as IdxName,
	ius.user_seeks,
	ius.user_scans,
	ius.user_lookups,
	ius.user_updates
	--sum (ius.user_seeks + 
	--ius.user_scans + 
	--ius.user_lookups +
	--ius.user_updates) as TotalHits
	FROM sys.dm_db_index_usage_stats ius
	INNER JOIN sys.indexes i
		ON ius.object_id = i.object_id 
		AND ius.index_id = i.index_id
	join sys.tables T 
		on T.object_id = ius.object_id
	join sys.schemas SCH
		on SCH.schema_id = T.schema_id
WHERE
DB_NAME(ius.database_id) = @DBN

select * from #TEMP_IDX_FRAG

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
