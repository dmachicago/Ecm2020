

-- use KenticoCMS_DataMart_2
GO
PRINT 'Creating proc_genPullChangesProc';
GO
IF EXISTS (SELECT name
             FROM sys.procedures
             WHERE name = 'proc_genPullChangesProc') 
    BEGIN
        DROP PROCEDURE proc_genPullChangesProc;
    END;
GO

IF EXISTS (SELECT name
             FROM sys.procedures
             WHERE name = 'proc_GenBaseTableExecCmds') 
    BEGIN
        DROP PROCEDURE proc_GenBaseTableExecCmds;
    END;
GO
-- exec proc_genPullChangesProc "KenticoCMS_1", "BASE_CMS_MembershipUser", 0 ,1
-- exec proc_genPullChangesProc "KenticoCMS_2", "BASE_CMS_MembershipUser", 0 ,1
-- exec proc_genPullChangesProc "KenticoCMS_3", "BASE_CMS_MembershipUser", 0 ,1
-- exec proc_GenBaseTableExecCmds 1 --Use this to VIEW Commands and not execute
-- exec proc_GenBaseTableExecCmds 0 --Use this to execute Commands one by one.
CREATE PROCEDURE proc_GenBaseTableExecCmds (@PreviewOnly AS bit = 0) 
AS
BEGIN

    DECLARE
           @i AS int = 0
         , @iRow AS int = 0
         , @iMax AS int = 0
         , @table_catalog AS nvarchar (250) 
         , @table_name AS nvarchar (250) 
         , @CMD AS nvarchar (max) 
         , @MySql AS nvarchar (max) 
         , @msg AS nvarchar (max) 
         , @DBNAME AS nvarchar (250) = 'KenticoCMS_2'
         , @T AS nvarchar (250) = '';

    SET @iMax = (SELECT COUNT (*)
                   FROM kenticoCMS_1.information_schema.tables
                   WHERE table_name LIKE '%'
                     AND table_name NOT LIKE '%[_]del'
                     AND table_name NOT LIKE '%HIST'
                     AND table_name NOT LIKE '%[_]Joined'
                     AND table_name NOT LIKE '%View[_]%'
                     AND table_name NOT LIKE '%[_]View%'
                     AND table_name NOT LIKE '%View'
                     AND table_name NOT LIKE '%[_]View[_]%'
                     AND table_name NOT LIKE '%[_]NoNulls'
                     AND table_name NOT LIKE '%[_]Archive'
                     AND table_name NOT LIKE '%[_]Staging[_]%'
                     AND table_name NOT LIKE '%[_]MeetNotModify'
                     AND table_name NOT LIKE '%[_]Step1'
                     AND table_name NOT LIKE '%[_]Step2'
                     AND table_name NOT LIKE '%[_]Step3'
                     AND table_name NOT LIKE '%[_]Step4'
                     AND table_name NOT LIKE '%[_]Step5') ;
    SET @iMax = @iMax * 3;

    DECLARE C CURSOR
        FOR SELECT ROW_NUMBER () OVER (ORDER BY table_name, table_catalog) AS Row
                 , 'KenticoCMS_1' AS table_catalog
                 , table_name
                 , 'exec proc_genPullChangesProc "KenticoCMS_1", "' + REPLACE (table_name, '', '') + '", 0,1 '
              FROM information_schema.tables
              WHERE table_type = 'BASE TABLE'
                AND table_name LIKE '%'
                AND table_name NOT LIKE '%[_]del'
                AND table_name NOT LIKE '%HIST'
                AND table_name NOT LIKE '%[_]Joined'
                AND table_name NOT LIKE '%View[_]%'
                AND table_name NOT LIKE '%[_]View%'
                AND table_name NOT LIKE '%View'
                AND table_name NOT LIKE '%[_]View[_]%'
                AND table_name NOT LIKE '%[_]NoNulls'
                AND table_name NOT LIKE '%[_]Archive'
                AND table_name NOT LIKE '%[_]Staging[_]%'
                AND table_name NOT LIKE '%[_]MeetNotModify'
                AND table_name NOT LIKE '%[_]Step1'
                AND table_name NOT LIKE '%[_]Step2'
                AND table_name NOT LIKE '%[_]Step3'
                AND table_name NOT LIKE '%[_]Step4'
                AND table_name NOT LIKE '%[_]Step5'
                AND table_name NOT LIKE 'SchemaChange%'
                AND table_name NOT LIKE '%[_]DIFF1'
                AND table_name NOT LIKE '%[_]DIFF2'
                AND table_name NOT LIKE '%[_]DIFF3'
                AND table_name NOT LIKE '%[_]DIFF4'
                AND table_name NOT LIKE 'CT_VersionTracking'
            UNION
            SELECT ROW_NUMBER () OVER (ORDER BY table_name, table_catalog) AS Row
                 , 'KenticoCMS_2' AS table_catalog
                 , table_name
                 , 'exec proc_genPullChangesProc "KenticoCMS_2", "' + REPLACE (table_name, '', '') + '", 0,1 '
              FROM information_schema.tables
              WHERE table_type = 'BASE TABLE'
                AND table_name LIKE '%'
                AND table_name NOT LIKE '%[_]del'
                AND table_name NOT LIKE '%HIST'
                AND table_name NOT LIKE '%[_]Joined'
                AND table_name NOT LIKE '%[_]View%'
                AND table_name NOT LIKE '%View'
                AND table_name NOT LIKE '%[_]View[_]%'
                AND table_name NOT LIKE '%[_]NoNulls'
                AND table_name NOT LIKE '%[_]Archive'
                AND table_name NOT LIKE '%[_]Staging[_]%'
                AND table_name NOT LIKE '%[_]MeetNotModify'
                AND table_name NOT LIKE '%[_]Step1'
                AND table_name NOT LIKE '%[_]Step2'
                AND table_name NOT LIKE '%[_]Step3'
                AND table_name NOT LIKE '%[_]Step4'
                AND table_name NOT LIKE '%[_]Step5'
                AND table_name NOT LIKE 'SchemaChange%'
                AND table_name NOT LIKE '%[_]DIFF1'
                AND table_name NOT LIKE '%[_]DIFF2'
                AND table_name NOT LIKE '%[_]DIFF3'
                AND table_name NOT LIKE '%[_]DIFF4'
                AND table_name NOT LIKE 'CT_VersionTracking'
            UNION
            SELECT ROW_NUMBER () OVER (ORDER BY table_name, table_catalog) AS Row
                 , 'KenticoCMS_3' AS table_catalog
                 , table_name
                 , 'exec proc_genPullChangesProc "KenticoCMS_3", "' + REPLACE (table_name, '', '') + '", 0,1 '
              FROM information_schema.tables
              WHERE table_type = 'BASE TABLE'
                AND table_name LIKE '%'
                AND table_name NOT LIKE '%[_]del'
                AND table_name NOT LIKE '%HIST'
                AND table_name NOT LIKE '%[_]Joined'
                AND table_name NOT LIKE '%[_]View%'
                AND table_name NOT LIKE '%View'
                AND table_name NOT LIKE '%[_]View[_]%'
                AND table_name NOT LIKE '%[_]NoNulls'
                AND table_name NOT LIKE '%[_]Archive'
                AND table_name NOT LIKE '%[_]Staging[_]%'
                AND table_name NOT LIKE '%[_]MeetNotModify'
                AND table_name NOT LIKE '%[_]Step1'
                AND table_name NOT LIKE '%[_]Step2'
                AND table_name NOT LIKE '%[_]Step3'
                AND table_name NOT LIKE '%[_]Step4'
                AND table_name NOT LIKE '%[_]Step5'
                AND table_name NOT LIKE 'SchemaChange%'
                AND table_name NOT LIKE '%[_]DIFF1'
                AND table_name NOT LIKE '%[_]DIFF2'
                AND table_name NOT LIKE '%[_]DIFF3'
                AND table_name NOT LIKE '%[_]DIFF4'
                AND table_name NOT LIKE 'CT_VersionTracking'
              ORDER BY table_name, table_catalog;

    OPEN C;

    FETCH NEXT FROM C INTO @iRow, @table_catalog, @table_name, @CMD;
    CREATE TABLE #REGENCMDS (cmd nvarchar (max)) ;
    WHILE @@FETCH_STATUS = 0
        BEGIN
            SET @i = @i + 1;
            SET @msg = CAST (@i AS nvarchar (50)) + ' OF ' + CAST (@iMax AS nvarchar (50)) ;

            IF @PreviewOnly = 1
                BEGIN
                    SET @Msg = 'PRINT ''' + @msg + '''';
                    INSERT INTO #REGENCMDS (cmd) 
                    VALUES
                           (@msg) ;
                    EXEC PrintImmediate @msg;
                    EXEC PrintImmediate 'GO';
                    INSERT INTO #REGENCMDS (cmd) 
                    VALUES
                           ('GO') ;
                    EXEC PrintImmediate @CMD;
                    INSERT INTO #REGENCMDS (cmd) 
                    VALUES
                           (@CMD) ;
                    EXEC PrintImmediate 'GO';
                    INSERT INTO #REGENCMDS (cmd) 
                    VALUES
                           ('GO') ;
                END;
            ELSE
                BEGIN EXEC PrintImmediate @msg;
                    EXEC PrintImmediate @CMD;
                END;

            IF @PreviewOnly = 0
                BEGIN
                    BEGIN TRY EXEC (@CMD) ;
                    END TRY
                    BEGIN CATCH
                        SET @Msg = 'ERROR: ' + @table_catalog + '.' + @table_name + CHAR (10) + @CMD;
                        EXEC PrintImmediate @Msg;
                    END CATCH;
                END;
            FETCH NEXT FROM C INTO @iRow, @table_catalog, @table_name, @CMD;
        END;

    CLOSE C;
    DEALLOCATE C;
    IF @PreviewOnly = 1
        BEGIN
            SELECT *
              FROM #REGENCMDS;
        END;
END;
GO

/**************************************************************************************************************
---------------------------------------------------------------------------------------------------------------
--Execute to REGEN everything on all BASE tables.
select 'exec proc_genPullChangesProc "KenticoCMS_1", "'+replace(table_name,'','')+'", 0,1 ' + char(10) + 'GO'
from information_schema.tables
where table_name like '%'
and table_name not like '%[_]del'
and table_name not like '%HIST'
and table_name not like '%[_]Joined'
and table_name not like '%View[_]%'
and table_name not like '%[_]View%'
and table_name not like '%View'
and table_name not like '%[_]View[_]%'
and table_name not like '%[_]NoNulls'
and table_name not like '%[_]Archive'
and table_name not like '%[_]Staging[_]%'
and table_name not like '%[_]MeetNotModify'
and table_name not like '%[_]Step1'
and table_name not like '%[_]Step2'
and table_name not like '%[_]Step3'
and table_name not like '%[_]Step4'
and table_name not like '%[_]Step5'

union
select 'exec proc_genPullChangesProc "KenticoCMS_2", "'+replace(table_name,'','')+'", 0,1 '  + char(10) + 'GO'
from information_schema.tables
where table_name like '%'
and table_name not like '%[_]del'
and table_name not like '%HIST'
and table_name not like '%[_]Joined'
and table_name not like '%[_]View%'
and table_name not like '%View'
and table_name not like '%[_]View[_]%'
and table_name not like '%[_]NoNulls'
and table_name not like '%[_]Archive'
and table_name not like '%[_]Staging[_]%'
and table_name not like '%[_]MeetNotModify'
and table_name not like '%[_]Step1'
and table_name not like '%[_]Step2'
and table_name not like '%[_]Step3'
and table_name not like '%[_]Step4'
and table_name not like '%[_]Step5'
union
select 'exec proc_genPullChangesProc "KenticoCMS_3", "'+replace(table_name,'','')+'", 0,1 '  + char(10) + 'GO'
from information_schema.tables
where table_name like '%'
and table_name not like '%[_]del'
and table_name not like '%HIST'
and table_name not like '%[_]Joined'
and table_name not like '%[_]View%'
and table_name not like '%View'
and table_name not like '%[_]View[_]%'
and table_name not like '%[_]NoNulls'
and table_name not like '%[_]Archive'
and table_name not like '%[_]Staging[_]%'
and table_name not like '%[_]MeetNotModify'
and table_name not like '%[_]Step1'
and table_name not like '%[_]Step2'
and table_name not like '%[_]Step3'
and table_name not like '%[_]Step4'
and table_name not like '%[_]Step5'
**************************************************************************************************************/

/******************************************************************************************************************************************************
EXEC proc_CreateBaseTable @InstanceName = "KenticoCMS_1" , @TblName = "HFit_HealthAssesmentUserStarted" , @SkipIfExists = 1 , @AddTableDefaults = "NO" 

use KenticoCMS_DataMart_2

exec proc_genPullChangesProc 'KenticoCMS_1', 'HFit_HealthAssesmentUserStarted', 1
exec proc_genPullChangesProc 'KenticoCMS_2', 'HFit_HealthAssesmentUserStarted', 1
exec proc_genPullChangesProc 'KenticoCMS_3', 'HFit_HealthAssesmentUserStarted', 1

exec proc_genPullChangesProc 'KenticoCMS_3', 'CMS_Site', 0
exec proc_genPullChangesProc 'KenticoCMS_1', 'CMS_User' , 0
exec proc_genPullChangesProc 'KenticoCMS_1', 'CMS_Document',  1
exec proc_genPullChangesProc 'KenticoCMS_2', 'cms_usersettings' 
******************************************************************************************************************************************************/

/******************************************************
-----------------------------------------------------
*******************************************************
INSERT INTO TestTable (FirstName, LastName)
SELECT FirstName, LastName
FROM Person.Contact
*******************************************************
******************************************************/

/**************************************************************************************************************
declare @DDL as nvarchar (max) = '' 
exec proc_genPullChangesProc 'KenticoCMS_1', 'HFit_ClientContact', @DeBug=0, @GenProcOnlyDoNotPullData=0
exec proc_genPullChangesProc 'KenticoCMS_2', 'HFit_ClientContact', @DeBug=1, @GenProcOnlyDoNotPullData=1
exec proc_genPullChangesProc 'KenticoCMS_3', 'HFit_GoalOutcome', @DeBug=1, @GenProcOnlyDoNotPullData=1
***************************************************************************************************************/

GO
CREATE PROCEDURE proc_genPullChangesProc (@InstanceName AS nvarchar (250) 
                                        , @TblName AS nvarchar (250) 
                                        , @DeBug AS integer = 0
                                        , @GenProcOnlyDoNotPullData AS bit = 0) 
AS
BEGIN

/******************************************************************************
******************************************************************************
Author:	  W. Dale Miller
Date:	  11.12.2015
Copyright:  DMA, Ltd.
Purpose:	  Generates a select into statement from a table or view. This method 
		  is used when table is already created in the database earlier and 
		  data is to be inserted into this table from another table.
Last Test:  11.12.2015 WDM
******************************************************************************
******************************************************************************/

    --declare @InstanceName AS NVARCHAR (250) = 'KenticoCMS_2';
    --declare @TblName AS NVARCHAR (250) =  'BASE_HFit_HealthAssesmentUserQuestion';
    --declare @DeBug AS INTEGER = 1;
    --declare @GenProcOnlyDoNotPullData AS BIT = 1;

    IF CHARINDEX ('BASE_', @TblName) > 0
        BEGIN
            SET @TblName = SUBSTRING (@TblName, 6, 99999) ;
        END;

    DECLARE
           @tsql AS nvarchar (max) = ''
         , @StartTime AS datetime = GETDATE () 
         , @rowcount int
         , @TS AS nvarchar (500) = 'select count(*) from ' + @InstanceName + '.information_schema.tables where TABLE_SCHEMA = ''dbo'' and  table_name = ''' + @TblName + '''';

    DECLARE
           @zout TABLE (zout int) ;
    INSERT INTO @zout
    EXEC (@TS) ;
    SET @rowcount = (SELECT zout
                       FROM @zout) ;

    IF @rowcount = 0
        BEGIN
            PRINT 'proc_genPullChangesProc: ' + @InstanceName + '.' + @TblName + ' not found, aborting.';
            RETURN -99;
        END;
    ELSE
        BEGIN
            PRINT '*!*!*!*!*!*!*!**!*!*!*!*!*!*!**!*!*!*!*!*!*!**!*!*!*!*!*!*!**!*!*!*!*!*!*!*';
            PRINT 'BEGINNING proc_genPullChangesProc: ' + @InstanceName + '.' + @TblName;
            PRINT 'Start: ' + CAST (GETDATE () AS nvarchar (50)) ;
            PRINT '*!*!*!*!*!*!*!**!*!*!*!*!*!*!**!*!*!*!*!*!*!**!*!*!*!*!*!*!**!*!*!*!*!*!*!*';
        END;

    DECLARE
           @tcnt AS int = 0;
    EXEC @tcnt = isPrimaryKeyExists @InstanceName, @TblName;

    IF @tcnt = 0
        BEGIN
            PRINT 'PRIMARY KEY MISSING ON: ' + @TblName;
            DECLARE
                   @xcolname AS nvarchar (500) = @TblName + '_GuidID';
            DECLARE
                   @pkname AS nvarchar (500) = 'PKey_CT_' + @TblName;
            SET @tsql = 'ALTER TABLE ' + @InstanceName + '.dbo.' + @TblName + ' ADD ' + @xcolname + ' uniqueidentifier not null default newid() ';
            EXEC (@tsql) ;
            SET @tsql = 'ALTER TABLE ' + @InstanceName + '.dbo.' + @TblName + ' ADD CONSTRAINT ' + @pkname + ' PRIMARY KEY (' + @xcolname + ') ';
            BEGIN TRY EXEC (@tsql) ;
                PRINT 'ADDED PRIMARY KEY MISSING ON: ' + @TblName + ' / ' + @xcolname;
            END TRY
            BEGIN CATCH
                PRINT 'ERROR: FAILED TO ADD PRIMARY KEY ON: ' + @TblName + ' / ' + @xcolname + ', ABORTING.';
                RETURN -88;
            END CATCH;

        END;

    DECLARE
           @Msg nvarchar (max) 
         , @BaseTable nvarchar (500) 
         , @ViewObjVars varchar (max) 
         , @r varchar (max) ;

    SET @BaseTable = 'BASE_' + @TblName;

    SET NOCOUNT ON;
    EXEC proc_ChangeTracking @InstanceName, @TblName, 1;

    --drop table #FTCols
    --declare @InstanceName AS nvarchar(250) = 'KenticoCMS_1' ;
    --declare @TblName AS nvarchar (250) = 'cms_usersettings' ;
    --declare @DeBug as integer = 1

    BEGIN TRY
        CLOSE PCursor;
        DEALLOCATE PCursor;
    END TRY
    BEGIN CATCH
        PRINT ' ';
    END CATCH;
    BEGIN TRY
        CLOSE TCursor;
        DEALLOCATE TCursor;
    END TRY
    BEGIN CATCH
        PRINT ' ';
    END CATCH;
    BEGIN TRY
        CLOSE ZCursor;
        DEALLOCATE ZCursor;
    END TRY
    BEGIN CATCH
        PRINT ' ';
    END CATCH;
    IF OBJECT_ID ('tempdb..#FTCols') IS NOT NULL
        BEGIN
            DROP TABLE #FTCols;
        END;
    DECLARE
           @CreateAllJobs AS int = 0
         , @Interval AS int = -1
         , @FQN AS nvarchar (1000) = @InstanceName + '.dbo.' + @TblName
         , @BaseTblName AS nvarchar (250) = 'BASE_' + @TblName
         , @last_sync_version AS bigint = 0
         , @mysql AS nvarchar (max) = ''
         , @FromClause AS nvarchar (max) = ''
         , @FactTableCOLS AS nvarchar (max) = ''
         , @BaseTableCOLS AS nvarchar (max) = ''
         , @BaseTableColsNoPK AS nvarchar (max) = ''
         , @ReturnedCols AS nvarchar (max) = NULL
         , @VersionTrackingTabl AS nvarchar (100) = 'BASE_' + @TblName + '_CTVerHIST '
         , @iCnt AS bigint = 0
         , @MySql2 AS nvarchar (max) = '';
    EXEC mart_GenObjVarBitFlgAlterStmts @InstanceName, @TblName, @r OUTPUT;
    --	   SELECT @r

    BEGIN TRY
        EXEC (@r) ;
    END TRY
    BEGIN CATCH
        PRINT 'ERROR: Failed to excecute: ' + @r;
    END CATCH;

    SET @MySql = 'select max(SYS_CHANGE_VERSION) from ' + @VersionTrackingTabl;

    DECLARE
           @result TABLE (LastVerNo bigint) ;
    INSERT INTO @result (LastVerNo) 
    EXEC (@MySql) ;
    SET @last_sync_version = (SELECT TOP (1) LastVerNo
                                FROM @result) ;
    IF @last_sync_version IS NULL
        BEGIN
            SET @last_sync_version = 0;
        END;

    DECLARE
           @PrimaryKeyCols AS TABLE (column_name nvarchar (100)) ;

    DECLARE
           @TgtTbl AS nvarchar (100) = '';
    DECLARE
           @S AS nvarchar (max) = '';

    SET @TgtTbl = @InstanceName + '.INFORMATION_SCHEMA.KEY_COLUMN_USAGE';

    SET @S = ' SELECT column_name ' + CHAR (10) ;
    SET @S = @S + ' FROM ' + @InstanceName + '.INFORMATION_SCHEMA.TABLE_CONSTRAINTS AS TC ' + CHAR (10) ;
    SET @S = @S + ' INNER JOIN ' + CHAR (10) ;
    SET @S = @S + '     ' + @TgtTbl + ' AS KU ' + CHAR (10) ;
    SET @S = @S + ' ON TC.CONSTRAINT_TYPE = ''PRIMARY KEY'' AND ' + CHAR (10) ;
    SET @S = @S + ' TC.CONSTRAINT_NAME = KU.CONSTRAINT_NAME ' + CHAR (10) ;
    SET @S = @S + ' and ku.table_name=''' + @TblName + '''' + CHAR (10) ;
    SET @S = @S + ' ORDER BY KU.TABLE_NAME, KU.ORDINAL_POSITION; ' + CHAR (10) ;

    INSERT INTO @PrimaryKeyCols
    EXEC (@S) ;

    IF @DeBug = 1
        BEGIN
            SELECT *
              FROM @PrimaryKeyCols;
        END;

    DECLARE
           @CTKeys AS nvarchar (max) = ''
         , @CTEPkeys AS nvarchar (max) = ''
         , @strPkeys AS nvarchar (max) = ''
         , @ON_Clause AS nvarchar (max) = ''
         , @iCols AS integer = 0;

    SET @iCols = (SELECT COUNT (*)
                    FROM @PrimaryKeyCols) ;
    IF @iCols = 0
        BEGIN
            SET @ON_Clause = '';
            PRINT 'NO PK COLS FOUND';
        END;
    IF @iCols > 0
        BEGIN
            --print 'YEA PK COLS FOUND';
            DECLARE
                   @Pkey AS nvarchar (100) = ''
                 , @MyPK AS nvarchar (max) = ''
                 , @II AS integer = 0;

            DECLARE PCursor CURSOR
                FOR SELECT column_name
                      FROM @PrimaryKeyCols;
            OPEN PCursor;
            FETCH NEXT FROM PCursor INTO @Pkey;

            SET @ON_Clause = ' ON ';

            WHILE @@FETCH_STATUS = 0
                BEGIN

                    SET @II = @II + 1;
                    IF @II < @iCols
                        BEGIN
                            SET @ON_Clause = @ON_Clause + ' FT.' + @Pkey + ' = CT.' + @Pkey + ' AND ' + CHAR (10) ;
                            SET @strPkeys = @strPkeys + @Pkey + ',';
                            SET @CTEPkeys = @CTEPkeys + 'S.' + @Pkey + ' = ' + 'T.' + @Pkey + ' AND ' + CHAR (10) ;
                            SET @CTKeys = @CTKeys + 'CT.' + @Pkey + ' , ';
                        END;
                    ELSE
                        BEGIN
                            SET @ON_Clause = @ON_Clause + ' FT.' + @Pkey + ' = CT.' + @Pkey + ' ' + CHAR (10) ;
                            SET @strPkeys = @strPkeys + @Pkey;
                            SET @CTEPkeys = @CTEPkeys + 'S.' + @Pkey + ' = ' + 'T.' + @Pkey + CHAR (10) ;
                            SET @CTKeys = @CTKeys + 'CT.' + @Pkey + CHAR (10) ;
                        END;
                    FETCH NEXT FROM PCursor INTO @Pkey;
                END;

            CLOSE PCursor;
            DEALLOCATE PCursor;
        END;

    SET @strPkeys = '';
    SELECT @strPkeys = COALESCE (@strPkeys + ', ', '') + column_name
      FROM @PrimaryKeyCols;
    SET @strPkeys = LTRIM (@strPkeys) ;
    SET @strPkeys = SUBSTRING (@strPkeys, 2, 9999) ;

    IF @DeBug = 1
        BEGIN
            PRINT 'NEW @strPkeys: ' + @strPkeys;
        END;

    DECLARE
           @TblKeys AS nvarchar (2000) = '';
    DECLARE
           @PK AS nvarchar (2000) = NULL;
    EXEC @TblKeys = procGetTablePK @InstanceName, @TblName, @PK OUT;
    SET @TblKeys = @PK;

    --**************************** EXEC *********************************************************
    EXEC @BaseTableCOLS = proc_GetTableColumnsCT @InstanceName, @TblName, @ReturnedCols OUT;
    --**************************** EXEC *********************************************************
    SET @BaseTableCOLS = @ReturnedCols;
    PRINT '@BaseTableCOLS: ' + @BaseTableCOLS;

    SET @FactTableCOLS = @BaseTableCOLS;
    PRINT '@FactTableCOLS: ' + @FactTableCOLS;

    SELECT * INTO #FTCols
      FROM dbo.udfSplitString (@FactTableCOLS) ;

    SET @BaseTableCOLS = '';
    SET @iCols = (SELECT COUNT (*)
                    FROM #FTCols) ;

    --print 'YEA PK COLS FOUND';    
    DECLARE
           @tCol AS nvarchar (100) = '';
    DECLARE
           @TPX AS nvarchar (max) = '';
    SET @II = 0;
    DECLARE TCursor CURSOR
        FOR SELECT strValue
              FROM #FTCols;
    OPEN TCursor;
    FETCH NEXT FROM TCursor INTO @tCol;
    WHILE @@FETCH_STATUS = 0
        BEGIN

            SET @tCol = (SELECT REPLACE (@tCol, CHAR (10) , '')) ;
            SET @II = @II + 1;
            IF @II < @iCols
                BEGIN
                    SELECT @BaseTableCOLS = @BaseTableCOLS + '   FT.' + @tCol + ',' + CHAR (10) ;
                END;
            ELSE
                BEGIN
                    SELECT @BaseTableCOLS = @BaseTableCOLS + '   FT.' + @tCol + CHAR (10) ;
                END;
            FETCH NEXT FROM TCursor INTO @tCol;
        END;

    CLOSE TCursor;
    DEALLOCATE TCursor;

    SET @FactTableCOLS = @FactTableCOLS + ', SYS_CHANGE_VERSION , LASTMODIFIEDDATE, HashCode, SVR, DBNAME ';
    SET @BaseTableCOLS = @BaseTableCOLS + ', CT.SYS_CHANGE_VERSION ' + CHAR (10) ;
    SET @BaseTableCOLS = @BaseTableCOLS + ', getdate() as LASTMODIFIEDDATE ' + CHAR (10) ;
    SET @BaseTableCOLS = @BaseTableCOLS + ', NULL as HashCode ' + CHAR (10) ;
    SET @BaseTableCOLS = @BaseTableCOLS + ', @@servername AS SVR ' + CHAR (10) ;
    SET @BaseTableCOLS = @BaseTableCOLS + ', ''' + @InstanceName + ''' AS DBNAME ' + CHAR (10) ;

    PRINT '2-@FactTableCOLS: ' + @FactTableCOLS;
    PRINT '2-@BaseTableCOLS: ' + @BaseTableCOLS;

    SET @FromClause = @FromClause + 'FROM CHANGETABLE (CHANGES ' + @FQN + ', @VersionNbr) AS CT ' + CHAR (10) ;
    SET @FromClause = @FromClause + '    JOIN ' + @FQN + ' AS FT ' + CHAR (10) ;
    SET @FromClause = @FromClause + '      ' + @ON_Clause + ' ';
    SET @FromClause = @FromClause + '    JOIN cte_new AS cte ' + CHAR (10) ;
    SET @FromClause = @FromClause + '      ' + REPLACE (@ON_Clause, 'CT.', 'cte.') + ' ';
    SET @FromClause = @FromClause + 'where SYS_CHANGE_OPERATION = ''I'' ' + CHAR (10) ;
    SET @FromClause = @FromClause + 'order by CT.SYS_CHANGE_VERSION desc ' + CHAR (10) ;

    --**************************** CREATE INSERT *********************************************************
    DECLARE
           @ProcName AS nvarchar (250) = 'proc_' + @BaseTblName + '_' + @InstanceName + '_Insert';
    --****************************************************************************************************
    IF CHARINDEX ('_1_', @ProcName) > 0
        BEGIN
            SET @Interval = 1;
        END;
    IF CHARINDEX ('_2_', @ProcName) > 0
        BEGIN
            SET @Interval = 2;
        END;
    IF CHARINDEX ('_3_', @ProcName) > 0
        BEGIN
            SET @Interval = 3;
        END;

    IF NOT EXISTS (SELECT column_name
                     FROM information_schema.columns
                     WHERE table_name = @BaseTblName
                       AND column_name = 'CT_RowDataUpdated') 
        BEGIN
            SET @mysql = 'Alter table ' + @BaseTblName + ' add CT_RowDataUpdated bit null default 1';
        END;
    EXEC mart_AddMissingColumnsFromSvrTable @PullFromInstanceName = @InstanceName, @BaseTableName = @BaseTable, @PullTableName = @TblName;

    BEGIN TRY
        SET @MySQl = 'alter table ' + @BaseTblName + ' add CT_RowDataUpdated bit null';
        EXEC (@MySql) ;
    END TRY
    BEGIN CATCH
        PRINT 'CT_RowDataUpdated added to ' + @BaseTblName;
    END CATCH;
    --**************************** CREATE INSERT PROC *********************************************************
    SET @mysql = '';
    SET @mysql = @mysql + 'create procedure ' + @ProcName + ' (@VersionNbr bigint = null) ' + CHAR (10) ;
    SET @mysql = @mysql + 'as ' + CHAR (10) ;
    SET @mysql = @mysql + 'Begin ' + CHAR (10) ;
    SET @mysql = @mysql + '   SET NOCOUNT ON; ' + CHAR (10) + CHAR (10) ;
    SET @mysql = @mysql + '-- Generated on: ' + CAST (GETDATE () AS nvarchar (50)) + CHAR (10) ;
    SET @mysql = @mysql + '-- NOTE: Due to orphan and test data in the PROD DBs, we need to make sure' + CHAR (10) ;
    SET @mysql = @mysql + '--       that test data is not replicated, thus the CTE. ' + CHAR (10) ;

    IF @DeBug = 1
        BEGIN
            PRINT '@Pkey: ' + @Pkey;
            PRINT '@ON_Clause: ' + @ON_Clause;
            PRINT '@FQN: ' + @FQN;
            PRINT '@InstanceName: ' + @InstanceName;
        END;


    DECLARE
           @CTE_DLL AS nvarchar (max) = '';
    SET @CTE_DLL = @CTE_DLL + 'WITH CTE_NEW (' + @strPkeys + ') ' + CHAR (10) ;
    SET @CTE_DLL = @CTE_DLL + 'AS (SELECT ' + @strPkeys + CHAR (10) ;
    SET @CTE_DLL = @CTE_DLL + 'FROM ' + @FQN + CHAR (10) ;
    SET @CTE_DLL = @CTE_DLL + 'EXCEPT ' + CHAR (10) ;
    SET @CTE_DLL = @CTE_DLL + 'SELECT ' + @strPkeys + CHAR (10) ;
    SET @CTE_DLL = @CTE_DLL + 'FROM ' + @BaseTblName + CHAR (10) ;
    SET @CTE_DLL = @CTE_DLL + 'WHERE DBNAME = ''' + @InstanceName + ''') ' + CHAR (10) ;
    IF @DeBug = 1
        BEGIN
            PRINT '@CTE_DLL: ' + @CTE_DLL;
        END;
    SET @mysql = @mysql + @CTE_DLL;

    SET @mysql = @mysql + 'INSERT INTO ' + @BaseTblName + CHAR (10) ;
    SET @mysql = @mysql + '(' + CHAR (10) ;
    SET @mysql = @mysql + @FactTableCOLS + CHAR (10) + '    ,CT_RowDataUpdated ';
    SET @mysql = @mysql + ')' + CHAR (10) ;
    SET @mysql = @mysql + 'SELECT' + CHAR (10) ;
    SET @mysql = @mysql + @BaseTableCOLS;
    SET @mysql = @mysql + '       , 1         --CT_RowDataUpdated' + CHAR (10) ;
    SET @mysql = @mysql + @FromClause + CHAR (10) ;
    SET @mysql = @mysql + 'declare @TotRecs as int = @@ROWCOUNT ; ' + CHAR (10) ;
    SET @mysql = @mysql + 'print ''RETURNED COUNT: '' + cast(@TotRecs  as nvarchar(50)) ; ' + CHAR (10) ;
    SET @mysql = @mysql + 'return @TotRecs ;' + CHAR (10) ;
    SET @mysql = @mysql + 'End ; ' + CHAR (10) ;

    IF @DeBug = 1
        BEGIN
            SELECT @mysql;
        END;

    SET @ProcName = 'proc_' + @BaseTblName + '_' + @InstanceName + '_Insert';
    SET @TSQL = '';
    IF EXISTS (SELECT name
                 FROM sys.procedures
                 WHERE name = @ProcName) 
        BEGIN
            PRINT 'FOUND: ' + @ProcName;
            SET @TSQL = 'Drop procedure ' + @ProcName;
            EXEC (@TSQL) ;
        END;
    ELSE
        BEGIN
            PRINT 'NOT FOUND: ' + @ProcName;
        END;
    BEGIN TRY
        PRINT 'Attempting: ' + @TSQL;
        SET @TSQL = 'Drop procedure ' + @ProcName;
        EXEC (@TSQL) ;
    END TRY
    BEGIN CATCH
        PRINT 'EXECUTED: ' + @TSQL;
    END CATCH;
    IF NOT EXISTS (SELECT name
                     FROM sys.procedures
                     WHERE name = 'dbo.' + @ProcName) 
        BEGIN
            PRINT '00 - CREATING INSERT PROCEDURE: ' + @ProcName + CHAR (10) ;

            BEGIN TRY EXEC (@MySql) ;
            END TRY
            BEGIN CATCH
                SET @MySql = SUBSTRING (@MySql, 8, 999999) ;
                SET @MySql = 'ALTER ' + @MySql;
                EXEC (@MySql) ;
                PRINT '00 - Executed ALter: ' + @ProcName + CHAR (10) ;
            END CATCH;
            PRINT '01 - CREATED INSERT PROCEDURE: ' + @ProcName;
        END;
    ELSE
        BEGIN
            PRINT '1 - PROCEDURE: ' + @ProcName + ' ALREADY EXISTS, dropping and recreating.';
            SET @MySql2 = 'drop procedure ' + @ProcName;
            EXEC (@MySql2) ;
            EXEC (@MySql) ;
            PRINT 'RE-CREATED PROCEDURE: ' + @ProcName;
        END;

    IF @CreateAllJobs = 1
        BEGIN EXEC proc_GenJobBaseTableSync @Interval, @ProcName;
            PRINT 'Created JOB : ' + 'JOB_' + @ProcName;
        END;
    SET @mysql = '';

	   /************************************************************
	   -----------------------------------------------------------
	   declare @DDL as nvarchar (max) = '' 
	   exec proc_genPullChangesProc 'KenticoCMS_2', 'CMS_Site', @DDL
	   ************************************************************/

    SET @ON_Clause = (SELECT REPLACE (@ON_Clause, 'FT.', 'BT.')) ;
    SET @CTKeys = (SELECT REPLACE (@CTKeys, 'BT.', 'FT.')) ;

    IF NOT EXISTS (SELECT column_name
                     FROM information_schema.columns
                     WHERE table_name = @BaseTblName
                       AND column_name = 'CT_RowDataUpdated') 
        BEGIN
            SET @mysql = 'Alter table ' + @BaseTblName + ' add CT_RowDataUpdated bit null default 1 ';
        END;

    --**************************** CREATE DELETE PROC *********************************************************
    SET @mysql = '';
    SET @ProcName = 'proc_' + @BaseTblName + '_' + @InstanceName + '_Delete';
    SET @mysql = @mysql + 'CREATE PROCEDURE ' + @ProcName + ' (@VersionNbr bigint = null) ' + CHAR (10) ;
    SET @mysql = @mysql + 'AS ' + CHAR (10) ;
    SET @mysql = @mysql + 'BEGIN ' + CHAR (10) ;
    SET @mysql = @mysql + ' ' + CHAR (10) ;
    SET @mysql = @mysql + 'SET NOCOUNT ON; ' + CHAR (10) ;
    SET @mysql = @mysql + '    WITH CTE ( ' + CHAR (10) ;
    SET @mysql = @mysql + '         ' + @strPkeys + CHAR (10) ;
    SET @mysql = @mysql + '    )  ' + CHAR (10) ;
    SET @mysql = @mysql + '        AS ( ' + CHAR (10) ;
    SET @mysql = @mysql + '        SELECT ' + CHAR (10) ;
    SET @mysql = @mysql + '         ' + @CTKeys + CHAR (10) ;
    SET @mysql = @mysql + '               FROM ' + CHAR (10) ;
    SET @mysql = @mysql + '                   CHANGETABLE (CHANGES ' + @FQN + ', @VersionNbr) AS CT ' + CHAR (10) ;
    --SET @mysql = @mysql + '                       RIGHT OUTER JOIN ' + @FQN + ' AS BT ' + CHAR (10) ;
    --SET @mysql = @mysql + '                          ' + @ON_Clause + ' ';
    SET @mysql = @mysql + '               WHERE SYS_CHANGE_OPERATION = ''D'' ' + CHAR (10) ;
    SET @mysql = @mysql + '        )  ' + CHAR (10) ;
    SET @mysql = @mysql + '        DELETE FT ' + CHAR (10) ;
    SET @mysql = @mysql + '               FROM ' + @BaseTblName + ' FT ' + CHAR (10) ;
    SET @mysql = @mysql + '                        INNER JOIN CTE CT ' + CHAR (10) ;
    SET @ON_Clause = (SELECT REPLACE (@ON_Clause, 'BT.', 'FT.')) ;
    SET @mysql = @mysql + '                          ' + @ON_Clause + ' ';
    --wdmxx    
    SET @mysql = @mysql + 'WHERE DBNAME = ''' + @InstanceName + '''; ' + CHAR (10) ;

    SET @mysql = @mysql + 'declare @TotRecs as int = @@ROWCOUNT ; ' + CHAR (10) ;
    SET @mysql = @mysql + 'print ''RETURNED COUNT: '' + cast(@TotRecs  as nvarchar(50)) ; ' + CHAR (10) ;
    SET @mysql = @mysql + 'return @TotRecs ;' + CHAR (10) ;
    SET @mysql = @mysql + 'END; ' + CHAR (10) ;

    --PRINT '@@CTKeys:' + @strPkeys ;
    --   PRINT '@@CTKeys:' + @CTKeys ;
    PRINT 'Created DELETE Procedure:' + @ProcName;

    IF @DeBug = 1
        BEGIN
            SELECT @mysql;
        END;

    DECLARE
           @DeleteProcSql AS nvarchar (max) = '';
    DECLARE
           @DeleteProcNAme AS nvarchar (500) = '';
    SET @DeleteProcNAme = @ProcName;
    IF EXISTS (SELECT name
                 FROM sys.procedures
                 WHERE name = @ProcName) 
        BEGIN
            PRINT 'Dropping DELETE Procedure ' + @ProcName;
            DECLARE
                   @TS2 AS nvarchar (500) = '';
            SET @TS2 = 'drop procedure ' + @ProcName;
            EXEC (@TS2) ;
            PRINT 'Dropped DELETE Procedure ' + @ProcName;
        END;
    ELSE
        BEGIN
            PRINT 'DELETE Procedure ' + @ProcName + ' does not currently exist. ';
        END;

    IF NOT EXISTS (SELECT name
                     FROM sys.procedures
                     WHERE name = @ProcName) 
        BEGIN
            PRINT '2 - CREATING DELETE PROCEDURE: ' + @ProcName;
            BEGIN TRY
                SET @DeleteProcSql = @MySql;
                EXEC (@MySql) ;
                --EXECUTE sp_executesql @MySql;
                PRINT 'Created DELETE Procedure: ' + @ProcName;
                IF EXISTS (SELECT name
                             FROM sys.procedures
                             WHERE name = @ProcName) 
                    BEGIN
                        PRINT 'Procedure ' + @ProcName + ' VERIFIED.';
                    END;
                ELSE
                    BEGIN
                        PRINT 'Procedure ' + @ProcName + ' FAILED VERIFICATION.';
                    END;
            END TRY
            BEGIN CATCH
                PRINT '------------------------------------------------------------';
                PRINT 'ERROR Failed to Create Procedure: ' + @ProcName;
                PRINT @MySql;
                PRINT '------------------------------------------------------------';
            END CATCH;

        END;
    --ELSE
    --    BEGIN
    --        PRINT '2 - DELETE PROCEDURE: ' + @ProcName + ' ALREADY EXISTS, dropping and recreating.';
    --        SET @MySql2 = 'drop procedure ' + @ProcName;
    --        EXEC (@MySql2) ;
    --        EXEC (@MySql) ;
    --if exists (Select name from sys.procedures where name = @ProcName)
    --print 'Procedure ' + @ProcName + ' VERIFIED.'
    --else 
    --print 'Procedure ' + @ProcName + ' FAILED VERIFICATION.'
    --        PRINT 'RE-Created DELETE Procedure: ' + @ProcName;
    --    END;

    IF @CreateAllJobs = 1
        BEGIN EXEC proc_GenJobBaseTableSync @Interval, @ProcName;
            PRINT 'Created JOB : ' + 'JOB_' + @ProcName;
        END;
    SET @mysql = '';

    --********************************************************************************************************
    SET @II = 0;
    DECLARE
           @X AS integer = -1
         , @X2 AS integer = -1
         , @XTableCOLS AS nvarchar (max) = '';

    DECLARE ZCursor CURSOR
        FOR SELECT strValue
              FROM #FTCols;
    OPEN ZCursor;
    FETCH NEXT FROM ZCursor INTO @tCol;
    WHILE @@FETCH_STATUS = 0
        BEGIN

            SET @tCol = (SELECT REPLACE (@tCol, CHAR (10) , '')) ;
            SET @II = @II + 1;
            IF @II < @iCols
                BEGIN EXEC @X = dbo.proc_IsColPrimaryKey @InstanceName, @TblName, @tCol;
                    EXEC @X2 = dbo.proc_IsColIdentity @InstanceName, @TblName, @tCol;
                    IF @X = 0
                   AND @X2 = 0
                        BEGIN
                            SET @XTableCOLS = @XTableCOLS + '   S.' + @tCol + ' = T.' + @tCol + ',' + CHAR (10) ;
                        END;
                END;
            ELSE
                BEGIN EXEC @X = proc_IsColPrimaryKey @InstanceName, @TblName, @tCol;
                    IF @X = 0
                        BEGIN
                            SET @XTableCOLS = @XTableCOLS + '   S.' + @tCol + ' = T.' + @tCol + ' ' + CHAR (10) ;
                        END;
                END;
            FETCH NEXT FROM ZCursor INTO @tCol;
        END;

    CLOSE ZCursor;
    DEALLOCATE ZCursor;

    --**********************************CREATE UPDATE PROC ****************************************************
    SET @ProcName = 'proc_' + @BaseTblName + '_' + @InstanceName + '_Update';
    IF NOT EXISTS (SELECT name
                     FROM sys.procedures
                     WHERE name = @ProcName) 
        BEGIN
            PRINT 'CREATING PROCEDURE: ' + @ProcName;
        END;
    ELSE
        BEGIN
            PRINT '3 - PROCEDURE: ' + @ProcName + ' ALREADY EXISTS, dropping and recreating.';
            SET @MySql = 'Drop Procedure ' + @ProcName;
            EXEC (@MySql) ;
        END;

    -- USE KenticoCMS_Datamart_2
    --********************************** GENERATE CT REQUIRED OBJECTS *************************************

    EXEC mart_GenViewObjVars @InstanceName, @TblName, @r OUTPUT;
    SET @ViewObjVars = (SELECT @r) ;
    --print '@ViewObjVars: ' + @ViewObjVars ;

    DECLARE
           @ObjCaseStmts varchar (max) ;
    --*****************************************************************************
    EXEC mart_GenViewObjCaseStmts @InstanceName, @TblName, @r OUTPUT;
    --*****************************************************************************
    SET @ObjCaseStmts = (SELECT @r) ;
    SET @Msg = '@ObjCaseStmts: ' + @ObjCaseStmts;
    EXEC PrintImmediate @msg;

    --**********************************CREATE UPDATE PROC ****************************************************
    SET @mysql = '';
    SET @mysql = @mysql + ' CREATE PROCEDURE ' + @ProcName + ' (@VersionNbr bigint = null) ' + CHAR (10) ;
    SET @mysql = @mysql + ' AS ' + CHAR (10) ;
    SET @mysql = @mysql + ' BEGIN ' + CHAR (10) ;
    SET @mysql = @mysql + 'SET NOCOUNT ON; ' + CHAR (10) ;
    --****************************************************************
    DECLARE
           @VarDcls varchar (max) ;
    EXEC mart_GenColObjVarDcls @InstanceName, @TblName, @r OUTPUT;
    SET @VarDcls = (SELECT @r) ;
    SET @mysql = @mysql + @VarDcls + CHAR (10) + CHAR (10) ;
    --****************************************************************
    DECLARE
           @VarSetStmts varchar (max) ;
    EXEC mart_GenPopulateObjVarSetStmts @InstanceName, @TblName, @r OUTPUT;
    SET @VarSetStmts = (SELECT @r) ;
    SET @mysql = @mysql + @VarSetStmts + CHAR (10) + CHAR (10) ;
    PRINT '@VarSetStmts: ' + @VarSetStmts;
    --****************************************************************

    SET @mysql = @mysql + '     WITH CTE ( ' + CHAR (10) ;
    SET @mysql = @mysql + '         ' + @strPkeys + CHAR (10) ;
    SET @mysql = @mysql + '         ,SYS_CHANGE_VERSION' + CHAR (10) ;
    SET @mysql = @mysql + '         ,SYS_CHANGE_COLUMNS' + CHAR (10) ;
    SET @mysql = @mysql + '        )  ' + CHAR (10) ;
    SET @mysql = @mysql + '         AS ( SELECT ' + CHAR (10) ;
    SET @mysql = @mysql + '                     ' + @strPkeys + CHAR (10) ;
    SET @mysql = @mysql + '                     ,SYS_CHANGE_VERSION' + CHAR (10) ;
    SET @mysql = @mysql + '                     ,SYS_CHANGE_COLUMNS' + CHAR (10) ;
    SET @mysql = @mysql + '                     FROM CHANGETABLE (CHANGES ' + @FQN + ', @VersionNbr) AS CT ' + CHAR (10) ;
    SET @mysql = @mysql + '                     WHERE SYS_CHANGE_OPERATION = ''U'')  ' + CHAR (10) ;
    SET @mysql = @mysql + '         UPDATE S ' + CHAR (10) ;
    SET @mysql = @mysql + '                SET ' + CHAR (10) ;
    SET @mysql = @mysql + '     ' + @XTableCOLS + CHAR (10) ;
    SET @mysql = @mysql + '                  ,S.LastModifiedDate = GETDATE ()  ' + CHAR (10) ;
    SET @mysql = @mysql + '                  ,S.SYS_CHANGE_VERSION = CTE.SYS_CHANGE_VERSION ' + CHAR (10) ;
    --********************************************************************************************************
    SET @mysql = @mysql + @ViewObjVars;
    --SET @mysql = @mysql + @VarSetStmts;
    SET @mysql = @mysql + @ObjCaseStmts;
    SET @mysql = @mysql + CHAR (10) ;
    --********************************************************************************************************
    SET @mysql = @mysql + '                    FROM ' + @FQN + ' AS T ' + CHAR (10) ;
    SET @mysql = @mysql + '                             JOIN ' + CHAR (10) ;
    SET @mysql = @mysql + '                             ' + @BaseTblName + ' AS S ' + CHAR (10) ;
    SET @mysql = @mysql + '                                 ON ' + CHAR (10) ;
    --SET @mysql = @mysql + '                                 S.UserSiteID = T.UserSiteID ' + CHAR (10) ;
    SET @mysql = @mysql + '                                 ' + @CTEPkeys + CHAR (10) ;
    SET @mysql = @mysql + '                             JOIN CTE ' + CHAR (10) ;

    SET @CTEPkeys = REPLACE (@CTEPkeys, 'S.', 'CTE.') ;

    SET @mysql = @mysql + '                                 ON ' + @CTEPkeys + CHAR (10) ;

    SET @mysql = @mysql + ' where S.DBNAME = ''' + @InstanceName + ''';		 --LOC001-02' + CHAR (10) ;

    SET @mysql = @mysql + 'declare @TotRecs as int = @@ROWCOUNT ; ' + CHAR (10) ;
    SET @mysql = @mysql + 'print ''RETURNED COUNT: '' + cast(@TotRecs  as nvarchar(50)) ; ' + CHAR (10) ;
    SET @mysql = @mysql + 'return @TotRecs ;' + CHAR (10) ;
    SET @mysql = @mysql + 'END ' + CHAR (10) ;

    IF @DeBug = 1
        BEGIN
            PRINT '************************************* BEGIN UPDATE PROC ******************************';
            PRINT @mysql;
            SELECT @mysql;
            PRINT '************************************* END UPDATE PROC ******************************';
        END;
    EXEC (@mysql) ;
    SET @Msg = 'CREATED Procedure: ' + @ProcName;
    EXEC PrintImmediate @msg;

    IF @CreateAllJobs = 1
        BEGIN EXEC proc_GenJobBaseTableSync @Interval, @ProcName;
            SET @Msg = 'Created JOB : ' + 'JOB_' + @ProcName;
            EXEC PrintImmediate @msg;
        END;

    --******************************************************************************
    SET @MySql = '';
    SET @ProcName = 'proc_' + @BaseTblName + '_' + @InstanceName + +'_SYNC';
    SET @BaseTableCOLS = (SELECT REPLACE (@BaseTableCOLS, 'CT.SYS_CHANGE_VERSION', '0 as SYS_CHANGE_VERSION')) ;

    SET @MySql = @MySql + 'CREATE PROCEDURE ' + @ProcName + ' (@VersionNbr bigint = null, @ReloadAll int = 0) ' + CHAR (10) ;
    SET @MySql = @MySql + 'AS ' + CHAR (10) ;
    SET @MySql = @MySql + 'BEGIN ' + CHAR (10) ;
    SET @MySql = @MySql + ' ' + CHAR (10) ;
    SET @mysql = @mysql + '  SET NOCOUNT ON; ' + CHAR (10) ;
    SET @MySql = @MySql + '    DECLARE @Action AS NVARCHAR(10) = NULL; ' + CHAR (10) ;
    SET @MySql = @MySql + '    DECLARE @NbrRecs AS bigint = 0; ' + CHAR (10) ;
    SET @MySql = @MySql + '    DECLARE @RowGuid AS nvarchar (100) = CAST (NEWID () AS nvarchar (50)) ; ' + CHAR (10) ;
    SET @MySql = @MySql + '    SET @Action = ''N''; ' + CHAR (10) ;
    SET @MySql = @MySql + '    EXEC proc_PERFMON_PullTime_HIST @RowGuid, @Action, ''' + @InstanceName + ''', ''' + @TblName + '''' + ', @NbrRecs, ''' + @ProcName + '''; ' + CHAR (10) ;
    SET @MySql = @MySql + ' ' + CHAR (10) ;
    SET @MySql = @MySql + '    --************************************************************************************* ' + CHAR (10) ;
    SET @MySql = @MySql + '    SET @Action = ''IS''; ' + CHAR (10) ;
    SET @MySql = @MySql + '    EXEC proc_PERFMON_PullTime_HIST @RowGuid, @Action, ''' + @InstanceName + ''', ''' + @TblName + '''' + ', @NbrRecs, ''' + @ProcName + '''; ' + CHAR (10) ;

    SET @MySql = @MySql + '    -- ' + CHAR (10) ;
    SET @MySql = @MySql + '        if @ReloadAll = 1 ' + CHAR (10) ;
    SET @MySql = @MySql + '        begin' + CHAR (10) ;
    SET @MySql = @MySql + '             delete from ' + @BaseTblName + ' where DBNAME = ''' + @InstanceName + ''' ; ' + CHAR (10) ;
    SET @MySql = @MySql + '        end ;' + CHAR (10) + CHAR (10) ;

    SET @MySql = @MySql + '    --     Locator LOCID100XX' + CHAR (10) ;

    SET @MySql = @MySql + '    WITH CTE_NEW ( ' + CHAR (10) ;
    SET @mysql = @mysql + '         ' + @strPkeys + CHAR (10) ;
    SET @MySql = @MySql + '         )  ' + CHAR (10) ;
    SET @MySql = @MySql + '        AS ( ' + CHAR (10) ;
    SET @MySql = @MySql + '        SELECT ' + CHAR (10) ;
    SET @mysql = @mysql + '         ' + @strPkeys + CHAR (10) ;
    SET @MySql = @MySql + '			 FROM ' + @BaseTblName + CHAR (10) ;
    SET @MySql = @MySql + '			 Where DBNAME = ''' + @InstanceName + '''' + CHAR (10) ;
    SET @MySql = @MySql + '        EXCEPT ' + CHAR (10) ;
    SET @MySql = @MySql + '        SELECT ' + CHAR (10) ;
    SET @mysql = @mysql + '         ' + @strPkeys + CHAR (10) ;
    SET @MySql = @MySql + '               FROM ' + @FQN + CHAR (10) ;
    SET @MySql = @MySql + '        )  ' + CHAR (10) ;
    SET @MySql = @MySql + ' ' + CHAR (10) ;
    SET @MySql = @MySql + '    DELETE B ' + CHAR (10) ;
    SET @MySql = @MySql + '    FROM ' + @BaseTblName + ' B ' + CHAR (10) ;
    SET @MySql = @MySql + '    INNER JOIN CTE_NEW C ' + CHAR (10) ;


    IF @Debug = 1
        BEGIN
            PRINT '@ON_Clause: ' + @ON_Clause;
        END;
    DECLARE
           @Temp_ON_Clause nvarchar (250) = '';
    SET @Temp_ON_Clause = REPLACE (@ON_Clause, 'FT.', 'B.') ;
    SET @Temp_ON_Clause = REPLACE (@Temp_ON_Clause, 'CT.', 'C.') ;

    IF @Debug = 1
        BEGIN
            PRINT '@Temp_ON_Clause: ' + @Temp_ON_Clause;
        END;

    SET @MySql = @MySql + '        ' + @Temp_ON_Clause + ' ' + CHAR (10) ;
    SET @MySql = @MySql + ' where DBNAME = ''' + @InstanceName + ''' ;    --QX001' + CHAR (10) ;
    SET @mysql = @mysql + 'declare @DelRecs as int = @@ROWCOUNT ; ' + CHAR (10) ;
    SET @mysql = @mysql + 'print ''DELETED COUNT: '' + cast(@DelRecs  as nvarchar(50)) ; ' + CHAR (10) ;

    SET @MySql = @MySql + '    --     Locator LOCID200XX' + CHAR (10) ;

    SET @MySql = @MySql + '    WITH CTE_NEW ( ' + CHAR (10) ;
    SET @mysql = @mysql + '         ' + @strPkeys + CHAR (10) ;
    SET @MySql = @MySql + '         )  ' + CHAR (10) ;
    SET @MySql = @MySql + '        AS ( ' + CHAR (10) ;
    SET @MySql = @MySql + '        SELECT ' + CHAR (10) ;
    SET @mysql = @mysql + '         ' + @strPkeys + CHAR (10) ;
    SET @MySql = @MySql + '               FROM ' + @FQN + CHAR (10) ;
    SET @MySql = @MySql + '        EXCEPT ' + CHAR (10) ;
    SET @MySql = @MySql + '        SELECT ' + CHAR (10) ;
    SET @mysql = @mysql + '         ' + @strPkeys + CHAR (10) ;
    SET @MySql = @MySql + '			 FROM ' + @BaseTblName + CHAR (10) ;
    SET @MySql = @MySql + '			 Where DBNAME = ''' + @InstanceName + '''' + CHAR (10) ;
    SET @MySql = @MySql + '        )  ' + CHAR (10) ;
    SET @MySql = @MySql + ' ' + CHAR (10) ;
    SET @mysql = @mysql + 'INSERT INTO ' + @BaseTblName + CHAR (10) ;
    SET @mysql = @mysql + '(' + CHAR (10) ;
    SET @mysql = @mysql + @FactTableCOLS + CHAR (10) ;
    SET @mysql = @mysql + ')' + CHAR (10) ;
    SET @mysql = @mysql + 'SELECT' + CHAR (10) ;
    SET @mysql = @mysql + @BaseTableCOLS + CHAR (10) ;
    SET @MySql = @MySql + '               FROM ' + CHAR (10) ;
    SET @MySql = @MySql + '                   ' + @InstanceName + '.dbo.' + @TblName + ' AS FT ' + CHAR (10) ;
    SET @MySql = @MySql + '                       JOIN CTE_NEW AS CT ' + CHAR (10) ;
    SET @MySql = @MySql + '                           ' + @ON_Clause + '    --LOC Z01 ' + CHAR (10) ;
    SET @MySql = @MySql + '--KX001 ' + CHAR (10) ;
    SET @mysql = @mysql + 'declare @TotRecs as int = @@ROWCOUNT ; ' + CHAR (10) ;
    SET @mysql = @mysql + 'print ''INSERTED COUNT: '' + cast(@TotRecs  as nvarchar(50)) ; ' + CHAR (10) ;

    SET @MySql = @MySql + '    --     Locator LOCID300XX' + CHAR (10) ;
    DECLARE
           @DDL varchar (max) ;
    --*********************************************************************************
    EXEC proc_GenSyncUpdateDML @InstanceName, @TblName, @DDL OUTPUT;
    SELECT @mysql = @mysql + @DDL + CHAR (10) ;
    --*********************************************************************************
    SET @mysql = @mysql + 'declare @iTotRecs int = @@ROWCOUNT ; ' + CHAR (10) ;
    SET @mysql = @mysql + 'print ''UPDATED COUNT: '' + cast(@iTotRecs as nvarchar(50)) ; ' + CHAR (10) + CHAR (10) ;
    SET @MySql = @MySql + '    EXEC proc_ResetTableCTVersionToLatest ''' + @InstanceName + ''',''' + @InstanceName + ''',''' + @TblName + ''',0; ' + CHAR (10) ;

    SET @MySql = @MySql + '    -- ' + CHAR (10) ;
    SET @MySql = @MySql + '    SET @Action = ''IE''; ' + CHAR (10) ;
    SET @MySql = @MySql + '    EXEC proc_PERFMON_PullTime_HIST @RowGuid, @Action, ''' + @InstanceName + ''', ''' + @TblName + '''' + ', @iTotRecs, ''' + @ProcName + '''; ' + CHAR (10) ;
    SET @MySql = @MySql + '    --************************************************************************************* ' + CHAR (10) ;
    SET @MySql = @MySql + '    SET @Action = ''T''; ' + CHAR (10) ;
    SET @MySql = @MySql + '    EXEC proc_PERFMON_PullTime_HIST @RowGuid, @Action, ''' + @InstanceName + ''', ''' + @TblName + '''' + ', @iTotRecs, ''' + @ProcName + '''; ' + CHAR (10) ;
    SET @MySql = @MySql + '    --************************************************************************************* ' + CHAR (10) ;
    SET @MySql = @MySql + '    IF @ReloadAll = 1 ' + CHAR (10) ;
    SET @MySql = @MySql + '    BEGIN                --ZX1001' + CHAR (10) ;
    SET @MySql = @MySql + '        truncate table ' + @TblName + '_DEL ; ' + CHAR (10) ;
    SET @MySql = @MySql + '        exec proc_InitializeDelTableData ' + @TblName + '_DEL, 0  ; ' + CHAR (10) ;
    SET @MySql = @MySql + '    END ' + CHAR (10) ;
    SET @MySql = @MySql + '    --************************************************************************************* ' + CHAR (10) ;

    SET @mysql = @mysql + 'return @iTotRecs ;' + CHAR (10) ;
    --    SET @mysql = @mysql + 'SET IDENTITY_INSERT ' + @BaseTblName + ' OFF ;' + CHAR ( 10) ;
    SET @MySql = @MySql + 'END; ' + CHAR (10) ;

    PRINT 'Created: ' + @ProcName;
    IF @Debug = 1
        BEGIN
            SELECT @MySql AS SYNC_DLL;
            PRINT @mysql;
        END;

    IF NOT EXISTS (SELECT name
                     FROM sys.procedures
                     WHERE name = @ProcName) 
        BEGIN
            PRINT '4 - CREATING PROCEDURE: ' + @ProcName;
        END;
    ELSE
        BEGIN
            PRINT '4 - PROCEDURE: ' + @ProcName + ' ALREADY EXISTS, dropping and recreating.';
            SET @MySql2 = 'Drop Procedure ' + @ProcName;
            EXEC (@MySql2) ;
        END;
    EXEC (@MySql) ;

    IF @CreateAllJobs = 1
        BEGIN EXEC proc_GenJobBaseTableSync @Interval, @ProcName;
            PRINT 'Created JOB : ' + 'JOB_' + @ProcName;
        END;

    --*******************************VERIFY DELETE PROC EXISTS*****************************************
    IF NOT EXISTS (SELECT name
                     FROM sys.procedures
                     WHERE name = @DeleteProcNAme) 
        BEGIN
            PRINT @DeleteProcNAme + ' Regenerating DELETE PROCEDURE.';
            EXEC (@DeleteProcSql) ;
        END;
    ELSE
        BEGIN
            PRINT @DeleteProcNAme + ' DELETE PROCEDURE NOW EXISTS.';
        END;
    --*******************************CREATE PROC APPLY CT CHANGES *****************************************
    SET @ProcName = 'proc_' + @BaseTblName + '_' + @InstanceName + '_ApplyCT';
    IF EXISTS (SELECT name
                 FROM sys.procedures
                 WHERE name = @ProcName) 
        BEGIN
            SET @MySql = 'drop procedure ' + @ProcName;
            EXEC (@MySql) ;
        END;
    SET @MySql = '';
    SET @MySql = @MySql + 'CREATE PROCEDURE ' + @ProcName + CHAR (10) ;
    SET @MySql = @MySql + 'AS ' + CHAR (10) ;
    SET @MySql = @MySql + 'BEGIN ' + CHAR (10) ;
    SET @MySql = @MySql + ' ' + CHAR (10) ;
    SET @mysql = @mysql + 'SET NOCOUNT ON; ' + CHAR (10) ;
    SET @MySql = @MySql + '    DECLARE @RowGuid AS nvarchar (100) = CAST (NEWID () AS nvarchar (50)) ; ' + CHAR (10) ;
    SET @MySql = @MySql + '    DECLARE @Action AS nvarchar (10) = null; ' + CHAR (10) ;
    SET @MySql = @MySql + '    DECLARE @NbrRecs AS bigint = 0; ' + CHAR (10) ;
    SET @MySql = @MySql + '    DECLARE @InstanceName AS nvarchar (100) = null; ' + CHAR (10) ;
    SET @MySql = @MySql + '    DECLARE @TblName AS nvarchar (100) = null; ' + CHAR (10) ;
    SET @MySql = @MySql + '    DECLARE @VersionTrackingTabl AS nvarchar (100) = null; ' + CHAR (10) ;
    SET @MySql = @MySql + '    DECLARE @MySql AS nvarchar (max) = null; ' + CHAR (10) ;
    SET @MySql = @MySql + '    DECLARE @last_sync_version  AS bigint = -1; ' + CHAR (10) ;
    SET @MySql = @MySql + '    DECLARE @curr_version  AS bigint = -1; ' + CHAR (10) ;
    SET @MySql = @MySql + '    DECLARE @result TABLE ( ' + CHAR (10) ;
    SET @MySql = @MySql + '                          LastVerNo bigint) ; ' + CHAR (10) ;
    SET @MySql = @MySql + ' ' + CHAR (10) ;
    SET @MySql = @MySql + '    SET @TblName = ''' + @TblName + '''; ' + CHAR (10) ;
    SET @MySql = @MySql + '    SET @InstanceName = ''' + @InstanceName + '''; ' + CHAR (10) ;
    SET @MySql = @MySql + '    SET @VersionTrackingTabl = ''' + @VersionTrackingTabl + '''; ' + CHAR (10) ;
    SET @MySql = @MySql + '    SET @curr_version = (SELECT ' + CHAR (10) ;
    SET @MySql = @MySql + '                                MAX (CT.SYS_CHANGE_VERSION)  ' + CHAR (10) ;
    SET @MySql = @MySql + '                                FROM CHANGETABLE ( CHANGES ' + @InstanceName + '.dbo.' + @TblName + ', NULL) AS ct); ' + CHAR (10) ;
    SET @MySql = @MySql + ' ' + CHAR (10) ;

    SET @MySql = @MySql + '    DECLARE @iCnt int = 0; ' + CHAR (10) ;
    SET @MySql = @MySql + '    EXEC @iCnt = proc_ifExistCurrVersionNbr @VersionTrackingTabl  , @InstanceName, @curr_version; ' + CHAR (10) ;
    SET @MySql = @MySql + '    IF @iCnt > 0 ' + CHAR (10) ;
    SET @MySql = @MySql + '         BEGIN ' + CHAR (10) ;
    SET @MySql = @MySql + '             PRINT ''Current version has previously been processed, returning.''; ' + CHAR (10) ;
    SET @MySql = @MySql + '             RETURN; ' + CHAR (10) ;
    SET @MySql = @MySql + '         END; ' + CHAR (10) ;

    SET @MySql = @MySql + '    EXEC @last_sync_version = proc_GetMaxCTVersionNbr @VersionTrackingTabl, @InstanceName ; ' + CHAR (10) ;
    SET @MySql = @MySql + ' ' + CHAR (10) ;
    SET @MySql = @MySql + '    SET @Action = ''N''; ' + CHAR (10) ;
    SET @MySql = @MySql + '    EXEC proc_PERFMON_PullTime_HIST @RowGuid, @Action, @InstanceName, @TblName, @NbrRecs, ''' + @ProcName + '''; ' + CHAR (10) ;
    SET @MySql = @MySql + ' ' + CHAR (10) ;
    SET @MySql = @MySql + '    set @MySql = ''select max(SYS_CHANGE_VERSION) from ' + @VersionTrackingTabl + ' Where DBMS = ''''' + @InstanceName + '''''' + ' ; ' + '''' + CHAR (10) ;
    SET @MySql = @MySql + ' ' + CHAR (10) ;
    SET @MySql = @MySql + '    INSERT INTO @result ( ' + CHAR (10) ;
    SET @MySql = @MySql + '           LastVerNo)  ' + CHAR (10) ;
    SET @MySql = @MySql + '    EXEC (@MySql) ; ' + CHAR (10) ;
    SET @MySql = @MySql + ' ' + CHAR (10) ;
    SET @MySql = @MySql + '    SET @last_sync_version = (SELECT TOP (1)  ' + CHAR (10) ;
    SET @MySql = @MySql + '                                     LastVerNo ' + CHAR (10) ;
    SET @MySql = @MySql + '                                     FROM @result); ' + CHAR (10) ;
    SET @MySql = @MySql + '    IF @last_sync_version IS NULL ' + CHAR (10) ;
    SET @MySql = @MySql + '        BEGIN ' + CHAR (10) ;
    SET @MySql = @MySql + '            SET @last_sync_version = 0; ' + CHAR (10) ;
    SET @MySql = @MySql + '        END; ' + CHAR (10) ;
    SET @MySql = @MySql + '    PRINT ''PULLING VERSION# '' + CAST (@last_sync_version AS nvarchar (50)) ; ' + CHAR (10) ;
    SET @MySql = @MySql + ' ' + CHAR (10) ;
    SET @MySql = @MySql + '    --************************************************************************************* ' + CHAR (10) ;
    SET @MySql = @MySql + '    SET @Action = ''IS''; ' + CHAR (10) ;
    SET @MySql = @MySql + '    EXEC proc_PERFMON_PullTime_HIST @RowGuid, @Action, @InstanceName, @TblName, @NbrRecs, NULL; ' + CHAR (10) ;
    SET @MySql = @MySql + '    -- ' + CHAR (10) ;

    SET @ProcName = 'proc_' + @BaseTblName + '_' + @InstanceName + '_Insert';

    SET @MySql = @MySql + '    EXEC @NbrRecs = ' + @ProcName + ' @last_sync_version; ' + CHAR (10) ;
    SET @MySql = @MySql + '    -- ' + CHAR (10) ;
    SET @MySql = @MySql + '    SET @Action = ''IE''; ' + CHAR (10) ;
    SET @MySql = @MySql + '    EXEC proc_PERFMON_PullTime_HIST @RowGuid, @Action, @InstanceName, @TblName, @NbrRecs, NULL; ' + CHAR (10) ;
    SET @MySql = @MySql + '    --************************************************************************************* ' + CHAR (10) ;
    SET @MySql = @MySql + '    SET @Action = ''US''; ' + CHAR (10) ;
    SET @MySql = @MySql + '    -- ' + CHAR (10) ;
    SET @MySql = @MySql + '    EXEC proc_PERFMON_PullTime_HIST @RowGuid, @Action, @InstanceName, @TblName, @NbrRecs, NULL; ' + CHAR (10) ;

    SET @ProcName = 'proc_' + @BaseTblName + '_' + @InstanceName + '_Update';

    SET @MySql = @MySql + '    EXEC @NbrRecs = ' + @ProcName + ' @last_sync_version; ' + CHAR (10) ;
    SET @MySql = @MySql + '    -- ' + CHAR (10) ;
    SET @MySql = @MySql + '    SET @Action = ''UE''; ' + CHAR (10) ;
    SET @MySql = @MySql + '    EXEC proc_PERFMON_PullTime_HIST @RowGuid, @Action, @InstanceName, @TblName, @NbrRecs, NULL; ' + CHAR (10) ;
    SET @MySql = @MySql + '    --************************************************************************************* ' + CHAR (10) ;
    SET @MySql = @MySql + '    SET @Action = ''DS''; ' + CHAR (10) ;
    SET @MySql = @MySql + '    EXEC proc_PERFMON_PullTime_HIST @RowGuid, @Action, @InstanceName, @TblName, @NbrRecs, NULL; ' + CHAR (10) ;
    SET @MySql = @MySql + '    -- ' + CHAR (10) ;

    SET @ProcName = 'proc_' + @BaseTblName + '_' + @InstanceName + '_Delete';

    SET @MySql = @MySql + '    EXEC @NbrRecs = ' + @ProcName + ' @last_sync_version; ' + CHAR (10) ;
    SET @MySql = @MySql + '    -- ' + CHAR (10) ;
    SET @MySql = @MySql + '    SET @Action = ''DE''; ' + CHAR (10) ;
    SET @MySql = @MySql + '    EXEC proc_PERFMON_PullTime_HIST @RowGuid, @Action, @InstanceName, @TblName, @NbrRecs, NULL; ' + CHAR (10) ;
    SET @MySql = @MySql + '    --************************************************************************************* ' + CHAR (10) ;
    SET @MySql = @MySql + '    SET @Action = ''T''; ' + CHAR (10) ;
    SET @MySql = @MySql + '    EXEC proc_PERFMON_PullTime_HIST @RowGuid, @Action, @InstanceName, @TblName, @NbrRecs, NULL; ' + CHAR (10) ;
    SET @MySql = @MySql + '    --************************************************************************************* ' + CHAR (10) ;
    SET @MySql = @MySql + ' ' + CHAR (10) ;
    SET @MySql = @MySql + '    EXEC proc_SaveCurrCTVersionNbr @InstanceName, @TblName , @curr_version; ' + CHAR (10) ;
    SET @MySql = @MySql + ' ' + CHAR (10) ;
    SET @MySql = @MySql + 'END; ' + CHAR (10) ;

    PRINT 'Created: ' + @ProcName;

    IF @Debug = 1
        BEGIN
            PRINT @mysql;
        END;

    IF NOT EXISTS (SELECT name
                     FROM sys.procedures
                     WHERE name = @ProcName) 
        BEGIN
            PRINT '5 - CREATING PROCEDURE: ' + @ProcName;
        END;
    ELSE
        BEGIN
            PRINT '5 - PROCEDURE: ' + @ProcName + ' ALREADY EXISTS, dropping and rereating.';
            SET @MySql2 = 'Drop Procedure ' + @ProcName;
            EXEC (@MySql2) ;
        END;
    EXEC (@MySql) ;

    IF @Debug = 1
        BEGIN
            PRINT @MySql;
        END;
    PRINT 'Created MASTER PROC : ' + @ProcName;

    IF EXISTS (SELECT name
                 FROM sys.procedures
                 WHERE name = 'proc_GenJobBaseTableSync') 
        BEGIN EXEC proc_GenJobBaseTableSync @Interval, @ProcName;
        END;
    ELSE
        BEGIN
            PRINT 'MSG ERROR 002: proc_GenJobBaseTableSync NOT found.';
            RAISERROR ('MSG ERROR 002: proc_GenJobBaseTableSync NOT found.', 14, 1) WITH NOWAIT;
        END;

    PRINT 'Created JOB : ' + 'JOB_' + @ProcName;

    SET NOCOUNT OFF;

    PRINT 'Pulling data from ' + @InstanceName + '.' + @TblName;
    DECLARE
           @InitProc AS nvarchar (200) = 'proc_' + @BaseTblName + '_' + @InstanceName + '_SYNC';

    IF @GenProcOnlyDoNotPullData = 0
        BEGIN EXEC (@InitProc) ;
        END;
    PRINT 'PULLED data from ' + @InstanceName + '.' + @TblName;
    PRINT '---------------------------------------------------------';

    --if @GenProcOnlyDoNotPullData = 0 
    --EXEC proc_UpdateTrackerDataSurrogateKey @BaseTblName;

    IF NOT EXISTS (SELECT name
                     FROM sys.procedures
                     WHERE name = @DeleteProcNAme) 
        BEGIN
            PRINT @DeleteProcNAme + ' Regenerating DELETE PROCEDURE.';
            EXEC (@DeleteProcSql) ;
        END;
    ELSE
        BEGIN
            PRINT @DeleteProcNAme + ' DELETE PROCEDURE NOW EXISTS.';
        END;

    PRINT '*!*!*!*!*!*!*!**!*!*!*!*!*!*!**!*!*!*!*!*!*!**!*!*!*!*!*!*!**!*!*!*!*!*!*!*';
    PRINT 'COMPLETED proc_genPullChangesProc: ' + @InstanceName + '.' + @TblName;
    PRINT 'END: ' + CAST (GETDATE () AS nvarchar (50)) ;
    PRINT '*!*!*!*!*!*!*!**!*!*!*!*!*!*!**!*!*!*!*!*!*!**!*!*!*!*!*!*!**!*!*!*!*!*!*!*';

    RETURN 0;

END;
GO
PRINT 'Created proc_genPullChangesProc';
GO



