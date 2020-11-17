
GO
PRINT 'Executing MASTER_LKP_CTVersion.SQL';
GO

IF EXISTS (SELECT
                  name
                  FROM sys.tables
                  WHERE
                  name = 'MASTER_LKP_CTVersion') 
    BEGIN
        DROP TABLE
             MASTER_LKP_CTVersion;
    END;

GO

CREATE TABLE dbo.MASTER_LKP_CTVersion (
             ProcedureID NVARCHAR (100) NOT NULL
           , SYS_CHANGE_VERSION BIGINT NOT NULL
           , TableName NVARCHAR (100) NOT NULL
           , CONSTRAINT PK_MASTER_LKP_CTVersion PRIMARY KEY CLUSTERED
             (
             ProcedureID ASC ,
             TableName ASC ,
             SYS_CHANGE_VERSION ASC
             ) 
                 WITH (PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , IGNORE_DUP_KEY = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) 
ON [PRIMARY];

create unique index UK_MASTER_LKP_CTVersion on MASTER_LKP_CTVersion (ProcedureID, SYS_CHANGE_VERSION);

GO
PRINT 'Executed MASTER_LKP_CTVersion.SQL';
GO
