--W. Dale Miller
--Dec. 11, 2011
--Test and Evaluate Index Performance for HA

GO

if not exists(select name from sys.indexes where name = 'PI_EDW_GroupMemberHistory_RowNbr')
BEGIN
	print ('CREATING Index PI_EDW_GroupMemberHistory_RowNbr') ;
	CREATE NONCLUSTERED INDEX [PI_EDW_GroupMemberHistory_RowNbr] ON [dbo].[EDW_GroupMemberHistory] ([RowNbr]);
END
ELSE 
	print ('Index PI_EDW_GroupMemberHistory_RowNbr FOUND') ;

GO

PRINT ' 1 of 1510 : Analyzing IX_COM_InternalStatus_InternalStatusDisplayName_InternalStatusEnabled';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_COM_InternalStatus_InternalStatusDisplayName_InternalStatusEnabled') 
    --IS NULL
    BEGIN
	   CREATE CLUSTERED INDEX

	   [IX_COM_InternalStatus_InternalStatusDisplayName_InternalStatusEnabled]

	   ON [dbo].[COM_InternalStatus] (  [InternalStatusDisplayName]  ASC , [InternalStatusEnabled]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 2 of 1510 : Created [IX_COM_InternalStatus_InternalStatusDisplayName_InternalStatusEnabled]';
    END;

GO

PRINT ' 3 of 1510 : Analyzing IX_OM_ContactRole_ContactRoleSiteID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_OM_ContactRole_ContactRoleSiteID') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[IX_OM_ContactRole_ContactRoleSiteID]
		ON [dbo].[OM_ContactRole] ( [ContactRoleSiteID]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 4 of 1510 : Created [IX_OM_ContactRole_ContactRoleSiteID]';
    END;

GO

PRINT ' 5 of 1510 : Analyzing IX_CMS_AutomationHistory_HistoryStepID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_AutomationHistory_HistoryStepID') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[IX_CMS_AutomationHistory_HistoryStepID]
		ON [dbo].[CMS_AutomationHistory] (  [HistoryStepID]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 6 of 1510 : Created [IX_CMS_AutomationHistory_HistoryStepID]';
    END;

GO

PRINT ' 7 of 1510 : Analyzing IX_CMS_AutomationHistory_HistoryApprovedByUserID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_AutomationHistory_HistoryApprovedByUserID') --IS NULL
    BEGIN  CREATE NONCLUSTERED INDEX
		 [IX_CMS_AutomationHistory_HistoryApprovedByUserID]
		 ON [dbo].[CMS_AutomationHistory] (  [HistoryApprovedByUserID]  ASC) 
		 WITH
		 (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 8 of 1510 : Created [IX_CMS_AutomationHistory_HistoryApprovedByUserID]';
    END;

GO

PRINT ' 9 of 1510 : Analyzing IX_CMS_AutomationHistory_HistoryApprovedWhen';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_AutomationHistory_HistoryApprovedWhen') --IS NULL
    BEGIN  CREATE NONCLUSTERED INDEX
		 [IX_CMS_AutomationHistory_HistoryApprovedWhen]
		 ON [dbo].[CMS_AutomationHistory] (  [HistoryApprovedWhen]  ASC) 
		 WITH
		 (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 10 of 1510 : Created [IX_CMS_AutomationHistory_HistoryApprovedWhen]';
    END;

GO

PRINT ' 11 of 1510 : Analyzing nonHistStateID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'nonHistStateID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [nonHistStateID]
	   ON [dbo].[CMS_AutomationHistory] (  [HistoryStateID]  ASC) INCLUDE ( [HistoryID] , [HistoryStepID] , [HistoryStepName] , [HistoryStepDisplayName] , [HistoryStepType] , [HistoryTargetStepID] , [HistoryTargetStepName] , [HistoryTargetStepDisplayName] , [HistoryTargetStepType] , [HistoryApprovedByUserID] , [HistoryApprovedWhen] , [HistoryComment] , [HistoryTransitionType] , [HistoryWorkflowID] , [HistoryRejected] , [HistoryWasRejected]) WITH ( PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 12 of 1510 : Created [nonHistStateID]';
    END;

GO

PRINT ' 13 of 1510 : Analyzing IX_CMS_Query_QueryLoadGeneration';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_Query_QueryLoadGeneration') 
    --IS NULL
    BEGIN
	   CREATE CLUSTERED INDEX
	   [IX_CMS_Query_QueryLoadGeneration]
	   ON [dbo].[CMS_Query] (  [QueryLoadGeneration]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 14 of 1510 : Created [IX_CMS_Query_QueryLoadGeneration]';
    END;

GO

PRINT ' 15 of 1510 : Analyzing IX_CMS_Query_QueryClassID_QueryName';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_Query_QueryClassID_QueryName') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[IX_CMS_Query_QueryClassID_QueryName]
		ON [dbo].[CMS_Query] (  [ClassID]  ASC , [QueryName]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 16 of 1510 : Created [IX_CMS_Query_QueryClassID_QueryName]';
    END;

GO

PRINT ' 17 of 1510 : Analyzing HFit_UserTracker_idx_01';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'HFit_UserTracker_idx_01') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [HFit_UserTracker_idx_01]
	   ON [dbo].[HFit_UserTracker] (  [UserID]  ASC) 
	   WITH
	   ( PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 18 of 1510 : Created [HFit_UserTracker_idx_01]';
    END;

GO

PRINT ' 19 of 1510 : Analyzing IX_HAUQGroupResults_ItemID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_HAUQGroupResults_ItemID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_HAUQGroupResults_ItemID]
	   ON [dbo].[HFit_HealthAssesmentUserQuestionGroupResults] (  [HARiskAreaItemID]  ASC) INCLUDE ([PointResults] , [FormulaResult] , [CodeName]) WITH (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 20 of 1510 : Created [IX_HAUQGroupResults_ItemID]';
    END;

GO

PRINT ' 21 of 1510 : Analyzing IX_HFit_HealthAssesmentUserQuestionGroupResult_1';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_HFit_HealthAssesmentUserQuestionGroupResult_1') --IS NULL
    BEGIN  CREATE NONCLUSTERED INDEX
		 [IX_HFit_HealthAssesmentUserQuestionGroupResult_1]
		 ON [dbo].[HFit_HealthAssesmentUserQuestionGroupResults] (  [HARiskAreaItemID]  ASC) INCLUDE ([CodeName]) WITH (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 22 of 1510 : Created [IX_HFit_HealthAssesmentUserQuestionGroupResult_1]';
    END;

GO

PRINT ' 23 of 1510 : Analyzing IX_COM_ExchangeTable_ExchangeTableValidFrom_ExchangeTableValidTo';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_COM_ExchangeTable_ExchangeTableValidFrom_ExchangeTableValidTo') 
    --IS NULL
    BEGIN
	   CREATE CLUSTERED INDEX
	   [IX_COM_ExchangeTable_ExchangeTableValidFrom_ExchangeTableValidTo]
	   ON [dbo].[COM_ExchangeTable] (  [ExchangeTableValidFrom] DESC , [ExchangeTableValidTo] DESC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 24 of 1510 : Created [IX_COM_ExchangeTable_ExchangeTableValidFrom_ExchangeTableValidTo]';
    END;

GO

PRINT ' 25 of 1510 : Analyzing nonMemID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'nonMemID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [nonMemID]
	   ON [dbo].[HFit_ContactGroupMembership] (  [cmsMembershipID]  ASC , [omContactGroupID]  ASC) WITH (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 26 of 1510 : Created [nonMemID]';
    END;

GO

PRINT ' 27 of 1510 : Analyzing IX_COM_DiscountCoupon_DiscoutCouponDisplayName';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_COM_DiscountCoupon_DiscoutCouponDisplayName') --IS NULL
    BEGIN  CREATE CLUSTERED INDEX
		 [IX_COM_DiscountCoupon_DiscoutCouponDisplayName]
		 ON [dbo].[COM_DiscountCoupon] (  [DiscountCouponDisplayName]  ASC) 
		 WITH
		 (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 28 of 1510 : Created [IX_COM_DiscountCoupon_DiscoutCouponDisplayName]';
    END;

GO

PRINT ' 29 of 1510 : Analyzing IX_COM_DiscountCoupon_DiscountCouponCode';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_COM_DiscountCoupon_DiscountCouponCode') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[IX_COM_DiscountCoupon_DiscountCouponCode]
		ON [dbo].[COM_DiscountCoupon] ( [DiscountCouponCode]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 30 of 1510 : Created [IX_COM_DiscountCoupon_DiscountCouponCode]';
    END;

GO

PRINT ' 31 of 1510 : Analyzing IX_CMS_Class_ClassID_ClassName_ClassDisplayName';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_Class_ClassID_ClassName_ClassDisplayName') --IS NULL
    BEGIN  CREATE CLUSTERED INDEX
		 [IX_CMS_Class_ClassID_ClassName_ClassDisplayName]
		 ON [dbo].[CMS_Class] (  [ClassID]  ASC , [ClassName]  ASC , [ClassDisplayName]  ASC) 
		 WITH
		 (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 32 of 1510 : Created [IX_CMS_Class_ClassID_ClassName_ClassDisplayName]';
    END;

GO

PRINT ' 33 of 1510 : Analyzing IX_CMS_Class_ClassName_ClassDisplayName_ClassID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_Class_ClassName_ClassDisplayName_ClassID') --IS NULL
    BEGIN  CREATE NONCLUSTERED INDEX
		 [IX_CMS_Class_ClassName_ClassDisplayName_ClassID]
		 ON [dbo].[CMS_Class] (  [ClassName]  ASC , [ClassDisplayName]  ASC , [ClassID]  ASC) 
		 WITH
		 (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 34 of 1510 : Created [IX_CMS_Class_ClassName_ClassDisplayName_ClassID]';
    END;

GO

PRINT ' 35 of 1510 : Analyzing IX_CMS_Class_ClassName_ClassGUID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_Class_ClassName_ClassGUID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_CMS_Class_ClassName_ClassGUID]
	   ON [dbo].[CMS_Class] (  [ClassName]  ASC , [ClassGUID]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 36 of 1510 : Created [IX_CMS_Class_ClassName_ClassGUID]';
    END;

GO

PRINT ' 37 of 1510 : Analyzing tType';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_Class_ClassShowAsSystemTable_ClassIsCustomTable_ClassIsCoupledClass_ClassIsDocumentType') --IS NULL
    BEGIN  CREATE NONCLUSTERED INDEX
		 [IX_CMS_Class_ClassShowAsSystemTable_ClassIsCustomTable_ClassIsCoupledClass_ClassIsDocumentTyp	e]
		 ON [dbo].[CMS_Class] (  [ClassShowAsSystemTable]  ASC , [ClassIsCustomTable]  ASC , [ClassIsCoupledClass] ASC , [ClassIsDocumentType]  ASC) 
		 WITH
		 (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 38 of 1510 : Created e]';
    END;

GO

PRINT ' 39 of 1510 : Analyzing IX_CMS_Class_ClassDefaultPageTemplateID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_Class_ClassDefaultPageTemplateID') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[IX_CMS_Class_ClassDefaultPageTemplateID]
		ON [dbo].[CMS_Class] ( [ClassDefaultPageTemplateID]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 40 of 1510 : Created [IX_CMS_Class_ClassDefaultPageTemplateID]';
    END;

GO

PRINT ' 41 of 1510 : Analyzing IX_CMS_Class_ClassLoadGeneration';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_Class_ClassLoadGeneration') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_CMS_Class_ClassLoadGeneration]
	   ON [dbo].[CMS_Class] (  [ClassLoadGeneration] ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 42 of 1510 : Created [IX_CMS_Class_ClassLoadGeneration]';
    END;

GO

PRINT ' 43 of 1510 : Analyzing PI_HFit_RewardsUserActivityDetail_ActivityNodeID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'PI_HFit_RewardsUserActivityDetail_ActivityNodeID') --IS NULL
    BEGIN  CREATE NONCLUSTERED INDEX
		 [PI_HFit_RewardsUserActivityDetail_ActivityNodeID]
		 ON [dbo].[HFit_RewardsUserActivityDetail] (  [ActivityNodeID]  ASC) 
		 WITH
		 (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 44 of 1510 : Created [PI_HFit_RewardsUserActivityDetail_ActivityNodeID]';
    END;

GO

PRINT ' 45 of 1510 : Analyzing HFit_RewardsUserActivityDetail_PiDate';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'HFit_RewardsUserActivityDetail_PiDate') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[HFit_RewardsUserActivityDetail_PiDate]
		ON [dbo].[HFit_RewardsUserActivityDetail] (  [ItemModifiedWhen]  ASC) INCLUDE ( [ItemCreatedWhen]) WITH (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 46 of 1510 : Created [HFit_RewardsUserActivityDetail_PiDate]';
    END;

GO

PRINT ' 47 of 1510 : Analyzing IDX_RewardsUserActivity_UserID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IDX_RewardsUserActivity_UserID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IDX_RewardsUserActivity_UserID]
	   ON [dbo].[HFit_RewardsUserActivityDetail] ( [UserID]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 48 of 1510 : Created [IDX_RewardsUserActivity_UserID]';
    END;

GO

PRINT ' 49 of 1510 : Analyzing PI_HFit_RewardsUserActivityDetail_Date';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'PI_HFit_RewardsUserActivityDetail_Date') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[PI_HFit_RewardsUserActivityDetail_Date]
		ON [dbo].[HFit_RewardsUserActivityDetail] (  [ItemModifiedWhen]  ASC) INCLUDE ( [ItemCreatedWhen]) WITH (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 50 of 1510 : Created [PI_HFit_RewardsUserActivityDetail_Date]';
    END;

GO

--PRINT ' 51 of 1510 : Analyzing cdx_StagingSyncTaskID';
--GO

--IF NOT EXISTS (SELECT [Name]
--			  FROM [sys].[Indexes]
--			  WHERE [Name] = 'cdx_StagingSyncTaskID') 
--    --IS NULL
--    BEGIN
--	   CREATE CLUSTERED INDEX
--	   [cdx_StagingSyncTaskID]
--	   ON [dbo].[Staging_SynchronizationArchive] (  [SynchronizationTaskID]  ASC) 
--	   WITH
--	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
--	   PRINT ' 52 of 1510 : Created [cdx_StagingSyncTaskID]';
--    END;

--GO

PRINT ' 53 of 1510 : Analyzing IX_COM_Supplier_SupplierDisplayName_SupplierEnabled';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_COM_Supplier_SupplierDisplayName_SupplierEnabled') 
    --IS NULL
    BEGIN
	   CREATE CLUSTERED INDEX
	   [IX_COM_Supplier_SupplierDisplayName_SupplierEnabled]
	   ON [dbo].[COM_Supplier] (  [SupplierDisplayName]  ASC , [SupplierEnabled]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 54 of 1510 : Created [IX_COM_Supplier_SupplierDisplayName_SupplierEnabled]';
    END;

GO

PRINT ' 55 of 1510 : Analyzing IX_CMS_Session_SessionLocation';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_Session_SessionLocation') 
    --IS NULL
    BEGIN
	   CREATE CLUSTERED INDEX
	   [IX_CMS_Session_SessionLocation]
	   ON [dbo].[CMS_Session] (  [SessionLocation]  ASC) WITH (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 56 of 1510 : Created [IX_CMS_Session_SessionLocation]';
    END;

GO

PRINT ' 57 of 1510 : Analyzing IX_CMS_Session_SessionUserID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_Session_SessionUserID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_CMS_Session_SessionUserID]
	   ON [dbo].[CMS_Session] (  [SessionUserID]  ASC) WITH (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 58 of 1510 : Created [IX_CMS_Session_SessionUserID]';
    END;

GO

PRINT ' 59 of 1510 : Analyzing IX_CMS_Session_SessionSiteID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_Session_SessionSiteID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_CMS_Session_SessionSiteID]
	   ON [dbo].[CMS_Session] (  [SessionSiteID]  ASC) WITH (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 60 of 1510 : Created [IX_CMS_Session_SessionSiteID]';
    END;

GO

PRINT ' 61 of 1510 : Analyzing IX_CMS_Session_SessionUserIsHidden';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_Session_SessionUserIsHidden') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[IX_CMS_Session_SessionUserIsHidden]
		ON [dbo].[CMS_Session] ( [SessionUserIsHidden]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 62 of 1510 : Created [IX_CMS_Session_SessionUserIsHidden]';
    END;

GO

PRINT ' 63 of 1510 : Analyzing IX_CMS_TagGroup_TagGroupDisplayName';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_TagGroup_TagGroupDisplayName') --IS NULL
    BEGIN CREATE CLUSTERED INDEX
		[IX_CMS_TagGroup_TagGroupDisplayName]
		ON [dbo].[CMS_TagGroup] ( [TagGroupDisplayName]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 64 of 1510 : Created [IX_CMS_TagGroup_TagGroupDisplayName]';
    END;

GO

PRINT ' 65 of 1510 : Analyzing IX_CMS_TagGroup_TagGroupSiteID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_TagGroup_TagGroupSiteID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_CMS_TagGroup_TagGroupSiteID]
	   ON [dbo].[CMS_TagGroup] (  [TagGroupSiteID]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 66 of 1510 : Created [IX_CMS_TagGroup_TagGroupSiteID]';
    END;

GO

PRINT ' 67 of 1510 : Analyzing IX_COM_OrderStatusUser_OrderID_Date';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_COM_OrderStatusUser_OrderID_Date') --IS NULL
    BEGIN CREATE CLUSTERED INDEX
		[IX_COM_OrderStatusUser_OrderID_Date]
		ON [dbo].[COM_OrderStatusUser] ( [OrderID]  ASC , Date DESC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 68 of 1510 : Created [IX_COM_OrderStatusUser_OrderID_Date]';
    END;

GO

PRINT ' 69 of 1510 : Analyzing IX_COM_OrderStatusUser_FromStatusID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_COM_OrderStatusUser_FromStatusID') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[IX_COM_OrderStatusUser_FromStatusID]
		ON [dbo].[COM_OrderStatusUser] ( [FromStatusID]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 70 of 1510 : Created [IX_COM_OrderStatusUser_FromStatusID]';
    END;

GO

PRINT ' 71 of 1510 : Analyzing IX_COM_OrderStatusUser_ToStatusID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_COM_OrderStatusUser_ToStatusID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_COM_OrderStatusUser_ToStatusID]
	   ON [dbo].[COM_OrderStatusUser] (  [ToStatusID] ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 72 of 1510 : Created [IX_COM_OrderStatusUser_ToStatusID]';
    END;

GO

PRINT ' 73 of 1510 : Analyzing IX_COM_OrderStatusUser_ChangedByUserID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_COM_OrderStatusUser_ChangedByUserID') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[IX_COM_OrderStatusUser_ChangedByUserID]
		ON [dbo].[COM_OrderStatusUser] ( [ChangedByUserID]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 74 of 1510 : Created [IX_COM_OrderStatusUser_ChangedByUserID]';
    END;

GO

--PRINT ' 75 of 1510 : Analyzing cdx_StagingSyncLogTaskID';
--GO

--IF NOT EXISTS (SELECT [Name]
--			  FROM [sys].[Indexes]
--			  WHERE [Name] = 'cdx_StagingSyncLogTaskID') 
--    --IS NULL
--    BEGIN
--	   CREATE CLUSTERED INDEX
--	   [cdx_StagingSyncLogTaskID]
--	   ON [dbo].[Staging_SyncLogArchive] (  [SyncLogTaskID]  ASC) 
--	   WITH
--	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
--	   PRINT ' 76 of 1510 : Created [cdx_StagingSyncLogTaskID]';
--    END;

--GO

PRINT ' 77 of 1510 : Analyzing IX_CMS_State_CountryID_StateDisplayName';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_State_CountryID_StateDisplayName') --IS NULL
    BEGIN CREATE CLUSTERED INDEX
		[IX_CMS_State_CountryID_StateDisplayName]
		ON [dbo].[CMS_State] ( [StateDisplayName]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 78 of 1510 : Created [IX_CMS_State_CountryID_StateDisplayName]';
    END;

GO

PRINT ' 79 of 1510 : Analyzing IX_Staging_Task_TaskNodeAliasPath';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Staging_Task_TaskNodeAliasPath') 
    --IS NULL
    BEGIN
	   CREATE CLUSTERED INDEX
	   [IX_Staging_Task_TaskNodeAliasPath]
	   ON [dbo].[Staging_Task] (  [TaskNodeAliasPath]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 80 of 1510 : Created [IX_Staging_Task_TaskNodeAliasPath]';
    END;

GO

PRINT ' 81 of 1510 : Analyzing IX_Staging_Task_TaskSiteID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Staging_Task_TaskSiteID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_Staging_Task_TaskSiteID]
	   ON [dbo].[Staging_Task] (  [TaskSiteID]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 82 of 1510 : Created [IX_Staging_Task_TaskSiteID]';
    END;

GO

PRINT ' 83 of 1510 : Analyzing IX_Staging_Task_TaskDocumentID_TaskNodeID_TaskRunning';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Staging_Task_TaskDocumentID_TaskNodeID_TaskRunning') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_Staging_Task_TaskDocumentID_TaskNodeID_TaskRunning]
	   ON [dbo].[Staging_Task] (  [TaskDocumentID] ASC , [TaskNodeID]  ASC , [TaskRunning]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 84 of 1510 : Created [IX_Staging_Task_TaskDocumentID_TaskNodeID_TaskRunning]';
    END;

GO

PRINT ' 85 of 1510 : Analyzing IX_Staging_Task_TaskType';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Staging_Task_TaskType') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_Staging_Task_TaskType]
	   ON [dbo].[Staging_Task] (  [TaskType]  ASC) 
	   WITH
	   ( PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 86 of 1510 : Created [IX_Staging_Task_TaskType]';
    END;

GO

PRINT ' 87 of 1510 : Analyzing IX_Staging_Task_TaskObjectType_TaskObjectID_TaskRunning';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Staging_Task_TaskObjectType_TaskObjectID_TaskRunning') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_Staging_Task_TaskObjectType_TaskObjectID_TaskRunning]
	   ON [dbo].[Staging_Task] (  [TaskObjectType] ASC , [TaskObjectID]  ASC , [TaskRunning]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 88 of 1510 : Created [IX_Staging_Task_TaskObjectType_TaskObjectID_TaskRunning]';
    END;

GO

PRINT ' 89 of 1510 : Analyzing IX_OM_AccountContact_ContactRoleID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_OM_AccountContact_ContactRoleID') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[IX_OM_AccountContact_ContactRoleID]
		ON [dbo].[OM_AccountContact] ( [ContactRoleID]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 90 of 1510 : Created [IX_OM_AccountContact_ContactRoleID]';
    END;

GO

PRINT ' 91 of 1510 : Analyzing IX_OM_AccountContact_AccountID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_OM_AccountContact_AccountID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_OM_AccountContact_AccountID]
	   ON [dbo].[OM_AccountContact] (  [AccountID]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 92 of 1510 : Created [IX_OM_AccountContact_AccountID]';
    END;

GO

PRINT ' 93 of 1510 : Analyzing IX_OM_AccountContact_ContactID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_OM_AccountContact_ContactID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_OM_AccountContact_ContactID]
	   ON [dbo].[OM_AccountContact] (  [ContactID]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 94 of 1510 : Created [IX_OM_AccountContact_ContactID]';
    END;

GO

PRINT ' 95 of 1510 : Analyzing IX_COM_OptionCategory_CategoryDisplayName_CategoryEnabled';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_COM_OptionCategory_CategoryDisplayName_CategoryEnabled') 
    --IS NULL
    BEGIN
	   CREATE CLUSTERED INDEX
	   [IX_COM_OptionCategory_CategoryDisplayName_CategoryEnabled]
	   ON [dbo].[COM_OptionCategory] ( [CategoryDisplayName]  ASC , [CategoryEnabled]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 96 of 1510 : Created [IX_COM_OptionCategory_CategoryDisplayName_CategoryEnabled]';
    END;

GO

PRINT ' 97 of 1510 : Analyzing IX_CMS_Tag_TagName';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_Tag_TagName') 
    --IS NULL
    BEGIN
	   CREATE CLUSTERED INDEX
	   [IX_CMS_Tag_TagName]
	   ON [dbo].[CMS_Tag] (  [TagName]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 98 of 1510 : Created [IX_CMS_Tag_TagName]';
    END;

GO

PRINT ' 99 of 1510 : Analyzing IX_CMS_Tag_TagGroupID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_Tag_TagGroupID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_CMS_Tag_TagGroupID]
	   ON [dbo].[CMS_Tag] (  [TagGroupID]  ASC) 
	   WITH
	   ( PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 100 of 1510 : Created [IX_CMS_Tag_TagGroupID]';
    END;

GO

PRINT ' 101 of 1510 : Analyzing IX_HFit_HealthAssesmentUserQuestion_1';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_HFit_HealthAssesmentUserQuestion_1') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[IX_HFit_HealthAssesmentUserQuestion_1]
		ON [dbo].[HFit_HealthAssesmentUserQuestion] (  [UserID]  ASC) INCLUDE ( [HAQuestionNodeGUID]) WITH ( PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 102 of 1510 : Created [IX_HFit_HealthAssesmentUserQuestion_1]';
    END;

GO

PRINT ' 103 of 1510 : Analyzing idx_UserQuestionCodeName';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'idx_UserQuestionCodeName') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [idx_UserQuestionCodeName]
	   ON [dbo].[HFit_HealthAssesmentUserQuestion] (  [CodeName] ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 104 of 1510 : Created [idx_UserQuestionCodeName]';
    END;

GO

PRINT ' 105 of 1510 : Analyzing ci_HFit_HealthAssesmentUserQuestion_NodeGUID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'ci_HFit_HealthAssesmentUserQuestion_NodeGUID') --IS NULL
    BEGIN  CREATE NONCLUSTERED INDEX
		 [ci_HFit_HealthAssesmentUserQuestion_NodeGUID]
		 ON [dbo].[HFit_HealthAssesmentUserQuestion] (  [HAQuestionNodeGUID]  ASC) INCLUDE ( [ItemID] , [HAQuestionScore] , [ItemModifiedWhen] , [HARiskAreaItemID] , [CodeName] , [PreWeightedScore] , [IsProfessionallyCollected]) WITH (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 106 of 1510 : Created [ci_HFit_HealthAssesmentUserQuestion_NodeGUID]';
    END;

GO

PRINT ' 107 of 1510 : Analyzing HFit_HealthAssesmentUserQuestion_HARiskAreaItemID_PI';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'HFit_HealthAssesmentUserQuestion_HARiskAreaItemID_PI') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [HFit_HealthAssesmentUserQuestion_HARiskAreaItemID_PI]
	   ON [dbo].[HFit_HealthAssesmentUserQuestion] ( [HARiskAreaItemID]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 108 of 1510 : Created [HFit_HealthAssesmentUserQuestion_HARiskAreaItemID_PI]';
    END;

GO

PRINT ' 109 of 1510 : Analyzing nonItemIDHARiskAreaItemID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'nonItemIDHARiskAreaItemID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [nonItemIDHARiskAreaItemID]
	   ON [dbo].[HFit_HealthAssesmentUserQuestion] (  [ItemID] ASC , [HARiskAreaItemID]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 110 of 1510 : Created [nonItemIDHARiskAreaItemID]';
    END;

GO

PRINT ' 111 of 1510 : Analyzing IX_CMS_ResourceTranslation_TranslationStringID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_ResourceTranslation_TranslationStringID') --IS NULL
    BEGIN  CREATE NONCLUSTERED INDEX
		 [IX_CMS_ResourceTranslation_TranslationStringID]
		 ON [dbo].[CMS_ResourceTranslation] (  [TranslationStringID]  ASC) 
		 WITH
		 (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 112 of 1510 : Created [IX_CMS_ResourceTranslation_TranslationStringID]';
    END;

GO

PRINT ' 113 of 1510 : Analyzing IX_CMS_ResourceTranslation_TranslationUICultureID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_ResourceTranslation_TranslationUICultureID') --IS NULL
    BEGIN  CREATE NONCLUSTERED INDEX
		 [IX_CMS_ResourceTranslation_TranslationUICultureID]
		 ON [dbo].[CMS_ResourceTranslation] (  [TranslationUICultureID]  ASC) 
		 WITH
		 (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 114 of 1510 : Created [IX_CMS_ResourceTranslation_TranslationUICultureID]';
    END;

GO

--PRINT ' 115 of 1510 : Analyzing cdx_StagingTaskTaskID';
--GO

--IF NOT EXISTS (SELECT [Name]
--			  FROM [sys].[Indexes]
--			  WHERE [Name] = 'cdx_StagingTaskTaskID') 
--    --IS NULL
--    BEGIN
--	   CREATE CLUSTERED INDEX
--	   [cdx_StagingTaskTaskID]
--	   ON [dbo].[Staging_TaskArchive] (  [TaskID]  ASC) 
--	   WITH
--	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
--	   PRINT ' 116 of 1510 : Created [cdx_StagingTaskTaskID]';
--    END;

--GO

PRINT ' 117 of 1510 : Analyzing IX_CMS_WebFarmServer_ServerDisplayName';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_WebFarmServer_ServerDisplayName') --IS NULL
    BEGIN CREATE CLUSTERED INDEX
		[IX_CMS_WebFarmServer_ServerDisplayName]
		ON [dbo].[CMS_WebFarmServer] ( [ServerDisplayName]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 118 of 1510 : Created [IX_CMS_WebFarmServer_ServerDisplayName]';
    END;

GO

PRINT ' 119 of 1510 : Analyzing IX_CMS_WebFarmServer_ServerName';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_WebFarmServer_ServerName') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_CMS_WebFarmServer_ServerName]
	   ON [dbo].[CMS_WebFarmServer] (  [ServerName]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 120 of 1510 : Created [IX_CMS_WebFarmServer_ServerName]';
    END;

GO

PRINT ' 121 of 1510 : Analyzing IX_CMS_WebFarmServer_ServerNameServerLastUpdated';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_WebFarmServer_ServerNameServerLastUpdated') --IS NULL
    BEGIN  CREATE NONCLUSTERED INDEX
		 [IX_CMS_WebFarmServer_ServerNameServerLastUpdated]
		 ON [dbo].[CMS_WebFarmServer] (  [ServerName]  ASC , [ServerLastUpdated]  ASC) 
		 WITH
		 (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 122 of 1510 : Created [IX_CMS_WebFarmServer_ServerNameServerLastUpdated]';
    END;

GO

PRINT ' 123 of 1510 : Analyzing IX_CMS_EmailTemplate_EmailTemplateDisplayName';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_EmailTemplate_EmailTemplateDisplayName') --IS NULL
    BEGIN  CREATE CLUSTERED INDEX
		 [IX_CMS_EmailTemplate_EmailTemplateDisplayName]
		 ON [dbo].[CMS_EmailTemplate] (  [EmailTemplateDisplayName]  ASC) 
		 WITH
		 (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 124 of 1510 : Created [IX_CMS_EmailTemplate_EmailTemplateDisplayName]';
    END;

GO

PRINT ' 125 of 1510 : Analyzing IX_CMS_EmailTemplate_EmailTemplateName_EmailTemplateSiteID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_EmailTemplate_EmailTemplateName_EmailTemplateSiteID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_CMS_EmailTemplate_EmailTemplateName_EmailTemplateSiteID]
	   ON [dbo].[CMS_EmailTemplate] ( [EmailTemplateName]  ASC , [EmailTemplateSiteID]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 126 of 1510 : Created [IX_CMS_EmailTemplate_EmailTemplateName_EmailTemplateSiteID]';
    END;

GO

PRINT ' 127 of 1510 : Analyzing IX_CMS_SettingsKey_KeyLoadGeneration_SiteID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_SettingsKey_KeyLoadGeneration_SiteID') --IS NULL
    BEGIN  CREATE CLUSTERED INDEX
		 [IX_CMS_SettingsKey_KeyLoadGeneration_SiteID]
		 ON [dbo].[CMS_SettingsKey] (  [KeyLoadGeneration]  ASC , [SiteID]  ASC) 
		 WITH
		 (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 128 of 1510 : Created [IX_CMS_SettingsKey_KeyLoadGeneration_SiteID]';
    END;

GO

PRINT ' 129 of 1510 : Analyzing IX_CMS_SettingsKey_SiteID_KeyName';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_SettingsKey_SiteID_KeyName') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_CMS_SettingsKey_SiteID_KeyName]
	   ON [dbo].[CMS_SettingsKey] (  [SiteID]  ASC , [KeyName]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 130 of 1510 : Created [IX_CMS_SettingsKey_SiteID_KeyName]';
    END;

GO

PRINT ' 131 of 1510 : Analyzing IX_CMS_SettingsKey_KeyCategoryID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_SettingsKey_KeyCategoryID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_CMS_SettingsKey_KeyCategoryID]
	   ON [dbo].[CMS_SettingsKey] (  [KeyCategoryID] ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 132 of 1510 : Created [IX_CMS_SettingsKey_KeyCategoryID]';
    END;

GO

PRINT ' 133 of 1510 : Analyzing nonKeyName';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'nonKeyName') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [nonKeyName]
	   ON [dbo].[CMS_SettingsKey] (  [KeyName]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 134 of 1510 : Created [nonKeyName]';
    END;

GO

PRINT ' 135 of 1510 : Analyzing nonKeyNameLocSiteID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'nonKeyNameLocSiteID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [nonKeyNameLocSiteID]
	   ON [dbo].[CMS_SettingsKey] (  [KeyName]  ASC , [KeyLoadGeneration]  ASC , [SiteID]  ASC) INCLUDE ( [KeyValue]) WITH (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 136 of 1510 : Created [nonKeyNameLocSiteID]';
    END;

GO

PRINT ' 137 of 1510 : Analyzing IX_CMS_SettingsKey_KeyName';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_SettingsKey_KeyName') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_CMS_SettingsKey_KeyName]
	   ON [dbo].[CMS_SettingsKey] (  [KeyName]  ASC) INCLUDE ( [KeyValue] , [SiteID]) WITH (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 138 of 1510 : Created [IX_CMS_SettingsKey_KeyName]';
    END;

GO

PRINT ' 139 of 1510 : Analyzing IX_OM_MVTVariant_MVTVariantPageTemplateID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_OM_MVTVariant_MVTVariantPageTemplateID') --IS NULL
    BEGIN  CREATE NONCLUSTERED INDEX
		 [IX_OM_MVTVariant_MVTVariantPageTemplateID]
		 ON [dbo].[OM_MVTVariant] (  [MVTVariantPageTemplateID]  ASC) 
		 WITH
		 (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 140 of 1510 : Created [IX_OM_MVTVariant_MVTVariantPageTemplateID]';
    END;

GO

PRINT ' 141 of 1510 : Analyzing IX_Analytics_ConversionCampaign';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Analytics_ConversionCampaign') 
    --IS NULL
    BEGIN
	   CREATE UNIQUE CLUSTERED INDEX
	   [IX_Analytics_ConversionCampaign]
	   ON [dbo].[Analytics_ConversionCampaign] ( [CampaignID]  ASC , [ConversionID]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 142 of 1510 : Created [IX_Analytics_ConversionCampaign]';
    END;

GO

PRINT ' 143 of 1510 : Analyzing IX_HFit_TrackerCardio_UserID_EventDate';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_HFit_TrackerCardio_UserID_EventDate') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[IX_HFit_TrackerCardio_UserID_EventDate]
		ON [dbo].[HFit_TrackerCardio] ( [UserID]  ASC , [EventDate]  ASC) INCLUDE ( [Minutes]) WITH (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 144 of 1510 : Created [IX_HFit_TrackerCardio_UserID_EventDate]';
    END;

GO

PRINT ' 145 of 1510 : Analyzing idx_HFit_TrackerCardio_CreateDate';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'idx_HFit_TrackerCardio_CreateDate') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [idx_HFit_TrackerCardio_CreateDate]
	   ON [dbo].[HFit_TrackerCardio] ( [ItemCreatedWhen]  ASC , [ItemModifiedWhen]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 146 of 1510 : Created [idx_HFit_TrackerCardio_CreateDate]';
    END;

GO

PRINT ' 147 of 1510 : Analyzing IX_Chat_OnlineSupport_SiteID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Chat_OnlineSupport_SiteID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_Chat_OnlineSupport_SiteID]
	   ON [dbo].[Chat_OnlineSupport] ( [ChatOnlineSupportSiteID]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 148 of 1510 : Created [IX_Chat_OnlineSupport_SiteID]';
    END;

GO

PRINT ' 149 of 1510 : Analyzing IX_COM_Manufacturer_ManufacturerDisplayName_ManufacturerEnabled';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_COM_Manufacturer_ManufacturerDisplayName_ManufacturerEnabled') 
    --IS NULL
    BEGIN
	   CREATE CLUSTERED INDEX
	   [IX_COM_Manufacturer_ManufacturerDisplayName_ManufacturerEnabled]
	   ON [dbo].[COM_Manufacturer] (  [ManufacturerDisplayName]  ASC , [ManufacturerEnabled]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 150 of 1510 : Created [IX_COM_Manufacturer_ManufacturerDisplayName_ManufacturerEnabled]';
    END;

GO

PRINT ' 151 of 1510 : Analyzing IX_CMS_WebPart_WebPartLoadGeneration';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_WebPart_WebPartLoadGeneration') --IS NULL
    BEGIN CREATE CLUSTERED INDEX
		[IX_CMS_WebPart_WebPartLoadGeneration]
		ON [dbo].[CMS_WebPart] ( [WebPartLoadGeneration]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 152 of 1510 : Created [IX_CMS_WebPart_WebPartLoadGeneration]';
    END;

GO

PRINT ' 153 of 1510 : Analyzing IX_CMS_WebPart_WebPartName';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_WebPart_WebPartName') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_CMS_WebPart_WebPartName]
	   ON [dbo].[CMS_WebPart] (  [WebPartName]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 154 of 1510 : Created [IX_CMS_WebPart_WebPartName]';
    END;

GO

PRINT ' 155 of 1510 : Analyzing IX_CMS_WebPart_WebPartCategoryID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_WebPart_WebPartCategoryID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_CMS_WebPart_WebPartCategoryID]
	   ON [dbo].[CMS_WebPart] (  [WebPartCategoryID] ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 156 of 1510 : Created [IX_CMS_WebPart_WebPartCategoryID]';
    END;

GO

PRINT ' 157 of 1510 : Analyzing IX_CMS_WebPart_WebPartParentID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_WebPart_WebPartParentID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_CMS_WebPart_WebPartParentID]
	   ON [dbo].[CMS_WebPart] (  [WebPartParentID]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 158 of 1510 : Created [IX_CMS_WebPart_WebPartParentID]';
    END;

GO

PRINT ' 159 of 1510 : Analyzing IX_CMS_WebPart_WebPartLastSelection';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_WebPart_WebPartLastSelection') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[IX_CMS_WebPart_WebPartLastSelection]
		ON [dbo].[CMS_WebPart] ( [WebPartLastSelection]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 160 of 1510 : Created [IX_CMS_WebPart_WebPartLastSelection]';
    END;

GO

PRINT ' 161 of 1510 : Analyzing idx_HFit_TrackerBloodPressure_UserIDEventDate';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'idx_HFit_TrackerBloodPressure_UserIDEventDate') --IS NULL
    BEGIN  CREATE NONCLUSTERED INDEX
		 [idx_HFit_TrackerBloodPressure_UserIDEventDate]
		 ON [dbo].[HFit_TrackerBloodPressure] (  [EventDate]  ASC , [UserID]  ASC) 
		 WITH
		 (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 162 of 1510 : Created [idx_HFit_TrackerBloodPressure_UserIDEventDate]';
    END;

GO

PRINT ' 163 of 1510 : Analyzing IX_Hfit_TrackerBloodPressure_1';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Hfit_TrackerBloodPressure_1') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_Hfit_TrackerBloodPressure_1]
	   ON [dbo].[HFit_TrackerBloodPressure] (  [UserID] ASC , [EventDate]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 164 of 1510 : Created [IX_Hfit_TrackerBloodPressure_1]';
    END;

GO

PRINT ' 165 of 1510 : Analyzing idx_HFit_TrackerBloodPressure_CreateDate';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'idx_HFit_TrackerBloodPressure_CreateDate') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[idx_HFit_TrackerBloodPressure_CreateDate]
		ON [dbo].[HFit_TrackerBloodPressure] (  [ItemCreatedWhen]  ASC , [ItemModifiedWhen]  ASC) 
		WITH
		( PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 166 of 1510 : Created [idx_HFit_TrackerBloodPressure_CreateDate]';
    END;

GO

PRINT ' 167 of 1510 : Analyzing IX_OM_Contact_ContactLastName';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_OM_Contact_ContactLastName') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_OM_Contact_ContactLastName]
	   ON [dbo].[OM_Contact] (  [ContactLastName]  ASC) WITH (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 168 of 1510 : Created [IX_OM_Contact_ContactLastName]';
    END;

GO

PRINT ' 169 of 1510 : Analyzing IX_OM_Contact_ContactStateID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_OM_Contact_ContactStateID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_OM_Contact_ContactStateID]
	   ON [dbo].[OM_Contact] (  [ContactStateID]  ASC) WITH (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 170 of 1510 : Created [IX_OM_Contact_ContactStateID]';
    END;

GO

PRINT ' 171 of 1510 : Analyzing IX_OM_Contact_ContactCountryID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_OM_Contact_ContactCountryID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_OM_Contact_ContactCountryID]
	   ON [dbo].[OM_Contact] (  [ContactCountryID]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 172 of 1510 : Created [IX_OM_Contact_ContactCountryID]';
    END;

GO

PRINT ' 173 of 1510 : Analyzing IX_OM_Contact_ContactStatusID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_OM_Contact_ContactStatusID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_OM_Contact_ContactStatusID]
	   ON [dbo].[OM_Contact] (  [ContactStatusID]  ASC) WITH (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 174 of 1510 : Created [IX_OM_Contact_ContactStatusID]';
    END;

GO

PRINT ' 175 of 1510 : Analyzing IX_OM_Contact_ContactOwnerUserID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_OM_Contact_ContactOwnerUserID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_OM_Contact_ContactOwnerUserID]
	   ON [dbo].[OM_Contact] (  [ContactOwnerUserID] ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 176 of 1510 : Created [IX_OM_Contact_ContactOwnerUserID]';
    END;

GO

PRINT ' 177 of 1510 : Analyzing IX_OM_Contact_ContactMergedWithContactID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_OM_Contact_ContactMergedWithContactID') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[IX_OM_Contact_ContactMergedWithContactID]
		ON [dbo].[OM_Contact] ( [ContactMergedWithContactID]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 178 of 1510 : Created [IX_OM_Contact_ContactMergedWithContactID]';
    END;

GO

PRINT ' 179 of 1510 : Analyzing IX_OM_Contact_ContactMergedWithContactID_ContactSiteID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_OM_Contact_ContactMergedWithContactID_ContactSiteID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_OM_Contact_ContactMergedWithContactID_ContactSiteID]
	   ON [dbo].[OM_Contact] ( [ContactMergedWithContactID]  ASC , [ContactSiteID]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 180 of 1510 : Created [IX_OM_Contact_ContactMergedWithContactID_ContactSiteID]';
    END;

GO

PRINT ' 181 of 1510 : Analyzing IX_OM_Contact_ContactSiteID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_OM_Contact_ContactSiteID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_OM_Contact_ContactSiteID]
	   ON [dbo].[OM_Contact] (  [ContactSiteID]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 182 of 1510 : Created [IX_OM_Contact_ContactSiteID]';
    END;

GO

PRINT ' 183 of 1510 : Analyzing IX_OM_Contact_ContactGlobalContactID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_OM_Contact_ContactGlobalContactID') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[IX_OM_Contact_ContactGlobalContactID]
		ON [dbo].[OM_Contact] ( [ContactGlobalContactID]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 184 of 1510 : Created [IX_OM_Contact_ContactGlobalContactID]';
    END;

GO

PRINT ' 185 of 1510 : Analyzing IX_OM_Contact_SalesForce';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_OM_Contact_SalesForce') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_OM_Contact_SalesForce]
	   ON [dbo].[OM_Contact] (  [ContactSalesForceLeadID]  ASC , [ContactSalesForceLeadReplicationDisabled]  ASC , [ContactSalesForceLeadReplicationSuspensionDateTime]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 186 of 1510 : Created [IX_OM_Contact_SalesForce]';
    END;

GO

PRINT ' 187 of 1510 : Analyzing IX_ContactContactSiteID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_ContactContactSiteID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_ContactContactSiteID]
	   ON [dbo].[OM_Contact] (  [ContactSiteID]  ASC , [ContactGUID]  ASC) INCLUDE ( [ContactID] , [ContactFirstName] , [ContactLastName] , [ContactCountryID] , [ContactEmail] , [ContactStatusID] , [ContactMergedWithContactID] , [ContactCreated] , [ContactGlobalContactID]) WITH (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 188 of 1510 : Created [IX_ContactContactSiteID]';
    END;

GO

PRINT ' 189 of 1510 : Analyzing nonContactID';
GO

--WDM Verify

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'nonContactID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [nonContactID]
	   ON [dbo].[OM_Contact] (  [ContactID]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 190 of 1510 : Created [nonContactID]';
    END;

GO

PRINT ' 191 of 1510 : Analyzing IX_Forums_ForumSubscription_SubscriptionForumID_SubscriptionEmail';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Forums_ForumSubscription_SubscriptionForumID_SubscriptionEmail') 
    --IS NULL
    BEGIN
	   CREATE CLUSTERED INDEX
	   [IX_Forums_ForumSubscription_SubscriptionForumID_SubscriptionEmail]
	   ON [dbo].[Forums_ForumSubscription] (  [SubscriptionEmail]  ASC , [SubscriptionForumID]  ASC) 
	   WITH
	   ( PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 192 of 1510 : Created [IX_Forums_ForumSubscription_SubscriptionForumID_SubscriptionEmail]';
    END;

GO

PRINT ' 193 of 1510 : Analyzing IX_Forums_ForumSubscription_SubscriptionUserID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Forums_ForumSubscription_SubscriptionUserID') --IS NULL
    BEGIN  CREATE NONCLUSTERED INDEX
		 [IX_Forums_ForumSubscription_SubscriptionUserID]
		 ON [dbo].[Forums_ForumSubscription] (  [SubscriptionUserID]  ASC) 
		 WITH
		 (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 194 of 1510 : Created [IX_Forums_ForumSubscription_SubscriptionUserID]';
    END;

GO

PRINT ' 195 of 1510 : Analyzing IX_Forums_ForumSubscription_SubscriptionPostID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Forums_ForumSubscription_SubscriptionPostID') --IS NULL
    BEGIN  CREATE NONCLUSTERED INDEX
		 [IX_Forums_ForumSubscription_SubscriptionPostID]
		 ON [dbo].[Forums_ForumSubscription] (  [SubscriptionPostID]  ASC) 
		 WITH
		 (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 196 of 1510 : Created [IX_Forums_ForumSubscription_SubscriptionPostID]';
    END;

GO

PRINT ' 197 of 1510 : Analyzing IX_CMS_TemplateDeviceLayout_PageTemplateID_ProfileID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_TemplateDeviceLayout_PageTemplateID_ProfileID') 
    --IS NULL
    BEGIN
	   CREATE  UNIQUE NONCLUSTERED INDEX
	   [IX_CMS_TemplateDeviceLayout_PageTemplateID_ProfileID]
	   ON [dbo].[CMS_TemplateDeviceLayout] ( [PageTemplateID]  ASC , [ProfileID]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 198 of 1510 : Created [IX_CMS_TemplateDeviceLayout_PageTemplateID_ProfileID]';
    END;

GO

PRINT ' 199 of 1510 : Analyzing IX_CMS_TemplateDeviceLayout_LayoutID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_TemplateDeviceLayout_LayoutID') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[IX_CMS_TemplateDeviceLayout_LayoutID]
		ON [dbo].[CMS_TemplateDeviceLayout] (  [LayoutID]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 200 of 1510 : Created [IX_CMS_TemplateDeviceLayout_LayoutID]';
    END;

GO

PRINT ' 201 of 1510 : Analyzing IX_CMS_BannerCategory_BannerCategoryName_BannerCategorySiteID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_BannerCategory_BannerCategoryName_BannerCategorySiteID') 
    --IS NULL
    BEGIN
	   CREATE  UNIQUE NONCLUSTERED  INDEX
	   [IX_CMS_BannerCategory_BannerCategoryName_BannerCategorySiteID]
	   ON [dbo].[CMS_BannerCategory] (  [BannerCategoryName]  ASC , [BannerCategorySiteID]  ASC) 
	   WITH
	   ( PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 202 of 1510 : Created [IX_CMS_BannerCategory_BannerCategoryName_BannerCategorySiteID]';
    END;

GO

PRINT ' 203 of 1510 : Analyzing IX_CMS_UIElement_ElementResourceID_ElementLevel_ElementParentID_ElementOrder_ElementCaption';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_UIElement_ElementResourceID_ElementLevel_ElementParentID_ElementOrder_ElementCaption') --IS NULL
    BEGIN  CREATE CLUSTERED INDEX
		 [IX_CMS_UIElement_ElementResourceID_ElementLevel_ElementParentID_ElementOrder_ElementCaption]
		 ON [dbo].[CMS_UIElement] (  [ElementResourceID]  ASC , [ElementLevel]  ASC , [ElementParentID]  ASC , [ElementOrder]  ASC , [ElementCaption]  ASC) 
		 WITH
		 (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 204 of 1510 : Created [IX_CMS_UIElement_ElementResourceID_ElementLevel_ElementParentID_ElementOrder_ElementCaption]';
    END;

GO

PRINT ' 205 of 1510 : Analyzing CMS_UIElement_idx_01';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'CMS_UIElement_idx_01') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [CMS_UIElement_idx_01]
	   ON [dbo].[CMS_UIElement] (  [ElementParentID]  ASC , [ElementLevel]  ASC) WITH (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 206 of 1510 : Created [CMS_UIElement_idx_01]';
    END;

GO

PRINT ' 207 of 1510 : Analyzing IX_Analytics_Index_All';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Analytics_Index_All') 
    --IS NULL
    BEGIN
	   CREATE CLUSTERED INDEX
	   [IX_Analytics_Index_All]
	   ON [dbo].[Analytics_Index] (  [IndexID]  ASC , [IndexZero]  ASC , [IndexMonthName]  ASC , [IndexDayName]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 208 of 1510 : Created [IX_Analytics_Index_All]';
    END;

GO

PRINT ' 209 of 1510 : Analyzing idx_HFit_TrackerStressManagement_CreateDate';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'idx_HFit_TrackerStressManagement_CreateDate') --IS NULL
    BEGIN  CREATE NONCLUSTERED INDEX
		 [idx_HFit_TrackerStressManagement_CreateDate]
		 ON [dbo].[HFit_TrackerStressManagement] (  [ItemCreatedWhen]  ASC , [ItemModifiedWhen]  ASC) 
		 WITH
		 ( PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 210 of 1510 : Created [idx_HFit_TrackerStressManagement_CreateDate]';
    END;

GO

PRINT ' 211 of 1510 : Analyzing IX_CMS_Country_CountryDisplayName';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_Country_CountryDisplayName') 
    --IS NULL
    BEGIN
	   CREATE CLUSTERED INDEX
	   [IX_CMS_Country_CountryDisplayName]
	   ON [dbo].[CMS_Country] (  [CountryDisplayName]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 212 of 1510 : Created [IX_CMS_Country_CountryDisplayName]';
    END;

GO

PRINT ' 213 of 1510 : Analyzing IX_HFit_HealthAssesmentUserModule_1';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_HFit_HealthAssesmentUserModule_1') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[IX_HFit_HealthAssesmentUserModule_1]
		ON [dbo].[HFit_HealthAssesmentUserModule] (  [UserID]  ASC) INCLUDE ( [HAModuleNodeGUID]) WITH ( PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 214 of 1510 : Created [IX_HFit_HealthAssesmentUserModule_1]';
    END;

GO

PRINT ' 215 of 1510 : Analyzing IX_HAModule_StartedItemID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_HAModule_StartedItemID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_HAModule_StartedItemID]
	   ON [dbo].[HFit_HealthAssesmentUserModule] ( [HAStartedItemID]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 216 of 1510 : Created [IX_HAModule_StartedItemID]';
    END;

GO

PRINT ' 217 of 1510 : Analyzing IX_CMS_LicenseKey_LicenseDomain';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_LicenseKey_LicenseDomain') 
    --IS NULL
    BEGIN
	   CREATE CLUSTERED INDEX
	   [IX_CMS_LicenseKey_LicenseDomain]
	   ON [dbo].[CMS_LicenseKey] (  [LicenseDomain]  ASC) WITH (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 218 of 1510 : Created [IX_CMS_LicenseKey_LicenseDomain]';
    END;

GO

PRINT ' 219 of 1510 : Analyzing IX_Blog_PostSubscription_SubscriptionPostDocumentID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Blog_PostSubscription_SubscriptionPostDocumentID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_Blog_PostSubscription_SubscriptionPostDocumentID]
	   ON [dbo].[Blog_PostSubscription] ( [SubscriptionPostDocumentID]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 220 of 1510 : Created [IX_Blog_PostSubscription_SubscriptionPostDocumentID]';
    END;

GO

PRINT ' 221 of 1510 : Analyzing IX_Blog_PostSubscription_SubscriptionUserID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Blog_PostSubscription_SubscriptionUserID') --IS NULL
    BEGIN  CREATE NONCLUSTERED INDEX
		 [IX_Blog_PostSubscription_SubscriptionUserID]
		 ON [dbo].[Blog_PostSubscription] (  [SubscriptionUserID]  ASC) 
		 WITH
		 (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 222 of 1510 : Created [IX_Blog_PostSubscription_SubscriptionUserID]';
    END;

GO

PRINT ' 223 of 1510 : Analyzing IX_CMS_Permission_ClassID_PermissionName';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_Permission_ClassID_PermissionName') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[IX_CMS_Permission_ClassID_PermissionName]
		ON [dbo].[CMS_Permission] ( [ClassID]  ASC , [PermissionName]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 224 of 1510 : Created [IX_CMS_Permission_ClassID_PermissionName]';
    END;

GO

PRINT ' 225 of 1510 : Analyzing IX_CMS_Permission_ResourceID_PermissionName';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_Permission_ResourceID_PermissionName') --IS NULL
    BEGIN  CREATE NONCLUSTERED INDEX
		 [IX_CMS_Permission_ResourceID_PermissionName]
		 ON [dbo].[CMS_Permission] (  [ResourceID]  ASC , [PermissionName]  ASC) 
		 WITH
		 (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 226 of 1510 : Created [IX_CMS_Permission_ResourceID_PermissionName]';
    END;

GO

PRINT ' 227 of 1510 : Analyzing IX_CMS_PageTemplateScope_PageTemplateScopePath';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_PageTemplateScope_PageTemplateScopePath') --IS NULL
    BEGIN  CREATE CLUSTERED INDEX
		 [IX_CMS_PageTemplateScope_PageTemplateScopePath]
		 ON [dbo].[CMS_PageTemplateScope] (  [PageTemplateScopePath]  ASC) 
		 WITH
		 (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 228 of 1510 : Created [IX_CMS_PageTemplateScope_PageTemplateScopePath]';
    END;

GO

PRINT ' 229 of 1510 : Analyzing IX_CMS_PageTemplateScope_PageTemplateScopeLevels';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_PageTemplateScope_PageTemplateScopeLevels') --IS NULL
    BEGIN  CREATE NONCLUSTERED INDEX
		 [IX_CMS_PageTemplateScope_PageTemplateScopeLevels]
		 ON [dbo].[CMS_PageTemplateScope] (  [PageTemplateScopeLevels]  ASC) 
		 WITH
		 (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 230 of 1510 : Created [IX_CMS_PageTemplateScope_PageTemplateScopeLevels]';
    END;

GO

PRINT ' 231 of 1510 : Analyzing IX_CMS_PageTemplateScope_PageTemplateScopeCultureID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_PageTemplateScope_PageTemplateScopeCultureID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_CMS_PageTemplateScope_PageTemplateScopeCultureID]
	   ON [dbo].[CMS_PageTemplateScope] ( [PageTemplateScopeCultureID]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 232 of 1510 : Created [IX_CMS_PageTemplateScope_PageTemplateScopeCultureID]';
    END;

GO

PRINT ' 233 of 1510 : Analyzing IX_CMS_PageTemplateScope_PageTemplateScopeClassID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_PageTemplateScope_PageTemplateScopeClassID') --IS NULL
    BEGIN  CREATE NONCLUSTERED INDEX
		 [IX_CMS_PageTemplateScope_PageTemplateScopeClassID]
		 ON [dbo].[CMS_PageTemplateScope] (  [PageTemplateScopeClassID]  ASC) 
		 WITH
		 (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 234 of 1510 : Created [IX_CMS_PageTemplateScope_PageTemplateScopeClassID]';
    END;

GO

PRINT ' 235 of 1510 : Analyzing IX_CMS_PageTemplateScope_PageTemplateScopeTemplateID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_PageTemplateScope_PageTemplateScopeTemplateID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_CMS_PageTemplateScope_PageTemplateScopeTemplateID]
	   ON [dbo].[CMS_PageTemplateScope] ( [PageTemplateScopeTemplateID]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 236 of 1510 : Created [IX_CMS_PageTemplateScope_PageTemplateScopeTemplateID]';
    END;

GO

PRINT ' 237 of 1510 : Analyzing IX_CMS_PageTemplateScope_PageTemplateScopeSiteID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_PageTemplateScope_PageTemplateScopeSiteID') --IS NULL
    BEGIN  CREATE NONCLUSTERED INDEX
		 [IX_CMS_PageTemplateScope_PageTemplateScopeSiteID]
		 ON [dbo].[CMS_PageTemplateScope] (  [PageTemplateScopeSiteID]  ASC) 
		 WITH
		 (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 238 of 1510 : Created [IX_CMS_PageTemplateScope_PageTemplateScopeSiteID]';
    END;

GO

PRINT ' 239 of 1510 : Analyzing idx_HFit_TrackerRegularMeals_CreateDate';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'idx_HFit_TrackerRegularMeals_CreateDate') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[idx_HFit_TrackerRegularMeals_CreateDate]
		ON [dbo].[HFit_TrackerRegularMeals] (  [ItemCreatedWhen]  ASC , [ItemModifiedWhen]  ASC) 
		WITH
		( PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 240 of 1510 : Created [idx_HFit_TrackerRegularMeals_CreateDate]';
    END;

GO

PRINT ' 241 of 1510 : Analyzing idx_HFit_TrackerWholeGrains_CreateDate';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'idx_HFit_TrackerWholeGrains_CreateDate') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[idx_HFit_TrackerWholeGrains_CreateDate]
		ON [dbo].[HFit_TrackerWholeGrains] (  [ItemCreatedWhen]  ASC , [ItemModifiedWhen]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 242 of 1510 : Created [idx_HFit_TrackerWholeGrains_CreateDate]';
    END;

GO

PRINT ' 243 of 1510 : Analyzing IX_Analytics_YearHits_HitsStartTime_HitsEndTime';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Analytics_YearHits_HitsStartTime_HitsEndTime') --IS NULL
    BEGIN  CREATE CLUSTERED INDEX
		 [IX_Analytics_YearHits_HitsStartTime_HitsEndTime]
		 ON [dbo].[Analytics_YearHits] (  [HitsStartTime] DESC , [HitsEndTime] DESC) 
		 WITH
		 (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 244 of 1510 : Created [IX_Analytics_YearHits_HitsStartTime_HitsEndTime]';
    END;

GO

PRINT ' 245 of 1510 : Analyzing IX_Analytics_WeekYearHits_HitsStatisticsID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Analytics_WeekYearHits_HitsStatisticsID') --IS NULL
    BEGIN  CREATE NONCLUSTERED INDEX
		 [IX_Analytics_WeekYearHits_HitsStatisticsID]
		 ON [dbo].[Analytics_YearHits] (  [HitsStatisticsID]  ASC) 
		 WITH
		 (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 246 of 1510 : Created [IX_Analytics_WeekYearHits_HitsStatisticsID]';
    END;

GO

PRINT ' 247 of 1510 : Analyzing IX_OM_Activity_ActivityActiveContactID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_OM_Activity_ActivityActiveContactID') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[IX_OM_Activity_ActivityActiveContactID]
		ON [dbo].[OM_Activity] ( [ActivityActiveContactID]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 248 of 1510 : Created [IX_OM_Activity_ActivityActiveContactID]';
    END;

GO

PRINT ' 249 of 1510 : Analyzing IX_OM_Activity_ActivityOriginalContactID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_OM_Activity_ActivityOriginalContactID') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[IX_OM_Activity_ActivityOriginalContactID]
		ON [dbo].[OM_Activity] ( [ActivityOriginalContactID]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 250 of 1510 : Created [IX_OM_Activity_ActivityOriginalContactID]';
    END;

GO

PRINT ' 251 of 1510 : Analyzing IX_OM_Activity_ActivityCreated';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_OM_Activity_ActivityCreated') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_OM_Activity_ActivityCreated]
	   ON [dbo].[OM_Activity] (  [ActivityCreated]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 252 of 1510 : Created [IX_OM_Activity_ActivityCreated]';
    END;

GO

PRINT ' 253 of 1510 : Analyzing IX_OM_Activity_ActivityType';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_OM_Activity_ActivityType') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_OM_Activity_ActivityType]
	   ON [dbo].[OM_Activity] (  [ActivityType]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 254 of 1510 : Created [IX_OM_Activity_ActivityType]';
    END;

GO

PRINT ' 255 of 1510 : Analyzing IX_OM_Activity_ActivityItemDetailID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_OM_Activity_ActivityItemDetailID') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[IX_OM_Activity_ActivityItemDetailID]
		ON [dbo].[OM_Activity] ( [ActivityItemDetailID]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 256 of 1510 : Created [IX_OM_Activity_ActivityItemDetailID]';
    END;

GO

PRINT ' 257 of 1510 : Analyzing IX_OM_Activity_ActivitySiteID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_OM_Activity_ActivitySiteID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_OM_Activity_ActivitySiteID]
	   ON [dbo].[OM_Activity] (  [ActivitySiteID]  ASC) WITH (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 258 of 1510 : Created [IX_OM_Activity_ActivitySiteID]';
    END;

GO

PRINT ' 259 of 1510 : Analyzing IX_CMS_InlineControl_ControlDisplayName';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_InlineControl_ControlDisplayName') --IS NULL
    BEGIN CREATE CLUSTERED INDEX
		[IX_CMS_InlineControl_ControlDisplayName]
		ON [dbo].[CMS_InlineControl] ( [ControlDisplayName]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 260 of 1510 : Created [IX_CMS_InlineControl_ControlDisplayName]';
    END;

GO

PRINT ' 261 of 1510 : Analyzing IX_CMS_BannedIP_IPAddressSiteID_IPAddress';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_BannedIP_IPAddressSiteID_IPAddress') --IS NULL
    BEGIN  CREATE CLUSTERED INDEX
		 [IX_CMS_BannedIP_IPAddressSiteID_IPAddress]
		 ON [dbo].[CMS_BannedIP] ( [IPAddress]  ASC , [IPAddressSiteID]  ASC) 
		 WITH
		 (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 262 of 1510 : Created [IX_CMS_BannedIP_IPAddressSiteID_IPAddress]';
    END;

GO

PRINT ' 263 of 1510 : Analyzing IX_Analytics_WeekHits_HitsStartTime_HitsEndTime';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Analytics_WeekHits_HitsStartTime_HitsEndTime') --IS NULL
    BEGIN  CREATE CLUSTERED INDEX
		 [IX_Analytics_WeekHits_HitsStartTime_HitsEndTime]
		 ON [dbo].[Analytics_WeekHits] (  [HitsStartTime] DESC , [HitsEndTime] DESC) 
		 WITH
		 (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 264 of 1510 : Created [IX_Analytics_WeekHits_HitsStartTime_HitsEndTime]';
    END;

GO

PRINT ' 265 of 1510 : Analyzing IX_Analytics_WeekHits_HitsStatisticsID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Analytics_WeekHits_HitsStatisticsID') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[IX_Analytics_WeekHits_HitsStatisticsID]
		ON [dbo].[Analytics_WeekHits] ( [HitsStatisticsID]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 266 of 1510 : Created [IX_Analytics_WeekHits_HitsStatisticsID]';
    END;

GO

PRINT ' 267 of 1510 : Analyzing idxpagetemplatetemp';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'idxpagetemplatetemp') 
    --IS NULL
    BEGIN
	   CREATE  UNIQUE CLUSTERED  INDEX
	   [idxpagetemplatetemp]
	   ON [dbo].[temp_CMS_PageTemplate] (  [PageTemplateID]  ASC) WITH (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 268 of 1510 : Created [idxpagetemplatetemp]';
    END;

GO

PRINT ' 269 of 1510 : Analyzing IX_CMS_FormUserControl_UserControlDisplayName';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_FormUserControl_UserControlDisplayName') --IS NULL
    BEGIN  CREATE CLUSTERED INDEX
		 [IX_CMS_FormUserControl_UserControlDisplayName]
		 ON [dbo].[CMS_FormUserControl] (  [UserControlDisplayName]  ASC) 
		 WITH
		 (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 270 of 1510 : Created [IX_CMS_FormUserControl_UserControlDisplayName]';
    END;

GO

PRINT ' 271 of 1510 : Analyzing IX_CMS_FormUserControl_UserControlResourceID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_FormUserControl_UserControlResourceID') --IS NULL
    BEGIN  CREATE NONCLUSTERED INDEX
		 [IX_CMS_FormUserControl_UserControlResourceID]
		 ON [dbo].[CMS_FormUserControl] (  [UserControlResourceID]  ASC) 
		 WITH
		 (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 272 of 1510 : Created [IX_CMS_FormUserControl_UserControlResourceID]';
    END;

GO

PRINT ' 273 of 1510 : Analyzing IX_CMS_FormUserControl_UserControlParentID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_FormUserControl_UserControlParentID') --IS NULL
    BEGIN  CREATE NONCLUSTERED INDEX
		 [IX_CMS_FormUserControl_UserControlParentID]
		 ON [dbo].[CMS_FormUserControl] (  [UserControlParentID]  ASC) 
		 WITH
		 (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 274 of 1510 : Created [IX_CMS_FormUserControl_UserControlParentID]';
    END;

GO

PRINT ' 275 of 1510 : Analyzing IX_Analytics_MonthHits_HitsStartTime_HitsEndTime';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Analytics_MonthHits_HitsStartTime_HitsEndTime') --IS NULL
    BEGIN  CREATE CLUSTERED INDEX
		 [IX_Analytics_MonthHits_HitsStartTime_HitsEndTime]
		 ON [dbo].[Analytics_MonthHits] (  [HitsStartTime] DESC , [HitsEndTime] DESC) 
		 WITH
		 (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 276 of 1510 : Created [IX_Analytics_MonthHits_HitsStartTime_HitsEndTime]';
    END;

GO

PRINT ' 277 of 1510 : Analyzing IX_Analytics_MonthHits_HitsStatisticsID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Analytics_MonthHits_HitsStatisticsID') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[IX_Analytics_MonthHits_HitsStatisticsID]
		ON [dbo].[Analytics_MonthHits] ( [HitsStatisticsID]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 278 of 1510 : Created [IX_Analytics_MonthHits_HitsStatisticsID]';
    END;

GO

PRINT ' 279 of 1510 : Analyzing IX_Newsletter_Subscriber_SubscriberSiteID_SubscriberFullName';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Newsletter_Subscriber_SubscriberSiteID_SubscriberFullName') 
    --IS NULL
    BEGIN
	   CREATE CLUSTERED INDEX
	   [IX_Newsletter_Subscriber_SubscriberSiteID_SubscriberFullName]
	   ON [dbo].[Newsletter_Subscriber] ( [SubscriberSiteID]  ASC , [SubscriberFullName]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 280 of 1510 : Created [IX_Newsletter_Subscriber_SubscriberSiteID_SubscriberFullName]';
    END;

GO

PRINT ' 281 of 1510 : Analyzing IX_Newsletter_Subscriber_SubscriberType_SubscriberRelatedID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Newsletter_Subscriber_SubscriberType_SubscriberRelatedID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_Newsletter_Subscriber_SubscriberType_SubscriberRelatedID]
	   ON [dbo].[Newsletter_Subscriber] (  [SubscriberType]  ASC , [SubscriberRelatedID]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 282 of 1510 : Created [IX_Newsletter_Subscriber_SubscriberType_SubscriberRelatedID]';
    END;

GO

PRINT ' 283 of 1510 : Analyzing IDX_Hfit_HealthAssesmentUserAnswers_HAAnswerNodeGUID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IDX_Hfit_HealthAssesmentUserAnswers_HAAnswerNodeGUID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IDX_Hfit_HealthAssesmentUserAnswers_HAAnswerNodeGUID]
	   ON [dbo].[HFit_HealthAssesmentUserAnswers] ( [ItemID]  ASC , [HAQuestionItemID]  ASC , [HAAnswerPoints]  ASC , [HAAnswerValue]  ASC , [CodeName]  ASC , [UOMCode]  ASC , [HAAnswerNodeGUID]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 284 of 1510 : Created [IDX_Hfit_HealthAssesmentUserAnswers_HAAnswerNodeGUID]';
    END;

GO

PRINT ' 285 of 1510 : Analyzing nonHAQuestionItemID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'nonHAQuestionItemID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [nonHAQuestionItemID]
	   ON [dbo].[HFit_HealthAssesmentUserAnswers] (  [HAQuestionItemID]  ASC) WITH (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 286 of 1510 : Created [nonHAQuestionItemID]';
    END;

GO

PRINT ' 287 of 1510 : Analyzing idx_HFit_TrackerStrength_CreateDate';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'idx_HFit_TrackerStrength_CreateDate') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[idx_HFit_TrackerStrength_CreateDate]
		ON [dbo].[HFit_TrackerStrength] ( [ItemCreatedWhen]  ASC , [ItemModifiedWhen]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 288 of 1510 : Created [idx_HFit_TrackerStrength_CreateDate]';
    END;

GO

PRINT ' 289 of 1510 : Analyzing idx_ThresholdTypeID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'idx_ThresholdTypeID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [idx_ThresholdTypeID]
	   ON [dbo].[HFit_HealthAssesmentThresholds] (  [ThresholdTypeID]  ASC) WITH (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 290 of 1510 : Created [idx_ThresholdTypeID]';
    END;

GO

PRINT ' 291 of 1510 : Analyzing Ref65';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'Ref65') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [Ref65]
	   ON [dbo].[HFit_HealthAssesmentThresholds] (  [ThresholdTypeID]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 292 of 1510 : Created [Ref65]';
    END;

GO

PRINT ' 293 of 1510 : Analyzing IX_Analytics_HourHits_HitsStartTime_HitsEndTime';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Analytics_HourHits_HitsStartTime_HitsEndTime') --IS NULL
    BEGIN  CREATE CLUSTERED INDEX
		 [IX_Analytics_HourHits_HitsStartTime_HitsEndTime]
		 ON [dbo].[Analytics_HourHits] (  [HitsStartTime] DESC , [HitsEndTime] DESC) 
		 WITH
		 (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 294 of 1510 : Created [IX_Analytics_HourHits_HitsStartTime_HitsEndTime]';
    END;

GO

PRINT ' 295 of 1510 : Analyzing IX_Analytics_HourHits_HitsStatisticsID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Analytics_HourHits_HitsStatisticsID') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[IX_Analytics_HourHits_HitsStatisticsID]
		ON [dbo].[Analytics_HourHits] ( [HitsStatisticsID]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 296 of 1510 : Created [IX_Analytics_HourHits_HitsStatisticsID]';
    END;

GO

PRINT ' 297 of 1510 : Analyzing IX_OM_ContactGroup_ContactGroupSiteID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_OM_ContactGroup_ContactGroupSiteID') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[IX_OM_ContactGroup_ContactGroupSiteID]
		ON [dbo].[OM_ContactGroup] ( [ContactGroupSiteID]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 298 of 1510 : Created [IX_OM_ContactGroup_ContactGroupSiteID]';
    END;

GO

PRINT ' 299 of 1510 : Analyzing PKI_EDW_BiometricViewRejectCriteria';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'PKI_EDW_BiometricViewRejectCriteria') --IS NULL
    BEGIN CREATE  UNIQUE CLUSTERED INDEX
		[PKI_EDW_BiometricViewRejectCriteria]
		ON [dbo].[EDW_BiometricViewRejectCriteria] (  [AccountCD]  ASC , [ItemCreatedWhen]  ASC , [SiteID]  ASC) WITH (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 300 of 1510 : Created [PKI_EDW_BiometricViewRejectCriteria]';
    END;

GO

PRINT ' 301 of 1510 : Analyzing idx_HFit_TrackerHighFatFoods_CreateDate';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'idx_HFit_TrackerHighFatFoods_CreateDate') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[idx_HFit_TrackerHighFatFoods_CreateDate]
		ON [dbo].[HFit_TrackerHighFatFoods] (  [ItemCreatedWhen]  ASC , [ItemModifiedWhen]  ASC) 
		WITH
		( PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 302 of 1510 : Created [idx_HFit_TrackerHighFatFoods_CreateDate]';
    END;

GO

PRINT ' 303 of 1510 : Analyzing IX_Newsletter_Emails_EmailNewsletterIssueID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Newsletter_Emails_EmailNewsletterIssueID') --IS NULL
    BEGIN  CREATE NONCLUSTERED INDEX
		 [IX_Newsletter_Emails_EmailNewsletterIssueID]
		 ON [dbo].[Newsletter_Emails] (  [EmailNewsletterIssueID]  ASC) 
		 WITH
		 (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 304 of 1510 : Created [IX_Newsletter_Emails_EmailNewsletterIssueID]';
    END;

GO

PRINT ' 305 of 1510 : Analyzing IX_Newsletter_Emails_EmailSubscriberID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Newsletter_Emails_EmailSubscriberID') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[IX_Newsletter_Emails_EmailSubscriberID]
		ON [dbo].[Newsletter_Emails] ( [EmailSubscriberID]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 306 of 1510 : Created [IX_Newsletter_Emails_EmailSubscriberID]';
    END;

GO

PRINT ' 307 of 1510 : Analyzing IX_Newsletter_Emails_EmailSiteID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Newsletter_Emails_EmailSiteID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_Newsletter_Emails_EmailSiteID]
	   ON [dbo].[Newsletter_Emails] (  [EmailSiteID] ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 308 of 1510 : Created [IX_Newsletter_Emails_EmailSiteID]';
    END;

GO

PRINT ' 309 of 1510 : Analyzing IX_Newsletter_Emails_EmailSending';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Newsletter_Emails_EmailSending') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_Newsletter_Emails_EmailSending]
	   ON [dbo].[Newsletter_Emails] (  [EmailSending] ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 310 of 1510 : Created [IX_Newsletter_Emails_EmailSending]';
    END;

GO

PRINT ' 311 of 1510 : Analyzing IX_Newsletter_Emails_EmailGUID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Newsletter_Emails_EmailGUID') 
    --IS NULL
    BEGIN
	   CREATE UNIQUE NONCLUSTERED INDEX
	   [IX_Newsletter_Emails_EmailGUID]
	   ON [dbo].[Newsletter_Emails] (  [EmailGUID] ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 312 of 1510 : Created [IX_Newsletter_Emails_EmailGUID]';
    END;

GO

PRINT ' 313 of 1510 : Analyzing IX_Analytics_DayHits_HitsStartTime_HitsEndTime';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Analytics_DayHits_HitsStartTime_HitsEndTime') --IS NULL
    BEGIN  CREATE CLUSTERED INDEX
		 [IX_Analytics_DayHits_HitsStartTime_HitsEndTime]
		 ON [dbo].[Analytics_DayHits] (  [HitsStartTime] DESC , [HitsEndTime] DESC) 
		 WITH
		 (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 314 of 1510 : Created [IX_Analytics_DayHits_HitsStartTime_HitsEndTime]';
    END;

GO

PRINT ' 315 of 1510 : Analyzing IX_Analytics_DayHits_HitsStatisticsID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Analytics_DayHits_HitsStatisticsID') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[IX_Analytics_DayHits_HitsStatisticsID]
		ON [dbo].[Analytics_DayHits] ( [HitsStatisticsID]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 316 of 1510 : Created [IX_Analytics_DayHits_HitsStatisticsID]';
    END;

GO

PRINT ' 317 of 1510 : Analyzing IX_Forums_ForumGroup_GroupSiteID_GroupOrder';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Forums_ForumGroup_GroupSiteID_GroupOrder') --IS NULL
    BEGIN  CREATE CLUSTERED INDEX
		 [IX_Forums_ForumGroup_GroupSiteID_GroupOrder]
		 ON [dbo].[Forums_ForumGroup] (  [GroupSiteID]  ASC , [GroupOrder]  ASC) 
		 WITH
		 (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 318 of 1510 : Created [IX_Forums_ForumGroup_GroupSiteID_GroupOrder]';
    END;

GO

PRINT ' 319 of 1510 : Analyzing IX_Forums_ForumGroup_GroupSiteID_GroupName';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Forums_ForumGroup_GroupSiteID_GroupName') --IS NULL
    BEGIN  CREATE NONCLUSTERED INDEX
		 [IX_Forums_ForumGroup_GroupSiteID_GroupName]
		 ON [dbo].[Forums_ForumGroup] (  [GroupSiteID]  ASC , [GroupName]  ASC) 
		 WITH
		 (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 320 of 1510 : Created [IX_Forums_ForumGroup_GroupSiteID_GroupName]';
    END;

GO

PRINT ' 321 of 1510 : Analyzing IX_Forums_ForumGroup_GroupGroupID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Forums_ForumGroup_GroupGroupID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_Forums_ForumGroup_GroupGroupID]
	   ON [dbo].[Forums_ForumGroup] (  [GroupGroupID] ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 322 of 1510 : Created [IX_Forums_ForumGroup_GroupGroupID]';
    END;

GO

PRINT ' 323 of 1510 : Analyzing IX_TrackerDailySteps_SourceID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_TrackerDailySteps_SourceID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_TrackerDailySteps_SourceID]
	   ON [dbo].[HFit_TrackerDailySteps] ( [TrackerCollectionSourceID]  ASC , [IsProfessionallyCollected]  ASC , [UserID]  ASC) 
	   WITH
	   ( PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 324 of 1510 : Created [IX_TrackerDailySteps_SourceID]';
    END;

GO

PRINT ' 325 of 1510 : Analyzing idx_HFit_TrackerDailySteps_CreateDate';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'idx_HFit_TrackerDailySteps_CreateDate') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[idx_HFit_TrackerDailySteps_CreateDate]
		ON [dbo].[HFit_TrackerDailySteps] (  [ItemCreatedWhen]  ASC , [ItemModifiedWhen]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 326 of 1510 : Created [idx_HFit_TrackerDailySteps_CreateDate]';
    END;

GO

PRINT ' 327 of 1510 : Analyzing IX_Chat_Room_SiteID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Chat_Room_SiteID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_Chat_Room_SiteID]
	   ON [dbo].[Chat_Room] (  [ChatRoomSiteID]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 328 of 1510 : Created [IX_Chat_Room_SiteID]';
    END;

GO

PRINT ' 329 of 1510 : Analyzing IX_Chat_Room_Enabled';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Chat_Room_Enabled') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_Chat_Room_Enabled]
	   ON [dbo].[Chat_Room] (  [ChatRoomEnabled]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 330 of 1510 : Created [IX_Chat_Room_Enabled]';
    END;

GO

PRINT ' 331 of 1510 : Analyzing IX_Chat_Room_IsSupport';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Chat_Room_IsSupport') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_Chat_Room_IsSupport]
	   ON [dbo].[Chat_Room] (  [ChatRoomIsSupport]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 332 of 1510 : Created [IX_Chat_Room_IsSupport]';
    END;

GO

PRINT ' 333 of 1510 : Analyzing idx_HFit_TrackerFruits_CreateDate';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'idx_HFit_TrackerFruits_CreateDate') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [idx_HFit_TrackerFruits_CreateDate]
	   ON [dbo].[HFit_TrackerFruits] ( [ItemCreatedWhen]  ASC , [ItemModifiedWhen]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 334 of 1510 : Created [idx_HFit_TrackerFruits_CreateDate]';
    END;

GO

PRINT ' 335 of 1510 : Analyzing IX_CMS_RelationshipName_RelationshipName_RelationshipDisplayName';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_RelationshipName_RelationshipName_RelationshipDisplayName') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_CMS_RelationshipName_RelationshipName_RelationshipDisplayName]
	   ON [dbo].[CMS_RelationshipName] (  [RelationshipName]  ASC , [RelationshipDisplayName]  ASC) 
	   WITH
	   ( PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 336 of 1510 : Created [IX_CMS_RelationshipName_RelationshipName_RelationshipDisplayName]';
    END;

GO

PRINT ' 337 of 1510 : Analyzing IX_CMS_RelationshipName_RelationshipAllowedObjects';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_RelationshipName_RelationshipAllowedObjects') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_CMS_RelationshipName_RelationshipAllowedObjects]
	   ON [dbo].[CMS_RelationshipName] ( [RelationshipAllowedObjects]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 338 of 1510 : Created [IX_CMS_RelationshipName_RelationshipAllowedObjects]';
    END;

GO

PRINT ' 339 of 1510 : Analyzing IX_CMS_UserSettings_UserNickName';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_UserSettings_UserNickName') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_CMS_UserSettings_UserNickName]
	   ON [dbo].[CMS_UserSettings] (  [UserNickName] ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 340 of 1510 : Created [IX_CMS_UserSettings_UserNickName]';
    END;

GO

PRINT ' 341 of 1510 : Analyzing IX_CMS_UserSettings_UserActivatedByUserID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_UserSettings_UserActivatedByUserID') --IS NULL
    BEGIN  CREATE NONCLUSTERED INDEX
		 [IX_CMS_UserSettings_UserActivatedByUserID]
		 ON [dbo].[CMS_UserSettings] (  [UserActivatedByUserID]  ASC) 
		 WITH
		 (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 342 of 1510 : Created [IX_CMS_UserSettings_UserActivatedByUserID]';
    END;

GO

PRINT ' 343 of 1510 : Analyzing IX_CMS_UserSettings_UserTimeZoneID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_UserSettings_UserTimeZoneID') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[IX_CMS_UserSettings_UserTimeZoneID]
		ON [dbo].[CMS_UserSettings] ( [UserTimeZoneID]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 344 of 1510 : Created [IX_CMS_UserSettings_UserTimeZoneID]';
    END;

GO

PRINT ' 345 of 1510 : Analyzing IX_CMS_UserSettings_UserAvatarID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_UserSettings_UserAvatarID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_CMS_UserSettings_UserAvatarID]
	   ON [dbo].[CMS_UserSettings] (  [UserAvatarID] ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 346 of 1510 : Created [IX_CMS_UserSettings_UserAvatarID]';
    END;

GO

PRINT ' 347 of 1510 : Analyzing IX_CMS_UserSettings_UserBadgeID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_UserSettings_UserBadgeID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_CMS_UserSettings_UserBadgeID]
	   ON [dbo].[CMS_UserSettings] (  [UserBadgeID]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 348 of 1510 : Created [IX_CMS_UserSettings_UserBadgeID]';
    END;

GO

PRINT ' 349 of 1510 : Analyzing IX_CMS_UserSettings_UserGender';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_UserSettings_UserGender') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_CMS_UserSettings_UserGender]
	   ON [dbo].[CMS_UserSettings] (  [UserGender]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 350 of 1510 : Created [IX_CMS_UserSettings_UserGender]';
    END;

GO

PRINT ' 351 of 1510 : Analyzing IX_CMS_UserSettings_UserSettingsUserGUID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_UserSettings_UserSettingsUserGUID') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[IX_CMS_UserSettings_UserSettingsUserGUID]
		ON [dbo].[CMS_UserSettings] ( [UserSettingsUserGUID]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 352 of 1510 : Created [IX_CMS_UserSettings_UserSettingsUserGUID]';
    END;

GO

PRINT ' 353 of 1510 : Analyzing IX_CMS_UserSettings_UserSettingsUserID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_UserSettings_UserSettingsUserID') --IS NULL
    BEGIN CREATE  UNIQUE NONCLUSTERED INDEX
		[IX_CMS_UserSettings_UserSettingsUserID]
		ON [dbo].[CMS_UserSettings] (  [UserSettingsUserID]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 354 of 1510 : Created [IX_CMS_UserSettings_UserSettingsUserID]';
    END;

GO

PRINT ' 355 of 1510 : Analyzing IX_CMS_UserSettings_WindowsLiveID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_UserSettings_WindowsLiveID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_CMS_UserSettings_WindowsLiveID]
	   ON [dbo].[CMS_UserSettings] (  [WindowsLiveID] ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 356 of 1510 : Created [IX_CMS_UserSettings_WindowsLiveID]';
    END;

GO

PRINT ' 357 of 1510 : Analyzing IX_CMS_UserSettings_UserWaitingForApproval';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_UserSettings_UserWaitingForApproval') --IS NULL
    BEGIN  CREATE NONCLUSTERED INDEX
		 [IX_CMS_UserSettings_UserWaitingForApproval]
		 ON [dbo].[CMS_UserSettings] (  [UserWaitingForApproval]  ASC) 
		 WITH
		 (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 358 of 1510 : Created [IX_CMS_UserSettings_UserWaitingForApproval]';
    END;

GO

PRINT ' 359 of 1510 : Analyzing IX_CMS_UserSettings_UserFacebookID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_UserSettings_UserFacebookID') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[IX_CMS_UserSettings_UserFacebookID]
		ON [dbo].[CMS_UserSettings] ( [UserFacebookID]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 360 of 1510 : Created [IX_CMS_UserSettings_UserFacebookID]';
    END;

GO

PRINT ' 361 of 1510 : Analyzing IX_CMS_UserSettings_UserAuthenticationGUID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_UserSettings_UserAuthenticationGUID') --IS NULL
    BEGIN  CREATE NONCLUSTERED INDEX
		 [IX_CMS_UserSettings_UserAuthenticationGUID]
		 ON [dbo].[CMS_UserSettings] (  [UserAuthenticationGUID]  ASC) 
		 WITH
		 (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 362 of 1510 : Created [IX_CMS_UserSettings_UserAuthenticationGUID]';
    END;

GO

PRINT ' 363 of 1510 : Analyzing IX_CMS_UserSettings_UserPasswordRequestHash';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_UserSettings_UserPasswordRequestHash') --IS NULL
    BEGIN  CREATE NONCLUSTERED INDEX
		 [IX_CMS_UserSettings_UserPasswordRequestHash]
		 ON [dbo].[CMS_UserSettings] (  [UserPasswordRequestHash]  ASC) 
		 WITH
		 (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 364 of 1510 : Created [IX_CMS_UserSettings_UserPasswordRequestHash]';
    END;

GO

PRINT ' 365 of 1510 : Analyzing IX_UserSettingsUserID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_UserSettingsUserID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_UserSettingsUserID]
	   ON [dbo].[CMS_UserSettings] (  [UserSettingsUserID]  ASC , [UserSettingsID]  ASC) INCLUDE ( [UserNickName]) WITH (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 366 of 1510 : Created [IX_UserSettingsUserID]';
    END;

GO

PRINT ' 367 of 1510 : Analyzing nonUserIDSetIDDate';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'nonUserIDSetIDDate') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [nonUserIDSetIDDate]
	   ON [dbo].[CMS_UserSettings] (  [UserSettingsUserID]  ASC , [UserSettingsID] ASC , [HFitCoachingEnrollDate]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 368 of 1510 : Created [nonUserIDSetIDDate]';
    END;

GO

PRINT ' 369 of 1510 : Analyzing pi_CMS_UserSettings_IDMPI';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'pi_CMS_UserSettings_IDMPI') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [pi_CMS_UserSettings_IDMPI]
	   ON [dbo].[CMS_UserSettings] (  [UserSettingsID]  ASC , [HFitUserMpiNumber]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 370 of 1510 : Created [pi_CMS_UserSettings_IDMPI]';
    END;

GO

PRINT ' 371 of 1510 : Analyzing PI02_view_EDW_RewardUserDetail';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'PI02_view_EDW_RewardUserDetail') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [PI02_view_EDW_RewardUserDetail]
	   ON [dbo].[CMS_UserSettings] (  [UserSettingsID] ASC , [HFitUserMpiNumber]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 372 of 1510 : Created [PI02_view_EDW_RewardUserDetail]';
    END;

GO

PRINT ' 373 of 1510 : Analyzing IDX_UserSettings_CoachID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IDX_UserSettings_CoachID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IDX_UserSettings_CoachID]
	   ON [dbo].[CMS_UserSettings] (  [HFitCoachId]  ASC) INCLUDE ( [UserSettingsUserID] , [HFitCoachingEnrollDate]) WITH (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 374 of 1510 : Created [IDX_UserSettings_CoachID]';
    END;

GO

PRINT ' 375 of 1510 : Analyzing IDX_UserSettings_SettingsUserID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IDX_UserSettings_SettingsUserID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IDX_UserSettings_SettingsUserID]
	   ON [dbo].[CMS_UserSettings] ( [UserSettingsUserID]  ASC) INCLUDE ( [UserNickName] , [UserGender] , [UserDateOfBirth] , [HFitUserMpiNumber]) WITH (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 376 of 1510 : Created [IDX_UserSettings_SettingsUserID]';
    END;

GO

PRINT ' 377 of 1510 : Analyzing IX_CMS_SearchIndex_IndexDisplayName';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_SearchIndex_IndexDisplayName') --IS NULL
    BEGIN CREATE CLUSTERED INDEX
		[IX_CMS_SearchIndex_IndexDisplayName]
		ON [dbo].[CMS_SearchIndex] ( [IndexDisplayName]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 378 of 1510 : Created [IX_CMS_SearchIndex_IndexDisplayName]';
    END;

GO

PRINT ' 379 of 1510 : Analyzing idx_HFit_TrackerVegetables_CreateDate';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'idx_HFit_TrackerVegetables_CreateDate') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[idx_HFit_TrackerVegetables_CreateDate]
		ON [dbo].[HFit_TrackerVegetables] (  [ItemCreatedWhen]  ASC , [ItemModifiedWhen]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 380 of 1510 : Created [idx_HFit_TrackerVegetables_CreateDate]';
    END;

GO

PRINT ' 381 of 1510 : Analyzing HFit_Account_ClientCode_PI';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'HFit_Account_ClientCode_PI') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [HFit_Account_ClientCode_PI]
	   ON [dbo].[HFit_Account] (  [AccountCD]  ASC) 
	   WITH
	   ( PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 382 of 1510 : Created [HFit_Account_ClientCode_PI]';
    END;

GO

PRINT ' 383 of 1510 : Analyzing HFit_Account_AccountID_CI';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'HFit_Account_AccountID_CI') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [HFit_Account_AccountID_CI]
	   ON [dbo].[HFit_Account] (  [AccountID]  ASC , [AccountCD] ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 384 of 1510 : Created [HFit_Account_AccountID_CI]';
    END;

GO

PRINT ' 385 of 1510 : Analyzing HFit_Account_SiteID_PI';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'HFit_Account_SiteID_PI') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [HFit_Account_SiteID_PI]
	   ON [dbo].[HFit_Account] (  [SiteID]  ASC) 
	   WITH
	   ( PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 386 of 1510 : Created [HFit_Account_SiteID_PI]';
    END;

GO

PRINT ' 387 of 1510 : Analyzing IX_CMS_ObjectSettings_ObjectSettingsObjectType_ObjectSettingsObjectID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_ObjectSettings_ObjectSettingsObjectType_ObjectSettingsObjectID') 
    --IS NULL
    BEGIN
	   CREATE UNIQUE NONCLUSTERED INDEX
	   [IX_CMS_ObjectSettings_ObjectSettingsObjectType_ObjectSettingsObjectID]
	   ON [dbo].[CMS_ObjectSettings] (  [ObjectSettingsObjectID]  ASC , [ObjectSettingsObjectType]  ASC) WITH (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 388 of 1510 : Created [IX_CMS_ObjectSettings_ObjectSettingsObjectType_ObjectSettingsObjectID]';
    END;

GO

PRINT ' 389 of 1510 : Analyzing IX_CMS_UICulture_UICultureName';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_UICulture_UICultureName') 
    --IS NULL
    BEGIN
	   CREATE CLUSTERED INDEX
	   [IX_CMS_UICulture_UICultureName]
	   ON [dbo].[CMS_UICulture] (  [UICultureName]  ASC) WITH (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 390 of 1510 : Created [IX_CMS_UICulture_UICultureName]';
    END;

GO

PRINT ' 391 of 1510 : Analyzing IX_Events_Attendee_AttendeeEmail_AttendeeFirstName_AttendeeLastName';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Events_Attendee_AttendeeEmail_AttendeeFirstName_AttendeeLastName') 
    --IS NULL
    BEGIN
	   CREATE CLUSTERED INDEX
	   [IX_Events_Attendee_AttendeeEmail_AttendeeFirstName_AttendeeLastName]
	   ON [dbo].[Events_Attendee] (  [AttendeeEmail]  ASC , [AttendeeFirstName]  ASC , [AttendeeLastName]  ASC) WITH (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 392 of 1510 : Created [IX_Events_Attendee_AttendeeEmail_AttendeeFirstName_AttendeeLastName]';
    END;

GO

PRINT ' 393 of 1510 : Analyzing IX_Events_Attendee_AttendeeEventNodeID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Events_Attendee_AttendeeEventNodeID') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[IX_Events_Attendee_AttendeeEventNodeID]
		ON [dbo].[Events_Attendee] ( [AttendeeEventNodeID]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 394 of 1510 : Created [IX_Events_Attendee_AttendeeEventNodeID]';
    END;

GO

PRINT ' 395 of 1510 : Analyzing IX_Polls_PollAnswer_AnswerPollID_AnswerOrder_AnswerEnabled';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Polls_PollAnswer_AnswerPollID_AnswerOrder_AnswerEnabled') 
    --IS NULL
    BEGIN
	   CREATE CLUSTERED INDEX
	   [IX_Polls_PollAnswer_AnswerPollID_AnswerOrder_AnswerEnabled]
	   ON [dbo].[Polls_PollAnswer] ( [AnswerOrder]  ASC , [AnswerPollID]  ASC , [AnswerEnabled]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 396 of 1510 : Created [IX_Polls_PollAnswer_AnswerPollID_AnswerOrder_AnswerEnabled]';
    END;

GO

PRINT ' 397 of 1510 : Analyzing IX_CMS_ObjectRelationship_RelationshipLeftObjectType_RelationshipLeftObjectID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_ObjectRelationship_RelationshipLeftObjectType_RelationshipLeftObjectID') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[IX_CMS_ObjectRelationship_RelationshipLeftObjectType_RelationshipLeftObjectID]
		ON [dbo].[CMS_ObjectRelationship] (  [RelationshipLeftObjectType]  ASC , [RelationshipLeftObjectID]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 398 of 1510 : Created [IX_CMS_ObjectRelationship_RelationshipLeftObjectType_RelationshipLeftObjectID]';
    END;

GO

PRINT ' 399 of 1510 : Analyzing IX_CMS_ObjectRelationship_RelationshipRightObjectType_RelationshipRightObjectID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_ObjectRelationship_RelationshipRightObjectType_RelationshipRightObjectID') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[IX_CMS_ObjectRelationship_RelationshipRightObjectType_RelationshipRightObjectID]
		ON [dbo].[CMS_ObjectRelationship] (  [RelationshipRightObjectType]  ASC , [RelationshipRightObjectID]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 400 of 1510 : Created [IX_CMS_ObjectRelationship_RelationshipRightObjectType_RelationshipRightObjectID]';
    END;

GO

PRINT ' 401 of 1510 : Analyzing idx_HFit_TrackerBMI_UserIDEventDate';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'idx_HFit_TrackerBMI_UserIDEventDate') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[idx_HFit_TrackerBMI_UserIDEventDate]
		ON [dbo].[HFit_TrackerBMI] (  [UserID] ASC) INCLUDE ( [EventDate]) WITH (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 402 of 1510 : Created [idx_HFit_TrackerBMI_UserIDEventDate]';
    END;

GO

PRINT ' 403 of 1510 : Analyzing idx_HFit_TrackerBMI_CreateDate';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'idx_HFit_TrackerBMI_CreateDate') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [idx_HFit_TrackerBMI_CreateDate]
	   ON [dbo].[HFit_TrackerBMI] (  [ItemCreatedWhen] ASC , [ItemModifiedWhen]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 404 of 1510 : Created [idx_HFit_TrackerBMI_CreateDate]';
    END;

GO

PRINT ' 405 of 1510 : Analyzing IX_Chat_Message_ChatMessageRoomID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Chat_Message_ChatMessageRoomID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_Chat_Message_ChatMessageRoomID]
	   ON [dbo].[Chat_Message] (  [ChatMessageRoomID] ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 406 of 1510 : Created [IX_Chat_Message_ChatMessageRoomID]';
    END;

GO

PRINT ' 407 of 1510 : Analyzing IX_Chat_Message_ChatMessageLastModified';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Chat_Message_ChatMessageLastModified') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[IX_Chat_Message_ChatMessageLastModified]
		ON [dbo].[Chat_Message] ( [ChatMessageLastModified]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 408 of 1510 : Created [IX_Chat_Message_ChatMessageLastModified]';
    END;

GO

PRINT ' 409 of 1510 : Analyzing IX_Chat_Message_ChatMessageSystemMessageType';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Chat_Message_ChatMessageSystemMessageType') --IS NULL
    BEGIN  CREATE NONCLUSTERED INDEX
		 [IX_Chat_Message_ChatMessageSystemMessageType]
		 ON [dbo].[Chat_Message] (  [ChatMessageSystemMessageType]  ASC) 
		 WITH
		 (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 410 of 1510 : Created [IX_Chat_Message_ChatMessageSystemMessageType]';
    END;

GO

PRINT ' 411 of 1510 : Analyzing IX_Messaging_Message_MessageRecipientUserID_MessageSent_MessageRecipientDeleted';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Messaging_Message_MessageRecipientUserID_MessageSent_MessageRecipientDeleted') --IS NULL
    BEGIN CREATE CLUSTERED INDEX
		[IX_Messaging_Message_MessageRecipientUserID_MessageSent_MessageRecipientDeleted]
		ON [dbo].[Messaging_Message] (  [MessageRecipientUserID]  ASC , [MessageSent] DESC , [MessageRecipientDeleted]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 412 of 1510 : Created [IX_Messaging_Message_MessageRecipientUserID_MessageSent_MessageRecipientDeleted]';
    END;

GO

PRINT ' 413 of 1510 : Analyzing IX_Messaging_Message_MessageSenderUserID_MessageSent_MessageSenderDeleted';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Messaging_Message_MessageSenderUserID_MessageSent_MessageSenderDeleted') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_Messaging_Message_MessageSenderUserID_MessageSent_MessageSenderDeleted]
	   ON [dbo].[Messaging_Message] (  [MessageSenderUserID]  ASC , [MessageSent]  ASC , [MessageSenderDeleted] ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 414 of 1510 : Created [IX_Messaging_Message_MessageSenderUserID_MessageSent_MessageSenderDeleted]';
    END;

GO

PRINT ' 415 of 1510 : Analyzing IX_Messaging_Message_MessageRecipientUserID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Messaging_Message_MessageRecipientUserID') --IS NULL
    BEGIN  CREATE NONCLUSTERED INDEX
		 [IX_Messaging_Message_MessageRecipientUserID]
		 ON [dbo].[Messaging_Message] (  [MessageRecipientUserID]  ASC) 
		 WITH
		 (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 416 of 1510 : Created [IX_Messaging_Message_MessageRecipientUserID]';
    END;

GO

PRINT ' 417 of 1510 : Analyzing IX_Community_Friend_FriendRequestedUserID_FriendStatus';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Community_Friend_FriendRequestedUserID_FriendStatus') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_Community_Friend_FriendRequestedUserID_FriendStatus]
	   ON [dbo].[Community_Friend] ( [FriendRequestedUserID]  ASC , [FriendStatus]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 418 of 1510 : Created [IX_Community_Friend_FriendRequestedUserID_FriendStatus]';
    END;

GO

PRINT ' 419 of 1510 : Analyzing IX_Community_Friend_FriendRequestedUserID_FriendUserID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Community_Friend_FriendRequestedUserID_FriendUserID') 
    --IS NULL
    BEGIN
	   CREATE  UNIQUE NONCLUSTERED INDEX
	   [IX_Community_Friend_FriendRequestedUserID_FriendUserID]
	   ON [dbo].[Community_Friend] ( [FriendRequestedUserID]  ASC , [FriendUserID]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 420 of 1510 : Created [IX_Community_Friend_FriendRequestedUserID_FriendUserID]';
    END;

GO

PRINT ' 421 of 1510 : Analyzing IX_Community_Friend_FriendUserID_FriendStatus';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Community_Friend_FriendUserID_FriendStatus') --IS NULL
    BEGIN  CREATE NONCLUSTERED INDEX
		 [IX_Community_Friend_FriendUserID_FriendStatus]
		 ON [dbo].[Community_Friend] (  [FriendUserID]  ASC , [FriendStatus]  ASC) 
		 WITH
		 (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 422 of 1510 : Created [IX_Community_Friend_FriendUserID_FriendStatus]';
    END;

GO

PRINT ' 423 of 1510 : Analyzing IX_Community_Friend_FriendApprovedBy';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Community_Friend_FriendApprovedBy') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[IX_Community_Friend_FriendApprovedBy]
		ON [dbo].[Community_Friend] ( [FriendApprovedBy]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 424 of 1510 : Created [IX_Community_Friend_FriendApprovedBy]';
    END;

GO

PRINT ' 425 of 1510 : Analyzing IX_Community_Friend_FriendRejectedBy';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Community_Friend_FriendRejectedBy') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[IX_Community_Friend_FriendRejectedBy]
		ON [dbo].[Community_Friend] ( [FriendRejectedBy]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 426 of 1510 : Created [IX_Community_Friend_FriendRejectedBy]';
    END;

GO

PRINT ' 427 of 1510 : Analyzing IX_Hfit_PostSubscriber_ContactGroupID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Hfit_PostSubscriber_ContactGroupID') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[IX_Hfit_PostSubscriber_ContactGroupID]
		ON [dbo].[HFit_PostSubscriber] ( [ContactGroupID]  ASC) INCLUDE ( [DocumentID] , [ContactID] , [Pinned] , [PublishDate]) WITH ( PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 428 of 1510 : Created [IX_Hfit_PostSubscriber_ContactGroupID]';
    END;

GO

PRINT ' 429 of 1510 : Analyzing IX_HFit_PostSubscriber_PublishDate_ItemModifiedWhen_ContactID_GroupID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_HFit_PostSubscriber_PublishDate_ItemModifiedWhen_ContactID_GroupID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_HFit_PostSubscriber_PublishDate_ItemModifiedWhen_ContactID_GroupID]
	   ON [dbo].[HFit_PostSubscriber] (  [ItemModifiedWhen]  ASC , [PublishDate]  ASC , [ContactID]  ASC , [ContactGroupID]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 430 of 1510 : Created [IX_HFit_PostSubscriber_PublishDate_ItemModifiedWhen_ContactID_GroupID]';
    END;

GO

PRINT ' 431 of 1510 : Analyzing IX_Hfit_PostSubscriber_ContactID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Hfit_PostSubscriber_ContactID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_Hfit_PostSubscriber_ContactID]
	   ON [dbo].[HFit_PostSubscriber] (  [ContactID] ASC) INCLUDE ( [DocumentID] , [Pinned] , [PublishDate]) WITH (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 432 of 1510 : Created [IX_Hfit_PostSubscriber_ContactID]';
    END;

GO

PRINT ' 433 of 1510 : Analyzing IX_Hfit_PostSubscriber_1';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Hfit_PostSubscriber_1') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_Hfit_PostSubscriber_1]
	   ON [dbo].[HFit_PostSubscriber] (  [DocumentID]  ASC) INCLUDE ( [ContactID] , [Pinned] , [PublishDate]) WITH (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 434 of 1510 : Created [IX_Hfit_PostSubscriber_1]';
    END;

GO

PRINT ' 435 of 1510 : Analyzing IX_Hfit_PostSubscriber_DocumentID_PublishDate';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Hfit_PostSubscriber_DocumentID_PublishDate') --IS NULL
    BEGIN  CREATE NONCLUSTERED INDEX
		 [IX_Hfit_PostSubscriber_DocumentID_PublishDate]
		 ON [dbo].[HFit_PostSubscriber] (  [DocumentID]  ASC , [PublishDate]  ASC) INCLUDE ( [ContactID] , [ContactGroupID] , [Pinned]) WITH (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 436 of 1510 : Created [IX_Hfit_PostSubscriber_DocumentID_PublishDate]';
    END;

GO

PRINT ' 437 of 1510 : Analyzing IX_PostSubscriber_PublishDate';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_PostSubscriber_PublishDate') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_PostSubscriber_PublishDate]
	   ON [dbo].[HFit_PostSubscriber] (  [PublishDate]  ASC) INCLUDE ( [ContactID] , [ContactGroupID] , [ItemModifiedWhen]) WITH (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 438 of 1510 : Created [IX_PostSubscriber_PublishDate]';
    END;

GO

PRINT ' 439 of 1510 : Analyzing IX_PostSubscriber_NodeID_ContactGroupID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_PostSubscriber_NodeID_ContactGroupID') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[IX_PostSubscriber_NodeID_ContactGroupID]
		ON [dbo].[HFit_PostSubscriber] ( [NodeID]  ASC , [ContactGroupID]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 440 of 1510 : Created [IX_PostSubscriber_NodeID_ContactGroupID]';
    END;

GO

PRINT ' 441 of 1510 : Analyzing IX_Hfit_PostSubscriber_NodeID_PublishDate';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Hfit_PostSubscriber_NodeID_PublishDate') --IS NULL
    BEGIN  CREATE NONCLUSTERED INDEX
		 [IX_Hfit_PostSubscriber_NodeID_PublishDate]
		 ON [dbo].[HFit_PostSubscriber] (  [NodeID]  ASC , [PublishDate]  ASC) INCLUDE ( [ContactID] , [ContactGroupID] , [Pinned]) WITH (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 442 of 1510 : Created [IX_Hfit_PostSubscriber_NodeID_PublishDate]';
    END;

GO

PRINT ' 443 of 1510 : Analyzing IX_CMS_Resource_ResourceDisplayName';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_Resource_ResourceDisplayName') --IS NULL
    BEGIN CREATE CLUSTERED INDEX
		[IX_CMS_Resource_ResourceDisplayName]
		ON [dbo].[CMS_Resource] ( [ResourceDisplayName]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 444 of 1510 : Created [IX_CMS_Resource_ResourceDisplayName]';
    END;

GO

PRINT ' 445 of 1510 : Analyzing IX_CMS_Resource_ResourceName';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_Resource_ResourceName') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_CMS_Resource_ResourceName]
	   ON [dbo].[CMS_Resource] (  [ResourceName]  ASC) WITH (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 446 of 1510 : Created [IX_CMS_Resource_ResourceName]';
    END;

GO

PRINT ' 447 of 1510 : Analyzing IX_Notification_Gateway_GatewayDisplayName';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Notification_Gateway_GatewayDisplayName') --IS NULL
    BEGIN  CREATE CLUSTERED INDEX
		 [IX_Notification_Gateway_GatewayDisplayName]
		 ON [dbo].[Notification_Gateway] (  [GatewayDisplayName]  ASC) 
		 WITH
		 (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 448 of 1510 : Created [IX_Notification_Gateway_GatewayDisplayName]';
    END;

GO

PRINT ' 449 of 1510 : Analyzing IX_Export_History_ExportDateTime';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Export_History_ExportDateTime') 
    --IS NULL
    BEGIN
	   CREATE CLUSTERED INDEX
	   [IX_Export_History_ExportDateTime]
	   ON [dbo].[Export_History] (  [ExportDateTime] DESC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 450 of 1510 : Created [IX_Export_History_ExportDateTime]';
    END;

GO

PRINT ' 451 of 1510 : Analyzing IX_Export_History_ExportSiteID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Export_History_ExportSiteID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_Export_History_ExportSiteID]
	   ON [dbo].[Export_History] (  [ExportSiteID]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 452 of 1510 : Created [IX_Export_History_ExportSiteID]';
    END;

GO

PRINT ' 453 of 1510 : Analyzing IX_Export_History_ExportUserID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Export_History_ExportUserID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_Export_History_ExportUserID]
	   ON [dbo].[Export_History] (  [ExportUserID]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 454 of 1510 : Created [IX_Export_History_ExportUserID]';
    END;

GO

PRINT ' 455 of 1510 : Analyzing IX_Polls_Poll_PollSiteID_PollDisplayName';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Polls_Poll_PollSiteID_PollDisplayName') --IS NULL
    BEGIN CREATE CLUSTERED INDEX
		[IX_Polls_Poll_PollSiteID_PollDisplayName]
		ON [dbo].[Polls_Poll] (  [PollSiteID] ASC , [PollDisplayName]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 456 of 1510 : Created [IX_Polls_Poll_PollSiteID_PollDisplayName]';
    END;

GO

PRINT ' 457 of 1510 : Analyzing IX_Polls_Poll_PollSiteID_PollCodeName';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Polls_Poll_PollSiteID_PollCodeName') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[IX_Polls_Poll_PollSiteID_PollCodeName]
		ON [dbo].[Polls_Poll] (  [PollSiteID] ASC , [PollCodeName]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 458 of 1510 : Created [IX_Polls_Poll_PollSiteID_PollCodeName]';
    END;

GO

PRINT ' 459 of 1510 : Analyzing IX_Polls_Poll_PollGroupID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Polls_Poll_PollGroupID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_Polls_Poll_PollGroupID]
	   ON [dbo].[Polls_Poll] (  [PollGroupID]  ASC) 
	   WITH
	   ( PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 460 of 1510 : Created [IX_Polls_Poll_PollGroupID]';
    END;

GO

PRINT ' 461 of 1510 : Analyzing IX_HFit_SSISLoadDetail_1';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_HFit_SSISLoadDetail_1') 
    AND EXISTS (Select name 
				from sys.tables 
				where name = 'HFit_SSISLoadDetail')
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_HFit_SSISLoadDetail_1]
	   ON [dbo].[HFit_SSISLoadDetail] (  [SSISLoadID]  ASC) WITH (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 462 of 1510 : Created [IX_HFit_SSISLoadDetail_1]';
    END;

GO

PRINT ' 463 of 1510 : Analyzing IX_Community_GroupMember_MemberJoined';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Community_GroupMember_MemberJoined') --IS NULL
    BEGIN CREATE CLUSTERED INDEX
		[IX_Community_GroupMember_MemberJoined]
		ON [dbo].[Community_GroupMember] ( [MemberJoined] DESC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 464 of 1510 : Created [IX_Community_GroupMember_MemberJoined]';
    END;

GO

PRINT ' 465 of 1510 : Analyzing IX_Community_GroupMember_MemberUserID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Community_GroupMember_MemberUserID') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[IX_Community_GroupMember_MemberUserID]
		ON [dbo].[Community_GroupMember] ( [MemberUserID]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 466 of 1510 : Created [IX_Community_GroupMember_MemberUserID]';
    END;

GO

PRINT ' 467 of 1510 : Analyzing IX_Community_GroupMember_MemberGroupID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Community_GroupMember_MemberGroupID') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[IX_Community_GroupMember_MemberGroupID]
		ON [dbo].[Community_GroupMember] (  [MemberGroupID]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 468 of 1510 : Created [IX_Community_GroupMember_MemberGroupID]';
    END;

GO

PRINT ' 469 of 1510 : Analyzing IX_Community_GroupMember_MemberApprovedByUserID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Community_GroupMember_MemberApprovedByUserID') --IS NULL
    BEGIN  CREATE NONCLUSTERED INDEX
		 [IX_Community_GroupMember_MemberApprovedByUserID]
		 ON [dbo].[Community_GroupMember] (  [MemberApprovedByUserID]  ASC) 
		 WITH
		 (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 470 of 1510 : Created [IX_Community_GroupMember_MemberApprovedByUserID]';
    END;

GO

PRINT ' 471 of 1510 : Analyzing IX_Community_GroupMember_MemberInvitedByUserID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Community_GroupMember_MemberInvitedByUserID') --IS NULL
    BEGIN  CREATE NONCLUSTERED INDEX
		 [IX_Community_GroupMember_MemberInvitedByUserID]
		 ON [dbo].[Community_GroupMember] (  [MemberInvitedByUserID]  ASC) 
		 WITH
		 (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 472 of 1510 : Created [IX_Community_GroupMember_MemberInvitedByUserID]';
    END;

GO

PRINT ' 473 of 1510 : Analyzing IX_Community_GroupMember_MemberStatus';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Community_GroupMember_MemberStatus') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[IX_Community_GroupMember_MemberStatus]
		ON [dbo].[Community_GroupMember] ( [MemberStatus]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 474 of 1510 : Created [IX_Community_GroupMember_MemberStatus]';
    END;

GO

PRINT ' 475 of 1510 : Analyzing IX_COM_CurrencyExchangeRate_ExchangeRateToCurrencyID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_COM_CurrencyExchangeRate_ExchangeRateToCurrencyID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_COM_CurrencyExchangeRate_ExchangeRateToCurrencyID]
	   ON [dbo].[COM_CurrencyExchangeRate] ( [ExchangeRateToCurrencyID]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 476 of 1510 : Created [IX_COM_CurrencyExchangeRate_ExchangeRateToCurrencyID]';
    END;

GO

PRINT ' 477 of 1510 : Analyzing IX_COM_CurrencyExchangeRate_ExchangeTableID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_COM_CurrencyExchangeRate_ExchangeTableID') --IS NULL
    BEGIN  CREATE NONCLUSTERED INDEX
		 [IX_COM_CurrencyExchangeRate_ExchangeTableID]
		 ON [dbo].[COM_CurrencyExchangeRate] (  [ExchangeTableID]  ASC) 
		 WITH
		 (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 478 of 1510 : Created [IX_COM_CurrencyExchangeRate_ExchangeTableID]';
    END;

GO

GO
PRINT ' 479 of 1510 : Analyzing IX_Reporting_ReportCategory_CategoryPath';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Reporting_ReportCategory_CategoryPath') --IS NULL
    BEGIN CREATE  UNIQUE CLUSTERED INDEX
		[IX_Reporting_ReportCategory_CategoryPath]
		ON [dbo].[Reporting_ReportCategory] (  [CategoryPath]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 480 of 1510 : Created [IX_Reporting_ReportCategory_CategoryPath]';
    END;

GO

PRINT ' 481 of 1510 : Analyzing IX_Reporting_ReportCategory_CategoryParentID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Reporting_ReportCategory_CategoryParentID') --IS NULL
    BEGIN  CREATE NONCLUSTERED INDEX
		 [IX_Reporting_ReportCategory_CategoryParentID]
		 ON [dbo].[Reporting_ReportCategory] (  [CategoryParentID]  ASC) 
		 WITH
		 (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 482 of 1510 : Created [IX_Reporting_ReportCategory_CategoryParentID]';
    END;

GO

PRINT ' 483 of 1510 : Analyzing IX_PM_ProjectTask_ProjectTaskProjectID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_PM_ProjectTask_ProjectTaskProjectID') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[IX_PM_ProjectTask_ProjectTaskProjectID]
		ON [dbo].[PM_ProjectTask] ( [ProjectTaskProjectID]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 484 of 1510 : Created [IX_PM_ProjectTask_ProjectTaskProjectID]';
    END;

GO

PRINT ' 485 of 1510 : Analyzing IX_PM_ProjectTask_ProjectTaskStatusID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_PM_ProjectTask_ProjectTaskStatusID') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[IX_PM_ProjectTask_ProjectTaskStatusID]
		ON [dbo].[PM_ProjectTask] ( [ProjectTaskStatusID]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 486 of 1510 : Created [IX_PM_ProjectTask_ProjectTaskStatusID]';
    END;

GO

PRINT ' 487 of 1510 : Analyzing IX_PM_ProjectTask_ProjectTaskPriorityID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_PM_ProjectTask_ProjectTaskPriorityID') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[IX_PM_ProjectTask_ProjectTaskPriorityID]
		ON [dbo].[PM_ProjectTask] ( [ProjectTaskPriorityID]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 488 of 1510 : Created [IX_PM_ProjectTask_ProjectTaskPriorityID]';
    END;

GO

PRINT ' 489 of 1510 : Analyzing IX_PM_ProjectTask_ProjectTaskOwnerID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_PM_ProjectTask_ProjectTaskOwnerID') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[IX_PM_ProjectTask_ProjectTaskOwnerID]
		ON [dbo].[PM_ProjectTask] ( [ProjectTaskOwnerID]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 490 of 1510 : Created [IX_PM_ProjectTask_ProjectTaskOwnerID]';
    END;

GO

PRINT ' 491 of 1510 : Analyzing IX_PM_ProjectTask_ProjectTaskAssignedToUserID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_PM_ProjectTask_ProjectTaskAssignedToUserID') --IS NULL
    BEGIN  CREATE NONCLUSTERED INDEX
		 [IX_PM_ProjectTask_ProjectTaskAssignedToUserID]
		 ON [dbo].[PM_ProjectTask] (  [ProjectTaskAssignedToUserID]  ASC) 
		 WITH
		 (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 492 of 1510 : Created [IX_PM_ProjectTask_ProjectTaskAssignedToUserID]';
    END;

GO

GO
PRINT ' 493 of 1510 : Analyzing PI_HFIT_Tracker_LastUpdate';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'PI_HFit_TrackerFlexibility_LastUpdate') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [PI_HFit_TrackerFlexibility_LastUpdate]
	   ON [dbo].[HFit_TrackerFlexibility] (  [ItemCreatedWhen] ASC , [ItemModifiedWhen]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 494 of 1510 : Created [PI_HFit_TrackerFlexibility_LastUpdate]';
    END;

GO

PRINT ' 495 of 1510 : Analyzing PI_HFit_TrackerBloodPressure_LastUpdate';
GO

--If NOT EXISTS (Select Name
--	 FROM [sys].[Indexes]
--	 WHERE [Name] = 'PI_HFit_TrackerBloodPressure_LastUpdate') --IS NULL
--    BEGIN CREATE NONCLUSTERED INDEX
--		[PI_HFit_TrackerBloodPressure_LastUpdate]
--		ON [dbo].[HFit_TrackerFlexibility] (  [ItemCreatedWhen]  ASC , [ItemModifiedWhen]  ASC) 
--		WITH
--		( PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
--	   PRINT ' 496 of 1510 : Created [PI_HFit_TrackerBloodPressure_LastUpdate]';
--    END;
--GO
--PRINT (' 497 of 1510 : Analyzing PI_HFit_TrackerBloodSugarAndGlucose_LastUpdate');
--GO
--If NOT EXISTS (Select Name
--	 FROM [sys].[Indexes]
--	 WHERE [Name] = 'PI_HFit_TrackerBloodSugarAndGlucose_LastUpdate') --IS NULL
--    BEGIN  CREATE NONCLUSTERED INDEX
--		 [PI_HFit_TrackerBloodSugarAndGlucose_LastUpdate]
--		 ON [dbo].[HFit_TrackerFlexibility] (  [ItemCreatedWhen]  ASC , [ItemModifiedWhen]  ASC) 
--		 WITH
--		 ( PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
--	   PRINT ' 498 of 1510 : Created [PI_HFit_TrackerBloodSugarAndGlucose_LastUpdate]';
--    END;
--GO
--PRINT (' 499 of 1510 : Analyzing PI_HFit_TrackerBMI_LastUpdate');
--GO
--If NOT EXISTS (Select Name
--	 FROM [sys].[Indexes]
--	 WHERE [Name] = 'PI_HFit_TrackerBMI_LastUpdate') 
----IS NULL
--    BEGIN
--	   CREATE NONCLUSTERED INDEX
--	   [PI_HFit_TrackerBMI_LastUpdate]
--	   ON [dbo].[HFit_TrackerFlexibility] ( [ItemCreatedWhen]  ASC , [ItemModifiedWhen]  ASC) 
--	   WITH
--	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
--	   PRINT ' 500 of 1510 : Created [PI_HFit_TrackerBMI_LastUpdate]';
--    END;
--GO
--PRINT (' 501 of 1510 : Analyzing PI_HFit_TrackerBodyFat_LastUpdate');
--GO
--If NOT EXISTS (Select Name
--	 FROM [sys].[Indexes]
--	 WHERE [Name] = 'PI_HFit_TrackerBodyFat_LastUpdate') 
----IS NULL
--    BEGIN
--	   CREATE NONCLUSTERED INDEX
--	   [PI_HFit_TrackerBodyFat_LastUpdate]
--	   ON [dbo].[HFit_TrackerFlexibility] ( [ItemCreatedWhen]  ASC , [ItemModifiedWhen]  ASC) 
--	   WITH
--	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
--	   PRINT ' 502 of 1510 : Created [PI_HFit_TrackerBodyFat_LastUpdate]';
--    END;
--GO
--PRINT (' 503 of 1510 : Analyzing PI_HFit_TrackerBodyMeasurements_LastUpdate');
--GO
--If NOT EXISTS (Select Name
--	 FROM [sys].[Indexes]
--	 WHERE [Name] = 'PI_HFit_TrackerBodyMeasurements_LastUpdate') --IS NULL
--    BEGIN  CREATE NONCLUSTERED INDEX
--		 [PI_HFit_TrackerBodyMeasurements_LastUpdate]
--		 ON [dbo].[HFit_TrackerFlexibility] (  [ItemCreatedWhen]  ASC , [ItemModifiedWhen]  ASC) 
--		 WITH
--		 ( PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
--	   PRINT ' 504 of 1510 : Created [PI_HFit_TrackerBodyMeasurements_LastUpdate]';
--    END;
--GO
--PRINT (' 505 of 1510 : Analyzing PI_HFit_TrackerCardio_LastUpdate');
--GO
--If NOT EXISTS (Select Name
--	 FROM [sys].[Indexes]
--	 WHERE [Name] = 'PI_HFit_TrackerCardio_LastUpdate') 
----IS NULL
--    BEGIN
--	   CREATE NONCLUSTERED INDEX
--	   [PI_HFit_TrackerCardio_LastUpdate]
--	   ON [dbo].[HFit_TrackerFlexibility] ( [ItemCreatedWhen]  ASC , [ItemModifiedWhen]  ASC) 
--	   WITH
--	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
--	   PRINT ' 506 of 1510 : Created [PI_HFit_TrackerCardio_LastUpdate]';
--    END;
--GO
--PRINT (' 507 of 1510 : Analyzing PI_HFit_TrackerCategory_LastUpdate');
--GO
--If NOT EXISTS (Select Name
--	 FROM [sys].[Indexes]
--	 WHERE [Name] = 'PI_HFit_TrackerCategory_LastUpdate') --IS NULL
--    BEGIN CREATE NONCLUSTERED INDEX
--		[PI_HFit_TrackerCategory_LastUpdate]
--		ON [dbo].[HFit_TrackerFlexibility] ( [ItemCreatedWhen]  ASC , [ItemModifiedWhen]  ASC) 
--		WITH
--		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
--	   PRINT ' 508 of 1510 : Created [PI_HFit_TrackerCategory_LastUpdate]';
--    END;
--GO
--PRINT (' 509 of 1510 : Analyzing PI_HFit_TrackerCholesterol_LastUpdate');
--GO
--If NOT EXISTS (Select Name
--	 FROM [sys].[Indexes]
--	 WHERE [Name] = 'PI_HFit_TrackerCholesterol_LastUpdate') --IS NULL
--    BEGIN CREATE NONCLUSTERED INDEX
--		[PI_HFit_TrackerCholesterol_LastUpdate]
--		ON [dbo].[HFit_TrackerFlexibility] (  [ItemCreatedWhen]  ASC , [ItemModifiedWhen]  ASC) 
--		WITH
--		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
--	   PRINT ' 510 of 1510 : Created [PI_HFit_TrackerCholesterol_LastUpdate]';
--    END;
--GO
--PRINT (' 511 of 1510 : Analyzing PI_HFit_TrackerCollectionSource_LastUpdate');
--GO
--If NOT EXISTS (Select Name
--	 FROM [sys].[Indexes]
--	 WHERE [Name] = 'PI_HFit_TrackerCollectionSource_LastUpdate') --IS NULL
--    BEGIN  CREATE NONCLUSTERED INDEX
--		 [PI_HFit_TrackerCollectionSource_LastUpdate]
--		 ON [dbo].[HFit_TrackerFlexibility] (  [ItemCreatedWhen]  ASC , [ItemModifiedWhen]  ASC) 
--		 WITH
--		 ( PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
--	   PRINT ' 512 of 1510 : Created [PI_HFit_TrackerCollectionSource_LastUpdate]';
--    END;
--GO
--PRINT (' 513 of 1510 : Analyzing PI_HFit_TrackerDailySteps_LastUpdate');
--GO
--If NOT EXISTS (Select Name
--	 FROM [sys].[Indexes]
--	 WHERE [Name] = 'PI_HFit_TrackerDailySteps_LastUpdate') --IS NULL
--    BEGIN CREATE NONCLUSTERED INDEX
--		[PI_HFit_TrackerDailySteps_LastUpdate]
--		ON [dbo].[HFit_TrackerFlexibility] (  [ItemCreatedWhen]  ASC , [ItemModifiedWhen]  ASC) 
--		WITH
--		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
--	   PRINT ' 514 of 1510 : Created [PI_HFit_TrackerDailySteps_LastUpdate]';
--    END;
--GO
--PRINT (' 515 of 1510 : Analyzing PI_HFit_TrackerDef_Item_LastUpdate');
--GO
--If NOT EXISTS (Select Name
--	 FROM [sys].[Indexes]
--	 WHERE [Name] = 'PI_HFit_TrackerDef_Item_LastUpdate') --IS NULL
--    BEGIN CREATE NONCLUSTERED INDEX
--		[PI_HFit_TrackerDef_Item_LastUpdate]
--		ON [dbo].[HFit_TrackerFlexibility] ( [ItemCreatedWhen]  ASC , [ItemModifiedWhen]  ASC) 
--		WITH
--		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
--	   PRINT ' 516 of 1510 : Created [PI_HFit_TrackerDef_Item_LastUpdate]';
--    END;
--GO
--PRINT (' 517 of 1510 : Analyzing PI_HFit_TrackerDef_Tracker_LastUpdate');
--GO
--If NOT EXISTS (Select Name
--	 FROM [sys].[Indexes]
--	 WHERE [Name] = 'PI_HFit_TrackerDef_Tracker_LastUpdate') --IS NULL
--    BEGIN CREATE NONCLUSTERED INDEX
--		[PI_HFit_TrackerDef_Tracker_LastUpdate]
--		ON [dbo].[HFit_TrackerFlexibility] (  [ItemCreatedWhen]  ASC , [ItemModifiedWhen]  ASC) 
--		WITH
--		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
--	   PRINT ' 518 of 1510 : Created [PI_HFit_TrackerDef_Tracker_LastUpdate]';
--    END;
--GO
--PRINT (' 519 of 1510 : Analyzing PI_HFit_TrackerDocument_LastUpdate');
--GO
--If NOT EXISTS (Select Name
--	 FROM [sys].[Indexes]
--	 WHERE [Name] = 'PI_HFit_TrackerDocument_LastUpdate') --IS NULL
--    BEGIN CREATE NONCLUSTERED INDEX
--		[PI_HFit_TrackerDocument_LastUpdate]
--		ON [dbo].[HFit_TrackerFlexibility] ( [ItemCreatedWhen]  ASC , [ItemModifiedWhen]  ASC) 
--		WITH
--		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
--	   PRINT ' 520 of 1510 : Created [PI_HFit_TrackerDocument_LastUpdate]';
--    END;
--GO
--PRINT (' 521 of 1510 : Analyzing PI_HFit_TrackerFlexibility_LastUpdate');
--GO
--If NOT EXISTS (Select Name
--	 FROM [sys].[Indexes]
--	 WHERE [Name] = 'PI_HFit_TrackerFlexibility_LastUpdate') --IS NULL
--    BEGIN CREATE NONCLUSTERED INDEX
--		[PI_HFit_TrackerFlexibility_LastUpdate]
--		ON [dbo].[HFit_TrackerFlexibility] (  [ItemCreatedWhen]  ASC , [ItemModifiedWhen]  ASC) 
--		WITH
--		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
--	   PRINT ' 522 of 1510 : Created [PI_HFit_TrackerFlexibility_LastUpdate]';
--    END;
--GO
--PRINT (' 523 of 1510 : Analyzing PI_HFit_TrackerFruits_LastUpdate');
--GO
--If NOT EXISTS (Select Name
--	 FROM [sys].[Indexes]
--	 WHERE [Name] = 'PI_HFit_TrackerFruits_LastUpdate') 
----IS NULL
--    BEGIN
--	   CREATE NONCLUSTERED INDEX
--	   [PI_HFit_TrackerFruits_LastUpdate]
--	   ON [dbo].[HFit_TrackerFlexibility] ( [ItemCreatedWhen]  ASC , [ItemModifiedWhen]  ASC) 
--	   WITH
--	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
--	   PRINT ' 524 of 1510 : Created [PI_HFit_TrackerFruits_LastUpdate]';
--    END;
--GO
--PRINT (' 525 of 1510 : Analyzing PI_HFit_TrackerHbA1c_LastUpdate');
--GO
--If NOT EXISTS (Select Name
--	 FROM [sys].[Indexes]
--	 WHERE [Name] = 'PI_HFit_TrackerHbA1c_LastUpdate') 
----IS NULL
--    BEGIN
--	   CREATE NONCLUSTERED INDEX
--	   [PI_HFit_TrackerHbA1c_LastUpdate]
--	   ON [dbo].[HFit_TrackerFlexibility] ( [ItemCreatedWhen]  ASC , [ItemModifiedWhen]  ASC) 
--	   WITH
--	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
--	   PRINT ' 526 of 1510 : Created [PI_HFit_TrackerHbA1c_LastUpdate]';
--    END;
--GO
--PRINT (' 527 of 1510 : Analyzing PI_HFit_TrackerHeight_LastUpdate');
--GO
--If NOT EXISTS (Select Name
--	 FROM [sys].[Indexes]
--	 WHERE [Name] = 'PI_HFit_TrackerHeight_LastUpdate') 
----IS NULL
--    BEGIN
--	   CREATE NONCLUSTERED INDEX
--	   [PI_HFit_TrackerHeight_LastUpdate]
--	   ON [dbo].[HFit_TrackerFlexibility] ( [ItemCreatedWhen]  ASC , [ItemModifiedWhen]  ASC) 
--	   WITH
--	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
--	   PRINT ' 528 of 1510 : Created [PI_HFit_TrackerHeight_LastUpdate]';
--    END;
--GO
--PRINT (' 529 of 1510 : Analyzing PI_HFit_TrackerHighFatFoods_LastUpdate');
--GO
--If NOT EXISTS (Select Name
--	 FROM [sys].[Indexes]
--	 WHERE [Name] = 'PI_HFit_TrackerHighFatFoods_LastUpdate') --IS NULL
--    BEGIN CREATE NONCLUSTERED INDEX
--		[PI_HFit_TrackerHighFatFoods_LastUpdate]
--		ON [dbo].[HFit_TrackerFlexibility] (  [ItemCreatedWhen]  ASC , [ItemModifiedWhen]  ASC) 
--		WITH
--		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
--	   PRINT ' 530 of 1510 : Created [PI_HFit_TrackerHighFatFoods_LastUpdate]';
--    END;
--GO
--PRINT (' 531 of 1510 : Analyzing PI_HFit_TrackerHighSodiumFoods_LastUpdate');
--GO
--If NOT EXISTS (Select Name
--	 FROM [sys].[Indexes]
--	 WHERE [Name] = 'PI_HFit_TrackerHighSodiumFoods_LastUpdate') --IS NULL
--    BEGIN  CREATE NONCLUSTERED INDEX
--		 [PI_HFit_TrackerHighSodiumFoods_LastUpdate]
--		 ON [dbo].[HFit_TrackerFlexibility] (  [ItemCreatedWhen]  ASC , [ItemModifiedWhen]  ASC) 
--		 WITH
--		 ( PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
--	   PRINT ' 532 of 1510 : Created [PI_HFit_TrackerHighSodiumFoods_LastUpdate]';
--    END;
--GO
--PRINT (' 533 of 1510 : Analyzing PI_HFit_TrackerInstance_Item_LastUpdate');
--GO
--If NOT EXISTS (Select Name
--	 FROM [sys].[Indexes]
--	 WHERE [Name] = 'PI_HFit_TrackerInstance_Item_LastUpdate') --IS NULL
--    BEGIN CREATE NONCLUSTERED INDEX
--		[PI_HFit_TrackerInstance_Item_LastUpdate]
--		ON [dbo].[HFit_TrackerFlexibility] (  [ItemCreatedWhen]  ASC , [ItemModifiedWhen]  ASC) 
--		WITH
--		( PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
--	   PRINT ' 534 of 1510 : Created [PI_HFit_TrackerInstance_Item_LastUpdate]';
--    END;
--GO
--PRINT (' 535 of 1510 : Analyzing PI_HFit_TrackerInstance_Tracker_LastUpdate');
--GO
--If NOT EXISTS (Select Name
--	 FROM [sys].[Indexes]
--	 WHERE [Name] = 'PI_HFit_TrackerInstance_Tracker_LastUpdate') --IS NULL
--    BEGIN  CREATE NONCLUSTERED INDEX
--		 [PI_HFit_TrackerInstance_Tracker_LastUpdate]
--		 ON [dbo].[HFit_TrackerFlexibility] (  [ItemCreatedWhen]  ASC , [ItemModifiedWhen]  ASC) 
--		 WITH
--		 ( PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
--	   PRINT ' 536 of 1510 : Created [PI_HFit_TrackerInstance_Tracker_LastUpdate]';
--    END;
--GO
--PRINT (' 537 of 1510 : Analyzing PI_HFit_TrackerMealPortions_LastUpdate');
--GO
--If NOT EXISTS (Select Name
--	 FROM [sys].[Indexes]
--	 WHERE [Name] = 'PI_HFit_TrackerMealPortions_LastUpdate') --IS NULL
--    BEGIN CREATE NONCLUSTERED INDEX
--		[PI_HFit_TrackerMealPortions_LastUpdate]
--		ON [dbo].[HFit_TrackerFlexibility] (  [ItemCreatedWhen]  ASC , [ItemModifiedWhen]  ASC) 
--		WITH
--		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
--	   PRINT ' 538 of 1510 : Created [PI_HFit_TrackerMealPortions_LastUpdate]';
--    END;
--GO
PRINT ' 539 of 1510 : Analyzing PI_HFit_TrackerMedicalCarePlan_LastUpdate';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'PI_HFit_TrackerMedicalCarePlan_LastUpdate') --IS NULL
    BEGIN  CREATE NONCLUSTERED INDEX
		 [PI_HFit_TrackerMedicalCarePlan_LastUpdate]
		 ON [dbo].[HFit_TrackerFlexibility] (  [ItemCreatedWhen]  ASC , [ItemModifiedWhen]  ASC) 
		 WITH
		 ( PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 540 of 1510 : Created [PI_HFit_TrackerMedicalCarePlan_LastUpdate]';
    END;

GO

PRINT ' 541 of 1510 : Analyzing PI_HFit_TrackerRegularMeals_LastUpdate';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'PI_HFit_TrackerRegularMeals_LastUpdate') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[PI_HFit_TrackerRegularMeals_LastUpdate]
		ON [dbo].[HFit_TrackerFlexibility] (  [ItemCreatedWhen]  ASC , [ItemModifiedWhen]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 542 of 1510 : Created [PI_HFit_TrackerRegularMeals_LastUpdate]';
    END;

GO

PRINT ' 543 of 1510 : Analyzing PI_HFit_TrackerRestingHeartRate_LastUpdate';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'PI_HFit_TrackerRestingHeartRate_LastUpdate') --IS NULL
    BEGIN  CREATE NONCLUSTERED INDEX
		 [PI_HFit_TrackerRestingHeartRate_LastUpdate]
		 ON [dbo].[HFit_TrackerFlexibility] (  [ItemCreatedWhen]  ASC , [ItemModifiedWhen]  ASC) 
		 WITH
		 ( PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 544 of 1510 : Created [PI_HFit_TrackerRestingHeartRate_LastUpdate]';
    END;

GO

PRINT ' 545 of 1510 : Analyzing PI_HFit_TrackerShots_LastUpdate';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'PI_HFit_TrackerShots_LastUpdate') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [PI_HFit_TrackerShots_LastUpdate]
	   ON [dbo].[HFit_TrackerFlexibility] ( [ItemCreatedWhen]  ASC , [ItemModifiedWhen]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 546 of 1510 : Created [PI_HFit_TrackerShots_LastUpdate]';
    END;

GO

PRINT ' 547 of 1510 : Analyzing PI_HFit_TrackerSitLess_LastUpdate';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'PI_HFit_TrackerSitLess_LastUpdate') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [PI_HFit_TrackerSitLess_LastUpdate]
	   ON [dbo].[HFit_TrackerFlexibility] ( [ItemCreatedWhen]  ASC , [ItemModifiedWhen]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 548 of 1510 : Created [PI_HFit_TrackerSitLess_LastUpdate]';
    END;

GO

PRINT ' 549 of 1510 : Analyzing PI_HFit_TrackerSleepPlan_LastUpdate';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'PI_HFit_TrackerSleepPlan_LastUpdate') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[PI_HFit_TrackerSleepPlan_LastUpdate]
		ON [dbo].[HFit_TrackerFlexibility] ( [ItemCreatedWhen]  ASC , [ItemModifiedWhen]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 550 of 1510 : Created [PI_HFit_TrackerSleepPlan_LastUpdate]';
    END;

GO

PRINT ' 551 of 1510 : Analyzing PI_HFit_TrackerStrength_LastUpdate';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'PI_HFit_TrackerStrength_LastUpdate') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[PI_HFit_TrackerStrength_LastUpdate]
		ON [dbo].[HFit_TrackerFlexibility] ( [ItemCreatedWhen]  ASC , [ItemModifiedWhen]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 552 of 1510 : Created [PI_HFit_TrackerStrength_LastUpdate]';
    END;

GO

PRINT ' 553 of 1510 : Analyzing PI_HFit_TrackerStress_LastUpdate';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'PI_HFit_TrackerStress_LastUpdate') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [PI_HFit_TrackerStress_LastUpdate]
	   ON [dbo].[HFit_TrackerFlexibility] ( [ItemCreatedWhen]  ASC , [ItemModifiedWhen]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 554 of 1510 : Created [PI_HFit_TrackerStress_LastUpdate]';
    END;

GO

PRINT ' 555 of 1510 : Analyzing PI_HFit_TrackerStressManagement_LastUpdate';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'PI_HFit_TrackerStressManagement_LastUpdate') --IS NULL
    BEGIN  CREATE NONCLUSTERED INDEX
		 [PI_HFit_TrackerStressManagement_LastUpdate]
		 ON [dbo].[HFit_TrackerFlexibility] (  [ItemCreatedWhen]  ASC , [ItemModifiedWhen]  ASC) 
		 WITH
		 ( PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 556 of 1510 : Created [PI_HFit_TrackerStressManagement_LastUpdate]';
    END;

GO

PRINT ' 557 of 1510 : Analyzing PI_HFit_TrackerSugaryDrinks_LastUpdate';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'PI_HFit_TrackerSugaryDrinks_LastUpdate') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[PI_HFit_TrackerSugaryDrinks_LastUpdate]
		ON [dbo].[HFit_TrackerFlexibility] (  [ItemCreatedWhen]  ASC , [ItemModifiedWhen]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 558 of 1510 : Created [PI_HFit_TrackerSugaryDrinks_LastUpdate]';
    END;

GO

PRINT ' 559 of 1510 : Analyzing PI_HFit_TrackerSugaryFoods_LastUpdate';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'PI_HFit_TrackerSugaryFoods_LastUpdate') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[PI_HFit_TrackerSugaryFoods_LastUpdate]
		ON [dbo].[HFit_TrackerFlexibility] (  [ItemCreatedWhen]  ASC , [ItemModifiedWhen]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 560 of 1510 : Created [PI_HFit_TrackerSugaryFoods_LastUpdate]';
    END;

GO

PRINT ' 561 of 1510 : Analyzing PI_HFit_TrackerSummary_LastUpdate';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'PI_HFit_TrackerSummary_LastUpdate') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [PI_HFit_TrackerSummary_LastUpdate]
	   ON [dbo].[HFit_TrackerFlexibility] ( [ItemCreatedWhen]  ASC , [ItemModifiedWhen]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 562 of 1510 : Created [PI_HFit_TrackerSummary_LastUpdate]';
    END;

GO

PRINT ' 563 of 1510 : Analyzing PI_HFit_TrackerTests_LastUpdate';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'PI_HFit_TrackerTests_LastUpdate') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [PI_HFit_TrackerTests_LastUpdate]
	   ON [dbo].[HFit_TrackerFlexibility] ( [ItemCreatedWhen]  ASC , [ItemModifiedWhen]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 564 of 1510 : Created [PI_HFit_TrackerTests_LastUpdate]';
    END;

GO

PRINT ' 565 of 1510 : Analyzing PI_HFit_TrackerTobaccoFree_LastUpdate';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'PI_HFit_TrackerTobaccoFree_LastUpdate') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[PI_HFit_TrackerTobaccoFree_LastUpdate]
		ON [dbo].[HFit_TrackerFlexibility] (  [ItemCreatedWhen]  ASC , [ItemModifiedWhen]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 566 of 1510 : Created [PI_HFit_TrackerTobaccoFree_LastUpdate]';
    END;

GO

PRINT ' 567 of 1510 : Analyzing PI_HFit_TrackerVegetables_LastUpdate';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'PI_HFit_TrackerVegetables_LastUpdate') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[PI_HFit_TrackerVegetables_LastUpdate]
		ON [dbo].[HFit_TrackerFlexibility] (  [ItemCreatedWhen]  ASC , [ItemModifiedWhen]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 568 of 1510 : Created [PI_HFit_TrackerVegetables_LastUpdate]';
    END;

GO

PRINT ' 569 of 1510 : Analyzing PI_HFit_TrackerWater_LastUpdate';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'PI_HFit_TrackerWater_LastUpdate') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [PI_HFit_TrackerWater_LastUpdate]
	   ON [dbo].[HFit_TrackerFlexibility] ( [ItemCreatedWhen]  ASC , [ItemModifiedWhen]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 570 of 1510 : Created [PI_HFit_TrackerWater_LastUpdate]';
    END;

GO

PRINT ' 571 of 1510 : Analyzing PI_HFit_TrackerWeight_LastUpdate';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'PI_HFit_TrackerWeight_LastUpdate') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [PI_HFit_TrackerWeight_LastUpdate]
	   ON [dbo].[HFit_TrackerFlexibility] ( [ItemCreatedWhen]  ASC , [ItemModifiedWhen]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 572 of 1510 : Created [PI_HFit_TrackerWeight_LastUpdate]';
    END;

GO

PRINT ' 573 of 1510 : Analyzing PI_HFit_TrackerWholeGrains_LastUpdate';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'PI_HFit_TrackerWholeGrains_LastUpdate') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[PI_HFit_TrackerWholeGrains_LastUpdate]
		ON [dbo].[HFit_TrackerFlexibility] (  [ItemCreatedWhen]  ASC , [ItemModifiedWhen]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 574 of 1510 : Created [PI_HFit_TrackerWholeGrains_LastUpdate]';
    END;

GO

PRINT ' 575 of 1510 : Analyzing idx_HFit_TrackerFlexibility_CreateDate';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'idx_HFit_TrackerFlexibility_CreateDate') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[idx_HFit_TrackerFlexibility_CreateDate]
		ON [dbo].[HFit_TrackerFlexibility] (  [ItemCreatedWhen]  ASC , [ItemModifiedWhen]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 576 of 1510 : Created [idx_HFit_TrackerFlexibility_CreateDate]';
    END;

GO

PRINT ' 577 of 1510 : Analyzing IX_Community_Group_GroupDisplayName';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Community_Group_GroupDisplayName') --IS NULL
    BEGIN CREATE CLUSTERED INDEX
		[IX_Community_Group_GroupDisplayName]
		ON [dbo].[Community_Group] ( [GroupSiteID]  ASC , [GroupDisplayName]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 578 of 1510 : Created [IX_Community_Group_GroupDisplayName]';
    END;

GO

PRINT ' 579 of 1510 : Analyzing IX_Community_Group_GroupSiteID_GroupName';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Community_Group_GroupSiteID_GroupName') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[IX_Community_Group_GroupSiteID_GroupName]
		ON [dbo].[Community_Group] ( [GroupSiteID]  ASC , [GroupName]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 580 of 1510 : Created [IX_Community_Group_GroupSiteID_GroupName]';
    END;

GO

PRINT ' 581 of 1510 : Analyzing IX_Community_Group_GroupCreatedByUserID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Community_Group_GroupCreatedByUserID') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[IX_Community_Group_GroupCreatedByUserID]
		ON [dbo].[Community_Group] ( [GroupCreatedByUserID]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 582 of 1510 : Created [IX_Community_Group_GroupCreatedByUserID]';
    END;

GO

PRINT ' 583 of 1510 : Analyzing IX_Community_Group_GroupApprovedByUserID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Community_Group_GroupApprovedByUserID') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[IX_Community_Group_GroupApprovedByUserID]
		ON [dbo].[Community_Group] ( [GroupApprovedByUserID]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 584 of 1510 : Created [IX_Community_Group_GroupApprovedByUserID]';
    END;

GO

PRINT ' 585 of 1510 : Analyzing IX_Community_Group_GroupAvatarID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Community_Group_GroupAvatarID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_Community_Group_GroupAvatarID]
	   ON [dbo].[Community_Group] (  [GroupAvatarID] ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 586 of 1510 : Created [IX_Community_Group_GroupAvatarID]';
    END;

GO

PRINT ' 587 of 1510 : Analyzing IX_Community_Group_GroupApproved';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Community_Group_GroupApproved') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_Community_Group_GroupApproved]
	   ON [dbo].[Community_Group] (  [GroupApproved] ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 588 of 1510 : Created [IX_Community_Group_GroupApproved]';
    END;

GO

PRINT ' 589 of 1510 : Analyzing IX_Reporting_ReportSubscription_ReportSubscriptionReportID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Reporting_ReportSubscription_ReportSubscriptionReportID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_Reporting_ReportSubscription_ReportSubscriptionReportID]
	   ON [dbo].[Reporting_ReportSubscription] (  [ReportSubscriptionReportID]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 590 of 1510 : Created [IX_Reporting_ReportSubscription_ReportSubscriptionReportID]';
    END;

GO

PRINT ' 591 of 1510 : Analyzing IX_Reporting_ReportSubscription_ReportSubscriptionGraphID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Reporting_ReportSubscription_ReportSubscriptionGraphID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_Reporting_ReportSubscription_ReportSubscriptionGraphID]
	   ON [dbo].[Reporting_ReportSubscription] (  [ReportSubscriptionGraphID]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 592 of 1510 : Created [IX_Reporting_ReportSubscription_ReportSubscriptionGraphID]';
    END;

GO

PRINT ' 593 of 1510 : Analyzing IX_Reporting_ReportSubscription_ReportSubscriptionTableID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Reporting_ReportSubscription_ReportSubscriptionTableID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_Reporting_ReportSubscription_ReportSubscriptionTableID]
	   ON [dbo].[Reporting_ReportSubscription] (  [ReportSubscriptionTableID]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 594 of 1510 : Created [IX_Reporting_ReportSubscription_ReportSubscriptionTableID]';
    END;

GO

PRINT ' 595 of 1510 : Analyzing IX_Reporting_ReportSubscription_ReportSubscriptionValueID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Reporting_ReportSubscription_ReportSubscriptionValueID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_Reporting_ReportSubscription_ReportSubscriptionValueID]
	   ON [dbo].[Reporting_ReportSubscription] (  [ReportSubscriptionValueID]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 596 of 1510 : Created [IX_Reporting_ReportSubscription_ReportSubscriptionValueID]';
    END;

GO

PRINT ' 597 of 1510 : Analyzing IX_Reporting_ReportSubscription_ReportSubscriptionSiteID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Reporting_ReportSubscription_ReportSubscriptionSiteID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_Reporting_ReportSubscription_ReportSubscriptionSiteID]
	   ON [dbo].[Reporting_ReportSubscription] ( [ReportSubscriptionSiteID]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 598 of 1510 : Created [IX_Reporting_ReportSubscription_ReportSubscriptionSiteID]';
    END;

GO

PRINT ' 599 of 1510 : Analyzing IX_CMS_TranslationSubmission';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_TranslationSubmission') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_CMS_TranslationSubmission]
	   ON [dbo].[CMS_TranslationSubmission] ( [SubmissionID]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 600 of 1510 : Created [IX_CMS_TranslationSubmission]';
    END;

GO

PRINT ' 601 of 1510 : Analyzing IX_CMS_TimeZone_TimeZoneDisplayName';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_TimeZone_TimeZoneDisplayName') --IS NULL
    BEGIN CREATE CLUSTERED INDEX
		[IX_CMS_TimeZone_TimeZoneDisplayName]
		ON [dbo].[CMS_TimeZone] ( [TimeZoneDisplayName]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 602 of 1510 : Created [IX_CMS_TimeZone_TimeZoneDisplayName]';
    END;

GO

PRINT ' 603 of 1510 : Analyzing IX_CMS_WebPartCategory_CategoryPath';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_WebPartCategory_CategoryPath') --IS NULL
    BEGIN CREATE  UNIQUE CLUSTERED INDEX
		[IX_CMS_WebPartCategory_CategoryPath]
		ON [dbo].[CMS_WebPartCategory] (  [CategoryPath]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 604 of 1510 : Created [IX_CMS_WebPartCategory_CategoryPath]';
    END;

GO

PRINT ' 605 of 1510 : Analyzing IX_CMS_WebPartCategory_CategoryParentID_CategoryOrder';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_WebPartCategory_CategoryParentID_CategoryOrder') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_CMS_WebPartCategory_CategoryParentID_CategoryOrder]
	   ON [dbo].[CMS_WebPartCategory] ( [CategoryParentID]  ASC , [CategoryOrder]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 606 of 1510 : Created [IX_CMS_WebPartCategory_CategoryParentID_CategoryOrder]';
    END;

GO

GO
PRINT ' 607 of 1510 : Analyzing IX_PM_Project_ProjectNodeID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_PM_Project_ProjectNodeID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_PM_Project_ProjectNodeID]
	   ON [dbo].[PM_Project] (  [ProjectNodeID]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 608 of 1510 : Created [IX_PM_Project_ProjectNodeID]';
    END;

GO

PRINT ' 609 of 1510 : Analyzing IX_PM_Project_ProjectGroupID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_PM_Project_ProjectGroupID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_PM_Project_ProjectGroupID]
	   ON [dbo].[PM_Project] (  [ProjectGroupID]  ASC) WITH (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 610 of 1510 : Created [IX_PM_Project_ProjectGroupID]';
    END;

GO

PRINT ' 611 of 1510 : Analyzing IX_PM_Project_ProjectOwner';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_PM_Project_ProjectOwner') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_PM_Project_ProjectOwner]
	   ON [dbo].[PM_Project] (  [ProjectOwner]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 612 of 1510 : Created [IX_PM_Project_ProjectOwner]';
    END;

GO

PRINT ' 613 of 1510 : Analyzing IX_PM_Project_ProjectStatusID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_PM_Project_ProjectStatusID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_PM_Project_ProjectStatusID]
	   ON [dbo].[PM_Project] (  [ProjectStatusID]  ASC) WITH (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 614 of 1510 : Created [IX_PM_Project_ProjectStatusID]';
    END;

GO

PRINT ' 615 of 1510 : Analyzing IX_PM_Project_ProjectSiteID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_PM_Project_ProjectSiteID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_PM_Project_ProjectSiteID]
	   ON [dbo].[PM_Project] (  [ProjectSiteID]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 616 of 1510 : Created [IX_PM_Project_ProjectSiteID]';
    END;

GO

PRINT ' 617 of 1510 : Analyzing IX_Blog_Comment_CommentDate';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Blog_Comment_CommentDate') 
    --IS NULL
    BEGIN
	   CREATE CLUSTERED INDEX
	   [IX_Blog_Comment_CommentDate]
	   ON [dbo].[Blog_Comment] (  [CommentDate] DESC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 618 of 1510 : Created [IX_Blog_Comment_CommentDate]';
    END;

GO

PRINT ' 619 of 1510 : Analyzing IX_Blog_Comment_CommentUserID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Blog_Comment_CommentUserID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_Blog_Comment_CommentUserID]
	   ON [dbo].[Blog_Comment] (  [CommentUserID]  ASC) WITH (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 620 of 1510 : Created [IX_Blog_Comment_CommentUserID]';
    END;

GO

PRINT ' 621 of 1510 : Analyzing IX_Blog_Comment_CommentApprovedByUserID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Blog_Comment_CommentApprovedByUserID') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[IX_Blog_Comment_CommentApprovedByUserID]
		ON [dbo].[Blog_Comment] ( [CommentApprovedByUserID]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 622 of 1510 : Created [IX_Blog_Comment_CommentApprovedByUserID]';
    END;

GO

PRINT ' 623 of 1510 : Analyzing IX_Blog_Comment_CommentPostDocumentID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Blog_Comment_CommentPostDocumentID') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[IX_Blog_Comment_CommentPostDocumentID]
		ON [dbo].[Blog_Comment] ( [CommentPostDocumentID]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 624 of 1510 : Created [IX_Blog_Comment_CommentPostDocumentID]';
    END;

GO

PRINT ' 625 of 1510 : Analyzing IX_Blog_Comment_CommentIsSpam_CommentIsApproved_CommentIsTrackback';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Blog_Comment_CommentIsSpam_CommentIsApproved_CommentIsTrackback') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_Blog_Comment_CommentIsSpam_CommentIsApproved_CommentIsTrackback]
	   ON [dbo].[Blog_Comment] (  [CommentIsSpam]  ASC , [CommentApproved]  ASC , [CommentIsTrackBack]  ASC) WITH (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 626 of 1510 : Created [IX_Blog_Comment_CommentIsSpam_CommentIsApproved_CommentIsTrackback]';
    END;

GO

PRINT ' 627 of 1510 : Analyzing IX_Forums_UserFavorites_UserID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Forums_UserFavorites_UserID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_Forums_UserFavorites_UserID]
	   ON [dbo].[Forums_UserFavorites] (  [UserID]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 628 of 1510 : Created [IX_Forums_UserFavorites_UserID]';
    END;

GO

PRINT ' 629 of 1510 : Analyzing IX_Forums_UserFavorites_UserID_PostID_ForumID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Forums_UserFavorites_UserID_PostID_ForumID') --IS NULL
    BEGIN  CREATE  UNIQUE NONCLUSTERED INDEX
		 [IX_Forums_UserFavorites_UserID_PostID_ForumID]
		 ON [dbo].[Forums_UserFavorites] (  [UserID]  ASC , [PostID]  ASC , [ForumID]  ASC) 
		 WITH
		 (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 630 of 1510 : Created [IX_Forums_UserFavorites_UserID_PostID_ForumID]';
    END;

GO

PRINT ' 631 of 1510 : Analyzing IX_Forums_UserFavorites_PostID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Forums_UserFavorites_PostID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_Forums_UserFavorites_PostID]
	   ON [dbo].[Forums_UserFavorites] (  [PostID]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 632 of 1510 : Created [IX_Forums_UserFavorites_PostID]';
    END;

GO

PRINT ' 633 of 1510 : Analyzing IX_Forums_UserFavorites_ForumID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Forums_UserFavorites_ForumID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_Forums_UserFavorites_ForumID]
	   ON [dbo].[Forums_UserFavorites] (  [ForumID]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 634 of 1510 : Created [IX_Forums_UserFavorites_ForumID]';
    END;

GO

PRINT ' 635 of 1510 : Analyzing IX_Forums_UserFavorites_SiteID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Forums_UserFavorites_SiteID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_Forums_UserFavorites_SiteID]
	   ON [dbo].[Forums_UserFavorites] (  [SiteID]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 636 of 1510 : Created [IX_Forums_UserFavorites_SiteID]';
    END;

GO

PRINT ' 637 of 1510 : Analyzing IX_HFit_HealthAssessmentImportStagingDetail_1';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_HFit_HealthAssessmentImportStagingDetail_1') --IS NULL
    BEGIN  CREATE NONCLUSTERED INDEX
		 [IX_HFit_HealthAssessmentImportStagingDetail_1]
		 ON [dbo].[HFit_HealthAssessmentImportStagingDetail] (  [MasterID]  ASC , [CodeNameType]  ASC) INCLUDE ([QuestionCodeName] , [AnswerValue] , [AnswerCodeName] , [IsProfessionallyCollected] , Timestamp) WITH (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 638 of 1510 : Created [IX_HFit_HealthAssessmentImportStagingDetail_1]';
    END;

GO

PRINT ' 639 of 1510 : Analyzing IX_HFit_HealthAssessmentImportStagingDetail_2';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_HFit_HealthAssessmentImportStagingDetail_2') --IS NULL
    BEGIN  CREATE NONCLUSTERED INDEX
		 [IX_HFit_HealthAssessmentImportStagingDetail_2]
		 ON [dbo].[HFit_HealthAssessmentImportStagingDetail] (  [CodeNameType]  ASC , [QuestionCodeName]  ASC , [IsProfessionallyCollected]  ASC) INCLUDE ( [MasterID] , [AnswerValue] , Timestamp) WITH ( PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 640 of 1510 : Created [IX_HFit_HealthAssessmentImportStagingDetail_2]';
    END;

GO

PRINT ' 641 of 1510 : Analyzing IX_CMS_Category_CategoryDisplayName_CategoryEnabled';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_Category_CategoryDisplayName_CategoryEnabled') 
    --IS NULL
    BEGIN
	   CREATE CLUSTERED INDEX
	   [IX_CMS_Category_CategoryDisplayName_CategoryEnabled]
	   ON [dbo].[CMS_Category] (  [CategoryDisplayName] ASC , [CategoryEnabled]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 642 of 1510 : Created [IX_CMS_Category_CategoryDisplayName_CategoryEnabled]';
    END;

GO

PRINT ' 643 of 1510 : Analyzing IX_CMS_Category_CategoryUserID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_Category_CategoryUserID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_CMS_Category_CategoryUserID]
	   ON [dbo].[CMS_Category] (  [CategoryUserID]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 644 of 1510 : Created [IX_CMS_Category_CategoryUserID]';
    END;

GO

PRINT ' 645 of 1510 : Analyzing IX_Community_Invitation_InvitedUserID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Community_Invitation_InvitedUserID') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[IX_Community_Invitation_InvitedUserID]
		ON [dbo].[Community_Invitation] ( [InvitedUserID]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 646 of 1510 : Created [IX_Community_Invitation_InvitedUserID]';
    END;

GO

PRINT ' 647 of 1510 : Analyzing IX_Community_Invitation_InvitedByUserID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Community_Invitation_InvitedByUserID') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[IX_Community_Invitation_InvitedByUserID]
		ON [dbo].[Community_Invitation] (  [InvitedByUserID]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 648 of 1510 : Created [IX_Community_Invitation_InvitedByUserID]';
    END;

GO

PRINT ' 649 of 1510 : Analyzing IX_Community_Invitation_InvitationGroupID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Community_Invitation_InvitationGroupID') --IS NULL
    BEGIN  CREATE NONCLUSTERED INDEX
		 [IX_Community_Invitation_InvitationGroupID]
		 ON [dbo].[Community_Invitation] (  [InvitationGroupID]  ASC) 
		 WITH
		 (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 650 of 1510 : Created [IX_Community_Invitation_InvitationGroupID]';
    END;

GO

PRINT ' 651 of 1510 : Analyzing idx_HFit_TrackerBodyFat_CreateDate';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'idx_HFit_TrackerBodyFat_CreateDate') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[idx_HFit_TrackerBodyFat_CreateDate]
		ON [dbo].[HFit_TrackerBodyFat] ( [ItemCreatedWhen]  ASC , [ItemModifiedWhen]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 652 of 1510 : Created [idx_HFit_TrackerBodyFat_CreateDate]';
    END;

GO

PRINT ' 653 of 1510 : Analyzing IX_CMS_WebPartContainer_ContainerDisplayName';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_WebPartContainer_ContainerDisplayName') --IS NULL
    BEGIN  CREATE CLUSTERED INDEX
		 [IX_CMS_WebPartContainer_ContainerDisplayName]
		 ON [dbo].[CMS_WebPartContainer] (  [ContainerDisplayName]  ASC) 
		 WITH
		 (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 654 of 1510 : Created [IX_CMS_WebPartContainer_ContainerDisplayName]';
    END;

GO

PRINT ' 655 of 1510 : Analyzing IX_CMS_WebPartContainer_ContainerName';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_WebPartContainer_ContainerName') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[IX_CMS_WebPartContainer_ContainerName]
		ON [dbo].[CMS_WebPartContainer] ( [ContainerName]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 656 of 1510 : Created [IX_CMS_WebPartContainer_ContainerName]';
    END;

GO

PRINT ' 657 of 1510 : Analyzing IX_Reporting_Report_ReportCategoryID_ReportDisplayName';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Reporting_Report_ReportCategoryID_ReportDisplayName') 
    --IS NULL
    BEGIN
	   CREATE CLUSTERED INDEX
	   [IX_Reporting_Report_ReportCategoryID_ReportDisplayName]
	   ON [dbo].[Reporting_Report] ( [ReportDisplayName]  ASC , [ReportCategoryID]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 658 of 1510 : Created [IX_Reporting_Report_ReportCategoryID_ReportDisplayName]';
    END;

GO

PRINT ' 659 of 1510 : Analyzing IX_Reporting_Report_ReportGUID_ReportName';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Reporting_Report_ReportGUID_ReportName') --IS NULL
    BEGIN  CREATE NONCLUSTERED INDEX
		 [IX_Reporting_Report_ReportGUID_ReportName]
		 ON [dbo].[Reporting_Report] (  [ReportGUID]  ASC , [ReportName]  ASC) 
		 WITH
		 (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 660 of 1510 : Created [IX_Reporting_Report_ReportGUID_ReportName]';
    END;

GO

PRINT ' 661 of 1510 : Analyzing IX_Reporting_Report_ReportName';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Reporting_Report_ReportName') 
    --IS NULL
    BEGIN
	   CREATE UNIQUE NONCLUSTERED INDEX
	   [IX_Reporting_Report_ReportName]
	   ON [dbo].[Reporting_Report] (  [ReportName] ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 662 of 1510 : Created [IX_Reporting_Report_ReportName]';
    END;

GO

PRINT ' 663 of 1510 : Analyzing IX_CMS_SearchTask_SearchTaskPriority_SearchTaskStatus_SearchTaskServerName';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_SearchTask_SearchTaskPriority_SearchTaskStatus_SearchTaskServerName') 
    --IS NULL
    BEGIN
	   CREATE CLUSTERED INDEX
	   [IX_CMS_SearchTask_SearchTaskPriority_SearchTaskStatus_SearchTaskServerName]
	   ON [dbo].[CMS_SearchTask] (  [SearchTaskPriority] DESC , [SearchTaskStatus]  ASC , [SearchTaskServerName] ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 664 of 1510 : Created [IX_CMS_SearchTask_SearchTaskPriority_SearchTaskStatus_SearchTaskServerName]';
    END;

GO

PRINT ' 665 of 1510 : Analyzing IX_CMS_WorkflowStepRoles_StepID_StepSourcePointGUID_RoleID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_WorkflowStepRoles_StepID_StepSourcePointGUID_RoleID') 
    --IS NULL
    BEGIN
	   CREATE  UNIQUE CLUSTERED INDEX
	   [IX_CMS_WorkflowStepRoles_StepID_StepSourcePointGUID_RoleID]
	   ON [dbo].[CMS_WorkflowStepRoles] (  [StepID]  ASC , [StepSourcePointGUID]  ASC , [RoleID]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 666 of 1510 : Created [IX_CMS_WorkflowStepRoles_StepID_StepSourcePointGUID_RoleID]';
    END;

GO

PRINT ' 667 of 1510 : Analyzing IX_CMS_Tree_NodeID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_Tree_NodeID') 
    --IS NULL
    BEGIN
	   CREATE  UNIQUE CLUSTERED  INDEX
	   [IX_CMS_Tree_NodeID]
	   ON [dbo].[CMS_Tree] (  [NodeID]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 668 of 1510 : Created [IX_CMS_Tree_NodeID]';
    END;

GO

PRINT ' 669 of 1510 : Analyzing IX_CMS_Tree_NodeID_NodeSiteID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_Tree_NodeID_NodeSiteID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_CMS_Tree_NodeID_NodeSiteID]
	   ON [dbo].[CMS_Tree] (  [NodeID]  ASC , [NodeSiteID] ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 670 of 1510 : Created [IX_CMS_Tree_NodeID_NodeSiteID]';
    END;

GO

PRINT ' 671 of 1510 : Analyzing IX_CMS_Tree_NodeLinkedNodeID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_Tree_NodeLinkedNodeID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_CMS_Tree_NodeLinkedNodeID]
	   ON [dbo].[CMS_Tree] (  [NodeLinkedNodeID]  ASC) INCLUDE ( [NodeID] , [NodeClassID]) WITH (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 672 of 1510 : Created [IX_CMS_Tree_NodeLinkedNodeID]';
    END;

GO

PRINT ' 673 of 1510 : Analyzing CMS_Tree_NodeSiteID_NodeID_NodeClassID_NodeLinkedNodeID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'CMS_Tree_NodeSiteID_NodeID_NodeClassID_NodeLinkedNodeID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [CMS_Tree_NodeSiteID_NodeID_NodeClassID_NodeLinkedNodeID]
	   ON [dbo].[CMS_Tree] (  [NodeSiteID]  ASC) INCLUDE ( [NodeID] , [NodeClassID] , [NodeLinkedNodeID]) WITH (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 674 of 1510 : Created [CMS_Tree_NodeSiteID_NodeID_NodeClassID_NodeLinkedNodeID]';
    END;

GO

PRINT ' 675 of 1510 : Analyzing IX_CMS_Tree_NodeSiteID_NodeGUID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_Tree_NodeSiteID_NodeGUID') 
    --IS NULL
    BEGIN
	   CREATE UNIQUE NONCLUSTERED INDEX
	   [IX_CMS_Tree_NodeSiteID_NodeGUID]
	   ON [dbo].[CMS_Tree] (  [NodeSiteID]  ASC , [NodeGUID]  ASC) INCLUDE ( [NodeID]) WITH (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 676 of 1510 : Created [IX_CMS_Tree_NodeSiteID_NodeGUID]';
    END;

GO

PRINT ' 677 of 1510 : Analyzing IX_CMS_Tree_NodeAliasPath';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_Tree_NodeAliasPath') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_CMS_Tree_NodeAliasPath]
	   ON [dbo].[CMS_Tree] (  [NodeAliasPath]  ASC) 
	   WITH
	   ( PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 678 of 1510 : Created [IX_CMS_Tree_NodeAliasPath]';
    END;

GO

PRINT ' 679 of 1510 : Analyzing IX_CMS_Tree_NodeParentID_NodeAlias_NodeName';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_Tree_NodeParentID_NodeAlias_NodeName') --IS NULL
    BEGIN  CREATE NONCLUSTERED INDEX
		 [IX_CMS_Tree_NodeParentID_NodeAlias_NodeName]
		 ON [dbo].[CMS_Tree] ( [NodeParentID]  ASC , [NodeAlias]  ASC , [NodeName]  ASC) 
		 WITH
		 (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 680 of 1510 : Created [IX_CMS_Tree_NodeParentID_NodeAlias_NodeName]';
    END;

GO

PRINT ' 681 of 1510 : Analyzing IX_CMS_Tree_NodeClassID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_Tree_NodeClassID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_CMS_Tree_NodeClassID]
	   ON [dbo].[CMS_Tree] (  [NodeClassID]  ASC) 
	   WITH
	   ( PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 682 of 1510 : Created [IX_CMS_Tree_NodeClassID]';
    END;

GO

PRINT ' 683 of 1510 : Analyzing IX_CMS_Tree_NodeLevel';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_Tree_NodeLevel') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_CMS_Tree_NodeLevel]
	   ON [dbo].[CMS_Tree] (  [NodeLevel]  ASC) 
	   WITH
	   ( PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 684 of 1510 : Created [IX_CMS_Tree_NodeLevel]';
    END;

GO

PRINT ' 685 of 1510 : Analyzing IX_CMS_Tree_NodeACLID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_Tree_NodeACLID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_CMS_Tree_NodeACLID]
	   ON [dbo].[CMS_Tree] (  [NodeACLID]  ASC) 
	   WITH
	   ( PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 686 of 1510 : Created [IX_CMS_Tree_NodeACLID]';
    END;

GO

PRINT ' 687 of 1510 : Analyzing IX_CMS_Tree_IsSecuredNode_RequiresSSL_NodeCacheMinutes';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_Tree_IsSecuredNode_RequiresSSL_NodeCacheMinutes') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_CMS_Tree_IsSecuredNode_RequiresSSL_NodeCacheMinutes]
	   ON [dbo].[CMS_Tree] (  [IsSecuredNode]  ASC , [RequiresSSL]  ASC , [NodeCacheMinutes]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 688 of 1510 : Created [IX_CMS_Tree_IsSecuredNode_RequiresSSL_NodeCacheMinutes]';
    END;

GO

PRINT ' 689 of 1510 : Analyzing IX_CMS_Tree_NodeSKUID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_Tree_NodeSKUID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_CMS_Tree_NodeSKUID]
	   ON [dbo].[CMS_Tree] (  [NodeSKUID]  ASC) 
	   WITH
	   ( PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 690 of 1510 : Created [IX_CMS_Tree_NodeSKUID]';
    END;

GO

PRINT ' 691 of 1510 : Analyzing IX_CMS_Tree_NodeOwner';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_Tree_NodeOwner') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_CMS_Tree_NodeOwner]
	   ON [dbo].[CMS_Tree] (  [NodeOwner]  ASC) 
	   WITH
	   ( PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 692 of 1510 : Created [IX_CMS_Tree_NodeOwner]';
    END;

GO

PRINT ' 693 of 1510 : Analyzing IX_CMS_Tree_NodeGroupID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_Tree_NodeGroupID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_CMS_Tree_NodeGroupID]
	   ON [dbo].[CMS_Tree] (  [NodeGroupID]  ASC) 
	   WITH
	   ( PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 694 of 1510 : Created [IX_CMS_Tree_NodeGroupID]';
    END;

GO

PRINT ' 695 of 1510 : Analyzing IX_CMS_WorkflowStepUser_StepID_StepSourcePointGUID_UserID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_WorkflowStepUser_StepID_StepSourcePointGUID_UserID') 
    --IS NULL
    BEGIN
	   CREATE  UNIQUE CLUSTERED INDEX
	   [IX_CMS_WorkflowStepUser_StepID_StepSourcePointGUID_UserID]
	   ON [dbo].[CMS_WorkflowStepUser] ( [StepID]  ASC , [StepSourcePointGUID]  ASC , [UserID]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 696 of 1510 : Created [IX_CMS_WorkflowStepUser_StepID_StepSourcePointGUID_UserID]';
    END;

GO

PRINT ' 697 of 1510 : Analyzing IX_Forums_ForumPost_PostIDPath';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Forums_ForumPost_PostIDPath') 
    --IS NULL
    BEGIN
	   CREATE UNIQUE CLUSTERED INDEX
	   [IX_Forums_ForumPost_PostIDPath]
	   ON [dbo].[Forums_ForumPost] (  [PostIDPath] ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 698 of 1510 : Created [IX_Forums_ForumPost_PostIDPath]';
    END;

GO

PRINT ' 699 of 1510 : Analyzing IX_Forums_ForumPost_PostForumID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Forums_ForumPost_PostForumID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_Forums_ForumPost_PostForumID]
	   ON [dbo].[Forums_ForumPost] (  [PostForumID]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 700 of 1510 : Created [IX_Forums_ForumPost_PostForumID]';
    END;

GO

PRINT ' 701 of 1510 : Analyzing IX_Forums_ForumPost_PostParentID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Forums_ForumPost_PostParentID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_Forums_ForumPost_PostParentID]
	   ON [dbo].[Forums_ForumPost] (  [PostParentID] ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 702 of 1510 : Created [IX_Forums_ForumPost_PostParentID]';
    END;

GO

PRINT ' 703 of 1510 : Analyzing IX_Forums_ForumPost_PostLevel';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Forums_ForumPost_PostLevel') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_Forums_ForumPost_PostLevel]
	   ON [dbo].[Forums_ForumPost] (  [PostLevel]  ASC) WITH (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 704 of 1510 : Created [IX_Forums_ForumPost_PostLevel]';
    END;

GO

PRINT ' 705 of 1510 : Analyzing IX_Forums_ForumPost_PostUserID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Forums_ForumPost_PostUserID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_Forums_ForumPost_PostUserID]
	   ON [dbo].[Forums_ForumPost] (  [PostUserID]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 706 of 1510 : Created [IX_Forums_ForumPost_PostUserID]';
    END;

GO

PRINT ' 707 of 1510 : Analyzing IX_Forums_ForumPost_PostApprovedByUserID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Forums_ForumPost_PostApprovedByUserID') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[IX_Forums_ForumPost_PostApprovedByUserID]
		ON [dbo].[Forums_ForumPost] ( [PostApprovedByUserID]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 708 of 1510 : Created [IX_Forums_ForumPost_PostApprovedByUserID]';
    END;

GO

PRINT ' 709 of 1510 : Analyzing IX_Forums_ForumPost_PostApproved';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Forums_ForumPost_PostApproved') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_Forums_ForumPost_PostApproved]
	   ON [dbo].[Forums_ForumPost] (  [PostApproved] ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 710 of 1510 : Created [IX_Forums_ForumPost_PostApproved]';
    END;

GO

PRINT ' 711 of 1510 : Analyzing IX_OM_ScoreContactRule_ScoreID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_OM_ScoreContactRule_ScoreID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_OM_ScoreContactRule_ScoreID]
	   ON [dbo].[OM_ScoreContactRule] (  [ScoreID]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 712 of 1510 : Created [IX_OM_ScoreContactRule_ScoreID]';
    END;

GO

PRINT ' 713 of 1510 : Analyzing IX_OM_ScoreContactRule_ScoreID_Expiration_ContactID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_OM_ScoreContactRule_ScoreID_Expiration_ContactID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_OM_ScoreContactRule_ScoreID_Expiration_ContactID]
	   ON [dbo].[OM_ScoreContactRule] (  [ScoreID]  ASC , [Expiration]  ASC) INCLUDE ( [ContactID]) WITH (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 714 of 1510 : Created [IX_OM_ScoreContactRule_ScoreID_Expiration_ContactID]';
    END;

GO

PRINT ' 715 of 1510 : Analyzing IX_OM_ScoreContactRule_RuleID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_OM_ScoreContactRule_RuleID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_OM_ScoreContactRule_RuleID]
	   ON [dbo].[OM_ScoreContactRule] (  [RuleID]  ASC) WITH (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 716 of 1510 : Created [IX_OM_ScoreContactRule_RuleID]';
    END;

GO

PRINT ' 717 of 1510 : Analyzing IX_CMS_UserRole_UserID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_UserRole_UserID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_CMS_UserRole_UserID]
	   ON [dbo].[CMS_UserRole] (  [UserID]  ASC) INCLUDE ([RoleID] , [ValidTo]) WITH (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 718 of 1510 : Created [IX_CMS_UserRole_UserID]';
    END;

GO

PRINT ' 719 of 1510 : Analyzing IX_CMS_UserRole_UserID_RoleID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_UserRole_UserID_RoleID') 
    --IS NULL
    BEGIN
	   CREATE UNIQUE NONCLUSTERED INDEX
	   [IX_CMS_UserRole_UserID_RoleID]
	   ON [dbo].[CMS_UserRole] (  [UserID]  ASC , [RoleID]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 720 of 1510 : Created [IX_CMS_UserRole_UserID_RoleID]';
    END;

GO

PRINT ' 721 of 1510 : Analyzing IX_CMS_Widget_WidgetCategoryID_WidgetDisplayName';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_Widget_WidgetCategoryID_WidgetDisplayName') --IS NULL
    BEGIN  CREATE CLUSTERED INDEX
		 [IX_CMS_Widget_WidgetCategoryID_WidgetDisplayName]
		 ON [dbo].[CMS_Widget] (  [WidgetCategoryID]  ASC , [WidgetDisplayName]  ASC) 
		 WITH
		 (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 722 of 1510 : Created [IX_CMS_Widget_WidgetCategoryID_WidgetDisplayName]';
    END;

GO

PRINT ' 723 of 1510 : Analyzing IX_CMS_Widget_WidgetWebPartID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_Widget_WidgetWebPartID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_CMS_Widget_WidgetWebPartID]
	   ON [dbo].[CMS_Widget] (  [WidgetWebPartID]  ASC) WITH (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 724 of 1510 : Created [IX_CMS_Widget_WidgetWebPartID]';
    END;

GO

PRINT ' 725 of 1510 : Analyzing IX_CMS_Widget_WidgetIsEnabled_WidgetForGroup_WidgetForEditor_WidgetForUser';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_Widget_WidgetIsEnabled_WidgetForGroup_WidgetForEditor_WidgetForUser') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_CMS_Widget_WidgetIsEnabled_WidgetForGroup_WidgetForEditor_WidgetForUser]
	   ON [dbo].[CMS_Widget] (  [WidgetIsEnabled]  ASC , [WidgetForGroup]  ASC , [WidgetForEditor]  ASC , [WidgetForUser]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 726 of 1510 : Created [IX_CMS_Widget_WidgetIsEnabled_WidgetForGroup_WidgetForEditor_WidgetForUser]';
    END;

GO

PRINT ' 727 of 1510 : Analyzing IX_CMS_MembershipUser_MembershipID_UserID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_MembershipUser_MembershipID_UserID') --IS NULL
    BEGIN  CREATE  UNIQUE NONCLUSTERED INDEX
		 [IX_CMS_MembershipUser_MembershipID_UserID]
		 ON [dbo].[CMS_MembershipUser] (  [MembershipID]  ASC , [UserID]  ASC) 
		 WITH
		 (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 728 of 1510 : Created [IX_CMS_MembershipUser_MembershipID_UserID]';
    END;

GO

PRINT ' 729 of 1510 : Analyzing IX_CMS_MembershipUser_UserIDValidTo';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_MembershipUser_UserIDValidTo') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[IX_CMS_MembershipUser_UserIDValidTo]
		ON [dbo].[CMS_MembershipUser] ( [UserID]  ASC , [ValidTo]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 730 of 1510 : Created [IX_CMS_MembershipUser_UserIDValidTo]';
    END;

GO

PRINT ' 731 of 1510 : Analyzing IX_CMS_Layout_LayoutDisplayName';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_Layout_LayoutDisplayName') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_CMS_Layout_LayoutDisplayName]
	   ON [dbo].[CMS_Layout] (  [LayoutDisplayName]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 732 of 1510 : Created [IX_CMS_Layout_LayoutDisplayName]';
    END;

GO

PRINT ' 733 of 1510 : Analyzing IX_OM_Rule_RuleScoreID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_OM_Rule_RuleScoreID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_OM_Rule_RuleScoreID]
	   ON [dbo].[OM_Rule] (  [RuleScoreID]  ASC) 
	   WITH
	   ( PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 734 of 1510 : Created [IX_OM_Rule_RuleScoreID]';
    END;

GO

PRINT ' 735 of 1510 : Analyzing IX_OM_Rule_RuleSiteID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_OM_Rule_RuleSiteID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_OM_Rule_RuleSiteID]
	   ON [dbo].[OM_Rule] (  [RuleSiteID]  ASC) 
	   WITH
	   ( PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 736 of 1510 : Created [IX_OM_Rule_RuleSiteID]';
    END;

GO

PRINT ' 737 of 1510 : Analyzing IX_CMS_Avatar_AvatarName';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_Avatar_AvatarName') 
    --IS NULL
    BEGIN
	   CREATE CLUSTERED INDEX
	   [IX_CMS_Avatar_AvatarName]
	   ON [dbo].[CMS_Avatar] (  [AvatarName]  ASC) 
	   WITH
	   ( PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 738 of 1510 : Created [IX_CMS_Avatar_AvatarName]';
    END;

GO

PRINT ' 739 of 1510 : Analyzing IX_CMS_Avatar_AvatarType_AvatarIsCustom';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_Avatar_AvatarType_AvatarIsCustom') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[IX_CMS_Avatar_AvatarType_AvatarIsCustom]
		ON [dbo].[CMS_Avatar] ( [AvatarType]  ASC , [AvatarIsCustom]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 740 of 1510 : Created [IX_CMS_Avatar_AvatarType_AvatarIsCustom]';
    END;

GO

PRINT ' 741 of 1510 : Analyzing IX_CMS_Avatar_AvatarGUID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_Avatar_AvatarGUID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_CMS_Avatar_AvatarGUID]
	   ON [dbo].[CMS_Avatar] (  [AvatarGUID]  ASC) 
	   WITH
	   ( PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 742 of 1510 : Created [IX_CMS_Avatar_AvatarGUID]';
    END;

GO

PRINT ' 743 of 1510 : Analyzing IX_Forums_Attachment_AttachmentGUID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Forums_Attachment_AttachmentGUID') --IS NULL
    BEGIN CREATE  UNIQUE NONCLUSTERED INDEX
		[IX_Forums_Attachment_AttachmentGUID]
		ON [dbo].[Forums_Attachment] (  [AttachmentSiteID]  ASC , [AttachmentGUID]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 744 of 1510 : Created [IX_Forums_Attachment_AttachmentGUID]';
    END;

GO

PRINT ' 745 of 1510 : Analyzing IX_Forums_Attachment_AttachmentPostID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Forums_Attachment_AttachmentPostID') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[IX_Forums_Attachment_AttachmentPostID]
		ON [dbo].[Forums_Attachment] ( [AttachmentPostID]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 746 of 1510 : Created [IX_Forums_Attachment_AttachmentPostID]';
    END;

GO

PRINT ' 747 of 1510 : Analyzing IX_CMS_WorkflowStep_StepID_StepName';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_WorkflowStep_StepID_StepName') --IS NULL
    BEGIN CREATE CLUSTERED INDEX
		[IX_CMS_WorkflowStep_StepID_StepName]
		ON [dbo].[CMS_WorkflowStep] (  [StepID] ASC , [StepName]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 748 of 1510 : Created [IX_CMS_WorkflowStep_StepID_StepName]';
    END;

GO

PRINT ' 749 of 1510 : Analyzing IX_CMS_WorkflowStep_StepWorkflowID_StepName';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_WorkflowStep_StepWorkflowID_StepName') --IS NULL
    BEGIN  CREATE  UNIQUE NONCLUSTERED INDEX
		 [IX_CMS_WorkflowStep_StepWorkflowID_StepName]
		 ON [dbo].[CMS_WorkflowStep] (  [StepWorkflowID]  ASC , [StepName]  ASC) 
		 WITH
		 (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 750 of 1510 : Created [IX_CMS_WorkflowStep_StepWorkflowID_StepName]';
    END;

GO

PRINT ' 751 of 1510 : Analyzing IX_CMS_WorkflowStep_StepWorkflowID_StepOrder';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_WorkflowStep_StepWorkflowID_StepOrder') --IS NULL
    BEGIN  CREATE NONCLUSTERED INDEX
		 [IX_CMS_WorkflowStep_StepWorkflowID_StepOrder]
		 ON [dbo].[CMS_WorkflowStep] (  [StepWorkflowID]  ASC , [StepOrder]  ASC) 
		 WITH
		 (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 752 of 1510 : Created [IX_CMS_WorkflowStep_StepWorkflowID_StepOrder]';
    END;

GO

PRINT ' 753 of 1510 : Analyzing IX_CMS_Role_SiteID_RoleName_RoleDisplayName';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_Role_SiteID_RoleName_RoleDisplayName') --IS NULL
    BEGIN  CREATE CLUSTERED INDEX
		 [IX_CMS_Role_SiteID_RoleName_RoleDisplayName]
		 ON [dbo].[CMS_Role] ( [SiteID]  ASC) 
		 WITH
		 (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 754 of 1510 : Created [IX_CMS_Role_SiteID_RoleName_RoleDisplayName]';
    END;

GO

PRINT ' 755 of 1510 : Analyzing IX_CMS_Role_SiteID_RoleName';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_Role_SiteID_RoleName') 
    --IS NULL
    BEGIN
	   CREATE UNIQUE NONCLUSTERED INDEX
	   [IX_CMS_Role_SiteID_RoleName]
	   ON [dbo].[CMS_Role] (  [RoleName]  ASC , [SiteID] ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 756 of 1510 : Created [IX_CMS_Role_SiteID_RoleName]';
    END;

GO

PRINT ' 757 of 1510 : Analyzing IX_CMS_Role_SiteID_RoleID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_Role_SiteID_RoleID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_CMS_Role_SiteID_RoleID]
	   ON [dbo].[CMS_Role] (  [SiteID]  ASC) 
	   WITH
	   ( PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 758 of 1510 : Created [IX_CMS_Role_SiteID_RoleID]';
    END;

GO

PRINT ' 759 of 1510 : Analyzing IX_CMS_Role_RoleGroupID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_Role_RoleGroupID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_CMS_Role_RoleGroupID]
	   ON [dbo].[CMS_Role] (  [RoleGroupID]  ASC) 
	   WITH
	   ( PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 760 of 1510 : Created [IX_CMS_Role_RoleGroupID]';
    END;

GO

PRINT ' 761 of 1510 : Analyzing idx_HFit_CMS_Role_SiteIDRoleID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'idx_HFit_CMS_Role_SiteIDRoleID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [idx_HFit_CMS_Role_SiteIDRoleID]
	   ON [dbo].[CMS_Role] (  [SiteID]  ASC , [RoleID]  ASC , [RoleDisplayName]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 762 of 1510 : Created [idx_HFit_CMS_Role_SiteIDRoleID]';
    END;

GO

PRINT ' 763 of 1510 : Analyzing nonRoleNameID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'nonRoleNameID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [nonRoleNameID]
	   ON [dbo].[CMS_Role] (  [RoleName]  ASC , [RoleID]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 764 of 1510 : Created [nonRoleNameID]';
    END;

GO

PRINT ' 765 of 1510 : Analyzing IX_CMS_EmailUser_Status';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_EmailUser_Status') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_CMS_EmailUser_Status]
	   ON [dbo].[CMS_EmailUser] (  [Status]  ASC) 
	   WITH
	   ( PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 766 of 1510 : Created [IX_CMS_EmailUser_Status]';
    END;

GO

PRINT ' 767 of 1510 : Analyzing IX_CMS_Transformation_TransformationClassID_TransformationName';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_Transformation_TransformationClassID_TransformationName') 
    --IS NULL
    BEGIN
	   CREATE CLUSTERED INDEX
	   [IX_CMS_Transformation_TransformationClassID_TransformationName]
	   ON [dbo].[CMS_Transformation] (  [TransformationClassID]  ASC , [TransformationName]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 768 of 1510 : Created [IX_CMS_Transformation_TransformationClassID_TransformationName]';
    END;

GO

PRINT ' 769 of 1510 : Analyzing IX_Board_Subscription_SubscriptionBoardID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Board_Subscription_SubscriptionBoardID') --IS NULL
    BEGIN  CREATE NONCLUSTERED INDEX
		 [IX_Board_Subscription_SubscriptionBoardID]
		 ON [dbo].[Board_Subscription] (  [SubscriptionBoardID]  ASC) 
		 WITH
		 (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 770 of 1510 : Created [IX_Board_Subscription_SubscriptionBoardID]';
    END;

GO

PRINT ' 771 of 1510 : Analyzing IX_Board_Subscription_SubscriptionUserID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Board_Subscription_SubscriptionUserID') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[IX_Board_Subscription_SubscriptionUserID]
		ON [dbo].[Board_Subscription] ( [SubscriptionUserID]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 772 of 1510 : Created [IX_Board_Subscription_SubscriptionUserID]';
    END;

GO

PRINT ' 773 of 1510 : Analyzing IX_OM_ContactGroupMember_ContactGroupMemberContactGroupID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_OM_ContactGroupMember_ContactGroupMemberContactGroupID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_OM_ContactGroupMember_ContactGroupMemberContactGroupID]
	   ON [dbo].[OM_ContactGroupMember] ( [ContactGroupMemberContactGroupID]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 774 of 1510 : Created [IX_OM_ContactGroupMember_ContactGroupMemberContactGroupID]';
    END;

GO

PRINT ' 775 of 1510 : Analyzing IX_OM_ContactGroupMember_ContactGroupMemberRelatedID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_OM_ContactGroupMember_ContactGroupMemberRelatedID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_OM_ContactGroupMember_ContactGroupMemberRelatedID]
	   ON [dbo].[OM_ContactGroupMember] ( [ContactGroupMemberRelatedID]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 776 of 1510 : Created [IX_OM_ContactGroupMember_ContactGroupMemberRelatedID]';
    END;

GO

PRINT ' 777 of 1510 : Analyzing idx_HFit_ContactGroupMember_RelatedID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'idx_HFit_ContactGroupMember_RelatedID') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[idx_HFit_ContactGroupMember_RelatedID]
		ON [dbo].[OM_ContactGroupMember] ( [ContactGroupMemberContactGroupID]  ASC , [ContactGroupMemberID]  ASC , [ContactGroupMemberRelatedID] ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 778 of 1510 : Created [idx_HFit_ContactGroupMember_RelatedID]';
    END;

GO

PRINT ' 779 of 1510 : Analyzing IX_CMS_CssStylesheet_StylesheetDisplayName';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_CssStylesheet_StylesheetDisplayName') --IS NULL
    BEGIN  CREATE CLUSTERED INDEX
		 [IX_CMS_CssStylesheet_StylesheetDisplayName]
		 ON [dbo].[CMS_CssStylesheet] (  [StylesheetDisplayName]  ASC) 
		 WITH
		 (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 780 of 1510 : Created [IX_CMS_CssStylesheet_StylesheetDisplayName]';
    END;

GO

PRINT ' 781 of 1510 : Analyzing IX_CMS_CssStylesheet_StylesheetName';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_CssStylesheet_StylesheetName') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[IX_CMS_CssStylesheet_StylesheetName]
		ON [dbo].[CMS_CssStylesheet] ( [StylesheetName]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 782 of 1510 : Created [IX_CMS_CssStylesheet_StylesheetName]';
    END;

GO

PRINT ' 783 of 1510 : Analyzing idx_HFit_TrackerSugaryDrinks_CreateDate';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'idx_HFit_TrackerSugaryDrinks_CreateDate') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[idx_HFit_TrackerSugaryDrinks_CreateDate]
		ON [dbo].[HFit_TrackerSugaryDrinks] (  [ItemCreatedWhen]  ASC , [ItemModifiedWhen]  ASC) 
		WITH
		( PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 784 of 1510 : Created [idx_HFit_TrackerSugaryDrinks_CreateDate]';
    END;

GO

PRINT ' 785 of 1510 : Analyzing Ref76';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'Ref76') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [Ref76]
	   ON [dbo].[HFit_HealthAssesmentRecomendations] (  [RecomendationTypeID]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 786 of 1510 : Created [Ref76]';
    END;

GO

PRINT ' 787 of 1510 : Analyzing IX_CMS_WorkflowScope_ScopeStartingPath';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_WorkflowScope_ScopeStartingPath') --IS NULL
    BEGIN CREATE CLUSTERED INDEX
		[IX_CMS_WorkflowScope_ScopeStartingPath]
		ON [dbo].[CMS_WorkflowScope] ( [ScopeStartingPath]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 788 of 1510 : Created [IX_CMS_WorkflowScope_ScopeStartingPath]';
    END;

GO

PRINT ' 789 of 1510 : Analyzing IX_CMS_WorkflowScope_ScopeWorkflowID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_WorkflowScope_ScopeWorkflowID') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[IX_CMS_WorkflowScope_ScopeWorkflowID]
		ON [dbo].[CMS_WorkflowScope] ( [ScopeWorkflowID]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 790 of 1510 : Created [IX_CMS_WorkflowScope_ScopeWorkflowID]';
    END;

GO

PRINT ' 791 of 1510 : Analyzing IX_CMS_WorkflowScope_ScopeClassID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_WorkflowScope_ScopeClassID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_CMS_WorkflowScope_ScopeClassID]
	   ON [dbo].[CMS_WorkflowScope] (  [ScopeClassID] ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 792 of 1510 : Created [IX_CMS_WorkflowScope_ScopeClassID]';
    END;

GO

PRINT ' 793 of 1510 : Analyzing IX_CMS_WorkflowScope_ScopeSiteID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_WorkflowScope_ScopeSiteID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_CMS_WorkflowScope_ScopeSiteID]
	   ON [dbo].[CMS_WorkflowScope] (  [ScopeSiteID] ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 794 of 1510 : Created [IX_CMS_WorkflowScope_ScopeSiteID]';
    END;

GO

PRINT ' 795 of 1510 : Analyzing IX_CMS_WorkflowScope_ScopeCultureID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_WorkflowScope_ScopeCultureID') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[IX_CMS_WorkflowScope_ScopeCultureID]
		ON [dbo].[CMS_WorkflowScope] ( [ScopeCultureID]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 796 of 1510 : Created [IX_CMS_WorkflowScope_ScopeCultureID]';
    END;

GO

PRINT ' 797 of 1510 : Analyzing IX_CMS_Form_FormDisplayName';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_Form_FormDisplayName') 
    --IS NULL
    BEGIN
	   CREATE CLUSTERED INDEX
	   [IX_CMS_Form_FormDisplayName]
	   ON [dbo].[CMS_Form] (  [FormDisplayName]  ASC) 
	   WITH
	   ( PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 798 of 1510 : Created [IX_CMS_Form_FormDisplayName]';
    END;

GO

PRINT ' 799 of 1510 : Analyzing IX_CMS_Form_FormClassID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_Form_FormClassID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_CMS_Form_FormClassID]
	   ON [dbo].[CMS_Form] (  [FormClassID]  ASC) 
	   WITH
	   ( PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 800 of 1510 : Created [IX_CMS_Form_FormClassID]';
    END;

GO

PRINT ' 801 of 1510 : Analyzing IX_CMS_Form_FormSiteID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_Form_FormSiteID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_CMS_Form_FormSiteID]
	   ON [dbo].[CMS_Form] (  [FormSiteID]  ASC) 
	   WITH
	   ( PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 802 of 1510 : Created [IX_CMS_Form_FormSiteID]';
    END;

GO

PRINT ' 803 of 1510 : Analyzing IX_CMS_Culture_CultureName';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_Culture_CultureName') 
    --IS NULL
    BEGIN
	   CREATE CLUSTERED INDEX
	   [IX_CMS_Culture_CultureName]
	   ON [dbo].[CMS_Culture] (  [CultureName]  ASC) 
	   WITH
	   ( PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 804 of 1510 : Created [IX_CMS_Culture_CultureName]';
    END;

GO

PRINT ' 805 of 1510 : Analyzing IX_CMS_Culture_CultureCode';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_Culture_CultureCode') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_CMS_Culture_CultureCode]
	   ON [dbo].[CMS_Culture] (  [CultureCode]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 806 of 1510 : Created [IX_CMS_Culture_CultureCode]';
    END;

GO

PRINT ' 807 of 1510 : Analyzing IX_CMS_CulturAlias';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_CulturAlias') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_CMS_CulturAlias]
	   ON [dbo].[CMS_Culture] (  [CultureAlias]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 808 of 1510 : Created [IX_CMS_CulturAlias]';
    END;

GO

PRINT ' 809 of 1510 : Analyzing IX_CMS_WidgetCategory_CategoryPath';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_WidgetCategory_CategoryPath') --IS NULL
    BEGIN CREATE  UNIQUE CLUSTERED INDEX
		[IX_CMS_WidgetCategory_CategoryPath]
		ON [dbo].[CMS_WidgetCategory] ( [WidgetCategoryPath]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 810 of 1510 : Created [IX_CMS_WidgetCategory_CategoryPath]';
    END;

GO

PRINT ' 811 of 1510 : Analyzing IX_CMS_WidgetCategory_WidgetCategoryID_WidgetCategoryOrder';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_WidgetCategory_WidgetCategoryID_WidgetCategoryOrder') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_CMS_WidgetCategory_WidgetCategoryID_WidgetCategoryOrder]
	   ON [dbo].[CMS_WidgetCategory] ( [WidgetCategoryParentID]  ASC , [WidgetCategoryOrder]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 812 of 1510 : Created [IX_CMS_WidgetCategory_WidgetCategoryID_WidgetCategoryOrder]';
    END;

GO

PRINT ' 813 of 1510 : Analyzing IX_Goal_CodeName';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Goal_CodeName') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_Goal_CodeName]
	   ON [dbo].[HFit_Goal] (  [CodeName]  ASC , [TrackerNodeGUID]  ASC) 
	   WITH
	   ( PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 814 of 1510 : Created [IX_Goal_CodeName]';
    END;

GO

PRINT ' 815 of 1510 : Analyzing IX_CMS_Email_EmailPriority_EmailStatus';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_Email_EmailPriority_EmailStatus') --IS NULL
    BEGIN CREATE CLUSTERED INDEX
		[IX_CMS_Email_EmailPriority_EmailStatus]
		ON [dbo].[CMS_Email] (  [EmailPriority] ASC , [EmailStatus]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 816 of 1510 : Created [IX_CMS_Email_EmailPriority_EmailStatus]';
    END;

GO

PRINT ' 817 of 1510 : Analyzing IX_CMS_Email_EmailSiteID_EmailStatus_EmailLastSendAttempt';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_Email_EmailSiteID_EmailStatus_EmailLastSendAttempt') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_CMS_Email_EmailSiteID_EmailStatus_EmailLastSendAttempt]
	   ON [dbo].[CMS_Email] (  [EmailSiteID]  ASC , [EmailStatus]  ASC , [EmailLastSendAttempt]  ASC) INCLUDE ( [EmailID]) WITH (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 818 of 1510 : Created [IX_CMS_Email_EmailSiteID_EmailStatus_EmailLastSendAttempt]';
    END;

GO

PRINT ' 819 of 1510 : Analyzing IX_CMS_Email_EmailStatus_EmailID_EmailPriority_EmailLastModified';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_Email_EmailStatus_EmailID_EmailPriority_EmailLastModified') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_CMS_Email_EmailStatus_EmailID_EmailPriority_EmailLastModified]
	   ON [dbo].[CMS_Email] (  [EmailStatus]  ASC , [EmailID]  ASC) INCLUDE ( [EmailPriority] , [EmailLastModified]) WITH (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 820 of 1510 : Created [IX_CMS_Email_EmailStatus_EmailID_EmailPriority_EmailLastModified]';
    END;

GO

PRINT ' 821 of 1510 : Analyzing idx_HFit_TrackerWater_CreateDate';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'idx_HFit_TrackerWater_CreateDate') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [idx_HFit_TrackerWater_CreateDate]
	   ON [dbo].[HFit_TrackerWater] (  [ItemCreatedWhen] ASC , [ItemModifiedWhen]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 822 of 1510 : Created [idx_HFit_TrackerWater_CreateDate]';
    END;

GO

PRINT ' 823 of 1510 : Analyzing IX_Board_Message_MessageInserted';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Board_Message_MessageInserted') 
    --IS NULL
    BEGIN
	   CREATE CLUSTERED INDEX
	   [IX_Board_Message_MessageInserted]
	   ON [dbo].[Board_Message] (  [MessageInserted] DESC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 824 of 1510 : Created [IX_Board_Message_MessageInserted]';
    END;

GO

PRINT ' 825 of 1510 : Analyzing IX_Board_Message_MessageApproved_MessageIsSpam';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Board_Message_MessageApproved_MessageIsSpam') --IS NULL
    BEGIN  CREATE NONCLUSTERED INDEX
		 [IX_Board_Message_MessageApproved_MessageIsSpam]
		 ON [dbo].[Board_Message] (  [MessageApproved]  ASC , [MessageIsSpam]  ASC) 
		 WITH
		 (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 826 of 1510 : Created [IX_Board_Message_MessageApproved_MessageIsSpam]';
    END;

GO

PRINT ' 827 of 1510 : Analyzing IX_Board_Message_MessageBoardID_MessageGUID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Board_Message_MessageBoardID_MessageGUID') --IS NULL
    BEGIN  CREATE  UNIQUE NONCLUSTERED INDEX
		 [IX_Board_Message_MessageBoardID_MessageGUID]
		 ON [dbo].[Board_Message] (  [MessageBoardID]  ASC , [MessageGUID]  ASC) 
		 WITH
		 (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 828 of 1510 : Created [IX_Board_Message_MessageBoardID_MessageGUID]';
    END;

GO

PRINT ' 829 of 1510 : Analyzing IX_Board_Message_MessageApprovedByUserID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Board_Message_MessageApprovedByUserID') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[IX_Board_Message_MessageApprovedByUserID]
		ON [dbo].[Board_Message] ( [MessageApprovedByUserID]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 830 of 1510 : Created [IX_Board_Message_MessageApprovedByUserID]';
    END;

GO

PRINT ' 831 of 1510 : Analyzing IX_Board_Message_MessageUserID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Board_Message_MessageUserID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_Board_Message_MessageUserID]
	   ON [dbo].[Board_Message] (  [MessageUserID]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 832 of 1510 : Created [IX_Board_Message_MessageUserID]';
    END;

GO

PRINT ' 833 of 1510 : Analyzing PI_SchemaChangeMonitor';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'PI_SchemaChangeMonitor') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [PI_SchemaChangeMonitor]
	   ON [dbo].[SchemaChangeMonitor] (  [OBJ]  ASC) 
	   WITH
	   ( PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 834 of 1510 : Created [PI_SchemaChangeMonitor]';
    END;

GO

PRINT ' 835 of 1510 : Analyzing IX_COM_TaxClassState_TaxClassID_StateID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_COM_TaxClassState_TaxClassID_StateID') --IS NULL
    BEGIN CREATE  UNIQUE NONCLUSTERED INDEX
		[IX_COM_TaxClassState_TaxClassID_StateID]
		ON [dbo].[COM_TaxClassState] (  [TaxClassID]  ASC , [StateID]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 836 of 1510 : Created [IX_COM_TaxClassState_TaxClassID_StateID]';
    END;

GO

PRINT ' 837 of 1510 : Analyzing IX_CMS_AlternativeForm_FormClassID_FormName';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_AlternativeForm_FormClassID_FormName') --IS NULL
    BEGIN  CREATE NONCLUSTERED INDEX
		 [IX_CMS_AlternativeForm_FormClassID_FormName]
		 ON [dbo].[CMS_AlternativeForm] (  [FormClassID]  ASC , [FormName]  ASC) 
		 WITH
		 (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 838 of 1510 : Created [IX_CMS_AlternativeForm_FormClassID_FormName]';
    END;

GO

PRINT ' 839 of 1510 : Analyzing IX_CMS_AlternativeForm_FormCoupledClassID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_AlternativeForm_FormCoupledClassID') --IS NULL
    BEGIN  CREATE NONCLUSTERED INDEX
		 [IX_CMS_AlternativeForm_FormCoupledClassID]
		 ON [dbo].[CMS_AlternativeForm] (  [FormCoupledClassID]  ASC) 
		 WITH
		 (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 840 of 1510 : Created [IX_CMS_AlternativeForm_FormCoupledClassID]';
    END;

GO

PRINT ' 841 of 1510 : Analyzing idx_HFit_TrackerMedicalCarePlan_CreateDate';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'idx_HFit_TrackerMedicalCarePlan_CreateDate') --IS NULL
    BEGIN  CREATE NONCLUSTERED INDEX
		 [idx_HFit_TrackerMedicalCarePlan_CreateDate]
		 ON [dbo].[HFit_TrackerMedicalCarePlan] (  [ItemCreatedWhen]  ASC , [ItemModifiedWhen]  ASC) 
		 WITH
		 ( PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 842 of 1510 : Created [idx_HFit_TrackerMedicalCarePlan_CreateDate]';
    END;

GO

PRINT ' 843 of 1510 : Analyzing IX_COM_TaxClassCountry_TaxClassID_CountryID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_COM_TaxClassCountry_TaxClassID_CountryID') --IS NULL
    BEGIN  CREATE  UNIQUE NONCLUSTERED INDEX
		 [IX_COM_TaxClassCountry_TaxClassID_CountryID]
		 ON [dbo].[COM_TaxClassCountry] (  [TaxClassID]  ASC , [CountryID]  ASC) 
		 WITH
		 (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 844 of 1510 : Created [IX_COM_TaxClassCountry_TaxClassID_CountryID]';
    END;

GO

PRINT ' 845 of 1510 : Analyzing idx_HFit_TrackerStress_CreateDate';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'idx_HFit_TrackerStress_CreateDate') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [idx_HFit_TrackerStress_CreateDate]
	   ON [dbo].[HFit_TrackerStress] ( [ItemCreatedWhen]  ASC , [ItemModifiedWhen]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 846 of 1510 : Created [idx_HFit_TrackerStress_CreateDate]';
    END;

GO

PRINT ' 847 of 1510 : Analyzing IX_CMS_WebPartLayout_WebPartLayoutWebPartID_WebPartLayoutCodeName';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_WebPartLayout_WebPartLayoutWebPartID_WebPartLayoutCodeName') 
    --IS NULL
    BEGIN
	   CREATE CLUSTERED INDEX
	   [IX_CMS_WebPartLayout_WebPartLayoutWebPartID_WebPartLayoutCodeName]
	   ON [dbo].[CMS_WebPartLayout] (  [WebPartLayoutWebPartID]  ASC , [WebPartLayoutCodeName]  ASC) 
	   WITH
	   ( PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 848 of 1510 : Created [IX_CMS_WebPartLayout_WebPartLayoutWebPartID_WebPartLayoutCodeName]';
    END;

GO

PRINT ' 849 of 1510 : Analyzing ctCulture';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Analytics_Statistics_StatisticsCode_StatisticsSiteID_StatisticsObjectID_StatisticsObjectCulture') --IS NULL
    BEGIN  CREATE CLUSTERED INDEX
		 [IX_Analytics_Statistics_StatisticsCode_StatisticsSiteID_StatisticsObjectID_StatisticsObjectCu	lture]
		 ON [dbo].[Analytics_Statistics] (  [StatisticsCode]  ASC) 
		 WITH
		 (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 850 of 1510 : Created lture]';
    END;

GO

PRINT ' 851 of 1510 : Analyzing IX_Staging_SyncLog_SyncLogTaskID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Staging_SyncLog_SyncLogTaskID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_Staging_SyncLog_SyncLogTaskID]
	   ON [dbo].[Staging_SyncLog] (  [SyncLogTaskID] ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 852 of 1510 : Created [IX_Staging_SyncLog_SyncLogTaskID]';
    END;

GO

PRINT ' 853 of 1510 : Analyzing IX_Staging_SyncLog_SyncLogServerID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Staging_SyncLog_SyncLogServerID') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[IX_Staging_SyncLog_SyncLogServerID]
		ON [dbo].[Staging_SyncLog] ( [SyncLogServerID]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 854 of 1510 : Created [IX_Staging_SyncLog_SyncLogServerID]';
    END;

GO

PRINT ' 855 of 1510 : Analyzing IX_CMS_AutomationState_StateStepID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_AutomationState_StateStepID') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[IX_CMS_AutomationState_StateStepID]
		ON [dbo].[CMS_AutomationState] ( [StateStepID]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 856 of 1510 : Created [IX_CMS_AutomationState_StateStepID]';
    END;

GO

PRINT ' 857 of 1510 : Analyzing IX_CMS_AutomationState_StateObjectID_StateObjectType';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_AutomationState_StateObjectID_StateObjectType') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_CMS_AutomationState_StateObjectID_StateObjectType]
	   ON [dbo].[CMS_AutomationState] ( [StateObjectID]  ASC , [StateObjectType]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 858 of 1510 : Created [IX_CMS_AutomationState_StateObjectID_StateObjectType]';
    END;

GO

PRINT ' 859 of 1510 : Analyzing nonStateSiteID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'nonStateSiteID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [nonStateSiteID]
	   ON [dbo].[CMS_AutomationState] (  [StateSiteID]  ASC , [StateStatus]  ASC) INCLUDE ([StateID] , [StateStepID] , [StateObjectID] , [StateObjectType] , [StateCreated] , [StateWorkflowID] , [StateUserID]) WITH (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 860 of 1510 : Created [nonStateSiteID]';
    END;

GO

PRINT ' 861 of 1510 : Analyzing idx_HFit_TrackerHbA1c_CreateDate';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'idx_HFit_TrackerHbA1c_CreateDate') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [idx_HFit_TrackerHbA1c_CreateDate]
	   ON [dbo].[HFit_TrackerHbA1c] (  [ItemCreatedWhen] ASC , [ItemModifiedWhen]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 862 of 1510 : Created [idx_HFit_TrackerHbA1c_CreateDate]';
    END;

GO

PRINT ' 863 of 1510 : Analyzing IX_Staging_Synchronization_SynchronizationTaskID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Staging_Synchronization_SynchronizationTaskID') --IS NULL
    BEGIN  CREATE NONCLUSTERED INDEX
		 [IX_Staging_Synchronization_SynchronizationTaskID]
		 ON [dbo].[Staging_Synchronization] (  [SynchronizationTaskID]  ASC) 
		 WITH
		 (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 864 of 1510 : Created [IX_Staging_Synchronization_SynchronizationTaskID]';
    END;

GO

PRINT ' 865 of 1510 : Analyzing IX_Staging_Synchronization_SynchronizationServerID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Staging_Synchronization_SynchronizationServerID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_Staging_Synchronization_SynchronizationServerID]
	   ON [dbo].[Staging_Synchronization] ( [SynchronizationServerID]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 866 of 1510 : Created [IX_Staging_Synchronization_SynchronizationServerID]';
    END;

GO

PRINT ' 867 of 1510 : Analyzing IX_OM_IP_IPActiveContactID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_OM_IP_IPActiveContactID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_OM_IP_IPActiveContactID]
	   ON [dbo].[OM_IP] (  [IPActiveContactID]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 868 of 1510 : Created [IX_OM_IP_IPActiveContactID]';
    END;

GO

PRINT ' 869 of 1510 : Analyzing IX_OM_IP_IPOriginalContactID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_OM_IP_IPOriginalContactID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_OM_IP_IPOriginalContactID]
	   ON [dbo].[OM_IP] (  [IPOriginalContactID]  ASC) WITH (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 870 of 1510 : Created [IX_OM_IP_IPOriginalContactID]';
    END;

GO

PRINT ' 871 of 1510 : Analyzing nonPostHealth';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'nonPostHealth') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [nonPostHealth]
	   ON [dbo].[HFit_PostHealthEducation] (  [PostHealthEducationID]  ASC , [PostName]  ASC , [PostTitle]  ASC , [PostImage]  ASC , [Pinned]  ASC , [PinnedExpireDate]  ASC , [PillarID]  ASC , [PersonaID]  ASC) INCLUDE ( [PostBody]) WITH (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 872 of 1510 : Created [nonPostHealth]';
    END;

GO

PRINT ' 873 of 1510 : Analyzing HFit_RewardException_PiDate';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'HFit_RewardException_PiDate') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [HFit_RewardException_PiDate]
	   ON [dbo].[HFit_RewardException] (  [ItemModifiedWhen] ASC) INCLUDE ( [ItemCreatedWhen]) WITH (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 874 of 1510 : Created [HFit_RewardException_PiDate]';
    END;

GO

PRINT ' 875 of 1510 : Analyzing IX_CMS_ACL_ACLInheritedACLs';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_ACL_ACLInheritedACLs') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_CMS_ACL_ACLInheritedACLs]
	   ON [dbo].[CMS_ACL] (  [ACLInheritedACLs]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 876 of 1510 : Created [IX_CMS_ACL_ACLInheritedACLs]';
    END;

GO

PRINT ' 877 of 1510 : Analyzing IX_CMS_ACL_ACLOwnerNodeID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_ACL_ACLOwnerNodeID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_CMS_ACL_ACLOwnerNodeID]
	   ON [dbo].[CMS_ACL] (  [ACLOwnerNodeID]  ASC) 
	   WITH
	   ( PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 878 of 1510 : Created [IX_CMS_ACL_ACLOwnerNodeID]';
    END;

GO

PRINT ' 879 of 1510 : Analyzing IX_COM_Department_DepartmentDisplayName';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_COM_Department_DepartmentDisplayName') --IS NULL
    BEGIN CREATE CLUSTERED INDEX
		[IX_COM_Department_DepartmentDisplayName]
		ON [dbo].[COM_Department] ( [DepartmentDisplayName]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 880 of 1510 : Created [IX_COM_Department_DepartmentDisplayName]';
    END;

GO

PRINT ' 881 of 1510 : Analyzing IX_COM_Department_DepartmentDefaultTaxClassID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_COM_Department_DepartmentDefaultTaxClassID') --IS NULL
    BEGIN  CREATE NONCLUSTERED INDEX
		 [IX_COM_Department_DepartmentDefaultTaxClassID]
		 ON [dbo].[COM_Department] (  [DepartmentDefaultTaxClassID]  ASC) 
		 WITH
		 (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 882 of 1510 : Created [IX_COM_Department_DepartmentDefaultTaxClassID]';
    END;

GO

PRINT ' 883 of 1510 : Analyzing idx_HFit_TrackerSugaryFoods_CreateDate';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'idx_HFit_TrackerSugaryFoods_CreateDate') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[idx_HFit_TrackerSugaryFoods_CreateDate]
		ON [dbo].[HFit_TrackerSugaryFoods] (  [ItemCreatedWhen]  ASC , [ItemModifiedWhen]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 884 of 1510 : Created [idx_HFit_TrackerSugaryFoods_CreateDate]';
    END;

GO

PRINT ' 885 of 1510 : Analyzing IX_OM_Search_SearchActivityID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_OM_Search_SearchActivityID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_OM_Search_SearchActivityID]
	   ON [dbo].[OM_Search] (  [SearchActivityID]  ASC) WITH (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 886 of 1510 : Created [IX_OM_Search_SearchActivityID]';
    END;

GO

PRINT ' 887 of 1510 : Analyzing IX_OM_UserAgent_UserAgentActiveContactID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_OM_UserAgent_UserAgentActiveContactID') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[IX_OM_UserAgent_UserAgentActiveContactID]
		ON [dbo].[OM_UserAgent] ( [UserAgentActiveContactID]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 888 of 1510 : Created [IX_OM_UserAgent_UserAgentActiveContactID]';
    END;

GO

PRINT ' 889 of 1510 : Analyzing IX_OM_UserAgent_UserAgentOriginalContactID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_OM_UserAgent_UserAgentOriginalContactID') --IS NULL
    BEGIN  CREATE NONCLUSTERED INDEX
		 [IX_OM_UserAgent_UserAgentOriginalContactID]
		 ON [dbo].[OM_UserAgent] (  [UserAgentOriginalContactID]  ASC) 
		 WITH
		 (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 890 of 1510 : Created [IX_OM_UserAgent_UserAgentOriginalContactID]';
    END;

GO

PRINT ' 891 of 1510 : Analyzing IX_Board_Board_BoardDocumentID_BoardName';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Board_Board_BoardDocumentID_BoardName') --IS NULL
    BEGIN CREATE  UNIQUE NONCLUSTERED INDEX
		[IX_Board_Board_BoardDocumentID_BoardName]
		ON [dbo].[Board_Board] (  [BoardDocumentID]  ASC , [BoardName]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 892 of 1510 : Created [IX_Board_Board_BoardDocumentID_BoardName]';
    END;

GO

PRINT ' 893 of 1510 : Analyzing IX_Board_Board_BoardGroupID_BoardName';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Board_Board_BoardGroupID_BoardName') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[IX_Board_Board_BoardGroupID_BoardName]
		ON [dbo].[Board_Board] ( [BoardGroupID]  ASC , [BoardName]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 894 of 1510 : Created [IX_Board_Board_BoardGroupID_BoardName]';
    END;

GO

PRINT ' 895 of 1510 : Analyzing IX_Board_Board_BoardUserID_BoardName';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Board_Board_BoardUserID_BoardName') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[IX_Board_Board_BoardUserID_BoardName]
		ON [dbo].[Board_Board] ( [BoardUserID]  ASC , [BoardName]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 896 of 1510 : Created [IX_Board_Board_BoardUserID_BoardName]';
    END;

GO

PRINT ' 897 of 1510 : Analyzing IX_Board_Board_BoardSiteID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Board_Board_BoardSiteID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_Board_Board_BoardSiteID]
	   ON [dbo].[Board_Board] (  [BoardSiteID]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 898 of 1510 : Created [IX_Board_Board_BoardSiteID]';
    END;

GO

PRINT ' 899 of 1510 : Analyzing IX_CMS_SettingsCategory_CategoryOrder';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_SettingsCategory_CategoryOrder') --IS NULL
    BEGIN CREATE CLUSTERED INDEX
		[IX_CMS_SettingsCategory_CategoryOrder]
		ON [dbo].[CMS_SettingsCategory] ( [CategoryOrder]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 900 of 1510 : Created [IX_CMS_SettingsCategory_CategoryOrder]';
    END;

GO

PRINT ' 901 of 1510 : Analyzing IX_OM_PageVisit_PageVisitActivityID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_OM_PageVisit_PageVisitActivityID') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[IX_OM_PageVisit_PageVisitActivityID]
		ON [dbo].[OM_PageVisit] ( [PageVisitActivityID]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 902 of 1510 : Created [IX_OM_PageVisit_PageVisitActivityID]';
    END;

GO

PRINT ' 903 of 1510 : Analyzing IX_CMS_WebTemplate_WebTemplateOrder';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_WebTemplate_WebTemplateOrder') --IS NULL
    BEGIN CREATE CLUSTERED INDEX
		[IX_CMS_WebTemplate_WebTemplateOrder]
		ON [dbo].[CMS_WebTemplate] ( [WebTemplateOrder]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 904 of 1510 : Created [IX_CMS_WebTemplate_WebTemplateOrder]';
    END;

GO

PRINT ' 905 of 1510 : Analyzing idx_HFit_TrackerRestingHeartRate_CreateDate';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'idx_HFit_TrackerRestingHeartRate_CreateDate') --IS NULL
    BEGIN  CREATE NONCLUSTERED INDEX
		 [idx_HFit_TrackerRestingHeartRate_CreateDate]
		 ON [dbo].[HFit_TrackerRestingHeartRate] (  [ItemCreatedWhen]  ASC , [ItemModifiedWhen]  ASC) 
		 WITH
		 ( PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 906 of 1510 : Created [idx_HFit_TrackerRestingHeartRate_CreateDate]';
    END;

GO

PRINT ' 907 of 1510 : Analyzing IX_CMS_WebFarmTask_TaskEnabled';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_WebFarmTask_TaskEnabled') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_CMS_WebFarmTask_TaskEnabled]
	   ON [dbo].[CMS_WebFarmTask] (  [TaskEnabled]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 908 of 1510 : Created [IX_CMS_WebFarmTask_TaskEnabled]';
    END;

GO

PRINT ' 909 of 1510 : Analyzing HFit_LKP_RewardTrigger_PiDate';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'HFit_LKP_RewardTrigger_PiDate') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [HFit_LKP_RewardTrigger_PiDate]
	   ON [dbo].[HFit_LKP_RewardTrigger] ( [ItemModifiedWhen]  ASC) INCLUDE ( [ItemCreatedWhen]) WITH (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 910 of 1510 : Created [HFit_LKP_RewardTrigger_PiDate]';
    END;

GO

PRINT ' 911 of 1510 : Analyzing idx_HFitTrackerSummary_UserID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'idx_HFitTrackerSummary_UserID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [idx_HFitTrackerSummary_UserID]
	   ON [dbo].[HFit_TrackerSummary] (  [UserId]  ASC) INCLUDE ( [WeekendDate] , [TrackerNodeGUID]) WITH (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 912 of 1510 : Created [idx_HFitTrackerSummary_UserID]';
    END;

GO

PRINT ' 913 of 1510 : Analyzing idx_HFitTrackerSummary_WeekendDate';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'idx_HFitTrackerSummary_WeekendDate') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[idx_HFitTrackerSummary_WeekendDate]
		ON [dbo].[HFit_TrackerSummary] ( [WeekendDate]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 914 of 1510 : Created [idx_HFitTrackerSummary_WeekendDate]';
    END;

GO

PRINT ' 915 of 1510 : Analyzing IX_Reporting_SavedReport_SavedReportReportID_SavedReportDate';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Reporting_SavedReport_SavedReportReportID_SavedReportDate') 
    --IS NULL
    BEGIN
	   CREATE CLUSTERED INDEX
	   [IX_Reporting_SavedReport_SavedReportReportID_SavedReportDate]
	   ON [dbo].[Reporting_SavedReport] ( [SavedReportReportID]  ASC , [SavedReportDate] DESC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 916 of 1510 : Created [IX_Reporting_SavedReport_SavedReportReportID_SavedReportDate]';
    END;

GO

PRINT ' 917 of 1510 : Analyzing IX_Reporting_SavedReport_SavedReportCreatedByUserID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Reporting_SavedReport_SavedReportCreatedByUserID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_Reporting_SavedReport_SavedReportCreatedByUserID]
	   ON [dbo].[Reporting_SavedReport] ( [SavedReportCreatedByUserID]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 918 of 1510 : Created [IX_Reporting_SavedReport_SavedReportCreatedByUserID]';
    END;

GO

PRINT ' 919 of 1510 : Analyzing IX_UserGoal_UserID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_UserGoal_UserID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_UserGoal_UserID]
	   ON [dbo].[HFit_UserGoal] (  [UserID]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 920 of 1510 : Created [IX_UserGoal_UserID]';
    END;

GO

PRINT ' 921 of 1510 : Analyzing IX_COM_VolumeDiscount_VolumeDiscountSKUID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_COM_VolumeDiscount_VolumeDiscountSKUID') --IS NULL
    BEGIN  CREATE NONCLUSTERED INDEX
		 [IX_COM_VolumeDiscount_VolumeDiscountSKUID]
		 ON [dbo].[COM_VolumeDiscount] (  [VolumeDiscountSKUID]  ASC) 
		 WITH
		 (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 922 of 1510 : Created [IX_COM_VolumeDiscount_VolumeDiscountSKUID]';
    END;

GO

PRINT ' 923 of 1510 : Analyzing IX_Reporting_SavedGraph_SavedGraphSavedReportID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Reporting_SavedGraph_SavedGraphSavedReportID') --IS NULL
    BEGIN  CREATE NONCLUSTERED INDEX
		 [IX_Reporting_SavedGraph_SavedGraphSavedReportID]
		 ON [dbo].[Reporting_SavedGraph] (  [SavedGraphSavedReportID]  ASC) 
		 WITH
		 (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 924 of 1510 : Created [IX_Reporting_SavedGraph_SavedGraphSavedReportID]';
    END;

GO

PRINT ' 925 of 1510 : Analyzing IX_Reporting_SavedGraph_SavedGraphGUID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Reporting_SavedGraph_SavedGraphGUID') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[IX_Reporting_SavedGraph_SavedGraphGUID]
		ON [dbo].[Reporting_SavedGraph] ( [SavedGraphGUID]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 926 of 1510 : Created [IX_Reporting_SavedGraph_SavedGraphGUID]';
    END;

GO

PRINT ' 927 of 1510 : Analyzing IX_CMS_DocumentAlias_AliasURLPath';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_DocumentAlias_AliasURLPath') 
    --IS NULL
    BEGIN
	   CREATE CLUSTERED INDEX
	   [IX_CMS_DocumentAlias_AliasURLPath]
	   ON [dbo].[CMS_DocumentAlias] (  [AliasURLPath]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 928 of 1510 : Created [IX_CMS_DocumentAlias_AliasURLPath]';
    END;

GO

PRINT ' 929 of 1510 : Analyzing IX_CMS_DocumentAlias_AliasNodeID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_DocumentAlias_AliasNodeID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_CMS_DocumentAlias_AliasNodeID]
	   ON [dbo].[CMS_DocumentAlias] (  [AliasNodeID] ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 930 of 1510 : Created [IX_CMS_DocumentAlias_AliasNodeID]';
    END;

GO

PRINT ' 931 of 1510 : Analyzing IX_CMS_Document_AliasCulture';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_Document_AliasCulture') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_CMS_Document_AliasCulture]
	   ON [dbo].[CMS_DocumentAlias] (  [AliasCulture]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 932 of 1510 : Created [IX_CMS_Document_AliasCulture]';
    END;

GO

PRINT ' 933 of 1510 : Analyzing IX_CMS_DocumentAlias_AliasWildcardRule_AliasPriority';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_DocumentAlias_AliasWildcardRule_AliasPriority') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_CMS_DocumentAlias_AliasWildcardRule_AliasPriority]
	   ON [dbo].[CMS_DocumentAlias] ( [AliasWildcardRule]  ASC , [AliasPriority]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 934 of 1510 : Created [IX_CMS_DocumentAlias_AliasWildcardRule_AliasPriority]';
    END;

GO

PRINT ' 935 of 1510 : Analyzing IX_CMS_DocumentAlias_AliasSiteID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_DocumentAlias_AliasSiteID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_CMS_DocumentAlias_AliasSiteID]
	   ON [dbo].[CMS_DocumentAlias] (  [AliasSiteID] ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 936 of 1510 : Created [IX_CMS_DocumentAlias_AliasSiteID]';
    END;

GO

PRINT ' 937 of 1510 : Analyzing nonChallengeNodeGIUD';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'nonChallengeNodeGIUD') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [nonChallengeNodeGIUD]
	   ON [dbo].[HFit_ChallengeUserRegistration] (  [UserID]  ASC , [SiteID]  ASC , [ChallengeNodeGUID]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 938 of 1510 : Created [nonChallengeNodeGIUD]';
    END;

GO

PRINT ' 939 of 1510 : Analyzing idx_HFit_TrackerHighSodiumFoods_CreateDate';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'idx_HFit_TrackerHighSodiumFoods_CreateDate') --IS NULL
    BEGIN  CREATE NONCLUSTERED INDEX
		 [idx_HFit_TrackerHighSodiumFoods_CreateDate]
		 ON [dbo].[HFit_TrackerHighSodiumFoods] (  [ItemCreatedWhen]  ASC , [ItemModifiedWhen]  ASC) 
		 WITH
		 ( PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 940 of 1510 : Created [idx_HFit_TrackerHighSodiumFoods_CreateDate]';
    END;

GO

PRINT ' 941 of 1510 : Analyzing IX_CMS_ResourceString_StringLoadGeneration';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_ResourceString_StringLoadGeneration') --IS NULL
    BEGIN  CREATE CLUSTERED INDEX
		 [IX_CMS_ResourceString_StringLoadGeneration]
		 ON [dbo].[CMS_ResourceString] (  [StringLoadGeneration]  ASC) 
		 WITH
		 (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 942 of 1510 : Created [IX_CMS_ResourceString_StringLoadGeneration]';
    END;

GO

PRINT ' 943 of 1510 : Analyzing IX_CMS_ResourceString_StringKey';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_ResourceString_StringKey') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_CMS_ResourceString_StringKey]
	   ON [dbo].[CMS_ResourceString] (  [StringKey]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 944 of 1510 : Created [IX_CMS_ResourceString_StringKey]';
    END;

GO

PRINT ' 945 of 1510 : Analyzing idx_HFit_TrackerCholesterol_CreateDate';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'idx_HFit_TrackerCholesterol_CreateDate') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[idx_HFit_TrackerCholesterol_CreateDate]
		ON [dbo].[HFit_TrackerCholesterol] (  [ItemCreatedWhen]  ASC , [ItemModifiedWhen]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 946 of 1510 : Created [idx_HFit_TrackerCholesterol_CreateDate]';
    END;

GO

PRINT ' 947 of 1510 : Analyzing IX_Forums_Forum_ForumGroupID_ForumOrder';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Forums_Forum_ForumGroupID_ForumOrder') --IS NULL
    BEGIN CREATE CLUSTERED INDEX
		[IX_Forums_Forum_ForumGroupID_ForumOrder]
		ON [dbo].[Forums_Forum] ( [ForumGroupID]  ASC , [ForumOrder]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 948 of 1510 : Created [IX_Forums_Forum_ForumGroupID_ForumOrder]';
    END;

GO

PRINT ' 949 of 1510 : Analyzing IX_Forums_Forum_ForumSiteID_ForumName';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Forums_Forum_ForumSiteID_ForumName') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[IX_Forums_Forum_ForumSiteID_ForumName]
		ON [dbo].[Forums_Forum] ( [ForumSiteID]  ASC , [ForumName]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 950 of 1510 : Created [IX_Forums_Forum_ForumSiteID_ForumName]';
    END;

GO

PRINT ' 951 of 1510 : Analyzing IX_Forums_Forum_ForumDocumentID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Forums_Forum_ForumDocumentID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_Forums_Forum_ForumDocumentID]
	   ON [dbo].[Forums_Forum] (  [ForumDocumentID]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 952 of 1510 : Created [IX_Forums_Forum_ForumDocumentID]';
    END;

GO

PRINT ' 953 of 1510 : Analyzing IX_HFit_CentralConfigSiteClientCulture';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_HFit_CentralConfigSiteClientCulture') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[IX_HFit_CentralConfigSiteClientCulture]
		ON [dbo].[HFit_CentralConfig] ( [ConfigSiteName]  ASC , [ConfigClientName]  ASC , [ConfigCultureCode]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 954 of 1510 : Created [IX_HFit_CentralConfigSiteClientCulture]';
    END;

GO

PRINT ' 955 of 1510 : Analyzing IX_HFit_CentralConfigKey';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_HFit_CentralConfigKey') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_HFit_CentralConfigKey]
	   ON [dbo].[HFit_CentralConfig] (  [ConfigKey]  ASC) WITH (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 956 of 1510 : Created [IX_HFit_CentralConfigKey]';
    END;

GO

PRINT ' 957 of 1510 : Analyzing IX_Reporting_ReportValue_ValueName_ValueReportID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Reporting_ReportValue_ValueName_ValueReportID') --IS NULL
    BEGIN  CREATE NONCLUSTERED INDEX
		 [IX_Reporting_ReportValue_ValueName_ValueReportID]
		 ON [dbo].[Reporting_ReportValue] (  [ValueName]  ASC , [ValueReportID]  ASC) 
		 WITH
		 (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 958 of 1510 : Created [IX_Reporting_ReportValue_ValueName_ValueReportID]';
    END;

GO

PRINT ' 959 of 1510 : Analyzing idx_HFit_TrackerInstance_Tracker_CreateDate';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'idx_HFit_TrackerInstance_Tracker_CreateDate') --IS NULL
    BEGIN  CREATE NONCLUSTERED INDEX
		 [idx_HFit_TrackerInstance_Tracker_CreateDate]
		 ON [dbo].[HFit_TrackerInstance_Tracker] (  [ItemCreatedWhen]  ASC , [ItemModifiedWhen]  ASC) 
		 WITH
		 ( PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 960 of 1510 : Created [idx_HFit_TrackerInstance_Tracker_CreateDate]';
    END;

GO

PRINT ' 961 of 1510 : Analyzing IX_Reporting_ReportTable_TableReportID_TableName';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Reporting_ReportTable_TableReportID_TableName') --IS NULL
    BEGIN  CREATE  UNIQUE NONCLUSTERED INDEX
		 [IX_Reporting_ReportTable_TableReportID_TableName]
		 ON [dbo].[Reporting_ReportTable] (  [TableName]  ASC , [TableReportID]  ASC) 
		 WITH
		 (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 962 of 1510 : Created [IX_Reporting_ReportTable_TableReportID_TableName]';
    END;

GO

PRINT ' 963 of 1510 : Analyzing IX_COM_ShoppingCartSKU_ShoppingCartID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_COM_ShoppingCartSKU_ShoppingCartID') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[IX_COM_ShoppingCartSKU_ShoppingCartID]
		ON [dbo].[COM_ShoppingCartSKU] ( [ShoppingCartID]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 964 of 1510 : Created [IX_COM_ShoppingCartSKU_ShoppingCartID]';
    END;

GO

PRINT ' 965 of 1510 : Analyzing IX_COM_ShoppingCartSKU_SKUID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_COM_ShoppingCartSKU_SKUID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_COM_ShoppingCartSKU_SKUID]
	   ON [dbo].[COM_ShoppingCartSKU] (  [SKUID]  ASC) WITH (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 966 of 1510 : Created [IX_COM_ShoppingCartSKU_SKUID]';
    END;

GO

PRINT ' 967 of 1510 : Analyzing IX_Notification_Subscription_SubscriptionGatewayID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Notification_Subscription_SubscriptionGatewayID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_Notification_Subscription_SubscriptionGatewayID]
	   ON [dbo].[Notification_Subscription] ( [SubscriptionGatewayID]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 968 of 1510 : Created [IX_Notification_Subscription_SubscriptionGatewayID]';
    END;

GO

PRINT ' 969 of 1510 : Analyzing IX_Notification_Subscription_SubscriptionTemplateID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Notification_Subscription_SubscriptionTemplateID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_Notification_Subscription_SubscriptionTemplateID]
	   ON [dbo].[Notification_Subscription] ( [SubscriptionTemplateID]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 970 of 1510 : Created [IX_Notification_Subscription_SubscriptionTemplateID]';
    END;

GO

PRINT ' 971 of 1510 : Analyzing entObjectID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Notification_Subscription_SubscriptionEventSource_SubscriptionEventCode_SubscriptionEventObjectID') --IS NULL
    BEGIN  CREATE NONCLUSTERED INDEX
		 [IX_Notification_Subscription_SubscriptionEventSource_SubscriptionEventCode_SubscriptionEventO	bjectID]
		 ON [dbo].[Notification_Subscription] (  [SubscriptionEventSource]  ASC , [SubscriptionEventCode]  ASC , [SubscriptionEventObjectID]  ASC) 
		 WITH
		 (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 972 of 1510 : Created bjectID]';
    END;

GO

PRINT ' 973 of 1510 : Analyzing IX_Notification_Subscription_SubscriptionUserID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Notification_Subscription_SubscriptionUserID') --IS NULL
    BEGIN  CREATE NONCLUSTERED INDEX
		 [IX_Notification_Subscription_SubscriptionUserID]
		 ON [dbo].[Notification_Subscription] (  [SubscriptionUserID]  ASC) 
		 WITH
		 (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 974 of 1510 : Created [IX_Notification_Subscription_SubscriptionUserID]';
    END;

GO

PRINT ' 975 of 1510 : Analyzing IX_Notification_Subscription_SubscriptionSiteID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Notification_Subscription_SubscriptionSiteID') --IS NULL
    BEGIN  CREATE NONCLUSTERED INDEX
		 [IX_Notification_Subscription_SubscriptionSiteID]
		 ON [dbo].[Notification_Subscription] (  [SubscriptionSiteID]  ASC) 
		 WITH
		 (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 976 of 1510 : Created [IX_Notification_Subscription_SubscriptionSiteID]';
    END;

GO

PRINT ' 977 of 1510 : Analyzing idx_HFit_TrackerBodyMeasurements_CreateDate';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'idx_HFit_TrackerBodyMeasurements_CreateDate') --IS NULL
    BEGIN  CREATE NONCLUSTERED INDEX
		 [idx_HFit_TrackerBodyMeasurements_CreateDate]
		 ON [dbo].[HFit_TrackerBodyMeasurements] (  [ItemCreatedWhen]  ASC , [ItemModifiedWhen]  ASC) 
		 WITH
		 ( PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 978 of 1510 : Created [idx_HFit_TrackerBodyMeasurements_CreateDate]';
    END;

GO

PRINT ' 979 of 1510 : Analyzing IX_COM_OrderItem_OrderItemOrderID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_COM_OrderItem_OrderItemOrderID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_COM_OrderItem_OrderItemOrderID]
	   ON [dbo].[COM_OrderItem] (  [OrderItemOrderID] ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 980 of 1510 : Created [IX_COM_OrderItem_OrderItemOrderID]';
    END;

GO

PRINT ' 981 of 1510 : Analyzing IX_COM_OrderItem_OrderItemSKUID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_COM_OrderItem_OrderItemSKUID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_COM_OrderItem_OrderItemSKUID]
	   ON [dbo].[COM_OrderItem] (  [OrderItemSKUID]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 982 of 1510 : Created [IX_COM_OrderItem_OrderItemSKUID]';
    END;

GO

PRINT ' 983 of 1510 : Analyzing idx_HFIT_Tracker_CreateDate';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'idx_HFIT_Tracker_CreateDate') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [idx_HFIT_Tracker_CreateDate]
	   ON [dbo].[HFIT_Tracker] (  [ItemCreatedWhen] DESC , [ItemModifiedWhen] DESC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 984 of 1510 : Created [idx_HFIT_Tracker_CreateDate]';
    END;

GO

PRINT ' 985 of 1510 : Analyzing idxHfitRewardsAwardUserDetail_CreateDate_PI';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'idxHfitRewardsAwardUserDetail_CreateDate_PI') --IS NULL
    BEGIN  CREATE NONCLUSTERED INDEX
		 [idxHfitRewardsAwardUserDetail_CreateDate_PI]
		 ON [dbo].[HFit_RewardsAwardUserDetail] (  [ItemCreatedWhen]  ASC , [ItemModifiedWhen]  ASC) 
		 WITH
		 ( PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 986 of 1510 : Created [idxHfitRewardsAwardUserDetail_CreateDate_PI]';
    END;

GO

PRINT ' 987 of 1510 : Analyzing IX_Reporting_ReportGraph_GraphReportID_GraphName';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Reporting_ReportGraph_GraphReportID_GraphName') --IS NULL
    BEGIN  CREATE  UNIQUE NONCLUSTERED INDEX
		 [IX_Reporting_ReportGraph_GraphReportID_GraphName]
		 ON [dbo].[Reporting_ReportGraph] (  [GraphReportID]  ASC , [GraphName]  ASC) 
		 WITH
		 (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 988 of 1510 : Created [IX_Reporting_ReportGraph_GraphReportID_GraphName]';
    END;

GO

PRINT ' 989 of 1510 : Analyzing IX_Reporting_ReportGraph_GraphGUID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Reporting_ReportGraph_GraphGUID') --IS NULL
    BEGIN CREATE  UNIQUE NONCLUSTERED INDEX
		[IX_Reporting_ReportGraph_GraphGUID]
		ON [dbo].[Reporting_ReportGraph] (  [GraphGUID]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 990 of 1510 : Created [IX_Reporting_ReportGraph_GraphGUID]';
    END;

GO

PRINT ' 991 of 1510 : Analyzing PK_CMS_ObjectVersionHistory';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'PK_CMS_ObjectVersionHistory') 
    --IS NULL
    BEGIN
	   CREATE UNIQUE CLUSTERED INDEX
	   [PK_CMS_ObjectVersionHistory]
	   ON [dbo].[CMS_ObjectVersionHistory] ( [VersionObjectType]  ASC , [VersionObjectID]  ASC , [VersionID] DESC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 992 of 1510 : Created [PK_CMS_ObjectVersionHistory]';
    END;

GO

PRINT ' 993 of 1510 : Analyzing IX_CMS_ObjectVersionHistory_VersionObjectType_VersionObjectID_VersionModifiedWhen';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_ObjectVersionHistory_VersionObjectType_VersionObjectID_VersionModifiedWhen') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[IX_CMS_ObjectVersionHistory_VersionObjectType_VersionObjectID_VersionModifiedWhen]
		ON [dbo].[CMS_ObjectVersionHistory] (  [VersionObjectType]  ASC , [VersionObjectID]  ASC , [VersionModifiedWhen] DESC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 994 of 1510 : Created [IX_CMS_ObjectVersionHistory_VersionObjectType_VersionObjectID_VersionModifiedWhen]';
    END;

GO

PRINT ' 995 of 1510 : Analyzing IX_CMS_ObjectVersionHistory_VersionObjectSiteID_VersionDeletedWhen';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_ObjectVersionHistory_VersionObjectSiteID_VersionDeletedWhen') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_CMS_ObjectVersionHistory_VersionObjectSiteID_VersionDeletedWhen]
	   ON [dbo].[CMS_ObjectVersionHistory] (  [VersionObjectSiteID]  ASC , [VersionDeletedWhen] DESC) 
	   WITH
	   ( PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 996 of 1510 : Created [IX_CMS_ObjectVersionHistory_VersionObjectSiteID_VersionDeletedWhen]';
    END;

GO

PRINT ' 997 of 1510 : Analyzing IX_CMS_ObjectVersionHistory_VersionModifiedByUserID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_ObjectVersionHistory_VersionModifiedByUserID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_CMS_ObjectVersionHistory_VersionModifiedByUserID]
	   ON [dbo].[CMS_ObjectVersionHistory] ( [VersionModifiedByUserID]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 998 of 1510 : Created [IX_CMS_ObjectVersionHistory_VersionModifiedByUserID]';
    END;

GO

PRINT ' 999 of 1510 : Analyzing IX_CMS_ObjectVersionHistory_VersionDeletedByUserID_VersionDeletedWhen';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_ObjectVersionHistory_VersionDeletedByUserID_VersionDeletedWhen') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_CMS_ObjectVersionHistory_VersionDeletedByUserID_VersionDeletedWhen]
	   ON [dbo].[CMS_ObjectVersionHistory] (  [VersionDeletedByUserID]  ASC , [VersionDeletedWhen] DESC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1000 of 1510 : Created [IX_CMS_ObjectVersionHistory_VersionDeletedByUserID_VersionDeletedWhen]';
    END;

GO

PRINT ' 1001 of 1510 : Analyzing IX_Newsletter_Link_LinkIssueID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Newsletter_Link_LinkIssueID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_Newsletter_Link_LinkIssueID]
	   ON [dbo].[Newsletter_Link] (  [LinkIssueID]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1002 of 1510 : Created [IX_Newsletter_Link_LinkIssueID]';
    END;

GO

PRINT ' 1003 of 1510 : Analyzing IX_Notification_TemplateText_TemplateID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Notification_TemplateText_TemplateID') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[IX_Notification_TemplateText_TemplateID]
		ON [dbo].[Notification_TemplateText] (  [TemplateID]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1004 of 1510 : Created [IX_Notification_TemplateText_TemplateID]';
    END;

GO

PRINT ' 1005 of 1510 : Analyzing IX_Notification_TemplateText_GatewayID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Notification_TemplateText_GatewayID') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[IX_Notification_TemplateText_GatewayID]
		ON [dbo].[Notification_TemplateText] (  [GatewayID]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1006 of 1510 : Created [IX_Notification_TemplateText_GatewayID]';
    END;

GO

PRINT ' 1007 of 1510 : Analyzing IX_CMS_Metafile_MetaFileObjectType_MetaFileObjectID_MetaFileGroupName';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_Metafile_MetaFileObjectType_MetaFileObjectID_MetaFileGroupName') 
    --IS NULL
    BEGIN
	   CREATE CLUSTERED INDEX
	   [IX_CMS_Metafile_MetaFileObjectType_MetaFileObjectID_MetaFileGroupName]
	   ON [dbo].[CMS_MetaFile] (  [MetaFileObjectType]  ASC , [MetaFileObjectID]  ASC , [MetaFileGroupName]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1008 of 1510 : Created [IX_CMS_Metafile_MetaFileObjectType_MetaFileObjectID_MetaFileGroupName]';
    END;

GO

PRINT ' 1009 of 1510 : Analyzing roupName';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_MetaFile_MetaFileGUID_MetaFileSiteID_MetaFileObjectType_MetaFileObjectID_MetaFileGroupName') --IS NULL
    BEGIN  CREATE NONCLUSTERED INDEX
		 [IX_CMS_MetaFile_MetaFileGUID_MetaFileSiteID_MetaFileObjectType_MetaFileObjectID_MetaFileGroup	Name]
		 ON [dbo].[CMS_MetaFile] (  [MetaFileGUID]  ASC , [MetaFileSiteID]  ASC , [MetaFileObjectType]  ASC , [MetaFileObjectID]  ASC , [MetaFileGroupName]  ASC) 
		 WITH
		 (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1010 of 1510 : Created Name]';
    END;

GO

PRINT ' 1011 of 1510 : Analyzing IX_CMS_Site_SiteDisplayName';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_Site_SiteDisplayName') 
    --IS NULL
    BEGIN
	   CREATE CLUSTERED INDEX
	   [IX_CMS_Site_SiteDisplayName]
	   ON [dbo].[CMS_Site] (  [SiteDisplayName]  ASC) 
	   WITH
	   ( PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1012 of 1510 : Created [IX_CMS_Site_SiteDisplayName]';
    END;

GO

PRINT ' 1013 of 1510 : Analyzing IX_CMS_Site_SiteName';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_Site_SiteName') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_CMS_Site_SiteName]
	   ON [dbo].[CMS_Site] (  [SiteName]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1014 of 1510 : Created [IX_CMS_Site_SiteName]';
    END;

GO

PRINT ' 1015 of 1510 : Analyzing IX_CMS_Site_SiteDomainName_SiteStatus';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_Site_SiteDomainName_SiteStatus') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[IX_CMS_Site_SiteDomainName_SiteStatus]
		ON [dbo].[CMS_Site] ( [SiteDomainName]  ASC , [SiteStatus]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1016 of 1510 : Created [IX_CMS_Site_SiteDomainName_SiteStatus]';
    END;

GO

PRINT ' 1017 of 1510 : Analyzing IX_CMS_Site_SiteDefaultStylesheetID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_Site_SiteDefaultStylesheetID') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[IX_CMS_Site_SiteDefaultStylesheetID]
		ON [dbo].[CMS_Site] ( [SiteDefaultStylesheetID]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1018 of 1510 : Created [IX_CMS_Site_SiteDefaultStylesheetID]';
    END;

GO

PRINT ' 1019 of 1510 : Analyzing IX_CMS_Site_SiteDefaultEditorStylesheet';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_Site_SiteDefaultEditorStylesheet') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[IX_CMS_Site_SiteDefaultEditorStylesheet]
		ON [dbo].[CMS_Site] ( [SiteDefaultEditorStylesheet]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1020 of 1510 : Created [IX_CMS_Site_SiteDefaultEditorStylesheet]';
    END;

GO

PRINT ' 1021 of 1510 : Analyzing HFit_PPTEligiblity_idx_01';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'HFit_PPTEligiblity_idx_01') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [HFit_PPTEligiblity_idx_01]
	   ON [dbo].[HFit_PPTEligibility] (  [TeamName]  ASC) WITH (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1022 of 1510 : Created [HFit_PPTEligiblity_idx_01]';
    END;

GO

PRINT ' 1023 of 1510 : Analyzing HFit_PPTEligibililty_idx_02';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'HFit_PPTEligibililty_idx_02') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [HFit_PPTEligibililty_idx_02]
	   ON [dbo].[HFit_PPTEligibility] (  [ClientCode]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1024 of 1510 : Created [HFit_PPTEligibililty_idx_02]';
    END;

GO

PRINT ' 1025 of 1510 : Analyzing HFit_PPTEligibility_idx_03';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'HFit_PPTEligibility_idx_03') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [HFit_PPTEligibility_idx_03]
	   ON [dbo].[HFit_PPTEligibility] (  [LastName]  ASC , [FirstName]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1026 of 1510 : Created [HFit_PPTEligibility_idx_03]';
    END;

GO

PRINT ' 1027 of 1510 : Analyzing HFit_PPTEligibililty_idx_04';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'HFit_PPTEligibililty_idx_04') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [HFit_PPTEligibililty_idx_04]
	   ON [dbo].[HFit_PPTEligibility] (  [UserID]  ASC) WITH (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1028 of 1510 : Created [HFit_PPTEligibililty_idx_04]';
    END;

GO

PRINT ' 1029 of 1510 : Analyzing IX_Media_File_FilePath';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Media_File_FilePath') 
    --IS NULL
    BEGIN
	   CREATE CLUSTERED INDEX
	   [IX_Media_File_FilePath]
	   ON [dbo].[Media_File] (  [FilePath]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1030 of 1510 : Created [IX_Media_File_FilePath]';
    END;

GO

PRINT ' 1031 of 1510 : Analyzing IX_Media_File_FileSiteID_FileGUID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Media_File_FileSiteID_FileGUID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_Media_File_FileSiteID_FileGUID]
	   ON [dbo].[Media_File] (  [FileSiteID]  ASC , [FileGUID]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1032 of 1510 : Created [IX_Media_File_FileSiteID_FileGUID]';
    END;

GO

PRINT ' 1033 of 1510 : Analyzing IX_Media_File_FileLibraryID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Media_File_FileLibraryID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_Media_File_FileLibraryID]
	   ON [dbo].[Media_File] (  [FileLibraryID]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1034 of 1510 : Created [IX_Media_File_FileLibraryID]';
    END;

GO

PRINT ' 1035 of 1510 : Analyzing IX_Media_File_FileCreatedByUserID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Media_File_FileCreatedByUserID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_Media_File_FileCreatedByUserID]
	   ON [dbo].[Media_File] (  [FileCreatedByUserID] ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1036 of 1510 : Created [IX_Media_File_FileCreatedByUserID]';
    END;

GO

PRINT ' 1037 of 1510 : Analyzing IX_Media_File_FileModifiedByUserID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Media_File_FileModifiedByUserID') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[IX_Media_File_FileModifiedByUserID]
		ON [dbo].[Media_File] ( [FileModifiedByUserID]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1038 of 1510 : Created [IX_Media_File_FileModifiedByUserID]';
    END;

GO

PRINT ' 1039 of 1510 : Analyzing IX_OM_MVTest_MVTestSiteID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_OM_MVTest_MVTestSiteID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_OM_MVTest_MVTestSiteID]
	   ON [dbo].[OM_MVTest] (  [MVTestSiteID]  ASC) 
	   WITH
	   ( PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1040 of 1510 : Created [IX_OM_MVTest_MVTestSiteID]';
    END;

GO

PRINT ' 1041 of 1510 : Analyzing IX_CMS_SiteDomainAlias_SiteDomainAliasName';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_SiteDomainAlias_SiteDomainAliasName') --IS NULL
    BEGIN  CREATE NONCLUSTERED INDEX
		 [IX_CMS_SiteDomainAlias_SiteDomainAliasName]
		 ON [dbo].[CMS_SiteDomainAlias] (  [SiteDomainAliasName]  ASC) 
		 WITH
		 (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1042 of 1510 : Created [IX_CMS_SiteDomainAlias_SiteDomainAliasName]';
    END;

GO

PRINT ' 1043 of 1510 : Analyzing IX_CMS_SiteDomainAlias_SiteID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_SiteDomainAlias_SiteID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_CMS_SiteDomainAlias_SiteID]
	   ON [dbo].[CMS_SiteDomainAlias] (  [SiteID]  ASC) WITH (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1044 of 1510 : Created [IX_CMS_SiteDomainAlias_SiteID]';
    END;

GO

PRINT ' 1045 of 1510 : Analyzing idx_HFit_TrackerHeight_CreateDate';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'idx_HFit_TrackerHeight_CreateDate') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [idx_HFit_TrackerHeight_CreateDate]
	   ON [dbo].[HFit_TrackerHeight] ( [ItemCreatedWhen]  ASC , [ItemModifiedWhen]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1046 of 1510 : Created [idx_HFit_TrackerHeight_CreateDate]';
    END;

GO

PRINT ' 1047 of 1510 : Analyzing IX_NC_Hfit_HealthAssessmentDataForImport';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_NC_Hfit_HealthAssessmentDataForImport') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[IX_NC_Hfit_HealthAssessmentDataForImport]
		ON [dbo].[Hfit_HealthAssessmentDataForImport] (  [QuestionCodeName]  ASC) INCLUDE ( [AnswerCodeName]) WITH (  PAD_INDEX = OFF , FILLFACTOR = 100 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1048 of 1510 : Created [IX_NC_Hfit_HealthAssessmentDataForImport]';
    END;

GO

PRINT ' 1049 of 1510 : Analyzing IX_OM_Account_AccountStateID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_OM_Account_AccountStateID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_OM_Account_AccountStateID]
	   ON [dbo].[OM_Account] (  [AccountStateID]  ASC) WITH (  PAD_INDEX = OFF , FILLFACTOR = 90 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1050 of 1510 : Created [IX_OM_Account_AccountStateID]';
    END;

GO

PRINT ' 1051 of 1510 : Analyzing IX_OM_Account_AccountCountryID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_OM_Account_AccountCountryID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_OM_Account_AccountCountryID]
	   ON [dbo].[OM_Account] (  [AccountCountryID]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 90 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1052 of 1510 : Created [IX_OM_Account_AccountCountryID]';
    END;

GO

PRINT ' 1053 of 1510 : Analyzing IX_OM_Account_AccountPrimaryContactID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_OM_Account_AccountPrimaryContactID') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[IX_OM_Account_AccountPrimaryContactID]
		ON [dbo].[OM_Account] ( [AccountPrimaryContactID]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 90 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1054 of 1510 : Created [IX_OM_Account_AccountPrimaryContactID]';
    END;

GO

PRINT ' 1055 of 1510 : Analyzing IX_OM_Account_AccountSecondaryContactID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_OM_Account_AccountSecondaryContactID') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[IX_OM_Account_AccountSecondaryContactID]
		ON [dbo].[OM_Account] ( [AccountSecondaryContactID]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 90 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1056 of 1510 : Created [IX_OM_Account_AccountSecondaryContactID]';
    END;

GO

PRINT ' 1057 of 1510 : Analyzing IX_OM_Account_AccountStatusID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_OM_Account_AccountStatusID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_OM_Account_AccountStatusID]
	   ON [dbo].[OM_Account] (  [AccountStatusID]  ASC) WITH (  PAD_INDEX = OFF , FILLFACTOR = 90 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1058 of 1510 : Created [IX_OM_Account_AccountStatusID]';
    END;

GO

PRINT ' 1059 of 1510 : Analyzing IX_OM_Account_AccountOwnerUserID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_OM_Account_AccountOwnerUserID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_OM_Account_AccountOwnerUserID]
	   ON [dbo].[OM_Account] (  [AccountOwnerUserID] ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 90 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1060 of 1510 : Created [IX_OM_Account_AccountOwnerUserID]';
    END;

GO

PRINT ' 1061 of 1510 : Analyzing IX_OM_Account_AccountSubsidiaryOfID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_OM_Account_AccountSubsidiaryOfID') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[IX_OM_Account_AccountSubsidiaryOfID]
		ON [dbo].[OM_Account] ( [AccountSubsidiaryOfID]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 90 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1062 of 1510 : Created [IX_OM_Account_AccountSubsidiaryOfID]';
    END;

GO

PRINT ' 1063 of 1510 : Analyzing IX_OM_Account_AccountMergedWithAccountID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_OM_Account_AccountMergedWithAccountID') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[IX_OM_Account_AccountMergedWithAccountID]
		ON [dbo].[OM_Account] ( [AccountMergedWithAccountID]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 90 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1064 of 1510 : Created [IX_OM_Account_AccountMergedWithAccountID]';
    END;

GO

PRINT ' 1065 of 1510 : Analyzing IX_OM_Account_AccountSiteID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_OM_Account_AccountSiteID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_OM_Account_AccountSiteID]
	   ON [dbo].[OM_Account] (  [AccountSiteID]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 90 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1066 of 1510 : Created [IX_OM_Account_AccountSiteID]';
    END;

GO

PRINT ' 1067 of 1510 : Analyzing IX_OM_Account_AccountGlobalAccountID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_OM_Account_AccountGlobalAccountID') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[IX_OM_Account_AccountGlobalAccountID]
		ON [dbo].[OM_Account] ( [AccountGlobalAccountID]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 90 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1068 of 1510 : Created [IX_OM_Account_AccountGlobalAccountID]';
    END;

GO

PRINT ' 1069 of 1510 : Analyzing IDX_ConfigFeatures_RoleID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IDX_ConfigFeatures_RoleID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IDX_ConfigFeatures_RoleID]
	   ON [dbo].[HFit_configFeatures] (  [RoleID]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1070 of 1510 : Created [IDX_ConfigFeatures_RoleID]';
    END;

GO

PRINT ' 1071 of 1510 : Analyzing IDX_ConfigFeatures_ParentRoleID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IDX_ConfigFeatures_ParentRoleID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IDX_ConfigFeatures_ParentRoleID]
	   ON [dbo].[HFit_configFeatures] (  [ParentRoleID] ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1072 of 1510 : Created [IDX_ConfigFeatures_ParentRoleID]';
    END;

GO

PRINT ' 1073 of 1510 : Analyzing IDX_ConfigFeatures_SiteID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IDX_ConfigFeatures_SiteID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IDX_ConfigFeatures_SiteID]
	   ON [dbo].[HFit_configFeatures] (  [SiteID]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1074 of 1510 : Created [IDX_ConfigFeatures_SiteID]';
    END;

GO

PRINT ' 1075 of 1510 : Analyzing IX_CMS_Workflow_WorkflowDisplayName';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_Workflow_WorkflowDisplayName') --IS NULL
    BEGIN CREATE CLUSTERED INDEX
		[IX_CMS_Workflow_WorkflowDisplayName]
		ON [dbo].[CMS_Workflow] ( [WorkflowDisplayName]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 90 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1076 of 1510 : Created [IX_CMS_Workflow_WorkflowDisplayName]';
    END;

GO

PRINT ' 1077 of 1510 : Analyzing idx_HFit_TrackerTobaccoFree_CreateDate';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'idx_HFit_TrackerTobaccoFree_CreateDate') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[idx_HFit_TrackerTobaccoFree_CreateDate]
		ON [dbo].[HFit_TrackerTobaccoFree] (  [ItemCreatedWhen]  ASC , [ItemModifiedWhen]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 100 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1078 of 1510 : Created [idx_HFit_TrackerTobaccoFree_CreateDate]';
    END;

GO

PRINT ' 1079 of 1510 : Analyzing IX_OM_MVTCombination_MVTCombinationPageTemplateID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_OM_MVTCombination_MVTCombinationPageTemplateID') --IS NULL
    BEGIN  CREATE NONCLUSTERED INDEX
		 [IX_OM_MVTCombination_MVTCombinationPageTemplateID]
		 ON [dbo].[OM_MVTCombination] (  [MVTCombinationPageTemplateID]  ASC) 
		 WITH
		 (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1080 of 1510 : Created [IX_OM_MVTCombination_MVTCombinationPageTemplateID]';
    END;

GO

PRINT ' 1081 of 1510 : Analyzing IDX_FeaturesToGroups_ContactGroupMembershipID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IDX_FeaturesToGroups_ContactGroupMembershipID') --IS NULL
    BEGIN  CREATE NONCLUSTERED INDEX
		 [IDX_FeaturesToGroups_ContactGroupMembershipID]
		 ON [dbo].[HFit_configGroupToFeature] (  [ContactGroupMembershipID]  ASC) 
		 WITH
		 (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1082 of 1510 : Created [IDX_FeaturesToGroups_ContactGroupMembershipID]';
    END;

GO

PRINT ' 1083 of 1510 : Analyzing IDX_ConfigGroupToFeatures_ConfigFeatureID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IDX_ConfigGroupToFeatures_ConfigFeatureID') --IS NULL
    BEGIN  CREATE NONCLUSTERED INDEX
		 [IDX_ConfigGroupToFeatures_ConfigFeatureID]
		 ON [dbo].[HFit_configGroupToFeature] (  [configFeatureID]  ASC) 
		 WITH
		 (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1084 of 1510 : Created [IDX_ConfigGroupToFeatures_ConfigFeatureID]';
    END;

GO

PRINT ' 1085 of 1510 : Analyzing nonFeatureIDItemID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'nonFeatureIDItemID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [nonFeatureIDItemID]
	   ON [dbo].[HFit_configGroupToFeature] (  [configFeatureID]  ASC , [ItemID]  ASC , [ContactGroupMembershipID]  ASC , [ValidFromDate]  ASC , [ValidToDate]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1086 of 1510 : Created [nonFeatureIDItemID]';
    END;

GO

PRINT ' 1087 of 1510 : Analyzing IDX_ConfigGroupToFeatures_SiteID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IDX_ConfigGroupToFeatures_SiteID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IDX_ConfigGroupToFeatures_SiteID]
	   ON [dbo].[HFit_configGroupToFeature] (  [SiteID] ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1088 of 1510 : Created [IDX_ConfigGroupToFeatures_SiteID]';
    END;

GO

PRINT ' 1089 of 1510 : Analyzing IX_CMS_ScheduledTask_TaskNextRunTime_TaskEnabled_TaskServerName';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_ScheduledTask_TaskNextRunTime_TaskEnabled_TaskServerName') 
    --IS NULL
    BEGIN
	   CREATE CLUSTERED INDEX
	   [IX_CMS_ScheduledTask_TaskNextRunTime_TaskEnabled_TaskServerName]
	   ON [dbo].[CMS_ScheduledTask] (  [TaskNextRunTime]  ASC , [TaskEnabled]  ASC , [TaskServerName]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1090 of 1510 : Created [IX_CMS_ScheduledTask_TaskNextRunTime_TaskEnabled_TaskServerName]';
    END;

GO

PRINT ' 1091 of 1510 : Analyzing IX_CMS_ScheduledTask_TaskSiteID_TaskDisplayName';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_ScheduledTask_TaskSiteID_TaskDisplayName') --IS NULL
    BEGIN  CREATE NONCLUSTERED INDEX
		 [IX_CMS_ScheduledTask_TaskSiteID_TaskDisplayName]
		 ON [dbo].[CMS_ScheduledTask] (  [TaskSiteID]  ASC , [TaskDisplayName]  ASC) 
		 WITH
		 (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1092 of 1510 : Created [IX_CMS_ScheduledTask_TaskSiteID_TaskDisplayName]';
    END;

GO

PRINT ' 1093 of 1510 : Analyzing IX_ScheduledTaskEnabled';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_ScheduledTaskEnabled') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_ScheduledTaskEnabled]
	   ON [dbo].[CMS_ScheduledTask] (  [TaskEnabled]  ASC , [TaskNextRunTime]  ASC , [TaskSiteID]  ASC , [TaskServerName]  ASC , [TaskUseExternalService]  ASC) INCLUDE ( [TaskID]) WITH (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1094 of 1510 : Created [IX_ScheduledTaskEnabled]';
    END;

GO

PRINT ' 1095 of 1510 : Analyzing IX_COM_ShoppingCart_ShoppingCartSiteID_ShoppingCartGUID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_COM_ShoppingCart_ShoppingCartSiteID_ShoppingCartGUID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_COM_ShoppingCart_ShoppingCartSiteID_ShoppingCartGUID]
	   ON [dbo].[COM_ShoppingCart] ( [ShoppingCartGUID]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 90 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1096 of 1510 : Created [IX_COM_ShoppingCart_ShoppingCartSiteID_ShoppingCartGUID]';
    END;

GO

PRINT ' 1097 of 1510 : Analyzing IX_COM_ShoppingCart_ShoppingCartUserID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_COM_ShoppingCart_ShoppingCartUserID') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[IX_COM_ShoppingCart_ShoppingCartUserID]
		ON [dbo].[COM_ShoppingCart] ( [ShoppingCartUserID]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 90 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1098 of 1510 : Created [IX_COM_ShoppingCart_ShoppingCartUserID]';
    END;

GO

PRINT ' 1099 of 1510 : Analyzing IX_COM_ShoppingCart_ShoppingCartLastUpdate';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_COM_ShoppingCart_ShoppingCartLastUpdate') --IS NULL
    BEGIN  CREATE NONCLUSTERED INDEX
		 [IX_COM_ShoppingCart_ShoppingCartLastUpdate]
		 ON [dbo].[COM_ShoppingCart] (  [ShoppingCartLastUpdate]  ASC) 
		 WITH
		 (  PAD_INDEX = OFF , FILLFACTOR = 90 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1100 of 1510 : Created [IX_COM_ShoppingCart_ShoppingCartLastUpdate]';
    END;

GO

PRINT ' 1101 of 1510 : Analyzing IX_COM_ShoppingCart_ShoppingCartCurrencyID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_COM_ShoppingCart_ShoppingCartCurrencyID') --IS NULL
    BEGIN  CREATE NONCLUSTERED INDEX
		 [IX_COM_ShoppingCart_ShoppingCartCurrencyID]
		 ON [dbo].[COM_ShoppingCart] (  [ShoppingCartCurrencyID]  ASC) 
		 WITH
		 (  PAD_INDEX = OFF , FILLFACTOR = 90 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1102 of 1510 : Created [IX_COM_ShoppingCart_ShoppingCartCurrencyID]';
    END;

GO

PRINT ' 1103 of 1510 : Analyzing IX_COM_ShoppingCart_ShoppingCartPaymentOptionID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_COM_ShoppingCart_ShoppingCartPaymentOptionID') --IS NULL
    BEGIN  CREATE NONCLUSTERED INDEX
		 [IX_COM_ShoppingCart_ShoppingCartPaymentOptionID]
		 ON [dbo].[COM_ShoppingCart] (  [ShoppingCartPaymentOptionID]  ASC) 
		 WITH
		 (  PAD_INDEX = OFF , FILLFACTOR = 90 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1104 of 1510 : Created [IX_COM_ShoppingCart_ShoppingCartPaymentOptionID]';
    END;

GO

PRINT ' 1105 of 1510 : Analyzing IX_COM_ShoppingCart_ShoppingCartShippingOptionID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_COM_ShoppingCart_ShoppingCartShippingOptionID') --IS NULL
    BEGIN  CREATE NONCLUSTERED INDEX
		 [IX_COM_ShoppingCart_ShoppingCartShippingOptionID]
		 ON [dbo].[COM_ShoppingCart] (  [ShoppingCartShippingOptionID]  ASC) 
		 WITH
		 (  PAD_INDEX = OFF , FILLFACTOR = 90 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1106 of 1510 : Created [IX_COM_ShoppingCart_ShoppingCartShippingOptionID]';
    END;

GO

PRINT ' 1107 of 1510 : Analyzing IX_COM_ShoppingCart_ShoppingCartDiscountCouponID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_COM_ShoppingCart_ShoppingCartDiscountCouponID') --IS NULL
    BEGIN  CREATE NONCLUSTERED INDEX
		 [IX_COM_ShoppingCart_ShoppingCartDiscountCouponID]
		 ON [dbo].[COM_ShoppingCart] (  [ShoppingCartDiscountCouponID]  ASC) 
		 WITH
		 (  PAD_INDEX = OFF , FILLFACTOR = 90 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1108 of 1510 : Created [IX_COM_ShoppingCart_ShoppingCartDiscountCouponID]';
    END;

GO

PRINT ' 1109 of 1510 : Analyzing IX_COM_ShoppingCart_ShoppingCartBillingAddressID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_COM_ShoppingCart_ShoppingCartBillingAddressID') --IS NULL
    BEGIN  CREATE NONCLUSTERED INDEX
		 [IX_COM_ShoppingCart_ShoppingCartBillingAddressID]
		 ON [dbo].[COM_ShoppingCart] (  [ShoppingCartBillingAddressID]  ASC) 
		 WITH
		 (  PAD_INDEX = OFF , FILLFACTOR = 90 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1110 of 1510 : Created [IX_COM_ShoppingCart_ShoppingCartBillingAddressID]';
    END;

GO

PRINT ' 1111 of 1510 : Analyzing IX_COM_ShoppingCart_ShoppingCartShippingAddressID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_COM_ShoppingCart_ShoppingCartShippingAddressID') --IS NULL
    BEGIN  CREATE NONCLUSTERED INDEX
		 [IX_COM_ShoppingCart_ShoppingCartShippingAddressID]
		 ON [dbo].[COM_ShoppingCart] (  [ShoppingCartShippingAddressID]  ASC) 
		 WITH
		 (  PAD_INDEX = OFF , FILLFACTOR = 90 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1112 of 1510 : Created [IX_COM_ShoppingCart_ShoppingCartShippingAddressID]';
    END;

GO

PRINT ' 1113 of 1510 : Analyzing IX_COM_ShoppingCart_ShoppingCartCustomerID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_COM_ShoppingCart_ShoppingCartCustomerID') --IS NULL
    BEGIN  CREATE NONCLUSTERED INDEX
		 [IX_COM_ShoppingCart_ShoppingCartCustomerID]
		 ON [dbo].[COM_ShoppingCart] (  [ShoppingCartCustomerID]  ASC) 
		 WITH
		 (  PAD_INDEX = OFF , FILLFACTOR = 90 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1114 of 1510 : Created [IX_COM_ShoppingCart_ShoppingCartCustomerID]';
    END;

GO

PRINT ' 1115 of 1510 : Analyzing IX_COM_ShoppingCart_ShoppingCartCompanyAddressID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_COM_ShoppingCart_ShoppingCartCompanyAddressID') --IS NULL
    BEGIN  CREATE NONCLUSTERED INDEX
		 [IX_COM_ShoppingCart_ShoppingCartCompanyAddressID]
		 ON [dbo].[COM_ShoppingCart] (  [ShoppingCartCompanyAddressID]  ASC) 
		 WITH
		 (  PAD_INDEX = OFF , FILLFACTOR = 90 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1116 of 1510 : Created [IX_COM_ShoppingCart_ShoppingCartCompanyAddressID]';
    END;

GO

PRINT ' 1117 of 1510 : Analyzing IX_OM_ABVariant_ABVariantTestID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_OM_ABVariant_ABVariantTestID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_OM_ABVariant_ABVariantTestID]
	   ON [dbo].[OM_ABVariant] (  [ABVariantTestID]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 90 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1118 of 1510 : Created [IX_OM_ABVariant_ABVariantTestID]';
    END;

GO

PRINT ' 1119 of 1510 : Analyzing IX_OM_ABVariant_ABVariantSiteID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_OM_ABVariant_ABVariantSiteID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_OM_ABVariant_ABVariantSiteID]
	   ON [dbo].[OM_ABVariant] (  [ABVariantSiteID]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 90 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1120 of 1510 : Created [IX_OM_ABVariant_ABVariantSiteID]';
    END;

GO

PRINT ' 1121 of 1510 : Analyzing idx_UserID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'idx_UserID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [idx_UserID]
	   ON [dbo].[HFit_HealthAssesmentUserStarted] (  [UserID]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1122 of 1510 : Created [idx_UserID]';
    END;

GO

PRINT ' 1123 of 1510 : Analyzing IX_CMS_UserSite_UserID_SiteID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_UserSite_UserID_SiteID') 
    --IS NULL
    BEGIN
	   CREATE UNIQUE NONCLUSTERED INDEX
	   [IX_CMS_UserSite_UserID_SiteID]
	   ON [dbo].[CMS_UserSite] (  [UserID]  ASC , [SiteID]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1124 of 1510 : Created [IX_CMS_UserSite_UserID_SiteID]';
    END;

GO

PRINT ' 1125 of 1510 : Analyzing PI_CMS_UserSite_SiteID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'PI_CMS_UserSite_SiteID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [PI_CMS_UserSite_SiteID]
	   ON [dbo].[CMS_UserSite] (  [SiteID]  ASC) INCLUDE ([UserID]) WITH (  PAD_INDEX = OFF , FILLFACTOR = 100 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1126 of 1510 : Created [PI_CMS_UserSite_SiteID]';
    END;

GO

PRINT ' 1127 of 1510 : Analyzing ix_CmsUserSite_Userid_PI';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'ix_CmsUserSite_Userid_PI') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [ix_CmsUserSite_Userid_PI]
	   ON [dbo].[CMS_UserSite] (  [UserID]  ASC) INCLUDE ([UserSiteID]) WITH (  PAD_INDEX = OFF , FILLFACTOR = 100 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1128 of 1510 : Created [ix_CmsUserSite_Userid_PI]';
    END;

GO

PRINT ' 1129 of 1510 : Analyzing IX_COM_Customer_CustomerLastName_CustomerFirstName_CustomerEnabled';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_COM_Customer_CustomerLastName_CustomerFirstName_CustomerEnabled') 
    --IS NULL
    BEGIN
	   CREATE CLUSTERED INDEX
	   [IX_COM_Customer_CustomerLastName_CustomerFirstName_CustomerEnabled]
	   ON [dbo].[COM_Customer] ( [CustomerLastName]  ASC , [CustomerFirstName]  ASC , [CustomerEnabled]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 90 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1130 of 1510 : Created [IX_COM_Customer_CustomerLastName_CustomerFirstName_CustomerEnabled]';
    END;

GO

PRINT ' 1131 of 1510 : Analyzing IX_COM_Customer_CustomerEmail';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_COM_Customer_CustomerEmail') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_COM_Customer_CustomerEmail]
	   ON [dbo].[COM_Customer] (  [CustomerEmail]  ASC) WITH (  PAD_INDEX = OFF , FILLFACTOR = 90 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1132 of 1510 : Created [IX_COM_Customer_CustomerEmail]';
    END;

GO

PRINT ' 1133 of 1510 : Analyzing IX_COM_Customer_CustomerCompany';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_COM_Customer_CustomerCompany') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_COM_Customer_CustomerCompany]
	   ON [dbo].[COM_Customer] (  [CustomerCompany]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 90 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1134 of 1510 : Created [IX_COM_Customer_CustomerCompany]';
    END;

GO

PRINT ' 1135 of 1510 : Analyzing IX_COM_Customer_CustomerUserID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_COM_Customer_CustomerUserID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_COM_Customer_CustomerUserID]
	   ON [dbo].[COM_Customer] (  [CustomerUserID]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 90 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1136 of 1510 : Created [IX_COM_Customer_CustomerUserID]';
    END;

GO

PRINT ' 1137 of 1510 : Analyzing IX_COM_Customer_CustomerPreferredCurrencyID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_COM_Customer_CustomerPreferredCurrencyID') --IS NULL
    BEGIN  CREATE NONCLUSTERED INDEX
		 [IX_COM_Customer_CustomerPreferredCurrencyID]
		 ON [dbo].[COM_Customer] (  [CustomerPreferredCurrencyID]  ASC) 
		 WITH
		 (  PAD_INDEX = OFF , FILLFACTOR = 90 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1138 of 1510 : Created [IX_COM_Customer_CustomerPreferredCurrencyID]';
    END;

GO

PRINT ' 1139 of 1510 : Analyzing IX_COM_Customer_CustomerPreferredShippingOptionID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_COM_Customer_CustomerPreferredShippingOptionID') --IS NULL
    BEGIN  CREATE NONCLUSTERED INDEX
		 [IX_COM_Customer_CustomerPreferredShippingOptionID]
		 ON [dbo].[COM_Customer] (  [CustomerPreferredShippingOptionID]  ASC) 
		 WITH
		 (  PAD_INDEX = OFF , FILLFACTOR = 90 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1140 of 1510 : Created [IX_COM_Customer_CustomerPreferredShippingOptionID]';
    END;

GO

PRINT ' 1141 of 1510 : Analyzing IX_COM_Customer_CustomerCountryID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_COM_Customer_CustomerCountryID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_COM_Customer_CustomerCountryID]
	   ON [dbo].[COM_Customer] (  [CustomerCountryID] ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 90 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1142 of 1510 : Created [IX_COM_Customer_CustomerCountryID]';
    END;

GO

PRINT ' 1143 of 1510 : Analyzing IX_COM_Customer_CustomerPrefferedPaymentOptionID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_COM_Customer_CustomerPrefferedPaymentOptionID') --IS NULL
    BEGIN  CREATE NONCLUSTERED INDEX
		 [IX_COM_Customer_CustomerPrefferedPaymentOptionID]
		 ON [dbo].[COM_Customer] (  [CustomerPrefferedPaymentOptionID]  ASC) 
		 WITH
		 (  PAD_INDEX = OFF , FILLFACTOR = 90 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1144 of 1510 : Created [IX_COM_Customer_CustomerPrefferedPaymentOptionID]';
    END;

GO

PRINT ' 1145 of 1510 : Analyzing IX_COM_Customer_CustomerStateID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_COM_Customer_CustomerStateID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_COM_Customer_CustomerStateID]
	   ON [dbo].[COM_Customer] (  [CustomerStateID]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 90 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1146 of 1510 : Created [IX_COM_Customer_CustomerStateID]';
    END;

GO

PRINT ' 1147 of 1510 : Analyzing IX_COM_Customer_CustomerDiscountLevelID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_COM_Customer_CustomerDiscountLevelID') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[IX_COM_Customer_CustomerDiscountLevelID]
		ON [dbo].[COM_Customer] ( [CustomerDiscountLevelID]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 90 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1148 of 1510 : Created [IX_COM_Customer_CustomerDiscountLevelID]';
    END;

GO

PRINT ' 1149 of 1510 : Analyzing idx_HFit_TrackerShots_CreateDate';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'idx_HFit_TrackerShots_CreateDate') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [idx_HFit_TrackerShots_CreateDate]
	   ON [dbo].[HFit_TrackerShots] (  [ItemCreatedWhen] ASC , [ItemModifiedWhen]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 100 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1150 of 1510 : Created [idx_HFit_TrackerShots_CreateDate]';
    END;

GO

PRINT ' 1151 of 1510 : Analyzing IX_CMS_AttachmentHistory_AttachmentDocumentID_AttachmentName';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_AttachmentHistory_AttachmentDocumentID_AttachmentName') 
    --IS NULL
    BEGIN
	   CREATE CLUSTERED INDEX
	   [IX_CMS_AttachmentHistory_AttachmentDocumentID_AttachmentName]
	   ON [dbo].[CMS_AttachmentHistory] ( [AttachmentDocumentID]  ASC , [AttachmentName]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1152 of 1510 : Created [IX_CMS_AttachmentHistory_AttachmentDocumentID_AttachmentName]';
    END;

GO

PRINT ' 1153 of 1510 : Analyzing IX_CMS_AttachmentHistory_AttachmentGUID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_AttachmentHistory_AttachmentGUID') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[IX_CMS_AttachmentHistory_AttachmentGUID]
		ON [dbo].[CMS_AttachmentHistory] (  [AttachmentGUID]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1154 of 1510 : Created [IX_CMS_AttachmentHistory_AttachmentGUID]';
    END;

GO

PRINT ' 1155 of 1510 : Analyzing IX_CMS_AttachmentHistory_AttachmentIsUnsorted_AttachmentGroupGUID_AttachmentOrder';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_AttachmentHistory_AttachmentIsUnsorted_AttachmentGroupGUID_AttachmentOrder') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[IX_CMS_AttachmentHistory_AttachmentIsUnsorted_AttachmentGroupGUID_AttachmentOrder]
		ON [dbo].[CMS_AttachmentHistory] (  [AttachmentIsUnsorted]  ASC , [AttachmentGroupGUID]  ASC , [AttachmentOrder]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1156 of 1510 : Created [IX_CMS_AttachmentHistory_AttachmentIsUnsorted_AttachmentGroupGUID_AttachmentOrder]';
    END;

GO

PRINT ' 1157 of 1510 : Analyzing IX_CMS_Personalization_PersonalizationUserID_PersonalizationDocumentID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_Personalization_PersonalizationUserID_PersonalizationDocumentID') 
    --IS NULL
    BEGIN
	   CREATE CLUSTERED INDEX
	   [IX_CMS_Personalization_PersonalizationUserID_PersonalizationDocumentID]
	   ON [dbo].[CMS_Personalization] (  [PersonalizationDocumentID]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1158 of 1510 : Created [IX_CMS_Personalization_PersonalizationUserID_PersonalizationDocumentID]';
    END;

GO

PRINT ' 1159 of 1510 : Analyzing PersonalizationDashboardName';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_Personalization_PersonalizationID_PersonalizationUserID_PersonalizationDocumentID_PersonalizationDashboardName') --IS NULL
    BEGIN  CREATE  UNIQUE NONCLUSTERED INDEX
		 [IX_CMS_Personalization_PersonalizationID_PersonalizationUserID_PersonalizationDocumentID_Pers	onalizationDashboardName]
		 ON [dbo].[CMS_Personalization] (  [PersonalizationID]  ASC , [PersonalizationUserID]  ASC , [PersonalizationDocumentID]  ASC , [PersonalizationDashboardName]  ASC) 
		 WITH
		 (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1160 of 1510 : Created onalizationDashboardName]';
    END;

GO

PRINT ' 1161 of 1510 : Analyzing IX_CMS_Personalization_PersonalizationSiteID_SiteID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_Personalization_PersonalizationSiteID_SiteID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_CMS_Personalization_PersonalizationSiteID_SiteID]
	   ON [dbo].[CMS_Personalization] ( [PersonalizationSiteID]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1162 of 1510 : Created [IX_CMS_Personalization_PersonalizationSiteID_SiteID]';
    END;

GO

PRINT ' 1163 of 1510 : Analyzing nonActiveTip';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'nonActiveTip') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [nonActiveTip]
	   ON [dbo].[HFit_TipOfTheDay] (  [Active]  ASC , [TipOfTheDayCategoryID]  ASC , [TipOfTheDayID]  ASC) INCLUDE ( [Title] , [Details] , [Source]) WITH (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1164 of 1510 : Created [nonActiveTip]';
    END;

GO

PRINT ' 1165 of 1510 : Analyzing nonUserID';
GO

IF NOT EXISTS (SELECT [name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'nonUserID') 
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [nonUserID]
	   ON [dbo].[HFit_Ref_RewardTrackerValidation] (  [UserId]  ASC , [TrackerType]  ASC , [RewardActivityNodeId]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1166 of 1510 : Created [nonUserID]';
    END;

GO

PRINT ' 1167 of 1510 : Analyzing r';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_Attachment_AttachmentDocumentID_AttachmentIsUnsorted_AttachmentName_AttachmentOrder') --IS NULL
    BEGIN  CREATE CLUSTERED INDEX
		 [IX_CMS_Attachment_AttachmentDocumentID_AttachmentIsUnsorted_AttachmentName_AttachmentOrder]
		 ON [dbo].[CMS_Attachment] (  [AttachmentDocumentID]  ASC , [AttachmentName]  ASC , [AttachmentIsUnsorted] ASC , [AttachmentOrder]  ASC) 
		 WITH
		 (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1168 of 1510 : Created [IX_CMS_Attachment_AttachmentDocumentID_AttachmentIsUnsorted_AttachmentName_AttachmentOrder]';
    END;

GO

PRINT ' 1169 of 1510 : Analyzing IX_CMS_Attachment_AttachmentGUID_AttachmentSiteID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_Attachment_AttachmentGUID_AttachmentSiteID') --IS NULL
    BEGIN  CREATE NONCLUSTERED INDEX
		 [IX_CMS_Attachment_AttachmentGUID_AttachmentSiteID]
		 ON [dbo].[CMS_Attachment] (  [AttachmentGUID]  ASC , [AttachmentSiteID]  ASC) 
		 WITH
		 (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1170 of 1510 : Created [IX_CMS_Attachment_AttachmentGUID_AttachmentSiteID]';
    END;

GO

PRINT ' 1171 of 1510 : Analyzing rder';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_Attachment_AttachmentIsUnsorted_AttachmentGroupGUID_AttachmentFormGUID_AttachmentOrder') --IS NULL
    BEGIN  CREATE NONCLUSTERED INDEX
		 [IX_CMS_Attachment_AttachmentIsUnsorted_AttachmentGroupGUID_AttachmentFormGUID_AttachmentOrder	]
		 ON [dbo].[CMS_Attachment] (  [AttachmentIsUnsorted]  ASC , [AttachmentGroupGUID]  ASC , [AttachmentFormGUID]  ASC , [AttachmentOrder]  ASC) 
		 WITH
		 (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1172 of 1510 : Created ]';
    END;

GO

PRINT ' 1173 of 1510 : Analyzing IX_GoalOutcome_WeekendGoalItem';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_GoalOutcome_WeekendGoalItem') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_GoalOutcome_WeekendGoalItem]
	   ON [dbo].[HFit_GoalOutcome] (  [WeekendDate]  ASC , [UserGoalItemID]  ASC) INCLUDE ( [Passed] , [IsCoachCreated]) WITH (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1174 of 1510 : Created [IX_GoalOutcome_WeekendGoalItem]';
    END;

GO

PRINT ' 1175 of 1510 : Analyzing IX_GoalOutcome_ItemidPassed';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_GoalOutcome_ItemidPassed') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_GoalOutcome_ItemidPassed]
	   ON [dbo].[HFit_GoalOutcome] (  [UserGoalItemID]  ASC , [Passed]  ASC , [Tracked]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1176 of 1510 : Created [IX_GoalOutcome_ItemidPassed]';
    END;

GO

PRINT ' 1177 of 1510 : Analyzing IX_OM_Membership_RelatedID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_OM_Membership_RelatedID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_OM_Membership_RelatedID]
	   ON [dbo].[OM_Membership] (  [RelatedID]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1178 of 1510 : Created [IX_OM_Membership_RelatedID]';
    END;

GO

PRINT ' 1179 of 1510 : Analyzing IX_OM_Membership_OriginalContactID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_OM_Membership_OriginalContactID') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[IX_OM_Membership_OriginalContactID]
		ON [dbo].[OM_Membership] ( [OriginalContactID]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1180 of 1510 : Created [IX_OM_Membership_OriginalContactID]';
    END;

GO

PRINT ' 1181 of 1510 : Analyzing IX_OM_Membership_ActiveContactID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_OM_Membership_ActiveContactID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_OM_Membership_ActiveContactID]
	   ON [dbo].[OM_Membership] (  [ActiveContactID] ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1182 of 1510 : Created [IX_OM_Membership_ActiveContactID]';
    END;

GO

PRINT ' 1183 of 1510 : Analyzing nonRelatedID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'nonRelatedID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [nonRelatedID]
	   ON [dbo].[OM_Membership] (  [RelatedID]  ASC , [MemberType]  ASC) INCLUDE ([OriginalContactID]) WITH (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1184 of 1510 : Created [nonRelatedID]';
    END;

GO

PRINT ' 1185 of 1510 : Analyzing nonActiveContactID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'nonActiveContactID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [nonActiveContactID]
	   ON [dbo].[OM_Membership] (  [ActiveContactID]  ASC , [RelatedID]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1186 of 1510 : Created [nonActiveContactID]';
    END;

GO

PRINT ' 1187 of 1510 : Analyzing IX_OM_MembershipMember';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_OM_MembershipMember') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_OM_MembershipMember]
	   ON [dbo].[OM_Membership] (  [MemberType]  ASC) INCLUDE ([RelatedID] , [ActiveContactID]) WITH (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1188 of 1510 : Created [IX_OM_MembershipMember]';
    END;

GO

PRINT ' 1189 of 1510 : Analyzing idx_HFit_OM_Membership_ActiveContactIDRelatedid';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'idx_HFit_OM_Membership_ActiveContactIDRelatedid') --IS NULL
    BEGIN  CREATE NONCLUSTERED INDEX
		 [idx_HFit_OM_Membership_ActiveContactIDRelatedid]
		 ON [dbo].[OM_Membership] (  [OriginalContactID]  ASC , [ActiveContactID]  ASC , [RelatedID]  ASC) 
		 WITH
		 ( PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1190 of 1510 : Created [idx_HFit_OM_Membership_ActiveContactIDRelatedid]';
    END;

GO

PRINT ' 1191 of 1510 : Analyzing nonMemIDActiveContID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'nonMemIDActiveContID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [nonMemIDActiveContID]
	   ON [dbo].[OM_Membership] (  [MembershipID]  ASC) INCLUDE ([ActiveContactID]) WITH (  PAD_INDEX = OFF , FILLFACTOR = 100 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1192 of 1510 : Created [nonMemIDActiveContID]';
    END;

GO

PRINT ' 1193 of 1510 : Analyzing nonRelMemTypeActContID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'nonRelMemTypeActContID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [nonRelMemTypeActContID]
	   ON [dbo].[OM_Membership] (  [RelatedID]  ASC , [MemberType] ASC , [ActiveContactID]  ASC) INCLUDE ( [MembershipID]) WITH (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1194 of 1510 : Created [nonRelMemTypeActContID]';
    END;

GO

PRINT ' 1195 of 1510 : Analyzing idx_HFit_TrackerBloodSugarAndGlucose_UserIDEventDate';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'idx_HFit_TrackerBloodSugarAndGlucose_UserIDEventDate') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [idx_HFit_TrackerBloodSugarAndGlucose_UserIDEventDate]
	   ON [dbo].[HFit_TrackerBloodSugarAndGlucose] ( [EventDate]  ASC , [UserID]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 100 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1196 of 1510 : Created [idx_HFit_TrackerBloodSugarAndGlucose_UserIDEventDate]';
    END;

GO

PRINT ' 1197 of 1510 : Analyzing IX_TrackerBloodSugar_ProfCollecUserID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_TrackerBloodSugar_ProfCollecUserID') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[IX_TrackerBloodSugar_ProfCollecUserID]
		ON [dbo].[HFit_TrackerBloodSugarAndGlucose] (  [IsProfessionallyCollected]  ASC , [UserID]  ASC , [EventDate]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1198 of 1510 : Created [IX_TrackerBloodSugar_ProfCollecUserID]';
    END;

GO

PRINT ' 1199 of 1510 : Analyzing IX_TrackerBloodSugar_UserID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_TrackerBloodSugar_UserID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_TrackerBloodSugar_UserID]
	   ON [dbo].[HFit_TrackerBloodSugarAndGlucose] ( [UserID]  ASC , [EventDate] DESC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1200 of 1510 : Created [IX_TrackerBloodSugar_UserID]';
    END;

GO

PRINT ' 1201 of 1510 : Analyzing idx_HFit_TrackerBloodSugarAndGlucose_CreateDate';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'idx_HFit_TrackerBloodSugarAndGlucose_CreateDate') --IS NULL
    BEGIN  CREATE NONCLUSTERED INDEX
		 [idx_HFit_TrackerBloodSugarAndGlucose_CreateDate]
		 ON [dbo].[HFit_TrackerBloodSugarAndGlucose] (  [ItemCreatedWhen]  ASC , [ItemModifiedWhen]  ASC) 
		 WITH
		 (  PAD_INDEX = OFF , FILLFACTOR = 100 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1202 of 1510 : Created [idx_HFit_TrackerBloodSugarAndGlucose_CreateDate]';
    END;

GO

PRINT ' 1203 of 1510 : Analyzing IX_OM_Score_ScoreSiteID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_OM_Score_ScoreSiteID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_OM_Score_ScoreSiteID]
	   ON [dbo].[OM_Score] (  [ScoreSiteID]  ASC) 
	   WITH
	   ( PAD_INDEX = OFF , FILLFACTOR = 90 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1204 of 1510 : Created [IX_OM_Score_ScoreSiteID]';
    END;

GO

PRINT ' 1205 of 1510 : Analyzing IX_Integration_Task_TaskNodeAliasPath';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Integration_Task_TaskNodeAliasPath') --IS NULL
    BEGIN CREATE CLUSTERED INDEX
		[IX_Integration_Task_TaskNodeAliasPath]
		ON [dbo].[Integration_Task] ( [TaskNodeAliasPath]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 90 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1206 of 1510 : Created [IX_Integration_Task_TaskNodeAliasPath]';
    END;

GO

PRINT ' 1207 of 1510 : Analyzing IX_Integration_Task_TaskType';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Integration_Task_TaskType') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_Integration_Task_TaskType]
	   ON [dbo].[Integration_Task] (  [TaskType]  ASC) WITH (  PAD_INDEX = OFF , FILLFACTOR = 90 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1208 of 1510 : Created [IX_Integration_Task_TaskType]';
    END;

GO

PRINT ' 1209 of 1510 : Analyzing IX_Integration_Task_TaskSiteID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Integration_Task_TaskSiteID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_Integration_Task_TaskSiteID]
	   ON [dbo].[Integration_Task] (  [TaskSiteID]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 90 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1210 of 1510 : Created [IX_Integration_Task_TaskSiteID]';
    END;

GO

PRINT ' 1211 of 1510 : Analyzing IX_CMS_OpenIDUser_OpenID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_OpenIDUser_OpenID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_CMS_OpenIDUser_OpenID]
	   ON [dbo].[CMS_OpenIDUser] (  [OpenID]  ASC) 
	   WITH
	   ( PAD_INDEX = OFF , FILLFACTOR = 90 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1212 of 1510 : Created [IX_CMS_OpenIDUser_OpenID]';
    END;

GO

PRINT ' 1213 of 1510 : Analyzing IX_CMS_OpenIDUser_UserID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_OpenIDUser_UserID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_CMS_OpenIDUser_UserID]
	   ON [dbo].[CMS_OpenIDUser] (  [UserID]  ASC) 
	   WITH
	   ( PAD_INDEX = OFF , FILLFACTOR = 90 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1214 of 1510 : Created [IX_CMS_OpenIDUser_UserID]';
    END;

GO

PRINT ' 1215 of 1510 : Analyzing IX_OM_ABTest_SiteID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_OM_ABTest_SiteID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_OM_ABTest_SiteID]
	   ON [dbo].[OM_ABTest] (  [ABTestSiteID]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 90 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1216 of 1510 : Created [IX_OM_ABTest_SiteID]';
    END;

GO

PRINT ' 1217 of 1510 : Analyzing epID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_WorkflowTransition_TransitionStartStepID_TransitionSourcePointGUID_TransitionEndStepID') --IS NULL
    BEGIN  CREATE  UNIQUE NONCLUSTERED INDEX
		 [IX_CMS_WorkflowTransition_TransitionStartStepID_TransitionSourcePointGUID_TransitionEndStepID	]
		 ON [dbo].[CMS_WorkflowTransition] (  [TransitionStartStepID]  ASC , [TransitionSourcePointGUID]  ASC , [TransitionEndStepID]  ASC) 
		 WITH
		 (  PAD_INDEX = OFF , FILLFACTOR = 90 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1218 of 1510 : Created ]';
    END;

GO

PRINT ' 1219 of 1510 : Analyzing IX_BadWords_Word_WordExpression';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_BadWords_Word_WordExpression') 
    --IS NULL
    BEGIN
	   CREATE CLUSTERED INDEX
	   [IX_BadWords_Word_WordExpression]
	   ON [dbo].[BadWords_Word] (  [WordExpression]  ASC) WITH (  PAD_INDEX = OFF , FILLFACTOR = 90 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1220 of 1510 : Created [IX_BadWords_Word_WordExpression]';
    END;

GO

PRINT ' 1221 of 1510 : Analyzing IX_BadWords_Word_WordIsGlobal';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_BadWords_Word_WordIsGlobal') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_BadWords_Word_WordIsGlobal]
	   ON [dbo].[BadWords_Word] (  [WordIsGlobal]  ASC) WITH (  PAD_INDEX = OFF , FILLFACTOR = 90 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1222 of 1510 : Created [IX_BadWords_Word_WordIsGlobal]';
    END;

GO

PRINT ' 1223 of 1510 : Analyzing IX_OM_AccountStatus_AccountStatusSiteID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_OM_AccountStatus_AccountStatusSiteID') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[IX_OM_AccountStatus_AccountStatusSiteID]
		ON [dbo].[OM_AccountStatus] ( [AccountStatusSiteID]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 90 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1224 of 1510 : Created [IX_OM_AccountStatus_AccountStatusSiteID]';
    END;

GO

PRINT ' 1225 of 1510 : Analyzing IX_Integration_Synchronization_SynchronizationTaskID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Integration_Synchronization_SynchronizationTaskID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_Integration_Synchronization_SynchronizationTaskID]
	   ON [dbo].[Integration_Synchronization] ( [SynchronizationTaskID]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 90 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1226 of 1510 : Created [IX_Integration_Synchronization_SynchronizationTaskID]';
    END;

GO

PRINT ' 1227 of 1510 : Analyzing IX_Integration_Synchronization_SynchronizationConnectorID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Integration_Synchronization_SynchronizationConnectorID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_Integration_Synchronization_SynchronizationConnectorID]
	   ON [dbo].[Integration_Synchronization] ( [SynchronizationConnectorID]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 90 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1228 of 1510 : Created [IX_Integration_Synchronization_SynchronizationConnectorID]';
    END;

GO

PRINT ' 1229 of 1510 : Analyzing IX_HFit_HealthAssesmentUserRiskCategory_1';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_HFit_HealthAssesmentUserRiskCategory_1') --IS NULL
    BEGIN  CREATE NONCLUSTERED INDEX
		 [IX_HFit_HealthAssesmentUserRiskCategory_1]
		 ON [dbo].[HFit_HealthAssesmentUserRiskCategory] (  [UserID]  ASC) INCLUDE ( [HARiskCategoryNodeGUID]) WITH (  PAD_INDEX = OFF , FILLFACTOR = 100 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1230 of 1510 : Created [IX_HFit_HealthAssesmentUserRiskCategory_1]';
    END;

GO

PRINT ' 1231 of 1510 : Analyzing IX_COM_ShippingOptionDisplayName';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_COM_ShippingOptionDisplayName') 
    --IS NULL
    BEGIN
	   CREATE CLUSTERED INDEX
	   [IX_COM_ShippingOptionDisplayName]
	   ON [dbo].[COM_ShippingOption] ( [ShippingOptionDisplayName]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 90 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1232 of 1510 : Created [IX_COM_ShippingOptionDisplayName]';
    END;

GO

PRINT ' 1233 of 1510 : Analyzing d';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_COM_ShippingOption_ShippingOptionSiteID_ShippingOptionDisplayName_ShippingOptionEnabled') --IS NULL
    BEGIN  CREATE NONCLUSTERED INDEX
		 [IX_COM_ShippingOption_ShippingOptionSiteID_ShippingOptionDisplayName_ShippingOptionEnabled]
		 ON [dbo].[COM_ShippingOption] (  [ShippingOptionSiteID]  ASC) 
		 WITH
		 (  PAD_INDEX = OFF , FILLFACTOR = 90 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1234 of 1510 : Created [IX_COM_ShippingOption_ShippingOptionSiteID_ShippingOptionDisplayName_ShippingOptionEnabled]';
    END;

GO

PRINT ' 1235 of 1510 : Analyzing idx_HFit_TrackerMealPortions_CreateDate';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'idx_HFit_TrackerMealPortions_CreateDate') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[idx_HFit_TrackerMealPortions_CreateDate]
		ON [dbo].[HFit_TrackerMealPortions] (  [ItemCreatedWhen]  ASC , [ItemModifiedWhen]  ASC) 
		WITH
		( PAD_INDEX = OFF , FILLFACTOR = 100 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1236 of 1510 : Created [idx_HFit_TrackerMealPortions_CreateDate]';
    END;

GO

PRINT ' 1237 of 1510 : Analyzing idx_HFit_TrackerTests_CreateDate';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'idx_HFit_TrackerTests_CreateDate') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [idx_HFit_TrackerTests_CreateDate]
	   ON [dbo].[HFit_TrackerTests] (  [ItemCreatedWhen] ASC , [ItemModifiedWhen]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 100 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1238 of 1510 : Created [idx_HFit_TrackerTests_CreateDate]';
    END;

GO

PRINT ' 1239 of 1510 : Analyzing IX_Chat_OnlineUser_SiteID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Chat_OnlineUser_SiteID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_Chat_OnlineUser_SiteID]
	   ON [dbo].[Chat_OnlineUser] (  [ChatOnlineUserSiteID] ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 90 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1240 of 1510 : Created [IX_Chat_OnlineUser_SiteID]';
    END;

GO

PRINT ' 1241 of 1510 : Analyzing IX_Newsletter_NewsletterIssue_IssueNewsletterID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Newsletter_NewsletterIssue_IssueNewsletterID') --IS NULL
    BEGIN  CREATE NONCLUSTERED INDEX
		 [IX_Newsletter_NewsletterIssue_IssueNewsletterID]
		 ON [dbo].[Newsletter_NewsletterIssue] (  [IssueNewsletterID]  ASC) 
		 WITH
		 (  PAD_INDEX = OFF , FILLFACTOR = 90 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1242 of 1510 : Created [IX_Newsletter_NewsletterIssue_IssueNewsletterID]';
    END;

GO

PRINT ' 1243 of 1510 : Analyzing IX_Newsletter_NewsletterIssue_IssueTemplateID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Newsletter_NewsletterIssue_IssueTemplateID') --IS NULL
    BEGIN  CREATE NONCLUSTERED INDEX
		 [IX_Newsletter_NewsletterIssue_IssueTemplateID]
		 ON [dbo].[Newsletter_NewsletterIssue] (  [IssueTemplateID]  ASC) 
		 WITH
		 (  PAD_INDEX = OFF , FILLFACTOR = 90 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1244 of 1510 : Created [IX_Newsletter_NewsletterIssue_IssueTemplateID]';
    END;

GO

PRINT ' 1245 of 1510 : Analyzing IX_Newslettes_NewsletterIssue_IssueShowInNewsletterArchive';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Newslettes_NewsletterIssue_IssueShowInNewsletterArchive') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_Newslettes_NewsletterIssue_IssueShowInNewsletterArchive]
	   ON [dbo].[Newsletter_NewsletterIssue] (  [IssueShowInNewsletterArchive]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 90 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1246 of 1510 : Created [IX_Newslettes_NewsletterIssue_IssueShowInNewsletterArchive]';
    END;

GO

PRINT ' 1247 of 1510 : Analyzing IX_Newsletter_NewsletterIssue_IssueSiteID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Newsletter_NewsletterIssue_IssueSiteID') --IS NULL
    BEGIN  CREATE NONCLUSTERED INDEX
		 [IX_Newsletter_NewsletterIssue_IssueSiteID]
		 ON [dbo].[Newsletter_NewsletterIssue] (  [IssueSiteID]  ASC) 
		 WITH
		 (  PAD_INDEX = OFF , FILLFACTOR = 90 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1248 of 1510 : Created [IX_Newsletter_NewsletterIssue_IssueSiteID]';
    END;

GO

PRINT ' 1249 of 1510 : Analyzing IX_Integration_Connector_ConnectorDisplayName';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Integration_Connector_ConnectorDisplayName') --IS NULL
    BEGIN  CREATE CLUSTERED INDEX
		 [IX_Integration_Connector_ConnectorDisplayName]
		 ON [dbo].[Integration_Connector] (  [ConnectorDisplayName]  ASC) 
		 WITH
		 (  PAD_INDEX = OFF , FILLFACTOR = 90 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1250 of 1510 : Created [IX_Integration_Connector_ConnectorDisplayName]';
    END;

GO

PRINT ' 1251 of 1510 : Analyzing IX_Integration_Connector_ConnectorEnabled';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Integration_Connector_ConnectorEnabled') --IS NULL
    BEGIN  CREATE NONCLUSTERED INDEX
		 [IX_Integration_Connector_ConnectorEnabled]
		 ON [dbo].[Integration_Connector] (  [ConnectorEnabled]  ASC) 
		 WITH
		 (  PAD_INDEX = OFF , FILLFACTOR = 90 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1252 of 1510 : Created [IX_Integration_Connector_ConnectorEnabled]';
    END;

GO

PRINT ' 1253 of 1510 : Analyzing IX_COM_PaymentOption_PaymentOptionSiteID_PaymentOptionDisplayName_PaymentOptionEnabled';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_COM_PaymentOption_PaymentOptionSiteID_PaymentOptionDisplayName_PaymentOptionEnabled') --IS NULL
    BEGIN  CREATE CLUSTERED INDEX
		 [IX_COM_PaymentOption_PaymentOptionSiteID_PaymentOptionDisplayName_PaymentOptionEnabled]
		 ON [dbo].[COM_PaymentOption] (  [PaymentOptionSiteID]  ASC , [PaymentOptionDisplayName]  ASC , [PaymentOptionEnabled]  ASC) 
		 WITH
		 (  PAD_INDEX = OFF , FILLFACTOR = 90 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1254 of 1510 : Created [IX_COM_PaymentOption_PaymentOptionSiteID_PaymentOptionDisplayName_PaymentOptionEnabled]';
    END;

GO

PRINT ' 1255 of 1510 : Analyzing IX_COM_PaymentOption_PaymentOptionSucceededOrderStatusID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_COM_PaymentOption_PaymentOptionSucceededOrderStatusID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_COM_PaymentOption_PaymentOptionSucceededOrderStatusID]
	   ON [dbo].[COM_PaymentOption] ( [PaymentOptionSucceededOrderStatusID]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 90 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1256 of 1510 : Created [IX_COM_PaymentOption_PaymentOptionSucceededOrderStatusID]';
    END;

GO

PRINT ' 1257 of 1510 : Analyzing IX_COM_PaymentOption_PaymentOptionFailedOrderStatusID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_COM_PaymentOption_PaymentOptionFailedOrderStatusID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_COM_PaymentOption_PaymentOptionFailedOrderStatusID]
	   ON [dbo].[COM_PaymentOption] ( [PaymentOptionFailedOrderStatusID]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 90 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1258 of 1510 : Created [IX_COM_PaymentOption_PaymentOptionFailedOrderStatusID]';
    END;

GO

PRINT ' 1259 of 1510 : Analyzing IX_HFit_HealthAssessmentImportStagingMaster_2';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_HFit_HealthAssessmentImportStagingMaster_2') --IS NULL
    BEGIN  CREATE NONCLUSTERED INDEX
		 [IX_HFit_HealthAssessmentImportStagingMaster_2]
		 ON [dbo].[HFit_HealthAssessmentImportStagingMaster] (  [IsProcessed]  ASC) INCLUDE ( [MasterID] , [UserID] , [SiteID]) WITH (  PAD_INDEX = OFF , FILLFACTOR = 100 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1260 of 1510 : Created [IX_HFit_HealthAssessmentImportStagingMaster_2]';
    END;

GO

PRINT ' 1261 of 1510 : Analyzing IX_CMS_AbuseReport_ReportWhen';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_AbuseReport_ReportWhen') 
    --IS NULL
    BEGIN
	   CREATE CLUSTERED INDEX
	   [IX_CMS_AbuseReport_ReportWhen]
	   ON [dbo].[CMS_AbuseReport] (  [ReportWhen] DESC) WITH (  PAD_INDEX = OFF , FILLFACTOR = 90 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1262 of 1510 : Created [IX_CMS_AbuseReport_ReportWhen]';
    END;

GO

PRINT ' 1263 of 1510 : Analyzing IX_CMS_AbuseReport_ReportUserID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_AbuseReport_ReportUserID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_CMS_AbuseReport_ReportUserID]
	   ON [dbo].[CMS_AbuseReport] (  [ReportUserID]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 90 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1264 of 1510 : Created [IX_CMS_AbuseReport_ReportUserID]';
    END;

GO

PRINT ' 1265 of 1510 : Analyzing IX_CMS_AbuseReport_ReportStatus';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_AbuseReport_ReportStatus') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_CMS_AbuseReport_ReportStatus]
	   ON [dbo].[CMS_AbuseReport] (  [ReportStatus]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 90 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1266 of 1510 : Created [IX_CMS_AbuseReport_ReportStatus]';
    END;

GO

PRINT ' 1267 of 1510 : Analyzing IX_CMS_AbuseReport_ReportSiteID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_AbuseReport_ReportSiteID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_CMS_AbuseReport_ReportSiteID]
	   ON [dbo].[CMS_AbuseReport] (  [ReportSiteID]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 90 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1268 of 1510 : Created [IX_CMS_AbuseReport_ReportSiteID]';
    END;

GO

PRINT ' 1269 of 1510 : Analyzing IX_COM_SKU_SKUName';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_COM_SKU_SKUName') 
    --IS NULL
    BEGIN
	   CREATE CLUSTERED INDEX
	   [IX_COM_SKU_SKUName]
	   ON [dbo].[COM_SKU] (  [SKUName]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 90 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1270 of 1510 : Created [IX_COM_SKU_SKUName]';
    END;

GO

PRINT ' 1271 of 1510 : Analyzing IX_COM_SKU_SKUPrice';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_COM_SKU_SKUPrice') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_COM_SKU_SKUPrice]
	   ON [dbo].[COM_SKU] (  [SKUPrice]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 90 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1272 of 1510 : Created [IX_COM_SKU_SKUPrice]';
    END;

GO

PRINT ' 1273 of 1510 : Analyzing IX_COM_SKU_SKUEnabled_SKUAvailableItems';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_COM_SKU_SKUEnabled_SKUAvailableItems') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[IX_COM_SKU_SKUEnabled_SKUAvailableItems]
		ON [dbo].[COM_SKU] (  [SKUEnabled] ASC , [SKUAvailableItems]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 90 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1274 of 1510 : Created [IX_COM_SKU_SKUEnabled_SKUAvailableItems]';
    END;

GO

PRINT ' 1275 of 1510 : Analyzing IX_COM_SKU_SKUDepartmentID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_COM_SKU_SKUDepartmentID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_COM_SKU_SKUDepartmentID]
	   ON [dbo].[COM_SKU] (  [SKUDepartmentID]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 90 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1276 of 1510 : Created [IX_COM_SKU_SKUDepartmentID]';
    END;

GO

PRINT ' 1277 of 1510 : Analyzing IX_COM_SKU_SKUName_SKUEnabled';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_COM_SKU_SKUName_SKUEnabled') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_COM_SKU_SKUName_SKUEnabled]
	   ON [dbo].[COM_SKU] (  [SKUDepartmentID]  ASC) WITH (  PAD_INDEX = OFF , FILLFACTOR = 90 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1278 of 1510 : Created [IX_COM_SKU_SKUName_SKUEnabled]';
    END;

GO

PRINT ' 1279 of 1510 : Analyzing IX_COM_SKU_SKUManufacturerID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_COM_SKU_SKUManufacturerID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_COM_SKU_SKUManufacturerID]
	   ON [dbo].[COM_SKU] (  [SKUManufacturerID]  ASC) WITH (  PAD_INDEX = OFF , FILLFACTOR = 90 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1280 of 1510 : Created [IX_COM_SKU_SKUManufacturerID]';
    END;

GO

PRINT ' 1281 of 1510 : Analyzing IX_COM_SKU_SKUInternalStatusID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_COM_SKU_SKUInternalStatusID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_COM_SKU_SKUInternalStatusID]
	   ON [dbo].[COM_SKU] (  [SKUInternalStatusID]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 90 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1282 of 1510 : Created [IX_COM_SKU_SKUInternalStatusID]';
    END;

GO

PRINT ' 1283 of 1510 : Analyzing IX_COM_SKU_SKUPublicStatusID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_COM_SKU_SKUPublicStatusID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_COM_SKU_SKUPublicStatusID]
	   ON [dbo].[COM_SKU] (  [SKUPublicStatusID]  ASC) WITH (  PAD_INDEX = OFF , FILLFACTOR = 90 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1284 of 1510 : Created [IX_COM_SKU_SKUPublicStatusID]';
    END;

GO

PRINT ' 1285 of 1510 : Analyzing IX_COM_SKU_SKUSupplierID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_COM_SKU_SKUSupplierID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_COM_SKU_SKUSupplierID]
	   ON [dbo].[COM_SKU] (  [SKUSupplierID]  ASC) 
	   WITH
	   ( PAD_INDEX = OFF , FILLFACTOR = 90 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1286 of 1510 : Created [IX_COM_SKU_SKUSupplierID]';
    END;

GO

PRINT ' 1287 of 1510 : Analyzing IX_COM_SKU_SKUOptionCategoryID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_COM_SKU_SKUOptionCategoryID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_COM_SKU_SKUOptionCategoryID]
	   ON [dbo].[COM_SKU] (  [SKUOptionCategoryID]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 90 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1288 of 1510 : Created [IX_COM_SKU_SKUOptionCategoryID]';
    END;

GO

PRINT ' 1289 of 1510 : Analyzing IX_Notification_Template_TemplateSiteID_TemplateDisplayName';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Notification_Template_TemplateSiteID_TemplateDisplayName') 
    --IS NULL
    BEGIN
	   CREATE CLUSTERED INDEX
	   [IX_Notification_Template_TemplateSiteID_TemplateDisplayName]
	   ON [dbo].[Notification_Template] ( [TemplateSiteID]  ASC , [TemplateDisplayName]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 90 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1290 of 1510 : Created [IX_Notification_Template_TemplateSiteID_TemplateDisplayName]';
    END;

GO

PRINT ' 1291 of 1510 : Analyzing PKI_SchemaMonitorObjectName';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'PKI_SchemaMonitorObjectName') 
    --IS NULL
    BEGIN
	   CREATE UNIQUE CLUSTERED INDEX
	   [PKI_SchemaMonitorObjectName]
	   ON [dbo].[SchemaMonitorObjectName] (  [ObjectName] ASC , [ObjectType]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 100 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1292 of 1510 : Created [PKI_SchemaMonitorObjectName]';
    END;

GO

PRINT ' 1293 of 1510 : Analyzing IX_COM_OrderStatus_StatusOrder_StatusDisplayName_StatusEnabled';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_COM_OrderStatus_StatusOrder_StatusDisplayName_StatusEnabled') 
    --IS NULL
    BEGIN
	   CREATE CLUSTERED INDEX
	   [IX_COM_OrderStatus_StatusOrder_StatusDisplayName_StatusEnabled]
	   ON [dbo].[COM_OrderStatus] ( [StatusOrder]  ASC , [StatusDisplayName]  ASC , [StatusEnabled]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 90 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1294 of 1510 : Created [IX_COM_OrderStatus_StatusOrder_StatusDisplayName_StatusEnabled]';
    END;

GO

PRINT ' 1295 of 1510 : Analyzing PCI_SchemaMonitorObjectNotify';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'PCI_SchemaMonitorObjectNotify') 
    --IS NULL
    BEGIN
	   CREATE UNIQUE CLUSTERED INDEX
	   [PCI_SchemaMonitorObjectNotify]
	   ON [dbo].[SchemaMonitorObjectNotify] ( [EmailAddr]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 100 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1296 of 1510 : Created [PCI_SchemaMonitorObjectNotify]';
    END;

GO

PRINT ' 1297 of 1510 : Analyzing IX_Newsletter_EmailTemplate_TemplateSiteID_TemplateDisplayName';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Newsletter_EmailTemplate_TemplateSiteID_TemplateDisplayName') 
    --IS NULL
    BEGIN
	   CREATE CLUSTERED INDEX
	   [IX_Newsletter_EmailTemplate_TemplateSiteID_TemplateDisplayName]
	   ON [dbo].[Newsletter_EmailTemplate] (  [TemplateSiteID]  ASC , [TemplateDisplayName]  ASC) 
	   WITH
	   ( PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1298 of 1510 : Created [IX_Newsletter_EmailTemplate_TemplateSiteID_TemplateDisplayName]';
    END;

GO

PRINT ' 1299 of 1510 : Analyzing IX_Newsletter_EmailTemplate_TemplateSiteID_TemplateName';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Newsletter_EmailTemplate_TemplateSiteID_TemplateName') 
    --IS NULL
    BEGIN
	   CREATE  UNIQUE NONCLUSTERED INDEX
	   [IX_Newsletter_EmailTemplate_TemplateSiteID_TemplateName]
	   ON [dbo].[Newsletter_EmailTemplate] (  [TemplateSiteID]  ASC , [TemplateName]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1300 of 1510 : Created [IX_Newsletter_EmailTemplate_TemplateSiteID_TemplateName]';
    END;

GO

PRINT ' 1301 of 1510 : Analyzing idx_HFit_TrackerWeight_CreateDate';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'idx_HFit_TrackerWeight_CreateDate') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [idx_HFit_TrackerWeight_CreateDate]
	   ON [dbo].[HFit_TrackerWeight] ( [ItemCreatedWhen]  ASC , [ItemModifiedWhen]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 100 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1302 of 1510 : Created [idx_HFit_TrackerWeight_CreateDate]';
    END;

GO

PRINT ' 1303 of 1510 : Analyzing IX_CMS_Badge_BadgeTopLimit';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_Badge_BadgeTopLimit') 
    --IS NULL
    BEGIN
	   CREATE CLUSTERED INDEX
	   [IX_CMS_Badge_BadgeTopLimit]
	   ON [dbo].[CMS_Badge] (  [BadgeTopLimit] DESC) 
	   WITH
	   ( PAD_INDEX = OFF , FILLFACTOR = 90 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1304 of 1510 : Created [IX_CMS_Badge_BadgeTopLimit]';
    END;

GO

PRINT ' 1305 of 1510 : Analyzing IX_Newsletter_ABTest_TestIssueID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Newsletter_ABTest_TestIssueID') 
    --IS NULL
    BEGIN
	   CREATE UNIQUE NONCLUSTERED INDEX
	   [IX_Newsletter_ABTest_TestIssueID]
	   ON [dbo].[Newsletter_ABTest] ( [TestIssueID]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 90 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1306 of 1510 : Created [IX_Newsletter_ABTest_TestIssueID]';
    END;

GO

PRINT ' 1307 of 1510 : Analyzing IX_Newsletter_ABTest_TestWinnerIssueID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Newsletter_ABTest_TestWinnerIssueID') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[IX_Newsletter_ABTest_TestWinnerIssueID]
		ON [dbo].[Newsletter_ABTest] ( [TestWinnerIssueID]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 90 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1308 of 1510 : Created [IX_Newsletter_ABTest_TestWinnerIssueID]';
    END;

GO

PRINT ' 1309 of 1510 : Analyzing IX_CMS_PageTemplateCategory_CategoryPath';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_PageTemplateCategory_CategoryPath') --IS NULL
    BEGIN CREATE  UNIQUE CLUSTERED INDEX
		[IX_CMS_PageTemplateCategory_CategoryPath]
		ON [dbo].[CMS_PageTemplateCategory] (  [CategoryPath]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 90 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1310 of 1510 : Created [IX_CMS_PageTemplateCategory_CategoryPath]';
    END;

GO

PRINT ' 1311 of 1510 : Analyzing IX_CMS_PageTemplateCategory_CategoryParentID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_PageTemplateCategory_CategoryParentID') --IS NULL
    BEGIN  CREATE NONCLUSTERED INDEX
		 [IX_CMS_PageTemplateCategory_CategoryParentID]
		 ON [dbo].[CMS_PageTemplateCategory] (  [CategoryParentID]  ASC) 
		 WITH
		 (  PAD_INDEX = OFF , FILLFACTOR = 90 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1312 of 1510 : Created [IX_CMS_PageTemplateCategory_CategoryParentID]';
    END;

GO

PRINT ' 1313 of 1510 : Analyzing IX_CMS_PageTemplateCategory_CategoryLevel';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_PageTemplateCategory_CategoryLevel') --IS NULL
    BEGIN  CREATE NONCLUSTERED INDEX
		 [IX_CMS_PageTemplateCategory_CategoryLevel]
		 ON [dbo].[CMS_PageTemplateCategory] (  [CategoryLevel]  ASC) 
		 WITH
		 (  PAD_INDEX = OFF , FILLFACTOR = 90 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1314 of 1510 : Created [IX_CMS_PageTemplateCategory_CategoryLevel]';
    END;

GO

PRINT ' 1315 of 1510 : Analyzing IX_COM_DiscountLevel_DiscountLevelDisplayName_DiscountLevelEnabled';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_COM_DiscountLevel_DiscountLevelDisplayName_DiscountLevelEnabled') 
    --IS NULL
    BEGIN
	   CREATE CLUSTERED INDEX
	   [IX_COM_DiscountLevel_DiscountLevelDisplayName_DiscountLevelEnabled]
	   ON [dbo].[COM_DiscountLevel] (  [DiscountLevelDisplayName]  ASC , [DiscountLevelEnabled]  ASC) 
	   WITH
	   ( PAD_INDEX = OFF , FILLFACTOR = 90 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1316 of 1510 : Created [IX_COM_DiscountLevel_DiscountLevelDisplayName_DiscountLevelEnabled]';
    END;

GO

PRINT ' 1317 of 1510 : Analyzing IX_Media_Library_LibraryDisplayName';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Media_Library_LibraryDisplayName') --IS NULL
    BEGIN CREATE CLUSTERED INDEX
		[IX_Media_Library_LibraryDisplayName]
		ON [dbo].[Media_Library] ( [LibrarySiteID]  ASC , [LibraryDisplayName]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1318 of 1510 : Created [IX_Media_Library_LibraryDisplayName]';
    END;

GO

PRINT ' 1319 of 1510 : Analyzing IX_Media_Library_LibrarySiteID_LibraryName_LibraryGUID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Media_Library_LibrarySiteID_LibraryName_LibraryGUID') 
    --IS NULL
    BEGIN
	   CREATE  UNIQUE NONCLUSTERED INDEX
	   [IX_Media_Library_LibrarySiteID_LibraryName_LibraryGUID]
	   ON [dbo].[Media_Library] ( [LibrarySiteID]  ASC , [LibraryName]  ASC , [LibraryGUID]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1320 of 1510 : Created [IX_Media_Library_LibrarySiteID_LibraryName_LibraryGUID]';
    END;

GO

PRINT ' 1321 of 1510 : Analyzing IX_Media_Library_LibraryGroupID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Media_Library_LibraryGroupID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_Media_Library_LibraryGroupID]
	   ON [dbo].[Media_Library] (  [LibraryGroupID]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1322 of 1510 : Created [IX_Media_Library_LibraryGroupID]';
    END;

GO

PRINT ' 1323 of 1510 : Analyzing IX_CMS_WorkflowHistory_VersionHistoryID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_WorkflowHistory_VersionHistoryID') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[IX_CMS_WorkflowHistory_VersionHistoryID]
		ON [dbo].[CMS_WorkflowHistory] ( [VersionHistoryID]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1324 of 1510 : Created [IX_CMS_WorkflowHistory_VersionHistoryID]';
    END;

GO

PRINT ' 1325 of 1510 : Analyzing IX_CMS_WorkflowHistory_StepID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_WorkflowHistory_StepID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_CMS_WorkflowHistory_StepID]
	   ON [dbo].[CMS_WorkflowHistory] (  [StepID]  ASC) WITH (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1326 of 1510 : Created [IX_CMS_WorkflowHistory_StepID]';
    END;

GO

PRINT ' 1327 of 1510 : Analyzing IX_CMS_WorkflowHistory_ApprovedByUserID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_WorkflowHistory_ApprovedByUserID') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[IX_CMS_WorkflowHistory_ApprovedByUserID]
		ON [dbo].[CMS_WorkflowHistory] ( [ApprovedByUserID]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1328 of 1510 : Created [IX_CMS_WorkflowHistory_ApprovedByUserID]';
    END;

GO

PRINT ' 1329 of 1510 : Analyzing IX_CMS_WorkflowHistory_ApprovedWhen';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_WorkflowHistory_ApprovedWhen') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[IX_CMS_WorkflowHistory_ApprovedWhen]
		ON [dbo].[CMS_WorkflowHistory] ( [ApprovedWhen]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1330 of 1510 : Created [IX_CMS_WorkflowHistory_ApprovedWhen]';
    END;

GO

PRINT ' 1331 of 1510 : Analyzing IX_COM_CustomerCreditHistory_EventCustomerID_EventDate';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_COM_CustomerCreditHistory_EventCustomerID_EventDate') 
    --IS NULL
    BEGIN
	   CREATE CLUSTERED INDEX
	   [IX_COM_CustomerCreditHistory_EventCustomerID_EventDate]
	   ON [dbo].[COM_CustomerCreditHistory] ( [EventCustomerID]  ASC , [EventDate] DESC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 90 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1332 of 1510 : Created [IX_COM_CustomerCreditHistory_EventCustomerID_EventDate]';
    END;

GO

PRINT ' 1333 of 1510 : Analyzing IX_Integration_SyncLog_SyncLogTaskID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Integration_SyncLog_SyncLogTaskID') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[IX_Integration_SyncLog_SyncLogTaskID]
		ON [dbo].[Integration_SyncLog] ( [SyncLogSynchronizationID]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 90 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1334 of 1510 : Created [IX_Integration_SyncLog_SyncLogTaskID]';
    END;

GO

PRINT ' 1335 of 1510 : Analyzing IX_HFit_HealthAssesmentUserRiskArea_1';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_HFit_HealthAssesmentUserRiskArea_1') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[IX_HFit_HealthAssesmentUserRiskArea_1]
		ON [dbo].[HFit_HealthAssesmentUserRiskArea] (  [UserID]  ASC) INCLUDE ( [HARiskAreaNodeGUID]) WITH ( PAD_INDEX = OFF , FILLFACTOR = 100 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1336 of 1510 : Created [IX_HFit_HealthAssesmentUserRiskArea_1]';
    END;

GO

PRINT ' 1337 of 1510 : Analyzing idx_UserRiskAreaCodeName';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'idx_UserRiskAreaCodeName') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [idx_UserRiskAreaCodeName]
	   ON [dbo].[HFit_HealthAssesmentUserRiskArea] (  [CodeName] ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1338 of 1510 : Created [idx_UserRiskAreaCodeName]';
    END;

GO

PRINT ' 1339 of 1510 : Analyzing HFit_HealthAssesmentUserRiskArea_HARiskCategoryItemID_PI';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'HFit_HealthAssesmentUserRiskArea_HARiskCategoryItemID_PI') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [HFit_HealthAssesmentUserRiskArea_HARiskCategoryItemID_PI]
	   ON [dbo].[HFit_HealthAssesmentUserRiskArea] (  [HARiskCategoryItemID]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 100 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1340 of 1510 : Created [HFit_HealthAssesmentUserRiskArea_HARiskCategoryItemID_PI]';
    END;

GO

PRINT ' 1341 of 1510 : Analyzing nonHARiskCategoryItemID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'nonHARiskCategoryItemID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [nonHARiskCategoryItemID]
	   ON [dbo].[HFit_HealthAssesmentUserRiskArea] (  [ItemID] ASC , [HARiskCategoryItemID]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 100 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1342 of 1510 : Created [nonHARiskCategoryItemID]';
    END;

GO

PRINT ' 1343 of 1510 : Analyzing IX_CMS_Membership_MembershipSiteID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_Membership_MembershipSiteID') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[IX_CMS_Membership_MembershipSiteID]
		ON [dbo].[CMS_Membership] ( [MembershipSiteID]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1344 of 1510 : Created [IX_CMS_Membership_MembershipSiteID]';
    END;

GO

PRINT ' 1345 of 1510 : Analyzing idx_HFit_TrackerSitLess_CreateDate';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'idx_HFit_TrackerSitLess_CreateDate') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[idx_HFit_TrackerSitLess_CreateDate]
		ON [dbo].[HFit_TrackerSitLess] ( [ItemCreatedWhen]  ASC , [ItemModifiedWhen]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 100 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1346 of 1510 : Created [idx_HFit_TrackerSitLess_CreateDate]';
    END;

GO

PRINT ' 1347 of 1510 : Analyzing IX_CMS_PageTemplate_PageTemplateCategoryID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_PageTemplate_PageTemplateCategoryID') --IS NULL
    BEGIN  CREATE CLUSTERED INDEX
		 [IX_CMS_PageTemplate_PageTemplateCategoryID]
		 ON [dbo].[CMS_PageTemplate] (  [PageTemplateCategoryID]  ASC) 
		 WITH
		 (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1348 of 1510 : Created [IX_CMS_PageTemplate_PageTemplateCategoryID]';
    END;

GO

PRINT ' 1349 of 1510 : Analyzing IX_CMS_PageTemplate_PageTemplateCodeName_PageTemplateDisplayName';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_PageTemplate_PageTemplateCodeName_PageTemplateDisplayName') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_CMS_PageTemplate_PageTemplateCodeName_PageTemplateDisplayName]
	   ON [dbo].[CMS_PageTemplate] (  [PageTemplateCodeName]  ASC , [PageTemplateDisplayName]  ASC) 
	   WITH
	   ( PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1350 of 1510 : Created [IX_CMS_PageTemplate_PageTemplateCodeName_PageTemplateDisplayName]';
    END;

GO

PRINT ' 1351 of 1510 : Analyzing IX_CMS_PageTemplate_PageTemplateSiteID_PageTemplateCodeName_PageTemplateGUID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_PageTemplate_PageTemplateSiteID_PageTemplateCodeName_PageTemplateGUID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_CMS_PageTemplate_PageTemplateSiteID_PageTemplateCodeName_PageTemplateGUID]
	   ON [dbo].[CMS_PageTemplate] (  [PageTemplateSiteID]  ASC , [PageTemplateCodeName]  ASC , [PageTemplateGUID]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1352 of 1510 : Created [IX_CMS_PageTemplate_PageTemplateSiteID_PageTemplateCodeName_PageTemplateGUID]';
    END;

GO

PRINT ' 1353 of 1510 : Analyzing IX_CMS_PageTemplate_PageTemplateLayoutID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_PageTemplate_PageTemplateLayoutID') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[IX_CMS_PageTemplate_PageTemplateLayoutID]
		ON [dbo].[CMS_PageTemplate] ( [PageTemplateLayoutID]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1354 of 1510 : Created [IX_CMS_PageTemplate_PageTemplateLayoutID]';
    END;

GO

PRINT ' 1355 of 1510 : Analyzing erTemplate';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_PageTemplate_PageTemplateIsReusable_PageTemplateForAllPages_PageTemplateShowAsMasterTemplate') --IS NULL
    BEGIN  CREATE NONCLUSTERED INDEX
		 [IX_CMS_PageTemplate_PageTemplateIsReusable_PageTemplateForAllPages_PageTemplateShowAsMasterTe	mplate]
		 ON [dbo].[CMS_PageTemplate] (  [PageTemplateIsReusable]  ASC , [PageTemplateForAllPages]  ASC , [PageTemplateShowAsMasterTemplate]  ASC) 
		 WITH
		 (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1356 of 1510 : Created mplate]';
    END;

GO

PRINT ' 1357 of 1510 : Analyzing IX_COM_Currency_CurrencyDisplayName';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_COM_Currency_CurrencyDisplayName') --IS NULL
    BEGIN CREATE CLUSTERED INDEX
		[IX_COM_Currency_CurrencyDisplayName]
		ON [dbo].[COM_Currency] ( [CurrencyDisplayName]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 90 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1358 of 1510 : Created [IX_COM_Currency_CurrencyDisplayName]';
    END;

GO

PRINT ' 1359 of 1510 : Analyzing IX_COM_Currency_CurrencyEnabled_CurrencyIsMain';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_COM_Currency_CurrencyEnabled_CurrencyIsMain') --IS NULL
    BEGIN  CREATE NONCLUSTERED INDEX
		 [IX_COM_Currency_CurrencyEnabled_CurrencyIsMain]
		 ON [dbo].[COM_Currency] (  [CurrencyEnabled]  ASC , [CurrencyIsMain]  ASC) 
		 WITH
		 (  PAD_INDEX = OFF , FILLFACTOR = 90 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1360 of 1510 : Created [IX_COM_Currency_CurrencyEnabled_CurrencyIsMain]';
    END;

GO

PRINT ' 1361 of 1510 : Analyzing IX_COM_Order_OrderSiteID_OrderDate';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_COM_Order_OrderSiteID_OrderDate') --IS NULL
    BEGIN CREATE CLUSTERED INDEX
		[IX_COM_Order_OrderSiteID_OrderDate]
		ON [dbo].[COM_Order] (  [OrderSiteID]  ASC , [OrderDate] DESC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 90 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1362 of 1510 : Created [IX_COM_Order_OrderSiteID_OrderDate]';
    END;

GO

PRINT ' 1363 of 1510 : Analyzing IX_COM_Order_OrderBillingAddressID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_COM_Order_OrderBillingAddressID') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[IX_COM_Order_OrderBillingAddressID]
		ON [dbo].[COM_Order] ( [OrderBillingAddressID]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 90 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1364 of 1510 : Created [IX_COM_Order_OrderBillingAddressID]';
    END;

GO

PRINT ' 1365 of 1510 : Analyzing IX_COM_Order_OrderShippingAddressID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_COM_Order_OrderShippingAddressID') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[IX_COM_Order_OrderShippingAddressID]
		ON [dbo].[COM_Order] ( [OrderShippingAddressID]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 90 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1366 of 1510 : Created [IX_COM_Order_OrderShippingAddressID]';
    END;

GO

PRINT ' 1367 of 1510 : Analyzing IX_COM_Order_OrderShippingOptionID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_COM_Order_OrderShippingOptionID') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[IX_COM_Order_OrderShippingOptionID]
		ON [dbo].[COM_Order] ( [OrderShippingOptionID]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 90 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1368 of 1510 : Created [IX_COM_Order_OrderShippingOptionID]';
    END;

GO

PRINT ' 1369 of 1510 : Analyzing IX_COM_Order_OrderStatusID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_COM_Order_OrderStatusID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_COM_Order_OrderStatusID]
	   ON [dbo].[COM_Order] (  [OrderStatusID]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 90 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1370 of 1510 : Created [IX_COM_Order_OrderStatusID]';
    END;

GO

PRINT ' 1371 of 1510 : Analyzing IX_COM_Order_OrderCurrencyID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_COM_Order_OrderCurrencyID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_COM_Order_OrderCurrencyID]
	   ON [dbo].[COM_Order] (  [OrderCurrencyID]  ASC) WITH (  PAD_INDEX = OFF , FILLFACTOR = 90 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1372 of 1510 : Created [IX_COM_Order_OrderCurrencyID]';
    END;

GO

PRINT ' 1373 of 1510 : Analyzing IX_COM_Order_OrderCustomerID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_COM_Order_OrderCustomerID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_COM_Order_OrderCustomerID]
	   ON [dbo].[COM_Order] (  [OrderCustomerID]  ASC) WITH (  PAD_INDEX = OFF , FILLFACTOR = 90 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1374 of 1510 : Created [IX_COM_Order_OrderCustomerID]';
    END;

GO

PRINT ' 1375 of 1510 : Analyzing IX_COM_Order_OrderPaymentOptionID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_COM_Order_OrderPaymentOptionID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_COM_Order_OrderPaymentOptionID]
	   ON [dbo].[COM_Order] (  [OrderPaymentOptionID] ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 90 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1376 of 1510 : Created [IX_COM_Order_OrderPaymentOptionID]';
    END;

GO

PRINT ' 1377 of 1510 : Analyzing IX_COM_Order_OrderDiscountCouponID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_COM_Order_OrderDiscountCouponID') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[IX_COM_Order_OrderDiscountCouponID]
		ON [dbo].[COM_Order] ( [OrderDiscountCouponID]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 90 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1378 of 1510 : Created [IX_COM_Order_OrderDiscountCouponID]';
    END;

GO

PRINT ' 1379 of 1510 : Analyzing IX_COM_Order_OrderCompanyAddressID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_COM_Order_OrderCompanyAddressID') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[IX_COM_Order_OrderCompanyAddressID]
		ON [dbo].[COM_Order] ( [OrderCompanyAddressID]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 90 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1380 of 1510 : Created [IX_COM_Order_OrderCompanyAddressID]';
    END;

GO

PRINT ' 1381 of 1510 : Analyzing PK_Tracker_EDW_Metadata';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'PK_Tracker_EDW_Metadata') 
    --IS NULL
    BEGIN
	   CREATE  UNIQUE CLUSTERED  INDEX
	   [PK_Tracker_EDW_Metadata]
	   ON [dbo].[Tracker_EDW_Metadata] (  [TableName]  ASC , [ColName] ASC , [AttrName]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 100 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1382 of 1510 : Created [PK_Tracker_EDW_Metadata]';
    END;

GO

PRINT ' 1383 of 1510 : Analyzing IX_Export_Task_TaskSiteID_TaskObjectType';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Export_Task_TaskSiteID_TaskObjectType') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[IX_Export_Task_TaskSiteID_TaskObjectType]
		ON [dbo].[Export_Task] ( [TaskSiteID]  ASC , [TaskObjectType]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 90 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1384 of 1510 : Created [IX_Export_Task_TaskSiteID_TaskObjectType]';
    END;

GO

PRINT ' 1385 of 1510 : Analyzing IX_CMS_VersionHistory_DocumentID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_VersionHistory_DocumentID') 
    --IS NULL
    BEGIN
	   CREATE CLUSTERED INDEX
	   [IX_CMS_VersionHistory_DocumentID]
	   ON [dbo].[CMS_VersionHistory] (  [DocumentID]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1386 of 1510 : Created [IX_CMS_VersionHistory_DocumentID]';
    END;

GO

PRINT ' 1387 of 1510 : Analyzing IX_CMS_VersionHistory_NodeSiteID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_VersionHistory_NodeSiteID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_CMS_VersionHistory_NodeSiteID]
	   ON [dbo].[CMS_VersionHistory] (  [NodeSiteID] ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1388 of 1510 : Created [IX_CMS_VersionHistory_NodeSiteID]';
    END;

GO

PRINT ' 1389 of 1510 : Analyzing IX_CMS_VersionHistory_ModifiedByUserID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_VersionHistory_ModifiedByUserID') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[IX_CMS_VersionHistory_ModifiedByUserID]
		ON [dbo].[CMS_VersionHistory] ( [ModifiedByUserID]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1390 of 1510 : Created [IX_CMS_VersionHistory_ModifiedByUserID]';
    END;

GO

PRINT ' 1391 of 1510 : Analyzing IX_CMS_VersionHistory_ToBePublished_PublishFrom_PublishTo';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_VersionHistory_ToBePublished_PublishFrom_PublishTo') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_CMS_VersionHistory_ToBePublished_PublishFrom_PublishTo]
	   ON [dbo].[CMS_VersionHistory] ( [ToBePublished]  ASC , [PublishFrom]  ASC , [PublishTo]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1392 of 1510 : Created [IX_CMS_VersionHistory_ToBePublished_PublishFrom_PublishTo]';
    END;

GO

PRINT ' 1393 of 1510 : Analyzing IX_CMS_VersionHistory_VersionDeletedByUserID_VersionDeletedWhen';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_VersionHistory_VersionDeletedByUserID_VersionDeletedWhen') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_CMS_VersionHistory_VersionDeletedByUserID_VersionDeletedWhen]
	   ON [dbo].[CMS_VersionHistory] (  [VersionDeletedByUserID]  ASC , [VersionDeletedWhen] DESC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1394 of 1510 : Created [IX_CMS_VersionHistory_VersionDeletedByUserID_VersionDeletedWhen]';
    END;

GO

PRINT ' 1395 of 1510 : Analyzing IX_VersionHistoryDocID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_VersionHistoryDocID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_VersionHistoryDocID]
	   ON [dbo].[CMS_VersionHistory] (  [DocumentID]  ASC , [VersionHistoryID]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 100 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1396 of 1510 : Created [IX_VersionHistoryDocID]';
    END;

GO

PRINT ' 1397 of 1510 : Analyzing IX_Newsletter_Newsletter_NewsletterSiteID_NewsletterDisplayName';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Newsletter_Newsletter_NewsletterSiteID_NewsletterDisplayName') 
    --IS NULL
    BEGIN
	   CREATE CLUSTERED INDEX
	   [IX_Newsletter_Newsletter_NewsletterSiteID_NewsletterDisplayName]
	   ON [dbo].[Newsletter_Newsletter] (  [NewsletterSiteID]  ASC , [NewsletterDisplayName]  ASC) 
	   WITH
	   ( PAD_INDEX = OFF , FILLFACTOR = 90 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1398 of 1510 : Created [IX_Newsletter_Newsletter_NewsletterSiteID_NewsletterDisplayName]';
    END;

GO

PRINT ' 1399 of 1510 : Analyzing IX_Newsletter_Newsletter_NewsletterSiteID_NewsletterName';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Newsletter_Newsletter_NewsletterSiteID_NewsletterName') 
    --IS NULL
    BEGIN
	   CREATE  UNIQUE NONCLUSTERED  INDEX
	   [IX_Newsletter_Newsletter_NewsletterSiteID_NewsletterName]
	   ON [dbo].[Newsletter_Newsletter] (  [NewsletterSiteID]  ASC , [NewsletterName]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 90 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1400 of 1510 : Created [IX_Newsletter_Newsletter_NewsletterSiteID_NewsletterName]';
    END;

GO

PRINT ' 1401 of 1510 : Analyzing IX_Newsletter_Newsletter_NewsletterSubscriptionTemplateID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Newsletter_Newsletter_NewsletterSubscriptionTemplateID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_Newsletter_Newsletter_NewsletterSubscriptionTemplateID]
	   ON [dbo].[Newsletter_Newsletter] ( [NewsletterSubscriptionTemplateID]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 90 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1402 of 1510 : Created [IX_Newsletter_Newsletter_NewsletterSubscriptionTemplateID]';
    END;

GO

PRINT ' 1403 of 1510 : Analyzing IX_Newsletter_Newsletter_NewsletterUnsubscriptionTemplateID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Newsletter_Newsletter_NewsletterUnsubscriptionTemplateID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_Newsletter_Newsletter_NewsletterUnsubscriptionTemplateID]
	   ON [dbo].[Newsletter_Newsletter] (  [NewsletterUnsubscriptionTemplateID]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 90 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1404 of 1510 : Created [IX_Newsletter_Newsletter_NewsletterUnsubscriptionTemplateID]';
    END;

GO

PRINT ' 1405 of 1510 : Analyzing IX_Newsletter_Newsletter_NewsletterTemplateID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Newsletter_Newsletter_NewsletterTemplateID') --IS NULL
    BEGIN  CREATE NONCLUSTERED INDEX
		 [IX_Newsletter_Newsletter_NewsletterTemplateID]
		 ON [dbo].[Newsletter_Newsletter] (  [NewsletterTemplateID]  ASC) 
		 WITH
		 (  PAD_INDEX = OFF , FILLFACTOR = 90 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1406 of 1510 : Created [IX_Newsletter_Newsletter_NewsletterTemplateID]';
    END;

GO

PRINT ' 1407 of 1510 : Analyzing IX_Newsletter_Newsletter_NewsletterOptInTemplateID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Newsletter_Newsletter_NewsletterOptInTemplateID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_Newsletter_Newsletter_NewsletterOptInTemplateID]
	   ON [dbo].[Newsletter_Newsletter] ( [NewsletterOptInTemplateID]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 90 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1408 of 1510 : Created [IX_Newsletter_Newsletter_NewsletterOptInTemplateID]';
    END;

GO

PRINT ' 1409 of 1510 : Analyzing idx_HFit_TrackerSleepPlan_CreateDate';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'idx_HFit_TrackerSleepPlan_CreateDate') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[idx_HFit_TrackerSleepPlan_CreateDate]
		ON [dbo].[HFit_TrackerSleepPlan] ( [ItemCreatedWhen]  ASC , [ItemModifiedWhen]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 100 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1410 of 1510 : Created [idx_HFit_TrackerSleepPlan_CreateDate]';
    END;

GO

PRINT ' 1411 of 1510 : Analyzing IX_COM_Address_AddressCustomerID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_COM_Address_AddressCustomerID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_COM_Address_AddressCustomerID]
	   ON [dbo].[COM_Address] (  [AddressCustomerID] ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 90 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1412 of 1510 : Created [IX_COM_Address_AddressCustomerID]';
    END;

GO

PRINT ' 1413 of 1510 : Analyzing IX_COM_Address_AddressCountryID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_COM_Address_AddressCountryID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_COM_Address_AddressCountryID]
	   ON [dbo].[COM_Address] (  [AddressCountryID]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 90 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1414 of 1510 : Created [IX_COM_Address_AddressCountryID]';
    END;

GO

PRINT ' 1415 of 1510 : Analyzing IX_COM_Address_AddressStateID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_COM_Address_AddressStateID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_COM_Address_AddressStateID]
	   ON [dbo].[COM_Address] (  [AddressStateID]  ASC) WITH (  PAD_INDEX = OFF , FILLFACTOR = 90 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1416 of 1510 : Created [IX_COM_Address_AddressStateID]';
    END;

GO

PRINT ' 1417 of 1510 : Analyzing IX_COM_Address_AddressEnabled_AddressIsBilling_AddressIsShipping_AddressIsCompany';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_COM_Address_AddressEnabled_AddressIsBilling_AddressIsShipping_AddressIsCompany') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[IX_COM_Address_AddressEnabled_AddressIsBilling_AddressIsShipping_AddressIsCompany]
		ON [dbo].[COM_Address] (  [AddressEnabled]  ASC , [AddressIsBilling]  ASC , [AddressIsShipping]  ASC , [AddressIsCompany]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 90 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1418 of 1510 : Created [IX_COM_Address_AddressEnabled_AddressIsBilling_AddressIsShipping_AddressIsCompany]';
    END;

GO

PRINT ' 1419 of 1510 : Analyzing idx_RecomendationID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'idx_RecomendationID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [idx_RecomendationID]
	   ON [dbo].[HFit_HealthAssesmentRecomendationClientConfig] (  [RecomdationID] ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 90 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1420 of 1510 : Created [idx_RecomendationID]';
    END;

GO

PRINT ' 1421 of 1510 : Analyzing IX_Chat_User_UserID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Chat_User_UserID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_Chat_User_UserID]
	   ON [dbo].[Chat_User] (  [ChatUserUserID]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 90 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1422 of 1510 : Created [IX_Chat_User_UserID]';
    END;

GO

PRINT ' 1423 of 1510 : Analyzing IX_COM_TaxClass_TaxClassDisplayName';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_COM_TaxClass_TaxClassDisplayName') --IS NULL
    BEGIN CREATE CLUSTERED INDEX
		[IX_COM_TaxClass_TaxClassDisplayName]
		ON [dbo].[COM_TaxClass] ( [TaxClassDisplayName]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 90 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1424 of 1510 : Created [IX_COM_TaxClass_TaxClassDisplayName]';
    END;

GO

PRINT ' 1425 of 1510 : Analyzing IX_OM_ContactStatus_ContactStatusSiteID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_OM_ContactStatus_ContactStatusSiteID') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[IX_OM_ContactStatus_ContactStatusSiteID]
		ON [dbo].[OM_ContactStatus] ( [ContactStatusSiteID]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 90 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1426 of 1510 : Created [IX_OM_ContactStatus_ContactStatusSiteID]';
    END;

GO

PRINT ' 1427 of 1510 : Analyzing IX_CMS_User_UserName';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_User_UserName') 
    --IS NULL
    BEGIN
	   CREATE  UNIQUE NONCLUSTERED  INDEX
	   [IX_CMS_User_UserName]
	   ON [dbo].[CMS_User] (  [UserName]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1428 of 1510 : Created [IX_CMS_User_UserName]';
    END;

GO

PRINT ' 1429 of 1510 : Analyzing IX_CMS_User_FullName';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_User_FullName') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_CMS_User_FullName]
	   ON [dbo].[CMS_User] (  [FullName]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1430 of 1510 : Created [IX_CMS_User_FullName]';
    END;

GO

PRINT ' 1431 of 1510 : Analyzing IX_CMS_User_Email';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_User_Email') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_CMS_User_Email]
	   ON [dbo].[CMS_User] (  [Email]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1432 of 1510 : Created [IX_CMS_User_Email]';
    END;

GO

PRINT ' 1433 of 1510 : Analyzing IX_CMS_User_UserEnabled_UserIsHidden';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_User_UserEnabled_UserIsHidden') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[IX_CMS_User_UserEnabled_UserIsHidden]
		ON [dbo].[CMS_User] (  [UserEnabled] ASC , [UserIsHidden]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1434 of 1510 : Created [IX_CMS_User_UserEnabled_UserIsHidden]';
    END;

GO

PRINT ' 1435 of 1510 : Analyzing IX_CMS_User_UserIsEditor';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_User_UserIsEditor') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_CMS_User_UserIsEditor]
	   ON [dbo].[CMS_User] (  [UserIsEditor]  ASC) 
	   WITH
	   ( PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1436 of 1510 : Created [IX_CMS_User_UserIsEditor]';
    END;

GO

PRINT ' 1437 of 1510 : Analyzing IX_CMS_User_UserIsGlobalAdministrator';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_User_UserIsGlobalAdministrator') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[IX_CMS_User_UserIsGlobalAdministrator]
		ON [dbo].[CMS_User] ( [UserIsGlobalAdministrator]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 100 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1438 of 1510 : Created [IX_CMS_User_UserIsGlobalAdministrator]';
    END;

GO

PRINT ' 1439 of 1510 : Analyzing IX_CMS_User_UserGUID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_User_UserGUID') 
    --IS NULL
    BEGIN
	   CREATE  UNIQUE NONCLUSTERED  INDEX
	   [IX_CMS_User_UserGUID]
	   ON [dbo].[CMS_User] (  [UserGUID]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1440 of 1510 : Created [IX_CMS_User_UserGUID]';
    END;

GO

PRINT ' 1441 of 1510 : Analyzing PI_CMS_User_UserIsGlobalAdministrator';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'PI_CMS_User_UserIsGlobalAdministrator') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[PI_CMS_User_UserIsGlobalAdministrator]
		ON [dbo].[CMS_User] ( [UserIsGlobalAdministrator]  ASC , [UserID]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 100 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1442 of 1510 : Created [PI_CMS_User_UserIsGlobalAdministrator]';
    END;

GO

PRINT ' 1443 of 1510 : Analyzing IX_CMS_Document_DocumentForeignKeyValue_DocumentID_DocumentNodeID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_Document_DocumentForeignKeyValue_DocumentID_DocumentNodeID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_CMS_Document_DocumentForeignKeyValue_DocumentID_DocumentNodeID]
	   ON [dbo].[CMS_Document] (  [DocumentForeignKeyValue]  ASC , [DocumentID]  ASC , [DocumentNodeID]  ASC) WITH (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1444 of 1510 : Created [IX_CMS_Document_DocumentForeignKeyValue_DocumentID_DocumentNodeID]';
    END;

GO

PRINT ' 1445 of 1510 : Analyzing IX_CMS_Document_WorkflowColumns';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_Document_WorkflowColumns') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_CMS_Document_WorkflowColumns]
	   ON [dbo].[CMS_Document] (  [DocumentID]  ASC , [DocumentNodeID]  ASC , [DocumentCulture]  ASC , [DocumentCheckedOutVersionHistoryID]  ASC , [DocumentPublishedVersionHistoryID]  ASC , [DocumentPublishFrom]  ASC , [DocumentPublishTo]  ASC , [DocumentWorkflowStepID]  ASC , [DocumentIsArchived]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1446 of 1510 : Created [IX_CMS_Document_WorkflowColumns]';
    END;

GO

PRINT ' 1447 of 1510 : Analyzing IX_CMS_Document_DocumentNodeID_DocumentID_DocumentCulture';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_Document_DocumentNodeID_DocumentID_DocumentCulture') 
    --IS NULL
    BEGIN
	   CREATE  UNIQUE NONCLUSTERED  INDEX
	   [IX_CMS_Document_DocumentNodeID_DocumentID_DocumentCulture]
	   ON [dbo].[CMS_Document] (  [DocumentNodeID]  ASC , [DocumentID]  ASC , [DocumentCulture]  ASC) 
	   WITH
	   ( PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1448 of 1510 : Created [IX_CMS_Document_DocumentNodeID_DocumentID_DocumentCulture]';
    END;

GO

PRINT ' 1449 of 1510 : Analyzing IX_CMS_Document_DocumentUrlPath_DocumentID_DocumentNodeID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_Document_DocumentUrlPath_DocumentID_DocumentNodeID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_CMS_Document_DocumentUrlPath_DocumentID_DocumentNodeID]
	   ON [dbo].[CMS_Document] ( [DocumentUrlPath]  ASC) INCLUDE ( [DocumentID] , [DocumentNodeID]) WITH (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1450 of 1510 : Created [IX_CMS_Document_DocumentUrlPath_DocumentID_DocumentNodeID]';
    END;

GO

PRINT ' 1451 of 1510 : Analyzing IX_CMS_Document_DocumentModifiedByUserID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_Document_DocumentModifiedByUserID') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[IX_CMS_Document_DocumentModifiedByUserID]
		ON [dbo].[CMS_Document] ( [DocumentModifiedByUserID]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1452 of 1510 : Created [IX_CMS_Document_DocumentModifiedByUserID]';
    END;

GO

PRINT ' 1453 of 1510 : Analyzing IX_CMS_Document_DocumentCulture_DocumentForeignKeyValue_Workflow';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_Document_DocumentCulture_DocumentForeignKeyValue_Workflow') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_CMS_Document_DocumentCulture_DocumentForeignKeyValue_Workflow]
	   ON [dbo].[CMS_Document] (  [DocumentCulture]  ASC) INCLUDE ( [DocumentForeignKeyValue] , [DocumentCheckedOutVersionHistoryID] , [DocumentPublishedVersionHistoryID] , [DocumentPublishFrom] , [DocumentPublishTo] , [DocumentNodeID] , [DocumentIsArchived]) WITH (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1454 of 1510 : Created [IX_CMS_Document_DocumentCulture_DocumentForeignKeyValue_Workflow]';
    END;

GO

PRINT ' 1455 of 1510 : Analyzing IX_CMS_Document_DocumentCreatedByUserID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_Document_DocumentCreatedByUserID') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[IX_CMS_Document_DocumentCreatedByUserID]
		ON [dbo].[CMS_Document] ( [DocumentCreatedByUserID]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1456 of 1510 : Created [IX_CMS_Document_DocumentCreatedByUserID]';
    END;

GO

PRINT ' 1457 of 1510 : Analyzing IX_CMS_Document_DocumentCheckedOutByUserID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_Document_DocumentCheckedOutByUserID') --IS NULL
    BEGIN  CREATE NONCLUSTERED INDEX
		 [IX_CMS_Document_DocumentCheckedOutByUserID]
		 ON [dbo].[CMS_Document] (  [DocumentCheckedOutByUserID]  ASC) 
		 WITH
		 (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1458 of 1510 : Created [IX_CMS_Document_DocumentCheckedOutByUserID]';
    END;

GO

PRINT ' 1459 of 1510 : Analyzing IX_CMS_Document_DocumentCulture';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_Document_DocumentCulture') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_CMS_Document_DocumentCulture]
	   ON [dbo].[CMS_Document] (  [DocumentCulture]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1460 of 1510 : Created [IX_CMS_Document_DocumentCulture]';
    END;

GO

PRINT ' 1461 of 1510 : Analyzing IX_CMS_Document_DocumentShowInSiteMap';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_Document_DocumentShowInSiteMap') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[IX_CMS_Document_DocumentShowInSiteMap]
		ON [dbo].[CMS_Document] ( [DocumentShowInSiteMap]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1462 of 1510 : Created [IX_CMS_Document_DocumentShowInSiteMap]';
    END;

GO

PRINT ' 1463 of 1510 : Analyzing IX_CMS_Document_DocumentMenuItemHideInNavigation';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_Document_DocumentMenuItemHideInNavigation') --IS NULL
    BEGIN  CREATE NONCLUSTERED INDEX
		 [IX_CMS_Document_DocumentMenuItemHideInNavigation]
		 ON [dbo].[CMS_Document] (  [DocumentMenuItemHideInNavigation]  ASC) 
		 WITH
		 (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1464 of 1510 : Created [IX_CMS_Document_DocumentMenuItemHideInNavigation]';
    END;

GO

PRINT ' 1465 of 1510 : Analyzing IX_CMS_Document_DocumentPageTemplateID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_Document_DocumentPageTemplateID') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[IX_CMS_Document_DocumentPageTemplateID]
		ON [dbo].[CMS_Document] ( [DocumentPageTemplateID]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1466 of 1510 : Created [IX_CMS_Document_DocumentPageTemplateID]';
    END;

GO

PRINT ' 1467 of 1510 : Analyzing IX_CMS_Document_DocumentTagGroupID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_Document_DocumentTagGroupID') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[IX_CMS_Document_DocumentTagGroupID]
		ON [dbo].[CMS_Document] ( [DocumentTagGroupID]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1468 of 1510 : Created [IX_CMS_Document_DocumentTagGroupID]';
    END;

GO

PRINT ' 1469 of 1510 : Analyzing IX_CMS_Document_DocumentWildcardRule_DocumentPriority';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_Document_DocumentWildcardRule_DocumentPriority') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_CMS_Document_DocumentWildcardRule_DocumentPriority]
	   ON [dbo].[CMS_Document] ( [DocumentWildcardRule]  ASC , [DocumentPriority]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1470 of 1510 : Created [IX_CMS_Document_DocumentWildcardRule_DocumentPriority]';
    END;

GO

PRINT ' 1471 of 1510 : Analyzing IX_CMS_Document_CreateDate';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_Document_CreateDate') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_CMS_Document_CreateDate]
	   ON [dbo].[CMS_Document] (  [DocumentCreatedWhen]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1472 of 1510 : Created [IX_CMS_Document_CreateDate]';
    END;

GO

PRINT ' 1473 of 1510 : Analyzing IX_CMS_Document_ModifiedDate';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_Document_ModifiedDate') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_CMS_Document_ModifiedDate]
	   ON [dbo].[CMS_Document] (  [DocumentModifiedWhen] ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 100 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1474 of 1510 : Created [IX_CMS_Document_ModifiedDate]';
    END;

GO

PRINT ' 1475 of 1510 : Analyzing IX_CMS_WebFarmServerTask_ServerID_TaskID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_CMS_WebFarmServerTask_ServerID_TaskID') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[IX_CMS_WebFarmServerTask_ServerID_TaskID]
		ON [dbo].[CMS_WebFarmServerTask] (  [ServerID]  ASC , [TaskID]  ASC) 
		WITH
		(  PAD_INDEX = OFF , FILLFACTOR = 90 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1476 of 1510 : Created [IX_CMS_WebFarmServerTask_ServerID_TaskID]';
    END;

GO

PRINT ' 1477 of 1510 : Analyzing CMS_WebFarmServerTask_idx_01';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'CMS_WebFarmServerTask_idx_01') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [CMS_WebFarmServerTask_idx_01]
	   ON [dbo].[CMS_WebFarmServerTask] (  [TaskID]  ASC) WITH (  PAD_INDEX = OFF , FILLFACTOR = 90 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1478 of 1510 : Created [CMS_WebFarmServerTask_idx_01]';
    END;

GO

PRINT ' 1479 of 1510 : Analyzing IX_COM_PublicStatus_PublicStatusDisplayName_PublicStatusEnabled';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_COM_PublicStatus_PublicStatusDisplayName_PublicStatusEnabled') 
    --IS NULL
    BEGIN
	   CREATE CLUSTERED INDEX
	   [IX_COM_PublicStatus_PublicStatusDisplayName_PublicStatusEnabled]
	   ON [dbo].[COM_PublicStatus] (  [PublicStatusDisplayName]  ASC , [PublicStatusEnabled]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 90 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1480 of 1510 : Created [IX_COM_PublicStatus_PublicStatusDisplayName_PublicStatusEnabled]';
    END;

GO

PRINT ' 1481 of 1510 : Analyzing IX_HFit_Screening_QST_1';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_HFit_Screening_QST_1') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_HFit_Screening_QST_1]
	   ON [dbo].[HFit_Screening_QST] (  [SSISLoadID]  ASC , [SBL_Participant_ID]  ASC) INCLUDE ( Timestamp) WITH (  PAD_INDEX = OFF , FILLFACTOR = 100 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1482 of 1510 : Created [IX_HFit_Screening_QST_1]';
    END;

GO

PRINT ' 1483 of 1510 : Analyzing HFit_RewardsUserLevelDetail_PiDate';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'HFit_RewardsUserLevelDetail_PiDate') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[HFit_RewardsUserLevelDetail_PiDate]
		ON [dbo].[HFit_RewardsUserLevelDetail] (  [ItemModifiedWhen]  ASC) INCLUDE ( [ItemCreatedWhen]) WITH (  PAD_INDEX = OFF , FILLFACTOR = 100 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1484 of 1510 : Created [HFit_RewardsUserLevelDetail_PiDate]';
    END;

GO

PRINT ' 1485 of 1510 : Analyzing PI_HFit_RewardsUserLevelDetail_Date';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'PI_HFit_RewardsUserLevelDetail_Date') --IS NULL
    BEGIN CREATE NONCLUSTERED INDEX
		[PI_HFit_RewardsUserLevelDetail_Date]
		ON [dbo].[HFit_RewardsUserLevelDetail] (  [ItemModifiedWhen]  ASC) INCLUDE ( [ItemCreatedWhen]) WITH (  PAD_INDEX = OFF , FILLFACTOR = 100 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1486 of 1510 : Created [PI_HFit_RewardsUserLevelDetail_Date]';
    END;

GO

PRINT ' 1487 of 1510 : Analyzing PI_HFit_RewardsUserLevelDetail_LevelNodeID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'PI_HFit_RewardsUserLevelDetail_LevelNodeID') --IS NULL
    BEGIN  CREATE NONCLUSTERED INDEX
		 [PI_HFit_RewardsUserLevelDetail_LevelNodeID]
		 ON [dbo].[HFit_RewardsUserLevelDetail] (  [LevelNodeID]  ASC) 
		 WITH
		 (  PAD_INDEX = OFF , FILLFACTOR = 100 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1488 of 1510 : Created [PI_HFit_RewardsUserLevelDetail_LevelNodeID]';
    END;

GO

PRINT ' 1489 of 1510 : Analyzing nonUserID';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'nonUserID') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [nonUserID]
	   ON [dbo].[HFit_RewardsUserLevelDetail] (  [UserID]  ASC) INCLUDE ( [ItemID] , [LevelVersionHistoryID] , [ItemCreatedBy] , [ItemCreatedWhen] , [ItemModifiedBy] , [ItemModifiedWhen] , [ItemOrder] , [ItemGUID] , [LevelCompletedDt] , [LevelNodeID] , [RewardGroupNodeId] , [RewardProgramNodeId]) WITH (  PAD_INDEX = OFF , FILLFACTOR = 80 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1490 of 1510 : Created [nonUserID]';
    END;

GO

PRINT ' 1491 of 1510 : Analyzing IX_Staging_Server_ServerSiteID_ServerDisplayName';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Staging_Server_ServerSiteID_ServerDisplayName') --IS NULL
    BEGIN  CREATE CLUSTERED INDEX
		 [IX_Staging_Server_ServerSiteID_ServerDisplayName]
		 ON [dbo].[Staging_Server] (  [ServerSiteID]  ASC , [ServerDisplayName]  ASC) 
		 WITH
		 (  PAD_INDEX = OFF , FILLFACTOR = 90 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1492 of 1510 : Created [IX_Staging_Server_ServerSiteID_ServerDisplayName]';
    END;

GO

PRINT ' 1493 of 1510 : Analyzing IX_Staging_Server_ServerEnabled';
GO

IF NOT EXISTS (SELECT [Name]
			  FROM [sys].[Indexes]
			  WHERE [Name] = 'IX_Staging_Server_ServerEnabled') 
    --IS NULL
    BEGIN
	   CREATE NONCLUSTERED INDEX
	   [IX_Staging_Server_ServerEnabled]
	   ON [dbo].[Staging_Server] (  [ServerEnabled]  ASC) 
	   WITH
	   (  PAD_INDEX = OFF , FILLFACTOR = 90 , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY ];
	   PRINT ' 1494 of 1510 : Created [IX_Staging_Server_ServerEnabled]';
    END;

GO

PRINT ' 1495 of 1510 : *****************************************';
PRINT ' 1496 of 1510 : BEGINNING IVP ***************************';
PRINT ' 1497 of 1510 : *****************************************';

--Turn OFF the DELETE and turn on the INDEX bit to CREATE an index
DECLARE @i1 AS bit = 0;	--PI_CMS_User_UserIsGlobalAdministrator
DECLARE @i2 AS bit = 0;	--pi_CMS_UserSettings_IDMPI
DECLARE @i3 AS bit = 0;	--PI02_view_EDW_RewardUserDetail
DECLARE @i4 AS bit = 0;	--ix_CmsUserSite_Userid_PI
DECLARE @i5 AS bit = 0;	--PI_CMS_UserSite_SiteID
DECLARE @i6 AS bit = 0;	--HFit_Account_AccountID_CI
DECLARE @i7 AS bit = 0;	--HFit_Account_ClientCode_PI
DECLARE @i8 AS bit = 0;	--HFit_Account_SiteID_PI
DECLARE @i9 AS bit = 0;	--ci_HFit_HealthAssesmentUserQuestion_NodeGUID
DECLARE @i10 AS bit = 0;	--HFit_HealthAssesmentUserQuestion_HARiskAreaItemID_PI
DECLARE @i11 AS bit = 0;	--HFit_HealthAssesmentUserRiskArea_HARiskCategoryItemID_PI

--Turn on the DELETE bit to remove the index
DECLARE @d1 AS bit = 0;	--CMS_User.PI_CMS_User_UserIsGlobalAdministrator
DECLARE @d2 AS bit = 0;	--CMS_UserSettings.pi_CMS_UserSettings_IDMPI
DECLARE @d3 AS bit = 0;	--CMS_UserSettings.PI02_view_EDW_RewardUserDetail
DECLARE @d4 AS bit = 0;	--CMS_UserSite.ix_CmsUserSite_Userid_PIHFit_HealthAssesmentUserQuestion_HARiskAreaItemID_PI
DECLARE @d5 AS bit = 0;	--CMS_UserSite.PI_CMS_UserSite_SiteID
DECLARE @d6 AS bit = 0;	--HFit_Account.HFit_Account_AccountID_CI
DECLARE @d7 AS bit = 0;	--HFit_Account.HFit_Account_ClientCode_PI
DECLARE @d8 AS bit = 0;	--HFit_Account.HFit_Account_SiteID_PI
DECLARE @d9 AS bit = 0;	--HFit_HealthAssesmentUserQuestion.ci_HFit_HealthAssesmentUserQuestion_NodeGUID
DECLARE @d10 AS bit = 0;	--HFit_HealthAssesmentUserQuestion.
DECLARE @d11 AS bit = 0;	--HFit_HealthAssesmentUserRiskArea.HFit_HealthAssesmentUserRiskArea_HARiskCategoryItemID_PI
PRINT ' 1498 of 1510 : DECLARES SET';

IF @d11 = 1
    BEGIN
	   DROP INDEX [HFit_HealthAssesmentUserRiskArea_HARiskCategoryItemID_PI] ON [dbo].[HFit_HealthAssesmentUserRiskArea];
    END;
ELSE
    BEGIN IF @i11 = 1
		    BEGIN
			   IF NOT EXISTS (SELECT [name]
							FROM [sys].[indexes]
							WHERE [name] = 'HFit_HealthAssesmentUserRiskArea_HARiskCategoryItemID_PI') 
				  BEGIN
					 CREATE NONCLUSTERED INDEX [HFit_HealthAssesmentUserRiskArea_HARiskCategoryItemID_PI] ON [dbo].[HFit_HealthAssesmentUserRiskArea]
					 (
					 [HARiskCategoryItemID] ASC
					 );
				  END;
		    END;
    END;
PRINT ' 1499 of 1510 :    Processing';
IF @i10 = 1
    BEGIN
	   DROP INDEX [HFit_HealthAssesmentUserQuestion_HARiskAreaItemID_PI] ON [dbo].[HFit_HealthAssesmentUserQuestion];
    END;
ELSE
    BEGIN IF @i10 = 1
		    BEGIN

			   IF @d10 = 1
				  BEGIN
					 IF NOT EXISTS (SELECT [name]
								   FROM [sys].[indexes]
								   WHERE [name] = 'HFit_HealthAssesmentUserQuestion_HARiskAreaItemID_PI') 
						BEGIN
						    CREATE NONCLUSTERED INDEX [HFit_HealthAssesmentUserQuestion_HARiskAreaItemID_PI] ON [dbo].[HFit_HealthAssesmentUserQuestion]
						    (
						    [HARiskAreaItemID] ASC
						    );
						END;
				  END;
		    END;
    END;
PRINT ' 1500 of 1510 :    Processing';
IF @d9 = 1
    BEGIN
	   DROP INDEX [ci_HFit_HealthAssesmentUserQuestion_NodeGUID] ON [dbo].[HFit_HealthAssesmentUserQuestion];
    END;
ELSE
    BEGIN IF @i9 = 1
		    BEGIN
			   IF NOT EXISTS (SELECT [name]
							FROM [sys].[indexes]
							WHERE [name] = 'ci_HFit_HealthAssesmentUserQuestion_NodeGUID') 
				  BEGIN
					 CREATE NONCLUSTERED INDEX [ci_HFit_HealthAssesmentUserQuestion_NodeGUID] ON [dbo].[HFit_HealthAssesmentUserQuestion]
					 (
					 [HAQuestionNodeGUID] ASC
					 ) 
					 INCLUDE ( 	[ItemID] ,
					 [HAQuestionScore] ,
					 [ItemModifiedWhen] ,
					 [HARiskAreaItemID] ,
					 [CodeName] ,
					 [PreWeightedScore] ,
					 [IsProfessionallyCollected]) ;
				  END;
		    END;
    END;
PRINT ' 1501 of 1510 :    Processing';
IF @d8 = 1
    BEGIN
	   DROP INDEX [HFit_Account_SiteID_PI] ON [dbo].[HFit_Account];
    END;
ELSE
    BEGIN IF @i8 = 1
		    BEGIN
			   IF NOT EXISTS (SELECT [name]
							FROM [sys].[indexes]
							WHERE [name] = 'HFit_Account_SiteID_PI') 
				  BEGIN
					 CREATE NONCLUSTERED INDEX [HFit_Account_SiteID_PI] ON [dbo].[HFit_Account]
					 (
					 [SiteID] ASC
					 );
				  END;
		    END;
    END;
PRINT ' 1502 of 1510 :    Processing';
IF @d7 = 1
    BEGIN
	   DROP INDEX [HFit_Account_ClientCode_PI] ON [dbo].[HFit_Account];
    END;
ELSE
    BEGIN IF @i7 = 1
		    BEGIN
			   IF NOT EXISTS (SELECT [name]
							FROM [sys].[indexes]
							WHERE [name] = 'HFit_Account_ClientCode_PI') 
				  BEGIN
					 CREATE NONCLUSTERED INDEX [HFit_Account_ClientCode_PI] ON [dbo].[HFit_Account]
					 (
					 [AccountCD] ASC
					 );
				  END;
		    END;
    END;
PRINT ' 1503 of 1510 :    Processing';
IF @d6 = 1
    BEGIN
	   DROP INDEX [HFit_Account_AccountID_CI] ON [dbo].[HFit_Account];
    END;
ELSE
    BEGIN IF @i6 = 1
		    BEGIN
			   IF NOT EXISTS (SELECT [name]
							FROM [sys].[indexes]
							WHERE [name] = 'HFit_Account_AccountID_CI') 
				  BEGIN
					 CREATE NONCLUSTERED INDEX [HFit_Account_AccountID_CI] ON [dbo].[HFit_Account]
					 (
					 [AccountID] ASC ,
					 [AccountCD] ASC
					 );
				  END;
		    END;
    END;
PRINT ' 1504 of 1510 :    Processing';
IF @d5 = 1
    BEGIN
	   DROP INDEX [PI_CMS_UserSite_SiteID] ON [dbo].[CMS_UserSite];
    END;
ELSE
    BEGIN IF @i5 = 1
		    BEGIN
			   IF NOT EXISTS (SELECT [name]
							FROM [sys].[indexes]
							WHERE [name] = 'PI_CMS_UserSite_SiteID') 
				  BEGIN
					 CREATE NONCLUSTERED INDEX [PI_CMS_UserSite_SiteID] ON [dbo].[CMS_UserSite]
					 (
					 [SiteID] ASC
					 ) 
					 INCLUDE ( 	[UserID]) ;
				  END;
		    END;
    END;
PRINT ' 1505 of 1510 :    Processing';
IF @d4 = 1
    BEGIN
	   DROP INDEX [ix_CmsUserSite_Userid_PI] ON [dbo].[CMS_UserSite];
    END;
ELSE
    BEGIN IF @i4 = 1
		    BEGIN
			   IF NOT EXISTS (SELECT [name]
							FROM [sys].[indexes]
							WHERE [name] = 'ix_CmsUserSite_Userid_PI') 
				  BEGIN
					 CREATE NONCLUSTERED INDEX [ix_CmsUserSite_Userid_PI] ON [dbo].[CMS_UserSite]
					 (
					 [UserID] ASC
					 ) 
					 INCLUDE ( 	[UserSiteID]) ;
				  END;
		    END;
    END;
PRINT ' 1506 of 1510 :    Processing';
IF @d3 = 1
    BEGIN
	   DROP INDEX [PI02_view_EDW_RewardUserDetail] ON [dbo].[CMS_UserSettings];
    END;
ELSE
    BEGIN IF @i3 = 1
		    BEGIN
			   IF NOT EXISTS (SELECT [name]
							FROM [sys].[indexes]
							WHERE [name] = 'PI02_view_EDW_RewardUserDetail') 
				  BEGIN
					 CREATE NONCLUSTERED INDEX [PI02_view_EDW_RewardUserDetail] ON [dbo].[CMS_UserSettings]
					 (
					 [UserSettingsID] ASC ,
					 [HFitUserMpiNumber] ASC
					 );
				  END;
		    END;
    END;
PRINT ' 1507 of 1510 :    Processing';
IF @d2 = 1
    BEGIN
	   DROP INDEX [pi_CMS_UserSettings_IDMPI] ON [dbo].[CMS_UserSettings];
    END;
ELSE
    BEGIN IF @i2 = 1
		    BEGIN
			   IF NOT EXISTS (SELECT [name]
							FROM [sys].[indexes]
							WHERE [name] = 'pi_CMS_UserSettings_IDMPI') 
				  BEGIN
					 CREATE NONCLUSTERED INDEX [pi_CMS_UserSettings_IDMPI] ON [dbo].[CMS_UserSettings]
					 (
					 [UserSettingsID] ASC ,
					 [HFitUserMpiNumber] ASC
					 );
				  END;
		    END;
    END;
PRINT ' 1508 of 1510 :    Processing';
IF @d1 = 1
    BEGIN
	   DROP INDEX [PI_CMS_User_UserIsGlobalAdministrator] ON [dbo].[CMS_User];
    END;
ELSE
    BEGIN IF @i1 = 1
		    BEGIN
			   IF NOT EXISTS (SELECT [name]
							FROM [sys].[indexes]
							WHERE [name] = 'PI_CMS_User_UserIsGlobalAdministrator') 
				  BEGIN
					 CREATE NONCLUSTERED INDEX [PI_CMS_User_UserIsGlobalAdministrator] ON [dbo].[CMS_User]
					 (
					 [UserIsGlobalAdministrator] ASC ,
					 [UserID] ASC
					 );
				  END;
		    END;

    END;

GO

PRINT (' 1510 of 1510 : END OF HAProdTuning.sql') ;

Go



