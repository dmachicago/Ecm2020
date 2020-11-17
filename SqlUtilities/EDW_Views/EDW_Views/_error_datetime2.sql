

CREATE TABLE [dbo].[#TempBioData](
	[TrackerNameAggregateTable] [varchar](30) NOT NULL,
	[ItemID] [int] NOT NULL,
	[EventDate] [datetime2](7) NOT NULL,
	[IsProfessionallyCollected] [bit] NOT NULL,
	[TrackerCollectionSourceID] [int] NOT NULL,
	[Notes] [nvarchar](1000) NULL,
	[UserID] [int] NOT NULL,
	[CollectionSourceName_Internal] [int] NULL,
	[CollectionSourceName_External] [int] NULL,
	[EventName] [varchar](7) NOT NULL,
	[UOM] [varchar](2) NOT NULL,
	[KEY1] [varchar](18) NOT NULL,
	[VAL1] [float] NULL,
	[KEY2] [varchar](2) NOT NULL,
	[VAL2] [int] NULL,
	[KEY3] [varchar](2) NOT NULL,
	[VAL3] [int] NULL,
	[KEY4] [varchar](2) NOT NULL,
	[VAL4] [int] NULL,
	[KEY5] [varchar](2) NOT NULL,
	[VAL5] [int] NULL,
	[KEY6] [varchar](2) NOT NULL,
	[VAL6] [int] NULL,
	[KEY7] [varchar](2) NOT NULL,
	[VAL7] [int] NULL,
	[KEY8] [varchar](2) NOT NULL,
	[VAL8] [int] NULL,
	[KEY9] [varchar](2) NOT NULL,
	[VAL9] [int] NULL,
	[KEY10] [varchar](2) NOT NULL,
	[VAL10] [int] NULL,
	[ItemCreatedBy] [int] NULL,
	[ItemCreatedWhen] [datetime2](7) NULL,
	[ItemModifiedBy] [int] NULL,
	[ItemModifiedWhen] [datetime2](7) NULL,
	[IsProcessedForHa] [bit] NOT NULL,
	[TXTKEY1] [varchar](2) NOT NULL,
	[TXTVAL1] [int] NULL,
	[TXTKEY2] [varchar](2) NOT NULL,
	[TXTVAL2] [int] NULL,
	[TXTKEY3] [varchar](2) NOT NULL,
	[TXTVAL3] [int] NULL,
	[ItemOrder] [int] NULL,
	[ItemGuid] [int] NULL,
	[UserGuid] [uniqueidentifier] NOT NULL,
	[MPI] [varchar](50) NOT NULL,
	[ClientCode] [varchar](12) NULL,
	[SiteGUID] [uniqueidentifier] NOT NULL,
	[AccountID] [int] NOT NULL,
	[AccountCD] [nvarchar](8) NULL,
	[IsAvailable] [bit] NULL,
	[IsCustom] [bit] NULL,
	[UniqueName] [nvarchar](50) NULL,
	[ColDesc] [nvarchar](50) NULL,
	[VendorID] [int] NULL,
	[VendorName] [int] NULL
)


