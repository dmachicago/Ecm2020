

GO
PRINT 'Executing proc_ConvertBigintToInt.sql';
GO
IF EXISTS (SELECT
                  name
                  FROM sys.procedures
                  WHERE
                  name = 'proc_ConvertBigintToInt') 
    BEGIN
        DROP PROCEDURE
             proc_ConvertBigintToInt;
    END;
GO

-- exec proc_ConvertBigintToInt HFit_HealthAssesmentUserStarted
CREATE PROCEDURE proc_ConvertBigintToInt (
       @TblName AS NVARCHAR (100)) 
AS
BEGIN

/*------------------------------
AUTHOR:	  W. Dale Miller
CONTACT:	  WDaleMiller@gmail.com
DATE:	  12/19/2015
USE:		  
*/
    DECLARE
           @S AS NVARCHAR (MAX) = ''
         , @Col AS NVARCHAR (100) = ''
         , @msg AS NVARCHAR (100) = ''
         , @is_nullable AS NVARCHAR (50) = '';

    -- select * from information_Schema.columns where table_name = 'BASE_HFit_HealthAssesmentUserStarted' 

    DECLARE C CURSOR
        FOR SELECT
                   column_name
                 , is_nullable
                   FROM information_Schema.columns
                   WHERE
                   table_name = @TblName AND
                   data_type = 'bigint' AND
                   column_name != 'SYS_CHANGE_VERSION' AND
                   column_name != 'ExceptionID' AND
                   column_name NOT LIKE '%_SCV' and column_name NOT LIKE 'SurrogateKey_%';

    OPEN C;

    FETCH NEXT FROM C INTO @Col , @is_nullable;

    WHILE
           @@FETCH_STATUS = 0
        BEGIN

            SET @S = 'ALter TABLE ' + @TblName + ' alter column ' + @Col + ' int ';
            IF
                   @is_nullable = 'YES'
                BEGIN
                    SET @S = @S + ' NULL ';
                END;
            ELSE
                BEGIN
                    SET @S = @S + ' NOT NULL ';
                END;
            SET @msg = 'Modify BIGINT: ' + @S;
            EXEC PrintImmediate @msg;
            EXEC (@S) ;
            FETCH NEXT FROM C INTO @Col , @is_nullable;
        END;
    CLOSE C;
    DEALLOCATE C;

END;

GO
PRINT 'Executed proc_ConvertBigintToInt.sql';
GO
