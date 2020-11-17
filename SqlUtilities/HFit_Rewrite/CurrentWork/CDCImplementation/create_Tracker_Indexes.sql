
-- use KenticoCMS_DataMArt_2

GO
PRINT 'Executing create_Tracker_Indexes.sql';
GO


-- SELECT 'TRUNCATE TABLE ' + TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME LIKE '%_del'SELECT 'TRUNCATE TABLE ' + TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME LIKE '%_del'


--if (SELECT count(*)
--FROM sys.indexes AS i
--INNER JOIN sys.index_columns AS ic 
--    ON i.object_id = ic.object_id AND i.index_id = ic.index_id
--WHERE i.name = 'PI_TrackerData_SKEY_SurrogateKey_CMS_user'
--and COL_NAME(ic.object_id,ic.column_id) = 'TrackerName') = 0

/*
-- USE this SCRIPT TO CHECK FOR THE EXISTANCE OF THE COLUMN TrackerName AND RE-CREATE INDEX IF MISSING
select 'Print ''START TIME: '''
+char(10) + 'Print getdate() ;' 
+char(10) + 'Print ''PI_TrackerData_SKEY_'+column_name +'''' + 
+char(10) + 'GO'
+char(10) + 'If  (SELECT count(*) ' 
+char(10) + 'FROM sys.indexes AS i '
+char(10) + 'INNER JOIN sys.index_columns AS ic '
+char(10) + '    ON i.object_id = ic.object_id AND i.index_id = ic.index_id'
+char(10) + 'where i.name = ''PI_TrackerData_SKEY_'+column_name +'''' + 
+char(10) + 'and COL_NAME(ic.object_id,ic.column_id) = ''TrackerName'') = 0'
+char(10) + 'BEGIN'
+char(10) + '    if exists (select name from sys.indexes where name = ''PI_TrackerData_SKEY_' + column_name + ''')'
+char(10) + '        DROP INDEX PI_TrackerData_SKEY_' + column_name + ' on dbo.FACT_TrackerData ; ' 
+char(10) + '    CREATE nonclustered INDEX PI_TrackerData_SKEY_' + column_name + ' on dbo.FACT_TrackerData ' 
+char(10) + '      (DBNAME asc, TrackerName ASC, SurrogateKey_' + replace(substring(C.table_name,6,9999),'_DEL','') + ' asc) ' 
+char(10) + 'END'
+char(10) + 'GO'
+char(10) + 'Print ''END TIME: '''
+char(10) + 'Print getdate() ;' 
+char(10) + 'Print ''*************************************************************'' ; ' 
+char(10) + 'GO'
    FROM INFORMATION_SCHEMA.TABLES t 
    LEFT JOIN INFORMATION_SCHEMA.COLUMNS c
    ON c.tABLE_NAME = t.TABLE_NAME 
    AND c.COLUMN_NAME = 'TrackerName'
    WHERE t.TABLE_NAME LIKE '%TRACKER%' 
    AND t.TABLE_NAME LIKE 'BASE_%' 
    AND t.TABLE_NAME not LIKE '%_NONULLS' 
    AND t.TABLE_NAME not LIKE '%_CtVerHist' 
    AND t.TABLE_NAME not LIKE '%_TestData' 
    AND t.TABLE_NAME not LIKE '%_VIEW_%' 
    AND t.TABLE_NAME not LIKE '%_LKP_%'     
    AND t.TABLE_NAME not LIKE '%_join_%'
    AND t.TABLE_NAME not LIKE '%Mapping'
    AND t.TABLE_NAME not LIKE '%Category'
    AND t.TABLE_NAME not LIKE '%_Item'
    AND t.TABLE_NAME not LIKE '%TrackerInstance_Tracker'
    and column_name like 'SurrogateKey_%'
*/    
    

/*

--USE THE FOLLOWING TO CREATE ALL MISSING TRACKER INDEXES on FACT_TrackerData
select 'If  not Exists (select name from sys.indexes where name = ''PI_TrackerData_SKEY_'+column_name +''')' + 
+char(10) + 'BEGIN'
+char(10) + 'CREATE nonclustered INDEX PI_TrackerData_SKEY_' + column_name + ' on dbo.FACT_TrackerData ' 
+char(10) + '(DBNAME asc, TrackerName ASC, ' + column_name + ' asc) ' 
+char(10) + 'END'
+char(10) + 'GO'
+char(10) + 'Print ''END TIME: ''' 
+char(10) + 'Print getdate() '  
+char(10) + 'GO'
from INFORMATION_SCHEMA.COLUMNS
where table_name like 'FACT_TrackerData' and column_name like 'SurrogateKey_%'

--USE THE FOLLOWING TO DROP AND RECREATE ALL TRACKER INDEXES on FACT_TrackerData
select 'If  Exists (select name from sys.indexes where name = ''PI_TrackerData_SKEY_'+column_name +''')' + 
+char(10) + 'BEGIN'
+char(10) + 'Print START TIME: ''' + getdate() + '''' 
+char(10) + 'DROP INDEX PI_TrackerData_SKEY_' + column_name + ' on dbo.FACT_TrackerData ' 
+char(10) + 'END'
+char(10) + 'GO'
+char(10) + 'Print ''' + Column_name + '''' 
+char(10) + 'GO'
+char(10) + 'CREATE nonclustered INDEX PI_TrackerData_SKEY_' + column_name + ' on dbo.FACT_TrackerData ' 
+char(10) + '(DBNAME asc, TrackerName ASC, ' + column_name + ' asc) ' 
+char(10) + 'GO'
+char(10) + 'Print END TIME: ''' + getdate() + '''' 
+char(10) + 'GO'
from INFORMATION_SCHEMA.COLUMNS
where table_name like 'FACT_TrackerData' and column_name like 'SurrogateKey_%'

--USE THE FOLLOWING TO CREATE ALL TRACKER TABLENAME COLUMNS
  SELECT 'If not exists (select column_name from information_Schema.columns where table_name = ''' + T.Table_name + ''' and column_name = ''TrackerName'')'
	+char(10) + 'Alter Table ' + T.table_name 
    +char(10) + 'ADD TrackerName nvarchar(100) default ''' + replace(substring(t.table_name, 6,9999), '_DEL','')  + ''';'
    +char(10) +'GO'
	+char(10) +'Print ''Processing ' + substring(t.table_name, 6,9999) + ''''
	+char(10) +'GO'
    +char(10) + 'Update ' + T.table_name + ' set TrackerName = ''' + replace(substring(t.table_name, 6,9999), '_DEL','') + ''' Where TrackerName is null'
	+char(10) + '   OR TrackerName != ''' + replace(substring(t.table_name, 6,9999), '_DEL','') + ''''
    +char(10) +'GO'+Char(10) 
    FROM INFORMATION_SCHEMA.TABLES t 
    LEFT JOIN INFORMATION_SCHEMA.COLUMNS c
    ON c.tABLE_NAME = t.TABLE_NAME 
    AND c.COLUMN_NAME = 'TrackerName'
    WHERE t.TABLE_NAME LIKE '%TRACKER%' 
    AND t.TABLE_NAME LIKE 'BASE_%' 
    AND t.TABLE_NAME not LIKE '%_NONULLS' 
    AND t.TABLE_NAME not LIKE '%_CtVerHist' 
    AND t.TABLE_NAME not LIKE '%_TestData' 
    AND t.TABLE_NAME not LIKE '%_VIEW_%' 
    AND t.TABLE_NAME not LIKE '%_LKP_%'     
    AND t.TABLE_NAME not LIKE '%_join_%'
    AND t.TABLE_NAME not LIKE '%Mapping'
    AND t.TABLE_NAME not LIKE '%Category'
    AND t.TABLE_NAME not LIKE '%_Item'
    AND t.TABLE_NAME not LIKE '%TrackerInstance_Tracker'    
--and C.Column_name is null
order by T.Table_Name
*/
go

IF NOT EXISTS (SELECT
                  name
                      FROM sys.indexes
                      WHERE
                      name = 'PI05_BASE_cms_usersettings') 
    BEGIN
        CREATE NONCLUSTERED INDEX PI05_BASE_cms_usersettings
        ON dbo.BASE_cms_usersettings (UserSettingsUserID , SVR , DBNAME , HFitUserMpiNumber) ;
    END;

GO

IF NOT EXISTS (SELECT
                  name
                      FROM sys.indexes
                      WHERE
                      name = 'PI05_BASE_cms_usersite') 
    BEGIN
        CREATE NONCLUSTERED INDEX PI05_BASE_cms_usersite
        ON dbo.BASE_cms_usersite (UserID , SiteID , SVR , DBNAME) ;
    END;

GO

IF NOT EXISTS (SELECT
                  name
                      FROM sys.indexes
                      WHERE
                      name = 'CI_BASE_HFit_Account') 
    BEGIN
        CREATE NONCLUSTERED INDEX CI_BASE_HFit_Account ON dbo.BASE_HFit_Account
        (
        SVR ASC ,
        DBNAME ASC ,
        SiteID ASC
        ) 
        INCLUDE (AccountCD , HashCode) WITH (PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , SORT_IN_TEMPDB = OFF , DROP_EXISTING = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON , FILLFACTOR = 80) ON [PRIMARY];
    END;
GO

IF NOT EXISTS (SELECT
                  name
                      FROM sys.indexes
                      WHERE
                      name = 'CI05_FACT_EDW_HealthAssesment') 
    BEGIN
        CREATE NONCLUSTERED INDEX CI05_FACT_EDW_HealthAssesment
        ON dbo.FACT_EDW_HealthAssesment (HAQUESTIONNODEGUID , SVR , DBNAME) 
        INCLUDE (USERSTARTEDITEMID) ;
    END;
GO

IF NOT EXISTS (SELECT
                  name
                      FROM sys.indexes
                      WHERE
                      name = 'CI05_BASE_HFit_HealthAssesmentUserQuestion') 
    BEGIN
        CREATE NONCLUSTERED INDEX CI05_BASE_HFit_HealthAssesmentUserQuestion
        ON dbo.BASE_HFit_HealthAssesmentUserQuestion (HARiskAreaItemID , SVR , DBNAME) 
        INCLUDE (HAQuestionScore , ItemModifiedWhen , CodeName , PreWeightedScore , IsProfessionallyCollected , HAQuestionNodeGUID , ItemID) ;
    END;
GO

IF NOT EXISTS (SELECT
                  name
                      FROM sys.indexes
                      WHERE
                      name = 'PKEY_FACT_EDW_TrackerCompositeDetails') 
    BEGIN
        CREATE UNIQUE NONCLUSTERED INDEX PKEY_FACT_EDW_TrackerCompositeDetails ON dbo.FACT_EDW_TrackerCompositeDetails
        (
        ItemID ASC ,
        SVR ,
        DBNAME , TrackerNameAggregateTable
        ) 
        INCLUDE (AccountCD) ;
    END;
GO

IF NOT EXISTS (SELECT
                  name
                      FROM sys.indexes
                      WHERE
                      name = 'PI01_FACT_HFit_TrackerCardio') 
    BEGIN
        CREATE NONCLUSTERED INDEX PI01_FACT_HFit_TrackerCardio
        ON dbo.FACT_HFit_TrackerCardio (ClientCode , SVR , DBNAME) 
        INCLUDE (TrackerNameAggregateTable , ItemID) ;
    END;

GO

IF NOT EXISTS (SELECT
                  name
                      FROM sys.indexes
                      WHERE
                      name = 'PI01_BASE_HFit_TrackerMealPortions') 
    BEGIN
        CREATE NONCLUSTERED INDEX PI01_BASE_HFit_TrackerMealPortions
        ON dbo.BASE_HFit_TrackerMealPortions (TrackerCollectionSourceID , SVR , DBNAME) 
        INCLUDE (UserID) ;
    END;
