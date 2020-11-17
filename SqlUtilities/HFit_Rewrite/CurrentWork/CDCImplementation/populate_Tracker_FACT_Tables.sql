--drop table FACT_HFit_TrackerRegularMeals ;
--drop table FACT_HFit_TrackerRestingHeartRate ;
--drop table FACT_HFit_TrackerMedicalCarePlan ;

/*
use KenticoCMS_Datamart_2

select * from information_schema.tables where table_name like '%HFit_Tracker%' and table_type = 'BASE TABLE'

select 'IF (Select count(*) from dbo.' + table_name + ')  = 0 drop table ' + table_name from information_schema.tables 
where 
table_name like 'FACT_HFit_Tracker%'
*/
--set rowcount 5 ;
EXEC PrintImmediate 'Processing FACT_HFit_TrackerBloodPressure';
EXEC PrintImmediate 'Rows: ';
EXEC proc_QuickRowCount BASE_HFit_TrackerBloodPressure;
IF NOT EXISTS (SELECT
                      name
                      FROM sys.tables
                      WHERE name = 'FACT_HFit_TrackerBloodPressure') 
    BEGIN
        EXEC PrintImmediate '*** Loading Records: FACT_HFit_TrackerBloodPressure';
        SELECT 
               'HFit_TrackerBloodPressure' AS TrackerNameAggregateTable
             , TT.ItemID
             , CAST (EventDate AS DATETIME) AS EventDate
             , TT.IsProfessionallyCollected
             , TT.TrackerCollectionSourceID
             , Notes
             , TT.UserID
             , CollectionSourceName_Internal
             , CollectionSourceName_External
             , 'MISSING' AS EventName
             , 'mm/Hg' AS UOM
             , 'Systolic' AS KEY1
             , CAST ( Systolic AS FLOAT) AS VAL1
             , 'Diastolic' AS KEY2
             , CAST ( Diastolic AS FLOAT) AS VAL2
             , 'NA' AS KEY3
             , NULL AS VAL3
             , 'NA' AS KEY4
             , NULL AS VAL4
             , 'NA' AS KEY5
             , NULL AS VAL5
             , 'NA' AS KEY6
             , NULL AS VAL6
             , 'NA' AS KEY7
             , NULL AS VAL7
             , 'NA' AS KEY8
             , NULL AS VAL8
             , 'NA' AS KEY9
             , NULL AS VAL9
             , 'NA' AS KEY10
             , NULL AS VAL10
             , TT.ItemCreatedBy
             , CAST (TT.ItemCreatedWhen AS DATETIME) AS ItemCreatedWhen
             , TT.ItemModifiedBy
             , CAST (TT.ItemModifiedWhen AS DATETIME) AS ItemModifiedWhen
             , IsProcessedForHa
             , 'NA' AS TXTKEY1
             , NULL AS TXTVAL1
             , 'NA' AS TXTKEY2
             , NULL AS TXTVAL2
             , 'NA' AS TXTKEY3
             , NULL AS TXTVAL3
             , NULL AS ItemOrder
             , NULL AS ItemGuid
             , C.UserGuid
             , PP.MPI
             , PP.ClientCode
             , S.SiteGUID
             , ACCT.AccountID
             , ACCT.AccountCD
             , T.IsAvailable
             , T.IsCustom
             , ISNULL ( T.UniqueName , 'bp') AS UniqueName
             , ISNULL ( T.UniqueName , 'bp') AS ColDesc
             , VENDOR.ItemID AS VendorID
             , VENDOR.VendorName
             , TT.LastModifiedDate
             , TT.SVR
             , TT.DBNAME
        INTO
             FACT_HFit_TrackerBloodPressure
               FROM dbo.BASE_HFit_TrackerBloodPressure AS TT
                        INNER JOIN dbo.BASE_CMS_User AS C
                            ON C.UserID = TT.UserID
                           AND C.SVR = TT.SVR
                           AND C.DBNAME = TT.DBNAME
                        INNER JOIN dbo.BASE_HFit_ppteligibility AS PP
                            ON TT.UserID = PP.userID
                           AND TT.SVR = PP.SVR
                           AND TT.DBNAME = PP.DBNAME
                        INNER JOIN dbo.BASE_HFit_Account AS ACCT
                            ON PP.ClientCode = ACCT.AccountCD
                           AND PP.SVR = ACCT.SVR
                           AND PP.DBNAME = ACCT.DBNAME
                        INNER JOIN dbo.BASE_CMS_Site AS S
                            ON ACCT.SiteID = S.SiteID
                           AND ACCT.SVR = S.SVR
                           AND ACCT.DBNAME = S.DBNAME
                        INNER JOIN dbo.BASE_HFit_TrackerCollectionSource AS TC
                            ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                           AND TC.SVR = TT.SVR
                           AND TC.DBNAME = TT.DBNAME
                        LEFT OUTER JOIN dbo.BASE_HFit_Tracker AS T
                            ON T.AggregateTableName = 'HFit_TrackerBloodPressure'
                           AND T.SVR = TT.SVR
                           AND T.DBNAME = TT.DBNAME
                        LEFT OUTER JOIN BASE_HFit_LKP_TrackerVendor AS VENDOR
                            ON TT.DBNAME = VENDOR.DBNAME
                           AND TT.SVR = VENDOR.SVR
                           AND TT.VendorID = Vendor.ItemID;
    END;

GO
--set rowcount 5 ;
EXEC PrintImmediate 'Processing FACT_HFit_TrackerBloodSugarAndGlucose';
EXEC PrintImmediate 'Rows: ';
EXEC proc_QuickRowCount BASE_HFit_TrackerBloodSugarAndGlucose;
IF NOT EXISTS (SELECT
                      name
                      FROM sys.tables
                      WHERE name = 'FACT_HFit_TrackerBloodSugarAndGlucose') 
    BEGIN
        EXEC PrintImmediate '*** Loading Records: FACT_HFit_TrackerBloodSugarAndGlucose';
        SELECT
               'HFit_TrackerBloodSugarAndGlucose' AS TrackerNameAggregateTable
             , TT.ItemID
             , CAST (EventDate AS DATETIME) AS EventDate
             , TT.IsProfessionallyCollected
             , TT.TrackerCollectionSourceID
             , Notes
             , TT.UserID
             , CollectionSourceName_Internal
             , CollectionSourceName_External
             , 'MISSING' AS EventName
             , 'mmol/L' AS UOM
             , 'Units' AS KEY1
             , CAST ( Units AS FLOAT) AS VAL1
             , 'FastingState' AS KEY2
             , CAST ( FastingState AS FLOAT) AS VAL2
             , 'NA' AS KEY3
             , NULL AS VAL3
             , 'NA' AS KEY4
             , NULL AS VAL4
             , 'NA' AS KEY5
             , NULL AS VAL5
             , 'NA' AS KEY6
             , NULL AS VAL6
             , 'NA' AS KEY7
             , NULL AS VAL7
             , 'NA' AS KEY8
             , NULL AS VAL8
             , 'NA' AS KEY9
             , NULL AS VAL9
             , 'NA' AS KEY10
             , NULL AS VAL10
             , TT.ItemCreatedBy
             , CAST (TT.ItemCreatedWhen AS DATETIME) AS ItemCreatedWhen
             , TT.ItemModifiedBy
             , CAST (TT.ItemModifiedWhen AS DATETIME) AS ItemModifiedWhen
             , IsProcessedForHa
             , 'NA' AS TXTKEY1
             , NULL AS TXTVAL1
             , 'NA' AS TXTKEY2
             , NULL AS TXTVAL2
             , 'NA' AS TXTKEY3
             , NULL AS TXTVAL3
             , NULL AS ItemOrder
             , NULL AS ItemGuid
             , C.UserGuid
             , PP.MPI
             , PP.ClientCode
             , S.SiteGUID
             , ACCT.AccountID
             , ACCT.AccountCD
             , T.IsAvailable
             , T.IsCustom
             , ISNULL ( T.UniqueName , 'glucose') AS UniqueName
             , ISNULL ( T.UniqueName , 'glucose') AS ColDesc
             , VENDOR.ItemID AS VendorID
             , VENDOR.VendorName
             , TT.LastModifiedDate
             , TT.SVR
             , TT.DBNAME
        INTO
             FACT_HFit_TrackerBloodSugarAndGlucose
               FROM dbo.BASE_HFit_TrackerBloodSugarAndGlucose AS TT
                        INNER JOIN dbo.BASE_CMS_User AS C
                            ON C.UserID = TT.UserID
                           AND C.SVR = TT.SVR
                           AND C.DBNAME = TT.DBNAME
                        INNER JOIN dbo.BASE_HFit_ppteligibility AS PP
                            ON TT.UserID = PP.userID
                           AND TT.SVR = PP.SVR
                           AND TT.DBNAME = PP.DBNAME
                        INNER JOIN dbo.BASE_HFit_Account AS ACCT
                            ON PP.ClientCode = ACCT.AccountCD
                           AND PP.SVR = ACCT.SVR
                           AND PP.DBNAME = ACCT.DBNAME
                        INNER JOIN dbo.BASE_CMS_Site AS S
                            ON ACCT.SiteID = S.SiteID
                           AND ACCT.SVR = S.SVR
                           AND ACCT.DBNAME = S.DBNAME
                        INNER JOIN dbo.BASE_HFit_TrackerCollectionSource AS TC
                            ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                           AND TC.SVR = TT.SVR
                           AND TC.DBNAME = TT.DBNAME
                        LEFT OUTER JOIN dbo.BASE_HFit_Tracker AS T
                            ON T.AggregateTableName = 'HFit_TrackerBloodSugarAndGlucose'
                           AND T.SVR = TT.SVR
                           AND T.DBNAME = TT.DBNAME
                        LEFT OUTER JOIN BASE_HFit_LKP_TrackerVendor AS VENDOR
                            ON TT.DBNAME = VENDOR.DBNAME
                           AND TT.SVR = VENDOR.SVR
                           AND TT.VendorID = Vendor.ItemID;
    END;
GO
--set rowcount 5 ;
EXEC PrintImmediate 'Processing FACT_HFit_TrackerBMI';
EXEC PrintImmediate 'Rows: ';
EXEC proc_QuickRowCount BASE_HFit_TrackerBMI;
IF NOT EXISTS (SELECT
                      name
                      FROM sys.tables
                      WHERE name = 'FACT_HFit_TrackerBMI') 
    BEGIN
        EXEC PrintImmediate '*** Loading Records: FACT_HFit_TrackerBMI';
        SELECT
               'HFit_TrackerBMI' AS TrackerNameAggregateTable
             , TT.ItemID
             , CAST (EventDate AS DATETIME) AS EventDate
             , TT.IsProfessionallyCollected
             , TT.TrackerCollectionSourceID
             , Notes
             , TT.UserID
             , CollectionSourceName_Internal
             , CollectionSourceName_External
             , 'MISSING' AS EventName
             , 'kg/m2' AS UOM
             , 'BMI' AS KEY1
             , CAST ( BMI AS FLOAT) AS VAL1
             , 'NA' AS KEY2
             , 0 AS VAL2
             , 'NA' AS KEY3
             , NULL AS VAL3
             , 'NA' AS KEY4
             , NULL AS VAL4
             , 'NA' AS KEY5
             , NULL AS VAL5
             , 'NA' AS KEY6
             , NULL AS VAL6
             , 'NA' AS KEY7
             , NULL AS VAL7
             , 'NA' AS KEY8
             , NULL AS VAL8
             , 'NA' AS KEY9
             , NULL AS VAL9
             , 'NA' AS KEY10
             , NULL AS VAL10
             , TT.ItemCreatedBy
             , CAST (TT.ItemCreatedWhen AS DATETIME) AS ItemCreatedWhen
             , TT.ItemModifiedBy
             , CAST (TT.ItemModifiedWhen AS DATETIME) AS ItemModifiedWhen
             , NULL AS IsProcessedForHa
             , 'NA' AS TXTKEY1
             , NULL AS TXTVAL1
             , 'NA' AS TXTKEY2
             , NULL AS TXTVAL2
             , 'NA' AS TXTKEY3
             , NULL AS TXTVAL3
             , TT.ItemOrder
             , NULL AS ItemGuid
             , C.UserGuid
             , PP.MPI
             , PP.ClientCode
             , S.SiteGUID
             , ACCT.AccountID
             , ACCT.AccountCD
             , T.IsAvailable
             , T.IsCustom
             , ISNULL ( T.UniqueName , 'HFit_TrackerBMI') AS UniqueName
             , ISNULL ( T.UniqueName , 'HFit_TrackerBMI') AS ColDesc
             , VENDOR.ItemID AS VendorID
             , VENDOR.VendorName
             , TT.LastModifiedDate
             , TT.SVR
             , TT.DBNAME
        INTO
             FACT_HFit_TrackerBMI
               FROM dbo.BASE_HFit_TrackerBMI AS TT
                        INNER JOIN dbo.BASE_CMS_User AS C
                            ON C.UserID = TT.UserID
                           AND C.SVR = TT.SVR
                           AND C.DBNAME = TT.DBNAME
                        INNER JOIN dbo.BASE_HFit_ppteligibility AS PP
                            ON TT.UserID = PP.userID
                           AND TT.SVR = PP.SVR
                           AND TT.DBNAME = PP.DBNAME
                        INNER JOIN dbo.BASE_HFit_Account AS ACCT
                            ON PP.ClientCode = ACCT.AccountCD
                           AND PP.SVR = ACCT.SVR
                           AND PP.DBNAME = ACCT.DBNAME
                        INNER JOIN dbo.BASE_CMS_Site AS S
                            ON ACCT.SiteID = S.SiteID
                           AND ACCT.SVR = S.SVR
                           AND ACCT.DBNAME = S.DBNAME
                        INNER JOIN dbo.BASE_HFit_TrackerCollectionSource AS TC
                            ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                           AND TC.SVR = TT.SVR
                           AND TC.DBNAME = TT.DBNAME
                        LEFT OUTER JOIN dbo.BASE_HFit_Tracker AS T
                            ON T.AggregateTableName = 'HFit_TrackerBMI'
                           AND T.SVR = TT.SVR
                           AND T.DBNAME = TT.DBNAME
                        LEFT OUTER JOIN BASE_HFit_LKP_TrackerVendor AS VENDOR
                            ON TT.DBNAME = VENDOR.DBNAME
                           AND TT.SVR = VENDOR.SVR
                           AND TT.VendorID = Vendor.ItemID;
    END;
GO
--set rowcount 5 ;
EXEC PrintImmediate 'Processing FACT_HFit_TrackerBodyFat';
EXEC PrintImmediate 'Rows: ';
EXEC proc_QuickRowCount BASE_HFit_TrackerBodyFat;
IF NOT EXISTS (SELECT
                      name
                      FROM sys.tables
                      WHERE name = 'FACT_HFit_TrackerBodyFat') 
    BEGIN
        EXEC PrintImmediate '*** Loading Records: FACT_HFit_TrackerBodyFat';
        SELECT
               'HFit_TrackerBodyFat' AS TrackerNameAggregateTable
             , TT.ItemID
             , CAST (EventDate AS DATETIME) AS EventDate
             , TT.IsProfessionallyCollected
             , TT.TrackerCollectionSourceID
             , Notes
             , TT.UserID
             , CollectionSourceName_Internal
             , CollectionSourceName_External
             , 'MISSING' AS EventName
             , 'PCT' AS UOM
             , 'Value' AS KEY1
             , CAST ( [Value] AS FLOAT) AS VAL1
             , 'NA' AS KEY2
             , 0 AS VAL2
             , 'NA' AS KEY3
             , NULL AS VAL3
             , 'NA' AS KEY4
             , NULL AS VAL4
             , 'NA' AS KEY5
             , NULL AS VAL5
             , 'NA' AS KEY6
             , NULL AS VAL6
             , 'NA' AS KEY7
             , NULL AS VAL7
             , 'NA' AS KEY8
             , NULL AS VAL8
             , 'NA' AS KEY9
             , NULL AS VAL9
             , 'NA' AS KEY10
             , NULL AS VAL10
             , TT.ItemCreatedBy
             , CAST (TT.ItemCreatedWhen AS DATETIME) AS ItemCreatedWhen
             , TT.ItemModifiedBy
             , CAST (TT.ItemModifiedWhen AS DATETIME) AS ItemModifiedWhen
             , NULL AS IsProcessedForHa
             , 'NA' AS TXTKEY1
             , NULL AS TXTVAL1
             , 'NA' AS TXTKEY2
             , NULL AS TXTVAL2
             , 'NA' AS TXTKEY3
             , NULL AS TXTVAL3
             , NULL AS ItemOrder
             , NULL AS ItemGuid
             , C.UserGuid
             , PP.MPI
             , PP.ClientCode
             , S.SiteGUID
             , ACCT.AccountID
             , ACCT.AccountCD
             , T.IsAvailable
             , T.IsCustom
             , ISNULL ( T.UniqueName , 'HFit_TrackerBodyFat') AS UniqueName
             , ISNULL ( T.UniqueName , 'HFit_TrackerBodyFat') AS ColDesc
             , VENDOR.ItemID AS VendorID
             , VENDOR.VendorName
             , TT.LastModifiedDate
             , TT.SVR
             , TT.DBNAME
        INTO
             FACT_HFit_TrackerBodyFat
               FROM dbo.BASE_HFit_TrackerBodyFat AS TT
                        INNER JOIN dbo.BASE_CMS_User AS C
                            ON C.UserID = TT.UserID
                           AND C.SVR = TT.SVR
                           AND C.DBNAME = TT.DBNAME
                        INNER JOIN dbo.BASE_HFit_ppteligibility AS PP
                            ON TT.UserID = PP.userID
                           AND TT.SVR = PP.SVR
                           AND TT.DBNAME = PP.DBNAME
                        INNER JOIN dbo.BASE_HFit_Account AS ACCT
                            ON PP.ClientCode = ACCT.AccountCD
                           AND PP.SVR = ACCT.SVR
                           AND PP.DBNAME = ACCT.DBNAME
                        INNER JOIN dbo.BASE_CMS_Site AS S
                            ON ACCT.SiteID = S.SiteID
                           AND ACCT.SVR = S.SVR
                           AND ACCT.DBNAME = S.DBNAME
                        INNER JOIN dbo.BASE_HFit_TrackerCollectionSource AS TC
                            ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                           AND TC.SVR = TT.SVR
                           AND TC.DBNAME = TT.DBNAME
                        LEFT OUTER JOIN dbo.BASE_HFit_Tracker AS T
                            ON T.AggregateTableName = 'HFit_TrackerBodyFat'
                           AND T.SVR = TT.SVR
                           AND T.DBNAME = TT.DBNAME
                        LEFT OUTER JOIN BASE_HFit_LKP_TrackerVendor AS VENDOR
                            ON TT.DBNAME = VENDOR.DBNAME
                           AND TT.SVR = VENDOR.SVR
                           AND TT.VendorID = Vendor.ItemID;
    END;

