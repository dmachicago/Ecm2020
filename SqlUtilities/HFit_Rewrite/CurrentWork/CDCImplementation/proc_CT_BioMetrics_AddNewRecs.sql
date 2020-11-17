
GO
-- USe KenticoCMS_Prod1

PRINT 'Executing proc_CT_BioMetrics_AddNewRecs.sql';
GO
IF EXISTS ( SELECT
                   name
                   FROM sys.procedures
                   WHERE name = 'proc_CT_BioMetrics_AddNewRecs') 
    BEGIN
        DROP PROCEDURE
             proc_CT_BioMetrics_AddNewRecs;
    END;
GO
-- proc_CT_BioMetrics_AddNewRecs
CREATE PROCEDURE proc_CT_BioMetrics_AddNewRecs
AS
BEGIN
            
    WITH CTE (
         UserID
       , UserGUID
       , SiteID
       , SiteGUID
       , itemid
       , TBL) 
        AS ( SELECT
                    UserID
                  , UserGUID
                  , SiteID
                  , SiteGUID
                  , itemid
                  , TBL
                    FROM ##Temp_BioMetrics
             EXCEPT
             SELECT
                    UserID
                  , UserGUID
                  , SiteID
                  , SiteGUID
                  , itemid
                  , TBL
                    FROM DIM_EDW_BioMetrics
                    WHERE LastModifiedDate IS NULL) 
        INSERT INTO dbo.DIM_EDW_BioMetrics (
               UserID
             , UserGUID
             , HFitUserMpiNumber
             , SiteID
             , SiteGUID
             , CreatedDate
             , ModifiedDate
             , Notes
             , IsProfessionallyCollected
             , EventDate
             , EventName
             , PPTWeight
             , PPTHbA1C
             , Fasting
             , HDL
             , LDL
             , Ratio
             , Total
             , Triglycerides
             , Glucose
             , FastingState
             , Systolic
             , Diastolic
             , PPTBodyFatPCT
             , BMI
             , WaistInches
             , HipInches
             , ThighInches
             , ArmInches
             , ChestInches
             , CalfInches
             , NeckInches
             , Height
             , HeartRate
             , FluShot
             , PneumoniaShot
             , PSATest
             , OtherExam
             , TScore
             , DRA
             , CotinineTest
             , ColoCareKit
             , CustomTest
             , CustomDesc
             , CollectionSource
             , AccountID
             , AccountCD
             , ChangeType
             , ItemCreatedWhen
             , ItemModifiedWhen
             , TrackerCollectionSourceID
             , itemid
             , TBL
             , VendorID
             , VendorName
             , HashCode
             , LastModifiedDate
             , DeletedFlg) 
        SELECT
               T.UserID
             , T.UserGUID
             , T.HFitUserMpiNumber
             , T.SiteID
             , T.SiteGUID
             , T.CreatedDate
             , T.ModifiedDate
             , T.Notes
             , T.IsProfessionallyCollected
             , T.EventDate
             , T.EventName
             , T.PPTWeight
             , T.PPTHbA1C
             , T.Fasting
             , T.HDL
             , T.LDL
             , T.Ratio
             , T.Total
             , T.Triglycerides
             , T.Glucose
             , T.FastingState
             , T.Systolic
             , T.Diastolic
             , T.PPTBodyFatPCT
             , T.BMI
             , T.WaistInches
             , T.HipInches
             , T.ThighInches
             , T.ArmInches
             , T.ChestInches
             , T.CalfInches
             , T.NeckInches
             , T.Height
             , T.HeartRate
             , T.FluShot
             , T.PneumoniaShot
             , T.PSATest
             , T.OtherExam
             , T.TScore
             , T.DRA
             , T.CotinineTest
             , T.ColoCareKit
             , T.CustomTest
             , T.CustomDesc
             , T.CollectionSource
             , T.AccountID
             , T.AccountCD
             , T.ChangeType
             , T.ItemCreatedWhen
             , T.ItemModifiedWhen
             , T.TrackerCollectionSourceID
             , T.itemid
             , T.TBL
             , T.VendorID
             , T.VendorName
             , T.HashCode
             , NULL AS LastModifiedDate
             , NULL AS DeletedFlg
               FROM
                    ##Temp_BioMetrics AS T
                         JOIN CTE AS S
                         ON
                            S.UserID = T.UserID AND
                            S.UserGUID = T.UserGUID AND
                            S.SiteID = T.SiteID AND
                            S.SiteGUID = T.SiteGUID AND
                            S.itemid = T.itemid AND
                            S.TBL = T.TBL;
    DECLARE
    @iInserts AS int = @@ROWCOUNT;
    PRINT 'NEW Insert Count: ' + CAST ( @iInserts AS nvarchar (50)) ;
    RETURN @iInserts;
END;

GO
PRINT 'Executed proc_CT_BioMetrics_AddNewRecs.sql';
GO
