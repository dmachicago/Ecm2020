USE [SMART]
GO
/****** Object:  UserDefinedFunction [dbo].[nNetBillingAmt]    Script Date: 11/02/2010 09:15:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
10/18/2010 - Added the calcualted variable @Calc_Time_key so that the procedure would not have to be modified every year. SDM
*/
ALTER  Function [dbo].[nNetBillingAmt](
				@sSrc_Sys_ID as varchar(6), 
				@iRecord_ID as int, 
				@Time_Key as int)
RETURNS numeric (38,6)
as 
begin
	declare @ReturnAmt as numeric (38,6)
	declare @Calc_Time_key as int
	set @Calc_Time_key = cast(cast(datepart(year,getdate()) as varchar) + '0101' as int)

	--if @sSrc_Sys_Id IN ('BPCSCO', 'BPCSRI') OR (@sSrc_Sys_Id='BPCSMH' AND @Time_Key >= 20100101) /*Changed to below SDM*/
    if @sSrc_Sys_Id IN ('BPCSCO', 'BPCSRI') OR (@sSrc_Sys_Id='BPCSMH' AND @Time_Key >= @Calc_Time_key)
	BEGIN
		SET @ReturnAmt = (							
							select  
							CASE WHEN (B.Financialreasoncode <> 'CRE7A') THEN 
								B.ExtendedUSDPrice 
							ELSE 0 
							END NET_BILLING_AMT 
								FROM BDCSQLSP.SMART_DB.dbo.DM_F_INVOICE_LN S
									LEFT OUTER JOIN BDCSQLSP.SMART_DB.dbo.BAG_BILLINGS B 
										ON S.INVOICE_NBR = B.InvoiceNumber 
											AND S.INVOICE_LN_NBR = B.InvoiceLineNumber 
											AND S.INVOICE_DT = B.InvoiceDate 
											AND (S.SRC_SYS_ID = B.SRC_SYS_ID 
												OR (S.SRC_SYS_ID='BPCSMH' AND B.SRC_SYS_ID IN ('BPCSM1', 'BPCSMH')))								
								WHERE S.Invoice_Ln_Key = @iRecord_ID
								--SDM Added line below 11/02/2010											
								AND B.Entity_ID IN ('Richmond', 'Canada', 'Mohawk') AND B.InvoiceDate > '01/01/2010')
	END
	/* Change here */
	else if  (@sSrc_Sys_Id =('BPCSMH') AND @Time_Key < @Calc_Time_key) OR @sSrc_Sys_Id IN ('THERMX', 'BPCSAL', 'STDMWP')
	begin
		/*****Begin IF 2 ******/
		SET @ReturnAmt = (
			select --top 1 /* ADDED TOP 1 to avoid the return of multiple records here 11/02/2010 SDM */
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
					(S.TO_LOC_CURR_RATE / 
						S.INVLN_SALE_AMT)
			END
		END
		from BDCSQLSP.SMART_DB.dbo.DM_F_SALES_SUMMARY S
		Where S.Record_KEY = @iRecord_ID)
		/*****End IF 2 ******/
	end
	ELSE
	Begin
		SET @ReturnAmt = (
			select --top 1 /* ADDED TOP 1 to avoid the return of multiple records here 11/02/2010 SDM */
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
					(S.TO_LOC_CURR_RATE / 
						S.INVLN_SALE_AMT)
			END
		END
		from SMART_GLOBAL_DW.dbo.DM_F_SALES_SUMMARY S
		Where S.Record_KEY = @iRecord_ID)
	End
	--return (select FISCAL_PERIOD from dm_d_calendar where time_key = convert(int, convert( varchar(8), getdate(), 112)))
	return @ReturnAmt
end
