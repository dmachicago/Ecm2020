--select * from DM_F_SALES_SUMMARY Where Record_KEY = 0001494087
--select top 10 * from DM_F_SALES_SUMMARY Where SRC_SYS_ID = 'STDMLT'
--select top 10 * from DM_F_SALES_SUMMARY Where INVLN_SALE_AMT = 0

declare @iRecord_ID int 
--set @iRecordID = 1494087    --BPCSCO
--set @iRecordID = 1551338    --BPCSMH
--set @iRecordID = NULL       --STDMLT
--set @iRecordID = 207        --INVLN_SALE_AMT = 0
set @iRecord_ID = 207
		select
			CASE WHEN (S.SRC_SYS_ID = 'BPCSMH') THEN
				(
				S.CUST_SALE_AMT + 
				S.INTER_SALE_AMT + 
				S.INTRA_SALE_AMT + 
				S.FREIGHT_AMT + 
				S.SERV_CHRG_AMT +					
				S.SND_ADJUST_AMT +
				S.OTH_ADJUST_AMT +
				S.CREDIT_RMA_AMT +
				S.ALLOWANCE_AMT
				)
			ELSE	
				CASE WHEN (S.SRC_SYS_ID <> 'STDMLT' OR S.INVLN_SALE_AMT = 0) THEN
					(
					S.CUST_SALE_AMT + 
					S.INTER_SALE_AMT + 
					S.INTRA_SALE_AMT +
					S.SND_ADJUST_AMT +
					S.OTH_ADJUST_AMT +
					S.CREDIT_RMA_AMT +
					S.ALLOWANCE_AMT
					)	
				ELSE
					(
					S.CUST_SALE_AMT + 
					S.INTER_SALE_AMT + 
					S.INTRA_SALE_AMT +
					S.SND_ADJUST_AMT +
					S.OTH_ADJUST_AMT +
					S.CREDIT_RMA_AMT +
					S.ALLOWANCE_AMT
					) * (S.TO_LOC_CURR_RATE / S.INVLN_SALE_AMT)
			END
		END
		from DM_F_SALES_SUMMARY S
		Where S.Record_KEY = @iRecord_ID