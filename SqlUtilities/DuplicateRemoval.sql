use CCInfo
go
  /* Delete Duplicate records */
WITH CTE (EmailAddr,CouponID, DuplicateCount)
AS
(
SELECT EmailAddr,CouponID,
ROW_NUMBER() OVER(PARTITION BY EmailAddr,CouponID ORDER BY EmailAddr) AS DuplicateCount
FROM CouponPromoAssignment
)
DELETE
FROM CTE
WHERE DuplicateCount > 1
GO
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
