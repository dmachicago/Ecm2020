-- W. Dale Miller
-- wdalemiller@gmail.com

USE DFINAnalytics;
GO
--drop TABLE [DFINAnalytics].[dbo].DFS_IndexFragReorgHistory

IF NOT EXISTS
(
    SELECT 1
    FROM   information_schema.tables
    WHERE  table_name = 'DFS_IndexFragReorgHistory'
)
    BEGIN
        CREATE TABLE [DFINAnalytics].[dbo].DFS_IndexFragReorgHistory
        ([DBName]      [NVARCHAR](128) NULL, 
         [Schema]      NVARCHAR(254)  NOT NULL, 
         [Table]       NVARCHAR(254)  NOT NULL, 
         [Index]       NVARCHAR(254)  NULL, 
         [OnlineReorg] [VARCHAR](10) NULL, 
         [Success]     [VARCHAR](10) NULL, 
         Rundate       DATETIME NULL, 
         RunID         NVARCHAR(60) NULL, 
         Stmt          VARCHAR(MAX) NULL, 
         RowNbr        INT IDENTITY(1, 1) NOT NULL
        )
        ON [PRIMARY];
        ALTER TABLE [DFINAnalytics].[dbo].DFS_IndexFragReorgHistory
        ADD DEFAULT(GETDATE()) FOR [RunDate];

END;

/****** Object:  StoredProcedure [dbo].[sp_UTIL_ReorgFragmentedIndexes]    Script Date: 1/10/2019 4:27:24 PM ******/
GO
-- select * FROM master.dbo.DFS_IndexFragHist 
-- exec sp_UTIL_ReorgFragmentedIndexes 'B5E6A690-F150-44E2-BF57-AB4765A94357', 0
USE master;
go
IF EXISTS
(
    SELECT 1
    FROM   sys.procedures
    WHERE  name = 'sp_UTIL_ReorgFragmentedIndexes'
)
    BEGIN
        DROP PROCEDURE sp_UTIL_ReorgFragmentedIndexes;
END;
GO

-- EXEC sp_UTIL_ReorgFragmentedIndexes 0;