GO
--set rowcount 5 ;
--******************************************************************************
EXEC PrintImmediate 'Processing FACT_HFit_TrackerBodyMeasurements';
EXEC PrintImmediate 'Rows: ';
EXEC proc_QuickRowCount BASE_HFit_TrackerBodyMeasurements;
IF NOT EXISTS (SELECT
                      name
                      FROM sys.tables
                      WHERE name = 'FACT_HFit_TrackerBodyMeasurements') 
    BEGIN
        EXEC PrintImmediate '*** Loading Records: FACT_HFit_TrackerBodyMeasurements';
        SELECT
               'HFit_TrackerBodyMeasurements' AS TrackerNameAggregateTable
             , TT.ItemID
             , CAST (EventDate AS DATETIME) AS EventDate
             , TT.IsProfessionallyCollected
             , TT.TrackerCollectionSourceID
             , Notes
             , TT.UserID
             , CollectionSourceName_Internal
             , CollectionSourceName_External
             , 'MISSING' AS EventName
             , 'Inch' AS UOM
             , 'WaistInches' AS KEY1
             , CAST ( WaistInches AS FLOAT) AS VAL1
             , 'HipInches' AS KEY2
             , CAST ( HipInches AS FLOAT) AS VAL2
             , 'ThighInches' AS KEY3
             , CAST ( ThighInches AS FLOAT) AS VAL3
             , 'ArmInches' AS KEY4
             , CAST ( ArmInches AS FLOAT) AS VAL4
             , 'ChestInches' AS KEY5
             , CAST ( ChestInches AS FLOAT) AS VAL5
             , 'CalfInches' AS KEY6
             , CAST ( CalfInches AS FLOAT) AS VAL6
             , 'NeckInches' AS KEY7
             , CAST ( NeckInches AS FLOAT) AS VAL7
             , 'NA' AS KEY8
             , NULL AS VAL8
             , 'NA' AS KEY9
             , NULL AS VAL9
             , 'NA' AS KEY10
             , NULL AS VAL10
             , TT.ItemCreatedBy
             , CAST (TT.ItemCreatedWhen AS DATETIME) AS ItemCreatedWhen
             , TT.ItemModifiedBy
             , CAST (TT.ItemModifiedWhen AS DATETIME) AS ItemModifiedWhen
             , IsProcessedForHa
             , 'NA' AS TXTKEY1
             , NULL AS TXTVAL1
             , 'NA' AS TXTKEY2
             , NULL AS TXTVAL2
             , 'NA' AS TXTKEY3
             , NULL AS TXTVAL3
             , NULL AS ItemOrder
             , NULL AS ItemGuid
             , C.UserGuid
             , PP.MPI
             , PP.ClientCode
             , S.SiteGUID
             , ACCT.AccountID
             , ACCT.AccountCD
             , T.IsAvailable
             , T.IsCustom
             , T.UniqueName
             , T.UniqueName AS ColDesc
             , VENDOR.ItemID AS VendorID
             , VENDOR.VendorName
             , TT.LastModifiedDate
             , TT.SVR
             , TT.DBNAME
        INTO
             FACT_HFit_TrackerBodyMeasurements
               FROM dbo.BASE_HFit_TrackerBodyMeasurements AS TT
                        INNER JOIN dbo.BASE_CMS_User AS C
                            ON C.UserID = TT.UserID
                           AND C.SVR = TT.SVR
                           AND C.DBNAME = TT.DBNAME
                        INNER JOIN dbo.BASE_HFit_ppteligibility AS PP
                            ON TT.UserID = PP.userID
                           AND TT.SVR = PP.SVR
                           AND TT.DBNAME = PP.DBNAME
                        INNER JOIN dbo.BASE_HFit_Account AS ACCT
                            ON PP.ClientCode = ACCT.AccountCD
                           AND PP.SVR = ACCT.SVR
                           AND PP.DBNAME = ACCT.DBNAME
                        INNER JOIN dbo.BASE_CMS_Site AS S
                            ON ACCT.SiteID = S.SiteID
                           AND ACCT.SVR = S.SVR
                           AND ACCT.DBNAME = S.DBNAME
                        INNER JOIN dbo.BASE_HFit_TrackerCollectionSource AS TC
                            ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                           AND TC.SVR = TT.SVR
                           AND TC.DBNAME = TT.DBNAME
                        LEFT OUTER JOIN dbo.BASE_HFit_Tracker AS T
                            ON T.AggregateTableName = 'HFit_TrackerBodyMeasurements'
                           AND T.SVR = TT.SVR
                           AND T.DBNAME = TT.DBNAME
                        LEFT OUTER JOIN BASE_HFit_LKP_TrackerVendor AS VENDOR
                            ON TT.DBNAME = VENDOR.DBNAME
                           AND TT.SVR = VENDOR.SVR
                           AND TT.VendorID = Vendor.ItemID;
    --******************************************************************************
    END;
GO
--set rowcount 5 ;
EXEC PrintImmediate 'Processing FACT_HFit_TrackerCardio';
EXEC PrintImmediate 'Rows: ';
EXEC proc_QuickRowCount BASE_HFit_TrackerCardio;
IF NOT EXISTS (SELECT
                      name
                      FROM sys.tables
                      WHERE name = 'FACT_HFit_TrackerCardio') 
    BEGIN
        EXEC PrintImmediate '*** Loading Records: FACT_HFit_TrackerCardio';
        SELECT
               'HFit_TrackerCardio' AS TrackerNameAggregateTable
             , TT.ItemID
             , CAST (EventDate AS DATETIME) AS EventDate
             , TT.IsProfessionallyCollected
             , TT.TrackerCollectionSourceID
             , Notes
             , TT.UserID
             , CollectionSourceName_Internal
             , CollectionSourceName_External
             , 'MISSING' AS EventName
             , 'NA' AS UOM
             , 'Minutes' AS KEY1
             , CAST ( Minutes AS FLOAT) AS VAL1
             , 'Distance' AS KEY2
             , CAST ( Distance AS FLOAT) AS VAL2
             , 'DistanceUnit' AS KEY3
             , CAST ( DistanceUnit AS FLOAT) AS VAL3
             , 'Intensity' AS KEY4
             , CAST ( Intensity AS FLOAT) AS VAL4
             , 'ActivityID' AS KEY5
             , CAST ( ActivityID AS FLOAT) AS VAL5
             , 'NA' AS KEY6
             , NULL AS VAL6
             , 'NA' AS KEY7
             , NULL AS VAL7
             , 'NA' AS KEY8
             , NULL AS VAL8
             , 'NA' AS KEY9
             , NULL AS VAL9
             , 'NA' AS KEY10
             , NULL AS VAL10
             , TT.ItemCreatedBy
             , CAST (TT.ItemCreatedWhen AS DATETIME) AS ItemCreatedWhen
             , TT.ItemModifiedBy
             , CAST (TT.ItemModifiedWhen AS DATETIME) AS ItemModifiedWhen
             , NULL AS IsProcessedForHa
             , 'NA' AS TXTKEY1
             , NULL AS TXTVAL1
             , 'NA' AS TXTKEY2
             , NULL AS TXTVAL2
             , 'NA' AS TXTKEY3
             , NULL AS TXTVAL3
             , NULL AS ItemOrder
             , NULL AS ItemGuid
             , C.UserGuid
             , PP.MPI
             , PP.ClientCode
             , S.SiteGUID
             , ACCT.AccountID
             , ACCT.AccountCD
             , T.IsAvailable
             , T.IsCustom
             , T.UniqueName
             , T.UniqueName AS ColDesc
             , NULL AS VendorID	--VENDOR.ItemID as VendorID
             , NULL AS VendorName --VENDOR.VendorName
             , TT.LastModifiedDate
             , TT.SVR
             , TT.DBNAME
        INTO
             FACT_HFit_TrackerCardio
               FROM dbo.BASE_HFit_TrackerCardio AS TT
                        INNER JOIN dbo.BASE_CMS_User AS C
                            ON C.UserID = TT.UserID
                           AND C.SVR = TT.SVR
                           AND C.DBNAME = TT.DBNAME
                        INNER JOIN dbo.BASE_HFit_ppteligibility AS PP
                            ON TT.UserID = PP.userID
                           AND TT.SVR = PP.SVR
                           AND TT.DBNAME = PP.DBNAME
                        INNER JOIN dbo.BASE_HFit_Account AS ACCT
                            ON PP.ClientCode = ACCT.AccountCD
                           AND PP.SVR = ACCT.SVR
                           AND PP.DBNAME = ACCT.DBNAME
                        INNER JOIN dbo.BASE_CMS_Site AS S
                            ON ACCT.SiteID = S.SiteID
                           AND ACCT.SVR = S.SVR
                           AND ACCT.DBNAME = S.DBNAME
                        INNER JOIN dbo.BASE_HFit_TrackerCollectionSource AS TC
                            ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                           AND TC.SVR = TT.SVR
                           AND TC.DBNAME = TT.DBNAME
                        LEFT OUTER JOIN dbo.BASE_HFit_Tracker AS T
                            ON T.AggregateTableName = 'HFit_TrackerCardio'
                           AND T.SVR = TT.SVR
                           AND T.DBNAME = TT.DBNAME
               --the following where clause was added on 11/23/2015 as a result of BAD DATA from the PPT
               WHERE
               EventDate > '01/01/1960';
    --left outer join BASE_HFit_LKP_TrackerVendor as VENDOR ON TT.DBNAME= VENDOR.DBNAME and TT.SVR= VENDOR.SVR
    END;
GO
--set rowcount 5 ;
EXEC PrintImmediate 'Processing FACT_HFit_TrackerCholesterol';
EXEC PrintImmediate 'Rows: ';
EXEC proc_QuickRowCount BASE_HFit_TrackerCholesterol;
IF NOT EXISTS (SELECT
                      name
                      FROM sys.tables
                      WHERE name = 'FACT_HFit_TrackerCholesterol') 
    BEGIN
        EXEC PrintImmediate '*** Loading Records: FACT_HFit_TrackerCholesterol';
        SELECT
               'HFit_TrackerCholesterol' AS TrackerNameAggregateTable
             , TT.ItemID
             , CAST (EventDate AS DATETIME) AS EventDate
             , TT.IsProfessionallyCollected
             , TT.TrackerCollectionSourceID
             , Notes
             , TT.UserID
             , CollectionSourceName_Internal
             , CollectionSourceName_External
             , 'MISSING' AS EventName
             , 'mg/dL' AS UOM
             , 'HDL' AS KEY1
             , CAST ( HDL AS FLOAT) AS VAL1
             , 'LDL' AS KEY2
             , CAST ( LDL AS FLOAT) AS VAL2
             , 'Total' AS KEY3
             , CAST ( Total AS FLOAT) AS VAL3
             , 'Tri' AS KEY4
             , CAST ( Tri AS FLOAT) AS VAL4
             , 'Ratio' AS KEY5
             , CAST ( Ratio AS FLOAT) AS VAL5
             , 'Fasting' AS KEY6
             , CAST ( Fasting AS FLOAT) AS VAL6
             , 'VLDL' AS KEY7
             , CAST ( VLDL AS FLOAT) AS VAL7
             , 'NA' AS KEY8
             , NULL AS VAL8
             , 'NA' AS KEY9
             , NULL AS VAL9
             , 'NA' AS KEY10
             , NULL AS VAL10
             , TT.ItemCreatedBy
             , CAST (TT.ItemCreatedWhen AS DATETIME) AS ItemCreatedWhen
             , TT.ItemModifiedBy
             , CAST (TT.ItemModifiedWhen AS DATETIME) AS ItemModifiedWhen
             , IsProcessedForHa
             , 'NA' AS TXTKEY1
             , NULL AS TXTVAL1
             , 'NA' AS TXTKEY2
             , NULL AS TXTVAL2
             , 'NA' AS TXTKEY3
             , NULL AS TXTVAL3
             , NULL AS ItemOrder
             , NULL AS ItemGuid
             , C.UserGuid
             , PP.MPI
             , PP.ClientCode
             , S.SiteGUID
             , ACCT.AccountID
             , ACCT.AccountCD
             , T.IsAvailable
             , T.IsCustom
             , ISNULL ( T.UniqueName , 'HFit_TrackerCholesterol') AS UniqueName
             , ISNULL ( T.UniqueName , 'HFit_TrackerCholesterol') AS ColDesc
             , VENDOR.ItemID AS VendorID
             , VENDOR.VendorName
             , TT.LastModifiedDate
             , TT.SVR
             , TT.DBNAME
        INTO
             FACT_HFit_TrackerCholesterol
               FROM dbo.BASE_HFit_TrackerCholesterol AS TT
                        INNER JOIN dbo.BASE_CMS_User AS C
                            ON C.UserID = TT.UserID
                           AND C.SVR = TT.SVR
                           AND C.DBNAME = TT.DBNAME
                        INNER JOIN dbo.BASE_HFit_ppteligibility AS PP
                            ON TT.UserID = PP.userID
                           AND TT.SVR = PP.SVR
                           AND TT.DBNAME = PP.DBNAME
                        INNER JOIN dbo.BASE_HFit_Account AS ACCT
                            ON PP.ClientCode = ACCT.AccountCD
                           AND PP.SVR = ACCT.SVR
                           AND PP.DBNAME = ACCT.DBNAME
                        INNER JOIN dbo.BASE_CMS_Site AS S
                            ON ACCT.SiteID = S.SiteID
                           AND ACCT.SVR = S.SVR
                           AND ACCT.DBNAME = S.DBNAME
                        INNER JOIN dbo.BASE_HFit_TrackerCollectionSource AS TC
                            ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                           AND TC.SVR = TT.SVR
                           AND TC.DBNAME = TT.DBNAME
                        LEFT OUTER JOIN dbo.BASE_HFit_Tracker AS T
                            ON T.AggregateTableName = 'HFit_TrackerCholesterol'
                           AND T.SVR = TT.SVR
                           AND T.DBNAME = TT.DBNAME
                        LEFT OUTER JOIN BASE_HFit_LKP_TrackerVendor AS VENDOR
                            ON TT.DBNAME = VENDOR.DBNAME
                           AND TT.SVR = VENDOR.SVR
                           AND TT.VendorID = Vendor.ItemID;
    truncate table FACT_HFit_TrackerCholesterol ;
    END;
GO
--set rowcount 5 ;
EXEC PrintImmediate 'Processing FACT_HFit_TrackerDailySteps';
EXEC PrintImmediate 'Rows: ';
EXEC proc_QuickRowCount BASE_HFit_TrackerDailySteps;
IF NOT EXISTS (SELECT
                      name
                      FROM sys.tables
                      WHERE name = 'FACT_HFit_TrackerDailySteps') 
    BEGIN
        EXEC PrintImmediate '*** Loading Records: FACT_HFit_TrackerDailySteps';
        SELECT
               'HFit_TrackerDailySteps' AS TrackerNameAggregateTable
             , TT.ItemID
             , CAST (EventDate AS DATETIME) AS EventDate
             , TT.IsProfessionallyCollected
             , TT.TrackerCollectionSourceID
             , Notes
             , TT.UserID
             , CollectionSourceName_Internal
             , CollectionSourceName_External
             , 'MISSING' AS EventName
             , 'Step' AS UOM
             , 'Steps' AS KEY1
             , CAST ( Steps AS FLOAT) AS VAL1
             , 'NA' AS KEY2
             , NULL AS VAL2
             , 'NA' AS KEY3
             , NULL AS VAL3
             , 'NA' AS KEY4
             , NULL AS VAL4
             , 'NA' AS KEY5
             , NULL AS VAL5
             , 'NA' AS KEY6
             , NULL AS VAL6
             , 'NA' AS KEY7
             , NULL AS VAL7
             , 'NA' AS KEY8
             , NULL AS VAL8
             , 'NA' AS KEY9
             , NULL AS VAL9
             , 'NA' AS KEY10
             , NULL AS VAL10
             , TT.ItemCreatedBy
             , CAST (TT.ItemCreatedWhen AS DATETIME) AS ItemCreatedWhen
             , TT.ItemModifiedBy
             , CAST (TT.ItemModifiedWhen AS DATETIME) AS ItemModifiedWhen
             , NULL AS IsProcessedForHa
             , 'NA' AS TXTKEY1
             , NULL AS TXTVAL1
             , 'NA' AS TXTKEY2
             , NULL AS TXTVAL2
             , 'NA' AS TXTKEY3
             , NULL AS TXTVAL3
             , NULL AS ItemOrder
             , NULL AS ItemGuid
             , C.UserGuid
             , PP.MPI
             , PP.ClientCode
             , S.SiteGUID
             , ACCT.AccountID
             , ACCT.AccountCD
             , T.IsAvailable
             , T.IsCustom
             , ISNULL ( T.UniqueName , 'HFit_TrackerDailySteps') AS UniqueName
             , ISNULL ( T.UniqueName , 'HFit_TrackerDailySteps') AS ColDesc
             , NULL AS VendorID	--VENDOR.ItemID as VendorID
             ,
               NULL AS VendorName --VENDOR.VendorName
             , TT.LastModifiedDate
             , TT.SVR
             , TT.DBNAME
        INTO
             FACT_HFit_TrackerDailySteps
               FROM dbo.BASE_HFit_TrackerDailySteps AS TT
                        INNER JOIN dbo.BASE_CMS_User AS C
                            ON C.UserID = TT.UserID
                           AND C.SVR = TT.SVR
                           AND C.DBNAME = TT.DBNAME
                        INNER JOIN dbo.BASE_HFit_ppteligibility AS PP
                            ON TT.UserID = PP.userID
                           AND TT.SVR = PP.SVR
                           AND TT.DBNAME = PP.DBNAME
                        INNER JOIN dbo.BASE_HFit_Account AS ACCT
                            ON PP.ClientCode = ACCT.AccountCD
                           AND PP.SVR = ACCT.SVR
                           AND PP.DBNAME = ACCT.DBNAME
                        INNER JOIN dbo.BASE_CMS_Site AS S
                            ON ACCT.SiteID = S.SiteID
                           AND ACCT.SVR = S.SVR
                           AND ACCT.DBNAME = S.DBNAME
                        INNER JOIN dbo.BASE_HFit_TrackerCollectionSource AS TC
                            ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                           AND TC.SVR = TT.SVR
                           AND TC.DBNAME = TT.DBNAME
                        LEFT OUTER JOIN dbo.BASE_HFit_Tracker AS T
                            ON T.AggregateTableName = 'HFit_TrackerDailySteps'
                           AND T.SVR = TT.SVR
                           AND T.DBNAME = TT.DBNAME;

    --left outer join BASE_HFit_LKP_TrackerVendor as VENDOR ON TT.DBNAME= VENDOR.DBNAME and TT.SVR= VENDOR.SVR
    END;
GO
--set rowcount 5 ;
EXEC PrintImmediate 'Processing FACT_HFit_TrackerFlexibility';
EXEC PrintImmediate 'Rows: ';
EXEC proc_QuickRowCount BASE_HFit_TrackerFlexibility;
IF NOT EXISTS (SELECT
                      name
                      FROM sys.tables
                      WHERE name = 'FACT_HFit_TrackerFlexibility') 
    BEGIN
        EXEC PrintImmediate '*** Loading Records: FACT_HFit_TrackerFlexibility';
        SELECT
               'HFit_TrackerFlexibility' AS TrackerNameAggregateTable
             , TT.ItemID
             , CAST (EventDate AS DATETIME) AS EventDate
             , TT.IsProfessionallyCollected
             , TT.TrackerCollectionSourceID
             , Notes
             , TT.UserID
             , CollectionSourceName_Internal
             , CollectionSourceName_External
             , 'MISSING' AS EventName
             , 'Y/N' AS UOM
             , 'HasStretched' AS KEY1
             , CAST ( HasStretched AS FLOAT) AS VAL1
             , 'NA' AS KEY2
             , NULL AS VAL2
             , 'NA' AS KEY3
             , NULL AS VAL3
             , 'NA' AS KEY4
             , NULL AS VAL4
             , 'NA' AS KEY5
             , NULL AS VAL5
             , 'NA' AS KEY6
             , NULL AS VAL6
             , 'NA' AS KEY7
             , NULL AS VAL7
             , 'NA' AS KEY8
             , NULL AS VAL8
             , 'NA' AS KEY9
             , NULL AS VAL9
             , 'NA' AS KEY10
             , NULL AS VAL10
             , TT.ItemCreatedBy
             , CAST (TT.ItemCreatedWhen AS DATETIME) AS ItemCreatedWhen
             , TT.ItemModifiedBy
             , CAST (TT.ItemModifiedWhen AS DATETIME) AS ItemModifiedWhen
             , NULL AS IsProcessedForHa
             , 'Activity' AS TXTKEY1
             , Activity AS TXTVAL1
             , 'NA' AS TXTKEY2
             , NULL AS TXTVAL2
             , 'NA' AS TXTKEY3
             , NULL AS TXTVAL3
             , NULL AS ItemOrder
             , NULL AS ItemGuid
             , C.UserGuid
             , PP.MPI
             , PP.ClientCode
             , S.SiteGUID
             , ACCT.AccountID
             , ACCT.AccountCD
             , T.IsAvailable
             , T.IsCustom
             , T.UniqueName
             , T.UniqueName AS ColDesc
             , NULL AS VendorID	--VENDOR.ItemID as VendorID
             ,
               NULL AS VendorName --VENDOR.VendorName
             , TT.LastModifiedDate
             , TT.SVR
             , TT.DBNAME
        INTO
             FACT_HFit_TrackerFlexibility
               FROM dbo.BASE_HFit_TrackerFlexibility AS TT
                        INNER JOIN dbo.BASE_CMS_User AS C
                            ON C.UserID = TT.UserID
                           AND C.SVR = TT.SVR
                           AND C.DBNAME = TT.DBNAME
                        INNER JOIN dbo.BASE_HFit_ppteligibility AS PP
                            ON TT.UserID = PP.userID
                           AND TT.SVR = PP.SVR
                           AND TT.DBNAME = PP.DBNAME
                        INNER JOIN dbo.BASE_HFit_Account AS ACCT
                            ON PP.ClientCode = ACCT.AccountCD
                           AND PP.SVR = ACCT.SVR
                           AND PP.DBNAME = ACCT.DBNAME
                        INNER JOIN dbo.BASE_CMS_Site AS S
                            ON ACCT.SiteID = S.SiteID
                           AND ACCT.SVR = S.SVR
                           AND ACCT.DBNAME = S.DBNAME
                        INNER JOIN dbo.BASE_HFit_TrackerCollectionSource AS TC
                            ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                           AND TC.SVR = TT.SVR
                           AND TC.DBNAME = TT.DBNAME
                        LEFT OUTER JOIN dbo.BASE_HFit_Tracker AS T
                            ON T.AggregateTableName = 'HFit_TrackerFlexibility'
                           AND T.SVR = TT.SVR
                           AND T.DBNAME = TT.DBNAME;

    --left outer join BASE_HFit_LKP_TrackerVendor as VENDOR ON TT.DBNAME= VENDOR.DBNAME and TT.SVR= VENDOR.SVR
    END;
