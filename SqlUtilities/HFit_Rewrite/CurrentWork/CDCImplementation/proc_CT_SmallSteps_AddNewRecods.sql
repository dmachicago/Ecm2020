
go 
print 'Executing proc_CT_SmallSteps_AddNewRecs.SQL'
go

if exists (select name from sys.procedures where name = 'proc_CT_SmallSteps_AddNewRecs')    
    drop procedure proc_CT_SmallSteps_AddNewRecs;
go
--exec proc_CT_SmallSteps_AddNewRecs
create procedure proc_CT_SmallSteps_AddNewRecs
as
WITH CTE_NEW (HFitUserMPINumber, HashCode )
            AS ( SELECT
                        HFitUserMPINumber, HashCode
                   FROM ##Temp_SmallSteps
                 EXCEPT
                 SELECT
                        HFitUserMPINumber, HashCode
                   FROM dbo.DIM_EDW_SmallSteps
                   WHERE DeletedFlg is null )
            INSERT INTO DIM_EDW_SmallSteps
            (
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
                   ,DeletedFlg
                   ,LastModifiedDate
                   ,HashCode
                   ,ChangeType
                   ,CT_UserSettingsID
                   ,CT_CMS_UserSettings_SCV
                   ,SiteID_CtID
                   ,SiteID_CHANGE_OPERATION
                   ,SITE_SCV
                   ,Campaign_CtID
                   ,Campaign_SCV
                   ,HealthAssesmentUserStarted_CtID
                   ,HealthAssesmentUserStarted_SCV
                   ,OutComeMessages_CtID
                   ,OutComeMessages_SCV
                   ,HFit_Account_CtID
                   ,HFit_Account_SCV
                   ,ToDoSmallSteps_CtID
                   ,ToDoSmallSteps_SCV
                   ,CT_UserSettings_CHANGE_OPERATION
                   ,Campaign_CHANGE_OPERATION
                   ,HealthAssesmentUserStarted_CHANGE_OPERATION
                   ,OutComeMessages_CHANGE_OPERATION
                   ,HFit_Account_CHANGE_OPERATION
                   ,ToDoSmallSteps_CHANGE_OPERATION
                   ,SmallStepResponses_CtID
                   ,SmallStepResponses_SCV
                   ,SmallStepResponses_CHANGE_OPERATION
                   --,RowNbr
                   ,TimeZone
                   ,ConvertedToCentralTime )
            SELECT
                   T.UserID
                   ,T.AccountCD
                   ,T.SiteGUID
                   ,T.SSItemID
                   ,T.SSItemCreatedBy
                   ,T.SSItemCreatedWhen
                   ,T.SSItemModifiedBy
                   ,T.SSItemModifiedWhen
                   ,T.SSItemOrder
                   ,T.SSItemGUID
                   ,T.SSHealthAssesmentUserStartedItemID
                   ,T.SSOutcomeMessageGuid
                   ,T.SSOutcomeMessage
                   ,T.HACampaignNodeGUID
                   ,T.HACampaignName
                   ,T.HACampaignStartDate
                   ,T.HACampaignEndDate
                   ,T.HAStartedDate
                   ,T.HACompletedDate
                   ,T.HAStartedMode
                   ,T.HACompletedMode
                   ,T.HaCodeName
                   ,T.HFitUserMPINumber
                   ,null AS DeletedFlg
                   ,null as LastModifiedDate
                   ,T.HashCode
                   ,T.ChangeType
                   ,T.CT_UserSettingsID
                   ,T.CT_CMS_UserSettings_SCV
                   ,T.SiteID_CtID
                   ,T.SiteID_CHANGE_OPERATION
                   ,T.SITE_SCV
                   ,T.Campaign_CtID
                   ,T.Campaign_SCV
                   ,T.HealthAssesmentUserStarted_CtID
                   ,T.HealthAssesmentUserStarted_SCV
                   ,T.OutComeMessages_CtID
                   ,T.OutComeMessages_SCV
                   ,T.HFit_Account_CtID
                   ,T.HFit_Account_SCV
                   ,T.ToDoSmallSteps_CtID
                   ,T.ToDoSmallSteps_SCV
                   ,T.CT_UserSettings_CHANGE_OPERATION
                   ,T.Campaign_CHANGE_OPERATION
                   ,T.HealthAssesmentUserStarted_CHANGE_OPERATION
                   ,T.OutComeMessages_CHANGE_OPERATION
                   ,T.HFit_Account_CHANGE_OPERATION
                   ,T.ToDoSmallSteps_CHANGE_OPERATION
                   ,T.SmallStepResponses_CtID
                   ,T.SmallStepResponses_SCV
                   ,T.SmallStepResponses_CHANGE_OPERATION
                   --,NULL AS RowNbr
                   ,NULL AS TimeZone
                   ,NULL AS ConvertedToCentralTime
              FROM
                   ##Temp_SmallSteps AS T JOIN
                        CTE_NEW AS C
                                        ON
				T.HFitUserMPINumber = C.HFitUserMPINumber
				AND T.HashCode = C.HashCode;

        DECLARE
           @iInserted AS int = @@ROWCOUNT;
	   PRINT 'Records Added: ' + CAST ( @iInserted AS nvarchar( 5 ));
	   return @iInserted ;
go 
print 'Executed proc_CT_SmallSteps_AddNewRecs.SQL'
go
