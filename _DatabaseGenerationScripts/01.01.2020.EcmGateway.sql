

USE [EcmGateway];
GO
/****** Object:  Schema [ECMUser]    Script Date: 10/30/2019 12:05:18 PM ******/

IF NOT EXISTS
(
  SELECT *
  FROM sys.schemas
  WHERE name=N'ECMUser'
)
BEGIN
EXEC sys.sp_executesql 
     N'CREATE SCHEMA [ECMUser]';
END;
GO
/****** Object:  Table [dbo].[ConnStr]    Script Date: 10/30/2019 12:05:18 PM ******/

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

IF NOT EXISTS
(
  SELECT *
  FROM sys.objects
  WHERE object_id=OBJECT_ID( N'[dbo].[ConnStr]' )
        AND type IN
  (N'U')
)
BEGIN
CREATE TABLE dbo.ConnStr
(
  ConnectID        INT IDENTITY( 1, 1 ) NOT NULL, 
  ConnectionName   NVARCHAR(50) NOT NULL, 
  ConnectionStirng NVARCHAR(4000) NOT NULL, 
  CompanyID        NVARCHAR(100) NOT NULL)
ON [PRIMARY]
END;
GO
/****** Object:  Table [dbo].[Gateway_Attach]    Script Date: 10/30/2019 12:05:18 PM ******/

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

IF NOT EXISTS
(
  SELECT *
  FROM sys.objects
  WHERE object_id=OBJECT_ID( N'[dbo].[Gateway_Attach]' )
        AND type IN
  (N'U')
)
BEGIN
CREATE TABLE dbo.Gateway_Attach
(
  CompanyID         NVARCHAR(100) NULL, 
  RepoID            NVARCHAR(100) NULL, 
  GateWayPW         NVARCHAR(80) NOT NULL, 
  GateUserID        NVARCHAR(80) NOT NULL, 
  GatewaySecureInfo NVARCHAR(2000) NOT NULL, 
  CreateDate        DATETIME NOT NULL, 
  LastUpdate        DATETIME NOT NULL, 
  Enabled           CHAR(1) NOT NULL)
ON [PRIMARY]
END;
GO

SET ANSI_PADDING ON;
GO
/****** Object:  Index [PK_Gateway]    Script Date: 10/30/2019 12:05:18 PM ******/

IF NOT EXISTS
(
  SELECT *
  FROM sys.indexes
  WHERE object_id=OBJECT_ID( N'[dbo].[Gateway_Attach]' )
        AND name=N'PK_Gateway'
)
BEGIN
CREATE UNIQUE CLUSTERED INDEX PK_Gateway
ON dbo.Gateway_Attach
(CompanyID ASC, RepoID ASC) 
  WITH
(PAD_INDEX=OFF, STATISTICS_NORECOMPUTE=OFF, SORT_IN_TEMPDB=OFF, IGNORE_DUP_KEY=OFF, DROP_EXISTING=OFF, ONLINE=OFF, ALLOW_ROW_LOCKS=ON, ALLOW_PAGE_LOCKS=ON)
ON [PRIMARY]
END;
GO
/****** Object:  Table [dbo].[Logs]    Script Date: 10/30/2019 12:05:18 PM ******/

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

IF NOT EXISTS
(
  SELECT *
  FROM sys.objects
  WHERE object_id=OBJECT_ID( N'[dbo].[Logs]' )
        AND type IN
  (N'U')
)
BEGIN
CREATE TABLE dbo.Logs
(
  UID       NVARCHAR(50) NULL, 
  ErrorMsg  NTEXT NULL, 
  EntryDate DATETIME NULL, 
  RowNbr    INT IDENTITY( 1, 1 ) NOT NULL)
ON [PRIMARY]
TEXTIMAGE_ON 
      [PRIMARY];
END;
GO
/****** Object:  Table [dbo].[PgmTrace]    Script Date: 10/30/2019 12:05:18 PM ******/

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