--exec sp_help 'HFit_TrackerPreventiveCare'
--insert into [#TempBioData]
SELECT 'HFit_TrackerPreventiveCare' AS TrackerNameAggregateTable ,
			TT.ItemID ,
			convert(datetime, EventDate, 101) AS EventDate,
			TT.IsProfessionallyCollected ,
			TT.TrackerCollectionSourceID ,
			Notes ,
			TT.UserID ,
			NULL AS CollectionSourceName_Internal ,
			NULL AS CollectionSourceName_External ,
			'MISSING' AS EventName ,
			'NA' AS UOM ,
			'PreventiveCare' AS KEY1 ,
			CAST (PreventiveCare AS float) AS VAL1 ,
			'NA' AS KEY2 ,
			NULL AS VAL2 ,
			'NA' AS KEY3 ,
			NULL AS VAL3 ,
			'NA' AS KEY4 ,
			NULL AS VAL4 ,
			'NA' AS KEY5 ,
			NULL AS VAL5 ,
			'NA' AS KEY6 ,
			NULL AS VAL6 ,
			'NA' AS KEY7 ,
			NULL AS VAL7 ,
			'NA' AS KEY8 ,
			NULL AS VAL8 ,
			'NA' AS KEY9 ,
			NULL AS VAL9 ,
			'NA' AS KEY10 ,
			NULL AS VAL10 ,
			TT.ItemCreatedBy ,
			TT.ItemCreatedWhen ,
			TT.ItemModifiedBy ,
			TT.ItemModifiedWhen ,
			IsProcessedForHa ,
			'NA' AS TXTKEY1 ,
			NULL as TXTVAL1 ,
			'NA' AS TXTKEY2 ,
			NULL AS TXTVAL2 ,
			'NA' AS TXTKEY3 ,
			NULL AS TXTVAL3 ,
			NULL AS ItemOrder ,
			NULL AS ItemGuid ,
			C.UserGuid ,
			PP.MPI ,
			PP.ClientCode ,
			S.SiteGUID ,
			ACCT.AccountID ,
			ACCT.AccountCD ,
			T.IsAvailable ,
			T.IsCustom ,
			T.UniqueName ,
			T.UniqueName AS ColDesc ,
			--VENDOR.ItemID AS VendorID ,
			--VENDOR.VendorName,
			NULL AS VendorID,
			NULL AS VendorName
	   FROM dbo.HFit_TrackerPreventiveCare AS TT
				INNER JOIN dbo.CMS_User AS C
					ON C.UserID = TT.UserID
				INNER JOIN dbo.hfit_ppteligibility AS PP
					ON TT.UserID = PP.userID
				INNER JOIN dbo.HFit_Account AS ACCT
					ON PP.ClientCode = ACCT.AccountCD
				INNER JOIN dbo.CMS_Site AS S
					ON ACCT.SiteID = S.SiteID
				INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
					ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
				LEFT OUTER JOIN dbo.HFIT_Tracker AS T
					ON T.AggregateTableName = 'HFit_TrackerTests'
				--LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
				--	ON TT.VendorID = VENDOR.ItemID;
UNION
	--exec sp_help 'HFit_TrackerTobaccoAttestation'
	--insert into [#TempBioData]
 	 SELECT 'HFit_TrackerTobaccoAttestation' AS TrackerNameAggregateTable ,
			TT.ItemID ,
			EventDate ,
			TT.IsProfessionallyCollected ,
			TT.TrackerCollectionSourceID ,
			Notes ,
			TT.UserID ,
			NULL AS CollectionSourceName_Internal ,
			NULL AS CollectionSourceName_External ,
			'MISSING' AS EventName ,
			'NA' AS UOM ,
			'TobaccoAttestation' AS KEY1 ,
			CAST (TobaccoAttestation AS float) AS VAL1 ,
			'NA' AS KEY2 ,
			NULL AS VAL2 ,
			'NA' AS KEY3 ,
			NULL AS VAL3 ,
			'NA' AS KEY4 ,
			NULL AS VAL4 ,
			'NA' AS KEY5 ,
			NULL AS VAL5 ,
			'NA' AS KEY6 ,
			NULL AS VAL6 ,
			'NA' AS KEY7 ,
			NULL AS VAL7 ,
			'NA' AS KEY8 ,
			NULL AS VAL8 ,
			'NA' AS KEY9 ,
			NULL AS VAL9 ,
			'NA' AS KEY10 ,
			NULL AS VAL10 ,
			TT.ItemCreatedBy ,
			TT.ItemCreatedWhen ,
			TT.ItemModifiedBy ,
			TT.ItemModifiedWhen ,
			IsProcessedForHa ,
			'NA' AS TXTKEY1 ,
			NULL as TXTVAL1 ,
			'NA' AS TXTKEY2 ,
			NULL AS TXTVAL2 ,
			'NA' AS TXTKEY3 ,
			NULL AS TXTVAL3 ,
			NULL AS ItemOrder ,
			NULL AS ItemGuid ,
			C.UserGuid ,
			PP.MPI ,
			PP.ClientCode ,
			S.SiteGUID ,
			ACCT.AccountID ,
			ACCT.AccountCD ,
			T.IsAvailable ,
			T.IsCustom ,
			T.UniqueName ,
			T.UniqueName AS ColDesc ,
			--VENDOR.ItemID AS VendorID ,
			--VENDOR.VendorName,
			NULL AS VendorID,
			NULL AS VendorName
	   FROM dbo.HFit_TrackerTobaccoAttestation AS TT
				INNER JOIN dbo.CMS_User AS C
					ON C.UserID = TT.UserID
				INNER JOIN dbo.hfit_ppteligibility AS PP
					ON TT.UserID = PP.userID
				INNER JOIN dbo.HFit_Account AS ACCT
					ON PP.ClientCode = ACCT.AccountCD
				INNER JOIN dbo.CMS_Site AS S
					ON ACCT.SiteID = S.SiteID
				INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
					ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
				LEFT OUTER JOIN dbo.HFIT_Tracker AS T
					ON T.AggregateTableName = 'HFit_TrackerTests'
				--LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
				--	ON TT.VendorID = VENDOR.ItemID;
UNION
--exec sp_help 'HFit_TrackerBodyFat'
--insert into [#TempBioData]
SELECT 'HFit_TrackerBodyFat' AS TrackerNameAggregateTable ,
			TT.ItemID ,
			EventDate ,
			TT.IsProfessionallyCollected ,
			TT.TrackerCollectionSourceID ,
			Notes ,
			TT.UserID ,
			CollectionSourceName_Internal ,
			CollectionSourceName_External ,
			'MISSING' AS EventName ,
			'PCT' AS UOM ,
			'Value' AS KEY1 ,
			CAST ([Value] AS float) AS VAL1 ,
			'NA' AS KEY2 ,
			0 AS VAL2 ,
			'NA' AS KEY3 ,
			NULL AS VAL3 ,
			'NA' AS KEY4 ,
			NULL AS VAL4 ,
			'NA' AS KEY5 ,
			NULL AS VAL5 ,
			'NA' AS KEY6 ,
			NULL AS VAL6 ,
			'NA' AS KEY7 ,
			NULL AS VAL7 ,
			'NA' AS KEY8 ,
			NULL AS VAL8 ,
			'NA' AS KEY9 ,
			NULL AS VAL9 ,
			'NA' AS KEY10 ,
			NULL AS VAL10 ,
			TT.ItemCreatedBy ,
			TT.ItemModifiedBy ,
			TT.ItemCreatedWhen ,
			TT.ItemModifiedWhen ,
			NULL AS IsProcessedForHa ,
			'NA' AS TXTKEY1 ,
			NULL AS TXTVAL1 ,
			'NA' AS TXTKEY2 ,
			NULL AS TXTVAL2 ,
			'NA' AS TXTKEY3 ,
			NULL AS TXTVAL3 ,
			NULL AS ItemOrder ,
			NULL AS ItemGuid ,
			C.UserGuid ,
			PP.MPI ,
			PP.ClientCode ,
			S.SiteGUID ,
			ACCT.AccountID ,
			ACCT.AccountCD ,
			T.IsAvailable ,
			T.IsCustom ,
			ISNULL (T.UniqueName , 'HFit_TrackerBodyFat') AS UniqueName ,
			ISNULL (T.UniqueName , 'HFit_TrackerBodyFat') AS ColDesc ,
			VENDOR.ItemID AS VendorID ,
			VENDOR.VendorName
into temp2
	   FROM dbo.HFit_TrackerBodyFat AS TT
				INNER JOIN dbo.CMS_User AS C
					ON C.UserID = TT.UserID
				INNER JOIN dbo.hfit_ppteligibility AS PP
					ON TT.UserID = PP.userID
				INNER JOIN dbo.HFit_Account AS ACCT
					ON PP.ClientCode = ACCT.AccountCD
				INNER JOIN dbo.CMS_Site AS S
					ON ACCT.SiteID = S.SiteID
				INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
					ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
				LEFT OUTER JOIN dbo.HFIT_Tracker AS T
					ON T.AggregateTableName = 'HFit_TrackerBodyFat'
				LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
					ON TT.VendorID = VENDOR.ItemID

