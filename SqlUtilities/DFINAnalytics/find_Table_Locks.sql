SELECT * FROM sys.dm_tran_locks
  WHERE resource_database_id = DB_ID()
  AND resource_associated_entity_id = OBJECT_ID(N'dbo.BASE_CMS_User');

SELECT * FROM sys.dm_tran_locks
  WHERE resource_database_id = DB_ID()
  AND resource_associated_entity_id = OBJECT_ID(N'dbo.BASE_View_OM_ContactGroupMember_User_ContactJoined');

exec sp_who2

dbcc inputbuffer (23)
dbcc inputbuffer (84)

dbcc inputbuffer (91)
select count(*) from KenticoCMS_1.dbo.view_OM_ContactGroupMember_User_ContactJoined
-- exec proc_View_OM_ContactGroupMember_User_ContactJoined_KenticoCMS_1

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
