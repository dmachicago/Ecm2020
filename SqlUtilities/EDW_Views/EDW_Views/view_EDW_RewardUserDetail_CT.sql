
GO
PRINT 'Processing: view_EDW_RewardUserDetail_CT ';
GO

IF EXISTS (SELECT
                  NAME
                  FROM sys.VIEWS
             WHERE NAME = 'view_EDW_RewardUserDetail_CT') 
    BEGIN
        DROP VIEW
             view_EDW_RewardUserDetail_CT;
    END;
GO

CREATE VIEW dbo.view_EDW_RewardUserDetail_CT
AS

SELECT 
    * from STAGING_EDW_RewardUserDetail;

GO
PRINT 'Completed : view_EDW_RewardUserDetail_CT ';
GO

PRINT '***** FROM: view_EDW_RewardUserDetail_CT.sql';
GO 