IF NOT EXISTS
(
  SELECT *
  FROM sys.objects
  WHERE object_id=OBJECT_ID( N'[dbo].[PgmTrace]' )
        AND type IN
  (N'U')
)
BEGIN
CREATE TABLE dbo.PgmTrace
(
  StmtID             NVARCHAR(50) NULL, 
  PgmName            NVARCHAR(254) NULL, 
  Stmt               NTEXT NOT NULL, 
  RowID              INT IDENTITY( 1, 1 ) NOT NULL, 
  CreateDate         DATETIME NULL, 
  ConnectiveGuid     NVARCHAR(50) NULL, 
  UserID             NVARCHAR(50) NULL, 
  HiveConnectionName NVARCHAR(50) NULL, 
  HiveActive         BIT NULL, 
  RepoSvrName        NVARCHAR(254) NULL, 
  RowCreationDate    DATETIME NULL, 
  RowLastModDate     DATETIME NULL)
ON [PRIMARY]
TEXTIMAGE_ON 
      [PRIMARY];
END;
GO
/****** Object:  Table [dbo].[User]    Script Date: 10/30/2019 12:05:18 PM ******/

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

IF NOT EXISTS
(
  SELECT *
  FROM sys.objects
  WHERE object_id=OBJECT_ID( N'[dbo].[User]' )
        AND type IN
  (N'U')
)
BEGIN
CREATE TABLE dbo.[User]
(
  UserID       NVARCHAR(100) NOT NULL, 
  UserPassword NVARCHAR(100) NOT NULL, 
  CreateDate   DATETIME NULL)
ON [PRIMARY]
END;
GO

SET ANSI_PADDING ON;
GO
/****** Object:  Index [PI01_PgmTrace]    Script Date: 10/30/2019 12:05:18 PM ******/

IF NOT EXISTS
(
  SELECT *
  FROM sys.indexes
  WHERE object_id=OBJECT_ID( N'[dbo].[PgmTrace]' )
        AND name=N'PI01_PgmTrace'
)
BEGIN
CREATE NONCLUSTERED INDEX PI01_PgmTrace
ON dbo.PgmTrace
(ConnectiveGuid ASC) 
  WITH
(PAD_INDEX=OFF, STATISTICS_NORECOMPUTE=OFF, SORT_IN_TEMPDB=OFF, DROP_EXISTING=OFF, ONLINE=OFF, ALLOW_ROW_LOCKS=ON, ALLOW_PAGE_LOCKS=ON, FILLFACTOR=80)
ON [PRIMARY]
END;
GO

IF NOT EXISTS
(
  SELECT *
  FROM sys.objects
  WHERE object_id=OBJECT_ID( N'[dbo].[DF_Gateway_Attach_CreateDate]' )
        AND type='D'
)
BEGIN
ALTER TABLE dbo.Gateway_Attach
ADD CONSTRAINT DF_Gateway_Attach_CreateDate DEFAULT GETDATE( ) FOR CreateDate;
END;
GO

IF NOT EXISTS
(
  SELECT *
  FROM sys.objects
  WHERE object_id=OBJECT_ID( N'[dbo].[DF_Gateway_Attach_LastUpdate]' )
        AND type='D'
)
BEGIN
ALTER TABLE dbo.Gateway_Attach
ADD CONSTRAINT DF_Gateway_Attach_LastUpdate DEFAULT GETDATE( ) FOR LastUpdate;
END;
GO

IF NOT EXISTS
(
  SELECT *
  FROM sys.objects
  WHERE object_id=OBJECT_ID( N'[dbo].[DF_Gateway_Attach_Enabled]' )
        AND type='D'
)
BEGIN
ALTER TABLE dbo.Gateway_Attach
ADD CONSTRAINT DF_Gateway_Attach_Enabled DEFAULT 'Y' FOR Enabled;
END;
GO

IF NOT EXISTS
(
  SELECT *
  FROM sys.objects
  WHERE object_id=OBJECT_ID( N'[dbo].[DF_Logs_EntryDate]' )
        AND type='D'
)
BEGIN
ALTER TABLE dbo.Logs
ADD CONSTRAINT DF_Logs_EntryDate DEFAULT GETDATE( ) FOR EntryDate;
END;
GO

