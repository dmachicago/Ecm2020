

PRINT 'executing rebuildMartTable.sql';
GO
IF EXISTS (SELECT name
             FROM sys.procedures
             WHERE name = 'rebuildMartTable') 
    BEGIN
        DROP PROCEDURE rebuildMartTable
    END;
GO
CREATE PROCEDURE rebuildMartTable (@MartTblName AS nvarchar (254)) 
AS
BEGIN

    DECLARE
          @MySql AS nvarchar (max) = '' , 
          @BackupMartTblName AS nvarchar (254) = '' , 
          @HistMartTblName AS nvarchar (254) = '' , 
          @isView bit = 0 , 
          @ProdTblName AS nvarchar (254) = SUBSTRING (@MartTblName , 6 , 9999) ;


    IF LEFT (@ProdTblName , 5) = 'VIEW_'
        BEGIN EXEC PrintImmediate 'Appears to be a view';
            SET @isView = 1;
        END;
    ELSE
        BEGIN
            IF CHARINDEX (@ProdTblName , '_VIEW_') > 1
                BEGIN EXEC PrintImmediate 'Appears to be a view';
                    SET @isView = 1;
                END;
            ELSE
                BEGIN EXEC PrintImmediate 'Appears to be a BASE Table.';
                END;
        END;


    SET @HistMartTblName = @MartTblName + '_DEL';
    SET @BackupMartTblName = @MartTblName + '_DEL_BAK';

    IF EXISTS (SELECT name
                 FROM sys.tables
                 WHERE name = @BackupMartTblName) 
        BEGIN EXEC PrintImmediate 'Preparing to make a backup of the HISTORY.';
            SET @MySql = 'drop table ' + @BackupMartTblName;
            EXEC (@MySql) ;
        END;

    IF EXISTS (SELECT name
                 FROM sys.tables
                 WHERE name = @HistMartTblName) 
        BEGIN EXEC PrintImmediate 'Making a backup of the HISTORY.';
            SET @MySql = 'select * into @BackupMartTblName from @MartTblName ';
            EXEC (@MySql) ;
        END;
    ELSE
        BEGIN EXEC PrintImmediate 'No HISTORY table found.';
        END;

    IF @isView = 1
        BEGIN EXEC proc_genPullChangesProc 'KenticoCMS_1' , @ProdTblName , @DeBug = 0 , @GenProcOnlyDoNotPullData = 1;
            EXEC proc_genPullChangesProc 'KenticoCMS_2' , @ProdTblName , @DeBug = 0 , @GenProcOnlyDoNotPullData = 1;
            EXEC proc_genPullChangesProc 'KenticoCMS_3' , @ProdTblName , @DeBug = 0 , @GenProcOnlyDoNotPullData = 1;
        END;
    ELSE
        BEGIN EXEC proc_GenBaseTableFromView 'KenticoCMS_1' , @ProdTblName , 'no' , @GenJobToExecute = 1 , @SkipIfExists = 0;
            EXEC proc_GenBaseTableFromView 'KenticoCMS_2' , @ProdTblName , 'no' , @GenJobToExecute = 1 , @SkipIfExists = 1;
            EXEC proc_GenBaseTableFromView 'KenticoCMS_3' , @ProdTblName , 'no' , @GenJobToExecute = 1 , @SkipIfExists = 1;
        END;
    EXEC PrintImmediate 'Regenerating the TRIGGERS';
    EXEC regen_CT_Triggers @ProdTblName;
    EXEC PrintImmediate 'Combining ALL jon steps.';
    EXEC combine_Job_Steps_Into_Single_Job @ProdTblName;
END;
GO
PRINT 'executed rebuildMartTable.sql';
GO
