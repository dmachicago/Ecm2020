
/*
  -- Use KenticoCMS_Datamart_2
  SELECT 'Alter Table ' + T.table_name 
    +char(10) + 'ADD TrackerName nvarchar(100) default ''' + replace(substring(t.table_name, 6,9999), '_DEL','') + ''';'
    +char(10) +'GO'
	+char(10) +'Print ''Processing ' + substring(t.table_name, 6,9999) + ''''
	+char(10) +'GO'
    +char(10) + 'Update ' + T.table_name + ' set TrackerName = ''' + replace(substring(t.table_name, 6,9999), '_DEL','') + ''' Where TrackerName is null;'
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
and C.Column_name is null
order by T.Table_Name

*/

Alter Table BASE_HFit_Ref_RewardTrackerValidation_DEL
ADD TrackerName nvarchar(100) default 'HFit_Ref_RewardTrackerValidation';
GO
Print 'Processing HFit_Ref_RewardTrackerValidation_DEL'
GO
Update BASE_HFit_Ref_RewardTrackerValidation_DEL set TrackerName = 'HFit_Ref_RewardTrackerValidation' Where TrackerName is null;
GO

Alter Table BASE_HFit_TrackerBloodSugarAndGlucose
ADD TrackerName nvarchar(100) default 'HFit_TrackerBloodSugarAndGlucose';
GO
Print 'Processing HFit_TrackerBloodSugarAndGlucose'
GO
Update BASE_HFit_TrackerBloodSugarAndGlucose set TrackerName = 'HFit_TrackerBloodSugarAndGlucose' Where TrackerName is null;
GO

Alter Table BASE_HFit_TrackerBloodSugarAndGlucose_DEL
ADD TrackerName nvarchar(100) default 'HFit_TrackerBloodSugarAndGlucose';
GO
Print 'Processing HFit_TrackerBloodSugarAndGlucose_DEL'
GO
Update BASE_HFit_TrackerBloodSugarAndGlucose_DEL set TrackerName = 'HFit_TrackerBloodSugarAndGlucose' Where TrackerName is null;
GO

Alter Table BASE_HFit_TrackerBodyFat
ADD TrackerName nvarchar(100) default 'HFit_TrackerBodyFat';
GO
Print 'Processing HFit_TrackerBodyFat'
GO
Update BASE_HFit_TrackerBodyFat set TrackerName = 'HFit_TrackerBodyFat' Where TrackerName is null;
GO

Alter Table BASE_HFit_TrackerBodyFat_DEL
ADD TrackerName nvarchar(100) default 'HFit_TrackerBodyFat';
GO
Print 'Processing HFit_TrackerBodyFat_DEL'
GO
Update BASE_HFit_TrackerBodyFat_DEL set TrackerName = 'HFit_TrackerBodyFat' Where TrackerName is null;
GO

Alter Table BASE_HFit_TrackerBodyMeasurements
ADD TrackerName nvarchar(100) default 'HFit_TrackerBodyMeasurements';
GO
Print 'Processing HFit_TrackerBodyMeasurements'
GO
Update BASE_HFit_TrackerBodyMeasurements set TrackerName = 'HFit_TrackerBodyMeasurements' Where TrackerName is null;
GO

Alter Table BASE_HFit_TrackerBodyMeasurements_DEL
ADD TrackerName nvarchar(100) default 'HFit_TrackerBodyMeasurements';
GO
Print 'Processing HFit_TrackerBodyMeasurements_DEL'
GO
Update BASE_HFit_TrackerBodyMeasurements_DEL set TrackerName = 'HFit_TrackerBodyMeasurements' Where TrackerName is null;
GO

Alter Table BASE_HFit_TrackerCategory
ADD TrackerName nvarchar(100) default 'HFit_TrackerCategory';
GO
Print 'Processing HFit_TrackerCategory'
GO
Update BASE_HFit_TrackerCategory set TrackerName = 'HFit_TrackerCategory' Where TrackerName is null;
GO

Alter Table BASE_HFit_TrackerCategory_DEL
ADD TrackerName nvarchar(100) default 'HFit_TrackerCategory';
GO
Print 'Processing HFit_TrackerCategory_DEL'
GO
Update BASE_HFit_TrackerCategory_DEL set TrackerName = 'HFit_TrackerCategory' Where TrackerName is null;
GO

