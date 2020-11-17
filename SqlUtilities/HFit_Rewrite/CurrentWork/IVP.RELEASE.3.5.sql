


go
Print '--------------------------------------------------------------';
Print 'END/start:';
print getdate();
Print '--------------------------------------------------------------';
go




go
Print '--------------------------------------------------------------';
Print 'END/start:';
print getdate();
Print '--------------------------------------------------------------';
go


GO
PRINT 'Processing: view_EDW_RewardUserDetail ';
GO

IF EXISTS (SELECT
                  NAME
                  FROM sys.VIEWS
                  WHERE NAME = 'view_EDW_RewardUserDetail') 
    BEGIN
        DROP VIEW
             view_EDW_RewardUserDetail;
    END;
GO
-- select count(*) from view_EDW_RewardUserDetail --334654
CREATE VIEW dbo.view_EDW_RewardUserDetail
AS

--**************************************************************************************************************************************************
--select * from [view_EDW_RewardUserDetail] where ItemModifiedWhen between '2000-11-14' and '2014-11-15'
--select * from [view_EDW_RewardUserDetail] where ItemModifiedWhen between '2014-05-12' and '2014-05-13' 
--8/7/2014 - added and commented out DocumentGuid and NodeGuid in case needed later
--8/08/2014 - Generated corrected view in DEV (WDM)
--8/12/2014 - Performance Issue - 00:06:49 @ 258502
--8/12/2014 - Performance Issue - Add PI01_view_EDW_RewardUserDetail
--8/12/2014 - Performance Issue - 00:03:46 @ 258502
--8/12/2014 - Performance Issue - Add PI02_view_EDW_RewardUserDetail
--8/12/2014 - Performance Issue - 00:03:45 @ 258502
--8/19/2014 - (WDM) Added where clause to make the query return english data only.	
--09.11.2014 : (wdm) Verified last mod date available to EDW - RewardsUserActivity_ItemModifiedWhen
--				RewardExceptionModifiedDate, RewardTrigger_DocumentModifiedWhen. Warned Laura this might create many dups.
--11.14.2014 : (wdm) The dups have surfaced. The combination of  HFRUAD.ActivityCompletedDt, 
--				HFRUAD.ItemModifiedWhen, HFRE.ItemModifiedWhen, HFRUAD.ItemModifiedWhen, VHFRTJ.DocumentModifiedWhen has exposed
--				tens of thousands of semi-redundant rows. Today, I commented these dates out and added a distinct and went from \
--				returning more than 100,000 rows for a given MPI and Client to 4 rows. I left in place the original dates of 
--				HFRULD.ItemCreatedWhen and HFRULD.ItemModifiedWhen. This gives us whether it is an insert or update. If multiple 
--				dates are used to determine changes, then it will be necessary to use a DATE filter to bring back only the 
--				rows indicating a change.
--11.18.2014 : (wdm) Found a USERID qualifier missing on the join of HFit_RewardsUserActivityDetail. Added this qualifier to USERID
--				and the view now appears to be functioning correctly returning about 160K rows in 2.5 minutes. The DISTINCT clause
--				made no difference in the number of returned rows, so it was removed and the execution time of the query was cut in half.
--11.18.2014 (wdm) added this filter so that only USER Detail was returned.
--01.01.2015 (WDM) added left outer join HFit_LKP_RewardActivity AND VHFRAJ.RewardActivityLKPName to the view - reference CR-47520
--01.01.2015 (WDM) Tested modifications - reference CR-47520
--02.17.2015 (WDM) and (SR) - modified the indexes and moved the where into a join to force the execution plan to modifiy itself. The 
--				view would not run in several hours since the deployment of this past Friday. Now, runs in a few minutes (less than 2).
-- 03.03.2015 Reviewed by nathan and dale and changes made as noted within.
--			ADDED THE FOLLOWING:
--				VHFRAJ.NodeGuid as RewardActivityGUID	--(03.03.2015 dale/nathan corrected)
--				VHFRPJ.DocumentGuid 	--(03.03.2015 dale/nathan corrected)
--				VHFRPJ.NodeGuid		--as RewardProgramGUID	--(03.03.2015 dale/nathan corrected)
--				VHFRGJ.NodeGuid	as RewardGroupGUID	--(03.03.2015 dale/nathan corrected)
--				VHFRTJ.NodeGuid AS RewardTriggerGUID	--(03.03.2015 dale/nathan corrected)
--03.19.2015 : by request of the EDW team, removed all columns not specificially requested
--			 and verified that was the request before initiating. The commented out columns
--			 were removed as a the solution to this request. 
--03.26.2015 : RewardGroupGUID removed per Shankar
--03.26.2015 : RewardExceptionModifiedDate Removed per Shankar
--03.26.2015 : Removed the following per Shankar  (ItemModifiedWhen/RewardExceptionModifiedDate)
--05.02.2015 : WDM - modified view for change tracking implementation (testing only)
--05.13.2015 : PUT IT BACK per discussion with Lee Allison. However, I can easily remove it again. (ItemModifiedWhen/RewardExceptionModifiedDate)
--05.13.2015 : Pulled the column from HFRUAD.ActivityCompletedDt AS RewardExceptionModifiedDate per Nathan 
--05.14.2015 : VHFRGJ.NodeGuid AS RewardGroupGUID	 --(03.03.2015 dale/nathan corrected) and removed 03.26.2015 per Shankar; put back 03.30.2015 deemed needed; removed 05.14.2015 who knows why.
--06.26.2015 : Dhaval and Dale discuss change request to view. 
--			 HFRUAD -> HFit_RewardsUserActivityDetail, we are asked to change a field (UserExceptionAppliedTo)
--			 to now point to ActivityCompletedId -> HFit_RewardsUserActivityDetail. This req made today 
--			 from Corina thru Laura. Dhaval and I CONNOT make this change without a CR. 
--			 We decided to implement as: HFRAUD.ActivityCompletedId as UserExceptionAppliedTo
--06.28.2015 : Reviewed, tested, and Passed by Corina
--07.13.2015 : #55054 raised by Corina indicates there may be data anomolies (returned number of rows) based on whether 
--			 a LEFT or INNER join is used. WDM tested the return counts on all machines using both inner and left joins.
--				288,480 with inner join   P5/P1	 @ 07.13.2015
--				288,480 with left join	 P5/P1	 @ 07.13.2015
--				372,060 with 2 left join	 P5/P1	 @ 07.13.2015
--				24,833 with inner join    P5/P2	 @ 07.13.2015
--				24,833 with left join	 P5/P2	 @ 07.13.2015
--				40,738 with 2 left join	 P5/P2	 @ 07.13.2015    
--				374,876 with inner join   P5/P3	 @ 07.13.2015
--				374,876 with left join	 P5/P3	 @ 07.13.2015
--				523,203 with 2 left join	 P5/P3	 @ 07.13.2015		  
--			 NOTE: In all instances on Prod5 and TGT, the returned row count is the same.
--08.02.2015	 Corina and Dale reviewed and tested the view DDL with corrections suggested by Corina that will cause a more 
--			 complete set of User Rewards to be returned.
--08.06.2015	 Yesterday the ciew was approved by Corina and is being scheduled for implementation tonight.
--**************************************************************************************************************************************************

SELECT DISTINCT
       cu.UserGUID
     , CS2.SiteGUID
     , cus2.HFitUserMpiNumber
     , VHFRAJ.NodeGuid AS RewardActivityGUID	--(03.03.2015 dale/nathan corrected)
     , VHFRPJ.RewardProgramName
     , CAST (VHFRPJ.DocumentModifiedWhen AS datetime) AS RewardModifiedDate

     , CAST (VHFRLJ.DocumentModifiedWhen  AS datetime) AS RewardLevelModifiedDate
     , CAST (HFRULD.LevelCompletedDt AS datetime) AS LevelCompletedDt
     , HFRUAD.ActivityPointsEarned
     , CAST (HFRUAD.ActivityCompletedDt AS datetime) AS ActivityCompletedDt
     , CAST (HFRUAD.ItemModifiedWhen  AS datetime) AS RewardActivityModifiedDate
     , VHFRAJ.ActivityPoints
     , HFRE.UserAccepted		  --Corina, please verify whether this column is needde or not
       --, HFRE.UserExceptionAppliedTo
     , HFRUAD.ActivityCompletedId AS UserExceptionAppliedTo
     , VHFRTJ.NodeGuid AS RewardTriggerGUID	--(03.03.2015 dale/nathan corrected)
     , HFA.AccountID
     , HFA.AccountCD
     , CASE
           WHEN CAST (HFRULD.ItemCreatedWhen AS date) = CAST (HFRULD.ItemModifiedWhen AS date) 
               THEN 'I'
           ELSE 'U'
       END AS ChangeType
     , CAST (HFRUAD.ActivityCompletedDt AS datetime) AS RewardExceptionModifiedDate

       FROM
           dbo.HFit_RewardsUserActivityDetail AS HFRUAD WITH (NOLOCK) 
               INNER JOIN dbo.View_HFit_RewardActivity_Joined AS VHFRAJ WITH (NOLOCK) 
                   ON VHFRAJ.NodeID = HFRUAD.ActivityNodeID
                  AND VHFRAJ.DocumentCulture = 'en-us'
               LEFT OUTER JOIN dbo.View_HFit_RewardGroup_Joined AS VHFRGJ WITH (NOLOCK) 
                   ON HFRUAD.rewardgroupnodeid = VHFRGJ.NodeID
                  AND VHFRGJ.DocumentCulture = 'en-us'
               LEFT OUTER JOIN dbo.View_HFit_RewardProgram_Joined AS VHFRPJ WITH (NOLOCK) 
                   ON HFRUAD.rewardprogramnodeid = VHFRPJ.NodeID
                  AND VHFRPJ.DocumentCulture = 'en-us'
               LEFT OUTER JOIN dbo.View_HFit_RewardLevel_Joined AS VHFRLJ WITH (NOLOCK) 
                   ON HFRUAD.rewardlevelnodeid = VHFRLJ.NodeID
                  AND VHFRLJ.DocumentCulture = 'en-us'
               INNER JOIN dbo.CMS_User AS CU WITH (NOLOCK) 
                   ON cu.UserID = HFRUAD.userid
               INNER JOIN dbo.CMS_UserSite AS CUS WITH (NOLOCK) 
                   ON CU.UserID = CUS.UserID
               INNER JOIN dbo.CMS_Site AS CS2 WITH (NOLOCK) 
                   ON CUS.SiteID = CS2.SiteID
               INNER JOIN dbo.HFit_Account AS HFA WITH (NOLOCK) 
                   ON cs2.SiteID = HFA.SiteID
               INNER JOIN dbo.CMS_UserSettings AS CUS2 WITH (NOLOCK) 
                   ON cu.UserID = cus2.UserSettingsUserID
               LEFT JOIN dbo.HFit_RewardsUserLevelDetail AS HFRULD WITH (NOLOCK) 
                   ON HFRUAD.rewardlevelnodeid = HFRULD.LevelNodeID
                  AND HFRULD.rewardgroupnodeid = HFRUAD.rewardgroupnodeid
                  AND HFRULD.rewardprogramnodeid = HFRUAD.rewardprogramnodeid
                  AND HFRULD.userid = HFRUAD.userid
               LEFT OUTER JOIN dbo.View_HFit_RewardTrigger_Joined AS VHFRTJ WITH (NOLOCK) 
                   ON VHFRAJ.NodeID = VHFRTJ.NodeParentID
                  AND VHFRTJ.DocumentCulture = 'en-us'
               LEFT OUTER JOIN dbo.HFit_RewardException AS HFRE WITH (NOLOCK) 
                   ON HFRE.RewardActivityID = VHFRAJ.RewardActivityID
                  AND HFRE.UserID = cu.UserID
       WHERE  cus2.HFitUserMpiNumber > 0;

GO
PRINT 'Completed : view_EDW_RewardUserDetail ';
GO

/*----------------------------------------
(WDM) Kept only these columns IAW CR-51005
UserGUID
SiteGUID 
HFitUserMPINumber
RewardActivityGUID
RewardProgramName
RewardModifiedDate
RewardGroupGUID
RewardLevelModifiedDate
LevelCompletedDt
ActivityPointsEarned
ActivityCompletedDt
RewardActivityModifiedDate
ActivityPoints
UserAccepted
UserExceptionAppliedTo
RewardTriggerGUID
AccountID
AccountCD 
ChangeType
RewardExceptionModifiedDate
*/

PRINT '***** FROM: view_EDW_RewardUserDetail.sql';
GO 



go
Print '--------------------------------------------------------------';
Print 'END/start:';
print getdate();
Print '--------------------------------------------------------------';
go


GO
PRINT 'Processing view_EDW_BioMetrics: ' + CAST (GETDATE () AS nvarchar (50)) + '  *** view_EDW_BioMetrics.sql (CR11690)';
GO
--drop table [EDW_BiometricViewRejectCriteria]
IF NOT EXISTS (SELECT [name]
			  FROM [sys].[tables]
			  WHERE [name] = 'EDW_BiometricViewRejectCriteria') 
    BEGIN
	   PRINT 'EDW_BiometricViewRejectCriteria NOT found, creating';
	   --This table contains the REJECT specifications for Biometric data. An entry causes all records before a date for a Client or SITE to be ignored.
	   --Use AccountCD and ItemCreatedWhen together OR SiteID and ItemCreatedWhen together. They work and reject in pairs.
	   CREATE TABLE [dbo].[EDW_BiometricViewRejectCriteria]
	   (
	   [AccountCD] nvarchar (8) NOT NULL
	 , [ItemCreatedWhen] datetime2 (7) NOT NULL
	 , [SiteID] int NOT NULL
	 , [RejectGUID] uniqueidentifier NULL
	   );

	   ALTER TABLE [dbo].[EDW_BiometricViewRejectCriteria]
	   ADD CONSTRAINT
		  [DF_EDW_BiometricViewRejectCriteria_RejectGUID] DEFAULT NEWID () FOR [RejectGUID];

	   ALTER TABLE [dbo].[EDW_BiometricViewRejectCriteria] SET (LOCK_ESCALATION = TABLE) ;

	   EXEC [sp_addextendedproperty]
	   @name = N'PURPOSE' , @value = 'This table contains the REJECT specifications for Biometric data. An entry causes all records before a date for a Client or SITE to be ignored. The data is entered as SiteID and Rejection Date OR AccountCD and Rejection Date. All dates prior to the rejection date wil be ignored.' ,
	   @level0type = N'Schema' , @level0name = 'dbo' ,
	   @level1type = N'Table' , @level1name = 'EDW_BiometricViewRejectCriteria';
	   --@level2type = N'Column', @level2name = NULL

	   EXEC [sp_addextendedproperty]
	   @name = N'MS_Description' , @value = 'Use AccountCD and ItemCreatedWhen together, entering a non-existant value for SiteID. They work and reject in pairs and this type of entry will only take AccountCD and ItemCreatedWhen date into consideration.' ,
	   @level0type = N'Schema' , @level0name = 'dbo' ,
	   @level1type = N'Table' , @level1name = 'EDW_BiometricViewRejectCriteria' ,
	   @level2type = N'Column' , @level2name = 'AccountCD';

	   EXEC [sp_addextendedproperty]
	   @name = N'USAGE' , @value = 'Use SiteID and ItemCreatedWhen together, entering a non-existant value for AccountCD. They work and reject in pairs.' ,
	   @level0type = N'Schema' , @level0name = 'dbo' ,
	   @level1type = N'Table' , @level1name = 'EDW_BiometricViewRejectCriteria' ,
	   @level2type = N'Column' , @level2name = 'SiteID';

	   EXEC [sp_addextendedproperty]
	   @name = N'USAGE' , @value = 'Use AccountCD or SiteID and ItemCreatedWhen together. They work and reject in pairs. Any date before this date will NOT be retrieved.' ,
	   @level0type = N'Schema' , @level0name = 'dbo' ,
	   @level1type = N'Table' , @level1name = 'EDW_BiometricViewRejectCriteria' ,
	   @level2type = N'Column' , @level2name = 'ItemCreatedWhen';
    END;
GO

IF EXISTS (SELECT [name]
		   FROM [sys].[views]
		   WHERE [name] = 'view_EDW_BiometricViewRejectCriteria') 
    BEGIN
	   PRINT 'view_EDW_BiometricViewRejectCriteria found, updating';
	   DROP VIEW [view_EDW_BiometricViewRejectCriteria];
    END;
GO

CREATE VIEW [view_EDW_BiometricViewRejectCriteria]
AS SELECT [AccountCD]
	   , [ItemCreatedWhen]
	   , [SiteID]
	   , [RejectGUID]
	FROM [dbo].[EDW_BiometricViewRejectCriteria];
GO
PRINT 'view_EDW_BiometricViewRejectCriteria, updated';
GO

IF NOT EXISTS (SELECT [name]
			  FROM [sys].[indexes]
			  WHERE [name] = 'PKI_EDW_BiometricViewRejectCriteria') 
    BEGIN
	   PRINT 'PKI_EDW_BiometricViewRejectCriteria NOT found, creating';
	   CREATE UNIQUE CLUSTERED INDEX [PKI_EDW_BiometricViewRejectCriteria] ON [dbo].[EDW_BiometricViewRejectCriteria]
	   (
	   [AccountCD] ASC ,
	   [ItemCreatedWhen] ASC ,
	   [SiteID] ASC
	   );
    END;
ELSE
    BEGIN
	   PRINT 'PKI_EDW_BiometricViewRejectCriteria created';
    END;

GO

IF EXISTS (SELECT [name]
		   FROM [sys].[procedures]
		   WHERE [name] = 'proc_Insert_EDW_BiometricViewRejectCriteria') 
    BEGIN
	   PRINT 'proc_Insert_EDW_BiometricViewRejectCriteria found, updating.';
	   DROP PROCEDURE [proc_Insert_EDW_BiometricViewRejectCriteria];
    END;
ELSE
    BEGIN
	   PRINT 'Creating proc_Insert_EDW_BiometricViewRejectCriteria';
    END;
GO

CREATE PROC [proc_Insert_EDW_BiometricViewRejectCriteria] (
	  @AccountCD AS nvarchar (50) , @ItemCreatedWhen AS datetime , @SiteID AS int) 
AS
BEGIN

    IF @SiteID IS NULL
	   BEGIN
		  SET @SiteID = -1;
	   END;

    DECLARE @iCnt integer = 0;
    SET @iCnt = (SELECT COUNT (*) 
			    FROM [EDW_BiometricViewRejectCriteria]
			    WHERE [AccountCD] = @AccountCD
				 AND [SiteID] = @SiteID) ;
    IF @iCnt <= 0
	   BEGIN
		  INSERT INTO [dbo].[EDW_BiometricViewRejectCriteria]
		  ([AccountCD]
		 , [ItemCreatedWhen]
		 , [SiteID]
		  ) 
		  VALUES
		  (@AccountCD
		  , @ItemCreatedWhen
		  , @SiteID
		  );
		  PRINT 'ADDED ' + @AccountCD + ' to EDW_BiometricViewRejectCriteria.';
	   END;
    ELSE
	   BEGIN
		  PRINT 'Account ' + @AccountCD + ' already defined to EDW_BiometricViewRejectCriteria.';
	   END;
