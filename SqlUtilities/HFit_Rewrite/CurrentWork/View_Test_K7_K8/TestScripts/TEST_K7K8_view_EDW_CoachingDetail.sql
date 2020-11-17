use KenticoCMS_PRD_prod3K7
GO 
if exists (select name from sys.tables where name = 'TEST_K7K8_view_EDW_CoachingDetail' )
BEGIN
    DROP Table TEST_K7K8_view_EDW_CoachingDetail
END
GO


--****************************************************
Select distinct top 1000 
     ItemID
    ,ItemGUID
    ,GoalID
    ,UserID
    ,UserGUID
    ,HFitUserMpiNumber
    ,SiteGUID
    ,AccountID
    ,AccountCD
    ,AccountName
    ,IsCreatedByCoach
    ,BaselineAmount
    ,GoalAmount
    ,DocumentID
    ,GoalStatusLKPID
    ,GoalStatusLKPName
    ,EvaluationStartDate
    ,EvaluationEndDate
    ,GoalStartDate
    ,CoachDescription
    ,EvaluationDate
    ,Passed
    ,WeekendDate
    ,ChangeType
    ,ItemCreatedWhen
    ,ItemModifiedWhen
    ,NodeGUID
    ,CloseReasonLKPID
    ,CloseReason
INTO KenticoCMS_PRD_prod3K7.dbo.TEST_K7K8_view_EDW_CoachingDetail
FROM
view_EDW_CoachingDetail where HFitUserMpiNumber > 0;
--****************************************************
use KenticoCMS_PRD_prod3K8
GO 
if exists (select name from sys.tables where name = 'TEST_K7K8_view_EDW_CoachingDetail' )
BEGIN
    DROP Table TEST_K7K8_view_EDW_CoachingDetail
END
GO


--****************************************************
Select distinct top 1000 
     ItemID
    ,ItemGUID
    ,GoalID
    ,UserID
    ,UserGUID
    ,HFitUserMpiNumber
    ,SiteGUID
    ,AccountID
    ,AccountCD
    ,AccountName
    ,IsCreatedByCoach
    ,BaselineAmount
    ,GoalAmount
    ,DocumentID
    ,GoalStatusLKPID
    ,GoalStatusLKPName
    ,EvaluationStartDate
    ,EvaluationEndDate
    ,GoalStartDate
    ,CoachDescription
    ,EvaluationDate
    ,Passed
    ,WeekendDate
    ,ChangeType
    ,ItemCreatedWhen
    ,ItemModifiedWhen
    ,NodeGUID
    ,CloseReasonLKPID
    ,CloseReason
INTO KenticoCMS_PRD_prod3K8.dbo.TEST_K7K8_view_EDW_CoachingDetail
FROM
view_EDW_CoachingDetail where HFitUserMpiNumber > 0;
--****************************************************
GO

select top 100 * from KenticoCMS_PRD_prod3K7.dbo.TEST_K7K8_view_EDW_CoachingDetail order by UserGuid, EvaluationDate;

select top 100 * from KenticoCMS_PRD_prod3K8.dbo.TEST_K7K8_view_EDW_CoachingDetail order by UserGuid, EvaluationDate;
