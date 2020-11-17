

ALTER PROCEDURE proc_BASE_HFit_GoalOutcome_SYNC_KenticoCms_1_ByHash
AS WITH CTE (
        GoalOutcomeID
      ,HashCode) 
       AS (SELECT
                  GoalOutcomeID
                ,CAST (HASHBYTES ('SHA1' , ISNULL (CAST (Passed AS NVARCHAR (50)) , '-') + ISNULL (CAST (EvaluationDate AS NVARCHAR (50)) , '-') + ISNULL (CAST (UserGoalItemID AS NVARCHAR (50)) , '-') + ISNULL (CAST (IsCoachCreated AS NVARCHAR (50)) , '-') + ISNULL (CAST (Tracked AS NVARCHAR (50)) , '-')) AS NVARCHAR (100)) AS HASHCODE
           FROM dbo.BASE_HFit_GoalOutcome
           WHERE
                  DBNAME = 'KenticoCMS_1'
           EXCEPT
           SELECT
                  GoalOutcomeID
                ,CAST (HASHBYTES ('SHA1' , ISNULL (CAST (Passed AS NVARCHAR (50)) , '-') + ISNULL (CAST (EvaluationDate AS NVARCHAR (50)) , '-') + ISNULL (CAST (UserGoalItemID AS NVARCHAR (50)) , '-') + ISNULL (CAST (IsCoachCreated AS NVARCHAR (50)) , '-') + ISNULL (CAST (Tracked AS NVARCHAR (50)) , '-')) AS NVARCHAR (100)) AS HASHCODE
           FROM KenticoCMS_1.dbo.HFit_GoalOutcome) 
       UPDATE BASE
           SET
               BASE.Passed = K.Passed
             ,BASE.EvaluationDate = K.EvaluationDate
             ,BASE.WeekendDate = K.WeekendDate
             ,BASE.UserGoalItemID = K.UserGoalItemID
             ,BASE.IsCoachCreated = K.IsCoachCreated
             ,BASE.Tracked = K.Tracked
             ,BASE.GoalOutcomeID = K.GoalOutcomeID
       FROM dbo.BASE_HFit_GoalOutcome AS BASE
                 JOIN CTE C
                 ON
              C.GoalOutcomeID = BASE.GoalOutcomeID
                 JOIN KenticoCMS_1.dbo.HFit_GoalOutcome K
                 ON
              C.GoalOutcomeID = K.GoalOutcomeID;
DECLARE
@i AS INT = @@ROWCOUNT;
PRINT 'Updated: ' + CAST (@i AS NVARCHAR (50)) + ' rows from KenticoCMS_1';

--**************************************************************************
GO
ALTER PROCEDURE proc_BASE_HFit_GoalOutcome_SYNC_KenticoCms_2_ByHash
AS WITH CTE (
        GoalOutcomeID
      ,HashCode) 
       AS (SELECT
                  GoalOutcomeID
                ,CAST (HASHBYTES ('SHA1' , ISNULL (CAST (Passed AS NVARCHAR (50)) , '-') + ISNULL (CAST (EvaluationDate AS NVARCHAR (50)) , '-') + ISNULL (CAST (UserGoalItemID AS NVARCHAR (50)) , '-') + ISNULL (CAST (IsCoachCreated AS NVARCHAR (50)) , '-') + ISNULL (CAST (Tracked AS NVARCHAR (50)) , '-')) AS NVARCHAR (100)) AS HASHCODE
           FROM dbo.BASE_HFit_GoalOutcome
           WHERE
                  DBNAME = 'KenticoCMS_2'
           EXCEPT
           SELECT
                  GoalOutcomeID
                ,CAST (HASHBYTES ('SHA1' , ISNULL (CAST (Passed AS NVARCHAR (50)) , '-') + ISNULL (CAST (EvaluationDate AS NVARCHAR (50)) , '-') + ISNULL (CAST (UserGoalItemID AS NVARCHAR (50)) , '-') + ISNULL (CAST (IsCoachCreated AS NVARCHAR (50)) , '-') + ISNULL (CAST (Tracked AS NVARCHAR (50)) , '-')) AS NVARCHAR (100)) AS HASHCODE
           FROM KenticoCMS_2.dbo.HFit_GoalOutcome) 
       UPDATE BASE
           SET
               BASE.Passed = K.Passed
             ,BASE.EvaluationDate = K.EvaluationDate
             ,BASE.WeekendDate = K.WeekendDate
             ,BASE.UserGoalItemID = K.UserGoalItemID
             ,BASE.IsCoachCreated = K.IsCoachCreated
             ,BASE.Tracked = K.Tracked
             ,BASE.GoalOutcomeID = K.GoalOutcomeID
       FROM dbo.BASE_HFit_GoalOutcome AS BASE
                 JOIN CTE C
                 ON
              C.GoalOutcomeID = BASE.GoalOutcomeID
                 JOIN KenticoCMS_2.dbo.HFit_GoalOutcome K
                 ON
              C.GoalOutcomeID = K.GoalOutcomeID;

