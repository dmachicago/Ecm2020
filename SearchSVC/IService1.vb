Imports System.Runtime.Serialization
Imports System.ServiceModel

' NOTE: You can use the "Rename" command on the context menu to change the interface name "IService1"
'       in both code and config file together.
<ServiceContract()>
Public Interface IService1

    <OperationContract>
    Function getSourceLength(ByVal SourceGuid As String, SourceType As String) As Int64

    <OperationContract>
    Function getSourceName(ByVal SourceGuid As String, SourceType As String) As String

    <OperationContract>
    Function DownLoadDocument(ByRef TypeImage As String, ByVal SourceGuid As String) As Byte()

    <OperationContract>
    Function GetAttachmentFromDB(ByRef SecureID As Integer, ByVal EmailGuid As String) As Byte()

    <OperationContract>
    Function getContentDT(sourceguid As String) As DataTable

    <OperationContract>
    Function TestIISConnection() As String

    <OperationContract>
    Function TestConnection() As String

    <OperationContract>
    Function getWordInflections(QRY As String, CS As String) As String

    <OperationContract>
    Function removeExpiredAlerts() As Boolean

    <OperationContract>
    Function ChangeUserPasswordAdmin(AdminUserID As String, ByVal UserLogin As String, ByVal NewPw1 As String, ByVal NewPw2 As String) As Boolean

    <OperationContract>
    Function AddUserGroup(ByVal GroupName As String, ByVal GroupOwnerUserID As String) As Boolean

    ''' <summary>
    '''   <br />
    ''' </summary>
    ''' <param name="MaxNbr"></param>
    <OperationContract>
    Function getErrorLogs(MaxNbr As String) As String

    <OperationContract>
    Sub SetEmailPublicFlag(ByRef SecureID As Integer, ByVal EmailGuid As String, ByVal isPublic As Boolean)

    <OperationContract>
    Sub SetDocumentToMaster(ByRef SecureID As Integer, ByVal SourceGuid As String, ByVal MasterFlag As Boolean)

    <OperationContract>
    Sub SetDocumentPublicFlag(ByRef SecureID As Integer, ByVal SourceGuid As String, ByVal isPublic As Boolean)

    <OperationContract>
    Function ExecuteSearchJson(TypeSearch As String, ByVal JsonSearchParms As String, ByRef RetMsg As String) As String

    <OperationContract>
    Function testServiceAvail() As String

    <OperationContract>
    Function GenerateSearchSQL(ByVal TypeSearch As String, ByVal SearchParmList As Dictionary(Of String, String)) As String

    <OperationContract>
    Function ExecuteSearchDT(SearchType As String,
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
                ByRef ContentRowCnt As Integer) As DataSet

    <OperationContract>
    Function GetFilesInZipDetail(ByRef SecureID As Integer, ByVal ParentGuid As String, ByRef RC As Boolean) As String

    <OperationContract>
    Function xGetXrtID(CustomerID As String, ServerName As String, DBName As String, InstanceName As String) As Integer

    <OperationContract>
    Function getSecEndPoint() As String

    <OperationContract>
    Function getContractID(SecureID As Integer, UserID As String) As String

    <OperationContract>
    Sub AddGroupLibraryAccess(SecureID As Integer, UserID As String, LibraryName As String, GroupName As String, GroupOwnerUserID As String, ByRef RC As Boolean, CurrUserID As String, SessionID As String, ControlSection As String)

    <OperationContract>
    Function AddGroupUser(SecureID As Integer, SessionID As String, CurrUserID As String, UserID As String, FullAccess As String, ReadOnlyAccess As String, DeleteAccess As String, Searchable As String, GroupOwnerUserID As String, GroupName As String, ControlSection As String) As Boolean

    '<OperationContract>
    'Function EncryptTripleDES(SecureID As Integer, ByVal Phrase As String, ByVal shiftKey As String) As String
    '<OperationContract>
    'Function EncryptTripleDES(SecureID As Integer, ByVal Phrase As String, ByVal shiftKey As String) As String

    <OperationContract>
    Function DBExecuteEncryptedSql(ByRef SecureID As Integer, ByRef MySql As String, ByVal EKEY As String) As Boolean

    <OperationContract>
    Function validateAttachSecureLogin(ByRef SecureID As Integer,
                                             ByVal CompanyID As String,
                                               ByVal RepoID As String,
                                               ByVal UserLogin As String,
                                               ByVal PW As String,
                                               ByRef RC As Boolean,
                                               ByRef RetMsg As String, ByRef GateWayEndPoint As String, ByRef DownloadEndpoint As String, ByRef ENCCS As String) As Boolean

    <OperationContract>
    Function GetXrtTest(dt As Date) As String

    <OperationContract()>
    Sub ckContentFlags(SecureID As Integer, SourceGuid As String, ByRef SD As Boolean, ByRef SP As Boolean, ByRef SAP As Boolean, ByRef bMaster As Boolean, ByRef RSS As Boolean, ByRef WEB As Boolean, ByRef bPublic As Boolean)

    '<OperationContract()>
    'Function getGatewayCS(SecureID As Integer, CompanyID As String, RepoID As String, PW As String, ByRef RetMsg As String, ByRef RC As Boolean) As String

    <OperationContract()>
    Function getCustomerLogoTitle() As String

    <OperationContract()>
    Function getExplodeEmailZip() As String

    <OperationContract()>
    Function getFacilityName() As String

    <OperationContract()>
    Function getAffinitydelay() As Integer

    <OperationContract()>
    Function getClcURL() As String

    <OperationContract()>
    Function getArchiverURL() As String

    <OperationContract()>
    Function ExecuteSqlStack(ByRef SecureID As Integer, ByRef SqlStack As Dictionary(Of Integer, String), UserID As String, SessionID As String, ControlSection As String) As Boolean

    <OperationContract()>
    Function getDefaultScreen(ByVal SecureID As Integer, ByVal UserID As String) As String

    <OperationContract()>
    Function RecallUserSearch(ByVal SecureID As Integer, ByVal SearchName As String, ByVal UID As String, ByRef strSearches As String) As Boolean

    <OperationContract()>
    Function SaveUserSearch(ByVal SecureID As Integer, ByVal SearchName As String, ByVal UID As String, ByVal strSearches As String) As Boolean

    '<OperationContract()>
    'Function GetFilesInZip(ByRef SecureID As Integer, ByVal ParentGuid As String, ByRef RC As Boolean) As String

    <OperationContract()>
    Function scheduleFileDownLoad(ByVal SecureID As Integer,
                                  ByVal ContentGuid As String,
                                  ByVal UserID As String,
                                  ByVal ContentType As String,
                                  ByVal Preview As Integer,
                                  ByVal Restore As Integer) As Boolean

    <OperationContract()>
    Function GetContentMetaData(ByVal SecureID As Integer, ByVal SourceGuid As String) As String

    <OperationContract()>
    Function removeRestoreFileByGuid(ByVal SecureID As Integer, ByVal RowGuid As String) As Boolean

    <OperationContract()>
    Function removeRestoreFiles(ByVal SecureID As Integer, ByRef UserID As String, ByRef MachineID As String) As Boolean

    <OperationContract()>
    Function getRestoreFileCount(ByVal SecureID As Integer, ByRef UserID As String, ByRef MachineID As String, ByRef Preview As Boolean) As Integer

    <OperationContract()>
    Function saveRestoreFile(ByVal SecureID As Integer, ByVal tgtTable As String, ByRef ContentGuid As String, ByVal Preview As Boolean, ByVal Restore As Boolean, ByRef UserID As String, ByRef MachineID As String, ByRef RC As Boolean, ByVal RetMsg As String) As Boolean

    <OperationContract()>
    Function GenEmailAttachmentsSQL(ByVal UserID As String, ByVal SearchParms As List(Of DS_SearchTerms), ByRef SecureID As Integer, ByVal InputSearchString As String,
        ByVal useFreetext As Boolean,
        ByVal ckWeighted As Boolean,
        ByVal isEmail As Boolean,
        ByVal LimitToCurrRecs As Boolean,
        ByVal ThesaurusList As ArrayList,
        ByVal txtThesaurus As String,
        ByVal cbThesaurusText As String, ByVal calledBy As String) As String

    <OperationContract()>
    Function GenEmailGeneratedSQL(UserID As String, ByVal SearchParms As List(Of DS_SearchTerms), ByRef SecureID As Integer) As String

    <OperationContract()>
    Function GenContentSearchSQL(UserID As String, ByVal SearchParms As List(Of DS_SearchTerms), ByRef SecureID As Integer, ByVal UID As String, ByVal SearchString As String, ByVal ckLimitToExisting As Boolean, ByVal txtThesaurus As String, ByVal cbThesaurusText As String, ByVal ckLimitToLib As Boolean, ByVal LibraryName As String, ByVal ckWeighted As Boolean) As String

    <OperationContract()>
    Sub ChangeUserContentPublic(ByVal ServiceID As Integer, ByVal CurrSelectedUserGuid As String, ByVal isPublic As String, ByRef RC As Boolean, ByRef RetMsg As String)

    <OperationContract()>
    Sub Refactor(ByVal SecureID As Integer, ByVal NewOwnerID As String, ByVal OldOwnerID As String, ByRef RC As Boolean, ByRef RetMsg As String)

    <OperationContract()>
    Function getSAASState(ByVal SecureID As Integer, ByVal UserID As String, ByVal DirName As String, ByVal FullPath As String, ByRef RetMsg As String, ByRef RC As Boolean) As String

    <OperationContract()>
    Function SetSAASState(ByVal SecureID As Integer, ByVal UserID As String, ByVal DirName As String, ByVal FullPath As String) As Boolean

    <OperationContract()>
    Function getListOfStrings01(ByRef SecureID As Integer, ByVal MySql As String, ByRef RC As Boolean, ByRef RetMsg As String, UserId As String, SessionID As String) As String

    <OperationContract()>
    Function getListOfStrings02(ByRef SecureID As Integer, ByVal MySql As String, ByRef RC As Boolean, ByRef RetMsg As String, UserId As String, SessionID As String) As List(Of DS_ListOfStrings02)

    <OperationContract()>
    Function getListOfStrings03(ByRef SecureID As Integer, ByVal MySql As String, ByRef RC As Boolean, ByRef RetMsg As String, UserId As String, SessionID As String) As List(Of DS_ListOfStrings03)

    <OperationContract()>
    Function getListOfStrings04(ByRef SecureID As Integer, ByVal MySql As String, ByRef RC As Boolean, ByRef RetMsg As String, UserId As String, SessionID As String) As List(Of DS_ListOfStrings04)

    <OperationContract()>
    Function PopulateLibraryUsersGrid(ByRef SecureID As Integer, ByVal LibraryName As String, ByVal ckLibUsersOnly As Boolean) As String

    <OperationContract()>
    Function getUserAuth(ByRef SecureID As Integer, ByVal Userid As String) As String

    <OperationContract()>
    Function DeleteUser(ByRef SecureID As Integer, ByVal SelectedUserGuid As String, ByRef RetMsg As String) As Boolean

    <OperationContract()>
    Function SaveUSer(ByVal SecureID As Integer, ByRef UserID As String, ByRef UserName As String, ByRef EmailAddress As String,
                      ByRef UserPassword As String, ByRef Admin As String, ByRef isActive As String,
                      ByRef UserLoginID As String, ByRef ClientOnly As Boolean, ByRef HiveConnectionName As String,
                      ByRef HiveActive As Boolean, ByRef RepoSvrName As String, ByRef RowCreationDate As Date, ByRef RowLastModDate As Date,
                      ByRef ActiveGuid As String, ByRef RepoName As String, ByRef RC As Boolean, ByRef RetMsg As String) As Boolean

    <OperationContract()>
    Function saveSearchSchedule(ByVal SecureID As Integer, ByRef SearchName As String, ByRef NotificationSMS As String, ByRef SearchDesc As String, ByRef OwnerID As String, ByRef SearchQuery As String, ByRef SendToEmail As String, ByRef ScheduleUnit As String, ByRef ScheduleHour As String, ByRef ScheduleDaysOfWeek As String, ByRef ScheduleDaysOfMonth As String, ByRef ScheduleMonthOfQtr As String, ByRef StartToRunDate As Date, ByRef EndRunDate As Date, ByRef SearchParameters As String, ByRef LastRunDate As Date, ByRef NumberOfExecutions As Integer, ByRef CreateDate As Date, ByRef LastModDate As Date, ByRef ScheduleHourInterval As Integer, ByRef RepoName As String, ByRef RC As Boolean, ByRef RetMsg As String) As Boolean

    <OperationContract()>
    Function getSearchSchedule(ByVal SecureID As Integer, ByRef SearchName As String, ByRef NotificationSMS As String, ByRef SearchDesc As String, ByRef OwnerID As String, ByRef SearchQuery As String, ByRef SendToEmail As String, ByRef ScheduleUnit As String, ByRef ScheduleHour As String, ByRef ScheduleDaysOfWeek As String, ByRef ScheduleDaysOfMonth As String, ByRef ScheduleMonthOfQtr As String, ByRef StartToRunDate As Date, ByRef EndRunDate As Date, ByRef SearchParameters As String, ByRef LastRunDate As Date, ByRef NumberOfExecutions As Integer, ByRef CreateDate As Date, ByRef LastModDate As Date, ByRef ScheduleHourInterval As Integer, ByRef RepoName As String, ByRef RC As Boolean, ByRef RetMsg As String) As Boolean

    <OperationContract()>
    Function InsertCoOwner(ByVal SecureID As Integer, ByVal CurrentOwner As String, ByVal CoOwner As String) As Boolean

    <OperationContract()>
    Function PopulateCoOwnerGrid(ByVal SecureID As Integer, ByVal UID As String) As String

    <OperationContract()>
    Function PopulateUserGrid(ByRef SecureID As Integer, ByVal UserID As String, ByVal DBisAdmin As Boolean) As System.Collections.Generic.List(Of DS_VUserGrid)

    <OperationContract()>
    Sub getGroupUsers(ByRef SecureID As Integer, ByVal GroupName As String, ByRef GroupList As ArrayList, ByRef RC As Boolean, ByRef RetMsg As String)

    <OperationContract()>
    Function PopulateDgGroupUsers(ByRef SecureID As Integer, ByVal OwnerUserGuidID As String, ByVal GroupName As String) As String

    <OperationContract()>
    Function DeleteGroupUsers(SecureID As Integer, ByVal CurrSelectedGroupName As String,
                              ByVal GroupOwnerGuid As String,
                              ByVal UserID As String, ByRef iDeleted As Integer, ByRef RetMsg As String) As Boolean

    <OperationContract()>
    Function getGroupOwnerGuidByGroupName(ByRef SecureID As Integer, ByVal GroupName As String) As String

    <OperationContract()>
    Sub AddLibraryGroupUser(ByRef SecureID As Integer, ByVal GroupName As String, ByRef RC As Boolean, CurrUserID As String, SessionID As String, ControlSection As String)

    <OperationContract()>
    Function PopulateGroupUserGrid(ByRef SecureID As Integer, ByVal GroupName As String) As String

    <OperationContract()>
    Function PopulateLibItemsGrid(ByRef SecureID As Integer, ByVal LibraryName As String, ByVal UserID As String) As String

    <OperationContract()>
    Function PopulateDgAssigned(ByRef SecureID As Integer, ByVal LibraryName As String, ByVal UserID As String) As String

    <OperationContract()>
    Sub ResetLibraryUsersCount(ByRef SecureID As Integer, ByRef RC As Boolean)

    <OperationContract()>
    Sub DeleteLibraryGroupUser(ByRef SecureID As Integer, ByVal GroupName As String, ByVal LibraryName As String, ByRef RC As Boolean)

    <OperationContract()>
    Function ChangeUserPassword(ByRef SecureID As Integer, ByVal UserLogin As String, ByVal OldPW As String, ByVal NewPw1 As String, ByVal NewPw2 As String) As Boolean

    <OperationContract()>
    Sub SaveClickStats(SecureID As Integer, ByVal IID As Integer, ByVal UserID As String, ByRef RC As Boolean)

    <OperationContract()>
    Sub cleanUpLibraryItems(ByRef SecureID As Integer, ByVal UserID As String)

    <OperationContract()>
    Sub RemoveLibraryDirectories(ByRef SecureID As Integer, ByVal UserID As String, ByVal DirectoryName As String, ByVal LibraryName As String, ByRef RC As Boolean, ByRef RetMsg As String)

    <OperationContract()>
    Sub RemoveLibraryEmails(ByRef SecureID As Integer, ByVal FolderName As String, ByVal LibraryName As String, ByVal UserID As String, ByRef RC As Boolean, ByRef RetMsg As String)

    <OperationContract()>
    Sub AddSysMsg(ByRef SecureID As Integer, ByVal UserID As String, ByVal tMsg As String, ByVal RC As Boolean)

    <OperationContract()>
    Sub AddLibraryDirectory(ByRef SecureID As Integer, ByVal FolderName As String, ByVal LibraryName As String, ByVal UserID As String, ByRef RecordsAdded As Integer, ByRef RC As Boolean, ByRef RetMsg As String)

    <OperationContract()>
    Sub AddLibraryEmail(ByRef SecureID As Integer, ByVal EmailFolder As String, ByVal LibraryName As String, ByVal UserID As String, ByRef RecordsAdded As Integer, ByVal RC As Boolean, ByVal RetMsg As String)

    <OperationContract()>
    Function PopulateLibraryGrid(ByRef SecureID As Integer, ByVal UserID As String) As String

    <OperationContract()>
    Function getListOfStrings(ByRef SecureID As Integer, ByRef strListOfItems As String, ByVal MySql As String, ByRef RC As Boolean, ByRef RetMsg As String) As Boolean

    <OperationContract()>
    Function getListOfStrings1(ByRef SecureID As Integer, ByRef strListOfItems As String, ByVal MySql As String, ByRef RC As Boolean, ByRef RetMsg As String, UserId As String, SessionID As String) As Boolean

    <OperationContract()>
    Function getListOfStrings2(ByRef SecureID As Integer, ByRef strListOfItems As String, ByVal MySql As String, ByRef RC As Boolean, ByRef RetMsg As String, UserId As String, SessionID As String) As Boolean

    <OperationContract()>
    Function getListOfStrings3(ByRef SecureID As Integer, ByRef strListOfItems As String, ByVal MySql As String, ByRef RC As Boolean, ByRef RetMsg As String, UserId As String, SessionID As String) As Boolean

    <OperationContract()>
    Function getListOfStrings4(ByRef SecureID As Integer, strListOfItems As String, ByVal MySql As String, ByRef RC As Boolean, ByRef RetMsg As String, UserId As String, SessionID As String) As Boolean

    <OperationContract()>
    Function iCount(ByRef SecureID As Integer, ByVal S As String) As Integer

    <OperationContract()>
    Sub GetLogPath(ByRef tPath As String)

    <OperationContract()>
    Function ActiveSessionGetVal(ByRef SecureID As Integer, ByRef SessionGuid As Guid, ByRef ParmName As String) As String

    <OperationContract()>
    Function ActiveSession(ByRef SecureID As Integer, ByVal SessionGuid As Guid, ByVal ParmName As String, ByVal ParmValue As String) As Boolean

    <OperationContract()>
    Sub setSecureLoginParms(ByRef SecureID As Integer, ByVal sCompanyID As String, ByVal sRepoID As String, ByRef RC As Boolean)

    <OperationContract()>
    Sub PopulateSecureLoginCB_V2(ByRef SecureID As Integer, ByRef AllRepos As String, ByVal CompanyID As String, ByRef RC As Boolean, ByRef RetMsg As String)

    <OperationContract()>
    Sub PopulateSecureLoginCB(ByRef SecureID As Integer, ByRef CB As String, ByVal CompanyID As String, ByRef RC As Boolean, ByRef RetMsg As String)

    <OperationContract()>
    Function getLoginPW(ByRef SecureID As Integer) As Object

    <OperationContract()>
    Sub setLoginPW(ByRef SecureID As Integer, ByVal RepoID As String)

    <OperationContract()>
    Function getSessionEncCs(ByRef SecureID As Integer) As Object

    <OperationContract()>
    Sub setSessionEncCs(ByRef SecureID As Integer, ByVal MySessionID As String)

    <OperationContract()>
    Sub setSessionRepoID(ByRef SecureID As Integer, ByVal RepoID As String)

    <OperationContract()>
    Function getSessionRepoID(ByRef SecureID As Integer) As Object

    <OperationContract()>
    Sub setSessionCompanyID(ByRef SecureID As Integer, ByVal CompanyID As String, ByRef RC As Boolean)

    <OperationContract()>
    Function getSessionCompanyID(ByRef SecureID As Integer) As Object

    <OperationContract()>
    Sub setLoginGuid(ByRef SecureID As Integer, ByVal MyLoginGuid As String)

    <OperationContract()>
    Function getLoginGuid(ByRef SecureID As Integer) As Object

    <OperationContract()>
    Function getHttpSessionID(ByRef SecureID As Integer) As Object

    <OperationContract()>
    Sub setSessionID(ByRef SecureID As Integer, ByVal MySessionID As String)

    <OperationContract()>
    Function ExpandInflectionTerms(ByRef SecureID As Integer, ByVal S As String) As String

    <OperationContract()>
    Function getServerDatabaseName(ByRef SecureID As Integer) As String

    <OperationContract()>
    Sub CleanLog(ByRef SecureID As Integer)

    <OperationContract()>
    Sub PopulateComboBox(ByRef SecureID As Integer, ByRef CB As String(), ByVal TblColName As String, ByVal S As String)

    <OperationContract()>
    Function GetEmailAttachments(ByRef SecureID As Integer, ByVal CurrEmailGuid As String) As String

    <OperationContract()>
    Function DbWriteToFile(ByRef SecureID As Integer, ByVal UID As String, ByVal SourceGuid As String, ByRef FileName As String) As Boolean

    '<OperationBehavior()>
    'Function InsertSourcefile(ByVal SourceGuid As String, _
    '              ByVal UploadFQN As String, _
    '              ByVal SourceName As String, _
    '              ByVal SourceTypeCode As String, _
    '              ByVal sLastAccessDate As String, _
    '              ByVal sCreateDate As String, _
    '              ByVal sLastWriteTime As String, _
    '              ByVal DataSourceOwnerUserID As String, _
    '              ByVal VersionNbr As Integer) As Boolean

    <OperationContract()>
    Sub SetSessionVariable(ByRef SecureID As Integer, ByVal key As String, ByVal KeyValue As String)

    <OperationContract()>
    Function GetSessionVariable(ByRef SecureID As Integer, ByVal key As String) As Object

    <OperationContract()>
    Function UpdateSourceImageCompressed(ByRef SecureID As Integer, ByVal UploadFQN As String, ByVal SourceGuid As String, ByVal LastAccessDate As String, ByVal CreateDate As String, ByVal LastWriteTime As String, ByVal VersionNbr As Integer, ByVal CompressedDataBuffer() As Byte) As Boolean

    <OperationContract()>
    Sub writeEmailFromDbToFile(ByRef SecureID As Integer, ByVal EmailGuid As String, ByRef SourceTypeCode As String, ByRef CompressedDataBuffer() As Byte, ByRef OriginalSize As Integer, ByRef CompressedSize As Integer, ByRef RC As Boolean)

    <OperationContract()>
    Sub writeAttachmentFromDbWriteToFile(ByRef SecureID As Integer, ByVal RowID As String, ByRef FQN As String, ByRef CompressedDataBuffer() As Byte, ByRef OriginalSize As Integer, ByRef CompressedSize As Integer, ByRef RC As Boolean)

    <OperationContract()>
    Sub writeImageSourceDataFromDbWriteToFile(ByRef SecureID As Integer, ByVal SourceGuid As String, ByRef FQN As String, ByRef CompressedDataBuffer() As Byte, ByRef OriginalSize As Integer, ByRef CompressedSize As Integer, ByRef RC As Boolean)

    <OperationContract()>
    Sub AddLibraryItems(ByRef SecureID As Integer, ByVal SourceGuid As String,
                        ByVal ItemTitle As String,
                        ByVal ItemType As String,
                        ByVal LibraryItemGuid As String,
                        ByVal DataSourceOwnerUserID As String,
                        ByVal LibraryOwnerUserID As String,
                        ByVal LibraryName As String,
                        ByVal AddedByUserGuidId As String,
                        ByRef RC As Boolean, ByRef rMsg As String)

    <OperationContract()>
    Sub PopulateGroupUserLibCombo(ByRef SecureID As Integer, ByVal UID As String, ByRef cb As String)

    <OperationContract()>
    Function GetLibOwnerByName(ByRef SecureID As Integer, ByVal LibraryName As String) As String

    <OperationContract()>
    Function GenerateSQL(ByVal SearchParmList As SortedList(Of String, String), ByRef SecureID As Integer, TypeSQL As String) As String

    <OperationContract>
    Function getJsonData(I As String) As String

    <OperationContract>
    Function ExecuteSearchEmail(ByRef SecureID As Integer,
                ByRef currSearchCnt As Integer,
                ByVal bGenSql As Boolean,
                ByVal SearchParmsJson As String,
                ByRef bFirstEmailSearchSubmit As Boolean,
                ByRef EmailRowCnt As Integer) As String

    <OperationContract()>
    Function ExecuteSearchContent(ByRef SecureID As Integer,
                ByRef currSearchCnt As Integer,
                ByVal bGenSql As Boolean,
                ByVal SearchParmsJson As String,
                ByRef bFirstContentSearchSubmit As Boolean,
                ByRef ContentRowCnt As Integer) As String

    <OperationContract()>
    Function getSearchState(ByRef SecureID As Integer, ByVal SearchID As Integer, ByVal UID As String, ByVal ScreenName As String, ByRef DICT As Dictionary(Of String, String), ByRef rMsg As String, ByRef RC As Boolean, ByVal HiveConnectionName As String, ByVal HiveActive As Boolean, ByVal RepoSvrName As String) As List(Of DS_USERSEARCHSTATE)

    <OperationContract()>
    Sub saveSearchState(ByRef SecureID As Integer, ByVal SearchID As Integer, ByVal UID As String, ByVal ScreenName As String, ByVal DICT As Dictionary(Of String, String), ByRef rMsg As String, ByRef RC As Boolean, ByVal HiveConnectionName As String, ByVal HiveActive As Boolean, ByVal RepoSvrName As String)

    <OperationContract()>
    Function getScreenState(ByRef SecureID As Integer, ByVal UID As String, ByVal ScreenName As String, ByRef DICT As Dictionary(Of String, String), ByRef rMsg As String, ByRef RC As Boolean, ByVal HiveConnectionName As String, ByVal HiveActive As Boolean, ByVal RepoSvrName As String) As List(Of DS_USERSCREENSTATE)

    <OperationContract()>
    Function getGridLayout(ByRef SecureID As Integer, ByVal UID As String, ByVal ScreenName As String, GridName As String, ByVal DICT As Dictionary(Of String, String), ByRef rMsg As String, ByRef RC As Boolean, ByVal HiveConnectionName As String, ByVal HiveActive As Boolean, ByVal RepoSvrName As String) As List(Of DS_clsUSERGRIDSTATE)

    <OperationContract()>
    Sub saveGridLayout(ByRef SecureID As Integer, ByRef UserID As String,
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
                                ByRef rMsg As String)

    <OperationContract()>
    Sub saveScreenState(ByRef SecureID As Integer, ByVal UID As String, ByVal ScreenName As String, ByVal DICT As Dictionary(Of String, String), ByRef rMsg As String, ByRef RC As Boolean, ByVal HiveConnectionName As String, ByVal HiveActive As Boolean, ByVal RepoSvrName As String)

    <OperationContract()>
    Sub getUserParms(ByRef SecureID As Integer, ByVal UserID As String, ByRef UserParms As Dictionary(Of String, String))

    <OperationContract()>
    Sub ParseLicDictionary(ByRef SecureID As Integer, ByVal S As String, ByRef D As Dictionary(Of String, String))

    <OperationContract()>
    Function LicenseType(ByVal SecureID As Integer, ByRef RC As Boolean, ByRef RetMsg As String) As String

    <OperationContract()>
    Function GetNbrUsers(ByRef SecureID As Integer) As Integer

    <OperationContract()>
    Function isLease(ByVal SecureID As Integer, ByRef RC As Boolean, ByRef RetMsg As String) As Boolean

    <OperationContract()>
    Function getMaxClients(ByVal SecureID As Integer, ByRef RC As Boolean, ByRef RetMsg As String) As Integer

    <OperationContract()>
    Function GetUserHostName(ByRef SecureID As Integer) As String

    <OperationContract()>
    Function GetUserHostAddress(ByRef SecureID As Integer) As String

    <OperationContract()>
    Function getUserGuidID(ByRef SecureID As Integer, ByVal UserLoginId As String) As String

    <OperationContract()>
    Function ProcessDates(ByRef SecureID As Integer) As Dictionary(Of String, Date)

    <OperationContract()>
    Function GetNbrMachineAll(ByRef SecureID As Integer) As Integer

    <OperationContract()>
    Function GetNbrMachine(ByRef SecureID As Integer, ByVal MachineName As String) As Integer

    <OperationContract()>
    Function isLicenseLocatedOnAssignedMachine(ByRef SecureID As Integer, ByRef ServerValText As String, ByRef InstanceValText As String, ByRef RC As Boolean, ByRef RetMsg As String) As Boolean

    <OperationContract()>
    Function GetXrt(ByRef SecureID As Integer, ByVal RC As Boolean, ByVal RetMsg As String) As String

    <OperationContract()>
    Function getSqlServerVersion(ByRef SecureID As Integer) As String

    <OperationContract()>
    Sub RecordGrowth(ByRef SecureID As Integer, ByRef RC As Boolean)

    <OperationContract()>
    Function ParseLic(ByRef SecureID As Integer, ByVal LT As String, ByVal tgtKey As String) As String

    <OperationContract()>
    Function GetLoggedinUserName(ByRef SecureID As Integer) As String

    <OperationContract()>
    Function getDBSIZEMB(ByRef SecureID As Integer) As Double

    <OperationContract()>
    Sub resetMissingEmailIds(ByRef SecureID As Integer, ByVal CurrUserGuidID As String, ByRef RC As Boolean)

    <OperationContract()>
    Sub UserParmInsertUpdate(ByRef SecureID As Integer, ByVal ParmName As String, ByVal UserID As String, ByVal ParmVal As String, ByRef RC As Boolean)

    <OperationContract()>
    Function validateLogin(ByRef SecureID As Integer, ByVal UserLogin As String, ByVal PW As String, ByRef UserGuidID As String) As Boolean

    <OperationContract()>
    Function getLoggedInUser(ByRef SecureID As Integer) As String

    <OperationContract()>
    Function getAttachedMachineName(ByRef SecureID As Integer) As String

    <OperationContract()>
    Function getServerInstanceName(ByRef SecureID As Integer) As String

    <OperationContract()>
    Function getServerMachineName(ByRef SecureID As Integer) As String

    <OperationContract()>
    Sub getSystemParm(ByRef SecureID As Integer, ByRef SystemParms As Dictionary(Of String, String))

    <OperationContract()>
    Function getSynonyms(ByRef SecureID As Integer, ByVal ThesaurusID As String, ByVal Token As String, ByRef lbSynonyms As String) As String

    <OperationContract()>
    Function getThesaurusID(ByRef SecureID As Integer, ByVal ThesaurusName As String) As String

    <OperationContract()>
    Function iCountContent(ByRef SecureID As Integer, ByVal S As String) As Integer

    <OperationContract()>
    Function getDatasourceParm(ByRef SecureID As Integer, ByVal AttributeName As String, ByVal SourceGuid As String) As String

    <OperationContract()>
    Function SaveRunParm(ByRef SecureID As Integer, ByVal UserID As String, ByRef ParmID As String, ByRef ParmVal As String) As Boolean

    <OperationContract()>
    Function iGetRowCount(ByRef SecureID As Integer, ByVal TBL As String, ByVal WhereClause As String) As Integer

    <OperationContract()>
    Function ZeroizeGlobalSearch(ByRef SecureID As Integer) As Boolean

    <OperationContract()>
    Sub updateIp(ByRef SecureID As Integer, ByVal HostName As String, ByVal IP As String, ByVal checkCode As Integer, ByRef RC As Boolean)

    <OperationContract()>
    Function PopulateSourceGridWithWeights(ByRef SecureID As Integer, ByVal StartingRow As Integer, ByVal EndingRow As Integer, ByVal CallerName As String, ByVal MySql As String, ByRef bNewRows As Boolean, ByRef SourceRowCnt As Integer) As List(Of DS_CONTENT)

    <OperationContract()>
    Function PopulateSourceGridNoWeights(ByRef SecureID As Integer, ByVal StartingRow As Integer, ByVal EndingRow As Integer, ByVal CallerName As String, ByVal MySql As String, ByRef bNewRows As Boolean, ByRef SourceRowCnt As Integer) As List(Of DS_CONTENT)

    <OperationContract()>
    Function PopulateEmailGridWithNoWeights(ByRef SecureID As Integer, ByVal UID As String, ByVal CallerName As String, ByVal MySql As String, ByVal nbrWeightMin As String, ByVal StartingRow As Integer, ByVal EndingRow As Integer, ByRef bNewRows As Boolean, ByRef EmailRowCnt As Integer) As List(Of DS_EMAIL)

    <OperationContract()>
    Function PopulateEmailGridWithWeights(ByRef SecureID As Integer, ByVal Userid As String, ByVal CallerName As String, ByVal MySql As String, ByVal nbrWeightMin As String, ByVal StartingRow As Integer, ByVal EndingRow As Integer, ByRef bNewRows As Boolean, ByRef EmailRowCnt As Integer) As List(Of DS_EMAIL)

    <OperationContract()>
    Sub LoadUserSearchHistory(ByRef SecureID As Integer, ByVal MaxNbrSearches As Integer, ByVal Uid As String, ByVal Screen As String, ByRef SearchHistoryArrayList As List(Of String), ByRef NbrReturned As Integer)

    <OperationContract()>
    Sub getAttachmentWeights(ByRef SecureID As Integer, ByRef SL As Dictionary(Of String, Integer), ByVal UserID As String)

    <OperationContract()>
    Function ExecuteSqlNewConn1(ByRef SecureID As Integer, ByRef EncryptedMySql As String, UserID As String, ContractID As String) As Boolean

    <OperationContract()>
    Function ExecuteSqlNewConn2(ByRef SecureID As Integer, ByRef EncryptedMySql As String, UserID As String, ContractID As String) As Boolean

    <OperationContract()>
    Function ExecuteSqlNewConn3(ByRef SecureID As Integer, ByRef EncryptedMySql As String, UserID As String, ContractID As String) As Boolean

    <OperationContract()>
    Function ExecuteSqlNewConn4(ByRef SecureID As Integer, ByRef EncryptedMySql As String, UserID As String, ContractID As String) As Boolean

    <OperationContract()>
    Function ExecuteSqlNewConn5(ByRef SecureID As Integer, ByRef EncryptedMySql As String, UserID As String, ContractID As String) As Boolean

    <OperationContract()>
    Function ExecuteSqlNewConnSecure(ByRef SecureID As Integer, ByRef MySql As String, UserID As String, ContractID As String) As Boolean

    <OperationContract()>
    Sub GetParmValue(ByRef SecureID As Integer, ByVal UID As String, ByRef Parms As List(Of String))

    <OperationContract()>
    Function DBisGlobalSearcher(ByRef SecureID As Integer, ByVal Userid As String) As Boolean

    <OperationContract()>
    Function DBisAdmin(ByRef SecureID As Integer, ByVal Userid As String) As Boolean

    <OperationContract()>
    Sub getUserParm(ByRef SecureID As Integer, ByRef sVariable As String, ByVal UserParm As String)

    <OperationContract()>
    Sub RemoveUnwantedCharacters(ByRef SecureID As Integer, ByRef tgtString As String)

    <OperationContract()>
    Function GetMachineIP(ByRef SecureID As Integer) As String

    <OperationContract()>
    Function getClientLicenses(ByRef SecureID As Integer, ByVal CompanyID As String, ByRef ErrorMessage As String, ByRef RC As Boolean) As List(Of DS_License)

