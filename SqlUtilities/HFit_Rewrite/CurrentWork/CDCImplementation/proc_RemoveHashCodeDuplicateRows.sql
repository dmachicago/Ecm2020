

PRINT 'Executing proc_RemoveHashCodeDuplicateRows.sql';
GO
IF EXISTS (SELECT name
             FROM sys.procedures
             WHERE name = 'proc_RemoveHashCodeDuplicateRows') 
    BEGIN
        DROP PROCEDURE proc_RemoveHashCodeDuplicateRows;
    END;
GO

-- exec proc_RemoveHashCodeDuplicateRows 'BASE_View_HFit_ChallengeRegistrationEmail_Joined'
-- exec proc_RemoveHashCodeDuplicateRows 'BASE_View_OM_ContactGroupMember_User_ContactJoined', 1
-- EXEC proc_RemoveHashCodeDuplicateRows 'BASE_View_OM_ContactGroupMember_User_ContactJoined',0 
CREATE PROCEDURE proc_RemoveHashCodeDuplicateRows (@TblName AS nvarchar (250) , 
                                                   @ShowSQL AS bit = 0) 
AS
BEGIN

    DECLARE
          @MySql nvarchar (max) = '';

    SET @MySql = 'WITH CTE (
         DBNAME
       , HashCode
       , DuplicateCount) 
        AS (
        SELECT
               DBNAME
             , HashCode
             ,ROW_NUMBER () OVER (PARTITION BY DBNAME
                                             , HashCode ORDER BY DBNAME , HashCode) AS DuplicateCount
        FROM ' + @TblName + '
        ) 
        delete
        FROM CTE
        WHERE
               DuplicateCount > 1 ';
    IF @ShowSQL = 1
        BEGIN
            PRINT @MySql;
        END;
    ELSE
        BEGIN EXEC (@MySql) ;
            DECLARE
                  @NBR AS bigint = @@ROWCOUNT;
            PRINT CAST (@NBR AS nvarchar (50)) + ' duplicates found and removed from ' + @TblName;
        END;
END;

GO
PRINT 'Executed proc_RemoveHashCodeDuplicateRows.sql';
GO

/*
WITH CTE (
         DBNAME
       , HashCode
       , DuplicateCount) 
        AS (
        SELECT
               DBNAME
             , HashCode
             ,ROW_NUMBER () OVER (PARTITION BY DBNAME
                                             , HashCode ORDER BY DBNAME , HashCode) AS DuplicateCount
        FROM BASE_View_OM_ContactGroupMember_User_ContactJoined
        ) 
        SELECT
               *
        INTO
             #TEMP_BASE_View_OM_ContactGroupMember_User_ContactJoined
        FROM CTE
        WHERE
               DuplicateCount > 1 

*/