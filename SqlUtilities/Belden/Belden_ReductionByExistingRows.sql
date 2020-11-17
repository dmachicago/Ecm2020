truncate table dbo.GLOBAL_Static_POS
--select count(*) from dbo.GLOBAL_Static_POS
--select count(*) from dbo.GLOBAL_Static_BI

--select top 100 * from GLOBAL_Static_POS where Extract = 'P1'
--order by RowID

/***********************************************************/	
--select top 20 * from dbo.GLOBAL_Static_POS where Extract = 'P2'
delete from dbo.GLOBAL_Static_POS
where RowGuid in (
select RowGuid from dbo.GLOBAL_Static_POS tMaster
	join dbo.GLOBAL_POS_Extract1 tSlave
	ON tMaster.RowID =  tSlave.RowID
	and tMaster.LastUpdate != tslave.LastUpdate)
	
SELECT     *
FROM       dbo.GLOBAL_POS_Extract1 AS a
WHERE      NOT EXISTS (SELECT RowID 
					FROM dbo.TEMP_P1_KEYS AS b 
					WHERE a.RowID = b.RowID )
/***********************************************************/	

delete from dbo.GLOBAL_Static_POS
where RowGuid in (
select RowGuid from dbo.GLOBAL_Static_POS tMaster
	join dbo.GLOBAL_POS_Extract2 tSlave
	ON tMaster.RowID =  tSlave.RowID
	and tMaster.LastUpdate != tslave.LastUpdate)
	
SELECT     *
FROM       dbo.GLOBAL_POS_Extract2 AS a
WHERE      NOT EXISTS (SELECT RowID 
					FROM dbo.TEMP_P2_KEYS AS b 
					WHERE a.RowID = b.RowID )
/***********************************************************/	
delete from dbo.GLOBAL_Static_POS
where RowGuid in (
select RowGuid from dbo.GLOBAL_Static_POS tMaster
	join dbo.GLOBAL_POS_Extract3 tSlave
	ON tMaster.RowID =  tSlave.RowID
	and tMaster.LastUpdate != tslave.LastUpdate)
	
SELECT     *
FROM       dbo.GLOBAL_POS_Extract3 AS a
WHERE      NOT EXISTS (SELECT RowID 
					FROM dbo.TEMP_P3_KEYS AS b 
					WHERE a.RowID = b.RowID )

/***********************************************************/	
delete from dbo.GLOBAL_Static_POS
where RowGuid in (
select RowGuid from dbo.GLOBAL_Static_POS tMaster
	join dbo.GLOBAL_POS_Extract4 tSlave
	ON tMaster.RowID =  tSlave.RowID
	and tMaster.LastUpdate != tslave.LastUpdate)
	
SELECT     *
FROM       dbo.GLOBAL_POS_Extract4 AS a
WHERE      NOT EXISTS (SELECT RowID 
					FROM dbo.TEMP_P4_KEYS AS b 
					WHERE a.RowID = b.RowID )
/***********************************************************/	
delete from dbo.GLOBAL_Static_POS
where RowGuid in (
select RowGuid from dbo.GLOBAL_Static_POS tMaster
	join dbo.GLOBAL_POS_Extract5 tSlave
	ON tMaster.RowID =  tSlave.RowID
	and tMaster.LastUpdate != tslave.LastUpdate)
	
SELECT     *
FROM       dbo.GLOBAL_POS_Extract5 AS a
WHERE      NOT EXISTS (SELECT RowID 
					FROM dbo.TEMP_P5_KEYS AS b 
					WHERE a.RowID = b.RowID )

/***********************************************************/						
delete from dbo.GLOBAL_Static_BI
where RowGuid in (
select RowGuid from dbo.GLOBAL_Static_BI tMaster
	join dbo.GLOBAL_BI_Extract1 tSlave
	ON tMaster.RowID =  tSlave.RowID
	and tMaster.LastUpdate != tslave.LastUpdate)
	
SELECT *
FROM dbo.GLOBAL_BI_Extract1 AS a
WHERE NOT EXISTS (SELECT RowID 
FROM dbo.TEMP_B1_KEYS AS b 
WHERE a.RowID = b.RowID )
/***********************************************************/						
delete from dbo.GLOBAL_Static_BI
where RowGuid in (
select RowGuid from dbo.GLOBAL_Static_BI tMaster
	join dbo.GLOBAL_BI_Extract2 tSlave
	ON tMaster.RowID =  tSlave.RowID
	and tMaster.LastUpdate != tslave.LastUpdate)
	
SELECT     *
FROM dbo.GLOBAL_BI_Extract2 AS a
WHERE NOT EXISTS (SELECT RowID 
FROM dbo.TEMP_B2_KEYS AS b 
WHERE a.RowID = b.RowID )
/***********************************************************/	
delete from dbo.GLOBAL_Static_BI
where RowGuid in (
select RowGuid from dbo.GLOBAL_Static_BI tMaster
	join dbo.GLOBAL_BI_Extract3 tSlave
	ON tMaster.RowID =  tSlave.RowID
	and tMaster.LastUpdate != tslave.LastUpdate)
	
SELECT     *
FROM dbo.GLOBAL_BI_Extract3 AS a
WHERE NOT EXISTS (SELECT RowID 
FROM dbo.TEMP_B3_KEYS AS b 
WHERE a.RowID = b.RowID )
/***********************************************************/											

update 	dbo.GLOBAL_Static_POS
set LastUpdate = getdate()
where RowId in 
(
447550,
447774,
448013,
448544,
448794,
449039,
449223,
449547,
449747)
			

