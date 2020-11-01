

use master
go
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'sp_IVP_Databases'
)
    DROP PROCEDURE sp_IVP_Databases;
GO
CREATE PROCEDURE sp_IVP_Databases
AS
    BEGIN
        DECLARE @gendb VARCHAR(1)= 'Y';
        DECLARE @name VARCHAR(250); -- database name 
        DECLARE @fileName VARCHAR(256); -- filename for backup 
        DECLARE @fileDate VARCHAR(20); -- used for file name 
        DECLARE @stmt NVARCHAR(MAX); -- used for file name 

        IF(@gendb = 'Y')
            BEGIN
                DECLARE CUR1 CURSOR
                FOR SELECT [name]
                    FROM sys.databases
                    WHERE [name] NOT IN('master', 'tempdb', 'model', 'msdb', 'ReportServer', 'ReportServerTempDB');
                OPEN CUR1;
                FETCH NEXT FROM CUR1 INTO @name;
                PRINT '/***********************************************************/';
                PRINT 'use MASTER;';
                PRINT '/***********************************************************/';
                PRINT 'GO';
                WHILE @@FETCH_STATUS = 0
                    BEGIN
                        SET @stmt = 'IF NOT EXISTS (select 1 from sys.databases where [name] = ''' + @name + ''')';
                        SET @stmt = @stmt + CHAR(10) + '    print (''ERROR: DATABASE missing ' + @name + ''');';
                        PRINT @stmt;
                        FETCH NEXT FROM CUR1 INTO @name;
        END;
                CLOSE CUR1;
                DEALLOCATE CUR1;
        END;
    END;
GO