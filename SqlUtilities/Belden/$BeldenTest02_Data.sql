declare @sSrc_Sys_ID varchar(6)
declare @iRecord_KEY int
declare @TIME_KEY int
declare @iRecord_ID as int

set @TIME_KEY = 20100101
set @sSrc_Sys_ID = 'BPCSCO'
set @iRecord_ID = 221403

select [dbo].[nNetBillingAmt](@sSrc_Sys_ID, @iRecord_ID, @Time_Key)