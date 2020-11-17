
update S
set SurrogateKey_CMS_User = U.SUrrogateKey_CMS_User 
from 
BASE_CMS_User U
    join BASE_CMS_UserSettings S 
	   on U.UserID = S.UserSettingsUserID
	   and U.SVR = S.SVR
	   and U.DBNAME = S.DBNAME



select 'exec proc_UpdateSurrogateKeyDataBetweenParentAndChild '
+ '@ParentTable = ''' + ParentTable + ''','
+ '@ParentSurrogateKeyName = '''+ParentSurrogateKeyName + ''','
+ '@ChildTable = '''+ChildTable+ ''','
+ '@ParentColumn = '''+ParentColumn+''','
+ '@ChildColumn = '''+ChildColumn+''','
+ '@PreviewOnly = 0' + char(10) + 'GO' as CMD
 from MART_SYNC_Table_FKRels

 exec proc_UpdateSurrogateKeyDataBetweenParentAndChild @ParentTable = 'BASE_Board_Board',@ParentSurrogateKeyName = 'SurrogateKey_Board_Board',@ChildTable = 'BASE_CMS_Document',@ParentColumn = 'BoardDocumentID',@ChildColumn = 'DocumentID',@PreviewOnly = 0
GO