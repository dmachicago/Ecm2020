
GO
PRINT 'Creating view view_EDW_RewardUserLevel_CT';
PRINT '***** FROM: view_EDW_RewardUserLevel_CT.sql';
GO

IF EXISTS (SELECT
                  name
                  FROM sys.views
             WHERE
                   name = 'view_EDW_RewardUserLevel_CT') 
    BEGIN
        DROP VIEW
             view_EDW_RewardUserLevel_CT;
    END;
GO

CREATE VIEW view_EDW_RewardUserLevel_CT
AS

/***************************************************************************************************
Changes:
04.17.2015 (WDM) Converted to provide Change Tracking

select top 1000 * from view_EDW_RewardUserLevel_CT

select count(*), HashCode from view_EDW_RewardUserLevel_CT group by HashCode having count(*) > 1

select count(*), 
       UserId
     , LevelCompletedDt
     , LevelName
     , SiteName
     , nodeguid
     , SiteGuid
     --, LevelHeader
     --, GroupHeadingText
     --, GroupHeadingDescription
from view_EDW_RewardUserLevel_CT 
group by UserId
     , LevelCompletedDt
     , LevelName
     , SiteName
     , nodeguid
     , SiteGuid
     --, LevelHeader
     --, GroupHeadingText
     --, GroupHeadingDescription
having count(*) > 1

***************************************************************************************************/

SELECT DISTINCT
       us.UserId
     , dl.LevelCompletedDt
     , RL_Joined.NodeName AS LevelName
     , s.SiteName
     , RL_Joined.nodeguid
     , s.SiteGuid
     , RL_Joined.LevelHeader
     , RL_Joined.GroupHeadingText
     , RL_Joined.GroupHeadingDescription
     , HASHBYTES ('sha1',
       ISNULL (CAST (us.UserId AS nvarchar (50)) , '--') + ISNULL (CAST (dl.LevelCompletedDt AS nvarchar (50)) , '--') + ISNULL (CAST (RL_Joined.NodeName AS nvarchar (250)) , '--') + ISNULL (CAST (s.SiteName AS nvarchar (250)) , '--') + ISNULL (CAST (RL_Joined.nodeguid AS nvarchar (50)) , '--') + ISNULL (CAST (s.SiteGuid AS nvarchar (50)) , '--') + ISNULL (CAST (RL_Joined.LevelHeader  AS nvarchar (250)) , '--') + ISNULL (CAST (LEFT (RL_Joined.GroupHeadingText, 1000) AS nvarchar (2000)) , '-') + ISNULL (CAST (LEFT (RL_Joined.GroupHeadingDescription, 2000) AS nvarchar (2000)) , '-') 
       ) AS HashCode
       FROM
           HFit_RewardsUserLevelDetail AS dl
               INNER JOIN View_HFit_RewardLevel_Joined AS RL_Joined
                   ON
                      RL_Joined.NodeId = dl.LevelNodeId
				    AND RL_Joined.DocumentCulture= 'EN-US'
                 JOIN CMS_UserSite AS us
                   ON
                      us.UserId = dl.UserId
                 JOIN CMS_Site AS s
                   ON
                      s.SiteId = us.SiteId;

GO

PRINT 'Created view view_EDW_RewardUserLevel_CT';

GO 

