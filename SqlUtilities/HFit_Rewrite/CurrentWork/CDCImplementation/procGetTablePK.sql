
-- use KenticoCMS_DataMart_2
/*
SELECT column_name
FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE OBJECTPROPERTY(OBJECT_ID(CONSTRAINT_SCHEMA + '.' + CONSTRAINT_NAME), 'IsPrimaryKey') = 1
AND TABLE_NAME = 'BASE_HFIT_Tracker' AND TABLE_SCHEMA = 'dbo'
order by Ordinal_Position
*/

GO
PRINT 'Executing procGetTablePK.sql';
GO
IF EXISTS (SELECT
                  *
                  FROM   sys.procedures
                  WHERE  name = 'procGetTablePK') 
    BEGIN
        PRINT 'Replacing function procGetTablePK';
        DROP PROCEDURE
             procGetTablePK;
    END;

GO
/*-----------------------------------------------------------
declare @MySql as nvarchar(2000) = '' ;
declare @InstanceName as nvarchar(50) = 'KenticoCMS_1'
declare @TblName as nvarchar(50) = 'BASE_HFIT_Tracker'
--exec @MySql = procGetTablePK @InstanceName, @TblName, @PK OUT
declare @PK as nvarchar(2000) = null ;
exec procGetTablePK 'KenticoCMS_DataMart_2', 'BASE_HFit_TrackerCardio', @PK OUT
print '@PK: ' + @PK ;
set @MySql = @PK ;
print @MySql ;
*/
CREATE PROCEDURE dbo.procGetTablePK (
     @InstanceName nvarchar (100) 
   , @TblName nvarchar (100) 
   , @PK nvarchar (2000) OUT) 
AS
BEGIN
    --W. Dale Miller
    --June 20, 2012
    DECLARE @COL AS nvarchar (2000) = '';
    DECLARE @MyPK AS nvarchar (2000) = '';
    DECLARE @S AS nvarchar (max) = '';

    IF CURSOR_STATUS ('global', 'PCursor') >= -1
        BEGIN
            DEALLOCATE PCursor;
        END;

    --SET @S = 'DECLARE PCursor CURSOR ' + CHAR (10) ;
    --SET @S = @S + ' FOR ' + CHAR (10) ;
    --SET @S = @S + '     SELECT ' + CHAR (10) ;
    --SET @S = @S + '            COLUMN_NAME ' + CHAR (10) ;
    --SET @S = @S + '            FROM ' + @InstanceName + '.INFORMATION_SCHEMA.KEY_COLUMN_USAGE ' + CHAR (10) ;
    --SET @S = @S + '              WHERE OBJECTPROPERTY (OBJECT_ID (CONSTRAINT_SCHEMA + ' + '''.''' + ' + CONSTRAINT_NAME) , ''IsPrimaryKey'') = 1 ' + CHAR (10) ;
    --SET @S = @S + '               AND TABLE_NAME = ''' + @TblName + '''' + CHAR (10) ;
    --SET @S = @S + '               AND TABLE_SCHEMA = ''dbo''' + CHAR (10) ;

    SET @S = 'DECLARE PCursor CURSOR FOR ' + CHAR (10) ;
    SET @S = @S + ' SELECT column_name ' + CHAR (10) ;
    SET @S = @S + ' FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS AS TC ' + CHAR (10) ;
    SET @S = @S + ' INNER JOIN ' + CHAR (10) ;
    SET @S = @S + ' INFORMATION_SCHEMA.KEY_COLUMN_USAGE AS KU ' + CHAR (10) ;
    SET @S = @S + ' ON TC.CONSTRAINT_TYPE = ''PRIMARY KEY'' AND ' + CHAR (10) ;
    SET @S = @S + ' TC.CONSTRAINT_NAME = KU.CONSTRAINT_NAME ' + CHAR (10) ;
    SET @S = @S + ' and ku.table_name=''' + @TblName + ''' ' + CHAR (10) ;
    SET @S = @S + ' ORDER BY KU.TABLE_NAME, KU.ORDINAL_POSITION; ' + CHAR (10) ;
   
    --print @S

    EXEC (@S) ;

    OPEN PCursor;
    FETCH NEXT FROM PCursor INTO @COL;
    IF @@FETCH_STATUS <> 0
        BEGIN
            PRINT 'No PKs found';
            RETURN '';
        END;

    WHILE @@FETCH_STATUS = 0
        BEGIN
            SELECT
                   @MyPK = @MyPK + @COL + ',';
            --PRINT @MyPK;
            FETCH NEXT FROM PCursor INTO @COL;
        END;

    CLOSE PCursor;
    DEALLOCATE PCursor;
    IF LEN (@MyPK) > 0
        BEGIN
            DECLARE @k AS int = LEN (@MyPK) ;
            SET @MyPK = SUBSTRING (@MyPK, 1, @k - 1) ;
        END;
    SET @PK = @MyPK;
END;
GO
PRINT 'Executed procGetTablePK.sql';
GO

