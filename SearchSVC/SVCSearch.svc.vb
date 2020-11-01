Imports ECMEncryption

' NOTE: You can use the "Rename" command on the context menu to change the class name "Service1" in
'       code, svc and config file together.
Public Class SVCSearch
    Implements IService1

    Dim CDF As New clsCdf
    Dim DB As New clsDatabaseSVR
    Dim LOG As New clsLogging
    Dim GEN As New clsGeneratorSVR

    Public ENC As New ECMEncrypt

    Public Function getSourceLength(ByVal SourceGuid As String, SourceType As String) As Int64 Implements IService1.getSourceLength
        Dim FileLen As Int64 = -1
        FileLen = DB.getSourceLength(SourceGuid, SourceType)
        Return FileLen
    End Function
    Public Function getSourceName(ByVal SourceGuid As String, SourceType As String) As String Implements IService1.getSourceName
        Return DB.getSourceName(SourceGuid, SourceType)
    End Function

    Public Function DownLoadDocument(ByRef TypeImage As String, ByVal SourceGuid As String) As Byte() Implements IService1.DownLoadDocument
        Return DB.DownLoadDocument(TypeImage, SourceGuid)
    End Function
    Public Function GetAttachmentFromDB(ByRef SecureID As Integer, ByVal EmailGuid As String) As Byte() Implements IService1.GetAttachmentFromDB
        Dim fdata As Byte() = DB.GetAttachmentFromDB(SecureID, EmailGuid)
        Return fdata
    End Function

    Public Function TestIISConnection() As String Implements IService1.TestIISConnection
        Dim str As String = "IIS Service Running..."
        Return str
    End Function

    Public Function TestConnection() As String Implements IService1.TestConnection
        Dim str As String = "Service Running - could not attach to database"
        If DB.getLicenseCount() >= 0 Then
            str = "Service connected and running... and connected to database"
        End If
        Return str
    End Function

    Public Function getWordInflections(qry As String, CS As String) As String Implements IService1.getWordInflections
        Return DB.getWordInflections(qry, CS)
    End Function

    Public Function removeExpiredAlerts() As Boolean Implements IService1.removeExpiredAlerts
        Return DB.removeExpiredAlerts()
    End Function

    Function ChangeUserPasswordAdmin(AdminUserID As String, ByVal UserLogin As String, ByVal NewPw1 As String, ByVal NewPw2 As String) As Boolean Implements IService1.ChangeUserPasswordAdmin
        Return DB.ChangeUserPasswordAdmin(AdminUserID, UserLogin, NewPw1, NewPw2)
    End Function

    Function AddUserGroup(ByVal GroupName As String, ByVal GroupOwnerUserID As String) As Boolean Implements IService1.AddUserGroup
        Return DB.AddUserGroup(GroupName, GroupOwnerUserID)
    End Function

    Function getErrorLogs(MaxNbr As String) As String Implements IService1.getErrorLogs
        Return DB.getErrorLogs(MaxNbr)
    End Function

    Sub SetEmailPublicFlag(ByRef SecureID As Integer, ByVal EmailGuid As String, ByVal isPublic As Boolean) Implements IService1.SetEmailPublicFlag
        DB.SetEmailPublicFlag(SecureID, EmailGuid, isPublic)
    End Sub

    Sub SetDocumentToMaster(ByRef SecureID As Integer, ByVal SourceGuid As String, ByVal MasterFlag As Boolean) Implements IService1.SetDocumentToMaster
        DB.SetDocumentToMaster(SecureID, SourceGuid, MasterFlag)
    End Sub

    Sub SetDocumentPublicFlag(ByRef SecureID As Integer, ByVal SourceGuid As String, ByVal isPublic As Boolean) Implements IService1.SetDocumentPublicFlag
        DB.SetDocumentPublicFlag(SecureID, SourceGuid, isPublic)
    End Sub

    Function ExecuteSearchJson(TypeSearch As String, ByVal JsonSearchParms As String, ByRef RetMsg As String) As String Implements IService1.ExecuteSearchJson
        Return DB.ExecuteSearchJson(TypeSearch, JsonSearchParms, RetMsg)
    End Function

    Function testServiceAvail() As String Implements IService1.testServiceAvail
        Return "Service running @ " + Date.Today.ToString
    End Function

    Function GenerateSearchSQL(ByVal TypeSearch As String, ByVal SearchParmList As Dictionary(Of String, String)) As String Implements IService1.GenerateSearchSQL

        Return GEN.genSearchSQL(TypeSearch, SearchParmList)

    End Function

    Public Function ExecuteSearchDT(SearchType As String,
                ByRef currSearchCnt As Integer,
                ByVal bGenSql As Boolean,
                ByRef EmailGenSql As String,
                ByVal SearchParmsJson As String,
                ByRef ContentGenSql As String,
                ByRef strListOEmailRows As String,
                ByRef strListOfContentRows As String,
                ByRef bFirstEmailSearchSubmit As Boolean,
                ByRef bFirstContentSearchSubmit As Boolean,
                ByRef EmailRowCnt As Integer,
                ByRef ContentRowCnt As Integer) As DataSet Implements IService1.ExecuteSearchDT

        Dim DT As New DataSet

        DT = DB.ExecuteSearchDT(SearchType,
                 currSearchCnt,
                 bGenSql,
                 EmailGenSql,
                 SearchParmsJson,
                 ContentGenSql,
                 strListOEmailRows,
                 strListOfContentRows,
                 bFirstEmailSearchSubmit,
                 bFirstContentSearchSubmit,
                 EmailRowCnt,
                 ContentRowCnt)

        Return DT

    End Function

    Public Function getSecEndPoint() As String Implements IService1.getSecEndPoint
        Return System.Configuration.ConfigurationManager.AppSettings("ECMSecureLoginEndPoint")
    End Function

    Public Function getContractID(SecureID As Integer, UserID As String) As String Implements IService1.getContractID
        Return DB.getContractID(SecureID, UserID)
    End Function

    Sub AddGroupLibraryAccess(SecureID As Integer, UserID As String, LibraryName As String, GroupName As String, GroupOwnerUserID As String, ByRef RC As Boolean, CurrUserID As String, SessionID As String, ControlSection As String) Implements IService1.AddGroupLibraryAccess
        DB.AddGroupLibraryAccess(SecureID, UserID, LibraryName, GroupName, GroupOwnerUserID, RC, CurrUserID, SessionID, ControlSection)
    End Sub

    Public Function AddGroupUser(SecureID As Integer, SessionID As String, CurrUserID As String, UserID As String, FullAccess As String, ReadOnlyAccess As String, DeleteAccess As String, Searchable As String, GroupOwnerUserID As String, GroupName As String, ControlSection As String) As Boolean Implements IService1.AddGroupUser
        Return DB.AddGroupUser(SecureID, SessionID, CurrUserID, UserID, FullAccess, ReadOnlyAccess, DeleteAccess, Searchable, GroupOwnerUserID, GroupName, ControlSection)
    End Function

    'Function EncryptTripleDES(SecureID As Integer, ByVal Phrase As String, ByVal UserID As String) As String Implements IService1.EncryptTripleDES
    '    Return ENC.AES256DecryptString(SecureID, UserID, Phrase)
    'End Function
    'Function EncryptTripleDES(SecureID As Integer, ByVal Phrase As String, ByVal UserID As String) As String Implements IService1.EncryptTripleDES
    '    Return DB.dbEncryptPhrase(SecureID, UserID, Phrase)
    'End Function
    Public Sub ckContentFlags(SecureID As Integer, SourceGuid As String, ByRef SD As Boolean, ByRef SP As Boolean, ByRef SAP As Boolean, ByRef bMaster As Boolean, ByRef RSS As Boolean, ByRef WEB As Boolean, ByRef bPublic As Boolean) Implements IService1.ckContentFlags
        DB.ckContentFlags(SecureID, SourceGuid, SD, SP, SAP, bMaster, RSS, WEB, bPublic)
    End Sub

    Public Function validateAttachSecureLogin(ByRef SecureID As Integer,
                                             ByVal CompanyID As String,
                                               ByVal RepoID As String,
                                               ByVal UserLogin As String,
                                               ByVal PW As String,
                                               ByRef RC As Boolean,
                                               ByRef RetMsg As String,
                                               ByRef GateWayEndPoint As String, ByRef DownloadEndpoint As String, ByRef ENCCS As String) As Boolean Implements IService1.validateAttachSecureLogin

        Return DB.validateAttachSecureLogin(SecureID, CompanyID, RepoID, UserLogin, PW, RC, RetMsg, GateWayEndPoint, DownloadEndpoint, ENCCS)

    End Function

    Public Sub PopulateSecureLoginCB_V2(ByRef SecureID As Integer, ByRef AllRepos As String, ByVal CompanyID As String, ByRef RC As Boolean, ByRef RetMsg As String) Implements IService1.PopulateSecureLoginCB_V2
        DB.PopulateSecureLoginCB_V2(SecureID, AllRepos, CompanyID, RC, RetMsg)
    End Sub

    Public Function getCustomerLogoTitle() As String Implements IService1.getCustomerLogoTitle
        Return System.Configuration.ConfigurationManager.AppSettings("CustomerLogoTitle")
    End Function

    Public Function getExplodeEmailZip() As String Implements IService1.getExplodeEmailZip
        Return System.Configuration.ConfigurationManager.AppSettings("ExplodeEmailZip")
    End Function

    Public Function getFacilityName() As String Implements IService1.getFacilityName
        Return System.Configuration.ConfigurationManager.AppSettings("FacilityName")
    End Function

    Public Function getAffinitydelay() As Integer Implements IService1.getAffinitydelay
        Return CInt(System.Configuration.ConfigurationManager.AppSettings("AffinityDelayMS"))
    End Function

    Public Function getClcURL() As String Implements IService1.getClcURL
        Return System.Configuration.ConfigurationManager.AppSettings("DownloadClcUrl")
    End Function

    Public Function getArchiverURL() As String Implements IService1.getArchiverURL
        Return System.Configuration.ConfigurationManager.AppSettings("DownloadArchiverURL")
    End Function

    Public Function ExecuteSqlStack(ByRef SecureID As Integer, ByRef SqlStack As Dictionary(Of Integer, String), UserID As String, SessionID As String, ControlSection As String) As Boolean Implements IService1.ExecuteSqlStack
        Return DB.ExecuteSqlStack(SecureID, SqlStack, UserID, SessionID, ControlSection)
    End Function

    Public Function getDefaultScreen(ByVal SecureID As Integer, ByVal UserID As String) As String Implements IService1.getDefaultScreen
        Return DB.getDefaultScreen(SecureID, UserID)
    End Function

    Public Function RecallUserSearch(ByVal SecureID As Integer, ByVal SearchName As String, ByVal UID As String, ByRef strSearches As String) As Boolean Implements IService1.RecallUserSearch
        Return DB.RecallUserSearch(SecureID, SearchName, UID, strSearches)
    End Function

    Public Function SaveUserSearch(ByVal SecureID As Integer, ByVal SearchName As String, ByVal UID As String, ByVal strSearches As String) As Boolean Implements IService1.SaveUserSearch
        Return DB.SaveUserSearch(SecureID, SearchName, UID, strSearches)
    End Function

    Public Function GetFilesInZipDetail(ByRef SecureID As Integer, ByVal ParentGuid As String, ByRef RC As Boolean) As String Implements IService1.GetFilesInZipDetail
        Dim ListOfFiles As String = DB.GetFilesInZipDetail(SecureID, ParentGuid, RC)
        Return ListOfFiles
    End Function

    Public Function scheduleFileDownLoad(ByVal SecureID As Integer,
                                  ByVal ContentGuid As String,
                                  ByVal UserID As String,
                                  ByVal ContentType As String,
                                  ByVal Preview As Integer,
                                  ByVal Restore As Integer) As Boolean Implements IService1.scheduleFileDownLoad

        Return DB.scheduleFileDownLoad(SecureID, ContentGuid, UserID, ContentType, Preview, Restore)

    End Function

    Public Function GetContentMetaData(ByVal SecureID As Integer, ByVal SourceGuid As String) As String Implements IService1.GetContentMetaData
        Dim ListOfItems As List(Of DS_Metadata) = DB.GetContentMetaData(SecureID, SourceGuid)
        Return Newtonsoft.Json.JsonConvert.SerializeObject(ListOfItems)
    End Function

    Public Function removeRestoreFileByGuid(ByVal SecureID As Integer, ByVal RowGuid As String) As Boolean Implements IService1.removeRestoreFileByGuid
        Return DB.removeRestoreFileByGuid(SecureID, RowGuid)
    End Function

    Public Function removeRestoreFiles(ByVal SecureID As Integer, ByRef UserID As String, ByRef MachineID As String) As Boolean Implements IService1.removeRestoreFiles
        Return DB.removeRestoreFiles(SecureID, UserID, MachineID)
    End Function

    Public Function getRestoreFileCount(ByVal SecureID As Integer, ByRef UserID As String, ByRef MachineID As String, ByRef Preview As Boolean) As Integer Implements IService1.getRestoreFileCount
        Return DB.getRestoreFileCount(SecureID, UserID, MachineID, Preview)
    End Function

    Public Function saveRestoreFile(ByVal SecureID As Integer, ByVal tgtTable As String, ByRef ContentGuid As String, ByVal Preview As Boolean, ByVal Restore As Boolean, ByRef UserID As String, ByRef MachineID As String, ByRef RC As Boolean, ByVal RetMsg As String) As Boolean Implements IService1.saveRestoreFile
        Return DB.saveRestoreFile(SecureID, tgtTable, ContentGuid, Preview, Restore, UserID, MachineID, RC, RetMsg)
    End Function

    Public Function GenEmailAttachmentsSQL(ByVal UserID As String,
                                                    ByVal SearchParms As List(Of DS_SearchTerms),
                                                    ByRef SecureID As Integer,
                                                    ByVal InputSearchString As String,
        ByVal useFreetext As Boolean,
        ByVal ckWeighted As Boolean,
        ByVal isEmail As Boolean,
        ByVal LimitToCurrRecs As Boolean,
        ByVal ThesaurusList As ArrayList,
        ByVal txtThesaurus As String,
        ByVal cbThesaurusText As String, ByVal calledBy As String) As String Implements IService1.GenEmailAttachmentsSQL

        Dim SearchParmList As New SortedList(Of String, String)
        DB.setSearchParms(SecureID, UserID, SearchParmList, SearchParms)

        Dim tSql As String = GEN.GenerateEmailAttachmentSQL(SearchParmList, UserID, SearchParms, SecureID, InputSearchString,
         useFreetext,
         ckWeighted,
         isEmail,
         LimitToCurrRecs,
         ThesaurusList,
         txtThesaurus,
         cbThesaurusText, calledBy)

        Return tSql
    End Function

    Public Function GenEmailGeneratedSQL(UserID As String, ByVal SearchParms As List(Of DS_SearchTerms), ByRef SecureID As Integer) As String Implements IService1.GenEmailGeneratedSQL

        Dim SearchTerms As String = ""
        Dim SearchHistory As String = ""

        Dim SearchParmList As New SortedList(Of String, String)
        DB.setSearchParms(SecureID, UserID, SearchParmList, SearchParms)

        Dim tSql As String = ""
        tSql = GEN.GenEmailGeneratedSQL(SearchParmList, SecureID, 0)

        Return tSql

    End Function

    Public Function GenContentSearchSQL(UserID As String, ByVal SearchParms As List(Of DS_SearchTerms), ByRef SecureID As Integer, ByVal UID As String, ByVal SearchString As String, ByVal ckLimitToExisting As Boolean, ByVal txtThesaurus As String, ByVal cbThesaurusText As String, ByVal ckLimitToLib As Boolean, ByVal LibraryName As String, ByVal ckWeighted As Boolean) As String Implements IService1.GenContentSearchSQL

        Dim SearchParmList As New SortedList(Of String, String)
        DB.setSearchParms(SecureID, UserID, SearchParmList, SearchParms)

        Dim tSql As String = GEN.GenContentSearchSQL(SearchParmList, SecureID)
        Return tSql

    End Function

    Public Sub ChangeUserContentPublic(ByVal ServiceID As Integer, ByVal CurrSelectedUserGuid As String, ByVal isPublic As String, ByRef RC As Boolean, ByRef RetMsg As String) Implements IService1.ChangeUserContentPublic
        DB.ChangeUserContentPublic(ServiceID, CurrSelectedUserGuid, isPublic, RC, RetMsg)
    End Sub

    Public Sub Refactor(ByVal SecureID As Integer, ByVal NewOwnerID As String, ByVal OldOwnerID As String, ByRef RC As Boolean, ByRef RetMsg As String) Implements IService1.Refactor
        DB.Refactor(SecureID, NewOwnerID, OldOwnerID, RC, RetMsg)
    End Sub

    Public Function getSAASState(ByVal SecureID As Integer, ByVal UserID As String, ByVal DirName As String, ByVal FullPath As String, ByRef RetMsg As String, ByRef RC As Boolean) As String Implements IService1.getSAASState
        Return DB.getSAASState(SecureID, UserID, DirName, FullPath, RetMsg, RC)
    End Function

    Public Function SetSAASState(ByVal SecureID As Integer, ByVal UserID As String, ByVal DirName As String, ByVal FullPath As String) As Boolean Implements IService1.SetSAASState
        Return DB.SetSAASState(SecureID, UserID, DirName, FullPath)
    End Function

    Public Function PopulateLibraryUsersGrid(ByRef SecureID As Integer, ByVal LibraryName As String, ByVal ckLibUsersOnly As Boolean) As String Implements IService1.PopulateLibraryUsersGrid
        Dim ListOfRows As New List(Of DS_VLibraryUsers)
        ListOfRows = DB.PopulateLibraryUsersGrid(SecureID, LibraryName, ckLibUsersOnly)
        Return Newtonsoft.Json.JsonConvert.SerializeObject(ListOfRows)
    End Function

    Public Function getUserAuth(ByRef SecureID As Integer, ByVal Userid As String) As String Implements IService1.getUserAuth
        Return DB.getUserAuth(SecureID, Userid)
    End Function

    Public Function DeleteUser(ByRef SecureID As Integer, ByVal SelectedUserGuid As String, ByRef RetMsg As String) As Boolean Implements IService1.DeleteUser
        Return DB.DeleteUser(SecureID, SelectedUserGuid, RetMsg)
    End Function

    Public Function SaveUser(ByVal SecureID As Integer, ByRef UserID As String, ByRef UserName As String, ByRef EmailAddress As String,
                      ByRef UserPassword As String, ByRef Admin As String, ByRef isActive As String,
                      ByRef UserLoginID As String, ByRef ClientOnly As Boolean, ByRef HiveConnectionName As String,
                      ByRef HiveActive As Boolean, ByRef RepoSvrName As String, ByRef RowCreationDate As Date, ByRef RowLastModDate As Date,
                      ByRef ActiveGuid As String, ByRef RepoName As String, ByRef RC As Boolean, ByRef RetMsg As String) As Boolean Implements IService1.SaveUSer

        Return DB.SaveUser(SecureID, UserID, UserName, EmailAddress,
                       UserPassword, Admin, isActive,
                       UserLoginID, ClientOnly, HiveConnectionName,
                       HiveActive, RepoSvrName, RowCreationDate, RowLastModDate,
                       ActiveGuid, RepoName, RC, RetMsg)

    End Function

    Public Function saveSearchSchedule(ByVal SecureID As Integer, ByRef SearchName As String, ByRef NotificationSMS As String, ByRef SearchDesc As String, ByRef OwnerID As String, ByRef SearchQuery As String, ByRef SendToEmail As String, ByRef ScheduleUnit As String, ByRef ScheduleHour As String, ByRef ScheduleDaysOfWeek As String, ByRef ScheduleDaysOfMonth As String, ByRef ScheduleMonthOfQtr As String, ByRef StartToRunDate As Date, ByRef EndRunDate As Date, ByRef SearchParameters As String, ByRef LastRunDate As Date, ByRef NumberOfExecutions As Integer, ByRef CreateDate As Date, ByRef LastModDate As Date, ByRef ScheduleHourInterval As Integer, ByRef RepoName As String, ByRef RC As Boolean, ByRef RetMsg As String) As Boolean Implements IService1.saveSearchSchedule
        Return DB.saveSearchSchedule(SecureID, SearchName, NotificationSMS, SearchDesc, OwnerID, SearchQuery, SendToEmail, ScheduleUnit, ScheduleHour, ScheduleDaysOfWeek, ScheduleDaysOfMonth, ScheduleMonthOfQtr, StartToRunDate, EndRunDate, SearchParameters, LastRunDate, NumberOfExecutions, CreateDate, LastModDate, ScheduleHourInterval, RepoName, RC, RetMsg)
    End Function

    Public Function getSearchSchedule(ByVal SecureID As Integer, ByRef SearchName As String, ByRef NotificationSMS As String, ByRef SearchDesc As String, ByRef OwnerID As String, ByRef SearchQuery As String, ByRef SendToEmail As String, ByRef ScheduleUnit As String, ByRef ScheduleHour As String, ByRef ScheduleDaysOfWeek As String, ByRef ScheduleDaysOfMonth As String, ByRef ScheduleMonthOfQtr As String, ByRef StartToRunDate As Date, ByRef EndRunDate As Date, ByRef SearchParameters As String, ByRef LastRunDate As Date, ByRef NumberOfExecutions As Integer, ByRef CreateDate As Date, ByRef LastModDate As Date, ByRef ScheduleHourInterval As Integer, ByRef RepoName As String, ByRef RC As Boolean, ByRef RetMsg As String) As Boolean Implements IService1.getSearchSchedule
        Return DB.getSearchSchedule(SecureID, SearchName, NotificationSMS, SearchDesc, OwnerID, SearchQuery, SendToEmail, ScheduleUnit, ScheduleHour, ScheduleDaysOfWeek, ScheduleDaysOfMonth, ScheduleMonthOfQtr, StartToRunDate, EndRunDate, SearchParameters, LastRunDate, NumberOfExecutions, CreateDate, LastModDate, ScheduleHourInterval, RepoName, RC, RetMsg)
    End Function

    Public Function InsertCoOwner(ByVal SecureID As Integer, ByVal CurrentOwner As String, ByVal CoOwner As String) As Boolean Implements IService1.InsertCoOwner
        Return DB.InsertCoOwner(SecureID, CurrentOwner, CoOwner)
    End Function

    Public Function PopulateCoOwnerGrid(ByVal SecureID As Integer, ByVal UID As String) As String Implements IService1.PopulateCoOwnerGrid
        Return DB.PopulateCoOwnerGrid(SecureID, UID)
    End Function

    Public Function PopulateUserGrid(ByRef SecureID As Integer, ByVal UserID As String, ByVal DBisAdmin As Boolean) As System.Collections.Generic.List(Of DS_VUserGrid) Implements IService1.PopulateUserGrid
        Return DB.PopulateUserGrid(SecureID, UserID, DBisAdmin)
    End Function

    Public Sub getGroupUsers(ByRef SecureID As Integer, ByVal GroupName As String, ByRef GroupList As ArrayList, ByRef RC As Boolean, ByRef RetMsg As String) Implements IService1.getGroupUsers
        DB.getGroupUsers(SecureID, GroupName, GroupList, RC, RetMsg)
    End Sub

    Public Function PopulateDgGroupUsers(ByRef SecureID As Integer, ByVal OwnerUserGuidID As String, ByVal GroupName As String) As String Implements IService1.PopulateDgGroupUsers
        Dim ListOfItems As New List(Of DS_DgGroupUsers)
        ListOfItems = DB.PopulateDgGroupUsers(SecureID, OwnerUserGuidID, GroupName)
        Return Newtonsoft.Json.JsonConvert.SerializeObject(ListOfItems)
    End Function

    Public Function DeleteGroupUsers(SecureID As Integer, ByVal CurrSelectedGroupName As String,
                              ByVal GroupOwnerGuid As String,
                              ByVal UserID As String, ByRef iDeleted As Integer, ByRef RetMsg As String) As Boolean Implements IService1.DeleteGroupUsers
        Return DB.DeleteGroupUsers(SecureID, CurrSelectedGroupName, GroupOwnerGuid, UserID, iDeleted, RetMsg)
    End Function

    Public Function getGroupOwnerGuidByGroupName(ByRef SecureID As Integer, ByVal GroupName As String) As String Implements IService1.getGroupOwnerGuidByGroupName
        Return DB.getGroupOwnerGuidByGroupName(SecureID, GroupName)
    End Function

    Public Sub AddLibraryGroupUser(ByRef SecureID As Integer, ByVal GroupName As String, ByRef RC As Boolean, CurrUserID As String, SessionID As String, ControlSection As String) Implements IService1.AddLibraryGroupUser
        DB.AddLibraryGroupUser(SecureID, GroupName, RC, CurrUserID, SessionID, ControlSection)
    End Sub

    Public Function PopulateGroupUserGrid(ByRef SecureID As Integer, ByVal GroupName As String) As String Implements IService1.PopulateGroupUserGrid
        Dim ListOfItems As New List(Of DS_dgGrpUsers)
        ListOfItems = DB.PopulateGroupUserGrid(SecureID, GroupName)
        Return Newtonsoft.Json.JsonConvert.SerializeObject(ListOfItems)
    End Function

    Public Function PopulateLibItemsGrid(ByRef SecureID As Integer, ByVal LibraryName As String, ByVal UserID As String) As String Implements IService1.PopulateLibItemsGrid
        Dim ListOfItems As New List(Of DS_LibItems)
        ListOfItems = DB.PopulateLibItemsGrid(SecureID, LibraryName, UserID)
        Return Newtonsoft.Json.JsonConvert.SerializeObject(ListOfItems)
    End Function

    Public Function PopulateDgAssigned(ByRef SecureID As Integer, ByVal LibraryName As String, ByVal UserID As String) As String Implements IService1.PopulateDgAssigned
        Dim ListOfItems As New List(Of DS_DgAssigned)
        ListOfItems = DB.PopulateDgAssigned(SecureID, LibraryName, UserID)
        Return Newtonsoft.Json.JsonConvert.SerializeObject(ListOfItems)
    End Function

    Public Sub ResetLibraryUsersCount(ByRef SecureID As Integer, ByRef RC As Boolean) Implements IService1.ResetLibraryUsersCount
        DB.ResetLibraryUsersCount(SecureID, RC)
    End Sub

    Public Sub DeleteLibraryGroupUser(ByRef SecureID As Integer, ByVal GroupName As String, ByVal LibraryName As String, ByRef RC As Boolean) Implements IService1.DeleteLibraryGroupUser
        DB.DeleteLibraryGroupUser(SecureID, GroupName, LibraryName, RC)
    End Sub

    Public Function ChangeUserPassword(ByRef SecureID As Integer, ByVal UserLogin As String, ByVal OldPW As String, ByVal NewPw1 As String, ByVal NewPw2 As String) As Boolean Implements IService1.ChangeUserPassword
        Return DB.ChangeUserPassword(SecureID, UserLogin, OldPW, NewPw1, NewPw2)
    End Function

    Public Sub SaveClickStats(SecureID As Integer, ByVal IID As Integer, ByVal UserID As String, ByRef RC As Boolean) Implements IService1.SaveClickStats
        DB.SaveClickStats(SecureID, IID, UserID, RC)
    End Sub

    Public Sub cleanUpLibraryItems(ByRef SecureID As Integer, ByVal UserID As String) Implements IService1.cleanUpLibraryItems
        DB.cleanUpLibraryItems(SecureID, UserID)
    End Sub

    Public Sub RemoveLibraryDirectories(ByRef SecureID As Integer, ByVal UserID As String, ByVal DirectoryName As String, ByVal LibraryName As String, ByRef RC As Boolean, ByRef RetMsg As String) Implements IService1.RemoveLibraryDirectories
        DB.RemoveLibraryDirectories(SecureID, UserID, DirectoryName, LibraryName, RC, RetMsg)
    End Sub

    Public Sub RemoveLibraryEmails(ByRef SecureID As Integer, ByVal FolderName As String, ByVal LibraryName As String, ByVal UserID As String, ByRef RC As Boolean, ByRef RetMsg As String) Implements IService1.RemoveLibraryEmails
        DB.RemoveLibraryEmails(SecureID, FolderName, LibraryName, UserID, RC, RetMsg)
    End Sub

    Public Sub AddSysMsg(ByRef SecureID As Integer, ByVal UserID As String, ByVal tMsg As String, ByVal RC As Boolean) Implements IService1.AddSysMsg
        DB.AddSysMsg(SecureID, UserID, tMsg, RC)
    End Sub

    Public Sub AddLibraryDirectory(ByRef SecureID As Integer, ByVal FolderName As String, ByVal LibraryName As String, ByVal UserID As String, ByRef RecordsAdded As Integer, ByRef RC As Boolean, ByRef RetMsg As String) Implements IService1.AddLibraryDirectory
        DB.AddLibraryDirectory(SecureID, FolderName, LibraryName, UserID, RecordsAdded, RC, RetMsg)
    End Sub

    Public Sub AddLibraryEmail(ByRef SecureID As Integer, ByVal EmailFolder As String, ByVal LibraryName As String, ByVal UserID As String, ByRef RecordsAdded As Integer, ByVal RC As Boolean, ByVal RetMsg As String) Implements IService1.AddLibraryEmail
        DB.AddLibraryEmail(SecureID, EmailFolder, LibraryName, UserID, RecordsAdded, RC, RetMsg)
    End Sub

    Public Function PopulateLibraryGrid(ByRef SecureID As Integer, ByVal UserID As String) As String Implements IService1.PopulateLibraryGrid
        Dim ListOfItems As New List(Of DS_VLibraryStats)
        ListOfItems = DB.PopulateLibraryGrid(SecureID, UserID)
        Return Newtonsoft.Json.JsonConvert.SerializeObject(ListOfItems)
    End Function

    Public Function getListOfStrings(ByRef SecureID As Integer, ByRef strListOfItems As String, ByVal MySql As String, ByRef RC As Boolean, ByRef RetMsg As String) As Boolean Implements IService1.getListOfStrings
        'MySql = ENC.AES256DecryptString(MySql)
        Return DB.getListOfStrings(SecureID, strListOfItems, MySql, RC, RetMsg)
    End Function

    Public Function getListOfStrings1(ByRef SecureID As Integer, ByRef strListOfItems As String, ByVal MySql As String, ByRef RC As Boolean, ByRef RetMsg As String, UserID As String, SessionID As String) As Boolean Implements IService1.getListOfStrings1
        'MySql = ENC.AES256DecryptString(MySql)
        Return DB.getListOfStrings1(SecureID, strListOfItems, MySql, RC, RetMsg)
    End Function

    Public Function getListOfStrings2(ByRef SecureID As Integer, ByRef strListOfItems As String, ByVal MySql As String, ByRef RC As Boolean, ByRef RetMsg As String, UserID As String, SessionID As String) As Boolean Implements IService1.getListOfStrings2
        MySql = ENC.AES256DecryptString(MySql)
        Return DB.getListOfStrings2(SecureID, strListOfItems, MySql, RC, RetMsg)
    End Function

    Public Function getListOfStrings3(ByRef SecureID As Integer, ByRef strListOfItems As String, ByVal MySql As String, ByRef RC As Boolean, ByRef RetMsg As String, UserID As String, SessionID As String) As Boolean Implements IService1.getListOfStrings3
        MySql = ENC.AES256DecryptString(MySql)
        Return DB.getListOfStrings3(SecureID, strListOfItems, MySql, RC, RetMsg)
    End Function

    Public Function getListOfStrings4(ByRef SecureID As Integer, strListOfItems As String, ByVal MySql As String, ByRef RC As Boolean, ByRef RetMsg As String, UserID As String, SessionID As String) As Boolean Implements IService1.getListOfStrings4
        MySql = ENC.AES256DecryptString(MySql)
        Return DB.getListOfStrings4(SecureID, strListOfItems, MySql, RC, RetMsg)
    End Function

    Public Function iCount(ByRef SecureID As Integer, ByVal S As String) As Integer Implements IService1.iCount
        Return DB.iCount(SecureID, S)
    End Function

    Public Sub GetLogPath(ByRef tPath As String) Implements IService1.GetLogPath
        tPath = Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData)
    End Sub

    Public Function ActiveSessionGetVal(ByRef SecureID As Integer, ByRef SessionGuid As Guid, ByRef ParmName As String) As String Implements IService1.ActiveSessionGetVal
        Dim ParmVal As String = DB.ActiveSessionGetVal(SecureID, SessionGuid, ParmName)
        Return ParmVal
    End Function

    Public Function ActiveSession(ByRef SecureID As Integer, ByVal SessionGuid As Guid, ByVal ParmName As String, ByVal ParmValue As String) As Boolean Implements IService1.ActiveSession
        Dim B As Boolean = DB.ActiveSession(SecureID, SessionGuid, ParmName, ParmValue)
        Return B
    End Function

    Public Sub setSecureLoginParms(ByRef SecureID As Integer, ByVal sCompanyID As String, ByVal sRepoID As String, ByRef RC As Boolean) Implements IService1.setSecureLoginParms
        DB.setSecureLoginParms(SecureID, sCompanyID, sRepoID, RC)
    End Sub

    Public Function getSessionEncCs(ByRef SecureID As Integer) As Object Implements IService1.getSessionEncCs
        Return System.Web.HttpContext.Current.Session.SessionID
        'Return HttpContext.Current.Session("EncryptedCS")
    End Function

    Public Sub setSessionEncCs(ByRef SecureID As Integer, ByVal MySessionID As String) Implements IService1.setSessionEncCs
        HttpContext.Current.Session("EncryptedCS") = MySessionID
    End Sub

    Public Function getHttpSessionID(ByRef SecureID As Integer) As Object Implements IService1.getHttpSessionID
        Return System.Web.HttpContext.Current.Session.SessionID
        'Return HttpContext.Current.Session("MySessionObject")
    End Function

    Public Sub setSessionID(ByRef SecureID As Integer, ByVal MySessionID As String) Implements IService1.setSessionID
        HttpContext.Current.Session("MySessionObject") = MySessionID
    End Sub

    Public Function getLoginGuid(ByRef SecureID As Integer) As Object Implements IService1.getLoginGuid
        Return HttpContext.Current.Session("MyLoginGuid")
    End Function

    Public Sub setLoginGuid(ByRef SecureID As Integer, ByVal MyLoginGuid As String) Implements IService1.setLoginGuid
        HttpContext.Current.Session("MyLoginGuid") = MyLoginGuid
    End Sub

    Public Function getSessionCompanyID(ByRef SecureID As Integer) As Object Implements IService1.getSessionCompanyID
        Return HttpContext.Current.Session("CompanyID")
    End Function

    Public Sub setSessionCompanyID(ByRef SecureID As Integer, ByVal CompanyID As String, ByRef RC As Boolean) Implements IService1.setSessionCompanyID
        HttpContext.Current.Session("CompanyID") = CompanyID
    End Sub

    Public Function getSessionRepoID(ByRef SecureID As Integer) As Object Implements IService1.getSessionRepoID
        Return HttpContext.Current.Session("RepoID")
    End Function

    Public Sub setSessionRepoID(ByRef SecureID As Integer, ByVal RepoID As String) Implements IService1.setSessionRepoID
        HttpContext.Current.Session("RepoID") = RepoID
    End Sub

    Public Function getLoginPW(ByRef SecureID As Integer) As Object Implements IService1.getLoginPW
        Return HttpContext.Current.Session("EncPW")
    End Function

    Public Sub setLoginPW(ByRef SecureID As Integer, ByVal RepoID As String) Implements IService1.setLoginPW
        HttpContext.Current.Session("EncPW") = RepoID
    End Sub

    Public Function ExpandInflectionTerms(ByRef SecureID As Integer, ByVal S As String) As String Implements IService1.ExpandInflectionTerms
        Dim tStr As String = DB.ExpandInflectionTerms(SecureID, S)
        Return tStr
    End Function

    Public Function getServerDatabaseName(ByRef SecureID As Integer) As String Implements IService1.getServerDatabaseName
        Dim S As String = ""
        S = DB.getServerDbName(SecureID)
        Return S
    End Function

    Public Sub CleanLog(ByRef SecureID As Integer) Implements IService1.CleanLog
        DB.CleanLog(SecureID)
    End Sub

    Sub PopulateComboBox(ByRef SecureID As Integer, ByRef CB As String(), ByVal TblColName As String, ByVal S As String) Implements IService1.PopulateComboBox
        DB.PopulateComboBox(SecureID, CB, TblColName, S)
    End Sub

    Public Sub PopulateSecureLoginCB(ByRef SecureID As Integer, ByRef CB As String, ByVal CompanyID As String, ByRef RC As Boolean, ByRef RetMsg As String) Implements IService1.PopulateSecureLoginCB

        DB.PopulateSecureLoginCB(SecureID, CB, CompanyID, RC, RetMsg)

    End Sub

    Public Function GetEmailAttachments(ByRef SecureID As Integer, ByVal CurrEmailGuid As String) As String Implements IService1.GetEmailAttachments
        Return DB.GetEmailAttachments(SecureID, CurrEmailGuid)
    End Function

    Public Function DbWriteToFile(ByRef SecureID As Integer, ByVal UID As String, ByVal SourceGuid As String, ByRef FileName As String) As Boolean Implements IService1.DbWriteToFile
        Dim B As Boolean = False
        B = DB.DbWriteToFile(SecureID, UID, SourceGuid, FileName)
        Return B
    End Function

    Public Sub SetSessionVariable(ByRef SecureID As Integer, ByVal key As String, ByVal KeyValue As String) Implements IService1.SetSessionVariable
        System.Web.HttpContext.Current.Session(key) = KeyValue
    End Sub

    Public Function GetSessionVariable(ByRef SecureID As Integer, ByVal key As String) As Object Implements IService1.GetSessionVariable
        Return System.Web.HttpContext.Current.Session(key)
    End Function

    Public Function UpdateSourceImageCompressed(ByRef SecureID As Integer, ByVal UploadFQN As String, ByVal SourceGuid As String, ByVal LastAccessDate As String, ByVal CreateDate As String, ByVal LastWriteTime As String, ByVal VersionNbr As Integer, ByVal CompressedDataBuffer() As Byte) As Boolean Implements IService1.UpdateSourceImageCompressed
        Dim B As Boolean = False
        B = DB.UpdateSourceImageCompressed(SecureID, UploadFQN, SourceGuid, LastAccessDate$, CreateDate$, LastWriteTime$, VersionNbr, CompressedDataBuffer)
        Return B
    End Function

    'Public Function InsertSourcefile(ByVal SourceGuid As String, _
    '              ByVal UploadFQN As String, _
    '              ByVal SourceName As String, _
    '              ByVal SourceTypeCode As String, _
    '              ByVal sLastAccessDate As String, _
    '              ByVal sCreateDate As String, _
    '              ByVal sLastWriteTime As String, _
    '              ByVal DataSourceOwnerUserID As String, _
    '              ByVal VersionNbr As Integer) As Boolean Implements IService1.InsertSourcefile

    '    Dim B As Boolean = false
    '    B = DB.InsertSourcefile(SourceGuid, UploadFQN, SourceName, SourceTypeCode, sLastAccessDate, sCreateDate, sLastWriteTime, DataSourceOwnerUserID, VersionNbr)
    '    Return B
    'End Function

    Public Sub writeImageSourceDataFromDbWriteToFile(ByRef SecureID As Integer, ByVal SourceGuid As String, ByRef FQN As String, ByRef CompressedDataBuffer() As Byte, ByRef OriginalSize As Integer, ByRef CompressedSize As Integer, ByRef RC As Boolean) Implements IService1.writeImageSourceDataFromDbWriteToFile
        DB.writeImageSourceDataFromDbWriteToFile(SecureID, SourceGuid, FQN, CompressedDataBuffer, OriginalSize, CompressedSize, RC)
    End Sub

    Public Sub writeAttachmentFromDbWriteToFile(ByRef SecureID As Integer, ByVal RowID As String, ByRef FQN As String, ByRef CompressedDataBuffer() As Byte, ByRef OriginalSize As Integer, ByRef CompressedSize As Integer, ByRef RC As Boolean) Implements IService1.writeAttachmentFromDbWriteToFile
        DB.writeAttachmentFromDbWriteToFile(SecureID, RowID, FQN, CompressedDataBuffer, OriginalSize, CompressedSize, RC)
    End Sub

    Public Sub writeEmailFromDbToFile(ByRef SecureID As Integer, ByVal EmailGuid As String, ByRef SourceTypeCode As String, ByRef CompressedDataBuffer() As Byte, ByRef OriginalSize As Integer, ByRef CompressedSize As Integer, ByRef RC As Boolean) Implements IService1.writeEmailFromDbToFile
        DB.writeEmailFromDbToFile(SecureID, EmailGuid, SourceTypeCode, CompressedDataBuffer, OriginalSize, CompressedSize, RC)
    End Sub

    Public Sub AddLibraryItems(ByRef SecureID As Integer, ByVal SourceGuid As String,
    ByVal ItemTitle As String,
    ByVal ItemType As String,
    ByVal LibraryItemGuid As String,
    ByVal DataSourceOwnerUserID As String,
    ByVal LibraryOwnerUserID As String,
    ByVal LibraryName As String,
    ByVal AddedByUserGuidId As String,
    ByRef RC As Boolean, ByRef rMsg As String) Implements IService1.AddLibraryItems

        DB.AddLibraryItems(SecureID, SourceGuid,
        ItemTitle,
        ItemType,
        LibraryItemGuid,
        DataSourceOwnerUserID,
        LibraryOwnerUserID,
        LibraryName,
        AddedByUserGuidId,
        RC, rMsg)

    End Sub

    Public Sub PopulateGroupUserLibCombo(ByRef SecureID As Integer, ByVal UID As String, ByRef cb As String) Implements IService1.PopulateGroupUserLibCombo
        DB.PopulateGroupUserLibCombo(SecureID, UID, cb)
    End Sub

    Public Function GetLibOwnerByName(ByRef SecureID As Integer, ByVal LibraryName As String) As String Implements IService1.GetLibOwnerByName
        Dim S As String = ""
        S = DB.GetLibOwnerByName(SecureID, LibraryName)
        Return S
    End Function

    Function GenerateSQL(ByVal SearchParmList As SortedList(Of String, String), ByRef SecureID As Integer, TypeSQL As String) As String Implements IService1.GenerateSQL
        Dim S As String = ""
        S = DB.GenerateSQL(SearchParmList, SecureID, TypeSQL)
        Return S
    End Function

    Public Function getJsonData(I As String) As String Implements IService1.getJsonData
        Dim jdata As String = DB.getJsonData(I)
        Return jdata
    End Function
    Public Function ExecuteSearchContent(ByRef SecureID As Integer,
                ByRef currSearchCnt As Integer,
                ByVal bGenSql As Boolean,
                ByVal SearchParmsJson As String,
                ByRef bFirstContentSearchSubmit As Boolean,
                ByRef ContentRowCnt As Integer) As String Implements IService1.ExecuteSearchContent
        Console.WriteLine("Start CONTENT Search: " + Now.ToString)
        Dim I As String = DB.ExecuteSearchContent(SecureID,
                                currSearchCnt,
                                bGenSql,
                                SearchParmsJson,
                                bFirstContentSearchSubmit,
                                ContentRowCnt)
        Console.WriteLine("Stop CONTENT Search: " + Now.ToString)
        Return I
    End Function

    Public Function ExecuteSearchEmail(ByRef SecureID As Integer,
                ByRef currSearchCnt As Integer,
                ByVal bGenSql As Boolean,
                ByVal SearchParmsJson As String,
                ByRef bFirstEmailSearchSubmit As Boolean,
                ByRef EmailRowCnt As Integer) As String Implements IService1.ExecuteSearchEmail
        Console.WriteLine("Start EMAIL Search: " + Now.ToString)
        Dim I As String = DB.ExecuteSearchEmail(SecureID,
               currSearchCnt,
               bGenSql,
               SearchParmsJson,
               bFirstEmailSearchSubmit,
               EmailRowCnt)
        Console.WriteLine("Stop EMAIL Search: " + Now.ToString)
        Return I
    End Function
    Public Sub saveSearchState(ByRef SecureID As Integer, ByVal SearchID As Integer, ByVal UID As String, ByVal ScreenName As String, ByVal DICT As Dictionary(Of String, String), ByRef rMsg As String, ByRef RC As Boolean, ByVal HiveConnectionName As String, ByVal HiveActive As Boolean, ByVal RepoSvrName As String) Implements IService1.saveSearchState
        DB.saveSearchState(SecureID, SearchID, UID, ScreenName, DICT, rMsg, RC, HiveConnectionName, HiveActive, RepoSvrName)
    End Sub

    Public Function getSearchState(ByRef SecureID As Integer, ByVal SearchID As Integer, ByVal UID As String, ByVal ScreenName As String, ByRef DICT As Dictionary(Of String, String), ByRef rMsg As String, ByRef RC As Boolean, ByVal HiveConnectionName As String, ByVal HiveActive As Boolean, ByVal RepoSvrName As String) As List(Of DS_USERSEARCHSTATE) Implements IService1.getSearchState
        Dim ListOfRows As New List(Of DS_USERSEARCHSTATE)
        ListOfRows = DB.getSearchState(SecureID, SearchID, UID, ScreenName, DICT, rMsg, RC, HiveConnectionName, HiveActive, RepoSvrName)
        Return ListOfRows
    End Function

    Public Sub saveGridLayout(ByRef SecureID As Integer, ByRef UserID As String,
                                ByRef ScreenName As String,
                                ByRef GridName As String,
                                ByRef ColName As String,
                                ByRef ColOrder As Integer,
                                ByRef ColWidth As Integer,
                                ByRef ColVisible As Boolean,
                                ByRef ColReadOnly As Boolean,
                                ByRef ColSortOrder As Integer,
                                ByRef ColSortAsc As Boolean,
                                ByRef HiveConnectionName As String,
                                ByRef HiveActive As Boolean,
                                ByRef RepoSvrName As String,
                                ByRef RowCreationDate As Date,
                                ByRef RowLastModDate As Date,
                                ByRef RowNbr As Integer,
                                ByRef RC As Boolean,
                                ByRef rMsg As String) Implements IService1.saveGridLayout

        DB.saveGridLayout(SecureID, UserID,
                         ScreenName,
                         GridName,
                         ColName,
                         ColOrder,
                         ColWidth,
                         ColVisible,
                         ColReadOnly,
                         ColSortOrder,
                         ColSortAsc,
                         HiveConnectionName,
                         HiveActive,
                         RepoSvrName,
                         RowCreationDate,
                         RowLastModDate,
                         RowNbr,
                         RC,
                         rMsg)

    End Sub

    Public Function getGridLayout(ByRef SecureID As Integer, ByVal UID As String, ByVal ScreenName As String, GridName As String, ByVal DICT As Dictionary(Of String, String), ByRef rMsg As String, ByRef RC As Boolean, ByVal HiveConnectionName As String, ByVal HiveActive As Boolean, ByVal RepoSvrName As String) As List(Of DS_clsUSERGRIDSTATE) Implements IService1.getGridLayout
        Dim ListOfRows As List(Of DS_clsUSERGRIDSTATE) = New List(Of DS_clsUSERGRIDSTATE)()
        ListOfRows = DB.getGridLayout(SecureID, UID, ScreenName, GridName, DICT, rMsg, RC, HiveConnectionName, HiveActive, RepoSvrName)
        Return ListOfRows
    End Function

    Public Sub saveScreenState(ByRef SecureID As Integer, ByVal UID As String, ByVal ScreenName As String, ByVal DICT As Dictionary(Of String, String), ByRef rMsg As String, ByRef RC As Boolean, ByVal HiveConnectionName As String, ByVal HiveActive As Boolean, ByVal RepoSvrName As String) Implements IService1.saveScreenState
        'Dim DB As New clsDatabase
        DB.saveScreenState(SecureID, UID, ScreenName, DICT, rMsg, RC, HiveConnectionName, HiveActive, RepoSvrName)
        'DB = Nothing
    End Sub

    Public Function getScreenState(ByRef SecureID As Integer, ByVal UID As String, ByVal ScreenName As String, ByRef DICT As Dictionary(Of String, String), ByRef rMsg As String, ByRef RC As Boolean, ByVal HiveConnectionName As String, ByVal HiveActive As Boolean, ByVal RepoSvrName As String) As List(Of DS_USERSCREENSTATE) Implements IService1.getScreenState
        Dim ListOfRows As New List(Of DS_USERSCREENSTATE)
        ListOfRows = DB.getScreenState(SecureID, UID, ScreenName, DICT, rMsg, RC, HiveConnectionName, HiveActive, RepoSvrName)
        'DB = Nothing
        Return ListOfRows
    End Function

    Public Function xGetXrtID(CustomerID As String, ServerName As String, DBName As String, InstanceName As String) As Integer Implements IService1.xGetXrtID
        Dim rid As Integer = DB.xGetXrtID(CustomerID, ServerName, DBName, InstanceName)
        Return rid
    End Function

    Public Sub getUserParms(ByRef SecureID As Integer, ByVal UserID As String, ByRef UserParms As Dictionary(Of String, String)) Implements IService1.getUserParms
        DB.getUserParms(SecureID, UserID, UserParms)
    End Sub

    Public Sub ParseLicDictionary(ByRef SecureID As Integer, ByVal S As String, ByRef D As Dictionary(Of String, String)) Implements IService1.ParseLicDictionary
        Dim LM As New clsLicenseMgt()
        LM.ParseLicDictionary(S, D)
        LM = Nothing
    End Sub

    Public Function LicenseType(ByVal SecureID As Integer, ByRef RC As Boolean, ByRef RetMsg As String) As String Implements IService1.LicenseType
        Dim LM As New clsLicenseMgt()
        Dim S As String = LM.LicenseType(SecureID, RC, RetMsg)
        LM = Nothing
        Return S
    End Function

    Public Function GetNbrUsers(ByRef SecureID As Integer) As Integer Implements IService1.GetNbrUsers
        Dim I As Integer = DB.GetNbrUsers(SecureID)
        Return I
    End Function

    Function isLease(ByVal SecureID As Integer, ByRef RC As Boolean, ByRef RetMsg As String) As Boolean Implements IService1.isLease
        Dim LM As New clsLicenseMgt()
        Dim B As Boolean = LM.isLease(SecureID, RC, RetMsg)
        LM = Nothing
        Return B
    End Function

    Public Function getMaxClients(ByVal SecureID As Integer, ByRef RC As Boolean, ByRef RetMsg As String) As Integer Implements IService1.getMaxClients
        Dim LM As New clsLicenseMgt()
        Dim I As Integer = LM.getMaxClients(SecureID, RC, RetMsg)
        LM = Nothing
        Return I
    End Function

    Public Function GetUserHostName(ByRef SecureID As Integer) As String Implements IService1.GetUserHostName
        Dim S As String = ""
        S = System.Web.HttpContext.Current.Request.UserHostName.ToString
        Return S
    End Function

    Public Function GetUserHostAddress(ByRef SecureID As Integer) As String Implements IService1.GetUserHostAddress
        Dim S As String = ""
        S = System.Web.HttpContext.Current.Request.UserHostAddress
        Return S
    End Function

    Public Function getUserGuidID(ByRef SecureID As Integer, ByVal UserLoginId As String) As String Implements IService1.getUserGuidID
        Dim UserGuid As String = DB.getUserGuidID(SecureID, UserLoginId)
        Return UserGuid
    End Function

    Public Function ProcessDates(ByRef SecureID As Integer) As Dictionary(Of String, Date) Implements IService1.ProcessDates
        Dim D As New Dictionary(Of String, Date)
        D = DB.ProcessDates(SecureID)
        Return D
    End Function

    Public Function GetNbrMachineAll(ByRef SecureID As Integer) As Integer Implements IService1.GetNbrMachineAll
        Dim I As Integer = DB.GetNbrMachine(SecureID)
        Return I
    End Function

    Public Function GetNbrMachine(ByRef SecureID As Integer, ByVal MachineName As String) As Integer Implements IService1.GetNbrMachine
        Dim I As Integer = DB.GetNbrMachine(SecureID, MachineName)
        Return I
    End Function

    Public Function isLicenseLocatedOnAssignedMachine(ByRef SecureID As Integer, ByRef ServerValText As String, ByRef InstanceValText As String, ByRef RC As Boolean, ByRef RetMsg As String) As Boolean Implements IService1.isLicenseLocatedOnAssignedMachine
        Dim LIC As New clsLicenseMgt()
        RC = LIC.isLicenseLocatedOnAssignedMachine(ServerValText, InstanceValText, SecureID, RC, RetMsg)
        LIC = Nothing
        Return RC
    End Function

    Public Function GetXrtTest(dt As Date) As String Implements IService1.GetXrtTest
        Return "Executed GetXrtTest: " + dt.ToString()
    End Function

    Public Function GetXrt(ByRef SecureID As Integer, ByVal RC As Boolean, ByVal RetMsg As String) As String Implements IService1.GetXrt
        'Dim LIC As New clsLicenseMgt()
        'Dim S As String = LIC.GetXrt(SecureID, RC, RetMsg)
        'LIC = Nothing
        Dim S As String = DB.GetXrt(SecureID, RC, RetMsg)
        Return S
    End Function

    Public Function getSqlServerVersion(ByRef SecureID As Integer) As String Implements IService1.getSqlServerVersion
        Dim S As String = DB.getSqlServerVersion(SecureID)
        Return S
    End Function

    Public Sub RecordGrowth(ByRef SecureID As Integer, ByRef RC As Boolean) Implements IService1.RecordGrowth
        DB.RecordGrowth(SecureID, RC)
    End Sub

    Public Function ParseLic(ByRef SecureID As Integer, ByVal LT As String, ByVal tgtKey As String) As String Implements IService1.ParseLic
        Dim S As String = ""
        Dim LM As New clsLicenseMgt()
        S = LM.ParseLic(LT$, "txtCustID")
        LM = Nothing
        Return S
    End Function

    Public Function getDBSIZEMB(ByRef SecureID As Integer) As Double Implements IService1.getDBSIZEMB
        Dim D As Double = DB.getDBSIZEMB(SecureID)
        Return D
    End Function

    Public Function GetLoggedinUserName(ByRef SecureID As Integer) As String Implements IService1.GetLoggedinUserName
        Dim UTIL As New clsUtilitySVR
        Dim UNAME As String = UTIL.GetLoggedinUserName()
        Return UNAME
    End Function

    Public Sub resetMissingEmailIds(ByRef SecureID As Integer, ByVal CurrUserGuidID As String, ByRef RC As Boolean) Implements IService1.resetMissingEmailIds
        DB.resetMissingEmailIds(SecureID, CurrUserGuidID, RC)
    End Sub

    Public Sub UserParmInsertUpdate(ByRef SecureID As Integer, ByVal ParmName As String, ByVal UserID As String, ByVal ParmVal As String, ByRef RC As Boolean) Implements IService1.UserParmInsertUpdate
        DB.UserParmInsertUpdate(SecureID, ParmName, UserID, ParmVal, RC)
    End Sub

    Public Function validateLogin(ByRef SecureID As Integer, ByVal UserLogin As String, ByVal PW As String, ByRef UserGuidID As String) As Boolean Implements IService1.validateLogin
        Dim RC As Boolean = False
        Dim B As Boolean = DB.validateLogin(SecureID, UserLogin, PW, UserGuidID)
        Return B
    End Function

    Public Function getLoggedInUser(ByRef SecureID As Integer) As String Implements IService1.getLoggedInUser
        Return DB.getLoggedInUser(SecureID)
    End Function

    Public Function getAttachedMachineName(ByRef SecureID As Integer) As String Implements IService1.getAttachedMachineName
        Return DB.getAttachedMachineName(SecureID)
    End Function

    Public Function getServerInstanceName(ByRef SecureID As Integer) As String Implements IService1.getServerInstanceName
        Return DB.getServerInstanceName(SecureID)
    End Function

    Public Function getServerMachineName(ByRef SecureID As Integer) As String Implements IService1.getServerMachineName
        Return DB.getServerMachineName(SecureID)
    End Function

    Public Sub getSystemParm(ByRef SecureID As Integer, ByRef SystemParms As Dictionary(Of String, String)) Implements IService1.getSystemParm
        DB.getSystemParm(SecureID, SystemParms)
    End Sub

    Public Function getSynonyms(ByRef SecureID As Integer, ByVal ThesaurusID As String, ByVal Token As String, ByRef lbSynonyms As String) As String Implements IService1.getSynonyms
        Dim DBSQL As New clsDb
        Dim S As String = DBSQL.getSynonyms(SecureID, ThesaurusID, Token, lbSynonyms)
        DBSQL = Nothing
        Return S
    End Function

    Public Function getThesaurusID(ByRef SecureID As Integer, ByVal ThesaurusName As String) As String Implements IService1.getThesaurusID
        Dim DBSQL As New clsDb
        Dim S As String = DB.getThesaurusID(SecureID, ThesaurusName)
        DBSQL = Nothing
        Return S
    End Function

    Public Function iCountContent(ByRef SecureID As Integer, ByVal MySql As String) As Integer Implements IService1.iCountContent
        Dim I As Integer
        I = DB.iCountContent(SecureID, MySql)
        Return I
    End Function

    Public Function getDatasourceParm(ByRef SecureID As Integer, ByVal AttributeName As String, ByVal SourceGuid As String) As String Implements IService1.getDatasourceParm
        Dim S As String = ""
        S = DB.getDatasourceParm(SecureID, AttributeName, SourceGuid)
        Return S
    End Function

    Public Function SaveRunParm(ByRef SecureID As Integer, ByVal UserID As String, ByRef ParmID As String, ByRef ParmVal As String) As Boolean Implements IService1.SaveRunParm
        Dim B As Boolean = False
        B = DB.SaveRunParm(SecureID, UserID, ParmID, ParmVal)
        Return B
    End Function

    Public Function iGetRowCount(ByRef SecureID As Integer, ByVal TBL As String, ByVal WhereClause As String) As Integer Implements IService1.iGetRowCount
        Dim I As Integer = DB.iGetRowCount(TBL, WhereClause)
        Return I
    End Function

    Public Function ZeroizeGlobalSearch(ByRef SecureID As Integer) As Boolean Implements IService1.ZeroizeGlobalSearch
        Dim B As Boolean
        B = DB.ZeroizeGlobalSearch(SecureID)
        Return B
    End Function

    Public Sub UpdateIP(ByRef SecureID As Integer, ByVal HostName As String, ByVal IP As String, ByVal checkCode As Integer, ByRef RC As Boolean) Implements IService1.updateIp
        DB.UpdateIP(SecureID, HostName, IP, checkCode, RC)
    End Sub

    Public Function PopulateSourceGridWithWeights(ByRef SecureID As Integer, ByVal StartingRow As Integer, ByVal EndingRow As Integer, ByVal CallerName As String, ByVal MySql As String, ByRef bNewRows As Boolean, ByRef SourceRowCnt As Integer) As List(Of DS_CONTENT) Implements IService1.PopulateSourceGridWithWeights
        Dim ListOfRows As New List(Of DS_CONTENT)
        ListOfRows = DB.PopulateSourceGridWithWeights(SecureID, StartingRow, EndingRow, CallerName, MySql, bNewRows, SourceRowCnt)
        Return ListOfRows
    End Function

    Public Function PopulateSourceGridNoWeights(ByRef SecureID As Integer, ByVal StartingRow As Integer, ByVal EndingRow As Integer, ByVal CallerName As String, ByVal MySql As String, ByRef bNewRows As Boolean, ByRef SourceRowCnt As Integer) As List(Of DS_CONTENT) Implements IService1.PopulateSourceGridNoWeights
        Dim ListOfRows As New List(Of DS_CONTENT)
        ListOfRows = DB.PopulateSourceGridNoWeights(SecureID, StartingRow, EndingRow, CallerName, MySql, bNewRows, SourceRowCnt)
        Return ListOfRows
    End Function

    Public Function PopulateEmailGridWithNoWeights(ByRef SecureID As Integer, ByVal UID As String, ByVal CallerName As String, ByVal MySql As String, ByVal nbrWeightMin As String, ByVal StartingRow As Integer, ByVal EndingRow As Integer, ByRef bNewRows As Boolean, ByRef EmailRowCnt As Integer) As List(Of DS_EMAIL) Implements IService1.PopulateEmailGridWithNoWeights
        Dim ListOfRows As New List(Of DS_EMAIL)
        ListOfRows = DB.PopulateEmailGridWithNoWeights(SecureID, UID, CallerName, MySql, StartingRow, EndingRow, bNewRows, EmailRowCnt)
        Return ListOfRows
    End Function

    Function PopulateEmailGridWithWeights(ByRef SecureID As Integer, ByVal UserID As String, ByVal CallerName As String, ByVal MySql As String, ByVal nbrWeightMin As String, ByVal StartingRow As Integer, ByVal EndingRow As Integer, ByRef bNewRows As Boolean, ByRef EmailRowCnt As Integer) As List(Of DS_EMAIL) Implements IService1.PopulateEmailGridWithWeights
        Dim ListOfRows As New List(Of DS_EMAIL)
        ListOfRows = DB.PopulateEmailGridWithWeights(SecureID, UserID, CallerName, MySql, nbrWeightMin, StartingRow, EndingRow, bNewRows, EmailRowCnt)
        Return ListOfRows
    End Function

    Public Sub LoadUserSearchHistory(ByRef SecureID As Integer, ByVal MaxNbrSearches As Integer, ByVal Uid As String, ByVal Screen As String, ByRef SearchHistoryArrayList As List(Of String), ByRef NbrReturned As Integer) Implements IService1.LoadUserSearchHistory
        DB.LoadUserSearchHistory(SecureID, MaxNbrSearches, Uid, Screen, SearchHistoryArrayList, NbrReturned)
    End Sub

    Public Sub getAttachmentWeights(ByRef SecureID As Integer, ByRef SL As Dictionary(Of String, Integer), ByVal UserID As String) Implements IService1.getAttachmentWeights
        DB.getAttachmentWeights(SecureID, SL, UserID)
    End Sub

    Public Function DBExecuteEncryptedSql(ByRef SecureID As Integer, ByRef MySql As String, ByVal EKEY As String) As Boolean Implements IService1.DBExecuteEncryptedSql
        Dim B As Boolean = False
        B = DB.DBExecuteEncryptedSql(SecureID, MySql, EKEY)
        Return B
    End Function

    Public Function ExecuteSqlNewConnSecure(ByRef SecureID As Integer, ByRef EncryptedMySql As String, UserID As String, ContractID As String) As Boolean Implements IService1.ExecuteSqlNewConnSecure
        'Dim ENCX As New ECMEncrypt

        Try
            Dim MySql = ENC.AES256DecryptString(EncryptedMySql)
            If MySql Is Nothing Then
                LOG.WriteToErrorLog("ERRor 1200: Encryption failure")
                Return False
            End If
            Dim B As Boolean = DB.DBExecuteSql(1200, MySql)
            If Not B Then
                LOG.WriteToErrorLog("ERRor 2112A: ExecuteSqlNewConnSecure failed - SQL: " + vbCrLf + MySql)
            End If
            Return B
        Catch ex As Exception
            LOG.WriteToErrorLog("ERRor 2112B: " + ex.Message)
        End Try
        'ENCX = Nothing
    End Function

    Public Function ExecuteSqlNewConn1(ByRef SecureID As Integer, ByRef EncryptedMySql As String, UserID As String, ContractID As String) As Boolean Implements IService1.ExecuteSqlNewConn1
        Dim MySql = ENC.AES256DecryptString(EncryptedMySql)
        Dim B As Boolean = False
        B = DB.DBExecuteSql(SecureID, MySql)
        Return B
    End Function

    Public Function ExecuteSqlNewConn2(ByRef SecureID As Integer, ByRef EncryptedMySql As String, UserID As String, ContractID As String) As Boolean Implements IService1.ExecuteSqlNewConn2
        Dim MySql = ENC.AES256DecryptString(EncryptedMySql)
        Dim B As Boolean = False
        B = DB.DBExecuteSql(SecureID, MySql)
        Return B
    End Function

    Public Function ExecuteSqlNewConn3(ByRef SecureID As Integer, ByRef EncryptedMySql As String, UserID As String, ContractID As String) As Boolean Implements IService1.ExecuteSqlNewConn3
        Dim MySql = ENC.AES256DecryptString(EncryptedMySql)
        Dim B As Boolean = False
        B = DB.DBExecuteSql(SecureID, MySql)
        Return B
    End Function

    Public Function ExecuteSqlNewConn4(ByRef SecureID As Integer, ByRef EncryptedMySql As String, UserID As String, ContractID As String) As Boolean Implements IService1.ExecuteSqlNewConn4
        Dim MySql = ENC.AES256DecryptString(EncryptedMySql)
        Dim B As Boolean = False
        B = DB.DBExecuteSql(SecureID, MySql)
        Return B
    End Function

    Public Function ExecuteSqlNewConn5(ByRef SecureID As Integer, ByRef EncryptedMySql As String, UserID As String, ContractID As String) As Boolean Implements IService1.ExecuteSqlNewConn5
        Dim MySql = ENC.AES256DecryptString(EncryptedMySql)
        Dim B As Boolean = False
        B = DB.DBExecuteSql(SecureID, MySql)
        Return B
    End Function

    Public Sub GetParmValue(ByRef SecureID As Integer, ByVal UID As String, ByRef Parms As List(Of String)) Implements IService1.GetParmValue
        DB.GetParmValue(SecureID, UID, Parms)
    End Sub

    Public Function DBisGlobalSearcher(ByRef SecureID As Integer, ByVal Userid As String) As Boolean Implements IService1.DBisGlobalSearcher
        Dim B As Boolean = False
        B = DBisGlobalSearcher(SecureID, Userid)
        Return B
    End Function

    Public Function DBisAdmin(ByRef SecureID As Integer, ByVal Userid As String) As Boolean Implements IService1.DBisAdmin
        Dim B As Boolean = False
        B = DBisAdmin(SecureID, Userid)
        Return B
    End Function

    Public Sub getUserParm(ByRef SecureID As Integer, ByRef sVariableToFetch As String, ByVal UserParm As String) Implements IService1.getUserParm
        Dim S As String = ""
        S = DB.getUserParm(SecureID, UserParm)
        sVariableToFetch = S
    End Sub

    Public Sub RemoveUnwantedCharacters(ByRef SecureID As Integer, ByRef tgtString As String) Implements IService1.RemoveUnwantedCharacters
        Dim UTIL As New clsUtilitySVR
        Dim S As String = UTIL.RemoveUnwantedCharacters(tgtString)
        tgtString = S
    End Sub

    Public Function GetMachineIP(ByRef SecureID As Integer) As String Implements IService1.GetMachineIP
        Dim S As String = ""
        Dim UTIL As New clsUtilitySVR
        S = UTIL.GetMachineIP()
        UTIL = Nothing
        Return S
    End Function

    Public Function getClientLicenses(ByRef SecureID As Integer, ByVal CompanyID As String, ByRef ErrorMessage As String, ByRef RC As Boolean) As List(Of DS_License) Implements IService1.getClientLicenses

        Dim L As List(Of DS_License)

        Dim RS As New clsRemoteSupport(SecureID)
        L = RS.getClientLicenses(SecureID, CompanyID, ErrorMessage, RC)
        RS = Nothing
        GC.Collect()

        Return L

    End Function

    Public Function getListOfStrings01(ByRef SecureID As Integer, ByVal MySql As String, ByRef RC As Boolean, ByRef RetMsg As String, UserId As String, SessionID As String) As String Implements IService1.getListOfStrings01
        MySql = ENC.AES256DecryptString(MySql)
        Return DB.getListOfStrings01(SecureID, MySql, RC, RetMsg)
    End Function

    Public Function getListOfStrings02(ByRef SecureID As Integer, ByVal MySql As String, ByRef RC As Boolean, ByRef RetMsg As String, UserId As String, SessionID As String) As List(Of DS_ListOfStrings02) Implements IService1.getListOfStrings02
        MySql = ENC.AES256DecryptString(MySql)
        Return DB.getListOfStrings02(SecureID, MySql, RC, RetMsg)
    End Function

    Public Function getListOfStrings03(ByRef SecureID As Integer, ByVal MySql As String, ByRef RC As Boolean, ByRef RetMsg As String, UserId As String, SessionID As String) As List(Of DS_ListOfStrings03) Implements IService1.getListOfStrings03
        MySql = ENC.AES256DecryptString(MySql)
        Return DB.getListOfStrings03(SecureID, MySql, RC, RetMsg)
    End Function

    Public Function getListOfStrings04(ByRef SecureID As Integer, ByVal MySql As String, ByRef RC As Boolean, ByRef RetMsg As String, UserId As String, SessionID As String) As List(Of DS_ListOfStrings04) Implements IService1.getListOfStrings04
        MySql = ENC.AES256DecryptString(MySql)
        Return DB.getListOfStrings04(SecureID, MySql, RC, RetMsg)
    End Function

    Public Function getContentDT(sourceguid As String) As DataTable Implements IService1.getContentDT
        Dim DT As DataTable = DB.getContentDT(sourceguid)
        Return DT
    End Function

End Class