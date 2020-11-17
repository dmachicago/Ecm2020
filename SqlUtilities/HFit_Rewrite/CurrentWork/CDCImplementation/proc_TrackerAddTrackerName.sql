

-- use KenticoCMS_DataMart
-- use KenticoCMS_DataMart_2
GO
PRINT 'Executing proc_TrackerAddTrackerName.sql';
GO
IF EXISTS (SELECT name
             FROM sys.procedures
             WHERE name = 'proc_TrackerAddTrackerName') 
    BEGIN
        DROP PROCEDURE proc_TrackerAddTrackerName;
    END;
GO
-- exec proc_TrackerAddTrackerName
CREATE PROCEDURE proc_TrackerAddTrackerName
AS
BEGIN

/*-----------------------------------------------------------------------------------
Author:	  W. Dale Miller
Date:	  01.08.2016
Purpose:	  Modifies each tracker table such that it contains the column TrackerName. 
		  TrackerName is used in the Primary Keys of trackers and needs to be in 
		  all tracker tables.
*/

    DECLARE
      @TblName AS nvarchar (100) = '' , 
      @msg AS nvarchar (4000) = '' , 
      @cmd AS nvarchar (4000) = '' , 
      @TrackerName AS nvarchar (100) = '';

    DECLARE C CURSOR
        FOR SELECT table_name
              FROM information_Schema.tables
              WHERE(table_name LIKE 'BASE_HFit_Tracker%'
                 OR table_name LIKE 'FACT_HFit_Tracker%'
                 OR table_name LIKE 'BASE_HFit_ToDoSmallSteps'
                 OR table_name LIKE 'BASE_HFit_TrackerBloodPressure')
               AND table_name NOT LIKE '%_DEL'
               AND table_name NOT LIKE '%_CTVerHIST'
               AND table_name NOT LIKE '%_TrackerDef%'
               AND table_name NOT LIKE 'BASE_HFIT_Tracker'
               AND table_name NOT LIKE 'BASE_HFit_TrackerDef_Tracker'
               AND table_name NOT LIKE '%TESTDATA';
    --AND table_name NOT LIKE '%VerHist' 
    --AND table_name NOT LIKE '%_DEL';

    OPEN C;

    FETCH NEXT FROM C INTO @TblName;

    WHILE @@FETCH_STATUS = 0
        BEGIN

            SET @msg = 'Processing: ' + @TblName;
            EXEC PrintImmediate @msg;

            IF NOT EXISTS (SELECT column_name
                             FROM information_schema.columns
                             WHERE table_name = @TblName
                               AND column_name = 'TrackerName') 
                BEGIN
                    SET @msg = 'Modifying: ' + @TblName;
                    EXEC PrintImmediate @msg;
                    SET @cmd = 'Alter table ' + @TblName + ' add TrackerName nvarchar(100) null ';
                    BEGIN TRY EXEC (@cmd) ;
                    END TRY
                    BEGIN CATCH
                        SET @msg = 'FAILED TO Modify: ' + @TblName + ' : ' + @cmd;
                        EXEC PrintImmediate @msg;
                    END CATCH;
                END;
            IF EXISTS (SELECT column_name
                         FROM information_schema.columns
                         WHERE table_name = @TblName
                           AND column_name = 'TrackerName') 
                BEGIN
                    SET @TrackerName = REPLACE (@TblName , 'BASE_' , '') ;
                    SET @TrackerName = REPLACE (@TblName , 'FACT_' , '') ;
                    SET @cmd = 'Update ' + @TblName + ' set TrackerName = ''' + @TrackerName + ''' where  TrackerName is null ';
                    EXEC PrintImmediate @cmd;
                    BEGIN TRY EXEC (@cmd) ;
                    END TRY
                    BEGIN CATCH
                        SET @msg = 'FAILED TO UPDATE: ' + @TblName + ' : ' + @cmd;
                        EXEC PrintImmediate @msg;
                    END CATCH;
                END;
            FETCH NEXT FROM C INTO @TblName;
        END;

    CLOSE C;
    DEALLOCATE C;
END;

GO
PRINT 'Executed proc_TrackerAddTrackerName.sql';
GO
