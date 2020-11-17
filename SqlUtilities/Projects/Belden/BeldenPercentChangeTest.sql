select  sum(Year_To_Date_Extended_Sales_Amount), sum(Previous_Year_To_Date_Sales_Amount)
from GLOBAL_BI_V2 
where FISCAL_YEAR in ('2010', '2009')
	and FISCAL_PERIOD = '08'
	and SRC_SYS_ID = 'BPCSRI' 
	and CUST_NAME like 'ANIXTER%' 