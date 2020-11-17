

GO
PRINT 'Creating view_EDW_RewardUserLevel_STAGED';
GO

IF EXISTS (SELECT
                  name
                  FROM sys.views
                  WHERE
                        name = 'view_EDW_RewardUserLevel_STAGED') 
    BEGIN
        DROP VIEW
             view_EDW_RewardUserLevel_STAGED;
    END;
GO

CREATE VIEW view_EDW_RewardUserLevel_STAGED
AS SELECT
 [UserId]
      ,[LevelCompletedDt]
      ,[LevelName]
      ,[SiteName]
      ,[nodeguid]
      ,[SiteGuid]
      ,[LevelHeader]
      ,[GroupHeadingText]
      ,[GroupHeadingDescription]
          FROM dbo.STAGING_EDW_RewardUserLevel;
GO

PRINT 'Created view_EDW_RewardUserLevel_STAGED';
GO
