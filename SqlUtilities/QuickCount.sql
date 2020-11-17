


GO
PRINT 'Creating QuickCount.sql';

GO
IF EXISTS ( SELECT
                   name
              FROM sys.procedures
              WHERE name = 'QuickCount' )
    BEGIN
        DROP PROCEDURE
             QuickCount
    END;
GO

/*
declare @i as bigint = 0 ;
EXEC @i = QuickCount 'Device_RawNotification' ;
print @i ;

    DECLARE
       @iTotal AS bigint = 0;

    EXEC @iTotal = QuickCount 'STAGING_EDW_RewardUserDetail';

    IF @iTotal = 1
        BEGIN
            SET @Reloadall = 1;
        END;

*/

CREATE PROCEDURE QuickCount ( @TblName AS nvarchar( 254 ), @TSchema AS nvarchar( 254 ) = null)
AS
BEGIN

    /*********************************************
    Author:	  Dale Miller
    Date:	  02.02.2008
    Copyright:  DMA, Ltd., Chicago, IL
    **********************************************/

	if @TSchema is not null 
	set @TblName = @TSchema+'.'+ @TblName ;

    DECLARE @i AS bigint = 0;

    SET @i = ( SELECT
                      SUM ( row_count )
                 FROM sys.dm_db_partition_stats
                 WHERE
                      object_id = OBJECT_ID( @TblName )
                  AND (
                      index_id = 0
                   OR index_id = 1));
    if @i is null
	   set @i = 0 ;
    PRINT @i;
    return @i ;
END;

GO
PRINT 'Created QuickCount.sql';
GO
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
