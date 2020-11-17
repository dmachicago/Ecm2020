
GO

PRINT 'Creating table EDW_Proc_Performance_Monitor';
PRINT 'FROM EDW_Proc_Performance_Monitor.sql';
GO

IF EXISTS (SELECT
                  name
                  FROM sys.tables
                  WHERE name = 'EDW_Proc_Performance_Monitor') 
    BEGIN
        DROP TABLE
             dbo.EDW_Proc_Performance_Monitor
    END;

GO

/****** Object:  Table [dbo].[EDW_Proc_Performance_Monitor]    Script Date: 5/11/2015 2:07:52 PM ******/

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO
/*
alter table EDW_Proc_Performance_Monitor alter column ElapsedSecs float null 
alter table EDW_Proc_Performance_Monitor alter column ElapsedMin float null 
alter table EDW_Proc_Performance_Monitor alter column ElapsedHrs float null 
*/
CREATE TABLE dbo.EDW_Proc_Performance_Monitor (
TraceName nvarchar (100) NOT NULL
           ,TrackID nvarchar (50) NOT NULL
           ,StartTime datetime NOT NULL
           ,EndTime datetime NULL
           ,ElapsedTime int NULL
           ,ElapsedTimeUnits nvarchar (50) NULL
		  ,AccumulatedTime int NULL
		  ,ElapsedSecs float
		  ,ElapsedMin  float
		  ,ElapsedHrs  float
           ,Rownbr int IDENTITY (1, 1) 
                       NOT NULL
           ,CONSTRAINT PK_EDW_Proc_Performance_Monitor PRIMARY KEY CLUSTERED
             (
             TraceName ASC, TrackID asc, Rownbr
             ) 
                WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) 
ON [PRIMARY];

GO

ALTER TABLE dbo.EDW_Proc_Performance_Monitor
ADD
            CONSTRAINT DF_EDW_Proc_Performance_Monitor_StartTime  DEFAULT GETDATE () FOR StartTime;
GO

PRINT 'CREATED table EDW_Proc_Performance_Monitor';
PRINT 'FROM EDW_Proc_Performance_Monitor.sql';
GO
