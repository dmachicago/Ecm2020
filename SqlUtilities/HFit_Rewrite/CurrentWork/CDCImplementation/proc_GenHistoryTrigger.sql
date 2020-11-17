

-- USE [KenticoCMS_DataMart_2];
GO

/*--------------------------------------------------------------------------------------------------------------------------------
select top 100 * from FACT_EDW_HFit_HealthAssesmentUserRiskArea_Joined
update FACT_EDW_HFit_HealthAssesmentUserRiskArea_Joined set HARiskAreaVersionID = null where UserRiskAreaItemID between 220 and 230
delete from FACT_EDW_HFit_HealthAssesmentUserRiskArea_Joined where UserRiskAreaItemID = 220
Select * from FACT_EDW_HFit_HealthAssesmentUserRiskArea_Joined_HISTORY
SELECT COUNT (*) FROM FACT_EDW_HFit_HealthAssesmentUserRiskArea_Joined;

select * from information_schema.tables where table_name like 'BASE_View_HFit_Coach_Bio%'

exec proc_GenHistoryTrigger 'KenticoCMS_DataMart', 'BASE_View_HFit_Coach_Bio', 0
exec proc_GenHistoryTrigger 'KenticoCMS_DataMart', 'BASE_View_CMS_Tree_Joined', 1
exec proc_GenHistoryTrigger 'KenticoCMS_DataMart', 'FACT_EDW_CMS_USER', 0
exec proc_GenHistoryTrigger 'KenticoCMS_DataMart', 'FACT_EDW_CMS_USERSETTINGS', 1
exec proc_GenHistoryTrigger 'KenticoCMS_DataMart', 'FACT_EDW_CMS_USERSETTINGS', 0
*/

GO
IF EXISTS (SELECT
                  name
                  FROM sys.procedures
                  WHERE
                  name = 'proc_GenHistoryTrigger') 
    BEGIN
        DROP PROCEDURE
             proc_GenHistoryTrigger;
    END;

GO

CREATE PROCEDURE proc_GenHistoryTrigger (
       @InstanceName  AS NVARCHAR (100) 
     , @TblName AS NVARCHAR (100) 
     , @PrintOnly AS INT = 1) 
AS
BEGIN

    --DECLARE @InstanceName AS NVARCHAR (100) = 'KenticoCMS_DataMart';
    --DECLARE @TblName AS NVARCHAR (100) = 'FACT_EDW_CMS_USERSETTINGS';
    --DECLARE @PrintOnly AS INT = 0;

    DECLARE
           @TBL AS NVARCHAR (100) = @TblName;
    DECLARE
           @SQL1 AS NVARCHAR (MAX) = '';
    DECLARE
           @TSQL AS NVARCHAR (MAX) = '';

    SET @SQL1 = '';
    SET @SQL1 = @SQL1 + 'IF EXISTS (SELECT ' + CHAR (10) ;
    SET @SQL1 = @SQL1 + '                  name ' + CHAR (10) ;
    SET @SQL1 = @SQL1 + '                  FROM sys.tables ' + CHAR (10) ;
    SET @SQL1 = @SQL1 + '                  WHERE ' + CHAR (10) ;
    SET @SQL1 = @SQL1 + '                  name = ''' + @TBL + '_HISTORY'')  ' + CHAR (10) ;
    SET @SQL1 = @SQL1 + '    BEGIN ' + CHAR (10) ;
    SET @SQL1 = @SQL1 + '        DROP TABLE ' + CHAR (10) ;
    SET @SQL1 = @SQL1 + '             ' + @TBL + '_HISTORY; ' + CHAR (10) ;
    SET @SQL1 = @SQL1 + '    END; ' + CHAR (10) ;
print @SQL1 ;
    IF @PrintOnly = 0
        BEGIN
            EXEC (@SQL1) 
        END;
    SET @TSQL = @TSQL + @SQL1 + CHAR (10) ;
    SET @SQL1 = '';
    SET @SQL1 = @SQL1 + ' SELECT TOP 1 ' + CHAR (10) ;
    SET @SQL1 = @SQL1 + '        * INTO ' + CHAR (10) ;
    SET @SQL1 = @SQL1 + '               ' + @TBL + '_HISTORY ' + CHAR (10) ;
    SET @SQL1 = @SQL1 + '        FROM ' + @TBL + '; ' + CHAR (10) ;
    SET @TSQL = @TSQL + @SQL1 + CHAR (10) ;
