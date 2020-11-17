
GO
PRINT 'Creating proc_QuickRowCount.sql';

GO
IF EXISTS ( SELECT
                   name
            FROM sys.procedures
            WHERE
                   name = 'proc_QuickRowCount') 
    BEGIN
        DROP PROCEDURE
             proc_QuickRowCount;
    END;
GO

/*----------------------------------------------------------------
use KenticoCMS_Datamart_2
declare @i as bigint = 0 ;
EXEC @i = proc_QuickRowCount 'Device_RawNotification' ;
print @i ;

    DECLARE
       @iTotal AS bigint = 0;

    EXEC @iTotal = proc_QuickRowCount 'FACT_EDW_RewardUserDetail';

    IF @iTotal = 1
        BEGIN
            SET @Reloadall = 1;
        END;
*/

CREATE PROCEDURE proc_QuickRowCount (
       @TblName AS NVARCHAR (254) 
     , @ShowRecCount AS BIT = 0) 
AS
BEGIN

/*-----------------------------------------------
    Author:	 Dale Miller
    Date:		 02.02.2008
    Copyright:  DMA, Ltd., Chicago, IL
*/
set NOCOUNT on
    DECLARE
           @i AS BIGINT = 0;

    SET @i = ( SELECT
                      SUM ( row_count) 
               FROM sys.dm_db_partition_stats
               WHERE
                      object_id = OBJECT_ID ( @TblName) AND
                      (
                        index_id = 0 OR
                        index_id = 1)) ;
    IF @i IS NULL
        BEGIN
            SET @i = 0
        END;
    IF
           @ShowRecCount = 1
        BEGIN
            PRINT @i
        END;
set NOCOUNT off
    RETURN @i;
END;

GO
PRINT 'Created proc_QuickRowCount.sql';
GO
