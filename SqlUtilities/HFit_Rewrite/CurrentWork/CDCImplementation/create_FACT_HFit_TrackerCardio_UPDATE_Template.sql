
-- drop table FACT_HFit_TrackerCardio
EXEC PrintImmediate 'Processing FACT_HFit_TrackerCardio';
EXEC PrintImmediate 'Rows: ';
EXEC proc_QuickRowCount BASE_HFit_TrackerCardio;

declare @StepSecs as bigint = 0 ;
declare @TotalSecs as bigint = 0 ;
declare @StartTime as datetime = getdate() ;
declare @Step1Time as datetime = getdate() ;
declare @Step2Time as datetime = getdate() ;
declare @Step3Time as datetime = getdate() ;
declare @Step4Time as datetime = getdate() ;
declare @Step5Time as datetime = getdate() ;
declare @Step6Time as datetime = getdate() ;

--******************************************************
print 'Starting Time: ' 
print getdate();

INSERT INTO FACT_HFit_TrackerCardio
(
       TrackerNameAggregateTable
     , ItemID
     , EventDate
     , IsProfessionallyCollected
     , TrackerCollectionSourceID
     , Notes
     , UserID
     , EventName
     , UOM
     , KEY1
     , VAL1
     , Key2
     , Val2
     , Key3
     , Val3
     , Key4
     , Val4
     , Key5
     , Val5
     , Key6
     , Val6
     , Key7
     , Val7
     , Key8
     , Val8
     , Key9
     , Val9
     , Key10
     , Val10
     , ItemCreatedBy
     , ItemCreatedWhen
     , ItemModifiedBy
     , ItemModifiedWhen
     , IsProcessedForHa
     , TXTKEY1
     , TXTVAL1
     , TXTKEY2
     , TXTVAL2
     , TXTKEY3
     , TXTVAL3
     , ItemOrder
     , ItemGuid
     , UserGuid
     , MPI
     , ClientCode
     , VendorID
     , VendorName
     , LastModifiedDate
     , SVR
     , DBNAME) 
SELECT
       'HFit_TrackerCardio' AS TrackerNameAggregateTable
     , TT.ItemID
     , CAST (EventDate AS DATETIME) AS EventDate
     , TT.IsProfessionallyCollected
     , TT.TrackerCollectionSourceID
     , Notes
     , TT.UserID
       --, CollectionSourceName_Internal
       --, CollectionSourceName_External
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
     , NULL AS VendorID	--VENDOR.ItemID as VendorID
     , NULL AS VendorName --VENDOR.VendorName
     , TT.LastModifiedDate
     , TT.SVR
     , TT.DBNAME

       FROM dbo.BASE_HFit_TrackerCardio AS TT
                INNER JOIN dbo.BASE_CMS_User AS C
                    ON C.UserID = TT.UserID
                   AND C.SVR = TT.SVR
                   AND C.DBNAME = TT.DBNAME
                INNER JOIN dbo.BASE_HFit_ppteligibility AS PP
                    ON TT.UserID = PP.userID
                   AND TT.SVR = PP.SVR
                   AND TT.DBNAME = PP.DBNAME
       WHERE
       EventDate > '01/01/1960';

set @StepSecs = DATEDIFF(second, @StartTime, getdate()) ;
print 'Step1 seconds: ' + cast(@StepSecs as nvarchar(50)) ;
set @Step2Time = getdate() ;
--******************************************************
UPDATE FT
       SET
           FT.AccountID = ACCT.AccountID
         ,FT.AccountCD = ACCT.AccountCD
           FROM BASE_HFit_TrackerCardio AS BT
                    JOIN FACT_HFit_TrackerCardio AS FT
                        ON
                        BT.SVR = FT.SVR
                    AND BT.DBNAME = FT.DBNAME
                    AND BT.ItemID = FT.ItemID
                    INNER JOIN dbo.BASE_HFit_Account AS ACCT
                        ON
                        FT.ClientCode = ACCT.AccountCD
                    AND FT.SVR = ACCT.SVR
                    AND FT.DBNAME = ACCT.DBNAME;