End Interface

<System.Runtime.Serialization.DataContract()>
Public Class DS_ImageData
    Public Property SourceName As String
    Public Property FileLength As Integer
    Public Property SourceImage As Byte()
End Class

<System.Runtime.Serialization.DataContract()>
Public Class DS_EmailAttachments

    <System.Runtime.Serialization.DataMember()>
    Public AttachmentName As String

    <System.Runtime.Serialization.DataMember()>
    Public RowID As Integer

    <System.Runtime.Serialization.DataMember()>
    Public EmailGuid As String

End Class

<System.Runtime.Serialization.DataContract()>
Public Class struct_LibUsers

    <System.Runtime.Serialization.DataMember()>
    Public LibraryName As String

    <System.Runtime.Serialization.DataMember()>
    Public UserName As String

    <System.Runtime.Serialization.DataMember()>
    Public OwnerName As String

    <System.Runtime.Serialization.DataMember()>
    Public UserGuid As String

    <System.Runtime.Serialization.DataMember()>
    Public OwnerGuid As String

    <System.Runtime.Serialization.DataMember()>
    Public UserLoginID As String

    <System.Runtime.Serialization.DataMember()>
    Public OwnerLoginID As String

End Class

<System.Runtime.Serialization.DataContract()>
Public Class struct_ActiveSearchGuids

    <System.Runtime.Serialization.DataMember()>
    Public TgtGuid As String

    <System.Runtime.Serialization.DataMember()>
    Public TgtUserID As String

    <System.Runtime.Serialization.DataMember()>
    Public OwnerName As String

    <System.Runtime.Serialization.DataMember()>
    Public UserGuid As String

    <System.Runtime.Serialization.DataMember()>
    Public OwnerGuid As String

    <System.Runtime.Serialization.DataMember()>
    Public UserLoginID As String

    <System.Runtime.Serialization.DataMember()>
    Public OwnerLoginID As String

