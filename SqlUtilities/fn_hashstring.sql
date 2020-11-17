
--SELECT SUBSTRING(master.dbo.fn_varbintohexstr(HashBytes('MD5', 'HelloWorld')), 3, 32)

select top 100 [query_hash],
			[query_plan_hash], 
			SUBSTRING(master.dbo.fn_varbintohexstr(HashBytes('sha1', [text])), 3, 1000) as qryhash, 
			SUBSTRING(master.dbo.fn_varbintohexstr(HashBytes('sha1', cast(query_plan as nvarchar(max)))), 3, 1000) as [planhash],
			CHECKSUM([text]) csumQryHash,
			CHECKSUM(cast(query_plan as nvarchar(max))) csumPlanHash
			from [dbo].[DFS_IO_BoundQry2000]
order by 3,4