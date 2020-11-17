
GO
PRINT 'FROM CreateTable_CT_VersionTracking.Sql';
PRINT 'Creating table CT_VersionTracking';
IF EXISTS (SELECT
                  name
                  FROM sys.tables
                  WHERE
                  name = 'CT_VersionTracking') 
    BEGIN
        DROP TABLE
             CT_VersionTracking;
    END;
GO
IF NOT EXISTS (SELECT
                      name
                      FROM sys.tables
                      WHERE
                      name = 'CT_VersionTracking') 
    BEGIN
        CREATE TABLE dbo.CT_VersionTracking (
                     SVRName nvarchar (100) NOT NULL
                   , DBName nvarchar (100) NOT NULL
                   , TgtView nvarchar ( 100) NOT NULL
                   , ExtractionDate datetime2 (7) NOT NULL
                   , ExtractedVersion int NOT NULL
                   , CurrentDbVersion int NULL
                   , ExtractedRowCnt int NOT NULL
                   , StartTime datetime2 ( 7) NOT NULL
                   , EndTime datetime2 ( 7) NULL
                   , CNT_Insert int NULL
                   , CNT_Update int NULL
                   , CNT_Delete int NULL
                   , CNT_StagingTable bigint NULL
                   , CNT_PulledRecords bigint NULL
                   , RowNbr int IDENTITY (1, 1) NOT NULL
                   , CONSTRAINT PK_CT_VersionTracking PRIMARY KEY CLUSTERED
                     (
                     SVRName, DBName, ExtractedVersion , TgtView, ExtractionDate ASC
                     ) 
                         WITH ( PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , IGNORE_DUP_KEY = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON)
ON [PRIMARY]
        ) 
        ON [PRIMARY];

        ALTER TABLE dbo.CT_VersionTracking
        ADD
                    CONSTRAINT DF_CT_VersionTracking_StartTime  DEFAULT GETDATE () FOR StartTime;
    END;

GO
PRINT 'Created table CT_VersionTracking';
GO

