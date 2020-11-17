
--USE DFINAnalytics;
GO

/*
select * from [DFS_SequenceTABLE]
*/

IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.TABLES
    WHERE TABLE_NAME = 'DFS_SequenceTABLE'
)
    BEGIN
        CREATE TABLE [dbo].[DFS_SequenceTABLE]
        ([ID] [BIGINT] IDENTITY(1, 1) NOT NULL,
        )
        ON [PRIMARY];
        CREATE UNIQUE INDEX pk_SequenceTABLE ON DFS_SequenceTABLE(id);
END;
GO

IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'UTIL_GetSeq'
)
    DROP PROCEDURE UTIL_GetSeq;
GO

-- select * from dbo.DFS_SequenceTABLE
-- exec UTIL_GetSeq
CREATE PROCEDURE UTIL_GetSeq
AS
    BEGIN
        DECLARE @id BIGINT;
        INSERT INTO dbo.DFS_SequenceTABLE WITH(TABLOCKX)
        DEFAULT VALUES;
        --Return the latest IDENTITY value.
        SET @id =
        (
            SELECT MAX(id)
            FROM dbo.DFS_SequenceTABLE
        );
        RETURN @id;
    END;

