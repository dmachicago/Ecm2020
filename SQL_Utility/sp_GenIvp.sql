--use [DMA.UD.License]
--use [ECM.Hive]
--use [ECM.Init]
--use [ECM.Language]
--use [ECM.Library.FS]
--use [ECM.SecureLogin]
--use [ECM.Thesaurus]
--use [EcmGateway]
use [TDR]
go
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'sp_GenIvp'
)
    DROP PROCEDURE sp_GenIvp;
GO
CREATE PROCEDURE sp_GenIvp
AS
    BEGIN
        DECLARE @stmt NVARCHAR(MAX); -- used for file name 
        DECLARE @name VARCHAR(250); -- database name 
        DECLARE CUR1 CURSOR
        FOR SELECT DISTINCT 
                   TABLE_NAME
            FROM INFORMATION_SCHEMA.TABLES;
        OPEN CUR1;
        FETCH NEXT FROM CUR1 INTO @name;
        PRINT CHAR(10) + 'GO';
        PRINT '/***********************************************************/';
        PRINT 'use [' + DB_NAME() + '];';
        PRINT '/***********************************************************/';
        PRINT 'GO';
        WHILE @@FETCH_STATUS = 0
            BEGIN
                SET @stmt = 'IF NOT EXISTS (select 1 from INFORMATION_SCHEMA.TABLES  where table_name = ''' + @name + ''')';
                SET @stmt = @stmt + CHAR(10) + '    print (''ERROR: TABLE missing [' + DB_NAME() + '] : ' + @name + ''');';
                PRINT @stmt;
                FETCH NEXT FROM CUR1 INTO @name;
            END;
        CLOSE CUR1;
        DEALLOCATE CUR1;

        /********************************************/

        DECLARE @col VARCHAR(250);
        DECLARE CUR2 CURSOR
        FOR SELECT TABLE_NAME, 
                   COLUMN_NAME
            FROM INFORMATION_SCHEMA.columns;
        OPEN CUR2;
        FETCH NEXT FROM CUR2 INTO @name, @col;
        PRINT CHAR(10) + 'GO';
        --PRINT 'use [' + DB_NAME() + '];';
        --PRINT 'GO';
        PRINT '/********** CHECK COLUMNS ******************/';
        WHILE @@FETCH_STATUS = 0
            BEGIN
                SET @stmt = 'IF NOT EXISTS (select 1 from INFORMATION_SCHEMA.columns where table_name = ''' + @name + ''' and COLUMN_NAME = ''' + @col + ''')';
                SET @stmt = @stmt + CHAR(10) + '    print (''ERROR: COLUMN missing [' + DB_NAME() + '] : ' + @name + ' @ ' + @col + ''');';
                PRINT @stmt;
                FETCH NEXT FROM CUR2 INTO @name, @col;
            END;
        CLOSE CUR2;
        DEALLOCATE CUR2;
    END;
GO 
