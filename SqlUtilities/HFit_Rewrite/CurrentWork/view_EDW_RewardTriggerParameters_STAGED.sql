
GO
print ('Processing: view_EDW_RewardTriggerParameters_STAGED ') ;
go

if exists(select NAME from sys.VIEWS where NAME = 'view_EDW_RewardTriggerParameters_STAGED')
BEGIN
	drop view view_EDW_RewardTriggerParameters_STAGED ;
END
GO

create VIEW [dbo].[view_EDW_RewardTriggerParameters_STAGED]
AS
select * from STAGING_EDW_RewardTriggerParameters
      

GO


  --  
  --  
GO 
print('***** Created: view_EDW_RewardTriggerParameters_STAGED.sql'); 
GO 