IF NOT EXISTS
(
  SELECT *
  FROM sys.objects
  WHERE object_id=OBJECT_ID( N'[dbo].[DF_PgmTrace_CreateDate]' )
        AND type='D'
)
BEGIN
ALTER TABLE dbo.PgmTrace
ADD CONSTRAINT DF_PgmTrace_CreateDate DEFAULT GETDATE( ) FOR CreateDate;
END;
GO

IF NOT EXISTS
(
  SELECT *
  FROM sys.objects
  WHERE object_id=OBJECT_ID( N'[dbo].[DF_User_CreateDate]' )
        AND type='D'
)
BEGIN
ALTER TABLE dbo.[User]
ADD CONSTRAINT DF_User_CreateDate DEFAULT GETDATE( ) FOR CreateDate;
END;
GO
/****** Object:  StoredProcedure [dbo].[spIndexUsage]    Script Date: 10/30/2019 12:05:18 PM ******/

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

IF NOT EXISTS
(
  SELECT *
  FROM sys.objects
  WHERE object_id=OBJECT_ID( N'[dbo].[spIndexUsage]' )
        AND type IN
  (N'P', 
   N'PC')
)
BEGIN
EXEC dbo.sp_executesql 
     @statement=N'CREATE PROCEDURE [dbo].[spIndexUsage] AS';
END;
GO
/**
*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=
IndexUsage
By W. Dale Miller

Reports index stats, index size+rows, member seek + include columns as two comma separated output columns, and index usage 
stats for one or more tables and/or schemas.  Flexible parameterized sorting.
Has all the output of Util_ListIndexes plus the usage stats.

Required Input Parameters
	none

Optional
	@SchemaName sysname=''		Filters schemas.  Can use LIKE wildcards.  All schemas if blank.  Accepts LIKE 

Wildcards.
	@TableName sysname=''		Filters tables.  Can use LIKE wildcards.  All tables if blank.  Accepts LIKE 

Wildcards.
	@Sort Tinyint=5				Determines what to sort the results by:
									Value	Sort Columns
									1		Score DESC, user_seeks DESC, 

user_scans DESC
									2		Score ASC, user_seeks ASC, 

user_scans ASC
									3		SchemaName ASC, TableName ASC, 

IndexName ASC
									4		SchemaName ASC, TableName ASC, 

Score DESC
									5		SchemaName ASC, TableName ASC, 

Score ASC
	@Delimiter VarChar(1)=','	Delimiter for the horizontal delimited seek and include column listings.

Usage:
	EXECUTE Util_IndexUsage 'dbo', 'order%', 5, '|'

Copyright:
	Licensed under the L-GPL - a weak copyleft license - you are permitted to use this as a component of a proprietary 

database and call this from proprietary software.
	Copyleft lets you do anything you want except plagarize, conceal the source, proprietarize modifications, or 

prohibit copying & re-distribution of this script/proc.

	This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU Lesser General Public License as
    published by the Free Software Foundation, either version 3 of the
    License, or (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Lesser General Public License for more details.

    see <http://www.fsf.org/licensing/licenses/lgpl.html> for the license text.

*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=
**/

ALTER PROCEDURE dbo.spIndexUsage 
  @SchemaName SYSNAME   ='', 
  @TableName  SYSNAME   ='', 
  @Sort       TINYINT   =5, 
  @Delimiter  VARCHAR(1)=','
AS
BEGIN
SELECT sys.schemas.schema_id, 
       sys.schemas.name
AS schema_name, 
       sys.objects.object_id, 
       sys.objects.name
AS object_name, 
       sys.indexes.index_id, 
       ISNULL( sys.indexes.name, '---' )
AS index_name, 
       partitions.Rows, 
       partitions.SizeMB, 
       INDEXPROPERTY( sys.objects.object_id, sys.indexes.name, 'IndexDepth' )
