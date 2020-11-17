select distinct tblname from PERFMON_PullTime_HIST
where executionEndDate between '2017-01-10' and getdate()
and (InsertCount > 0 or UpdateCount > 0 or DeleteCount >0 )
order by executionEndDate desc
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
