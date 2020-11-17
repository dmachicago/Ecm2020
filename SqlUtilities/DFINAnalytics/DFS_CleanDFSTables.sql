
/** USEDFINAnalytics;*/

GO

IF NOT EXISTS ( SELECT 1
  FROM information_schema.tables
  WHERE table_name = 'DFS_CleanedDFSTables'
   AND 
   TABLE_TYPE = 'BASE TABLE'
  ) 
    BEGIN
 CREATE TABLE DFS_CleanedDFSTables ( 
  SvrName    NVARCHAR(150) NOT NULL , 
  DBName     NVARCHAR(150) NOT NULL , 
  TBLName    NVARCHAR(150) NOT NULL , 
  RowCNT     INT NULL , 
  DropRowCNT INT NULL , 
  CreateDate DATETIME DEFAULT GETDATE() , 
  [UID] UNIQUEIDENTIFIER DEFAULT NEWID()
  );
 CREATE INDEX pi_DFS_CleanedDFSTables ON DFS_CleanedDFSTables ( TBLName
   );
END;
GO

IF EXISTS ( SELECT 1
     FROM sys.procedures
     WHERE name = 'UTIL_CleanUpOneTable'
   ) 
    BEGIN
 DROP PROCEDURE UTIL_CleanUpOneTable;
END;
GO
/*
	exec UTIL_CleanUpOneTable 'DFS_QryOptStatsHistory', 'ExecutionDate', 21 ;
*/
CREATE PROCEDURE UTIL_CleanUpOneTable ( 
   @tbl   NVARCHAR(150) , 
   @DateColumn   NVARCHAR(50) , 
   @DaysToDelete INT
     ) 
AS
    BEGIN
		 exec UTIL_DFS_DBVersion;
		 
		 DECLARE @Acnt INT;
		 DECLARE @Bcnt INT;
		 DECLARE @retval INT;
		 DECLARE @sSQL NVARCHAR(500);
		 DECLARE @ParmDefinition NVARCHAR(500);
		 DECLARE @i INT;
		 DECLARE @tablename NVARCHAR(50);
		 
		 SELECT @tablename = @tbl;
		 SELECT @sSQL = N'SELECT @retvalOUT = count(*) FROM ' + @tablename;
		 SET @ParmDefinition = N'@retvalOUT int OUTPUT';
		 EXEC sp_executesql @sSQL , @ParmDefinition , @retvalOUT = @retval OUTPUT;
		 SET @Acnt = ( SELECT @retval );
		 PRINT @tbl + ' @Bcnt = ' + CAST(@Bcnt AS NVARCHAR(50));
		 SELECT @sSQL = 'delete from dbo.' + @tbl + ' where ' + @DateColumn + ' <= getdate() - ' + CAST(@DaysToDelete AS NVARCHAR(10));
		 PRINT @sSQL;
		 SELECT @sSQL = N'SELECT @retvalOUT = count(*) FROM ' + @tablename;
		 SET @ParmDefinition = N'@retvalOUT int OUTPUT';
		 EXEC sp_executesql @sSQL , @ParmDefinition , @retvalOUT = @retval OUTPUT;
		 SET @Bcnt = ( SELECT @retval );
		 PRINT @tbl + ' @Bcnt = ' + CAST(@Bcnt AS NVARCHAR(50));
		 INSERT INTO [dbo].[DFS_CleanedDFSTables] ( [SvrName] , [DBName] , [TBLName] , [RowCNT] , [DropRowCNT] , [CreateDate] , [UID]
		  ) 
		 VALUES ( @@servername , DB_NAME() , @tbl , @Acnt , @Bcnt , GETDATE() , NEWID()
		   );
    END;
GO

IF EXISTS ( SELECT 1
     FROM sys.procedures
     WHERE name = 'UTIL_CleanDFSTables'
   ) 
    BEGIN
 DROP PROCEDURE UTIL_CleanDFSTables;
END;
GO

/* exec UTIL_CleanDFSTables @DaysToDelete = 1 */

CREATE PROCEDURE UTIL_CleanDFSTables ( 
   @DaysToDelete INT = 3
    ) 