AS IndexDepth, 
       sys.indexes.type, 
       sys.indexes.type_desc, 
       sys.indexes.fill_factor, 
       sys.indexes.is_unique, 
       sys.indexes.is_primary_key, 
       sys.indexes.is_unique_constraint, 
       ISNULL( Index_Columns.index_columns_key, '---' )
AS index_columns_key, 
       ISNULL( Index_Columns.index_columns_include, '---' )
AS index_columns_include, 
       ISNULL( sys.dm_db_index_usage_stats.user_seeks, 0 )
AS user_seeks, 
       ISNULL( sys.dm_db_index_usage_stats.user_scans, 0 )
AS user_scans, 
       ISNULL( sys.dm_db_index_usage_stats.user_lookups, 0 )
AS user_lookups, 
       ISNULL( sys.dm_db_index_usage_stats.user_updates, 0 )
AS user_updates, 
       sys.dm_db_index_usage_stats.last_user_seek, 
       sys.dm_db_index_usage_stats.last_user_scan, 
       sys.dm_db_index_usage_stats.last_user_lookup, 
       sys.dm_db_index_usage_stats.last_user_update, 
       ISNULL( sys.dm_db_index_usage_stats.system_seeks, 0 )
AS system_seeks, 
       ISNULL( sys.dm_db_index_usage_stats.system_scans, 0 )
AS system_scans, 
       ISNULL( sys.dm_db_index_usage_stats.system_lookups, 0 )
AS system_lookups, 
       ISNULL( sys.dm_db_index_usage_stats.system_updates, 0 )
AS system_updates, 
       sys.dm_db_index_usage_stats.last_system_seek, 
       sys.dm_db_index_usage_stats.last_system_scan, 
       sys.dm_db_index_usage_stats.last_system_lookup, 
       sys.dm_db_index_usage_stats.last_system_update, 
       ((CONVERT( NUMERIC(19, 6), ISNULL( sys.dm_db_index_usage_stats.user_seeks, 0 ) )+CONVERT( NUMERIC(19, 6), ISNULL( sys.dm_db_index_usage_stats.system_seeks, 0 ) ))*10+CASE
                                                                                                                                                                               WHEN sys.indexes.type=2
                                                                                                                                                                               THEN(CONVERT( NUMERIC(19, 6), ISNULL( sys.dm_db_index_usage_stats.user_scans, 0 ) )+CONVERT( NUMERIC(19, 6), ISNULL( sys.dm_db_index_usage_stats.system_scans, 0 ) ))*1
                                                                                                                                                                               ELSE 0
                                                                                                                                                                             END+1)/CASE
                                                                                                                                                                                      WHEN sys.indexes.type=2
                                                                                                                                                                                      THEN CONVERT( NUMERIC(19, 6), ISNULL( sys.dm_db_index_usage_stats.user_updates, 0 ) )+CONVERT( NUMERIC(19, 6), ISNULL( sys.dm_db_index_usage_stats.system_updates, 0 ) )+1
                                                                                                                                                                                      ELSE 1
                                                                                                                                                                                    END
AS Score
FROM sys.objects
JOIN
sys.schemas
ON sys.objects.schema_id=sys.schemas.schema_id
    JOIN
    sys.indexes
    ON sys.indexes.object_id=sys.objects.object_id
        JOIN
(
  SELECT object_id, 
         index_id, 
         SUM( row_count )
  AS Rows, 
         CONVERT( NUMERIC(19, 3), CONVERT( NUMERIC(19, 3), SUM( in_row_reserved_page_count+lob_reserved_page_count+row_overflow_reserved_page_count ) )/CONVERT( NUMERIC(19, 3), 128 ) )
  AS SizeMB
  FROM sys.dm_db_partition_stats
  GROUP BY object_id, 
           index_id
)
AS partitions
        ON sys.indexes.object_id=partitions.object_id
           AND sys.indexes.index_id=partitions.index_id
            CROSS APPLY