END;

GO

IF EXISTS (SELECT [name]
		   FROM [sys].[procedures]
		   WHERE [name] = 'proc_Delete_EDW_BiometricViewRejectCriteria_Acct') 
    BEGIN
	   PRINT 'proc_Delete_EDW_BiometricViewRejectCriteria_Acct  found, updating.';
	   DROP PROCEDURE [proc_Delete_EDW_BiometricViewRejectCriteria_Acct];
    END;
ELSE
    BEGIN
	   PRINT 'Creating proc_Delete_EDW_BiometricViewRejectCriteria_Acct';
    END;

GO

CREATE PROC [proc_Delete_EDW_BiometricViewRejectCriteria_Acct] (
	  @AccountCD AS nvarchar (50) , @ItemCreatedWhen AS datetime) 
AS
BEGIN
    DELETE FROM [dbo].[EDW_BiometricViewRejectCriteria]
	 WHERE [AccountCD] = @AccountCD
	   AND [ItemCreatedWhen] = @ItemCreatedWhen;
END;

GO
IF EXISTS (SELECT [name]
		   FROM [sys].[procedures]
		   WHERE [name] = 'proc_Delete_EDW_BiometricViewRejectCriteria_Site') 
    BEGIN
	   PRINT 'proc_Delete_EDW_BiometricViewRejectCriteria_Site  found, updating.';
	   DROP PROCEDURE [proc_Delete_EDW_BiometricViewRejectCriteria_Site];
    END;
ELSE
    BEGIN
	   PRINT 'Creating proc_Delete_EDW_BiometricViewRejectCriteria_Site';
    END;

GO

CREATE PROC [proc_Delete_EDW_BiometricViewRejectCriteria_Site] (
	  @SiteID AS int , @ItemCreatedWhen AS datetime) 
AS
BEGIN
    DELETE FROM [dbo].[EDW_BiometricViewRejectCriteria]
	 WHERE [SiteID] = @SiteID
	   AND [ItemCreatedWhen] = @ItemCreatedWhen;

END;
GO

IF EXISTS (SELECT [name]
		   FROM [sys].[views]
		   WHERE [name] = 'view_EDW_BioMetrics') 
    BEGIN
	   PRINT 'Removing current view_EDW_BioMetrics.';
	   DROP VIEW [view_EDW_BioMetrics];
    END;
GO
PRINT 'Creating view_EDW_BioMetrics.';
GO

CREATE VIEW [dbo].[view_EDW_BioMetrics]
AS
--*****************************************************************************************************************************************
--************** TEST Criteria and Results for view_EDW_BioMetrics ************************************************************************
--INSERT INTO [dbo].[EDW_BiometricViewRejectCriteria] ([AccountCD],[ItemCreatedWhen],[SiteID]) VALUES('XX','2013-12-01',17  )  
--NOTE:		XX is used so that the AccountCD is NOT taken into account and only SiteID and ItemCreatedWhen is used.
--GO	--Tested by wdm on 11.21.2014

-- select count(*) from view_EDW_BioMetrics		--(wdm) & (jc) : testing on {ProdStaging = 136348} / With reject on 136339 = 9

--select * from view_EDW_BioMetrics	 where AccountCD = 'peabody' AND COALESCE (EventDate,ItemCreatedWhen) is not NULL and COALESCE (EventDate,ItemCreatedWhen) < '2013-12-01'	: 9 
--select * from view_Hfit_BioMetrics where AccountCD = 'peabody' AND COALESCE (EventDate,ItemCreatedWhen) is not NULL and COALESCE (EventDate,ItemCreatedWhen) < '2013-12-01'	: 9 

--select * from view_EDW_BioMetrics	where AccountCD = 'peabody' and ItemCreatedWhen < '2013-12-01 00:00:00.000'		: 7 
--select * from view_EDW_BioMetrics	where AccountCD = 'peaboOK dy' and EventDate < '2013-12-01 00:00:00.000'		: 9 

--select count(*) from view_EDW_BioMetrics		--NO REJECT FILTER : 136348
--select count(*) from view_EDW_BioMetrics		--REJECT FILTER ON : 136339 == 9 GOOD TEST

--select count(*) from view_Hfit_BioMetrics	:136393
--select count(*) from view_Hfit_BioMetrics where COALESCE (EventDate,ItemCreatedWhen) is not NULL 	:136348

--NOTE: All tests passed 11.21.2014, 11.23.2014, 12.2.2014, 12,4,2014

--truncate table EDW_BiometricViewRejectCriteria

--INSERT INTO [dbo].[EDW_BiometricViewRejectCriteria]([AccountCD],[ItemCreatedWhen],[SiteID])VALUES('peabody','2013-12-01',-1)         
--NOTE:		-1 is used so that the SiteID is NOT taken into account and only AccountCD and ItemCreatedWhen is used.
--GO	--Tested by wdm on 11.21.2014

--select * from view_EDW_BioMetrics where ItemCreatedWhen < '2013-12-01' and AccountCD = 'peabody' returns 1034
--		so the number should be 43814 - 1034 = 42780 with AccountCD = 'peabody' and ItemCreatedWhen = '2014-03-19'
--		in table EDW_BiometricViewRejectCriteria. And it worked (wdm) 11.21.2014
--GO	--Tested by wdm on 11.21.2014

--select * from view_EDW_BioMetrics where SiteID = 17 and ItemCreatedWhen < '2014-03-19' returns 22,974
--		so the number should be 43814 - 22974 = 20840 with SIteID = 17 and ItemCreatedWhen = '2014-03-19'
--		in table EDW_BiometricViewRejectCriteria. And it worked (wdm) 11.21.2014
--GO	--Tested by wdm on 11.21.2014

--	11.24.2014 (wdm) -	requested a review of this code and validation with EDW.

-- 12.22.2014 - Received an SR from John C. via Richard to add two fields to the view, Table name and Item ID.
-- 12.23.2014 - Added the Vendor ID and Vendor name to the view via the HFit_LKP_TrackerVendor table
-- 12.25.2014 - Added the EDW_BiometricViewRejectCriteria to allow selective rejection of historical records
-- 01.19.2014 - Prepared for Simpson Willams

--*****************************************************************************************************************************************
SELECT DISTINCT
--HFit_UserTracker
[HFUT].[UserID]
, [cus].[UserSettingsUserGUID] AS [UserGUID]
, [cus].[HFitUserMpiNumber]
, [cus2].[SiteID]
, [cs].[SiteGUID]
, cast(NULL as datetime) AS [CreatedDate]
, cast(NULL as datetime) AS [ModifiedDate]
, NULL AS [Notes]
, NULL AS [IsProfessionallyCollected]
, NULL AS [EventDate]
, 'Not Build Yet' AS [EventName]

--HFit_TrackerWeight
, NULL AS [PPTWeight]

--HFit_TrackerHbA1C
, NULL AS [PPTHbA1C]

--HFit_TrackerCholesterol
, NULL AS [Fasting]
, NULL AS [HDL]
, NULL AS [LDL]
, NULL AS [Ratio]
, NULL AS [Total]
, NULL AS [Triglycerides]

--HFit_TrackerBloodSugarandGlucose
, NULL AS [Glucose]
, NULL AS [FastingState]

--HFit_TrackerBloodPressure
, NULL AS [Systolic]
, NULL AS [Diastolic]

--HFit_TrackerBodyFat
, NULL AS [PPTBodyFatPCT]

--HFit_TrackerBMI
, NULL AS [BMI]

--HFit_TrackerBodyMeasurements
, NULL AS [WaistInches]
, NULL AS [HipInches]
, NULL AS [ThighInches]
, NULL AS [ArmInches]
, NULL AS [ChestInches]
, NULL AS [CalfInches]
, NULL AS [NeckInches]

--HFit_TrackerHeight
, NULL AS [Height]

--HFit_TrackerRestingHeartRate
, NULL AS [HeartRate]
, --HFit_TrackerShots
NULL AS [FluShot]
, NULL AS [PneumoniaShot]

--HFit_TrackerTests
, NULL AS [PSATest]
, NULL AS [OtherExam]
, NULL AS [TScore]
, NULL AS [DRA]
, NULL AS [CotinineTest]
, NULL AS [ColoCareKit]
, NULL AS [CustomTest]
, NULL AS [CustomDesc]
, NULL AS [CollectionSource]
, [HFA].[AccountID]
, [HFA].[AccountCD]
, CASE
	 WHEN [HFUT].[ItemCreatedWhen] = COALESCE ([HFUT].[ItemModifiedWhen] , [hfut].[ItemCreatedWhen]) 
	 THEN 'I'
	 ELSE 'U'
  END AS [ChangeType]
, cast([HFUT].[ItemCreatedWhen] as datetime) as ItemCreatedWhen
, cast([HFUT].[ItemModifiedWhen] as datetime) as ItemModifiedWhen
, 0   AS [TrackerCollectionSourceID]
, [HFUT].[itemid]
, 'HFit_UserTracker' AS [TBL]
, NULL AS [VendorID]		--VENDOR.ItemID as VendorID
, NULL AS [VendorName]		--VENDOR.VendorName
  FROM
	  [dbo].[HFit_UserTracker] AS [HFUT]
		 INNER JOIN [dbo].[CMS_UserSettings] AS [CUS]
			ON [hfut].[UserID] = [cus].[UserSettingsUserID]
		 INNER JOIN [dbo].[CMS_UserSite] AS [CUS2]
			ON [cus].[UserSettingsUserID] = [cus2].[UserID]
		 INNER JOIN [dbo].[CMS_Site] AS [CS]
			ON [CUS2].[SiteID] = [CS].[SiteID]
		 INNER JOIN [dbo].[HFit_Account] AS [HFA]
			ON [cs].[SiteID] = [HFA].[SiteID]
  --left outer join HFit_LKP_TrackerVendor as VENDOR on HFUT.VendorID = VENDOR.ItemID
  --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table EDW_BiometricViewRejectCriteria
  WHERE [CS].[SITEID] NOT IN (SELECT [SiteID]
						  FROM [EDW_BiometricViewRejectCriteria]
						  WHERE [HFUT].[ItemCreatedWhen] < [ItemCreatedWhen]) 
    AND [HFA].[AccountCD] NOT IN (SELECT [AccountCD]
							 FROM [EDW_BiometricViewRejectCriteria]
							 WHERE [HFA].[AccountCD] = [AccountCD]
							   AND [HFUT].[ItemCreatedWhen] < [ItemCreatedWhen]) 
	   --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified within table EDW_BiometricViewRejectCriteria
    AND [HFUT].[ItemCreatedWhen] IS NOT NULL		--Add per Robert and Laura 12.4.2014

UNION ALL
SELECT distinct
[hftw].[UserID]
, [cus].[UserSettingsUserGUID]
, [cus].[HFitUserMpiNumber]
, [cus2].[SiteID]
, [cs].[SiteGUID]
, cast([HFTW].[ItemCreatedWhen] as datetime) as ItemCreatedWhen
, cast([HFTW].[ItemModifiedWhen] as datetime) as ItemModifiedWhen
, [HFTW].[Notes]
, [HFTW].[IsProfessionallyCollected]
, cast([HFTW].[EventDate] as datetime ) as EventDate
, 'Not Build Yet' AS [EventName]
, [hftw].Value AS [PPTWeight]
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, [HFTCS].[CollectionSourceName_External]
, [HFA].[AccountID]
, [HFA].[AccountCD]
, CASE
	 WHEN [HFTW].[ItemCreatedWhen] = COALESCE ([HFTW].[ItemModifiedWhen] , [HFTW].[ItemCreatedWhen]) 
	 THEN 'I'
	 ELSE 'U'
  END AS [ChangeType]
, cast([HFTW].[ItemCreatedWhen] as datetime) as ItemCreatedWhen
, cast([HFTW].[ItemModifiedWhen] as datetime) as ItemModifiedWhen
, [HFTCS].[TrackerCollectionSourceID]
, [HFTW].[itemid]
, 'HFit_TrackerWeight' AS [TBL]
, [VENDOR].[ItemID] AS [VendorID]
, [VENDOR].[VendorName]
  FROM
	  [dbo].[HFit_TrackerWeight] AS [HFTW]
		 INNER JOIN [dbo].[HFit_TrackerCollectionSource] AS [HFTCS]
			ON [HFTW].[TrackerCollectionSourceID] = [HFTCS].[TrackerCollectionSourceID]
		 INNER JOIN [dbo].[CMS_UserSettings] AS [CUS]
			ON [HFTW].[UserID] = [cus].[UserSettingsUserID]
		 INNER JOIN [dbo].[CMS_UserSite] AS [CUS2]
			ON [cus].[UserSettingsUserID] = [cus2].[UserID]
		 INNER JOIN [dbo].[CMS_Site] AS [CS]
			ON [CUS2].[SiteID] = [CS].[SiteID]
		 INNER JOIN [dbo].[HFit_Account] AS [HFA]
			ON [cs].[SiteID] = [HFA].[SiteID]
		 LEFT OUTER JOIN [HFit_LKP_TrackerVendor] AS [VENDOR]
			ON [HFTW].[VendorID] = [VENDOR].[ItemID]
  WHERE [CS].[SITEID] NOT IN (SELECT [SiteID]
						  FROM [EDW_BiometricViewRejectCriteria]
						  WHERE COALESCE ([HFTW].[EventDate] , [HFTW].[ItemCreatedWhen]) < [ItemCreatedWhen]) 
    AND [HFA].[AccountCD] NOT IN (SELECT [AccountCD]
							 FROM [EDW_BiometricViewRejectCriteria]
							 WHERE [HFA].[AccountCD] = [AccountCD]
							   AND COALESCE ([HFTW].[EventDate] , [HFTW].[ItemCreatedWhen]) < [ItemCreatedWhen]) 
    AND ([HFTW].[ItemCreatedWhen] IS NOT NULL
	 OR [HFTW].[EventDate] IS NOT NULL)		--Add per RObert and Laura 12.4.2014			

UNION ALL
SELECT distinct
[HFTHA].[UserID]
, [cus].[UserSettingsUserGUID]
, [cus].[HFitUserMpiNumber]
, [cus2].[SiteID]
, [cs].[SiteGUID]
, cast([HFTHA].[ItemCreatedWhen] as datetime) ItemCreatedWhen
, cast([HFTHA].[ItemModifiedWhen] as datetime) ItemModifiedWhen
, [HFTHA].[Notes]
, [HFTHA].[IsProfessionallyCollected]
, cast([HFTHA].[EventDate] as datetime ) as EventDate
, 'Not Build Yet' AS [EventName]
, NULL
, [HFTHA].Value AS [PPTHbA1C]
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, [HFTCS].[CollectionSourceName_External]
, [HFA].[AccountID]
, [HFA].[AccountCD]
, CASE
	 WHEN [HFTHA].[ItemCreatedWhen] = COALESCE ([HFTHA].[ItemModifiedWhen] , [HFTHA].[ItemCreatedWhen]) 
	 THEN 'I'
	 ELSE 'U'
  END AS [ChangeType]
, cast([HFTHA].[ItemCreatedWhen] as datetime) ItemCreatedWhen
, cast([HFTHA].[ItemModifiedWhen] as datetime) ItemModifiedWhen
, [HFTCS].[TrackerCollectionSourceID]
, [HFTHA].[itemid]
, 'HFit_TrackerHbA1c' AS [TBL]
, [VENDOR].[ItemID] AS [VendorID]
, [VENDOR].[VendorName]
  FROM
	  [dbo].[HFit_TrackerHbA1c] AS [HFTHA]
		 INNER JOIN [dbo].[HFit_TrackerCollectionSource] AS [HFTCS]
			ON [HFTHA].[TrackerCollectionSourceID] = [HFTCS].[TrackerCollectionSourceID]
		 INNER JOIN [dbo].[CMS_UserSettings] AS [CUS]
			ON [HFTHA].[UserID] = [cus].[UserSettingsUserID]
		 INNER JOIN [dbo].[CMS_UserSite] AS [CUS2]
			ON [cus].[UserSettingsUserID] = [cus2].[UserID]
		 INNER JOIN [dbo].[CMS_Site] AS [CS]
			ON [CUS2].[SiteID] = [CS].[SiteID]
		 INNER JOIN [dbo].[HFit_Account] AS [HFA]
			ON [cs].[SiteID] = [HFA].[SiteID]
		 LEFT OUTER JOIN [HFit_LKP_TrackerVendor] AS [VENDOR]
			ON [HFTHA].[VendorID] = [VENDOR].[ItemID]
  --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table EDW_BiometricViewRejectCriteria
  WHERE [CS].[SITEID] NOT IN (SELECT [SiteID]
						  FROM [EDW_BiometricViewRejectCriteria]
						  WHERE COALESCE ([HFTHA].[EventDate] , [HFTHA].[ItemCreatedWhen]) < [ItemCreatedWhen]) 
    AND [HFA].[AccountCD] NOT IN (SELECT [AccountCD]
							 FROM [EDW_BiometricViewRejectCriteria]
							 WHERE [HFA].[AccountCD] = [AccountCD]
							   AND COALESCE ([HFTHA].[EventDate] , [HFTHA].[ItemCreatedWhen]) < [ItemCreatedWhen]) 
    AND ([HFTHA].[ItemCreatedWhen] IS NOT NULL
	 OR [HFTHA].[EventDate] IS NOT NULL)		--Add per RObert and Laura 12.4.2014

UNION ALL
SELECT distinct
[HFTC].[UserID]
, [cus].[UserSettingsUserGUID]
, [cus].[HFitUserMpiNumber]
, [cus2].[SiteID]
, [cs].[SiteGUID]
, cast([HFTC].[ItemCreatedWhen] as datetime) ItemCreatedWhen
, cast([HFTC].[ItemModifiedWhen] as datetime) ItemModifiedWhen
, [HFTC].[Notes]
, [HFTC].[IsProfessionallyCollected]
, cast([HFTC].[EventDate] as datetime ) as EventDate
, 'Not Build Yet' AS [EventName]
, NULL
, NULL
, [HFTC].[Fasting]
, [HFTC].[HDL]
, [HFTC].[LDL]
, [HFTC].[Ratio]
, [HFTC].[Total]
, [HFTC].[Tri]
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, [HFTCS].[CollectionSourceName_External]
, [HFA].[AccountID]
, [HFA].[AccountCD]
, CASE
	 WHEN [HFTC].[ItemCreatedWhen] = COALESCE ([HFTC].[ItemModifiedWhen] , [HFTC].[ItemCreatedWhen]) 
	 THEN 'I'
	 ELSE 'U'
  END AS [ChangeType]
