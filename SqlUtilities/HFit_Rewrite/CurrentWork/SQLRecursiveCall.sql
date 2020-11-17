
WITH CTE_TBL(ParentClassID,ClassID,ClassCode,LEVEL)
AS
(
    SELECT ParentClassID,ClassID,ClassCode,0 AS LEVEL FROM dbo.Classification WHERE ParentClassID is null
    UNION ALL
    SELECT Classification.ParentClassID,Classification.ClassID,Classification.ClassCode,Level + 1 AS LEVEL 
		FROM dbo.Classification
    INNER JOIN CTE_TBL AS smr ON smr.ClassID = dbo.Classification.ParentClassID
)
SELECT ParentClassID,ClassID,ClassCode,LEVEL FROM CTE_TBL
--where (classID = 56 or classID = 11 or ParentClassID = 56)
order by cast([ParentClassID] as int), ClassCode†ⴭ†਍†ⴭ†਍佇ഠ瀊楲瑮✨⨪⨪‪剆䵏›兓剌捥牵楳敶慃汬献汱⤧※਍佇ഠ