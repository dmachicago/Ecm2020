select distinct COUNT(*), Track, Race, Horse, Date 
from TNA_DRF_HR
group by Track, Race, Horse, Date 
having COUNT(*) > 1

WITH CTE (Track, Race, Horse, Date , DuplicateCount)
AS
(
SELECT Track, Race, Horse, Date ,
ROW_NUMBER() OVER(PARTITION BY Track, Race, Horse, Date ORDER BY Track, Race, Horse, Date) AS DuplicateCount
FROM TNA_DRF_HR
)
DELETE
FROM CTE
WHERE DuplicateCount > 1
GO