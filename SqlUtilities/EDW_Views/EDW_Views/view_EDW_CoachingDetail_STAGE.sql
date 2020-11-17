
GO
print('***** FROM: view_EDW_CoachingDetail_STAGE.sql'); 
go

print ('Processing: view_EDW_CoachingDetail_STAGE ') ;
go

if exists(select TABLE_NAME from INFORMATION_SCHEMA.VIEWS where TABLE_NAME = 'view_EDW_CoachingDetail_STAGE')
BEGIN
	drop view view_EDW_CoachingDetail_STAGE ;
END
GO

--GRANT SELECT
--	ON [dbo].[[view_EDW_CoachingDetail_STAGE]]
--	TO [EDWReader_PRD]
--GO

/* TEST Queries
select * from [view_EDW_CoachingDetail_STAGE]
select * from [view_EDW_CoachingDetail_STAGE] where CloseReasonLKPID != 0
select count(*) from [view_EDW_CoachingDetail_STAGE]
*/

create VIEW [dbo].[view_EDW_CoachingDetail_STAGE]
AS
    select * from STAGING_EDW_CoachingDetail ;
GO
print('***** Created: view_EDW_CoachingDetail_STAGE'); 
GO 

