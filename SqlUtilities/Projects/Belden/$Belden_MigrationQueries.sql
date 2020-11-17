
select count(*)  from BDCSQLSP.SMART_DB.dbo.DM_F_SALES_SUMMARY		--Record_key
select count(*)  from dbo.DM_F_SALES_SUMMARY

select count(*)  from BDCSQLSP.SMART_DB.dbo.DM_D_ITEM				--Item_KEY
select count(*)  from dbo.DM_D_ITEM

select count(*)  from BDCSQLSP.SMART_DB.dbo.DM_D_CUSTOMER			--Customer_Key
select count(*)  from dbo.DM_D_CUSTOMER			

select count(*)  from BDCSQLSP.SMART_DB.dbo.DM_D_CALENDAR			--Time_Key
select count(*)  from dbo.DM_D_CALENDAR

select top 10 *  from BDCSQLSP.SMART_DB.dbo.DM_F_SALES_SUMMARY		--Record_key
select top 10 *  from BDCSQLSP.SMART_DB.dbo.DM_D_ITEM				--Item_KEY
select top 10 *  from BDCSQLSP.SMART_DB.dbo.DM_D_CUSTOMER			--Customer_Key
select top 10 *  from BDCSQLSP.SMART_DB.dbo.DM_D_CALENDAR			--Time_Key

select count(*)  from BDCSQLSP.SMART_DB.dbo.DM_D_CUSTOMER
select count(*)  from dbo.DM_D_CUSTOMER

truncate table dbo.DM_D_CUSTOMER

select customer_key from dbo.DM_D_CUSTOMER 
select record_key from dbo.DM_F_SALES_SUMMARY

/***************************************************************/
select count(*) from BDCSQLSP.SMART_DB.DBO.DM_F_SALES_SUMMARY 
	where Record_Key not in 
	(
	select Record_Key from dbo.DM_F_SALES_SUMMARY
	)

select count(*) from BDCSQLSP.SMART_DB.dbo.DM_D_ITEM
	where Item_KEY not in 
	(
	select Item_KEY from dbo.DM_D_ITEM
	)
/***************************************************************/	
	

select distinct customer_key, count(*)
from BDCSQLSP.SMART_DB.dbo.DM_D_CUSTOMER 
group by customer_key
having count(*) > 1

delete from DBO.DM_F_SALES_SUMMARY 
	where Record_Key in 
	(
	select SCHILD.Record_Key from SMART_GLOBAL_DW.dbo.DM_F_SALES_SUMMARY SPARENT
	--select count(*) from SMART_GLOBAL_DW.dbo.DM_F_SALES_SUMMARY SPARENT
	join [dbo].[DM_F_SALES_SUMMARY] SCHILD
	ON SPARENT.Record_Key =  SCHILD.Record_Key
	and SPARENT.UPDATE_DTTM > SCHILD.[UPDATE_DTTM] 
	)

	
delete from DBO.DM_D_ITEM
	where Item_KEY in 
	(
	select SCHILD.Item_KEY from BDCSQLSP.SMART_DB.dbo.DM_D_ITEM SPARENT
	--select count(*) from BDCSQLSP.SMART_DB.dbo.DM_D_ITEM SPARENT
	join [dbo].[DM_D_ITEM] SCHILD
	ON SPARENT.Item_KEY =  SCHILD.Item_KEY
	and SPARENT.UPDATE_DTTM > SCHILD.[UPDATE_DTTM] 
	)
	
delete from DBO.DM_D_CUSTOMER
	where Customer_Key in 
	(
	select SCHILD.Customer_Key from BDCSQLSP.SMART_DB.dbo.DM_D_CUSTOMER SPARENT
	--select count(*) from BDCSQLSP.SMART_DB.dbo.DM_D_CUSTOMER SPARENT
	join [dbo].[DM_D_CUSTOMER] SCHILD
	ON SPARENT.Customer_Key =  SCHILD.Customer_Key
	and SPARENT.UPDATE_DTTM > SCHILD.[UPDATE_DTTM] 
	)	
	
delete from DBO.DM_D_CALENDAR
	where Item_KEY in 
	(
	select SCHILD.Item_KEY from BDCSQLSP.SMART_DB.dbo.DM_D_CALENDAR SPARENT
	--select count(*) from BDCSQLSP.SMART_DB.dbo.DM_D_CALENDAR SPARENT
	join [dbo].[DM_D_CALENDAR] SCHILD
	ON SPARENT.Time_Key =  SCHILD.Time_Key
	and SPARENT.UPDATE_DTTM > SCHILD.[UPDATE_DTTM] 
	)	