GO

IF NOT EXISTS (SELECT
                  name
                      FROM sys.indexes
                      WHERE
                      name = 'PI00_BASE_hfit_PPTEligibility') 
    BEGIN
        CREATE NONCLUSTERED INDEX PI00_BASE_hfit_PPTEligibility ON dbo.BASE_hfit_PPTEligibility (SVR , DBNAME) 
        INCLUDE (UserID , ClientCode) ;
    END;

GO
IF EXISTS (SELECT
              name
                  FROM sys.indexes
                  WHERE
                  name = 'CI_BASE_HFit_TrackerCollectionSource') 
    BEGIN
        DROP INDEX CI_BASE_HFit_TrackerCollectionSource ON dbo.BASE_HFit_TrackerCollectionSource;
    END;
GO

IF NOT EXISTS (SELECT
                  name
                      FROM sys.indexes
                      WHERE
                      name = 'CI_BASE_HFit_TrackerCollectionSource') 
    BEGIN
        CREATE NONCLUSTERED INDEX CI_BASE_HFit_TrackerCollectionSource ON dbo.BASE_HFit_TrackerCollectionSource
        (
        SVR ,
        DBNAME ,
        TrackerCollectionSourceID ,
        ItemID
        ) 
        INCLUDE (HashCode) ;
    END;
GO

IF NOT EXISTS (SELECT
                  name
                      FROM sys.indexes
                      WHERE
                      name = 'PI01_BASE_cms_user') 
    BEGIN

        CREATE NONCLUSTERED INDEX PI01_BASE_cms_user
        ON dbo.BASE_cms_user (UserID , SVR , DBNAME) ;
    END;
GO

