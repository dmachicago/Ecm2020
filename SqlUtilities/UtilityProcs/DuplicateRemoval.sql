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