End Class

<System.Runtime.Serialization.DataContract()>
Public Class struct_ArchiveFolderId

    <System.Runtime.Serialization.DataMember()>
    Public ContainerName As String

    <System.Runtime.Serialization.DataMember()>
    Public FolderName As String

    <System.Runtime.Serialization.DataMember()>
    Public FolderID As String

    <System.Runtime.Serialization.DataMember()>
    Public storeid As String

End Class

<System.Runtime.Serialization.DataContract()>
Public Class struct_Dg

    <System.Runtime.Serialization.DataMember()>
    Public C1 As String

    <System.Runtime.Serialization.DataMember()>
    Public C2 As String

    <System.Runtime.Serialization.DataMember()>
    Public C3 As String

    <System.Runtime.Serialization.DataMember()>
    Public C4 As String

    <System.Runtime.Serialization.DataMember()>
    Public C5 As String

    <System.Runtime.Serialization.DataMember()>
    Public C6 As String

    <System.Runtime.Serialization.DataMember()>
    Public C7 As String

    <System.Runtime.Serialization.DataMember()>
    Public C8 As String

    <System.Runtime.Serialization.DataMember()>
    Public C9 As String

    <System.Runtime.Serialization.DataMember()>
    Public C10 As String

    <System.Runtime.Serialization.DataMember()>
    Public C11 As String

    <System.Runtime.Serialization.DataMember()>
    Public C12 As String

    <System.Runtime.Serialization.DataMember()>
    Public C13 As String

    <System.Runtime.Serialization.DataMember()>
    Public C14 As String

    <System.Runtime.Serialization.DataMember()>
    Public C15 As String

    <System.Runtime.Serialization.DataMember()>
    Public C16 As String

    <System.Runtime.Serialization.DataMember()>
    Public C17 As String

    <System.Runtime.Serialization.DataMember()>
    Public C18 As String

    <System.Runtime.Serialization.DataMember()>
    Public C19 As String

    <System.Runtime.Serialization.DataMember()>
    Public C20 As String

    <System.Runtime.Serialization.DataMember()>
    Public C21 As String

    <System.Runtime.Serialization.DataMember()>
    Public C22 As String

    <System.Runtime.Serialization.DataMember()>
    Public C23 As String

    <System.Runtime.Serialization.DataMember()>
    Public C24 As String

    <System.Runtime.Serialization.DataMember()>
    Public C25 As String

    <System.Runtime.Serialization.DataMember()>
    Public C26 As String

    <System.Runtime.Serialization.DataMember()>
    Public C27 As String

    <System.Runtime.Serialization.DataMember()>
    Public C28 As String

    <System.Runtime.Serialization.DataMember()>
    Public C29 As String

    <System.Runtime.Serialization.DataMember()>
    Public C30 As String

