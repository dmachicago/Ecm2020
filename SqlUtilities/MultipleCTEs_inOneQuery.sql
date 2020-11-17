
multiple CTEs in one query, as well as reuse a CTE:

WITH    cte1 AS
        (
        SELECT  1 AS id
        ),
        cte2 AS
        (
        SELECT  2 AS id
        )
SELECT  *
FROM    cte1
UNION ALL
SELECT  *
FROM    cte2
UNION ALL
SELECT  *
FROM    cte1