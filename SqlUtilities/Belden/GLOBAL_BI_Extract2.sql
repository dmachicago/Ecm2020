USE [SMART]
GO

/****** Object:  View [dbo].[GLOBAL_BI_Extract2]    Script Date: 10/29/2010 14:22:02 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


ALTER view [dbo].[GLOBAL_BI_Extract2] AS
	SELECT  
        S.SRC_SYS_ID,
    	CASE WHEN (I.SRC_SYS_ID = 'STDMWP' 
    				OR (I.SRC_SYS_ID='BPCSMH' 
    				AND (S.FREIGHT_AMT > 0 
    				OR S.SERV_CHRG_AMT > 0)
    				) 
    				OR (I.FINISH_FLG IS NULL)) 
    	THEN 
    		'Y' 
    	ELSE 
    		I.FINISH_FLG 
    	END Item_Finish_Flag,
		NULL AMERICAS_SALESINCENTIVE_RECAP_1,
		NULL AMERICAS_SALESINCENTIVE_RECAP_2,
		S.TRX_TYPE SALES_TRANSACTION_TYPE,
		S.QUANTITY Quantity,
		dbo.nNetBillingAmt(S.Src_Sys_ID, S.Record_KEY, S.TIME_KEY) as Actual_Amt,
		C.NAME CUST_NAME,
		T.FISCAL_YEAR,
		T.FISCAL_PERIOD,
		S.INVOICE_NBR,
		
		NULL AMERICAS_ITEM_FAMILY,

		dbo.sCurrentPeriod() BOWLER_MAX_PERIOD,
	    cast (year(getdate()) as varchar(4)) BOWLER_TARGET_YEAR,
		
		dbo.nCurrentMoSalesAmtOrQty(T.FISCAL_YEAR, T.FISCAL_PERIOD, dbo.nNetBillingAmt(S.Src_Sys_ID, S.Record_KEY, S.TIME_KEY))  as Current_Month_Sales_Extended_Amount,
		dbo.nYearToDateExtendedSalesAmtOrQty(T.FISCAL_YEAR, dbo.nNetBillingAmt(S.Src_Sys_ID, S.Record_KEY, S.TIME_KEY)) as Year_To_Date_Extended_Sales_Amount,
		dbo.nPrevYearToDateSalesAmtOrQty(T.FISCAL_YEAR, T.FISCAL_PERIOD, dbo.nNetBillingAmt(S.Src_Sys_ID, S.Record_KEY, S.TIME_KEY)) as Previous_Year_To_date_Sales_Amount,
		dbo.nSalesExtendedAmtYoYchange(T.FISCAL_YEAR, T.FISCAL_PERIOD, dbo.nNetBillingAmt(S.Src_Sys_ID, S.Record_KEY, S.TIME_KEY)) as Sales_Extended_Amount_YoY_Change,
		
		dbo.nCurrentMoSalesAmtOrQty(T.FISCAL_YEAR, T.FISCAL_PERIOD, S.QUANTITY )  as Current_Month_Quantity,
		dbo.nYearToDateExtendedSalesAmtOrQty(T.FISCAL_YEAR,  S.QUANTITY ) as Year_To_Date_Extended_Quantity,
		dbo.nPrevYearToDateSalesAmtOrQty(T.FISCAL_YEAR, T.FISCAL_PERIOD,  S.QUANTITY ) as Previous_Year_To_date_Quantity,
		dbo.nSalesExtendedAmtYoYchange(T.FISCAL_YEAR, T.FISCAL_PERIOD,  S.QUANTITY ) as Sales_Quantity_YoY_Change,
    'B2' Extract
/*		
	FROM BDCSQLSP.SMART_DB.dbo.DM_F_SALES_SUMMARY S
		LEFT OUTER JOIN BDCSQLSP.SMART_DB.dbo.DM_D_ITEM I ON I.ITEM_KEY=S.ITEM_KEY  
		LEFT OUTER JOIN BDCSQLSP.SMART_DB.dbo.DM_D_CUSTOMER C  ON C.CUSTOMER_KEY=S.CUSTOMER_KEY
		LEFT OUTER JOIN BDCSQLSP.SMART_DB.dbo.DM_D_CALENDAR T ON T.TIME_KEY=S.TIME_KEY
	WHERE (S.SRC_SYS_ID='BPCSMH' AND S.TIME_KEY  < 20100101) OR S.SRC_SYS_ID IN ('THERMX', 'BPCSAL', 'STDMWP')
*/	
	FROM dbo.DM_F_SALES_SUMMARY_Extract S
		LEFT OUTER JOIN dbo.DM_D_ITEM_Extract I ON I.ITEM_KEY=S.ITEM_KEY  
		LEFT OUTER JOIN dbo.DM_D_CUSTOMER C  ON C.CUSTOMER_KEY=S.CUSTOMER_KEY
		LEFT OUTER JOIN dbo.DM_D_CALENDAR T ON T.TIME_KEY=S.TIME_KEY
	WHERE (S.SRC_SYS_ID='BPCSMH' AND S.TIME_KEY  < 20100101) OR S.SRC_SYS_ID IN ('THERMX', 'BPCSAL', 'STDMWP')




GO


