


--A recursive CTE requires four elements in order to work properly.
--Anchor query (runs once and the results ‘seed’ the Recursive query)
--Recursive query (runs multiple times and is the criteria for the remaining results)
--UNION ALL statement to bind the Anchor and Recursive queries together.
--INNER JOIN statement to bind the Recursive query to the results of the CTE.

select top 100 * from INFORMATION_SCHEMA.VIEW_TABLE_USAGE
select top 100 * from INFORMATION_SCHEMA.tables
select top 100 * from INFORMATION_SCHEMA.columns where table_name = 'view_EDW_HealthAssesment'
go

WITH mycte
	AS (SELECT TU.view_name, TU.Table_Name, IST.TABLE_TYPE
		  FROM INFORMATION_SCHEMA.VIEW_TABLE_USAGE as TU with (NOLOCK)
		  join INFORMATION_SCHEMA.tables as IST on IST.TABLE_NAME = TU.TABLE_NAME
		  WHERE view_name = 'view_EDW_HEalthAssesment'
UNION ALL

    SELECT ISV.view_name, ISV.Table_Name, IST.TABLE_TYPE
    FROM INFORMATION_SCHEMA.VIEW_TABLE_USAGE as ISV
	   join INFORMATION_SCHEMA.tables as IST on IST.TABLE_NAME = ISV.TABLE_NAME
			   INNER JOIN mycte
				ON ISV.view_name = mycte.table_name
			   --WHERE mycte.view_name = 'view_EDW_HEalthAssesment'
)

	SELECT * FROM mycte
order by view_name, table_name
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
