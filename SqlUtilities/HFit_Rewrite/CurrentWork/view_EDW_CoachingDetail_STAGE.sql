
GO
PRINT '***** FROM: view_EDW_CoachingDetail_STAGE.sql';
GO

PRINT 'Processing: view_EDW_CoachingDetail_STAGED ';
GO

IF EXISTS (SELECT
                  TABLE_NAME
                  FROM INFORMATION_SCHEMA.VIEWS
                  WHERE TABLE_NAME = 'view_EDW_CoachingDetail_STAGED') 
    BEGIN
        DROP VIEW
             view_EDW_CoachingDetail_STAGED;
    END;
GO

--GRANT SELECT
--	ON [dbo].[[view_EDW_CoachingDetail_STAGED]]
--	TO [EDWReader_PRD]
--GO

/* TEST Queries
select * from [view_EDW_CoachingDetail_STAGED]
select * from [view_EDW_CoachingDetail_STAGED] where CloseReasonLKPID != 0
select count(*) from [view_EDW_CoachingDetail_STAGED]
*/

CREATE VIEW dbo.view_EDW_CoachingDetail_STAGED
AS SELECT
          ItemID
        , ItemGUID
        , GoalID
        , UserID
        , UserGUID
        , HFitUserMpiNumber
        , SiteGUID
        , AccountID
        , AccountCD
        , AccountName
        , IsCreatedByCoach
        , BaselineAmount
        , GoalAmount
        , DocumentID
        , GoalStatusLKPID
        , GoalStatusLKPName
        , EvaluationStartDate
        , EvaluationEndDate
        , GoalStartDate
        , CoachDescription
        , EvaluationDate
        , Passed
        , WeekendDate
        , ChangeType
        , ItemCreatedWhen
        , ItemModifiedWhen
        , NodeGUID
        , CloseReasonLKPID
        , CloseReason
          FROM STAGING_EDW_CoachingDetail;
GO
PRINT '***** Created: view_EDW_CoachingDetail_STAGED';
GO 