End Class

<System.Runtime.Serialization.DataContract()>
Public Class DS_EmailNoWeight

    <System.Runtime.Serialization.DataMember()>
    Public SentOn As Date

    <System.Runtime.Serialization.DataMember()>
    Public ShortSubj As String

    <System.Runtime.Serialization.DataMember()>
    Public SenderEmailAddress As String

    <System.Runtime.Serialization.DataMember()>
    Public SenderName As String

    <System.Runtime.Serialization.DataMember()>
    Public SentTO As String

    <System.Runtime.Serialization.DataMember()>
    Public Body As String

    <System.Runtime.Serialization.DataMember()>
    Public CC As String

    <System.Runtime.Serialization.DataMember()>
    Public Bcc As String

    <System.Runtime.Serialization.DataMember()>
    Public CreationTime As Date

    <System.Runtime.Serialization.DataMember()>
    Public AllRecipients As String

    <System.Runtime.Serialization.DataMember()>
    Public ReceivedByName As String

    <System.Runtime.Serialization.DataMember()>
    Public ReceivedTime As Date

    <System.Runtime.Serialization.DataMember()>
    Public MsgSize As Integer

    <System.Runtime.Serialization.DataMember()>
    Public SUBJECT As String

    <System.Runtime.Serialization.DataMember()>
    Public OriginalFolder As String

    <System.Runtime.Serialization.DataMember()>
    Public EmailGuid As String

    <System.Runtime.Serialization.DataMember()>
    Public RetentionExpirationDate As Date

    <System.Runtime.Serialization.DataMember()>
    Public isPublic As String

    <System.Runtime.Serialization.DataMember()>
    Public UserID As String

    <System.Runtime.Serialization.DataMember()>
    Public SourceTypeCode As String

    <System.Runtime.Serialization.DataMember()>
    Public NbrAttachments As Integer

    <System.Runtime.Serialization.DataMember()>
    Public RID As String

    <System.Runtime.Serialization.DataMember()>
    Public RepoSvrName As String

    <System.Runtime.Serialization.DataMember()>
    Public ROWID As String

