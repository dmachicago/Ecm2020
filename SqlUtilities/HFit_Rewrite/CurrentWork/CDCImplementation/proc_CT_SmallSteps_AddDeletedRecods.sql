
go 
print 'Executing proc_CT_SmallSteps_AddDeletedRecords.SQL'
go
if exists (select name from sys.procedures where name = 'proc_CT_SmallSteps_AddDeletedRecords')
    drop procedure proc_CT_SmallSteps_AddDeletedRecords;
go

create procedure proc_CT_SmallSteps_AddDeletedRecords
AS
DECLARE
           @DELDATE AS datetime2 ( 7 ) = GETDATE ( );
        WITH CTE_DEL (
             AccountCD
             ,SiteGUID
             ,SSItemID
             ,SSItemGUID
             ,SSHealthAssesmentUserStartedItemID
             ,SSOutcomeMessageGuid
             ,HFitUserMPINumber
             ,HACampaignNodeGUID
             ,HAStartedMode
             ,HACompletedMode
             ,HaCodeName
             ,HACampaignStartDate
             ,HACampaignEndDate )
            AS ( SELECT
                        AccountCD
                        ,SiteGUID
                        ,SSItemID
                        ,SSItemGUID
                        ,SSHealthAssesmentUserStartedItemID
                        ,SSOutcomeMessageGuid
                        ,HFitUserMPINumber
                        ,HACampaignNodeGUID
                        ,HAStartedMode
                        ,HACompletedMode
                        ,HaCodeName
                        ,HACampaignStartDate
                        ,HACampaignEndDate
                   FROM DIM_EDW_SmallSteps
                 EXCEPT
                 SELECT
                        AccountCD
                        ,SiteGUID
                        ,SSItemID
                        ,SSItemGUID
                        ,SSHealthAssesmentUserStartedItemID
                        ,SSOutcomeMessageGuid
                        ,HFitUserMPINumber
                        ,HACampaignNodeGUID
                        ,HAStartedMode
                        ,HACompletedMode
                        ,HaCodeName
                        ,HACampaignStartDate
                        ,HACampaignEndDate
                   FROM Temp_SmallSteps )
            UPDATE S
              SET
                  DeletedFlg = 1
                  ,LastModifiedDate = @DELDATE
              FROM DIM_EDW_SmallSteps AS S JOIN
                        CTE_DEL AS C
                                               ON
                   S.AccountCD = C.AccountCD
               AND S.SiteGUID = C.SiteGUID
               AND S.SSItemID = C.SSItemID
               AND S.SSItemGUID = C.SSItemGUID
               AND S.SSHealthAssesmentUserStartedItemID = C.SSHealthAssesmentUserStartedItemID
               AND S.SSOutcomeMessageGuid = C.SSOutcomeMessageGuid
               AND S.HFitUserMPINumber = C.HFitUserMPINumber
               AND S.HACampaignNodeGUID = C.HACampaignNodeGUID
               AND s.HACampaignStartDate = c.HACampaignStartDate
               AND s.HACampaignEndDate = C.HACampaignEndDate
               AND S.HAStartedMode = C.HAStartedMode
               AND S.HACompletedMode = C.HACompletedMode
               AND S.HaCodeName = C.HaCodeName;
        DECLARE
           @iDeleted AS int = @@ROWCOUNT;
    return @iDeleted ;
go 
print 'Executed proc_CT_SmallSteps_AddDeletedRecords.SQL'
go
