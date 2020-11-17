
USE [KenticoCMS_DataMart];
GO

/*--------------------------------------------------------------------------------------------------------------------------------
select top 100 * from DIM_EDW_HFit_HealthAssesmentUserRiskArea_Joined
update DIM_EDW_HFit_HealthAssesmentUserRiskArea_Joined set HARiskAreaVersionID = null where UserRiskAreaItemID between 220 and 230
delete from DIM_EDW_HFit_HealthAssesmentUserRiskArea_Joined where UserRiskAreaItemID = 220
Select * from DIM_EDW_HFit_HealthAssesmentUserRiskArea_Joined_HISTORY
SELECT COUNT (*) FROM DIM_EDW_HFit_HealthAssesmentUserRiskArea_Joined;


exec proc_GenHistoryTrigger 'KenticoCMS_DataMart', 'DIM_EDW_CMS_USER', 1
exec proc_GenHistoryTrigger 'KenticoCMS_DataMart', 'DIM_EDW_CMS_USER', 0

*/

go
if exists (select name from sys.procedures where name = 'proc_GenHistoryTrigger')
    drop procedure proc_GenHistoryTrigger;

go

CREATE PROCEDURE proc_GenHistoryTrigger (
       @InstanceName  AS NVARCHAR (100) 
     , @TblName AS NVARCHAR (100), @PrintOnly as int = 1) 
