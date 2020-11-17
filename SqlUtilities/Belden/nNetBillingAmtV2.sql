USE [SMART]
GO

/****** Object:  UserDefinedFunction [dbo].[nNetBillingAmt]    Script Date: 10/19/2010 08:24:20 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[nNetBillingAmt]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[nNetBillingAmt]
GO

USE [SMART]
GO

/****** Object:  UserDefinedFunction [dbo].[nNetBillingAmt]    Script Date: 10/19/2010 08:24:20 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*
FROM BDCSQLSP.SMART_DB.dbo.DM_F_INVOICE_LN S
LEFT OUTER JOIN BDCSQLSP.SMART_DB.dbo.BAG_BILLINGS B ON S.INVOICE_NBR = B.InvoiceNumber 
	AND S.INVOICE_LN_NBR = B.InvoiceLineNumber 
	AND S.INVOICE_DT = B.InvoiceDate 
	AND (S.SRC_SYS_ID = B.SRC_SYS_ID OR (S.SRC_SYS_ID='BPCSMH' AND B.SRC_SYS_ID IN ('BPCSM1', 'BPCSMH')))
*/

/*
10/18/2010 - Added the calcualted variable @Calc_Time_key so that the procedure would not have to be modified every year. SDM
10/19/2010 - Added a DB Control parameter, @DbTable, to allow parametric selection of the target DB from which to read the data.
			@DbTable Acceptable Values are:
				1 - NULL defaults to 'DM_F_SALES_SUMMARY'
				2 - 'DM_F_SALES_SUMMARY'
				3 - 'DM_F_INVOICE_LN'
				4 - 'SUMMARY' defaults to 'DM_F_SALES_SUMMARY'
				5 - 'INVOICE' defaults to 'DM_F_INVOICE_LN'
				4 - 'S' defaults to 'DM_F_SALES_SUMMARY'
				5 - 'I' defaults to 'DM_F_INVOICE_LN'				
*/
CREATE Function [dbo].[nNetBillingAmtV2](
				@sSrc_Sys_ID as varchar(6), 
				@iRecord_ID as int, 
				@Time_Key as int,
				@DbTable as varchar)
