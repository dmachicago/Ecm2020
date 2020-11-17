/*
select net_billing_amt from global_bi where Invoice_Nbr = '0001494087' and src_sys_id like 'STDM%'
select Actual_amt from global_bi_v2 where Invoice_Nbr = '0001494087' and src_sys_id like 'STDM%'
select dbo.nNetBillingAmt('STDMLT', 0001494087, 20100101)
select dbo.nNetBillingAmtSummary('STDMLT', 0001494087, 20100101)
select dbo.nNetBillingAmtInvoice('STDMLT', 0001494087, 20100101)
select dbo.nNetBillingAmtV2('STDMLT', 0001494087, 20100101, 'S')
select dbo.nNetBillingAmtV2('STDMLT', 0001494087, 20100101, 'I')
*/
--select * from DM_F_SALES_SUMMARY Where Record_KEY = 0001494087
--select top 100 * from DM_F_SALES_SUMMARY Where SRC_SYS_ID like 'STDM%'
--select top 10 * from DM_F_SALES_SUMMARY Where INVLN_SALE_AMT = 0
--set @iRecordID = 1494087    --BPCSCO  (this is the key that started the testing)
--set @iRecordID = 1551338    --BPCSMH
--set @iRecordID = NULL       --STDMLT
--set @iRecordID = 207        --INVLN_SALE_AMT = 0

/* Test 01 */
select * from tView where Record_Key = 1494087
select * from tView where Record_Key = 207
select * from tView where Record_Key = 1551338

/* Test 02 */
select * from tView where Record_Key = 1494087 
and src_sys_id like 'STDM%'

/* Test 03 */
select dbo.nNetBillingAmt('STDM%', 0001494087, 20100101)

alter view tView as 
--declare @iRecord_ID int 
--set @iRecord_ID = 207
		select
			CASE WHEN (SRC_SYS_ID = 'BPCSMH') THEN
				(
				CUST_SALE_AMT + 
				INTER_SALE_AMT + 
				INTRA_SALE_AMT + 
				FREIGHT_AMT + 
				SERV_CHRG_AMT +					
				SND_ADJUST_AMT +
				OTH_ADJUST_AMT +
				CREDIT_RMA_AMT +
				ALLOWANCE_AMT
				)
			ELSE	
				CASE WHEN (SRC_SYS_ID <> 'STDMLT' OR INVLN_SALE_AMT = 0) THEN
					(
					CUST_SALE_AMT + 
					INTER_SALE_AMT + 
					INTRA_SALE_AMT +
					SND_ADJUST_AMT +
					OTH_ADJUST_AMT +
					CREDIT_RMA_AMT +
					ALLOWANCE_AMT
					)	
				ELSE
					(
					CUST_SALE_AMT + 
					INTER_SALE_AMT + 
					INTRA_SALE_AMT +
					SND_ADJUST_AMT +
					OTH_ADJUST_AMT +
					CREDIT_RMA_AMT +
					ALLOWANCE_AMT
					) * (TO_LOC_CURR_RATE / INVLN_SALE_AMT)
			END
		END NetBillingAmt,
		SRC_SYS_ID,
		Record_Key
		from DM_F_SALES_SUMMARY
		--Where Record_KEY = @iRecord_ID