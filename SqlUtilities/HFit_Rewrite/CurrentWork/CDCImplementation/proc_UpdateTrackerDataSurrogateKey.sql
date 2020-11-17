USE KenticoCMS_DataMart_2;
GO

/*-------------------------------------------------------------------------------------------------------------
select 'EXEC proc_UpdateTrackerDataSurrogateKey ' + table_name +char(10) + 'GO' from INFORMATION_SCHEMA.TABLES 
where table_name like 'BASE_HFit_Tracker%' 
and table_name NOT like '%VerHIST' 	
and table_name NOT like '%_DEL' 	
*/

GO
PRINT 'Execute proc_UpdateTrackerDataSurrogateKey.sql';
GO
IF EXISTS (SELECT
                  name
                  FROM sys.procedures
                  WHERE
                  name = 'proc_UpdateTrackerDataSurrogateKey') 
    BEGIN
        DROP PROCEDURE
             proc_UpdateTrackerDataSurrogateKey
    END;
GO
-- exec proc_UpdateTrackerDataSurrogateKey BASE_HFit_TrackerBloodPressure
-- exec proc_UpdateTrackerDataSurrogateKey BASE_HFit_TrackerHbA1c
-- exec proc_UpdateTrackerDataSurrogateKey BASE_HFit_TrackerBMI
-- exec proc_UpdateTrackerDataSurrogateKey BASE_HFit_TrackerShots
CREATE PROCEDURE proc_UpdateTrackerDataSurrogateKey (
       @TblName AS NVARCHAR (250)) 
AS
BEGIN
    -- declare @TblName as nvarchar(250) = 'BASE_HFit_TrackerBloodPressure'

    DECLARE
           @MySql AS NVARCHAR (MAX) = ''
         , @SKEY AS NVARCHAR (500) = ''
         , @iCnt AS BIGINT = 0;

    UPDATE F
      SET
          F.SurrogateKey_HFit_TrackerBloodPressure = B.SurrogateKey_HFit_TrackerBloodPressure
          FROM
          BASE_HFit_TrackerBloodPressure B JOIN
          FACT_TrackerData F
              ON
           F.DBNAME = B.DBNAME AND
           F.ItemID = B.ItemID AND
           F.TrackerName = @TblName AND
           F.SurrogateKey_HFit_TrackerBloodPressure IS NULL;
    SET @iCnt = @@ROWCOUNT;
    PRINT @TblName + ': ' + cast (@iCnt AS NVARCHAR (50)) + ' SurrogateKey rows updated.';
END;

--select top 100 * from FACT_TrackerData where TrackerName = 'BASE_HFit_TrackerBloodPressure'
GO
PRINT 'Executed proc_UpdateTrackerDataSurrogateKey.sql';
GO
