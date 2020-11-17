
GO
-- select top 100 * from [BASE_HFit_HealthAssesmentUserStarted]
-- select top 100 * from [BASE_HFit_HealthAssesmentUserStarted] where UserStartedItemID in (select itemID from 
-- delete from [BASE_HFit_HealthAssesmentUserStarted] where ItemID = 83988
/*
delete from [BASE_HFit_HealthAssesmentUserStarted] where ItemID = 83988 and DBNAME = 'KenticoCMS_1'
select top 100 * from BASE_HFit_HealthAssesmentUserStarted where ItemID = 83988
select * from [BASE_HFit_HealthAssesmentUserStarted]
where ITemID in (
83089
,83580
,83695
,83812
,83988
,84257
,84903
,84936
)
*/

-- USE [KenticoCMS_Datamart_2]

go
print 'Executing TRIG_DEL_BASE_HFit_HealthAssesmentUserStarted_HA_Sync.sql'
go
if exists (Select name from sys.triggers where name = 'TRIG_DEL_BASE_HFit_HealthAssesmentUserStarted_HA_Sync')
    drop trigger TRIG_DEL_BASE_HFit_HealthAssesmentUserStarted_HA_Sync;
go

create TRIGGER [dbo].[TRIG_DEL_BASE_HFit_HealthAssesmentUserStarted_HA_Sync]
    ON [dbo].[BASE_HFit_HealthAssesmentUserStarted]
    after DELETE AS 
BEGIN 

delete BASE
    from dbo.BASE_MART_EDW_HealthAssesment as BASE
    inner join deleted as D
	   on BASE.dbname = D.dbname
	   and BASE.UserStartedItemID = D.Itemid ;

print 'Affected Rows Removed from BASE_MART_EDW_HealthAssesment: ' + cast(@@ROWCOUNT as nvarchar(50))  ;

END; 

go
print 'Executed TRIG_DEL_BASE_HFit_HealthAssesmentUserStarted_HA_Sync.sql'
go