print @SQL1 ;
    IF @PrintOnly = 0
        BEGIN
            EXEC (@SQL1) 
        END;

    SET @SQL1 = '';
    SET @SQL1 = @SQL1 + ' truncate TABLE ' + @TBL + '_HISTORY;  ' + CHAR (10) ;
    SET @TSQL = @TSQL + @SQL1 + CHAR (10) ;
print @SQL1 ;
    IF @PrintOnly = 0
        BEGIN
            EXEC (@SQL1) 
        END;

    SET @SQL1 = '';
    SET @SQL1 = @SQL1 + ' ALTER TABLE ' + @TBL + '_HISTORY ' + CHAR (10) ;
    SET @SQL1 = @SQL1 + ' ADD ' + CHAR (10) ;
    SET @SQL1 = @SQL1 + '             [action] CHAR (1) DEFAULT ''U''; ' + CHAR (10) ;
print @SQL1 ;
    IF @PrintOnly = 0
        BEGIN
            EXEC (@SQL1) 
        END;

    SET @SQL1 = '';
    SET @SQL1 = @SQL1 + ' ALTER TABLE ' + @TBL + '_HISTORY ' + CHAR (10) ;
    SET @SQL1 = @SQL1 + ' ADD ' + CHAR (10) ;
    SET @SQL1 = @SQL1 + '             action_date DATETIME DEFAULT GETDATE () ; ' + CHAR (10) ;
    SET @TSQL = @TSQL + @SQL1 + CHAR (10) ;
print @SQL1 ;
    IF @PrintOnly = 0
        BEGIN
            EXEC (@SQL1) 
        END;

    SET @SQL1 = '';
    SET @SQL1 = @SQL1 + ' IF EXISTS (SELECT ' + CHAR (10) ;
    SET @SQL1 = @SQL1 + '                   name ' + CHAR (10) ;
    SET @SQL1 = @SQL1 + '                   FROM sys.triggers ' + CHAR (10) ;
    SET @SQL1 = @SQL1 + '                   WHERE ' + CHAR (10) ;
    SET @SQL1 = @SQL1 + '                   name = ''TRIG_UPDT_' + @TBL + ''')  ' + CHAR (10) ;
    SET @SQL1 = @SQL1 + '     BEGIN ' + CHAR (10) ;
    SET @SQL1 = @SQL1 + '         DROP TRIGGER ' + CHAR (10) ;
    SET @SQL1 = @SQL1 + '              dbo.TRIG_UPDT_' + + @TBL + '; ' + CHAR (10) ;
    SET @SQL1 = @SQL1 + '     END; ' + CHAR (10) ;
    SET @TSQL = @TSQL + @SQL1 + CHAR (10) ;
print @SQL1 ;
    IF @PrintOnly = 0
        BEGIN
            EXEC (@SQL1) ;
        END;

    SET @SQL1 = '';

    IF @PrintOnly = 1
        BEGIN
            SET @SQL1 = @SQL1 + 'GO' + CHAR (10) ;
        END;
    SET @SQL1 = @SQL1 + ' CREATE TRIGGER dbo.TRIG_UPDT_' + @TBL + CHAR (10) ;
    SET @SQL1 = @SQL1 + ' ON dbo.' + @TBL + CHAR (10) ;
    SET @SQL1 = @SQL1 + '     AFTER UPDATE ' + CHAR (10) ;
    SET @SQL1 = @SQL1 + ' AS ' + CHAR (10) ;
    SET @SQL1 = @SQL1 + ' BEGIN ' + CHAR (10) ;
    SET @SQL1 = @SQL1 + '     INSERT INTO ' + @TBL + '_HISTORY ' + CHAR (10) ;
    SET @SQL1 = @SQL1 + '     ( ' + CHAR (10) ;

    DECLARE
           @COLS AS NVARCHAR (MAX) = '';
    DECLARE
           @ReturnedCols AS NVARCHAR (MAX) = NULL;

    EXEC @COLS = proc_GetTableColumnsCT @InstanceName , @TblName , @ReturnedCols OUT;
    SET @COLS = @ReturnedCols;

    --PRINT @COLS;

    SET @SQL1 = @SQL1 + @COLS + CHAR (10) ;
    SET @SQL1 = @SQL1 + '  ,Action   ) ' + CHAR (10) ;
    SET @SQL1 = @SQL1 + ' SELECT ' + CHAR (10) ;
    SET @SQL1 = @SQL1 + @COLS + CHAR (10) ;
    SET @SQL1 = @SQL1 + '         , ''U'' ' + CHAR (10) ;
    SET @SQL1 = @SQL1 + '            FROM inserted ' + CHAR (10) ;
    SET @SQL1 = @SQL1 + ' END; ' + CHAR (10) ;
    SET @TSQL = @TSQL + @SQL1 + CHAR (10) ;
print @SQL1 ;
    IF @PrintOnly = 0
        BEGIN
            EXEC (@SQL1) ;
        END;

    SET @SQL1 = ' ';
    IF @PrintOnly = 1
        BEGIN PRINT @SQL1;
        END;
    IF @PrintOnly = 1
        BEGIN PRINT @SQL1;
        END;
    IF @PrintOnly = 1
        BEGIN
            SET @SQL1 = @SQL1 + 'GO ' + CHAR (10) ;
        END;

    SET @SQL1 = @SQL1 + ' IF EXISTS (SELECT ' + CHAR (10) ;
    SET @SQL1 = @SQL1 + '                   name ' + CHAR (10) ;
    SET @SQL1 = @SQL1 + '                   FROM sys.triggers ' + CHAR (10) ;
    SET @SQL1 = @SQL1 + '                   WHERE ' + CHAR (10) ;
    SET @SQL1 = @SQL1 + '                   name = ''TRIG_DEL_' + @TBL + ''')  ' + CHAR (10) ;
    SET @SQL1 = @SQL1 + '     BEGIN ' + CHAR (10) ;
    SET @SQL1 = @SQL1 + '         DROP TRIGGER ' + CHAR (10) ;
    SET @SQL1 = @SQL1 + '              dbo.TRIG_DEL_' + @TBL + '; ' + CHAR (10) ;
    SET @SQL1 = @SQL1 + '     END; ' + CHAR (10) ;
    SET @TSQL = @TSQL + @SQL1 + CHAR (10) ;
