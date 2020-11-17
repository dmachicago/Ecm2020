
--select * From HFit_LKP_HES_AwardType
--select * From HFit_LKP_RewardTrigger

GO
PRINT 'FROM view_EDW_Awards';
PRINT 'Creating view_EDW_Awards';
GO
IF EXISTS (SELECT
                  name
                  FROM sys.views
                  WHERE name = 'view_EDW_Awards') 
    BEGIN
        DROP VIEW
             view_EDW_Awards;
    END;
GO
CREATE VIEW view_EDW_Awards
AS

--*************************************************************************************
-- 2.3.2015 : WDM - Created the initial view for Awards (HEW)
-- 2.3.2015 : WDM - Laura B. had objections as to how the data was pulled, Nate agreed
--					to look at it again.
--*************************************************************************************

SELECT
       AWARD.ItemID
     , AWARD.ItemCreatedBy
     , CAST (AWARD.ItemCreatedWhen AS datetime) AS ItemCreatedWhen
     , AWARD.ItemModifiedBy
     , CAST (AWARD.ItemModifiedWhen AS datetime) AS ItemModifiedWhen
     , AWARD.ItemOrder
     , AWARD.ItemGUID
     , AWARD.UserID
     , CAST (AWARD.EventDate AS datetime) AS EventDate
     , AWARD.RewardTriggerID
     , AWARD.[Value]
     , AWARD.Challenge_GUID
     , AWARD.HESAwardID
     , ATYPE.AwardType
     , ATRIGGER.RewardTriggerLKPName
     , ATRIGGER.RewardTriggerRewardActivityLKPID
     , ATRIGGER.RewardTriggerLKPDisplayName
     , ATRIGGER.HESCode
       FROM
            HFit_HES_Award AS AWARD
                JOIN HFit_LKP_RewardTrigger AS ATRIGGER
                ON AWARD.RewardTriggerID = ATRIGGER.RewardTriggerLKPID
                JOIN HFit_LKP_HES_AwardType AS ATYPE
                ON AWARD.HESAwardID = ATYPE.itemID;
GO
PRINT 'Created view_EDW_Awards';
GO