GO
--set rowcount 5 ;
EXEC PrintImmediate 'Processing FACT_HFit_TrackerFruits';
EXEC PrintImmediate 'Rows: ';
EXEC proc_QuickRowCount BASE_HFit_TrackerFruits;
IF NOT EXISTS (SELECT
                      name
                      FROM sys.tables
                      WHERE name = 'FACT_HFit_TrackerFruits') 
    BEGIN
        EXEC PrintImmediate '*** Loading Records: FACT_HFit_TrackerFruits';
        SELECT
               'HFit_TrackerFruits' AS TrackerNameAggregateTable
             , TT.ItemID
             , CAST (EventDate AS DATETIME) AS EventDate
             , TT.IsProfessionallyCollected
             , TT.TrackerCollectionSourceID
             , Notes
             , TT.UserID
             , CollectionSourceName_Internal
             , CollectionSourceName_External
             , 'MISSING' AS EventName
             , 'CUP(8oz)' AS UOM
             , 'Cups' AS KEY1
             , CAST ( Cups AS FLOAT) AS VAL1
             , 'NA' AS KEY2
             , NULL AS VAL2
             , 'NA' AS KEY3
             , NULL AS VAL3
             , 'NA' AS KEY4
             , NULL AS VAL4
             , 'NA' AS KEY5
             , NULL AS VAL5
             , 'NA' AS KEY6
             , NULL AS VAL6
             , 'NA' AS KEY7
             , NULL AS VAL7
             , 'NA' AS KEY8
             , NULL AS VAL8
             , 'NA' AS KEY9
             , NULL AS VAL9
             , 'NA' AS KEY10
             , NULL AS VAL10
             , TT.ItemCreatedBy
             , CAST (TT.ItemCreatedWhen AS DATETIME) AS ItemCreatedWhen
             , TT.ItemModifiedBy
             , CAST (TT.ItemModifiedWhen AS DATETIME) AS ItemModifiedWhen
             , NULL AS IsProcessedForHa
             , 'NA' AS TXTKEY1
             , NULL AS TXTVAL1
             , 'NA' AS TXTKEY2
             , NULL AS TXTVAL2
             , 'NA' AS TXTKEY3
             , NULL AS TXTVAL3
             , NULL AS ItemOrder
             , NULL AS ItemGuid
             , C.UserGuid
             , PP.MPI
             , PP.ClientCode
             , S.SiteGUID
             , ACCT.AccountID
             , ACCT.AccountCD
             , T.IsAvailable
             , T.IsCustom
             , T.UniqueName
             , T.UniqueName AS ColDesc
             , NULL AS VendorID	--VENDOR.ItemID as VendorID
             ,
               NULL AS VendorName --VENDOR.VendorName
             , TT.LastModifiedDate
             , TT.SVR
             , TT.DBNAME
        INTO
             FACT_HFit_TrackerFruits
               FROM dbo.BASE_HFit_TrackerFruits AS TT
                        INNER JOIN dbo.BASE_CMS_User AS C
                            ON C.UserID = TT.UserID
                           AND C.SVR = TT.SVR
                           AND C.DBNAME = TT.DBNAME
                        INNER JOIN dbo.BASE_HFit_ppteligibility AS PP
                            ON TT.UserID = PP.userID
                           AND TT.SVR = PP.SVR
                           AND TT.DBNAME = PP.DBNAME
                        INNER JOIN dbo.BASE_HFit_Account AS ACCT
                            ON PP.ClientCode = ACCT.AccountCD
                           AND PP.SVR = ACCT.SVR
                           AND PP.DBNAME = ACCT.DBNAME
                        INNER JOIN dbo.BASE_CMS_Site AS S
                            ON ACCT.SiteID = S.SiteID
                           AND ACCT.SVR = S.SVR
                           AND ACCT.DBNAME = S.DBNAME
                        INNER JOIN dbo.BASE_HFit_TrackerCollectionSource AS TC
                            ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                           AND TC.SVR = TT.SVR
                           AND TC.DBNAME = TT.DBNAME
                        LEFT OUTER JOIN dbo.BASE_HFit_Tracker AS T
                            ON T.AggregateTableName = 'HFit_TrackerFruits'
                           AND T.SVR = TT.SVR
                           AND T.DBNAME = TT.DBNAME;

    --left outer join BASE_HFit_LKP_TrackerVendor as VENDOR ON TT.DBNAME= VENDOR.DBNAME and TT.SVR= VENDOR.SVR
    END;
GO
--set rowcount 5 ;
--drop table FACT_HFit_TrackerHbA1c
EXEC PrintImmediate 'Processing FACT_HFit_TrackerHbA1c';
EXEC PrintImmediate 'Rows: ';
EXEC proc_QuickRowCount BASE_HFit_TrackerHbA1c;
IF NOT EXISTS (SELECT
                      name
                      FROM sys.tables
                      WHERE name = 'FACT_HFit_TrackerHbA1c') 
    BEGIN
        EXEC PrintImmediate '*** Loading Records: FACT_HFit_TrackerHbA1c';
        SELECT
               'HFit_TrackerHbA1c' AS TrackerNameAggregateTable
             , TT.ItemID
             , CAST (EventDate AS DATETIME) AS EventDate
             , TT.IsProfessionallyCollected
             , TT.TrackerCollectionSourceID
             , Notes
             , TT.UserID
             , CollectionSourceName_Internal
             , CollectionSourceName_External
             , 'MISSING' AS EventName
             , 'mmol/mol' AS UOM
             , 'Value' AS KEY1
             , CAST ( [Value] AS FLOAT) AS VAL1
             , 'NA' AS KEY2
             , NULL AS VAL2
             , 'NA' AS KEY3
             , NULL AS VAL3
             , 'NA' AS KEY4
             , NULL AS VAL4
             , 'NA' AS KEY5
             , NULL AS VAL5
             , 'NA' AS KEY6
             , NULL AS VAL6
             , 'NA' AS KEY7
             , NULL AS VAL7
             , 'NA' AS KEY8
             , NULL AS VAL8
             , 'NA' AS KEY9
             , NULL AS VAL9
             , 'NA' AS KEY10
             , NULL AS VAL10
             , TT.ItemCreatedBy
             , CAST (TT.ItemCreatedWhen AS DATETIME) AS ItemCreatedWhen
             , TT.ItemModifiedBy
             , CAST (TT.ItemModifiedWhen AS DATETIME) AS ItemModifiedWhen
             , IsProcessedForHa
             , 'NA' AS TXTKEY1
             , NULL AS TXTVAL1
             , 'NA' AS TXTKEY2
             , NULL AS TXTVAL2
             , 'NA' AS TXTKEY3
             , NULL AS TXTVAL3
             , NULL AS ItemOrder
             , NULL AS ItemGuid
             , C.UserGuid
             , PP.MPI
             , PP.ClientCode
             , S.SiteGUID
             , ACCT.AccountID
             , ACCT.AccountCD
             , T.IsAvailable
             , T.IsCustom
             , T.UniqueName
             , T.UniqueName AS ColDesc
             , VENDOR.ItemID AS VendorID
             , VENDOR.VendorName
             , TT.LastModifiedDate
             , TT.SVR
             , TT.DBNAME
        INTO
             FACT_HFit_TrackerHbA1c
               FROM dbo.BASE_HFit_TrackerHbA1c AS TT
                        INNER JOIN dbo.BASE_CMS_User AS C
                            ON C.UserID = TT.UserID
                           AND C.SVR = TT.SVR
                           AND C.DBNAME = TT.DBNAME
                        INNER JOIN dbo.BASE_HFit_ppteligibility AS PP
                            ON TT.UserID = PP.userID
                           AND TT.SVR = PP.SVR
                           AND TT.DBNAME = PP.DBNAME
                        INNER JOIN dbo.BASE_HFit_Account AS ACCT
                            ON PP.ClientCode = ACCT.AccountCD
                           AND PP.SVR = ACCT.SVR
                           AND PP.DBNAME = ACCT.DBNAME
                        INNER JOIN dbo.BASE_CMS_Site AS S
                            ON ACCT.SiteID = S.SiteID
                           AND ACCT.SVR = S.SVR
                           AND ACCT.DBNAME = S.DBNAME
                        INNER JOIN dbo.BASE_HFit_TrackerCollectionSource AS TC
                            ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                           AND TC.SVR = TT.SVR
                           AND TC.DBNAME = TT.DBNAME
                        LEFT OUTER JOIN dbo.BASE_HFit_Tracker AS T
                            ON T.AggregateTableName = 'HFit_TrackerHbA1c'
                           AND T.SVR = TT.SVR
                           AND T.DBNAME = TT.DBNAME
                        LEFT OUTER JOIN BASE_HFit_LKP_TrackerVendor AS VENDOR
                            ON TT.DBNAME = VENDOR.DBNAME
                           AND TT.SVR = VENDOR.SVR
                           AND TT.VendorID = Vendor.ItemID;
    END;
GO
--set rowcount 5 ;
EXEC PrintImmediate 'Processing FACT_HFit_TrackerHeight';
EXEC PrintImmediate 'Rows: ';
EXEC proc_QuickRowCount BASE_HFit_TrackerHeight;
EXEC proc_QuickRowCount FACT_HFit_TrackerHeight;

IF NOT EXISTS (SELECT
                      name
                      FROM sys.tables
                      WHERE name = 'FACT_HFit_TrackerHeight') 
    BEGIN
        EXEC PrintImmediate '*** Loading Records: FACT_HFit_TrackerHeight';
        SELECT
               'HFit_TrackerHeight' AS TrackerNameAggregateTable
             , TT.ItemID
             , CAST (EventDate AS DATETIME) AS EventDate
             , TT.IsProfessionallyCollected
             , TT.TrackerCollectionSourceID
             , Notes
             , TT.UserID
             , CollectionSourceName_Internal
             , CollectionSourceName_External
             , 'MISSING' AS EventName
             , 'inch' AS UOM
             , 'Height' AS KEY1
             , Height AS VAL1
             , 'NA' AS KEY2
             , NULL AS VAL2
             , 'NA' AS KEY3
             , NULL AS VAL3
             , 'NA' AS KEY4
             , NULL AS VAL4
             , 'NA' AS KEY5
             , NULL AS VAL5
             , 'NA' AS KEY6
             , NULL AS VAL6
             , 'NA' AS KEY7
             , NULL AS VAL7
             , 'NA' AS KEY8
             , NULL AS VAL8
             , 'NA' AS KEY9
             , NULL AS VAL9
             , 'NA' AS KEY10
             , NULL AS VAL10
             , TT.ItemCreatedBy
             , CAST (TT.ItemCreatedWhen AS DATETIME) AS ItemCreatedWhen
             , TT.ItemModifiedBy
             , CAST (TT.ItemModifiedWhen AS DATETIME) AS ItemModifiedWhen
             , IsProcessedForHa
             , 'NA' AS TXTKEY1
             , NULL AS TXTVAL1
             , 'NA' AS TXTKEY2
             , NULL AS TXTVAL2
             , 'NA' AS TXTKEY3
             , NULL AS TXTVAL3
             , TT.ItemOrder
             , TT.ItemGuid
             , C.UserGuid
             , PP.MPI
             , PP.ClientCode
             , S.SiteGUID
             , ACCT.AccountID
             , ACCT.AccountCD
             , T.IsAvailable
             , T.IsCustom
             , ISNULL ( T.UniqueName , 'HFit_TrackerHeight') AS UniqueName
             , ISNULL ( T.UniqueName , 'HFit_TrackerHeight') AS ColDesc
             , VENDOR.ItemID AS VendorID
             , VENDOR.VendorName
             , TT.LastModifiedDate
             , TT.SVR
             , TT.DBNAME
        INTO
             FACT_HFit_TrackerHeight
               FROM dbo.BASE_HFit_TrackerHeight AS TT
                        INNER JOIN dbo.BASE_CMS_User AS C
                            ON C.UserID = TT.UserID
                           AND C.SVR = TT.SVR
                           AND C.DBNAME = TT.DBNAME
                        INNER JOIN dbo.BASE_HFit_ppteligibility AS PP
                            ON TT.UserID = PP.userID
                           AND TT.SVR = PP.SVR
                           AND TT.DBNAME = PP.DBNAME
                        INNER JOIN dbo.BASE_HFit_Account AS ACCT
                            ON PP.ClientCode = ACCT.AccountCD
                           AND PP.SVR = ACCT.SVR
                           AND PP.DBNAME = ACCT.DBNAME
                        INNER JOIN dbo.BASE_CMS_Site AS S
                            ON ACCT.SiteID = S.SiteID
                           AND ACCT.SVR = S.SVR
                           AND ACCT.DBNAME = S.DBNAME
                        INNER JOIN dbo.BASE_HFit_TrackerCollectionSource AS TC
                            ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                           AND TC.SVR = TT.SVR
                           AND TC.DBNAME = TT.DBNAME
                        LEFT OUTER JOIN dbo.BASE_HFit_Tracker AS T
                            ON T.AggregateTableName = 'HFit_TrackerHeight'
                           AND T.SVR = TT.SVR
                           AND T.DBNAME = TT.DBNAME
                        LEFT OUTER JOIN BASE_HFit_LKP_TrackerVendor AS VENDOR
                            ON TT.DBNAME = VENDOR.DBNAME
                           AND TT.SVR = VENDOR.SVR
                           AND TT.VendorID = Vendor.ItemID;
    END;
GO
--set rowcount 5 ;
EXEC PrintImmediate 'Processing FACT_HFit_TrackerHighFatFoods';
EXEC PrintImmediate 'Rows: ';
EXEC proc_QuickRowCount BASE_HFit_TrackerHighFatFoods;
IF NOT EXISTS (SELECT
                      name
                      FROM sys.tables
                      WHERE name = 'FACT_HFit_TrackerHighFatFoods') 
    BEGIN
        EXEC PrintImmediate '*** Loading Records: FACT_HFit_TrackerHighFatFoods';
        SELECT
               'HFit_TrackerHighFatFoods' AS TrackerNameAggregateTable
             , TT.ItemID
             , CAST (EventDate AS DATETIME) AS EventDate
             , TT.IsProfessionallyCollected
             , TT.TrackerCollectionSourceID
             , Notes
             , TT.UserID
             , CollectionSourceName_Internal
             , CollectionSourceName_External
             , 'MISSING' AS EventName
             , 'Occurs' AS UOM
             , 'Times' AS KEY1
             , CAST ( Times AS FLOAT) AS VAL1
             , 'NA' AS KEY2
             , NULL AS VAL2
             , 'NA' AS KEY3
             , NULL AS VAL3
             , 'NA' AS KEY4
             , NULL AS VAL4
             , 'NA' AS KEY5
             , NULL AS VAL5
             , 'NA' AS KEY6
             , NULL AS VAL6
             , 'NA' AS KEY7
             , NULL AS VAL7
             , 'NA' AS KEY8
             , NULL AS VAL8
             , 'NA' AS KEY9
             , NULL AS VAL9
             , 'NA' AS KEY10
             , NULL AS VAL10
             , TT.ItemCreatedBy
             , CAST (TT.ItemCreatedWhen AS DATETIME) AS ItemCreatedWhen
             , TT.ItemModifiedBy
             , CAST (TT.ItemModifiedWhen AS DATETIME) AS ItemModifiedWhen
             , NULL AS IsProcessedForHa
             , 'NA' AS TXTKEY1
             , NULL AS TXTVAL1
             , 'NA' AS TXTKEY2
             , NULL AS TXTVAL2
             , 'NA' AS TXTKEY3
             , NULL AS TXTVAL3
             , NULL AS ItemOrder
             , NULL AS ItemGuid
             , C.UserGuid
             , PP.MPI
             , PP.ClientCode
             , S.SiteGUID
             , ACCT.AccountID
             , ACCT.AccountCD
             , T.IsAvailable
             , T.IsCustom
             , T.UniqueName
             , T.UniqueName AS ColDesc
             , NULL AS VendorID	--VENDOR.ItemID as VendorID
             , NULL AS VendorName --VENDOR.VendorName
             , TT.LastModifiedDate
             , TT.SVR
             , TT.DBNAME
        INTO
             FACT_HFit_TrackerHighFatFoods
               FROM dbo.BASE_HFit_TrackerHighFatFoods AS TT
                        INNER JOIN dbo.BASE_CMS_User AS C
                            ON C.UserID = TT.UserID
                           AND C.SVR = TT.SVR
                           AND C.DBNAME = TT.DBNAME
                        INNER JOIN dbo.BASE_HFit_ppteligibility AS PP
                            ON TT.UserID = PP.userID
                           AND TT.SVR = PP.SVR
                           AND TT.DBNAME = PP.DBNAME
                        INNER JOIN dbo.BASE_HFit_Account AS ACCT
                            ON PP.ClientCode = ACCT.AccountCD
                           AND PP.SVR = ACCT.SVR
                           AND PP.DBNAME = ACCT.DBNAME
                        INNER JOIN dbo.BASE_CMS_Site AS S
                            ON ACCT.SiteID = S.SiteID
                           AND ACCT.SVR = S.SVR
                           AND ACCT.DBNAME = S.DBNAME
                        INNER JOIN dbo.BASE_HFit_TrackerCollectionSource AS TC
                            ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                           AND TC.SVR = TT.SVR
                           AND TC.DBNAME = TT.DBNAME
                        LEFT OUTER JOIN dbo.BASE_HFit_Tracker AS T
                            ON T.AggregateTableName = 'HFit_TrackerHighFatFoods'
                           AND T.SVR = TT.SVR
                           AND T.DBNAME = TT.DBNAME;

    --left outer join BASE_HFit_LKP_TrackerVendor as VENDOR ON TT.DBNAME= VENDOR.DBNAME and TT.SVR= VENDOR.SVR
    END;
