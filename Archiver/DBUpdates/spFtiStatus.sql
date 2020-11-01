
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'spFtiStatus'
)
    DROP PROCEDURE spFtiStatus;
GO
/*
exec spFtiStatus
ALTER FULLTEXT CATALOG ftCatalog REBUILD
ALTER FULLTEXT CATALOG ftDataSourceImage REBUILD
ALTER FULLTEXT CATALOG ftEmailCatalog REBUILD
ALTER FULLTEXT CATALOG ftEmailAttachment REBUILD
ALTER FULLTEXT CATALOG ftEmail REBUILD
*/
CREATE PROCEDURE spFtiStatus
AS
    BEGIN
	/*
	Here is the description of the columns of this script result set:

	- db_name – Name of the SQL Server database, unique within an instance of SQL Server
	- is_ft_enabled – The value of 1 indicates that the full-text and semantic indexing is enabled
	- ft_catalog_file_logical_name – Returns the logical file name of the full-text index catalog file
	- ft_catalog_file_physical_name – Returns the phyisical file name of the full-text index catalog file
	- table_name – Returns the name of the table where full-text index exists
	- ft_catalog_logical_index_size_in_mb – Returns the logical size of the full-text catalog in megabytes(MB)
	- is_accent_sensitive – Returns the accent-sensitivity setting for full-text catalog. The value of 1 indicates that full-text catalog is accent sensitive
	- unique_key_count – Returns the number of unique keys in the full-text catalog
	- row_count_in_thousands – Returns the estimated number of rows (in thousands) in all full-text indexes in this full-text catalog
	- is_clustered_index_scan – Indicates whether the population involves a scan on the clustered index
	- range_count – Returns the number of sub-ranges into which this population has been parallelized
	- import_status – Indicates whether the full-text catalog is being imported. The value of 1 indicates that the full-text catalog is being imported
	- current_state_of_fts_catalog – Returns the state of the full-text catalog
	- is_paused – Indicates whether the population of the active full-text catalog has been paused
	- population_status – Returns the status of current population
	- ft_catalog_population_type – Returns the type of full-text catalog population type
	- status_of_population – Returns the status of this population
	- completion_type_description – Returns the description of status of the population
	- queued_population_type_description – Returns description of the population to follow, if any. For example, when CHANGE TRACKING = AUTO and the initial full population is in progress, this column would show “Auto population.”
	- start_time – Returns the time that the population started.
	- last_populated – Returns the time when the last full-text index population completed

	*/
        SELECT DB_NAME(ftsac.[database_id]) AS [db_name], 
               DATABASEPROPERTYEX(DB_NAME(ftsac.[database_id]), 'IsFulltextEnabled') AS [is_ft_enabled], 
               ftsac.[name] AS [catalog_name], 
               mfs.[name] AS [ft_catalog_file_logical_name], 
               mfs.[physical_name] AS [ft_catalog_file_physical_name], 
               OBJECT_NAME(ftsip.[table_id]) AS [table_name], 
               FULLTEXTCATALOGPROPERTY(ftsac.[name], 'IndexSize') AS [ft_catalog_logical_index_size_in_mb], 
               FULLTEXTCATALOGPROPERTY(ftsac.[name], 'AccentSensitivity') AS [is_accent_sensitive], 
               FULLTEXTCATALOGPROPERTY(ftsac.[name], 'UniqueKeyCount') AS [unique_key_count], 
               ftsac.[row_count_in_thousands], 
               ftsip.[is_clustered_index_scan], 
               ftsip.[range_count], 
               FULLTEXTCATALOGPROPERTY(ftsac.[name], 'ImportStatus') AS [import_status], 
               ftsac.[status_description] AS [current_state_of_fts_catalog], 
               ftsac.[is_paused], 
        (
            SELECT CASE FULLTEXTCATALOGPROPERTY(ftsac.[name], 'PopulateStatus')
                       WHEN 0
                       THEN 'Idle'
                       WHEN 1
                       THEN 'Full Population In Progress'
                       WHEN 2
                       THEN 'Paused'
                       WHEN 3
                       THEN 'Throttled'
                       WHEN 4
                       THEN 'Recovering'
                       WHEN 5
                       THEN 'Shutdown'
                       WHEN 6
                       THEN 'Incremental Population In Progress'
                       WHEN 7
                       THEN 'Building Index'
                       WHEN 8
                       THEN 'Disk Full. Paused'
                       WHEN 9
                       THEN 'Change Tracking'
                   END
        ) AS [population_status], 
               ftsip.[population_type_description] AS [ft_catalog_population_type], 
               ftsip.[status_description] AS [status_of_population], 
               ftsip.[completion_type_description], 
               ftsip.[queued_population_type_description], 
               ftsip.[start_time], 
               DATEADD(ss, FULLTEXTCATALOGPROPERTY(ftsac.[name], 'PopulateCompletionAge'), '1/1/1990') AS [last_populated],
			   DATEDIFF(second,ftsip.[start_time], DATEADD(ss, FULLTEXTCATALOGPROPERTY(ftsac.[name], 'PopulateCompletionAge'), '1/1/1990')) AS RunTimeSecs
        FROM [sys].[dm_fts_active_catalogs] ftsac
             INNER JOIN [sys].[databases] dbs ON dbs.[database_id] = ftsac.[database_id]
             LEFT JOIN [sys].[master_files] mfs ON mfs.[database_id] = dbs.[database_id]
                                                   AND mfs.[physical_name] NOT LIKE '%.mdf'
                                                   AND mfs.[physical_name] NOT LIKE '%.ndf'
                                                   AND mfs.[physical_name] NOT LIKE '%.ldf'
             CROSS JOIN [sys].[dm_fts_index_population] ftsip
        WHERE ftsac.[database_id] = ftsip.[database_id]
              AND ftsac.[catalog_id] = ftsip.[catalog_id];
    END;