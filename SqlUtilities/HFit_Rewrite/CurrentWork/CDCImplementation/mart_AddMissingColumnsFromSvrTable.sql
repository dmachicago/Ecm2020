

-- use KenticoCMS_Datamart_2
--mart_AddMissingColumnsFromSvrTable

GO
PRINT 'Executing mart_AddMissingColumnsFromSvrTable.sql';
GO
IF EXISTS (SELECT
                  name
           FROM sys.procedures
           WHERE
                  name = 'mart_AddMissingColumnsFromSvrTable') 
    BEGIN
        DROP PROCEDURE
             mart_AddMissingColumnsFromSvrTable;
    END;
GO

/*---------------------------------------------------------------
use KenticoCMS_Datamart_2
go
exec mart_AddMissingColumnsFromSvrTable  
    @PullFromInstanceName = 'KenticoCMS_3'
    , @BaseTableName = 'BASE_HFit_RewardsUserSummaryArchive'
    , @PullTableName = 'HFit_RewardsUserSummaryArchive'
    ,@PreviewOnly = 1

select * from information_schema.columns where table_name = 'BASE_HFit_RewardsUserSummaryArchive'

*/
CREATE PROCEDURE mart_AddMissingColumnsFromSvrTable (
       @PullFromInstanceName AS NVARCHAR (250) 
     , @BaseTableName AS NVARCHAR (250) 
     , @PullTableName AS NVARCHAR (250)
	   , @PreviewOnly as bit = 0) 
AS
BEGIN

    -- use KenticoCMS_Datamart_2

    --DECLARE
    --     @PullFromInstanceName AS NVARCHAR (250) = 'KenticoCMS_3'
    --   , @BaseTableName AS NVARCHAR (250) = 'BASE_HFit_RewardsUserSummaryArchive'
    --   , @PullTableName AS NVARCHAR (250) = 'HFit_RewardsUserSummaryArchive' ;

    DECLARE
         @mysql AS NVARCHAR (MAX) 
       , @TempColTbl AS NVARCHAR (250) = 'HFit_RewardsUserSummaryArchive';

    SET @TempColTbl = 'TempCol_' + @BaseTableName;
    IF EXISTS (SELECT
                      name
               FROM sys.tables
               WHERE
                      name = @TempColTbl) 
        BEGIN
            SET @MySQl = 'drop table ' + @TempColTbl;
            EXEC (@MySql) ;
        END;

    IF NOT EXISTS (SELECT
                          column_name
                   FROM information_schema.columns
                   WHERE
                          table_name = @BaseTableName AND
                          column_name = 'CT_RowDataUpdated') 
        BEGIN
            SET @mysql = 'Alter table ' + @BaseTableName + ' add CT_RowDataUpdated bit null default 1 ';
        END;

    --IF OBJECT_ID ('tempdb..#TempPullFromBaseTbl') IS NOT NULL
    --    BEGIN DROP TABLE
    --               #TempPullFromBaseTbl;
    --    END;
    IF OBJECT_ID ('tempdb..#TempBaseTbl') IS NOT NULL
        BEGIN DROP TABLE
                   #TempBaseTbl;
        END;

    SET @MySql = 'SELECT ' + CHAR (10) + '       COLUMN_NAME ' + CHAR (10) + '     , IS_NULLABLE ' + CHAR (10) + '     , DATA_TYPE ' + CHAR (10) + '     , CHARACTER_MAXIMUM_LENGTH  INTO ' + CHAR (10) + '              ' + @TempColTbl + CHAR (10) + '       FROM ' + @PullFromInstanceName + '.information_schema.columns ' + CHAR (10) + 'WHERE ' + CHAR (10) + '              table_name = ''' + @PullTableName + ''' AND ' + CHAR (10) + '       TABLE_SCHEMA = ''dbo'' AND column_name NOT IN ( ' + CHAR (10) + '       SELECT ' + CHAR (10) + '              column_name ' + CHAR (10) + 'FROM information_schema.columns ' + CHAR (10) + '       WHERE ' + CHAR (10) + '       table_name = ''' + @BaseTableName + ''' AND ' + CHAR (10) + '              TABLE_SCHEMA = ''dbo'' ' + CHAR (10) + '       ) ' + CHAR (10) ;
    print @MySql ;
    EXEC (@MySql) ;

    --set @MySql = 'select * from ' + @TempColTbl;
    --print @MySql ;
    --exec (@MySql ) ;

    SELECT
           COLUMN_NAME
         , IS_NULLABLE
         , DATA_TYPE
         , CHARACTER_MAXIMUM_LENGTH  INTO
                                          #TempBaseTbl
    FROM information_schema.columns
    WHERE
           table_name = @BaseTableName AND
           TABLE_SCHEMA = 'dbo';

    DECLARE
         @COLUMN_NAME AS NVARCHAR (250) 
       , @IS_NULLABLE AS NVARCHAR (50) 
       , @DATA_TYPE AS NVARCHAR (50) 
       , @CHARACTER_MAXIMUM_LENGTH AS INT
       , @T AS NVARCHAR (250) = ''
       , @Msg AS NVARCHAR (MAX) = ''
       , @i AS INT = 0
       , @j AS INT = 0;

    set @MySql = 
    'DECLARE C CURSOR ' + char(10) +
    '    FOR ' + char(10) +
    '        SELECT ' + char(10) +
    '               COLUMN_NAME ' + char(10) +
    '             , IS_NULLABLE ' + char(10) +
    '             , DATA_TYPE ' + char(10) +
    '             , CHARACTER_MAXIMUM_LENGTH ' + char(10) +
    '        FROM ' + @TempColTbl;
    exec (@MySql) ; 

    OPEN C;
    FETCH NEXT FROM C INTO @COLUMN_NAME , @IS_NULLABLE , @DATA_TYPE , @CHARACTER_MAXIMUM_LENGTH;

    WHILE
           @@FETCH_STATUS = 0
        BEGIN
            SET @i = (SELECT
                             COUNT (1) 
                      FROM information_schema.columns
                      WHERE
                             table_name = @BaseTableName AND
                             column_name = @COLUMN_NAME) ;
            IF @i = 0
                BEGIN
                    BEGIN TRY
                        SET @MySql = 'Alter table ' + @BaseTableName + ' add ' + @COLUMN_NAME + ' ' + @DATA_TYPE + ' NULL';
				    if @PreviewOnly = 0 
                        EXEC (@MySql) ;
                        SET @Msg = 'SUCCESS: ' + @MySql;
                        EXEC PrintImmediate @MySql;
                    END TRY
                    BEGIN CATCH
                        SET @Msg = 'ERROR: ' + @MySql;
                        EXEC PrintImmediate @msg;
                    END CATCH;

                END;
            FETCH NEXT FROM C INTO @COLUMN_NAME , @IS_NULLABLE , @DATA_TYPE , @CHARACTER_MAXIMUM_LENGTH;
        END;

    CLOSE C;
    DEALLOCATE C;

	    IF EXISTS (SELECT
                      name
               FROM sys.tables
               WHERE
                      name = @TempColTbl) 
        BEGIN
            SET @MySQl = 'drop table ' + @TempColTbl;
            EXEC (@MySql) ;
        END;

END;
GO
PRINT 'Executed mart_AddMissingColumnsFromSvrTable.sql';
GO
