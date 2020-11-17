WITH CTE AS
(
SELECT TOP 10 *
FROM [EDW_GroupMemberToday]
ORDER BY HFitUserMpiNumber
)
DELETE FROM CTE
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