GO
--set rowcount 5 ;
EXEC PrintImmediate 'Processing FACT_HFit_TrackerHighSodiumFoods';
EXEC PrintImmediate 'Rows: ';
EXEC proc_QuickRowCount BASE_HFit_TrackerHighSodiumFoods;
IF NOT EXISTS (SELECT
                      name
                      FROM sys.tables
                      WHERE name = 'FACT_HFit_TrackerHighSodiumFoods') 
    BEGIN
        EXEC PrintImmediate '*** Loading Records: FACT_HFit_TrackerHighSodiumFoods';
        SELECT
               'HFit_TrackerHighSodiumFoods' AS TrackerNameAggregateTable
             , TT.ItemID
             , CAST (EventDate AS DATETIME) AS EventDate
             , TT.IsProfessionallyCollected
             , TT.TrackerCollectionSourceID
             , Notes
             , TT.UserID
             , CollectionSourceName_Internal
             , CollectionSourceName_External
             , 'MISSING' AS EventName
             , 'Occurs' AS UOM
             , 'Times' AS KEY1
             , CAST ( Times AS FLOAT) AS VAL1
             , 'NA' AS KEY2
             , NULL AS VAL2
             , 'NA' AS KEY3
             , NULL AS VAL3
             , 'NA' AS KEY4
             , NULL AS VAL4
             , 'NA' AS KEY5
             , NULL AS VAL5
             , 'NA' AS KEY6
             , NULL AS VAL6
             , 'NA' AS KEY7
             , NULL AS VAL7
             , 'NA' AS KEY8
             , NULL AS VAL8
             , 'NA' AS KEY9
             , NULL AS VAL9
             , 'NA' AS KEY10
             , NULL AS VAL10
             , TT.ItemCreatedBy
             , CAST (TT.ItemCreatedWhen AS DATETIME) AS ItemCreatedWhen
             , TT.ItemModifiedBy
             , CAST (TT.ItemModifiedWhen AS DATETIME) AS ItemModifiedWhen
             , NULL AS IsProcessedForHa
             , 'NA' AS TXTKEY1
             , NULL AS TXTVAL1
             , 'NA' AS TXTKEY2
             , NULL AS TXTVAL2
             , 'NA' AS TXTKEY3
             , NULL AS TXTVAL3
             , NULL AS ItemOrder
             , NULL AS ItemGuid
             , C.UserGuid
             , PP.MPI
             , PP.ClientCode
             , S.SiteGUID
             , ACCT.AccountID
             , ACCT.AccountCD
             , T.IsAvailable
             , T.IsCustom
             , T.UniqueName
             , T.UniqueName AS ColDesc
             , NULL AS VendorID	--VENDOR.ItemID as VendorID
             ,
               NULL AS VendorName --VENDOR.VendorName
             , TT.LastModifiedDate
             , TT.SVR
             , TT.DBNAME
        INTO
             FACT_HFit_TrackerHighSodiumFoods
               FROM dbo.BASE_HFit_TrackerHighSodiumFoods AS TT
                        INNER JOIN dbo.BASE_CMS_User AS C
                            ON C.UserID = TT.UserID
                           AND C.SVR = TT.SVR
                           AND C.DBNAME = TT.DBNAME
                        INNER JOIN dbo.BASE_HFit_ppteligibility AS PP
                            ON TT.UserID = PP.userID
                           AND TT.SVR = PP.SVR
                           AND TT.DBNAME = PP.DBNAME
                        INNER JOIN dbo.BASE_HFit_Account AS ACCT
                            ON PP.ClientCode = ACCT.AccountCD
                           AND PP.SVR = ACCT.SVR
                           AND PP.DBNAME = ACCT.DBNAME
                        INNER JOIN dbo.BASE_CMS_Site AS S
                            ON ACCT.SiteID = S.SiteID
                           AND ACCT.SVR = S.SVR
                           AND ACCT.DBNAME = S.DBNAME
                        INNER JOIN dbo.BASE_HFit_TrackerCollectionSource AS TC
                            ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                           AND TC.SVR = TT.SVR
                           AND TC.DBNAME = TT.DBNAME
                        LEFT OUTER JOIN dbo.BASE_HFit_Tracker AS T
                            ON T.AggregateTableName = 'HFit_TrackerHighSodiumFoods'
                           AND T.SVR = TT.SVR
                           AND T.DBNAME = TT.DBNAME;
    END;
GO
--set rowcount 5 ;
EXEC PrintImmediate 'Processing FACT_HFit_TrackerInstance_Tracker';
EXEC PrintImmediate 'Rows: ';
EXEC proc_QuickRowCount BASE_HFit_TrackerInstance_Tracker;
IF NOT EXISTS (SELECT
                      name
                      FROM sys.tables
                      WHERE name = 'FACT_HFit_TrackerInstance_Tracker') 
    BEGIN
        EXEC PrintImmediate '*** Loading Records: FACT_HFit_TrackerInstance_Tracker';
        SELECT
               'HFit_TrackerInstance_Tracker' AS TrackerNameAggregateTable
             , TT.ItemID
             , CAST (EventDate AS DATETIME) AS EventDate
             , TT.IsProfessionallyCollected
             , TT.TrackerCollectionSourceID
             , Notes
             , TT.UserID
             , CollectionSourceName_Internal
             , CollectionSourceName_External
             , 'MISSING' AS EventName
             , 'Y/N' AS UOM
             , 'TrackerDefID' AS KEY1
             , CAST (TrackerDefID AS FLOAT) AS VAL1
             , 'YesNoValue' AS KEY2
             , CAST (YesNoValue AS FLOAT) AS VAL2
             , 'NA' AS KEY3
             , NULL AS VAL3
             , 'NA' AS KEY4
             , NULL AS VAL4
             , 'NA' AS KEY5
             , NULL AS VAL5
             , 'NA' AS KEY6
             , NULL AS VAL6
             , 'NA' AS KEY7
             , NULL AS VAL7
             , 'NA' AS KEY8
             , NULL AS VAL8
             , 'NA' AS KEY9
             , NULL AS VAL9
             , 'NA' AS KEY10
             , NULL AS VAL10
             , TT.ItemCreatedBy
             , CAST (TT.ItemCreatedWhen AS DATETIME) AS ItemCreatedWhen
             , TT.ItemModifiedBy
             , CAST (TT.ItemModifiedWhen AS DATETIME) AS ItemModifiedWhen
             , NULL AS IsProcessedForHa
             , 'NA' AS TXTKEY1
             , NULL AS TXTVAL1
             , 'NA' AS TXTKEY2
             , NULL AS TXTVAL2
             , 'NA' AS TXTKEY3
             , NULL AS TXTVAL3
             , NULL AS ItemOrder
             , NULL AS ItemGuid
             , C.UserGuid
             , PP.MPI
             , PP.ClientCode
             , S.SiteGUID
             , ACCT.AccountID
             , ACCT.AccountCD
             , T.IsAvailable
             , T.IsCustom
             , T.UniqueName
             , T.UniqueName AS ColDesc
             , NULL AS VendorID
             , NULL AS VendorName
             , TT.LastModifiedDate
             , TT.SVR
             , TT.DBNAME
        INTO
             FACT_HFit_TrackerInstance_Tracker
               FROM dbo.BASE_HFit_TrackerInstance_Tracker AS TT
                        INNER JOIN dbo.BASE_HFit_TrackerDef_Tracker AS TDT
                            ON TDT.trackerid = TT.trackerDefID
                           AND TDT.SVR = TT.SVR
                           AND TDT.DBNAME = TT.DBNAME
                        INNER JOIN dbo.BASE_CMS_User AS C
                            ON C.UserID = TT.UserID
                           AND C.SVR = TT.SVR
                           AND C.DBNAME = TT.DBNAME
                        INNER JOIN dbo.BASE_HFit_ppteligibility AS PP
                            ON TT.UserID = PP.userID
                           AND TT.SVR = PP.SVR
                           AND TT.DBNAME = PP.DBNAME
                        INNER JOIN dbo.BASE_HFit_Account AS ACCT
                            ON PP.ClientCode = ACCT.AccountCD
                           AND PP.SVR = ACCT.SVR
                           AND PP.DBNAME = ACCT.DBNAME
                        INNER JOIN dbo.BASE_CMS_Site AS S
                            ON ACCT.SiteID = S.SiteID
                           AND ACCT.SVR = S.SVR
                           AND ACCT.DBNAME = S.DBNAME
                        INNER JOIN dbo.BASE_HFit_TrackerCollectionSource AS TC
                            ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                           AND TC.SVR = TT.SVR
                           AND TC.DBNAME = TT.DBNAME
                        LEFT OUTER JOIN dbo.BASE_HFit_Tracker AS T
                            ON T.AggregateTableName = 'HFit_TrackerInstance_Tracker'
                           AND T.SVR = TT.SVR
                           AND T.DBNAME = TT.DBNAME
                           AND T.DBNAME = TDT.DBNAME
                           AND T.SVR = TDT.SVR;
    END;
GO
--set rowcount 5 ;
EXEC PrintImmediate 'Processing FACT_HFit_TrackerMealPortions';
EXEC PrintImmediate 'Rows: ';
EXEC proc_QuickRowCount BASE_HFit_TrackerMealPortions;
IF NOT EXISTS (SELECT
                      name
                      FROM sys.tables
                      WHERE name = 'FACT_HFit_TrackerMealPortions') 
    BEGIN
        EXEC PrintImmediate '*** Loading Records: FACT_HFit_TrackerMealPortions';
        SELECT
               'HFit_TrackerMealPortions' AS TrackerNameAggregateTable
             , TT.ItemID
             , CAST (EventDate AS DATETIME) AS EventDate
             , TT.IsProfessionallyCollected
             , TT.TrackerCollectionSourceID
             , Notes
             , TT.UserID
             , CollectionSourceName_Internal
             , CollectionSourceName_External
             , 'MISSING' AS EventName
             , 'NA-portion' AS UOM
             , 'Portions' AS KEY1
             , CAST ( Portions AS FLOAT) AS VAL1
             , 'NA' AS KEY2
             , NULL AS VAL2
             , 'NA' AS KEY3
             , NULL AS VAL3
             , 'NA' AS KEY4
             , NULL AS VAL4
             , 'NA' AS KEY5
             , NULL AS VAL5
             , 'NA' AS KEY6
             , NULL AS VAL6
             , 'NA' AS KEY7
             , NULL AS VAL7
             , 'NA' AS KEY8
             , NULL AS VAL8
             , 'NA' AS KEY9
             , NULL AS VAL9
             , 'NA' AS KEY10
             , NULL AS VAL10
             , TT.ItemCreatedBy
             , CAST (TT.ItemCreatedWhen AS DATETIME) AS ItemCreatedWhen
             , TT.ItemModifiedBy
             , CAST (TT.ItemModifiedWhen AS DATETIME) AS ItemModifiedWhen
             , NULL AS IsProcessedForHa
             , 'NA' AS TXTKEY1
             , NULL AS TXTVAL1
             , 'NA' AS TXTKEY2
             , NULL AS TXTVAL2
             , 'NA' AS TXTKEY3
             , NULL AS TXTVAL3
             , NULL AS ItemOrder
             , NULL AS ItemGuid
             , C.UserGuid
             , PP.MPI
             , PP.ClientCode
             , S.SiteGUID
             , ACCT.AccountID
             , ACCT.AccountCD
             , T.IsAvailable
             , T.IsCustom
             , T.UniqueName
             , T.UniqueName AS ColDesc
             , NULL AS VendorID	--VENDOR.ItemID as VendorID
             ,
               NULL AS VendorName --VENDOR.VendorName
             , TT.LastModifiedDate
             , TT.SVR
             , TT.DBNAME
        INTO
             FACT_HFit_TrackerMealPortions
               FROM dbo.BASE_HFit_TrackerMealPortions AS TT
                        INNER JOIN dbo.BASE_CMS_User AS C
                            ON C.UserID = TT.UserID
                           AND C.SVR = TT.SVR
                           AND C.DBNAME = TT.DBNAME
                        INNER JOIN dbo.BASE_HFit_ppteligibility AS PP
                            ON TT.UserID = PP.userID
                           AND TT.SVR = PP.SVR
                           AND TT.DBNAME = PP.DBNAME
                        INNER JOIN dbo.BASE_HFit_Account AS ACCT
                            ON PP.ClientCode = ACCT.AccountCD
                           AND PP.SVR = ACCT.SVR
                           AND PP.DBNAME = ACCT.DBNAME
                        INNER JOIN dbo.BASE_CMS_Site AS S
                            ON ACCT.SiteID = S.SiteID
                           AND ACCT.SVR = S.SVR
                           AND ACCT.DBNAME = S.DBNAME
                        INNER JOIN dbo.BASE_HFit_TrackerCollectionSource AS TC
                            ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                           AND TC.SVR = TT.SVR
                           AND TC.DBNAME = TT.DBNAME
                        LEFT OUTER JOIN dbo.BASE_HFit_Tracker AS T
                            ON T.AggregateTableName = 'HFit_TrackerMealPortions'
                           AND T.SVR = TT.SVR
                           AND T.DBNAME = TT.DBNAME;

    --left outer join BASE_HFit_LKP_TrackerVendor as VENDOR ON TT.DBNAME= VENDOR.DBNAME and TT.SVR= VENDOR.SVR
    END;
GO
--set rowcount 5 ;
EXEC PrintImmediate 'Processing FACT_HFit_TrackerMedicalCarePlan';
EXEC PrintImmediate 'Rows: ';
EXEC proc_QuickRowCount BASE_HFit_TrackerMedicalCarePlan;
IF NOT EXISTS (SELECT
                      name
                      FROM sys.tables
                      WHERE name = 'FACT_HFit_TrackerMedicalCarePlan') 
    BEGIN
        EXEC PrintImmediate '*** Loading Records: FACT_HFit_TrackerMedicalCarePlan';
        SELECT
               'HFit_TrackerMedicalCarePlan' AS TrackerNameAggregateTable
             , TT.ItemID
             , CAST (EventDate AS DATETIME) AS EventDate
             , TT.IsProfessionallyCollected
             , TT.TrackerCollectionSourceID
             , Notes
             , TT.UserID
             , CollectionSourceName_Internal
             , CollectionSourceName_External
             , 'MISSING' AS EventName
             , 'Y/N' AS UOM
             , 'FollowedPlan' AS KEY1
             , CAST ( FollowedPlan AS FLOAT) AS VAL1
             , 'NA' AS KEY2
             , NULL AS VAL2
             , 'NA' AS KEY3
             , NULL AS VAL3
             , 'NA' AS KEY4
             , NULL AS VAL4
             , 'NA' AS KEY5
             , NULL AS VAL5
             , 'NA' AS KEY6
             , NULL AS VAL6
             , 'NA' AS KEY7
             , NULL AS VAL7
             , 'NA' AS KEY8
             , NULL AS VAL8
             , 'NA' AS KEY9
             , NULL AS VAL9
             , 'NA' AS KEY10
             , NULL AS VAL10
             , TT.ItemCreatedBy
             , CAST (TT.ItemCreatedWhen AS DATETIME) AS ItemCreatedWhen
             , TT.ItemModifiedBy
             , CAST (TT.ItemModifiedWhen AS DATETIME) AS ItemModifiedWhen
             , NULL AS IsProcessedForHa
             , 'NA' AS TXTKEY1
             , NULL AS TXTVAL1
             , 'NA' AS TXTKEY2
             , NULL AS TXTVAL2
             , 'NA' AS TXTKEY3
             , NULL AS TXTVAL3
             , NULL AS ItemOrder
             , NULL AS ItemGuid
             , C.UserGuid
             , PP.MPI
             , PP.ClientCode
             , S.SiteGUID
             , ACCT.AccountID
             , ACCT.AccountCD
             , T.IsAvailable
             , T.IsCustom
             , T.UniqueName
             , T.UniqueName AS ColDesc
             , NULL AS VendorID	--VENDOR.ItemID as VendorID
             , NULL AS VendorName --VENDOR.VendorName
             , TT.LastModifiedDate
             , TT.SVR
             , TT.DBNAME
        INTO
             FACT_HFit_TrackerMedicalCarePlan
               FROM dbo.BASE_HFit_TrackerMedicalCarePlan AS TT
                        INNER JOIN dbo.BASE_CMS_User AS C
                            ON C.UserID = TT.UserID
                           AND C.SVR = TT.SVR
                           AND C.DBNAME = TT.DBNAME
                        INNER JOIN dbo.BASE_HFit_ppteligibility AS PP
                            ON TT.UserID = PP.userID
                           AND TT.SVR = PP.SVR
                           AND TT.DBNAME = PP.DBNAME
                        INNER JOIN dbo.BASE_HFit_Account AS ACCT
                            ON PP.ClientCode = ACCT.AccountCD
                           AND PP.SVR = ACCT.SVR
                           AND PP.DBNAME = ACCT.DBNAME
                        INNER JOIN dbo.BASE_CMS_Site AS S
                            ON ACCT.SiteID = S.SiteID
                           AND ACCT.SVR = S.SVR
                           AND ACCT.DBNAME = S.DBNAME
                        INNER JOIN dbo.BASE_HFit_TrackerCollectionSource AS TC
                            ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                           AND TC.SVR = TT.SVR
                           AND TC.DBNAME = TT.DBNAME
                        LEFT OUTER JOIN dbo.BASE_HFit_Tracker AS T
                            ON T.AggregateTableName = 'HFit_TrackerMedicalCarePlan'
                           AND T.SVR = TT.SVR
                           AND T.DBNAME = TT.DBNAME;

    --left outer join BASE_HFit_LKP_TrackerVendor as VENDOR ON TT.DBNAME= VENDOR.DBNAME and TT.SVR= VENDOR.SVR
    END;
GO
--set rowcount 5 ;
EXEC PrintImmediate 'Processing FACT_HFit_TrackerRegularMeals';
EXEC PrintImmediate 'Rows: ';
EXEC proc_QuickRowCount BASE_HFit_TrackerRegularMeals;
IF NOT EXISTS (SELECT
                      name
                      FROM sys.tables
                      WHERE name = 'FACT_HFit_TrackerRegularMeals') 
    BEGIN
        EXEC PrintImmediate '*** Loading Records: FACT_HFit_TrackerRegularMeals';
        SELECT
               'HFit_TrackerRegularMeals' AS TrackerNameAggregateTable
             , TT.ItemID
             , CAST (EventDate AS DATETIME) AS EventDate
             , TT.IsProfessionallyCollected
             , TT.TrackerCollectionSourceID
             , Notes
             , TT.UserID
             , CollectionSourceName_Internal
             , CollectionSourceName_External
             , 'MISSING' AS EventName
             , 'Occurs' AS UOM
             , 'Units' AS KEY1
             , CAST ( Units AS FLOAT) AS VAL1
             , 'NA' AS KEY2
             , NULL AS VAL2
             , 'NA' AS KEY3
             , NULL AS VAL3
             , 'NA' AS KEY4
             , NULL AS VAL4
             , 'NA' AS KEY5
             , NULL AS VAL5
             , 'NA' AS KEY6
             , NULL AS VAL6
             , 'NA' AS KEY7
             , NULL AS VAL7
             , 'NA' AS KEY8
             , NULL AS VAL8
             , 'NA' AS KEY9
             , NULL AS VAL9
             , 'NA' AS KEY10
             , NULL AS VAL10
             , TT.ItemCreatedBy
             , CAST (TT.ItemCreatedWhen AS DATETIME) AS ItemCreatedWhen
             , TT.ItemModifiedBy
             , CAST (TT.ItemModifiedWhen AS DATETIME) AS ItemModifiedWhen
             , NULL AS IsProcessedForHa
             , 'NA' AS TXTKEY1
             , NULL AS TXTVAL1
             , 'NA' AS TXTKEY2
             , NULL AS TXTVAL2
             , 'NA' AS TXTKEY3
             , NULL AS TXTVAL3
             , NULL AS ItemOrder
             , NULL AS ItemGuid
             , C.UserGuid
             , PP.MPI
             , PP.ClientCode
             , S.SiteGUID
             , ACCT.AccountID
             , ACCT.AccountCD
             , T.IsAvailable
             , T.IsCustom
             , T.UniqueName
             , T.UniqueName AS ColDesc
             , NULL AS VendorID	--VENDOR.ItemID as VendorID
             ,
               NULL AS VendorName --VENDOR.VendorName
             , TT.LastModifiedDate
             , TT.SVR
             , TT.DBNAME
        INTO
             FACT_HFit_TrackerRegularMeals
               FROM dbo.BASE_HFit_TrackerRegularMeals AS TT
                        INNER JOIN dbo.BASE_CMS_User AS C
                            ON C.UserID = TT.UserID
                           AND C.SVR = TT.SVR
                           AND C.DBNAME = TT.DBNAME
                        INNER JOIN dbo.BASE_HFit_ppteligibility AS PP
                            ON TT.UserID = PP.userID
                           AND TT.SVR = PP.SVR
                           AND TT.DBNAME = PP.DBNAME
                        INNER JOIN dbo.BASE_HFit_Account AS ACCT
                            ON PP.ClientCode = ACCT.AccountCD
                           AND PP.SVR = ACCT.SVR
                           AND PP.DBNAME = ACCT.DBNAME
                        INNER JOIN dbo.BASE_CMS_Site AS S
                            ON ACCT.SiteID = S.SiteID
                           AND ACCT.SVR = S.SVR
                           AND ACCT.DBNAME = S.DBNAME
                        INNER JOIN dbo.BASE_HFit_TrackerCollectionSource AS TC
                            ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                           AND TC.SVR = TT.SVR
                           AND TC.DBNAME = TT.DBNAME
                        LEFT OUTER JOIN dbo.BASE_HFit_Tracker AS T
                            ON T.AggregateTableName = 'HFit_TrackerRegularMeals'
                           AND T.SVR = TT.SVR
                           AND T.DBNAME = TT.DBNAME;

    --left outer join BASE_HFit_LKP_TrackerVendor as VENDOR ON TT.DBNAME= VENDOR.DBNAME and TT.SVR= VENDOR.SVR
    END;