Alter Table BASE_HFit_TrackerDef_Item
ADD TrackerName nvarchar(100) default 'HFit_TrackerDef_Item';
GO
Print 'Processing HFit_TrackerDef_Item'
GO
Update BASE_HFit_TrackerDef_Item set TrackerName = 'HFit_TrackerDef_Item' Where TrackerName is null;
GO

Alter Table BASE_HFit_TrackerDef_Item_DEL
ADD TrackerName nvarchar(100) default 'HFit_TrackerDef_Item';
GO
Print 'Processing HFit_TrackerDef_Item_DEL'
GO
Update BASE_HFit_TrackerDef_Item_DEL set TrackerName = 'HFit_TrackerDef_Item' Where TrackerName is null;
GO

Alter Table BASE_HFit_TrackerDocument
ADD TrackerName nvarchar(100) default 'HFit_TrackerDocument';
GO
Print 'Processing HFit_TrackerDocument'
GO
Update BASE_HFit_TrackerDocument set TrackerName = 'HFit_TrackerDocument' Where TrackerName is null;
GO

Alter Table BASE_HFit_TrackerDocument_DEL
ADD TrackerName nvarchar(100) default 'HFit_TrackerDocument';
GO
Print 'Processing HFit_TrackerDocument_DEL'
GO
Update BASE_HFit_TrackerDocument_DEL set TrackerName = 'HFit_TrackerDocument' Where TrackerName is null;
GO

Alter Table BASE_HFit_TrackerHbA1c
ADD TrackerName nvarchar(100) default 'HFit_TrackerHbA1c';
GO
Print 'Processing HFit_TrackerHbA1c'
GO
Update BASE_HFit_TrackerHbA1c set TrackerName = 'HFit_TrackerHbA1c' Where TrackerName is null;
GO

Alter Table BASE_HFit_TrackerHbA1c_DEL
ADD TrackerName nvarchar(100) default 'HFit_TrackerHbA1c';
GO
Print 'Processing HFit_TrackerHbA1c_DEL'
GO
Update BASE_HFit_TrackerHbA1c_DEL set TrackerName = 'HFit_TrackerHbA1c' Where TrackerName is null;
GO

Alter Table BASE_HFit_TrackerHighFatFoods
ADD TrackerName nvarchar(100) default 'HFit_TrackerHighFatFoods';
GO
Print 'Processing HFit_TrackerHighFatFoods'
GO
Update BASE_HFit_TrackerHighFatFoods set TrackerName = 'HFit_TrackerHighFatFoods' Where TrackerName is null;
GO

Alter Table BASE_HFit_TrackerHighFatFoods_DEL
ADD TrackerName nvarchar(100) default 'HFit_TrackerHighFatFoods';
GO
Print 'Processing HFit_TrackerHighFatFoods_DEL'
GO
Update BASE_HFit_TrackerHighFatFoods_DEL set TrackerName = 'HFit_TrackerHighFatFoods' Where TrackerName is null;
GO

Alter Table BASE_HFit_TrackerHighSodiumFoods
ADD TrackerName nvarchar(100) default 'HFit_TrackerHighSodiumFoods';
GO
Print 'Processing HFit_TrackerHighSodiumFoods'
GO
Update BASE_HFit_TrackerHighSodiumFoods set TrackerName = 'HFit_TrackerHighSodiumFoods' Where TrackerName is null;
GO

Alter Table BASE_HFit_TrackerHighSodiumFoods_DEL
ADD TrackerName nvarchar(100) default 'HFit_TrackerHighSodiumFoods';
GO
Print 'Processing HFit_TrackerHighSodiumFoods_DEL'
GO
Update BASE_HFit_TrackerHighSodiumFoods_DEL set TrackerName = 'HFit_TrackerHighSodiumFoods' Where TrackerName is null;
GO

Alter Table BASE_HFit_TrackerInstance_Item
ADD TrackerName nvarchar(100) default 'HFit_TrackerInstance_Item';
GO
Print 'Processing HFit_TrackerInstance_Item'
GO
Update BASE_HFit_TrackerInstance_Item set TrackerName = 'HFit_TrackerInstance_Item' Where TrackerName is null;
GO