, cast([HFTC].[ItemCreatedWhen] as datetime) ItemCreatedWhen
, cast([HFTC].[ItemModifiedWhen] as datetime) ItemModifiedWhen
, [HFTCS].[TrackerCollectionSourceID]
, [HFTC].[itemid]
, 'HFit_TrackerCholesterol' AS [TBL]
, [VENDOR].[ItemID] AS [VendorID]
, [VENDOR].[VendorName]
  FROM
	  [dbo].[HFit_TrackerCholesterol] AS [HFTC]
		 INNER JOIN [dbo].[HFit_TrackerCollectionSource] AS [HFTCS]
			ON [HFTC].[TrackerCollectionSourceID] = [HFTCS].[TrackerCollectionSourceID]
		 INNER JOIN [dbo].[CMS_UserSettings] AS [CUS]
			ON [HFTC].[UserID] = [cus].[UserSettingsUserID]
		 INNER JOIN [dbo].[CMS_UserSite] AS [CUS2]
			ON [cus].[UserSettingsUserID] = [cus2].[UserID]
		 INNER JOIN [dbo].[CMS_Site] AS [CS]
			ON [CUS2].[SiteID] = [CS].[SiteID]
		 INNER JOIN [dbo].[HFit_Account] AS [HFA]
			ON [cs].[SiteID] = [HFA].[SiteID]
		 LEFT OUTER JOIN [HFit_LKP_TrackerVendor] AS [VENDOR]
			ON [HFTC].[VendorID] = [VENDOR].[ItemID]
  --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table EDW_BiometricViewRejectCriteria
  WHERE [CS].[SITEID] NOT IN (SELECT [SiteID]
						  FROM [EDW_BiometricViewRejectCriteria]
						  WHERE COALESCE ([HFTC].[EventDate] , [HFTC].[ItemCreatedWhen]) < [ItemCreatedWhen]) 
    AND [HFA].[AccountCD] NOT IN (SELECT [AccountCD]
							 FROM [EDW_BiometricViewRejectCriteria]
							 WHERE [HFA].[AccountCD] = [AccountCD]
							   AND COALESCE ([HFTC].[EventDate] , [HFTC].[ItemCreatedWhen]) < [ItemCreatedWhen]) 
    AND ([HFTC].[ItemCreatedWhen] IS NOT NULL
	 OR [HFTC].[EventDate] IS NOT NULL)		--Add per RObert and Laura 12.4.2014

UNION ALL
SELECT distinct
[HFTBSAG].[UserID]
, [cus].[UserSettingsUserGUID]
, [cus].[HFitUserMpiNumber]
, [cus2].[SiteID]
, [cs].[SiteGUID]
, cast([HFTBSAG].[ItemCreatedWhen] as datetime) ItemCreatedWhen
, cast([HFTBSAG].[ItemModifiedWhen] as datetime) ItemModifiedWhen
, [HFTBSAG].[Notes]
, [HFTBSAG].[IsProfessionallyCollected]
, cast([HFTBSAG].[EventDate] as datetime ) as EventDate
, 'Not Build Yet' AS [EventName]
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, [HFTBSAG].[Units]
, [HFTBSAG].[FastingState]
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, [HFTCS].[CollectionSourceName_External]
, [HFA].[AccountID]
, [HFA].[AccountCD]
, CASE
	 WHEN [HFTBSAG].[ItemCreatedWhen] = COALESCE ([HFTBSAG].[ItemModifiedWhen] , [HFTBSAG].[ItemCreatedWhen]) 
	 THEN 'I'
	 ELSE 'U'
  END AS [ChangeType]
, cast([HFTBSAG].[ItemCreatedWhen] as datetime) ItemCreatedWhen
, cast([HFTBSAG].[ItemModifiedWhen] as datetime) ItemModifiedWhen
, [HFTCS].[TrackerCollectionSourceID]
, [HFTBSAG].[itemid]
, 'HFit_TrackerBloodSugarAndGlucose' AS [TBL]
, [VENDOR].[ItemID] AS [VendorID]
, [VENDOR].[VendorName]
  FROM
	  [dbo].[HFit_TrackerBloodSugarAndGlucose] AS [HFTBSAG]
		 INNER JOIN [dbo].[HFit_TrackerCollectionSource] AS [HFTCS]
			ON [HFTBSAG].[TrackerCollectionSourceID] = [HFTCS].[TrackerCollectionSourceID]
		 INNER JOIN [dbo].[CMS_UserSettings] AS [CUS]
			ON [HFTBSAG].[UserID] = [cus].[UserSettingsUserID]
		 INNER JOIN [dbo].[CMS_UserSite] AS [CUS2]
			ON [cus].[UserSettingsUserID] = [cus2].[UserID]
		 INNER JOIN [dbo].[CMS_Site] AS [CS]
			ON [CUS2].[SiteID] = [CS].[SiteID]
		 INNER JOIN [dbo].[HFit_Account] AS [HFA]
			ON [cs].[SiteID] = [HFA].[SiteID]
		 LEFT OUTER JOIN [HFit_LKP_TrackerVendor] AS [VENDOR]
			ON [HFTBSAG].[VendorID] = [VENDOR].[ItemID]
  --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table EDW_BiometricViewRejectCriteria
  WHERE [CS].[SITEID] NOT IN (SELECT [SiteID]
						  FROM [EDW_BiometricViewRejectCriteria]
						  WHERE COALESCE ([HFTBSAG].[EventDate] , [HFTBSAG].[ItemCreatedWhen]) < [ItemCreatedWhen]) 
    AND [HFA].[AccountCD] NOT IN (SELECT [AccountCD]
							 FROM [EDW_BiometricViewRejectCriteria]
							 WHERE [HFA].[AccountCD] = [AccountCD]
							   AND COALESCE ([HFTBSAG].[EventDate] , [HFTBSAG].[ItemCreatedWhen]) < [ItemCreatedWhen]) 
    AND ([HFTBSAG].[ItemCreatedWhen] IS NOT NULL
	 OR [HFTBSAG].[EventDate] IS NOT NULL)		--Add per RObert and Laura 12.4.2014

UNION ALL
SELECT distinct
[HFTBP].[UserID]
, [cus].[UserSettingsUserGUID]
, [cus].[HFitUserMpiNumber]
, [cus2].[SiteID]
, [cs].[SiteGUID]
, cast([HFTBP].[ItemCreatedWhen] as datetime) ItemCreatedWhen
, cast([HFTBP].[ItemModifiedWhen] as datetime) ItemModifiedWhen
, [HFTBP].[Notes]
, [HFTBP].[IsProfessionallyCollected]
, cast([HFTBP].[EventDate] as datetime ) as EventDate
, 'Not Build Yet' AS [EventName]
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, [HFTBP].[Systolic]
, [HFTBP].[Diastolic]
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, [HFTCS].[CollectionSourceName_External]
, [HFA].[AccountID]
, [HFA].[AccountCD]
, CASE
	 WHEN [HFTBP].[ItemCreatedWhen] = COALESCE ([HFTBP].[ItemModifiedWhen] , [HFTBP].[ItemCreatedWhen]) 
	 THEN 'I'
	 ELSE 'U'
  END AS [ChangeType]
, cast([HFTBP].[ItemCreatedWhen] as datetime) ItemCreatedWhen
, cast([HFTBP].[ItemModifiedWhen] as datetime) ItemModifiedWhen
, [HFTCS].[TrackerCollectionSourceID]
, [HFTBP].[itemid]
, 'HFit_TrackerBloodPressure' AS [TBL]
, [VENDOR].[ItemID] AS [VendorID]
, [VENDOR].[VendorName]
  FROM
	  [dbo].[HFit_TrackerBloodPressure] AS [HFTBP]
		 INNER JOIN [dbo].[HFit_TrackerCollectionSource] AS [HFTCS]
			ON [HFTBP].[TrackerCollectionSourceID] = [HFTCS].[TrackerCollectionSourceID]
		 INNER JOIN [dbo].[CMS_UserSettings] AS [CUS]
			ON [HFTBP].[UserID] = [cus].[UserSettingsUserID]
		 INNER JOIN [dbo].[CMS_UserSite] AS [CUS2]
			ON [cus].[UserSettingsUserID] = [cus2].[UserID]
		 INNER JOIN [dbo].[CMS_Site] AS [CS]
			ON [CUS2].[SiteID] = [CS].[SiteID]
		 INNER JOIN [dbo].[HFit_Account] AS [HFA]
			ON [cs].[SiteID] = [HFA].[SiteID]
		 LEFT OUTER JOIN [HFit_LKP_TrackerVendor] AS [VENDOR]
			ON [HFTBP].[VendorID] = [VENDOR].[ItemID]
  --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table EDW_BiometricViewRejectCriteria
  WHERE [CS].[SITEID] NOT IN (SELECT [SiteID]
						  FROM [EDW_BiometricViewRejectCriteria]
						  WHERE COALESCE ([HFTBP].[EventDate] , [HFTBP].[ItemCreatedWhen]) < [ItemCreatedWhen]) 
    AND [HFA].[AccountCD] NOT IN (SELECT [AccountCD]
							 FROM [EDW_BiometricViewRejectCriteria]
							 WHERE [HFA].[AccountCD] = [AccountCD]
							   AND COALESCE ([HFTBP].[EventDate] , [HFTBP].[ItemCreatedWhen]) < [ItemCreatedWhen]) 
    AND ([HFTBP].[ItemCreatedWhen] IS NOT NULL
	 OR [HFTBP].[EventDate] IS NOT NULL)		--Add per RObert and Laura 12.4.2014

UNION ALL
SELECT distinct
[HFTBF].[UserID]
, [cus].[UserSettingsUserGUID]
, [cus].[HFitUserMpiNumber]
, [cus2].[SiteID]
, [cs].[SiteGUID]
, cast([HFTBF].[ItemCreatedWhen] as datetime) ItemCreatedWhen
, cast([HFTBF].[ItemModifiedWhen] as datetime) ItemModifiedWhen
, [HFTBF].[Notes]
, [HFTBF].[IsProfessionallyCollected]
, cast([HFTBF].[EventDate] as datetime ) as EventDate
, 'Not Build Yet' AS [EventName]
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, [HFTBF].Value AS [PPTBodyFatPCT]
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, [HFTCS].[CollectionSourceName_External]
, [HFA].[AccountID]
, [HFA].[AccountCD]
, CASE
	 WHEN [HFTBF].[ItemCreatedWhen] = COALESCE ([HFTBF].[ItemModifiedWhen] , [HFTBF].[ItemCreatedWhen]) 
	 THEN 'I'
	 ELSE 'U'
  END AS [ChangeType]
, cast([HFTBF].[ItemCreatedWhen] as datetime) ItemCreatedWhen
, cast([HFTBF].[ItemModifiedWhen] as datetime) ItemModifiedWhen
, [HFTCS].[TrackerCollectionSourceID]
, [HFTBF].[itemid]
, 'HFit_TrackerBodyFat' AS [TBL]
, [VENDOR].[ItemID] AS [VendorID]
, [VENDOR].[VendorName]
  FROM
	  [dbo].[HFit_TrackerBodyFat] AS [HFTBF]
		 INNER JOIN [dbo].[HFit_TrackerCollectionSource] AS [HFTCS]
			ON [HFTBF].[TrackerCollectionSourceID] = [HFTCS].[TrackerCollectionSourceID]
		 INNER JOIN [dbo].[CMS_UserSettings] AS [CUS]
			ON [HFTBF].[UserID] = [cus].[UserSettingsUserID]
		 INNER JOIN [dbo].[CMS_UserSite] AS [CUS2]
			ON [cus].[UserSettingsUserID] = [cus2].[UserID]
		 INNER JOIN [dbo].[CMS_Site] AS [CS]
			ON [CUS2].[SiteID] = [CS].[SiteID]
		 INNER JOIN [dbo].[HFit_Account] AS [HFA]
			ON [cs].[SiteID] = [HFA].[SiteID]
		 LEFT OUTER JOIN [HFit_LKP_TrackerVendor] AS [VENDOR]
			ON [HFTBF].[VendorID] = [VENDOR].[ItemID]
  --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table EDW_BiometricViewRejectCriteria
  WHERE [CS].[SITEID] NOT IN (SELECT [SiteID]
						  FROM [EDW_BiometricViewRejectCriteria]
						  WHERE COALESCE ([HFTBF].[EventDate] , [HFTBF].[ItemCreatedWhen]) < [ItemCreatedWhen]) 
    AND [HFA].[AccountCD] NOT IN (SELECT [AccountCD]
							 FROM [EDW_BiometricViewRejectCriteria]
							 WHERE [HFA].[AccountCD] = [AccountCD]
							   AND COALESCE ([HFTBF].[EventDate] , [HFTBF].[ItemCreatedWhen]) < [ItemCreatedWhen]) 
    AND ([HFTBF].[ItemCreatedWhen] IS NOT NULL
	 OR [HFTBF].[EventDate] IS NOT NULL)		--Add per RObert and Laura 12.4.2014

UNION ALL
SELECT distinct
[HFTB].[UserID]
, [cus].[UserSettingsUserGUID]
, [cus].[HFitUserMpiNumber]
, [cus2].[SiteID]
, [cs].[SiteGUID]
, cast([HFTB].[ItemCreatedWhen] as datetime) ItemCreatedWhen
, cast([HFTB].[ItemModifiedWhen] as datetime) ItemModifiedWhen
, [HFTB].[Notes]
, [HFTB].[IsProfessionallyCollected]
, cast([HFTB].[EventDate] as datetime ) as EventDate
, 'Not Build Yet' AS [EventName]
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, [HFTB].[BMI]
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, [HFTCS].[CollectionSourceName_External]
, [HFA].[AccountID]
, [HFA].[AccountCD]
, CASE
	 WHEN [HFTB].[ItemCreatedWhen] = COALESCE ([HFTB].[ItemModifiedWhen] , [HFTB].[ItemCreatedWhen]) 
	 THEN 'I'
	 ELSE 'U'
  END AS [ChangeType]
, cast([HFTB].[ItemCreatedWhen] as datetime) ItemCreatedWhen
, cast([HFTB].[ItemModifiedWhen] as datetime) ItemModifiedWhen
, [HFTCS].[TrackerCollectionSourceID]
, [HFTB].[itemid]
, 'HFit_TrackerBMI' AS [TBL]
, [VENDOR].[ItemID] AS [VendorID]
, [VENDOR].[VendorName]
  FROM
	  [dbo].[HFit_TrackerBMI] AS [HFTB]
		 INNER JOIN [dbo].[HFit_TrackerCollectionSource] AS [HFTCS]
			ON [HFTB].[TrackerCollectionSourceID] = [HFTCS].[TrackerCollectionSourceID]
		 INNER JOIN [dbo].[CMS_UserSettings] AS [CUS]
			ON [HFTB].[UserID] = [cus].[UserSettingsUserID]
		 INNER JOIN [dbo].[CMS_UserSite] AS [CUS2]
			ON [cus].[UserSettingsUserID] = [cus2].[UserID]
		 INNER JOIN [dbo].[CMS_Site] AS [CS]
			ON [CUS2].[SiteID] = [CS].[SiteID]
		 INNER JOIN [dbo].[HFit_Account] AS [HFA]
			ON [cs].[SiteID] = [HFA].[SiteID]
		 LEFT OUTER JOIN [HFit_LKP_TrackerVendor] AS [VENDOR]
			ON [HFTB].[VendorID] = [VENDOR].[ItemID]
  --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified within table EDW_BiometricViewRejectCriteria
  WHERE [CS].[SITEID] NOT IN (SELECT [SiteID]
						  FROM [EDW_BiometricViewRejectCriteria]
						  WHERE COALESCE ([HFTB].[EventDate] , [HFTB].[ItemCreatedWhen]) < [ItemCreatedWhen]) 
    AND [HFA].[AccountCD] NOT IN (SELECT [AccountCD]
							 FROM [EDW_BiometricViewRejectCriteria]
							 WHERE [HFA].[AccountCD] = [AccountCD]
							   AND COALESCE ([HFTB].[EventDate] , [HFTB].[ItemCreatedWhen]) < [ItemCreatedWhen]) 
    AND ([HFTB].[ItemCreatedWhen] IS NOT NULL
	 OR [HFTB].[EventDate] IS NOT NULL)		--Add per RObert and Laura 12.4.2014

UNION ALL
SELECT distinct
[HFTBM].[UserID]
, [cus].[UserSettingsUserGUID]
, [cus].[HFitUserMpiNumber]
, [cus2].[SiteID]
, [cs].[SiteGUID]
, cast([HFTBM].[ItemCreatedWhen] as datetime) ItemCreatedWhen
, cast([HFTBM].[ItemModifiedWhen] as datetime) ItemModifiedWhen
, [HFTBM].[Notes]
, [HFTBM].[IsProfessionallyCollected]
, cast([HFTBM].[EventDate] as datetime ) as EventDate
, 'Not Build Yet' AS [EventName]
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, [HFTBM].[WaistInches]
, [HFTBM].[HipInches]
, [HFTBM].[ThighInches]
, [HFTBM].[ArmInches]
, [HFTBM].[ChestInches]
, [HFTBM].[CalfInches]
, [HFTBM].[NeckInches]
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, [HFTCS].[CollectionSourceName_External]
, [HFA].[AccountID]
, [HFA].[AccountCD]
, CASE
	 WHEN [HFTBM].[ItemCreatedWhen] = COALESCE ([HFTBM].[ItemModifiedWhen] , [HFTBM].[ItemCreatedWhen]) 
	 THEN 'I'
	 ELSE 'U'
  END AS [ChangeType]
, cast([HFTBM].[ItemCreatedWhen] as datetime) ItemCreatedWhen
, cast([HFTBM].[ItemModifiedWhen] as datetime) ItemModifiedWhen
, [HFTCS].[TrackerCollectionSourceID]
, [HFTBM].[itemid]
, 'HFit_TrackerBodyMeasurements' AS [TBL]
, [VENDOR].[ItemID] AS [VendorID]
, [VENDOR].[VendorName]
  FROM
	  [dbo].[HFit_TrackerBodyMeasurements] AS [HFTBM]
		 INNER JOIN [dbo].[HFit_TrackerCollectionSource] AS [HFTCS]
			ON [HFTBM].[TrackerCollectionSourceID] = [HFTCS].[TrackerCollectionSourceID]
		 INNER JOIN [dbo].[CMS_UserSettings] AS [CUS]
			ON [HFTBM].[UserID] = [cus].[UserSettingsUserID]
		 INNER JOIN [dbo].[CMS_UserSite] AS [CUS2]
			ON [cus].[UserSettingsUserID] = [cus2].[UserID]
		 INNER JOIN [dbo].[CMS_Site] AS [CS]
			ON [CUS2].[SiteID] = [CS].[SiteID]
		 INNER JOIN [dbo].[HFit_Account] AS [HFA]
			ON [cs].[SiteID] = [HFA].[SiteID]
		 LEFT OUTER JOIN [HFit_LKP_TrackerVendor] AS [VENDOR]
			ON [HFTBM].[VendorID] = [VENDOR].[ItemID]
  --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table EDW_BiometricViewRejectCriteria
  WHERE [CS].[SITEID] NOT IN (SELECT [SiteID]
						  FROM [EDW_BiometricViewRejectCriteria]
						  WHERE COALESCE ([HFTBM].[EventDate] , [HFTBM].[ItemCreatedWhen]) < [ItemCreatedWhen]) 
    AND [HFA].[AccountCD] NOT IN (SELECT [AccountCD]
							 FROM [EDW_BiometricViewRejectCriteria]
							 WHERE [HFA].[AccountCD] = [AccountCD]
							   AND COALESCE ([HFTBM].[EventDate] , [HFTBM].[ItemCreatedWhen]) < [ItemCreatedWhen]) 
    AND ([HFTBM].[ItemCreatedWhen] IS NOT NULL
	 OR [HFTBM].[EventDate] IS NOT NULL)		--Add per RObert and Laura 12.4.2014

