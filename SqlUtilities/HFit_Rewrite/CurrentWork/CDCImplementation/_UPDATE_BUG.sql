
select top 100 * from BASE_HFit_TrackerCholesterol
update BASE_HFit_TrackerCholesterol set Notes = '-' where ItemID in
(select top 100 itemid from BASE_HFit_TrackerCholesterol where Notes is null)


select count(*) from  CHANGETABLE (CHANGES BASE_HFit_TrackerCholesterol, 0) AS C
where C.SYS_CHANGE_OPERATION = 'U'  

update BASE_HFit_TrackerCardio
    set ItemModifiedWhen = getdate()
	   where ItemID in (select top 50 itemid from BASE_HFit_TrackerCardio order by itemid desc  )



    update FACT_TrackerData 
    set 
	   TrackerCollectionSourceID = BT.TrackerCollectionSourceID
	   ,IsProfessionallyCollected = BT.IsProfessionallyCollected
	   ,Minutes = BT.Minutes
	   ,Distance = BT.Distance
    from 
	   CHANGETABLE (CHANGES BASE_HFit_TrackerCardio, 0) AS C 
	   inner join BASE_HFit_TrackerCardio as BT
	     on C.SVR = BT.SVR
		  AND C.DBNAME = BT.DBNAME	
		  AND C.ItemID = BT.ItemID
		  AND C.SYS_CHANGE_OPERATION = 'U'    
  


select top 100 * from BASE_HFit_TrackerCholesterol
update BASE_HFit_TrackerCholesterol set isProfessionallyCollected = 1 where ItemID in
(select top 100 itemid from BASE_HFit_TrackerCholesterol)
select top 100 * from BASE_HFit_TrackerCholesterol_DEL where action = 'U'
select * from  CHANGETABLE (CHANGES BASE_HFit_TrackerCholesterol, 0) AS C
where C.SYS_CHANGE_OPERATION = 'U'  



select * from  CHANGETABLE (CHANGES BASE_HFit_TrackerCardio, 0) AS C
where C.SYS_CHANGE_OPERATION = 'D'  

select sys.schemas.name as Schema_name, sys.tables.name as Table_name from sys.change_tracking_tables
join sys.tables on sys.tables.object_id = sys.change_tracking_tables.object_id
join sys.schemas on sys.schemas.schema_id = sys.tables.schema_id
order by sys.tables.name