--select * from STAGING_EDW_HealthAssessment where PkHashCode = '½*wÃtßóK”$ùí=!'

/* Delete Duplicate records */

WITH CTE (
     UserStartedItemID ,
     UserGUID ,
     PKHashCode ,
     DuplicateCount )
    AS (
    SELECT
           UserStartedItemID ,
           UserGUID ,
           PKHashCode ,
           ROW_NUMBER( ) OVER( PARTITION BY UserStartedItemID ,
                                            UserGUID ,
                                            PKHashCode ORDER BY UserStartedItemID , UserGUID , PKHashCode ) AS DuplicateCount
      FROM STAGING_EDW_HealthAssessment
    )
    DELETE
    FROM CTE
      WHERE
            DuplicateCount > 1;
GO


WITH CTE (
     PKHashCode ,
     DuplicateCount )
    AS (
    SELECT
           HashCode ,
           ROW_NUMBER( ) OVER( PARTITION BY HashCode ORDER BY HashCode ) AS DuplicateCount
      FROM FACT_MART_EDW_HealthAssesment
    )
    DELETE
    FROM CTE
      WHERE
            DuplicateCount > 1;
GO

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
