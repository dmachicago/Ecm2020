USE TrackAnalytics
GO
SELECT [CA], [AZ], [TX]
FROM
(
SELECT sp.StateProvinceCode
FROM Person.Address a
INNER JOIN Person.StateProvince sp
ON a.StateProvinceID = sp.StateProvinceID
) p
PIVOT
(
COUNT (StateProvinceCode)
FOR StateProvinceCode
IN ([CA], [AZ], [TX])
) AS pvt;


