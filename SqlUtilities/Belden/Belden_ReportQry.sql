SELECT top 200 AL1.SRC_SYS_ID_POS, AL1.SRC_SYS_ID, AL1.SALES_EXTENDED_AMT_USD,
	AL1.MANUFACTURER_NAME, AL1.REPORT_ENDING_CALENDAR_YEAR,
	AL1.REPORT_ENDING_CALENDAR_QUARTER, AL1.REPORT_ENDING_CALENDAR_MONTH,
	AL1.AMERICAS_SALESINCENTIVE_RECAP_1, AL1.AMERICAS_SALESINCENTIVE_RECAP_2,
	AL1.BRANCH_ID, AL1.BUSINESSUNIT_GRP, AL1.DISTRIBUTOR_NAME,
	AL1.REPORT_ENDING_DATE, AL1.SALES_QUANTITY, AL1.SALES_EXTENDED_AMT_USD,
	AL1.REPORT_ENDING_FISCAL_YEAR, AL1.REPORT_ENDING_FISCAL_QUARTER,
	AL1.REPORT_ENDING_FISCAL_PERIOD, AL1.REPORT_ENDING_PERIOD_FISCAL_NAME,
	AL1.REPORT_ENDING_CALENDAR_MONTH_NAME,
	AL1.Current_Month_Sales_Extended_Amount,
	AL1.Year_To_Date_Extended_Sales_Amount,
	AL1.Previous_Year_To_date_Sales_Amount,
	AL1.Sales_Extended_Amount_YoY_Change, AL1.Current_Month_Quantity,
	AL1.Year_To_Date_Extended_Quantity, AL1.Previous_Year_To_date_Quantity,
	AL1.Sales_Quantity_YoY_Change 
FROM dbo.GLOBAL_POS_V2 AL1 
WHERE
	((AL1.SRC_SYS_ID_POS='AXT_V2' AND AL1.SRC_SYS_ID IN ('BPCSCO', 'BPCSRI')
	AND AL1.REPORT_ENDING_CALENDAR_YEAR IN ('2009', '2010') AND
	AL1.AMERICAS_SALESINCENTIVE_RECAP_2 IN ('New Gen Coax', 'New Gen
	Multiconductor') AND (NOT (AL1.ITEM_NBR LIKE 'S%' OR AL1.ITEM_NBR LIKE
	'Y%'))))