
--A recursive CTE requires four elements in order to work properly.
--Anchor query (runs once and the results ‘seed’ the Recursive query)
--Recursive query (runs multiple times and is the criteria for the remaining results)
--UNION ALL statement to bind the Anchor and Recursive queries together.
--INNER JOIN statement to bind the Recursive query to the results of the CTE.

WITH mycte
	AS (SELECT
			   empid
			 , firstname
			 , lastname
			 , managerid
			   FROM employee
			   WHERE managerid IS NULL
		UNION ALL
		SELECT
			   empid
			 , firstname
			 , lastname
			 , managerid
			   FROM
					employee INNER JOIN mycte
							ON employee.managerid = mycte.empid
			   WHERE employee.managerid IS NOT NULL) 
	SELECT
		   *
		   FROM mycte;
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