print @SQL1 ;
    IF @PrintOnly = 0
        BEGIN
            EXEC (@SQL1) ;
        END;

    SET @SQL1 = '';
    IF @PrintOnly = 1
        BEGIN
            SET @SQL1 = @SQL1 + 'GO ' + CHAR (10) ;
        END;

    IF @PrintOnly = 1
        BEGIN
            SET @SQL1 = @SQL1 + 'GO' + CHAR (10) ;
        END;
    SET @SQL1 = @SQL1 + ' CREATE TRIGGER dbo.TRIG_DEL_' + @TBL + CHAR (10) ;
    SET @SQL1 = @SQL1 + ' ON dbo.' + @TBL + CHAR (10) ;
    SET @SQL1 = @SQL1 + '     FOR DELETE ' + CHAR (10) ;
    SET @SQL1 = @SQL1 + ' AS ' + CHAR (10) ;
    SET @SQL1 = @SQL1 + ' BEGIN ' + CHAR (10) ;
    SET @SQL1 = @SQL1 + '     INSERT INTO ' + + @TBL + '_HISTORY ' + CHAR (10) ;
    SET @SQL1 = @SQL1 + '     ( ' + CHAR (10) ;
    SET @SQL1 = @SQL1 + @COLS + CHAR (10) ;
    SET @SQL1 = @SQL1 + '  ,Action   ) ' + CHAR (10) ;
    SET @SQL1 = @SQL1 + '     SELECT ' + CHAR (10) ;
    SET @SQL1 = @SQL1 + @COLS + CHAR (10) ;
    SET @SQL1 = @SQL1 + '         , ''D'' ' + CHAR (10) ;
    SET @SQL1 = @SQL1 + '            FROM DELETED ;' + CHAR (10) ;
    SET @SQL1 = @SQL1 + ' END; ' + CHAR (10) ;
    IF @PrintOnly = 0
        BEGIN
            EXEC (@SQL1) ;
        END;

    IF @PrintOnly = 0
        BEGIN
            PRINT 'ADDING Triggers to ' + @TBL;
        END;
print '@SQL1: ' + @SQL1 ;
print '@TSQL : ' + @TSQL ;
    SET @TSQL = @TSQL + @SQL1 + CHAR (10) ;
    IF @PrintOnly = 1
        BEGIN
            SELECT
                   @TSQL;
        END;
print '@TSQL: '+ @TSQL ;
--else 
--begin
-- print 'EXECUTING SQL on: ' + @TBL ;
--exec (@TSQL) 
--end ;
END;
GO