set @StepSecs = DATEDIFF(second, @StartTime, @Step2Time) ;
print 'Step2 seconds: ' + cast(@StepSecs as nvarchar(50)) ;
set @Step3Time = getdate() ;
--******************************************************
UPDATE FT
       SET
FT.AccountCD = ACCT.AccountCD
           FROM BASE_HFit_TrackerCardio AS BT
                    JOIN FACT_HFit_TrackerCardio AS FT
                        ON
                        BT.ItemID = FT.ItemID
                    AND FT.SVR = BT.SVR
                    AND FT.DBNAME = BT.DBNAME
                    INNER JOIN dbo.BASE_HFit_Account AS ACCT
                        ON
                        FT.ClientCode = ACCT.AccountCD
                    AND FT.SVR = ACCT.SVR
                    AND FT.DBNAME = ACCT.DBNAME  

set @StepSecs = DATEDIFF(second, @StartTime, @Step3Time) ;
print 'Step3 seconds: ' + cast(@StepSecs as nvarchar(50)) ;
set @Step4Time = getdate() ;                  
--******************************************************
set rowcount 0 ;
UPDATE FT
       SET
           FT.SiteGUID = S.SiteGUID
           FROM FACT_HFit_TrackerCardio AS FT
                INNER JOIN dbo.BASE_HFit_Account AS ACCT
                        ON
                        FT.AccountCD = ACCT.AccountCD
                    AND FT.SVR = ACCT.SVR
                    AND FT.DBNAME = ACCT.DBNAME
                    INNER JOIN dbo.BASE_CMS_Site AS S
                        ON
                        ACCT.SiteID = S.SiteID
                    AND ACCT.SVR = S.SVR
                    AND ACCT.DBNAME = S.DBNAME;

set @StepSecs = DATEDIFF(second, @StartTime, @Step4Time) ;
print 'Step4 seconds: ' + cast(@StepSecs as nvarchar(50)) ;
set @Step5Time = getdate() ;
--******************************************************
UPDATE FT
       SET
           FT.CollectionSourceName_Internal = TC.CollectionSourceName_Internal
         ,FT.CollectionSourceName_External = TC.CollectionSourceName_External
           FROM BASE_HFit_TrackerCardio AS BT
                    JOIN FACT_HFit_TrackerCardio AS FT
                        ON
                        BT.ItemID = FT.ItemID
                    AND FT.SVR = BT.SVR
                    AND FT.DBNAME = BT.DBNAME
                    INNER JOIN dbo.BASE_HFit_TrackerCollectionSource AS TC
                        ON
                        TC.TrackerCollectionSourceID = BT.TrackerCollectionSourceID
                    AND TC.SVR = BT.SVR
                    AND TC.DBNAME = BT.DBNAME;

set @StepSecs = DATEDIFF(second, @StartTime, @Step5Time) ;
print 'Step5 seconds: ' + cast(@StepSecs as nvarchar(50)) ;
set @Step6Time = getdate() ;
--******************************************************
UPDATE FT
       SET
           FT.IsAvailable = T.IsAvailable
         ,FT.IsCustom = T.IsCustom
         ,FT.UniqueName = T.UniqueName
         ,FT.ColDesc = T.UniqueName
           FROM FACT_HFit_TrackerCardio AS FT
                    JOIN dbo.BASE_HFit_Tracker AS T
                        ON
                        T.AggregateTableName = 'HFit_TrackerCardio'
                    AND T.SVR = FT.SVR
                    AND T.DBNAME = FT.DBNAME OPTION (
                                                    MAXDOP 1) ;

set @StepSecs = DATEDIFF(second, @StartTime, @Step5Time) ;
print 'Step6 seconds: ' + cast(@StepSecs as nvarchar(50)) ;

set @StepSecs = DATEDIFF(second, @StartTime, getdate()) ;
print 'Total Time in seconds: ' + cast(@StepSecs as nvarchar(50)) ;

print 'Ending Time: ' 
print getdate();
