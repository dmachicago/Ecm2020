--* USEDFINAnalytics;
GO
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'PrintImmediate'
)
    DROP PROCEDURE PrintImmediate;
GO
CREATE PROCEDURE [dbo].[PrintImmediate](@MSG AS NVARCHAR(MAX))
AS
    BEGIN
 RAISERROR(@MSG, 10, 1) WITH NOWAIT;
    END;
GO
--* USEMASTER;
GO
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'sp_PrintImmediate'
)
    DROP PROCEDURE sp_PrintImmediate;
GO
CREATE PROCEDURE [dbo].[sp_PrintImmediate](@MSG AS NVARCHAR(MAX))
AS
    BEGIN
 RAISERROR(@MSG, 10, 1) WITH NOWAIT;
    END;
