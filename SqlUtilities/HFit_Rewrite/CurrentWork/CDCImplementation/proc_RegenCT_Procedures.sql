

USE KenticoCMS_Datamart_2;
GO

DECLARE
     @InstanceName NVARCHAR (250) = 'KenticoCMS_1',@TblNAme NVARCHAR (250) = 'CMS_User';

DECLARE
     @BASETable NVARCHAR (250) = ''
    ,@ChgTable NVARCHAR (250) = ''
    ,@DelTable NVARCHAR (250) = '';

set @BASETable  = '' + @TblNAme;
set @ChgTable = @BASETable + '_CTVerHIST';
set @DelTable = '' + @TblName + '_DEL'

DECLARE
     @r VARCHAR ( MAX) 
    ,@mysql VARCHAR ( MAX) 
    ,@DDL VARCHAR ( MAX) 
   , @SurrogateKeyName AS NVARCHAR ( 100) = ''
   , @tsql AS NVARCHAR (MAX) = ''
   , @Msg AS NVARCHAR (MAX) = ''
   , @s AS NVARCHAR (MAX) = ''
   , @tcnt AS INT = 0
   , @StartTime AS DATETIME = GETDATE () 
   , @rowcount INT   
   , @TS AS NVARCHAR (500) = 'select count(*) from ' + @InstanceName + '.information_schema.tables where table_name = ''' + @TblName + '''';
DECLARE
     @xcolname AS NVARCHAR (500) = @TblName + '_GuidID'
   , @pkname AS NVARCHAR (500) = 'PKey_CT_' + @TblName;

SET @SurrogateKeyName = 'SurrogateKey_' + @TblName;
EXEC @tcnt = isPrimaryKeyExists @InstanceName , @TblName;

IF @tcnt = 0
    BEGIN
        SET @tsql = 'ALTER TABLE ' + @InstanceName + '.dbo.' + @TblName + ' ADD ' + @xcolname + ' uniqueidentifier not null default newid() ';
        EXEC (@tsql) ;
        SET @tsql = 'ALTER TABLE ' + @InstanceName + '.dbo.' + @TblName + ' ADD CONSTRAINT ' + @pkname + ' PRIMARY KEY (' + @xcolname + ') ';
        EXEC (@tsql) ;
    END;

SET @SurrogateKeyName = 'SurrogateKey_' + @TblName;
IF NOT EXISTS ( SELECT
                       COLUMN_NAME
                FROM INFORMATION_SCHEMA.COLUMNS
                WHERE
                       COLUMN_NAME = @SurrogateKeyName AND
                       TABLE_NAME = @BASETable) 
    BEGIN
        SET @msg = 'Adding Column ' + @SurrogateKeyName + ' to ' + @BASETable;
        EXEC PrintImmediate @msg;
        SET @S = 'ALTER TABLE ' + @BASETable + ' ADD ' + @SurrogateKeyName + ' bigint identity (1,1) not NULL ';
        PRINT @s;
        EXEC ( @S) ;
    END;

IF EXISTS ( SELECT
                   TABLE_NAME
            FROM INFORMATION_SCHEMA.TABLES
            WHERE
                   TABLE_NAME = @BASETable) 
    BEGIN
        SET @Msg = 'Verifying CT cols in ' + @BASETable;
        EXEC PrintImmediate @Msg;

        --ADD CT Columns to the BASE table

        EXEC mart_GenObjVarBitFlgAlterStmts @InstanceName , @TblName , @r OUTPUT;

    --SELECT @r ;

    END;

SET @Msg = '11X - Verifying CT cols in ' + @BASETable;
EXEC PrintImmediate @Msg;
EXEC mart_GenObjVarBitFlgAlterStmts @InstanceName , @TblName , @r OUTPUT;

--SELECT @r ;

IF NOT EXISTS ( SELECT
                       column_name
                FROM information_schema.columns
                WHERE
                       table_name = @BASETable AND
                       column_name = 'CT_RowDataUpdated') 
    BEGIN
        SET @mysql = 'Alter table ' + @BASETable + ' add CT_RowDataUpdated bit null default 1';
    END;
EXEC mart_AddMissingColumns @BASETable , @DelTable;

EXEC proc_genPullChangesProc @InstanceName , @TblName, 0, 1;

EXEC proc_genBaseDelTrigger @BASETable , @DDL OUTPUT;

EXEC proc_genBaseUpdtTrigger @BASETable , @DDL OUTPUT;

EXEC proc_GenCT_HistProcedure @InstanceName , @TBLNAME , @ChgTable , @DDL OUTPUT;