
alter proc [dbo].[Proc_EDW_RewardUserDetail] (@StartDate as datetime, @EndDate as datetime, @TrackPerf as nvarchar(1))
as
BEGIN


--********************************************************************************************************************
--select * from [view_EDW_RewardUserDetail] where ItemModifiedWhen between '2000-11-14' and '2014-11-15'
--select * from [view_EDW_RewardUserDetail] where ItemModifiedWhen between '2014-05-12' and '2014-05-13' 
--8/7/2014 - added and commented out DocumentGuid and NodeGuid in case needed later
--8/08/2014 - Generated corrected view in DEV (WDM)
--8/12/2014 - Performance Issue - 00:06:49 @ 258502
--8/12/2014 - Performance Issue - Add PI01_view_EDW_RewardUserDetail
--8/12/2014 - Performance Issue - 00:03:46 @ 258502
--8/12/2014 - Performance Issue - Add PI02_view_EDW_RewardUserDetail
--8/12/2014 - Performance Issue - 00:03:45 @ 258502
--********************************************************************************************************************

--********************************************************************************************************************
--EXECUTION:
--	@StartDate: The date from which to begin selection of data
--	@EndDate  : The date from which to stop selection of data
--	@TrackPerf: Anything other than a NULL char to track performance.
--	exec Proc_EDW_RewardUserDetail NULL, NULL, 'Y'
--	exec Proc_EDW_RewardUserDetail '2010-11-14', '2014-11-15', 'Y'
--	exec Proc_EDW_RewardUserDetail '2014-06-10', '2014-06-11', NULL
--********************************************************************************************************************

	declare @P0Start as datetime ;
	declare @P0End as datetime ;

	set @P0Start = getdate() ;
	
	IF @StartDate is null 
	BEGIN
		set @StartDate  =DATEADD(Day, 0, DATEDIFF(Day, 0, GetDate()));	--Midnight yesterday;	
	END
	
	IF @EndDate is null 
	BEGIN
		set @EndDate = cast (getdate() as date);
	END

	--*************************************************************************

IF not EXISTS
		(
			SELECT name
			FROM SYS.INDEXES
			WHERE NAME = 'pi_CMS_UserSettings_IDMPI'
		)
	BEGIN
		CREATE nonCLUSTERED  INDEX pi_CMS_UserSettings_IDMPI
		ON CMS_UserSettings
		(		[UserSettingsID] ASC 
				, [HFitUserMpiNumber]
		)
	END


	IF not EXISTS
		(
			SELECT name
			FROM SYS.INDEXES
			WHERE NAME = 'pi_CMS_UserSettings_IDMPI'
		)
	BEGIN
		CREATE nonCLUSTERED  INDEX pi_CMS_UserSettings_IDMPI
		ON CMS_UserSettings
		(		[UserSettingsID] ASC 
				, [HFitUserMpiNumber]
		)
	END
	--GO	

