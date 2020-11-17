

go 
print 'Executing proc_CT_SmallSteps_AddUpdatedRecs.SQL'
go
if exists (select name from sys.procedures where name = 'proc_CT_SmallSteps_AddUpdatedRecs')    
    drop procedure proc_CT_SmallSteps_AddUpdatedRecs;
go

create procedure proc_CT_SmallSteps_AddUpdatedRecs
AS
DECLARE
		  @RUNDATE AS datetime2 ( 7 ) = GETDATE ( );

        UPDATE S
          SET
              S.UserID = T.UserID
              ,S.AccountCD = T.AccountCD
              ,S.SiteGUID = T.SiteGUID
              ,S.SSItemID = T.SSItemID
              ,S.SSItemCreatedBy = T.SSItemCreatedBy
              ,S.SSItemCreatedWhen = T.SSItemCreatedWhen
              ,S.SSItemModifiedBy = T.SSItemModifiedBy
              ,S.SSItemModifiedWhen = T.SSItemModifiedWhen
              ,S.SSItemOrder = T.SSItemOrder
              ,S.SSItemGUID = T.SSItemGUID
              ,S.SSHealthAssesmentUserStartedItemID = T.SSHealthAssesmentUserStartedItemID
              ,S.SSOutcomeMessageGuid = T.SSOutcomeMessageGuid
              ,S.SSOutcomeMessage = T.SSOutcomeMessage
              ,S.HACampaignNodeGUID = T.HACampaignNodeGUID
              ,S.HACampaignName = T.HACampaignName
              ,S.HACampaignStartDate = T.HACampaignStartDate
              ,S.HACampaignEndDate = T.HACampaignEndDate
              ,S.HAStartedDate = T.HAStartedDate
              ,S.HACompletedDate = T.HACompletedDate
              ,S.HAStartedMode = T.HAStartedMode
              ,S.HACompletedMode = T.HACompletedMode
              ,S.HaCodeName = T.HaCodeName
              ,S.HFitUserMPINumber = T.HFitUserMPINumber
              ,S.HashCode = T.HashCode
              ,S.ChangeType = 'U'
              ,S.LastModifiedDate = GETDATE ( )
              ,S.DeletedFlg = NULL
              ,S.ConvertedToCentralTime = NULL
          FROM ##Temp_SmallSteps AS T JOIN
                    DIM_EDW_SmallSteps AS S
                                    ON
                   S.AccountCD = T.AccountCD
               AND S.SiteGUID = T.SiteGUID
               AND S.SSItemID = T.SSItemID
               AND S.SSItemGUID = T.SSItemGUID
               AND S.SSHealthAssesmentUserStartedItemID = T.SSHealthAssesmentUserStartedItemID
               AND S.SSOutcomeMessageGuid = T.SSOutcomeMessageGuid
               AND S.HFitUserMPINumber = T.HFitUserMPINumber
               AND S.HACampaignNodeGUID = T.HACampaignNodeGUID
               AND S.HAStartedMode = T.HAStartedMode
               AND S.HACompletedMode = T.HACompletedMode
               AND S.HaCodeName = T.HaCodeName
               AND S.HACampaignStartDate = t.HACampaignStartDate
               AND S.HACampaignEndDate = t.HACampaignEndDate
           AND S.HASHCODE != T.HASHCODE
           AND S.DeletedFlg IS NULL;
        DECLARE
           @iUpdated AS int = + @@ROWCOUNT;
    RETURN @iUpdated  ;
go 
print 'Executed proc_CT_SmallSteps_AddUpdatedRecs.SQL'
go
