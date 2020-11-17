/*
use KenticoCMS_Datamart_2
go

SELECT SCHEMA_NAME(SCHEMA_ID) AS [Schema], 
SO.name AS [ObjectName],
SO.Type_Desc AS [ObjectType (UDF/SP)],
P.parameter_id AS [ParameterID],
P.name AS [ParameterName],
TYPE_NAME(P.user_type_id) AS [ParameterDataType],
P.max_length AS [ParameterMaxBytes],
P.is_output AS [IsOutPutParameter]
FROM sys.objects AS SO
INNER JOIN sys.parameters AS P 
ON SO.OBJECT_ID = P.OBJECT_ID
WHERE SO.OBJECT_ID IN ( SELECT OBJECT_ID 
FROM sys.objects
WHERE TYPE IN ('P','FN'))
and P.name like '@Reload%'
ORDER BY [Schema], SO.name, P.parameter_id
*/

/*
-- USE THIS SCRIPT to generate the execution commands:
select 'Print ''Executing ' + SO.name + ''''
+char(10) + 'GO'
+char(10) + 'print ''Start Time:'' '
+char(10) + 'Print getdate()'
+char(10) + 'GO'
+char(10) + 'EXEC ' + SO.name + ' ' + P.name + ' = 1' 
+char(10) + 'GO'
+char(10) + 'print ''END Time:'' '
+char(10) + 'Print getdate()'
+char(10) + 'print ''*****************************************************'' ' 
+char(10) + 'GO'
FROM sys.objects AS SO
INNER JOIN sys.parameters AS P 
ON SO.OBJECT_ID = P.OBJECT_ID
WHERE SO.OBJECT_ID IN ( SELECT OBJECT_ID 
FROM sys.objects
WHERE TYPE IN ('P','FN'))
and P.name like '@Reload%'
and SO.Name not like '%EventLog%'
ORDER BY SO.name, P.parameter_id
*/


