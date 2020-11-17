GO
print('Creating view_HealthInterestDetail_STAGED'); 
GO

if exists(select name from sys.views where name = 'view_HealthInterestDetail_STAGED')
BEGIN 
	drop view view_HealthInterestDetail_STAGED ;
END
go

/*
STAGING_EDW_HealthInterestDetail
select count(*) from view_HealthInterestDetail_STAGED

select count(*),  HealthAreaID
		,NodeID
		,NodeGuid
		,AccountCD
from view_HealthInterestDetail_STAGED
group by HealthAreaID
		,NodeID
		,NodeGuid
		,AccountCD
having count(*) > 1
*/
CREATE VIEW [dbo].[view_HealthInterestDetail_STAGED]
AS
	--12/03/2014 (wdm) this view was created by Chad Gurka and passed over to Team P to include into the build
	SELECT * from STAGING_EDW_HealthInterestDetail
		
GO
print('Created view_HealthInterestDetail_STAGED'); 
GO
  --  
  --  
GO 
print('***** FROM: view_HealthInterestDetail_STAGED.sql'); 
GO 
