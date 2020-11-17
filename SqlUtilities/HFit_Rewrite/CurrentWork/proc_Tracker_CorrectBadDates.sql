

GO
PRINT 'Executing proc_Tracker_CorrectBadDates.sql';
GO
IF EXISTS (SELECT
                  name
                  FROM sys.procedures
                  WHERE
                  name = 'proc_Tracker_CorrectBadDates') 
    BEGIN
        DROP PROCEDURE
             proc_Tracker_CorrectBadDates;
    END;
GO

--select count(*) from [KenticoCMS_PRD_1 ].dbo.[HFit_TrackerBloodPressure]
--   where EventDate < '01-01-1960' AND ItemCreatedBy <> 53 AND TrackerCollectionSourceID = 4;
-- exec proc_Tracker_CorrectBadDates 'KenticoCMS_PRD_1', 'HFit_TrackerBloodPressure', '2015-12-04 18:00:00', null ,'YES' ;
-- exec proc_Tracker_CorrectBadDates 'KenticoCMS_PRD_1', 'HFit_TrackerBloodPressure', '2015-12-04 18:00:00', '1,2,3,4' ,'YES' ;
-- exec proc_Tracker_CorrectBadDates 'KenticoCMS_PRD_1', 'HFit_TrackerBMI', '2015-12-04 18:00:00', 'NO'  ;
CREATE PROCEDURE proc_Tracker_CorrectBadDates (
       @SvrName AS NVARCHAR (250) 
     , @TblName AS NVARCHAR (250) 
     , @NewDate AS NVARCHAR (250) 
     , @ItemIDs AS NVARCHAR (4000) 
     , @Preview AS NVARCHAR (10) = 'YES') 
AS
BEGIN

/*--------------------------------------------------------------------------------------
Author:	  W. Dale Miller
Date:	  12.22.2015
Purpose:	  Correct bad dates contained within Tracker data.
Usage:	  If ItemIDs are supplied, only corrections are supplied to the specific ItemIDs.
		  Else, corrections are supplied to BAD dates before 1960.
*/
    DECLARE
           @MySql AS NVARCHAR (MAX) = '';

    SET @MySql = 'UPDATE [' + @SvrName + ' ].dbo.[' + @TblName + ']' + char (10) ;
    SET @MySql = @MySql + '    set EventDate = ''' + @NewDate + '''' + char (10) ;
    IF @ItemIDs IS NOT NULL
        BEGIN
            SET @MySql = @MySql + '    where ItemID in ( ' + @ItemIDs + ')';
        END
    ELSE
        BEGIN
            SET @MySql = @MySql + '    where EventDate < ''01-01-1960'' AND ItemCreatedBy <> 53 AND TrackerCollectionSourceID = 4;';
        END;

    BEGIN TRANSACTION TrackerFix;

    BEGIN TRY
        IF @Preview = 'NO'
            BEGIN
                EXEC (@MySql) ;
                PRINT 'FIX SUCCESSFUL - LOG THE DETAILS here.';
            END ;
        ELSE
            BEGIN
                PRINT 'Preview: ' + @MySql;
            END;
        COMMIT TRANSACTION TrackerFix;
    END TRY
    BEGIN CATCH
        PRINT 'NOTIFY A DBA OF A FAILURE HERE and the DETAILS.';
        PRINT @MySql;
        ROLLBACK TRANSACTION TrackerFix;
    END CATCH;

END;
GO
PRINT 'Executed proc_Tracker_CorrectBadDates.sql';
GO

--SELECT
--       'Update [KenticoCMS_PRD_3].[dbo].[HFit_TrackerBloodPressure] set Eventdate = ' + char (39) + '2015-12-04 18:00:00' + char (39) + ' where itemid =' + cast (ItemID AS NVARCHAR (10)) 
--       FROM KenticoCMS_PRD_3.dbo.HFit_TrackerBloodPressure
--       WHERE
--       EventDate < '01-01-1960' AND ItemCreatedBy <> 53 AND TrackerCollectionSourceID = 4;
--SELECT
--       'Update [KenticoCMS_PRD_3].[dbo].[HFit_TrackerBMI] set Eventdate = ' + char (39) + '2015-12-04 18:00:00' + char (39) + ' where itemid =' + cast (ItemID AS NVARCHAR (10)) 
--       FROM KenticoCMS_PRD_3.dbo.HFit_TrackerBMI
--       WHERE
--       EventDate < '01-01-1960' AND
--       ItemCreatedBy <> 53 AND
--       TrackerCollectionSourceID = 4;
--SELECT
--       'Update [KenticoCMS_PRD_3].[dbo].[HFit_TrackerCholesterol] set Eventdate = ' + char (39) + '2015-12-04 18:00:00' + char (39) + ' where itemid =' + cast (ItemID AS NVARCHAR (10)) 
--       FROM KenticoCMS_PRD_3.dbo.HFit_TrackerCholesterol
--       WHERE
--       EventDate < '01-01-1960' AND
--       ItemCreatedBy <> 53 AND
--       TrackerCollectionSourceID = 4;
--SELECT
--       'Update [KenticoCMS_PRD_3].[dbo].[HFit_TrackerHeight] set Eventdate = ' + char (39) + '2015-12-04 18:00:00' + char (39) + ' where itemid =' + cast (ItemID AS NVARCHAR (10)) 
--       FROM KenticoCMS_PRD_3.dbo.HFit_TrackerHeight
--       WHERE
--       EventDate < '01-01-1960' AND
--       ItemCreatedBy <> 53 AND
--       TrackerCollectionSourceID = 4;
--SELECT
--       'Update [KenticoCMS_PRD_3].[dbo].[HFit_TrackerBloodSugarAndGlucose] set Eventdate = ' + char (39) + '2015-12-04 18:00:00' + char (39) + ' where itemid =' + cast (ItemID AS NVARCHAR (10)) 
--       FROM KenticoCMS_PRD_3.dbo.HFit_TrackerBloodSugarAndGlucose
--       WHERE
--       EventDate < '01-01-1960' AND
--       ItemCreatedBy <> 53 AND
--       TrackerCollectionSourceID = 4;
--SELECT
--       'Update [KenticoCMS_PRD_3].[dbo].[HFit_TrackerWeight] set Eventdate = ' + char (39) + '2015-12-04 18:00:00' + char (39) + ' where itemid =' + cast (ItemID AS NVARCHAR (10)) 
--       FROM KenticoCMS_PRD_3.dbo.HFit_TrackerWeight
--       WHERE
--       EventDate < '01-01-1960' AND
--       ItemCreatedBy <> 53 AND
--       TrackerCollectionSourceID = 4;
--SELECT
--       'Update [KenticoCMS_PRD_3].[dbo].[HFit_TrackerCotinine] set Eventdate = ' + char (39) + '2015-12-04 18:00:00' + char (39) + ' where itemid =' + cast (ItemID AS NVARCHAR (10)) 
--       FROM KenticoCMS_PRD_3.dbo.HFit_TrackerWeight
--       WHERE
--       EventDate < '01-01-1960' AND
--       ItemCreatedBy <> 53 AND
--       TrackerCollectionSourceID = 4;
--SELECT
--       'Update [KenticoCMS_PRD_3].[dbo].[HFit_TrackerTests] set Eventdate = ' + char (39) + '2015-12-04 18:00:00' + char (39) + ' where itemid =' + cast (ItemID AS NVARCHAR (10)) 
--       FROM KenticoCMS_PRD_3.dbo.HFit_TrackerWeight
--       WHERE
--       EventDate < '01-01-1960' AND
--       ItemCreatedBy <> 53 AND
--       TrackerCollectionSourceID = 4;