End Class

<DataContract()>
Public Class DS_EMAIL

    <DataMember()>
    Public RANK As Integer

    <System.Runtime.Serialization.DataMember()>
    Public SentOn As Date

    <System.Runtime.Serialization.DataMember()>
    Public ShortSubj As String

    <System.Runtime.Serialization.DataMember()>
    Public SenderEmailAddress As String

    <System.Runtime.Serialization.DataMember()>
    Public SenderName As String

    <System.Runtime.Serialization.DataMember()>
    Public SentTO As String

    <System.Runtime.Serialization.DataMember()>
    Public Body As String

    <System.Runtime.Serialization.DataMember()>
    Public CC As String

    <System.Runtime.Serialization.DataMember()>
    Public Bcc As String

    <System.Runtime.Serialization.DataMember()>
    Public CreationTime As Date

    <System.Runtime.Serialization.DataMember()>
    Public AllRecipients As String

    <System.Runtime.Serialization.DataMember()>
    Public ReceivedByName As String

    <System.Runtime.Serialization.DataMember()>
    Public ReceivedTime As Date

    <System.Runtime.Serialization.DataMember()>
    Public MsgSize As Integer

    <System.Runtime.Serialization.DataMember()>
    Public SUBJECT As String

    <System.Runtime.Serialization.DataMember()>
    Public OriginalFolder As String

    <System.Runtime.Serialization.DataMember()>
    Public EmailGuid As String

    <System.Runtime.Serialization.DataMember()>
    Public RetentionExpirationDate As Date

    <System.Runtime.Serialization.DataMember()>
    Public isPublic As String

    <System.Runtime.Serialization.DataMember()>
    Public UserID As String

    <System.Runtime.Serialization.DataMember()>
    Public SourceTypeCode As String

    <System.Runtime.Serialization.DataMember()>
    Public NbrAttachments As Integer

    <System.Runtime.Serialization.DataMember()>
    Public RID As String

    <System.Runtime.Serialization.DataMember()>
    Public RepoSvrName As String

    <System.Runtime.Serialization.DataMember()>
    Public ROWID As String

    <System.Runtime.Serialization.DataMember()>
    Public FoundInAttach As Boolean