GO
--set rowcount 5 ;
EXEC PrintImmediate 'Processing FACT_HFit_TrackerRestingHeartRate';
EXEC PrintImmediate 'Rows: ';
EXEC proc_QuickRowCount BASE_HFit_TrackerRestingHeartRate;
IF NOT EXISTS (SELECT
                      name
                      FROM sys.tables
                      WHERE name = 'FACT_HFit_TrackerRestingHeartRate') 
    BEGIN
        EXEC PrintImmediate '*** Loading Records: FACT_HFit_TrackerRestingHeartRate';
        SELECT
               'HFit_TrackerRestingHeartRate' AS TrackerNameAggregateTable
             , TT.ItemID
             , CAST (EventDate AS DATETIME) AS EventDate
             , TT.IsProfessionallyCollected
             , TT.TrackerCollectionSourceID
             , Notes
             , TT.UserID
             , CollectionSourceName_Internal
             , CollectionSourceName_External
             , 'MISSING' AS EventName
             , 'BPM' AS UOM
             , 'HeartRate' AS KEY1
             , CAST ( HeartRate AS FLOAT) AS VAL1
             , 'NA' AS KEY2
             , NULL AS VAL2
             , 'NA' AS KEY3
             , NULL AS VAL3
             , 'NA' AS KEY4
             , NULL AS VAL4
             , 'NA' AS KEY5
             , NULL AS VAL5
             , 'NA' AS KEY6
             , NULL AS VAL6
             , 'NA' AS KEY7
             , NULL AS VAL7
             , 'NA' AS KEY8
             , NULL AS VAL8
             , 'NA' AS KEY9
             , NULL AS VAL9
             , 'NA' AS KEY10
             , NULL AS VAL10
             , TT.ItemCreatedBy
             , CAST (TT.ItemCreatedWhen AS DATETIME) AS ItemCreatedWhen
             , TT.ItemModifiedBy
             , CAST (TT.ItemModifiedWhen AS DATETIME) AS ItemModifiedWhen
             , NULL AS IsProcessedForHa
             , 'NA' AS TXTKEY1
             , NULL AS TXTVAL1
             , 'NA' AS TXTKEY2
             , NULL AS TXTVAL2
             , 'NA' AS TXTKEY3
             , NULL AS TXTVAL3
             , NULL AS ItemOrder
             , NULL AS ItemGuid
             , C.UserGuid
             , PP.MPI
             , PP.ClientCode
             , S.SiteGUID
             , ACCT.AccountID
             , ACCT.AccountCD
             , T.IsAvailable
             , T.IsCustom
             , T.UniqueName
             , T.UniqueName AS ColDesc
             , VENDOR.ItemID AS VendorID
             , VENDOR.VendorName
             , TT.LastModifiedDate
             , TT.SVR
             , TT.DBNAME
        INTO
             FACT_HFit_TrackerRestingHeartRate
               FROM dbo.BASE_HFit_TrackerRestingHeartRate AS TT
                        INNER JOIN dbo.BASE_CMS_User AS C
                            ON C.UserID = TT.UserID
                           AND C.SVR = TT.SVR
                           AND C.DBNAME = TT.DBNAME
                        INNER JOIN dbo.BASE_HFit_ppteligibility AS PP
                            ON TT.UserID = PP.userID
                           AND TT.SVR = PP.SVR
                           AND TT.DBNAME = PP.DBNAME
                        INNER JOIN dbo.BASE_HFit_Account AS ACCT
                            ON PP.ClientCode = ACCT.AccountCD
                           AND PP.SVR = ACCT.SVR
                           AND PP.DBNAME = ACCT.DBNAME
                        INNER JOIN dbo.BASE_CMS_Site AS S
                            ON ACCT.SiteID = S.SiteID
                           AND ACCT.SVR = S.SVR
                           AND ACCT.DBNAME = S.DBNAME
                        INNER JOIN dbo.BASE_HFit_TrackerCollectionSource AS TC
                            ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                           AND TC.SVR = TT.SVR
                           AND TC.DBNAME = TT.DBNAME
                        LEFT OUTER JOIN dbo.BASE_HFit_Tracker AS T
                            ON T.AggregateTableName = 'HFit_TrackerRestingHeartRate'
                           AND T.SVR = TT.SVR
                           AND T.DBNAME = TT.DBNAME
                        LEFT OUTER JOIN BASE_HFit_LKP_TrackerVendor AS VENDOR
                            ON TT.DBNAME = VENDOR.DBNAME
                           AND TT.SVR = VENDOR.SVR
                           AND TT.VendorID = Vendor.ItemID;
    END;
GO
--set rowcount 5 ;
EXEC PrintImmediate 'Processing FACT_HFit_TrackerShots';
EXEC PrintImmediate 'Rows: ';
EXEC proc_QuickRowCount BASE_HFit_TrackerShots;
IF NOT EXISTS (SELECT
                      name
                      FROM sys.tables
                      WHERE name = 'FACT_HFit_TrackerShots') 
    BEGIN
        EXEC PrintImmediate '*** Loading Records: FACT_HFit_TrackerShots';
        SELECT
               'HFit_TrackerShots' AS TrackerNameAggregateTable
             , TT.ItemID
             , CAST (EventDate AS DATETIME) AS EventDate
             , TT.IsProfessionallyCollected
             , TT.TrackerCollectionSourceID
             , Notes
             , TT.UserID
             , CollectionSourceName_Internal
             , CollectionSourceName_External
             , 'MISSING' AS EventName
             , 'Y/N' AS UOM
             , 'FluShot' AS KEY1
             , CAST ( FluShot AS FLOAT) AS VAL1
             , 'PneumoniaShot' AS KEY2
             , CAST ( PneumoniaShot AS FLOAT) AS VAL2
             , 'NA' AS KEY3
             , NULL AS VAL3
             , 'NA' AS KEY4
             , NULL AS VAL4
             , 'NA' AS KEY5
             , NULL AS VAL5
             , 'NA' AS KEY6
             , NULL AS VAL6
             , 'NA' AS KEY7
             , NULL AS VAL7
             , 'NA' AS KEY8
             , NULL AS VAL8
             , 'NA' AS KEY9
             , NULL AS VAL9
             , 'NA' AS KEY10
             , NULL AS VAL10
             , TT.ItemCreatedBy
             , CAST (TT.ItemCreatedWhen AS DATETIME) AS ItemCreatedWhen
             , TT.ItemModifiedBy
             , CAST (TT.ItemModifiedWhen AS DATETIME) AS ItemModifiedWhen
             , NULL AS IsProcessedForHa
             , 'NA' AS TXTKEY1
             , NULL AS TXTVAL1
             , 'NA' AS TXTKEY2
             , NULL AS TXTVAL2
             , 'NA' AS TXTKEY3
             , NULL AS TXTVAL3
             , TT.ItemOrder
             , TT.ItemGuid
             , C.UserGuid
             , PP.MPI
             , PP.ClientCode
             , S.SiteGUID
             , ACCT.AccountID
             , ACCT.AccountCD
             , T.IsAvailable
             , T.IsCustom
             , T.UniqueName
             , T.UniqueName AS ColDesc
             , VENDOR.ItemID AS VendorID
             , VENDOR.VendorName
             , TT.LastModifiedDate
             , TT.SVR
             , TT.DBNAME
        INTO
             FACT_HFit_TrackerShots
               FROM dbo.BASE_HFit_TrackerShots AS TT
                        INNER JOIN dbo.BASE_CMS_User AS C
                            ON C.UserID = TT.UserID
                           AND C.SVR = TT.SVR
                           AND C.DBNAME = TT.DBNAME
                        INNER JOIN dbo.BASE_HFit_ppteligibility AS PP
                            ON TT.UserID = PP.userID
                           AND TT.SVR = PP.SVR
                           AND TT.DBNAME = PP.DBNAME
                        INNER JOIN dbo.BASE_HFit_Account AS ACCT
                            ON PP.ClientCode = ACCT.AccountCD
                           AND PP.SVR = ACCT.SVR
                           AND PP.DBNAME = ACCT.DBNAME
                        INNER JOIN dbo.BASE_CMS_Site AS S
                            ON ACCT.SiteID = S.SiteID
                           AND ACCT.SVR = S.SVR
                           AND ACCT.DBNAME = S.DBNAME
                        INNER JOIN dbo.BASE_HFit_TrackerCollectionSource AS TC
                            ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                           AND TC.SVR = TT.SVR
                           AND TC.DBNAME = TT.DBNAME
                        LEFT OUTER JOIN dbo.BASE_HFit_Tracker AS T
                            ON T.AggregateTableName = 'HFit_TrackerShots'
                           AND T.SVR = TT.SVR
                           AND T.DBNAME = TT.DBNAME
                        LEFT OUTER JOIN BASE_HFit_LKP_TrackerVendor AS VENDOR
                            ON TT.DBNAME = VENDOR.DBNAME
                           AND TT.SVR = VENDOR.SVR
                           AND TT.VendorID = Vendor.ItemID;
    END;
GO
--set rowcount 5 ;
EXEC PrintImmediate 'Processing FACT_HFit_TrackerSitLess';
EXEC PrintImmediate 'Rows: ';
EXEC proc_QuickRowCount BASE_HFit_TrackerSitLess;
IF NOT EXISTS (SELECT
                      name
                      FROM sys.tables
                      WHERE name = 'FACT_HFit_TrackerSitLess') 
    BEGIN
        EXEC PrintImmediate '*** Loading Records: FACT_HFit_TrackerSitLess';
        SELECT
               'HFit_TrackerSitLess' AS TrackerNameAggregateTable
             , TT.ItemID
             , CAST (EventDate AS DATETIME) AS EventDate
             , TT.IsProfessionallyCollected
             , TT.TrackerCollectionSourceID
             , Notes
             , TT.UserID
             , CollectionSourceName_Internal
             , CollectionSourceName_External
             , 'MISSING' AS EventName
             , 'Occurs' AS UOM
             , 'Times' AS KEY1
             , CAST ( Times AS FLOAT) AS VAL1
             , 'NA' AS KEY2
             , NULL AS VAL2
             , 'NA' AS KEY3
             , NULL AS VAL3
             , 'NA' AS KEY4
             , NULL AS VAL4
             , 'NA' AS KEY5
             , NULL AS VAL5
             , 'NA' AS KEY6
             , NULL AS VAL6
             , 'NA' AS KEY7
             , NULL AS VAL7
             , 'NA' AS KEY8
             , NULL AS VAL8
             , 'NA' AS KEY9
             , NULL AS VAL9
             , 'NA' AS KEY10
             , NULL AS VAL10
             , TT.ItemCreatedBy
             , CAST (TT.ItemCreatedWhen AS DATETIME) AS ItemCreatedWhen
             , TT.ItemModifiedBy
             , CAST (TT.ItemModifiedWhen AS DATETIME) AS ItemModifiedWhen
             , NULL AS IsProcessedForHa
             , 'NA' AS TXTKEY1
             , NULL AS TXTVAL1
             , 'NA' AS TXTKEY2
             , NULL AS TXTVAL2
             , 'NA' AS TXTKEY3
             , NULL AS TXTVAL3
             , NULL AS ItemOrder
             , NULL AS ItemGuid
             , C.UserGuid
             , PP.MPI
             , PP.ClientCode
             , S.SiteGUID
             , ACCT.AccountID
             , ACCT.AccountCD
             , T.IsAvailable
             , T.IsCustom
             , T.UniqueName
             , T.UniqueName AS ColDesc
             , NULL AS VendorID	--VENDOR.ItemID as VendorID
             ,
               NULL AS VendorName --VENDOR.VendorName
             , TT.LastModifiedDate
             , TT.SVR
             , TT.DBNAME
        INTO
             FACT_HFit_TrackerSitLess
               FROM dbo.BASE_HFit_TrackerSitLess AS TT
                        INNER JOIN dbo.BASE_CMS_User AS C
                            ON C.UserID = TT.UserID
                           AND C.SVR = TT.SVR
                           AND C.DBNAME = TT.DBNAME
                        INNER JOIN dbo.BASE_HFit_ppteligibility AS PP
                            ON TT.UserID = PP.userID
                           AND TT.SVR = PP.SVR
                           AND TT.DBNAME = PP.DBNAME
                        INNER JOIN dbo.BASE_HFit_Account AS ACCT
                            ON PP.ClientCode = ACCT.AccountCD
                           AND PP.SVR = ACCT.SVR
                           AND PP.DBNAME = ACCT.DBNAME
                        INNER JOIN dbo.BASE_CMS_Site AS S
                            ON ACCT.SiteID = S.SiteID
                           AND ACCT.SVR = S.SVR
                           AND ACCT.DBNAME = S.DBNAME
                        INNER JOIN dbo.BASE_HFit_TrackerCollectionSource AS TC
                            ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                           AND TC.SVR = TT.SVR
                           AND TC.DBNAME = TT.DBNAME
                        LEFT OUTER JOIN dbo.BASE_HFit_Tracker AS T
                            ON T.AggregateTableName = 'HFit_TrackerSitLess'
                           AND T.SVR = TT.SVR
                           AND T.DBNAME = TT.DBNAME;

    --left outer join BASE_HFit_LKP_TrackerVendor as VENDOR ON TT.DBNAME= VENDOR.DBNAME and TT.SVR= VENDOR.SVR
    END;
GO
--set rowcount 5 ;
EXEC PrintImmediate 'Processing FACT_HFit_TrackerSleepPlan';
EXEC PrintImmediate 'Rows: ';
EXEC proc_QuickRowCount BASE_HFit_TrackerSleepPlan;
IF NOT EXISTS (SELECT
                      name
                      FROM sys.tables
                      WHERE name = 'FACT_HFit_TrackerSleepPlan') 
    BEGIN
        EXEC PrintImmediate '*** Loading Records: FACT_HFit_TrackerSleepPlan';
        SELECT
               'HFit_TrackerSleepPlan' AS TrackerNameAggregateTable
             , TT.ItemID
             , CAST (EventDate AS DATETIME) AS EventDate
             , TT.IsProfessionallyCollected
             , TT.TrackerCollectionSourceID
             , Notes
             , TT.UserID
             , CollectionSourceName_Internal
             , CollectionSourceName_External
             , 'MISSING' AS EventName
             , 'HR' AS UOM
             , 'DidFollow' AS KEY1
             , CAST ( DidFollow AS FLOAT) AS VAL1
             , 'HoursSlept' AS KEY2
             , HoursSlept AS VAL2
             , 'NA' AS KEY3
             , NULL AS VAL3
             , 'NA' AS KEY4
             , NULL AS VAL4
             , 'NA' AS KEY5
             , NULL AS VAL5
             , 'NA' AS KEY6
             , NULL AS VAL6
             , 'NA' AS KEY7
             , NULL AS VAL7
             , 'NA' AS KEY8
             , NULL AS VAL8
             , 'NA' AS KEY9
             , NULL AS VAL9
             , 'NA' AS KEY10
             , NULL AS VAL10
             , TT.ItemCreatedBy
             , CAST (TT.ItemCreatedWhen AS DATETIME) AS ItemCreatedWhen
             , TT.ItemModifiedBy
             , CAST (TT.ItemModifiedWhen AS DATETIME) AS ItemModifiedWhen
             , NULL AS IsProcessedForHa
             , 'Techniques' AS TXTKEY1
             , Techniques AS TXTVAL1
             , 'NA' AS TXTKEY2
             , NULL AS TXTVAL2
             , 'NA' AS TXTKEY3
             , NULL AS TXTVAL3
             , NULL AS ItemOrder
             , NULL AS ItemGuid
             , C.UserGuid
             , PP.MPI
             , PP.ClientCode
             , S.SiteGUID
             , ACCT.AccountID
             , ACCT.AccountCD
             , T.IsAvailable
             , T.IsCustom
             , T.UniqueName
             , T.UniqueName AS ColDesc
             , NULL AS VendorID	--VENDOR.ItemID as VendorID
             ,
               NULL AS VendorName --VENDOR.VendorName
             , TT.LastModifiedDate
             , TT.SVR
             , TT.DBNAME
        INTO
             FACT_HFit_TrackerSleepPlan
               FROM dbo.BASE_HFit_TrackerSleepPlan AS TT
                        INNER JOIN dbo.BASE_CMS_User AS C
                            ON C.UserID = TT.UserID
                           AND C.SVR = TT.SVR
                           AND C.DBNAME = TT.DBNAME
                        INNER JOIN dbo.BASE_HFit_ppteligibility AS PP
                            ON TT.UserID = PP.userID
                           AND TT.SVR = PP.SVR
                           AND TT.DBNAME = PP.DBNAME
                        INNER JOIN dbo.BASE_HFit_Account AS ACCT
                            ON PP.ClientCode = ACCT.AccountCD
                           AND PP.SVR = ACCT.SVR
                           AND PP.DBNAME = ACCT.DBNAME
                        INNER JOIN dbo.BASE_CMS_Site AS S
                            ON ACCT.SiteID = S.SiteID
                           AND ACCT.SVR = S.SVR
                           AND ACCT.DBNAME = S.DBNAME
                        INNER JOIN dbo.BASE_HFit_TrackerCollectionSource AS TC
                            ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                           AND TC.SVR = TT.SVR
                           AND TC.DBNAME = TT.DBNAME
                        LEFT OUTER JOIN dbo.BASE_HFit_Tracker AS T
                            ON T.AggregateTableName = 'HFit_TrackerSleepPlan'
                           AND T.SVR = TT.SVR
                           AND T.DBNAME = TT.DBNAME;

    --left outer join BASE_HFit_LKP_TrackerVendor as VENDOR ON TT.DBNAME= VENDOR.DBNAME and TT.SVR= VENDOR.SVR
    END;
GO
--set rowcount 5 ;
EXEC PrintImmediate 'Processing FACT_HFit_TrackerStrength';
EXEC PrintImmediate 'Rows: ';
EXEC proc_QuickRowCount BASE_HFit_TrackerStrength;
IF NOT EXISTS (SELECT
                      name
                      FROM sys.tables
                      WHERE name = 'FACT_HFit_TrackerStrength') 
    BEGIN
        EXEC PrintImmediate '*** Loading Records: FACT_HFit_TrackerStrength';
        SELECT
               'HFit_TrackerStrength' AS TrackerNameAggregateTable
             , TT.ItemID
             , CAST (EventDate AS DATETIME) AS EventDate
             , TT.IsProfessionallyCollected
             , TT.TrackerCollectionSourceID
             , Notes
             , TT.UserID
             , CollectionSourceName_Internal
             , CollectionSourceName_External
             , 'MISSING' AS EventName
             , 'Y/N' AS UOM
             , 'HasTrained' AS KEY1
             , CAST ( HasTrained AS FLOAT) AS VAL1
             , 'NA' AS KEY2
             , NULL AS VAL2
             , 'NA' AS KEY3
             , NULL AS VAL3
             , 'NA' AS KEY4
             , NULL AS VAL4
             , 'NA' AS KEY5
             , NULL AS VAL5
             , 'NA' AS KEY6
             , NULL AS VAL6
             , 'NA' AS KEY7
             , NULL AS VAL7
             , 'NA' AS KEY8
             , NULL AS VAL8
             , 'NA' AS KEY9
             , NULL AS VAL9
             , 'NA' AS KEY10
             , NULL AS VAL10
             , TT.ItemCreatedBy
             , CAST (TT.ItemCreatedWhen AS DATETIME) AS ItemCreatedWhen
             , TT.ItemModifiedBy
             , CAST (TT.ItemModifiedWhen AS DATETIME) AS ItemModifiedWhen
             , NULL AS IsProcessedForHa
             , 'Activity' AS TXTKEY1
             , Activity AS TXTVAL1
             , 'NA' AS TXTKEY2
             , NULL AS TXTVAL2
             , 'NA' AS TXTKEY3
             , NULL AS TXTVAL3
             , NULL AS ItemOrder
             , NULL AS ItemGuid
             , C.UserGuid
             , PP.MPI
             , PP.ClientCode
             , S.SiteGUID
             , ACCT.AccountID
             , ACCT.AccountCD
             , T.IsAvailable
             , T.IsCustom
             , T.UniqueName
             , T.UniqueName AS ColDesc
             , NULL AS VendorID	--VENDOR.ItemID as VendorID
             ,
               NULL AS VendorName --VENDOR.VendorName
             , TT.LastModifiedDate
             , TT.SVR
             , TT.DBNAME
        INTO
             FACT_HFit_TrackerStrength
               FROM dbo.BASE_HFit_TrackerStrength AS TT
                        INNER JOIN dbo.BASE_CMS_User AS C
                            ON C.UserID = TT.UserID
                           AND C.SVR = TT.SVR
                           AND C.DBNAME = TT.DBNAME
                        INNER JOIN dbo.BASE_HFit_ppteligibility AS PP
                            ON TT.UserID = PP.userID
                           AND TT.SVR = PP.SVR
                           AND TT.DBNAME = PP.DBNAME
                        INNER JOIN dbo.BASE_HFit_Account AS ACCT
                            ON PP.ClientCode = ACCT.AccountCD
                           AND PP.SVR = ACCT.SVR
                           AND PP.DBNAME = ACCT.DBNAME
                        INNER JOIN dbo.BASE_CMS_Site AS S
                            ON ACCT.SiteID = S.SiteID
                           AND ACCT.SVR = S.SVR
                           AND ACCT.DBNAME = S.DBNAME
                        INNER JOIN dbo.BASE_HFit_TrackerCollectionSource AS TC
                            ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                           AND TC.SVR = TT.SVR
                           AND TC.DBNAME = TT.DBNAME
                        LEFT OUTER JOIN dbo.BASE_HFit_Tracker AS T
                            ON T.AggregateTableName = 'HFit_TrackerStrength'
                           AND T.SVR = TT.SVR
                           AND T.DBNAME = TT.DBNAME;

    --left outer join BASE_HFit_LKP_TrackerVendor as VENDOR ON TT.DBNAME= VENDOR.DBNAME and TT.SVR= VENDOR.SVR
    END;
