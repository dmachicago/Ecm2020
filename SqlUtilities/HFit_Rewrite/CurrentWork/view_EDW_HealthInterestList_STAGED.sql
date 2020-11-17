

GO
PRINT 'Creating view view_EDW_HealthInterestList_STAGED';
PRINT 'Generated FROM: view_EDW_HealthInterestList_STAGED.SQL';
GO
IF EXISTS (SELECT
                  name
                  FROM sys.views
             WHERE name = 'view_EDW_HealthInterestList_STAGED') 
    BEGIN
        PRINT 'VIEW view_EDW_HealthInterestList_STAGED, replacing.';
        DROP VIEW
             view_EDW_HealthInterestList_STAGED;
    END;
GO

create view view_EDW_HealthInterestList_STAGED
as 
SELECT [HealthAreaID]
      ,[NodeID]
      ,[NodeGuid]
      ,[AccountCD]
      ,[HealthAreaName]
      ,[HealthAreaDescription]
      ,[CodeName]
      ,[DocumentCreatedWhen]
      ,[DocumentModifiedWhen]
  FROM [dbo].[view_EDW_HealthInterestList]
GO
PRINT 'Created view view_EDW_HealthInterestList_STAGED';

GO


