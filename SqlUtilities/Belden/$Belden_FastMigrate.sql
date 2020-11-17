truncate table dbo.DM_D_ITEM_Extract
go
INSERT INTO dbo.DM_D_ITEM_Extract (ITEM_KEY,
FINISH_FLG,
SRC_SYS_ID,
UPDATE_DTTM)
SELECT ITEM_KEY,
FINISH_FLG,
SRC_SYS_ID,
UPDATE_DTTM
from BDCSQLSP.SMART_DB.DBO.DM_D_ITEM
where ITEM_KEY not in 
(Select ITEM_KEY from dbo.DM_D_ITEM_Extract)
go


truncate table DBO.DM_F_SALES_SUMMARY_Extract
go
insert into DBO.DM_F_SALES_SUMMARY_Extract
	(ITEM_KEY,
	CUSTOMER_KEY,
	FREIGHT_AMT,
	INVOICE_NBR,
	QUANTITY,
	Record_KEY,
	SERV_CHRG_AMT,
	SRC_SYS_ID,
	TIME_KEY,
	TRX_TYPE,
	UPDATE_DTTM)
SELECT 
	ITEM_KEY,
	CUSTOMER_KEY,
	FREIGHT_AMT,
	INVOICE_NBR,
	QUANTITY,
	Record_KEY,
	SERV_CHRG_AMT,
	SRC_SYS_ID,
	TIME_KEY,
	TRX_TYPE,
	UPDATE_DTTM
from BDCSQLSP.SMART_DB.DBO.DM_F_SALES_SUMMARY
where ITEM_KEY not in 
(Select ITEM_KEY from DBO.DM_F_SALES_SUMMARY_Extract)

--select 
--ITEM_KEY,
--CUSTOMER_KEY,
--FREIGHT_AMT,
--INVOICE_NBR,
--QUANTITY,
--Record_KEY,
--SERV_CHRG_AMT,
--SRC_SYS_ID,
--TIME_KEY,
--TRX_TYPE SALES_TRANSACTION_TYPE,
--UPDATE_DTTM
--into DBO.DM_F_SALES_SUMMARY_Extract
--from BDCSQLSP.SMART_DB.DBO.DM_F_SALES_SUMMARY


select
CUSTOMER_KEY,
NAME CUST_NAME,
UPDATE_DTTM
into DBO.DM_D_CUSTOMER_Extract
from BDCSQLSP.SMART_DB.DBO.DM_D_CUSTOMER

truncate table dbo.DM_D_ITEM_Extract
go
INSERT INTO dbo.DM_D_ITEM_Extract (ITEM_KEY,
FINISH_FLG,
SRC_SYS_ID,
UPDATE_DTTM)
SELECT ITEM_KEY,
FINISH_FLG,
SRC_SYS_ID,
UPDATE_DTTM
from BDCSQLSP.SMART_DB.DBO.DM_D_ITEM
where ITEM_KEY not in 
(Select ITEM_KEY from dbo.DM_D_ITEM_Extract)
go

GLOBAL_STATIC_Pos

truncate table GLOBAL_STATIC_BI

INSERT INTO dbo.GLOBAL_STATIC_BI (
	SRC_SYS_ID,
	Item_Finish_Flag,
	AMERICAS_SALESINCENTIVE_RECAP_1,
	AMERICAS_SALESINCENTIVE_RECAP_2,
	SALES_TRANSACTION_TYPE,
	Quantity,
	Actual_Amt,
	CUST_NAME,
	FISCAL_YEAR,
	FISCAL_PERIOD,
	INVOICE_NBR,
	AMERICAS_ITEM_FAMILY,
	BOWLER_MAX_PERIOD,
	BOWLER_TARGET_YEAR,
	Current_Month_Sales_Extended_Amount,
	Year_To_Date_Extended_Sales_Amount,
	Previous_Year_To_date_Sales_Amount,
	Sales_Extended_Amount_YoY_Change,
	Current_Month_Quantity,
	Year_To_Date_Extended_Quantity,
	Previous_Year_To_date_Quantity,
	Sales_Quantity_YoY_Change,
	Extract)
SELECT
	SRC_SYS_ID,
	Item_Finish_Flag,
	AMERICAS_SALESINCENTIVE_RECAP_1,
	AMERICAS_SALESINCENTIVE_RECAP_2,
	SALES_TRANSACTION_TYPE,
	Quantity,
	Actual_Amt,
	CUST_NAME,
	FISCAL_YEAR,
	FISCAL_PERIOD,
	INVOICE_NBR,
	AMERICAS_ITEM_FAMILY,
	BOWLER_MAX_PERIOD,
	BOWLER_TARGET_YEAR,
	Current_Month_Sales_Extended_Amount,
	Year_To_Date_Extended_Sales_Amount,
	Previous_Year_To_date_Sales_Amount,
	Sales_Extended_Amount_YoY_Change,
	Current_Month_Quantity,
	Year_To_Date_Extended_Quantity,
	Previous_Year_To_date_Quantity,
	Sales_Quantity_YoY_Change,
	Extract
from dbo.GLOBAL_BI_Extract1