GO
--set rowcount 5 ;
EXEC PrintImmediate 'Processing FACT_HFit_TrackerStress';
EXEC PrintImmediate 'Rows: ';
EXEC proc_QuickRowCount BASE_HFit_TrackerStress;
IF NOT EXISTS (SELECT
                      name
                      FROM sys.tables
                      WHERE name = 'FACT_HFit_TrackerStress') 
    BEGIN
        EXEC PrintImmediate '*** Loading Records: FACT_HFit_TrackerStress';
        SELECT
               'HFit_TrackerStress' AS TrackerNameAggregateTable
             , TT.ItemID
             , CAST (EventDate AS DATETIME) AS EventDate
             , TT.IsProfessionallyCollected
             , TT.TrackerCollectionSourceID
             , Notes
             , TT.UserID
             , CollectionSourceName_Internal
             , CollectionSourceName_External
             , 'MISSING' AS EventName
             , 'gradient' AS UOM
             , 'Intensity' AS KEY1
             , CAST ( Intensity AS FLOAT) AS VAL1
             , 'NA' AS KEY2
             , NULL AS VAL2
             , 'NA' AS KEY3
             , NULL AS VAL3
             , 'NA' AS KEY4
             , NULL AS VAL4
             , 'NA' AS KEY5
             , NULL AS VAL5
             , 'NA' AS KEY6
             , NULL AS VAL6
             , 'NA' AS KEY7
             , NULL AS VAL7
             , 'NA' AS KEY8
             , NULL AS VAL8
             , 'NA' AS KEY9
             , NULL AS VAL9
             , 'NA' AS KEY10
             , NULL AS VAL10
             , TT.ItemCreatedBy
             , CAST (TT.ItemCreatedWhen AS DATETIME) AS ItemCreatedWhen
             , TT.ItemModifiedBy
             , CAST (TT.ItemModifiedWhen AS DATETIME) AS ItemModifiedWhen
             , NULL AS IsProcessedForHa
             , 'Awareness' AS TXTKEY1
             , Awareness AS TXTVAL1
             , 'NA' AS TXTKEY2
             , NULL AS TXTVAL2
             , 'NA' AS TXTKEY3
             , NULL AS TXTVAL3
             , NULL AS ItemOrder
             , NULL AS ItemGuid
             , C.UserGuid
             , PP.MPI
             , PP.ClientCode
             , S.SiteGUID
             , ACCT.AccountID
             , ACCT.AccountCD
             , T.IsAvailable
             , T.IsCustom
             , T.UniqueName
             , T.UniqueName AS ColDesc
             , NULL AS VendorID	--VENDOR.ItemID as VendorID
             ,
               NULL AS VendorName --VENDOR.VendorName
             , TT.LastModifiedDate
             , TT.SVR
             , TT.DBNAME
        INTO
             FACT_HFit_TrackerStress
               FROM dbo.BASE_HFit_TrackerStress AS TT
                        INNER JOIN dbo.BASE_CMS_User AS C
                            ON C.UserID = TT.UserID
                           AND C.SVR = TT.SVR
                           AND C.DBNAME = TT.DBNAME
                        INNER JOIN dbo.BASE_HFit_ppteligibility AS PP
                            ON TT.UserID = PP.userID
                           AND TT.SVR = PP.SVR
                           AND TT.DBNAME = PP.DBNAME
                        INNER JOIN dbo.BASE_HFit_Account AS ACCT
                            ON PP.ClientCode = ACCT.AccountCD
                           AND PP.SVR = ACCT.SVR
                           AND PP.DBNAME = ACCT.DBNAME
                        INNER JOIN dbo.BASE_CMS_Site AS S
                            ON ACCT.SiteID = S.SiteID
                           AND ACCT.SVR = S.SVR
                           AND ACCT.DBNAME = S.DBNAME
                        INNER JOIN dbo.BASE_HFit_TrackerCollectionSource AS TC
                            ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                           AND TC.SVR = TT.SVR
                           AND TC.DBNAME = TT.DBNAME
                        LEFT OUTER JOIN dbo.BASE_HFit_Tracker AS T
                            ON T.AggregateTableName = 'HFit_TrackerStress'
                           AND T.SVR = TT.SVR
                           AND T.DBNAME = TT.DBNAME;

    --left outer join BASE_HFit_LKP_TrackerVendor as VENDOR ON TT.DBNAME= VENDOR.DBNAME and TT.SVR= VENDOR.SVR
    END;
GO
--set rowcount 5 ;
EXEC PrintImmediate 'Processing FACT_HFit_TrackerStressManagement';
EXEC PrintImmediate 'Rows: ';
EXEC proc_QuickRowCount BASE_HFit_TrackerStressManagement;
IF NOT EXISTS (SELECT
                      name
                      FROM sys.tables
                      WHERE name = 'FACT_HFit_TrackerStressManagement') 
    BEGIN
        EXEC PrintImmediate '*** Loading Records: FACT_HFit_TrackerStressManagement';
        SELECT
               'HFit_TrackerStressManagement' AS TrackerNameAggregateTable
             , TT.ItemID
             , CAST (EventDate AS DATETIME) AS EventDate
             , TT.IsProfessionallyCollected
             , TT.TrackerCollectionSourceID
             , Notes
             , TT.UserID
             , CollectionSourceName_Internal
             , CollectionSourceName_External
             , 'MISSING' AS EventName
             , 'gradient' AS UOM
             , 'HasPracticed' AS KEY1
             , CAST ( HasPracticed AS FLOAT) AS VAL1
             , 'Effectiveness' AS KEY2
             , CAST ( Effectiveness AS FLOAT) AS VAL2
             , 'NA' AS KEY3
             , NULL AS VAL3
             , 'NA' AS KEY4
             , NULL AS VAL4
             , 'NA' AS KEY5
             , NULL AS VAL5
             , 'NA' AS KEY6
             , NULL AS VAL6
             , 'NA' AS KEY7
             , NULL AS VAL7
             , 'NA' AS KEY8
             , NULL AS VAL8
             , 'NA' AS KEY9
             , NULL AS VAL9
             , 'NA' AS KEY10
             , NULL AS VAL10
             , TT.ItemCreatedBy
             , CAST (TT.ItemCreatedWhen AS DATETIME) AS ItemCreatedWhen
             , TT.ItemModifiedBy
             , CAST (TT.ItemModifiedWhen AS DATETIME) AS ItemModifiedWhen
             , NULL AS IsProcessedForHa
             , 'Activity' AS TXTKEY1
             , Activity AS TXTVAL1
             , 'NA' AS TXTKEY2
             , NULL AS TXTVAL2
             , 'NA' AS TXTKEY3
             , NULL AS TXTVAL3
             , NULL AS ItemOrder
             , NULL AS ItemGuid
             , C.UserGuid
             , PP.MPI
             , PP.ClientCode
             , S.SiteGUID
             , ACCT.AccountID
             , ACCT.AccountCD
             , T.IsAvailable
             , T.IsCustom
             , T.UniqueName
             , T.UniqueName AS ColDesc
             , NULL AS VendorID	--VENDOR.ItemID as VendorID
             ,
               NULL AS VendorName --VENDOR.VendorName
             , TT.LastModifiedDate
             , TT.SVR
             , TT.DBNAME
        INTO
             FACT_HFit_TrackerStressManagement
               FROM dbo.BASE_HFit_TrackerStressManagement AS TT
                        INNER JOIN dbo.BASE_CMS_User AS C
                            ON C.UserID = TT.UserID
                           AND C.SVR = TT.SVR
                           AND C.DBNAME = TT.DBNAME
                        INNER JOIN dbo.BASE_HFit_ppteligibility AS PP
                            ON TT.UserID = PP.userID
                           AND TT.SVR = PP.SVR
                           AND TT.DBNAME = PP.DBNAME
                        INNER JOIN dbo.BASE_HFit_Account AS ACCT
                            ON PP.ClientCode = ACCT.AccountCD
                           AND PP.SVR = ACCT.SVR
                           AND PP.DBNAME = ACCT.DBNAME
                        INNER JOIN dbo.BASE_CMS_Site AS S
                            ON ACCT.SiteID = S.SiteID
                           AND ACCT.SVR = S.SVR
                           AND ACCT.DBNAME = S.DBNAME
                        INNER JOIN dbo.BASE_HFit_TrackerCollectionSource AS TC
                            ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                           AND TC.SVR = TT.SVR
                           AND TC.DBNAME = TT.DBNAME
                        LEFT OUTER JOIN dbo.BASE_HFit_Tracker AS T
                            ON T.AggregateTableName = 'HFit_TrackerStressManagement'
                           AND T.SVR = TT.SVR
                           AND T.DBNAME = TT.DBNAME;

    --left outer join BASE_HFit_LKP_TrackerVendor as VENDOR ON TT.DBNAME= VENDOR.DBNAME and TT.SVR= VENDOR.SVR
    END;
GO
--set rowcount 5 ;
EXEC PrintImmediate 'Processing FACT_HFit_TrackerSugaryDrinks';
EXEC PrintImmediate 'Rows: ';
EXEC proc_QuickRowCount BASE_HFit_TrackerSugaryDrinks;
IF NOT EXISTS (SELECT
                      name
                      FROM sys.tables
                      WHERE name = 'FACT_HFit_TrackerSugaryDrinks') 
    BEGIN
        EXEC PrintImmediate '*** Loading Records: FACT_HFit_TrackerSugaryDrinks';
        SELECT
               'HFit_TrackerSugaryDrinks' AS TrackerNameAggregateTable
             , TT.ItemID
             , CAST (EventDate AS DATETIME) AS EventDate
             , TT.IsProfessionallyCollected
             , TT.TrackerCollectionSourceID
             , Notes
             , TT.UserID
             , CollectionSourceName_Internal
             , CollectionSourceName_External
             , 'MISSING' AS EventName
             , 'OZ' AS UOM
             , 'Ounces' AS KEY1
             , CAST ( Ounces AS FLOAT) AS VAL1
             , 'NA' AS KEY2
             , NULL AS VAL2
             , 'NA' AS KEY3
             , NULL AS VAL3
             , 'NA' AS KEY4
             , NULL AS VAL4
             , 'NA' AS KEY5
             , NULL AS VAL5
             , 'NA' AS KEY6
             , NULL AS VAL6
             , 'NA' AS KEY7
             , NULL AS VAL7
             , 'NA' AS KEY8
             , NULL AS VAL8
             , 'NA' AS KEY9
             , NULL AS VAL9
             , 'NA' AS KEY10
             , NULL AS VAL10
             , TT.ItemCreatedBy
             , CAST (TT.ItemCreatedWhen AS DATETIME) AS ItemCreatedWhen
             , TT.ItemModifiedBy
             , CAST (TT.ItemModifiedWhen AS DATETIME) AS ItemModifiedWhen
             , NULL AS IsProcessedForHa
             , 'NA' AS TXTKEY1
             , NULL AS TXTVAL1
             , 'NA' AS TXTKEY2
             , NULL AS TXTVAL2
             , 'NA' AS TXTKEY3
             , NULL AS TXTVAL3
             , NULL AS ItemOrder
             , NULL AS ItemGuid
             , C.UserGuid
             , PP.MPI
             , PP.ClientCode
             , S.SiteGUID
             , ACCT.AccountID
             , ACCT.AccountCD
             , T.IsAvailable
             , T.IsCustom
             , T.UniqueName
             , T.UniqueName AS ColDesc
             , NULL AS VendorID	--VENDOR.ItemID as VendorID
             ,
               NULL AS VendorName --VENDOR.VendorName
             , TT.LastModifiedDate
             , TT.SVR
             , TT.DBNAME
        INTO
             FACT_HFit_TrackerSugaryDrinks
               FROM dbo.BASE_HFit_TrackerSugaryDrinks AS TT
                        INNER JOIN dbo.BASE_CMS_User AS C
                            ON C.UserID = TT.UserID
                           AND C.SVR = TT.SVR
                           AND C.DBNAME = TT.DBNAME
                        INNER JOIN dbo.BASE_HFit_ppteligibility AS PP
                            ON TT.UserID = PP.userID
                           AND TT.SVR = PP.SVR
                           AND TT.DBNAME = PP.DBNAME
                        INNER JOIN dbo.BASE_HFit_Account AS ACCT
                            ON PP.ClientCode = ACCT.AccountCD
                           AND PP.SVR = ACCT.SVR
                           AND PP.DBNAME = ACCT.DBNAME
                        INNER JOIN dbo.BASE_CMS_Site AS S
                            ON ACCT.SiteID = S.SiteID
                           AND ACCT.SVR = S.SVR
                           AND ACCT.DBNAME = S.DBNAME
                        INNER JOIN dbo.BASE_HFit_TrackerCollectionSource AS TC
                            ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                           AND TC.SVR = TT.SVR
                           AND TC.DBNAME = TT.DBNAME
                        LEFT OUTER JOIN dbo.BASE_HFit_Tracker AS T
                            ON T.AggregateTableName = 'HFit_TrackerSugaryDrinks'
                           AND T.SVR = TT.SVR
                           AND T.DBNAME = TT.DBNAME;

    --left outer join BASE_HFit_LKP_TrackerVendor as VENDOR ON TT.DBNAME= VENDOR.DBNAME and TT.SVR= VENDOR.SVR
    END;
GO
--set rowcount 5 ;
EXEC PrintImmediate 'Processing FACT_HFit_TrackerSugaryFoods';
EXEC PrintImmediate 'Rows: ';
EXEC proc_QuickRowCount BASE_HFit_TrackerSugaryFoods;
IF NOT EXISTS (SELECT
                      name
                      FROM sys.tables
                      WHERE name = 'FACT_HFit_TrackerSugaryFoods') 
    BEGIN
        EXEC PrintImmediate '*** Loading Records: FACT_HFit_TrackerSugaryFoods';
        SELECT
               'HFit_TrackerSugaryFoods' AS TrackerNameAggregateTable
             , TT.ItemID
             , CAST (EventDate AS DATETIME) AS EventDate
             , TT.IsProfessionallyCollected
             , TT.TrackerCollectionSourceID
             , Notes
             , TT.UserID
             , CollectionSourceName_Internal
             , CollectionSourceName_External
             , 'MISSING' AS EventName
             , 'NA-portion' AS UOM
             , 'Portions' AS KEY1
             , CAST ( Portions AS FLOAT) AS VAL1
             , 'NA' AS KEY2
             , NULL AS VAL2
             , 'NA' AS KEY3
             , NULL AS VAL3
             , 'NA' AS KEY4
             , NULL AS VAL4
             , 'NA' AS KEY5
             , NULL AS VAL5
             , 'NA' AS KEY6
             , NULL AS VAL6
             , 'NA' AS KEY7
             , NULL AS VAL7
             , 'NA' AS KEY8
             , NULL AS VAL8
             , 'NA' AS KEY9
             , NULL AS VAL9
             , 'NA' AS KEY10
             , NULL AS VAL10
             , TT.ItemCreatedBy
             , CAST (TT.ItemCreatedWhen AS DATETIME) AS ItemCreatedWhen
             , TT.ItemModifiedBy
             , CAST (TT.ItemModifiedWhen AS DATETIME) AS ItemModifiedWhen
             , NULL AS IsProcessedForHa
             , 'NA' AS TXTKEY1
             , NULL AS TXTVAL1
             , 'NA' AS TXTKEY2
             , NULL AS TXTVAL2
             , 'NA' AS TXTKEY3
             , NULL AS TXTVAL3
             , NULL AS ItemOrder
             , NULL AS ItemGuid
             , C.UserGuid
             , PP.MPI
             , PP.ClientCode
             , S.SiteGUID
             , ACCT.AccountID
             , ACCT.AccountCD
             , T.IsAvailable
             , T.IsCustom
             , T.UniqueName
             , T.UniqueName AS ColDesc
             , NULL AS VendorID	--VENDOR.ItemID as VendorID
             ,
               NULL AS VendorName --VENDOR.VendorName
             , TT.LastModifiedDate
             , TT.SVR
             , TT.DBNAME
        INTO
             FACT_HFit_TrackerSugaryFoods
               FROM dbo.BASE_HFit_TrackerSugaryFoods AS TT
                        INNER JOIN dbo.BASE_CMS_User AS C
                            ON C.UserID = TT.UserID
                           AND C.SVR = TT.SVR
                           AND C.DBNAME = TT.DBNAME
                        INNER JOIN dbo.BASE_HFit_ppteligibility AS PP
                            ON TT.UserID = PP.userID
                           AND TT.SVR = PP.SVR
                           AND TT.DBNAME = PP.DBNAME
                        INNER JOIN dbo.BASE_HFit_Account AS ACCT
                            ON PP.ClientCode = ACCT.AccountCD
                           AND PP.SVR = ACCT.SVR
                           AND PP.DBNAME = ACCT.DBNAME
                        INNER JOIN dbo.BASE_CMS_Site AS S
                            ON ACCT.SiteID = S.SiteID
                           AND ACCT.SVR = S.SVR
                           AND ACCT.DBNAME = S.DBNAME
                        INNER JOIN dbo.BASE_HFit_TrackerCollectionSource AS TC
                            ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                           AND TC.SVR = TT.SVR
                           AND TC.DBNAME = TT.DBNAME
                        LEFT OUTER JOIN dbo.BASE_HFit_Tracker AS T
                            ON T.AggregateTableName = 'HFit_TrackerSugaryFoods'
                           AND T.SVR = TT.SVR
                           AND T.DBNAME = TT.DBNAME;
    END;
