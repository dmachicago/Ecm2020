
GO

PRINT 'Execute proc_CT_EDW_CoachingDetail_NoDups.sql';
GO

IF EXISTS (SELECT
                  name
                  FROM sys.procedures
                  WHERE name = 'proc_CT_EDW_CoachingDetail_NoDups') 
    BEGIN
        DROP PROCEDURE
             proc_CT_EDW_CoachingDetail_NoDups
    END;
GO

-- exec proc_CT_EDW_CoachingDetail_NoDups

CREATE PROCEDURE proc_CT_EDW_CoachingDetail_NoDups
AS
BEGIN

/*------------------------
 Delete Duplicate records 
*/
    WITH CTE (
         ItemID
       , ItemGUID
       , GoalID
       , UserGUID
       , SiteGUID
       , AccountID
       , AccountCD
       , WeekendDate
       , NodeGUID, DuplicateCount) 
        AS (   SELECT
                      ItemID
                    , ItemGUID
                    , GoalID
                    , UserGUID
                    , SiteGUID
                    , AccountID
                    , AccountCD
                    , WeekendDate
                    , NodeGUID
                    , ROW_NUMBER () OVER (PARTITION BY   ItemID
                                                       , ItemGUID
                                                       , GoalID
                                                       , UserGUID
                                                       , SiteGUID
                                                       , AccountID
                                                       , AccountCD
                                                       , WeekendDate
                                                       , NodeGUID
                      ORDER BY   ItemID
                      , ItemGUID
                      , GoalID
                      , UserGUID
                      , SiteGUID
                      , AccountID
                      , AccountCD
                      , WeekendDate
                      , NodeGUID) AS DuplicateCount
                      FROM DIM_EDW_CoachingDetail
        ) 
        DELETE
        FROM CTE
               WHERE
                     DuplicateCount > 1;
END;
GO
PRINT 'Executed proc_CT_EDW_CoachingDetail_NoDups.sql';
GO
