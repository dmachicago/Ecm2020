WITH CTE (
     SVR
   , DBNAME
   , ItemID) 
    AS (
    SELECT SVR, DBNAME, ItemID FROM BASE_HFit_TrackerCardio
    EXCEPT
    SELECT SVR, DBNAME, ItemID FROM FACT_TrackerData WHERE TrackerName = 'BASE_HFit_TrackerCardio'
    ) 
    INSERT INTO FACT_TrackerData (
           TrackerName
         , TrackerCollectionSourceID
         , IsProfessionallyCollected
         , Minutes
         , Distance
         , DistanceUnit
         , EventDate
         , Intensity
         , ActivityID
         , Notes
         , UserID
         , ItemCreatedBy
         , ItemCreatedWhen
         , ItemModifiedBy
         , ItemModifiedWhen
         , ItemID
         , ACTION
         , SYS_CHANGE_VERSION
         , LASTMODIFIEDDATE
         , HashCode
         , SVR
         , DBNAME
    ) 
    SELECT
           'BASE_HFit_TrackerCardio'
         , BT.TrackerCollectionSourceID
         , BT.IsProfessionallyCollected
         , BT.Minutes
         , BT.Distance
         , BT.DistanceUnit
         , BT.EventDate
         , BT.Intensity
         , BT.ActivityID
         , BT.Notes
         , BT.UserID
         , BT.ItemCreatedBy
         , BT.ItemCreatedWhen
         , BT.ItemModifiedBy
         , BT.ItemModifiedWhen
         , BT.ItemID
         , BT.ACTION
         , BT.SYS_CHANGE_VERSION
         , BT.LASTMODIFIEDDATE
         , BT.HashCode
         , BT.SVR
         , BT.DBNAME
           FROM BASE_HFit_TrackerCardio AS BT
                    JOIN CTE
                        ON CTE.SVR = BT.SVR
                       AND CTE.DBNAME = BT.DBNAME
                       AND CTE.ItemID = BT.ItemID;