End Class

<System.Runtime.Serialization.DataContract()>
Public Class DS_CONTENT

    <System.Runtime.Serialization.DataMember()>
    Public RANK As Integer

    <System.Runtime.Serialization.DataMember()>
    Public SourceName As String

    <System.Runtime.Serialization.DataMember()>
    Public CreateDate As Date

    <System.Runtime.Serialization.DataMember()>
    Public VersionNbr As Integer

    <System.Runtime.Serialization.DataMember()>
    Public LastAccessDate As Date

    <System.Runtime.Serialization.DataMember()>
    Public FileLength As Integer

    <System.Runtime.Serialization.DataMember()>
    Public LastWriteTime As Date

    <System.Runtime.Serialization.DataMember()>
    Public OriginalFileType As String

    <System.Runtime.Serialization.DataMember()>
    Public isPublic As String

    <System.Runtime.Serialization.DataMember()>
    Public FQN As String

    <System.Runtime.Serialization.DataMember()>
    Public SourceGuid As String

    <System.Runtime.Serialization.DataMember()>
    Public DataSourceOwnerUserID As String

    <System.Runtime.Serialization.DataMember()>
    Public FileDirectory As String

    <System.Runtime.Serialization.DataMember()>
    Public RetentionExpirationDate As Date

    <System.Runtime.Serialization.DataMember()>
    Public isMaster As String

    <System.Runtime.Serialization.DataMember()>
    Public StructuredData As Boolean

    <System.Runtime.Serialization.DataMember()>
    Public RepoSvrName As String

    <System.Runtime.Serialization.DataMember()>
    Public ROWID As String

    <System.Runtime.Serialization.DataMember()>
    Public Description As String

    <System.Runtime.Serialization.DataMember()>
    Public RssLinkFlg As Boolean

    <System.Runtime.Serialization.DataMember()>
    Public isWebPage As String

