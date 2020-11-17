--select top 100 * from dbo.GLOBAL_STATIC_BI where extract = 'B3'
--select count(*) from dbo.GLOBAL_STATIC_BI where extract = 'B3'

create procedure spMigrateGLOBAL_Static_BI3
as 
delete from dbo.GLOBAL_Static_BI
	where RowGuid in (
	select RowGuid from dbo.GLOBAL_Static_BI tMaster
		join dbo.GLOBAL_BI_Extract3 tSlave
		ON tMaster.RowID =  tSlave.RowID
		and tMaster.Invoice_Nbr = tslave.Invoice_Nbr
		and tMaster.LastUpdate != tslave.LastUpdate) ;

truncate table dbo.TEMP_B3_KEYS ;

INSERT INTO dbo.TEMP_B3_KEYS (RowID, Invoice_Number)
	SELECT RowID, Invoice_Nbr
	FROM dbo.GLOBAL_Static_BI
	WHERE Extract = 'B3' ;

INSERT INTO dbo.GLOBAL_STATIC_BI 
	  ([SRC_SYS_ID]
      ,[Item_Finish_Flag]
      ,[AMERICAS_SALESINCENTIVE_RECAP_1]
      ,[AMERICAS_SALESINCENTIVE_RECAP_2]
      ,[SALES_TRANSACTION_TYPE]
      ,[Quantity]
      ,[Actual_Amt]
      ,[CUST_NAME]
      ,[FISCAL_YEAR]
      ,[FISCAL_PERIOD]
      ,[INVOICE_NBR]
      ,[AMERICAS_ITEM_FAMILY]
      ,[BOWLER_MAX_PERIOD]
      ,[BOWLER_TARGET_YEAR]
      ,[Current_Month_Sales_Extended_Amount]
      ,[Year_To_Date_Extended_Sales_Amount]
      ,[Previous_Year_To_date_Sales_Amount]
      ,[Sales_Extended_Amount_YoY_Change]
      ,[Current_Month_Quantity]
      ,[Year_To_Date_Extended_Quantity]
      ,[Previous_Year_To_date_Quantity]
      ,[Sales_Quantity_YoY_Change]
      ,[Extract]
      ,[RowID]
      ,[LastUpdate])
SELECT 
[SRC_SYS_ID]
      ,B.[ITEM_FINISH_FLG]
      ,B.[AMERICAS_SALESINCENTIVE_RECAP_1]
      ,B.[AMERICAS_SALESINCENTIVE_RECAP_2]
      ,B.[SALES_TRANSACTION_TYPE]
      ,B.[Quantity]
      ,B.[Actual_Amt]
      ,B.[CUST_NAME]
      ,B.[FISCAL_YEAR]
      ,B.[FISCAL_PERIOD]
      ,B.[INVOICE_NBR]
      ,B.[AMERICAS_ITEM_FAMILY]
      ,B.[BOWLER_MAX_PERIOD]
      ,B.[BOWLER_TARGET_YEAR]
      ,B.[Current_Month_Sales_Extended_Amount]
      ,B.[Year_To_Date_Extended_Sales_Amount]
      ,B.[Previous_Year_To_date_Sales_Amount]
      ,B.[Sales_Extended_Amount_YoY_Change]
      ,B.[Current_Month_Quantity]
      ,B.[Year_To_Date_Extended_Quantity]
      ,B.[Previous_Year_To_date_Quantity]
      ,B.[Sales_Quantity_YoY_Change]
      ,B.[Extract]
      ,B.[RowID]
      ,B.[LastUpdate]      
FROM dbo.GLOBAL_BI_Extract3 B
where B.RowID
not in (Select RowID from dbo.TEMP_B3_KEYS) ;