AS
    BEGIN
		exec UTIL_DFS_DBVersion;
 IF EXISTS ( SELECT 1
 FROM sys.tables
 WHERE name = ' DFS_SequenceTABLE'
    ) 
     BEGIN
  EXEC UTIL_CleanUpOneTable 'DFS_SequenceTABLE' , 'CreateDate' , @DaysToDelete;
 END;
 IF EXISTS ( SELECT 1
 FROM sys.tables
 WHERE name = ' DFS_MissingIndexes'
    ) 
     BEGIN
  EXEC UTIL_CleanUpOneTable 'DFS_MissingIndexes' , 'CreateDate' , @DaysToDelete;
 END;
 IF EXISTS ( SELECT 1
 FROM sys.tables
 WHERE name = ' DFS_MissingFKIndexes'
    ) 
     BEGIN
  EXEC UTIL_CleanUpOneTable 'DFS_MissingFKIndexes' , 'CreateDate' , @DaysToDelete;
 END;
 IF EXISTS ( SELECT 1
 FROM sys.tables
 WHERE name = ' DFS_MissingFKIndexes'
    ) 
     BEGIN
  EXEC UTIL_CleanUpOneTable 'DFS_MissingFKIndexes' , 'CreateDate' , @DaysToDelete;
 END;
 IF EXISTS ( SELECT 1
 FROM sys.tables
 WHERE name = ' DFS_TableReadWrites'
    ) 
     BEGIN
  EXEC UTIL_CleanUpOneTable 'DFS_TableReadWrites' , 'RunDate' , @DaysToDelete;
 END;
 IF EXISTS ( SELECT 1
 FROM sys.tables
 WHERE name = ' DFS_IndexStats'
    ) 
     BEGIN
  EXEC UTIL_CleanUpOneTable 'DFS_IndexStats' , 'CreateDate' , @DaysToDelete;
 END;
 IF EXISTS ( SELECT 1
 FROM sys.tables
 WHERE name = ' DFS_BlockingHistory'
    ) 
     BEGIN
  EXEC UTIL_CleanUpOneTable 'DFS_BlockingHistory' , 'CreateDate' , @DaysToDelete;
 END;
 IF EXISTS ( SELECT 1
 FROM sys.tables
 WHERE name = ' DFS_SEQ'
    ) 
     BEGIN
  EXEC UTIL_CleanUpOneTable 'DFS_SEQ' , 'GenDate' , @DaysToDelete;
 END;
 IF EXISTS ( SELECT 1
 FROM sys.tables
 WHERE name = ' DFS_CPU_BoundQry2000'
    ) 
     BEGIN
  EXEC UTIL_CleanUpOneTable 'DFS_CPU_BoundQry2000' , 'RunDate' , @DaysToDelete;
 END;
 IF EXISTS ( SELECT 1
 FROM sys.tables
 WHERE name = ' DFS_IO_BoundQry2000'
    ) 
     BEGIN
  EXEC UTIL_CleanUpOneTable 'DFS_IO_BoundQry2000' , 'RunDate' , @DaysToDelete;
 END;
 IF EXISTS ( SELECT 1
 FROM sys.tables
 WHERE name = ' DFS_TranLocks'
    ) 
     BEGIN
  EXEC UTIL_CleanUpOneTable 'DFS_TranLocks' , 'CreateDate' , @DaysToDelete;
 END;
 IF EXISTS ( SELECT 1
 FROM sys.tables
 WHERE name = ' DFS_QryOptStats'
    ) 
     BEGIN
  EXEC UTIL_CleanUpOneTable 'DFS_QryOptStats' , 'RunDate' , @DaysToDelete;
 END;
 IF EXISTS ( SELECT 1
 FROM sys.tables
 WHERE name = ' DFS_Workload'
    ) 
     BEGIN
  EXEC UTIL_CleanUpOneTable 'DFS_Workload' , 'RunDate' , @DaysToDelete;
 END;
 IF EXISTS ( SELECT 1
 FROM sys.tables
 WHERE name = ' DFS_PerfMonitor'
    ) 
     BEGIN
  EXEC UTIL_CleanUpOneTable 'DFS_PerfMonitor' , 'CreateDate' , @DaysToDelete;
 END;
 IF EXISTS ( SELECT 1
 FROM sys.tables
 WHERE name = ' DFS_TxMonitorTableStats'
    ) 
     BEGIN
  EXEC UTIL_CleanUpOneTable 'DFS_TxMonitorTableStats' , 'CreateDate' , @DaysToDelete;
 END;
 IF EXISTS ( SELECT 1
 FROM sys.tables
 WHERE name = ' DFS_TxMonitorTblUpdates'
    ) 
     BEGIN
  EXEC UTIL_CleanUpOneTable 'DFS_TxMonitorTblUpdates' , 'CreateDate' , @DaysToDelete;
 END;
 IF EXISTS ( SELECT 1
 FROM sys.tables
 WHERE name = ' DFS_DbFileSizing'
    ) 
     BEGIN
  EXEC UTIL_CleanUpOneTable 'DFS_DbFileSizing' , 'CreateDate' , @DaysToDelete;
 END;
 IF EXISTS ( SELECT 1
 FROM sys.tables
 WHERE name = ' DFS_TxMonitorIDX'
    ) 
     BEGIN
  EXEC UTIL_CleanUpOneTable 'DFS_TxMonitorIDX' , 'CreateDate' , @DaysToDelete;
 END;
 IF EXISTS ( SELECT 1
 FROM sys.tables
 WHERE name = ' DFS_DeadlockStats'
    ) 
     BEGIN
  EXEC UTIL_CleanUpOneTable 'DFS_DeadlockStats' , 'RunDate' , @DaysToDelete;
 END;
 IF EXISTS ( SELECT 1
 FROM sys.tables
 WHERE name = ' DFS_IndexFragReorgHistory'
    ) 
     BEGIN
  EXEC UTIL_CleanUpOneTable 'DFS_IndexFragReorgHistory' , 'RunDate' , @DaysToDelete;
 END;
 IF EXISTS ( SELECT 1
 FROM sys.tables
 WHERE name = ' DFS_TableGrowthHistory'
    ) 
     BEGIN
  EXEC UTIL_CleanUpOneTable 'DFS_TableGrowthHistory' , 'CreateDate' , @DaysToDelete;
 END;
 IF EXISTS ( SELECT 1
 FROM sys.tables
 WHERE name = ' DFS_IO_BoundQry'
    ) 
     BEGIN
  EXEC UTIL_CleanUpOneTable 'DFS_IO_BoundQry' , 'RunDate' , @DaysToDelete;
 END;
 IF EXISTS ( SELECT 1
 FROM sys.tables
 WHERE name = ' DFS_CPU_BoundQry'
    ) 
     BEGIN
  EXEC UTIL_CleanUpOneTable 'DFS_CPU_BoundQry' , 'RunDate' , @DaysToDelete;
 END;
    END;