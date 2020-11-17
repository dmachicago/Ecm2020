go
print('Creating [view_EDW_RewardUserDetail]') ;
go

if exists (select table_name from information_schema.tables where table_name = 'view_EDW_RewardUserDetail')
BEGIN
    print('Updating [view_EDW_RewardUserDetail]') ;
    drop view view_EDW_RewardUserDetail ;
END
go

CREATE VIEW [dbo].[view_EDW_RewardUserDetail]
AS 
SELECT DISTINCT
--02.03.2015 : LevelName, LevelHeader, GroupHeadingText, GroupHeadingDescription
   [cu].[UserGUID]
 , [CS2].[SiteGUID]
 , [cus2].[HFitUserMpiNumber]
 , [VHFRAJ].[RewardActivityID]
 , [VHFRPJ].[RewardProgramName]
 , [VHFRPJ].[RewardProgramID]
 , [VHFRPJ].[RewardProgramPeriodStart]
 , [VHFRPJ].[RewardProgramPeriodEnd]
 , [VHFRPJ].[DocumentModifiedWhen] AS [RewardModifiedDate]
 , [VHFRGJ].[GroupName]
 , [VHFRGJ].[RewardGroupID]
 , [VHFRGJ].[RewardGroupPeriodStart]
 , [VHFRGJ].[RewardGroupPeriodEnd]
 , [VHFRGJ].[DocumentModifiedWhen] AS [RewardGroupModifieDate]
 , [RL_Joined].[Level]
 , [HFLRLT].[RewardLevelTypeLKPName]
 , [RL_Joined].[DocumentModifiedWhen] AS [RewardLevelModifiedDate]
 , [HFRULD].[LevelCompletedDt]
 , [HFRULD].[LevelVersionHistoryID]
 , [RL_Joined].[RewardLevelPeriodStart]
 , [RL_Joined].[RewardLevelPeriodEnd]
 , [VHFRAJ].[ActivityName]
 , [HFRUAD].[ActivityPointsEarned]
 , [HFRUAD].[ActivityCompletedDt]
 , [HFRUAD].[ActivityVersionID]
 , [HFRUAD].[ItemModifiedWhen] AS [RewardActivityModifiedDate]
 , [VHFRAJ].[RewardActivityPeriodStart]
 , [VHFRAJ].[RewardActivityPeriodEnd]
 , [VHFRAJ].[ActivityPoints]
 , [HFRE].[UserAccepted]
 , [HFRE].[UserExceptionAppliedTo]
 , [HFRE].[ItemModifiedWhen] AS [RewardExceptionModifiedDate]
 , [VHFRTJ].[TriggerName]
 , [VHFRTJ].[RewardTriggerID]
 , [HFLRT2].[RewardTriggerLKPDisplayName]
 , [HFLRT2].[RewardTriggerDynamicValue]
 , [HFLRT2].[ItemModifiedWhen] AS [RewardTriggerModifiedDate]
 , [HFLRT].[RewardTypeLKPName]
 , [HFA].[AccountID]
 , [HFA].[AccountCD]
 , CASE
	  WHEN CAST ([HFRULD].[ItemCreatedWhen] AS date) = CAST ([HFRULD].[ItemModifiedWhen] AS date) 
	  THEN 'I'
	  ELSE 'U'
   END AS [ChangeType]
 , [HFRULD].[ItemCreatedWhen]
 , [HFRULD].[ItemModifiedWhen]

 , [RL_Joined].[LevelName]
 , [RL_Joined].[LevelHeader]
 , [RL_Joined].[GroupHeadingText]
 , [RL_Joined].[GroupHeadingDescription]

	FROM
		[dbo].[View_HFit_RewardProgram_Joined] AS [VHFRPJ]  
		    LEFT OUTER JOIN [dbo].[View_HFit_RewardGroup_Joined] AS [VHFRGJ]  
			   ON [VHFRPJ].[NodeID] = [VHFRGJ].[NodeParentID]
		    LEFT OUTER JOIN [dbo].[View_HFit_RewardLevel_Joined] AS [RL_Joined]  
			   ON [VHFRGJ].[NodeID] = [RL_Joined].[NodeParentID]
		    LEFT OUTER JOIN [dbo].[HFit_LKP_RewardType] AS [HFLRT]  
			   ON [RL_Joined].[AwardType] = [HFLRT].[RewardTypeLKPID]
		    LEFT OUTER JOIN [dbo].[HFit_LKP_RewardLevelType] AS [HFLRLT]  
			   ON [RL_Joined].[LevelType] = [HFLRLT].[RewardLevelTypeLKPID]
		    INNER JOIN [dbo].[HFit_RewardsUserLevelDetail] AS [HFRULD]  
			   ON [RL_Joined].[NodeID] = [HFRULD].[LevelNodeID]
		    INNER JOIN [dbo].[CMS_User] AS [CU]  
			   ON [hfruld].[UserID] = [cu].[UserID]
		    INNER JOIN [dbo].[CMS_UserSite] AS [CUS]  
			   ON [CU].[UserID] = [CUS].[UserID]
		    INNER JOIN [dbo].[CMS_Site] AS [CS2]  
			   ON [CUS].[SiteID] = [CS2].[SiteID]
		    INNER JOIN [dbo].[HFit_Account] AS [HFA]  
			   ON [cs2].[SiteID] = [HFA].[SiteID]
		    INNER JOIN [dbo].[CMS_UserSettings] AS [CUS2]  
			   ON [cu].[UserID] = [cus2].[UserSettingsUserID]
		    LEFT OUTER JOIN [dbo].[View_HFit_RewardActivity_Joined] AS [VHFRAJ]  
			   ON [RL_Joined].[NodeID] = [VHFRAJ].[NodeParentID]
		    INNER JOIN [dbo].[HFit_RewardsUserActivityDetail] AS [HFRUAD]  
			   ON [VHFRAJ].[NodeID] = [HFRUAD].[ActivityNodeID]
		    LEFT OUTER JOIN [dbo].[View_HFit_RewardTrigger_Joined] AS [VHFRTJ]  
			   ON [VHFRAJ].[NodeID] = [VHFRTJ].[NodeParentID]
		    LEFT OUTER JOIN [dbo].[HFit_LKP_RewardTrigger] AS [HFLRT2]  
			   ON [VHFRTJ].[RewardTriggerLKPID] = [HFLRT2].[RewardTriggerLKPID]
		    LEFT OUTER JOIN [dbo].[HFit_RewardException] AS [HFRE]  
			   ON [HFRE].[RewardActivityID] = [VHFRAJ].[RewardActivityID]
			  AND [HFRE].[UserID] = [cu].[UserID];

GO


print('CREATED [view_EDW_RewardUserDetail]') ;
GO

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
