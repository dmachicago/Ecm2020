

use master
/*
W. Dale Miller
CR @ July 26, 2015, DMA Limited
All rights to use and modify granted to DMA Limited's customers and clients.
This procedure causes a print statement to execute through an error interrupt and 
will print the passed in message without waiting for SQL Server to find time.
It is an immediate print
*/
GO
PRINT 'Executing sp_PrintImmediate.sql';
GO
IF EXISTS (SELECT
                  name
                  FROM sys.procedures
                  WHERE name = 'sp_PrintImmediate') 
    BEGIN
        DROP PROCEDURE
             sp_PrintImmediate
    END;
GO

CREATE PROCEDURE sp_PrintImmediate (
       @MSG AS NVARCHAR (MAX)) 
AS
BEGIN
    RAISERROR (@MSG , 10, 1) WITH NOWAIT;
END;
GO
PRINT 'Executed sp_PrintImmediate.sql';
GO

