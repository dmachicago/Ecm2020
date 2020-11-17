

go
Print 'Creating view_EDW_SmallStepResponses_STAGED.sql' ;
go

if exists (select name from sys.views where name = 'view_EDW_SmallStepResponses_STAGED')
 drop view view_EDW_SmallStepResponses_STAGED ;
go

create view view_EDW_SmallStepResponses_STAGED as 
SELECT [UserID]
      ,[AccountCD]
      ,[SiteGUID]
      ,[SSItemID]
      ,[SSItemCreatedBy]
      ,[SSItemCreatedWhen]
      ,[SSItemModifiedBy]
      ,[SSItemModifiedWhen]
      ,[SSItemOrder]
      ,[SSItemGUID]
      ,[SSHealthAssesmentUserStartedItemID]
      ,[SSOutcomeMessageGuid]
      ,[SSOutcomeMessage]
      ,[HACampaignNodeGUID]
      ,[HACampaignName]
      ,[HACampaignStartDate]
      ,[HACampaignEndDate]
      ,[HAStartedDate]
      ,[HACompletedDate]
      ,[HAStartedMode]
      ,[HACompletedMode]
      ,[HaCodeName]
      ,[HFitUserMPINumber]
  FROM [dbo].STAGING_EDW_SmallSteps
GO


Print 'Created view_EDW_SmallStepResponses_STAGED' ;
go
