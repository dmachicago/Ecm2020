
--* USEDFINAnalytics;
GO

/*
select * from [SequenceTABLE]
*/

IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.TABLES
    WHERE TABLE_NAME = 'SequenceTABLE'
)
    BEGIN
 CREATE TABLE [dbo].[SequenceTABLE]
 ([ID] [BIGINT] IDENTITY(1, 1) NOT NULL,
 )
 ON [PRIMARY];
 CREATE UNIQUE INDEX pk_SequenceTABLE ON SequenceTABLE(id);
END;
GO
--* USEmaster;
GO
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'sp_UTIL_GetSeq'
)
    DROP PROCEDURE sp_UTIL_GetSeq;
GO

-- select * from dbo.SequenceTABLE
-- exec sp_UTIL_GetSeq
CREATE PROCEDURE sp_UTIL_GetSeq
AS
    BEGIN
 DECLARE @id BIGINT;
 INSERT INTO dbo.SequenceTABLE WITH(TABLOCKX)
 DEFAULT VALUES;
 --Return the latest IDENTITY value.
 SET @id =
 (
     SELECT MAX(id)
     FROM dbo.SequenceTABLE
 );
 RETURN @id;
    END;

