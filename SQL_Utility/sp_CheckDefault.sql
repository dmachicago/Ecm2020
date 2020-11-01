
GO
USE master;
GO

/*
declare @tbl  NVARCHAR(250), @col  NVARCHAR(250), @stmt NVARCHAR(2000);

set @tbl = 'ActiveDirUser' ;
set  @col = 'RowGuid' ;
set  @stmt  = 'ALTER TABLE [dbo].[ActiveDirUser] ADD  CONSTRAINT [DF__ActiveDir__RowGu__1590259A]  DEFAULT (newid()) FOR [RowGuid]' ;
exec sp_CheckDefault @tbl, @col, @stmt ;
*/

IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'sp_CheckDefault'
)
    DROP PROCEDURE sp_CheckDefault;
GO
CREATE PROCEDURE sp_CheckDefault
(@tbl  NVARCHAR(250), 
 @col  NVARCHAR(250), 
 @stmt NVARCHAR(2000)
)
AS
    BEGIN
        IF EXISTS
        (
            SELECT *
            FROM information_schema.columns
            WHERE table_name = @tbl
                  AND column_name = @col
                  --and Table_schema = 'dbo'
                  AND column_default IS NULL
        )
            BEGIN
                BEGIN TRY
                    EXECUTE sp_executesql @stmt;
        END TRY
                BEGIN CATCH
                    PRINT ERROR_NUMBER();
                    PRINT ERROR_MESSAGE();
        END CATCH;
        END;
    END;