DECLARE
@i AS INT = @@ROWCOUNT;
PRINT 'Updated: ' + CAST (@i AS NVARCHAR (50)) + ' rows from KenticoCMS_2';
--********************************************************************************

GO
ALTER PROCEDURE proc_BASE_HFit_GoalOutcome_SYNC_KenticoCms_3_ByHash
AS WITH CTE (
        GoalOutcomeID
      ,HashCode) 
       AS (SELECT
                  GoalOutcomeID
                ,CAST (HASHBYTES ('SHA1' , ISNULL (CAST (Passed AS NVARCHAR (50)) , '-') + ISNULL (CAST (EvaluationDate AS NVARCHAR (50)) , '-') + ISNULL (CAST (UserGoalItemID AS NVARCHAR (50)) , '-') + ISNULL (CAST (IsCoachCreated AS NVARCHAR (50)) , '-') + ISNULL (CAST (Tracked AS NVARCHAR (50)) , '-')) AS NVARCHAR (100)) AS HASHCODE
           FROM dbo.BASE_HFit_GoalOutcome
           WHERE
                  DBNAME = 'KenticoCMS_3'
           EXCEPT
           SELECT
                  GoalOutcomeID
                ,CAST (HASHBYTES ('SHA1' , ISNULL (CAST (Passed AS NVARCHAR (50)) , '-') + ISNULL (CAST (EvaluationDate AS NVARCHAR (50)) , '-') + ISNULL (CAST (UserGoalItemID AS NVARCHAR (50)) , '-') + ISNULL (CAST (IsCoachCreated AS NVARCHAR (50)) , '-') + ISNULL (CAST (Tracked AS NVARCHAR (50)) , '-')) AS NVARCHAR (100)) AS HASHCODE
           FROM KenticoCMS_3.dbo.HFit_GoalOutcome) 
       UPDATE BASE
           SET
               BASE.Passed = K.Passed
             ,BASE.EvaluationDate = K.EvaluationDate
             ,BASE.WeekendDate = K.WeekendDate
             ,BASE.UserGoalItemID = K.UserGoalItemID
             ,BASE.IsCoachCreated = K.IsCoachCreated
             ,BASE.Tracked = K.Tracked
             ,BASE.GoalOutcomeID = K.GoalOutcomeID
       FROM dbo.BASE_HFit_GoalOutcome AS BASE
                 JOIN CTE C
                 ON
              C.GoalOutcomeID = BASE.GoalOutcomeID
                 JOIN KenticoCMS_3.dbo.HFit_GoalOutcome K
                 ON
              C.GoalOutcomeID = K.GoalOutcomeID;
DECLARE
@i AS INT = @@ROWCOUNT;
PRINT 'Updated: ' + CAST (@i AS NVARCHAR (50)) + ' rows from KenticoCMS_3';