AS
BEGIN

    DECLARE
           @TBL AS NVARCHAR (100) = 'DIM_EDW_CMS_USER';
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
    SET @TSQL = @TSQL + @SQL1 + CHAR (10) ;
    if @PrintOnly = 0 EXEC(@SQL1)

    SET @SQL1 = '';
    SET @SQL1 = @SQL1 + ' SELECT TOP 1 ' + CHAR (10) ;
    SET @SQL1 = @SQL1 + '        * INTO ' + CHAR (10) ;
    SET @SQL1 = @SQL1 + '               ' + @TBL + '_HISTORY ' + CHAR (10) ;
    SET @SQL1 = @SQL1 + '        FROM ' + @TBL + '; ' + CHAR (10) ;
    SET @TSQL = @TSQL + @SQL1 + CHAR (10) ;
    if @PrintOnly = 0 EXEC(@SQL1)

    SET @SQL1 = '';
    SET @SQL1 = @SQL1 + ' truncate TABLE ' + @TBL + '_HISTORY;  ' + CHAR (10) ;
    SET @TSQL = @TSQL + @SQL1 + CHAR (10) ;
    if @PrintOnly = 0 EXEC(@SQL1)

    SET @SQL1 = '';
    SET @SQL1 = @SQL1 + ' ALTER TABLE ' + @TBL + '_HISTORY ' + CHAR (10) ;
    SET @SQL1 = @SQL1 + ' ADD ' + CHAR (10) ;
    SET @SQL1 = @SQL1 + '             [action] CHAR (1) DEFAULT ''U''; ' + CHAR (10) ;
    SET @SQL1 = @SQL1 + ' ALTER TABLE ' + @TBL + '_HISTORY ' + CHAR (10) ;
    SET @SQL1 = @SQL1 + ' ADD ' + CHAR (10) ;
    SET @SQL1 = @SQL1 + '             action_date DATETIME DEFAULT GETDATE () ; ' + CHAR (10) ;
    SET @TSQL = @TSQL + @SQL1 + CHAR (10) ;
    if @PrintOnly = 0 EXEC(@SQL1)

    SET @SQL1 = '';
    SET @SQL1 = @SQL1 + ' IF EXISTS (SELECT ' + CHAR (10) ;
    SET @SQL1 = @SQL1 + '                   name ' + CHAR (10) ;
    SET @SQL1 = @SQL1 + '                   FROM sys.triggers ' + CHAR (10) ;
    SET @SQL1 = @SQL1 + '                   WHERE ' + CHAR (10) ;
    SET @SQL1 = @SQL1 + '                   name = ''' + @TBL + ''')  ' + CHAR (10) ;
    SET @SQL1 = @SQL1 + '     BEGIN ' + CHAR (10) ;
    SET @SQL1 = @SQL1 + '         DROP TRIGGER ' + CHAR (10) ;
    SET @SQL1 = @SQL1 + '              dbo.TRIG_UPDT_DIM_EDW_HFit_HealthAssesmentUserRiskArea_Joined; ' + CHAR (10) ;
    SET @SQL1 = @SQL1 + '     END; ' + CHAR (10) ;
    SET @TSQL = @TSQL + @SQL1 + CHAR (10) ;
    if @PrintOnly = 0 EXEC(@SQL1)

    SET @SQL1 = '';
    set @SQL1 = @SQL1 + ' GO '  + CHAR (10) ;
    SET @SQL1 = @SQL1 + ' CREATE TRIGGER dbo.TRIG_UPDT_DIM_EDW_HFit_HealthAssesmentUserRiskArea_Joined ' + CHAR (10) ;
    SET @SQL1 = @SQL1 + ' ON dbo.DIM_EDW_HFit_HealthAssesmentUserRiskArea_Joined ' + CHAR (10) ;
    SET @SQL1 = @SQL1 + '     AFTER UPDATE ' + CHAR (10) ;
    SET @SQL1 = @SQL1 + ' AS ' + CHAR (10) ;
    SET @SQL1 = @SQL1 + ' BEGIN ' + CHAR (10) ;
    SET @SQL1 = @SQL1 + '     INSERT INTO DIM_EDW_HFit_HealthAssesmentUserRiskArea_Joined_HISTORY ' + CHAR (10) ;
    SET @SQL1 = @SQL1 + '     ( ' + CHAR (10) ;

    DECLARE
           @COLS AS NVARCHAR (MAX) = '';
    DECLARE
           @ReturnedCols AS NVARCHAR (MAX) = NULL;

    EXEC @COLS = proc_GetTableColumnsCT @InstanceName , @TblName , @ReturnedCols OUT;
    SET @COLS = @ReturnedCols;

    SET @SQL1 = @SQL1 + @COLS + CHAR (10) ;
    SET @SQL1 = @SQL1 + '  ,Action   ) ' + CHAR (10) ;
    SET @SQL1 = @SQL1 + ' SELECT ' + CHAR (10) ;
    SET @SQL1 = @SQL1 + @COLS + CHAR (10) ;
    SET @SQL1 = @SQL1 + '         , ''U'' ' + CHAR (10) ;
    SET @SQL1 = @SQL1 + '            FROM inserted; ' + CHAR (10) ;
    SET @SQL1 = @SQL1 + ' END; ' + CHAR (10) ;
    SET @TSQL = @TSQL + @SQL1 + CHAR (10) ;
    if @PrintOnly = 0 EXEC(@SQL1)

    SET @SQL1 = ' ';
    if @PrintOnly = 1 PRINT @SQL1;
    if @PrintOnly = 1 PRINT @SQL1;
    SET @SQL1 = @SQL1 + ' IF EXISTS (SELECT ' + CHAR (10) ;
    SET @SQL1 = @SQL1 + '                   name ' + CHAR (10) ;
    SET @SQL1 = @SQL1 + '                   FROM sys.triggers ' + CHAR (10) ;
    SET @SQL1 = @SQL1 + '                   WHERE ' + CHAR (10) ;
    SET @SQL1 = @SQL1 + '                   name = ''TRIG_DEL_' + @TBL + ''')  ' + CHAR (10) ;
    SET @SQL1 = @SQL1 + '     BEGIN ' + CHAR (10) ;
    SET @SQL1 = @SQL1 + '         DROP TRIGGER ' + CHAR (10) ;
    SET @SQL1 = @SQL1 + '              dbo.TRIG_' + @TBL + '; ' + CHAR (10) ;
    SET @SQL1 = @SQL1 + '     END; ' + CHAR (10) ;
    SET @TSQL = @TSQL + @SQL1 + CHAR (10) ;
    if @PrintOnly = 0 EXEC(@SQL1)

    SET @SQL1 = '';
    SET @SQL1 = @SQL1 + ' CREATE TRIGGER dbo.TRIG_DEL_DIM_EDW_HFit_HealthAssesmentUserRiskArea_Joined ' + CHAR (10) ;
    SET @SQL1 = @SQL1 + ' ON dbo.DIM_EDW_HFit_HealthAssesmentUserRiskArea_Joined ' + CHAR (10) ;
    SET @SQL1 = @SQL1 + '     FOR DELETE ' + CHAR (10) ;
    SET @SQL1 = @SQL1 + ' AS ' + CHAR (10) ;
    SET @SQL1 = @SQL1 + ' BEGIN ' + CHAR (10) ;
    SET @SQL1 = @SQL1 + '     INSERT INTO DIM_EDW_HFit_HealthAssesmentUserRiskArea_Joined_HISTORY ' + CHAR (10) ;
    SET @SQL1 = @SQL1 + '     ( ' + CHAR (10) ;
    SET @SQL1 = @SQL1 + @COLS + CHAR (10) ;
    SET @SQL1 = @SQL1 + '  ,Action   ) ' + CHAR (10) ;
    SET @SQL1 = @SQL1 + '     SELECT ' + CHAR (10) ;
    SET @SQL1 = @SQL1 + @COLS + CHAR (10) ;
    SET @SQL1 = @SQL1 + '         , ''U'' ' + CHAR (10) ;
    SET @SQL1 = @SQL1 + '            FROM DELETED; ' + CHAR (10) ;
    SET @SQL1 = @SQL1 + ' END; ' + CHAR (10) ;
    if @PrintOnly = 0 EXEC(@SQL1)
    SET @TSQL = @TSQL + @SQL1 + CHAR (10) ;
    if @PrintOnly =	    1
    select  @TSQL ;
END;
GO
