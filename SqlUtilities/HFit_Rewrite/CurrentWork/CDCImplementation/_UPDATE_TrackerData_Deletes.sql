

--delete from BASE_HFit_TrackerCardio
--where ItemID in 
--(select top 50 itemid from BASE_HFit_TrackerCardio order by itemid desc  )


    DELETE FT
    from CHANGETABLE (CHANGES BASE_HFit_TrackerCardio, 0) AS C 
	   inner join FACT_TrackerData as FT	   
		  on C.DBNAME = FT.DBNAME	
		  and C.DBNAME = FT.DBNAME	
		  AND C.ItemID = FT.ItemID
		   AND C.SYS_CHANGE_OPERATION = 'D'
  