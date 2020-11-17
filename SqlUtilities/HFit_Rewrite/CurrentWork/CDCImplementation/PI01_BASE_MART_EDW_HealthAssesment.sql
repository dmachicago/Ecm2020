
GO
PRINT 'Executing PI01_BASE_MART_EDW_HealthAssesment.sql';
GO
IF NOT EXISTS (SELECT name
                 FROM sys.indexes
                 WHERE name = 'PI01_BASE_MART_EDW_HealthAssesment') 
    BEGIN
        CREATE NONCLUSTERED INDEX PI01_BASE_MART_EDW_HealthAssesment 
		  ON dbo.BASE_MART_EDW_HealthAssesment (SVR, DBNAME, SiteID) 
		  INCLUDE (UserID, AccountID, AccountCD, AccountName) 
    END;
GO
PRINT 'Executed PI01_BASE_MART_EDW_HealthAssesment.sql';
GO

