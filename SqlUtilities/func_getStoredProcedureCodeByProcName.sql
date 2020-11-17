-- W. Dale Miller @ 2015
--************************************************************************
-- exec 

IF EXISTS ( SELECT 1
            FROM sys.procedures
            WHERE name = 'UTIL_GetSpCode'
          ) 
    BEGIN
        DROP PROCEDURE UTIL_GetSpCode;
END;
GO

-- HOW TO EXECUTE THE PROC AND GET THE CODE
/*
declare @ProcSQL nvarchar(max);
exec UTIL_GetSpCode @DBName ='master', @Schema = 'dbo' , @PName = 'UTIL_MonitorWorkload', @sql = @ProcSQL output;
print '@ProcSQL: ' + char(10) + @ProcSQL;
select @ProcSQL;
*/

CREATE PROCEDURE UTIL_GetSpCode ( 
                 @DBName NVARCHAR(100) , 
                 @Schema NVARCHAR(100) , 
                 @PName  NVARCHAR(100) , 
                 @sql    NVARCHAR(MAX) OUTPUT
                                ) 
AS
    BEGIN
        BEGIN
            --DECLARE @val VARCHAR(MAX);
            DECLARE @table TABLE ( 
                                 val VARCHAR(MAX)
                                 );
            DECLARE @FQN NVARCHAR(500)= @DBname + '.' + @Schema + '.' + @PName;
            INSERT INTO @table
            EXEC sp_helptext @FQN;
            SELECT @sql = COALESCE(@sql , '') + val
            FROM @table;
            RETURN;
        END;
        --print @val
        --************************************************************************
        -- HOW TO EXECUTE THE PROC AND GET THE CODE
		-- W. Dale Miller @ 2015
		/*
		declare @ProcSQL nvarchar(max);
		exec UTIL_GetSpCode @DBName ='master', @Schema = 'dbo' , @PName = 'UTIL_MonitorWorkload', @sql = @ProcSQL output;
		print '@ProcSQL: ' + char(10) + @ProcSQL;
		select @ProcSQL;
		*/

    END;