CREATE PROCEDURE [dbo].[sp_UTIL_ReorgFragmentedIndexes](@PreviewOnly INT = 1)
AS
    BEGIN

        --*******************CLEAN UP THE INDEXES TO BE PROCESSED *****************
        DELETE FROM [DFINAnalytics].[dbo].[DFS_IndexFragHist]
        WHERE       [Index] IS NULL;
        DELETE FROM [DFINAnalytics].[dbo].[DFS_IndexFragHist]
        WHERE       EXISTS
        (
            SELECT *
            FROM   [DFINAnalytics].[dbo].[DFS_IndexFragHist] AS b
            WHERE  b.[DBName] = [DFINAnalytics].[dbo].[DFS_IndexFragHist].[DBName]
                   AND b.[Schema] = [DFINAnalytics].[dbo].[DFS_IndexFragHist].[Schema]
                   AND b.[Table] = [DFINAnalytics].[dbo].[DFS_IndexFragHist].[Table]
                   AND b.[Index] = [DFINAnalytics].[dbo].[DFS_IndexFragHist].[Index]
                   AND b.IndexProcessed = [DFINAnalytics].[dbo].[DFS_IndexFragHist].[IndexProcessed]
            GROUP BY b.[DBName], 
                     b.[Schema], 
                     b.[Table], 
                     b.[Index], 
                     b.IndexProcessed
            HAVING [DFINAnalytics].[dbo].[DFS_IndexFragHist].[RowNbr] > MIN(b.[RowNbr])
        );
        --******************************************************************************
		
        DECLARE @msg NVARCHAR(2000);
        DECLARE @RunID VARCHAR(60);
        DECLARE @stmt NVARCHAR(2000);
        DECLARE @Rownbr INT;
		DECLARE @TotCnt INT;
		DECLARE @i INT = 0 ;
        DECLARE @dbname NVARCHAR(100);
        DECLARE @Schema NVARCHAR(100), @Table NVARCHAR(100), @Index NVARCHAR(100);

		set @TotCnt = (select count(*) from [DFINAnalytics].[dbo].[DFS_IndexFragHist] where IndexProcessed = 0);

        DECLARE CursorReorg CURSOR
        FOR SELECT DBName, 
                   [Schema], 
                   [Table], 
                   [Index], 
                   Rownbr, 
                   RunID
            FROM   master.dbo.DFS_IndexFragHist
            WHERE  IndexProcessed != 1
                   AND [index] IS NOT NULL;
        OPEN CursorReorg;
        FETCH NEXT FROM CursorReorg INTO @DBName, @Schema, @Table, @Index, @Rownbr, @RunID;
        WHILE @@FETCH_STATUS = 0
            BEGIN
				set @i = @i + 1;
				set @msg = '#' + cast(@i as nvarchar(10)) + ' of ' + cast(@TotCnt as nvarchar(10)) ;
                SET @msg = 'REORGANIZE: ' + @DBName + '.' + @Schema + '.' + @Table + ' / ' + @Index;
                exec  DFINAnalytics.dbo.PrintImmediate 
                     @msg;
                SET @stmt = 'ALTER Index ' + @Index + ' ON ' + @DBName + '.' + @Schema + '.' + @Table;
				--SET @stmt = @stmt + ' REORGANIZE ';
                SET @stmt = @stmt + ' REBUILD WITH ';
                SET @stmt = @stmt + '(';
                SET @stmt = @stmt + '  FILLFACTOR = 80 ';
                SET @stmt = @stmt + '  ,ONLINE = ON ';
				SET @stmt = @stmt + ');';
                IF @PreviewOnly = 1
                    BEGIN
                        PRINT('Preview: ' + @stmt);
                END;
                IF @PreviewOnly = 0
                    BEGIN
						BEGIN TRY
							set @msg = 'Starting the REBUILD: ON ' + @DBName + '.' + @Schema + '.' + @Table;
							exec PrintImmediate @msg ;
                            EXECUTE sp_executesql @stmt;
							begin try
                            INSERT INTO [dbo].[DFS_IndexFragReorgHistory]
                            ([DBName], 
                             [Schema], 
                             [Table], 
                             [Index], 
                             [OnlineReorg], 
                             [Success], 
                             [Rundate], 
                             [RunID],
							 [Stmt]                             
                            )
                            VALUES
                            (@DBName, 
                             @Schema, 
                             @Table, 
                             @Index, 
                             'YES', 
                             'YES', 
                             GETDATE(), 
                             @RunID, 
                             @stmt
                            );
							end try
							begin catch 
								set @msg = 'FAILED TO SAVE HISTORY:' ;
								set @msg = @msg + '|' + @DBName ;
								set @msg = @msg +  '.' + @Schema ;
								set @msg = @msg +  '.' + @Table ;
								set @msg = @msg +  '.' + @Index ;
								set @msg = @msg +  ' @' + @stmt ;
								set @msg =  @msg + '@'  ;
								exec PrintImmediate @msg;
								SET @msg = 'ERR MSG @0: ' + (select ERROR_MESSAGE());
								exec  DFINAnalytics.dbo.PrintImmediate 
									@msg;
                            
							end catch
                      END TRY
                      BEGIN CATCH
                            SET @msg = '-- **************************************';
                            exec  DFINAnalytics.dbo.PrintImmediate 
                                 @msg;
							SET @msg = 'ERR MSG @1: ' + (select ERROR_MESSAGE());
                            exec  DFINAnalytics.dbo.PrintImmediate 
                                 @msg;
                            SET @msg = 'CURRENT DB: ' + @dbname;
                            exec  DFINAnalytics.dbo.PrintImmediate 
                                 @msg;
                            SET @msg = 'ERROR: ' + @stmt;
                            exec  DFINAnalytics.dbo.PrintImmediate 
                                 @msg;
                            BEGIN TRY
                                SET @stmt = 'ALTER Index ' + @Index + ' ON ' + @DBName + '.' + @Schema + '.' + @Table;
                                SET @stmt = @stmt + ' reorganize;';
								--SET @stmt = 'ALTER Index ' + @Index + ' ON ' + @DBName + '.' + @Schema + '.' + @Table;
								--SET @stmt = @stmt + ' reorganize;';
                                EXECUTE sp_executesql 
                                        @stmt;
                                PRINT '-- **************************************';
                                SET @msg = 'Reorganize : ' + @stmt;
                                exec  DFINAnalytics.dbo.PrintImmediate 
                                     @msg;
                                PRINT '-- **************************************';
                                INSERT INTO [dbo].[DFS_IndexFragReorgHistory]
                                ([DBName], 
                                 [Schema], 
                                 [Table], 
                                 [Index], 
                                 [OnlineReorg], 
                                 [Success], 
                                 [Rundate], 
                                 [RunID], 
                                 [Stmt]
                                )
                                VALUES
                                (@DBName, 
                                 @Schema, 
                                 @Table, 
                                 @Index, 
                                 'NO @1', 
                                 'YES', 
                                 GETDATE(), 
                                 @RunID, 
                                 @stmt
                                );
                            END TRY
                            BEGIN CATCH
								SET @msg = 'ERR MSG: ' + (select ERROR_MESSAGE());
								exec  DFINAnalytics.dbo.PrintImmediate 
									@msg;
                                INSERT INTO [DFINAnalytics].[dbo].[DFS_IndexFragErrors]
                                ([SqlCmd], 
                                 DBNAME
                                )
                                VALUES
                                (@stmt, 
                                 @DBName
                                );
                                INSERT INTO [dbo].[DFS_IndexFragReorgHistory]
                                ([DBName], 
                                 [Schema], 
                                 [Table], 
                                 [Index], 
                                 [OnlineReorg], 
                                 [Success], 
                                 [Rundate], 
                                 [RunID], 
                                 [Stmt]
                                )
                                VALUES
                                (@DBName, 
                                 @Schema, 
                                 @Table, 
                                 @Index, 
                                 'NO @2', 
                                 'NO', 
                                 GETDATE(), 
                                 @RunID, 
                                 @stmt
                                );
                END CATCH;
                END CATCH;
                END;
                IF @PreviewOnly = 0
                    BEGIN
                        UPDATE  [DFINAnalytics].[dbo].[DFS_IndexFragHist]
                            SET 
                                IndexProcessed = 1
                        WHERE   RowNbr = @Rownbr;
                END;
                FETCH NEXT FROM CursorReorg INTO @DBName, @Schema, @Table, @Index, @Rownbr, @RunID;
            END;
        CLOSE CursorReorg;
        DEALLOCATE CursorReorg;
    END;