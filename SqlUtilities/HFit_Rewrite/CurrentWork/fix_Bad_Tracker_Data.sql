
/*
SELECT
       *
       FROM HFit_TrackerBloodPressure
       WHERE eventdate < CAST ('1900-01-01' AS datetime2) 
          OR Itemcreatedwhen < CAST ('1900-01-01' AS datetime2) 
          OR ItemModifiedwhen < CAST ('1900-01-01' AS datetime2) ;
*/

UPDATE HFit_TrackerBloodSugarAndGlucose
       SET
           EventDate = '2015-07-27 17:00:00.0000000'
WHERE
      ItemID IN (
      SELECT
             ItemID
             FROM HFit_TrackerBloodPressure
             WHERE eventdate < CAST ('1900-01-01' AS datetime2) 
                OR Itemcreatedwhen < CAST ('1900-01-01' AS datetime2) 
                OR ItemModifiedwhen < CAST ('1900-01-01' AS datetime2)) ;

UPDATE HFit_TrackerBloodSugarAndGlucose
       SET
           EventDate = '2015-07-27 17:00:00.0000000'
WHERE
      ItemID IN (
      SELECT
             ItemID
             FROM HFit_TrackerBloodSugarAndGlucose
             WHERE eventdate < CAST ('1900-01-01' AS datetime2) 
                OR Itemcreatedwhen < CAST ('1900-01-01' AS datetime2) 
                OR ItemModifiedwhen < CAST ('1900-01-01' AS datetime2)) ;

UPDATE HFit_TrackerBMI
       SET
           EventDate = '2015-07-27 17:00:00.0000000'
WHERE
      ItemID IN (
      SELECT
             ItemID
             FROM HFit_TrackerBMI
             WHERE eventdate < CAST ('1900-01-01' AS datetime2) 
                OR Itemcreatedwhen < CAST ('1900-01-01' AS datetime2) 
                OR ItemModifiedwhen < CAST ('1900-01-01' AS datetime2)) ;

UPDATE HFit_TrackerCholesterol
       SET
           EventDate = '2015-07-27 17:00:00.0000000'
WHERE
      ItemID IN (
      SELECT
             *
             FROM HFit_TrackerCholesterol
             WHERE eventdate < CAST ('1900-01-01' AS datetime2) 
                OR Itemcreatedwhen < CAST ('1900-01-01' AS datetime2) 
                OR ItemModifiedwhen < CAST ('1900-01-01' AS datetime2)) ;

UPDATE HFit_TrackerHeight
       SET
           EventDate = '2015-07-27 17:00:00.0000000'
WHERE
      ItemID IN (
      SELECT
             ItemID
             FROM HFit_TrackerHeight
             WHERE eventdate < CAST ('1900-01-01' AS datetime2) 
                OR Itemcreatedwhen < CAST ('1900-01-01' AS datetime2) 
                OR ItemModifiedwhen < CAST ('1900-01-01' AS datetime2)) ;

UPDATE HFit_TrackerWeight
       SET
           EventDate = '2015-07-27 17:00:00.0000000'
WHERE
      ItemID IN (
      SELECT
             ItemID
             FROM HFit_TrackerWeight
             WHERE eventdate < CAST ('1900-01-01' AS datetime2) 
                OR Itemcreatedwhen < CAST ('1900-01-01' AS datetime2) 
                OR ItemModifiedwhen < CAST ('1900-01-01' AS datetime2)) ;


