


GO
PRINT 'Creating proc_QuickRowCount.sql';

GO
IF EXISTS ( SELECT
                   name
              FROM sys.procedures
              WHERE name = 'proc_QuickRowCount' )
    BEGIN
        DROP PROCEDURE
             proc_QuickRowCount
    END;
GO

CREATE PROCEDURE proc_QuickRowCount ( @TblName AS nvarchar( 254 ), @TSchema AS nvarchar( 254 ) = null)
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
PRINT 'Created proc_QuickRowCount.sql';
GO
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

