
use DataMartPlatform
go
exec proc_BASE_CMS_User_KenticoCMS_1_SYNC
go

delete from BASE_CMS_User where UserName = 'NA'
select top 100 * from BASE_CMS_User  where UserName = 'NA' order by LastModifiedDate desc

select count(*) from KenticoCMS_3.dbo.CMS_USER
select distinct UserID from KenticoCMS_3.dbo.HFit_TrackerBMI where UserID not in 
(select UserID from KenticoCMS_3.dbo.CMS_USER )
go
select distinct 'exec proc_AddMissingUserID  '+cast(UserID as nvarchar(50)) + ',''AZUPRDSQL05'', ' + '''KenticoCMS_1''' as cmd from KenticoCMS_1.dbo.HFit_TrackerBMI where UserID not in 
(select UserID from BASE_CMS_USER where DBNAME = 'KenticoCMS_1' )
union 
select distinct 'exec proc_AddMissingUserID  '+cast(UserID as nvarchar(50)) + ',''AZUPRDSQL05'', ' + '''KenticoCMS_2''' as cmd from KenticoCMS_2.dbo.HFit_TrackerBMI where UserID not in 
(select UserID from BASE_CMS_USER where DBNAME = 'KenticoCMS_2' )
union 
select distinct 'exec proc_AddMissingUserID  '+cast(UserID as nvarchar(50)) + ',''AZUPRDSQL05'', ' + '''KenticoCMS_3''' as cmd from KenticoCMS_3.dbo.HFit_TrackerBMI where UserID not in 
(select UserID from BASE_CMS_USER where DBNAME = 'KenticoCMS_3' )

select * from KenticoCMS_3.dbo.CMS_USER where UserID = 65310
exec proc_AddMissingUserID  66057,'AZUPRDSQL05', 'KenticoCMS_3'
go

