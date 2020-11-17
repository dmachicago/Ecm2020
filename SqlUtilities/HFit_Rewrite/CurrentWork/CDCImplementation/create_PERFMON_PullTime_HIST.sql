GO
PRINT 'Executing create_DFS_PERFMON_PullTime_HIST.sql ';
GO
IF EXISTS
(
    SELECT name
    FROM sys.tables
    WHERE name = 'DFS_PERFMON_PullTime_HIST'
)
    BEGIN
        DROP TABLE DFS_PERFMON_PullTime_HIST;
END;

-- select * from DFS_PERFMON_PullTime_HIST order by ExecutionStartTime desc
-- truncate table DFS_PERFMON_PullTime_HIST    
GO
CREATE TABLE dbo.DFS_PERFMON_PullTime_HIST
(RowGuid             UNIQUEIDENTIFIER NOT NULL, 
 DBMS                NVARCHAR(100) NOT NULL, 
 TblName             NVARCHAR(100) NOT NULL, 
 ProcName            NVARCHAR(100) NOT NULL, 
 ExecutionStartTime  DATETIME NOT NULL, 
 ExecutionEndDate    DATETIME NULL, 
 ExecutionSuccessful BIT NULL, 
 InsertStartTime     DATETIME NULL, 
 InsertEndTime       DATETIME NULL, 
 InsertCount         INT NULL, 
 DeleteStartTime     DATETIME NULL, 
 DeleteEndTime       DATETIME NULL, 
 DeleteCount         INT NULL, 
 UpdateStartTime     DATETIME NULL, 
 UpdateEndTime       DATETIME NULL, 
 UpdateCount         INT NULL, 
 InsertSuccessful    BIT NULL, 
 DeleteSuccessFull   BIT NULL, 
 UpdateSuccessFull   BIT NULL, 
 TotalTimeMinutes    DECIMAL(12, 3) NULL, 
 CONSTRAINT PK_DFS_PERFMON_PullTime_HIST PRIMARY KEY CLUSTERED(RowGuid ASC, DBMS ASC, TblName ASC)
 WITH(PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY];
GO
ALTER TABLE dbo.DFS_PERFMON_PullTime_HIST
ADD CONSTRAINT DF_Table_1_ExecutionDate DEFAULT GETDATE() FOR ExecutionStartTime;
GO
ALTER TABLE dbo.DFS_PERFMON_PullTime_HIST
ADD CONSTRAINT DF_DFS_PERFMON_PullTime_HIST_ExecutionSuccessful DEFAULT 0 FOR ExecutionSuccessful;
GO
PRINT 'Executed create_DFS_PERFMON_PullTime_HIST.sql ';
GO