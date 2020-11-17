--SELECT top 100 * FROM sys.fn_dblog(NULL,NULL)

SELECT top 100
[RowLog Contents 0],
       [RowLog Contents 1],
       [Current LSN],
       Operation,
       Context,
       [Transaction ID],
       AllocUnitId,
       AllocUnitName,
       [Page ID],
       [Slot ID]
FROM sys.fn_dblog(NULL,NULL)
WHERE Context IN ('LCX_MARK_AS_GHOST', 'LCX_HEAP', 'LCX_CLUSTERED') 
AND Operation IN ('LOP_DELETE_ROWS', 'LOP_INSERT_ROWS') 
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
