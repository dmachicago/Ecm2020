USE [SMART]
GO

/****** Object:  View [dbo].[GLOBAL_BI_V2]    Script Date: 09/23/2010 16:20:18 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[GLOBAL_BI_V2]'))
DROP VIEW [dbo].[GLOBAL_BI_V2]
GO

USE [SMART]
GO

/****** Object:  View [dbo].[GLOBAL_BI_V2]    Script Date: 09/23/2010 16:20:19 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[GLOBAL_BI_V2]
AS
SELECT  
	S.SRC_SYS_ID,
	CASE WHEN (I.SRC_SYS_ID = 'STDMWP' 
				OR (I.SRC_SYS_ID='BPCSMH' 
					AND (S.FREIGHT_AMT > 0 
					OR S.SERV_CHRG_AMT > 0)) 
				OR (I.FINISH_FLG IS NULL)) 
			THEN 'Y' ELSE I.FINISH_FLG 
	END Item_Finish_Flag,
	NULL AMERICAS_SALESINCENTIVE_RECAP_1,
	NULL AMERICAS_SALESINCENTIVE_RECAP_2,
	S.TRX_TYPE SALES_TRANSACTION_TYPE,
	S.QUANTITY Quantity,		
	dbo.nNetBillingAmt(S.Src_Sys_ID, S.Record_KEY, S.TIME_KEY) as Actual_Amt,
	C.NAME CUST_NAME,
	T.FISCAL_YEAR,
	T.FISCAL_PERIOD,
	dbo.nCurrentMoSalesAmtOrQty(T.FISCAL_YEAR, T.FISCAL_PERIOD, dbo.nNetBillingAmt(S.Src_Sys_ID, S.Record_KEY, S.TIME_KEY)) as Current_Month_Sales_Extended_Amount,
	dbo.nYearToDateExtendedSalesAmtOrQty(T.FISCAL_YEAR, dbo.nNetBillingAmt(S.Src_Sys_ID, S.Record_KEY, S.TIME_KEY)) as Year_To_Date_Extended_Sales_Amount,
	dbo.nPrevYearToDateSalesAmtOrQty(T.FISCAL_YEAR, T.FISCAL_PERIOD, dbo.nNetBillingAmt(S.Src_Sys_ID, S.Record_KEY, S.TIME_KEY)) as Previous_Year_To_date_Sales_Amount,
	dbo.nSalesExtendedAmtYoYchange(T.FISCAL_YEAR, T.FISCAL_PERIOD, dbo.nNetBillingAmt(S.Src_Sys_ID, S.Record_KEY, S.TIME_KEY)) as Sales_Extended_Amount_YoY_Change ,
		
	dbo.nCurrentMoSalesAmtOrQty(T.FISCAL_YEAR, T.FISCAL_PERIOD, S.QUANTITY) as Current_Month_Quantity,
	dbo.nYearToDateExtendedSalesAmtOrQty(T.FISCAL_YEAR,  S.QUANTITY ) as Year_To_Date_Extended_Quantity,
	dbo.nPrevYearToDateSalesAmtOrQty(T.FISCAL_YEAR, T.FISCAL_PERIOD,  S.QUANTITY) as Previous_Year_To_date_Quantity,
	dbo.nSalesExtendedAmtYoYchange(T.FISCAL_YEAR, T.FISCAL_PERIOD,  S.QUANTITY) as Sales_Quantity_YoY_Change
			
FROM SMART_GLOBAL_DW.dbo.DM_F_SALES_SUMMARY S
	JOIN SMART_GLOBAL_DW.dbo.DM_D_ITEM I ON I.ITEM_KEY=S.ITEM_KEY  
	JOIN SMART_GLOBAL_DW.dbo.DM_D_CUSTOMER C  ON C.CUSTOMER_KEY=S.CUSTOMER_KEY
	JOIN SMART_GLOBAL_DW.dbo.DM_D_CALENDAR T ON T.TIME_KEY=S.TIME_KEY
	LEFT OUTER JOIN (SELECT CASE WHEN SRC_SYS_ID= 'TEXTAL' THEN 'BPCSAL'
								 WHEN SRC_SYS_ID= 'TEXTAS' THEN 'ASIASR'
								 WHEN SRC_SYS_ID= 'TEXTCO' THEN 'BPCSCO'
								 WHEN SRC_SYS_ID= 'TEXTEU' THEN 'BPCSEU'
								 WHEN SRC_SYS_ID= 'TEXTMH' THEN 'BPCSMH'
								 WHEN SRC_SYS_ID= 'TEXTRI' THEN 'BPCSRI'
								 WHEN SRC_SYS_ID= 'TEXTTM' THEN 'THERMX'
								 WHEN SRC_SYS_ID= 'TEXTWP' THEN 'STDMWP' END AS SRC_SYS_ID,
								 ACCT_NBR AS CUSTOMER_NBR,
								 GBL_NAME AS LEVEL01_NAME,
								 GBL_DIV AS LEVEL02_NAME,
								 CH_CATG AS LEVEL03_NAME,
								 CHR_ATTR1 AS LEVEL04_NAME,
								 CHR_ATTR2 AS LEVEL05_NAME FROM SMART.dbo.TPR_TXT_GBL_ACCOUNT h3 WHERE H3.Current_Ind = 'Y') ch 
								 ON ch.CUSTOMER_NBR = C.CUSTOMER_NBR AND ch.SRC_SYS_ID = S.SRC_SYS_ID							 
	WHERE NOT S.SRC_SYS_ID  IN ('BPCSRI', 'BPCSCO', 'BPCSMH', 'BPCSAL', 'THERMX', 'STDMWP')
UNION ALL
	SELECT  
        S.SRC_SYS_ID,
    	CASE WHEN (I.SRC_SYS_ID = 'STDMWP' OR (I.SRC_SYS_ID='BPCSMH' AND (S.FREIGHT_AMT > 0 OR S.SERV_CHRG_AMT > 0)) OR (I.FINISH_FLG IS NULL)) THEN 'Y' ELSE I.FINISH_FLG 
    	END Item_Finish_Flag,
		NULL AMERICAS_SALESINCENTIVE_RECAP_1,
		NULL AMERICAS_SALESINCENTIVE_RECAP_2,
		S.TRX_TYPE SALES_TRANSACTION_TYPE,
		S.QUANTITY Quantity,
		dbo.nNetBillingAmt(S.Src_Sys_ID, S.Record_KEY, S.TIME_KEY) as Actual_Amt,
		C.NAME CUST_NAME,
		T.FISCAL_YEAR,
		T.FISCAL_PERIOD,
		dbo.nCurrentMoSalesAmtOrQty(T.FISCAL_YEAR, T.FISCAL_PERIOD, dbo.nNetBillingAmt(S.Src_Sys_ID, S.Record_KEY, S.TIME_KEY))  as Current_Month_Sales_Extended_Amount,
		dbo.nYearToDateExtendedSalesAmtOrQty(T.FISCAL_YEAR, dbo.nNetBillingAmt(S.Src_Sys_ID, S.Record_KEY, S.TIME_KEY)) as Year_To_Date_Extended_Sales_Amount,
		dbo.nPrevYearToDateSalesAmtOrQty(T.FISCAL_YEAR, T.FISCAL_PERIOD, dbo.nNetBillingAmt(S.Src_Sys_ID, S.Record_KEY, S.TIME_KEY)) as Previous_Year_To_date_Sales_Amount,
		dbo.nSalesExtendedAmtYoYchange(T.FISCAL_YEAR, T.FISCAL_PERIOD, dbo.nNetBillingAmt(S.Src_Sys_ID, S.Record_KEY, S.TIME_KEY)) as Sales_Extended_Amount_YoY_Change,
		
		dbo.nCurrentMoSalesAmtOrQty(T.FISCAL_YEAR, T.FISCAL_PERIOD, S.QUANTITY )  as Current_Month_Quantity,
		dbo.nYearToDateExtendedSalesAmtOrQty(T.FISCAL_YEAR,  S.QUANTITY ) as Year_To_Date_Extended_Quantity,
		dbo.nPrevYearToDateSalesAmtOrQty(T.FISCAL_YEAR, T.FISCAL_PERIOD,  S.QUANTITY ) as Previous_Year_To_date_Quantity,
		dbo.nSalesExtendedAmtYoYchange(T.FISCAL_YEAR, T.FISCAL_PERIOD,  S.QUANTITY ) as Sales_Quantity_YoY_Change
		
	FROM BDCSQLSP.SMART_DB.dbo.DM_F_SALES_SUMMARY S
		LEFT OUTER JOIN BDCSQLSP.SMART_DB.dbo.DM_D_ITEM I ON I.ITEM_KEY=S.ITEM_KEY  
		LEFT OUTER JOIN BDCSQLSP.SMART_DB.dbo.DM_D_CUSTOMER C  ON C.CUSTOMER_KEY=S.CUSTOMER_KEY
		LEFT OUTER JOIN BDCSQLSP.SMART_DB.dbo.DM_D_CALENDAR T ON T.TIME_KEY=S.TIME_KEY
	WHERE (S.SRC_SYS_ID='BPCSMH' AND S.TIME_KEY  < 20100101) OR S.SRC_SYS_ID IN ('THERMX', 'BPCSAL', 'STDMWP')

UNION ALL 
	SELECT  
        S.SRC_SYS_ID,
       	CASE WHEN (S.SRC_SYS_ID IN ('BPCSRI', 'BPCSCO')) THEN 
	   			CASE WHEN (B.ItemClass >= 'B0' AND B.ItemClass <= 'QZ') OR (B.ItemClass >= 'T0' AND B.ItemClass <= 'T2')  THEN 'Y' ELSE 'N' END
	   		ELSE
	   			CASE WHEN (B.ItemClass >= 'R0' AND B.ItemClass <= 'SZ')  THEN 'Y' ELSE 'N' END
	   		END ITEM_FINISH_FLG,
	   		
		B.SalesIncentiveRecapClass1 AMERICAS_SALESINCENTIVE_RECAP_1,
		B.SalesIncentiveRecapClass2 AMERICAS_SALESINCENTIVE_RECAP_2,
    
		CASE  WHEN (B.DivisionCode = 9 AND LEFT(B.ItemClass, 1) <> 'A') THEN 'THIRD'
			  WHEN (B.DivisionCode = 9 AND LEFT(B.ItemClass, 1) = 'A') THEN 'UNKNOWN'
		ELSE S.TRX_TYPE 
		END SALES_TRANSACTION_TYPE,
		
		B.ExtendedQuantity Quantity,		
		dbo.nNetBillingAmt(S.Src_Sys_ID, S.Invoice_Ln_Key, S.TIME_KEY) as Actual_Amt,
		C.NAME CUST_NAME,
			
		T.FISCAL_YEAR,
		T.FISCAL_PERIOD,
		dbo.nCurrentMoSalesAmtOrQty(T.FISCAL_YEAR, T.FISCAL_PERIOD, dbo.nNetBillingAmt(S.Src_Sys_ID, S.Invoice_Ln_Key, S.TIME_KEY)) as Current_Month_Sales_Extended_Amount,
		dbo.nYearToDateExtendedSalesAmtOrQty(T.FISCAL_YEAR, dbo.nNetBillingAmt(S.Src_Sys_ID, S.Invoice_Ln_Key, S.TIME_KEY)) as Year_To_Date_Extended_Sales_Amount,
		dbo.nPrevYearToDateSalesAmtOrQty(T.FISCAL_YEAR, T.FISCAL_PERIOD, dbo.nNetBillingAmt(S.Src_Sys_ID, S.Invoice_Ln_Key, S.TIME_KEY)) as Previous_Year_To_date_Sales_Amount,
		dbo.nSalesExtendedAmtYoYchange(T.FISCAL_YEAR, T.FISCAL_PERIOD, dbo.nNetBillingAmt(S.Src_Sys_ID, S.Invoice_Ln_Key, S.TIME_KEY)) as Sales_Extended_Amount_YoY_Change,
		
		dbo.nCurrentMoSalesAmtOrQty(T.FISCAL_YEAR, T.FISCAL_PERIOD, S.QUANTITY )  as Current_Month_Quantity,
		dbo.nYearToDateExtendedSalesAmtOrQty(T.FISCAL_YEAR,  S.QUANTITY ) as Year_To_Date_Extended_Quantity,
		dbo.nPrevYearToDateSalesAmtOrQty(T.FISCAL_YEAR, T.FISCAL_PERIOD,  S.QUANTITY ) as Previous_Year_To_date_Quantity,
		dbo.nSalesExtendedAmtYoYchange(T.FISCAL_YEAR, T.FISCAL_PERIOD,  S.QUANTITY ) as Sales_Quantity_YoY_Change
		
	FROM BDCSQLSP.SMART_DB.dbo.DM_F_INVOICE_LN S
		LEFT OUTER JOIN BDCSQLSP.SMART_DB.dbo.BAG_BILLINGS B ON S.INVOICE_NBR = B.InvoiceNumber AND S.INVOICE_LN_NBR = B.InvoiceLineNumber AND S.INVOICE_DT = B.InvoiceDate AND (S.SRC_SYS_ID = B.SRC_SYS_ID OR (S.SRC_SYS_ID='BPCSMH' AND B.SRC_SYS_ID IN ('BPCSM1', 'BPCSMH')))
		LEFT OUTER JOIN BDCSQLSP.SMART_DB.dbo.DM_D_ITEM I ON I.ITEM_KEY=S.ITEM_KEY  
		LEFT OUTER JOIN BDCSQLSP.SMART_DB.dbo.DM_D_CUSTOMER C  ON C.CUSTOMER_KEY=S.CUSTOMER_KEY
		LEFT OUTER JOIN BDCSQLSP.SMART_DB.dbo.DM_D_CALENDAR T ON T.TIME_KEY=S.TIME_KEY
		LEFT OUTER JOIN TPR_X_RECAPCLASS_PRODUCTGROUP PG ON B.SalesIncentiveRecapClass2=PG.SalesIncentiveRecapClass2
	WHERE S.SRC_SYS_ID IN ('BPCSCO', 'BPCSRI') OR (S.SRC_SYS_ID='BPCSMH' AND S.TIME_KEY >= 20100101)





GO