(
  SELECT LEFT( index_columns_key, LEN( index_columns_key )-1 )
  AS index_columns_key, 
         LEFT( index_columns_include, LEN( index_columns_include )-1 )
  AS index_columns_include
  FROM
  (
    SELECT
    (
      SELECT sys.columns.name+@Delimiter+' '
      FROM sys.index_columns
      JOIN
      sys.columns
      ON sys.index_columns.column_id=sys.columns.column_id
         AND sys.index_columns.object_id=sys.columns.object_id
      WHERE sys.index_columns.is_included_column=0
            AND sys.indexes.object_id=sys.index_columns.object_id
            AND sys.indexes.index_id=sys.index_columns.index_id
      ORDER BY key_ordinal FOR XML PATH( '' )
    )
    AS index_columns_key, 
    (
      SELECT sys.columns.name+@Delimiter+' '
      FROM sys.index_columns
      JOIN
      sys.columns
      ON sys.index_columns.column_id=sys.columns.column_id
         AND sys.index_columns.object_id=sys.columns.object_id
      WHERE sys.index_columns.is_included_column=1
            AND sys.indexes.object_id=sys.index_columns.object_id
            AND sys.indexes.index_id=sys.index_columns.index_id
      ORDER BY index_column_id FOR XML PATH( '' )
    )
    AS index_columns_include
  )
  AS Index_Columns
)
AS Index_Columns
                LEFT OUTER JOIN
                sys.dm_db_index_usage_stats
                ON sys.indexes.index_id=sys.dm_db_index_usage_stats.index_id
                   AND sys.indexes.object_id=sys.dm_db_index_usage_stats.object_id
                   AND sys.dm_db_index_usage_stats.database_id=DB_ID( )
WHERE sys.objects.type='u'
      AND sys.schemas.name LIKE CASE
                                  WHEN @SchemaName=''
                                  THEN sys.schemas.name
                                  ELSE @SchemaName
                                END
      AND sys.objects.name LIKE CASE
                                  WHEN @TableName=''
                                  THEN sys.objects.name
                                  ELSE @TableName
                                END