Print 'Executing proc_BASE_Board_Board_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_Board_Board_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_Board_Board_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_Board_Board_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_Board_Board_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_Board_Board_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_Board_Message_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_Board_Message_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_Board_Message_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_Board_Message_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_Board_Message_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_Board_Message_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_Chat_Message_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_Chat_Message_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_Chat_Message_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_Chat_Message_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_Chat_Message_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_Chat_Message_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_Chat_Room_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_Chat_Room_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_Chat_Room_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_Chat_Room_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_Chat_Room_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_Chat_Room_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_Chat_User_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_Chat_User_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_Chat_User_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_Chat_User_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_Chat_User_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_Chat_User_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_AbuseReport_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_AbuseReport_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_AbuseReport_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_AbuseReport_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_AbuseReport_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_AbuseReport_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_ACL_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_ACL_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_ACL_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_ACL_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_ACL_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_ACL_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_ACLItem_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_ACLItem_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_ACLItem_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_ACLItem_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_ACLItem_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_ACLItem_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_AllowedChildClasses_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_AllowedChildClasses_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_AllowedChildClasses_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_AllowedChildClasses_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_AllowedChildClasses_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_AllowedChildClasses_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_AlternativeForm_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_AlternativeForm_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_AlternativeForm_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_AlternativeForm_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_AlternativeForm_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_AlternativeForm_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_Attachment_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_Attachment_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_Attachment_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_Attachment_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_Attachment_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_Attachment_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_AttachmentForEmail_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_AttachmentForEmail_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_AttachmentForEmail_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_AttachmentForEmail_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_AttachmentForEmail_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_AttachmentForEmail_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_AttachmentHistory_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_AttachmentHistory_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_AttachmentHistory_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_AttachmentHistory_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_AttachmentHistory_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_AttachmentHistory_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_AutomationHistory_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_AutomationHistory_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_AutomationHistory_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_AutomationHistory_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_AutomationHistory_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_AutomationHistory_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_AutomationState_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_AutomationState_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_AutomationState_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_AutomationState_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_AutomationState_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_AutomationState_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_Avatar_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_Avatar_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_Avatar_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_Avatar_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_Avatar_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_Avatar_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_Badge_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_Badge_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_Badge_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_Badge_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_Badge_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_Badge_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_BannedIP_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_BannedIP_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_BannedIP_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_BannedIP_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_BannedIP_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_BannedIP_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_Banner_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_Banner_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_Banner_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_Banner_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_Banner_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_Banner_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_BannerCategory_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_BannerCategory_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_BannerCategory_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_BannerCategory_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_BannerCategory_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_BannerCategory_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_Category_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_Category_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_Category_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_Category_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_Category_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_Category_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_Class_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_Class_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_Class_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_Class_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_Class_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_Class_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_ClassSite_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_ClassSite_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_ClassSite_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_ClassSite_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_ClassSite_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_ClassSite_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_Country_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_Country_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_Country_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_Country_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_Country_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_Country_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_CssStylesheet_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_CssStylesheet_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_CssStylesheet_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_CssStylesheet_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_CssStylesheet_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_CssStylesheet_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_CssStylesheetSite_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_CssStylesheetSite_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_CssStylesheetSite_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_CssStylesheetSite_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_CssStylesheetSite_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_CssStylesheetSite_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_Culture_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_Culture_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_Culture_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_Culture_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_Culture_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_Culture_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_DeviceProfile_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_DeviceProfile_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_DeviceProfile_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_DeviceProfile_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_DeviceProfile_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_DeviceProfile_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_DeviceProfileLayout_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_DeviceProfileLayout_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_DeviceProfileLayout_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_DeviceProfileLayout_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_DeviceProfileLayout_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_DeviceProfileLayout_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_Document_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_Document_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_Document_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_Document_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_Document_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_Document_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_DocumentAlias_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_DocumentAlias_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_DocumentAlias_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_DocumentAlias_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_DocumentAlias_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_DocumentAlias_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_DocumentCategory_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_DocumentCategory_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_DocumentCategory_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_DocumentCategory_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_DocumentCategory_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_DocumentCategory_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_DocumentTag_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_DocumentTag_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_DocumentTag_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_DocumentTag_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_DocumentTag_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_DocumentTag_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_DocumentTypeScope_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_DocumentTypeScope_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_DocumentTypeScope_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_DocumentTypeScope_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_DocumentTypeScope_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_DocumentTypeScope_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_DocumentTypeScopeClass_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_DocumentTypeScopeClass_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_DocumentTypeScopeClass_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_DocumentTypeScopeClass_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_DocumentTypeScopeClass_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_DocumentTypeScopeClass_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_Email_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_Email_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_Email_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_Email_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_Email_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_Email_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_EmailAttachment_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_EmailAttachment_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_EmailAttachment_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_EmailAttachment_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_EmailAttachment_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_EmailAttachment_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_EmailTemplate_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_EmailTemplate_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_EmailTemplate_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_EmailTemplate_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_EmailTemplate_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_EmailTemplate_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_EmailUser_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_EmailUser_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_EmailUser_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_EmailUser_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_EmailUser_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_EmailUser_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_Form_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_Form_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_Form_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_Form_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_Form_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_Form_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_FormRole_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_FormRole_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_FormRole_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_FormRole_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_FormRole_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_FormRole_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_FormUserControl_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_FormUserControl_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_FormUserControl_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_FormUserControl_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_FormUserControl_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_FormUserControl_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_HelpTopic_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_HelpTopic_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_HelpTopic_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_HelpTopic_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_HelpTopic_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_HelpTopic_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_InlineControl_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_InlineControl_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_InlineControl_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_InlineControl_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_InlineControl_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_InlineControl_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_InlineControlSite_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_InlineControlSite_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_InlineControlSite_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_InlineControlSite_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_InlineControlSite_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_InlineControlSite_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_Layout_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_Layout_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_Layout_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_Layout_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_Layout_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_Layout_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_LicenseKey_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_LicenseKey_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_LicenseKey_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_LicenseKey_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_LicenseKey_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_LicenseKey_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_MacroRule_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_MacroRule_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_MacroRule_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_MacroRule_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_MacroRule_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_MacroRule_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_Membership_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_Membership_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_Membership_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_Membership_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_Membership_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_Membership_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_MembershipRole_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_MembershipRole_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_MembershipRole_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_MembershipRole_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_MembershipRole_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_MembershipRole_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_MembershipUser_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_MembershipUser_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_MembershipUser_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_MembershipUser_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_MembershipUser_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_MembershipUser_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_MetaFile_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_MetaFile_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_MetaFile_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_MetaFile_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_MetaFile_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_MetaFile_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_ObjectRelationship_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_ObjectRelationship_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_ObjectRelationship_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_ObjectRelationship_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_ObjectRelationship_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_ObjectRelationship_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_ObjectSettings_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_ObjectSettings_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_ObjectSettings_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_ObjectSettings_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_ObjectSettings_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_ObjectSettings_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_ObjectVersionHistory_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_ObjectVersionHistory_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_ObjectVersionHistory_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_ObjectVersionHistory_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_ObjectVersionHistory_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_ObjectVersionHistory_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_ObjectWorkflowTrigger_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_ObjectWorkflowTrigger_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_ObjectWorkflowTrigger_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_ObjectWorkflowTrigger_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_ObjectWorkflowTrigger_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_ObjectWorkflowTrigger_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_OpenIDUser_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_OpenIDUser_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_OpenIDUser_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_OpenIDUser_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_OpenIDUser_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_OpenIDUser_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_PageTemplate_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_PageTemplate_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_PageTemplate_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_PageTemplate_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_PageTemplate_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_PageTemplate_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_PageTemplateCategory_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_PageTemplateCategory_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_PageTemplateCategory_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_PageTemplateCategory_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_PageTemplateCategory_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_PageTemplateCategory_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_PageTemplateScope_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_PageTemplateScope_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_PageTemplateScope_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_PageTemplateScope_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_PageTemplateScope_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_PageTemplateScope_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_PageTemplateSite_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_PageTemplateSite_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_PageTemplateSite_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_PageTemplateSite_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_PageTemplateSite_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_PageTemplateSite_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_Permission_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_Permission_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_Permission_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_Permission_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_Permission_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_Permission_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_Personalization_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_Personalization_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_Personalization_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_Personalization_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_Personalization_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_Personalization_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_Query_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_Query_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_Query_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_Query_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_Query_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_Query_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_Relationship_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_Relationship_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_Relationship_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_Relationship_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_Relationship_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_Relationship_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_RelationshipName_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_RelationshipName_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_RelationshipName_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_RelationshipName_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_RelationshipName_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_RelationshipName_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_RelationshipNameSite_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_RelationshipNameSite_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_RelationshipNameSite_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_RelationshipNameSite_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_RelationshipNameSite_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_RelationshipNameSite_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_Resource_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_Resource_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_Resource_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_Resource_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_Resource_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_Resource_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_ResourceLibrary_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_ResourceLibrary_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_ResourceLibrary_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_ResourceLibrary_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_ResourceLibrary_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_ResourceLibrary_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_ResourceSite_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_ResourceSite_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_ResourceSite_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_ResourceSite_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_ResourceSite_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_ResourceSite_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_ResourceString_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_ResourceString_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_ResourceString_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_ResourceString_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_ResourceString_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_ResourceString_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_ResourceTranslation_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_ResourceTranslation_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_ResourceTranslation_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_ResourceTranslation_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_ResourceTranslation_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_ResourceTranslation_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_Role_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_Role_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_Role_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_Role_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_Role_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_Role_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_RoleApplication_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_RoleApplication_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_RoleApplication_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_RoleApplication_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_RoleApplication_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_RoleApplication_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_RolePermission_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_RolePermission_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_RolePermission_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_RolePermission_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_RolePermission_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_RolePermission_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_RoleUIElement_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_RoleUIElement_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_RoleUIElement_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_RoleUIElement_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_RoleUIElement_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_RoleUIElement_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_ScheduledTask_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_ScheduledTask_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_ScheduledTask_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_ScheduledTask_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_ScheduledTask_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_ScheduledTask_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_SearchEngine_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_SearchEngine_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_SearchEngine_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_SearchEngine_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_SearchEngine_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_SearchEngine_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_SearchIndex_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_SearchIndex_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_SearchIndex_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_SearchIndex_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_SearchIndex_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_SearchIndex_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_SearchIndexCulture_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_SearchIndexCulture_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_SearchIndexCulture_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_SearchIndexCulture_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_SearchIndexCulture_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_SearchIndexCulture_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_SearchIndexSite_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_SearchIndexSite_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_SearchIndexSite_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_SearchIndexSite_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_SearchIndexSite_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_SearchIndexSite_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_SearchTask_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_SearchTask_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_SearchTask_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_SearchTask_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_SearchTask_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_SearchTask_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_Session_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_Session_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_Session_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_Session_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_Session_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_Session_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_settingkeybak_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_settingkeybak_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_settingkeybak_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_settingkeybak_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_settingkeybak_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_settingkeybak_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_SettingsCategory_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_SettingsCategory_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_SettingsCategory_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_SettingsCategory_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_SettingsCategory_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_SettingsCategory_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_SettingsKey_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_SettingsKey_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_SettingsKey_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_SettingsKey_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_SettingsKey_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_SettingsKey_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_Site_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_Site_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_Site_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_Site_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_Site_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_Site_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_SiteCulture_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_SiteCulture_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_SiteCulture_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_SiteCulture_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_SiteCulture_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_SiteCulture_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_SiteDomainAlias_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_SiteDomainAlias_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_SiteDomainAlias_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_SiteDomainAlias_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_SiteDomainAlias_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_SiteDomainAlias_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_SMTPServer_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_SMTPServer_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_SMTPServer_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_SMTPServer_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_SMTPServer_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_SMTPServer_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_SMTPServerSite_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_SMTPServerSite_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_SMTPServerSite_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_SMTPServerSite_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_SMTPServerSite_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_SMTPServerSite_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_State_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_State_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_State_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_State_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_State_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_State_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_Tag_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_Tag_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_Tag_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_Tag_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_Tag_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_Tag_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_TagGroup_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_TagGroup_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_TagGroup_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_TagGroup_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_TagGroup_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_TagGroup_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_TemplateDeviceLayout_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_TemplateDeviceLayout_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_TemplateDeviceLayout_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_TemplateDeviceLayout_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_TemplateDeviceLayout_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_TemplateDeviceLayout_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_TimeZone_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_TimeZone_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_TimeZone_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_TimeZone_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_TimeZone_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_TimeZone_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_Transformation_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_Transformation_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_Transformation_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_Transformation_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_Transformation_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_Transformation_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_TranslationService_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_TranslationService_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_TranslationService_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_TranslationService_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_TranslationService_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_TranslationService_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_TranslationSubmission_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_TranslationSubmission_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_TranslationSubmission_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_TranslationSubmission_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_TranslationSubmission_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_TranslationSubmission_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_TranslationSubmissionItem_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_TranslationSubmissionItem_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_TranslationSubmissionItem_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_TranslationSubmissionItem_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_TranslationSubmissionItem_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_TranslationSubmissionItem_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_Tree_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_Tree_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_Tree_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_Tree_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_Tree_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_Tree_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_UIElement_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_UIElement_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_UIElement_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_UIElement_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_UIElement_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_UIElement_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_cms_user_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_cms_user_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_cms_user_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_cms_user_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_cms_user_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_cms_user_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_UserCulture_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_UserCulture_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_UserCulture_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_UserCulture_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_UserCulture_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_UserCulture_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_UserRole_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_UserRole_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_UserRole_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_UserRole_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_UserRole_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_UserRole_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_cms_usersettings_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_cms_usersettings_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_cms_usersettings_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_cms_usersettings_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_cms_usersettings_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_cms_usersettings_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_cms_usersite_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_cms_usersite_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_cms_usersite_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_cms_usersite_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_cms_usersite_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_cms_usersite_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_VersionAttachment_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_VersionAttachment_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_VersionAttachment_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_VersionAttachment_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_VersionAttachment_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_VersionAttachment_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_VersionHistory_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_VersionHistory_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_VersionHistory_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_VersionHistory_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_VersionHistory_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_VersionHistory_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_WebFarmServer_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_WebFarmServer_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_WebFarmServer_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_WebFarmServer_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_WebFarmServer_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_WebFarmServer_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_WebFarmServerTask_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_WebFarmServerTask_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_WebFarmServerTask_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_WebFarmServerTask_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_WebFarmServerTask_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_WebFarmServerTask_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_WebFarmTask_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_WebFarmTask_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_WebFarmTask_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_WebFarmTask_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_WebFarmTask_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_WebFarmTask_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_WebPart_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_WebPart_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_WebPart_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_WebPart_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_WebPart_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_WebPart_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_WebPartCategory_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_WebPartCategory_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_WebPartCategory_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_WebPartCategory_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_WebPartCategory_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_WebPartCategory_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_WebPartContainer_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_WebPartContainer_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_WebPartContainer_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_WebPartContainer_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_WebPartContainer_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_WebPartContainer_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_WebPartContainerSite_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_WebPartContainerSite_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_WebPartContainerSite_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_WebPartContainerSite_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_WebPartContainerSite_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_WebPartContainerSite_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_WebPartLayout_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_WebPartLayout_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_WebPartLayout_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_WebPartLayout_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_WebPartLayout_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_WebPartLayout_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_WebTemplate_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_WebTemplate_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_WebTemplate_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_WebTemplate_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_WebTemplate_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_WebTemplate_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_Widget_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_Widget_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_Widget_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_Widget_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_Widget_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_Widget_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_WidgetCategory_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_WidgetCategory_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_WidgetCategory_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_WidgetCategory_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_WidgetCategory_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_WidgetCategory_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_WidgetRole_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_WidgetRole_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_WidgetRole_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_WidgetRole_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_WidgetRole_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_WidgetRole_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_Workflow_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_Workflow_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_Workflow_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_Workflow_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_Workflow_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_Workflow_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_WorkflowAction_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_WorkflowAction_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_WorkflowAction_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_WorkflowAction_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_WorkflowAction_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_WorkflowAction_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_WorkflowHistory_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_WorkflowHistory_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_WorkflowHistory_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_WorkflowHistory_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_WorkflowHistory_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_WorkflowHistory_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_WorkflowScope_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_WorkflowScope_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_WorkflowScope_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_WorkflowScope_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_WorkflowScope_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_WorkflowScope_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_WorkflowStep_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_WorkflowStep_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_WorkflowStep_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_WorkflowStep_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_WorkflowStep_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_WorkflowStep_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_WorkflowStepRoles_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_WorkflowStepRoles_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_WorkflowStepRoles_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_WorkflowStepRoles_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_WorkflowStepRoles_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_WorkflowStepRoles_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_WorkflowStepUser_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_WorkflowStepUser_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_WorkflowStepUser_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_WorkflowStepUser_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_WorkflowStepUser_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_WorkflowStepUser_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_WorkflowTransition_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_WorkflowTransition_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_WorkflowTransition_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_WorkflowTransition_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_WorkflowTransition_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_WorkflowTransition_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_WorkflowUser_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_WorkflowUser_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_WorkflowUser_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_WorkflowUser_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CMS_WorkflowUser_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CMS_WorkflowUser_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_coachExclusion_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_coachExclusion_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_coachExclusion_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_coachExclusion_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_coachExclusion_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_coachExclusion_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_Address_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_Address_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_Address_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_Address_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_Address_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_Address_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_Bundle_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_Bundle_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_Bundle_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_Bundle_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_Bundle_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_Bundle_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_Carrier_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_Carrier_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_Carrier_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_Carrier_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_Carrier_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_Carrier_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_CouponCode_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_CouponCode_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_CouponCode_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_CouponCode_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_CouponCode_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_CouponCode_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_Currency_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_Currency_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_Currency_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_Currency_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_Currency_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_Currency_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_CurrencyExchangeRate_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_CurrencyExchangeRate_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_CurrencyExchangeRate_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_CurrencyExchangeRate_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_CurrencyExchangeRate_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_CurrencyExchangeRate_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_Customer_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_Customer_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_Customer_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_Customer_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_Customer_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_Customer_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_CustomerCreditHistory_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_CustomerCreditHistory_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_CustomerCreditHistory_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_CustomerCreditHistory_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_CustomerCreditHistory_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_CustomerCreditHistory_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_Department_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_Department_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_Department_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_Department_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_Department_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_Department_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_DepartmentTaxClass_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_DepartmentTaxClass_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_DepartmentTaxClass_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_DepartmentTaxClass_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_DepartmentTaxClass_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_DepartmentTaxClass_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_Discount_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_Discount_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_Discount_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_Discount_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_Discount_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_Discount_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_DiscountCoupon_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_DiscountCoupon_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_DiscountCoupon_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_DiscountCoupon_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_DiscountCoupon_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_DiscountCoupon_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_ExchangeTable_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_ExchangeTable_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_ExchangeTable_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_ExchangeTable_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_ExchangeTable_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_ExchangeTable_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_InternalStatus_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_InternalStatus_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_InternalStatus_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_InternalStatus_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_InternalStatus_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_InternalStatus_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_Manufacturer_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_Manufacturer_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_Manufacturer_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_Manufacturer_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_Manufacturer_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_Manufacturer_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_MultiBuyCouponCode_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_MultiBuyCouponCode_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_MultiBuyCouponCode_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_MultiBuyCouponCode_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_MultiBuyCouponCode_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_MultiBuyCouponCode_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_MultiBuyDiscount_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_MultiBuyDiscount_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_MultiBuyDiscount_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_MultiBuyDiscount_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_MultiBuyDiscount_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_MultiBuyDiscount_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_MultiBuyDiscountDepartment_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_MultiBuyDiscountDepartment_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_MultiBuyDiscountDepartment_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_MultiBuyDiscountDepartment_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_MultiBuyDiscountDepartment_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_MultiBuyDiscountDepartment_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_MultiBuyDiscountSKU_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_MultiBuyDiscountSKU_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_MultiBuyDiscountSKU_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_MultiBuyDiscountSKU_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_MultiBuyDiscountSKU_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_MultiBuyDiscountSKU_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_OptionCategory_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_OptionCategory_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_OptionCategory_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_OptionCategory_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_OptionCategory_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_OptionCategory_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_Order_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_Order_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_Order_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_Order_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_Order_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_Order_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_OrderAddress_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_OrderAddress_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_OrderAddress_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_OrderAddress_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_OrderAddress_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_OrderAddress_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_OrderItem_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_OrderItem_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_OrderItem_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_OrderItem_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_OrderItem_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_OrderItem_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_OrderItemSKUFile_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_OrderItemSKUFile_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_OrderItemSKUFile_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_OrderItemSKUFile_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_OrderItemSKUFile_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_OrderItemSKUFile_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_OrderStatus_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_OrderStatus_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_OrderStatus_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_OrderStatus_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_OrderStatus_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_OrderStatus_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_OrderStatusUser_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_OrderStatusUser_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_OrderStatusUser_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_OrderStatusUser_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_OrderStatusUser_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_OrderStatusUser_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_PaymentOption_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_PaymentOption_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_PaymentOption_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_PaymentOption_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_PaymentOption_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_PaymentOption_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_PaymentShipping_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_PaymentShipping_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_PaymentShipping_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_PaymentShipping_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_PaymentShipping_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_PaymentShipping_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_PublicStatus_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_PublicStatus_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_PublicStatus_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_PublicStatus_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_PublicStatus_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_PublicStatus_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_ShippingCost_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_ShippingCost_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_ShippingCost_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_ShippingCost_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_ShippingCost_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_ShippingCost_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_ShippingOption_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_ShippingOption_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_ShippingOption_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_ShippingOption_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_ShippingOption_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_ShippingOption_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_ShippingOptionTaxClass_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_ShippingOptionTaxClass_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_ShippingOptionTaxClass_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_ShippingOptionTaxClass_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_ShippingOptionTaxClass_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_ShippingOptionTaxClass_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_ShoppingCart_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_ShoppingCart_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_ShoppingCart_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_ShoppingCart_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_ShoppingCart_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_ShoppingCart_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_ShoppingCartSKU_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_ShoppingCartSKU_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_ShoppingCartSKU_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_ShoppingCartSKU_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_ShoppingCartSKU_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_ShoppingCartSKU_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_SKU_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_SKU_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_SKU_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_SKU_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_SKU_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_SKU_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_SKUAllowedOption_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_SKUAllowedOption_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_SKUAllowedOption_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_SKUAllowedOption_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_SKUAllowedOption_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_SKUAllowedOption_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_SKUDiscountCoupon_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_SKUDiscountCoupon_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_SKUDiscountCoupon_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_SKUDiscountCoupon_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_SKUDiscountCoupon_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_SKUDiscountCoupon_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_SKUFile_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_SKUFile_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_SKUFile_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_SKUFile_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_SKUFile_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_SKUFile_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_SKUOptionCategory_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_SKUOptionCategory_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_SKUOptionCategory_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_SKUOptionCategory_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_SKUOptionCategory_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_SKUOptionCategory_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_SKUTaxClasses_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_SKUTaxClasses_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_SKUTaxClasses_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_SKUTaxClasses_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_SKUTaxClasses_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_SKUTaxClasses_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_Supplier_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_Supplier_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_Supplier_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_Supplier_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_Supplier_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_Supplier_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_TaxClass_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_TaxClass_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_TaxClass_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_TaxClass_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_TaxClass_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_TaxClass_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_TaxClassCountry_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_TaxClassCountry_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_TaxClassCountry_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_TaxClassCountry_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_TaxClassCountry_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_TaxClassCountry_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_TaxClassState_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_TaxClassState_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_TaxClassState_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_TaxClassState_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_TaxClassState_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_TaxClassState_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_UserDepartment_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_UserDepartment_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_UserDepartment_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_UserDepartment_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_UserDepartment_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_UserDepartment_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_VariantOption_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_VariantOption_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_VariantOption_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_VariantOption_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_VariantOption_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_VariantOption_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_VolumeDiscount_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_VolumeDiscount_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_VolumeDiscount_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_VolumeDiscount_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_VolumeDiscount_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_VolumeDiscount_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_Wishlist_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_Wishlist_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_Wishlist_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_Wishlist_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_COM_Wishlist_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_COM_Wishlist_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_Community_Friend_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_Community_Friend_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_Community_Friend_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_Community_Friend_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_Community_Friend_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_Community_Friend_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_Community_Group_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_Community_Group_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_Community_Group_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_Community_Group_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_Community_Group_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_Community_Group_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_Community_GroupMember_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_Community_GroupMember_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_Community_GroupMember_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_Community_GroupMember_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_Community_GroupMember_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_Community_GroupMember_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_Community_GroupRolePermission_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_Community_GroupRolePermission_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_Community_GroupRolePermission_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_Community_GroupRolePermission_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_Community_GroupRolePermission_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_Community_GroupRolePermission_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_Community_Invitation_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_Community_Invitation_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_Community_Invitation_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_Community_Invitation_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_Community_Invitation_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_Community_Invitation_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CT_VersionTracking_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CT_VersionTracking_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_CT_VersionTracking_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_CT_VersionTracking_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_EDW_BiometricViewRejectCriteria_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_EDW_BiometricViewRejectCriteria_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_EDW_BiometricViewRejectCriteria_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_EDW_BiometricViewRejectCriteria_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_EDW_BiometricViewRejectCriteria_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_EDW_BiometricViewRejectCriteria_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_EDW_GroupMemberHistory_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_EDW_GroupMemberHistory_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_EDW_GroupMemberHistory_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_EDW_GroupMemberHistory_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_EDW_GroupMemberHistory_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_EDW_GroupMemberHistory_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_EDW_GroupMemberToday_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_EDW_GroupMemberToday_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_EDW_GroupMemberToday_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_EDW_GroupMemberToday_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_EDW_GroupMemberToday_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_EDW_GroupMemberToday_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_EDW_HealthAssessment_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_EDW_HealthAssessment_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_EDW_HealthAssessment_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_EDW_HealthAssessment_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_EDW_HealthAssessment_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_EDW_HealthAssessment_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_EDW_HealthAssessmentDefinition_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_EDW_HealthAssessmentDefinition_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_EDW_HealthAssessmentDefinition_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_EDW_HealthAssessmentDefinition_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_EDW_HealthAssessmentDefinition_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_EDW_HealthAssessmentDefinition_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_EDW_PerformanceMeasure_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_EDW_PerformanceMeasure_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_EDW_PerformanceMeasure_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_EDW_PerformanceMeasure_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_EDW_PerformanceMeasure_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_EDW_PerformanceMeasure_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_EDW_RoleMemberHistory_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_EDW_RoleMemberHistory_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_EDW_RoleMemberHistory_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_EDW_RoleMemberHistory_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_EDW_RoleMemberHistory_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_EDW_RoleMemberHistory_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_EDW_RoleMembership_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_EDW_RoleMembership_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_EDW_RoleMembership_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_EDW_RoleMembership_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_EDW_RoleMembership_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_EDW_RoleMembership_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_EDW_RoleMemberToday_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_EDW_RoleMemberToday_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_EDW_RoleMemberToday_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_EDW_RoleMemberToday_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_EDW_RoleMemberToday_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_EDW_RoleMemberToday_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFIT_Account_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFIT_Account_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFIT_Account_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFIT_Account_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFIT_Account_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFIT_Account_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_Announcements_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_Announcements_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_Announcements_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_Announcements_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_Announcements_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_Announcements_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_BiometricData_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_BiometricData_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_BiometricData_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_BiometricData_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_BiometricData_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_BiometricData_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_Blurb_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_Blurb_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_Blurb_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_Blurb_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_Blurb_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_Blurb_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_Calculator_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_Calculator_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_Calculator_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_Calculator_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_Calculator_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_Calculator_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_CallList_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_CallList_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_CallList_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_CallList_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_CallList_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_CallList_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_CentralConfig_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_CentralConfig_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_CentralConfig_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_CentralConfig_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_CentralConfig_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_CentralConfig_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_hfit_challenge_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_hfit_challenge_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_hfit_challenge_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_hfit_challenge_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_hfit_challenge_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_hfit_challenge_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_hfit_ChallengeAbout_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_hfit_ChallengeAbout_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_hfit_ChallengeAbout_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_hfit_ChallengeAbout_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_hfit_ChallengeAbout_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_hfit_ChallengeAbout_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_hfit_challengeBase_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_hfit_challengeBase_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_hfit_challengeBase_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_hfit_challengeBase_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_hfit_challengeBase_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_hfit_challengeBase_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_hfit_ChallengeFAQ_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_hfit_ChallengeFAQ_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_hfit_ChallengeFAQ_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_hfit_ChallengeFAQ_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_hfit_ChallengeFAQ_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_hfit_ChallengeFAQ_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_hfit_challengeGeneralSettings_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_hfit_challengeGeneralSettings_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_hfit_challengeGeneralSettings_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_hfit_challengeGeneralSettings_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_hfit_challengeGeneralSettings_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_hfit_challengeGeneralSettings_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_ChallengeNewsletter_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_ChallengeNewsletter_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_ChallengeNewsletter_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_ChallengeNewsletter_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_ChallengeNewsletter_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_ChallengeNewsletter_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_ChallengeNewsletterRelationship_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_ChallengeNewsletterRelationship_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_ChallengeNewsletterRelationship_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_ChallengeNewsletterRelationship_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_ChallengeNewsletterRelationship_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_ChallengeNewsletterRelationship_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_hfit_challengeOffering_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_hfit_challengeOffering_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_hfit_challengeOffering_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_hfit_challengeOffering_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_hfit_challengeOffering_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_hfit_challengeOffering_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_ChallengePostTemplate_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_ChallengePostTemplate_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_ChallengePostTemplate_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_ChallengePostTemplate_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_ChallengePostTemplate_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_ChallengePostTemplate_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_ChallengePPTEligibleCDPostTemplate_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_ChallengePPTEligibleCDPostTemplate_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_ChallengePPTEligibleCDPostTemplate_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_ChallengePPTEligibleCDPostTemplate_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_ChallengePPTEligibleCDPostTemplate_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_ChallengePPTEligibleCDPostTemplate_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_hFit_ChallengePPTEligiblePostTemplate_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_hFit_ChallengePPTEligiblePostTemplate_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_hFit_ChallengePPTEligiblePostTemplate_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_hFit_ChallengePPTEligiblePostTemplate_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_hFit_ChallengePPTEligiblePostTemplate_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_hFit_ChallengePPTEligiblePostTemplate_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_ChallengePPTRegisteredPostTemplate_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_ChallengePPTRegisteredPostTemplate_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_ChallengePPTRegisteredPostTemplate_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_ChallengePPTRegisteredPostTemplate_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_ChallengePPTRegisteredPostTemplate_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_ChallengePPTRegisteredPostTemplate_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_ChallengePPTRegisteredRDPostTemplate_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_ChallengePPTRegisteredRDPostTemplate_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_ChallengePPTRegisteredRDPostTemplate_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_ChallengePPTRegisteredRDPostTemplate_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_ChallengePPTRegisteredRDPostTemplate_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_ChallengePPTRegisteredRDPostTemplate_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_ChallengeRegistrationEmail_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_ChallengeRegistrationEmail_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_ChallengeRegistrationEmail_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_ChallengeRegistrationEmail_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_ChallengeRegistrationEmail_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_ChallengeRegistrationEmail_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_ChallengeRegistrationPostTemplate_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_ChallengeRegistrationPostTemplate_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_ChallengeRegistrationPostTemplate_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_ChallengeRegistrationPostTemplate_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_ChallengeRegistrationPostTemplate_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_ChallengeRegistrationPostTemplate_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_ChallengeRegistrations_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_ChallengeRegistrations_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_ChallengeRegistrations_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_ChallengeRegistrations_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_ChallengeRegistrations_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_ChallengeRegistrations_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_ChallengeRegistrationSettings_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_ChallengeRegistrationSettings_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_ChallengeRegistrationSettings_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_ChallengeRegistrationSettings_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_ChallengeRegistrationSettings_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_ChallengeRegistrationSettings_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_ChallengeRegistrationTempData_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_ChallengeRegistrationTempData_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_ChallengeRegistrationTempData_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_ChallengeRegistrationTempData_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_ChallengeRegistrationTempData_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_ChallengeRegistrationTempData_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_hfit_ChallengeTeam_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_hfit_ChallengeTeam_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_hfit_ChallengeTeam_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_hfit_ChallengeTeam_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_hfit_ChallengeTeam_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_hfit_ChallengeTeam_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_hfit_ChallengeTeams_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_hfit_ChallengeTeams_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_hfit_ChallengeTeams_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_hfit_ChallengeTeams_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_hfit_ChallengeTeams_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_hfit_ChallengeTeams_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_hfit_challengeTypes_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_hfit_challengeTypes_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_hfit_challengeTypes_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_hfit_challengeTypes_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_hfit_challengeTypes_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_hfit_challengeTypes_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_ChallengeUserRegistration_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_ChallengeUserRegistration_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_ChallengeUserRegistration_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_ChallengeUserRegistration_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_ChallengeUserRegistration_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_ChallengeUserRegistration_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_Class_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_Class_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_Class_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_Class_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_Class_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_Class_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_ClassType_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_ClassType_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_ClassType_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_ClassType_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_ClassType_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_ClassType_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_Hfit_Client_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_Hfit_Client_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_Hfit_Client_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_Hfit_Client_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_Hfit_Client_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_Hfit_Client_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_ClientContact_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_ClientContact_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_ClientContact_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_ClientContact_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_ClientContact_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_ClientContact_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_Hfit_ClientDeviceSuspensionLog_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_Hfit_ClientDeviceSuspensionLog_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_Hfit_ClientDeviceSuspensionLog_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_Hfit_ClientDeviceSuspensionLog_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_Hfit_ClientDeviceSuspensionLog_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_Hfit_ClientDeviceSuspensionLog_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_ClientSecurityQuestions_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_ClientSecurityQuestions_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_ClientSecurityQuestions_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_ClientSecurityQuestions_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_ClientSecurityQuestions_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_ClientSecurityQuestions_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_CMS_User_CHANGES_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_CMS_User_CHANGES_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_CMS_User_CHANGES_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_CMS_User_CHANGES_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_CMS_User_CHANGES_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_CMS_User_CHANGES_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_Coaches_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_Coaches_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_Coaches_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_Coaches_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_Coaches_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_Coaches_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_CoachingAuditLog_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_CoachingAuditLog_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_CoachingAuditLog_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_CoachingAuditLog_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_CoachingAuditLog_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_CoachingAuditLog_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_CoachingCallLogTemporalContainer_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_CoachingCallLogTemporalContainer_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_CoachingCallLogTemporalContainer_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_CoachingCallLogTemporalContainer_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_CoachingCallLogTemporalContainer_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_CoachingCallLogTemporalContainer_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_hfit_CoachingCMTemporalContainer_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_hfit_CoachingCMTemporalContainer_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_hfit_CoachingCMTemporalContainer_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_hfit_CoachingCMTemporalContainer_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_hfit_CoachingCMTemporalContainer_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_hfit_CoachingCMTemporalContainer_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_CoachingCommitToQuit_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_CoachingCommitToQuit_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_CoachingCommitToQuit_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_CoachingCommitToQuit_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_CoachingCommitToQuit_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_CoachingCommitToQuit_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_CoachingEnrollmentReport_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_CoachingEnrollmentReport_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_CoachingEnrollmentReport_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_CoachingEnrollmentReport_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_CoachingEnrollmentReport_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_CoachingEnrollmentReport_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_CoachingEnrollmentSettings_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_CoachingEnrollmentSettings_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_CoachingEnrollmentSettings_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_CoachingEnrollmentSettings_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_CoachingEnrollmentSettings_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_CoachingEnrollmentSettings_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_CoachingEnrollmentSyncStaging_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_CoachingEnrollmentSyncStaging_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_CoachingEnrollmentSyncStaging_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_CoachingEnrollmentSyncStaging_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_CoachingEnrollmentSyncStaging_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_CoachingEnrollmentSyncStaging_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_CoachingEvalHAOverall_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_CoachingEvalHAOverall_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_CoachingEvalHAOverall_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_CoachingEvalHAOverall_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_CoachingEvalHAOverall_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_CoachingEvalHAOverall_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_CoachingEvalHAQA_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_CoachingEvalHAQA_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_CoachingEvalHAQA_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_CoachingEvalHAQA_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_CoachingEvalHAQA_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_CoachingEvalHAQA_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_CoachingEvalHARiskArea_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_CoachingEvalHARiskArea_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_CoachingEvalHARiskArea_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_CoachingEvalHARiskArea_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_CoachingEvalHARiskArea_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_CoachingEvalHARiskArea_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_CoachingEvalHARiskCategory_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_CoachingEvalHARiskCategory_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_CoachingEvalHARiskCategory_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_CoachingEvalHARiskCategory_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_CoachingEvalHARiskCategory_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_CoachingEvalHARiskCategory_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_CoachingEvalHARiskModule_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_CoachingEvalHARiskModule_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_CoachingEvalHARiskModule_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_CoachingEvalHARiskModule_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_CoachingEvalHARiskModule_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_CoachingEvalHARiskModule_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_CoachingGetStarted_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_CoachingGetStarted_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_CoachingGetStarted_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_CoachingGetStarted_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_CoachingGetStarted_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_CoachingGetStarted_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_CoachingHATemporalContainer_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_CoachingHATemporalContainer_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_CoachingHATemporalContainer_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_CoachingHATemporalContainer_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_CoachingHATemporalContainer_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_CoachingHATemporalContainer_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_CoachingHealthActionPlan_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_CoachingHealthActionPlan_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_CoachingHealthActionPlan_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_CoachingHealthActionPlan_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_CoachingHealthActionPlan_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_CoachingHealthActionPlan_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_CoachingHealthArea_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_CoachingHealthArea_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_CoachingHealthArea_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_CoachingHealthArea_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_CoachingHealthArea_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_CoachingHealthArea_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_CoachingHealthInterest_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_CoachingHealthInterest_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_CoachingHealthInterest_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_CoachingHealthInterest_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_CoachingHealthInterest_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_CoachingHealthInterest_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_CoachingLibraryHealthArea_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_CoachingLibraryHealthArea_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_CoachingLibraryHealthArea_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_CoachingLibraryHealthArea_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_CoachingLibraryHealthArea_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_CoachingLibraryHealthArea_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_CoachingLibraryResource_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_CoachingLibraryResource_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_CoachingLibraryResource_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_CoachingLibraryResource_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_CoachingLibraryResource_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_CoachingLibraryResource_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_CoachingLibraryResources_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_CoachingLibraryResources_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_CoachingLibraryResources_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_CoachingLibraryResources_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_CoachingLibraryResources_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_CoachingLibraryResources_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_CoachingLibrarySettings_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_CoachingLibrarySettings_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_CoachingLibrarySettings_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_CoachingLibrarySettings_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_CoachingLibrarySettings_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_CoachingLibrarySettings_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_CoachingLMTemporalContainer_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_CoachingLMTemporalContainer_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_CoachingLMTemporalContainer_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_CoachingLMTemporalContainer_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_CoachingLMTemporalContainer_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_CoachingLMTemporalContainer_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_CoachingMyGoalsSettings_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_CoachingMyGoalsSettings_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_CoachingMyGoalsSettings_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_CoachingMyGoalsSettings_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_CoachingMyGoalsSettings_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_CoachingMyGoalsSettings_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_CoachingMyHealthInterestsSettings_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_CoachingMyHealthInterestsSettings_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_CoachingMyHealthInterestsSettings_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_CoachingMyHealthInterestsSettings_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_CoachingMyHealthInterestsSettings_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_CoachingMyHealthInterestsSettings_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_CoachingNotAssignedSettings_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_CoachingNotAssignedSettings_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_CoachingNotAssignedSettings_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_CoachingNotAssignedSettings_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_CoachingNotAssignedSettings_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_CoachingNotAssignedSettings_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_CoachingPrivacyPolicy_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_CoachingPrivacyPolicy_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_CoachingPrivacyPolicy_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_CoachingPrivacyPolicy_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_CoachingPrivacyPolicy_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_CoachingPrivacyPolicy_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_CoachingSessionCompleted_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_CoachingSessionCompleted_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_CoachingSessionCompleted_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_CoachingSessionCompleted_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_CoachingSessionCompleted_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_CoachingSessionCompleted_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_Hfit_CoachingSystemSettings_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_Hfit_CoachingSystemSettings_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_Hfit_CoachingSystemSettings_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_Hfit_CoachingSystemSettings_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_Hfit_CoachingSystemSettings_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_Hfit_CoachingSystemSettings_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_CoachingTermsAndConditionsSettings_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_CoachingTermsAndConditionsSettings_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_CoachingTermsAndConditionsSettings_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_CoachingTermsAndConditionsSettings_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_CoachingTermsAndConditionsSettings_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_CoachingTermsAndConditionsSettings_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_Hfit_CoachingUserCMCondition_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_Hfit_CoachingUserCMCondition_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_Hfit_CoachingUserCMCondition_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_Hfit_CoachingUserCMCondition_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_Hfit_CoachingUserCMCondition_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_Hfit_CoachingUserCMCondition_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_Hfit_CoachingUserCMExclusion_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_Hfit_CoachingUserCMExclusion_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_Hfit_CoachingUserCMExclusion_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_Hfit_CoachingUserCMExclusion_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_Hfit_CoachingUserCMExclusion_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_Hfit_CoachingUserCMExclusion_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_CoachingUserServiceLevel_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_CoachingUserServiceLevel_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_CoachingUserServiceLevel_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_CoachingUserServiceLevel_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_CoachingUserServiceLevel_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_CoachingUserServiceLevel_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_CoachingWelcomeSettings_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_CoachingWelcomeSettings_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_CoachingWelcomeSettings_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_CoachingWelcomeSettings_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_CoachingWelcomeSettings_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_CoachingWelcomeSettings_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_Company_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_Company_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_Company_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_Company_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_Company_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_Company_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_configFeatures_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_configFeatures_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_configFeatures_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_configFeatures_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_configFeatures_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_configFeatures_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_configGroupToFeature_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_configGroupToFeature_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_configGroupToFeature_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_configGroupToFeature_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_configGroupToFeature_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_configGroupToFeature_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_Configuration_CallLogCoaching_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_Configuration_CallLogCoaching_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_Configuration_CallLogCoaching_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_Configuration_CallLogCoaching_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_Configuration_CallLogCoaching_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_Configuration_CallLogCoaching_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFIT_Configuration_CMCoaching_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFIT_Configuration_CMCoaching_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFIT_Configuration_CMCoaching_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFIT_Configuration_CMCoaching_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFIT_Configuration_CMCoaching_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFIT_Configuration_CMCoaching_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFIT_Configuration_HACoaching_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFIT_Configuration_HACoaching_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFIT_Configuration_HACoaching_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFIT_Configuration_HACoaching_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFIT_Configuration_HACoaching_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFIT_Configuration_HACoaching_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_Configuration_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_Configuration_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_Configuration_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_Configuration_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_Configuration_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_Configuration_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_Configuration_LMCoaching_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_Configuration_LMCoaching_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_Configuration_LMCoaching_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_Configuration_LMCoaching_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_Configuration_LMCoaching_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_Configuration_LMCoaching_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFIT_Configuration_Screening_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFIT_Configuration_Screening_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFIT_Configuration_Screening_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFIT_Configuration_Screening_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFIT_Configuration_Screening_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFIT_Configuration_Screening_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_ConsentAndRelease_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_ConsentAndRelease_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_ConsentAndRelease_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_ConsentAndRelease_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_ConsentAndRelease_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_ConsentAndRelease_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_ConsentAndReleaseAgreement_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_ConsentAndReleaseAgreement_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_ConsentAndReleaseAgreement_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_ConsentAndReleaseAgreement_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_ConsentAndReleaseAgreement_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_ConsentAndReleaseAgreement_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_ContactGroupMembership_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_ContactGroupMembership_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_ContactGroupMembership_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_ContactGroupMembership_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_ContactGroupMembership_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_ContactGroupMembership_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_ContactGroupSyncExclude_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_ContactGroupSyncExclude_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_ContactGroupSyncExclude_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_ContactGroupSyncExclude_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_ContactGroupSyncExclude_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_ContactGroupSyncExclude_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_ContentBlock_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_ContentBlock_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_ContentBlock_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_ContentBlock_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_ContentBlock_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_ContentBlock_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_CustomSettingsTemporalContainer_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_CustomSettingsTemporalContainer_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_CustomSettingsTemporalContainer_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_CustomSettingsTemporalContainer_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_CustomSettingsTemporalContainer_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_CustomSettingsTemporalContainer_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_DataEntry_Clinical_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_DataEntry_Clinical_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_DataEntry_Clinical_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_DataEntry_Clinical_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_DataEntry_Clinical_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_DataEntry_Clinical_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_EligibilityLoadTracking_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_EligibilityLoadTracking_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_EligibilityLoadTracking_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_EligibilityLoadTracking_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_EligibilityLoadTracking_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_EligibilityLoadTracking_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_EmailTemplate_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_EmailTemplate_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_EmailTemplate_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_EmailTemplate_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_EmailTemplate_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_EmailTemplate_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_Event_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_Event_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_Event_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_Event_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_Event_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_Event_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_EventType_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_EventType_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_EventType_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_EventType_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_EventType_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_EventType_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_FooterAdministration_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_FooterAdministration_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_FooterAdministration_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_FooterAdministration_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_FooterAdministration_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_FooterAdministration_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_Fulfillment_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_Fulfillment_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_Fulfillment_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_Fulfillment_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_Fulfillment_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_Fulfillment_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_FulfillmentCodes_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_FulfillmentCodes_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_FulfillmentCodes_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_FulfillmentCodes_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_FulfillmentCodes_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_FulfillmentCodes_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_Goal_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_Goal_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_Goal_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_Goal_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_Goal_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_Goal_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_GoalCategory_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_GoalCategory_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_GoalCategory_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_GoalCategory_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_GoalCategory_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_GoalCategory_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_GoalOutcome_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_GoalOutcome_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_GoalOutcome_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_GoalOutcome_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_GoalOutcome_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_GoalOutcome_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_GoalSubCategory_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_GoalSubCategory_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_GoalSubCategory_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_GoalSubCategory_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_GoalSubCategory_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_GoalSubCategory_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_GroupAddUsers_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_GroupAddUsers_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_GroupAddUsers_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_GroupAddUsers_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_GroupAddUsers_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_GroupAddUsers_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_GroupRebuildSchedule_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_GroupRebuildSchedule_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_GroupRebuildSchedule_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_GroupRebuildSchedule_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_GroupRebuildSchedule_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_GroupRebuildSchedule_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_GroupRemovedUsers_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_GroupRemovedUsers_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_GroupRemovedUsers_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_GroupRemovedUsers_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_GroupRemovedUsers_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_GroupRemovedUsers_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HA_IPadExceptionLog_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HA_IPadExceptionLog_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HA_IPadExceptionLog_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HA_IPadExceptionLog_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HA_IPadExceptionLog_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HA_IPadExceptionLog_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HA_IPadLog_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HA_IPadLog_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HA_IPadLog_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HA_IPadLog_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HA_IPadLog_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HA_IPadLog_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HA_UseAndDisclosure_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HA_UseAndDisclosure_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HA_UseAndDisclosure_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HA_UseAndDisclosure_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HA_UseAndDisclosure_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HA_UseAndDisclosure_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HAAgreement_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HAAgreement_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HAAgreement_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HAAgreement_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HAAgreement_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HAAgreement_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HACampaign_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HACampaign_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HACampaign_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HACampaign_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HACampaign_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HACampaign_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_Hfit_HACampaigns_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_Hfit_HACampaigns_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_Hfit_HACampaigns_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_Hfit_HACampaigns_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_Hfit_HACampaigns_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_Hfit_HACampaigns_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_Hfit_HAHealthCheckCampaignData_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_Hfit_HAHealthCheckCampaignData_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_Hfit_HAHealthCheckCampaignData_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_Hfit_HAHealthCheckCampaignData_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_Hfit_HAHealthCheckCampaignData_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_Hfit_HAHealthCheckCampaignData_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_Hfit_HAHealthCheckCodes_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_Hfit_HAHealthCheckCodes_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_Hfit_HAHealthCheckCodes_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_Hfit_HAHealthCheckCodes_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_Hfit_HAHealthCheckCodes_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_Hfit_HAHealthCheckCodes_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_Hfit_HAHealthCheckLog_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_Hfit_HAHealthCheckLog_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_Hfit_HAHealthCheckLog_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_Hfit_HAHealthCheckLog_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_Hfit_HAHealthCheckLog_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_Hfit_HAHealthCheckLog_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HaScoringStrategies_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HaScoringStrategies_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HaScoringStrategies_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HaScoringStrategies_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HaScoringStrategies_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HaScoringStrategies_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HAWelcomeSettings_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HAWelcomeSettings_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HAWelcomeSettings_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HAWelcomeSettings_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HAWelcomeSettings_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HAWelcomeSettings_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAdvisingSessionCompleted_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAdvisingSessionCompleted_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAdvisingSessionCompleted_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAdvisingSessionCompleted_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAdvisingSessionCompleted_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAdvisingSessionCompleted_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssesmentAnswerCodeNames_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssesmentAnswerCodeNames_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssesmentAnswerCodeNames_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssesmentAnswerCodeNames_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssesmentAnswerCodeNames_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssesmentAnswerCodeNames_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssesmentAnswers_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssesmentAnswers_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssesmentAnswers_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssesmentAnswers_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssesmentAnswers_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssesmentAnswers_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssesmentMatrixQuestion_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssesmentMatrixQuestion_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssesmentMatrixQuestion_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssesmentMatrixQuestion_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssesmentMatrixQuestion_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssesmentMatrixQuestion_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssesmentModule_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssesmentModule_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssesmentModule_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssesmentModule_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssesmentModule_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssesmentModule_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssesmentModuleCodeNames_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssesmentModuleCodeNames_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssesmentModuleCodeNames_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssesmentModuleCodeNames_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssesmentModuleCodeNames_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssesmentModuleCodeNames_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssesmentMultipleChoiceQuestion_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssesmentMultipleChoiceQuestion_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssesmentMultipleChoiceQuestion_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssesmentMultipleChoiceQuestion_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssesmentMultipleChoiceQuestion_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssesmentMultipleChoiceQuestion_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssesmentPhysicalActivityScoring_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssesmentPhysicalActivityScoring_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssesmentPhysicalActivityScoring_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssesmentPhysicalActivityScoring_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssesmentPhysicalActivityScoring_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssesmentPhysicalActivityScoring_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssesmentPredefinedAnswer_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssesmentPredefinedAnswer_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssesmentPredefinedAnswer_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssesmentPredefinedAnswer_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssesmentPredefinedAnswer_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssesmentPredefinedAnswer_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssesmentQuestionCodeNames_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssesmentQuestionCodeNames_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssesmentQuestionCodeNames_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssesmentQuestionCodeNames_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssesmentQuestionCodeNames_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssesmentQuestionCodeNames_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssesmentQuestionGroupCodeNames_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssesmentQuestionGroupCodeNames_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssesmentQuestionGroupCodeNames_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssesmentQuestionGroupCodeNames_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssesmentQuestionGroupCodeNames_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssesmentQuestionGroupCodeNames_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssesmentRecomendationClientConfig_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssesmentRecomendationClientConfig_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssesmentRecomendationClientConfig_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssesmentRecomendationClientConfig_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssesmentRecomendationClientConfig_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssesmentRecomendationClientConfig_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssesmentRecomendations_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssesmentRecomendations_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssesmentRecomendations_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssesmentRecomendations_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssesmentRecomendations_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssesmentRecomendations_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssesmentRecomendationTypes_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssesmentRecomendationTypes_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssesmentRecomendationTypes_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssesmentRecomendationTypes_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssesmentRecomendationTypes_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssesmentRecomendationTypes_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssesmentRiskArea_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssesmentRiskArea_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssesmentRiskArea_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssesmentRiskArea_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssesmentRiskArea_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssesmentRiskArea_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssesmentRiskAreaCodeNames_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssesmentRiskAreaCodeNames_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssesmentRiskAreaCodeNames_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssesmentRiskAreaCodeNames_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssesmentRiskAreaCodeNames_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssesmentRiskAreaCodeNames_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssesmentRiskCategory_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssesmentRiskCategory_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssesmentRiskCategory_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssesmentRiskCategory_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssesmentRiskCategory_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssesmentRiskCategory_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssesmentRiskCategoryCodeNames_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssesmentRiskCategoryCodeNames_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssesmentRiskCategoryCodeNames_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssesmentRiskCategoryCodeNames_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssesmentRiskCategoryCodeNames_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssesmentRiskCategoryCodeNames_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssesmentStarted_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssesmentStarted_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssesmentStarted_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssesmentStarted_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssesmentStarted_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssesmentStarted_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssesmentThresholdGrouping_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssesmentThresholdGrouping_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssesmentThresholdGrouping_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssesmentThresholdGrouping_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssesmentThresholdGrouping_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssesmentThresholdGrouping_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssesmentThresholds_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssesmentThresholds_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssesmentThresholds_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssesmentThresholds_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssesmentThresholds_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssesmentThresholds_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssesmentThresholdTypes_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssesmentThresholdTypes_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssesmentThresholdTypes_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssesmentThresholdTypes_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssesmentThresholdTypes_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssesmentThresholdTypes_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssesmentUserAnswers_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssesmentUserAnswers_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssesmentUserAnswers_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssesmentUserAnswers_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssesmentUserAnswers_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssesmentUserAnswers_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssesmentUserModule_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssesmentUserModule_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssesmentUserModule_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssesmentUserModule_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssesmentUserModule_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssesmentUserModule_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssesmentUserQuestion_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssesmentUserQuestion_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssesmentUserQuestion_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssesmentUserQuestion_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssesmentUserQuestion_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssesmentUserQuestion_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssesmentUserQuestionGroupResults_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssesmentUserQuestionGroupResults_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssesmentUserQuestionGroupResults_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssesmentUserQuestionGroupResults_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssesmentUserQuestionGroupResults_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssesmentUserQuestionGroupResults_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssesmentUserQuestionImport_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssesmentUserQuestionImport_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssesmentUserQuestionImport_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssesmentUserQuestionImport_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssesmentUserQuestionImport_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssesmentUserQuestionImport_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssesmentUserQuestionStaging_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssesmentUserQuestionStaging_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssesmentUserQuestionStaging_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssesmentUserQuestionStaging_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssesmentUserQuestionStaging_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssesmentUserQuestionStaging_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssesmentUserRiskArea_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssesmentUserRiskArea_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssesmentUserRiskArea_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssesmentUserRiskArea_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssesmentUserRiskArea_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssesmentUserRiskArea_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssesmentUserRiskCategory_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssesmentUserRiskCategory_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssesmentUserRiskCategory_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssesmentUserRiskCategory_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssesmentUserRiskCategory_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssesmentUserRiskCategory_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssesmentUserStarted_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssesmentUserStarted_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssesmentUserStarted_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssesmentUserStarted_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssesmentUserStarted_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssesmentUserStarted_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssessment_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssessment_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssessment_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssessment_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssessment_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssessment_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssessmentBmiScoring_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssessmentBmiScoring_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssessmentBmiScoring_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssessmentBmiScoring_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssessmentBmiScoring_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssessmentBmiScoring_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssessmentCodeNamesToTrackerMapping_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssessmentCodeNamesToTrackerMapping_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssessmentCodeNamesToTrackerMapping_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssessmentCodeNamesToTrackerMapping_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssessmentCodeNamesToTrackerMapping_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssessmentCodeNamesToTrackerMapping_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssessmentConfiguration_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssessmentConfiguration_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssessmentConfiguration_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssessmentConfiguration_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssessmentConfiguration_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssessmentConfiguration_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_Hfit_HealthAssessmentDataForImport_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_Hfit_HealthAssessmentDataForImport_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_Hfit_HealthAssessmentDataForImport_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_Hfit_HealthAssessmentDataForImport_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_Hfit_HealthAssessmentDataForImport_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_Hfit_HealthAssessmentDataForImport_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssessmentDataForMissingResponses_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssessmentDataForMissingResponses_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssessmentDataForMissingResponses_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssessmentDataForMissingResponses_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssessmentDataForMissingResponses_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssessmentDataForMissingResponses_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssessmentDiasBpScoring_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssessmentDiasBpScoring_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssessmentDiasBpScoring_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssessmentDiasBpScoring_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssessmentDiasBpScoring_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssessmentDiasBpScoring_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssessmentFastingGlucoseScoring_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssessmentFastingGlucoseScoring_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssessmentFastingGlucoseScoring_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssessmentFastingGlucoseScoring_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssessmentFastingGlucoseScoring_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssessmentFastingGlucoseScoring_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssessmentFreeForm_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssessmentFreeForm_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssessmentFreeForm_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssessmentFreeForm_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssessmentFreeForm_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssessmentFreeForm_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssessmentHbA1cScoring_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssessmentHbA1cScoring_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssessmentHbA1cScoring_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssessmentHbA1cScoring_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssessmentHbA1cScoring_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssessmentHbA1cScoring_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssessmentHDLScoring_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssessmentHDLScoring_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssessmentHDLScoring_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssessmentHDLScoring_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssessmentHDLScoring_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssessmentHDLScoring_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssessmentImportStaging_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssessmentImportStaging_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssessmentImportStaging_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssessmentImportStaging_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssessmentImportStaging_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssessmentImportStaging_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssessmentImportStagingDetail_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssessmentImportStagingDetail_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssessmentImportStagingDetail_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssessmentImportStagingDetail_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssessmentImportStagingDetail_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssessmentImportStagingDetail_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssessmentImportStagingException_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssessmentImportStagingException_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssessmentImportStagingException_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssessmentImportStagingException_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssessmentImportStagingException_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssessmentImportStagingException_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssessmentImportStagingMaster_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssessmentImportStagingMaster_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssessmentImportStagingMaster_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssessmentImportStagingMaster_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssessmentImportStagingMaster_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssessmentImportStagingMaster_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssessmentLDLScoring_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssessmentLDLScoring_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssessmentLDLScoring_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssessmentLDLScoring_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssessmentLDLScoring_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssessmentLDLScoring_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssessmentModuleConfiguration_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssessmentModuleConfiguration_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssessmentModuleConfiguration_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssessmentModuleConfiguration_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssessmentModuleConfiguration_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssessmentModuleConfiguration_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssessmentNonFastingGlucoseScoring_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssessmentNonFastingGlucoseScoring_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssessmentNonFastingGlucoseScoring_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssessmentNonFastingGlucoseScoring_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssessmentNonFastingGlucoseScoring_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssessmentNonFastingGlucoseScoring_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssessmentPaperException_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssessmentPaperException_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssessmentPaperException_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssessmentPaperException_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssessmentPaperException_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssessmentPaperException_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssessmentSysBpScoring_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssessmentSysBpScoring_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssessmentSysBpScoring_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssessmentSysBpScoring_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssessmentSysBpScoring_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssessmentSysBpScoring_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssessmentTCHDLRatioScoring_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssessmentTCHDLRatioScoring_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssessmentTCHDLRatioScoring_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssessmentTCHDLRatioScoring_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssessmentTCHDLRatioScoring_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssessmentTCHDLRatioScoring_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssessmentTCScoring_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssessmentTCScoring_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssessmentTCScoring_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssessmentTCScoring_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssessmentTCScoring_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssessmentTCScoring_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssessmentTriglyceridesScoring_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssessmentTriglyceridesScoring_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssessmentTriglyceridesScoring_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssessmentTriglyceridesScoring_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthAssessmentTriglyceridesScoring_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthAssessmentTriglyceridesScoring_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthSummarySettings_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthSummarySettings_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthSummarySettings_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthSummarySettings_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HealthSummarySettings_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HealthSummarySettings_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HES_Award_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HES_Award_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HES_Award_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HES_Award_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HES_Award_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HES_Award_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HESChallenge_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HESChallenge_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HESChallenge_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HESChallenge_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HESChallenge_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HESChallenge_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HESChallengeTable_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HESChallengeTable_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HESChallengeTable_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HESChallengeTable_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HESChallengeTable_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HESChallengeTable_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HRA_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HRA_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HRA_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HRA_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HRA_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HRA_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HSAbout_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HSAbout_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HSAbout_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HSAbout_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HSAbout_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HSAbout_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HSBiometricChart_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HSBiometricChart_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HSBiometricChart_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HSBiometricChart_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HSBiometricChart_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HSBiometricChart_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HSGraphRangeSetting_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HSGraphRangeSetting_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HSGraphRangeSetting_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HSGraphRangeSetting_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HSGraphRangeSetting_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HSGraphRangeSetting_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HSHealthMeasuresSettings_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HSHealthMeasuresSettings_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HSHealthMeasuresSettings_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HSHealthMeasuresSettings_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HSHealthMeasuresSettings_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HSHealthMeasuresSettings_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HSLearnMoreDocument_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HSLearnMoreDocument_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HSLearnMoreDocument_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HSLearnMoreDocument_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_HSLearnMoreDocument_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_HSLearnMoreDocument_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_Join_ClinicalSourceTracker_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_Join_ClinicalSourceTracker_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_Join_ClinicalSourceTracker_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_Join_ClinicalSourceTracker_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_Join_ClinicalSourceTracker_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_Join_ClinicalSourceTracker_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_join_ClinicalTrackers_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_join_ClinicalTrackers_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_join_ClinicalTrackers_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_join_ClinicalTrackers_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_join_ClinicalTrackers_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_join_ClinicalTrackers_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_LKP_CallResult_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_LKP_CallResult_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_LKP_CallResult_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_LKP_CallResult_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_LKP_CallResult_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_LKP_CallResult_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_LKP_CardioActivityIntensity_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_LKP_CardioActivityIntensity_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_LKP_CardioActivityIntensity_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_LKP_CardioActivityIntensity_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_LKP_CardioActivityIntensity_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_LKP_CardioActivityIntensity_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_LKP_CoachingAuditLogType_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_LKP_CoachingAuditLogType_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_LKP_CoachingAuditLogType_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_LKP_CoachingAuditLogType_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_LKP_CoachingAuditLogType_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_LKP_CoachingAuditLogType_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_LKP_CoachingCMConditions_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_LKP_CoachingCMConditions_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_LKP_CoachingCMConditions_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_LKP_CoachingCMConditions_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_LKP_CoachingCMConditions_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_LKP_CoachingCMConditions_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_LKP_CoachingCMExclusions_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_LKP_CoachingCMExclusions_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_LKP_CoachingCMExclusions_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_LKP_CoachingCMExclusions_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_LKP_CoachingCMExclusions_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_LKP_CoachingCMExclusions_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_LKP_CoachingOptOutReason_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_LKP_CoachingOptOutReason_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_LKP_CoachingOptOutReason_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_LKP_CoachingOptOutReason_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_LKP_CoachingOptOutReason_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_LKP_CoachingOptOutReason_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_LKP_CoachingServiceLevel_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_LKP_CoachingServiceLevel_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_LKP_CoachingServiceLevel_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_LKP_CoachingServiceLevel_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_LKP_CoachingServiceLevel_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_LKP_CoachingServiceLevel_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_LKP_CoachingServiceLevelStatus_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_LKP_CoachingServiceLevelStatus_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_LKP_CoachingServiceLevelStatus_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_LKP_CoachingServiceLevelStatus_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_LKP_CoachingServiceLevelStatus_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_LKP_CoachingServiceLevelStatus_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_LKP_CoachViewTimeZone_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_LKP_CoachViewTimeZone_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_LKP_CoachViewTimeZone_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_LKP_CoachViewTimeZone_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_LKP_CoachViewTimeZone_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_LKP_CoachViewTimeZone_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_LKP_ContactGroupType_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_LKP_ContactGroupType_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_LKP_ContactGroupType_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_LKP_ContactGroupType_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_LKP_ContactGroupType_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_LKP_ContactGroupType_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_Hfit_LKP_CustomTrackerDefaultMetadata_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_Hfit_LKP_CustomTrackerDefaultMetadata_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_Hfit_LKP_CustomTrackerDefaultMetadata_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_Hfit_LKP_CustomTrackerDefaultMetadata_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_Hfit_LKP_CustomTrackerDefaultMetadata_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_Hfit_LKP_CustomTrackerDefaultMetadata_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFIT_LKP_EDW_REJECTMPI_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFIT_LKP_EDW_REJECTMPI_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_LKP_EDW_RejectMPI_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_LKP_EDW_RejectMPI_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_LKP_EDW_RejectMPI_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_LKP_EDW_RejectMPI_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_LKP_FastingState_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_LKP_FastingState_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_LKP_FastingState_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_LKP_FastingState_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_LKP_FastingState_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_LKP_FastingState_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_LKP_Frequency_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_LKP_Frequency_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_LKP_Frequency_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_LKP_Frequency_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_LKP_Frequency_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_LKP_Frequency_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_LKP_FulfillmentFeatures_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_LKP_FulfillmentFeatures_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_LKP_FulfillmentFeatures_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_LKP_FulfillmentFeatures_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_LKP_FulfillmentFeatures_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_LKP_FulfillmentFeatures_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_LKP_GoalCloseReason_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_LKP_GoalCloseReason_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_LKP_GoalCloseReason_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_LKP_GoalCloseReason_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_LKP_GoalCloseReason_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_LKP_GoalCloseReason_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_LKP_GoalStatus_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_LKP_GoalStatus_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_LKP_GoalStatus_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_LKP_GoalStatus_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_LKP_GoalStatus_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_LKP_GoalStatus_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_LKP_HealthAssessmentImportStatus_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_LKP_HealthAssessmentImportStatus_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_LKP_HealthAssessmentImportStatus_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_LKP_HealthAssessmentImportStatus_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_LKP_HealthAssessmentImportStatus_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_LKP_HealthAssessmentImportStatus_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_LKP_HES_AwardType_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_LKP_HES_AwardType_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_LKP_HES_AwardType_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_LKP_HES_AwardType_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_LKP_HES_AwardType_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_LKP_HES_AwardType_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_LKP_HES_ValueType_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_LKP_HES_ValueType_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_Hfit_LKP_NicotineAssessment_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_Hfit_LKP_NicotineAssessment_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_Hfit_LKP_NicotineAssessment_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_Hfit_LKP_NicotineAssessment_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_Hfit_LKP_NicotineAssessment_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_Hfit_LKP_NicotineAssessment_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_LKP_RewardActivity_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_LKP_RewardActivity_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_LKP_RewardActivity_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_LKP_RewardActivity_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_LKP_RewardActivity_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_LKP_RewardActivity_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_LKP_RewardCompleted_FIX_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_LKP_RewardCompleted_FIX_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_LKP_RewardCompleted_FIX_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_LKP_RewardCompleted_FIX_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_LKP_RewardCompleted_FIX_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_LKP_RewardCompleted_FIX_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_LKP_RewardCompleted_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_LKP_RewardCompleted_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_LKP_RewardCompleted_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_LKP_RewardCompleted_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_LKP_RewardCompleted_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_LKP_RewardCompleted_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_LKP_RewardFrequency_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_LKP_RewardFrequency_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_LKP_RewardFrequency_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_LKP_RewardFrequency_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_LKP_RewardFrequency_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_LKP_RewardFrequency_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_LKP_RewardGroupLevel_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_LKP_RewardGroupLevel_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_LKP_RewardGroupLevel_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_LKP_RewardGroupLevel_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_LKP_RewardGroupLevel_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_LKP_RewardGroupLevel_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_LKP_RewardLevel_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_LKP_RewardLevel_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_LKP_RewardLevel_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_LKP_RewardLevel_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_LKP_RewardLevel_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_LKP_RewardLevel_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_LKP_RewardLevelType_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_LKP_RewardLevelType_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_LKP_RewardLevelType_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_LKP_RewardLevelType_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_LKP_RewardLevelType_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_LKP_RewardLevelType_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_LKP_RewardTrigger_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_LKP_RewardTrigger_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_LKP_RewardTrigger_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_LKP_RewardTrigger_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_LKP_RewardTrigger_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_LKP_RewardTrigger_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_LKP_RewardTriggerParameter_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_LKP_RewardTriggerParameter_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_LKP_RewardTriggerParameter_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_LKP_RewardTriggerParameter_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_LKP_RewardTriggerParameter_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_LKP_RewardTriggerParameter_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_LKP_RewardTriggerParameterOperator_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_LKP_RewardTriggerParameterOperator_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_LKP_RewardTriggerParameterOperator_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_LKP_RewardTriggerParameterOperator_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_LKP_RewardTriggerParameterOperator_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_LKP_RewardTriggerParameterOperator_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_LKP_RewardType_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_LKP_RewardType_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_LKP_RewardType_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_LKP_RewardType_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_LKP_RewardType_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_LKP_RewardType_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_LKP_ScheduledNotificationDeliveryType_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_LKP_ScheduledNotificationDeliveryType_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_LKP_ScheduledNotificationDeliveryType_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_LKP_ScheduledNotificationDeliveryType_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_LKP_ScheduledNotificationDeliveryType_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_LKP_ScheduledNotificationDeliveryType_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_LKP_StressManagementActivity_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_LKP_StressManagementActivity_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_LKP_StressManagementActivity_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_LKP_StressManagementActivity_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_LKP_StressManagementActivity_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_LKP_StressManagementActivity_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_LKP_TrackerCardioActivity_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_LKP_TrackerCardioActivity_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_LKP_TrackerCardioActivity_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_LKP_TrackerCardioActivity_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_LKP_TrackerCardioActivity_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_LKP_TrackerCardioActivity_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_LKP_TrackerFlexibilityActivity_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_LKP_TrackerFlexibilityActivity_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_LKP_TrackerFlexibilityActivity_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_LKP_TrackerFlexibilityActivity_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_LKP_TrackerFlexibilityActivity_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_LKP_TrackerFlexibilityActivity_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_LKP_TrackerSleepPlanTechniques_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_LKP_TrackerSleepPlanTechniques_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_LKP_TrackerSleepPlanTechniques_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_LKP_TrackerSleepPlanTechniques_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_LKP_TrackerSleepPlanTechniques_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_LKP_TrackerSleepPlanTechniques_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_LKP_TrackerStrengthActivity_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_LKP_TrackerStrengthActivity_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_LKP_TrackerStrengthActivity_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_LKP_TrackerStrengthActivity_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_LKP_TrackerStrengthActivity_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_LKP_TrackerStrengthActivity_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_LKP_TrackerTable_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_LKP_TrackerTable_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_LKP_TrackerTable_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_LKP_TrackerTable_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_LKP_TrackerTable_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_LKP_TrackerTable_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_LKP_TrackerTobaccoQuitAids_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_LKP_TrackerTobaccoQuitAids_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_LKP_TrackerTobaccoQuitAids_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_LKP_TrackerTobaccoQuitAids_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_LKP_TrackerTobaccoQuitAids_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_LKP_TrackerTobaccoQuitAids_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_LKP_TrackerVendor_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_LKP_TrackerVendor_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_LKP_TrackerVendor_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_LKP_TrackerVendor_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_LKP_TrackerVendor_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_LKP_TrackerVendor_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_LKP_UnitOfMeasure_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_LKP_UnitOfMeasure_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_LKP_UnitOfMeasure_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_LKP_UnitOfMeasure_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_LKP_UnitOfMeasure_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_LKP_UnitOfMeasure_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_LKP_UserType_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_LKP_UserType_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_LKP_UserType_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_LKP_UserType_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_LKP_UserType_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_LKP_UserType_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_LoginPageSettings_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_LoginPageSettings_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_LoginPageSettings_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_LoginPageSettings_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_LoginPageSettings_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_LoginPageSettings_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_Hfit_MarketplaceProduct_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_Hfit_MarketplaceProduct_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_Hfit_MarketplaceProduct_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_Hfit_MarketplaceProduct_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_Hfit_MarketplaceProduct_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_Hfit_MarketplaceProduct_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_Hfit_MarketplaceProductTypes_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_Hfit_MarketplaceProductTypes_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_Hfit_MarketplaceProductTypes_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_Hfit_MarketplaceProductTypes_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_Hfit_MarketplaceProductTypes_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_Hfit_MarketplaceProductTypes_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_Message_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_Message_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_Message_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_Message_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_Message_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_Message_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_MockMpiData_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_MockMpiData_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_MockMpiData_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_MockMpiData_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_MockMpiData_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_MockMpiData_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_Hfit_MyHealthSettings_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_Hfit_MyHealthSettings_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_Hfit_MyHealthSettings_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_Hfit_MyHealthSettings_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_Hfit_MyHealthSettings_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_Hfit_MyHealthSettings_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_Newsletter_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_Newsletter_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_Newsletter_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_Newsletter_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_Newsletter_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_Newsletter_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_OutComeMessages_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_OutComeMessages_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_OutComeMessages_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_OutComeMessages_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_OutComeMessages_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_OutComeMessages_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_Pillar_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_Pillar_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_Pillar_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_Pillar_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_Pillar_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_Pillar_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_PLPPackageContent_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_PLPPackageContent_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_PLPPackageContent_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_PLPPackageContent_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_PLPPackageContent_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_PLPPackageContent_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_hfit_Post_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_hfit_Post_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_hfit_Post_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_hfit_Post_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_hfit_Post_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_hfit_Post_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_PostChallenge_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_PostChallenge_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_PostChallenge_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_PostChallenge_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_PostChallenge_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_PostChallenge_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_PostEmptyFeed_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_PostEmptyFeed_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_PostEmptyFeed_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_PostEmptyFeed_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_PostEmptyFeed_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_PostEmptyFeed_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_PostHealthEducation_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_PostHealthEducation_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_PostHealthEducation_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_PostHealthEducation_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_PostHealthEducation_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_PostHealthEducation_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_PostMessage_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_PostMessage_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_PostMessage_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_PostMessage_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_PostMessage_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_PostMessage_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_PostQuote_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_PostQuote_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_PostQuote_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_PostQuote_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_PostQuote_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_PostQuote_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_PostReminder_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_PostReminder_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_PostReminder_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_PostReminder_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_PostReminder_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_PostReminder_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_PostSubscriber_ContactBackup_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_PostSubscriber_ContactBackup_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_PostSubscriber_ContactBackup_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_PostSubscriber_ContactBackup_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_PostSubscriber_ContactBackup_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_PostSubscriber_ContactBackup_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_PostSubscriber_ContactMap_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_PostSubscriber_ContactMap_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_PostSubscriber_ContactMap_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_PostSubscriber_ContactMap_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_PostSubscriber_ContactMap_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_PostSubscriber_ContactMap_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_PostSubscriber_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_PostSubscriber_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_PostSubscriber_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_PostSubscriber_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_PostSubscriber_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_PostSubscriber_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_hfit_PPTEligibility_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_hfit_PPTEligibility_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_hfit_PPTEligibility_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_hfit_PPTEligibility_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_hfit_PPTEligibility_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_hfit_PPTEligibility_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFIt_PptEligibility_mosbrun_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFIt_PptEligibility_mosbrun_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_PPTStatus_CR27070_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_PPTStatus_CR27070_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_PPTStatus_CR27070_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_PPTStatus_CR27070_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_PPTStatus_CR27070_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_PPTStatus_CR27070_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_PPTStatus_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_PPTStatus_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_PPTStatus_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_PPTStatus_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_PPTStatus_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_PPTStatus_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_PPTStatusEnum_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_PPTStatusEnum_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_PPTStatusEnum_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_PPTStatusEnum_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_PPTStatusEnum_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_PPTStatusEnum_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_PPTStatusIpadMappingCodeCleanup_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_PPTStatusIpadMappingCodeCleanup_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_PPTStatusIpadMappingCodeCleanup_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_PPTStatusIpadMappingCodeCleanup_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_PPTStatusIpadMappingCodeCleanup_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_PPTStatusIpadMappingCodeCleanup_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_PrivacyPolicy_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_PrivacyPolicy_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_PrivacyPolicy_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_PrivacyPolicy_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_PrivacyPolicy_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_PrivacyPolicy_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_ProgramFeedNotificationSettings_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_ProgramFeedNotificationSettings_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_ProgramFeedNotificationSettings_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_ProgramFeedNotificationSettings_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_ProgramFeedNotificationSettings_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_ProgramFeedNotificationSettings_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_Ref_RewardTrackerValidation_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_Ref_RewardTrackerValidation_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_Ref_RewardTrackerValidation_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_Ref_RewardTrackerValidation_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_Ref_RewardTrackerValidation_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_Ref_RewardTrackerValidation_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_RegistrationWelcome_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_RegistrationWelcome_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_RegistrationWelcome_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_RegistrationWelcome_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_RegistrationWelcome_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_RegistrationWelcome_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_RewardAboutInfoItem_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_RewardAboutInfoItem_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_RewardAboutInfoItem_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_RewardAboutInfoItem_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_RewardAboutInfoItem_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_RewardAboutInfoItem_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_RewardActivity_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_RewardActivity_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_RewardActivity_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_RewardActivity_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_RewardActivity_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_RewardActivity_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_RewardDatesAggregator_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_RewardDatesAggregator_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_RewardDatesAggregator_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_RewardDatesAggregator_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_RewardDatesAggregator_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_RewardDatesAggregator_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_RewardDefaultSettings_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_RewardDefaultSettings_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_RewardDefaultSettings_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_RewardDefaultSettings_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_RewardDefaultSettings_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_RewardDefaultSettings_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_RewardException_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_RewardException_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_RewardException_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_RewardException_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_RewardException_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_RewardException_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_RewardGroup_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_RewardGroup_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_RewardGroup_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_RewardGroup_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_RewardGroup_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_RewardGroup_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_RewardGroupSummary_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_RewardGroupSummary_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_RewardGroupSummary_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_RewardGroupSummary_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_RewardGroupSummary_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_RewardGroupSummary_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_RewardLevel_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_RewardLevel_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_RewardLevel_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_RewardLevel_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_RewardLevel_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_RewardLevel_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_RewardOverrideLog_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_RewardOverrideLog_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_RewardOverrideLog_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_RewardOverrideLog_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_RewardOverrideLog_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_RewardOverrideLog_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_RewardParameterBase_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_RewardParameterBase_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_RewardParameterBase_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_RewardParameterBase_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_RewardParameterBase_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_RewardParameterBase_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_RewardProgram_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_RewardProgram_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_RewardProgram_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_RewardProgram_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_RewardProgram_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_RewardProgram_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_RewardsAboutInfoItem_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_RewardsAboutInfoItem_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_RewardsAboutInfoItem_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_RewardsAboutInfoItem_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_RewardsAboutInfoItem_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_RewardsAboutInfoItem_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_RewardsAwardUserDetail_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_RewardsAwardUserDetail_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_RewardsAwardUserDetail_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_RewardsAwardUserDetail_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_RewardsAwardUserDetail_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_RewardsAwardUserDetail_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_RewardsAwardUserDetailArchive_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_RewardsAwardUserDetailArchive_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_RewardsAwardUserDetailArchive_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_RewardsAwardUserDetailArchive_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_RewardsAwardUserDetailArchive_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_RewardsAwardUserDetailArchive_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_RewardsReprocessQueue_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_RewardsReprocessQueue_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_RewardsReprocessQueue_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_RewardsReprocessQueue_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_RewardsReprocessQueue_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_RewardsReprocessQueue_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_RewardsUserActivityDetail_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_RewardsUserActivityDetail_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_RewardsUserActivityDetail_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_RewardsUserActivityDetail_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_RewardsUserActivityDetail_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_RewardsUserActivityDetail_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_RewardsUserInterfaceState_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_RewardsUserInterfaceState_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_RewardsUserInterfaceState_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_RewardsUserInterfaceState_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_RewardsUserInterfaceState_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_RewardsUserInterfaceState_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_RewardsUserLevelDetail_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_RewardsUserLevelDetail_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_RewardsUserLevelDetail_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_RewardsUserLevelDetail_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_RewardsUserLevelDetail_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_RewardsUserLevelDetail_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_RewardsUserRepeatableTriggerDetail_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_RewardsUserRepeatableTriggerDetail_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_RewardsUserRepeatableTriggerDetail_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_RewardsUserRepeatableTriggerDetail_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_RewardsUserRepeatableTriggerDetail_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_RewardsUserRepeatableTriggerDetail_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_RewardsUserSummary_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_RewardsUserSummary_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_RewardsUserSummary_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_RewardsUserSummary_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_RewardsUserSummary_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_RewardsUserSummary_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_RewardsUserSummaryArchive_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_RewardsUserSummaryArchive_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_RewardsUserSummaryArchive_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_RewardsUserSummaryArchive_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_RewardsUserSummaryArchive_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_RewardsUserSummaryArchive_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_RewardsUserTrigger_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_RewardsUserTrigger_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_RewardsUserTrigger_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_RewardsUserTrigger_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_RewardsUserTrigger_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_RewardsUserTrigger_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_RewardTrigger_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_RewardTrigger_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_RewardTrigger_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_RewardTrigger_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_RewardTrigger_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_RewardTrigger_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_RewardTriggerParameter_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_RewardTriggerParameter_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_RewardTriggerParameter_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_RewardTriggerParameter_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_RewardTriggerParameter_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_RewardTriggerParameter_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_RewardTriggerTobaccoParameter_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_RewardTriggerTobaccoParameter_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_RewardTriggerTobaccoParameter_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_RewardTriggerTobaccoParameter_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_RewardTriggerTobaccoParameter_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_RewardTriggerTobaccoParameter_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_RightsResponsibilities_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_RightsResponsibilities_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_RightsResponsibilities_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_RightsResponsibilities_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_RightsResponsibilities_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_RightsResponsibilities_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_ScheduledNotification_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_ScheduledNotification_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_ScheduledNotification_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_ScheduledNotification_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_ScheduledNotification_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_ScheduledNotification_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_ScheduledNotificationHistory_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_ScheduledNotificationHistory_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_ScheduledNotificationHistory_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_ScheduledNotificationHistory_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_ScheduledNotificationHistory_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_ScheduledNotificationHistory_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_ScheduledTaskHistory_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_ScheduledTaskHistory_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_ScheduledTaskHistory_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_ScheduledTaskHistory_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_ScheduledTaskHistory_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_ScheduledTaskHistory_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_SchedulerEventAppointmentSlot_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_SchedulerEventAppointmentSlot_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_SchedulerEventAppointmentSlot_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_SchedulerEventAppointmentSlot_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_SchedulerEventAppointmentSlot_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_SchedulerEventAppointmentSlot_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_SchedulerEventType_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_SchedulerEventType_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_SchedulerEventType_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_SchedulerEventType_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_SchedulerEventType_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_SchedulerEventType_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_Screening_CNT_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_Screening_CNT_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_Screening_CNT_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_Screening_CNT_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_Screening_CNT_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_Screening_CNT_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_Screening_MAP_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_Screening_MAP_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_Screening_MAP_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_Screening_MAP_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_Screening_MAP_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_Screening_MAP_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_Screening_PPT_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_Screening_PPT_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_Screening_PPT_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_Screening_PPT_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_Screening_PPT_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_Screening_PPT_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_Screening_QST_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_Screening_QST_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_Screening_QST_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_Screening_QST_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_Screening_QST_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_Screening_QST_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_ScreeningEvent_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_ScreeningEvent_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_ScreeningEvent_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_ScreeningEvent_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_ScreeningEvent_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_ScreeningEvent_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_ScreeningEventCategory_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_ScreeningEventCategory_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_ScreeningEventCategory_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_ScreeningEventCategory_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_ScreeningEventCategory_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_ScreeningEventCategory_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_ScreeningEventDate_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_ScreeningEventDate_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_ScreeningEventDate_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_ScreeningEventDate_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_ScreeningEventDate_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_ScreeningEventDate_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_ScreeningTemporalContainer_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_ScreeningTemporalContainer_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_ScreeningTemporalContainer_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_ScreeningTemporalContainer_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_ScreeningTemporalContainer_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_ScreeningTemporalContainer_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_SecurityQuestion_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_SecurityQuestion_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_SecurityQuestion_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_SecurityQuestion_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_SecurityQuestion_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_SecurityQuestion_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_Hfit_SecurityQuestionSettings_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_Hfit_SecurityQuestionSettings_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_Hfit_SecurityQuestionSettings_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_Hfit_SecurityQuestionSettings_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_Hfit_SecurityQuestionSettings_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_Hfit_SecurityQuestionSettings_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_Hfit_SmallStepResponses_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_Hfit_SmallStepResponses_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_Hfit_SmallStepResponses_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_Hfit_SmallStepResponses_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_Hfit_SmallStepResponses_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_Hfit_SmallStepResponses_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_SmallSteps_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_SmallSteps_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_SmallSteps_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_SmallSteps_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_SmallSteps_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_SmallSteps_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_hfit_SocialProof_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_hfit_SocialProof_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_hfit_SocialProof_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_hfit_SocialProof_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_hfit_SocialProof_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_hfit_SocialProof_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_SSIS_ScreeningMapping_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_SSIS_ScreeningMapping_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_SSIS_ScreeningMapping_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_SSIS_ScreeningMapping_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_SSIS_ScreeningMapping_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_SSIS_ScreeningMapping_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_SsoAttributeData_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_SsoAttributeData_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_SsoAttributeData_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_SsoAttributeData_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_SsoAttributeData_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_SsoAttributeData_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFIT_SsoConfiguration_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFIT_SsoConfiguration_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFIT_SsoConfiguration_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFIT_SsoConfiguration_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFIT_SsoConfiguration_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFIT_SsoConfiguration_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_SsoData_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_SsoData_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_SsoData_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_SsoData_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_SsoData_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_SsoData_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_SsoRequest_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_SsoRequest_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_SsoRequest_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_SsoRequest_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_SsoRequest_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_SsoRequest_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_SsoRequestAttributes_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_SsoRequestAttributes_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_SsoRequestAttributes_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_SsoRequestAttributes_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_SsoRequestAttributes_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_SsoRequestAttributes_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_Staging_Blurb_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_Staging_Blurb_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_Staging_Blurb_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_Staging_Blurb_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_Staging_Blurb_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_Staging_Blurb_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_Staging_Clinical_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_Staging_Clinical_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_Staging_Clinical_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_Staging_Clinical_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_Staging_Clinical_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_Staging_Clinical_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_Staging_Coach_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_Staging_Coach_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_Staging_Coach_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_Staging_Coach_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_Staging_Coach_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_Staging_Coach_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_Staging_Fulfillment_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_Staging_Fulfillment_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_Staging_Fulfillment_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_Staging_Fulfillment_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_StagingEligibility_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_StagingEligibility_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_StagingEligibility_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_StagingEligibility_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_StagingEligibility_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_StagingEligibility_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_StagingScreenings_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_StagingScreenings_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_StagingScreenings_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_StagingScreenings_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_StagingScreenings_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_StagingScreenings_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_StatbridgeFileDownload_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_StatbridgeFileDownload_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_StatbridgeFileDownload_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_StatbridgeFileDownload_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_StatbridgeFileDownload_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_StatbridgeFileDownload_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_SyncTaskSettings_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_SyncTaskSettings_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_SyncTaskSettings_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_SyncTaskSettings_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_SyncTaskSettings_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_SyncTaskSettings_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_hfit_TemporalConfigurationContainer_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_hfit_TemporalConfigurationContainer_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_hfit_TemporalConfigurationContainer_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_hfit_TemporalConfigurationContainer_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_hfit_TemporalConfigurationContainer_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_hfit_TemporalConfigurationContainer_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_TermsConditions_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_TermsConditions_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_TermsConditions_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_TermsConditions_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_TermsConditions_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_TermsConditions_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_Hfit_TimezoneConfiguration_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_Hfit_TimezoneConfiguration_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_Hfit_TimezoneConfiguration_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_Hfit_TimezoneConfiguration_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_Hfit_TimezoneConfiguration_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_Hfit_TimezoneConfiguration_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_TipOfTheDay_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_TipOfTheDay_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_TipOfTheDay_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_TipOfTheDay_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_TipOfTheDay_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_TipOfTheDay_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_Hfit_TipOfTheDayCategory_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_Hfit_TipOfTheDayCategory_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_Hfit_TipOfTheDayCategory_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_Hfit_TipOfTheDayCategory_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_Hfit_TipOfTheDayCategory_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_Hfit_TipOfTheDayCategory_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_Hfit_TipOfTheDayCategoryCT_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_Hfit_TipOfTheDayCategoryCT_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_Hfit_TipOfTheDayCategoryCT_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_Hfit_TipOfTheDayCategoryCT_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_Hfit_TipOfTheDayCategoryCT_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_Hfit_TipOfTheDayCategoryCT_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_Tobacco_Goal_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_Tobacco_Goal_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_Tobacco_Goal_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_Tobacco_Goal_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_Tobacco_Goal_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_Tobacco_Goal_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_ToDoPersonal_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_ToDoPersonal_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_ToDoPersonal_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_ToDoPersonal_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_ToDoPersonal_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_ToDoPersonal_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_ToDoSmallSteps_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_ToDoSmallSteps_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_ToDoSmallSteps_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_ToDoSmallSteps_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_ToDoSmallSteps_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_ToDoSmallSteps_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_TodoSource_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_TodoSource_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_TodoSource_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_TodoSource_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_TodoSource_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_TodoSource_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFIT_Tracker_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFIT_Tracker_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFIT_Tracker_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFIT_Tracker_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFIT_Tracker_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFIT_Tracker_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_TrackerBloodPressure_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_TrackerBloodPressure_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_TrackerBloodPressure_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_TrackerBloodPressure_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_TrackerBloodPressure_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_TrackerBloodPressure_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_TrackerBloodSugarAndGlucose_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_TrackerBloodSugarAndGlucose_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_TrackerBloodSugarAndGlucose_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_TrackerBloodSugarAndGlucose_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_TrackerBloodSugarAndGlucose_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_TrackerBloodSugarAndGlucose_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_TrackerBMI_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_TrackerBMI_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_TrackerBMI_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_TrackerBMI_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_TrackerBMI_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_TrackerBMI_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_TrackerBodyFat_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_TrackerBodyFat_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_TrackerBodyFat_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_TrackerBodyFat_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_TrackerBodyFat_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_TrackerBodyFat_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_TrackerBodyMeasurements_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_TrackerBodyMeasurements_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_TrackerBodyMeasurements_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_TrackerBodyMeasurements_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_TrackerBodyMeasurements_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_TrackerBodyMeasurements_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_TrackerCardio_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_TrackerCardio_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_TrackerCardio_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_TrackerCardio_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_TrackerCardio_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_TrackerCardio_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_TrackerCategory_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_TrackerCategory_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_TrackerCategory_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_TrackerCategory_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_TrackerCategory_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_TrackerCategory_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_TrackerCholesterol_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_TrackerCholesterol_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_TrackerCholesterol_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_TrackerCholesterol_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_TrackerCholesterol_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_TrackerCholesterol_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_TrackerCollectionSource_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_TrackerCollectionSource_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_TrackerCollectionSource_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_TrackerCollectionSource_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_TrackerCollectionSource_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_TrackerCollectionSource_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_TrackerCotinine_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_TrackerCotinine_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_TrackerCotinine_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_TrackerCotinine_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_TrackerCotinine_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_TrackerCotinine_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_TrackerDailySteps_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_TrackerDailySteps_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_TrackerDailySteps_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_TrackerDailySteps_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_TrackerDailySteps_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_TrackerDailySteps_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_TrackerDef_Item_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_TrackerDef_Item_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_TrackerDef_Item_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_TrackerDef_Item_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_TrackerDef_Item_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_TrackerDef_Item_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_TrackerDef_Tracker_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_TrackerDef_Tracker_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_TrackerDef_Tracker_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_TrackerDef_Tracker_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_TrackerDef_Tracker_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_TrackerDef_Tracker_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_TrackerDocument_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_TrackerDocument_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_TrackerDocument_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_TrackerDocument_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_TrackerDocument_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_TrackerDocument_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_TrackerFlexibility_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_TrackerFlexibility_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_TrackerFlexibility_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_TrackerFlexibility_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_TrackerFlexibility_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_TrackerFlexibility_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_TrackerFruits_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_TrackerFruits_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_TrackerFruits_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_TrackerFruits_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_TrackerFruits_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_TrackerFruits_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_TrackerHbA1c_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_TrackerHbA1c_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_TrackerHbA1c_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_TrackerHbA1c_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_TrackerHbA1c_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_TrackerHbA1c_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_TrackerHeight_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_TrackerHeight_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_TrackerHeight_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_TrackerHeight_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_TrackerHeight_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_TrackerHeight_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_TrackerHighFatFoods_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_TrackerHighFatFoods_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_TrackerHighFatFoods_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_TrackerHighFatFoods_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_TrackerHighFatFoods_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_TrackerHighFatFoods_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_TrackerHighSodiumFoods_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_TrackerHighSodiumFoods_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_TrackerHighSodiumFoods_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_TrackerHighSodiumFoods_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_TrackerHighSodiumFoods_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_TrackerHighSodiumFoods_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_TrackerInstance_Item_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_TrackerInstance_Item_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_TrackerInstance_Item_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_TrackerInstance_Item_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_TrackerInstance_Item_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_TrackerInstance_Item_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_TrackerInstance_Tracker_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_TrackerInstance_Tracker_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_TrackerInstance_Tracker_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_TrackerInstance_Tracker_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_TrackerInstance_Tracker_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_TrackerInstance_Tracker_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_TrackerMealPortions_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_TrackerMealPortions_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_TrackerMealPortions_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_TrackerMealPortions_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_TrackerMealPortions_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_TrackerMealPortions_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_TrackerMedicalCarePlan_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_TrackerMedicalCarePlan_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_TrackerMedicalCarePlan_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_TrackerMedicalCarePlan_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_TrackerMedicalCarePlan_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_TrackerMedicalCarePlan_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_TrackerPreventiveCare_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_TrackerPreventiveCare_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_TrackerPreventiveCare_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_TrackerPreventiveCare_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_TrackerPreventiveCare_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_TrackerPreventiveCare_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_TrackerRegularMeals_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_TrackerRegularMeals_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_TrackerRegularMeals_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_TrackerRegularMeals_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_TrackerRegularMeals_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_TrackerRegularMeals_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_TrackerRestingHeartRate_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_TrackerRestingHeartRate_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_TrackerRestingHeartRate_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_TrackerRestingHeartRate_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_TrackerRestingHeartRate_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_TrackerRestingHeartRate_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_TrackerShots_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_TrackerShots_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_TrackerShots_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_TrackerShots_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_TrackerShots_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_TrackerShots_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_TrackerSitLess_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_TrackerSitLess_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_TrackerSitLess_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_TrackerSitLess_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_TrackerSitLess_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_TrackerSitLess_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_TrackerSleepPlan_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_TrackerSleepPlan_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_TrackerSleepPlan_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_TrackerSleepPlan_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_TrackerSleepPlan_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_TrackerSleepPlan_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_TrackerStrength_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_TrackerStrength_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_TrackerStrength_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_TrackerStrength_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_TrackerStrength_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_TrackerStrength_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_TrackerStress_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_TrackerStress_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_TrackerStress_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_TrackerStress_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_TrackerStress_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_TrackerStress_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_TrackerStressManagement_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_TrackerStressManagement_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_TrackerStressManagement_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_TrackerStressManagement_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_TrackerStressManagement_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_TrackerStressManagement_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_TrackerSugaryDrinks_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_TrackerSugaryDrinks_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_TrackerSugaryDrinks_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_TrackerSugaryDrinks_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_TrackerSugaryDrinks_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_TrackerSugaryDrinks_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_TrackerSugaryFoods_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_TrackerSugaryFoods_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_TrackerSugaryFoods_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_TrackerSugaryFoods_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_TrackerSugaryFoods_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_TrackerSugaryFoods_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_TrackerSummary_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_TrackerSummary_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_TrackerSummary_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_TrackerSummary_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_TrackerSummary_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_TrackerSummary_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_TrackerTests_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_TrackerTests_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_TrackerTests_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_TrackerTests_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_TrackerTests_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_TrackerTests_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_TrackerTobaccoAttestation_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_TrackerTobaccoAttestation_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_TrackerTobaccoAttestation_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_TrackerTobaccoAttestation_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_TrackerTobaccoAttestation_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_TrackerTobaccoAttestation_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_TrackerTobaccoFree_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_TrackerTobaccoFree_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_TrackerTobaccoFree_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_TrackerTobaccoFree_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_TrackerTobaccoFree_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_TrackerTobaccoFree_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_TrackerVegetables_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_TrackerVegetables_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_TrackerVegetables_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_TrackerVegetables_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_TrackerVegetables_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_TrackerVegetables_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_TrackerWater_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_TrackerWater_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_TrackerWater_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_TrackerWater_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_TrackerWater_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_TrackerWater_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_TrackerWeight_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_TrackerWeight_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_TrackerWeight_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_TrackerWeight_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_TrackerWeight_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_TrackerWeight_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_TrackerWholeGrains_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_TrackerWholeGrains_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_TrackerWholeGrains_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_TrackerWholeGrains_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_TrackerWholeGrains_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_TrackerWholeGrains_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_UnitOfMeasure_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_UnitOfMeasure_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_UnitOfMeasure_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_UnitOfMeasure_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_UnitOfMeasure_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_UnitOfMeasure_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_UserGoal_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_UserGoal_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_UserGoal_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_UserGoal_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_UserGoal_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_UserGoal_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_UserRewardPoints_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_UserRewardPoints_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_UserRewardPoints_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_UserRewardPoints_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_UserRewardPoints_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_UserRewardPoints_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_UserSchedulerAppointment_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_UserSchedulerAppointment_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_UserSchedulerAppointment_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_UserSchedulerAppointment_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_UserSchedulerAppointment_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_UserSchedulerAppointment_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_UserTracker_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_UserTracker_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_UserTracker_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_UserTracker_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_UserTracker_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_UserTracker_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_UserTrackerCategory_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_UserTrackerCategory_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_UserTrackerCategory_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_UserTrackerCategory_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_UserTrackerCategory_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_UserTrackerCategory_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_ValMeasures_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_ValMeasures_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_ValMeasures_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_ValMeasures_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_ValMeasures_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_ValMeasures_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_ValMeasureType_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_ValMeasureType_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_ValMeasureType_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_ValMeasureType_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_ValMeasureType_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_ValMeasureType_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_ValMeasureValues_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_ValMeasureValues_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_ValMeasureValues_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_ValMeasureValues_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_ValMeasureValues_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_ValMeasureValues_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_WellnessGoal_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_WellnessGoal_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_WellnessGoal_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_WellnessGoal_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_WellnessGoal_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_WellnessGoal_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_hfit_WellnessGoalPostTemplate_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_hfit_WellnessGoalPostTemplate_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_hfit_WellnessGoalPostTemplate_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_hfit_WellnessGoalPostTemplate_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_hfit_WellnessGoalPostTemplate_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_hfit_WellnessGoalPostTemplate_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_WellnessGoals_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_WellnessGoals_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_WellnessGoals_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_WellnessGoals_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_HFit_WellnessGoals_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_HFit_WellnessGoals_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_Messaging_Message_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_Messaging_Message_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_Messaging_Message_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_Messaging_Message_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_Messaging_Message_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_Messaging_Message_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_OM_ABTest_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_OM_ABTest_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_OM_ABTest_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_OM_ABTest_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_OM_ABTest_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_OM_ABTest_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_OM_ABVariant_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_OM_ABVariant_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_OM_ABVariant_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_OM_ABVariant_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_OM_ABVariant_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_OM_ABVariant_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_OM_Account_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_OM_Account_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_OM_Account_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_OM_Account_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_OM_Account_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_OM_Account_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_OM_AccountContact_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_OM_AccountContact_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_OM_AccountContact_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_OM_AccountContact_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_OM_AccountContact_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_OM_AccountContact_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_OM_AccountStatus_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_OM_AccountStatus_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_OM_AccountStatus_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_OM_AccountStatus_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_OM_AccountStatus_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_OM_AccountStatus_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_OM_Activity_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_OM_Activity_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_OM_Activity_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_OM_Activity_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_OM_Activity_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_OM_Activity_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_OM_ActivityType_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_OM_ActivityType_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_OM_ActivityType_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_OM_ActivityType_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_OM_ActivityType_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_OM_ActivityType_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_OM_Contact_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_OM_Contact_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_OM_Contact_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_OM_Contact_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_OM_Contact_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_OM_Contact_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_OM_ContactGroup_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_OM_ContactGroup_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_OM_ContactGroup_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_OM_ContactGroup_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_OM_ContactGroup_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_OM_ContactGroup_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_OM_ContactGroupMember_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_OM_ContactGroupMember_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_OM_ContactGroupMember_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_OM_ContactGroupMember_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_OM_ContactGroupMember_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_OM_ContactGroupMember_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_OM_ContactRole_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_OM_ContactRole_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_OM_ContactRole_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_OM_ContactRole_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_OM_ContactRole_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_OM_ContactRole_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_OM_ContactStatus_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_OM_ContactStatus_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_OM_ContactStatus_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_OM_ContactStatus_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_OM_ContactStatus_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_OM_ContactStatus_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_OM_IP_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_OM_IP_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_OM_IP_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_OM_IP_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_OM_IP_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_OM_IP_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_OM_Membership_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_OM_Membership_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_OM_Membership_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_OM_Membership_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_OM_Membership_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_OM_Membership_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_OM_MVTCombination_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_OM_MVTCombination_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_OM_MVTCombination_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_OM_MVTCombination_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_OM_MVTCombination_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_OM_MVTCombination_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_OM_MVTCombinationVariation_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_OM_MVTCombinationVariation_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_OM_MVTCombinationVariation_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_OM_MVTCombinationVariation_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_OM_MVTCombinationVariation_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_OM_MVTCombinationVariation_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_OM_MVTest_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_OM_MVTest_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_OM_MVTest_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_OM_MVTest_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_OM_MVTest_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_OM_MVTest_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_OM_MVTVariant_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_OM_MVTVariant_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_OM_MVTVariant_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_OM_MVTVariant_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_OM_MVTVariant_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_OM_MVTVariant_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_OM_PageVisit_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_OM_PageVisit_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_OM_PageVisit_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_OM_PageVisit_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_OM_PageVisit_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_OM_PageVisit_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_OM_PersonalizationVariant_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_OM_PersonalizationVariant_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_OM_PersonalizationVariant_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_OM_PersonalizationVariant_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_OM_PersonalizationVariant_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_OM_PersonalizationVariant_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_OM_Rule_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_OM_Rule_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_OM_Rule_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_OM_Rule_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_OM_Rule_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_OM_Rule_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_OM_Score_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_OM_Score_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_OM_Score_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_OM_Score_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_OM_Score_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_OM_Score_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_OM_ScoreContactRule_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_OM_ScoreContactRule_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_OM_ScoreContactRule_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_OM_ScoreContactRule_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_OM_ScoreContactRule_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_OM_ScoreContactRule_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_OM_Search_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_OM_Search_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_OM_Search_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_OM_Search_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_OM_Search_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_OM_Search_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_OM_UserAgent_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_OM_UserAgent_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_OM_UserAgent_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_OM_UserAgent_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_OM_UserAgent_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_OM_UserAgent_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_PM_Project_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_PM_Project_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_PM_Project_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_PM_Project_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_PM_Project_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_PM_Project_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_PM_ProjectRolePermission_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_PM_ProjectRolePermission_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_PM_ProjectRolePermission_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_PM_ProjectRolePermission_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_PM_ProjectRolePermission_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_PM_ProjectRolePermission_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_PM_ProjectStatus_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_PM_ProjectStatus_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_PM_ProjectStatus_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_PM_ProjectStatus_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_PM_ProjectStatus_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_PM_ProjectStatus_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_PM_ProjectTask_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_PM_ProjectTask_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_PM_ProjectTask_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_PM_ProjectTask_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_PM_ProjectTask_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_PM_ProjectTask_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_PM_ProjectTaskPriority_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_PM_ProjectTaskPriority_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_PM_ProjectTaskPriority_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_PM_ProjectTaskPriority_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_PM_ProjectTaskPriority_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_PM_ProjectTaskPriority_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_PM_ProjectTaskStatus_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_PM_ProjectTaskStatus_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_PM_ProjectTaskStatus_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_PM_ProjectTaskStatus_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_PM_ProjectTaskStatus_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_PM_ProjectTaskStatus_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_RPT_CoachingFromPortal_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_RPT_CoachingFromPortal_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_RPT_CoachingFromPortal_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_RPT_CoachingFromPortal_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_RPT_CoachingFromPortal_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_RPT_CoachingFromPortal_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_SchemaChangeMonitor_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_SchemaChangeMonitor_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_SchemaChangeMonitor_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_SchemaChangeMonitor_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_SchemaChangeMonitor_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_SchemaChangeMonitor_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_SchemaChangeMonitor_rptData_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_SchemaChangeMonitor_rptData_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_SchemaChangeMonitor_rptData_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_SchemaChangeMonitor_rptData_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_SchemaChangeMonitor_rptData_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_SchemaChangeMonitor_rptData_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_SchemaChangeMonitorEvent_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_SchemaChangeMonitorEvent_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_SchemaChangeMonitorEvent_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_SchemaChangeMonitorEvent_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_SchemaChangeMonitorEvent_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_SchemaChangeMonitorEvent_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_SchemaMonitorObjectName_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_SchemaMonitorObjectName_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_SchemaMonitorObjectName_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_SchemaMonitorObjectName_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_SchemaMonitorObjectName_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_SchemaMonitorObjectName_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_SchemaMonitorObjectNotify_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_SchemaMonitorObjectNotify_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_SchemaMonitorObjectNotify_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_SchemaMonitorObjectNotify_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_SchemaMonitorObjectNotify_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_SchemaMonitorObjectNotify_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_SM_FacebookAccount_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_SM_FacebookAccount_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_SM_FacebookAccount_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_SM_FacebookAccount_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_SM_FacebookAccount_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_SM_FacebookAccount_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_SM_FacebookApplication_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_SM_FacebookApplication_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_SM_FacebookApplication_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_SM_FacebookApplication_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_SM_FacebookApplication_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_SM_FacebookApplication_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_SM_LinkedInAccount_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_SM_LinkedInAccount_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_SM_LinkedInAccount_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_SM_LinkedInAccount_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_SM_LinkedInAccount_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_SM_LinkedInAccount_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_SM_TwitterAccount_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_SM_TwitterAccount_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_SM_TwitterAccount_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_SM_TwitterAccount_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_SM_TwitterAccount_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_SM_TwitterAccount_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_SM_TwitterApplication_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_SM_TwitterApplication_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_SM_TwitterApplication_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_SM_TwitterApplication_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_SM_TwitterApplication_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_SM_TwitterApplication_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_sysdiagrams_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_sysdiagrams_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_TBL_DIFF1_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_TBL_DIFF1_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_TBL_DIFF1_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_TBL_DIFF1_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_TBL_DIFF1_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_TBL_DIFF1_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_TBL_DIFF2_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_TBL_DIFF2_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_TBL_DIFF2_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_TBL_DIFF2_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_TBL_DIFF2_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_TBL_DIFF2_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_TBL_DIFF3_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_TBL_DIFF3_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_TBL_DIFF3_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_TBL_DIFF3_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_TBL_DIFF3_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_TBL_DIFF3_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_TBL_DIFF4_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_TBL_DIFF4_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_TBL_DIFF4_KenticoCMS_2_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_TBL_DIFF4_KenticoCMS_2_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_TBL_DIFF4_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_TBL_DIFF4_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_TEMP_FK_Constraints_KenticoCMS_3_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_TEMP_FK_Constraints_KenticoCMS_3_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_BASE_tmp_HealthAssessmentData_KenticoCMS_1_SYNC'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_BASE_tmp_HealthAssessmentData_KenticoCMS_1_SYNC @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_coachExclusion_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_coachExclusion_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_coachExclusion_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_coachExclusion_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_coachExclusion_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_coachExclusion_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_CT_DIM_HFIT_Tracker'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_CT_DIM_HFIT_Tracker @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_CT_DIM_HFit_TrackerBloodPressure'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_CT_DIM_HFit_TrackerBloodPressure @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_CT_DIM_HFit_TrackerBloodSugarAndGlucose'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_CT_DIM_HFit_TrackerBloodSugarAndGlucose @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_CT_DIM_HFit_TrackerBMI'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_CT_DIM_HFit_TrackerBMI @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_CT_DIM_HFit_TrackerBodyFat'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_CT_DIM_HFit_TrackerBodyFat @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_CT_DIM_HFit_TrackerBodyMeasurements'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_CT_DIM_HFit_TrackerBodyMeasurements @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_CT_DIM_HFit_TrackerCardio'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_CT_DIM_HFit_TrackerCardio @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_CT_DIM_HFit_TrackerCholesterol'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_CT_DIM_HFit_TrackerCholesterol @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_CT_DIM_HFit_TrackerCollectionSource'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_CT_DIM_HFit_TrackerCollectionSource @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_CT_DIM_HFit_TrackerCotinine'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_CT_DIM_HFit_TrackerCotinine @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_CT_DIM_HFit_TrackerDailySteps'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_CT_DIM_HFit_TrackerDailySteps @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_CT_DIM_HFit_TrackerDef_Tracker'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_CT_DIM_HFit_TrackerDef_Tracker @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_CT_DIM_HFit_TrackerFlexibility'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_CT_DIM_HFit_TrackerFlexibility @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_CT_DIM_HFit_TrackerFruits'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_CT_DIM_HFit_TrackerFruits @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_CT_DIM_HFit_TrackerHbA1c'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_CT_DIM_HFit_TrackerHbA1c @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_CT_DIM_HFit_TrackerHeight'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_CT_DIM_HFit_TrackerHeight @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_CT_DIM_HFit_TrackerHighFatFoods'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_CT_DIM_HFit_TrackerHighFatFoods @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_CT_DIM_HFit_TrackerHighSodiumFoods'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_CT_DIM_HFit_TrackerHighSodiumFoods @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_CT_DIM_HFit_TrackerInstance_Tracker'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_CT_DIM_HFit_TrackerInstance_Tracker @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_CT_DIM_HFit_TrackerMealPortions'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_CT_DIM_HFit_TrackerMealPortions @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_CT_DIM_HFit_TrackerMedicalCarePlan'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_CT_DIM_HFit_TrackerMedicalCarePlan @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_CT_DIM_HFit_TrackerPreventiveCare'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_CT_DIM_HFit_TrackerPreventiveCare @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_CT_DIM_HFit_TrackerRegularMeals'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_CT_DIM_HFit_TrackerRegularMeals @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_CT_DIM_HFit_TrackerRestingHeartRate'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_CT_DIM_HFit_TrackerRestingHeartRate @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_CT_DIM_HFit_TrackerShots'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_CT_DIM_HFit_TrackerShots @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_CT_DIM_HFit_TrackerSitLess'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_CT_DIM_HFit_TrackerSitLess @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_CT_DIM_HFit_TrackerSleepPlan'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_CT_DIM_HFit_TrackerSleepPlan @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_CT_DIM_HFit_TrackerStrength'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_CT_DIM_HFit_TrackerStrength @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_CT_DIM_HFit_TrackerStress'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_CT_DIM_HFit_TrackerStress @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_CT_DIM_HFit_TrackerStressManagement'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_CT_DIM_HFit_TrackerStressManagement @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_CT_DIM_HFit_TrackerSugaryDrinks'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_CT_DIM_HFit_TrackerSugaryDrinks @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_CT_DIM_HFit_TrackerSugaryFoods'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_CT_DIM_HFit_TrackerSugaryFoods @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_CT_DIM_HFit_TrackerTests'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_CT_DIM_HFit_TrackerTests @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_CT_DIM_HFit_TrackerTobaccoAttestation'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_CT_DIM_HFit_TrackerTobaccoAttestation @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_CT_DIM_HFit_TrackerTobaccoFree'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_CT_DIM_HFit_TrackerTobaccoFree @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_CT_DIM_HFit_TrackerVegetables'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_CT_DIM_HFit_TrackerVegetables @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_CT_DIM_HFit_TrackerWater'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_CT_DIM_HFit_TrackerWater @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_CT_DIM_HFit_TrackerWeight'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_CT_DIM_HFit_TrackerWeight @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_CT_DIM_HFit_TrackerWholeGrains'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_CT_DIM_HFit_TrackerWholeGrains @ReloadAll = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_DIM_EDW_Participant'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_DIM_EDW_Participant @Reloadall = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFit_Coaches_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFit_Coaches_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFit_Coaches_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFit_Coaches_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFit_Coaches_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFit_Coaches_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFit_CoachingAuditLog_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFit_CoachingAuditLog_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFit_CoachingAuditLog_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFit_CoachingAuditLog_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFit_CoachingAuditLog_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFit_CoachingAuditLog_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFit_CoachingCallLogTemporalContainer_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFit_CoachingCallLogTemporalContainer_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFit_CoachingCallLogTemporalContainer_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFit_CoachingCallLogTemporalContainer_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFit_CoachingCallLogTemporalContainer_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFit_CoachingCallLogTemporalContainer_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_hfit_CoachingCMTemporalContainer_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_hfit_CoachingCMTemporalContainer_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_hfit_CoachingCMTemporalContainer_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_hfit_CoachingCMTemporalContainer_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_hfit_CoachingCMTemporalContainer_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_hfit_CoachingCMTemporalContainer_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFit_CoachingCommitToQuit_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFit_CoachingCommitToQuit_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFit_CoachingCommitToQuit_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFit_CoachingCommitToQuit_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFit_CoachingCommitToQuit_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFit_CoachingCommitToQuit_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFit_CoachingEnrollmentReport_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFit_CoachingEnrollmentReport_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFit_CoachingEnrollmentReport_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFit_CoachingEnrollmentReport_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFit_CoachingEnrollmentReport_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFit_CoachingEnrollmentReport_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFit_CoachingEnrollmentSettings_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFit_CoachingEnrollmentSettings_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFit_CoachingEnrollmentSettings_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFit_CoachingEnrollmentSettings_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFit_CoachingEnrollmentSettings_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFit_CoachingEnrollmentSettings_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFit_CoachingEnrollmentSyncStaging_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFit_CoachingEnrollmentSyncStaging_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFit_CoachingEnrollmentSyncStaging_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFit_CoachingEnrollmentSyncStaging_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFit_CoachingEnrollmentSyncStaging_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFit_CoachingEnrollmentSyncStaging_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFit_CoachingEvalHAOverall_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFit_CoachingEvalHAOverall_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFit_CoachingEvalHAOverall_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFit_CoachingEvalHAOverall_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFit_CoachingEvalHAOverall_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFit_CoachingEvalHAOverall_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFit_CoachingEvalHAQA_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFit_CoachingEvalHAQA_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFit_CoachingEvalHAQA_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFit_CoachingEvalHAQA_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFit_CoachingEvalHAQA_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFit_CoachingEvalHAQA_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFit_CoachingEvalHARiskArea_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFit_CoachingEvalHARiskArea_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFit_CoachingEvalHARiskArea_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFit_CoachingEvalHARiskArea_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFit_CoachingEvalHARiskArea_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFit_CoachingEvalHARiskArea_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFit_CoachingEvalHARiskCategory_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFit_CoachingEvalHARiskCategory_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFit_CoachingEvalHARiskCategory_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFit_CoachingEvalHARiskCategory_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFit_CoachingEvalHARiskCategory_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFit_CoachingEvalHARiskCategory_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFit_CoachingEvalHARiskModule_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFit_CoachingEvalHARiskModule_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFit_CoachingEvalHARiskModule_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFit_CoachingEvalHARiskModule_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFit_CoachingEvalHARiskModule_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFit_CoachingEvalHARiskModule_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFit_CoachingGetStarted_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFit_CoachingGetStarted_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFit_CoachingGetStarted_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFit_CoachingGetStarted_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFit_CoachingGetStarted_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFit_CoachingGetStarted_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFit_CoachingHATemporalContainer_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFit_CoachingHATemporalContainer_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFit_CoachingHATemporalContainer_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFit_CoachingHATemporalContainer_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFit_CoachingHATemporalContainer_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFit_CoachingHATemporalContainer_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFit_CoachingHealthActionPlan_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFit_CoachingHealthActionPlan_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFit_CoachingHealthActionPlan_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFit_CoachingHealthActionPlan_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFit_CoachingHealthActionPlan_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFit_CoachingHealthActionPlan_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFit_CoachingHealthArea_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFit_CoachingHealthArea_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFit_CoachingHealthArea_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFit_CoachingHealthArea_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFit_CoachingHealthArea_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFit_CoachingHealthArea_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFit_CoachingHealthInterest_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFit_CoachingHealthInterest_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFit_CoachingHealthInterest_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFit_CoachingHealthInterest_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFit_CoachingHealthInterest_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFit_CoachingHealthInterest_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFit_CoachingLibraryHealthArea_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFit_CoachingLibraryHealthArea_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFit_CoachingLibraryHealthArea_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFit_CoachingLibraryHealthArea_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFit_CoachingLibraryHealthArea_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFit_CoachingLibraryHealthArea_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFit_CoachingLibraryResource_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFit_CoachingLibraryResource_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFit_CoachingLibraryResource_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFit_CoachingLibraryResource_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFit_CoachingLibraryResource_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFit_CoachingLibraryResource_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFit_CoachingLibraryResources_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFit_CoachingLibraryResources_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFit_CoachingLibraryResources_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFit_CoachingLibraryResources_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFit_CoachingLibraryResources_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFit_CoachingLibraryResources_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFit_CoachingLibrarySettings_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFit_CoachingLibrarySettings_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFit_CoachingLibrarySettings_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFit_CoachingLibrarySettings_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFit_CoachingLibrarySettings_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFit_CoachingLibrarySettings_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFit_CoachingLMTemporalContainer_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFit_CoachingLMTemporalContainer_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFit_CoachingLMTemporalContainer_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFit_CoachingLMTemporalContainer_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFit_CoachingLMTemporalContainer_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFit_CoachingLMTemporalContainer_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFit_CoachingMyGoalsSettings_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFit_CoachingMyGoalsSettings_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFit_CoachingMyGoalsSettings_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFit_CoachingMyGoalsSettings_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFit_CoachingMyGoalsSettings_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFit_CoachingMyGoalsSettings_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFit_CoachingMyHealthInterestsSettings_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFit_CoachingMyHealthInterestsSettings_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFit_CoachingMyHealthInterestsSettings_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFit_CoachingMyHealthInterestsSettings_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFit_CoachingMyHealthInterestsSettings_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFit_CoachingMyHealthInterestsSettings_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFit_CoachingNotAssignedSettings_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFit_CoachingNotAssignedSettings_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFit_CoachingNotAssignedSettings_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFit_CoachingNotAssignedSettings_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFit_CoachingNotAssignedSettings_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFit_CoachingNotAssignedSettings_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFit_CoachingPrivacyPolicy_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFit_CoachingPrivacyPolicy_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFit_CoachingPrivacyPolicy_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFit_CoachingPrivacyPolicy_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFit_CoachingPrivacyPolicy_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFit_CoachingPrivacyPolicy_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFit_CoachingSessionCompleted_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFit_CoachingSessionCompleted_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFit_CoachingSessionCompleted_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFit_CoachingSessionCompleted_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFit_CoachingSessionCompleted_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFit_CoachingSessionCompleted_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_Hfit_CoachingSystemSettings_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_Hfit_CoachingSystemSettings_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_Hfit_CoachingSystemSettings_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_Hfit_CoachingSystemSettings_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_Hfit_CoachingSystemSettings_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_Hfit_CoachingSystemSettings_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFit_CoachingTermsAndConditionsSettings_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFit_CoachingTermsAndConditionsSettings_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFit_CoachingTermsAndConditionsSettings_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFit_CoachingTermsAndConditionsSettings_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFit_CoachingTermsAndConditionsSettings_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFit_CoachingTermsAndConditionsSettings_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_Hfit_CoachingUserCMCondition_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_Hfit_CoachingUserCMCondition_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_Hfit_CoachingUserCMCondition_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_Hfit_CoachingUserCMCondition_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_Hfit_CoachingUserCMCondition_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_Hfit_CoachingUserCMCondition_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_Hfit_CoachingUserCMExclusion_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_Hfit_CoachingUserCMExclusion_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_Hfit_CoachingUserCMExclusion_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_Hfit_CoachingUserCMExclusion_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_Hfit_CoachingUserCMExclusion_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_Hfit_CoachingUserCMExclusion_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFit_CoachingUserServiceLevel_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFit_CoachingUserServiceLevel_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFit_CoachingUserServiceLevel_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFit_CoachingUserServiceLevel_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFit_CoachingUserServiceLevel_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFit_CoachingUserServiceLevel_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFit_CoachingWelcomeSettings_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFit_CoachingWelcomeSettings_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFit_CoachingWelcomeSettings_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFit_CoachingWelcomeSettings_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFit_CoachingWelcomeSettings_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFit_CoachingWelcomeSettings_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFit_Configuration_CallLogCoaching_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFit_Configuration_CallLogCoaching_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFit_Configuration_CallLogCoaching_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFit_Configuration_CallLogCoaching_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFit_Configuration_CallLogCoaching_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFit_Configuration_CallLogCoaching_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFIT_Configuration_CMCoaching_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFIT_Configuration_CMCoaching_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFIT_Configuration_CMCoaching_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFIT_Configuration_CMCoaching_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFIT_Configuration_CMCoaching_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFIT_Configuration_CMCoaching_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFIT_Configuration_HACoaching_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFIT_Configuration_HACoaching_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFIT_Configuration_HACoaching_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFIT_Configuration_HACoaching_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFIT_Configuration_HACoaching_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFIT_Configuration_HACoaching_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFit_Configuration_LMCoaching_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFit_Configuration_LMCoaching_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFit_Configuration_LMCoaching_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFit_Configuration_LMCoaching_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFit_Configuration_LMCoaching_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFit_Configuration_LMCoaching_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFit_LKP_CoachingAuditLogType_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFit_LKP_CoachingAuditLogType_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFit_LKP_CoachingAuditLogType_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFit_LKP_CoachingAuditLogType_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFit_LKP_CoachingAuditLogType_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFit_LKP_CoachingAuditLogType_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFit_LKP_CoachingCMConditions_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFit_LKP_CoachingCMConditions_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFit_LKP_CoachingCMConditions_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFit_LKP_CoachingCMConditions_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFit_LKP_CoachingCMConditions_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFit_LKP_CoachingCMConditions_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFit_LKP_CoachingCMExclusions_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFit_LKP_CoachingCMExclusions_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFit_LKP_CoachingCMExclusions_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFit_LKP_CoachingCMExclusions_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFit_LKP_CoachingCMExclusions_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFit_LKP_CoachingCMExclusions_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFit_LKP_CoachingOptOutReason_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFit_LKP_CoachingOptOutReason_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFit_LKP_CoachingOptOutReason_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFit_LKP_CoachingOptOutReason_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFit_LKP_CoachingOptOutReason_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFit_LKP_CoachingOptOutReason_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFit_LKP_CoachingServiceLevel_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFit_LKP_CoachingServiceLevel_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFit_LKP_CoachingServiceLevel_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFit_LKP_CoachingServiceLevel_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFit_LKP_CoachingServiceLevel_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFit_LKP_CoachingServiceLevel_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFit_LKP_CoachingServiceLevelStatus_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFit_LKP_CoachingServiceLevelStatus_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFit_LKP_CoachingServiceLevelStatus_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFit_LKP_CoachingServiceLevelStatus_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFit_LKP_CoachingServiceLevelStatus_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFit_LKP_CoachingServiceLevelStatus_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFit_LKP_CoachViewTimeZone_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFit_LKP_CoachViewTimeZone_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFit_LKP_CoachViewTimeZone_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFit_LKP_CoachViewTimeZone_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFit_LKP_CoachViewTimeZone_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFit_LKP_CoachViewTimeZone_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFit_Staging_Coach_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFit_Staging_Coach_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFit_Staging_Coach_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFit_Staging_Coach_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFit_Staging_Coach_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFit_Staging_Coach_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFit_UserCoachingAlert_MeetNotModify_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFit_UserCoachingAlert_MeetNotModify_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFit_UserCoachingAlert_MeetNotModify_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFit_UserCoachingAlert_MeetNotModify_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFit_UserCoachingAlert_MeetNotModify_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFit_UserCoachingAlert_MeetNotModify_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFit_UserCoachingAlert_NotMet_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFit_UserCoachingAlert_NotMet_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFit_UserCoachingAlert_NotMet_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFit_UserCoachingAlert_NotMet_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFit_UserCoachingAlert_NotMet_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFit_UserCoachingAlert_NotMet_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFit_UserCoachingAlert_NotMet_Step1_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFit_UserCoachingAlert_NotMet_Step1_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFit_UserCoachingAlert_NotMet_Step1_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFit_UserCoachingAlert_NotMet_Step1_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFit_UserCoachingAlert_NotMet_Step1_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFit_UserCoachingAlert_NotMet_Step1_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFit_UserCoachingAlert_NotMet_Step2_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFit_UserCoachingAlert_NotMet_Step2_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFit_UserCoachingAlert_NotMet_Step2_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFit_UserCoachingAlert_NotMet_Step2_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFit_UserCoachingAlert_NotMet_Step2_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFit_UserCoachingAlert_NotMet_Step2_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFit_UserCoachingAlert_NotMet_Step3_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFit_UserCoachingAlert_NotMet_Step3_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFit_UserCoachingAlert_NotMet_Step3_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFit_UserCoachingAlert_NotMet_Step3_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFit_UserCoachingAlert_NotMet_Step3_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFit_UserCoachingAlert_NotMet_Step3_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFit_UserCoachingAlert_NotMet_Step4_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFit_UserCoachingAlert_NotMet_Step4_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFit_UserCoachingAlert_NotMet_Step4_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFit_UserCoachingAlert_NotMet_Step4_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFit_UserCoachingAlert_NotMet_Step4_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFit_UserCoachingAlert_NotMet_Step4_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFit_UserCoachingAlert_NotMet_Step5_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFit_UserCoachingAlert_NotMet_Step5_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFit_UserCoachingAlert_NotMet_Step5_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFit_UserCoachingAlert_NotMet_Step5_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_HFit_UserCoachingAlert_NotMet_Step5_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_HFit_UserCoachingAlert_NotMet_Step5_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_RPT_CoachingFromPortal_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_RPT_CoachingFromPortal_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_RPT_CoachingFromPortal_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_RPT_CoachingFromPortal_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_RPT_CoachingFromPortal_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_RPT_CoachingFromPortal_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_STAGING_EDW_Participant'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_STAGING_EDW_Participant @Reloadall = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing PROC_STAGING_Pull_EDW_HealthAssesment_TEMPDATA'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC PROC_STAGING_Pull_EDW_HealthAssesment_TEMPDATA @ReloadAllData = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_Boards_BoardMessage_Joined'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_Boards_BoardMessage_Joined @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_Boards_BoardMessage_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_Boards_BoardMessage_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_Boards_BoardMessage_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_Boards_BoardMessage_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_Boards_BoardMessage_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_Boards_BoardMessage_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_BookingSystem_Joined'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_BookingSystem_Joined @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_BookingSystem_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_BookingSystem_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_BookingSystem_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_BookingSystem_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_BookingSystem_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_BookingSystem_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_CMS_ObjectVersionHistoryUser_Joined'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_CMS_ObjectVersionHistoryUser_Joined @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_CMS_ObjectVersionHistoryUser_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_CMS_ObjectVersionHistoryUser_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_CMS_ObjectVersionHistoryUser_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_CMS_ObjectVersionHistoryUser_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_CMS_ObjectVersionHistoryUser_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_CMS_ObjectVersionHistoryUser_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_CMS_PageTemplateCategoryPageTemplate_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_CMS_PageTemplateCategoryPageTemplate_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_CMS_PageTemplateCategoryPageTemplate_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_CMS_PageTemplateCategoryPageTemplate_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_CMS_PageTemplateCategoryPageTemplate_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_CMS_PageTemplateCategoryPageTemplate_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_CMS_Relationship_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_CMS_Relationship_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_CMS_Relationship_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_CMS_Relationship_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_CMS_Relationship_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_CMS_Relationship_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_CMS_ResourceString_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_CMS_ResourceString_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_CMS_ResourceString_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_CMS_ResourceString_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_CMS_ResourceString_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_CMS_ResourceString_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_CMS_ResourceTranslated_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_CMS_ResourceTranslated_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_CMS_ResourceTranslated_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_CMS_ResourceTranslated_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_CMS_ResourceTranslated_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_CMS_ResourceTranslated_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_CMS_RoleResourcePermission_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_CMS_RoleResourcePermission_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_CMS_RoleResourcePermission_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_CMS_RoleResourcePermission_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_CMS_RoleResourcePermission_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_CMS_RoleResourcePermission_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_CMS_SiteRoleResourceUIElement_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_CMS_SiteRoleResourceUIElement_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_CMS_SiteRoleResourceUIElement_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_CMS_SiteRoleResourceUIElement_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_CMS_SiteRoleResourceUIElement_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_CMS_SiteRoleResourceUIElement_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_CMS_Tree_Joined'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_CMS_Tree_Joined @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_CMS_Tree_Joined_Attachments'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_CMS_Tree_Joined_Attachments @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_CMS_Tree_Joined_Attachments_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_CMS_Tree_Joined_Attachments_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_CMS_Tree_Joined_Attachments_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_CMS_Tree_Joined_Attachments_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_CMS_Tree_Joined_Attachments_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_CMS_Tree_Joined_Attachments_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_CMS_Tree_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_CMS_Tree_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_CMS_Tree_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_CMS_Tree_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_CMS_Tree_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_CMS_Tree_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_CMS_Tree_Joined_Linked'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_CMS_Tree_Joined_Linked @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_CMS_Tree_Joined_Linked_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_CMS_Tree_Joined_Linked_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_CMS_Tree_Joined_Linked_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_CMS_Tree_Joined_Linked_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_CMS_Tree_Joined_Linked_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_CMS_Tree_Joined_Linked_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_CMS_Tree_Joined_Regular'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_CMS_Tree_Joined_Regular @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_CMS_Tree_Joined_Regular_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_CMS_Tree_Joined_Regular_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_CMS_Tree_Joined_Regular_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_CMS_Tree_Joined_Regular_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_CMS_Tree_Joined_Regular_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_CMS_Tree_Joined_Regular_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_CMS_Tree_Joined_Versions_Attachments_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_CMS_Tree_Joined_Versions_Attachments_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_CMS_Tree_Joined_Versions_Attachments_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_CMS_Tree_Joined_Versions_Attachments_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_CMS_Tree_Joined_Versions_Attachments_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_CMS_Tree_Joined_Versions_Attachments_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_CMS_Tree_Joined_Versions_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_CMS_Tree_Joined_Versions_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_CMS_Tree_Joined_Versions_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_CMS_Tree_Joined_Versions_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_CMS_Tree_Joined_Versions_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_CMS_Tree_Joined_Versions_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_CMS_User_With_HFitCoachingSettings_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_CMS_User_With_HFitCoachingSettings_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_CMS_User_With_HFitCoachingSettings_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_CMS_User_With_HFitCoachingSettings_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_CMS_User_With_HFitCoachingSettings_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_CMS_User_With_HFitCoachingSettings_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_CMS_UserRole_Joined'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_CMS_UserRole_Joined @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_CMS_UserRole_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_CMS_UserRole_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_CMS_UserRole_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_CMS_UserRole_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_CMS_UserRole_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_CMS_UserRole_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_CMS_UserRole_MembershipRole_ValidOnly_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_CMS_UserRole_MembershipRole_ValidOnly_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_CMS_UserRole_MembershipRole_ValidOnly_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_CMS_UserRole_MembershipRole_ValidOnly_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_CMS_UserRole_MembershipRole_ValidOnly_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_CMS_UserRole_MembershipRole_ValidOnly_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_CMS_UserSettingsRole_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_CMS_UserSettingsRole_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_CMS_UserSettingsRole_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_CMS_UserSettingsRole_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_CMS_UserSettingsRole_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_CMS_UserSettingsRole_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_CMS_WebPartCategoryWebpart_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_CMS_WebPartCategoryWebpart_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_CMS_WebPartCategoryWebpart_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_CMS_WebPartCategoryWebpart_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_CMS_WebPartCategoryWebpart_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_CMS_WebPartCategoryWebpart_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_CMS_WidgetCategoryWidget_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_CMS_WidgetCategoryWidget_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_CMS_WidgetCategoryWidget_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_CMS_WidgetCategoryWidget_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_CMS_WidgetCategoryWidget_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_CMS_WidgetCategoryWidget_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_COM_SKUOptionCategory_OptionCategory_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_COM_SKUOptionCategory_OptionCategory_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_COM_SKUOptionCategory_OptionCategory_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_COM_SKUOptionCategory_OptionCategory_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_COM_SKUOptionCategory_OptionCategory_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_COM_SKUOptionCategory_OptionCategory_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_CONTENT_Article_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_CONTENT_Article_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_CONTENT_Article_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_CONTENT_Article_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_CONTENT_Article_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_CONTENT_Article_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_CONTENT_Blog_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_CONTENT_Blog_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_CONTENT_Blog_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_CONTENT_Blog_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_CONTENT_Blog_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_CONTENT_Blog_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_CONTENT_BlogMonth_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_CONTENT_BlogMonth_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_CONTENT_BlogMonth_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_CONTENT_BlogMonth_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_CONTENT_BlogMonth_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_CONTENT_BlogMonth_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_CONTENT_BlogPost_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_CONTENT_BlogPost_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_CONTENT_BlogPost_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_CONTENT_BlogPost_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_CONTENT_BlogPost_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_CONTENT_BlogPost_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_CONTENT_BookingEvent_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_CONTENT_BookingEvent_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_CONTENT_BookingEvent_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_CONTENT_BookingEvent_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_CONTENT_BookingEvent_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_CONTENT_BookingEvent_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_CONTENT_Cellphone_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_CONTENT_Cellphone_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_CONTENT_Cellphone_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_CONTENT_Cellphone_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_CONTENT_Cellphone_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_CONTENT_Cellphone_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_CONTENT_Event_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_CONTENT_Event_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_CONTENT_Event_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_CONTENT_Event_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_CONTENT_Event_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_CONTENT_Event_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_CONTENT_FAQ_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_CONTENT_FAQ_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_CONTENT_FAQ_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_CONTENT_FAQ_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_CONTENT_FAQ_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_CONTENT_FAQ_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_CONTENT_File_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_CONTENT_File_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_CONTENT_File_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_CONTENT_File_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_CONTENT_File_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_CONTENT_File_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_CONTENT_ImageGallery_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_CONTENT_ImageGallery_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_CONTENT_ImageGallery_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_CONTENT_ImageGallery_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_CONTENT_ImageGallery_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_CONTENT_ImageGallery_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_CONTENT_Job_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_CONTENT_Job_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_CONTENT_Job_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_CONTENT_Job_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_CONTENT_Job_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_CONTENT_Job_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_CONTENT_KBArticle_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_CONTENT_KBArticle_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_CONTENT_KBArticle_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_CONTENT_KBArticle_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_CONTENT_KBArticle_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_CONTENT_KBArticle_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_CONTENT_Laptop_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_CONTENT_Laptop_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_CONTENT_Laptop_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_CONTENT_Laptop_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_CONTENT_Laptop_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_CONTENT_Laptop_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_CONTENT_MenuItem_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_CONTENT_MenuItem_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_CONTENT_MenuItem_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_CONTENT_MenuItem_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_CONTENT_MenuItem_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_CONTENT_MenuItem_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_CONTENT_News_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_CONTENT_News_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_CONTENT_News_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_CONTENT_News_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_CONTENT_News_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_CONTENT_News_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_CONTENT_Office_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_CONTENT_Office_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_CONTENT_Office_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_CONTENT_Office_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_CONTENT_Office_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_CONTENT_Office_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_CONTENT_PressRelease_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_CONTENT_PressRelease_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_CONTENT_PressRelease_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_CONTENT_PressRelease_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_CONTENT_PressRelease_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_CONTENT_PressRelease_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_CONTENT_Product_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_CONTENT_Product_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_CONTENT_Product_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_CONTENT_Product_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_CONTENT_Product_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_CONTENT_Product_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_CONTENT_SimpleArticle_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_CONTENT_SimpleArticle_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_CONTENT_SimpleArticle_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_CONTENT_SimpleArticle_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_CONTENT_SimpleArticle_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_CONTENT_SimpleArticle_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_CONTENT_Smartphone_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_CONTENT_Smartphone_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_CONTENT_Smartphone_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_CONTENT_Smartphone_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_CONTENT_Smartphone_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_CONTENT_Smartphone_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_CONTENT_Wireframe_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_CONTENT_Wireframe_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_CONTENT_Wireframe_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_CONTENT_Wireframe_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_CONTENT_Wireframe_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_CONTENT_Wireframe_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_view_EDW_Awards_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_view_EDW_Awards_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_view_EDW_Awards_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_view_EDW_Awards_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_view_EDW_BioMetrics_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_view_EDW_BioMetrics_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_view_EDW_BioMetrics_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_view_EDW_BioMetrics_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_view_EDW_BioMetrics_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_view_EDW_BioMetrics_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_view_EDW_BiometricViewRejectCriteria_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_view_EDW_BiometricViewRejectCriteria_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_view_EDW_ClientCompany_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_view_EDW_ClientCompany_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_view_EDW_Coaches_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_view_EDW_Coaches_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_view_EDW_Coaches_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_view_EDW_Coaches_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_view_EDW_Coaches_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_view_EDW_Coaches_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_view_EDW_CoachingDefinition_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_view_EDW_CoachingDefinition_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_view_EDW_CoachingDefinition_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_view_EDW_CoachingDefinition_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_view_EDW_CoachingDefinition_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_view_EDW_CoachingDefinition_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_view_EDW_CoachingDetail_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_view_EDW_CoachingDetail_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_view_EDW_CoachingDetail_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_view_EDW_CoachingDetail_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_view_EDW_CoachingDetail_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_view_EDW_CoachingDetail_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_view_EDW_CoachingPPTAvailable_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_view_EDW_CoachingPPTAvailable_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_view_EDW_CoachingPPTAvailable_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_view_EDW_CoachingPPTAvailable_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_view_EDW_CoachingPPTAvailable_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_view_EDW_CoachingPPTAvailable_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_view_EDW_CoachingPPTEligible_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_view_EDW_CoachingPPTEligible_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_view_EDW_CoachingPPTEligible_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_view_EDW_CoachingPPTEligible_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_view_EDW_CoachingPPTEligible_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_view_EDW_CoachingPPTEligible_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_view_EDW_CoachingPPTEnrolled_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_view_EDW_CoachingPPTEnrolled_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_view_EDW_CoachingPPTEnrolled_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_view_EDW_CoachingPPTEnrolled_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_view_EDW_CoachingPPTEnrolled_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_view_EDW_CoachingPPTEnrolled_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_view_EDW_Eligibility_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_view_EDW_Eligibility_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_view_EDW_EligibilityHistory_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_view_EDW_EligibilityHistory_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_view_EDW_HAassessment_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_view_EDW_HAassessment_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_view_EDW_HealthAssesment_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_view_EDW_HealthAssesment_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_view_EDW_HealthAssesment_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_view_EDW_HealthAssesment_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_view_EDW_HealthAssesment_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_view_EDW_HealthAssesment_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_EDW_HealthAssesmentAnswers_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_EDW_HealthAssesmentAnswers_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_EDW_HealthAssesmentQuestions_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_EDW_HealthAssesmentQuestions_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_EDW_HealthAssesmentQuestions_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_EDW_HealthAssesmentQuestions_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_EDW_HealthAssesmentQuestions_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_EDW_HealthAssesmentQuestions_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_view_EDW_HealthInterestDetail_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_view_EDW_HealthInterestDetail_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_view_EDW_HealthInterestDetail_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_view_EDW_HealthInterestDetail_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_view_EDW_HealthInterestDetail_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_view_EDW_HealthInterestDetail_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_view_EDW_HealthInterestList_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_view_EDW_HealthInterestList_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_view_EDW_Participant_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_view_EDW_Participant_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_view_EDW_RewardAwardDetail_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_view_EDW_RewardAwardDetail_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_EDW_RewardProgram_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_EDW_RewardProgram_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_EDW_RewardProgram_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_EDW_RewardProgram_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_EDW_RewardProgram_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_EDW_RewardProgram_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_view_EDW_RewardsDefinition_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_view_EDW_RewardsDefinition_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_view_EDW_RewardTriggerParameters_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_view_EDW_RewardTriggerParameters_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_view_EDW_RewardUserDetail_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_view_EDW_RewardUserDetail_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_view_EDW_RewardUserLevel_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_view_EDW_RewardUserLevel_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_view_EDW_RoleEligibility_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_view_EDW_RoleEligibility_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_view_EDW_RoleEligibility_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_view_EDW_RoleEligibility_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_view_EDW_RoleEligibility_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_view_EDW_RoleEligibility_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_view_EDW_ScreeningsFromTrackers_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_view_EDW_ScreeningsFromTrackers_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_view_EDW_SmallStepResponses_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_view_EDW_SmallStepResponses_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_view_EDW_TrackerCompositeDetails_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_view_EDW_TrackerCompositeDetails_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_view_EDW_TrackerMetadata_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_view_EDW_TrackerMetadata_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_view_EDW_TrackerShots_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_view_EDW_TrackerShots_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_view_EDW_TrackerTests_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_view_EDW_TrackerTests_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_Forums_GroupForumPost_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_Forums_GroupForumPost_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_Forums_GroupForumPost_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_Forums_GroupForumPost_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_Forums_GroupForumPost_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_Forums_GroupForumPost_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_Calculator_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_Calculator_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_Calculator_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_Calculator_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_Calculator_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_Calculator_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_hfit_challenge_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_hfit_challenge_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_hfit_challenge_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_hfit_challenge_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_hfit_challenge_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_hfit_challenge_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_hfit_ChallengeAbout_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_hfit_ChallengeAbout_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_hfit_ChallengeAbout_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_hfit_ChallengeAbout_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_hfit_ChallengeAbout_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_hfit_ChallengeAbout_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_hfit_challengeBase_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_hfit_challengeBase_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_hfit_challengeBase_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_hfit_challengeBase_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_hfit_challengeBase_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_hfit_challengeBase_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_hfit_ChallengeFAQ_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_hfit_ChallengeFAQ_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_hfit_ChallengeFAQ_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_hfit_ChallengeFAQ_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_hfit_ChallengeFAQ_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_hfit_ChallengeFAQ_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_hfit_challengeGeneralSettings_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_hfit_challengeGeneralSettings_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_hfit_challengeGeneralSettings_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_hfit_challengeGeneralSettings_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_hfit_challengeGeneralSettings_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_hfit_challengeGeneralSettings_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_ChallengeNewsletter_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_ChallengeNewsletter_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_ChallengeNewsletter_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_ChallengeNewsletter_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_ChallengeNewsletter_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_ChallengeNewsletter_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_hfit_challengeOffering_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_hfit_challengeOffering_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_hfit_challengeOffering_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_hfit_challengeOffering_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_hfit_challengeOffering_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_hfit_challengeOffering_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_ChallengePostTemplate_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_ChallengePostTemplate_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_ChallengePostTemplate_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_ChallengePostTemplate_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_ChallengePostTemplate_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_ChallengePostTemplate_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_ChallengePPTEligibleCDPostTemplate_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_ChallengePPTEligibleCDPostTemplate_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_ChallengePPTEligibleCDPostTemplate_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_ChallengePPTEligibleCDPostTemplate_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_ChallengePPTEligibleCDPostTemplate_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_ChallengePPTEligibleCDPostTemplate_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_hFit_ChallengePPTEligiblePostTemplate_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_hFit_ChallengePPTEligiblePostTemplate_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_hFit_ChallengePPTEligiblePostTemplate_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_hFit_ChallengePPTEligiblePostTemplate_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_hFit_ChallengePPTEligiblePostTemplate_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_hFit_ChallengePPTEligiblePostTemplate_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_ChallengePPTRegisteredPostTemplate_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_ChallengePPTRegisteredPostTemplate_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_ChallengePPTRegisteredPostTemplate_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_ChallengePPTRegisteredPostTemplate_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_ChallengePPTRegisteredPostTemplate_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_ChallengePPTRegisteredPostTemplate_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_ChallengePPTRegisteredRDPostTemplate_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_ChallengePPTRegisteredRDPostTemplate_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_ChallengePPTRegisteredRDPostTemplate_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_ChallengePPTRegisteredRDPostTemplate_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_ChallengePPTRegisteredRDPostTemplate_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_ChallengePPTRegisteredRDPostTemplate_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_ChallengeRegistrationEmail_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_ChallengeRegistrationEmail_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_ChallengeRegistrationEmail_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_ChallengeRegistrationEmail_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_ChallengeRegistrationEmail_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_ChallengeRegistrationEmail_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_ChallengeRegistrationPostTemplate_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_ChallengeRegistrationPostTemplate_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_ChallengeRegistrationPostTemplate_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_ChallengeRegistrationPostTemplate_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_ChallengeRegistrationPostTemplate_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_ChallengeRegistrationPostTemplate_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_ChallengeRegistrationSettings_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_ChallengeRegistrationSettings_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_ChallengeRegistrationSettings_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_ChallengeRegistrationSettings_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_ChallengeRegistrationSettings_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_ChallengeRegistrationSettings_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_hfit_ChallengeTeam_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_hfit_ChallengeTeam_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_hfit_ChallengeTeam_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_hfit_ChallengeTeam_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_hfit_ChallengeTeam_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_hfit_ChallengeTeam_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_hfit_ChallengeTeams_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_hfit_ChallengeTeams_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_hfit_ChallengeTeams_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_hfit_ChallengeTeams_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_hfit_ChallengeTeams_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_hfit_ChallengeTeams_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_Class_Joined'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_Class_Joined @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_Class_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_Class_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_Class_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_Class_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_Class_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_Class_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_Hfit_Client_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_Hfit_Client_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_Hfit_Client_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_Hfit_Client_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_Hfit_Client_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_Hfit_Client_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_ClientContact_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_ClientContact_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_ClientContact_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_ClientContact_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_ClientContact_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_ClientContact_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_Coach_Bio'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_Coach_Bio @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_Coach_Bio_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_Coach_Bio_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_Coach_Bio_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_Coach_Bio_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_Coach_Bio_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_Coach_Bio_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_CoachingAuditLog_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_CoachingAuditLog_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_CoachingAuditLog_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_CoachingAuditLog_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_CoachingAuditLog_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_CoachingAuditLog_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_CoachingCallLogTemporalContainer_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_CoachingCallLogTemporalContainer_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_CoachingCallLogTemporalContainer_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_CoachingCallLogTemporalContainer_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_CoachingCallLogTemporalContainer_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_CoachingCallLogTemporalContainer_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_hfit_CoachingCMTemporalContainer_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_hfit_CoachingCMTemporalContainer_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_hfit_CoachingCMTemporalContainer_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_hfit_CoachingCMTemporalContainer_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_hfit_CoachingCMTemporalContainer_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_hfit_CoachingCMTemporalContainer_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_CoachingCommitToQuit_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_CoachingCommitToQuit_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_CoachingCommitToQuit_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_CoachingCommitToQuit_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_CoachingCommitToQuit_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_CoachingCommitToQuit_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_CoachingEnrollment_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_CoachingEnrollment_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_CoachingEnrollment_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_CoachingEnrollment_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_CoachingEnrollment_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_CoachingEnrollment_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_CoachingEnrollmentSettings_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_CoachingEnrollmentSettings_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_CoachingEnrollmentSettings_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_CoachingEnrollmentSettings_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_CoachingEnrollmentSettings_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_CoachingEnrollmentSettings_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_CoachingEvalHAOverall_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_CoachingEvalHAOverall_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_CoachingEvalHAOverall_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_CoachingEvalHAOverall_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_CoachingEvalHAOverall_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_CoachingEvalHAOverall_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_CoachingEvalHAQA_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_CoachingEvalHAQA_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_CoachingEvalHAQA_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_CoachingEvalHAQA_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_CoachingEvalHAQA_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_CoachingEvalHAQA_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_CoachingEvalHARiskArea_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_CoachingEvalHARiskArea_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_CoachingEvalHARiskArea_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_CoachingEvalHARiskArea_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_CoachingEvalHARiskArea_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_CoachingEvalHARiskArea_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_CoachingEvalHARiskCategory_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_CoachingEvalHARiskCategory_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_CoachingEvalHARiskCategory_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_CoachingEvalHARiskCategory_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_CoachingEvalHARiskCategory_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_CoachingEvalHARiskCategory_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_CoachingEvalHARiskModule_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_CoachingEvalHARiskModule_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_CoachingEvalHARiskModule_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_CoachingEvalHARiskModule_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_CoachingEvalHARiskModule_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_CoachingEvalHARiskModule_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_CoachingGetStarted_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_CoachingGetStarted_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_CoachingGetStarted_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_CoachingGetStarted_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_CoachingGetStarted_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_CoachingGetStarted_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_CoachingGetUserDaysSinceActivity_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_CoachingGetUserDaysSinceActivity_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_CoachingGetUserDaysSinceActivity_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_CoachingGetUserDaysSinceActivity_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_CoachingGetUserDaysSinceActivity_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_CoachingGetUserDaysSinceActivity_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_CoachingHATemporalContainer_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_CoachingHATemporalContainer_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_CoachingHATemporalContainer_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_CoachingHATemporalContainer_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_CoachingHATemporalContainer_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_CoachingHATemporalContainer_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_CoachingHealthActionPlan_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_CoachingHealthActionPlan_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_CoachingHealthActionPlan_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_CoachingHealthActionPlan_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_CoachingHealthActionPlan_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_CoachingHealthActionPlan_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_CoachingHealthArea_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_CoachingHealthArea_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_CoachingHealthArea_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_CoachingHealthArea_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_CoachingHealthArea_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_CoachingHealthArea_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_CoachingLibraryHealthArea_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_CoachingLibraryHealthArea_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_CoachingLibraryHealthArea_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_CoachingLibraryHealthArea_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_CoachingLibraryHealthArea_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_CoachingLibraryHealthArea_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_CoachingLibraryResource_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_CoachingLibraryResource_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_CoachingLibraryResource_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_CoachingLibraryResource_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_CoachingLibraryResource_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_CoachingLibraryResource_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_CoachingLibraryResources_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_CoachingLibraryResources_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_CoachingLibraryResources_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_CoachingLibraryResources_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_CoachingLibraryResources_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_CoachingLibraryResources_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_CoachingLibrarySettings_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_CoachingLibrarySettings_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_CoachingLibrarySettings_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_CoachingLibrarySettings_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_CoachingLibrarySettings_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_CoachingLibrarySettings_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_CoachingLMTemporalContainer_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_CoachingLMTemporalContainer_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_CoachingLMTemporalContainer_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_CoachingLMTemporalContainer_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_CoachingLMTemporalContainer_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_CoachingLMTemporalContainer_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_CoachingMyGoalsSettings_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_CoachingMyGoalsSettings_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_CoachingMyGoalsSettings_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_CoachingMyGoalsSettings_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_CoachingMyGoalsSettings_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_CoachingMyGoalsSettings_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_CoachingMyHealthInterestsSettings_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_CoachingMyHealthInterestsSettings_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_CoachingMyHealthInterestsSettings_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_CoachingMyHealthInterestsSettings_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_CoachingMyHealthInterestsSettings_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_CoachingMyHealthInterestsSettings_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_CoachingNotAssignedSettings_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_CoachingNotAssignedSettings_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_CoachingNotAssignedSettings_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_CoachingNotAssignedSettings_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_CoachingNotAssignedSettings_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_CoachingNotAssignedSettings_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_CoachingPrivacyPolicy_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_CoachingPrivacyPolicy_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_CoachingPrivacyPolicy_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_CoachingPrivacyPolicy_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_CoachingPrivacyPolicy_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_CoachingPrivacyPolicy_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_CoachingReadyForNotification_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_CoachingReadyForNotification_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_CoachingReadyForNotification_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_CoachingReadyForNotification_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_CoachingReadyForNotification_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_CoachingReadyForNotification_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_CoachingServiceLevelProgramDates_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_CoachingServiceLevelProgramDates_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_CoachingServiceLevelProgramDates_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_CoachingServiceLevelProgramDates_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_CoachingServiceLevelProgramDates_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_CoachingServiceLevelProgramDates_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_Hfit_CoachingSystemSettings_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_Hfit_CoachingSystemSettings_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_Hfit_CoachingSystemSettings_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_Hfit_CoachingSystemSettings_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_Hfit_CoachingSystemSettings_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_Hfit_CoachingSystemSettings_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_CoachingTermsAndConditionsSettings_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_CoachingTermsAndConditionsSettings_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_CoachingTermsAndConditionsSettings_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_CoachingTermsAndConditionsSettings_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_CoachingTermsAndConditionsSettings_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_CoachingTermsAndConditionsSettings_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_CoachingWelcomeSettings_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_CoachingWelcomeSettings_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_CoachingWelcomeSettings_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_CoachingWelcomeSettings_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_CoachingWelcomeSettings_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_CoachingWelcomeSettings_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_Configuration_CallLogCoaching_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_Configuration_CallLogCoaching_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_Configuration_CallLogCoaching_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_Configuration_CallLogCoaching_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_Configuration_CallLogCoaching_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_Configuration_CallLogCoaching_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFIT_Configuration_CMCoaching_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFIT_Configuration_CMCoaching_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFIT_Configuration_CMCoaching_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFIT_Configuration_CMCoaching_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFIT_Configuration_CMCoaching_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFIT_Configuration_CMCoaching_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFIT_Configuration_HACoaching_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFIT_Configuration_HACoaching_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFIT_Configuration_HACoaching_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFIT_Configuration_HACoaching_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFIT_Configuration_HACoaching_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFIT_Configuration_HACoaching_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_Configuration_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_Configuration_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_Configuration_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_Configuration_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_Configuration_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_Configuration_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_Configuration_LMCoaching_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_Configuration_LMCoaching_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_Configuration_LMCoaching_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_Configuration_LMCoaching_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_Configuration_LMCoaching_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_Configuration_LMCoaching_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFIT_Configuration_Screening_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFIT_Configuration_Screening_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFIT_Configuration_Screening_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFIT_Configuration_Screening_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFIT_Configuration_Screening_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFIT_Configuration_Screening_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_ConsentAndRelease_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_ConsentAndRelease_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_ConsentAndRelease_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_ConsentAndRelease_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_ConsentAndRelease_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_ConsentAndRelease_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_ContentBlock_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_ContentBlock_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_ContentBlock_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_ContentBlock_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_ContentBlock_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_ContentBlock_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_CustomSettingsTemporalContainer_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_CustomSettingsTemporalContainer_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_CustomSettingsTemporalContainer_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_CustomSettingsTemporalContainer_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_CustomSettingsTemporalContainer_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_CustomSettingsTemporalContainer_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_EmailTemplate_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_EmailTemplate_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_EmailTemplate_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_EmailTemplate_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_EmailTemplate_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_EmailTemplate_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_Event_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_Event_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_Event_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_Event_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_Event_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_Event_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_Goal_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_Goal_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_Goal_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_Goal_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_Goal_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_Goal_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_GoalCategory_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_GoalCategory_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_GoalCategory_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_GoalCategory_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_GoalCategory_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_GoalCategory_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_GoalSubCategory_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_GoalSubCategory_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_GoalSubCategory_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_GoalSubCategory_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_GoalSubCategory_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_GoalSubCategory_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_HA_UseAndDisclosure_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_HA_UseAndDisclosure_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_HA_UseAndDisclosure_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_HA_UseAndDisclosure_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_HA_UseAndDisclosure_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_HA_UseAndDisclosure_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_HACampaign_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_HACampaign_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_HACampaign_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_HACampaign_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_HACampaign_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_HACampaign_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_Hfit_HACampaigns_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_Hfit_HACampaigns_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_Hfit_HACampaigns_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_Hfit_HACampaigns_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_Hfit_HACampaigns_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_Hfit_HACampaigns_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_HAWelcomeSettings_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_HAWelcomeSettings_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_HAWelcomeSettings_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_HAWelcomeSettings_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_HAWelcomeSettings_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_HAWelcomeSettings_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_HealthAssesmentAnswers_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_HealthAssesmentAnswers_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_HealthAssesmentMatrixQuestion_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_HealthAssesmentMatrixQuestion_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_HealthAssesmentMatrixQuestion_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_HealthAssesmentMatrixQuestion_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_HealthAssesmentMatrixQuestion_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_HealthAssesmentMatrixQuestion_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_HealthAssesmentModule_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_HealthAssesmentModule_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_HealthAssesmentModule_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_HealthAssesmentModule_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_HealthAssesmentModule_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_HealthAssesmentModule_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_HealthAssesmentMultipleChoiceQuestion_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_HealthAssesmentMultipleChoiceQuestion_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_HealthAssesmentMultipleChoiceQuestion_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_HealthAssesmentMultipleChoiceQuestion_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_HealthAssesmentMultipleChoiceQuestion_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_HealthAssesmentMultipleChoiceQuestion_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_HealthAssesmentPageBreaks_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_HealthAssesmentPageBreaks_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_HealthAssesmentPredefinedAnswer_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_HealthAssesmentPredefinedAnswer_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_HealthAssesmentPredefinedAnswer_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_HealthAssesmentPredefinedAnswer_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_HealthAssesmentPredefinedAnswer_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_HealthAssesmentPredefinedAnswer_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_HealthAssesmentQuestions_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_HealthAssesmentQuestions_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_HealthAssesmentQuestionTitleIDX_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_HealthAssesmentQuestionTitleIDX_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_HealthAssesmentRiskArea_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_HealthAssesmentRiskArea_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_HealthAssesmentRiskArea_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_HealthAssesmentRiskArea_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_HealthAssesmentRiskArea_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_HealthAssesmentRiskArea_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_HealthAssesmentRiskCategory_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_HealthAssesmentRiskCategory_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_HealthAssesmentRiskCategory_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_HealthAssesmentRiskCategory_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_HealthAssesmentRiskCategory_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_HealthAssesmentRiskCategory_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_view_HFit_HealthAssesmentUserResponses_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_view_HFit_HealthAssesmentUserResponses_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_HealthAssessment_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_HealthAssessment_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_HealthAssessment_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_HealthAssessment_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_HealthAssessment_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_HealthAssessment_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_HealthAssessmentConfiguration_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_HealthAssessmentConfiguration_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_HealthAssessmentConfiguration_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_HealthAssessmentConfiguration_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_HealthAssessmentConfiguration_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_HealthAssessmentConfiguration_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_HealthAssessmentFreeForm_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_HealthAssessmentFreeForm_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_HealthAssessmentFreeForm_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_HealthAssessmentFreeForm_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_HealthAssessmentFreeForm_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_HealthAssessmentFreeForm_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_HealthAssessmentModuleConfiguration_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_HealthAssessmentModuleConfiguration_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_HealthAssessmentModuleConfiguration_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_HealthAssessmentModuleConfiguration_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_HealthAssessmentModuleConfiguration_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_HealthAssessmentModuleConfiguration_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_HealthSummarySettings_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_HealthSummarySettings_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_HealthSummarySettings_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_HealthSummarySettings_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_HealthSummarySettings_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_HealthSummarySettings_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_HESChallenge_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_HESChallenge_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_HESChallenge_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_HESChallenge_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_HESChallenge_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_HESChallenge_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_HRA_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_HRA_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_HRA_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_HRA_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_HRA_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_HRA_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_HSAbout_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_HSAbout_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_HSAbout_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_HSAbout_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_HSAbout_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_HSAbout_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_HSBiometricChart_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_HSBiometricChart_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_HSBiometricChart_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_HSBiometricChart_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_HSBiometricChart_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_HSBiometricChart_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_HSGraphRangeSetting_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_HSGraphRangeSetting_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_HSGraphRangeSetting_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_HSGraphRangeSetting_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_HSGraphRangeSetting_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_HSGraphRangeSetting_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_HSHealthMeasuresSettings_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_HSHealthMeasuresSettings_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_HSHealthMeasuresSettings_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_HSHealthMeasuresSettings_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_HSHealthMeasuresSettings_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_HSHealthMeasuresSettings_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_HSLearnMoreDocument_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_HSLearnMoreDocument_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_HSLearnMoreDocument_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_HSLearnMoreDocument_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_HSLearnMoreDocument_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_HSLearnMoreDocument_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_LoginPageSettings_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_LoginPageSettings_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_LoginPageSettings_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_LoginPageSettings_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_LoginPageSettings_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_LoginPageSettings_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_Hfit_MarketplaceProduct_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_Hfit_MarketplaceProduct_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_Hfit_MarketplaceProduct_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_Hfit_MarketplaceProduct_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_Hfit_MarketplaceProduct_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_Hfit_MarketplaceProduct_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_Message_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_Message_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_Message_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_Message_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_Message_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_Message_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_Hfit_MyHealthSettings_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_Hfit_MyHealthSettings_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_Hfit_MyHealthSettings_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_Hfit_MyHealthSettings_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_Hfit_MyHealthSettings_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_Hfit_MyHealthSettings_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_Newsletter_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_Newsletter_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_Newsletter_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_Newsletter_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_Newsletter_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_Newsletter_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_OutComeMessages_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_OutComeMessages_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_OutComeMessages_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_OutComeMessages_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_OutComeMessages_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_OutComeMessages_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_Pillar_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_Pillar_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_Pillar_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_Pillar_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_Pillar_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_Pillar_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_PLPPackageContent_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_PLPPackageContent_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_PLPPackageContent_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_PLPPackageContent_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_PLPPackageContent_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_PLPPackageContent_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_hfit_Post_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_hfit_Post_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_hfit_Post_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_hfit_Post_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_hfit_Post_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_hfit_Post_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_PostChallenge_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_PostChallenge_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_PostChallenge_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_PostChallenge_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_PostChallenge_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_PostChallenge_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_PostEmptyFeed_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_PostEmptyFeed_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_PostEmptyFeed_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_PostEmptyFeed_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_PostEmptyFeed_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_PostEmptyFeed_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_PostHealthEducation_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_PostHealthEducation_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_PostHealthEducation_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_PostHealthEducation_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_PostHealthEducation_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_PostHealthEducation_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_PostMessage_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_PostMessage_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_PostMessage_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_PostMessage_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_PostMessage_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_PostMessage_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_PostQuote_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_PostQuote_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_PostQuote_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_PostQuote_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_PostQuote_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_PostQuote_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_PostReminder_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_PostReminder_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_PostReminder_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_PostReminder_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_PostReminder_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_PostReminder_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_PrivacyPolicy_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_PrivacyPolicy_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_PrivacyPolicy_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_PrivacyPolicy_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_PrivacyPolicy_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_PrivacyPolicy_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_ProgramFeedNotificationSettings_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_ProgramFeedNotificationSettings_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_ProgramFeedNotificationSettings_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_ProgramFeedNotificationSettings_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_ProgramFeedNotificationSettings_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_ProgramFeedNotificationSettings_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_RegistrationWelcome_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_RegistrationWelcome_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_RegistrationWelcome_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_RegistrationWelcome_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_RegistrationWelcome_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_RegistrationWelcome_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_RewardActivity_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_RewardActivity_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_RewardActivity_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_RewardActivity_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_RewardActivity_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_RewardActivity_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_RewardDefaultSettings_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_RewardDefaultSettings_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_RewardDefaultSettings_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_RewardDefaultSettings_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_RewardDefaultSettings_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_RewardDefaultSettings_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_RewardGroup_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_RewardGroup_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_RewardGroup_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_RewardGroup_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_RewardGroup_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_RewardGroup_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_RewardLevel_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_RewardLevel_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_RewardLevel_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_RewardLevel_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_RewardLevel_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_RewardLevel_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_RewardParameterBase_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_RewardParameterBase_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_RewardParameterBase_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_RewardParameterBase_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_RewardParameterBase_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_RewardParameterBase_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_RewardProgram_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_RewardProgram_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_RewardProgram_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_RewardProgram_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_RewardProgram_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_RewardProgram_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_RewardsAboutInfoItem_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_RewardsAboutInfoItem_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_RewardsAboutInfoItem_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_RewardsAboutInfoItem_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_RewardsAboutInfoItem_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_RewardsAboutInfoItem_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_RewardTrigger_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_RewardTrigger_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_RewardTrigger_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_RewardTrigger_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_RewardTrigger_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_RewardTrigger_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_RewardTriggerParameter_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_RewardTriggerParameter_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_RewardTriggerParameter_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_RewardTriggerParameter_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_RewardTriggerParameter_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_RewardTriggerParameter_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_RewardTriggerTobaccoParameter_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_RewardTriggerTobaccoParameter_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_RewardTriggerTobaccoParameter_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_RewardTriggerTobaccoParameter_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_RewardTriggerTobaccoParameter_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_RewardTriggerTobaccoParameter_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_RightsResponsibilities_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_RightsResponsibilities_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_RightsResponsibilities_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_RightsResponsibilities_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_RightsResponsibilities_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_RightsResponsibilities_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_ScheduledNotification_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_ScheduledNotification_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_ScheduledNotification_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_ScheduledNotification_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_ScheduledNotification_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_ScheduledNotification_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_ScreeningEvent_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_ScreeningEvent_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_ScreeningEvent_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_ScreeningEvent_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_ScreeningEvent_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_ScreeningEvent_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_ScreeningEventCategory_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_ScreeningEventCategory_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_ScreeningEventCategory_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_ScreeningEventCategory_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_ScreeningEventCategory_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_ScreeningEventCategory_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_ScreeningEventDate_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_ScreeningEventDate_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_ScreeningEventDate_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_ScreeningEventDate_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_ScreeningEventDate_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_ScreeningEventDate_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_ScreeningTemporalContainer_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_ScreeningTemporalContainer_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_ScreeningTemporalContainer_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_ScreeningTemporalContainer_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_ScreeningTemporalContainer_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_ScreeningTemporalContainer_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_SecurityQuestion_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_SecurityQuestion_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_SecurityQuestion_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_SecurityQuestion_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_SecurityQuestion_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_SecurityQuestion_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_Hfit_SecurityQuestionSettings_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_Hfit_SecurityQuestionSettings_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_Hfit_SecurityQuestionSettings_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_Hfit_SecurityQuestionSettings_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_Hfit_SecurityQuestionSettings_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_Hfit_SecurityQuestionSettings_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_SmallSteps_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_SmallSteps_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_SmallSteps_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_SmallSteps_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_SmallSteps_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_SmallSteps_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_hfit_SocialProof_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_hfit_SocialProof_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_hfit_SocialProof_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_hfit_SocialProof_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_hfit_SocialProof_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_hfit_SocialProof_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFIT_SsoConfiguration_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFIT_SsoConfiguration_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFIT_SsoConfiguration_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFIT_SsoConfiguration_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFIT_SsoConfiguration_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFIT_SsoConfiguration_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_SsoRequest_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_SsoRequest_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_SsoRequest_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_SsoRequest_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_SsoRequest_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_SsoRequest_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_SsoRequestAttributes_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_SsoRequestAttributes_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_SsoRequestAttributes_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_SsoRequestAttributes_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_SsoRequestAttributes_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_SsoRequestAttributes_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_hfit_TemporalConfigurationContainer_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_hfit_TemporalConfigurationContainer_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_hfit_TemporalConfigurationContainer_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_hfit_TemporalConfigurationContainer_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_hfit_TemporalConfigurationContainer_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_hfit_TemporalConfigurationContainer_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_TermsConditions_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_TermsConditions_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_TermsConditions_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_TermsConditions_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_TermsConditions_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_TermsConditions_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_Hfit_TimezoneConfiguration_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_Hfit_TimezoneConfiguration_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_Hfit_TimezoneConfiguration_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_Hfit_TimezoneConfiguration_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_Hfit_TimezoneConfiguration_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_Hfit_TimezoneConfiguration_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_TipOfTheDay_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_TipOfTheDay_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_TipOfTheDay_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_TipOfTheDay_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_TipOfTheDay_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_TipOfTheDay_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_Hfit_TipOfTheDayCategory_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_Hfit_TipOfTheDayCategory_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_Hfit_TipOfTheDayCategory_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_Hfit_TipOfTheDayCategory_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_Hfit_TipOfTheDayCategory_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_Hfit_TipOfTheDayCategory_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_Tobacco_Goal_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_Tobacco_Goal_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_Tobacco_Goal_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_Tobacco_Goal_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_Tobacco_Goal_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_Tobacco_Goal_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_TrackerCategory_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_TrackerCategory_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_TrackerCategory_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_TrackerCategory_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_TrackerCategory_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_TrackerCategory_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_TrackerDocument_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_TrackerDocument_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_TrackerDocument_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_TrackerDocument_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_TrackerDocument_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_TrackerDocument_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_UserSearch_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_UserSearch_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_UserSearch_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_UserSearch_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_UserSearch_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_UserSearch_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_WellnessGoal_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_WellnessGoal_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_WellnessGoal_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_WellnessGoal_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_HFit_WellnessGoal_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_HFit_WellnessGoal_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_hfit_WellnessGoalPostTemplate_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_hfit_WellnessGoalPostTemplate_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_hfit_WellnessGoalPostTemplate_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_hfit_WellnessGoalPostTemplate_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_hfit_WellnessGoalPostTemplate_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_hfit_WellnessGoalPostTemplate_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_Integration_Task_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_Integration_Task_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_Integration_Task_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_Integration_Task_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_Integration_Task_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_Integration_Task_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_Membership_MembershipUser_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_Membership_MembershipUser_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_Membership_MembershipUser_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_Membership_MembershipUser_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_Membership_MembershipUser_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_Membership_MembershipUser_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_Newsletter_Subscriptions_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_Newsletter_Subscriptions_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_Newsletter_Subscriptions_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_Newsletter_Subscriptions_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_Newsletter_Subscriptions_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_Newsletter_Subscriptions_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_NewsletterSubscriberUserRole_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_NewsletterSubscriberUserRole_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_NewsletterSubscriberUserRole_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_NewsletterSubscriberUserRole_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_NewsletterSubscriberUserRole_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_NewsletterSubscriberUserRole_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_OM_Account_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_OM_Account_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_OM_Account_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_OM_Account_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_OM_Account_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_OM_Account_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_OM_Account_MembershipJoined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_OM_Account_MembershipJoined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_OM_Account_MembershipJoined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_OM_Account_MembershipJoined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_OM_Account_MembershipJoined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_OM_Account_MembershipJoined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_OM_AccountContact_AccountJoined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_OM_AccountContact_AccountJoined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_OM_AccountContact_AccountJoined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_OM_AccountContact_AccountJoined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_OM_AccountContact_AccountJoined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_OM_AccountContact_AccountJoined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_OM_AccountContact_ContactJoined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_OM_AccountContact_ContactJoined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_OM_AccountContact_ContactJoined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_OM_AccountContact_ContactJoined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_OM_AccountContact_ContactJoined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_OM_AccountContact_ContactJoined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_OM_ContactGroupMember_AccountJoined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_OM_ContactGroupMember_AccountJoined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_OM_ContactGroupMember_AccountJoined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_OM_ContactGroupMember_AccountJoined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_OM_ContactGroupMember_AccountJoined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_OM_ContactGroupMember_AccountJoined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_OM_ContactGroupMember_ContactJoined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_OM_ContactGroupMember_ContactJoined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_OM_ContactGroupMember_ContactJoined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_OM_ContactGroupMember_ContactJoined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_OM_ContactGroupMember_ContactJoined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_OM_ContactGroupMember_ContactJoined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_OM_ContactGroupMember_User_ContactJoined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_OM_ContactGroupMember_User_ContactJoined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_OM_ContactGroupMember_User_ContactJoined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_OM_ContactGroupMember_User_ContactJoined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_OM_ContactGroupMember_User_ContactJoined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_OM_ContactGroupMember_User_ContactJoined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_PM_ProjectStatus_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_PM_ProjectStatus_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_PM_ProjectStatus_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_PM_ProjectStatus_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_PM_ProjectStatus_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_PM_ProjectStatus_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_PM_ProjectTaskStatus_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_PM_ProjectTaskStatus_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_PM_ProjectTaskStatus_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_PM_ProjectTaskStatus_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_PM_ProjectTaskStatus_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_PM_ProjectTaskStatus_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_Reporting_CategoryReport_Joined_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_Reporting_CategoryReport_Joined_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_Reporting_CategoryReport_Joined_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_Reporting_CategoryReport_Joined_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_Reporting_CategoryReport_Joined_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_Reporting_CategoryReport_Joined_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_view_ToDoCoachingEnrollment_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_view_ToDoCoachingEnrollment_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_view_ToDoCoachingEnrollment_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_view_ToDoCoachingEnrollment_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_view_ToDoCoachingEnrollment_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_view_ToDoCoachingEnrollment_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_view_ToDoCoachingEnrollmentCompleted_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_view_ToDoCoachingEnrollmentCompleted_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_view_ToDoCoachingEnrollmentCompleted_KenticoCMS_2'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_view_ToDoCoachingEnrollmentCompleted_KenticoCMS_2 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_view_ToDoCoachingEnrollmentCompleted_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_view_ToDoCoachingEnrollmentCompleted_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_ToDoHealthAssesment_KenticoCMS_1'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_ToDoHealthAssesment_KenticoCMS_1 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_ToDoHealthAssesment_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_ToDoHealthAssesment_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO
Print 'Executing proc_View_ToDoHealthAssesmentCompleted_KenticoCMS_3'
GO
print 'Start Time:' 
Print getdate()
GO
EXEC proc_View_ToDoHealthAssesmentCompleted_KenticoCMS_3 @ReloadALL = 1
GO
print 'END Time:' 
Print getdate()
print '*****************************************************' 
GO