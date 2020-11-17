-- table variable to store procedure names
DECLARE
       @v TABLE (
                RecID INT IDENTITY (1 , 1) 
              , spname SYSNAME) ;

-- retrieve the list of stored procedures
INSERT INTO @v (
       spname) 
SELECT
       '[' + s.name + '].[' + sp.name + ']'
FROM
     sys.procedures AS sp
     INNER JOIN sys.schemas AS s
     ON
       s.schema_id = sp.schema_id
WHERE
       is_ms_shipped = 0;

-- counter variables
DECLARE
       @cnt INT
     , @Tot INT;
SELECT
       @cnt = 1;
SELECT
       @Tot = COUNT (*) 
FROM @v;

DECLARE
       @spname SYSNAME;

-- start the loop
WHILE @Cnt <= @Tot
    BEGIN
        SELECT
               @spname = spname
        FROM @v
        WHERE RecID = @Cnt;

        PRINT 'refreshing...' + @spname;

        BEGIN TRY
            -- refresh the stored procedure
            EXEC sp_refreshsqlmodule @spname;
        END TRY
        BEGIN CATCH
            PRINT 'Validation failed for : ' + @spname + ', Error:' + ERROR_MESSAGE () ;
        END CATCH;
        SET @Cnt = @cnt + 1;
    END;
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
