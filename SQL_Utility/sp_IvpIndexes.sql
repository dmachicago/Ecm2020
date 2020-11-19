--D. Miller
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
    WHERE name = 'sp_IvpIndexes'
)
    DROP PROCEDURE sp_IvpIndexes;
GO
-- exec sp_IvpIndexes
CREATE PROCEDURE sp_IvpIndexes
AS
    BEGIN
        SET NOCOUNT ON;  
        PRINT '-- INDEX EVAL Using DATABASE ' + DB_NAME();
       
        PRINT '/********** CHECK INDEXES ******************/';
        DECLARE @stmt NVARCHAR(MAX)= '';
		DECLARE @dbname NVARCHAR(250)= '';
        DECLARE @index_name NVARCHAR(250)= '';
        DECLARE @columns NVARCHAR(MAX)= '';
        DECLARE @index_type NVARCHAR(250)= '';
        DECLARE @unique NVARCHAR(250)= '';
        DECLARE @table_name NVARCHAR(250)= '';
        DECLARE @object_type NVARCHAR(250)= '';
		
		IF OBJECT_ID('tempdb..#TEMP_IDX') IS NOT NULL DROP TABLE #Results ;
		create table #TEMP_IDX (Database_Name nvarchar(250), Table_Name nvarchar(250), Index_Name nvarchar(250));

		insert into #TEMP_IDX
		SELECT DB_NAME() AS Database_Name
		, o.name AS Table_Name
		, i.name AS Index_Name
		FROM sys.indexes i
		INNER JOIN sys.objects o ON i.object_id = o.object_id
		WHERE i.name IS NOT NULL
		AND o.type = 'U'
		ORDER BY o.name, i.type ;
			
		DECLARE CurIdx CURSOR
        FOR SELECT Database_Name
				, Table_Name
				, Index_Name
				FROM #TEMP_IDX
						
		OPEN CurIdx;
        FETCH NEXT FROM CurIdx INTO @dbname, @table_name, @index_name ;
        PRINT CHAR(10) + 'GO';
        PRINT 'use [' + DB_NAME() + '];';
        PRINT 'GO';
        PRINT '/************  CHECK INDEXES II ************/';
        WHILE @@FETCH_STATUS = 0
            BEGIN
                SET @stmt = 'IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE object_id = OBJECT_ID(''' + @table_name + ''') AND name=''' + @index_name + ''')';
                PRINT @stmt;
                SET @stmt = '    print (''ERROR: INDEX missing [' + DB_NAME() + '] : ' + @table_name + ' @ ' + @index_name + ''');';
                PRINT @stmt;
                FETCH NEXT FROM CurIdx INTO @dbname, @table_name, @index_name ;
            END;
        CLOSE CurIdx;
        DEALLOCATE CurIdx;
		SET NOCOUNT OFF;  
    END;
GO 