IF not EXISTS
		(
			SELECT name
			FROM SYS.INDEXES
			WHERE NAME = 'PI_CMS_UserSite_SiteID'
		)
	BEGIN
	CREATE NONCLUSTERED INDEX PI_CMS_UserSite_SiteID
		ON [dbo].[CMS_UserSite] ([SiteID])
		INCLUDE ([UserID])
	END

	IF EXISTS
		(
			SELECT name
			FROM tempdb.dbo.sysobjects			
			WHERE ID = OBJECT_ID(N'tempdb..#Temp_View_HFit_RewardProgram_Joined')
		)
	BEGIN
		drop table #Temp_View_HFit_RewardProgram_Joined;
	END
	--GO			
	select NodeID, RewardProgramName, RewardProgramID, RewardProgramPeriodStart, RewardProgramPeriodEnd, DocumentModifiedWhen 
	into #Temp_View_HFit_RewardProgram_Joined 
	from View_HFit_RewardProgram_Joined 
	where View_HFit_RewardProgram_Joined.DocumentCulture = 'en-us' ;
	
	create clustered index PI_Temp_View_HFit_RewardProgram_Joined on #Temp_View_HFit_RewardProgram_Joined 
	(
		NodeID
	)
	--*************************************************************************
	
	IF EXISTS
		(
			SELECT name
			FROM tempdb.dbo.sysobjects			
			WHERE ID = OBJECT_ID(N'tempdb..#TEMP_View_HFit_RewardGroup_Joined')
		)
	BEGIN
		drop table #TEMP_View_HFit_RewardGroup_Joined;
	END
	--GO			
		select NodeID, NodeParentID, GroupName, RewardGroupID, RewardGroupPeriodStart ,RewardGroupPeriodEnd ,DocumentModifiedWhen 
	into #TEMP_View_HFit_RewardGroup_Joined
	from View_HFit_RewardGroup_Joined
	where View_HFit_RewardGroup_Joined.DocumentCulture = 'en-us' ;
	
	create clustered index PI_TEMP_View_HFit_RewardGroup_Joined
	 on #TEMP_View_HFit_RewardGroup_Joined
	(
		NodeID, NodeParentID, GroupName, RewardGroupID, RewardGroupPeriodStart ,RewardGroupPeriodEnd ,DocumentModifiedWhen 
	)
	--*************************************************************************
	--*************************************************************************
	
	IF EXISTS
		(
			SELECT name
			FROM tempdb.dbo.sysobjects			
			WHERE ID = OBJECT_ID(N'tempdb..#TEMP_View_HFit_RewardLevel_Joined')
		)
	BEGIN
		drop table #TEMP_View_HFit_RewardLevel_Joined;
	END
	--GO			
		select NodeID, NodeParentID, AwardType, LevelType, Level, DocumentModifiedWhen, RewardLevelPeriodStart, RewardLevelPeriodEnd
	into #TEMP_View_HFit_RewardLevel_Joined
	from View_HFit_RewardLevel_Joined
	where View_HFit_RewardLevel_Joined.DocumentCulture = 'en-us' ;
	
	create clustered index PI_TEMP_View_HFit_RewardLevel_Joined
	 on #TEMP_View_HFit_RewardLevel_Joined
	(
		NodeID, NodeParentID, AwardType, LevelType, Level, DocumentModifiedWhen, RewardLevelPeriodStart, RewardLevelPeriodEnd
	)
	--*************************************************************************
	--*************************************************************************
	
	IF EXISTS
		(
			SELECT name
			FROM tempdb.dbo.sysobjects			
			WHERE ID = OBJECT_ID(N'tempdb..#TEMP_View_HFit_RewardActivity_Joined')
		)
	BEGIN
		drop table #TEMP_View_HFit_RewardActivity_Joined;
	END
	--GO			
		select NodeID, NodeParentID, RewardActivityID, ActivityName, RewardActivityPeriodStart, RewardActivityPeriodEnd, ActivityPoints
	into #TEMP_View_HFit_RewardActivity_Joined
	from View_HFit_RewardActivity_Joined
	where View_HFit_RewardActivity_Joined.DocumentCulture = 'en-us' ;
	
	create clustered index PI_TEMP_View_HFit_RewardActivity_Joined
	 on #TEMP_View_HFit_RewardActivity_Joined
	(
		NodeID, NodeParentID, RewardActivityID, ActivityName, RewardActivityPeriodStart, RewardActivityPeriodEnd, ActivityPoints
	)
	--*************************************************************************
	--*************************************************************************	
	IF EXISTS
		(
			SELECT name
			FROM tempdb.dbo.sysobjects			
			WHERE ID = OBJECT_ID(N'tempdb..#TEMP_View_HFit_RewardTrigger_Joined')
		)
	BEGIN
		drop table #TEMP_View_HFit_RewardTrigger_Joined;
	END
	--GO			
		select NodeParentID, RewardTriggerLKPID, TriggerName, RewardTriggerID
	into #TEMP_View_HFit_RewardTrigger_Joined
	from View_HFit_RewardTrigger_Joined
	where View_HFit_RewardTrigger_Joined.DocumentCulture = 'en-us' ;
	
	create clustered index PI_TEMP_View_HFit_RewardTrigger_Joined
	 on #TEMP_View_HFit_RewardTrigger_Joined
	(
		NodeParentID, RewardTriggerLKPID, TriggerName, RewardTriggerID
	)
	--*************************************************************************
	--*************************************************************************	
	IF EXISTS
		(
			SELECT name
			FROM tempdb.dbo.sysobjects			
			WHERE ID = OBJECT_ID(N'tempdb..#TEMP_CMS_UserSettings')
		)
	BEGIN
		drop table #TEMP_CMS_UserSettings;
	END
	--GO			
		select HFitUserMpiNumber, UserSettingsUserID
	into #TEMP_CMS_UserSettings
	from CMS_UserSettings	
	
	create clustered index PI_TEMP_CMS_UserSettings
	 on #TEMP_CMS_UserSettings
	(
		HFitUserMpiNumber, UserSettingsUserID
	)

	CREATE NONCLUSTERED INDEX PI_TEMP_CMS_UserSettings2
		ON [dbo].[#TEMP_CMS_UserSettings] 
		([UserSettingsUserID])
		INCLUDE ([HFitUserMpiNumber])
	
	--*************************************************************************
	--***********************************************************************************************
	-- This is the data extraction QUERY
	--***********************************************************************************************
	SELECT 
		cu.UserGUID
		, CS2.SiteGUID
		, cus2.HFitUserMpiNumber
		, VHFRAJ.RewardActivityID
		, VHFRPJ.RewardProgramName
		, VHFRPJ.RewardProgramID
		, VHFRPJ.RewardProgramPeriodStart
		, VHFRPJ.RewardProgramPeriodEnd
		, VHFRPJ.DocumentModifiedWhen AS RewardModifiedDate
		, VHFRGJ.GroupName
		, VHFRGJ.RewardGroupID
		, VHFRGJ.RewardGroupPeriodStart
		, VHFRGJ.RewardGroupPeriodEnd
		, VHFRGJ.DocumentModifiedWhen AS RewardGroupModifieDate
		, VHFRLJ.Level
		, HFLRLT.RewardLevelTypeLKPName
		, VHFRLJ.DocumentModifiedWhen AS RewardLevelModifiedDate
		, HFRULD.LevelCompletedDt
		, HFRULD.LevelVersionHistoryID
		, VHFRLJ.RewardLevelPeriodStart
		, VHFRLJ.RewardLevelPeriodEnd
		, VHFRAJ.ActivityName
		, HFRUAD.ActivityPointsEarned
		, HFRUAD.ActivityCompletedDt
		, HFRUAD.ActivityVersionID
		, HFRUAD.ItemModifiedWhen AS RewardActivityModifiedDate
		, VHFRAJ.RewardActivityPeriodStart
		, VHFRAJ.RewardActivityPeriodEnd
		, VHFRAJ.ActivityPoints
		, HFRE.UserAccepted
		, HFRE.UserExceptionAppliedTo
		, HFRE.ItemModifiedWhen AS RewardExceptionModifiedDate
		, VHFRTJ.TriggerName
		, VHFRTJ.RewardTriggerID
		, HFLRT2.RewardTriggerLKPDisplayName
		, HFLRT2.RewardTriggerDynamicValue
		, HFLRT2.ItemModifiedWhen AS RewardTriggerModifiedDate
		, HFLRT.RewardTypeLKPName
		, HFA.AccountID
		, HFA.AccountCD
		, CASE	WHEN CAST(HFRULD.ItemCreatedWhen AS DATE) = CAST(HFRULD.ItemModifiedWhen AS DATE)
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		, HFRULD.ItemCreatedWhen
		, HFRULD.ItemModifiedWhen
		--, VHFRPJ.DocumentGuid		--WDM added 8/7/2014 in case needed
		--, VHFRPJ.NodeGuid		--WDM added 8/7/2014 in case needed		
	FROM
		#Temp_View_HFit_RewardProgram_Joined AS VHFRPJ WITH ( NOLOCK )
		LEFT OUTER JOIN #TEMP_View_HFit_RewardGroup_Joined AS VHFRGJ WITH ( NOLOCK ) ON VHFRPJ.NodeID = VHFRGJ.NodeParentID
		LEFT OUTER JOIN #TEMP_View_HFit_RewardLevel_Joined AS VHFRLJ WITH ( NOLOCK ) ON VHFRGJ.NodeID = VHFRLJ.NodeParentID
		LEFT OUTER JOIN dbo.HFit_LKP_RewardType AS HFLRT WITH ( NOLOCK ) ON VHFRLJ.AwardType = HFLRT.RewardTypeLKPID
		LEFT OUTER JOIN dbo.HFit_LKP_RewardLevelType AS HFLRLT WITH ( NOLOCK ) ON vhfrlj.LevelType = HFLRLT.RewardLevelTypeLKPID
		INNER JOIN dbo.HFit_RewardsUserLevelDetail AS HFRULD WITH ( NOLOCK ) ON VHFRLJ.NodeID = HFRULD.LevelNodeID
		INNER JOIN dbo.CMS_User AS CU WITH ( NOLOCK ) ON hfruld.UserID = cu.UserID
		INNER JOIN dbo.CMS_UserSite AS CUS WITH ( NOLOCK ) ON CU.UserID = CUS.UserID
		INNER JOIN dbo.CMS_Site AS CS2 WITH ( NOLOCK ) ON CUS.SiteID = CS2.SiteID
		INNER JOIN dbo.HFit_Account AS HFA WITH ( NOLOCK ) ON cs2.SiteID = HFA.SiteID

		INNER JOIN #TEMP_CMS_UserSettings AS CUS2 ON cu.UserID = cus2.UserSettingsUserID		
		LEFT OUTER JOIN #TEMP_View_HFit_RewardActivity_Joined AS VHFRAJ WITH ( NOLOCK ) ON VHFRLJ.NodeID = VHFRAJ.NodeParentID
		
		INNER JOIN dbo.HFit_RewardsUserActivityDetail AS HFRUAD WITH ( NOLOCK ) ON VHFRAJ.NodeID = HFRUAD.ActivityNodeID
		LEFT OUTER JOIN dbo.View_HFit_RewardTrigger_Joined AS VHFRTJ WITH ( NOLOCK ) ON VHFRAJ.NodeID = VHFRTJ.NodeParentID
		LEFT OUTER JOIN dbo.HFit_LKP_RewardTrigger AS HFLRT2 WITH ( NOLOCK ) ON VHFRTJ.RewardTriggerLKPID = HFLRT2.RewardTriggerLKPID
		LEFT OUTER JOIN dbo.HFit_RewardException AS HFRE WITH ( NOLOCK ) ON HFRE.RewardActivityID = VHFRAJ.RewardActivityID
				AND HFRE.UserID = cu.UserID
	
		Where HFRULD.ItemModifiedWhen >= @StartDate AND HFRULD.ItemModifiedWhen <= @EndDate
		--OPTION (TABLE HINT(CUS2 , index (pi_CMS_UserSettings_IDMPI)))

	if @TrackPerf is not null 
	BEGIN
		set @P0End = getdate() ;
		exec proc_EDW_MeasurePerf 'ElapsedTime','HARewardUSer-P0',0, @P0Start, @P0End;
	END

END --End of Proc