--select top 10 * from GLOBAL_EXTRACT_BI

DELETE FROM GLOBAL_EXTRACT_BI
WHERE EXISTS (
SELECT * FROM GLOBAL_EXTRACT_BI AS b
WHERE
b.[col1] = GLOBAL_EXTRACT_BI.[col1]
AND b.[col2] = GLOBAL_EXTRACT_BI.[col2]
AND b.[col3] = GLOBAL_EXTRACT_BI.[col3]
AND b.[col3] = GLOBAL_EXTRACT_BI.[col3]
AND b.[col3] = GLOBAL_EXTRACT_BI.[col3]
AND b.[col3] = GLOBAL_EXTRACT_BI.[col3]
AND b.[col3] = GLOBAL_EXTRACT_BI.[col3]
GROUP BY
b.[col1], b.[col2], b.[col3]
HAVING
GLOBAL_EXTRACT_BI.[RowIdentity] > MIN(b.[RowIdentity])
)



select count(*) from GLOBAL_EXTRACT_BI
WHERE EXISTS (
SELECT * FROM GLOBAL_EXTRACT_BI AS b
WHERE
b.[col1] = GLOBAL_EXTRACT_BI.[col1]
AND b.[col2] = GLOBAL_EXTRACT_BI.[col2]
AND b.[col3] = GLOBAL_EXTRACT_BI.[col3]
AND b.[col3] = GLOBAL_EXTRACT_BI.[col3]
AND b.[col3] = GLOBAL_EXTRACT_BI.[col3]
AND b.[col3] = GLOBAL_EXTRACT_BI.[col3]
AND b.[col3] = GLOBAL_EXTRACT_BI.[col3]
GROUP BY
b.[col1], b.[col2], b.[col3]
HAVING
GLOBAL_EXTRACT_BI.[RowIdentity] > MIN(b.[RowIdentity])
)
