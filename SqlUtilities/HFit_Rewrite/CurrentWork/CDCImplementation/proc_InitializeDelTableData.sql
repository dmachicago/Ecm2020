

GO
PRINT 'Executing proc_InitializeDelTableData.sql';
GO
GO
IF EXISTS (SELECT name
             FROM sys.procedures
             WHERE name = 'proc_InitializeDelTableData') 
    BEGIN
        DROP PROCEDURE proc_InitializeDelTableData;
    END;
GO

-- exec proc_InitializeDelTableData BASE_Board_Board_DEL, 0
-- exec proc_InitializeDelTableData BASE_CMS_User_DEL
-- exec proc_InitializeDelTableData BASE_CMS_User_DELX
-- EXEC proc_InitializeDelTableData BASE_CMS_Attachment_DEL, 0
CREATE PROCEDURE proc_InitializeDelTableData (@DelTblName nvarchar (254) 
                                            , @PreviewOnly int = 1) 
AS
BEGIN
    --declare @DelTblName nvarchar(254) = 'BASE_BASE_View_HFit_Coach_Bio_DEL' ;
    --DECLARE @PreviewOnly int = 1;

    IF NOT EXISTS (SELECT name
                     FROM sys.tables
                     WHERE name = @DelTblName) 
        BEGIN
            PRINT 'ERROR: TABLE ' + @DelTblName + ' does not exist, ABORTING LOAD.';
            RETURN;
        END;

    DECLARE
           @MySql nvarchar (max) = ''
         , @cols nvarchar (max) = ''
         , @ActualNumberOfResults int = 0
         , @BaseTblName nvarchar (254) = ''
         , @I int = 0;

    SET @BaseTblName = REPLACE (@DelTblName, '_DEL', '') ;
    IF NOT EXISTS (SELECT name
                     FROM sys.tables
                     WHERE name = @BaseTblName) 
        BEGIN
            PRINT 'ERROR: TABLE ' + @BaseTblName + ' does not exist, ABORTING LOAD.';
            RETURN;
        END;
    DECLARE
           @rowcount TABLE (Value int) ;
    EXEC @I = proc_QuickRowCount @DelTblName;

    --INSERT INTO @rowcount
    --EXEC ('SELECT COUNT(*) from '+@DelTblName) ;
    --SELECT @ActualNumberOfResults = Value
    --  FROM @rowcount;
    --PRINT @ActualNumberOfResults;

    IF @I > 0
        BEGIN
            PRINT 'RECORDS ALREADY EXIST IN TABLE ' + @DelTblName + ', ABORTING LOAD.';
            RETURN;
        END;
    ELSE
	   EXEC @I = proc_QuickRowCount @BaseTblName;
        BEGIN
            PRINT 'NO RECORDS IN TABLE ' + @DelTblName + ', LOADING '+cast(@I as nvarchar(50))+' DELTA records.';
        END;


    SELECT @cols = @cols + column_name + ','
      FROM information_schema.columns
      WHERE table_name = @BaseTblName;

    SET @I = LEN (@cols) - 1;
    --PRINT @I;
    SET @cols = SUBSTRING (@cols, 1, @I) ;
    --PRINT @cols;
    SET @MySql = 'INSERT INTO ' + @DelTblName + ' (' + @cols + +')' + CHAR (10) + 'SELECT ' + @cols + char(10) + ' from ' + @BaseTblName;
    PRINT @MySql;

    IF @PreviewOnly != 1
        BEGIN 
		  PRINT @MySql ;
		  EXEC (@MySql) 
        END;

END;

GO
PRINT 'Created proc_InitializeDelTableData.sql';
GO