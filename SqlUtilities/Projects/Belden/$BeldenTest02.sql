/*
select top 10 * from BDCSQLSP.SMART_DB.dbo.DM_F_INVOICE_LN
where SRC_SYS_ID = 'BPCSCO'
and INVOICE_LN_KEY = 221403
*/
--and Financialreasoncode <> 'CRE7A'

declare @sSrc_Sys_ID varchar(6)
declare @iRecord_KEY int
declare @TIME_KEY int
declare @iRecord_ID as int

set @TIME_KEY = 20100101
set @sSrc_Sys_ID = 'BPCSCO'
set @iRecord_ID = 221403

declare @ReturnAmt as numeric (38,6)
	declare @Calc_Time_key as int
	set @Calc_Time_key = cast(cast(datepart(year,getdate()) as varchar) + '0101' as int)
	--select NetBillingAmt 
	
    if @sSrc_Sys_Id IN ('BPCSCO', 'BPCSRI') OR (@sSrc_Sys_Id='BPCSMH' AND @Time_Key >= 20100101)
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
				WHERE S.Invoice_Ln_Key = @iRecord_ID)
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
					(S.TO_LOC_CURR_RATE / 
						S.INVLN_SALE_AMT)
			END
		END
		from DM_F_SALES_SUMMARY S
		Where S.Record_KEY = @iRecord_ID)
	End