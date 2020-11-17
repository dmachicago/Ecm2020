
GO
PRINT 'Creating view_EDW_BioMetrics_STAGE';
PRINT 'FROM: view_EDW_BioMetrics_STAGE.sql';
GO

IF EXISTS (SELECT
                  name
                  FROM sys.views
                  WHERE
                        name = 'view_EDW_BioMetrics_STAGE') 
    BEGIN
        DROP VIEW
             view_EDW_BioMetrics_STAGE
    END;

GO
CREATE VIEW view_EDW_BioMetrics_STAGE
AS SELECT
          *
          FROM dbo.STAGING_EDW_BioMetrics;
GO
PRINT 'CREATED view_EDW_BioMetrics_STAGE.sql';
GO


