
select COUNT(*) from [VIRTSVR\ECMLIB].[ECM.Library].dbo.datasource

select COUNT(*) from [dellt100\ecmlib].[ecm.library].dbo.datasource

select COUNT(*) from [ecm.library].dbo.datasource

DROP view vHiveUsers
GO
create view vHiveUsers
as
select UserLoginID, EmailAddress, 'HIVE00' as InstanceID from [virtsvr\ecmlib].[ecm.library].dbo.users
union 
select UserLoginID, EmailAddress, 'HIVE01' as InstanceID from [dellt100\ecmlib].[ecm.library].dbo.users
union
select UserLoginID, EmailAddress, 'HIVE2' as InstanceID from [ecm.library].dbo.users

create view vHiveUsers2
as
select UserLoginID, EmailAddress from [virtsvr\ecmlib].[ecm.library].dbo.users
union 
select UserLoginID, EmailAddress from [dellt100\ecmlib].[ecm.library].dbo.users
union
select UserLoginID, EmailAddress from [ecm.library].dbo.users

select * FROM vHiveUsers
order by UserLoginID

select * FROM vHiveUsers2
order by UserLoginID