RETURNS numeric (38,6)
as 
begin
	
	declare @ReturnAmt as numeric (38,6)
	declare @Calc_Time_key as int
	set @Calc_Time_key = cast(cast(datepart(year,getdate()) as varchar) + '0101' as int)

	if len(@DbTable) = 0 
	begin
		set @DbTable = 'DM_F_SALES_SUMMARY'
	end 
	if @DbTable = 'SUMMARY' 
	Begin
		set @DbTable = 'DM_F_SALES_SUMMARY'
	end
	if @DbTable = 'INVOICE' 
	Begin
		set @DbTable = 'DM_F_INVOICE_LN'
	end
	if @DbTable = 'S' 
	Begin
		set @DbTable = 'DM_F_SALES_SUMMARY'
	end
	if @DbTable = 'I' 
	Begin
		set @DbTable = 'DM_F_INVOICE_LN'
	end

	--if @sSrc_Sys_Id IN ('BPCSCO', 'BPCSRI') OR (@sSrc_Sys_Id='BPCSMH' AND @Time_Key >= 20100101) /*Changed to below SDM*/
	if @DbTable = 'DM_F_SALES_SUMMARY'
	begin
		if @sSrc_Sys_ID = 'BPCSMH'
		begin
			
			SET @ReturnAmt = (
							Select 
							S.CUST_SALE_AMT + 
							S.INTER_SALE_AMT + 
							S.INTRA_SALE_AMT + 
							S.FREIGHT_AMT + 
							S.SERV_CHRG_AMT + 
							S.SND_ADJUST_AMT + 
							S.OTH_ADJUST_AMT + 
							S.CREDIT_RMA_AMT + 
							S.ALLOWANCE_AMT
							from DM_F_SALES_SUMMARY S
							Where S.Record_KEY = @iRecord_ID
							)
		end
		else if @sSrc_Sys_Id IN ('BPCSCO', 'BPCSRI') OR (@sSrc_Sys_Id='BPCSMH' AND @Time_Key >= @Calc_Time_key)
			BEGIN
			SET @ReturnAmt = (
								select 
								CASE WHEN (B.Financialreasoncode <> 'CRE7A') THEN 
									B.ExtendedUSDPrice 
								ELSE 
									0 
								END NET_BILLING_AMT 
								
								FROM BDCSQLSP.SMART_DB.dbo.DM_F_INVOICE_LN S
										LEFT OUTER JOIN BDCSQLSP.SMART_DB.dbo.BAG_BILLINGS B 
											ON S.INVOICE_NBR = B.InvoiceNumber 
												AND S.INVOICE_LN_NBR = B.InvoiceLineNumber 
												AND S.INVOICE_DT = B.InvoiceDate 
												AND (
													S.SRC_SYS_ID = B.SRC_SYS_ID 
													OR 
														(
														S.SRC_SYS_ID='BPCSMH' 
														AND B.SRC_SYS_ID IN ('BPCSM1', 'BPCSMH')
														)
													)
								WHERE S.Invoice_Ln_Key = @iRecord_ID
							)
			END
		ELSE
			Begin
			SET @ReturnAmt = (
				select
				CASE WHEN (S.SRC_SYS_ID = 'BPCSMH') THEN
					(
						(
						S.CUST_SALE_AMT + 
						S.INTER_SALE_AMT + 
						S.INTRA_SALE_AMT + 
						S.FREIGHT_AMT + 
						S.SERV_CHRG_AMT
						)+
					S.SND_ADJUST_AMT +
					S.OTH_ADJUST_AMT +
					S.CREDIT_RMA_AMT +
					S.ALLOWANCE_AMT
					)
				ELSE	
					CASE WHEN (S.SRC_SYS_ID <> 'STDMLT' OR S.INVLN_SALE_AMT = 0) THEN
						(
							(
							S.CUST_SALE_AMT + 
							S.INTER_SALE_AMT + 
							S.INTRA_SALE_AMT
							)+
						S.SND_ADJUST_AMT +
						S.OTH_ADJUST_AMT +
						S.CREDIT_RMA_AMT +
						S.ALLOWANCE_AMT
						)	
					ELSE
						(
							(S.CUST_SALE_AMT + 
							S.INTER_SALE_AMT + 
							S.INTRA_SALE_AMT)+
							S.SND_ADJUST_AMT +
							S.OTH_ADJUST_AMT +
							S.CREDIT_RMA_AMT +
							S.ALLOWANCE_AMT) * 
						   (S.TO_LOC_CURR_RATE / S.INVLN_SALE_AMT)
				END
			END
			from DM_F_SALES_SUMMARY S
			Where S.Record_KEY = @iRecord_ID)
		End
	end
	if @DbTable = 'DM_F_INVOICE_LN'
	begin
	if @sSrc_Sys_ID = 'BPCSMH'
		begin
			
			SET @ReturnAmt = (
							Select 
							S.CUST_SALE_AMT + 
							S.INTER_SALE_AMT + 
							S.INTRA_SALE_AMT + 
							S.FREIGHT_AMT + 
							S.SERV_CHRG_AMT + 
							S.SND_ADJUST_AMT + 
							S.OTH_ADJUST_AMT + 
							S.CREDIT_RMA_AMT + 
							S.ALLOWANCE_AMT
							from DM_F_SALES_SUMMARY S
							Where S.Record_KEY = @iRecord_ID
							)
		end
		else if @sSrc_Sys_Id IN ('BPCSCO', 'BPCSRI') OR (@sSrc_Sys_Id='BPCSMH' AND @Time_Key >= @Calc_Time_key)
			BEGIN
			SET @ReturnAmt = (
								select 
								CASE WHEN (B.Financialreasoncode <> 'CRE7A') THEN 
									B.ExtendedUSDPrice 
								ELSE 
									0 
								END NET_BILLING_AMT 
								
								FROM BDCSQLSP.SMART_DB.dbo.DM_F_INVOICE_LN S
										LEFT OUTER JOIN BDCSQLSP.SMART_DB.dbo.BAG_BILLINGS B 
											ON S.INVOICE_NBR = B.InvoiceNumber 
												AND S.INVOICE_LN_NBR = B.InvoiceLineNumber 
												AND S.INVOICE_DT = B.InvoiceDate 
												AND (
													S.SRC_SYS_ID = B.SRC_SYS_ID 
													OR 
														(
														S.SRC_SYS_ID='BPCSMH' 
														AND B.SRC_SYS_ID IN ('BPCSM1', 'BPCSMH')
														)
													)
								WHERE S.Invoice_Ln_Key = @iRecord_ID
							)
			END
		ELSE
			Begin
			SET @ReturnAmt = (
				select
				CASE WHEN (S.SRC_SYS_ID = 'BPCSMH') THEN
					(
						(
						S.CUST_SALE_AMT + 
						S.INTER_SALE_AMT + 
						S.INTRA_SALE_AMT + 
						S.FREIGHT_AMT + 
						S.SERV_CHRG_AMT
						)+
					S.SND_ADJUST_AMT +
					S.OTH_ADJUST_AMT +
					S.CREDIT_RMA_AMT +
					S.ALLOWANCE_AMT
					)
				ELSE	
					CASE WHEN (S.SRC_SYS_ID <> 'STDMLT' OR S.INVLN_SALE_AMT = 0) THEN
						(
							(
							S.CUST_SALE_AMT + 
							S.INTER_SALE_AMT + 
							S.INTRA_SALE_AMT
							)+
						S.SND_ADJUST_AMT +
						S.OTH_ADJUST_AMT +
						S.CREDIT_RMA_AMT +
						S.ALLOWANCE_AMT
						)	
					ELSE
						(
							(S.CUST_SALE_AMT + 
							S.INTER_SALE_AMT + 
							S.INTRA_SALE_AMT)+
							S.SND_ADJUST_AMT +
							S.OTH_ADJUST_AMT +
							S.CREDIT_RMA_AMT +
							S.ALLOWANCE_AMT) * 
						   (S.TO_LOC_CURR_RATE / S.INVLN_SALE_AMT)
				END
			END
			FROM BDCSQLSP.SMART_DB.dbo.DM_F_INVOICE_LN S
				LEFT OUTER JOIN BDCSQLSP.SMART_DB.dbo.BAG_BILLINGS B ON S.INVOICE_NBR = B.InvoiceNumber 
				AND S.INVOICE_LN_NBR = B.InvoiceLineNumber 
				AND S.INVOICE_DT = B.InvoiceDate 
				AND (S.SRC_SYS_ID = B.SRC_SYS_ID OR (S.SRC_SYS_ID='BPCSMH' AND B.SRC_SYS_ID IN ('BPCSM1', 'BPCSMH')))
			Where S.INVOICE_LN_KEY = @iRecord_ID)
		End
	end
	--return (select FISCAL_PERIOD from dm_d_calendar where time_key = convert(int, convert( varchar(8), getdate(), 112)))
	return @ReturnAmt
end
GO