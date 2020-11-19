--D. Miller
--SELECT DISTINCT 
--       OBJECT_NAME(fic.[object_id]) table_name, 
--       [name] column_name
--FROM sys.fulltext_index_columns fic
--     INNER JOIN sys.columns c ON c.[object_id] = fic.[object_id]
--                                 AND c.[column_id] = fic.[column_id]
--where OBJECT_NAME(fic.[object_id])  = 'DataSource' and [name] = 'FQN';


--USE [ECM.Library.FS];
--SELECT *
--FROM sys.fulltext_indexes;
--IF NOT OBJECTPROPERTY(OBJECT_ID('DataSource'), 'TableHasActiveFulltextIndex') = 1
--    PRINT 'ERROR: DataSource missing fulltest indexes';
--IF NOT OBJECTPROPERTY(OBJECT_ID('Email'), 'TableHasActiveFulltextIndex') = 1
--    PRINT 'ERROR: Email missing fulltest indexes';

USE [ECM.Library.FS];
GO
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'sp_IVP_FTI'
)
    DROP PROCEDURE sp_IVP_FTI;
GO
-- exec sp_IVP_FTI
CREATE PROCEDURE sp_IVP_FTI
AS
    BEGIN
        DECLARE @gendb VARCHAR(1)= 'Y';
        DECLARE @column_name VARCHAR(250); -- database name 
        DECLARE @table_name VARCHAR(256); -- filename for backup 
        DECLARE @fileDate VARCHAR(20); -- used for file name 
        DECLARE @stmt NVARCHAR(MAX); -- used for file name 

        IF(@gendb = 'Y')
            BEGIN

			PRINT ' ';
			PRINT 'GO';
				print 'USE [ECM.Library.FS];'
				PRINT 'GO';

                DECLARE CUR1 CURSOR
                FOR SELECT DISTINCT 
                           OBJECT_NAME(fic.[object_id]) table_name, 
                           [name] column_name
                    FROM sys.fulltext_index_columns fic
                         INNER JOIN sys.columns c ON c.[object_id] = fic.[object_id]
                                                     AND c.[column_id] = fic.[column_id];
                OPEN CUR1;
                FETCH NEXT FROM CUR1 INTO @table_name, @column_name;
                PRINT '/***********************************************************/';
                PRINT '-- FULLTEXT Index validation;';
                PRINT '/***********************************************************/';
                WHILE @@FETCH_STATUS = 0
                    BEGIN
                        SET @stmt = 'IF NOT EXISTS (SELECT DISTINCT 
											   OBJECT_NAME(fic.[object_id]) table_name, 
											   [name] column_name
										FROM sys.fulltext_index_columns fic
											 INNER JOIN sys.columns c ON c.[object_id] = fic.[object_id]
																		 AND c.[column_id] = fic.[column_id]
										where OBJECT_NAME(fic.[object_id])  = '''+@table_name+''' and [name] = '''+@column_name+ ''')';

                        SET @stmt = @stmt + CHAR(10) + '    print (''ERROR: FTI missing: ' + @table_name + ' @ ' + @column_name + ''');';
                        PRINT @stmt;
                        FETCH NEXT FROM CUR1 INTO @table_name, @column_name;
        END;
                CLOSE CUR1;
                DEALLOCATE CUR1;
        END;
    END;
GO