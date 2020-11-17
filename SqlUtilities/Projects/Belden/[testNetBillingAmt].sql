
alter Function [dbo].[testNetBillingAmt](@sSrc_Sys_ID as varchar, @iRecord_ID as int, @Time_Key as int)
RETURNS numeric
as 
begin
	declare @ReturnAmt as numeric
	--select NetBillingAmt 
	
	if @sSrc_Sys_Id IN ('BPCSCO', 'BPCSRI') OR (@sSrc_Sys_Id='BPCSMH' AND @Time_Key >= 20100101)
	BEGIN
		SET @ReturnAmt = (select 
			CASE WHEN (B.Financialreasoncode <> 'CRE7A') THEN 
				B.ExtendedUSDPrice 
			ELSE 0 
			END NET_BILLING_AMT 
				FROM BDCSQLSP.SMART_DB.dbo.DM_F_INVOICE_LN S
			LEFT OUTER JOIN BDCSQLSP.SMART_DB.dbo.BAG_BILLINGS B 
				ON S.INVOICE_NBR = B.InvoiceNumber AND S.INVOICE_LN_NBR = B.InvoiceLineNumber AND S.INVOICE_DT = B.InvoiceDate 
					AND (S.SRC_SYS_ID = B.SRC_SYS_ID 
					OR (S.SRC_SYS_ID='BPCSMH' 
					AND B.SRC_SYS_ID IN ('BPCSM1', 'BPCSMH')))
			WHERE S.Invoice_Ln_Key = @iRecord_ID)
	END
	/*
	ELSE
		select 
		CASE WHEN (S.SRC_SYS_ID <> 'STDMLT' OR S.INVLN_SALE_AMT = 0) THEN
			CASE WHEN ((S.CUST_SALE_AMT + S.INTER_SALE_AMT + S.INTRA_SALE_AMT <> 0 AND S.FREIGHT_AMT <> 0) AND (I.SRC_SYS_ID='BPCSRI' OR I.SRC_SYS_ID='BPCSCO')) THEN 
				((S.CUST_SALE_AMT + S.INTER_SALE_AMT + S.INTRA_SALE_AMT - FREIGHT_AMT)+S.SND_ADJUST_AMT+S.OTH_ADJUST_AMT+S.CREDIT_RMA_AMT+S.ALLOWANCE_AMT)
			ELSE
				CASE WHEN ((S.CREDIT_RMA_AMT <> 0 AND S.SERV_CHRG_AMT <> 0) AND (I.SRC_SYS_ID='BPCSRI' OR I.SRC_SYS_ID='BPCSCO')) THEN
					0
				ELSE
					((S.CUST_SALE_AMT + S.INTER_SALE_AMT + S.INTRA_SALE_AMT)+S.SND_ADJUST_AMT+S.OTH_ADJUST_AMT+S.CREDIT_RMA_AMT+S.ALLOWANCE_AMT)
				END			
			END		
		ELSE
			((S.CUST_SALE_AMT + S.INTER_SALE_AMT + S.INTRA_SALE_AMT)+S.SND_ADJUST_AMT+S.OTH_ADJUST_AMT+S.CREDIT_RMA_AMT+S.ALLOWANCE_AMT) * (S.TO_LOC_CURR_RATE / S.INVLN_SALE_AMT)
		END
	END NET_BILLING_AMT,

		
			CASE WHEN (B.Financialreasoncode <> 'CRE7A') THEN 
				B.ExtendedUSDPrice 
			ELSE 0 
			END NET_BILLING_AMT 
				FROM BDCSQLSP.SMART_DB.dbo.DM_F_INVOICE_LN S
			LEFT OUTER JOIN BDCSQLSP.SMART_DB.dbo.BAG_BILLINGS B 
				ON S.INVOICE_NBR = B.InvoiceNumber AND S.INVOICE_LN_NBR = B.InvoiceLineNumber AND S.INVOICE_DT = B.InvoiceDate 
					AND (S.SRC_SYS_ID = B.SRC_SYS_ID 
					OR (S.SRC_SYS_ID='BPCSMH' 
					AND B.SRC_SYS_ID IN ('BPCSM1', 'BPCSMH')))
			WHERE S.Invoice_Ln_Key = @iRecord_ID
	END
*/
	--return (select FISCAL_PERIOD from dm_d_calendar where time_key = convert(int, convert( varchar(8), getdate(), 112)))
	return @ReturnAmt
end
GO