create procedure proc_AddMissingUserID (@UserID int,@SVR nvarchar(50) , @DBNAME  nvarchar(50))
as
INSERT INTO [dbo].[BASE_cms_user]
           ([UserName]
           ,[FirstName]
           ,[MiddleName]
           ,[LastName]
           ,[FullName]
           ,[Email]
           ,[UserPassword]
           ,[PreferredCultureCode]
           ,[PreferredUICultureCode]
           ,[UserEnabled]
           ,[UserIsEditor]
           ,[UserIsGlobalAdministrator]
           ,[UserIsExternal]
           ,[UserPasswordFormat]
           ,[UserCreated]
           ,[LastLogon]
           ,[UserStartingAliasPath]
           ,[UserGUID]
           ,[UserLastModified]
           ,[UserLastLogonInfo]
           ,[UserIsHidden]
           ,[UserVisibility]
           ,[UserIsDomain]
           ,[UserHasAllowedCultures]
           ,[UserSiteManagerDisabled]
           ,[UserPasswordBuffer]
           ,[UserTokenID]
           ,[UserMFRequired]
           ,[UserTokenIteration]
           ,[UserID]
           ,[Action]
           ,[SYS_CHANGE_VERSION]
           ,[LASTMODIFIEDDATE]
           ,[HashCode]
           ,[SVR]
           ,[DBNAME]
           ,[SurrogateKey_Board_Board]
           ,[SurrogateKey_Board_Message]
           ,[SurrogateKey_Chat_User]
           ,[SurrogateKey_CMS_AbuseReport]
           ,[SurrogateKey_CMS_ACLItem]
           ,[SurrogateKey_CMS_AutomationHistory]
           ,[SurrogateKey_CMS_AutomationState]
           ,[SurrogateKey_CMS_Category]
           ,[SurrogateKey_CMS_Document]
           ,[SurrogateKey_CMS_EmailUser]
           ,[SurrogateKey_CMS_MembershipUser]
           ,[SurrogateKey_CMS_ObjectSettings]
           ,[SurrogateKey_CMS_ObjectVersionHistory]
           ,[SurrogateKey_CMS_OpenIDUser]
           ,[SurrogateKey_CMS_Personalization]
           ,[SurrogateKey_CMS_ScheduledTask]
           ,[SurrogateKey_CMS_Session]
           ,[SurrogateKey_CMS_TranslationSubmission]
           ,[SurrogateKey_CMS_Tree]
           ,[SurrogateKey_CMS_UserCulture]
           ,[SurrogateKey_CMS_UserRole]
           ,[SurrogateKey_CMS_UserSettings]
           ,[SurrogateKey_CMS_UserSite]
           ,[SurrogateKey_CMS_VersionHistory]
           ,[SurrogateKey_CMS_WorkflowHistory]
           ,[SurrogateKey_CMS_WorkflowStepUser]
           ,[SurrogateKey_CMS_WorkflowUser]
           ,[SurrogateKey_Community_Group]
           ,[SurrogateKey_Messaging_Message]
           ,[SurrogateKey_OM_Account]
           ,[SurrogateKey_OM_Contact]
           ,[CT_UserID]
           ,[CT_UserName]
           ,[CT_FirstName]
           ,[CT_MiddleName]
           ,[CT_LastName]
           ,[CT_FullName]
           ,[CT_Email]
           ,[CT_UserPassword]
           ,[CT_PreferredCultureCode]
           ,[CT_PreferredUICultureCode]
           ,[CT_UserEnabled]
           ,[CT_UserIsEditor]
           ,[CT_UserIsGlobalAdministrator]
           ,[CT_UserIsExternal]
           ,[CT_UserPasswordFormat]
           ,[CT_UserCreated]
           ,[CT_LastLogon]
           ,[CT_UserStartingAliasPath]
           ,[CT_UserGUID]
           ,[CT_UserLastModified]
           ,[CT_UserLastLogonInfo]
           ,[CT_UserIsHidden]
           ,[CT_UserVisibility]
           ,[CT_UserIsDomain]
           ,[CT_UserHasAllowedCultures]
           ,[CT_UserSiteManagerDisabled]
           ,[CT_UserPasswordBuffer]
           ,[CT_UserTokenID]
           ,[CT_UserMFRequired]
           ,[CT_UserTokenIteration]
           ,[CT_RowDataUpdated])
     VALUES
           ('NA' --<UserName, nvarchar(100),>
           ,'NA' --<FirstName, nvarchar(100),>
           ,'NA' --<MiddleName, nvarchar(100),>
           ,'NA' --<LastName, nvarchar(100),>
           ,'NA' --<FullName, nvarchar(450),>
           ,'NA' --<Email, nvarchar(100),>
           ,'NA' --<UserPassword, nvarchar(100),>
           ,'NA' --<PreferredCultureCode, nvarchar(10),>
           ,'NA' --<PreferredUICultureCode, nvarchar(10),>
           ,0		--<UserEnabled, bit,>
           ,0	 --<UserIsEditor, bit,>
           ,0	 --<UserIsGlobalAdministrator, bit,>
           ,0	 --<UserIsExternal, bit,>
           ,'NA' --<UserPasswordFormat, nvarchar(10),>
           ,getdate()   --<UserCreated, datetime2(7),>
           ,getdate()   --<LastLogon, datetime2(7),>
           ,'NA' --<UserStartingAliasPath, nvarchar(200),>
           ,newid()	--<UserGUID, uniqueidentifier,>
           ,getdate()   --<UserLastModified, datetime2(7),>
           ,'NA' --<UserLastLogonInfo, nvarchar(max),>
           ,0 --<UserIsHidden, bit,>
           ,0	 --<UserVisibility, nvarchar(max),>
           ,0	 --<UserIsDomain, bit,>
           ,0	 --<UserHasAllowedCultures, bit,>
           ,0	 --<UserSiteManagerDisabled, bit,>
           ,'NA' --<UserPasswordBuffer, nvarchar(2000),>
           ,newid()	--<UserTokenID, uniqueidentifier,>
           ,0	 --<UserMFRequired, bit,>
           ,0	 --<UserTokenIteration, int,>
           ,@UserID
           ,'X' --<Action, char(1),>
           ,0	 --<SYS_CHANGE_VERSION, bigint,>
           ,getdate()   --<LASTMODIFIEDDATE, datetime2(7),>
           ,'NA' --<HashCode, nvarchar(75),>
           ,@SVR	--<SVR, nvarchar(100),>
           ,@DBNAME	--<DBNAME, nvarchar(100),>
           ,0    --SurrogateKey_Board_Board, bigint,>
           ,0    --SurrogateKey_Board_Message, bigint,>
           ,0    --SurrogateKey_Chat_User, bigint,>
           ,0    --SurrogateKey_CMS_AbuseReport, bigint,>
           ,0    --SurrogateKey_CMS_ACLItem, bigint,>
           ,0    --SurrogateKey_CMS_AutomationHistory, bigint,>
           ,0    --SurrogateKey_CMS_AutomationState, bigint,>
           ,0    --SurrogateKey_CMS_Category, bigint,>
           ,0    --SurrogateKey_CMS_Document, bigint,>
           ,0    --SurrogateKey_CMS_EmailUser, bigint,>
           ,0    --SurrogateKey_CMS_MembershipUser, bigint,>
           ,0    --SurrogateKey_CMS_ObjectSettings, bigint,>
           ,0    --SurrogateKey_CMS_ObjectVersionHistory, bigint,>
           ,0    --SurrogateKey_CMS_OpenIDUser, bigint,>
           ,0    --SurrogateKey_CMS_Personalization, bigint,>
           ,0    --SurrogateKey_CMS_ScheduledTask, bigint,>
           ,0    --SurrogateKey_CMS_Session, bigint,>
           ,0    --SurrogateKey_CMS_TranslationSubmission, bigint,>
           ,0    --SurrogateKey_CMS_Tree, bigint,>
           ,0    --SurrogateKey_CMS_UserCulture, bigint,>
           ,0    --SurrogateKey_CMS_UserRole, bigint,>
           ,0    --SurrogateKey_CMS_UserSettings, bigint,>
           ,0    --SurrogateKey_CMS_UserSite, bigint,>
           ,0    --SurrogateKey_CMS_VersionHistory, bigint,>
           ,0    --SurrogateKey_CMS_WorkflowHistory, bigint,>
           ,0    --SurrogateKey_CMS_WorkflowStepUser, bigint,>
           ,0    --SurrogateKey_CMS_WorkflowUser, bigint,>
           ,0    --SurrogateKey_Community_Group, bigint,>
           ,0    --SurrogateKey_Messaging_Message, bigint,>
           ,0    --SurrogateKey_OM_Account, bigint,>
           ,0    --SurrogateKey_OM_Contact, bigint,>
           ,0    --CT_UserID, bit,>
           ,0    --CT_UserName, bit,>
           ,0    --CT_FirstName, bit,>
           ,0    --CT_MiddleName, bit,>
           ,0    --CT_LastName, bit,>
           ,0    --CT_FullName, bit,>
           ,0    --CT_Email, bit,>
           ,0    --CT_UserPassword, bit,>
           ,0    --CT_PreferredCultureCode, bit,>
           ,0    --CT_PreferredUICultureCode, bit,>
           ,0    --CT_UserEnabled, bit,>
           ,0    --CT_UserIsEditor, bit,>
           ,0    --CT_UserIsGlobalAdministrator, bit,>
           ,0    --CT_UserIsExternal, bit,>
           ,0    --CT_UserPasswordFormat, bit,>
           ,0    --CT_UserCreated, bit,>
           ,0    --CT_LastLogon, bit,>
           ,0    --CT_UserStartingAliasPath, bit,>
           ,0    --CT_UserGUID, bit,>
           ,0    --CT_UserLastModified, bit,>
           ,0    --CT_UserLastLogonInfo, bit,>
           ,0    --CT_UserIsHidden, bit,>
           ,0    --CT_UserVisibility, bit,>
           ,0    --CT_UserIsDomain, bit,>
           ,0    --CT_UserHasAllowedCultures, bit,>
           ,0    --CT_UserSiteManagerDisabled, bit,>
           ,0    --CT_UserPasswordBuffer, bit,>
           ,0    --CT_UserTokenID, bit,>
           ,0    --CT_UserMFRequired, bit,>
           ,0    --CT_UserTokenIteration, bit,>
           ,0)    --CT_RowDataUpdated, bit,>)

		 exec proc_AddMissingUserID  128184,'AZUPRDSQL05', 'KenticoCMS_2'
exec proc_AddMissingUserID  75447,'AZUPRDSQL05', 'KenticoCMS_2'
exec proc_AddMissingUserID  94002,'AZUPRDSQL05', 'KenticoCMS_2'
exec proc_AddMissingUserID  114496,'AZUPRDSQL05', 'KenticoCMS_2'
exec proc_AddMissingUserID  128039,'AZUPRDSQL05', 'KenticoCMS_2'
exec proc_AddMissingUserID  128124,'AZUPRDSQL05', 'KenticoCMS_2'
exec proc_AddMissingUserID  128046,'AZUPRDSQL05', 'KenticoCMS_2'
exec proc_AddMissingUserID  85687,'AZUPRDSQL05', 'KenticoCMS_2'
exec proc_AddMissingUserID  75,'AZUPRDSQL05', 'KenticoCMS_2'