GO
--set rowcount 5 ;
EXEC PrintImmediate 'Processing FACT_HFit_TrackerTests';
EXEC PrintImmediate 'Rows: ';
EXEC proc_QuickRowCount BASE_HFit_TrackerTests;
IF NOT EXISTS (SELECT
                      name
                      FROM sys.tables
                      WHERE name = 'FACT_HFit_TrackerTests') 
    BEGIN
        EXEC PrintImmediate '*** Loading Records: FACT_HFit_TrackerTests';
        SELECT
               'HFit_TrackerTests' AS TrackerNameAggregateTable
             , TT.ItemID
             , CAST (EventDate AS DATETIME) AS EventDate
             , TT.IsProfessionallyCollected
             , TT.TrackerCollectionSourceID
             , Notes
             , TT.UserID
             , CollectionSourceName_Internal
             , CollectionSourceName_External
             , 'MISSING' AS EventName
             , 'NA' AS UOM
             , 'PSATest' AS KEY1
             , CAST ( PSATest AS FLOAT) AS VAL1
             , 'OtherExam' AS KEY1
             , CAST ( OtherExam AS FLOAT) AS VAL2
             , 'TScore' AS KEY3
             , CAST ( TScore AS FLOAT) AS VAL3
             , 'DRA' AS KEY4
             , CAST ( DRA AS FLOAT) AS VAL4
             , 'CotinineTest' AS KEY5
             , CAST ( CotinineTest AS FLOAT) AS VAL5
             , 'ColoCareKit' AS KEY6
             , CAST ( ColoCareKit AS FLOAT) AS VAL6
             , 'CustomTest' AS KEY7
             , CAST ( CustomTest AS FLOAT) AS VAL7
             , 'TSH' AS KEY8
             , CAST ( TSH AS FLOAT) AS VAL8
             , 'NA' AS KEY9
             , NULL AS VAL9
             , 'NA' AS KEY10
             , NULL AS VAL10
             , TT.ItemCreatedBy
             , CAST (TT.ItemCreatedWhen AS DATETIME) AS ItemCreatedWhen
             , TT.ItemModifiedBy
             , CAST (TT.ItemModifiedWhen AS DATETIME) AS ItemModifiedWhen
             , NULL AS IsProcessedForHa
             , 'CustomDesc' AS TXTKEY1
             , CustomDesc AS TXTVAL1
             , 'NA' AS TXTKEY2
             , NULL AS TXTVAL2
             , 'NA' AS TXTKEY3
             , NULL AS TXTVAL3
             , TT.ItemOrder
             , TT.ItemGuid
             , C.UserGuid
             , PP.MPI
             , PP.ClientCode
             , S.SiteGUID
             , ACCT.AccountID
             , ACCT.AccountCD
             , T.IsAvailable
             , T.IsCustom
             , T.UniqueName
             , T.UniqueName AS ColDesc
             , VENDOR.ItemID AS VendorID
             , VENDOR.VendorName
             , TT.LastModifiedDate
             , TT.SVR
             , TT.DBNAME
        INTO
             FACT_HFit_TrackerTests
               FROM dbo.BASE_HFit_TrackerTests AS TT
                        INNER JOIN dbo.BASE_CMS_User AS C
                            ON C.UserID = TT.UserID
                           AND C.SVR = TT.SVR
                           AND C.DBNAME = TT.DBNAME
                        INNER JOIN dbo.BASE_HFit_ppteligibility AS PP
                            ON TT.UserID = PP.userID
                           AND TT.SVR = PP.SVR
                           AND TT.DBNAME = PP.DBNAME
                        INNER JOIN dbo.BASE_HFit_Account AS ACCT
                            ON PP.ClientCode = ACCT.AccountCD
                           AND PP.SVR = ACCT.SVR
                           AND PP.DBNAME = ACCT.DBNAME
                        INNER JOIN dbo.BASE_CMS_Site AS S
                            ON ACCT.SiteID = S.SiteID
                           AND ACCT.SVR = S.SVR
                           AND ACCT.DBNAME = S.DBNAME
                        INNER JOIN dbo.BASE_HFit_TrackerCollectionSource AS TC
                            ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                           AND TC.SVR = TT.SVR
                           AND TC.DBNAME = TT.DBNAME
                        LEFT OUTER JOIN dbo.BASE_HFit_Tracker AS T
                            ON T.AggregateTableName = 'HFit_TrackerTests'
                           AND T.SVR = TT.SVR
                           AND T.DBNAME = TT.DBNAME
                        LEFT OUTER JOIN BASE_HFit_LKP_TrackerVendor AS VENDOR
                            ON TT.DBNAME = VENDOR.DBNAME
                           AND TT.SVR = VENDOR.SVR
                           AND TT.VendorID = Vendor.ItemID;
    END;
GO
--set rowcount 5 ;
EXEC PrintImmediate 'Processing FACT_HFit_TrackerTobaccoFree';
EXEC PrintImmediate 'Rows: ';
EXEC proc_QuickRowCount BASE_HFit_TrackerTobaccoFree;
IF NOT EXISTS (SELECT
                      name
                      FROM sys.tables
                      WHERE name = 'FACT_HFit_TrackerTobaccoFree') 
    BEGIN
        EXEC PrintImmediate '*** Loading Records: FACT_HFit_TrackerTobaccoFree';
        SELECT
               'HFit_TrackerTobaccoFree' AS TrackerNameAggregateTable
             , TT.ItemID
             , CAST (EventDate AS DATETIME) AS EventDate
             , TT.IsProfessionallyCollected
             , TT.TrackerCollectionSourceID
             , Notes
             , TT.UserID
             , CollectionSourceName_Internal
             , CollectionSourceName_External
             , 'MISSING' AS EventName
             , 'Y/N' AS UOM
             , 'WasTobaccoFree' AS KEY1
             , CAST ( WasTobaccoFree AS FLOAT) AS VAL1
             , 'NA' AS KEY2
             , NULL AS VAL2
             , 'NA' AS KEY3
             , NULL AS VAL3
             , 'NA' AS KEY4
             , NULL AS VAL4
             , 'NA' AS KEY5
             , NULL AS VAL5
             , 'NA' AS KEY6
             , NULL AS VAL6
             , 'NA' AS KEY7
             , NULL AS VAL7
             , 'NA' AS KEY8
             , NULL AS VAL8
             , 'NA' AS KEY9
             , NULL AS VAL9
             , 'NA' AS KEY10
             , NULL AS VAL10
             , TT.ItemCreatedBy
             , CAST (TT.ItemCreatedWhen AS DATETIME) AS ItemCreatedWhen
             , TT.ItemModifiedBy
             , CAST (TT.ItemModifiedWhen AS DATETIME) AS ItemModifiedWhen
             , NULL AS IsProcessedForHa
             , 'QuitAids' AS TXTKEY1
             , QuitAids AS TXTVAL1
             , 'QuitMeds' AS TXTKEY2
             , QuitMeds AS TXTVAL2
             , 'NA' AS TXTKEY3
             , NULL AS TXTVAL3
             , NULL AS ItemOrder
             , NULL AS ItemGuid
             , C.UserGuid
             , PP.MPI
             , PP.ClientCode
             , S.SiteGUID
             , ACCT.AccountID
             , ACCT.AccountCD
             , T.IsAvailable
             , T.IsCustom
             , T.UniqueName
             , T.UniqueName AS ColDesc
             , NULL AS VendorID	--VENDOR.ItemID as VendorID
             ,
               NULL AS VendorName --VENDOR.VendorName
             , TT.LastModifiedDate
             , TT.SVR
             , TT.DBNAME
        INTO
             FACT_HFit_TrackerTobaccoFree
               FROM dbo.BASE_HFit_TrackerTobaccoFree AS TT
                        INNER JOIN dbo.BASE_CMS_User AS C
                            ON C.UserID = TT.UserID
                           AND C.SVR = TT.SVR
                           AND C.DBNAME = TT.DBNAME
                        INNER JOIN dbo.BASE_HFit_ppteligibility AS PP
                            ON TT.UserID = PP.userID
                           AND TT.SVR = PP.SVR
                           AND TT.DBNAME = PP.DBNAME
                        INNER JOIN dbo.BASE_HFit_Account AS ACCT
                            ON PP.ClientCode = ACCT.AccountCD
                           AND PP.SVR = ACCT.SVR
                           AND PP.DBNAME = ACCT.DBNAME
                        INNER JOIN dbo.BASE_CMS_Site AS S
                            ON ACCT.SiteID = S.SiteID
                           AND ACCT.SVR = S.SVR
                           AND ACCT.DBNAME = S.DBNAME
                        INNER JOIN dbo.BASE_HFit_TrackerCollectionSource AS TC
                            ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                           AND TC.SVR = TT.SVR
                           AND TC.DBNAME = TT.DBNAME
                        LEFT OUTER JOIN dbo.BASE_HFit_Tracker AS T
                            ON T.AggregateTableName = 'HFit_TrackerTobaccoFree'
                           AND T.SVR = TT.SVR
                           AND T.DBNAME = TT.DBNAME;

    --left outer join BASE_HFit_LKP_TrackerVendor as VENDOR ON TT.DBNAME= VENDOR.DBNAME and TT.SVR= VENDOR.SVR
    END;
GO
--set rowcount 5 ;
EXEC PrintImmediate 'Processing FACT_HFit_TrackerVegetables';
EXEC PrintImmediate 'Rows: ';
EXEC proc_QuickRowCount BASE_HFit_TrackerVegetables;
IF NOT EXISTS (SELECT
                      name
                      FROM sys.tables
                      WHERE name = 'FACT_HFit_TrackerVegetables') 
    BEGIN
        EXEC PrintImmediate '*** Loading Records: FACT_HFit_TrackerVegetables';
        SELECT
               'HFit_TrackerVegetables' AS TrackerNameAggregateTable
             , TT.ItemID
             , CAST (EventDate AS DATETIME) AS EventDate
             , TT.IsProfessionallyCollected
             , TT.TrackerCollectionSourceID
             , Notes
             , TT.UserID
             , CollectionSourceName_Internal
             , CollectionSourceName_External
             , 'MISSING' AS EventName
             , 'CUP(8oz)' AS UOM
             , 'Cups' AS KEY1
             , CAST ( Cups AS FLOAT) AS VAL1
             , 'NA' AS KEY2
             , NULL AS VAL2
             , 'NA' AS KEY3
             , NULL AS VAL3
             , 'NA' AS KEY4
             , NULL AS VAL4
             , 'NA' AS KEY5
             , NULL AS VAL5
             , 'NA' AS KEY6
             , NULL AS VAL6
             , 'NA' AS KEY7
             , NULL AS VAL7
             , 'NA' AS KEY8
             , NULL AS VAL8
             , 'NA' AS KEY9
             , NULL AS VAL9
             , 'NA' AS KEY10
             , NULL AS VAL10
             , TT.ItemCreatedBy
             , CAST (TT.ItemCreatedWhen AS DATETIME) AS ItemCreatedWhen
             , TT.ItemModifiedBy
             , CAST (TT.ItemModifiedWhen AS DATETIME) AS ItemModifiedWhen
             , NULL AS IsProcessedForHa
             , 'NA' AS TXTKEY1
             , NULL AS TXTVAL1
             , 'NA' AS TXTKEY2
             , NULL AS TXTVAL2
             , 'NA' AS TXTKEY3
             , NULL AS TXTVAL3
             , NULL AS ItemOrder
             , NULL AS ItemGuid
             , C.UserGuid
             , PP.MPI
             , PP.ClientCode
             , S.SiteGUID
             , ACCT.AccountID
             , ACCT.AccountCD
             , T.IsAvailable
             , T.IsCustom
             , T.UniqueName
             , T.UniqueName AS ColDesc
             , NULL AS VendorID	--VENDOR.ItemID as VendorID
             ,
               NULL AS VendorName --VENDOR.VendorName
             , TT.LastModifiedDate
             , TT.SVR
             , TT.DBNAME
        INTO
             FACT_HFit_TrackerVegetables
               FROM dbo.BASE_HFit_TrackerVegetables AS TT
                        INNER JOIN dbo.BASE_CMS_User AS C
                            ON C.UserID = TT.UserID
                           AND C.SVR = TT.SVR
                           AND C.DBNAME = TT.DBNAME
                        INNER JOIN dbo.BASE_HFit_ppteligibility AS PP
                            ON TT.UserID = PP.userID
                           AND TT.SVR = PP.SVR
                           AND TT.DBNAME = PP.DBNAME
                        INNER JOIN dbo.BASE_HFit_Account AS ACCT
                            ON PP.ClientCode = ACCT.AccountCD
                           AND PP.SVR = ACCT.SVR
                           AND PP.DBNAME = ACCT.DBNAME
                        INNER JOIN dbo.BASE_CMS_Site AS S
                            ON ACCT.SiteID = S.SiteID
                           AND ACCT.SVR = S.SVR
                           AND ACCT.DBNAME = S.DBNAME
                        INNER JOIN dbo.BASE_HFit_TrackerCollectionSource AS TC
                            ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                           AND TC.SVR = TT.SVR
                           AND TC.DBNAME = TT.DBNAME
                        LEFT OUTER JOIN dbo.BASE_HFit_Tracker AS T
                            ON T.AggregateTableName = 'HFit_TrackerVegetables'
                           AND T.SVR = TT.SVR
                           AND T.DBNAME = TT.DBNAME;

    --left outer join BASE_HFit_LKP_TrackerVendor as VENDOR ON TT.DBNAME= VENDOR.DBNAME and TT.SVR= VENDOR.SVR
    END;
GO
--set rowcount 5 ;
EXEC PrintImmediate 'Processing FACT_HFit_TrackerWater';
EXEC PrintImmediate 'Rows: ';
EXEC proc_QuickRowCount BASE_HFit_TrackerWater;
IF NOT EXISTS (SELECT
                      name
                      FROM sys.tables
                      WHERE name = 'FACT_HFit_TrackerWater') 
    BEGIN
        EXEC PrintImmediate '*** Loading Records: FACT_HFit_TrackerWater';
        SELECT
               'HFit_TrackerWater' AS TrackerNameAggregateTable
             , TT.ItemID
             , CAST (EventDate AS DATETIME) AS EventDate
             , TT.IsProfessionallyCollected
             , TT.TrackerCollectionSourceID
             , Notes
             , TT.UserID
             , CollectionSourceName_Internal
             , CollectionSourceName_External
             , 'MISSING' AS EventName
             , 'OZ' AS UOM
             , 'Ounces' AS KEY1
             , CAST ( Ounces AS FLOAT) AS VAL1
             , 'NA' AS KEY2
             , NULL AS VAL2
             , 'NA' AS KEY3
             , NULL AS VAL3
             , 'NA' AS KEY4
             , NULL AS VAL4
             , 'NA' AS KEY5
             , NULL AS VAL5
             , 'NA' AS KEY6
             , NULL AS VAL6
             , 'NA' AS KEY7
             , NULL AS VAL7
             , 'NA' AS KEY8
             , NULL AS VAL8
             , 'NA' AS KEY9
             , NULL AS VAL9
             , 'NA' AS KEY10
             , NULL AS VAL10
             , TT.ItemCreatedBy
             , CAST (TT.ItemCreatedWhen AS DATETIME) AS ItemCreatedWhen
             , TT.ItemModifiedBy
             , CAST (TT.ItemModifiedWhen AS DATETIME) AS ItemModifiedWhen
             , NULL AS IsProcessedForHa
             , 'NA' AS TXTKEY1
             , NULL AS TXTVAL1
             , 'NA' AS TXTKEY2
             , NULL AS TXTVAL2
             , 'NA' AS TXTKEY3
             , NULL AS TXTVAL3
             , NULL AS ItemOrder
             , NULL AS ItemGuid
             , C.UserGuid
             , PP.MPI
             , PP.ClientCode
             , S.SiteGUID
             , ACCT.AccountID
             , ACCT.AccountCD
             , T.IsAvailable
             , T.IsCustom
             , T.UniqueName
             , T.UniqueName AS ColDesc
             , NULL AS VendorID	--VENDOR.ItemID as VendorID
             ,
               NULL AS VendorName --VENDOR.VendorName
             , TT.LastModifiedDate
             , TT.SVR
             , TT.DBNAME
        INTO
             FACT_HFit_TrackerWater
               FROM dbo.BASE_HFit_TrackerWater AS TT
                        INNER JOIN dbo.BASE_CMS_User AS C
                            ON C.UserID = TT.UserID
                           AND C.SVR = TT.SVR
                           AND C.DBNAME = TT.DBNAME
                        INNER JOIN dbo.BASE_HFit_ppteligibility AS PP
                            ON TT.UserID = PP.userID
                           AND TT.SVR = PP.SVR
                           AND TT.DBNAME = PP.DBNAME
                        INNER JOIN dbo.BASE_HFit_Account AS ACCT
                            ON PP.ClientCode = ACCT.AccountCD
                           AND PP.SVR = ACCT.SVR
                           AND PP.DBNAME = ACCT.DBNAME
                        INNER JOIN dbo.BASE_CMS_Site AS S
                            ON ACCT.SiteID = S.SiteID
                           AND ACCT.SVR = S.SVR
                           AND ACCT.DBNAME = S.DBNAME
                        INNER JOIN dbo.BASE_HFit_TrackerCollectionSource AS TC
                            ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                           AND TC.SVR = TT.SVR
                           AND TC.DBNAME = TT.DBNAME
                        LEFT OUTER JOIN dbo.BASE_HFit_Tracker AS T
                            ON T.AggregateTableName = 'HFit_TrackerWater'
                           AND T.SVR = TT.SVR
                           AND T.DBNAME = TT.DBNAME;

    --left outer join BASE_HFit_LKP_TrackerVendor as VENDOR ON TT.DBNAME= VENDOR.DBNAME and TT.SVR= VENDOR.SVR
    END;
GO
--set rowcount 5 ;
EXEC PrintImmediate 'Processing FACT_HFit_TrackerWeight';
EXEC PrintImmediate 'Rows: ';
EXEC proc_QuickRowCount BASE_HFit_TrackerWeight;
IF NOT EXISTS (SELECT
                      name
                      FROM sys.tables
                      WHERE name = 'FACT_HFit_TrackerWeight') 
    BEGIN
        EXEC PrintImmediate '*** Loading Records: FACT_HFit_TrackerWeight';
        SELECT
               'HFit_TrackerWeight' AS TrackerNameAggregateTable
             , TT.ItemID
             , CAST (EventDate AS DATETIME) AS EventDate
             , TT.IsProfessionallyCollected
             , TT.TrackerCollectionSourceID
             , Notes
             , TT.UserID
             , CollectionSourceName_Internal
             , CollectionSourceName_External
             , 'MISSING' AS EventName
             , 'LBS' AS UOM
             , 'Value' AS KEY1
             , [Value] AS VAL1
             , 'NA' AS KEY2
             , NULL AS VAL2
             , 'NA' AS KEY3
             , NULL AS VAL3
             , 'NA' AS KEY4
             , NULL AS VAL4
             , 'NA' AS KEY5
             , NULL AS VAL5
             , 'NA' AS KEY6
             , NULL AS VAL6
             , 'NA' AS KEY7
             , NULL AS VAL7
             , 'NA' AS KEY8
             , NULL AS VAL8
             , 'NA' AS KEY9
             , NULL AS VAL9
             , 'NA' AS KEY10
             , NULL AS VAL10
             , TT.ItemCreatedBy
             , CAST (TT.ItemCreatedWhen AS DATETIME) AS ItemCreatedWhen
             , TT.ItemModifiedBy
             , CAST (TT.ItemModifiedWhen AS DATETIME) AS ItemModifiedWhen
             , IsProcessedForHa
             , 'NA' AS TXTKEY1
             , NULL AS TXTVAL1
             , 'NA' AS TXTKEY2
             , NULL AS TXTVAL2
             , 'NA' AS TXTKEY3
             , NULL AS TXTVAL3
             , NULL AS ItemOrder
             , NULL AS ItemGuid
             , C.UserGuid
             , PP.MPI
             , PP.ClientCode
             , S.SiteGUID
             , ACCT.AccountID
             , ACCT.AccountCD
             , T.IsAvailable
             , T.IsCustom
             , T.UniqueName
             , T.UniqueName AS ColDesc
             , VENDOR.ItemID AS VendorID
             , VENDOR.VendorName
             , TT.LastModifiedDate
             , TT.SVR
             , TT.DBNAME
        INTO
             FACT_HFit_TrackerWeight
               FROM dbo.BASE_HFit_TrackerWeight AS TT
                        INNER JOIN dbo.BASE_CMS_User AS C
                            ON C.UserID = TT.UserID
                           AND C.SVR = TT.SVR
                           AND C.DBNAME = TT.DBNAME
                        INNER JOIN dbo.BASE_HFit_ppteligibility AS PP
                            ON TT.UserID = PP.userID
                           AND TT.SVR = PP.SVR
                           AND TT.DBNAME = PP.DBNAME
                        INNER JOIN dbo.BASE_HFit_Account AS ACCT
                            ON PP.ClientCode = ACCT.AccountCD
                           AND PP.SVR = ACCT.SVR
                           AND PP.DBNAME = ACCT.DBNAME
                        INNER JOIN dbo.BASE_CMS_Site AS S
                            ON ACCT.SiteID = S.SiteID
                           AND ACCT.SVR = S.SVR
                           AND ACCT.DBNAME = S.DBNAME
                        INNER JOIN dbo.BASE_HFit_TrackerCollectionSource AS TC
                            ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                           AND TC.SVR = TT.SVR
                           AND TC.DBNAME = TT.DBNAME
                        LEFT OUTER JOIN dbo.BASE_HFit_Tracker AS T
                            ON T.AggregateTableName = 'HFit_TrackerWeight'
                           AND T.SVR = TT.SVR
                           AND T.DBNAME = TT.DBNAME
                        LEFT OUTER JOIN BASE_HFit_LKP_TrackerVendor AS VENDOR
                            ON TT.DBNAME = VENDOR.DBNAME
                           AND TT.SVR = VENDOR.SVR
                           AND TT.VendorID = Vendor.ItemID;
    END;
