

GO
PRINT 'Executing Create_BASE_View_EDW_HealthAssesmentQuestions_HA_LastPullDate.sql';
GO

-- select * from [BASE_View_EDW_HealthAssesmentQuestions_HA_LastPullDate]

IF EXISTS (SELECT
                  name
           FROM sys.indexes
           WHERE
                  name = 'PI_BASE_View_EDW_HealthAssesmentQuestions_HA_LastPullDate') 
    BEGIN
        DROP INDEX PI_BASE_View_EDW_HealthAssesmentQuestions_HA_LastPullDate ON dbo.BASE_View_EDW_HealthAssesmentQuestions_HA_LastPullDate;
    END;
GO

IF EXISTS (SELECT
                  name
           FROM sys.indexes
           WHERE
                  name = 'GUID_BASE_View_EDW_HealthAssesmentQuestions_HA_LastPullDate') 
    BEGIN
        DROP INDEX GUID_BASE_View_EDW_HealthAssesmentQuestions_HA_LastPullDate ON dbo.BASE_View_EDW_HealthAssesmentQuestions_HA_LastPullDate;
    END;
GO

IF EXISTS (SELECT
                  name
           FROM sys.tables
           WHERE
                  name = 'BASE_View_EDW_HealthAssesmentQuestions_HA_LastPullDate') 
    BEGIN
        DROP TABLE
             dbo.BASE_View_EDW_HealthAssesmentQuestions_HA_LastPullDate;
    END;
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

CREATE TABLE dbo.BASE_View_EDW_HealthAssesmentQuestions_HA_LastPullDate (
             LastPullDate DATETIME NOT NULL
           ,CreateDate DATETIME NOT NULL
                                DEFAULT GETDATE () 
           ,RowNumber INT IDENTITY (1 , 1) 
                          NOT NULL
           ,StartTime DATETIME NULL
           ,EndTime DATETIME NULL
           ,ElapsedSeconds DECIMAL (10, 3) NULL
           ,RowsAffected INT NULL
           ,RowGUID UNIQUEIDENTIFIER NOT NULL
           ,SuccessfulExecution INT NULL
                                    DEFAULT 0) 
ON [PRIMARY];

GO

/***************************************************************************************************************************
***** Object:  Index [GUID_BASE_View_EDW_HealthAssesmentQuestions_HA_LastPullDate]    Script Date: 4/6/2016 4:08:48 PM *****
***************************************************************************************************************************/

CREATE NONCLUSTERED INDEX GUID_BASE_View_EDW_HealthAssesmentQuestions_HA_LastPullDate ON dbo.BASE_View_EDW_HealthAssesmentQuestions_HA_LastPullDate (RowGUID DESC) WITH (PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , SORT_IN_TEMPDB = OFF , DROP_EXISTING = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
GO

/*************************************************************************************************************************
***** Object:  Index [PI_BASE_View_EDW_HealthAssesmentQuestions_HA_LastPullDate]    Script Date: 4/6/2016 4:08:48 PM *****
*************************************************************************************************************************/

CREATE NONCLUSTERED INDEX PI_BASE_View_EDW_HealthAssesmentQuestions_HA_LastPullDate ON dbo.BASE_View_EDW_HealthAssesmentQuestions_HA_LastPullDate (LastPullDate DESC) WITH (PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , SORT_IN_TEMPDB = OFF , DROP_EXISTING = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
GO

GO
PRINT 'Executed Create_BASE_View_EDW_HealthAssesmentQuestions_HA_LastPullDate.sql';
GO