ORDER BY CASE @Sort
           WHEN 1
           THEN(((CONVERT( NUMERIC(19, 6), ISNULL( sys.dm_db_index_usage_stats.user_seeks, 0 ) )+CONVERT( NUMERIC(19, 6), ISNULL( sys.dm_db_index_usage_stats.system_seeks, 0 ) ))*10+CASE
                                                                                                                                                                                        WHEN sys.indexes.type=2
                                                                                                                                                                                        THEN(CONVERT( NUMERIC(19, 6), ISNULL( sys.dm_db_index_usage_stats.user_scans, 0 ) )+CONVERT( NUMERIC(19, 6), ISNULL( sys.dm_db_index_usage_stats.system_scans, 0 ) ))*1
                                                                                                                                                                                        ELSE 0
                                                                                                                                                                                      END+1)/CASE
                                                                                                                                                                                               WHEN sys.indexes.type=2
                                                                                                                                                                                               THEN CONVERT( NUMERIC(19, 6), ISNULL( sys.dm_db_index_usage_stats.user_updates, 0 ) )+CONVERT( NUMERIC(19, 6), ISNULL( sys.dm_db_index_usage_stats.system_updates, 0 ) )+1
                                                                                                                                                                                               ELSE 1
                                                                                                                                                                                             END)*-1
           WHEN 2
           THEN((CONVERT( NUMERIC(19, 6), ISNULL( sys.dm_db_index_usage_stats.user_seeks, 0 ) )+CONVERT( NUMERIC(19, 6), ISNULL( sys.dm_db_index_usage_stats.system_seeks, 0 ) ))*10+CASE
                                                                                                                                                                                       WHEN sys.indexes.type=2
                                                                                                                                                                                       THEN(CONVERT( NUMERIC(19, 6), ISNULL( sys.dm_db_index_usage_stats.user_scans, 0 ) )+CONVERT( NUMERIC(19, 6), ISNULL( sys.dm_db_index_usage_stats.system_scans, 0 ) ))*1
                                                                                                                                                                                       ELSE 0
                                                                                                                                                                                     END+1)/CASE
                                                                                                                                                                                              WHEN sys.indexes.type=2
                                                                                                                                                                                              THEN CONVERT( NUMERIC(19, 6), ISNULL( sys.dm_db_index_usage_stats.user_updates, 0 ) )+CONVERT( NUMERIC(19, 6), ISNULL( sys.dm_db_index_usage_stats.system_updates, 0 ) )+1
                                                                                                                                                                                              ELSE 1
                                                                                                                                                                                            END
           ELSE NULL
         END,
         CASE @Sort
           WHEN 3
           THEN sys.schemas.name
           WHEN 4
           THEN sys.schemas.name
           WHEN 5
           THEN sys.schemas.name
           ELSE NULL
         END,
         CASE @Sort
           WHEN 1
           THEN CONVERT( VARCHAR(10), sys.dm_db_index_usage_stats.user_seeks*-1 )
           WHEN 2
           THEN CONVERT( VARCHAR(10), sys.dm_db_index_usage_stats.user_seeks )
           ELSE NULL
         END,
         CASE @Sort
           WHEN 3
           THEN sys.objects.name
           WHEN 4
           THEN sys.objects.name
           WHEN 5
           THEN sys.objects.name
           ELSE NULL
         END,
         CASE @Sort
           WHEN 1
           THEN sys.dm_db_index_usage_stats.user_scans*-1
           WHEN 2
           THEN sys.dm_db_index_usage_stats.user_scans
           WHEN 4
           THEN(((CONVERT( NUMERIC(19, 6), ISNULL( sys.dm_db_index_usage_stats.user_seeks, 0 ) )+CONVERT( NUMERIC(19, 6), ISNULL( sys.dm_db_index_usage_stats.system_seeks, 0 ) ))*10+CASE
                                                                                                                                                                                        WHEN sys.indexes.type=2
                                                                                                                                                                                        THEN(CONVERT( NUMERIC(19, 6), ISNULL( sys.dm_db_index_usage_stats.user_scans, 0 ) )+CONVERT( NUMERIC(19, 6), ISNULL( sys.dm_db_index_usage_stats.system_scans, 0 ) ))*1
                                                                                                                                                                                        ELSE 0
                                                                                                                                                                                      END+1)/CASE
                                                                                                                                                                                               WHEN sys.indexes.type=2
                                                                                                                                                                                               THEN CONVERT( NUMERIC(19, 6), ISNULL( sys.dm_db_index_usage_stats.user_updates, 0 ) )+CONVERT( NUMERIC(19, 6), ISNULL( sys.dm_db_index_usage_stats.system_updates, 0 ) )+1
                                                                                                                                                                                               ELSE 1
                                                                                                                                                                                             END)*-1
           WHEN 5
           THEN((CONVERT( NUMERIC(19, 6), ISNULL( sys.dm_db_index_usage_stats.user_seeks, 0 ) )+CONVERT( NUMERIC(19, 6), ISNULL( sys.dm_db_index_usage_stats.system_seeks, 0 ) ))*10+CASE
                                                                                                                                                                                       WHEN sys.indexes.type=2
                                                                                                                                                                                       THEN(CONVERT( NUMERIC(19, 6), ISNULL( sys.dm_db_index_usage_stats.user_scans, 0 ) )+CONVERT( NUMERIC(19, 6), ISNULL( sys.dm_db_index_usage_stats.system_scans, 0 ) ))*1
                                                                                                                                                                                       ELSE 0
                                                                                                                                                                                     END+1)/CASE
                                                                                                                                                                                              WHEN sys.indexes.type=2
                                                                                                                                                                                              THEN CONVERT( NUMERIC(19, 6), ISNULL( sys.dm_db_index_usage_stats.user_updates, 0 ) )+CONVERT( NUMERIC(19, 6), ISNULL( sys.dm_db_index_usage_stats.system_updates, 0 ) )+1
                                                                                                                                                                                              ELSE 1
                                                                                                                                                                                            END
           ELSE NULL
         END,
         CASE @Sort
           WHEN 3
           THEN sys.indexes.name
           ELSE NULL
         END;
END;
GO