GO
--set rowcount 5 ;
EXEC PrintImmediate 'Processing FACT_HFit_TrackerWholeGrains';
EXEC PrintImmediate 'Rows: ';
EXEC proc_QuickRowCount BASE_HFit_TrackerWholeGrains;
IF NOT EXISTS (SELECT
                      name
                      FROM sys.tables
                      WHERE name = 'FACT_HFit_TrackerWholeGrains') 
    BEGIN
        EXEC PrintImmediate '*** Loading Records: FACT_HFit_TrackerWholeGrains';
        SELECT
               'HFit_TrackerWholeGrains' AS TrackerNameAggregateTable
             , TT.ItemID
             , CAST (EventDate AS DATETIME) AS EventDate
             , TT.IsProfessionallyCollected
             , TT.TrackerCollectionSourceID
             , Notes
             , TT.UserID
             , CollectionSourceName_Internal
             , CollectionSourceName_External
             , 'MISSING' AS EventName
             , 'NA-serving' AS UOM
             , 'Servings' AS KEY1
             , CAST ( Servings AS FLOAT) AS VAL1
             , 'NA' AS KEY2
             , NULL AS VAL2
             , 'NA' AS KEY3
             , NULL AS VAL3
             , 'NA' AS KEY4
             , NULL AS VAL4
             , 'NA' AS KEY5
             , NULL AS VAL5
             , 'NA' AS KEY6
             , NULL AS VAL6
             , 'NA' AS KEY7
             , NULL AS VAL7
             , 'NA' AS KEY8
             , NULL AS VAL8
             , 'NA' AS KEY9
             , NULL AS VAL9
             , 'NA' AS KEY10
             , NULL AS VAL10
             , TT.ItemCreatedBy
             , CAST (TT.ItemCreatedWhen AS DATETIME) AS ItemCreatedWhen
             , TT.ItemModifiedBy
             , CAST (TT.ItemModifiedWhen AS DATETIME) AS ItemModifiedWhen
             , NULL AS IsProcessedForHa
             , 'NA' AS TXTKEY1
             , NULL AS TXTVAL1
             , 'NA' AS TXTKEY2
             , NULL AS TXTVAL2
             , 'NA' AS TXTKEY3
             , NULL AS TXTVAL3
             , NULL AS ItemOrder
             , NULL AS ItemGuid
             , C.UserGuid
             , PP.MPI
             , PP.ClientCode
             , S.SiteGUID
             , ACCT.AccountID
             , ACCT.AccountCD
             , T.IsAvailable
             , T.IsCustom
             , T.UniqueName
             , T.UniqueName AS ColDesc
             , NULL AS VendorID	--VENDOR.ItemID as VendorID
             ,
               NULL AS VendorName --VENDOR.VendorName
             , TT.LastModifiedDate
             , TT.SVR
             , TT.DBNAME
        INTO
             FACT_HFit_TrackerWholeGrains
               FROM dbo.BASE_HFit_TrackerWholeGrains AS TT
                        INNER JOIN dbo.BASE_CMS_User AS C
                            ON C.UserID = TT.UserID
                           AND C.SVR = TT.SVR
                           AND C.DBNAME = TT.DBNAME
                        INNER JOIN dbo.BASE_HFit_ppteligibility AS PP
                            ON TT.UserID = PP.userID
                           AND TT.SVR = PP.SVR
                           AND TT.DBNAME = PP.DBNAME
                        INNER JOIN dbo.BASE_HFit_Account AS ACCT
                            ON PP.ClientCode = ACCT.AccountCD
                           AND PP.SVR = ACCT.SVR
                           AND PP.DBNAME = ACCT.DBNAME
                        INNER JOIN dbo.BASE_CMS_Site AS S
                            ON ACCT.SiteID = S.SiteID
                           AND ACCT.SVR = S.SVR
                           AND ACCT.DBNAME = S.DBNAME
                        INNER JOIN dbo.BASE_HFit_TrackerCollectionSource AS TC
                            ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                           AND TC.SVR = TT.SVR
                           AND TC.DBNAME = TT.DBNAME
                        LEFT OUTER JOIN dbo.BASE_HFit_Tracker AS T
                            ON T.AggregateTableName = 'HFit_TrackerWholeGrains'
                           AND T.SVR = TT.SVR
                           AND T.DBNAME = TT.DBNAME;
    END;
GO
--set rowcount 5 ;
EXEC PrintImmediate 'Processing FACT_HFit_TrackerCotinine';
EXEC PrintImmediate 'Rows: ';
EXEC proc_QuickRowCount BASE_HFit_TrackerCotinine;
IF NOT EXISTS (SELECT
                      name
                      FROM sys.tables
                      WHERE name = 'FACT_HFit_TrackerCotinine') 
    BEGIN
        EXEC PrintImmediate '*** Loading Records: FACT_HFit_TrackerCotinine';
        SELECT
               'HFit_TrackerCotinine' AS TrackerNameAggregateTable
             , TT.ItemID
             , CAST (EventDate AS DATETIME) AS EventDate
             , TT.IsProfessionallyCollected
             , TT.TrackerCollectionSourceID
             , Notes
             , TT.UserID
             , NULL AS CollectionSourceName_Internal
             , NULL AS CollectionSourceName_External
             , 'MISSING' AS EventName
             , 'NA' AS UOM
             , 'NicotineAssessment' AS KEY1
             , CAST ( NicotineAssessment AS FLOAT) AS VAL1
             , 'NA' AS KEY2
             , NULL AS VAL2
             , 'NA' AS KEY3
             , NULL AS VAL3
             , 'NA' AS KEY4
             , NULL AS VAL4
             , 'NA' AS KEY5
             , NULL AS VAL5
             , 'NA' AS KEY6
             , NULL AS VAL6
             , 'NA' AS KEY7
             , NULL AS VAL7
             , 'NA' AS KEY8
             , NULL AS VAL8
             , 'NA' AS KEY9
             , NULL AS VAL9
             , 'NA' AS KEY10
             , NULL AS VAL10
             , TT.ItemCreatedBy
             , CAST (TT.ItemCreatedWhen AS DATETIME) AS ItemCreatedWhen
             , TT.ItemModifiedBy
             , CAST (TT.ItemModifiedWhen AS DATETIME) AS ItemModifiedWhen
             , IsProcessedForHa
             , 'NA' AS TXTKEY1
             , NULL AS TXTVAL1
             , 'NA' AS TXTKEY2
             , NULL AS TXTVAL2
             , 'NA' AS TXTKEY3
             , NULL AS TXTVAL3
             , NULL AS ItemOrder
             , NULL AS ItemGuid
             , C.UserGuid
             , PP.MPI
             , PP.ClientCode
             , S.SiteGUID
             , ACCT.AccountID
             , ACCT.AccountCD
             , T.IsAvailable
             , T.IsCustom
             , T.UniqueName
             , T.UniqueName AS ColDesc
             , --VENDOR.ItemID AS VendorID ,
               --VENDOR.VendorName,
               NULL AS VendorID
             , NULL AS VendorName
             , TT.LastModifiedDate
             , TT.SVR
             , TT.DBNAME
        INTO
             FACT_HFit_TrackerCotinine
               FROM dbo.BASE_HFit_TrackerCotinine AS TT
                        INNER JOIN dbo.BASE_CMS_User AS C
                            ON C.UserID = TT.UserID
                           AND C.SVR = TT.SVR
                           AND C.DBNAME = TT.DBNAME
                        INNER JOIN dbo.BASE_HFit_ppteligibility AS PP
                            ON TT.UserID = PP.userID
                           AND TT.SVR = PP.SVR
                           AND TT.DBNAME = PP.DBNAME
                        INNER JOIN dbo.BASE_HFit_Account AS ACCT
                            ON PP.ClientCode = ACCT.AccountCD
                           AND PP.SVR = ACCT.SVR
                           AND PP.DBNAME = ACCT.DBNAME
                        INNER JOIN dbo.BASE_CMS_Site AS S
                            ON ACCT.SiteID = S.SiteID
                           AND ACCT.SVR = S.SVR
                           AND ACCT.DBNAME = S.DBNAME
                        INNER JOIN dbo.BASE_HFit_TrackerCollectionSource AS TC
                            ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                           AND TC.SVR = TT.SVR
                           AND TC.DBNAME = TT.DBNAME
                        LEFT OUTER JOIN dbo.BASE_HFit_Tracker AS T
                            ON T.AggregateTableName = 'HFit_TrackerCotinine'
                           AND T.SVR = TT.SVR
                           AND T.DBNAME = TT.DBNAME;

    --LEFT OUTER JOIN BASE_HFit_LKP_TrackerVendor AS VENDOR
    --	ON TT.DBNAME= VENDOR.DBNAME and TT.SVR= VENDOR.SVR;

    END;
GO
--set rowcount 5 ;
EXEC PrintImmediate 'Processing FACT_HFit_TrackerPreventiveCare';
EXEC PrintImmediate 'Rows: ';
EXEC proc_QuickRowCount BASE_HFit_TrackerPreventiveCare;
IF NOT EXISTS (SELECT
                      name
                      FROM sys.tables
                      WHERE name = 'FACT_HFit_TrackerPreventiveCare') 
    BEGIN
        EXEC PrintImmediate '*** Loading Records: FACT_HFit_TrackerPreventiveCare';
        SELECT
               'HFit_TrackerPreventiveCare' AS TrackerNameAggregateTable
             , TT.ItemID
             , CAST (EventDate AS DATETIME) AS EventDate
             , TT.IsProfessionallyCollected
             , TT.TrackerCollectionSourceID
             , Notes
             , TT.UserID
             , NULL AS CollectionSourceName_Internal
             , NULL AS CollectionSourceName_External
             , 'MISSING' AS EventName
             , 'NA' AS UOM
             , 'PreventiveCare' AS KEY1
             , CAST ( PreventiveCare AS FLOAT) AS VAL1
             , 'NA' AS KEY2
             , NULL AS VAL2
             , 'NA' AS KEY3
             , NULL AS VAL3
             , 'NA' AS KEY4
             , NULL AS VAL4
             , 'NA' AS KEY5
             , NULL AS VAL5
             , 'NA' AS KEY6
             , NULL AS VAL6
             , 'NA' AS KEY7
             , NULL AS VAL7
             , 'NA' AS KEY8
             , NULL AS VAL8
             , 'NA' AS KEY9
             , NULL AS VAL9
             , 'NA' AS KEY10
             , NULL AS VAL10
             , TT.ItemCreatedBy
             , CAST (TT.ItemCreatedWhen AS DATETIME) AS ItemCreatedWhen
             , TT.ItemModifiedBy
             , CAST (TT.ItemModifiedWhen AS DATETIME) AS ItemModifiedWhen
             , IsProcessedForHa
             , 'NA' AS TXTKEY1
             , NULL AS TXTVAL1
             , 'NA' AS TXTKEY2
             , NULL AS TXTVAL2
             , 'NA' AS TXTKEY3
             , NULL AS TXTVAL3
             , NULL AS ItemOrder
             , NULL AS ItemGuid
             , C.UserGuid
             , PP.MPI
             , PP.ClientCode
             , S.SiteGUID
             , ACCT.AccountID
             , ACCT.AccountCD
             , T.IsAvailable
             , T.IsCustom
             , T.UniqueName
             , T.UniqueName AS ColDesc
             , --VENDOR.ItemID AS VendorID ,
               --VENDOR.VendorName,
               NULL AS VendorID
             , NULL AS VendorName
             , TT.LastModifiedDate
             , TT.SVR
             , TT.DBNAME
        INTO
             FACT_HFit_TrackerPreventiveCare
               FROM dbo.BASE_HFit_TrackerPreventiveCare AS TT
                        INNER JOIN dbo.BASE_CMS_User AS C
                            ON C.UserID = TT.UserID
                           AND C.SVR = TT.SVR
                           AND C.DBNAME = TT.DBNAME
                        INNER JOIN dbo.BASE_HFit_ppteligibility AS PP
                            ON TT.UserID = PP.userID
                           AND TT.SVR = PP.SVR
                           AND TT.DBNAME = PP.DBNAME
                        INNER JOIN dbo.BASE_HFit_Account AS ACCT
                            ON PP.ClientCode = ACCT.AccountCD
                           AND PP.SVR = ACCT.SVR
                           AND PP.DBNAME = ACCT.DBNAME
                        INNER JOIN dbo.BASE_CMS_Site AS S
                            ON ACCT.SiteID = S.SiteID
                           AND ACCT.SVR = S.SVR
                           AND ACCT.DBNAME = S.DBNAME
                        INNER JOIN dbo.BASE_HFit_TrackerCollectionSource AS TC
                            ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                           AND TC.SVR = TT.SVR
                           AND TC.DBNAME = TT.DBNAME
                        LEFT OUTER JOIN dbo.BASE_HFit_Tracker AS T
                            ON T.AggregateTableName = 'HFit_TrackerPreventiveCare'
                           AND T.SVR = TT.SVR
                           AND T.DBNAME = TT.DBNAME;

    --LEFT OUTER JOIN BASE_HFit_LKP_TrackerVendor AS VENDOR
    --	ON TT.DBNAME= VENDOR.DBNAME and TT.SVR= VENDOR.SVR;
    END;
GO
--set rowcount 5 ;
EXEC PrintImmediate 'Processing FACT_HFit_TrackerTobaccoAttestation';
EXEC PrintImmediate 'Rows: ';
EXEC proc_QuickRowCount BASE_HFit_TrackerTobaccoAttestation;
IF NOT EXISTS (SELECT
                      name
                      FROM sys.tables
                      WHERE name = 'FACT_HFit_TrackerTobaccoAttestation') 
    BEGIN
        EXEC PrintImmediate '*** Loading Records: FACT_HFit_TrackerTobaccoAttestation';
        SELECT
               'HFit_TrackerTobaccoAttestation' AS TrackerNameAggregateTable
             , TT.ItemID
             , CAST (EventDate AS DATETIME) AS EventDate
             , TT.IsProfessionallyCollected
             , TT.TrackerCollectionSourceID
             , Notes
             , TT.UserID
             , NULL AS CollectionSourceName_Internal
             , NULL AS CollectionSourceName_External
             , 'MISSING' AS EventName
             , 'NA' AS UOM
             , 'TobaccoAttestation' AS KEY1
             , CAST ( TobaccoAttestation AS FLOAT) AS VAL1
             , 'NA' AS KEY2
             , NULL AS VAL2
             , 'NA' AS KEY3
             , NULL AS VAL3
             , 'NA' AS KEY4
             , NULL AS VAL4
             , 'NA' AS KEY5
             , NULL AS VAL5
             , 'NA' AS KEY6
             , NULL AS VAL6
             , 'NA' AS KEY7
             , NULL AS VAL7
             , 'NA' AS KEY8
             , NULL AS VAL8
             , 'NA' AS KEY9
             , NULL AS VAL9
             , 'NA' AS KEY10
             , NULL AS VAL10
             , TT.ItemCreatedBy
             , CAST (TT.ItemCreatedWhen AS DATETIME) AS ItemCreatedWhen
             , TT.ItemModifiedBy
             , CAST (TT.ItemModifiedWhen AS DATETIME) AS ItemModifiedWhen
             , IsProcessedForHa
             , 'NA' AS TXTKEY1
             , NULL AS TXTVAL1
             , 'NA' AS TXTKEY2
             , NULL AS TXTVAL2
             , 'NA' AS TXTKEY3
             , NULL AS TXTVAL3
             , NULL AS ItemOrder
             , NULL AS ItemGuid
             , C.UserGuid
             , PP.MPI
             , PP.ClientCode
             , S.SiteGUID
             , ACCT.AccountID
             , ACCT.AccountCD
             , T.IsAvailable
             , T.IsCustom
             , T.UniqueName
             , T.UniqueName AS ColDesc
             , --VENDOR.ItemID AS VendorID ,
               --VENDOR.VendorName,
               NULL AS VendorID
             , NULL AS VendorName
             , TT.LastModifiedDate
             , TT.SVR
             , TT.DBNAME
        INTO
             FACT_HFit_TrackerTobaccoAttestation
               FROM dbo.BASE_HFit_TrackerTobaccoAttestation AS TT
                        INNER JOIN dbo.BASE_CMS_User AS C
                            ON C.UserID = TT.UserID
                           AND C.SVR = TT.SVR
                           AND C.DBNAME = TT.DBNAME
                        INNER JOIN dbo.BASE_HFit_ppteligibility AS PP
                            ON TT.UserID = PP.userID
                           AND TT.SVR = PP.SVR
                           AND TT.DBNAME = PP.DBNAME
                        INNER JOIN dbo.BASE_HFit_Account AS ACCT
                            ON PP.ClientCode = ACCT.AccountCD
                           AND PP.SVR = ACCT.SVR
                           AND PP.DBNAME = ACCT.DBNAME
                        INNER JOIN dbo.BASE_CMS_Site AS S
                            ON ACCT.SiteID = S.SiteID
                           AND ACCT.SVR = S.SVR
                           AND ACCT.DBNAME = S.DBNAME
                        INNER JOIN dbo.BASE_HFit_TrackerCollectionSource AS TC
                            ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                           AND TC.SVR = TT.SVR
                           AND TC.DBNAME = TT.DBNAME
                        LEFT OUTER JOIN dbo.BASE_HFit_Tracker AS T
                            ON T.AggregateTableName = 'HFit_TrackerTobaccoAttestation'
                           AND T.SVR = TT.SVR
                           AND T.DBNAME = TT.DBNAME;
    END;

/*
	select 'exec proc_SetTrackerPrimaryKey ' + table_name 
	from information_schema.tables 
	where table_name like 'FACT_HFit_Tracker%'
*/
exec proc_SetTrackerPrimaryKey FACT_HFit_TrackerSitLess
exec proc_SetTrackerPrimaryKey FACT_HFit_TrackerSleepPlan
exec proc_SetTrackerPrimaryKey FACT_HFit_TrackerStrength
exec proc_SetTrackerPrimaryKey FACT_HFit_TrackerStress
exec proc_SetTrackerPrimaryKey FACT_HFit_TrackerStressManagement
exec proc_SetTrackerPrimaryKey FACT_HFit_TrackerSugaryDrinks
exec proc_SetTrackerPrimaryKey FACT_HFit_TrackerSugaryFoods
exec proc_SetTrackerPrimaryKey FACT_HFit_TrackerTobaccoFree
exec proc_SetTrackerPrimaryKey FACT_HFit_TrackerVegetables
exec proc_SetTrackerPrimaryKey FACT_HFit_TrackerHeight
exec proc_SetTrackerPrimaryKey FACT_HFit_TrackerWater
exec proc_SetTrackerPrimaryKey FACT_HFit_TrackerWeight
exec proc_SetTrackerPrimaryKey FACT_HFit_TrackerWholeGrains
exec proc_SetTrackerPrimaryKey FACT_HFit_TrackerCotinine
exec proc_SetTrackerPrimaryKey FACT_HFit_TrackerPreventiveCare
exec proc_SetTrackerPrimaryKey FACT_HFit_TrackerCardio
exec proc_SetTrackerPrimaryKey FACT_HFit_TrackerTobaccoAttestation
exec proc_SetTrackerPrimaryKey FACT_HFit_TrackerMedicalCarePlan
exec proc_SetTrackerPrimaryKey FACT_HFit_TrackerRegularMeals
exec proc_SetTrackerPrimaryKey FACT_HFit_TrackerRestingHeartRate
exec proc_SetTrackerPrimaryKey FACT_HFit_TrackerBloodSugarAndGlucose
exec proc_SetTrackerPrimaryKey FACT_HFit_TrackerBloodPressure

exec proc_SetTrackerPrimaryKey FACT_HFit_TrackerBMI

exec proc_SetTrackerPrimaryKey FACT_HFit_TrackerBodyFat
exec proc_SetTrackerPrimaryKey FACT_HFit_TrackerBodyMeasurements
exec proc_SetTrackerPrimaryKey FACT_HFit_TrackerDailySteps
exec proc_SetTrackerPrimaryKey FACT_HFit_TrackerHbA1c
exec proc_SetTrackerPrimaryKey FACT_HFit_TrackerHighFatFoods
exec proc_SetTrackerPrimaryKey FACT_HFit_TrackerHighSodiumFoods

exec proc_SetTrackerPrimaryKey FACT_HFit_TrackerInstance_Tracker

exec proc_SetTrackerPrimaryKey FACT_HFit_TrackerCholesterol
exec proc_SetTrackerPrimaryKey FACT_HFit_TrackerMealPortions
exec proc_SetTrackerPrimaryKey FACT_HFit_TrackerFlexibility
exec proc_SetTrackerPrimaryKey FACT_HFit_TrackerFruits
exec proc_SetTrackerPrimaryKey FACT_HFit_TrackerShots
