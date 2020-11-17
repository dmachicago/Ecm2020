
GO
PRINT 'Creating CT_Performance_History';
PRINT 'FROM CT_Performance_History.sql';
GO

IF NOT EXISTS (SELECT
                  name
                      FROM sys.tables
                      WHERE name = 'CT_Performance_History') 
    BEGIN
        PRINT 'CT_Performance_History missing - created now.';
        CREATE TABLE dbo.CT_Performance_History (
           RowGuid uniqueidentifier NOT NULL
         ,RowNbr int IDENTITY (1, 1) 
                     NOT NULL
         ,CALLING_PROC nvarchar (100) NOT NULL
         ,PROC_LOCATION nvarchar (100) NOT NULL
         ,starttime datetime2 (7) NOT NULL
         ,endtime datetime2 (7) NULL
         ,elapsedsecs decimal (18, 2) NULL
         ,elapsedmin decimal (18, 2) NULL
         ,elapsedhr decimal (18, 2) NULL
         ,RowsProcessed bigint NULL
         ,CreateDate datetime NULL
         ,LastModifiedDate datetime NULL
         ,CONSTRAINT PK_CT_Performance_History PRIMARY KEY CLUSTERED
           (
           RowGuid ASC,
           RowNbr ASC
           ) 
              WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
        ) 
        ON [PRIMARY];

        ALTER TABLE dbo.CT_Performance_History
        ADD
           CONSTRAINT DF_CT_Performance_History_CreateDate  DEFAULT GETDATE () FOR CreateDate;

	   PRINT 'Created CT_Performance_History';
    END;
else 
    PRINT 'CT_Performance_History already exists, skipping create.';
GO

PRINT 'FROM CT_Performance_History.sql';
GO