Alter Table BASE_HFit_TrackerInstance_Item_DEL
ADD TrackerName nvarchar(100) default 'HFit_TrackerInstance_Item';
GO
Print 'Processing HFit_TrackerInstance_Item_DEL'
GO
Update BASE_HFit_TrackerInstance_Item_DEL set TrackerName = 'HFit_TrackerInstance_Item' Where TrackerName is null;
GO

Alter Table BASE_HFit_TrackerRestingHeartRate
ADD TrackerName nvarchar(100) default 'HFit_TrackerRestingHeartRate';
GO
Print 'Processing HFit_TrackerRestingHeartRate'
GO
Update BASE_HFit_TrackerRestingHeartRate set TrackerName = 'HFit_TrackerRestingHeartRate' Where TrackerName is null;
GO

Alter Table BASE_HFit_TrackerRestingHeartRate_DEL
ADD TrackerName nvarchar(100) default 'HFit_TrackerRestingHeartRate';
GO
Print 'Processing HFit_TrackerRestingHeartRate_DEL'
GO
Update BASE_HFit_TrackerRestingHeartRate_DEL set TrackerName = 'HFit_TrackerRestingHeartRate' Where TrackerName is null;
GO

Alter Table BASE_HFit_TrackerStrength
ADD TrackerName nvarchar(100) default 'HFit_TrackerStrength';
GO
Print 'Processing HFit_TrackerStrength'
GO
Update BASE_HFit_TrackerStrength set TrackerName = 'HFit_TrackerStrength' Where TrackerName is null;
GO

Alter Table BASE_HFit_TrackerStrength_DEL
ADD TrackerName nvarchar(100) default 'HFit_TrackerStrength';
GO
Print 'Processing HFit_TrackerStrength_DEL'
GO
Update BASE_HFit_TrackerStrength_DEL set TrackerName = 'HFit_TrackerStrength' Where TrackerName is null;
GO

Alter Table BASE_HFit_TrackerSummary
ADD TrackerName nvarchar(100) default 'HFit_TrackerSummary';
GO
Print 'Processing HFit_TrackerSummary'
GO
Update BASE_HFit_TrackerSummary set TrackerName = 'HFit_TrackerSummary' Where TrackerName is null;
GO

Alter Table BASE_HFit_TrackerSummary_DEL
ADD TrackerName nvarchar(100) default 'HFit_TrackerSummary';
GO
Print 'Processing HFit_TrackerSummary_DEL'
GO
Update BASE_HFit_TrackerSummary_DEL set TrackerName = 'HFit_TrackerSummary' Where TrackerName is null;
GO

Alter Table BASE_HFit_UserTracker
ADD TrackerName nvarchar(100) default 'HFit_UserTracker';
GO
Print 'Processing HFit_UserTracker'
GO
Update BASE_HFit_UserTracker set TrackerName = 'HFit_UserTracker' Where TrackerName is null;
GO

Alter Table BASE_HFit_UserTracker_DEL
ADD TrackerName nvarchar(100) default 'HFit_UserTracker';
GO
Print 'Processing HFit_UserTracker_DEL'
GO
Update BASE_HFit_UserTracker_DEL set TrackerName = 'HFit_UserTracker' Where TrackerName is null;
GO

Alter Table BASE_HFit_UserTrackerCategory
ADD TrackerName nvarchar(100) default 'HFit_UserTrackerCategory';
GO
Print 'Processing HFit_UserTrackerCategory'
GO
Update BASE_HFit_UserTrackerCategory set TrackerName = 'HFit_UserTrackerCategory' Where TrackerName is null;
GO

Alter Table BASE_HFit_UserTrackerCategory_DEL
ADD TrackerName nvarchar(100) default 'HFit_UserTrackerCategory';
GO
Print 'Processing HFit_UserTrackerCategory_DEL'
GO
Update BASE_HFit_UserTrackerCategory_DEL set TrackerName = 'HFit_UserTrackerCategory' Where TrackerName is null;
GO