UNION ALL
SELECT distinct
[HFTH].[UserID]
, [cus].[UserSettingsUserGUID]
, [cus].[HFitUserMpiNumber]
, [cus2].[SiteID]
, [cs].[SiteGUID]
, cast([HFTH].[ItemCreatedWhen] as datetime) ItemCreatedWhen
, cast([HFTH].[ItemModifiedWhen] as datetime) ItemModifiedWhen
, [HFTH].[Notes]
, [HFTH].[IsProfessionallyCollected]
, cast([HFTH].[EventDate] as datetime ) as EventDate
, 'Not Build Yet' AS [EventName]
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, [HFTH].[Height]
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, [HFTCS].[CollectionSourceName_External]
, [HFA].[AccountID]
, [HFA].[AccountCD]
, CASE
	 WHEN [HFTH].[ItemCreatedWhen] = COALESCE ([HFTH].[ItemModifiedWhen] , [HFTH].[ItemCreatedWhen]) 
	 THEN 'I'
	 ELSE 'U'
  END AS [ChangeType]
, cast([HFTH].[ItemCreatedWhen] as datetime) ItemCreatedWhen
, cast([HFTH].[ItemModifiedWhen] as datetime) ItemModifiedWhen
, [HFTCS].[TrackerCollectionSourceID]
, [HFTH].[itemid]
, 'HFit_TrackerHeight' AS [TBL]
, [VENDOR].[ItemID] AS [VendorID]
, [VENDOR].[VendorName]
  FROM
	  [dbo].[HFit_TrackerHeight] AS [HFTH]
		 INNER JOIN [dbo].[HFit_TrackerCollectionSource] AS [HFTCS]
			ON [HFTH].[TrackerCollectionSourceID] = [HFTCS].[TrackerCollectionSourceID]
		 INNER JOIN [dbo].[CMS_UserSettings] AS [CUS]
			ON [HFTH].[UserID] = [cus].[UserSettingsUserID]
		 INNER JOIN [dbo].[CMS_UserSite] AS [CUS2]
			ON [cus].[UserSettingsUserID] = [cus2].[UserID]
		 INNER JOIN [dbo].[CMS_Site] AS [CS]
			ON [CUS2].[SiteID] = [CS].[SiteID]
		 INNER JOIN [dbo].[HFit_Account] AS [HFA]
			ON [cs].[SiteID] = [HFA].[SiteID]
		 LEFT OUTER JOIN [HFit_LKP_TrackerVendor] AS [VENDOR]
			ON [HFTH].[VendorID] = [VENDOR].[ItemID]
  --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table EDW_BiometricViewRejectCriteria		
  WHERE [CS].[SITEID] NOT IN (SELECT [SiteID]
						  FROM [EDW_BiometricViewRejectCriteria]
						  WHERE COALESCE ([HFTH].[EventDate] , [HFTH].[ItemCreatedWhen]) < [ItemCreatedWhen]) 
    AND [HFA].[AccountCD] NOT IN (SELECT [AccountCD]
							 FROM [EDW_BiometricViewRejectCriteria]
							 WHERE [HFA].[AccountCD] = [AccountCD]
							   AND COALESCE ([HFTH].[EventDate] , [HFTH].[ItemCreatedWhen]) < [ItemCreatedWhen]) 
    AND ([HFTH].[ItemCreatedWhen] IS NOT NULL
	 OR [HFTH].[EventDate] IS NOT NULL)		--Add per RObert and Laura 12.4.2014
UNION ALL
SELECT distinct
[HFTRHR].[UserID]
, [cus].[UserSettingsUserGUID]
, [cus].[HFitUserMpiNumber]
, [cus2].[SiteID]
, [cs].[SiteGUID]
, cast([HFTRHR].[ItemCreatedWhen] as datetime) ItemCreatedWhen
, cast([HFTRHR].[ItemModifiedWhen] as datetime) ItemModifiedWhen
, [HFTRHR].[Notes]
, [HFTRHR].[IsProfessionallyCollected]
, cast([HFTRHR].[EventDate] as datetime ) as EventDate
, 'Not Build Yet' AS [EventName]
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, [HFTRHR].[HeartRate]
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, [HFTCS].[CollectionSourceName_External]
, [HFA].[AccountID]
, [HFA].[AccountCD]
, CASE
	 WHEN [HFTRHR].[ItemCreatedWhen] = COALESCE ([HFTRHR].[ItemModifiedWhen] , [HFTRHR].[ItemCreatedWhen]) 
	 THEN 'I'
	 ELSE 'U'
  END AS [ChangeType]
, cast([HFTRHR].[ItemCreatedWhen] as datetime) ItemCreatedWhen
, cast([HFTRHR].[ItemModifiedWhen] as datetime) ItemModifiedWhen
, [HFTCS].[TrackerCollectionSourceID]
, [HFTRHR].[itemid]
, 'HFit_TrackerRestingHeartRate' AS [TBL]
, [VENDOR].[ItemID] AS [VendorID]
, [VENDOR].[VendorName]
  FROM
	  [dbo].[HFit_TrackerRestingHeartRate] AS [HFTRHR]
		 INNER JOIN [dbo].[HFit_TrackerCollectionSource] AS [HFTCS]
			ON [HFTRHR].[TrackerCollectionSourceID] = [HFTCS].[TrackerCollectionSourceID]
		 INNER JOIN [dbo].[CMS_UserSettings] AS [CUS]
			ON [HFTRHR].[UserID] = [cus].[UserSettingsUserID]
		 INNER JOIN [dbo].[CMS_UserSite] AS [CUS2]
			ON [cus].[UserSettingsUserID] = [cus2].[UserID]
		 INNER JOIN [dbo].[CMS_Site] AS [CS]
			ON [CUS2].[SiteID] = [CS].[SiteID]
		 INNER JOIN [dbo].[HFit_Account] AS [HFA]
			ON [cs].[SiteID] = [HFA].[SiteID]
		 LEFT OUTER JOIN [HFit_LKP_TrackerVendor] AS [VENDOR]
			ON [HFTRHR].[VendorID] = [VENDOR].[ItemID]
  --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table EDW_BiometricViewRejectCriteria
  WHERE [CS].[SITEID] NOT IN (SELECT [SiteID]
						  FROM [EDW_BiometricViewRejectCriteria]
						  WHERE COALESCE ([HFTRHR].[EventDate] , [HFTRHR].[ItemCreatedWhen]) < [ItemCreatedWhen]) 
    AND [HFA].[AccountCD] NOT IN (SELECT [AccountCD]
							 FROM [EDW_BiometricViewRejectCriteria]
							 WHERE [HFA].[AccountCD] = [AccountCD]
							   AND COALESCE ([HFTRHR].[EventDate] , [HFTRHR].[ItemCreatedWhen]) < [ItemCreatedWhen]) 
    AND ([HFTRHR].[ItemCreatedWhen] IS NOT NULL
	 OR [HFTRHR].[EventDate] IS NOT NULL)		--Add per RObert and Laura 12.4.2014

UNION ALL
SELECT distinct
[HFTS].[UserID]
, [cus].[UserSettingsUserGUID]
, [cus].[HFitUserMpiNumber]
, [cus2].[SiteID]
, [cs].[SiteGUID]
, cast([HFTS].[ItemCreatedWhen] as datetime) ItemCreatedWhen
, cast([HFTS].[ItemModifiedWhen] as datetime) ItemModifiedWhen
, [HFTS].[Notes]
, [HFTS].[IsProfessionallyCollected]
, cast([HFTS].[EventDate] as datetime ) as EventDate
, 'Not Build Yet' AS [EventName]
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, [HFTS].[FluShot]
, [HFTS].[PneumoniaShot]
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, [HFTCS].[CollectionSourceName_External]
, [HFA].[AccountID]
, [HFA].[AccountCD]
, CASE
	 WHEN [HFTS].[ItemCreatedWhen] = COALESCE ([HFTS].[ItemModifiedWhen] , [HFTS].[ItemCreatedWhen]) 
	 THEN 'I'
	 ELSE 'U'
  END AS [ChangeType]
, cast([HFTS].[ItemCreatedWhen] as datetime) ItemCreatedWhen
, cast([HFTS].[ItemModifiedWhen] as datetime) ItemModifiedWhen
, [HFTCS].[TrackerCollectionSourceID]
, [HFTS].[itemid]
, 'HFit_TrackerShots' AS [TBL]
, [VENDOR].[ItemID] AS [VendorID]
, [VENDOR].[VendorName]
  FROM
	  [dbo].[HFit_TrackerShots] AS [HFTS]
		 INNER JOIN [dbo].[HFit_TrackerCollectionSource] AS [HFTCS]
			ON [HFTS].[TrackerCollectionSourceID] = [HFTCS].[TrackerCollectionSourceID]
		 INNER JOIN [dbo].[CMS_UserSettings] AS [CUS]
			ON [HFTS].[UserID] = [cus].[UserSettingsUserID]
		 INNER JOIN [dbo].[CMS_UserSite] AS [CUS2]
			ON [cus].[UserSettingsUserID] = [cus2].[UserID]
		 INNER JOIN [dbo].[CMS_Site] AS [CS]
			ON [CUS2].[SiteID] = [CS].[SiteID]
		 INNER JOIN [dbo].[HFit_Account] AS [HFA]
			ON [cs].[SiteID] = [HFA].[SiteID]
		 LEFT OUTER JOIN [HFit_LKP_TrackerVendor] AS [VENDOR]
			ON [HFTS].[VendorID] = [VENDOR].[ItemID]
  --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table EDW_BiometricViewRejectCriteria
  WHERE [CS].[SITEID] NOT IN (SELECT [SiteID]
						  FROM [EDW_BiometricViewRejectCriteria]
						  WHERE COALESCE ([HFTS].[EventDate] , [HFTS].[ItemCreatedWhen]) < [ItemCreatedWhen]) 
    AND [HFA].[AccountCD] NOT IN (SELECT [AccountCD]
							 FROM [EDW_BiometricViewRejectCriteria]
							 WHERE [HFA].[AccountCD] = [AccountCD]
							   AND COALESCE ([HFTS].[EventDate] , [HFTS].[ItemCreatedWhen]) < [ItemCreatedWhen]) 
    AND ([HFTS].[ItemCreatedWhen] IS NOT NULL
	 OR [HFTS].[EventDate] IS NOT NULL)		--Add per RObert and Laura 12.4.2014

UNION ALL
SELECT distinct
[HFTT].[UserID]
, [cus].[UserSettingsUserGUID]
, [cus].[HFitUserMpiNumber]
, [cus2].[SiteID]
, [cs].[SiteGUID]
, cast([HFTT].[ItemCreatedWhen] as datetime) ItemCreatedWhen
, cast([HFTT].[ItemModifiedWhen] as datetime) ItemModifiedWhen
, [HFTT].[Notes]
, [HFTT].[IsProfessionallyCollected]
, cast([HFTT].[EventDate] as datetime ) as EventDate
, 'Not Build Yet' AS [EventName]
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, [HFTT].[PSATest]
, [HFTT].[OtherExam]
, [HFTT].[TScore]
, [HFTT].[DRA]
, [HFTT].[CotinineTest]
, [HFTT].[ColoCareKit]
, [HFTT].[CustomTest]
, [HFTT].[CustomDesc]
, [HFTCS].[CollectionSourceName_External]
, [HFA].[AccountID]
, [HFA].[AccountCD]
, CASE
	 WHEN [HFTT].[ItemCreatedWhen] = COALESCE ([HFTT].[ItemModifiedWhen] , [HFTT].[ItemCreatedWhen]) 
	 THEN 'I'
	 ELSE 'U'
  END AS [ChangeType]
, cast([HFTT].[ItemCreatedWhen] as datetime) ItemCreatedWhen
, cast([HFTT].[ItemModifiedWhen] as datetime) ItemModifiedWhen
, [HFTCS].[TrackerCollectionSourceID]
, [HFTT].[itemid]
, 'HFit_TrackerTests' AS [TBL]
, [VENDOR].[ItemID] AS [VendorID]
, [VENDOR].[VendorName]
  FROM
	  [dbo].[HFit_TrackerTests] AS [HFTT]
		 INNER JOIN [dbo].[HFit_TrackerCollectionSource] AS [HFTCS]
			ON [HFTT].[TrackerCollectionSourceID] = [HFTCS].[TrackerCollectionSourceID]
		 INNER JOIN [dbo].[CMS_UserSettings] AS [CUS]
			ON [HFTT].[UserID] = [cus].[UserSettingsUserID]
		 INNER JOIN [dbo].[CMS_UserSite] AS [CUS2]
			ON [cus].[UserSettingsUserID] = [cus2].[UserID]
		 INNER JOIN [dbo].[CMS_Site] AS [CS]
			ON [CUS2].[SiteID] = [CS].[SiteID]
		 INNER JOIN [dbo].[HFit_Account] AS [HFA]
			ON [cs].[SiteID] = [HFA].[SiteID]
		 LEFT OUTER JOIN [HFit_LKP_TrackerVendor] AS [VENDOR]
			ON [HFTT].[VendorID] = [VENDOR].[ItemID]
  --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table EDW_BiometricViewRejectCriteria
  WHERE [CS].[SITEID] NOT IN (SELECT [SiteID]
						  FROM [EDW_BiometricViewRejectCriteria]
						  WHERE COALESCE ([HFTT].[EventDate] , [HFTT].[ItemCreatedWhen]) < [ItemCreatedWhen]) 
    AND [HFA].[AccountCD] NOT IN (SELECT [AccountCD]
							 FROM [EDW_BiometricViewRejectCriteria]
							 WHERE [HFA].[AccountCD] = [AccountCD]
							   AND COALESCE ([HFTT].[EventDate] , [HFTT].[ItemCreatedWhen]) < [ItemCreatedWhen]) 
    AND ([HFTT].[ItemCreatedWhen] IS NOT NULL
	 OR [HFTT].[EventDate] IS NOT NULL);		--Add per RObert and Laura 12.4.2014

--HFit_TrackerBMI
--HFit_TrackerBodyMeasurements
--HFit_TrackerHeight
--HFit_TrackerRestingHeartRate
--HFit_TrackerShots
--HFit_TrackerTests

GO

PRINT 'Created view_EDW_BioMetrics: ' + CAST (GETDATE () AS nvarchar (50)) ;
GO
--  
--  
GO
PRINT '***** FROM: view_EDW_BioMetrics.sql';
GO

----***************************************************************************************************************************
----** REMOVE THE INSERTS AFTER INTITAL LOAD
----***************************************************************************************************************************
--truncate table EDW_BiometricViewRejectCriteria ;
--go 
--insert into EDW_BiometricViewRejectCriteria (AccountCD, ItemCreatedWhen, SiteID)
--Values (
--'trstmark','11/4/2013',-1) ;
--GO
--insert into EDW_BiometricViewRejectCriteria (AccountCD, ItemCreatedWhen, SiteID)
--Values (
--'entergy','1/6/2014',-1) ;
--GO
--insert into EDW_BiometricViewRejectCriteria (AccountCD, ItemCreatedWhen, SiteID)
--Values (
--'mcwp','1/27/2014',-1) ;
--GO
--insert into EDW_BiometricViewRejectCriteria (AccountCD, ItemCreatedWhen, SiteID)
--Values (
--'stateneb','4/1/2014',-1) ;
--GO
--insert into EDW_BiometricViewRejectCriteria (AccountCD, ItemCreatedWhen, SiteID)
--Values (
--'jnj','5/28/2014',-1) ;
--GO
--insert into EDW_BiometricViewRejectCriteria (AccountCD, ItemCreatedWhen, SiteID)
--Values (
--'coopers','7/1/2014',-1) ;
--GO
--insert into EDW_BiometricViewRejectCriteria (AccountCD, ItemCreatedWhen, SiteID)
--Values (
--'cnh','8/4/2014',-1) ;
--GO
--insert into EDW_BiometricViewRejectCriteria (AccountCD, ItemCreatedWhen, SiteID)
--Values (
--'amat','8/4/2014',-1) ;
--GO
--insert into EDW_BiometricViewRejectCriteria (AccountCD, ItemCreatedWhen, SiteID)
--Values (
--'dupont','8/18/2014',-1) ;
--GO
--insert into EDW_BiometricViewRejectCriteria (AccountCD, ItemCreatedWhen, SiteID)
--Values (
--'ejones','9/3/2014',-1) ;
--GO
--insert into EDW_BiometricViewRejectCriteria (AccountCD, ItemCreatedWhen, SiteID)
--Values (
--'avera','9/15/2014',-1) ;
--GO
--insert into EDW_BiometricViewRejectCriteria (AccountCD, ItemCreatedWhen, SiteID)
--Values (
--'sprvalu','9/18/2014',-1) ;
--GO
--insert into EDW_BiometricViewRejectCriteria (AccountCD, ItemCreatedWhen, SiteID)
--Values (
--'firstgrp','10/6/2014',-1) ;
--GO
--insert into EDW_BiometricViewRejectCriteria (AccountCD, ItemCreatedWhen, SiteID)
--Values (
--'rexnord','12/2/2014',-1) ;
--GO
PRINT '***** COMPLETED : view_EDW_BioMetrics.sql';
GO 



go
Print '--------------------------------------------------------------';
Print 'END/start:';
print getdate();
Print '--------------------------------------------------------------';
go


GO
PRINT 'Processing: view_EDW_HealthAssesmentClientView ';
GO

IF EXISTS (SELECT
                  TABLE_NAME
                  FROM INFORMATION_SCHEMA.VIEWS
             WHERE TABLE_NAME = 'view_EDW_HealthAssesmentClientView') 
    BEGIN
        DROP VIEW
             view_EDW_HealthAssesmentClientView;
    END;
GO

--GRANT SELECT
--	ON [dbo].[view_EDW_HealthAssesmentClientView]
--	TO [EDWReader_PRD]
--GO

