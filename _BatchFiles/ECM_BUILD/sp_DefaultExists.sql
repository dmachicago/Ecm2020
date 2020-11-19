--D. Miller July 1012
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'sp_AddDefault'
)
    DROP PROCEDURE sp_AddDefault;
GO
--exec sp_AddDefault 'Retention', 'RowGuid'
CREATE PROCEDURE sp_AddDefault
(@TBL     NVARCHAR(250), 
 @COL     NVARCHAR(250), 
 @default NVARCHAR(250)
)
AS
    BEGIN
        DECLARE @CMD NVARCHAR(4000)= '';
        IF NOT EXISTS
        (
            SELECT 1
            FROM sys.tables
            WHERE name = @TBL
        )
            BEGIN
                SET @CMD = 'NOTICE: Table ' + @TBL + ' not found in DB ' + DB_NAME();
                PRINT @CMD;
                RETURN 0;
        END

        IF NOT EXISTS
        (
            SELECT 1
            FROM INFORMATION_SCHEMA.COLUMNS
            WHERE COLUMN_NAME = @COL
                  AND TABLE_NAME = @TBL
        )
            BEGIN
                SET @CMD = 'NOTICE: Table ' + @TBL + ' does not contain column ' + @COL + ' in DB ' + DB_NAME();
                PRINT @CMD;
                RETURN 0;
        END;

		declare @ix int = 0;
		exec @ix = sp_DefaultExists @TBL, @COL ;

		if @ix = 1 
		begin
			SET @CMD = 'NOTICE: Table ' + @TBL + ' and column ' + @COL + ' in DB ' + DB_NAME() + ' already has a default assigned.';
			PRINT @CMD;
			return ;
		end

        SET @CMD = 'alter table ' + @TBL + ' ADD DEFAULT(' + @default + ') FOR ' + @COL + ';';
        PRINT @CMD;
        BEGIN TRY
            EXEC sp_executesql 
                 @CMD;
        END TRY
        BEGIN CATCH
			declare @msg nvarchar(4000) = '' ;
            PRINT 'NOTICE: Default set for ' + @TBL + ' : ' + @COL + ' = ' + @default;
			set @msg = (SELECT ERROR_MESSAGE() );
            PRINT (@msg);			
        END CATCH;
    END;
GO
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'sp_DefaultExists'
)
    DROP PROCEDURE sp_DefaultExists;
GO

--exec sp_DefaultExists 'Retention', 'RowGuid'
CREATE PROCEDURE sp_DefaultExists
(@TBL NVARCHAR(250), 
 @COL NVARCHAR(250)
)
AS
    BEGIN
        DECLARE @I AS INTEGER= 0;
        SET @I =
        (
            SELECT COUNT(*)
            FROM sys.default_constraints AS d
                 INNER JOIN sys.columns AS c ON d.parent_object_id = c.object_id
                                                AND d.parent_column_id = c.column_id
            WHERE d.parent_object_id = OBJECT_ID(@TBL, N'U')
                  AND c.name = @COL
        );
        PRINT @I;
        RETURN @I;
    END;
GO