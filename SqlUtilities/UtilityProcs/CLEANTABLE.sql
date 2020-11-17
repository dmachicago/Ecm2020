DBCC CLEANTABLE('TrackAnalytics', 'dbo.TNA_DRF_HR') ; 
exec sp_spaceused 'dbo.TNA_DRF_HR'

--reclaim the space from the table 
EXEC sp_msforeachtable 'DBCC CLEANTABLE(0, ''?'') '; 

--check the space used one more time
SELECT
alloc_unit_type_desc
,page_count
,avg_page_space_used_in_percent
,record_count
FROM
sys.dm_db_index_physical_stats(
DB_ID()
,OBJECT_ID(N'dbo.TNA_DRF_HR')
,NULL
,NULL
,'Detailed')