--******************************************************************************
--8/8/2014 - Generated corrected view in DEV (WDM)
--09.11.2014 (wdm) added to facilitate EDW last mod date
--02.04.2015 (wdm) #48828 added , HACampaign.BiometricCampaignStartDate, 
--		  HACampaign.BiometricCampaignEndDate, HACampaign.CampaignStartDate, 
--		  HACampaign.CampaignEndDate, HACampaign.Name, 
--		  HACampaign.NodeGuid as CampaignNodeGuid
--02.05.2015 Ashwin and I reviewed and approved
-- select top 100 * from view_EDW_HealthAssesmentClientView
--03.27.2015 ( Sowmiya V) - made changes to the view to look at the HealthAssesmentID 
--  only in the join condition.
--  The fix was needed to handle the SR#51281: Platform CampaignNodeGuid missing. 
--	   for view view_EDW_HealthAssesmentClientView
--  Leaving the old code as commented with notes. 
-- 03.13.2015 - (WDM) set the view up for change tracking - the SIMPLE version that does not 
--			 require change tracking tables to be involved.
--select count(*) from view_EDW_HealthAssesmentClientView
--SELECT * FROM   INFORMATION_SCHEMA.VIEWS WHERE  VIEW_DEFINITION like '%view_EDW_HealthAssesmentClientView%'
--******************************************************************************
CREATE VIEW dbo.view_EDW_HealthAssesmentClientView
AS SELECT 
          HFitAcct.AccountID
        , HFitAcct.AccountCD
        , HFitAcct.AccountName
        , HFitAcct.ItemGUID AS ClientGuid
        , CMSSite.SiteGUID
        , NULL AS CompanyID
        , NULL AS CompanyGUID
        , NULL AS CompanyName
        , HAJoined.DocumentName
        , cast(HACampaign.DocumentPublishFrom as datetime) AS HAStartDate
        , cast(HACampaign.DocumentPublishTo as datetime) AS HAEndDate
        , HACampaign.NodeSiteID
        , HAAssessmentMod.Title
        , HAAssessmentMod.CodeName
        , HAAssessmentMod.IsEnabled
        , CASE
              WHEN CAST (HACampaign.DocumentCreatedWhen AS date) = CAST (HACampaign.DocumentModifiedWhen AS date) 
                  THEN 'I'
              ELSE 'U'
          END AS ChangeType
        , cast(HACampaign.DocumentCreatedWhen as datetime) as DocumentCreatedWhen
        , cast(HACampaign.DocumentModifiedWhen as datetime) as DocumentModifiedWhen
        , cast(HAAssessmentMod.DocumentModifiedWhen  as datetime) AS AssesmentModule_DocumentModifiedWhen     --09.11.2014 (wdm) added to facilitate EDW last mod date
        , HAAssessmentMod.DocumentCulture AS DocumentCulture_HAAssessmentMod
        , HACampaign.DocumentCulture AS DocumentCulture_HACampaign
        , HAJoined.DocumentCulture AS DocumentCulture_HAJoined
        , cast(HACampaign.BiometricCampaignStartDate as datetime)as BiometricCampaignStartDate
        , cast(HACampaign.BiometricCampaignEndDate as datetime)as BiometricCampaignEndDate
        , cast(HACampaign.CampaignStartDate as datetime)as CampaignStartDate
        , cast(HACampaign.CampaignEndDate as datetime)as CampaignEndDate
        , HACampaign.Name
        , HACampaign.NodeGuid AS CampaignNodeGuid
        , HACampaign.HACampaignID
          FROM
               dbo.View_HFit_HACampaign_Joined AS HACampaign
                   INNER JOIN dbo.CMS_Site AS CMSSite
                       ON HACampaign.NodeSiteID = CMSSite.SiteID
                   INNER JOIN dbo.HFit_Account AS HFitAcct
                       ON HACampaign.NodeSiteID = HFitAcct.SiteID
                   INNER JOIN dbo.View_HFit_HealthAssessment_Joined AS HAJoined
                       ON HACampaign.HealthAssessmentID = HAJoined.DocumentID      --  added line to handle    SR #51281   
                          -- ON CASE ----03.27.2015 - Commented code to release the SR #51281
                          --WHEN [HACampaign].[HealthAssessmentConfigurationID] < 0
                          --THEN [HACampaign].[HealthAssessmentID]
                          --ELSE [HACampaign].[HealthAssessmentConfigurationID]
                          --END = HAJoined.DocumentID
                      AND HAJoined.DocumentCulture = 'en-US'
                   INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS HAAssessmentMod
                       ON HAJoined.nodeid = HAAssessmentMod.NodeParentID
                      AND HAAssessmentMod.DocumentCulture = 'en-US'
     WHERE HACampaign.DocumentCulture = 'en-US';
GO

PRINT 'Created: view_EDW_HealthAssesmentClientView ';
GO
--  
--  
GO
PRINT '***** FROM: view_EDW_HealthAssesmentClientView.sql';
GO 



go
Print '--------------------------------------------------------------';
Print 'END/start:';
print getdate();
Print '--------------------------------------------------------------';
go


PRINT 'Processing: view_EDW_HealthAssesmentDeffinition ' + CAST ( GETDATE () AS NVARCHAR (50)) ;
GO
-- exec sp_depends view_EDW_HealthAssesmentDeffinition
-- select count(*) from view_EDW_HealthAssesmentDeffinition

IF EXISTS ( SELECT
                   TABLE_NAME
                   FROM INFORMATION_SCHEMA.VIEWS
                   WHERE TABLE_NAME = 'view_EDW_HealthAssesmentDeffinition') 
    BEGIN
        DROP VIEW
             view_EDW_HealthAssesmentDeffinition;
    END;
