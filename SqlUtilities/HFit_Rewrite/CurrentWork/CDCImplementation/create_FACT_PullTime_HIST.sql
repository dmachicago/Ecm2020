

GO
PRINT 'Executing create_FACT_PullTime_HIST.sql ';
GO
IF EXISTS (SELECT
                  name
                  FROM sys.tables
                  WHERE name = 'FACT_PullTime_HIST') 
    BEGIN
        DROP TABLE
             FACT_PullTime_HIST
    END;

GO
CREATE TABLE dbo.FACT_PullTime_HIST (
             RowGuid uniqueidentifier NOT NULL
           ,DBMS nvarchar (100) NOT NULL
           ,TblName nvarchar (100) NOT NULL
		 ,ProcName nvarchar (100) NOT NULL
           ,ExecutionStartTime datetime NOT NULL
           ,ExecutionEndDate datetime NULL
           ,ExecutionSuccessful bit NULL
           ,InsertStartTime datetime NULL
           ,InsertEndTime datetime NULL
           ,InsertCount int NULL
           ,DeleteStartTime datetime NULL
           ,DeleteEndTime datetime NULL
           ,DeleteCount int NULL
           ,UpdateStartTime datetime NULL
           ,UpdateEndTime datetime NULL
           ,UpdateCount int NULL
           ,InsertSuccessful bit NULL
           ,DeleteSuccessFull bit NULL
           ,UpdateSuccessFull bit NULL
           ,TotalTimeMinutes decimal (10, 2) NULL
           ,CONSTRAINT PK_FACT_PullTime_HIST PRIMARY KEY CLUSTERED
             (
             RowGuid ASC,
             DBMS ASC,
             TblName ASC
             ) 
                WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) 
ON [PRIMARY];

GO

ALTER TABLE dbo.FACT_PullTime_HIST
ADD
            CONSTRAINT DF_Table_1_ExecutionDate  DEFAULT GETDATE () FOR ExecutionStartTime;
GO

ALTER TABLE dbo.FACT_PullTime_HIST
ADD
            CONSTRAINT DF_FACT_PullTime_HIST_ExecutionSuccessful  DEFAULT 0 FOR ExecutionSuccessful;
GO
PRINT 'Executed create_FACT_PullTime_HIST.sql ';
GO

