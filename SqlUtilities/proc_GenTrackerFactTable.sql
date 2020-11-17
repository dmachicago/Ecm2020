
-- proc_GenTrackerFactTable
GO
PRINT 'Executing proc_GenTrackerFactTable.sql';
GO

IF EXISTS (SELECT
                  name
                  FROM sys.procedures
                  WHERE
                  name = 'proc_GenTrackerFactTable') 
    BEGIN
        DROP PROCEDURE
             proc_GenTrackerFactTable
    END;

GO
-- exec proc_GenTrackerFactTable
CREATE PROCEDURE proc_GenTrackerFactTable
AS
BEGIN
    DECLARE
           @column_name AS NVARCHAR (100) = '';
    DECLARE
           @data_type AS NVARCHAR (100) = '';
    DECLARE
           @Character_Maximum_Length AS INT = 0;
    DECLARE
           @MySql AS NVARCHAR (MAX) = '';
    DECLARE
           @i AS INT = 0;
    SET @MySql = 'BEGIN TRY ' + CHAR (10) ;
    SET @MySql = @MySql + '    DROP table FACT_TrackerData ' + CHAR (10) ;
    SET @MySql = @MySql + 'END TRY ' + CHAR (10) ;
    SET @MySql = @MySql + 'BEGIN Catch ' + CHAR (10) ;
    SET @MySql = @MySql + '    PRINT ''NO DROP...''' + CHAR (10) ;
    SET @MySql = @MySql + 'END Catch ' + CHAR (10) ;

    SET @MySql = @MySql + 'Create table FACT_TrackerData ( TrackerName nvarchar(100) , ' + CHAR (10) ;

    DECLARE C CURSOR
        FOR
            SELECT DISTINCT
                   column_name
                 , data_type
                 , Character_Maximum_Length
                   FROM information_schema.columns
                   WHERE
                   table_name LIKE 'BASE_HFit_Tracker%' AND
                   table_name NOT LIKE '%_del' AND
                   table_name NOT LIKE '%_CTVerHIST'
                   ORDER BY
                            column_name , data_type;

    OPEN C;
    FETCH NEXT FROM C
    INTO @column_name , @data_type , @Character_Maximum_Length;

    WHILE
           @@FETCH_STATUS = 0
        BEGIN
            SET @i = @i + 1;
            IF @i = 1
                BEGIN
                    SET @MySql = @MySql + '    ' + @column_name + ' ' + @data_type;
                    IF
                           @Character_Maximum_Length > 0
                        BEGIN
                            SET @MySql = @MySql + ' (' + CAST (@Character_Maximum_Length AS NVARCHAR (50)) + ')';
                        END;
                    SET @MySql = @MySql + ' NULL ' + CHAR (10) ;
                END ;
            ELSE
                BEGIN
                    SET @MySql = @MySql + '    ,' + @column_name + ' ' + @data_type;
                    IF
                           @Character_Maximum_Length > 0
                        BEGIN
                            SET @MySql = @MySql + ' (' + CAST (@Character_Maximum_Length AS NVARCHAR (50)) + ')';
                        END;
                    SET @MySql = @MySql + ' NULL ' + CHAR (10) ;
                END;
            --PRINT @column_name + ',' + @data_type + ',' + CAST (ISNULL (@Character_Maximum_Length , -1) AS NVARCHAR (50)) ;
            FETCH NEXT FROM C INTO @column_name , @data_type , @Character_Maximum_Length;
        END;
    SET @MySql = @MySql + ' )' + CHAR (10) ;
    CLOSE C;
    DEALLOCATE C;
    EXEC (@MySql) ;
    PRINT 'TABLE FACT_TrackerData successfully created.' ;
END;

GO
PRINT 'Executed proc_GenTrackerFactTable.sql';
GO

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
