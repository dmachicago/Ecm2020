
GO
-- USe KenticoCMS_Prod1
PRINT 'Executing proc_CT_BioMetrics_AddUpdatedRecs.sql';
GO
IF EXISTS ( SELECT
                   name
                   FROM sys.procedures
                   WHERE name = 'proc_CT_BioMetrics_AddUpdatedRecs') 
    BEGIN
        DROP PROCEDURE
             proc_CT_BioMetrics_AddUpdatedRecs;
    END;
GO
CREATE PROCEDURE proc_CT_BioMetrics_AddUpdatedRecs
AS
BEGIN

    DECLARE
    @RUNDATE AS  datetime2 ( 7) = GETDATE () ;

    UPDATE S
      SET
          S.UserID = T.UserID
        ,S.UserGUID = T.UserGUID
        ,S.HFitUserMpiNumber = T.HFitUserMpiNumber
        ,S.SiteID = T.SiteID
        ,S.SiteGUID = T.SiteGUID
        ,S.CreatedDate = T.CreatedDate
        ,S.ModifiedDate = T.ModifiedDate
        ,S.Notes = T.Notes
        ,S.IsProfessionallyCollected = T.IsProfessionallyCollected
        ,S.EventDate = T.EventDate
        ,S.EventName = T.EventName
        ,S.PPTWeight = T.PPTWeight
        ,S.PPTHbA1C = T.PPTHbA1C
        ,S.Fasting = T.Fasting
        ,S.HDL = T.HDL
        ,S.LDL = T.LDL
        ,S.Ratio = T.Ratio
        ,S.Total = T.Total
        ,S.Triglycerides = T.Triglycerides
        ,S.Glucose = T.Glucose
        ,S.FastingState = T.FastingState
        ,S.Systolic = T.Systolic
        ,S.Diastolic = T.Diastolic
        ,S.PPTBodyFatPCT = T.PPTBodyFatPCT
        ,S.BMI = T.BMI
        ,S.WaistInches = T.WaistInches
        ,S.HipInches = T.HipInches
        ,S.ThighInches = T.ThighInches
        ,S.ArmInches = T.ArmInches
        ,S.ChestInches = T.ChestInches
        ,S.CalfInches = T.CalfInches
        ,S.NeckInches = T.NeckInches
        ,S.Height = T.Height
        ,S.HeartRate = T.HeartRate
        ,S.FluShot = T.FluShot
        ,S.PneumoniaShot = T.PneumoniaShot
        ,S.PSATest = T.PSATest
        ,S.OtherExam = T.OtherExam
        ,S.TScore = T.TScore
        ,S.DRA = T.DRA
        ,S.CotinineTest = T.CotinineTest
        ,S.ColoCareKit = T.ColoCareKit
        ,S.CustomTest = T.CustomTest
        ,S.CustomDesc = T.CustomDesc
        ,S.CollectionSource = T.CollectionSource
        ,S.AccountID = T.AccountID
        ,S.AccountCD = T.AccountCD
        ,S.ChangeType = T.ChangeType
        ,S.ItemCreatedWhen = T.ItemCreatedWhen
        ,S.ItemModifiedWhen = T.ItemModifiedWhen
        ,S.TrackerCollectionSourceID = T.TrackerCollectionSourceID
        ,S.itemid = T.itemid
        ,S.TBL = T.TBL
        ,S.VendorID = T.VendorID
        ,S.VendorName = T.VendorName
        ,S.HashCode = T.HashCode
        ,S.LastModifiedDate = GETDATE () 
        ,S.DeletedFlg = NULL
          FROM DIM_EDW_BioMetrics AS S
                    JOIN ##Temp_BioMetrics AS T
                    ON
                    S.UserID = T.UserID AND
                    S.UserGUID = T.UserGUID AND
                    S.SiteID = T.SiteID AND
                    S.SiteGUID = T.SiteGUID AND
                    S.itemid = T.itemid AND
                    S.TBL = T.TBL
           WHERE
                 S.HashCode != T.HashCode AND
                 S.DeletedFlg IS NULL;

    DECLARE
    @iInserts AS int = @@ROWCOUNT;
    PRINT 'Updated Record Count: ' + CAST ( @iInserts AS nvarchar (50)) ;
    RETURN @iInserts;
END;

GO
PRINT 'Executed proc_CT_BioMetrics_AddUpdatedRecs.sql';
GO