End Class

<System.Runtime.Serialization.DataContract()>
Public Class DS_License

    <System.Runtime.Serialization.DataMember()>
    Public LicenseNbr As Integer

    <System.Runtime.Serialization.DataMember()>
    Public CompanyID As String

    <System.Runtime.Serialization.DataMember()>
    Public MachineID As String

    <System.Runtime.Serialization.DataMember()>
    Public LicenseID As String

    <System.Runtime.Serialization.DataMember()>
    Public Applied As String

    <System.Runtime.Serialization.DataMember()>
    Public PurchasedMachines As String

    <System.Runtime.Serialization.DataMember()>
    Public PurchasedUsers As String

    <System.Runtime.Serialization.DataMember()>
    Public SupportActive As String

    <System.Runtime.Serialization.DataMember()>
    Public SupportActiveDate As String

    <System.Runtime.Serialization.DataMember()>
    Public SupportInactiveDate As String

    <System.Runtime.Serialization.DataMember()>
    Public LicenseText As String

    <System.Runtime.Serialization.DataMember()>
    Public LicenseTypeCode As String

    <System.Runtime.Serialization.DataMember()>
    Public EncryptedLicense As String

    <System.Runtime.Serialization.DataMember()>
    Public ServerNAME As String

    <System.Runtime.Serialization.DataMember()>
    Public SqlInstanceName As String

End Class

<System.Runtime.Serialization.DataContract()>
Public Class DS_ErrorLogs

    <System.Runtime.Serialization.DataMember()>
    Public Severity As String

    <System.Runtime.Serialization.DataMember()>
    Public LoggedMessage As String

    <System.Runtime.Serialization.DataMember()>
    Public EntryDate As DateTime

    <System.Runtime.Serialization.DataMember()>
    Public LogName As String

    <System.Runtime.Serialization.DataMember()>
    Public EntryUserID As String

End Class

<System.Runtime.Serialization.DataContract()>
Public Class DS_USERSCREENSTATE

    <System.Runtime.Serialization.DataMember()>
    Public ScreenName As String

    <System.Runtime.Serialization.DataMember()>
    Public UserID As String

    <System.Runtime.Serialization.DataMember()>
    Public ParmName As String

    <System.Runtime.Serialization.DataMember()>
    Public ParmVal As String

    <System.Runtime.Serialization.DataMember()>
    Public ParmDataType As String

    <System.Runtime.Serialization.DataMember()>
    Public HiveConnectionName As String

    <System.Runtime.Serialization.DataMember()>
    Public HiveActive As Boolean

    <System.Runtime.Serialization.DataMember()>
    Public RepoSvrName As String

    <System.Runtime.Serialization.DataMember()>
    Public RowCreationDate As Date

    <System.Runtime.Serialization.DataMember()>
    Public RowLastModDate As Date

    <System.Runtime.Serialization.DataMember()>
    Public RowNbr As Integer

End Class

<System.Runtime.Serialization.DataContract()>
Public Class DS_USERSEARCHSTATE

    <System.Runtime.Serialization.DataMember()>
    Public SearchID As Integer

    <System.Runtime.Serialization.DataMember()>
    Public ScreenName As String

    <System.Runtime.Serialization.DataMember()>
    Public UserID As String

    <System.Runtime.Serialization.DataMember()>
    Public ParmName As String

    <System.Runtime.Serialization.DataMember()>
    Public ParmVal As String

    <System.Runtime.Serialization.DataMember()>
    Public ParmDataType As String

    <System.Runtime.Serialization.DataMember()>
    Public HiveConnectionName As String

    <System.Runtime.Serialization.DataMember()>
    Public HiveActive As Boolean

    <System.Runtime.Serialization.DataMember()>
    Public RepoSvrName As String

    <System.Runtime.Serialization.DataMember()>
    Public RowCreationDate As Date

    <System.Runtime.Serialization.DataMember()>
    Public RowLastModDate As Date

    <System.Runtime.Serialization.DataMember()>
    Public RowNbr As Integer

End Class

<System.Runtime.Serialization.DataContract()>
Public Class DS_clsUSERGRIDSTATE

    <System.Runtime.Serialization.DataMember()>
    Public UserID As String

    <System.Runtime.Serialization.DataMember()>
    Public ScreenName As String

    <System.Runtime.Serialization.DataMember()>
    Public GridName As String

    <System.Runtime.Serialization.DataMember()>
    Public ColName As String

    <System.Runtime.Serialization.DataMember()>
    Public ColOrder As Integer

    <System.Runtime.Serialization.DataMember()>
    Public ColWidth As Integer

    <System.Runtime.Serialization.DataMember()>
    Public ColVisible As Boolean

    <System.Runtime.Serialization.DataMember()>
    Public ColReadOnly As Boolean

    <System.Runtime.Serialization.DataMember()>
    Public ColSortOrder As Integer

    <System.Runtime.Serialization.DataMember()>
    Public ColSortAsc As Boolean

    <System.Runtime.Serialization.DataMember()>
    Public HiveConnectionName As String

    <System.Runtime.Serialization.DataMember()>
    Public HiveActive As Boolean

    <System.Runtime.Serialization.DataMember()>
    Public RepoSvrName As String

    <System.Runtime.Serialization.DataMember()>
    Public RowCreationDate As Date

    <System.Runtime.Serialization.DataMember()>
    Public RowLastModDate As Date

    <System.Runtime.Serialization.DataMember()>
    Public RowNbr As Integer

End Class

<System.Runtime.Serialization.DataContract()>
Public Class DS_SearchTerms

    <System.Runtime.Serialization.DataMember()>
    Public SearchTypeCode As String

    <System.Runtime.Serialization.DataMember()>
    Public Term As String

    <System.Runtime.Serialization.DataMember()>
    Public TermVal As String

    <System.Runtime.Serialization.DataMember()>
    Public TermDatatype As String

End Class

<System.Runtime.Serialization.DataContract()>
Public Class DS_SYSTEMPARMS

    <System.Runtime.Serialization.DataMember()>
    Public SysParm As String

    <System.Runtime.Serialization.DataMember()>
    Public SysParmDesc As String

    <System.Runtime.Serialization.DataMember()>
    Public SysParmVal As String

    <System.Runtime.Serialization.DataMember()>
    Public flgActive As String

    <System.Runtime.Serialization.DataMember()>
    Public isDirectory As String

    <System.Runtime.Serialization.DataMember()>
    Public isEmailFolder As String

    <System.Runtime.Serialization.DataMember()>
    Public flgAllSubDirs As String

    <System.Runtime.Serialization.DataMember()>
    Public HiveConnectionName As String

    <System.Runtime.Serialization.DataMember()>
    Public HiveActive As Boolean

    <System.Runtime.Serialization.DataMember()>
    Public RepoSvrName As String

    <System.Runtime.Serialization.DataMember()>
    Public RowCreationDate As Date

    <System.Runtime.Serialization.DataMember()>
    Public RowLastModDate As Date

End Class

<System.Runtime.Serialization.DataContract()>
Public Class DS_ZipFiles

    <System.Runtime.Serialization.DataMember()>
    Public SourceName As String

    <System.Runtime.Serialization.DataMember()>
    Public isParent As Boolean

    <System.Runtime.Serialization.DataMember()>
    Public SourceGuid As String

End Class

<System.Runtime.Serialization.DataContract()>
Public Class DS_VLibraryStats

    <System.Runtime.Serialization.DataMember()>
    Public LibraryName As String

    <System.Runtime.Serialization.DataMember()>
    Public isPublic As String

    <System.Runtime.Serialization.DataMember()>
    Public Items As Integer

    <System.Runtime.Serialization.DataMember()>
    Public Members As Integer

End Class

<System.Runtime.Serialization.DataContract()>
Public Class DS_dgGrpUsers

    <System.Runtime.Serialization.DataMember()>
    Public UserName As String

    <System.Runtime.Serialization.DataMember()>
    Public UserID As String