IF NOT EXISTS (SELECT
                  name
                      FROM sys.indexes
                      WHERE
                      name = 'CI_BASE_hfit_PPTEligibility') 
    BEGIN
        --DROP INDEX [CI_BASE_hfit_PPTEligibility] ON [dbo].[BASE_hfit_PPTEligibility]
        EXEC printImmediate 'Creating [CI_BASE_hfit_PPTEligibility]';

        CREATE NONCLUSTERED INDEX CI_BASE_hfit_PPTEligibility ON dbo.BASE_hfit_PPTEligibility
        (
        SVR , DBNAME , ClientCode , UserID
        ) 
        INCLUDE (MPI , HashCode) WITH (PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , SORT_IN_TEMPDB = OFF , DROP_EXISTING = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
    END;
GO

IF NOT EXISTS (SELECT
                  name
                      FROM sys.indexes
                      WHERE
                      name = 'CI_BASE_HFit_TrackerBloodPressure') 
    BEGIN
        --DROP INDEX [CI_BASE_HFit_TrackerBloodPressure] ON [dbo].[BASE_HFit_TrackerBloodPressure]
        EXEC printImmediate 'Creating [CI_BASE_HFit_TrackerBloodPressure]';
        CREATE NONCLUSTERED INDEX [CI_BASE_HFit_TrackerBloodPressure ] ON dbo.BASE_HFit_TrackerBloodPressure
        (
        SVR ,
        DBNAME ,
        ItemID ,
        UserID
        ) 
        INCLUDE (TrackerCollectionSourceID , VendorID , HashCode) WITH (PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , SORT_IN_TEMPDB = OFF , DROP_EXISTING = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
    END;

IF NOT EXISTS (SELECT
                  name
                      FROM sys.indexes
                      WHERE
                      name = 'FACT_EDW_TrackerCompositeDetails_Recno') 
    BEGIN
        CREATE NONCLUSTERED INDEX FACT_EDW_TrackerCompositeDetails_Recno ON dbo.FACT_EDW_TrackerCompositeDetails
        (
        RowNumber ASC
        ) 
        INCLUDE ( 	TrackerNameAggregateTable) WITH (PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , SORT_IN_TEMPDB = OFF , DROP_EXISTING = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
    END;
GO

--*****************************************
print 'STARTING TRACKER INDEXES...'


If not exists (select column_name from information_Schema.columns where table_name = 'BASE_HFit_HealthAssessmentCodeNamesToTrackerMapping' and column_name = 'TrackerName')
Alter Table BASE_HFit_HealthAssessmentCodeNamesToTrackerMapping
ADD TrackerName nvarchar(100) default 'HFit_HealthAssessmentCodeNamesToTrackerMapping';
GO
Print 'Processing HFit_HealthAssessmentCodeNamesToTrackerMapping'
GO
Update BASE_HFit_HealthAssessmentCodeNamesToTrackerMapping set TrackerName = 'HFit_HealthAssessmentCodeNamesToTrackerMapping' Where TrackerName is null
   OR TrackerName != 'HFit_HealthAssessmentCodeNamesToTrackerMapping'
GO

If not exists (select column_name from information_Schema.columns where table_name = 'BASE_HFit_HealthAssessmentCodeNamesToTrackerMapping_DEL' and column_name = 'TrackerName')
Alter Table BASE_HFit_HealthAssessmentCodeNamesToTrackerMapping_DEL
ADD TrackerName nvarchar(100) default 'HFit_HealthAssessmentCodeNamesToTrackerMapping';
GO
Print 'Processing HFit_HealthAssessmentCodeNamesToTrackerMapping_DEL'
GO
Update BASE_HFit_HealthAssessmentCodeNamesToTrackerMapping_DEL set TrackerName = 'HFit_HealthAssessmentCodeNamesToTrackerMapping' Where TrackerName is null
   OR TrackerName != 'HFit_HealthAssessmentCodeNamesToTrackerMapping'
GO

If not exists (select column_name from information_Schema.columns where table_name = 'BASE_HFit_Join_ClinicalSourceTracker' and column_name = 'TrackerName')
Alter Table BASE_HFit_Join_ClinicalSourceTracker
ADD TrackerName nvarchar(100) default 'HFit_Join_ClinicalSourceTracker';
GO
Print 'Processing HFit_Join_ClinicalSourceTracker'
GO
Update BASE_HFit_Join_ClinicalSourceTracker set TrackerName = 'HFit_Join_ClinicalSourceTracker' Where TrackerName is null
   OR TrackerName != 'HFit_Join_ClinicalSourceTracker'
GO
-- use KenticoCMS_Datamart_2
If not exists (select column_name from information_Schema.columns where table_name = 'BASE_HFit_Join_ClinicalSourceTracker_DEL' and column_name = 'TrackerName')
Alter Table BASE_HFit_Join_ClinicalSourceTracker_DEL
ADD TrackerName nvarchar(100) default 'HFit_Join_ClinicalSourceTracker';
GO
Print 'Processing HFit_Join_ClinicalSourceTracker_DEL'
GO
Update BASE_HFit_Join_ClinicalSourceTracker_DEL set TrackerName = 'HFit_Join_ClinicalSourceTracker' Where TrackerName is null
   OR TrackerName != 'HFit_Join_ClinicalSourceTracker'
GO

If not exists (select column_name from information_Schema.columns where table_name = 'BASE_HFit_join_ClinicalTrackers' and column_name = 'TrackerName')
Alter Table BASE_HFit_join_ClinicalTrackers
ADD TrackerName nvarchar(100) default 'HFit_join_ClinicalTrackers';
GO
Print 'Processing HFit_join_ClinicalTrackers'
GO
Update BASE_HFit_join_ClinicalTrackers set TrackerName = 'HFit_join_ClinicalTrackers' Where TrackerName is null
   OR TrackerName != 'HFit_join_ClinicalTrackers'
GO

If not exists (select column_name from information_Schema.columns where table_name = 'BASE_HFit_join_ClinicalTrackers_DEL' and column_name = 'TrackerName')
Alter Table BASE_HFit_join_ClinicalTrackers_DEL
ADD TrackerName nvarchar(100) default 'HFit_join_ClinicalTrackers';
GO
Print 'Processing HFit_join_ClinicalTrackers_DEL'
GO
Update BASE_HFit_join_ClinicalTrackers_DEL set TrackerName = 'HFit_join_ClinicalTrackers' Where TrackerName is null
   OR TrackerName != 'HFit_join_ClinicalTrackers'
GO

If not exists (select column_name from information_Schema.columns where table_name = 'BASE_HFit_Ref_RewardTrackerValidation' and column_name = 'TrackerName')
Alter Table BASE_HFit_Ref_RewardTrackerValidation
ADD TrackerName nvarchar(100) default 'HFit_Ref_RewardTrackerValidation';
GO
Print 'Processing HFit_Ref_RewardTrackerValidation'
GO
Update BASE_HFit_Ref_RewardTrackerValidation set TrackerName = 'HFit_Ref_RewardTrackerValidation' Where TrackerName is null
   OR TrackerName != 'HFit_Ref_RewardTrackerValidation'
GO

If not exists (select column_name from information_Schema.columns where table_name = 'BASE_HFit_Ref_RewardTrackerValidation_DEL' and column_name = 'TrackerName')
Alter Table BASE_HFit_Ref_RewardTrackerValidation_DEL
ADD TrackerName nvarchar(100) default 'HFit_Ref_RewardTrackerValidation';
GO
Print 'Processing HFit_Ref_RewardTrackerValidation_DEL'
GO
Update BASE_HFit_Ref_RewardTrackerValidation_DEL set TrackerName = 'HFit_Ref_RewardTrackerValidation' Where TrackerName is null
   OR TrackerName != 'HFit_Ref_RewardTrackerValidation'
GO

If not exists (select column_name from information_Schema.columns where table_name = 'BASE_HFIT_Tracker' and column_name = 'TrackerName')
Alter Table BASE_HFIT_Tracker
ADD TrackerName nvarchar(100) default 'HFIT_Tracker';
GO
Print 'Processing HFIT_Tracker'
GO
Update BASE_HFIT_Tracker set TrackerName = 'HFIT_Tracker' Where TrackerName is null
   OR TrackerName != 'HFIT_Tracker'
GO

If not exists (select column_name from information_Schema.columns where table_name = 'BASE_HFIT_Tracker_DEL' and column_name = 'TrackerName')
Alter Table BASE_HFIT_Tracker_DEL
ADD TrackerName nvarchar(100) default 'HFIT_Tracker';
GO
Print 'Processing HFIT_Tracker_DEL'
GO
Update BASE_HFIT_Tracker_DEL set TrackerName = 'HFIT_Tracker' Where TrackerName is null
   OR TrackerName != 'HFIT_Tracker'
GO

If not exists (select column_name from information_Schema.columns where table_name = 'BASE_HFit_TrackerBloodPressure' and column_name = 'TrackerName')
Alter Table BASE_HFit_TrackerBloodPressure
ADD TrackerName nvarchar(100) default 'HFit_TrackerBloodPressure';
GO
Print 'Processing HFit_TrackerBloodPressure'
GO
Update BASE_HFit_TrackerBloodPressure set TrackerName = 'HFit_TrackerBloodPressure' Where TrackerName is null
   OR TrackerName != 'HFit_TrackerBloodPressure'
GO

If not exists (select column_name from information_Schema.columns where table_name = 'BASE_HFit_TrackerBloodPressure_DEL' and column_name = 'TrackerName')
Alter Table BASE_HFit_TrackerBloodPressure_DEL
ADD TrackerName nvarchar(100) default 'HFit_TrackerBloodPressure';
GO
Print 'Processing HFit_TrackerBloodPressure_DEL'
GO
Update BASE_HFit_TrackerBloodPressure_DEL set TrackerName = 'HFit_TrackerBloodPressure' Where TrackerName is null
   OR TrackerName != 'HFit_TrackerBloodPressure'
GO

If not exists (select column_name from information_Schema.columns where table_name = 'BASE_HFit_TrackerBloodSugarAndGlucose' and column_name = 'TrackerName')
Alter Table BASE_HFit_TrackerBloodSugarAndGlucose
ADD TrackerName nvarchar(100) default 'HFit_TrackerBloodSugarAndGlucose';
GO
Print 'Processing HFit_TrackerBloodSugarAndGlucose'
GO
Update BASE_HFit_TrackerBloodSugarAndGlucose set TrackerName = 'HFit_TrackerBloodSugarAndGlucose' Where TrackerName is null
   OR TrackerName != 'HFit_TrackerBloodSugarAndGlucose'
GO

If not exists (select column_name from information_Schema.columns where table_name = 'BASE_HFit_TrackerBloodSugarAndGlucose_DEL' and column_name = 'TrackerName')
Alter Table BASE_HFit_TrackerBloodSugarAndGlucose_DEL
ADD TrackerName nvarchar(100) default 'HFit_TrackerBloodSugarAndGlucose';
GO
Print 'Processing HFit_TrackerBloodSugarAndGlucose_DEL'
GO
Update BASE_HFit_TrackerBloodSugarAndGlucose_DEL set TrackerName = 'HFit_TrackerBloodSugarAndGlucose' Where TrackerName is null
   OR TrackerName != 'HFit_TrackerBloodSugarAndGlucose'
GO

If not exists (select column_name from information_Schema.columns where table_name = 'BASE_HFit_TrackerBMI' and column_name = 'TrackerName')
Alter Table BASE_HFit_TrackerBMI
ADD TrackerName nvarchar(100) default 'HFit_TrackerBMI';
GO
Print 'Processing HFit_TrackerBMI'
GO
Update BASE_HFit_TrackerBMI set TrackerName = 'HFit_TrackerBMI' Where TrackerName is null
   OR TrackerName != 'HFit_TrackerBMI'
GO

If not exists (select column_name from information_Schema.columns where table_name = 'BASE_HFit_TrackerBMI_DEL' and column_name = 'TrackerName')
Alter Table BASE_HFit_TrackerBMI_DEL
ADD TrackerName nvarchar(100) default 'HFit_TrackerBMI';
GO
Print 'Processing HFit_TrackerBMI_DEL'
GO
Update BASE_HFit_TrackerBMI_DEL set TrackerName = 'HFit_TrackerBMI' Where TrackerName is null
   OR TrackerName != 'HFit_TrackerBMI'
GO

If not exists (select column_name from information_Schema.columns where table_name = 'BASE_HFit_TrackerBodyFat' and column_name = 'TrackerName')
Alter Table BASE_HFit_TrackerBodyFat
ADD TrackerName nvarchar(100) default 'HFit_TrackerBodyFat';
GO
Print 'Processing HFit_TrackerBodyFat'
GO
Update BASE_HFit_TrackerBodyFat set TrackerName = 'HFit_TrackerBodyFat' Where TrackerName is null
   OR TrackerName != 'HFit_TrackerBodyFat'
GO

If not exists (select column_name from information_Schema.columns where table_name = 'BASE_HFit_TrackerBodyFat_DEL' and column_name = 'TrackerName')
Alter Table BASE_HFit_TrackerBodyFat_DEL
ADD TrackerName nvarchar(100) default 'HFit_TrackerBodyFat';
GO
Print 'Processing HFit_TrackerBodyFat_DEL'
GO
Update BASE_HFit_TrackerBodyFat_DEL set TrackerName = 'HFit_TrackerBodyFat' Where TrackerName is null
   OR TrackerName != 'HFit_TrackerBodyFat'
GO

If not exists (select column_name from information_Schema.columns where table_name = 'BASE_HFit_TrackerBodyMeasurements' and column_name = 'TrackerName')
Alter Table BASE_HFit_TrackerBodyMeasurements
ADD TrackerName nvarchar(100) default 'HFit_TrackerBodyMeasurements';
GO
Print 'Processing HFit_TrackerBodyMeasurements'
GO
Update BASE_HFit_TrackerBodyMeasurements set TrackerName = 'HFit_TrackerBodyMeasurements' Where TrackerName is null
   OR TrackerName != 'HFit_TrackerBodyMeasurements'
GO

If not exists (select column_name from information_Schema.columns where table_name = 'BASE_HFit_TrackerBodyMeasurements_DEL' and column_name = 'TrackerName')
Alter Table BASE_HFit_TrackerBodyMeasurements_DEL
ADD TrackerName nvarchar(100) default 'HFit_TrackerBodyMeasurements';
GO
Print 'Processing HFit_TrackerBodyMeasurements_DEL'
GO
Update BASE_HFit_TrackerBodyMeasurements_DEL set TrackerName = 'HFit_TrackerBodyMeasurements' Where TrackerName is null
   OR TrackerName != 'HFit_TrackerBodyMeasurements'
GO

If not exists (select column_name from information_Schema.columns where table_name = 'BASE_HFit_TrackerCardio' and column_name = 'TrackerName')
Alter Table BASE_HFit_TrackerCardio
ADD TrackerName nvarchar(100) default 'HFit_TrackerCardio';
GO
Print 'Processing HFit_TrackerCardio'
GO
Update BASE_HFit_TrackerCardio set TrackerName = 'HFit_TrackerCardio' Where TrackerName is null
   OR TrackerName != 'HFit_TrackerCardio'
GO

If not exists (select column_name from information_Schema.columns where table_name = 'BASE_HFit_TrackerCardio_DEL' and column_name = 'TrackerName')
Alter Table BASE_HFit_TrackerCardio_DEL
ADD TrackerName nvarchar(100) default 'HFit_TrackerCardio';
GO
Print 'Processing HFit_TrackerCardio_DEL'
GO
Update BASE_HFit_TrackerCardio_DEL set TrackerName = 'HFit_TrackerCardio' Where TrackerName is null
   OR TrackerName != 'HFit_TrackerCardio'
GO

If not exists (select column_name from information_Schema.columns where table_name = 'BASE_HFit_TrackerCategory' and column_name = 'TrackerName')
Alter Table BASE_HFit_TrackerCategory
ADD TrackerName nvarchar(100) default 'HFit_TrackerCategory';
GO
Print 'Processing HFit_TrackerCategory'
GO
Update BASE_HFit_TrackerCategory set TrackerName = 'HFit_TrackerCategory' Where TrackerName is null
   OR TrackerName != 'HFit_TrackerCategory'
GO

If not exists (select column_name from information_Schema.columns where table_name = 'BASE_HFit_TrackerCategory_DEL' and column_name = 'TrackerName')
Alter Table BASE_HFit_TrackerCategory_DEL
ADD TrackerName nvarchar(100) default 'HFit_TrackerCategory';
GO
Print 'Processing HFit_TrackerCategory_DEL'
GO
Update BASE_HFit_TrackerCategory_DEL set TrackerName = 'HFit_TrackerCategory' Where TrackerName is null
   OR TrackerName != 'HFit_TrackerCategory'
GO

If not exists (select column_name from information_Schema.columns where table_name = 'BASE_HFit_TrackerCholesterol' and column_name = 'TrackerName')
Alter Table BASE_HFit_TrackerCholesterol
ADD TrackerName nvarchar(100) default 'HFit_TrackerCholesterol';
GO
Print 'Processing HFit_TrackerCholesterol'
GO
Update BASE_HFit_TrackerCholesterol set TrackerName = 'HFit_TrackerCholesterol' Where TrackerName is null
   OR TrackerName != 'HFit_TrackerCholesterol'
GO

If not exists (select column_name from information_Schema.columns where table_name = 'BASE_HFit_TrackerCholesterol_DEL' and column_name = 'TrackerName')
Alter Table BASE_HFit_TrackerCholesterol_DEL
ADD TrackerName nvarchar(100) default 'HFit_TrackerCholesterol';
GO
Print 'Processing HFit_TrackerCholesterol_DEL'
GO
Update BASE_HFit_TrackerCholesterol_DEL set TrackerName = 'HFit_TrackerCholesterol' Where TrackerName is null
   OR TrackerName != 'HFit_TrackerCholesterol'
GO

If not exists (select column_name from information_Schema.columns where table_name = 'BASE_HFit_TrackerCollectionSource' and column_name = 'TrackerName')
Alter Table BASE_HFit_TrackerCollectionSource
ADD TrackerName nvarchar(100) default 'HFit_TrackerCollectionSource';
GO
Print 'Processing HFit_TrackerCollectionSource'
GO
Update BASE_HFit_TrackerCollectionSource set TrackerName = 'HFit_TrackerCollectionSource' Where TrackerName is null
   OR TrackerName != 'HFit_TrackerCollectionSource'
GO

If not exists (select column_name from information_Schema.columns where table_name = 'BASE_HFit_TrackerCollectionSource_DEL' and column_name = 'TrackerName')
Alter Table BASE_HFit_TrackerCollectionSource_DEL
ADD TrackerName nvarchar(100) default 'HFit_TrackerCollectionSource';
GO
Print 'Processing HFit_TrackerCollectionSource_DEL'
GO
Update BASE_HFit_TrackerCollectionSource_DEL set TrackerName = 'HFit_TrackerCollectionSource' Where TrackerName is null
   OR TrackerName != 'HFit_TrackerCollectionSource'
GO

If not exists (select column_name from information_Schema.columns where table_name = 'BASE_HFit_TrackerCotinine' and column_name = 'TrackerName')
Alter Table BASE_HFit_TrackerCotinine
ADD TrackerName nvarchar(100) default 'HFit_TrackerCotinine';
GO
Print 'Processing HFit_TrackerCotinine'
GO
Update BASE_HFit_TrackerCotinine set TrackerName = 'HFit_TrackerCotinine' Where TrackerName is null
   OR TrackerName != 'HFit_TrackerCotinine'
GO

If not exists (select column_name from information_Schema.columns where table_name = 'BASE_HFit_TrackerCotinine_DEL' and column_name = 'TrackerName')
Alter Table BASE_HFit_TrackerCotinine_DEL
ADD TrackerName nvarchar(100) default 'HFit_TrackerCotinine';
GO
Print 'Processing HFit_TrackerCotinine_DEL'
GO
Update BASE_HFit_TrackerCotinine_DEL set TrackerName = 'HFit_TrackerCotinine' Where TrackerName is null
   OR TrackerName != 'HFit_TrackerCotinine'
GO

If not exists (select column_name from information_Schema.columns where table_name = 'BASE_HFit_TrackerDailySteps' and column_name = 'TrackerName')
Alter Table BASE_HFit_TrackerDailySteps
ADD TrackerName nvarchar(100) default 'HFit_TrackerDailySteps';
GO
Print 'Processing HFit_TrackerDailySteps'
GO
Update BASE_HFit_TrackerDailySteps set TrackerName = 'HFit_TrackerDailySteps' Where TrackerName is null
   OR TrackerName != 'HFit_TrackerDailySteps'
GO

If not exists (select column_name from information_Schema.columns where table_name = 'BASE_HFit_TrackerDailySteps_DEL' and column_name = 'TrackerName')
Alter Table BASE_HFit_TrackerDailySteps_DEL
ADD TrackerName nvarchar(100) default 'HFit_TrackerDailySteps';
GO
Print 'Processing HFit_TrackerDailySteps_DEL'
GO
Update BASE_HFit_TrackerDailySteps_DEL set TrackerName = 'HFit_TrackerDailySteps' Where TrackerName is null
   OR TrackerName != 'HFit_TrackerDailySteps'
GO

If not exists (select column_name from information_Schema.columns where table_name = 'BASE_HFit_TrackerDef_Item' and column_name = 'TrackerName')
Alter Table BASE_HFit_TrackerDef_Item
ADD TrackerName nvarchar(100) default 'HFit_TrackerDef_Item';
GO
Print 'Processing HFit_TrackerDef_Item'
GO
Update BASE_HFit_TrackerDef_Item set TrackerName = 'HFit_TrackerDef_Item' Where TrackerName is null
   OR TrackerName != 'HFit_TrackerDef_Item'
GO

If not exists (select column_name from information_Schema.columns where table_name = 'BASE_HFit_TrackerDef_Item_DEL' and column_name = 'TrackerName')
Alter Table BASE_HFit_TrackerDef_Item_DEL
ADD TrackerName nvarchar(100) default 'HFit_TrackerDef_Item';
GO
Print 'Processing HFit_TrackerDef_Item_DEL'
GO
Update BASE_HFit_TrackerDef_Item_DEL set TrackerName = 'HFit_TrackerDef_Item' Where TrackerName is null
   OR TrackerName != 'HFit_TrackerDef_Item'
GO

If not exists (select column_name from information_Schema.columns where table_name = 'BASE_HFit_TrackerDef_Tracker' and column_name = 'TrackerName')
Alter Table BASE_HFit_TrackerDef_Tracker
ADD TrackerName nvarchar(100) default 'HFit_TrackerDef_Tracker';
GO
Print 'Processing HFit_TrackerDef_Tracker'
GO
Update BASE_HFit_TrackerDef_Tracker set TrackerName = 'HFit_TrackerDef_Tracker' Where TrackerName is null
   OR TrackerName != 'HFit_TrackerDef_Tracker'
GO

If not exists (select column_name from information_Schema.columns where table_name = 'BASE_HFit_TrackerDef_Tracker_DEL' and column_name = 'TrackerName')
Alter Table BASE_HFit_TrackerDef_Tracker_DEL
ADD TrackerName nvarchar(100) default 'HFit_TrackerDef_Tracker';
GO
Print 'Processing HFit_TrackerDef_Tracker_DEL'
GO
Update BASE_HFit_TrackerDef_Tracker_DEL set TrackerName = 'HFit_TrackerDef_Tracker' Where TrackerName is null
   OR TrackerName != 'HFit_TrackerDef_Tracker'
GO

If not exists (select column_name from information_Schema.columns where table_name = 'BASE_HFit_TrackerDocument' and column_name = 'TrackerName')
Alter Table BASE_HFit_TrackerDocument
ADD TrackerName nvarchar(100) default 'HFit_TrackerDocument';
GO
Print 'Processing HFit_TrackerDocument'
GO
Update BASE_HFit_TrackerDocument set TrackerName = 'HFit_TrackerDocument' Where TrackerName is null
   OR TrackerName != 'HFit_TrackerDocument'
GO

If not exists (select column_name from information_Schema.columns where table_name = 'BASE_HFit_TrackerDocument_DEL' and column_name = 'TrackerName')
Alter Table BASE_HFit_TrackerDocument_DEL
ADD TrackerName nvarchar(100) default 'HFit_TrackerDocument';
GO
Print 'Processing HFit_TrackerDocument_DEL'
GO
Update BASE_HFit_TrackerDocument_DEL set TrackerName = 'HFit_TrackerDocument' Where TrackerName is null
   OR TrackerName != 'HFit_TrackerDocument'
GO

If not exists (select column_name from information_Schema.columns where table_name = 'BASE_HFit_TrackerFlexibility' and column_name = 'TrackerName')
Alter Table BASE_HFit_TrackerFlexibility
ADD TrackerName nvarchar(100) default 'HFit_TrackerFlexibility';
GO
Print 'Processing HFit_TrackerFlexibility'
GO
Update BASE_HFit_TrackerFlexibility set TrackerName = 'HFit_TrackerFlexibility' Where TrackerName is null
   OR TrackerName != 'HFit_TrackerFlexibility'
GO

If not exists (select column_name from information_Schema.columns where table_name = 'BASE_HFit_TrackerFlexibility_DEL' and column_name = 'TrackerName')
Alter Table BASE_HFit_TrackerFlexibility_DEL
ADD TrackerName nvarchar(100) default 'HFit_TrackerFlexibility';
GO
Print 'Processing HFit_TrackerFlexibility_DEL'
GO
Update BASE_HFit_TrackerFlexibility_DEL set TrackerName = 'HFit_TrackerFlexibility' Where TrackerName is null
   OR TrackerName != 'HFit_TrackerFlexibility'
GO

If not exists (select column_name from information_Schema.columns where table_name = 'BASE_HFit_TrackerFruits' and column_name = 'TrackerName')
Alter Table BASE_HFit_TrackerFruits
ADD TrackerName nvarchar(100) default 'HFit_TrackerFruits';
GO
Print 'Processing HFit_TrackerFruits'
GO
Update BASE_HFit_TrackerFruits set TrackerName = 'HFit_TrackerFruits' Where TrackerName is null
   OR TrackerName != 'HFit_TrackerFruits'
GO

If not exists (select column_name from information_Schema.columns where table_name = 'BASE_HFit_TrackerFruits_DEL' and column_name = 'TrackerName')
Alter Table BASE_HFit_TrackerFruits_DEL
ADD TrackerName nvarchar(100) default 'HFit_TrackerFruits';
GO
Print 'Processing HFit_TrackerFruits_DEL'
GO
Update BASE_HFit_TrackerFruits_DEL set TrackerName = 'HFit_TrackerFruits' Where TrackerName is null
   OR TrackerName != 'HFit_TrackerFruits'
GO

If not exists (select column_name from information_Schema.columns where table_name = 'BASE_HFit_TrackerHbA1c' and column_name = 'TrackerName')
Alter Table BASE_HFit_TrackerHbA1c
ADD TrackerName nvarchar(100) default 'HFit_TrackerHbA1c';
GO
Print 'Processing HFit_TrackerHbA1c'
GO
Update BASE_HFit_TrackerHbA1c set TrackerName = 'HFit_TrackerHbA1c' Where TrackerName is null
   OR TrackerName != 'HFit_TrackerHbA1c'
GO

If not exists (select column_name from information_Schema.columns where table_name = 'BASE_HFit_TrackerHbA1c_DEL' and column_name = 'TrackerName')
Alter Table BASE_HFit_TrackerHbA1c_DEL
ADD TrackerName nvarchar(100) default 'HFit_TrackerHbA1c';
GO
Print 'Processing HFit_TrackerHbA1c_DEL'
GO
Update BASE_HFit_TrackerHbA1c_DEL set TrackerName = 'HFit_TrackerHbA1c' Where TrackerName is null
   OR TrackerName != 'HFit_TrackerHbA1c'
GO

If not exists (select column_name from information_Schema.columns where table_name = 'BASE_HFit_TrackerHeight' and column_name = 'TrackerName')
Alter Table BASE_HFit_TrackerHeight
ADD TrackerName nvarchar(100) default 'HFit_TrackerHeight';
GO
Print 'Processing HFit_TrackerHeight'
GO
Update BASE_HFit_TrackerHeight set TrackerName = 'HFit_TrackerHeight' Where TrackerName is null
   OR TrackerName != 'HFit_TrackerHeight'
GO

If not exists (select column_name from information_Schema.columns where table_name = 'BASE_HFit_TrackerHeight_DEL' and column_name = 'TrackerName')
Alter Table BASE_HFit_TrackerHeight_DEL
ADD TrackerName nvarchar(100) default 'HFit_TrackerHeight';
GO
Print 'Processing HFit_TrackerHeight_DEL'
GO
Update BASE_HFit_TrackerHeight_DEL set TrackerName = 'HFit_TrackerHeight' Where TrackerName is null
   OR TrackerName != 'HFit_TrackerHeight'
GO

If not exists (select column_name from information_Schema.columns where table_name = 'BASE_HFit_TrackerHighFatFoods' and column_name = 'TrackerName')
Alter Table BASE_HFit_TrackerHighFatFoods
ADD TrackerName nvarchar(100) default 'HFit_TrackerHighFatFoods';
GO
Print 'Processing HFit_TrackerHighFatFoods'
GO
Update BASE_HFit_TrackerHighFatFoods set TrackerName = 'HFit_TrackerHighFatFoods' Where TrackerName is null
   OR TrackerName != 'HFit_TrackerHighFatFoods'
GO

If not exists (select column_name from information_Schema.columns where table_name = 'BASE_HFit_TrackerHighFatFoods_DEL' and column_name = 'TrackerName')
Alter Table BASE_HFit_TrackerHighFatFoods_DEL
ADD TrackerName nvarchar(100) default 'HFit_TrackerHighFatFoods';
GO
Print 'Processing HFit_TrackerHighFatFoods_DEL'
GO
Update BASE_HFit_TrackerHighFatFoods_DEL set TrackerName = 'HFit_TrackerHighFatFoods' Where TrackerName is null
   OR TrackerName != 'HFit_TrackerHighFatFoods'
GO

If not exists (select column_name from information_Schema.columns where table_name = 'BASE_HFit_TrackerHighSodiumFoods' and column_name = 'TrackerName')
Alter Table BASE_HFit_TrackerHighSodiumFoods
ADD TrackerName nvarchar(100) default 'HFit_TrackerHighSodiumFoods';
GO
Print 'Processing HFit_TrackerHighSodiumFoods'
GO
Update BASE_HFit_TrackerHighSodiumFoods set TrackerName = 'HFit_TrackerHighSodiumFoods' Where TrackerName is null
   OR TrackerName != 'HFit_TrackerHighSodiumFoods'
GO

If not exists (select column_name from information_Schema.columns where table_name = 'BASE_HFit_TrackerHighSodiumFoods_DEL' and column_name = 'TrackerName')
Alter Table BASE_HFit_TrackerHighSodiumFoods_DEL
ADD TrackerName nvarchar(100) default 'HFit_TrackerHighSodiumFoods';
GO
Print 'Processing HFit_TrackerHighSodiumFoods_DEL'
GO
Update BASE_HFit_TrackerHighSodiumFoods_DEL set TrackerName = 'HFit_TrackerHighSodiumFoods' Where TrackerName is null
   OR TrackerName != 'HFit_TrackerHighSodiumFoods'
GO

If not exists (select column_name from information_Schema.columns where table_name = 'BASE_HFit_TrackerInstance_Item' and column_name = 'TrackerName')
Alter Table BASE_HFit_TrackerInstance_Item
ADD TrackerName nvarchar(100) default 'HFit_TrackerInstance_Item';
GO
Print 'Processing HFit_TrackerInstance_Item'
GO
Update BASE_HFit_TrackerInstance_Item set TrackerName = 'HFit_TrackerInstance_Item' Where TrackerName is null
   OR TrackerName != 'HFit_TrackerInstance_Item'
GO

If not exists (select column_name from information_Schema.columns where table_name = 'BASE_HFit_TrackerInstance_Item_DEL' and column_name = 'TrackerName')
Alter Table BASE_HFit_TrackerInstance_Item_DEL
ADD TrackerName nvarchar(100) default 'HFit_TrackerInstance_Item';
GO
Print 'Processing HFit_TrackerInstance_Item_DEL'
GO
Update BASE_HFit_TrackerInstance_Item_DEL set TrackerName = 'HFit_TrackerInstance_Item' Where TrackerName is null
   OR TrackerName != 'HFit_TrackerInstance_Item'
GO

If not exists (select column_name from information_Schema.columns where table_name = 'BASE_HFit_TrackerInstance_Tracker' and column_name = 'TrackerName')
Alter Table BASE_HFit_TrackerInstance_Tracker
ADD TrackerName nvarchar(100) default 'HFit_TrackerInstance_Tracker';
GO
Print 'Processing HFit_TrackerInstance_Tracker'
GO
Update BASE_HFit_TrackerInstance_Tracker set TrackerName = 'HFit_TrackerInstance_Tracker' Where TrackerName is null
   OR TrackerName != 'HFit_TrackerInstance_Tracker'
GO

If not exists (select column_name from information_Schema.columns where table_name = 'BASE_HFit_TrackerInstance_Tracker_DEL' and column_name = 'TrackerName')
Alter Table BASE_HFit_TrackerInstance_Tracker_DEL
ADD TrackerName nvarchar(100) default 'HFit_TrackerInstance_Tracker';
GO
Print 'Processing HFit_TrackerInstance_Tracker_DEL'
GO
Update BASE_HFit_TrackerInstance_Tracker_DEL set TrackerName = 'HFit_TrackerInstance_Tracker' Where TrackerName is null
   OR TrackerName != 'HFit_TrackerInstance_Tracker'
GO

If not exists (select column_name from information_Schema.columns where table_name = 'BASE_HFit_TrackerMealPortions' and column_name = 'TrackerName')
Alter Table BASE_HFit_TrackerMealPortions
ADD TrackerName nvarchar(100) default 'HFit_TrackerMealPortions';
GO
Print 'Processing HFit_TrackerMealPortions'
GO
Update BASE_HFit_TrackerMealPortions set TrackerName = 'HFit_TrackerMealPortions' Where TrackerName is null
   OR TrackerName != 'HFit_TrackerMealPortions'
GO

If not exists (select column_name from information_Schema.columns where table_name = 'BASE_HFit_TrackerMealPortions_DEL' and column_name = 'TrackerName')
Alter Table BASE_HFit_TrackerMealPortions_DEL
ADD TrackerName nvarchar(100) default 'HFit_TrackerMealPortions';
GO
Print 'Processing HFit_TrackerMealPortions_DEL'
GO
Update BASE_HFit_TrackerMealPortions_DEL set TrackerName = 'HFit_TrackerMealPortions' Where TrackerName is null
   OR TrackerName != 'HFit_TrackerMealPortions'
GO

If not exists (select column_name from information_Schema.columns where table_name = 'BASE_HFit_TrackerMedicalCarePlan' and column_name = 'TrackerName')
Alter Table BASE_HFit_TrackerMedicalCarePlan
ADD TrackerName nvarchar(100) default 'HFit_TrackerMedicalCarePlan';
GO
Print 'Processing HFit_TrackerMedicalCarePlan'
GO
Update BASE_HFit_TrackerMedicalCarePlan set TrackerName = 'HFit_TrackerMedicalCarePlan' Where TrackerName is null
   OR TrackerName != 'HFit_TrackerMedicalCarePlan'
GO

If not exists (select column_name from information_Schema.columns where table_name = 'BASE_HFit_TrackerMedicalCarePlan_DEL' and column_name = 'TrackerName')
Alter Table BASE_HFit_TrackerMedicalCarePlan_DEL
ADD TrackerName nvarchar(100) default 'HFit_TrackerMedicalCarePlan';
GO
Print 'Processing HFit_TrackerMedicalCarePlan_DEL'
GO
Update BASE_HFit_TrackerMedicalCarePlan_DEL set TrackerName = 'HFit_TrackerMedicalCarePlan' Where TrackerName is null
   OR TrackerName != 'HFit_TrackerMedicalCarePlan'
GO

If not exists (select column_name from information_Schema.columns where table_name = 'BASE_HFit_TrackerPreventiveCare' and column_name = 'TrackerName')
Alter Table BASE_HFit_TrackerPreventiveCare
ADD TrackerName nvarchar(100) default 'HFit_TrackerPreventiveCare';
GO
Print 'Processing HFit_TrackerPreventiveCare'
GO
Update BASE_HFit_TrackerPreventiveCare set TrackerName = 'HFit_TrackerPreventiveCare' Where TrackerName is null
   OR TrackerName != 'HFit_TrackerPreventiveCare'
GO

If not exists (select column_name from information_Schema.columns where table_name = 'BASE_HFit_TrackerPreventiveCare_DEL' and column_name = 'TrackerName')
Alter Table BASE_HFit_TrackerPreventiveCare_DEL
ADD TrackerName nvarchar(100) default 'HFit_TrackerPreventiveCare';
GO
Print 'Processing HFit_TrackerPreventiveCare_DEL'
GO
Update BASE_HFit_TrackerPreventiveCare_DEL set TrackerName = 'HFit_TrackerPreventiveCare' Where TrackerName is null
   OR TrackerName != 'HFit_TrackerPreventiveCare'
GO

If not exists (select column_name from information_Schema.columns where table_name = 'BASE_HFit_TrackerRegularMeals' and column_name = 'TrackerName')
Alter Table BASE_HFit_TrackerRegularMeals
ADD TrackerName nvarchar(100) default 'HFit_TrackerRegularMeals';
GO
Print 'Processing HFit_TrackerRegularMeals'
GO
Update BASE_HFit_TrackerRegularMeals set TrackerName = 'HFit_TrackerRegularMeals' Where TrackerName is null
   OR TrackerName != 'HFit_TrackerRegularMeals'
GO

If not exists (select column_name from information_Schema.columns where table_name = 'BASE_HFit_TrackerRegularMeals_DEL' and column_name = 'TrackerName')
Alter Table BASE_HFit_TrackerRegularMeals_DEL
ADD TrackerName nvarchar(100) default 'HFit_TrackerRegularMeals';
GO
Print 'Processing HFit_TrackerRegularMeals_DEL'
GO
Update BASE_HFit_TrackerRegularMeals_DEL set TrackerName = 'HFit_TrackerRegularMeals' Where TrackerName is null
   OR TrackerName != 'HFit_TrackerRegularMeals'
GO

If not exists (select column_name from information_Schema.columns where table_name = 'BASE_HFit_TrackerRestingHeartRate' and column_name = 'TrackerName')
Alter Table BASE_HFit_TrackerRestingHeartRate
ADD TrackerName nvarchar(100) default 'HFit_TrackerRestingHeartRate';
GO
Print 'Processing HFit_TrackerRestingHeartRate'
GO
Update BASE_HFit_TrackerRestingHeartRate set TrackerName = 'HFit_TrackerRestingHeartRate' Where TrackerName is null
   OR TrackerName != 'HFit_TrackerRestingHeartRate'
GO

If not exists (select column_name from information_Schema.columns where table_name = 'BASE_HFit_TrackerRestingHeartRate_DEL' and column_name = 'TrackerName')
Alter Table BASE_HFit_TrackerRestingHeartRate_DEL
ADD TrackerName nvarchar(100) default 'HFit_TrackerRestingHeartRate';
GO
Print 'Processing HFit_TrackerRestingHeartRate_DEL'
GO
Update BASE_HFit_TrackerRestingHeartRate_DEL set TrackerName = 'HFit_TrackerRestingHeartRate' Where TrackerName is null
   OR TrackerName != 'HFit_TrackerRestingHeartRate'
GO

If not exists (select column_name from information_Schema.columns where table_name = 'BASE_HFit_TrackerShots' and column_name = 'TrackerName')
Alter Table BASE_HFit_TrackerShots
ADD TrackerName nvarchar(100) default 'HFit_TrackerShots';
GO
Print 'Processing HFit_TrackerShots'
GO
Update BASE_HFit_TrackerShots set TrackerName = 'HFit_TrackerShots' Where TrackerName is null
   OR TrackerName != 'HFit_TrackerShots'
GO

If not exists (select column_name from information_Schema.columns where table_name = 'BASE_HFit_TrackerShots_DEL' and column_name = 'TrackerName')
Alter Table BASE_HFit_TrackerShots_DEL
ADD TrackerName nvarchar(100) default 'HFit_TrackerShots';
GO
Print 'Processing HFit_TrackerShots_DEL'
GO
Update BASE_HFit_TrackerShots_DEL set TrackerName = 'HFit_TrackerShots' Where TrackerName is null
   OR TrackerName != 'HFit_TrackerShots'
GO

If not exists (select column_name from information_Schema.columns where table_name = 'BASE_HFit_TrackerSitLess' and column_name = 'TrackerName')
Alter Table BASE_HFit_TrackerSitLess
ADD TrackerName nvarchar(100) default 'HFit_TrackerSitLess';
GO
Print 'Processing HFit_TrackerSitLess'
GO
Update BASE_HFit_TrackerSitLess set TrackerName = 'HFit_TrackerSitLess' Where TrackerName is null
   OR TrackerName != 'HFit_TrackerSitLess'
GO

If not exists (select column_name from information_Schema.columns where table_name = 'BASE_HFit_TrackerSitLess_DEL' and column_name = 'TrackerName')
Alter Table BASE_HFit_TrackerSitLess_DEL
ADD TrackerName nvarchar(100) default 'HFit_TrackerSitLess';
GO
Print 'Processing HFit_TrackerSitLess_DEL'
GO
Update BASE_HFit_TrackerSitLess_DEL set TrackerName = 'HFit_TrackerSitLess' Where TrackerName is null
   OR TrackerName != 'HFit_TrackerSitLess'
GO

If not exists (select column_name from information_Schema.columns where table_name = 'BASE_HFit_TrackerSleepPlan' and column_name = 'TrackerName')
Alter Table BASE_HFit_TrackerSleepPlan
ADD TrackerName nvarchar(100) default 'HFit_TrackerSleepPlan';
GO
Print 'Processing HFit_TrackerSleepPlan'
GO
Update BASE_HFit_TrackerSleepPlan set TrackerName = 'HFit_TrackerSleepPlan' Where TrackerName is null
   OR TrackerName != 'HFit_TrackerSleepPlan'
GO

If not exists (select column_name from information_Schema.columns where table_name = 'BASE_HFit_TrackerSleepPlan_DEL' and column_name = 'TrackerName')
Alter Table BASE_HFit_TrackerSleepPlan_DEL
ADD TrackerName nvarchar(100) default 'HFit_TrackerSleepPlan';
GO
Print 'Processing HFit_TrackerSleepPlan_DEL'
GO
Update BASE_HFit_TrackerSleepPlan_DEL set TrackerName = 'HFit_TrackerSleepPlan' Where TrackerName is null
   OR TrackerName != 'HFit_TrackerSleepPlan'
GO

If not exists (select column_name from information_Schema.columns where table_name = 'BASE_HFit_TrackerStrength' and column_name = 'TrackerName')
Alter Table BASE_HFit_TrackerStrength
ADD TrackerName nvarchar(100) default 'HFit_TrackerStrength';
GO
Print 'Processing HFit_TrackerStrength'
GO
Update BASE_HFit_TrackerStrength set TrackerName = 'HFit_TrackerStrength' Where TrackerName is null
   OR TrackerName != 'HFit_TrackerStrength'
GO

If not exists (select column_name from information_Schema.columns where table_name = 'BASE_HFit_TrackerStrength_DEL' and column_name = 'TrackerName')
Alter Table BASE_HFit_TrackerStrength_DEL
ADD TrackerName nvarchar(100) default 'HFit_TrackerStrength';
GO
Print 'Processing HFit_TrackerStrength_DEL'
GO
Update BASE_HFit_TrackerStrength_DEL set TrackerName = 'HFit_TrackerStrength' Where TrackerName is null
   OR TrackerName != 'HFit_TrackerStrength'
GO

If not exists (select column_name from information_Schema.columns where table_name = 'BASE_HFit_TrackerStress' and column_name = 'TrackerName')
Alter Table BASE_HFit_TrackerStress
ADD TrackerName nvarchar(100) default 'HFit_TrackerStress';
GO
Print 'Processing HFit_TrackerStress'
GO
Update BASE_HFit_TrackerStress set TrackerName = 'HFit_TrackerStress' Where TrackerName is null
   OR TrackerName != 'HFit_TrackerStress'
GO

If not exists (select column_name from information_Schema.columns where table_name = 'BASE_HFit_TrackerStress_DEL' and column_name = 'TrackerName')
Alter Table BASE_HFit_TrackerStress_DEL
ADD TrackerName nvarchar(100) default 'HFit_TrackerStress';
GO
Print 'Processing HFit_TrackerStress_DEL'
GO
Update BASE_HFit_TrackerStress_DEL set TrackerName = 'HFit_TrackerStress' Where TrackerName is null
   OR TrackerName != 'HFit_TrackerStress'
GO

If not exists (select column_name from information_Schema.columns where table_name = 'BASE_HFit_TrackerStressManagement' and column_name = 'TrackerName')
Alter Table BASE_HFit_TrackerStressManagement
ADD TrackerName nvarchar(100) default 'HFit_TrackerStressManagement';
GO
Print 'Processing HFit_TrackerStressManagement'
GO
Update BASE_HFit_TrackerStressManagement set TrackerName = 'HFit_TrackerStressManagement' Where TrackerName is null
   OR TrackerName != 'HFit_TrackerStressManagement'
GO

If not exists (select column_name from information_Schema.columns where table_name = 'BASE_HFit_TrackerStressManagement_DEL' and column_name = 'TrackerName')
Alter Table BASE_HFit_TrackerStressManagement_DEL
ADD TrackerName nvarchar(100) default 'HFit_TrackerStressManagement';
GO
Print 'Processing HFit_TrackerStressManagement_DEL'
GO
Update BASE_HFit_TrackerStressManagement_DEL set TrackerName = 'HFit_TrackerStressManagement' Where TrackerName is null
   OR TrackerName != 'HFit_TrackerStressManagement'
GO

If not exists (select column_name from information_Schema.columns where table_name = 'BASE_HFit_TrackerSugaryDrinks' and column_name = 'TrackerName')
Alter Table BASE_HFit_TrackerSugaryDrinks
ADD TrackerName nvarchar(100) default 'HFit_TrackerSugaryDrinks';
GO
Print 'Processing HFit_TrackerSugaryDrinks'
GO
Update BASE_HFit_TrackerSugaryDrinks set TrackerName = 'HFit_TrackerSugaryDrinks' Where TrackerName is null
   OR TrackerName != 'HFit_TrackerSugaryDrinks'
GO

If not exists (select column_name from information_Schema.columns where table_name = 'BASE_HFit_TrackerSugaryDrinks_DEL' and column_name = 'TrackerName')
Alter Table BASE_HFit_TrackerSugaryDrinks_DEL
ADD TrackerName nvarchar(100) default 'HFit_TrackerSugaryDrinks';
GO
Print 'Processing HFit_TrackerSugaryDrinks_DEL'
GO
Update BASE_HFit_TrackerSugaryDrinks_DEL set TrackerName = 'HFit_TrackerSugaryDrinks' Where TrackerName is null
   OR TrackerName != 'HFit_TrackerSugaryDrinks'
GO

If not exists (select column_name from information_Schema.columns where table_name = 'BASE_HFit_TrackerSugaryFoods' and column_name = 'TrackerName')
Alter Table BASE_HFit_TrackerSugaryFoods
ADD TrackerName nvarchar(100) default 'HFit_TrackerSugaryFoods';
GO
Print 'Processing HFit_TrackerSugaryFoods'
GO
Update BASE_HFit_TrackerSugaryFoods set TrackerName = 'HFit_TrackerSugaryFoods' Where TrackerName is null
   OR TrackerName != 'HFit_TrackerSugaryFoods'
GO

If not exists (select column_name from information_Schema.columns where table_name = 'BASE_HFit_TrackerSugaryFoods_DEL' and column_name = 'TrackerName')
Alter Table BASE_HFit_TrackerSugaryFoods_DEL
ADD TrackerName nvarchar(100) default 'HFit_TrackerSugaryFoods';
GO
Print 'Processing HFit_TrackerSugaryFoods_DEL'
GO
Update BASE_HFit_TrackerSugaryFoods_DEL set TrackerName = 'HFit_TrackerSugaryFoods' Where TrackerName is null
   OR TrackerName != 'HFit_TrackerSugaryFoods'
GO

If not exists (select column_name from information_Schema.columns where table_name = 'BASE_HFit_TrackerSummary' and column_name = 'TrackerName')
Alter Table BASE_HFit_TrackerSummary
ADD TrackerName nvarchar(100) default 'HFit_TrackerSummary';
GO
Print 'Processing HFit_TrackerSummary'
GO
Update BASE_HFit_TrackerSummary set TrackerName = 'HFit_TrackerSummary' Where TrackerName is null
   OR TrackerName != 'HFit_TrackerSummary'
GO

If not exists (select column_name from information_Schema.columns where table_name = 'BASE_HFit_TrackerSummary_DEL' and column_name = 'TrackerName')
Alter Table BASE_HFit_TrackerSummary_DEL
ADD TrackerName nvarchar(100) default 'HFit_TrackerSummary';
GO
Print 'Processing HFit_TrackerSummary_DEL'
GO
Update BASE_HFit_TrackerSummary_DEL set TrackerName = 'HFit_TrackerSummary' Where TrackerName is null
   OR TrackerName != 'HFit_TrackerSummary'
GO

If not exists (select column_name from information_Schema.columns where table_name = 'BASE_HFit_TrackerTests' and column_name = 'TrackerName')
Alter Table BASE_HFit_TrackerTests
ADD TrackerName nvarchar(100) default 'HFit_TrackerTests';
GO
Print 'Processing HFit_TrackerTests'
GO
Update BASE_HFit_TrackerTests set TrackerName = 'HFit_TrackerTests' Where TrackerName is null
   OR TrackerName != 'HFit_TrackerTests'
GO

If not exists (select column_name from information_Schema.columns where table_name = 'BASE_HFit_TrackerTests_DEL' and column_name = 'TrackerName')
Alter Table BASE_HFit_TrackerTests_DEL
ADD TrackerName nvarchar(100) default 'HFit_TrackerTests';
GO
Print 'Processing HFit_TrackerTests_DEL'
GO
Update BASE_HFit_TrackerTests_DEL set TrackerName = 'HFit_TrackerTests' Where TrackerName is null
   OR TrackerName != 'HFit_TrackerTests'
GO

If not exists (select column_name from information_Schema.columns where table_name = 'BASE_HFit_TrackerTobaccoAttestation' and column_name = 'TrackerName')
Alter Table BASE_HFit_TrackerTobaccoAttestation
ADD TrackerName nvarchar(100) default 'HFit_TrackerTobaccoAttestation';
GO
Print 'Processing HFit_TrackerTobaccoAttestation'
GO
Update BASE_HFit_TrackerTobaccoAttestation set TrackerName = 'HFit_TrackerTobaccoAttestation' Where TrackerName is null
   OR TrackerName != 'HFit_TrackerTobaccoAttestation'
GO

If not exists (select column_name from information_Schema.columns where table_name = 'BASE_HFit_TrackerTobaccoAttestation_DEL' and column_name = 'TrackerName')
Alter Table BASE_HFit_TrackerTobaccoAttestation_DEL
ADD TrackerName nvarchar(100) default 'HFit_TrackerTobaccoAttestation';
GO
Print 'Processing HFit_TrackerTobaccoAttestation_DEL'
GO
Update BASE_HFit_TrackerTobaccoAttestation_DEL set TrackerName = 'HFit_TrackerTobaccoAttestation' Where TrackerName is null
   OR TrackerName != 'HFit_TrackerTobaccoAttestation'
GO

If not exists (select column_name from information_Schema.columns where table_name = 'BASE_HFit_TrackerTobaccoFree' and column_name = 'TrackerName')
Alter Table BASE_HFit_TrackerTobaccoFree
ADD TrackerName nvarchar(100) default 'HFit_TrackerTobaccoFree';
GO
Print 'Processing HFit_TrackerTobaccoFree'
GO
Update BASE_HFit_TrackerTobaccoFree set TrackerName = 'HFit_TrackerTobaccoFree' Where TrackerName is null
   OR TrackerName != 'HFit_TrackerTobaccoFree'
GO

If not exists (select column_name from information_Schema.columns where table_name = 'BASE_HFit_TrackerTobaccoFree_DEL' and column_name = 'TrackerName')
Alter Table BASE_HFit_TrackerTobaccoFree_DEL
ADD TrackerName nvarchar(100) default 'HFit_TrackerTobaccoFree';
GO
Print 'Processing HFit_TrackerTobaccoFree_DEL'
GO
Update BASE_HFit_TrackerTobaccoFree_DEL set TrackerName = 'HFit_TrackerTobaccoFree' Where TrackerName is null
   OR TrackerName != 'HFit_TrackerTobaccoFree'
GO

If not exists (select column_name from information_Schema.columns where table_name = 'BASE_HFit_TrackerVegetables' and column_name = 'TrackerName')
Alter Table BASE_HFit_TrackerVegetables
ADD TrackerName nvarchar(100) default 'HFit_TrackerVegetables';
GO
Print 'Processing HFit_TrackerVegetables'
GO
Update BASE_HFit_TrackerVegetables set TrackerName = 'HFit_TrackerVegetables' Where TrackerName is null
   OR TrackerName != 'HFit_TrackerVegetables'
GO

If not exists (select column_name from information_Schema.columns where table_name = 'BASE_HFit_TrackerVegetables_DEL' and column_name = 'TrackerName')
Alter Table BASE_HFit_TrackerVegetables_DEL
ADD TrackerName nvarchar(100) default 'HFit_TrackerVegetables';
GO
Print 'Processing HFit_TrackerVegetables_DEL'
GO
Update BASE_HFit_TrackerVegetables_DEL set TrackerName = 'HFit_TrackerVegetables' Where TrackerName is null
   OR TrackerName != 'HFit_TrackerVegetables'
GO

If not exists (select column_name from information_Schema.columns where table_name = 'BASE_HFit_TrackerWater' and column_name = 'TrackerName')
Alter Table BASE_HFit_TrackerWater
ADD TrackerName nvarchar(100) default 'HFit_TrackerWater';
GO
Print 'Processing HFit_TrackerWater'
GO
Update BASE_HFit_TrackerWater set TrackerName = 'HFit_TrackerWater' Where TrackerName is null
   OR TrackerName != 'HFit_TrackerWater'
GO

If not exists (select column_name from information_Schema.columns where table_name = 'BASE_HFit_TrackerWater_DEL' and column_name = 'TrackerName')
Alter Table BASE_HFit_TrackerWater_DEL
ADD TrackerName nvarchar(100) default 'HFit_TrackerWater';
GO
Print 'Processing HFit_TrackerWater_DEL'
GO
Update BASE_HFit_TrackerWater_DEL set TrackerName = 'HFit_TrackerWater' Where TrackerName is null
   OR TrackerName != 'HFit_TrackerWater'
GO

If not exists (select column_name from information_Schema.columns where table_name = 'BASE_HFit_TrackerWeight' and column_name = 'TrackerName')
Alter Table BASE_HFit_TrackerWeight
ADD TrackerName nvarchar(100) default 'HFit_TrackerWeight';
GO
Print 'Processing HFit_TrackerWeight'
GO
Update BASE_HFit_TrackerWeight set TrackerName = 'HFit_TrackerWeight' Where TrackerName is null
   OR TrackerName != 'HFit_TrackerWeight'
GO

If not exists (select column_name from information_Schema.columns where table_name = 'BASE_HFit_TrackerWeight_DEL' and column_name = 'TrackerName')
Alter Table BASE_HFit_TrackerWeight_DEL
ADD TrackerName nvarchar(100) default 'HFit_TrackerWeight';
GO
Print 'Processing HFit_TrackerWeight_DEL'
GO
Update BASE_HFit_TrackerWeight_DEL set TrackerName = 'HFit_TrackerWeight' Where TrackerName is null
   OR TrackerName != 'HFit_TrackerWeight'
GO

If not exists (select column_name from information_Schema.columns where table_name = 'BASE_HFit_TrackerWholeGrains' and column_name = 'TrackerName')
Alter Table BASE_HFit_TrackerWholeGrains
ADD TrackerName nvarchar(100) default 'HFit_TrackerWholeGrains';
GO
Print 'Processing HFit_TrackerWholeGrains'
GO
Update BASE_HFit_TrackerWholeGrains set TrackerName = 'HFit_TrackerWholeGrains' Where TrackerName is null
   OR TrackerName != 'HFit_TrackerWholeGrains'
GO

If not exists (select column_name from information_Schema.columns where table_name = 'BASE_HFit_TrackerWholeGrains_DEL' and column_name = 'TrackerName')
Alter Table BASE_HFit_TrackerWholeGrains_DEL
ADD TrackerName nvarchar(100) default 'HFit_TrackerWholeGrains';
GO
Print 'Processing HFit_TrackerWholeGrains_DEL'
GO
Update BASE_HFit_TrackerWholeGrains_DEL set TrackerName = 'HFit_TrackerWholeGrains' Where TrackerName is null
   OR TrackerName != 'HFit_TrackerWholeGrains'
GO

If not exists (select column_name from information_Schema.columns where table_name = 'BASE_HFit_UserTracker' and column_name = 'TrackerName')
Alter Table BASE_HFit_UserTracker
ADD TrackerName nvarchar(100) default 'HFit_UserTracker';
GO
Print 'Processing HFit_UserTracker'
GO
Update BASE_HFit_UserTracker set TrackerName = 'HFit_UserTracker' Where TrackerName is null
   OR TrackerName != 'HFit_UserTracker'
GO

If not exists (select column_name from information_Schema.columns where table_name = 'BASE_HFit_UserTracker_DEL' and column_name = 'TrackerName')
Alter Table BASE_HFit_UserTracker_DEL
ADD TrackerName nvarchar(100) default 'HFit_UserTracker';
GO
Print 'Processing HFit_UserTracker_DEL'
GO
Update BASE_HFit_UserTracker_DEL set TrackerName = 'HFit_UserTracker' Where TrackerName is null
   OR TrackerName != 'HFit_UserTracker'
GO

If not exists (select column_name from information_Schema.columns where table_name = 'BASE_HFit_UserTrackerCategory' and column_name = 'TrackerName')
Alter Table BASE_HFit_UserTrackerCategory
ADD TrackerName nvarchar(100) default 'HFit_UserTrackerCategory';
GO
Print 'Processing HFit_UserTrackerCategory'
GO
Update BASE_HFit_UserTrackerCategory set TrackerName = 'HFit_UserTrackerCategory' Where TrackerName is null
   OR TrackerName != 'HFit_UserTrackerCategory'
GO

If not exists (select column_name from information_Schema.columns where table_name = 'BASE_HFit_UserTrackerCategory_DEL' and column_name = 'TrackerName')
Alter Table BASE_HFit_UserTrackerCategory_DEL
ADD TrackerName nvarchar(100) default 'HFit_UserTrackerCategory';
GO
Print 'Processing HFit_UserTrackerCategory_DEL'
GO
Update BASE_HFit_UserTrackerCategory_DEL set TrackerName = 'HFit_UserTrackerCategory' Where TrackerName is null
   OR TrackerName != 'HFit_UserTrackerCategory'
GO


--*************************************************
-- CHECK INDEXES EXIST
wdmxx
If NOT Exists (select name from sys.indexes where name = 'PI_TrackerData_SKEY_SurrogateKey_CMS_user')
BEGIN
Print 'SurrogateKey_CMS_user'
CREATE nonclustered INDEX PI_TrackerData_SKEY_SurrogateKey_CMS_user on dbo.FACT_TrackerData 
(DBNAME asc, TrackerName ASC, SurrogateKey_CMS_user asc) 
END
GO
If NOT Exists (select name from sys.indexes where name = 'PI_TrackerData_SKEY_SurrogateKey_HFIT_Tracker')
BEGIN
Print 'SurrogateKey_HFIT_Tracker'
CREATE nonclustered INDEX PI_TrackerData_SKEY_SurrogateKey_HFIT_Tracker on dbo.FACT_TrackerData 
(DBNAME asc, TrackerName ASC, SurrogateKey_HFIT_Tracker asc) 
END
GO
If NOT Exists (select name from sys.indexes where name = 'PI_TrackerData_SKEY_SurrogateKey_HFit_TrackerBloodPressure')
BEGIN
Print 'SurrogateKey_HFit_TrackerBloodPressure'
CREATE nonclustered INDEX PI_TrackerData_SKEY_SurrogateKey_HFit_TrackerBloodPressure on dbo.FACT_TrackerData 
(DBNAME asc, TrackerName ASC, SurrogateKey_HFit_TrackerBloodPressure asc) 
END
GO
If NOT Exists (select name from sys.indexes where name = 'PI_TrackerData_SKEY_SurrogateKey_HFit_TrackerBloodSugarAndGlucose')
BEGIN
Print 'SurrogateKey_HFit_TrackerBloodSugarAndGlucose'
CREATE nonclustered INDEX PI_TrackerData_SKEY_SurrogateKey_HFit_TrackerBloodSugarAndGlucose on dbo.FACT_TrackerData 
(DBNAME asc, TrackerName ASC, SurrogateKey_HFit_TrackerBloodSugarAndGlucose asc) 
END
GO
If NOT Exists (select name from sys.indexes where name = 'PI_TrackerData_SKEY_SurrogateKey_HFit_TrackerBMI')
BEGIN
Print 'SurrogateKey_HFit_TrackerBMI'
CREATE nonclustered INDEX PI_TrackerData_SKEY_SurrogateKey_HFit_TrackerBMI on dbo.FACT_TrackerData 
(DBNAME asc, TrackerName ASC, SurrogateKey_HFit_TrackerBMI asc) 
END
GO
If NOT Exists (select name from sys.indexes where name = 'PI_TrackerData_SKEY_SurrogateKey_HFit_TrackerBodyFat')
BEGIN
Print 'SurrogateKey_HFit_TrackerBodyFat'
CREATE nonclustered INDEX PI_TrackerData_SKEY_SurrogateKey_HFit_TrackerBodyFat on dbo.FACT_TrackerData 
(DBNAME asc, TrackerName ASC, SurrogateKey_HFit_TrackerBodyFat asc) 
END
GO
If NOT Exists (select name from sys.indexes where name = 'PI_TrackerData_SKEY_SurrogateKey_HFit_TrackerBodyMeasurements')
BEGIN
Print 'SurrogateKey_HFit_TrackerBodyMeasurements'
CREATE nonclustered INDEX PI_TrackerData_SKEY_SurrogateKey_HFit_TrackerBodyMeasurements on dbo.FACT_TrackerData 
(DBNAME asc, TrackerName ASC, SurrogateKey_HFit_TrackerBodyMeasurements asc) 
END
GO
If NOT Exists (select name from sys.indexes where name = 'PI_TrackerData_SKEY_SurrogateKey_HFit_TrackerCardio')
BEGIN
Print 'SurrogateKey_HFit_TrackerCardio'
CREATE nonclustered INDEX PI_TrackerData_SKEY_SurrogateKey_HFit_TrackerCardio on dbo.FACT_TrackerData 
(DBNAME asc, TrackerName ASC, SurrogateKey_HFit_TrackerCardio asc) 
END
GO
If NOT Exists (select name from sys.indexes where name = 'PI_TrackerData_SKEY_SurrogateKey_HFit_TrackerCholesterol')
BEGIN
Print 'SurrogateKey_HFit_TrackerCholesterol'
CREATE nonclustered INDEX PI_TrackerData_SKEY_SurrogateKey_HFit_TrackerCholesterol on dbo.FACT_TrackerData 
(DBNAME asc, TrackerName ASC, SurrogateKey_HFit_TrackerCholesterol asc) 
END
GO
If NOT Exists (select name from sys.indexes where name = 'PI_TrackerData_SKEY_SurrogateKey_HFit_TrackerCollectionSource')
BEGIN
Print 'SurrogateKey_HFit_TrackerCollectionSource'
CREATE nonclustered INDEX PI_TrackerData_SKEY_SurrogateKey_HFit_TrackerCollectionSource on dbo.FACT_TrackerData 
(DBNAME asc, TrackerName ASC, SurrogateKey_HFit_TrackerCollectionSource asc) 
END
GO
If NOT Exists (select name from sys.indexes where name = 'PI_TrackerData_SKEY_SurrogateKey_HFit_TrackerCotinine')
BEGIN
Print 'SurrogateKey_HFit_TrackerCotinine'
CREATE nonclustered INDEX PI_TrackerData_SKEY_SurrogateKey_HFit_TrackerCotinine on dbo.FACT_TrackerData 
(DBNAME asc, TrackerName ASC, SurrogateKey_HFit_TrackerCotinine asc) 
END
GO
If NOT Exists (select name from sys.indexes where name = 'PI_TrackerData_SKEY_SurrogateKey_HFit_TrackerDailySteps')
BEGIN
Print 'SurrogateKey_HFit_TrackerDailySteps'
CREATE nonclustered INDEX PI_TrackerData_SKEY_SurrogateKey_HFit_TrackerDailySteps on dbo.FACT_TrackerData 
(DBNAME asc, TrackerName ASC, SurrogateKey_HFit_TrackerDailySteps asc) 
END
GO
If NOT Exists (select name from sys.indexes where name = 'PI_TrackerData_SKEY_SurrogateKey_HFit_TrackerDef_Tracker')
BEGIN
Print 'SurrogateKey_HFit_TrackerDef_Tracker'
CREATE nonclustered INDEX PI_TrackerData_SKEY_SurrogateKey_HFit_TrackerDef_Tracker on dbo.FACT_TrackerData 
(DBNAME asc, TrackerName ASC, SurrogateKey_HFit_TrackerDef_Tracker asc) 
END
GO
If NOT Exists (select name from sys.indexes where name = 'PI_TrackerData_SKEY_SurrogateKey_HFit_TrackerFlexibility')
BEGIN
Print 'SurrogateKey_HFit_TrackerFlexibility'
CREATE nonclustered INDEX PI_TrackerData_SKEY_SurrogateKey_HFit_TrackerFlexibility on dbo.FACT_TrackerData 
(DBNAME asc, TrackerName ASC, SurrogateKey_HFit_TrackerFlexibility asc) 
END
GO
If NOT Exists (select name from sys.indexes where name = 'PI_TrackerData_SKEY_SurrogateKey_HFit_TrackerFruits')
BEGIN
Print 'SurrogateKey_HFit_TrackerFruits'
CREATE nonclustered INDEX PI_TrackerData_SKEY_SurrogateKey_HFit_TrackerFruits on dbo.FACT_TrackerData 
(DBNAME asc, TrackerName ASC, SurrogateKey_HFit_TrackerFruits asc) 
END
GO
If NOT Exists (select name from sys.indexes where name = 'PI_TrackerData_SKEY_SurrogateKey_HFit_TrackerHbA1c')
BEGIN
Print 'SurrogateKey_HFit_TrackerHbA1c'
CREATE nonclustered INDEX PI_TrackerData_SKEY_SurrogateKey_HFit_TrackerHbA1c on dbo.FACT_TrackerData 
(DBNAME asc, TrackerName ASC, SurrogateKey_HFit_TrackerHbA1c asc) 
END
GO
If NOT Exists (select name from sys.indexes where name = 'PI_TrackerData_SKEY_SurrogateKey_HFit_TrackerHeight')
BEGIN
Print 'SurrogateKey_HFit_TrackerHeight'
CREATE nonclustered INDEX PI_TrackerData_SKEY_SurrogateKey_HFit_TrackerHeight on dbo.FACT_TrackerData 
(DBNAME asc, TrackerName ASC, SurrogateKey_HFit_TrackerHeight asc) 
END
GO
If NOT Exists (select name from sys.indexes where name = 'PI_TrackerData_SKEY_SurrogateKey_HFit_TrackerHighFatFoods')
BEGIN
Print 'SurrogateKey_HFit_TrackerHighFatFoods'
CREATE nonclustered INDEX PI_TrackerData_SKEY_SurrogateKey_HFit_TrackerHighFatFoods on dbo.FACT_TrackerData 
(DBNAME asc, TrackerName ASC, SurrogateKey_HFit_TrackerHighFatFoods asc) 
END
GO
If NOT Exists (select name from sys.indexes where name = 'PI_TrackerData_SKEY_SurrogateKey_HFit_TrackerHighSodiumFoods')
BEGIN
Print 'SurrogateKey_HFit_TrackerHighSodiumFoods'
CREATE nonclustered INDEX PI_TrackerData_SKEY_SurrogateKey_HFit_TrackerHighSodiumFoods on dbo.FACT_TrackerData 
(DBNAME asc, TrackerName ASC, SurrogateKey_HFit_TrackerHighSodiumFoods asc) 
END
GO
If NOT Exists (select name from sys.indexes where name = 'PI_TrackerData_SKEY_SurrogateKey_HFit_TrackerInstance_Tracker')
BEGIN
Print 'SurrogateKey_HFit_TrackerInstance_Tracker'
CREATE nonclustered INDEX PI_TrackerData_SKEY_SurrogateKey_HFit_TrackerInstance_Tracker on dbo.FACT_TrackerData 
(DBNAME asc, TrackerName ASC, SurrogateKey_HFit_TrackerInstance_Tracker asc) 
END
GO
If NOT Exists (select name from sys.indexes where name = 'PI_TrackerData_SKEY_SurrogateKey_HFit_TrackerMealPortions')
BEGIN
Print 'SurrogateKey_HFit_TrackerMealPortions'
CREATE nonclustered INDEX PI_TrackerData_SKEY_SurrogateKey_HFit_TrackerMealPortions on dbo.FACT_TrackerData 
(DBNAME asc, TrackerName ASC, SurrogateKey_HFit_TrackerMealPortions asc) 
END
GO
If NOT Exists (select name from sys.indexes where name = 'PI_TrackerData_SKEY_SurrogateKey_HFit_TrackerMedicalCarePlan')
BEGIN
Print 'SurrogateKey_HFit_TrackerMedicalCarePlan'
CREATE nonclustered INDEX PI_TrackerData_SKEY_SurrogateKey_HFit_TrackerMedicalCarePlan on dbo.FACT_TrackerData 
(DBNAME asc, TrackerName ASC, SurrogateKey_HFit_TrackerMedicalCarePlan asc) 
END
GO
If NOT Exists (select name from sys.indexes where name = 'PI_TrackerData_SKEY_SurrogateKey_HFit_TrackerPreventiveCare')
BEGIN
Print 'SurrogateKey_HFit_TrackerPreventiveCare'
CREATE nonclustered INDEX PI_TrackerData_SKEY_SurrogateKey_HFit_TrackerPreventiveCare on dbo.FACT_TrackerData 
(DBNAME asc, TrackerName ASC, SurrogateKey_HFit_TrackerPreventiveCare asc) 
END
GO
If NOT Exists (select name from sys.indexes where name = 'PI_TrackerData_SKEY_SurrogateKey_HFit_TrackerRegularMeals')
BEGIN
Print 'SurrogateKey_HFit_TrackerRegularMeals'
CREATE nonclustered INDEX PI_TrackerData_SKEY_SurrogateKey_HFit_TrackerRegularMeals on dbo.FACT_TrackerData 
(DBNAME asc, TrackerName ASC, SurrogateKey_HFit_TrackerRegularMeals asc) 
END
GO
If NOT Exists (select name from sys.indexes where name = 'PI_TrackerData_SKEY_SurrogateKey_HFit_TrackerRestingHeartRate')
BEGIN
Print 'SurrogateKey_HFit_TrackerRestingHeartRate'
CREATE nonclustered INDEX PI_TrackerData_SKEY_SurrogateKey_HFit_TrackerRestingHeartRate on dbo.FACT_TrackerData 
(DBNAME asc, TrackerName ASC, SurrogateKey_HFit_TrackerRestingHeartRate asc) 
END
GO
If NOT Exists (select name from sys.indexes where name = 'PI_TrackerData_SKEY_SurrogateKey_HFit_TrackerShots')
BEGIN
Print 'SurrogateKey_HFit_TrackerShots'
CREATE nonclustered INDEX PI_TrackerData_SKEY_SurrogateKey_HFit_TrackerShots on dbo.FACT_TrackerData 
(DBNAME asc, TrackerName ASC, SurrogateKey_HFit_TrackerShots asc) 
END
GO
If NOT Exists (select name from sys.indexes where name = 'PI_TrackerData_SKEY_SurrogateKey_HFit_TrackerSitLess')
BEGIN
Print 'SurrogateKey_HFit_TrackerSitLess'
CREATE nonclustered INDEX PI_TrackerData_SKEY_SurrogateKey_HFit_TrackerSitLess on dbo.FACT_TrackerData 
(DBNAME asc, TrackerName ASC, SurrogateKey_HFit_TrackerSitLess asc) 
END
GO
If NOT Exists (select name from sys.indexes where name = 'PI_TrackerData_SKEY_SurrogateKey_HFit_TrackerSleepPlan')
BEGIN
Print 'SurrogateKey_HFit_TrackerSleepPlan'
CREATE nonclustered INDEX PI_TrackerData_SKEY_SurrogateKey_HFit_TrackerSleepPlan on dbo.FACT_TrackerData 
(DBNAME asc, TrackerName ASC, SurrogateKey_HFit_TrackerSleepPlan asc) 
END
GO
If NOT Exists (select name from sys.indexes where name = 'PI_TrackerData_SKEY_SurrogateKey_HFit_TrackerStrength')
BEGIN
Print 'SurrogateKey_HFit_TrackerStrength'
CREATE nonclustered INDEX PI_TrackerData_SKEY_SurrogateKey_HFit_TrackerStrength on dbo.FACT_TrackerData 
(DBNAME asc, TrackerName ASC, SurrogateKey_HFit_TrackerStrength asc) 
END
GO
If NOT Exists (select name from sys.indexes where name = 'PI_TrackerData_SKEY_SurrogateKey_HFit_TrackerStress')
BEGIN
Print 'SurrogateKey_HFit_TrackerStress'
CREATE nonclustered INDEX PI_TrackerData_SKEY_SurrogateKey_HFit_TrackerStress on dbo.FACT_TrackerData 
(DBNAME asc, TrackerName ASC, SurrogateKey_HFit_TrackerStress asc) 
END
GO
If NOT Exists (select name from sys.indexes where name = 'PI_TrackerData_SKEY_SurrogateKey_HFit_TrackerStressManagement')
BEGIN
Print 'SurrogateKey_HFit_TrackerStressManagement'
CREATE nonclustered INDEX PI_TrackerData_SKEY_SurrogateKey_HFit_TrackerStressManagement on dbo.FACT_TrackerData 
(DBNAME asc, TrackerName ASC, SurrogateKey_HFit_TrackerStressManagement asc) 
END
GO
If NOT Exists (select name from sys.indexes where name = 'PI_TrackerData_SKEY_SurrogateKey_HFit_TrackerSugaryDrinks')
BEGIN
Print 'SurrogateKey_HFit_TrackerSugaryDrinks'
CREATE nonclustered INDEX PI_TrackerData_SKEY_SurrogateKey_HFit_TrackerSugaryDrinks on dbo.FACT_TrackerData 
(DBNAME asc, TrackerName ASC, SurrogateKey_HFit_TrackerSugaryDrinks asc) 
END
GO
If NOT Exists (select name from sys.indexes where name = 'PI_TrackerData_SKEY_SurrogateKey_HFit_TrackerSugaryFoods')
BEGIN
Print 'SurrogateKey_HFit_TrackerSugaryFoods'
CREATE nonclustered INDEX PI_TrackerData_SKEY_SurrogateKey_HFit_TrackerSugaryFoods on dbo.FACT_TrackerData 
(DBNAME asc, TrackerName ASC, SurrogateKey_HFit_TrackerSugaryFoods asc) 
END
GO
If NOT Exists (select name from sys.indexes where name = 'PI_TrackerData_SKEY_SurrogateKey_HFit_TrackerTests')
BEGIN
Print 'SurrogateKey_HFit_TrackerTests'
CREATE nonclustered INDEX PI_TrackerData_SKEY_SurrogateKey_HFit_TrackerTests on dbo.FACT_TrackerData 
(DBNAME asc, TrackerName ASC, SurrogateKey_HFit_TrackerTests asc) 
END
GO
If NOT Exists (select name from sys.indexes where name = 'PI_TrackerData_SKEY_SurrogateKey_HFit_TrackerTobaccoAttestation')
BEGIN
Print 'SurrogateKey_HFit_TrackerTobaccoAttestation'
CREATE nonclustered INDEX PI_TrackerData_SKEY_SurrogateKey_HFit_TrackerTobaccoAttestation on dbo.FACT_TrackerData 
(DBNAME asc, TrackerName ASC, SurrogateKey_HFit_TrackerTobaccoAttestation asc) 
END
GO
If NOT Exists (select name from sys.indexes where name = 'PI_TrackerData_SKEY_SurrogateKey_HFit_TrackerTobaccoFree')
BEGIN
Print 'SurrogateKey_HFit_TrackerTobaccoFree'
CREATE nonclustered INDEX PI_TrackerData_SKEY_SurrogateKey_HFit_TrackerTobaccoFree on dbo.FACT_TrackerData 
(DBNAME asc, TrackerName ASC, SurrogateKey_HFit_TrackerTobaccoFree asc) 
END
GO
If NOT Exists (select name from sys.indexes where name = 'PI_TrackerData_SKEY_SurrogateKey_HFit_TrackerVegetables')
BEGIN
Print 'SurrogateKey_HFit_TrackerVegetables'
CREATE nonclustered INDEX PI_TrackerData_SKEY_SurrogateKey_HFit_TrackerVegetables on dbo.FACT_TrackerData 
(DBNAME asc, TrackerName ASC, SurrogateKey_HFit_TrackerVegetables asc) 
END
GO
If NOT Exists (select name from sys.indexes where name = 'PI_TrackerData_SKEY_SurrogateKey_HFit_TrackerWater')
BEGIN
Print 'SurrogateKey_HFit_TrackerWater'
CREATE nonclustered INDEX PI_TrackerData_SKEY_SurrogateKey_HFit_TrackerWater on dbo.FACT_TrackerData 
(DBNAME asc, TrackerName ASC, SurrogateKey_HFit_TrackerWater asc) 
END
GO
If NOT Exists (select name from sys.indexes where name = 'PI_TrackerData_SKEY_SurrogateKey_HFit_TrackerWeight')
BEGIN
Print 'SurrogateKey_HFit_TrackerWeight'
CREATE nonclustered INDEX PI_TrackerData_SKEY_SurrogateKey_HFit_TrackerWeight on dbo.FACT_TrackerData 
(DBNAME asc, TrackerName ASC, SurrogateKey_HFit_TrackerWeight asc) 
END
GO
If NOT Exists (select name from sys.indexes where name = 'PI_TrackerData_SKEY_SurrogateKey_HFit_TrackerWholeGrains')
BEGIN
Print 'SurrogateKey_HFit_TrackerWholeGrains'
CREATE nonclustered INDEX PI_TrackerData_SKEY_SurrogateKey_HFit_TrackerWholeGrains on dbo.FACT_TrackerData 
(DBNAME asc, TrackerName ASC, SurrogateKey_HFit_TrackerWholeGrains asc) 
END
GO

--*******************************************************
PRINT 'COMPLETE! - Executed create_Tracker_Indexes.sql'; 