GO
-- select * from view_EDW_HealthAssesmentDeffinition
CREATE VIEW dbo.view_EDW_HealthAssesmentDeffinition
AS SELECT DISTINCT
   --**************************************************************************************************************
   --NOTE: The column DocumentModifiedWhen comes from the CMS_TREE join - it was left 
   --		unchanged when other dates added for the Last Mod Date additions. 
   --		Therefore, the 'ChangeType' was left dependent upon this date only. 09.12.2014 (wdm)
   --*****************************************************************************************************************************************************
   --Test Queries:
   --select * from view_EDW_HealthAssesmentDeffinition where AnsDocumentGuid is not NULL
   --Changes:
   --WDM - 6/25/2014
   --Query was returning a NULL dataset. Found that it is being caused by the AccountCD join.
   --Worked with Shane to discover the CMS Tree had been modified.
   --Modified the code so that reads it reads the CMS tree correctly - working.
   --7/14/2014 1:29 time to run - 79024 rows - DEV
   --7/14/2014 0:58 time to run - 57472 rows - PROD1
   --7/15/2014 - Query was returning NodeName of 'Campaigns' only
   --	Found the issue in view View_HFit_HACampaign_Joined. Documented the change in the view.
   --7/16/2014 - Full Select: Using a DocumentModifiedWhen filter 00:17:28 - Record Cnt: 793,520
   --8/7/2014 - Executed in DEV with GUID changes and returned 1.13M Rows in 23:14.
   --8/8/2014 - Executed in DEV with GUID changes, new views, and returned 1.13M Rows in 20:16.
   --8/8/2014 - Generated corrected view in DEV
   --8/12/2014 - John C. explained that Account Code and Site Guid are not needed, NULLED
   --				them out. With them in the QRY, returned 43104 rows, with them nulled
   --				out, returned 43104 rows. Using a DISTINCT, 28736 rows returned and execution
   --				time doubled approximately.
   --				Has to add a DISTINCT to all the queries - .
   --				Original Query 0:25 @ 43104
   --				Original Query 0:46 @ 28736 (distinct)
   --				Filter added - VHFHAQ.DocumentCulture 0:22 @ 14368
   --				Filter added - and VHFHARCJ.DocumentCulture = 'en-us'	 0:06 @ 3568
   --				Filter added - and VHFHARAJ.DocumentCulture = 'en-us'	 0:03 @ 1784
   --8/12/2014 - Applied the language filters with John C. and performance improved, as expected,
   --				such that when running the view in QA: 
   --8/12/2014 - select * from [view_EDW_HealthAssesmentDeffinition] where DocumentModifiedWhen between '2000-11-14' and 
   --				'2014-11-15' now runs exceptionally fast
   --08/12/2014 - ProdStaging 00:21:52 @ 2442
   --08/12/2014 - ProdStaging 00:21:09 @ 13272 (UNION ALL   --UNION)
   --08/12/2014 - ProdStaging 00:21:37 @ 13272 (UNION ONLY)
   --08/12/2014 - ProdStaging 00:06:26 @ 1582 (UNION ONLY & Select Filters Added for Culture)
   --08/12/2014 - ProdStaging 00:10:07 @ 6636 (UNION ALL   --UNION) and all selected
   --08/12/2014 - ProdStaging added PI PI_View_CMS_Tree_Joined_Regular_DocumentCulture: 00:2:34 @ 6636 
   --08/12/2014 - DEV 00:00:58 @ 3792
   --09.11.2014 - (wdm) added the needed date fields to help EDW in determining the last mod date of a row.
   --10.01.2014 - Dale and Mark reworked this view to use NodeGUIDS and eliminated the CMS_TREE View from participating as 
   --				well as Site and Account data
   --11.25.2014 - (wdm) added multi-select column capability. The values can be 0,1, NULL
   --12.29.2014 - (wdm) Added HTML stripping to two columns #47619, the others mentioned already had stripping applied
   --12.31.2014 - (wdm) Started the review to apply CR-47517: Eliminate Matrix Questions with NULL Answer GUID's
   --01.07.2014 - (wdm) 47619 The Health Assessment Definition interface view contains HTML tags - corrected with udf_StripHTML
   --************************************************************************************************************************************************************
          NULL AS SiteGUID --cs.SiteGUID								--WDM 08.12.2014 per John C.
 ,
          NULL AS AccountCD	 --, HFA.AccountCD						--WDM 08.07.2014 per John C.
 ,
          HA.NodeID AS HANodeID										--WDM 08.07.2014
 ,
          HA.NodeName AS HANodeName									--WDM 08.07.2014
          --, HA.DocumentID AS HADocumentID								--WDM 08.07.2014 commented out and left in place for history
 ,
          NULL AS HADocumentID										--WDM 08.07.2014; 09.29.2014: Mark and Dale discussed that NODEGUID should be used such that the multi-language/culture is not a problem.
 ,
          HA.NodeSiteID AS HANodeSiteID								--WDM 08.07.2014
 ,
          HA.DocumentPublishedVersionHistoryID AS HADocPubVerID		--WDM 08.07.2014
 ,
          dbo.udf_StripHTML ( VHFHAMJ.Title) AS ModTitle              --WDM 47619
 ,
          dbo.udf_StripHTML ( LEFT ( VHFHAMJ.IntroText , 4000)) AS IntroText              --WDM 47619
 ,
          VHFHAMJ.NodeGuid AS ModDocGuid	--, VHFHAMJ.DocumentID AS ModDocID	--WDM 08.07.2014	M&D 10.01.2014
 ,
          VHFHAMJ.Weight AS ModWeight
 ,VHFHAMJ.IsEnabled AS ModIsEnabled
 ,VHFHAMJ.CodeName AS ModCodeName
 ,VHFHAMJ.DocumentPublishedVersionHistoryID AS ModDocPubVerID
 ,dbo.udf_StripHTML ( VHFHARCJ.Title) AS RCTitle              --WDM 47619
 ,
          VHFHARCJ.Weight AS RCWeight
 ,VHFHARCJ.NodeGuid AS RCDocumentGUID	--, VHFHARCJ.DocumentID AS RCDocumentID	--WDM 08.07.2014	M&D 10.01.2014
 ,
          VHFHARCJ.IsEnabled AS RCIsEnabled
 ,VHFHARCJ.CodeName AS RCCodeName
 ,VHFHARCJ.DocumentPublishedVersionHistoryID AS RCDocPubVerID
 ,dbo.udf_StripHTML ( VHFHARAJ.Title) AS RATytle              --WDM 47619
 ,
          VHFHARAJ.Weight AS RAWeight
 ,VHFHARAJ.NodeGuid AS RADocumentGuid	--, VHFHARAJ.DocumentID AS RADocumentID	--WDM 08.07.2014	M&D 10.01.2014
 ,
          VHFHARAJ.IsEnabled AS RAIsEnabled
 ,VHFHARAJ.CodeName AS RACodeName
 ,VHFHARAJ.ScoringStrategyID AS RAScoringStrategyID
 ,VHFHARAJ.DocumentPublishedVersionHistoryID AS RADocPubVerID
 ,VHFHAQ.QuestionType
 ,dbo.udf_StripHTML ( LEFT ( VHFHAQ.Title , 4000)) AS QuesTitle              --WDM 47619
 ,
          VHFHAQ.Weight AS QuesWeight
 ,VHFHAQ.IsRequired AS QuesIsRequired

          --, VHFHAQ.DocumentGuid AS QuesDocumentGuid	--, VHFHAQ.DocumentID AS QuesDocumentID	--WDM 08.07.2014	M&D 10.01.2014
 ,
          VHFHAQ.NodeGuid AS QuesDocumentGuid	--, VHFHAQ.DocumentID AS QuesDocumentID	--WDM 08.07.2014

 ,VHFHAQ.IsEnabled AS QuesIsEnabled
 ,LEFT ( VHFHAQ.IsVisible , 4000) AS QuesIsVisible
 ,VHFHAQ.IsStaging AS QuesIsSTaging
 ,VHFHAQ.CodeName AS QuestionCodeName
 ,VHFHAQ.DocumentPublishedVersionHistoryID AS QuesDocPubVerID
 ,VHFHAA.Value AS AnsValue
 ,VHFHAA.Points AS AnsPoints
 ,VHFHAA.NodeGuid AS AnsDocumentGuid		--ref: #47517
 ,
          VHFHAA.IsEnabled AS AnsIsEnabled
 ,VHFHAA.CodeName AS AnsCodeName
 ,VHFHAA.UOM AS AnsUOM
 ,VHFHAA.DocumentPublishedVersionHistoryID AS AnsDocPUbVerID
 ,CASE
      WHEN CAST ( HA.DocumentCreatedWhen AS DATE) = CAST ( HA.DocumentModifiedWhen AS DATE) 
          THEN 'I'
      ELSE 'U'
  END AS ChangeType
 ,CAST ( HA.DocumentCreatedWhen AS DATETIME) AS DocumentCreatedWhen
 ,CAST ( HA.DocumentModifiedWhen AS DATETIME) AS DocumentModifiedWhen
 ,HA.NodeGuid AS CmsTreeNodeGuid	--WDM 08.07.2014 ADDED TO the returned Columns
 ,
          HA.NodeGUID AS HANodeGUID
          --, NULL as SiteLastModified
 ,
          NULL AS SiteLastModified
          --, NULL as Account_ItemModifiedWhen
 ,
          NULL AS Account_ItemModifiedWhen
          --, c.DocumentModifiedWhen as Campaign_DocumentModifiedWhen
 ,
          NULL AS Campaign_DocumentModifiedWhen
 ,CAST ( HA.DocumentModifiedWhen AS DATETIME) AS Assessment_DocumentModifiedWhen
 ,CAST ( VHFHAMJ.DocumentModifiedWhen AS DATETIME) AS Module_DocumentModifiedWhen
 ,CAST ( VHFHARCJ.DocumentModifiedWhen AS DATETIME) AS RiskCategory_DocumentModifiedWhen
 ,CAST ( VHFHARAJ.DocumentModifiedWhen AS DATETIME) AS RiskArea_DocumentModifiedWhen
 ,CAST ( VHFHAQ.DocumentModifiedWhen AS DATETIME) AS Question_DocumentModifiedWhen
 ,CAST ( VHFHAA.DocumentModifiedWhen AS DATETIME) AS Answer_DocumentModifiedWhen
 ,HAMCQ.AllowMultiSelect
 ,'SID01' AS LocID
          FROM
               View_HFit_HealthAssessment_Joined AS HA WITH (NOLOCK) 
                    INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ
                    ON HA.NodeID = VHFHAMJ.NodeParentID
                    INNER JOIN dbo.View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ
                    ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
                    INNER JOIN dbo.View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ
                    ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
                    INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ
                    ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
                    LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA
                    ON VHFHAQ.NodeID = VHFHAA.NodeParentID
                    LEFT OUTER JOIN View_HFit_HealthAssesmentMultipleChoiceQuestion_Joined AS HAMCQ
                    ON
                       VHFHAQ.Nodeguid = HAMCQ.Nodeguid AND
                       HAMCQ.DocumentCulture = 'en-US'
          WHERE
          VHFHAQ.DocumentCulture = 'en-us'	--WDM 08.12.2014	
          AND
          (
            VHFHAA.DocumentCulture = 'en-us' OR
            VHFHAA.DocumentCulture IS NULL)	--WDM 08.12.2014		
          AND
          VHFHARCJ.DocumentCulture = 'en-us'	--WDM 08.12.2014		
          AND
          VHFHARAJ.DocumentCulture = 'en-us'	--WDM 08.12.2014		
          AND
          VHFHAMJ.DocumentCulture = 'en-us'	--WDM 08.12.2014	
          AND
          HA.DocumentCulture = 'en-us'		--WDM 08.12.2014	
          AND
          VHFHAA.NodeGuid IS NOT NULL		--ref: #47517

   UNION ALL   --UNION
   --WDM Retrieve Matrix Level 1 Question Group
   SELECT DISTINCT
          NULL AS SiteGUID --cs.SiteGUID		--WDM 08.12.2014
        ,
          NULL AS AccountCD	 --, HFA.AccountCD												--WDM 08.07.2014
        ,
          HA.NodeID		--WDM 08.07.2014
        ,
          HA.NodeName		--WDM 08.07.2014
        ,
          NULL AS HADocumentID		--WDM 08.07.2014
        ,
          HA.NodeSiteID		--WDM 08.07.2014
          --,VCTJ.NodeAliasPath
        ,
          HA.DocumentPublishedVersionHistoryID		--WDM 08.07.2014
        ,
          dbo.udf_StripHTML ( VHFHAMJ.Title)              --WDM 47619
        ,
          dbo.udf_StripHTML ( LEFT ( LEFT ( VHFHAMJ.IntroText , 4000) , 4000)) AS IntroText              --WDM 47619
        ,
          VHFHAMJ.NodeGuid
        ,VHFHAMJ.Weight
        ,VHFHAMJ.IsEnabled
        ,VHFHAMJ.CodeName
          --,VHFHAMJ.NodeAliasPath
        ,
          VHFHAMJ.DocumentPublishedVersionHistoryID
        ,dbo.udf_StripHTML ( VHFHARCJ.Title)              --WDM 47619
        ,
          VHFHARCJ.Weight
        ,VHFHARCJ.NodeGuid
        ,VHFHARCJ.IsEnabled
        ,VHFHARCJ.CodeName
          --,VHFHARCJ.NodeAliasPath
        ,
          VHFHARCJ.DocumentPublishedVersionHistoryID
        ,dbo.udf_StripHTML ( VHFHARAJ.Title)              --WDM 47619
        ,
          VHFHARAJ.Weight
        ,VHFHARAJ.NodeGuid
        ,VHFHARAJ.IsEnabled
        ,VHFHARAJ.CodeName
          --,VHFHARAJ.NodeAliasPath
        ,
          VHFHARAJ.ScoringStrategyID
        ,VHFHARAJ.DocumentPublishedVersionHistoryID
        ,VHFHAQ2.QuestionType
        ,dbo.udf_StripHTML ( LEFT ( VHFHAQ2.Title , 4000)) AS QuesTitle              --WDM 47619
        ,
          VHFHAQ2.Weight
        ,VHFHAQ2.IsRequired
        ,VHFHAQ2.NodeGuid
        ,VHFHAQ2.IsEnabled
        ,LEFT ( VHFHAQ2.IsVisible , 4000) 
        ,VHFHAQ2.IsStaging
        ,VHFHAQ2.CodeName AS QuestionCodeName
          --,VHFHAQ2.NodeAliasPath
        ,
          VHFHAQ2.DocumentPublishedVersionHistoryID
        ,VHFHAA2.Value
        ,VHFHAA2.Points
        ,VHFHAA2.NodeGuid		--ref: #47517
        ,
          VHFHAA2.IsEnabled
        ,VHFHAA2.CodeName
        ,VHFHAA2.UOM
          --,VHFHAA2.NodeAliasPath
        ,
          VHFHAA2.DocumentPublishedVersionHistoryID
        ,CASE
             WHEN CAST ( HA.DocumentCreatedWhen AS DATE) = CAST ( HA.DocumentModifiedWhen AS DATE) 
                 THEN 'I'
             ELSE 'U'
         END AS ChangeType
        ,CAST ( HA.DocumentCreatedWhen AS DATETIME) AS DocumentCreatedWhen
        ,CAST ( HA.DocumentModifiedWhen AS DATETIME) AS DocumentModifiedWhen
        ,HA.NodeGuid AS CmsTreeNodeGuid	--WDM 08.07.2014
        ,
          HA.NodeGUID AS HANodeGUID
        ,NULL AS SiteLastModified
        ,NULL AS Account_ItemModifiedWhen
          --, c.DocumentModifiedWhen as Campaign_DocumentModifiedWhen
        ,
          NULL AS Campaign_DocumentModifiedWhen
        ,CAST ( HA.DocumentModifiedWhen AS DATETIME) AS Assessment_DocumentModifiedWhen
        ,CAST ( VHFHAMJ.DocumentModifiedWhen AS DATETIME) AS Module_DocumentModifiedWhen
        ,CAST ( VHFHARCJ.DocumentModifiedWhen AS DATETIME) AS RiskCategory_DocumentModifiedWhen
        ,CAST ( VHFHARAJ.DocumentModifiedWhen AS DATETIME) AS RiskArea_DocumentModifiedWhen
        ,CAST ( VHFHAQ.DocumentModifiedWhen AS DATETIME) AS Question_DocumentModifiedWhen
        ,CAST ( VHFHAA.DocumentModifiedWhen AS DATETIME) AS Answer_DocumentModifiedWhen
        ,HAMCQ.AllowMultiSelect
        ,'SID02' AS LocID
          FROM
               --dbo.View_CMS_Tree_Joined AS VCTJ
               --INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
               --INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID

               --Campaign links Client which links to Assessment
               --INNER JOIN dbo.View_HFit_HACampaign_Joined as c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID	--Note: 

               View_HFit_HealthAssessment_Joined AS HA WITH (NOLOCK) 
                    INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ
                    ON HA.NodeID = VHFHAMJ.NodeParentID
                    INNER JOIN dbo.View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ
                    ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
                    INNER JOIN dbo.View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ
                    ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
                    INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ
                    ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
                    LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA
                    ON VHFHAQ.NodeID = VHFHAA.NodeParentID --matrix level 1 questiongroup
                    INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ2
                    ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
                    INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA2
                    ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID
                    LEFT OUTER JOIN View_HFit_HealthAssesmentMultipleChoiceQuestion_Joined AS HAMCQ
                    ON
                       VHFHAQ.Nodeguid = HAMCQ.Nodeguid AND
                       HAMCQ.DocumentCulture = 'en-US'
          WHERE
          VHFHAQ.DocumentCulture = 'en-us' AND
          (
            VHFHAA.DocumentCulture = 'en-us' OR
            VHFHAA.DocumentCulture IS NULL)	--WDM 08.12.2014		
          AND
          VHFHARCJ.DocumentCulture = 'en-us' AND
          VHFHARAJ.DocumentCulture = 'en-us' AND
          VHFHAMJ.DocumentCulture = 'en-us'	--WDM 08.12.2014	
          AND
          HA.DocumentCulture = 'en-us'	--WDM 08.12.2014		
          AND
          VHFHAA2.NodeGuid IS NOT NULL		--ref: #47517

   UNION ALL   --UNION
   --WDM Retrieve Branching Level 1 Question and Matrix Level 1 Question Group
   SELECT DISTINCT
          NULL AS SiteGUID --cs.SiteGUID		--WDM 08.12.2014
        ,
          NULL AS AccountCD	 --, HFA.AccountCD												--WDM 08.07.2014
        ,
          HA.NodeID		--WDM 08.07.2014
        ,
          HA.NodeName		--WDM 08.07.2014
        ,
          NULL AS HADocumentID		--WDM 08.07.2014
        ,
          HA.NodeSiteID		--WDM 08.07.2014
          --,VCTJ.NodeAliasPath
        ,
          HA.DocumentPublishedVersionHistoryID		--WDM 08.07.2014
        ,
          dbo.udf_StripHTML ( VHFHAMJ.Title) 
        ,dbo.udf_StripHTML ( LEFT ( VHFHAMJ.IntroText , 4000)) AS IntroText
        ,VHFHAMJ.NodeGuid
        ,VHFHAMJ.Weight
        ,VHFHAMJ.IsEnabled
        ,VHFHAMJ.CodeName
          --,VHFHAMJ.NodeAliasPath
        ,
          VHFHAMJ.DocumentPublishedVersionHistoryID
        ,dbo.udf_StripHTML ( VHFHARCJ.Title) 
        ,VHFHARCJ.Weight
        ,VHFHARCJ.NodeGuid
        ,VHFHARCJ.IsEnabled
        ,VHFHARCJ.CodeName
          --,VHFHARCJ.NodeAliasPath
        ,
          VHFHARCJ.DocumentPublishedVersionHistoryID
        ,dbo.udf_StripHTML ( VHFHARAJ.Title) 
        ,VHFHARAJ.Weight
        ,VHFHARAJ.NodeGuid
        ,VHFHARAJ.IsEnabled
        ,VHFHARAJ.CodeName
          --,VHFHARAJ.NodeAliasPath
        ,
          VHFHARAJ.ScoringStrategyID
        ,VHFHARAJ.DocumentPublishedVersionHistoryID
        ,VHFHAQ3.QuestionType
        ,dbo.udf_StripHTML ( LEFT ( VHFHAQ3.Title , 4000)) AS QuesTitle
        ,VHFHAQ3.Weight
        ,VHFHAQ3.IsRequired
        ,VHFHAQ3.NodeGuid
        ,VHFHAQ3.IsEnabled
        ,LEFT ( VHFHAQ3.IsVisible , 4000) 
        ,VHFHAQ3.IsStaging
        ,VHFHAQ3.CodeName AS QuestionCodeName
          --,VHFHAQ3.NodeAliasPath
        ,
          VHFHAQ3.DocumentPublishedVersionHistoryID
        ,VHFHAA3.Value
        ,VHFHAA3.Points
        ,VHFHAA3.NodeGuid		--ref: #47517
        ,
          VHFHAA3.IsEnabled
        ,VHFHAA3.CodeName
        ,VHFHAA3.UOM
          --,VHFHAA3.NodeAliasPath
        ,
          VHFHAA3.DocumentPublishedVersionHistoryID
        ,CASE
             WHEN CAST ( HA.DocumentCreatedWhen AS DATE) = CAST ( HA.DocumentModifiedWhen AS DATE) 
                 THEN 'I'
             ELSE 'U'
         END AS ChangeType
        ,CAST ( HA.DocumentCreatedWhen AS DATETIME) AS DocumentCreatedWhen
        ,CAST ( HA.DocumentModifiedWhen AS DATETIME) AS DocumentModifiedWhen
        ,HA.NodeGuid AS CmsTreeNodeGuid	--WDM 08.07.2014
        ,
          HA.NodeGUID AS HANodeGUID
        ,NULL AS SiteLastModified
        ,NULL AS Account_ItemModifiedWhen
          --, c.DocumentModifiedWhen as Campaign_DocumentModifiedWhen
        ,
          NULL AS Campaign_DocumentModifiedWhen
        ,CAST ( HA.DocumentModifiedWhen AS DATETIME) AS Assessment_DocumentModifiedWhen
        ,CAST ( VHFHAMJ.DocumentModifiedWhen AS DATETIME) AS Module_DocumentModifiedWhen
        ,CAST ( VHFHARCJ.DocumentModifiedWhen AS DATETIME) AS RiskCategory_DocumentModifiedWhen
        ,CAST ( VHFHARAJ.DocumentModifiedWhen AS DATETIME) AS RiskArea_DocumentModifiedWhen
        ,CAST ( VHFHAQ.DocumentModifiedWhen AS DATETIME) AS Question_DocumentModifiedWhen
        ,CAST ( VHFHAA.DocumentModifiedWhen AS DATETIME) AS Answer_DocumentModifiedWhen
        ,HAMCQ.AllowMultiSelect
        ,'SID03' AS LocID
          FROM
               --dbo.View_CMS_Tree_Joined AS VCTJ
               --INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
               --INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID

               --Campaign links Client which links to Assessment
               --INNER JOIN dbo.View_HFit_HACampaign_Joined as c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID	--Note: 

               View_HFit_HealthAssessment_Joined AS HA WITH (NOLOCK) 
                    INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ
                    ON HA.NodeID = VHFHAMJ.NodeParentID
                    INNER JOIN dbo.View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ
                    ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
                    INNER JOIN dbo.View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ
                    ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
                    INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ
                    ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
                    LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA
                    ON VHFHAQ.NodeID = VHFHAA.NodeParentID --matrix level 1 questiongroup
               --INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
               --INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID

               --Branching Level 1 Question 
                    INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ3
                    ON VHFHAA.NodeID = VHFHAQ3.NodeParentID
                    LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA3
                    ON VHFHAQ3.NodeID = VHFHAA3.NodeParentID
                    LEFT OUTER JOIN View_HFit_HealthAssesmentMultipleChoiceQuestion_Joined AS HAMCQ
                    ON
                       VHFHAQ.Nodeguid = HAMCQ.Nodeguid AND
                       HAMCQ.DocumentCulture = 'en-US'
          WHERE
          VHFHAQ.DocumentCulture = 'en-us' AND
          (
            VHFHAA.DocumentCulture = 'en-us' OR
            VHFHAA.DocumentCulture IS NULL)	--WDM 08.12.2014		
          AND
          VHFHARCJ.DocumentCulture = 'en-us' AND
          VHFHARAJ.DocumentCulture = 'en-us' AND
          VHFHAMJ.DocumentCulture = 'en-us'	--WDM 08.12.2014	
          AND
          HA.DocumentCulture = 'en-us'	--WDM 08.12.2014		
          AND
          VHFHAA3.NodeGuid IS NOT NULL		--ref: #47517

   UNION ALL   --UNION
   --WDM Retrieve Branching Level 1 Question and Matrix Level 2 Question Group
   SELECT DISTINCT
          NULL AS SiteGUID --cs.SiteGUID		--WDM 08.12.2014
        ,
          NULL AS AccountCD	 --, HFA.AccountCD												--WDM 08.07.2014
        ,
          HA.NodeID		--WDM 08.07.2014
        ,
          HA.NodeName		--WDM 08.07.2014
        ,
          NULL AS HADocumentID		--WDM 08.07.2014
        ,
          HA.NodeSiteID		--WDM 08.07.2014
          --,VCTJ.NodeAliasPath
        ,
          HA.DocumentPublishedVersionHistoryID		--WDM 08.07.2014
        ,
          dbo.udf_StripHTML ( VHFHAMJ.Title) 
        ,dbo.udf_StripHTML ( LEFT ( VHFHAMJ.IntroText , 4000)) AS IntroText
        ,VHFHAMJ.NodeGuid
        ,VHFHAMJ.Weight
        ,VHFHAMJ.IsEnabled
        ,VHFHAMJ.CodeName
          --,VHFHAMJ.NodeAliasPath
        ,
          VHFHAMJ.DocumentPublishedVersionHistoryID
        ,dbo.udf_StripHTML ( VHFHARCJ.Title) 
        ,VHFHARCJ.Weight
        ,VHFHARCJ.NodeGuid
        ,VHFHARCJ.IsEnabled
        ,VHFHARCJ.CodeName
          --,VHFHARCJ.NodeAliasPath
        ,
          VHFHARCJ.DocumentPublishedVersionHistoryID
        ,dbo.udf_StripHTML ( VHFHARAJ.Title) 
        ,VHFHARAJ.Weight
        ,VHFHARAJ.NodeGuid
        ,VHFHARAJ.IsEnabled
        ,VHFHARAJ.CodeName
          --,VHFHARAJ.NodeAliasPath
        ,
          VHFHARAJ.ScoringStrategyID
        ,VHFHARAJ.DocumentPublishedVersionHistoryID
        ,VHFHAQ7.QuestionType
        ,dbo.udf_StripHTML ( LEFT ( VHFHAQ7.Title , 4000)) AS QuesTitle
        ,VHFHAQ7.Weight
        ,VHFHAQ7.IsRequired
        ,VHFHAQ7.NodeGuid
        ,VHFHAQ7.IsEnabled
        ,LEFT ( VHFHAQ7.IsVisible , 4000) 
        ,VHFHAQ7.IsStaging
        ,VHFHAQ7.CodeName AS QuestionCodeName
          --,VHFHAQ7.NodeAliasPath
        ,
          VHFHAQ7.DocumentPublishedVersionHistoryID
        ,VHFHAA7.Value
        ,VHFHAA7.Points
        ,VHFHAA7.NodeGuid		--ref: #47517
        ,
          VHFHAA7.IsEnabled
        ,VHFHAA7.CodeName
        ,VHFHAA7.UOM
          --,VHFHAA7.NodeAliasPath
        ,
          VHFHAA7.DocumentPublishedVersionHistoryID
        ,CASE
             WHEN CAST ( HA.DocumentCreatedWhen AS DATE) = CAST ( HA.DocumentModifiedWhen AS DATE) 
                 THEN 'I'
             ELSE 'U'
         END AS ChangeType
        ,CAST ( HA.DocumentCreatedWhen AS DATETIME) AS DocumentCreatedWhen
        ,CAST ( HA.DocumentModifiedWhen AS DATETIME) AS DocumentModifiedWhen
        ,HA.NodeGuid AS CmsTreeNodeGuid	--WDM 08.07.2014
        ,
          HA.NodeGUID AS HANodeGUID
        ,NULL AS SiteLastModified
        ,NULL AS Account_ItemModifiedWhen
          --, c.DocumentModifiedWhen as Campaign_DocumentModifiedWhen
        ,
          NULL AS Campaign_DocumentModifiedWhen
        ,CAST ( HA.DocumentModifiedWhen AS DATETIME) AS Assessment_DocumentModifiedWhen
        ,CAST ( VHFHAMJ.DocumentModifiedWhen AS DATETIME) AS Module_DocumentModifiedWhen
        ,CAST ( VHFHARCJ.DocumentModifiedWhen AS DATETIME) AS RiskCategory_DocumentModifiedWhen
        ,CAST ( VHFHARAJ.DocumentModifiedWhen AS DATETIME) AS RiskArea_DocumentModifiedWhen
        ,CAST ( VHFHAQ.DocumentModifiedWhen AS DATETIME) AS Question_DocumentModifiedWhen
        ,CAST ( VHFHAA.DocumentModifiedWhen AS DATETIME) AS Answer_DocumentModifiedWhen
        ,HAMCQ.AllowMultiSelect
        ,'SID04' AS LocID
          FROM
               --dbo.View_CMS_Tree_Joined AS VCTJ
               --INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
               --INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID

               --Campaign links Client which links to Assessment
               --INNER JOIN dbo.View_HFit_HACampaign_Joined as c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID	--Note: 

               View_HFit_HealthAssessment_Joined AS HA WITH (NOLOCK) 
                    INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ
                    ON HA.NodeID = VHFHAMJ.NodeParentID
                    INNER JOIN dbo.View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ
                    ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
                    INNER JOIN dbo.View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ
                    ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
                    INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ
                    ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
                    LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA
                    ON VHFHAQ.NodeID = VHFHAA.NodeParentID --matrix level 1 questiongroup
               --INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
               --INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID

               --Branching Level 1 Question 
                    INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ3
                    ON VHFHAA.NodeID = VHFHAQ3.NodeParentID --LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA3 ON VHFHAQ3.NodeID = VHFHAA3.NodeParentID

               --Matrix Level 2 Question Group
                    INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ7
                    ON VHFHAQ3.NodeID = VHFHAQ7.NodeParentID
                    INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA7
                    ON VHFHAQ7.NodeID = VHFHAA7.NodeParentID
                    LEFT OUTER JOIN View_HFit_HealthAssesmentMultipleChoiceQuestion_Joined AS HAMCQ
                    ON
                       VHFHAQ.Nodeguid = HAMCQ.Nodeguid AND
                       HAMCQ.DocumentCulture = 'en-US'
          WHERE
          VHFHAQ.DocumentCulture = 'en-us' AND
          (
            VHFHAA.DocumentCulture = 'en-us' OR
            VHFHAA.DocumentCulture IS NULL)	--WDM 08.12.2014		
          AND
          VHFHARCJ.DocumentCulture = 'en-us' AND
          VHFHARAJ.DocumentCulture = 'en-us' AND
          VHFHAMJ.DocumentCulture = 'en-us'	--WDM 08.12.2014	
          AND
          HA.DocumentCulture = 'en-us'	--WDM 08.12.2014		
          AND
          VHFHAA7.NodeGuid IS NOT NULL		--ref: #47517

   UNION ALL   --UNION
   --****************************************************
   --WDM 6/25/2014 Retrieve the Branching level 1 Question Group
   --THE PROBLEM LIES HERE in this part of query : 1:40 minute
   -- Added two perf indexes to the first query: 25 Sec
   --****************************************************
   SELECT DISTINCT
          NULL AS SiteGUID --cs.SiteGUID		--WDM 08.12.2014
        ,
          NULL AS AccountCD	 --, HFA.AccountCD												--WDM 08.07.2014
        ,
          HA.NodeID		--WDM 08.07.2014
        ,
          HA.NodeName		--WDM 08.07.2014
        ,
          NULL AS HADocumentID		--WDM 08.07.2014
        ,
          HA.NodeSiteID		--WDM 08.07.2014
          --,VCTJ.NodeAliasPath
        ,
          HA.DocumentPublishedVersionHistoryID		--WDM 08.07.2014
        ,
          dbo.udf_StripHTML ( VHFHAMJ.Title) 
        ,dbo.udf_StripHTML ( LEFT ( VHFHAMJ.IntroText , 4000)) AS IntroText
        ,VHFHAMJ.NodeGuid
        ,VHFHAMJ.Weight
        ,VHFHAMJ.IsEnabled
        ,VHFHAMJ.CodeName
          --,VHFHAMJ.NodeAliasPath
        ,
          VHFHAMJ.DocumentPublishedVersionHistoryID
        ,dbo.udf_StripHTML ( VHFHARCJ.Title) 
        ,VHFHARCJ.Weight
        ,VHFHARCJ.NodeGuid
        ,VHFHARCJ.IsEnabled
        ,VHFHARCJ.CodeName
          --,VHFHARCJ.NodeAliasPath
        ,
          VHFHARCJ.DocumentPublishedVersionHistoryID
        ,dbo.udf_StripHTML ( VHFHARAJ.Title) 
        ,VHFHARAJ.Weight
        ,VHFHARAJ.NodeGuid
        ,VHFHARAJ.IsEnabled
        ,VHFHARAJ.CodeName
          --,VHFHARAJ.NodeAliasPath
        ,
          VHFHARAJ.ScoringStrategyID
        ,VHFHARAJ.DocumentPublishedVersionHistoryID
        ,VHFHAQ8.QuestionType
        ,dbo.udf_StripHTML ( LEFT ( VHFHAQ8.Title , 4000)) AS QuesTitle
        ,VHFHAQ8.Weight
        ,VHFHAQ8.IsRequired
        ,VHFHAQ8.NodeGuid
        ,VHFHAQ8.IsEnabled
        ,LEFT ( VHFHAQ8.IsVisible , 4000) 
        ,VHFHAQ8.IsStaging
        ,VHFHAQ8.CodeName AS QuestionCodeName
          --,VHFHAQ8.NodeAliasPath
        ,
          VHFHAQ8.DocumentPublishedVersionHistoryID
        ,VHFHAA8.Value
        ,VHFHAA8.Points
        ,VHFHAA8.NodeGuid		--ref: #47517
        ,
          VHFHAA8.IsEnabled
        ,VHFHAA8.CodeName
        ,VHFHAA8.UOM
          --,VHFHAA8.NodeAliasPath
        ,
          VHFHAA8.DocumentPublishedVersionHistoryID
        ,CASE
             WHEN CAST ( HA.DocumentCreatedWhen AS DATE) = CAST ( HA.DocumentModifiedWhen AS DATE) 
                 THEN 'I'
             ELSE 'U'
         END AS ChangeType
        ,CAST ( HA.DocumentCreatedWhen AS DATETIME) AS DocumentCreatedWhen
        ,CAST ( HA.DocumentModifiedWhen AS DATETIME) AS DocumentModifiedWhen
        ,HA.NodeGuid AS CmsTreeNodeGuid	--WDM 08.07.2014
        ,
          HA.NodeGUID AS HANodeGUID
        ,NULL AS SiteLastModified
        ,NULL AS Account_ItemModifiedWhen
          --, c.DocumentModifiedWhen as Campaign_DocumentModifiedWhen
        ,
          NULL AS Campaign_DocumentModifiedWhen
        ,CAST ( HA.DocumentModifiedWhen AS DATETIME) AS Assessment_DocumentModifiedWhen
        ,CAST ( VHFHAMJ.DocumentModifiedWhen AS DATETIME) AS Module_DocumentModifiedWhen
        ,CAST ( VHFHARCJ.DocumentModifiedWhen AS DATETIME) AS RiskCategory_DocumentModifiedWhen
        ,CAST ( VHFHARAJ.DocumentModifiedWhen AS DATETIME) AS RiskArea_DocumentModifiedWhen
        ,CAST ( VHFHAQ.DocumentModifiedWhen AS DATETIME) AS Question_DocumentModifiedWhen
        ,CAST ( VHFHAA.DocumentModifiedWhen AS DATETIME) AS Answer_DocumentModifiedWhen
        ,HAMCQ.AllowMultiSelect
        ,'SID05' AS LocID
          FROM
               --dbo.View_CMS_Tree_Joined AS VCTJ
               --INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
               --INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID

               --Campaign links Client which links to Assessment
               --INNER JOIN dbo.View_HFit_HACampaign_Joined as c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID	--Note: 

               View_HFit_HealthAssessment_Joined AS HA WITH (NOLOCK) 
                    INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ
                    ON HA.NodeID = VHFHAMJ.NodeParentID
                    INNER JOIN dbo.View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ
                    ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
                    INNER JOIN dbo.View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ
                    ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
                    INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ
                    ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
                    LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA
                    ON VHFHAQ.NodeID = VHFHAA.NodeParentID --matrix level 1 questiongroup
               --INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
               --INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID

               --Branching Level 1 Question 
                    INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ3
                    ON VHFHAA.NodeID = VHFHAQ3.NodeParentID --LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA3 ON VHFHAQ3.NodeID = VHFHAA3.NodeParentID

               --Matrix Level 2 Question Group
                    INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ7
                    ON VHFHAQ3.NodeID = VHFHAQ7.NodeParentID
                    INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA7
                    ON VHFHAQ7.NodeID = VHFHAA7.NodeParentID --Matrix branching level 1 question group
                    INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ8
                    ON VHFHAA7.NodeID = VHFHAQ8.NodeParentID
                    INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA8
                    ON VHFHAQ8.NodeID = VHFHAA8.NodeParentID
                    LEFT OUTER JOIN View_HFit_HealthAssesmentMultipleChoiceQuestion_Joined AS HAMCQ
                    ON
                       VHFHAQ.Nodeguid = HAMCQ.Nodeguid AND
                       HAMCQ.DocumentCulture = 'en-US'
          WHERE
          VHFHAQ.DocumentCulture = 'en-us' AND
          (
            VHFHAA.DocumentCulture = 'en-us' OR
            VHFHAA.DocumentCulture IS NULL)	--WDM 08.12.2014		
          AND
          VHFHARCJ.DocumentCulture = 'en-us' AND
          VHFHARAJ.DocumentCulture = 'en-us' AND
          VHFHAMJ.DocumentCulture = 'en-us'	--WDM 08.12.2014	
          AND
          HA.DocumentCulture = 'en-us'	--WDM 08.12.2014		
          AND
          VHFHAA8.NodeGuid IS NOT NULL		--ref: #47517

   UNION ALL   --UNION
   --****************************************************
   --WDM 6/25/2014 Retrieve the Branching level 2 Question Group
   --THE PROBLEM LIES HERE in this part of query : 1:48  minutes
   --With the new indexes: 29 Secs
   --****************************************************
   SELECT DISTINCT
          NULL AS SiteGUID --cs.SiteGUID		--WDM 08.12.2014
        ,
          NULL AS AccountCD	 --, HFA.AccountCD												--WDM 08.07.2014
        ,
          HA.NodeID		--WDM 08.07.2014
        ,
          HA.NodeName		--WDM 08.07.2014
        ,
          NULL AS HADocumentID		--WDM 08.07.2014
        ,
          HA.NodeSiteID		--WDM 08.07.2014
          --,VCTJ.NodeAliasPath
        ,
          HA.DocumentPublishedVersionHistoryID		--WDM 08.07.2014
        ,
          dbo.udf_StripHTML ( VHFHAMJ.Title) 
        ,dbo.udf_StripHTML ( LEFT ( VHFHAMJ.IntroText , 4000)) AS IntroText
        ,VHFHAMJ.NodeGuid
        ,VHFHAMJ.Weight
        ,VHFHAMJ.IsEnabled
        ,VHFHAMJ.CodeName
          --,VHFHAMJ.NodeAliasPath
        ,
          VHFHAMJ.DocumentPublishedVersionHistoryID
        ,dbo.udf_StripHTML ( VHFHARCJ.Title) 
        ,VHFHARCJ.Weight
        ,VHFHARCJ.NodeGuid
        ,VHFHARCJ.IsEnabled
        ,VHFHARCJ.CodeName
          --,VHFHARCJ.NodeAliasPath
        ,
          VHFHARCJ.DocumentPublishedVersionHistoryID
        ,dbo.udf_StripHTML ( VHFHARAJ.Title) 
        ,VHFHARAJ.Weight
        ,VHFHARAJ.NodeGuid
        ,VHFHARAJ.IsEnabled
        ,VHFHARAJ.CodeName
          --,VHFHARAJ.NodeAliasPath
        ,
          VHFHARAJ.ScoringStrategyID
        ,VHFHARAJ.DocumentPublishedVersionHistoryID
        ,VHFHAQ4.QuestionType
        ,dbo.udf_StripHTML ( LEFT ( VHFHAQ4.Title , 4000)) AS QuesTitle
        ,VHFHAQ4.Weight
        ,VHFHAQ4.IsRequired
        ,VHFHAQ4.NodeGuid
        ,VHFHAQ4.IsEnabled
        ,LEFT ( VHFHAQ4.IsVisible , 4000) 
        ,VHFHAQ4.IsStaging
        ,VHFHAQ4.CodeName AS QuestionCodeName
          --,VHFHAQ4.NodeAliasPath
        ,
          VHFHAQ4.DocumentPublishedVersionHistoryID
        ,VHFHAA4.Value
        ,VHFHAA4.Points
        ,VHFHAA4.NodeGuid		--ref: #47517
        ,
          VHFHAA4.IsEnabled
        ,VHFHAA4.CodeName
        ,VHFHAA4.UOM
          --,VHFHAA4.NodeAliasPath
        ,
          VHFHAA4.DocumentPublishedVersionHistoryID
        ,CASE
             WHEN CAST ( HA.DocumentCreatedWhen AS DATE) = CAST ( HA.DocumentModifiedWhen AS DATE) 
                 THEN 'I'
             ELSE 'U'
         END AS ChangeType
        ,CAST ( HA.DocumentCreatedWhen AS DATETIME) AS DocumentCreatedWhen
        ,CAST ( HA.DocumentModifiedWhen AS DATETIME) AS DocumentModifiedWhen
        ,HA.NodeGuid AS CmsTreeNodeGuid	--WDM 08.07.2014
        ,
          HA.NodeGUID AS HANodeGUID
        ,NULL AS SiteLastModified
        ,NULL AS Account_ItemModifiedWhen
          --, c.DocumentModifiedWhen as Campaign_DocumentModifiedWhen
        ,
          NULL AS Campaign_DocumentModifiedWhen
        ,CAST ( HA.DocumentModifiedWhen AS DATETIME) AS Assessment_DocumentModifiedWhen
        ,CAST ( VHFHAMJ.DocumentModifiedWhen AS DATETIME) AS Module_DocumentModifiedWhen
        ,CAST ( VHFHARCJ.DocumentModifiedWhen AS DATETIME) AS RiskCategory_DocumentModifiedWhen
        ,CAST ( VHFHARAJ.DocumentModifiedWhen AS DATETIME) AS RiskArea_DocumentModifiedWhen
        ,CAST ( VHFHAQ.DocumentModifiedWhen AS DATETIME) AS Question_DocumentModifiedWhen
        ,CAST ( VHFHAA.DocumentModifiedWhen AS DATETIME) AS Answer_DocumentModifiedWhen
        ,HAMCQ.AllowMultiSelect
        ,'SID06' AS LocID
          FROM
               --dbo.View_CMS_Tree_Joined AS VCTJ
               --INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
               --INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID

               --Campaign links Client which links to Assessment
               --INNER JOIN dbo.View_HFit_HACampaign_Joined as c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID	--Note: 

               View_HFit_HealthAssessment_Joined AS HA WITH (NOLOCK) 
                    INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ
                    ON HA.NodeID = VHFHAMJ.NodeParentID
                    INNER JOIN dbo.View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ
                    ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
                    INNER JOIN dbo.View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ
                    ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
                    INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ
                    ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
                    LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA
                    ON VHFHAQ.NodeID = VHFHAA.NodeParentID --matrix level 1 questiongroup
               --INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
               --INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID

               --Branching Level 1 Question 
                    INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ3
                    ON VHFHAA.NodeID = VHFHAQ3.NodeParentID
                    LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA3
                    ON VHFHAQ3.NodeID = VHFHAA3.NodeParentID --Matrix Level 2 Question Group
               --INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ7 ON VHFHAQ3.NodeID = VHFHAQ7.NodeParentID
               --INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA7 ON VHFHAQ7.NodeID = VHFHAA7.NodeParentID

               --Matrix branching level 1 question group
               --INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ8 ON VHFHAA7.NodeID = VHFHAQ8.NodeParentID
               --INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA8 ON VHFHAQ8.NodeID = VHFHAA8.NodeParentID

               --Branching level 2 Question Group
                    INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ4
                    ON VHFHAA3.NodeID = VHFHAQ4.NodeParentID
                    INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA4
                    ON VHFHAQ4.NodeID = VHFHAA4.NodeParentID
                    LEFT OUTER JOIN View_HFit_HealthAssesmentMultipleChoiceQuestion_Joined AS HAMCQ
                    ON
                       VHFHAQ.Nodeguid = HAMCQ.Nodeguid AND
                       HAMCQ.DocumentCulture = 'en-US'
          WHERE
          VHFHAQ.DocumentCulture = 'en-us' AND
          (
            VHFHAA.DocumentCulture = 'en-us' OR
            VHFHAA.DocumentCulture IS NULL)	--WDM 08.12.2014		
          AND
          VHFHARCJ.DocumentCulture = 'en-us' AND
          VHFHARAJ.DocumentCulture = 'en-us' AND
          VHFHAMJ.DocumentCulture = 'en-us'	--WDM 08.12.2014	
          AND
          HA.DocumentCulture = 'en-us'	--WDM 08.12.2014		
          AND
          VHFHAA4.NodeGuid IS NOT NULL		--ref: #47517

   UNION ALL   --UNION
   --WDM 6/25/2014 Retrieve the Branching level 3 Question Group
   SELECT DISTINCT
          NULL AS SiteGUID --cs.SiteGUID		--WDM 08.12.2014
        ,
          NULL AS AccountCD	 --, HFA.AccountCD												--WDM 08.07.2014
        ,
          HA.NodeID		--WDM 08.07.2014
        ,
          HA.NodeName		--WDM 08.07.2014
        ,
          NULL AS HADocumentID		--WDM 08.07.2014
        ,
          HA.NodeSiteID		--WDM 08.07.2014
          --,VCTJ.NodeAliasPath
        ,
          HA.DocumentPublishedVersionHistoryID		--WDM 08.07.2014
        ,
          dbo.udf_StripHTML ( VHFHAMJ.Title) 
        ,dbo.udf_StripHTML ( LEFT ( VHFHAMJ.IntroText , 4000)) AS IntroText
        ,VHFHAMJ.NodeGuid
        ,VHFHAMJ.Weight
        ,VHFHAMJ.IsEnabled
        ,VHFHAMJ.CodeName
          --,VHFHAMJ.NodeAliasPath
        ,
          VHFHAMJ.DocumentPublishedVersionHistoryID
        ,dbo.udf_StripHTML ( VHFHARCJ.Title) 
        ,VHFHARCJ.Weight
        ,VHFHARCJ.NodeGuid
        ,VHFHARCJ.IsEnabled
        ,VHFHARCJ.CodeName
          --,VHFHARCJ.NodeAliasPath
        ,
          VHFHARCJ.DocumentPublishedVersionHistoryID
        ,dbo.udf_StripHTML ( VHFHARAJ.Title) 
        ,VHFHARAJ.Weight
        ,VHFHARAJ.NodeGuid
        ,VHFHARAJ.IsEnabled
        ,VHFHARAJ.CodeName
          --,VHFHARAJ.NodeAliasPath
        ,
          VHFHARAJ.ScoringStrategyID
        ,VHFHARAJ.DocumentPublishedVersionHistoryID
        ,VHFHAQ5.QuestionType
        ,dbo.udf_StripHTML ( LEFT ( VHFHAQ5.Title , 4000)) AS QuesTitle
        ,VHFHAQ5.Weight
        ,VHFHAQ5.IsRequired
        ,VHFHAQ5.NodeGuid
        ,VHFHAQ5.IsEnabled
        ,LEFT ( VHFHAQ5.IsVisible , 4000) 
        ,VHFHAQ5.IsStaging
        ,VHFHAQ5.CodeName AS QuestionCodeName
          --,VHFHAQ5.NodeAliasPath
        ,
          VHFHAQ5.DocumentPublishedVersionHistoryID
        ,VHFHAA5.Value
        ,VHFHAA5.Points
        ,VHFHAA5.NodeGuid		--ref: #47517
        ,
          VHFHAA5.IsEnabled
        ,VHFHAA5.CodeName
        ,VHFHAA5.UOM
          --,VHFHAA5.NodeAliasPath
        ,
          VHFHAA5.DocumentPublishedVersionHistoryID
        ,CASE
             WHEN CAST ( HA.DocumentCreatedWhen AS DATE) = CAST ( HA.DocumentModifiedWhen AS DATE) 
                 THEN 'I'
             ELSE 'U'
         END AS ChangeType
        ,CAST ( HA.DocumentCreatedWhen AS DATETIME) AS DocumentCreatedWhen
        ,CAST ( HA.DocumentModifiedWhen AS DATETIME) AS DocumentModifiedWhen
        ,HA.NodeGuid AS CmsTreeNodeGuid	--WDM 08.07.2014
        ,
          HA.NodeGUID AS HANodeGUID
        ,NULL AS SiteLastModified
        ,NULL AS Account_ItemModifiedWhen
          --, c.DocumentModifiedWhen as Campaign_DocumentModifiedWhen
        ,
          NULL AS Campaign_DocumentModifiedWhen
        ,CAST ( HA.DocumentModifiedWhen AS DATETIME) AS Assessment_DocumentModifiedWhen
        ,CAST ( VHFHAMJ.DocumentModifiedWhen AS DATETIME) AS Module_DocumentModifiedWhen
        ,CAST ( VHFHARCJ.DocumentModifiedWhen AS DATETIME) AS RiskCategory_DocumentModifiedWhen
        ,CAST ( VHFHARAJ.DocumentModifiedWhen AS DATETIME) AS RiskArea_DocumentModifiedWhen
        ,CAST ( VHFHAQ.DocumentModifiedWhen AS DATETIME) AS Question_DocumentModifiedWhen
        ,CAST ( VHFHAA.DocumentModifiedWhen AS DATETIME) AS Answer_DocumentModifiedWhen
        ,HAMCQ.AllowMultiSelect
        ,'SID07' AS LocID
          FROM
               --dbo.View_CMS_Tree_Joined AS VCTJ
               --INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
               --INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID

               --Campaign links Client which links to Assessment
               --INNER JOIN dbo.View_HFit_HACampaign_Joined as c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID	--Note: 

               View_HFit_HealthAssessment_Joined AS HA WITH (NOLOCK) 
                    INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ
                    ON HA.NodeID = VHFHAMJ.NodeParentID
                    INNER JOIN dbo.View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ
                    ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
                    INNER JOIN dbo.View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ
                    ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
                    INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ
                    ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
                    LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA
                    ON VHFHAQ.NodeID = VHFHAA.NodeParentID --matrix level 1 questiongroup
               --INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
               --INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID

               --Branching Level 1 Question 
                    INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ3
                    ON VHFHAA.NodeID = VHFHAQ3.NodeParentID
                    LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA3
                    ON VHFHAQ3.NodeID = VHFHAA3.NodeParentID --Matrix Level 2 Question Group
               --INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ7 ON VHFHAQ3.NodeID = VHFHAQ7.NodeParentID
               --INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA7 ON VHFHAQ7.NodeID = VHFHAA7.NodeParentID

               --Matrix branching level 1 question group
               --INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ8 ON VHFHAA7.NodeID = VHFHAQ8.NodeParentID
               --INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA8 ON VHFHAQ8.NodeID = VHFHAA8.NodeParentID

               --Branching level 2 Question Group
                    INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ4
                    ON VHFHAA3.NodeID = VHFHAQ4.NodeParentID
                    INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA4
                    ON VHFHAQ4.NodeID = VHFHAA4.NodeParentID --Branching level 3 Question Group
                    INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ5
                    ON VHFHAA4.NodeID = VHFHAQ5.NodeParentID
                    INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA5
                    ON VHFHAQ5.NodeID = VHFHAA5.NodeParentID
                    LEFT OUTER JOIN View_HFit_HealthAssesmentMultipleChoiceQuestion_Joined AS HAMCQ
                    ON
                       VHFHAQ.Nodeguid = HAMCQ.Nodeguid AND
                       HAMCQ.DocumentCulture = 'en-US'
          WHERE
          VHFHAQ.DocumentCulture = 'en-us' AND
          (
            VHFHAA.DocumentCulture = 'en-us' OR
            VHFHAA.DocumentCulture IS NULL)	--WDM 08.12.2014		
          AND
          VHFHARCJ.DocumentCulture = 'en-us' AND
          VHFHARAJ.DocumentCulture = 'en-us' AND
          VHFHAMJ.DocumentCulture = 'en-us'	--WDM 08.12.2014	
          AND
          HA.DocumentCulture = 'en-us'	--WDM 08.12.2014		
          AND
          VHFHAA5.NodeGuid IS NOT NULL		--ref: #47517

   UNION ALL   --UNION
   --WDM 6/25/2014 Retrieve the Branching level 4 Question Group
   SELECT DISTINCT
          NULL AS SiteGUID --cs.SiteGUID		--WDM 08.12.2014
        ,
          NULL AS AccountCD	 --, HFA.AccountCD												--WDM 08.07.2014
        ,
          HA.NodeID		--WDM 08.07.2014
        ,
          HA.NodeName		--WDM 08.07.2014
        ,
          NULL AS HADocumentID		--WDM 08.07.2014
        ,
          HA.NodeSiteID		--WDM 08.07.2014
          --,VCTJ.NodeAliasPath
        ,
          HA.DocumentPublishedVersionHistoryID		--WDM 08.07.2014
        ,
          dbo.udf_StripHTML ( VHFHAMJ.Title) 
        ,dbo.udf_StripHTML ( LEFT ( VHFHAMJ.IntroText , 4000)) AS IntroText
        ,VHFHAMJ.NodeGuid
        ,VHFHAMJ.Weight
        ,VHFHAMJ.IsEnabled
        ,VHFHAMJ.CodeName
          --,VHFHAMJ.NodeAliasPath
        ,
          VHFHAMJ.DocumentPublishedVersionHistoryID
        ,dbo.udf_StripHTML ( VHFHARCJ.Title) 
        ,VHFHARCJ.Weight
        ,VHFHARCJ.NodeGuid
        ,VHFHARCJ.IsEnabled
        ,VHFHARCJ.CodeName
          --,VHFHARCJ.NodeAliasPath
        ,
          VHFHARCJ.DocumentPublishedVersionHistoryID
        ,dbo.udf_StripHTML ( VHFHARAJ.Title) 
        ,VHFHARAJ.Weight
        ,VHFHARAJ.NodeGuid
        ,VHFHARAJ.IsEnabled
        ,VHFHARAJ.CodeName
          --,VHFHARAJ.NodeAliasPath
        ,
          VHFHARAJ.ScoringStrategyID
        ,VHFHARAJ.DocumentPublishedVersionHistoryID
        ,VHFHAQ6.QuestionType
        ,dbo.udf_StripHTML ( LEFT ( VHFHAQ6.Title , 4000)) AS QuesTitle
        ,VHFHAQ6.Weight
        ,VHFHAQ6.IsRequired
        ,VHFHAQ6.NodeGuid
        ,VHFHAQ6.IsEnabled
        ,LEFT ( VHFHAQ6.IsVisible , 4000) 
        ,VHFHAQ6.IsStaging
        ,VHFHAQ6.CodeName AS QuestionCodeName
          --,VHFHAQ6.NodeAliasPath
        ,
          VHFHAQ6.DocumentPublishedVersionHistoryID
        ,VHFHAA6.Value
        ,VHFHAA6.Points
        ,VHFHAA6.NodeGuid		--ref: #47517
        ,
          VHFHAA6.IsEnabled
        ,VHFHAA6.CodeName
        ,VHFHAA6.UOM
          --,VHFHAA6.NodeAliasPath
        ,
          VHFHAA6.DocumentPublishedVersionHistoryID
        ,CASE
             WHEN CAST ( HA.DocumentCreatedWhen AS DATE) = CAST ( HA.DocumentModifiedWhen AS DATE) 
                 THEN 'I'
             ELSE 'U'
         END AS ChangeType
        ,CAST ( HA.DocumentCreatedWhen AS DATETIME) AS DocumentCreatedWhen
        ,CAST ( HA.DocumentModifiedWhen AS DATETIME) AS DocumentModifiedWhen
        ,HA.NodeGuid AS CmsTreeNodeGuid	--WDM 08.07.2014
        ,
          HA.NodeGUID AS HANodeGUID
        ,NULL AS SiteLastModified
        ,NULL AS Account_ItemModifiedWhen
          --, c.DocumentModifiedWhen as Campaign_DocumentModifiedWhen
        ,
          NULL AS Campaign_DocumentModifiedWhen
        ,CAST ( HA.DocumentModifiedWhen AS DATETIME) AS Assessment_DocumentModifiedWhen
        ,CAST ( VHFHAMJ.DocumentModifiedWhen AS DATETIME) AS Module_DocumentModifiedWhen
        ,CAST ( VHFHARCJ.DocumentModifiedWhen AS DATETIME) AS RiskCategory_DocumentModifiedWhen
        ,CAST ( VHFHARAJ.DocumentModifiedWhen AS DATETIME) AS RiskArea_DocumentModifiedWhen
        ,CAST ( VHFHAQ.DocumentModifiedWhen AS DATETIME) AS Question_DocumentModifiedWhen
        ,CAST ( VHFHAA.DocumentModifiedWhen AS DATETIME) AS Answer_DocumentModifiedWhen
        ,HAMCQ.AllowMultiSelect
        ,'SID08' AS LocID
          FROM
               --dbo.View_CMS_Tree_Joined AS VCTJ
               --INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
               --INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID

               --Campaign links Client which links to Assessment
               --INNER JOIN dbo.View_HFit_HACampaign_Joined as c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID	--Note: 

               View_HFit_HealthAssessment_Joined AS HA WITH (NOLOCK) 
                    INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ
                    ON HA.NodeID = VHFHAMJ.NodeParentID
                    INNER JOIN dbo.View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ
                    ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
                    INNER JOIN dbo.View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ
                    ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
                    INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ
                    ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
                    LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA
                    ON VHFHAQ.NodeID = VHFHAA.NodeParentID --matrix level 1 questiongroup
               --INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
               --INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID

               --Branching Level 1 Question 
                    INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ3
                    ON VHFHAA.NodeID = VHFHAQ3.NodeParentID
                    LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA3
                    ON VHFHAQ3.NodeID = VHFHAA3.NodeParentID --Matrix Level 2 Question Group
               --INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ7 ON VHFHAQ3.NodeID = VHFHAQ7.NodeParentID
               --INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA7 ON VHFHAQ7.NodeID = VHFHAA7.NodeParentID

               --Matrix branching level 1 question group
               --INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ8 ON VHFHAA7.NodeID = VHFHAQ8.NodeParentID
               --INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA8 ON VHFHAQ8.NodeID = VHFHAA8.NodeParentID

               --Branching level 2 Question Group
                    INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ4
                    ON VHFHAA3.NodeID = VHFHAQ4.NodeParentID
                    INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA4
                    ON VHFHAQ4.NodeID = VHFHAA4.NodeParentID --Branching level 3 Question Group
               --select count(*) from dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA4
                    INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ5
                    ON VHFHAA4.NodeID = VHFHAQ5.NodeParentID
                    INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA5
                    ON VHFHAQ5.NodeID = VHFHAA5.NodeParentID --Branching level 4 Question Group
                    INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ6
                    ON VHFHAA5.NodeID = VHFHAQ6.NodeParentID
                    INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA6
                    ON VHFHAQ6.NodeID = VHFHAA6.NodeParentID
                    LEFT OUTER JOIN View_HFit_HealthAssesmentMultipleChoiceQuestion_Joined AS HAMCQ
                    ON
                       VHFHAQ.Nodeguid = HAMCQ.Nodeguid AND
                       HAMCQ.DocumentCulture = 'en-US'
          WHERE
          VHFHAQ.DocumentCulture = 'en-us' AND
          (
            VHFHAA.DocumentCulture = 'en-us' OR
            VHFHAA.DocumentCulture IS NULL)	--WDM 08.12.2014		
          AND
          VHFHARCJ.DocumentCulture = 'en-us' AND
          VHFHARAJ.DocumentCulture = 'en-us' AND
          VHFHAMJ.DocumentCulture = 'en-us'	--WDM 08.12.2014	
          AND
          HA.DocumentCulture = 'en-us'	--WDM 08.12.2014		
          AND
          VHFHAA6.NodeGuid IS NOT NULL		--ref: #47517

   UNION ALL   --UNION
   --WDM 6/25/2014 Retrieve the Branching level 5 Question Group
   SELECT DISTINCT
          NULL AS SiteGUID --cs.SiteGUID		--WDM 08.12.2014
        ,
          NULL AS AccountCD	 --, HFA.AccountCD												--WDM 08.07.2014
        ,
          HA.NodeID		--WDM 08.07.2014
        ,
          HA.NodeName		--WDM 08.07.2014
        ,
          NULL AS HADocumentID		--WDM 08.07.2014
        ,
          HA.NodeSiteID		--WDM 08.07.2014
          --,VCTJ.NodeAliasPath
        ,
          HA.DocumentPublishedVersionHistoryID		--WDM 08.07.2014
        ,
          dbo.udf_StripHTML ( VHFHAMJ.Title) 
        ,dbo.udf_StripHTML ( LEFT ( VHFHAMJ.IntroText , 4000)) AS IntroText
        ,VHFHAMJ.NodeGuid
        ,VHFHAMJ.Weight
        ,VHFHAMJ.IsEnabled
        ,VHFHAMJ.CodeName
          --,VHFHAMJ.NodeAliasPath
        ,
          VHFHAMJ.DocumentPublishedVersionHistoryID
        ,dbo.udf_StripHTML ( VHFHARCJ.Title) 
        ,VHFHARCJ.Weight
        ,VHFHARCJ.NodeGuid
        ,VHFHARCJ.IsEnabled
        ,VHFHARCJ.CodeName
          --,VHFHARCJ.NodeAliasPath
        ,
          VHFHARCJ.DocumentPublishedVersionHistoryID
        ,dbo.udf_StripHTML ( VHFHARAJ.Title) 
        ,VHFHARAJ.Weight
        ,VHFHARAJ.NodeGuid
        ,VHFHARAJ.IsEnabled
        ,VHFHARAJ.CodeName
          --,VHFHARAJ.NodeAliasPath
        ,
          VHFHARAJ.ScoringStrategyID
        ,VHFHARAJ.DocumentPublishedVersionHistoryID
        ,VHFHAQ9.QuestionType
        ,dbo.udf_StripHTML ( LEFT ( VHFHAQ9.Title , 4000)) AS QuesTitle
        ,VHFHAQ9.Weight
        ,VHFHAQ9.IsRequired
        ,VHFHAQ9.NodeGuid
        ,VHFHAQ9.IsEnabled
        ,LEFT ( VHFHAQ9.IsVisible , 4000) 
        ,VHFHAQ9.IsStaging
        ,VHFHAQ9.CodeName AS QuestionCodeName
          --,VHFHAQ9.NodeAliasPath
        ,
          VHFHAQ9.DocumentPublishedVersionHistoryID
        ,VHFHAA9.Value
        ,VHFHAA9.Points
        ,VHFHAA9.NodeGuid		--ref: #47517
        ,
          VHFHAA9.IsEnabled
        ,VHFHAA9.CodeName
        ,VHFHAA9.UOM
          --,VHFHAA9.NodeAliasPath
        ,
          VHFHAA9.DocumentPublishedVersionHistoryID
        ,CASE
             WHEN CAST ( HA.DocumentCreatedWhen AS DATE) = CAST ( HA.DocumentModifiedWhen AS DATE) 
                 THEN 'I'
             ELSE 'U'
         END AS ChangeType
        ,CAST ( HA.DocumentCreatedWhen AS DATETIME) AS DocumentCreatedWhen
        ,CAST ( HA.DocumentModifiedWhen AS DATETIME) AS DocumentModifiedWhen
        ,HA.NodeGuid AS CmsTreeNodeGuid	--WDM 08.07.2014
        ,
          HA.NodeGUID AS HANodeGUID
        ,NULL AS SiteLastModified
        ,NULL AS Account_ItemModifiedWhen
          --, c.DocumentModifiedWhen as Campaign_DocumentModifiedWhen
        ,
          NULL AS Campaign_DocumentModifiedWhen
        ,CAST ( HA.DocumentModifiedWhen AS DATETIME) AS Assessment_DocumentModifiedWhen
        ,CAST ( VHFHAMJ.DocumentModifiedWhen AS DATETIME) AS Module_DocumentModifiedWhen
        ,CAST ( VHFHARCJ.DocumentModifiedWhen AS DATETIME) AS RiskCategory_DocumentModifiedWhen
        ,CAST ( VHFHARAJ.DocumentModifiedWhen AS DATETIME) AS RiskArea_DocumentModifiedWhen
        ,CAST ( VHFHAQ.DocumentModifiedWhen AS DATETIME) AS Question_DocumentModifiedWhen
        ,CAST ( VHFHAA.DocumentModifiedWhen AS DATETIME) AS Answer_DocumentModifiedWhen
        ,HAMCQ.AllowMultiSelect
        ,'SID09' AS LocID
          FROM
               --dbo.View_CMS_Tree_Joined AS VCTJ
               --INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
               --INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID

               --Campaign links Client which links to Assessment
               --INNER JOIN dbo.View_HFit_HACampaign_Joined as c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID	--Note: 

               View_HFit_HealthAssessment_Joined AS HA WITH (NOLOCK) 
                    INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ
                    ON HA.NodeID = VHFHAMJ.NodeParentID
                    INNER JOIN dbo.View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ
                    ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
                    INNER JOIN dbo.View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ
                    ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
                    INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ
                    ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
                    LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA
                    ON VHFHAQ.NodeID = VHFHAA.NodeParentID --matrix level 1 questiongroup
               --INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
               --INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID

               --Branching Level 1 Question 
                    INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ3
                    ON VHFHAA.NodeID = VHFHAQ3.NodeParentID
                    LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA3
                    ON VHFHAQ3.NodeID = VHFHAA3.NodeParentID --Matrix Level 2 Question Group
               --INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ7 ON VHFHAQ3.NodeID = VHFHAQ7.NodeParentID
               --INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA7 ON VHFHAQ7.NodeID = VHFHAA7.NodeParentID

               --Matrix branching level 1 question group
               --INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ8 ON VHFHAA7.NodeID = VHFHAQ8.NodeParentID
               --INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA8 ON VHFHAQ8.NodeID = VHFHAA8.NodeParentID

               --Branching level 2 Question Group
                    INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ4
                    ON VHFHAA3.NodeID = VHFHAQ4.NodeParentID
                    INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA4
                    ON VHFHAQ4.NodeID = VHFHAA4.NodeParentID --Branching level 3 Question Group
               --select count(*) from dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA4
                    INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ5
                    ON VHFHAA4.NodeID = VHFHAQ5.NodeParentID
                    INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA5
                    ON VHFHAQ5.NodeID = VHFHAA5.NodeParentID --Branching level 4 Question Group
                    INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ6
                    ON VHFHAA5.NodeID = VHFHAQ6.NodeParentID
                    INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA6
                    ON VHFHAQ6.NodeID = VHFHAA6.NodeParentID --Branching level 5 Question Group
                    INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ9
                    ON VHFHAA6.NodeID = VHFHAQ9.NodeParentID
                    INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA9
                    ON VHFHAQ9.NodeID = VHFHAA9.NodeParentID
                    LEFT OUTER JOIN View_HFit_HealthAssesmentMultipleChoiceQuestion_Joined AS HAMCQ
                    ON
                       VHFHAQ.Nodeguid = HAMCQ.Nodeguid AND
                       HAMCQ.DocumentCulture = 'en-US'
          WHERE
          VHFHAQ.DocumentCulture = 'en-us' AND
          (
            VHFHAA.DocumentCulture = 'en-us' OR
            VHFHAA.DocumentCulture IS NULL)	--WDM 08.12.2014		
          AND
          VHFHARCJ.DocumentCulture = 'en-us' AND
          VHFHARAJ.DocumentCulture = 'en-us' AND
          VHFHAMJ.DocumentCulture = 'en-us'	--WDM 08.12.2014	
          AND
          HA.DocumentCulture = 'en-us'	--WDM 08.12.2014		
          AND
          VHFHAA9.NodeGuid IS NOT NULL;		--ref: #47517

GO

PRINT 'Processed: view_EDW_HealthAssesmentDeffinition ';
GO
--  
--  
GO
PRINT '***** FROM: view_EDW_HealthAssesmentDeffinition.sql';
GO 

--START ENDING THE IVP
GO

DECLARE @DBNAME nvarchar (100) ;
DECLARE @ServerName nvarchar (80) ;
SET @ServerName = (SELECT
                          @@SERVERNAME);
SET @DBNAME = (SELECT
                      DB_NAME () AS [Current Database]);

IF @@TRANCOUNT > 0
    BEGIN
	   print 'OPEN Transaction Committed!!'
        COMMIT TRANSACTION
    END;

PRINT '--';
PRINT '*************************************************************************************************************';
PRINT 'IVP Processing complete - please check for errors: on database ' + @DBNAME + ' : ON SERVER : ' + @ServerName + ' ON ' + CAST (GETDATE () AS nvarchar (50)) ;
PRINT '*************************************************************************************************************';
--  
GO
PRINT '***** FROM: TheEnd.sql';
GO 