End Class

<System.Runtime.Serialization.DataContract()>
Public Class DS_DgAssigned

    <System.Runtime.Serialization.DataMember()>
    Public GroupName As String

    <System.Runtime.Serialization.DataMember()>
    Public GroupOwnerUserID As String

End Class

<System.Runtime.Serialization.DataContract()>
Public Class DS_LibItems

    <System.Runtime.Serialization.DataMember()>
    Public ItemTitle As String

    <System.Runtime.Serialization.DataMember()>
    Public ItemType As String

    <System.Runtime.Serialization.DataMember()>
    Public LibraryName As String

    <System.Runtime.Serialization.DataMember()>
    Public LibraryOwnerUserID As String

    <System.Runtime.Serialization.DataMember()>
    Public AddedByUserGuidId As String

    <System.Runtime.Serialization.DataMember()>
    Public DataSourceOwnerUserID As String

    <System.Runtime.Serialization.DataMember()>
    Public SourceGuid As String

    <System.Runtime.Serialization.DataMember()>
    Public LibraryItemGuid As String

End Class

<System.Runtime.Serialization.DataContract()>
Public Class DS_DgGroupUsers

    <System.Runtime.Serialization.DataMember()>
    Public UserName As String

    <System.Runtime.Serialization.DataMember()>
    Public UserID As String

    <System.Runtime.Serialization.DataMember()>
    Public FullAccess As Boolean

    <System.Runtime.Serialization.DataMember()>
    Public ReadOnlyAccess As Boolean

    <System.Runtime.Serialization.DataMember()>
    Public DeleteAccess As Boolean

    <System.Runtime.Serialization.DataMember()>
    Public Searchable As Boolean

End Class

<System.Runtime.Serialization.DataContract()>
Public Class DS_VUserGrid

    <System.Runtime.Serialization.DataMember()>
    Public UserID As String

    <System.Runtime.Serialization.DataMember()>
    Public UserName As String

    <System.Runtime.Serialization.DataMember()>
    Public EmailAddress As String

    <System.Runtime.Serialization.DataMember()>
    Public Admin As String

    <System.Runtime.Serialization.DataMember()>
    Public isActive As String

    <System.Runtime.Serialization.DataMember()>
    Public UserLoginID As String

    <System.Runtime.Serialization.DataMember()>
    Public ClientOnly As Boolean

    <System.Runtime.Serialization.DataMember()>
    Public HiveConnectionName As String

    <System.Runtime.Serialization.DataMember()>
    Public HiveActive As Boolean

    <System.Runtime.Serialization.DataMember()>
    Public RepoSvrName As String

    <System.Runtime.Serialization.DataMember()>
    Public RowCreationDate As Date

    <System.Runtime.Serialization.DataMember()>
    Public RowLastModDate As Date

End Class

<System.Runtime.Serialization.DataContract()>
Public Class DS_CoOwner

    <System.Runtime.Serialization.DataMember()>
    Public CoOwnerName As String

    <System.Runtime.Serialization.DataMember()>
    Public CoOwnerID As String

    <System.Runtime.Serialization.DataMember()>
    Public RowID As Integer

End Class

<System.Runtime.Serialization.DataContract()>
Public Class DS_VLibraryUsers

    <System.Runtime.Serialization.DataMember()>
    Public UserID As String

    <System.Runtime.Serialization.DataMember()>
    Public LibraryName As String

    <System.Runtime.Serialization.DataMember()>
    Public LibraryOwnerUserID As String

    <System.Runtime.Serialization.DataMember()>
    Public UserName As String

End Class

<System.Runtime.Serialization.DataContract()>
Public Class DS_SEARCHSCHEDULE

    <System.Runtime.Serialization.DataMember()>
    Public SearchName As String

    <System.Runtime.Serialization.DataMember()>
    Public NotificationSMS As String

    <System.Runtime.Serialization.DataMember()>
    Public SearchDesc As String

    <System.Runtime.Serialization.DataMember()>
    Public OwnerID As String

    <System.Runtime.Serialization.DataMember()>
    Public SearchQuery As String

    <System.Runtime.Serialization.DataMember()>
    Public SendToEmail As String

    <System.Runtime.Serialization.DataMember()>
    Public ScheduleUnit As String

    <System.Runtime.Serialization.DataMember()>
    Public ScheduleHour As String

    <System.Runtime.Serialization.DataMember()>
    Public ScheduleDaysOfWeek As String

    <System.Runtime.Serialization.DataMember()>
    Public ScheduleDaysOfMonth As String

    <System.Runtime.Serialization.DataMember()>
    Public ScheduleMonthOfQtr As String

    <System.Runtime.Serialization.DataMember()>
    Public StartToRunDate As Date

    <System.Runtime.Serialization.DataMember()>
    Public EndRunDate As Date

    <System.Runtime.Serialization.DataMember()>
    Public SearchParameters As String

    <System.Runtime.Serialization.DataMember()>
    Public LastRunDate As Date

    <System.Runtime.Serialization.DataMember()>
    Public NumberOfExecutions As Integer

    <System.Runtime.Serialization.DataMember()>
    Public CreateDate As Date

    <System.Runtime.Serialization.DataMember()>
    Public LastModDate As Date

    <System.Runtime.Serialization.DataMember()>
    Public ScheduleHourInterval As Integer

    <System.Runtime.Serialization.DataMember()>
    Public RepoName As String

End Class

<System.Runtime.Serialization.DataContract()>
Public Class DS_ListOfStrings00

    <System.Runtime.Serialization.DataMember()>
    Public strItem As String

End Class

<System.Runtime.Serialization.DataContract()>
Public Class DS_ListOfStrings01

    <System.Runtime.Serialization.DataMember()>
    Public strItem As String

End Class

<System.Runtime.Serialization.DataContract()>
Public Class DS_ListOfStrings02

    <System.Runtime.Serialization.DataMember()>
    Public strItem As String

End Class

<System.Runtime.Serialization.DataContract()>
Public Class DS_ListOfStrings03

    <System.Runtime.Serialization.DataMember()>
    Public strItem As String

End Class

<System.Runtime.Serialization.DataContract()>
Public Class DS_ListOfStrings04

    <System.Runtime.Serialization.DataMember()>
    Public strItem As String

End Class

<System.Runtime.Serialization.DataContract()>
Public Class DS_RESTOREQUEUE

    <System.Runtime.Serialization.DataMember()>
    Public ContentGuid As String

    <System.Runtime.Serialization.DataMember()>
    Public UserID As String

    <System.Runtime.Serialization.DataMember()>
    Public MachineID As String

    <System.Runtime.Serialization.DataMember()>
    Public FQN As String

    <System.Runtime.Serialization.DataMember()>
    Public FileSize As Integer

    <System.Runtime.Serialization.DataMember()>
    Public ContentType As String

    <System.Runtime.Serialization.DataMember()>
    Public Preview As Boolean

    <System.Runtime.Serialization.DataMember()>
    Public Restore As Boolean

    <System.Runtime.Serialization.DataMember()>
    Public ProcessingCompleted As Boolean

    <System.Runtime.Serialization.DataMember()>
    Public EntryDate As Date

    <System.Runtime.Serialization.DataMember()>
    Public ProcessedDate As Date

    <System.Runtime.Serialization.DataMember()>
    Public StartDownloadTime As Date

    <System.Runtime.Serialization.DataMember()>
    Public EndDownloadTime As Date

    <System.Runtime.Serialization.DataMember()>
    Public RepoName As String

    <System.Runtime.Serialization.DataMember()>
    Public RowGuid As Guid

End Class

<System.Runtime.Serialization.DataContract()>
Public Class DS_Metadata

    <System.Runtime.Serialization.DataMember()>
    Public AttributeName As String

    <System.Runtime.Serialization.DataMember()>
    Public AttributeValue As String

End Class


<DataContract>
Public Class DS_ContentDS
    <DataMember>
    Public Property ContentDS As DataTable
End Class

