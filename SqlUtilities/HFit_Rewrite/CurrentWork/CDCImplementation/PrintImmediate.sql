

-- use KenticoCMS_1
use [DFINAnalytics];
GO
PRINT 'Executing PrintImmediate.sql';
GO
IF EXISTS (SELECT
                  name
                  FROM sys.procedures
                  WHERE name = 'PrintImmediate') 
    BEGIN
        DROP PROCEDURE
             PrintImmediate
    END;
GO

CREATE PROCEDURE PrintImmediate (
       @MSG AS NVARCHAR (MAX)) 
AS
BEGIN
    RAISERROR (@MSG , 10, 1) WITH NOWAIT;
END;
GO
PRINT 'Executed PrintImmediate.sql';
GO
