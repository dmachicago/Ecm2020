use KenticoCMS_PRD_prod3K7
GO 
if exists (select name from sys.tables where name = 'TEST_K7K8_view_EDW_SmallStepResponses' )
BEGIN
    DROP Table TEST_K7K8_view_EDW_SmallStepResponses
END
GO


--****************************************************
Select DISTINCT top 100 
     UserID
    ,AccountCD
    ,SiteGUID
    ,SSItemID
    ,SSItemCreatedBy
    ,SSItemCreatedWhen
    ,SSItemModifiedBy
    ,SSItemModifiedWhen
    ,SSItemOrder
    ,SSItemGUID
    ,SSHealthAssesmentUserStartedItemID
    ,SSOutcomeMessageGuid
    ,SSOutcomeMessage
    ,HACampaignNodeGUID
    ,HACampaignName
    ,HACampaignStartDate
    ,HACampaignEndDate
    ,HAStartedDate
    ,HACompletedDate
    ,HAStartedMode
    ,HACompletedMode
    ,HaCodeName
    ,HFitUserMPINumber
INTO KenticoCMS_PRD_prod3K7.dbo.TEST_K7K8_view_EDW_SmallStepResponses
FROM
view_EDW_SmallStepResponses;
--****************************************************
use KenticoCMS_PRD_prod3K8
GO 
if exists (select name from sys.tables where name = 'TEST_K7K8_view_EDW_SmallStepResponses' )
BEGIN
    DROP Table TEST_K7K8_view_EDW_SmallStepResponses
END
GO


--****************************************************
Select DISTINCT top 100 
     UserID
    ,AccountCD
    ,SiteGUID
    ,SSItemID
    ,SSItemCreatedBy
    ,SSItemCreatedWhen
    ,SSItemModifiedBy
    ,SSItemModifiedWhen
    ,SSItemOrder
    ,SSItemGUID
    ,SSHealthAssesmentUserStartedItemID
    ,SSOutcomeMessageGuid
    ,SSOutcomeMessage
    ,HACampaignNodeGUID
    ,HACampaignName
    ,HACampaignStartDate
    ,HACampaignEndDate
    ,HAStartedDate
    ,HACompletedDate
    ,HAStartedMode
    ,HACompletedMode
    ,HaCodeName
    ,HFitUserMPINumber
INTO KenticoCMS_PRD_prod3K8.dbo.TEST_K7K8_view_EDW_SmallStepResponses
FROM
view_EDW_SmallStepResponses;
--****************************************************
GO

select top 100 * from KenticoCMS_PRD_prod3K7.dbo.TEST_K7K8_view_EDW_SmallStepResponses order by UserID, HACompletedDate;

select top 100 * from KenticoCMS_PRD_prod3K8.dbo.TEST_K7K8_view_EDW_SmallStepResponses order by UserID, HACompletedDate;

--update HFit_EDW_K7K8_TestDDL set Passed = 1 where VIEW_NAME = 'view_EDW_SmallStepResponses'; 