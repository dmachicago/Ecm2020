GO
PRINT 'Creating view_EDW_HealthInterestDetail_STAGED';
GO

IF EXISTS (SELECT
                  name
                  FROM sys.views
                  WHERE name = 'view_EDW_HealthInterestDetail_STAGED') 
    BEGIN
        DROP VIEW
             view_EDW_HealthInterestDetail_STAGED;
    END;
GO

/*
STAGING_EDW_HealthInterestDetail
select count(*) from view_EDW_HealthInterestDetail_STAGED

select count(*),  HealthAreaID
		,NodeID
		,NodeGuid
		,AccountCD
from view_EDW_HealthInterestDetail_STAGED
group by HealthAreaID
		,NodeID
		,NodeGuid
		,AccountCD
having count(*) > 1
*/

CREATE VIEW dbo.view_EDW_HealthInterestDetail_STAGED
AS SELECT
          UserID
        , UserGUID
        , HFitUserMpiNumber
        , SiteGUID
        , CoachingHealthInterestID
        , FirstHealthAreaID
        , FirstNodeID
        , FirstNodeGuid
        , FirstHealthAreaName
        , FirstHealthAreaDescription
        , FirstCodeName
        , SecondHealthAreaID
        , SecondNodeID
        , SecondNodeGuid
        , SecondHealthAreaName
        , SecondHealthAreaDescription
        , SecondCodeName
        , ThirdHealthAreaID
        , ThirdNodeID
        , ThirdNodeGuid
        , ThirdHealthAreaName
        , ThirdHealthAreaDescription
        , ThirdCodeName
        , ItemCreatedWhen
        , ItemModifiedWhen
          FROM STAGING_EDW_HealthInterestDetail;

GO
PRINT 'Created view_EDW_HealthInterestDetail_STAGED';
GO
--  
--  
GO
PRINT '***** FROM: view_EDW_HealthInterestDetail_STAGED.sql';
GO 
