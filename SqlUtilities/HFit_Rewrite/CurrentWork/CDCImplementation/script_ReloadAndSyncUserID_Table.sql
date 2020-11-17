

Declare @ChildTable nvarchar(256) = 'BASE_CMS_UserSite' ;
Declare @ChildColumn nvarchar(256) = 'UserID' ;

exec proc_DisableAllTableTriggers @ChildTable;
truncate table BASE_CMS_UserSite ;

exec [dbo].[proc_BASE_CMS_UserSite_KenticoCMS_1_SYNC] 0, 1;
exec [dbo].[proc_BASE_CMS_UserSite_KenticoCMS_2_SYNC] 0, 1;
exec [dbo].[proc_BASE_CMS_UserSite_KenticoCMS_3_SYNC] 0, 1;

exec sync_SurrogateKey_CMS_User @ChildTable, @ChildColumn ;
exec proc_EnableAllTableTriggers @ChildTable;