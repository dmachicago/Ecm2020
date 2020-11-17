
/** USEDFINAnalytics*/

GO
DECLARE @CutoffPct AS DECIMAL(10, 0)= 29.5;
SET NOCOUNT ON;
IF EXISTS
(
    SELECT 1
    FROM master.information_schema.tables
    WHERE table_name = 'DFS_IndexReorgCmds'
)
    TRUNCATE TABLE dbo.DFS_IndexReorgCmds;
    ELSE
    CREATE TABLE dbo.DFS_IndexReorgCmds
    (CMD     NVARCHAR(MAX) NULL, 
     RowNbr  INT IDENTITY(1, 1) NOT NULL, 
     PctFrag DECIMAL(10, 2) NULL
    );
IF OBJECT_ID('tempdb..#AllIndexes') IS NOT NULL
    DROP TABLE #AllIndexes;
CREATE TABLE #AllIndexes
(DBName        NVARCHAR(150) NULL, 
 [schema]      NVARCHAR(150) NULL, 
 [TableName]   NVARCHAR(150) NULL, 
 [IDX]         NVARCHAR(150) NULL, 
 [is_disabled] INT
);

/*select top 100 * from sys.indexes*/

CREATE INDEX idxAllIndexes
ON #AllIndexes
(DBName
);
CREATE INDEX idxAllIndexesDisabled
ON #AllIndexes
(is_disabled
);
EXEC sp_MSForEachdb 
     'insert into #AllIndexes SELECT ''?'' as DBName, SCH.name as [Schema], T.name AS TableName , S.name as IDX , S.is_disabled
from ?.sys.tables T 
join ?.sys.indexes S on T.object_id = S.object_id
join ?.sys.schemas SCH on T.schema_id = SCH.schema_id
WHERE  T.type=''U''';
DECLARE @DCnt AS INT= 0;
SET @DCnt =
(
    SELECT COUNT(*)
    FROM #AllIndexes
    WHERE [is_disabled] = 1
);
PRINT 'DISABLED COUNT: ' + CAST(@DCnt AS NVARCHAR(10));
DELETE FROM #AllIndexes
WHERE DBName IN('master', 'model', 'msdb', 'DBA', 'tempdb')
OR [is_disabled] = 1;
DECLARE @DBName NVARCHAR(125);
DECLARE @Schema NVARCHAR(125);
DECLARE @TableName NVARCHAR(125);
DECLARE @IdxName NVARCHAR(125);
DECLARE @msg NVARCHAR(2000);
DECLARE @I INT= 0;
DECLARE @Totrecs INT= 0;
DECLARE @NewCmd NVARCHAR(2000);
DECLARE @DBID INT= 0;
DECLARE @TblID INT= 0;
DECLARE @IdxID DECIMAL(10, 2)= 0;
DECLARE @SchemaID INT= 0;
DECLARE @FQN NVARCHAR(150);
DECLARE @stmt NVARCHAR(2000);
DECLARE @PctFrag DECIMAL(10, 2)= 0;
SET @Totrecs =
(
    SELECT COUNT(*)
    FROM #AllIndexes
);

/* SELECT top 10 * FROM #AllIndexes*/

DECLARE xcur CURSOR
FOR SELECT [DBName], 
           [schema], 
           TableName, 
           IDX
    FROM #AllIndexes;
OPEN xcur;
FETCH NEXT FROM xcur INTO @DBName, @Schema, @TableName, @IdxName;
WHILE @@fetch_status = 0
    BEGIN
        SET @FQN = @DBName + '.' + @Schema + '.' + @TableName;
        SET @DBID = DB_ID(@DBName);
        SET @TblID =
        (
            SELECT OBJECT_ID(@FQN)
        );
        SET @stmt = N'select @InternalVar = (select I.index_id as IDXID from ' + @DBName + '.sys.tables T
		join ' + @DBName + '.sys.indexes I on I.object_id = T.object_id
		where T.name = ''' + @Tablename + ''' 
		and I.name = ''' + @Idxname + '''); ';
        SET @IdxID = 0;
        EXEC sp_executesql 
             @stmt, 
             N'@InternalVar decimal(10,2) out', 
             @InternalVar = @IdxID OUT;
        SET @PctFrag = CAST(
        (
            SELECT MAX(avg_fragmentation_in_percent)
            FROM sys.dm_db_index_physical_stats(@DBID, @TblID, @IdxID, NULL, 'DETAILED')
        ) AS DECIMAL(10, 2));

        /*Select * from sys.dm_db_index_physical_stats ( 13,1731575490,3, NULL, 'DETAILED');*/

        SET @I = @I + 1;
        IF @PctFrag > @CutoffPct
            BEGIN
                SET @NewCmd = 'ALTER Index ' + @IdxName + ' ON ' + @DBName + '.' + @Schema + '.' + @TableName;
                SET @NewCmd = @NewCmd + ' REORGANIZE ';
                INSERT INTO dbo.DFS_IndexReorgCmds
                ( cmd, 
                  PctFrag
                ) 
                VALUES
                (
                       @NewCmd
                     , @PctFrag
                );
                SET @msg = '@ ' + CAST(@I AS NVARCHAR(20)) + ' of ' + CAST(@Totrecs AS NVARCHAR(20));
                EXEC sp_printimmediate 
                     @msg;

/*SET @msg = '@FQN ' + @FQN + ' - @DBID:' + CAST(@DBID AS NVARCHAR(20))
  		+ ' - @TblID:' + CAST(@TblID AS NVARCHAR(20));
  EXEC sp_printimmediate @msg; 
  print '@IdxID= ' + cast(@IdxID as nvarchar(10));
  print '@PctFrag = ' + cast(@PctFrag as nvarchar(10));*/

        END;
        FETCH NEXT FROM xcur INTO @DBName, @Schema, @TableName, @IdxName;
    END;

/*DROP TABLE #AllIndexes;*/

CLOSE xcur;
DEALLOCATE xcur;
SELECT *
FROM dbo.DFS_IndexReorgCmds;
SET NOCOUNT OFF;