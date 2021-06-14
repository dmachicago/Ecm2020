' ***********************************************************************
' Assembly         : EcmCloudWcf.Web
' Author           : wdale
' Created          : 12-15-2020
'
' Last Modified By : wdale
' Last Modified On : 12-16-2020
' ***********************************************************************
' <copyright file="IService1.vb" company="ECM Library,LLC">
'     Copyright @ECM Library 2020 all rights reserved.
' </copyright>
' <summary></summary>
' ***********************************************************************
Imports System.Runtime.Serialization
Imports System.ServiceModel

' NOTE: You can use the "Rename" command on the context menu to change the interface name "IService1"
'       in both code and config file together.
''' <summary>
''' Interface IService1
''' </summary>
<ServiceContract()>
Public Interface IService1

    ''' <summary>
    ''' Gets the length of the source.
    ''' </summary>
    ''' <param name="SourceGuid">The source unique identifier.</param>
    ''' <param name="SourceType">Type of the source.</param>
    ''' <returns>Int64.</returns>
    <OperationContract>
    Function getSourceLength(ByVal SourceGuid As String, SourceType As String) As Int64

    ''' <summary>
    ''' Gets the name of the source.
    ''' </summary>
    ''' <param name="SourceGuid">The source unique identifier.</param>
    ''' <param name="SourceType">Type of the source.</param>
    ''' <returns>System.String.</returns>
    <OperationContract>
    Function getSourceName(ByVal SourceGuid As String, SourceType As String) As String

    ''' <summary>
    ''' Downs the load document.
    ''' </summary>
    ''' <param name="TypeImage">The type image.</param>
    ''' <param name="SourceGuid">The source unique identifier.</param>
    ''' <returns>System.Byte().</returns>
    <OperationContract>
    Function DownLoadDocument(ByRef TypeImage As String, ByVal SourceGuid As String) As Byte()

    ''' <summary>
    ''' Gets the attachment from database.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="EmailGuid">The email unique identifier.</param>
    ''' <returns>System.Byte().</returns>
    <OperationContract>
    Function GetAttachmentFromDB(ByRef SecureID As Integer, ByVal EmailGuid As String) As Byte()

    ''' <summary>
    ''' Gets the content dt.
    ''' </summary>
    ''' <param name="sourceguid">The sourceguid.</param>
    ''' <returns>DataTable.</returns>
    <OperationContract>
    Function getContentDT(sourceguid As String) As DataTable

    ''' <summary>
    ''' Tests the IIS connection.
    ''' </summary>
    ''' <returns>System.String.</returns>
    <OperationContract>
    Function TestIISConnection() As String

    ''' <summary>
    ''' Tests the connection.
    ''' </summary>
    ''' <returns>System.String.</returns>
    <OperationContract>
    Function TestConnection() As String

    ''' <summary>
    ''' Gets the word inflections.
    ''' </summary>
    ''' <param name="QRY">The qry.</param>
    ''' <param name="CS">The cs.</param>
    ''' <returns>System.String.</returns>
    <OperationContract>
    Function getWordInflections(QRY As String, CS As String) As String

    ''' <summary>
    ''' Removes the expired alerts.
    ''' </summary>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    <OperationContract>
    Function removeExpiredAlerts() As Boolean

    ''' <summary>
    ''' Changes the user password admin.
    ''' </summary>
    ''' <param name="AdminUserID">The admin user identifier.</param>
    ''' <param name="UserLogin">The user login.</param>
    ''' <param name="NewPw1">Creates new pw1.</param>
    ''' <param name="NewPw2">Creates new pw2.</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    <OperationContract>
    Function ChangeUserPasswordAdmin(AdminUserID As String, ByVal UserLogin As String, ByVal NewPw1 As String, ByVal NewPw2 As String) As Boolean

    ''' <summary>
    ''' Adds the user group.
    ''' </summary>
    ''' <param name="GroupName">Name of the group.</param>
    ''' <param name="GroupOwnerUserID">The group owner user identifier.</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    <OperationContract>
    Function AddUserGroup(ByVal GroupName As String, ByVal GroupOwnerUserID As String) As Boolean

    ''' <summary>
    ''' <br />
    ''' </summary>
    ''' <param name="MaxNbr">The maximum NBR.</param>
    ''' <returns>System.String.</returns>
    <OperationContract>
    Function getErrorLogs(MaxNbr As String) As String

    ''' <summary>
    ''' Sets the email public flag.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="EmailGuid">The email unique identifier.</param>
    ''' <param name="isPublic">if set to <c>true</c> [is public].</param>
    <OperationContract>
    Sub SetEmailPublicFlag(ByRef SecureID As Integer, ByVal EmailGuid As String, ByVal isPublic As Boolean)

    ''' <summary>
    ''' Sets the document to master.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="SourceGuid">The source unique identifier.</param>
    ''' <param name="MasterFlag">if set to <c>true</c> [master flag].</param>
    <OperationContract>
    Sub SetDocumentToMaster(ByRef SecureID As Integer, ByVal SourceGuid As String, ByVal MasterFlag As Boolean)

    ''' <summary>
    ''' Sets the document public flag.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="SourceGuid">The source unique identifier.</param>
    ''' <param name="isPublic">if set to <c>true</c> [is public].</param>
    <OperationContract>
    Sub SetDocumentPublicFlag(ByRef SecureID As Integer, ByVal SourceGuid As String, ByVal isPublic As Boolean)

    ''' <summary>
    ''' Executes the search json.
    ''' </summary>
    ''' <param name="TypeSearch">The type search.</param>
    ''' <param name="JsonSearchParms">The json search parms.</param>
    ''' <param name="RetMsg">The ret MSG.</param>
    ''' <returns>System.String.</returns>
    <OperationContract>
    Function ExecuteSearchJson(TypeSearch As String, ByVal JsonSearchParms As String, ByRef RetMsg As String, UserRowsToFetch As Integer) As String

    ''' <summary>
    ''' Tests the service avail.
    ''' </summary>
    ''' <returns>System.String.</returns>
    <OperationContract>
    Function testServiceAvail() As String

    ''' <summary>
    ''' Generates the search SQL.
    ''' </summary>
    ''' <param name="TypeSearch">The type search.</param>
    ''' <param name="SearchParmList">The search parm list.</param>
    ''' <returns>System.String.</returns>
    <OperationContract>
    Function GenerateSearchSQL(ByVal TypeSearch As String, ByVal SearchParmList As Dictionary(Of String, String)) As String

    ''' <summary>
    ''' Executes the search dt.
    ''' </summary>
    ''' <param name="SearchType">Type of the search.</param>
    ''' <param name="currSearchCnt">The curr search count.</param>
    ''' <param name="bGenSql">if set to <c>true</c> [b gen SQL].</param>
    ''' <param name="EmailGenSql">The email gen SQL.</param>
    ''' <param name="SearchParmsJson">The search parms json.</param>
    ''' <param name="ContentGenSql">The content gen SQL.</param>
    ''' <param name="strListOEmailRows">The string list o email rows.</param>
    ''' <param name="strListOfContentRows">The string list of content rows.</param>
    ''' <param name="bFirstEmailSearchSubmit">if set to <c>true</c> [b first email search submit].</param>
    ''' <param name="bFirstContentSearchSubmit">if set to <c>true</c> [b first content search submit].</param>
    ''' <param name="EmailRowCnt">The email row count.</param>
    ''' <param name="ContentRowCnt">The content row count.</param>
    ''' <returns>DataSet.</returns>
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
                ByRef ContentRowCnt As Integer,
                UserRowsToFetch As Integer) As DataSet

    ''' <summary>
    ''' Gets the files in zip detail.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="ParentGuid">The parent unique identifier.</param>
    ''' <param name="RC">if set to <c>true</c> [rc].</param>
    ''' <returns>System.String.</returns>
    <OperationContract>
    Function GetFilesInZipDetail(ByRef SecureID As Integer, ByVal ParentGuid As String, ByRef RC As Boolean) As String

    ''' <summary>
    ''' xes the get XRT identifier.
    ''' </summary>
    ''' <param name="CustomerID">The customer identifier.</param>
    ''' <param name="ServerName">Name of the server.</param>
    ''' <param name="DBName">Name of the database.</param>
    ''' <param name="InstanceName">Name of the instance.</param>
    ''' <returns>System.Int32.</returns>
    <OperationContract>
    Function xGetXrtID(CustomerID As String, ServerName As String, DBName As String, InstanceName As String) As Integer

    ''' <summary>
    ''' Gets the sec end point.
    ''' </summary>
    ''' <returns>System.String.</returns>
    <OperationContract>
    Function getSecEndPoint() As String

    ''' <summary>
    ''' Gets the contract identifier.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="UserID">The user identifier.</param>
    ''' <returns>System.String.</returns>
    <OperationContract>
    Function getContractID(SecureID As Integer, UserID As String) As String

    ''' <summary>
    ''' Adds the group library access.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="UserID">The user identifier.</param>
    ''' <param name="LibraryName">Name of the library.</param>
    ''' <param name="GroupName">Name of the group.</param>
    ''' <param name="GroupOwnerUserID">The group owner user identifier.</param>
    ''' <param name="RC">if set to <c>true</c> [rc].</param>
    ''' <param name="CurrUserID">The curr user identifier.</param>
    ''' <param name="SessionID">The session identifier.</param>
    ''' <param name="ControlSection">The control section.</param>
    <OperationContract>
    Sub AddGroupLibraryAccess(SecureID As Integer, UserID As String, LibraryName As String, GroupName As String, GroupOwnerUserID As String, ByRef RC As Boolean, CurrUserID As String, SessionID As String, ControlSection As String)

    ''' <summary>
    ''' Adds the group user.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="SessionID">The session identifier.</param>
    ''' <param name="CurrUserID">The curr user identifier.</param>
    ''' <param name="UserID">The user identifier.</param>
    ''' <param name="FullAccess">The full access.</param>
    ''' <param name="ReadOnlyAccess">The read only access.</param>
    ''' <param name="DeleteAccess">The delete access.</param>
    ''' <param name="Searchable">The searchable.</param>
    ''' <param name="GroupOwnerUserID">The group owner user identifier.</param>
    ''' <param name="GroupName">Name of the group.</param>
    ''' <param name="ControlSection">The control section.</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    <OperationContract>
    Function AddGroupUser(SecureID As Integer, SessionID As String, CurrUserID As String, UserID As String, FullAccess As String, ReadOnlyAccess As String, DeleteAccess As String, Searchable As String, GroupOwnerUserID As String, GroupName As String, ControlSection As String) As Boolean

    '<OperationContract>
    'Function EncryptTripleDES(SecureID As Integer, ByVal Phrase As String, ByVal shiftKey As String) As String
    '<OperationContract>
    'Function EncryptTripleDES(SecureID As Integer, ByVal Phrase As String, ByVal shiftKey As String) As String

    ''' <summary>
    ''' Databases the execute encrypted SQL.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="MySql">My SQL.</param>
    ''' <param name="EKEY">The ekey.</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    <OperationContract>
    Function DBExecuteEncryptedSql(ByRef SecureID As Integer, ByRef MySql As String, ByVal EKEY As String) As Boolean

    ''' <summary>
    ''' Validates the attach secure login.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="CompanyID">The company identifier.</param>
    ''' <param name="RepoID">The repo identifier.</param>
    ''' <param name="UserLogin">The user login.</param>
    ''' <param name="PW">The pw.</param>
    ''' <param name="RC">if set to <c>true</c> [rc].</param>
    ''' <param name="RetMsg">The ret MSG.</param>
    ''' <param name="GateWayEndPoint">The gate way end point.</param>
    ''' <param name="DownloadEndpoint">The download endpoint.</param>
    ''' <param name="ENCCS">The enccs.</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    <OperationContract>
    Function validateAttachSecureLogin(ByRef SecureID As Integer,
                                             ByVal CompanyID As String,
                                               ByVal RepoID As String,
                                               ByVal UserLogin As String,
                                               ByVal PW As String,
                                               ByRef RC As Boolean,
                                               ByRef RetMsg As String, ByRef GateWayEndPoint As String, ByRef DownloadEndpoint As String, ByRef ENCCS As String) As Boolean

    ''' <summary>
    ''' Gets the XRT test.
    ''' </summary>
    ''' <param name="dt">The dt.</param>
    ''' <returns>System.String.</returns>
    <OperationContract>
    Function GetXrtTest(dt As Date) As String

    ''' <summary>
    ''' Cks the content flags.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="SourceGuid">The source unique identifier.</param>
    ''' <param name="SD">if set to <c>true</c> [sd].</param>
    ''' <param name="SP">if set to <c>true</c> [sp].</param>
    ''' <param name="SAP">if set to <c>true</c> [sap].</param>
    ''' <param name="bMaster">if set to <c>true</c> [b master].</param>
    ''' <param name="RSS">if set to <c>true</c> [RSS].</param>
    ''' <param name="WEB">if set to <c>true</c> [web].</param>
    ''' <param name="bPublic">if set to <c>true</c> [b public].</param>
    <OperationContract()>
    Sub ckContentFlags(SecureID As Integer, SourceGuid As String, ByRef SD As Boolean, ByRef SP As Boolean, ByRef SAP As Boolean, ByRef bMaster As Boolean, ByRef RSS As Boolean, ByRef WEB As Boolean, ByRef bPublic As Boolean)

    '<OperationContract()>
    'Function getGatewayCS(SecureID As Integer, CompanyID As String, RepoID As String, PW As String, ByRef RetMsg As String, ByRef RC As Boolean) As String

    ''' <summary>
    ''' Gets the customer logo title.
    ''' </summary>
    ''' <returns>System.String.</returns>
    <OperationContract()>
    Function getCustomerLogoTitle() As String

    ''' <summary>
    ''' Gets the explode email zip.
    ''' </summary>
    ''' <returns>System.String.</returns>
    <OperationContract()>
    Function getExplodeEmailZip() As String

    ''' <summary>
    ''' Gets the name of the facility.
    ''' </summary>
    ''' <returns>System.String.</returns>
    <OperationContract()>
    Function getFacilityName() As String

    ''' <summary>
    ''' Gets the affinitydelay.
    ''' </summary>
    ''' <returns>System.Int32.</returns>
    <OperationContract()>
    Function getAffinitydelay() As Integer

    ''' <summary>
    ''' Gets the CLC URL.
    ''' </summary>
    ''' <returns>System.String.</returns>
    <OperationContract()>
    Function getClcURL() As String

    ''' <summary>
    ''' Gets the archiver URL.
    ''' </summary>
    ''' <returns>System.String.</returns>
    <OperationContract()>
    Function getArchiverURL() As String

    ''' <summary>
    ''' Executes the SQL stack.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="SqlStack">The SQL stack.</param>
    ''' <param name="UserID">The user identifier.</param>
    ''' <param name="SessionID">The session identifier.</param>
    ''' <param name="ControlSection">The control section.</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    <OperationContract()>
    Function ExecuteSqlStack(ByRef SecureID As Integer, ByRef SqlStack As Dictionary(Of Integer, String), UserID As String, SessionID As String, ControlSection As String) As Boolean

    ''' <summary>
    ''' Gets the default screen.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="UserID">The user identifier.</param>
    ''' <returns>System.String.</returns>
    <OperationContract()>
    Function getDefaultScreen(ByVal SecureID As Integer, ByVal UserID As String) As String

    ''' <summary>
    ''' Recalls the user search.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="SearchName">Name of the search.</param>
    ''' <param name="UID">The uid.</param>
    ''' <param name="strSearches">The string searches.</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    <OperationContract()>
    Function RecallUserSearch(ByVal SecureID As Integer, ByVal SearchName As String, ByVal UID As String, ByRef strSearches As String) As Boolean

    ''' <summary>
    ''' Saves the user search.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="SearchName">Name of the search.</param>
    ''' <param name="UID">The uid.</param>
    ''' <param name="strSearches">The string searches.</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    <OperationContract()>
    Function SaveUserSearch(ByVal SecureID As Integer, ByVal SearchName As String, ByVal UID As String, ByVal strSearches As String) As Boolean

    '<OperationContract()>
    'Function GetFilesInZip(ByRef SecureID As Integer, ByVal ParentGuid As String, ByRef RC As Boolean) As String

    ''' <summary>
    ''' Schedules the file down load.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="ContentGuid">The content unique identifier.</param>
    ''' <param name="UserID">The user identifier.</param>
    ''' <param name="ContentType">Type of the content.</param>
    ''' <param name="Preview">The preview.</param>
    ''' <param name="Restore">The restore.</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    <OperationContract()>
    Function scheduleFileDownLoad(ByVal SecureID As Integer,
                                  ByVal ContentGuid As String,
                                  ByVal UserID As String,
                                  ByVal ContentType As String,
                                  ByVal Preview As Integer,
                                  ByVal Restore As Integer) As Boolean

    ''' <summary>
    ''' Gets the content meta data.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="SourceGuid">The source unique identifier.</param>
    ''' <returns>System.String.</returns>
    <OperationContract()>
    Function GetContentMetaData(ByVal SecureID As Integer, ByVal SourceGuid As String) As String

    ''' <summary>
    ''' Removes the restore file by unique identifier.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="RowGuid">The row unique identifier.</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    <OperationContract()>
    Function removeRestoreFileByGuid(ByVal SecureID As Integer, ByVal RowGuid As String) As Boolean

    ''' <summary>
    ''' Removes the restore files.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="UserID">The user identifier.</param>
    ''' <param name="MachineID">The machine identifier.</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    <OperationContract()>
    Function removeRestoreFiles(ByVal SecureID As Integer, ByRef UserID As String, ByRef MachineID As String) As Boolean

    ''' <summary>
    ''' Gets the restore file count.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="UserID">The user identifier.</param>
    ''' <param name="MachineID">The machine identifier.</param>
    ''' <param name="Preview">if set to <c>true</c> [preview].</param>
    ''' <returns>System.Int32.</returns>
    <OperationContract()>
    Function getRestoreFileCount(ByVal SecureID As Integer, ByRef UserID As String, ByRef MachineID As String, ByRef Preview As Boolean) As Integer

    ''' <summary>
    ''' Saves the restore file.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="tgtTable">The TGT table.</param>
    ''' <param name="ContentGuid">The content unique identifier.</param>
    ''' <param name="Preview">if set to <c>true</c> [preview].</param>
    ''' <param name="Restore">if set to <c>true</c> [restore].</param>
    ''' <param name="UserID">The user identifier.</param>
    ''' <param name="MachineID">The machine identifier.</param>
    ''' <param name="RC">if set to <c>true</c> [rc].</param>
    ''' <param name="RetMsg">The ret MSG.</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    <OperationContract()>
    Function saveRestoreFile(ByVal SecureID As Integer, ByVal tgtTable As String, ByRef ContentGuid As String, ByVal Preview As Boolean, ByVal Restore As Boolean, ByRef UserID As String, ByRef MachineID As String, ByRef RC As Boolean, ByVal RetMsg As String) As Boolean

    ''' <summary>
    ''' Gens the email attachments SQL.
    ''' </summary>
    ''' <param name="UserID">The user identifier.</param>
    ''' <param name="SearchParms">The search parms.</param>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="InputSearchString">The input search string.</param>
    ''' <param name="useFreetext">if set to <c>true</c> [use freetext].</param>
    ''' <param name="ckWeighted">if set to <c>true</c> [ck weighted].</param>
    ''' <param name="isEmail">if set to <c>true</c> [is email].</param>
    ''' <param name="LimitToCurrRecs">if set to <c>true</c> [limit to curr recs].</param>
    ''' <param name="ThesaurusList">The thesaurus list.</param>
    ''' <param name="txtThesaurus">The text thesaurus.</param>
    ''' <param name="cbThesaurusText">The cb thesaurus text.</param>
    ''' <param name="calledBy">The called by.</param>
    ''' <returns>System.String.</returns>
    <OperationContract()>
    Function GenEmailAttachmentsSQL(ByVal UserID As String, ByVal SearchParms As List(Of DS_SearchTerms), ByRef SecureID As Integer, ByVal InputSearchString As String,
        ByVal useFreetext As Boolean,
        ByVal ckWeighted As Boolean,
        ByVal isEmail As Boolean,
        ByVal LimitToCurrRecs As Boolean,
        ByVal ThesaurusList As ArrayList,
        ByVal txtThesaurus As String,
        ByVal cbThesaurusText As String, ByVal calledBy As String) As String

    ''' <summary>
    ''' Gens the email generated SQL.
    ''' </summary>
    ''' <param name="UserID">The user identifier.</param>
    ''' <param name="SearchParms">The search parms.</param>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <returns>System.String.</returns>
    <OperationContract()>
    Function GenEmailGeneratedSQL(UserID As String, ByVal SearchParms As List(Of DS_SearchTerms), ByRef SecureID As Integer) As String

    ''' <summary>
    ''' Gens the content search SQL.
    ''' </summary>
    ''' <param name="UserID">The user identifier.</param>
    ''' <param name="SearchParms">The search parms.</param>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="UID">The uid.</param>
    ''' <param name="SearchString">The search string.</param>
    ''' <param name="ckLimitToExisting">if set to <c>true</c> [ck limit to existing].</param>
    ''' <param name="txtThesaurus">The text thesaurus.</param>
    ''' <param name="cbThesaurusText">The cb thesaurus text.</param>
    ''' <param name="ckLimitToLib">if set to <c>true</c> [ck limit to library].</param>
    ''' <param name="LibraryName">Name of the library.</param>
    ''' <param name="ckWeighted">if set to <c>true</c> [ck weighted].</param>
    ''' <returns>System.String.</returns>
    <OperationContract()>
    Function GenContentSearchSQL(UserID As String, ByVal SearchParms As List(Of DS_SearchTerms), ByRef SecureID As Integer, ByVal UID As String, ByVal SearchString As String, ByVal ckLimitToExisting As Boolean, ByVal txtThesaurus As String, ByVal cbThesaurusText As String, ByVal ckLimitToLib As Boolean, ByVal LibraryName As String, ByVal ckWeighted As Boolean) As String

    ''' <summary>
    ''' Changes the user content public.
    ''' </summary>
    ''' <param name="ServiceID">The service identifier.</param>
    ''' <param name="CurrSelectedUserGuid">The curr selected user unique identifier.</param>
    ''' <param name="isPublic">The is public.</param>
    ''' <param name="RC">if set to <c>true</c> [rc].</param>
    ''' <param name="RetMsg">The ret MSG.</param>
    <OperationContract()>
    Sub ChangeUserContentPublic(ByVal ServiceID As Integer, ByVal CurrSelectedUserGuid As String, ByVal isPublic As String, ByRef RC As Boolean, ByRef RetMsg As String)

    ''' <summary>
    ''' Refactors the specified secure identifier.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="NewOwnerID">Creates new ownerid.</param>
    ''' <param name="OldOwnerID">The old owner identifier.</param>
    ''' <param name="RC">if set to <c>true</c> [rc].</param>
    ''' <param name="RetMsg">The ret MSG.</param>
    <OperationContract()>
    Sub Refactor(ByVal SecureID As Integer, ByVal NewOwnerID As String, ByVal OldOwnerID As String, ByRef RC As Boolean, ByRef RetMsg As String)

    ''' <summary>
    ''' Gets the state of the saas.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="UserID">The user identifier.</param>
    ''' <param name="DirName">Name of the dir.</param>
    ''' <param name="FullPath">The full path.</param>
    ''' <param name="RetMsg">The ret MSG.</param>
    ''' <param name="RC">if set to <c>true</c> [rc].</param>
    ''' <returns>System.String.</returns>
    <OperationContract()>
    Function getSAASState(ByVal SecureID As Integer, ByVal UserID As String, ByVal DirName As String, ByVal FullPath As String, ByRef RetMsg As String, ByRef RC As Boolean) As String

    ''' <summary>
    ''' Sets the state of the saas.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="UserID">The user identifier.</param>
    ''' <param name="DirName">Name of the dir.</param>
    ''' <param name="FullPath">The full path.</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    <OperationContract()>
    Function SetSAASState(ByVal SecureID As Integer, ByVal UserID As String, ByVal DirName As String, ByVal FullPath As String) As Boolean

    <OperationContract()>
    Function getNewListOfStrings(ByRef SecureID As Integer, ByVal MySql As String, ByRef RC As Boolean, ByRef RetMsg As String, UserId As String, SessionID As String) As List(Of String)

    <OperationContract()>
    Function getListOfStrings01(ByRef SecureID As Integer, ByVal MySql As String, ByRef RC As Boolean, ByRef RetMsg As String, UserId As String, SessionID As String) As String

    ''' <summary>
    ''' Gets the list of strings02.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="MySql">My SQL.</param>
    ''' <param name="RC">if set to <c>true</c> [rc].</param>
    ''' <param name="RetMsg">The ret MSG.</param>
    ''' <param name="UserId">The user identifier.</param>
    ''' <param name="SessionID">The session identifier.</param>
    ''' <returns>List(Of DS_ListOfStrings02).</returns>
    <OperationContract()>
    Function getListOfStrings02(ByRef SecureID As Integer, ByVal MySql As String, ByRef RC As Boolean, ByRef RetMsg As String, UserId As String, SessionID As String) As List(Of DS_ListOfStrings02)

    ''' <summary>
    ''' Gets the list of strings03.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="MySql">My SQL.</param>
    ''' <param name="RC">if set to <c>true</c> [rc].</param>
    ''' <param name="RetMsg">The ret MSG.</param>
    ''' <param name="UserId">The user identifier.</param>
    ''' <param name="SessionID">The session identifier.</param>
    ''' <returns>List(Of DS_ListOfStrings03).</returns>
    <OperationContract()>
    Function getListOfStrings03(ByRef SecureID As Integer, ByVal MySql As String, ByRef RC As Boolean, ByRef RetMsg As String, UserId As String, SessionID As String) As List(Of DS_ListOfStrings03)

    ''' <summary>
    ''' Gets the list of strings04.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="MySql">My SQL.</param>
    ''' <param name="RC">if set to <c>true</c> [rc].</param>
    ''' <param name="RetMsg">The ret MSG.</param>
    ''' <param name="UserId">The user identifier.</param>
    ''' <param name="SessionID">The session identifier.</param>
    ''' <returns>List(Of DS_ListOfStrings04).</returns>
    <OperationContract()>
    Function getListOfStrings04(ByRef SecureID As Integer, ByVal MySql As String, ByRef RC As Boolean, ByRef RetMsg As String, UserId As String, SessionID As String) As List(Of DS_ListOfStrings04)

    ''' <summary>
    ''' Populates the library users grid.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="LibraryName">Name of the library.</param>
    ''' <param name="ckLibUsersOnly">if set to <c>true</c> [ck library users only].</param>
    ''' <returns>System.String.</returns>
    <OperationContract()>
    Function PopulateLibraryUsersGrid(ByRef SecureID As Integer, ByVal LibraryName As String, ByVal ckLibUsersOnly As Boolean) As String

    ''' <summary>
    ''' Gets the user authentication.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="Userid">The userid.</param>
    ''' <returns>System.String.</returns>
    <OperationContract()>
    Function getUserAuth(ByRef SecureID As Integer, ByVal Userid As String) As String

    ''' <summary>
    ''' Deletes the user.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="SelectedUserGuid">The selected user unique identifier.</param>
    ''' <param name="RetMsg">The ret MSG.</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    <OperationContract()>
    Function DeleteUser(ByRef SecureID As Integer, ByVal SelectedUserGuid As String, ByRef RetMsg As String) As Boolean

    ''' <summary>
    ''' Saves the u ser.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="UserID">The user identifier.</param>
    ''' <param name="UserName">Name of the user.</param>
    ''' <param name="EmailAddress">The email address.</param>
    ''' <param name="UserPassword">The user password.</param>
    ''' <param name="Admin">The admin.</param>
    ''' <param name="isActive">The is active.</param>
    ''' <param name="UserLoginID">The user login identifier.</param>
    ''' <param name="ClientOnly">if set to <c>true</c> [client only].</param>
    ''' <param name="HiveConnectionName">Name of the hive connection.</param>
    ''' <param name="HiveActive">if set to <c>true</c> [hive active].</param>
    ''' <param name="RepoSvrName">Name of the repo SVR.</param>
    ''' <param name="RowCreationDate">The row creation date.</param>
    ''' <param name="RowLastModDate">The row last mod date.</param>
    ''' <param name="ActiveGuid">The active unique identifier.</param>
    ''' <param name="RepoName">Name of the repo.</param>
    ''' <param name="RC">if set to <c>true</c> [rc].</param>
    ''' <param name="RetMsg">The ret MSG.</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    <OperationContract()>
    Function SaveUSer(ByVal SecureID As Integer, ByRef UserID As String, ByRef UserName As String, ByRef EmailAddress As String,
                      ByRef UserPassword As String, ByRef Admin As String, ByRef isActive As String,
                      ByRef UserLoginID As String, ByRef ClientOnly As Boolean, ByRef HiveConnectionName As String,
                      ByRef HiveActive As Boolean, ByRef RepoSvrName As String, ByRef RowCreationDate As Date, ByRef RowLastModDate As Date,
                      ByRef ActiveGuid As String, ByRef RepoName As String, ByRef RC As Boolean, ByRef RetMsg As String) As Boolean

    ''' <summary>
    ''' Saves the search schedule.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="SearchName">Name of the search.</param>
    ''' <param name="NotificationSMS">The notification SMS.</param>
    ''' <param name="SearchDesc">The search desc.</param>
    ''' <param name="OwnerID">The owner identifier.</param>
    ''' <param name="SearchQuery">The search query.</param>
    ''' <param name="SendToEmail">The send to email.</param>
    ''' <param name="ScheduleUnit">The schedule unit.</param>
    ''' <param name="ScheduleHour">The schedule hour.</param>
    ''' <param name="ScheduleDaysOfWeek">The schedule days of week.</param>
    ''' <param name="ScheduleDaysOfMonth">The schedule days of month.</param>
    ''' <param name="ScheduleMonthOfQtr">The schedule month of QTR.</param>
    ''' <param name="StartToRunDate">The start to run date.</param>
    ''' <param name="EndRunDate">The end run date.</param>
    ''' <param name="SearchParameters">The search parameters.</param>
    ''' <param name="LastRunDate">The last run date.</param>
    ''' <param name="NumberOfExecutions">The number of executions.</param>
    ''' <param name="CreateDate">The create date.</param>
    ''' <param name="LastModDate">The last mod date.</param>
    ''' <param name="ScheduleHourInterval">The schedule hour interval.</param>
    ''' <param name="RepoName">Name of the repo.</param>
    ''' <param name="RC">if set to <c>true</c> [rc].</param>
    ''' <param name="RetMsg">The ret MSG.</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    <OperationContract()>
    Function saveSearchSchedule(ByVal SecureID As Integer, ByRef SearchName As String, ByRef NotificationSMS As String, ByRef SearchDesc As String, ByRef OwnerID As String, ByRef SearchQuery As String, ByRef SendToEmail As String, ByRef ScheduleUnit As String, ByRef ScheduleHour As String, ByRef ScheduleDaysOfWeek As String, ByRef ScheduleDaysOfMonth As String, ByRef ScheduleMonthOfQtr As String, ByRef StartToRunDate As Date, ByRef EndRunDate As Date, ByRef SearchParameters As String, ByRef LastRunDate As Date, ByRef NumberOfExecutions As Integer, ByRef CreateDate As Date, ByRef LastModDate As Date, ByRef ScheduleHourInterval As Integer, ByRef RepoName As String, ByRef RC As Boolean, ByRef RetMsg As String) As Boolean

    ''' <summary>
    ''' Gets the search schedule.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="SearchName">Name of the search.</param>
    ''' <param name="NotificationSMS">The notification SMS.</param>
    ''' <param name="SearchDesc">The search desc.</param>
    ''' <param name="OwnerID">The owner identifier.</param>
    ''' <param name="SearchQuery">The search query.</param>
    ''' <param name="SendToEmail">The send to email.</param>
    ''' <param name="ScheduleUnit">The schedule unit.</param>
    ''' <param name="ScheduleHour">The schedule hour.</param>
    ''' <param name="ScheduleDaysOfWeek">The schedule days of week.</param>
    ''' <param name="ScheduleDaysOfMonth">The schedule days of month.</param>
    ''' <param name="ScheduleMonthOfQtr">The schedule month of QTR.</param>
    ''' <param name="StartToRunDate">The start to run date.</param>
    ''' <param name="EndRunDate">The end run date.</param>
    ''' <param name="SearchParameters">The search parameters.</param>
    ''' <param name="LastRunDate">The last run date.</param>
    ''' <param name="NumberOfExecutions">The number of executions.</param>
    ''' <param name="CreateDate">The create date.</param>
    ''' <param name="LastModDate">The last mod date.</param>
    ''' <param name="ScheduleHourInterval">The schedule hour interval.</param>
    ''' <param name="RepoName">Name of the repo.</param>
    ''' <param name="RC">if set to <c>true</c> [rc].</param>
    ''' <param name="RetMsg">The ret MSG.</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    <OperationContract()>
    Function getSearchSchedule(ByVal SecureID As Integer, ByRef SearchName As String, ByRef NotificationSMS As String, ByRef SearchDesc As String, ByRef OwnerID As String, ByRef SearchQuery As String, ByRef SendToEmail As String, ByRef ScheduleUnit As String, ByRef ScheduleHour As String, ByRef ScheduleDaysOfWeek As String, ByRef ScheduleDaysOfMonth As String, ByRef ScheduleMonthOfQtr As String, ByRef StartToRunDate As Date, ByRef EndRunDate As Date, ByRef SearchParameters As String, ByRef LastRunDate As Date, ByRef NumberOfExecutions As Integer, ByRef CreateDate As Date, ByRef LastModDate As Date, ByRef ScheduleHourInterval As Integer, ByRef RepoName As String, ByRef RC As Boolean, ByRef RetMsg As String) As Boolean

    ''' <summary>
    ''' Inserts the co owner.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="CurrentOwner">The current owner.</param>
    ''' <param name="CoOwner">The co owner.</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    <OperationContract()>
    Function InsertCoOwner(ByVal SecureID As Integer, ByVal CurrentOwner As String, ByVal CoOwner As String) As Boolean

    ''' <summary>
    ''' Populates the co owner grid.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="UID">The uid.</param>
    ''' <returns>System.String.</returns>
    <OperationContract()>
    Function PopulateCoOwnerGrid(ByVal SecureID As Integer, ByVal UID As String) As String

    ''' <summary>
    ''' Populates the user grid.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="UserID">The user identifier.</param>
    ''' <param name="DBisAdmin">if set to <c>true</c> [d bis admin].</param>
    ''' <returns>System.Collections.Generic.List(Of DS_VUserGrid).</returns>
    <OperationContract()>
    Function PopulateUserGrid(ByRef SecureID As Integer, ByVal UserID As String, ByVal DBisAdmin As Boolean) As System.Collections.Generic.List(Of DS_VUserGrid)

    ''' <summary>
    ''' Gets the group users.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="GroupName">Name of the group.</param>
    ''' <param name="GroupList">The group list.</param>
    ''' <param name="RC">if set to <c>true</c> [rc].</param>
    ''' <param name="RetMsg">The ret MSG.</param>
    <OperationContract()>
    Sub getGroupUsers(ByRef SecureID As Integer, ByVal GroupName As String, ByRef GroupList As ArrayList, ByRef RC As Boolean, ByRef RetMsg As String)

    ''' <summary>
    ''' Populates the dg group users.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="OwnerUserGuidID">The owner user unique identifier identifier.</param>
    ''' <param name="GroupName">Name of the group.</param>
    ''' <returns>System.String.</returns>
    <OperationContract()>
    Function PopulateDgGroupUsers(ByRef SecureID As Integer, ByVal OwnerUserGuidID As String, ByVal GroupName As String) As String

    ''' <summary>
    ''' Deletes the group users.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="CurrSelectedGroupName">Name of the curr selected group.</param>
    ''' <param name="GroupOwnerGuid">The group owner unique identifier.</param>
    ''' <param name="UserID">The user identifier.</param>
    ''' <param name="iDeleted">The i deleted.</param>
    ''' <param name="RetMsg">The ret MSG.</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    <OperationContract()>
    Function DeleteGroupUsers(SecureID As Integer, ByVal CurrSelectedGroupName As String,
                              ByVal GroupOwnerGuid As String,
                              ByVal UserID As String, ByRef iDeleted As Integer, ByRef RetMsg As String) As Boolean

    ''' <summary>
    ''' Gets the name of the group owner unique identifier by group.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="GroupName">Name of the group.</param>
    ''' <returns>System.String.</returns>
    <OperationContract()>
    Function getGroupOwnerGuidByGroupName(ByRef SecureID As Integer, ByVal GroupName As String) As String

    ''' <summary>
    ''' Adds the library group user.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="GroupName">Name of the group.</param>
    ''' <param name="RC">if set to <c>true</c> [rc].</param>
    ''' <param name="CurrUserID">The curr user identifier.</param>
    ''' <param name="SessionID">The session identifier.</param>
    ''' <param name="ControlSection">The control section.</param>
    <OperationContract()>
    Sub AddLibraryGroupUser(ByRef SecureID As Integer, ByVal GroupName As String, ByRef RC As Boolean, CurrUserID As String, SessionID As String, ControlSection As String)

    ''' <summary>
    ''' Populates the group user grid.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="GroupName">Name of the group.</param>
    ''' <returns>System.String.</returns>
    <OperationContract()>
    Function PopulateGroupUserGrid(ByRef SecureID As Integer, ByVal GroupName As String) As String

    ''' <summary>
    ''' Populates the library items grid.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="LibraryName">Name of the library.</param>
    ''' <param name="UserID">The user identifier.</param>
    ''' <returns>System.String.</returns>
    <OperationContract()>
    Function PopulateLibItemsGrid(ByRef SecureID As Integer, ByVal LibraryName As String, ByVal UserID As String) As String

    ''' <summary>
    ''' Populates the dg assigned.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="LibraryName">Name of the library.</param>
    ''' <param name="UserID">The user identifier.</param>
    ''' <returns>System.String.</returns>
    <OperationContract()>
    Function PopulateDgAssigned(ByRef SecureID As Integer, ByVal LibraryName As String, ByVal UserID As String) As String

    ''' <summary>
    ''' Resets the library users count.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="RC">if set to <c>true</c> [rc].</param>
    <OperationContract()>
    Sub ResetLibraryUsersCount(ByRef SecureID As Integer, ByRef RC As Boolean)

    ''' <summary>
    ''' Deletes the library group user.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="GroupName">Name of the group.</param>
    ''' <param name="LibraryName">Name of the library.</param>
    ''' <param name="RC">if set to <c>true</c> [rc].</param>
    <OperationContract()>
    Sub DeleteLibraryGroupUser(ByRef SecureID As Integer, ByVal GroupName As String, ByVal LibraryName As String, ByRef RC As Boolean)

    ''' <summary>
    ''' Changes the user password.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="UserLogin">The user login.</param>
    ''' <param name="OldPW">The old pw.</param>
    ''' <param name="NewPw1">Creates new pw1.</param>
    ''' <param name="NewPw2">Creates new pw2.</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    <OperationContract()>
    Function ChangeUserPassword(ByRef SecureID As Integer, ByVal UserLogin As String, ByVal OldPW As String, ByVal NewPw1 As String, ByVal NewPw2 As String) As Boolean

    ''' <summary>
    ''' Saves the click stats.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="IID">The iid.</param>
    ''' <param name="UserID">The user identifier.</param>
    ''' <param name="RC">if set to <c>true</c> [rc].</param>
    <OperationContract()>
    Sub SaveClickStats(SecureID As Integer, ByVal IID As Integer, ByVal UserID As String, ByRef RC As Boolean)

    ''' <summary>
    ''' Cleans up library items.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="UserID">The user identifier.</param>
    <OperationContract()>
    Sub cleanUpLibraryItems(ByRef SecureID As Integer, ByVal UserID As String)

    ''' <summary>
    ''' Removes the library directories.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="UserID">The user identifier.</param>
    ''' <param name="DirectoryName">Name of the directory.</param>
    ''' <param name="LibraryName">Name of the library.</param>
    ''' <param name="RC">if set to <c>true</c> [rc].</param>
    ''' <param name="RetMsg">The ret MSG.</param>
    <OperationContract()>
    Sub RemoveLibraryDirectories(ByRef SecureID As Integer, ByVal UserID As String, ByVal DirectoryName As String, ByVal LibraryName As String, ByRef RC As Boolean, ByRef RetMsg As String)

    ''' <summary>
    ''' Removes the library emails.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="FolderName">Name of the folder.</param>
    ''' <param name="LibraryName">Name of the library.</param>
    ''' <param name="UserID">The user identifier.</param>
    ''' <param name="RC">if set to <c>true</c> [rc].</param>
    ''' <param name="RetMsg">The ret MSG.</param>
    <OperationContract()>
    Sub RemoveLibraryEmails(ByRef SecureID As Integer, ByVal FolderName As String, ByVal LibraryName As String, ByVal UserID As String, ByRef RC As Boolean, ByRef RetMsg As String)

    ''' <summary>
    ''' Adds the system MSG.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="UserID">The user identifier.</param>
    ''' <param name="tMsg">The t MSG.</param>
    ''' <param name="RC">if set to <c>true</c> [rc].</param>
    <OperationContract()>
    Sub AddSysMsg(ByRef SecureID As Integer, ByVal UserID As String, ByVal tMsg As String, ByVal RC As Boolean)

    ''' <summary>
    ''' Adds the library directory.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="FolderName">Name of the folder.</param>
    ''' <param name="LibraryName">Name of the library.</param>
    ''' <param name="UserID">The user identifier.</param>
    ''' <param name="RecordsAdded">The records added.</param>
    ''' <param name="RC">if set to <c>true</c> [rc].</param>
    ''' <param name="RetMsg">The ret MSG.</param>
    <OperationContract()>
    Sub AddLibraryDirectory(ByRef SecureID As Integer, ByVal FolderName As String, ByVal LibraryName As String, ByVal UserID As String, ByRef RecordsAdded As Integer, ByRef RC As Boolean, ByRef RetMsg As String)

    ''' <summary>
    ''' Adds the library email.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="EmailFolder">The email folder.</param>
    ''' <param name="LibraryName">Name of the library.</param>
    ''' <param name="UserID">The user identifier.</param>
    ''' <param name="RecordsAdded">The records added.</param>
    ''' <param name="RC">if set to <c>true</c> [rc].</param>
    ''' <param name="RetMsg">The ret MSG.</param>
    <OperationContract()>
    Sub AddLibraryEmail(ByRef SecureID As Integer, ByVal EmailFolder As String, ByVal LibraryName As String, ByVal UserID As String, ByRef RecordsAdded As Integer, ByVal RC As Boolean, ByVal RetMsg As String)

    ''' <summary>
    ''' Populates the library grid.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="UserID">The user identifier.</param>
    ''' <returns>System.String.</returns>
    <OperationContract()>
    Function PopulateLibraryGrid(ByRef SecureID As Integer, ByVal UserID As String) As String

    ''' <summary>
    ''' Gets the list of strings.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="strListOfItems">The string list of items.</param>
    ''' <param name="MySql">My SQL.</param>
    ''' <param name="RC">if set to <c>true</c> [rc].</param>
    ''' <param name="RetMsg">The ret MSG.</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    <OperationContract()>
    Function getListOfStrings(ByRef SecureID As Integer, ByRef strListOfItems As String, ByVal MySql As String, ByRef RC As Boolean, ByRef RetMsg As String) As Boolean

    ''' <summary>
    ''' Gets the list of strings1.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="strListOfItems">The string list of items.</param>
    ''' <param name="MySql">My SQL.</param>
    ''' <param name="RC">if set to <c>true</c> [rc].</param>
    ''' <param name="RetMsg">The ret MSG.</param>
    ''' <param name="UserId">The user identifier.</param>
    ''' <param name="SessionID">The session identifier.</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    <OperationContract()>
    Function getListOfStrings1(ByRef SecureID As Integer, ByRef strListOfItems As String, ByVal MySql As String, ByRef RC As Boolean, ByRef RetMsg As String, UserId As String, SessionID As String) As Boolean

    ''' <summary>
    ''' Gets the list of strings2.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="strListOfItems">The string list of items.</param>
    ''' <param name="MySql">My SQL.</param>
    ''' <param name="RC">if set to <c>true</c> [rc].</param>
    ''' <param name="RetMsg">The ret MSG.</param>
    ''' <param name="UserId">The user identifier.</param>
    ''' <param name="SessionID">The session identifier.</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    <OperationContract()>
    Function getListOfStrings2(ByRef SecureID As Integer, ByRef strListOfItems As String, ByVal MySql As String, ByRef RC As Boolean, ByRef RetMsg As String, UserId As String, SessionID As String) As Boolean

    ''' <summary>
    ''' Gets the list of strings3.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="strListOfItems">The string list of items.</param>
    ''' <param name="MySql">My SQL.</param>
    ''' <param name="RC">if set to <c>true</c> [rc].</param>
    ''' <param name="RetMsg">The ret MSG.</param>
    ''' <param name="UserId">The user identifier.</param>
    ''' <param name="SessionID">The session identifier.</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    <OperationContract()>
    Function getListOfStrings3(ByRef SecureID As Integer, ByRef strListOfItems As String, ByVal MySql As String, ByRef RC As Boolean, ByRef RetMsg As String, UserId As String, SessionID As String) As Boolean

    ''' <summary>
    ''' Gets the list of strings4.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="strListOfItems">The string list of items.</param>
    ''' <param name="MySql">My SQL.</param>
    ''' <param name="RC">if set to <c>true</c> [rc].</param>
    ''' <param name="RetMsg">The ret MSG.</param>
    ''' <param name="UserId">The user identifier.</param>
    ''' <param name="SessionID">The session identifier.</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    <OperationContract()>
    Function getListOfStrings4(ByRef SecureID As Integer, strListOfItems As String, ByVal MySql As String, ByRef RC As Boolean, ByRef RetMsg As String, UserId As String, SessionID As String) As Boolean

    ''' <summary>
    ''' is the count.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="S">The s.</param>
    ''' <returns>System.Int32.</returns>
    <OperationContract()>
    Function iCount(ByRef SecureID As Integer, ByVal S As String) As Integer

    ''' <summary>
    ''' Gets the log path.
    ''' </summary>
    ''' <param name="tPath">The t path.</param>
    <OperationContract()>
    Sub GetLogPath(ByRef tPath As String)

    ''' <summary>
    ''' Actives the session get value.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="SessionGuid">The session unique identifier.</param>
    ''' <param name="ParmName">Name of the parm.</param>
    ''' <returns>System.String.</returns>
    <OperationContract()>
    Function ActiveSessionGetVal(ByRef SecureID As Integer, ByRef SessionGuid As Guid, ByRef ParmName As String) As String

    ''' <summary>
    ''' Actives the session.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="SessionGuid">The session unique identifier.</param>
    ''' <param name="ParmName">Name of the parm.</param>
    ''' <param name="ParmValue">The parm value.</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    <OperationContract()>
    Function ActiveSession(ByRef SecureID As Integer, ByVal SessionGuid As Guid, ByVal ParmName As String, ByVal ParmValue As String) As Boolean

    ''' <summary>
    ''' Sets the secure login parms.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="sCompanyID">The s company identifier.</param>
    ''' <param name="sRepoID">The s repo identifier.</param>
    ''' <param name="RC">if set to <c>true</c> [rc].</param>
    <OperationContract()>
    Sub setSecureLoginParms(ByRef SecureID As Integer, ByVal sCompanyID As String, ByVal sRepoID As String, ByRef RC As Boolean)

    ''' <summary>
    ''' Populates the secure login cb v2.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="AllRepos">All repos.</param>
    ''' <param name="CompanyID">The company identifier.</param>
    ''' <param name="RC">if set to <c>true</c> [rc].</param>
    ''' <param name="RetMsg">The ret MSG.</param>
    <OperationContract()>
    Sub PopulateSecureLoginCB_V2(ByRef SecureID As Integer, ByRef AllRepos As String, ByVal CompanyID As String, ByRef RC As Boolean, ByRef RetMsg As String)

    ''' <summary>
    ''' Populates the secure login cb.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="CB">The cb.</param>
    ''' <param name="CompanyID">The company identifier.</param>
    ''' <param name="RC">if set to <c>true</c> [rc].</param>
    ''' <param name="RetMsg">The ret MSG.</param>
    <OperationContract()>
    Sub PopulateSecureLoginCB(ByRef SecureID As Integer, ByRef CB As String, ByVal CompanyID As String, ByRef RC As Boolean, ByRef RetMsg As String)

    ''' <summary>
    ''' Gets the login pw.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <returns>System.Object.</returns>
    <OperationContract()>
    Function getLoginPW(ByRef SecureID As Integer) As Object

    ''' <summary>
    ''' Sets the login pw.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="RepoID">The repo identifier.</param>
    <OperationContract()>
    Sub setLoginPW(ByRef SecureID As Integer, ByVal RepoID As String)

    ''' <summary>
    ''' Gets the session enc cs.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <returns>System.Object.</returns>
    <OperationContract()>
    Function getSessionEncCs(ByRef SecureID As Integer) As Object

    ''' <summary>
    ''' Sets the session enc cs.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="MySessionID">My session identifier.</param>
    <OperationContract()>
    Sub setSessionEncCs(ByRef SecureID As Integer, ByVal MySessionID As String)

    ''' <summary>
    ''' Sets the session repo identifier.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="RepoID">The repo identifier.</param>
    <OperationContract()>
    Sub setSessionRepoID(ByRef SecureID As Integer, ByVal RepoID As String)

    ''' <summary>
    ''' Gets the session repo identifier.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <returns>System.Object.</returns>
    <OperationContract()>
    Function getSessionRepoID(ByRef SecureID As Integer) As Object

    ''' <summary>
    ''' Sets the session company identifier.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="CompanyID">The company identifier.</param>
    ''' <param name="RC">if set to <c>true</c> [rc].</param>
    <OperationContract()>
    Sub setSessionCompanyID(ByRef SecureID As Integer, ByVal CompanyID As String, ByRef RC As Boolean)

    ''' <summary>
    ''' Gets the session company identifier.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <returns>System.Object.</returns>
    <OperationContract()>
    Function getSessionCompanyID(ByRef SecureID As Integer) As Object

    ''' <summary>
    ''' Sets the login unique identifier.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="MyLoginGuid">My login unique identifier.</param>
    <OperationContract()>
    Sub setLoginGuid(ByRef SecureID As Integer, ByVal MyLoginGuid As String)

    ''' <summary>
    ''' Gets the login unique identifier.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <returns>System.Object.</returns>
    <OperationContract()>
    Function getLoginGuid(ByRef SecureID As Integer) As Object

    ''' <summary>
    ''' Gets the HTTP session identifier.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <returns>System.Object.</returns>
    <OperationContract()>
    Function getHttpSessionID(ByRef SecureID As Integer) As Object

    ''' <summary>
    ''' Sets the session identifier.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="MySessionID">My session identifier.</param>
    <OperationContract()>
    Sub setSessionID(ByRef SecureID As Integer, ByVal MySessionID As String)

    ''' <summary>
    ''' Expands the inflection terms.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="S">The s.</param>
    ''' <returns>System.String.</returns>
    <OperationContract()>
    Function ExpandInflectionTerms(ByRef SecureID As Integer, ByVal S As String) As String

    ''' <summary>
    ''' Gets the name of the server database.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <returns>System.String.</returns>
    <OperationContract()>
    Function getServerDatabaseName(ByRef SecureID As Integer) As String

    ''' <summary>
    ''' Cleans the log.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    <OperationContract()>
    Sub CleanLog(ByRef SecureID As Integer)

    ''' <summary>
    ''' Populates the ComboBox.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="CB">The cb.</param>
    ''' <param name="TblColName">Name of the table col.</param>
    ''' <param name="S">The s.</param>
    <OperationContract()>
    Sub PopulateComboBox(ByRef SecureID As Integer, ByRef CB As String(), ByVal TblColName As String, ByVal S As String)

    ''' <summary>
    ''' Gets the email attachments.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="CurrEmailGuid">The curr email unique identifier.</param>
    ''' <returns>System.String.</returns>
    <OperationContract()>
    Function GetEmailAttachments(ByRef SecureID As Integer, ByVal CurrEmailGuid As String) As String

    ''' <summary>
    ''' Databases the write to file.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="UID">The uid.</param>
    ''' <param name="SourceGuid">The source unique identifier.</param>
    ''' <param name="FileName">Name of the file.</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
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

    ''' <summary>
    ''' Sets the session variable.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="key">The key.</param>
    ''' <param name="KeyValue">The key value.</param>
    <OperationContract()>
    Sub SetSessionVariable(ByRef SecureID As Integer, ByVal key As String, ByVal KeyValue As String)

    ''' <summary>
    ''' Gets the session variable.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="key">The key.</param>
    ''' <returns>System.Object.</returns>
    <OperationContract()>
    Function GetSessionVariable(ByRef SecureID As Integer, ByVal key As String) As Object

    ''' <summary>
    ''' Updates the source image compressed.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="UploadFQN">The upload FQN.</param>
    ''' <param name="SourceGuid">The source unique identifier.</param>
    ''' <param name="LastAccessDate">The last access date.</param>
    ''' <param name="CreateDate">The create date.</param>
    ''' <param name="LastWriteTime">The last write time.</param>
    ''' <param name="VersionNbr">The version NBR.</param>
    ''' <param name="CompressedDataBuffer">The compressed data buffer.</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    <OperationContract()>
    Function UpdateSourceImageCompressed(ByRef SecureID As Integer, ByVal UploadFQN As String, ByVal SourceGuid As String, ByVal LastAccessDate As String, ByVal CreateDate As String, ByVal LastWriteTime As String, ByVal VersionNbr As Integer, ByVal CompressedDataBuffer() As Byte) As Boolean

    ''' <summary>
    ''' Writes the email from database to file.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="EmailGuid">The email unique identifier.</param>
    ''' <param name="SourceTypeCode">The source type code.</param>
    ''' <param name="CompressedDataBuffer">The compressed data buffer.</param>
    ''' <param name="OriginalSize">Size of the original.</param>
    ''' <param name="CompressedSize">Size of the compressed.</param>
    ''' <param name="RC">if set to <c>true</c> [rc].</param>
    <OperationContract()>
    Sub writeEmailFromDbToFile(ByRef SecureID As Integer, ByVal EmailGuid As String, ByRef SourceTypeCode As String, ByRef CompressedDataBuffer() As Byte, ByRef OriginalSize As Integer, ByRef CompressedSize As Integer, ByRef RC As Boolean)

    ''' <summary>
    ''' Writes the attachment from database write to file.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="RowID">The row identifier.</param>
    ''' <param name="FQN">The FQN.</param>
    ''' <param name="CompressedDataBuffer">The compressed data buffer.</param>
    ''' <param name="OriginalSize">Size of the original.</param>
    ''' <param name="CompressedSize">Size of the compressed.</param>
    ''' <param name="RC">if set to <c>true</c> [rc].</param>
    <OperationContract()>
    Sub writeAttachmentFromDbWriteToFile(ByRef SecureID As Integer, ByVal RowID As String, ByRef FQN As String, ByRef CompressedDataBuffer() As Byte, ByRef OriginalSize As Integer, ByRef CompressedSize As Integer, ByRef RC As Boolean)

    ''' <summary>
    ''' Writes the image source data from database write to file.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="SourceGuid">The source unique identifier.</param>
    ''' <param name="FQN">The FQN.</param>
    ''' <param name="CompressedDataBuffer">The compressed data buffer.</param>
    ''' <param name="OriginalSize">Size of the original.</param>
    ''' <param name="CompressedSize">Size of the compressed.</param>
    ''' <param name="RC">if set to <c>true</c> [rc].</param>
    <OperationContract()>
    Sub writeImageSourceDataFromDbWriteToFile(ByRef SecureID As Integer, ByVal SourceGuid As String, ByRef FQN As String, ByRef CompressedDataBuffer() As Byte, ByRef OriginalSize As Integer, ByRef CompressedSize As Integer, ByRef RC As Boolean)

    ''' <summary>
    ''' Adds the library items.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="SourceGuid">The source unique identifier.</param>
    ''' <param name="ItemTitle">The item title.</param>
    ''' <param name="ItemType">Type of the item.</param>
    ''' <param name="LibraryItemGuid">The library item unique identifier.</param>
    ''' <param name="DataSourceOwnerUserID">The data source owner user identifier.</param>
    ''' <param name="LibraryOwnerUserID">The library owner user identifier.</param>
    ''' <param name="LibraryName">Name of the library.</param>
    ''' <param name="AddedByUserGuidId">The added by user unique identifier identifier.</param>
    ''' <param name="RC">if set to <c>true</c> [rc].</param>
    ''' <param name="rMsg">The r MSG.</param>
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

    ''' <summary>
    ''' Populates the group user library combo.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="UID">The uid.</param>
    ''' <param name="cb">The cb.</param>
    <OperationContract()>
    Sub PopulateGroupUserLibCombo(ByRef SecureID As Integer, ByVal UID As String, ByRef cb As String)

    ''' <summary>
    ''' Gets the name of the library owner by.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="LibraryName">Name of the library.</param>
    ''' <returns>System.String.</returns>
    <OperationContract()>
    Function GetLibOwnerByName(ByRef SecureID As Integer, ByVal LibraryName As String) As String

    ''' <summary>
    ''' Generates the SQL.
    ''' </summary>
    ''' <param name="SearchParmList">The search parm list.</param>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="TypeSQL">The type SQL.</param>
    ''' <returns>System.String.</returns>
    <OperationContract()>
    Function GenerateSQL(ByVal SearchParmList As SortedList(Of String, String), ByRef SecureID As Integer, TypeSQL As String) As String

    <OperationContract>
    Function getRowIDs(ByRef SearchSQL As String, SearchTypeCode As String, SecureID As Integer) As String

    ''' <summary>
    ''' Gets the json data.
    ''' </summary>
    ''' <param name="I">The i.</param>
    ''' <returns>System.String.</returns>
    <OperationContract>
    Function getJsonData(I As String) As String

    ''' <summary>
    ''' Executes the search email.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="currSearchCnt">The curr search count.</param>
    ''' <param name="bGenSql">if set to <c>true</c> [b gen SQL].</param>
    ''' <param name="SearchParmsJson">The search parms json.</param>
    ''' <param name="bFirstEmailSearchSubmit">if set to <c>true</c> [b first email search submit].</param>
    ''' <param name="EmailRowCnt">The email row count.</param>
    ''' <returns>System.String.</returns>
    <OperationContract>
    Function ExecuteSearchEmail(ByRef SecureID As Integer,
                ByRef currSearchCnt As Integer,
                ByVal bGenSql As Boolean,
                ByVal SearchParmsJson As String,
                ByRef bFirstEmailSearchSubmit As Boolean,
                ByRef EmailRowCnt As Integer,
                                UserRowsToFetch As Integer) As String

    ''' <summary>
    ''' Executes the content of the search.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="currSearchCnt">The curr search count.</param>
    ''' <param name="bGenSql">if set to <c>true</c> [b gen SQL].</param>
    ''' <param name="SearchParmsJson">The search parms json.</param>
    ''' <param name="bFirstContentSearchSubmit">if set to <c>true</c> [b first content search submit].</param>
    ''' <param name="ContentRowCnt">The content row count.</param>
    ''' <returns>System.String.</returns>
    <OperationContract()>
    Function ExecuteSearchContent(ByRef SecureID As Integer,
                ByRef currSearchCnt As Integer,
                ByVal bGenSql As Boolean,
                ByVal SearchParmsJson As String,
                ByRef bFirstContentSearchSubmit As Boolean,
                ByRef ContentRowCnt As Integer,
                                  UserRowsToFetch As Integer) As String

    ''' <summary>
    ''' Gets the state of the search.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="SearchID">The search identifier.</param>
    ''' <param name="UID">The uid.</param>
    ''' <param name="ScreenName">Name of the screen.</param>
    ''' <param name="DICT">The dictionary.</param>
    ''' <param name="rMsg">The r MSG.</param>
    ''' <param name="RC">if set to <c>true</c> [rc].</param>
    ''' <param name="HiveConnectionName">Name of the hive connection.</param>
    ''' <param name="HiveActive">if set to <c>true</c> [hive active].</param>
    ''' <param name="RepoSvrName">Name of the repo SVR.</param>
    ''' <returns>List(Of DS_USERSEARCHSTATE).</returns>
    <OperationContract()>
    Function getSearchState(ByRef SecureID As Integer, ByVal SearchID As Integer, ByVal UID As String, ByVal ScreenName As String, ByRef DICT As Dictionary(Of String, String), ByRef rMsg As String, ByRef RC As Boolean, ByVal HiveConnectionName As String, ByVal HiveActive As Boolean, ByVal RepoSvrName As String) As List(Of DS_USERSEARCHSTATE)

    ''' <summary>
    ''' Saves the state of the search.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="SearchID">The search identifier.</param>
    ''' <param name="UID">The uid.</param>
    ''' <param name="ScreenName">Name of the screen.</param>
    ''' <param name="DICT">The dictionary.</param>
    ''' <param name="rMsg">The r MSG.</param>
    ''' <param name="RC">if set to <c>true</c> [rc].</param>
    ''' <param name="HiveConnectionName">Name of the hive connection.</param>
    ''' <param name="HiveActive">if set to <c>true</c> [hive active].</param>
    ''' <param name="RepoSvrName">Name of the repo SVR.</param>
    <OperationContract()>
    Sub saveSearchState(ByRef SecureID As Integer, ByVal SearchID As Integer, ByVal UID As String, ByVal ScreenName As String, ByVal DICT As Dictionary(Of String, String), ByRef rMsg As String, ByRef RC As Boolean, ByVal HiveConnectionName As String, ByVal HiveActive As Boolean, ByVal RepoSvrName As String)

    ''' <summary>
    ''' Gets the state of the screen.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="UID">The uid.</param>
    ''' <param name="ScreenName">Name of the screen.</param>
    ''' <param name="DICT">The dictionary.</param>
    ''' <param name="rMsg">The r MSG.</param>
    ''' <param name="RC">if set to <c>true</c> [rc].</param>
    ''' <param name="HiveConnectionName">Name of the hive connection.</param>
    ''' <param name="HiveActive">if set to <c>true</c> [hive active].</param>
    ''' <param name="RepoSvrName">Name of the repo SVR.</param>
    ''' <returns>List(Of DS_USERSCREENSTATE).</returns>
    <OperationContract()>
    Function getScreenState(ByRef SecureID As Integer, ByVal UID As String, ByVal ScreenName As String, ByRef DICT As Dictionary(Of String, String), ByRef rMsg As String, ByRef RC As Boolean, ByVal HiveConnectionName As String, ByVal HiveActive As Boolean, ByVal RepoSvrName As String) As List(Of DS_USERSCREENSTATE)

    ''' <summary>
    ''' Gets the grid layout.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="UID">The uid.</param>
    ''' <param name="ScreenName">Name of the screen.</param>
    ''' <param name="GridName">Name of the grid.</param>
    ''' <param name="DICT">The dictionary.</param>
    ''' <param name="rMsg">The r MSG.</param>
    ''' <param name="RC">if set to <c>true</c> [rc].</param>
    ''' <param name="HiveConnectionName">Name of the hive connection.</param>
    ''' <param name="HiveActive">if set to <c>true</c> [hive active].</param>
    ''' <param name="RepoSvrName">Name of the repo SVR.</param>
    ''' <returns>List(Of DS_clsUSERGRIDSTATE).</returns>
    <OperationContract()>
    Function getGridLayout(ByRef SecureID As Integer, ByVal UID As String, ByVal ScreenName As String, GridName As String, ByVal DICT As Dictionary(Of String, String), ByRef rMsg As String, ByRef RC As Boolean, ByVal HiveConnectionName As String, ByVal HiveActive As Boolean, ByVal RepoSvrName As String) As List(Of DS_clsUSERGRIDSTATE)

    ''' <summary>
    ''' Saves the grid layout.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="UserID">The user identifier.</param>
    ''' <param name="ScreenName">Name of the screen.</param>
    ''' <param name="GridName">Name of the grid.</param>
    ''' <param name="ColName">Name of the col.</param>
    ''' <param name="ColOrder">The col order.</param>
    ''' <param name="ColWidth">Width of the col.</param>
    ''' <param name="ColVisible">if set to <c>true</c> [col visible].</param>
    ''' <param name="ColReadOnly">if set to <c>true</c> [col read only].</param>
    ''' <param name="ColSortOrder">The col sort order.</param>
    ''' <param name="ColSortAsc">if set to <c>true</c> [col sort asc].</param>
    ''' <param name="HiveConnectionName">Name of the hive connection.</param>
    ''' <param name="HiveActive">if set to <c>true</c> [hive active].</param>
    ''' <param name="RepoSvrName">Name of the repo SVR.</param>
    ''' <param name="RowCreationDate">The row creation date.</param>
    ''' <param name="RowLastModDate">The row last mod date.</param>
    ''' <param name="RowNbr">The row NBR.</param>
    ''' <param name="RC">if set to <c>true</c> [rc].</param>
    ''' <param name="rMsg">The r MSG.</param>
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

    ''' <summary>
    ''' Saves the state of the screen.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="UID">The uid.</param>
    ''' <param name="ScreenName">Name of the screen.</param>
    ''' <param name="DICT">The dictionary.</param>
    ''' <param name="rMsg">The r MSG.</param>
    ''' <param name="RC">if set to <c>true</c> [rc].</param>
    ''' <param name="HiveConnectionName">Name of the hive connection.</param>
    ''' <param name="HiveActive">if set to <c>true</c> [hive active].</param>
    ''' <param name="RepoSvrName">Name of the repo SVR.</param>
    <OperationContract()>
    Sub saveScreenState(ByRef SecureID As Integer, ByVal UID As String, ByVal ScreenName As String, ByVal DICT As Dictionary(Of String, String), ByRef rMsg As String, ByRef RC As Boolean, ByVal HiveConnectionName As String, ByVal HiveActive As Boolean, ByVal RepoSvrName As String)

    ''' <summary>
    ''' Gets the user parms.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="UserID">The user identifier.</param>
    ''' <param name="UserParms">The user parms.</param>
    <OperationContract()>
    Sub getUserParms(ByRef SecureID As Integer, ByVal UserID As String, ByRef UserParms As Dictionary(Of String, String))

    ''' <summary>
    ''' Parses the lic dictionary.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="S">The s.</param>
    ''' <param name="D">The d.</param>
    <OperationContract()>
    Sub ParseLicDictionary(ByRef SecureID As Integer, ByVal S As String, ByRef D As Dictionary(Of String, String))

    ''' <summary>
    ''' Licenses the type.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="RC">if set to <c>true</c> [rc].</param>
    ''' <param name="RetMsg">The ret MSG.</param>
    ''' <returns>System.String.</returns>
    <OperationContract()>
    Function LicenseType(ByVal SecureID As Integer, ByRef RC As Boolean, ByRef RetMsg As String) As String

    ''' <summary>
    ''' Gets the NBR users.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <returns>System.Int32.</returns>
    <OperationContract()>
    Function GetNbrUsers(ByRef SecureID As Integer) As Integer

    ''' <summary>
    ''' Determines whether the specified secure identifier is lease.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="RC">if set to <c>true</c> [rc].</param>
    ''' <param name="RetMsg">The ret MSG.</param>
    ''' <returns><c>true</c> if the specified secure identifier is lease; otherwise, <c>false</c>.</returns>
    <OperationContract()>
    Function isLease(ByVal SecureID As Integer, ByRef RC As Boolean, ByRef RetMsg As String) As Boolean

    ''' <summary>
    ''' Gets the maximum clients.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="RC">if set to <c>true</c> [rc].</param>
    ''' <param name="RetMsg">The ret MSG.</param>
    ''' <returns>System.Int32.</returns>
    <OperationContract()>
    Function getMaxClients(ByVal SecureID As Integer, ByRef RC As Boolean, ByRef RetMsg As String) As Integer

    ''' <summary>
    ''' Gets the name of the user host.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <returns>System.String.</returns>
    <OperationContract()>
    Function GetUserHostName(ByRef SecureID As Integer) As String

    ''' <summary>
    ''' Gets the user host address.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <returns>System.String.</returns>
    <OperationContract()>
    Function GetUserHostAddress(ByRef SecureID As Integer) As String

    ''' <summary>
    ''' Gets the user unique identifier identifier.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="UserLoginId">The user login identifier.</param>
    ''' <returns>System.String.</returns>
    <OperationContract()>
    Function getUserGuidID(ByRef SecureID As Integer, ByVal UserLoginId As String) As String

    ''' <summary>
    ''' Processes the dates.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <returns>Dictionary(Of System.String, System.DateTime).</returns>
    <OperationContract()>
    Function ProcessDates(ByRef SecureID As Integer) As Dictionary(Of String, Date)

    ''' <summary>
    ''' Gets the NBR machine all.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <returns>System.Int32.</returns>
    <OperationContract()>
    Function GetNbrMachineAll(ByRef SecureID As Integer) As Integer

    ''' <summary>
    ''' Gets the NBR machine.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="MachineName">Name of the machine.</param>
    ''' <returns>System.Int32.</returns>
    <OperationContract()>
    Function GetNbrMachine(ByRef SecureID As Integer, ByVal MachineName As String) As Integer

    ''' <summary>
    ''' Determines whether [is license located on assigned machine] [the specified secure identifier].
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="ServerValText">The server value text.</param>
    ''' <param name="InstanceValText">The instance value text.</param>
    ''' <param name="RC">if set to <c>true</c> [rc].</param>
    ''' <param name="RetMsg">The ret MSG.</param>
    ''' <returns><c>true</c> if [is license located on assigned machine] [the specified secure identifier]; otherwise, <c>false</c>.</returns>
    <OperationContract()>
    Function isLicenseLocatedOnAssignedMachine(ByRef SecureID As Integer, ByRef ServerValText As String, ByRef InstanceValText As String, ByRef RC As Boolean, ByRef RetMsg As String) As Boolean

    ''' <summary>
    ''' Gets the XRT.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="RC">if set to <c>true</c> [rc].</param>
    ''' <param name="RetMsg">The ret MSG.</param>
    ''' <returns>System.String.</returns>
    <OperationContract()>
    Function GetXrt(ByRef SecureID As Integer, ByVal RC As Boolean, ByVal RetMsg As String) As String

    ''' <summary>
    ''' Gets the SQL server version.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <returns>System.String.</returns>
    <OperationContract()>
    Function getSqlServerVersion(ByRef SecureID As Integer) As String

    ''' <summary>
    ''' Records the growth.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="RC">if set to <c>true</c> [rc].</param>
    <OperationContract()>
    Sub RecordGrowth(ByRef SecureID As Integer, ByRef RC As Boolean)

    ''' <summary>
    ''' Parses the lic.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="LT">The lt.</param>
    ''' <param name="tgtKey">The TGT key.</param>
    ''' <returns>System.String.</returns>
    <OperationContract()>
    Function ParseLic(ByRef SecureID As Integer, ByVal LT As String, ByVal tgtKey As String) As String

    ''' <summary>
    ''' Gets the name of the loggedin user.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <returns>System.String.</returns>
    <OperationContract()>
    Function GetLoggedinUserName(ByRef SecureID As Integer) As String

    ''' <summary>
    ''' Gets the dbsizemb.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <returns>System.Double.</returns>
    <OperationContract()>
    Function getDBSIZEMB(ByRef SecureID As Integer) As Double

    ''' <summary>
    ''' Resets the missing email ids.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="CurrUserGuidID">The curr user unique identifier identifier.</param>
    ''' <param name="RC">if set to <c>true</c> [rc].</param>
    <OperationContract()>
    Sub resetMissingEmailIds(ByRef SecureID As Integer, ByVal CurrUserGuidID As String, ByRef RC As Boolean)

    ''' <summary>
    ''' Users the parm insert update.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="ParmName">Name of the parm.</param>
    ''' <param name="UserID">The user identifier.</param>
    ''' <param name="ParmVal">The parm value.</param>
    ''' <param name="RC">if set to <c>true</c> [rc].</param>
    <OperationContract()>
    Sub UserParmInsertUpdate(ByRef SecureID As Integer, ByVal ParmName As String, ByVal UserID As String, ByVal ParmVal As String, ByRef RC As Boolean)

    ''' <summary>
    ''' Validates the login.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="UserLogin">The user login.</param>
    ''' <param name="PW">The pw.</param>
    ''' <param name="UserGuidID">The user unique identifier identifier.</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    <OperationContract()>
    Function validateLogin(ByRef SecureID As Integer, ByVal UserLogin As String, ByVal PW As String, ByRef UserGuidID As String) As Boolean

    ''' <summary>
    ''' Gets the logged in user.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <returns>System.String.</returns>
    <OperationContract()>
    Function getLoggedInUser(ByRef SecureID As Integer) As String

    ''' <summary>
    ''' Gets the name of the attached machine.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <returns>System.String.</returns>
    <OperationContract()>
    Function getAttachedMachineName(ByRef SecureID As Integer) As String

    ''' <summary>
    ''' Gets the name of the server instance.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <returns>System.String.</returns>
    <OperationContract()>
    Function getServerInstanceName(ByRef SecureID As Integer) As String

    ''' <summary>
    ''' Gets the name of the server machine.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <returns>System.String.</returns>
    <OperationContract()>
    Function getServerMachineName(ByRef SecureID As Integer) As String

    ''' <summary>
    ''' Gets the system parm.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="SystemParms">The system parms.</param>
    <OperationContract()>
    Sub getSystemParm(ByRef SecureID As Integer, ByRef SystemParms As Dictionary(Of String, String))

    ''' <summary>
    ''' Gets the synonyms.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="ThesaurusID">The thesaurus identifier.</param>
    ''' <param name="Token">The token.</param>
    ''' <param name="lbSynonyms">The lb synonyms.</param>
    ''' <returns>System.String.</returns>
    <OperationContract()>
    Function getSynonyms(ByRef SecureID As Integer, ByVal ThesaurusID As String, ByVal Token As String, ByRef lbSynonyms As String) As String

    ''' <summary>
    ''' Gets the thesaurus identifier.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="ThesaurusName">Name of the thesaurus.</param>
    ''' <returns>System.String.</returns>
    <OperationContract()>
    Function getThesaurusID(ByRef SecureID As Integer, ByVal ThesaurusName As String) As String

    ''' <summary>
    ''' is the content of the count.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="S">The s.</param>
    ''' <returns>System.Int32.</returns>
    <OperationContract()>
    Function iCountContent(ByRef SecureID As Integer, ByVal S As String) As Integer

    ''' <summary>
    ''' Gets the datasource parm.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="AttributeName">Name of the attribute.</param>
    ''' <param name="SourceGuid">The source unique identifier.</param>
    ''' <returns>System.String.</returns>
    <OperationContract()>
    Function getDatasourceParm(ByRef SecureID As Integer, ByVal AttributeName As String, ByVal SourceGuid As String) As String

    ''' <summary>
    ''' Saves the run parm.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="UserID">The user identifier.</param>
    ''' <param name="ParmID">The parm identifier.</param>
    ''' <param name="ParmVal">The parm value.</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    <OperationContract()>
    Function SaveRunParm(ByRef SecureID As Integer, ByVal UserID As String, ByRef ParmID As String, ByRef ParmVal As String) As Boolean

    ''' <summary>
    ''' is the get row count.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="TBL">The table.</param>
    ''' <param name="WhereClause">The where clause.</param>
    ''' <returns>System.Int32.</returns>
    <OperationContract()>
    Function iGetRowCount(ByRef SecureID As Integer, ByVal TBL As String, ByVal WhereClause As String) As Integer

    ''' <summary>
    ''' Zeroizes the global search.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    <OperationContract()>
    Function ZeroizeGlobalSearch(ByRef SecureID As Integer) As Boolean

    ''' <summary>
    ''' Updates the ip.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="HostName">Name of the host.</param>
    ''' <param name="IP">The ip.</param>
    ''' <param name="checkCode">The check code.</param>
    ''' <param name="RC">if set to <c>true</c> [rc].</param>
    <OperationContract()>
    Sub updateIp(ByRef SecureID As Integer, ByVal HostName As String, ByVal IP As String, ByVal checkCode As Integer, ByRef RC As Boolean)

    ''' <summary>
    ''' Populates the source grid with weights.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="StartingRow">The starting row.</param>
    ''' <param name="EndingRow">The ending row.</param>
    ''' <param name="CallerName">Name of the caller.</param>
    ''' <param name="MySql">My SQL.</param>
    ''' <param name="bNewRows">if set to <c>true</c> [b new rows].</param>
    ''' <param name="SourceRowCnt">The source row count.</param>
    ''' <returns>List(Of DS_CONTENT).</returns>
    <OperationContract()>
    Function PopulateSourceGridWithWeights(ByRef SecureID As Integer, ByVal StartingRow As Integer, ByVal EndingRow As Integer, ByVal CallerName As String, ByVal MySql As String, ByRef bNewRows As Boolean, ByRef SourceRowCnt As Integer) As List(Of DS_CONTENT)

    ''' <summary>
    ''' Populates the source grid no weights.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="StartingRow">The starting row.</param>
    ''' <param name="EndingRow">The ending row.</param>
    ''' <param name="CallerName">Name of the caller.</param>
    ''' <param name="MySql">My SQL.</param>
    ''' <param name="bNewRows">if set to <c>true</c> [b new rows].</param>
    ''' <param name="SourceRowCnt">The source row count.</param>
    ''' <returns>List(Of DS_CONTENT).</returns>
    <OperationContract()>
    Function PopulateSourceGridNoWeights(ByRef SecureID As Integer, ByVal StartingRow As Integer, ByVal EndingRow As Integer, ByVal CallerName As String, ByVal MySql As String, ByRef bNewRows As Boolean, ByRef SourceRowCnt As Integer) As List(Of DS_CONTENT)

    ''' <summary>
    ''' Populates the email grid with no weights.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="UID">The uid.</param>
    ''' <param name="CallerName">Name of the caller.</param>
    ''' <param name="MySql">My SQL.</param>
    ''' <param name="nbrWeightMin">The NBR weight minimum.</param>
    ''' <param name="StartingRow">The starting row.</param>
    ''' <param name="EndingRow">The ending row.</param>
    ''' <param name="bNewRows">if set to <c>true</c> [b new rows].</param>
    ''' <param name="EmailRowCnt">The email row count.</param>
    ''' <returns>List(Of DS_EMAIL).</returns>
    <OperationContract()>
    Function PopulateEmailGridWithNoWeights(ByRef SecureID As Integer, ByVal UID As String, ByVal CallerName As String, ByVal MySql As String, ByVal nbrWeightMin As String, ByVal StartingRow As Integer, ByVal EndingRow As Integer, ByRef bNewRows As Boolean, ByRef EmailRowCnt As Integer) As List(Of DS_EMAIL)

    ''' <summary>
    ''' Populates the email grid with weights.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="Userid">The userid.</param>
    ''' <param name="CallerName">Name of the caller.</param>
    ''' <param name="MySql">My SQL.</param>
    ''' <param name="nbrWeightMin">The NBR weight minimum.</param>
    ''' <param name="StartingRow">The starting row.</param>
    ''' <param name="EndingRow">The ending row.</param>
    ''' <param name="bNewRows">if set to <c>true</c> [b new rows].</param>
    ''' <param name="EmailRowCnt">The email row count.</param>
    ''' <returns>List(Of DS_EMAIL).</returns>
    <OperationContract()>
    Function PopulateEmailGridWithWeights(ByRef SecureID As Integer, ByVal Userid As String, ByVal CallerName As String, ByVal MySql As String, ByVal nbrWeightMin As String, ByVal StartingRow As Integer, ByVal EndingRow As Integer, ByRef bNewRows As Boolean, ByRef EmailRowCnt As Integer) As List(Of DS_EMAIL)

    ''' <summary>
    ''' Loads the user search history.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="MaxNbrSearches">The maximum NBR searches.</param>
    ''' <param name="Uid">The uid.</param>
    ''' <param name="Screen">The screen.</param>
    ''' <param name="SearchHistoryArrayList">The search history array list.</param>
    ''' <param name="NbrReturned">The NBR returned.</param>
    <OperationContract()>
    Sub LoadUserSearchHistory(ByRef SecureID As Integer, ByVal MaxNbrSearches As Integer, ByVal Uid As String, ByVal Screen As String, ByRef SearchHistoryArrayList As List(Of String), ByRef NbrReturned As Integer)

    ''' <summary>
    ''' Gets the attachment weights.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="SL">The sl.</param>
    ''' <param name="UserID">The user identifier.</param>
    <OperationContract()>
    Sub getAttachmentWeights(ByRef SecureID As Integer, ByRef SL As Dictionary(Of String, Integer), ByVal UserID As String)

    ''' <summary>
    ''' Executes the SQL new conn1.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="EncryptedMySql">The encrypted my SQL.</param>
    ''' <param name="UserID">The user identifier.</param>
    ''' <param name="ContractID">The contract identifier.</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    <OperationContract()>
    Function ExecuteSqlNewConn1(ByRef SecureID As Integer, ByRef EncryptedMySql As String, UserID As String, ContractID As String) As Boolean

    ''' <summary>
    ''' Executes the SQL new conn2.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="EncryptedMySql">The encrypted my SQL.</param>
    ''' <param name="UserID">The user identifier.</param>
    ''' <param name="ContractID">The contract identifier.</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    <OperationContract()>
    Function ExecuteSqlNewConn2(ByRef SecureID As Integer, ByRef EncryptedMySql As String, UserID As String, ContractID As String) As Boolean

    ''' <summary>
    ''' Executes the SQL new conn3.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="EncryptedMySql">The encrypted my SQL.</param>
    ''' <param name="UserID">The user identifier.</param>
    ''' <param name="ContractID">The contract identifier.</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    <OperationContract()>
    Function ExecuteSqlNewConn3(ByRef SecureID As Integer, ByRef EncryptedMySql As String, UserID As String, ContractID As String) As Boolean

    ''' <summary>
    ''' Executes the SQL new conn4.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="EncryptedMySql">The encrypted my SQL.</param>
    ''' <param name="UserID">The user identifier.</param>
    ''' <param name="ContractID">The contract identifier.</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    <OperationContract()>
    Function ExecuteSqlNewConn4(ByRef SecureID As Integer, ByRef EncryptedMySql As String, UserID As String, ContractID As String) As Boolean

    ''' <summary>
    ''' Executes the SQL new conn5.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="EncryptedMySql">The encrypted my SQL.</param>
    ''' <param name="UserID">The user identifier.</param>
    ''' <param name="ContractID">The contract identifier.</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    <OperationContract()>
    Function ExecuteSqlNewConn5(ByRef SecureID As Integer, ByRef EncryptedMySql As String, UserID As String, ContractID As String) As Boolean

    ''' <summary>
    ''' Executes the SQL new connection secure.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="MySql">My SQL.</param>
    ''' <param name="UserID">The user identifier.</param>
    ''' <param name="ContractID">The contract identifier.</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    <OperationContract()>
    Function ExecuteSqlNewConnSecure(ByRef SecureID As Integer, ByRef MySql As String, UserID As String, ContractID As String) As Boolean

    ''' <summary>
    ''' Gets the parm value.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="UID">The uid.</param>
    ''' <param name="Parms">The parms.</param>
    <OperationContract()>
    Sub GetParmValue(ByRef SecureID As Integer, ByVal UID As String, ByRef Parms As List(Of String))

    ''' <summary>
    ''' ds the bis global searcher.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="Userid">The userid.</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    <OperationContract()>
    Function DBisGlobalSearcher(ByRef SecureID As Integer, ByVal Userid As String) As Boolean

    ''' <summary>
    ''' ds the bis admin.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="Userid">The userid.</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    <OperationContract()>
    Function DBisAdmin(ByRef SecureID As Integer, ByVal Userid As String) As Boolean

    ''' <summary>
    ''' Gets the user parm.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="sVariable">The s variable.</param>
    ''' <param name="UserParm">The user parm.</param>
    <OperationContract()>
    Sub getUserParm(ByRef SecureID As Integer, ByRef sVariable As String, ByVal UserParm As String)

    ''' <summary>
    ''' Removes the unwanted characters.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="tgtString">The TGT string.</param>
    <OperationContract()>
    Sub RemoveUnwantedCharacters(ByRef SecureID As Integer, ByRef tgtString As String)

    ''' <summary>
    ''' Gets the machine ip.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <returns>System.String.</returns>
    <OperationContract()>
    Function GetMachineIP(ByRef SecureID As Integer) As String

    ''' <summary>
    ''' Gets the client licenses.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="CompanyID">The company identifier.</param>
    ''' <param name="ErrorMessage">The error message.</param>
    ''' <param name="RC">if set to <c>true</c> [rc].</param>
    ''' <returns>List(Of DS_License).</returns>
    <OperationContract()>
    Function getClientLicenses(ByRef SecureID As Integer, ByVal CompanyID As String, ByRef ErrorMessage As String, ByRef RC As Boolean) As List(Of DS_License)

End Interface

''' <summary>
''' Class DS_ImageData.
''' </summary>
<System.Runtime.Serialization.DataContract()>
Public Class DS_ImageData
    ''' <summary>
    ''' Gets or sets the name of the source.
    ''' </summary>
    ''' <value>The name of the source.</value>
    Public Property SourceName As String
    ''' <summary>
    ''' Gets or sets the length of the file.
    ''' </summary>
    ''' <value>The length of the file.</value>
    Public Property FileLength As Integer
    ''' <summary>
    ''' Gets or sets the source image.
    ''' </summary>
    ''' <value>The source image.</value>
    Public Property SourceImage As Byte()
End Class

''' <summary>
''' Class DS_EmailAttachments.
''' </summary>
<System.Runtime.Serialization.DataContract()>
Public Class DS_EmailAttachments

    ''' <summary>
    ''' The attachment name
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public AttachmentName As String

    ''' <summary>
    ''' The row identifier
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public RowID As Integer

    ''' <summary>
    ''' The email unique identifier
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public EmailGuid As String

End Class

''' <summary>
''' Class struct_LibUsers.
''' </summary>
<System.Runtime.Serialization.DataContract()>
Public Class struct_LibUsers

    ''' <summary>
    ''' The library name
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public LibraryName As String

    ''' <summary>
    ''' The user name
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public UserName As String

    ''' <summary>
    ''' The owner name
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public OwnerName As String

    ''' <summary>
    ''' The user unique identifier
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public UserGuid As String

    ''' <summary>
    ''' The owner unique identifier
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public OwnerGuid As String

    ''' <summary>
    ''' The user login identifier
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public UserLoginID As String

    ''' <summary>
    ''' The owner login identifier
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public OwnerLoginID As String

End Class

''' <summary>
''' Class struct_ActiveSearchGuids.
''' </summary>
<System.Runtime.Serialization.DataContract()>
Public Class struct_ActiveSearchGuids

    ''' <summary>
    ''' The TGT unique identifier
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public TgtGuid As String

    ''' <summary>
    ''' The TGT user identifier
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public TgtUserID As String

    ''' <summary>
    ''' The owner name
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public OwnerName As String

    ''' <summary>
    ''' The user unique identifier
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public UserGuid As String

    ''' <summary>
    ''' The owner unique identifier
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public OwnerGuid As String

    ''' <summary>
    ''' The user login identifier
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public UserLoginID As String

    ''' <summary>
    ''' The owner login identifier
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public OwnerLoginID As String

End Class

''' <summary>
''' Class struct_ArchiveFolderId.
''' </summary>
<System.Runtime.Serialization.DataContract()>
Public Class struct_ArchiveFolderId

    ''' <summary>
    ''' The container name
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public ContainerName As String

    ''' <summary>
    ''' The folder name
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public FolderName As String

    ''' <summary>
    ''' The folder identifier
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public FolderID As String

    ''' <summary>
    ''' The storeid
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public storeid As String

End Class

''' <summary>
''' Class struct_Dg.
''' </summary>
<System.Runtime.Serialization.DataContract()>
Public Class struct_Dg

    ''' <summary>
    ''' The c1
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public C1 As String

    ''' <summary>
    ''' The c2
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public C2 As String

    ''' <summary>
    ''' The c3
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public C3 As String

    ''' <summary>
    ''' The c4
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public C4 As String

    ''' <summary>
    ''' The c5
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public C5 As String

    ''' <summary>
    ''' The c6
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public C6 As String

    ''' <summary>
    ''' The c7
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public C7 As String

    ''' <summary>
    ''' The c8
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public C8 As String

    ''' <summary>
    ''' The c9
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public C9 As String

    ''' <summary>
    ''' The C10
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public C10 As String

    ''' <summary>
    ''' The C11
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public C11 As String

    ''' <summary>
    ''' The C12
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public C12 As String

    ''' <summary>
    ''' The C13
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public C13 As String

    ''' <summary>
    ''' The C14
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public C14 As String

    ''' <summary>
    ''' The C15
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public C15 As String

    ''' <summary>
    ''' The C16
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public C16 As String

    ''' <summary>
    ''' The C17
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public C17 As String

    ''' <summary>
    ''' The C18
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public C18 As String

    ''' <summary>
    ''' The C19
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public C19 As String

    ''' <summary>
    ''' The C20
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public C20 As String

    ''' <summary>
    ''' The C21
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public C21 As String

    ''' <summary>
    ''' The C22
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public C22 As String

    ''' <summary>
    ''' The C23
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public C23 As String

    ''' <summary>
    ''' The C24
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public C24 As String

    ''' <summary>
    ''' The C25
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public C25 As String

    ''' <summary>
    ''' The C26
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public C26 As String

    ''' <summary>
    ''' The C27
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public C27 As String

    ''' <summary>
    ''' The C28
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public C28 As String

    ''' <summary>
    ''' The C29
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public C29 As String

    ''' <summary>
    ''' The C30
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public C30 As String

End Class

''' <summary>
''' Class DS_EmailNoWeight.
''' </summary>
<System.Runtime.Serialization.DataContract()>
Public Class DS_EmailNoWeight

    ''' <summary>
    ''' The sent on
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public SentOn As Date

    ''' <summary>
    ''' The short subj
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public ShortSubj As String

    ''' <summary>
    ''' The sender email address
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public SenderEmailAddress As String

    ''' <summary>
    ''' The sender name
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public SenderName As String

    ''' <summary>
    ''' The sent to
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public SentTO As String

    ''' <summary>
    ''' The body
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public Body As String

    ''' <summary>
    ''' The cc
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public CC As String

    ''' <summary>
    ''' The BCC
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public Bcc As String

    ''' <summary>
    ''' The creation time
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public CreationTime As Date

    ''' <summary>
    ''' All recipients
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public AllRecipients As String

    ''' <summary>
    ''' The received by name
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public ReceivedByName As String

    ''' <summary>
    ''' The received time
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public ReceivedTime As Date

    ''' <summary>
    ''' The MSG size
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public MsgSize As Integer

    ''' <summary>
    ''' The subject
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public SUBJECT As String

    ''' <summary>
    ''' The original folder
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public OriginalFolder As String

    ''' <summary>
    ''' The email unique identifier
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public EmailGuid As String

    ''' <summary>
    ''' The retention expiration date
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public RetentionExpirationDate As Date

    ''' <summary>
    ''' The is public
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public isPublic As String

    ''' <summary>
    ''' The user identifier
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public UserID As String

    ''' <summary>
    ''' The source type code
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public SourceTypeCode As String

    ''' <summary>
    ''' The NBR attachments
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public NbrAttachments As Integer

    ''' <summary>
    ''' The rid
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public RID As String

    ''' <summary>
    ''' The repo SVR name
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public RepoSvrName As String

    ''' <summary>
    ''' The rowid
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public ROWID As String

End Class

''' <summary>
''' Class DS_EMAIL.
''' </summary>
<DataContract()>
Public Class DS_EMAIL

    ''' <summary>
    ''' The rank
    ''' </summary>
    <DataMember()>
    Public RANK As Integer

    ''' <summary>
    ''' The sent on
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public SentOn As Date

    ''' <summary>
    ''' The short subj
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public ShortSubj As String

    ''' <summary>
    ''' The sender email address
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public SenderEmailAddress As String

    ''' <summary>
    ''' The sender name
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public SenderName As String

    ''' <summary>
    ''' The sent to
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public SentTO As String

    ''' <summary>
    ''' The body
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public Body As String

    ''' <summary>
    ''' The cc
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public CC As String

    ''' <summary>
    ''' The BCC
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public Bcc As String

    ''' <summary>
    ''' The creation time
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public CreationTime As Date

    ''' <summary>
    ''' All recipients
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public AllRecipients As String

    ''' <summary>
    ''' The received by name
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public ReceivedByName As String

    ''' <summary>
    ''' The received time
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public ReceivedTime As Date

    ''' <summary>
    ''' The MSG size
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public MsgSize As Integer

    ''' <summary>
    ''' The subject
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public SUBJECT As String

    ''' <summary>
    ''' The original folder
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public OriginalFolder As String

    ''' <summary>
    ''' The email unique identifier
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public EmailGuid As String

    ''' <summary>
    ''' The retention expiration date
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public RetentionExpirationDate As Date

    ''' <summary>
    ''' The is public
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public isPublic As String

    ''' <summary>
    ''' The user identifier
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public UserID As String

    ''' <summary>
    ''' The source type code
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public SourceTypeCode As String

    ''' <summary>
    ''' The NBR attachments
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public NbrAttachments As Integer

    ''' <summary>
    ''' The rid
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public RID As String

    ''' <summary>
    ''' The repo SVR name
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public RepoSvrName As String

    ''' <summary>
    ''' The rowid
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public ROWID As String

    ''' <summary>
    ''' The found in attach
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public FoundInAttach As Boolean

    <System.Runtime.Serialization.DataMember()>
    Public RowSeq As Int32

End Class

''' <summary>
''' Class DS_CONTENT.
''' </summary>
<System.Runtime.Serialization.DataContract()>
Public Class DS_CONTENT

    ''' <summary>
    ''' The rank
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public RANK As Integer

    ''' <summary>
    ''' The source name
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public SourceName As String

    ''' <summary>
    ''' The create date
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public CreateDate As Date

    ''' <summary>
    ''' The version NBR
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public VersionNbr As Integer

    ''' <summary>
    ''' The last access date
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public LastAccessDate As Date

    ''' <summary>
    ''' The file length
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public FileLength As Integer

    ''' <summary>
    ''' The last write time
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public LastWriteTime As Date

    ''' <summary>
    ''' The original file type
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public OriginalFileType As String

    ''' <summary>
    ''' The is public
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public isPublic As String

    ''' <summary>
    ''' The FQN
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public FQN As String

    ''' <summary>
    ''' The source unique identifier
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public SourceGuid As String

    ''' <summary>
    ''' The data source owner user identifier
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public DataSourceOwnerUserID As String

    ''' <summary>
    ''' The file directory
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public FileDirectory As String

    ''' <summary>
    ''' The retention expiration date
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public RetentionExpirationDate As Date

    ''' <summary>
    ''' The is master
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public isMaster As String

    ''' <summary>
    ''' The structured data
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public StructuredData As Boolean

    ''' <summary>
    ''' The repo SVR name
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public RepoSvrName As String

    ''' <summary>
    ''' The rowid
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public ROWID As String

    ''' <summary>
    ''' The description
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public Description As String

    ''' <summary>
    ''' The RSS link FLG
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public RssLinkFlg As Boolean

    ''' <summary>
    ''' The is web page
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public isWebPage As String

    <System.Runtime.Serialization.DataMember()>
    Public RowSeq As Int32

End Class

''' <summary>
''' Class DS_License.
''' </summary>
<System.Runtime.Serialization.DataContract()>
Public Class DS_License

    ''' <summary>
    ''' The license NBR
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public LicenseNbr As Integer

    ''' <summary>
    ''' The company identifier
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public CompanyID As String

    ''' <summary>
    ''' The machine identifier
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public MachineID As String

    ''' <summary>
    ''' The license identifier
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public LicenseID As String

    ''' <summary>
    ''' The applied
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public Applied As String

    ''' <summary>
    ''' The purchased machines
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public PurchasedMachines As String

    ''' <summary>
    ''' The purchased users
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public PurchasedUsers As String

    ''' <summary>
    ''' The support active
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public SupportActive As String

    ''' <summary>
    ''' The support active date
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public SupportActiveDate As String

    ''' <summary>
    ''' The support inactive date
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public SupportInactiveDate As String

    ''' <summary>
    ''' The license text
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public LicenseText As String

    ''' <summary>
    ''' The license type code
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public LicenseTypeCode As String

    ''' <summary>
    ''' The encrypted license
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public EncryptedLicense As String

    ''' <summary>
    ''' The server name
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public ServerNAME As String

    ''' <summary>
    ''' The SQL instance name
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public SqlInstanceName As String

End Class

''' <summary>
''' Class DS_ErrorLogs.
''' </summary>
<System.Runtime.Serialization.DataContract()>
Public Class DS_ErrorLogs

    ''' <summary>
    ''' The severity
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public Severity As String

    ''' <summary>
    ''' The logged message
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public LoggedMessage As String

    ''' <summary>
    ''' The entry date
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public EntryDate As DateTime

    ''' <summary>
    ''' The log name
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public LogName As String

    ''' <summary>
    ''' The entry user identifier
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public EntryUserID As String

End Class

''' <summary>
''' Class DS_USERSCREENSTATE.
''' </summary>
<System.Runtime.Serialization.DataContract()>
Public Class DS_USERSCREENSTATE

    ''' <summary>
    ''' The screen name
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public ScreenName As String

    ''' <summary>
    ''' The user identifier
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public UserID As String

    ''' <summary>
    ''' The parm name
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public ParmName As String

    ''' <summary>
    ''' The parm value
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public ParmVal As String

    ''' <summary>
    ''' The parm data type
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public ParmDataType As String

    ''' <summary>
    ''' The hive connection name
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public HiveConnectionName As String

    ''' <summary>
    ''' The hive active
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public HiveActive As Boolean

    ''' <summary>
    ''' The repo SVR name
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public RepoSvrName As String

    ''' <summary>
    ''' The row creation date
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public RowCreationDate As Date

    ''' <summary>
    ''' The row last mod date
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public RowLastModDate As Date

    ''' <summary>
    ''' The row NBR
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public RowNbr As Integer

End Class

''' <summary>
''' Class DS_USERSEARCHSTATE.
''' </summary>
<System.Runtime.Serialization.DataContract()>
Public Class DS_USERSEARCHSTATE

    ''' <summary>
    ''' The search identifier
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public SearchID As Integer

    ''' <summary>
    ''' The screen name
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public ScreenName As String

    ''' <summary>
    ''' The user identifier
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public UserID As String

    ''' <summary>
    ''' The parm name
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public ParmName As String

    ''' <summary>
    ''' The parm value
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public ParmVal As String

    ''' <summary>
    ''' The parm data type
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public ParmDataType As String

    ''' <summary>
    ''' The hive connection name
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public HiveConnectionName As String

    ''' <summary>
    ''' The hive active
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public HiveActive As Boolean

    ''' <summary>
    ''' The repo SVR name
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public RepoSvrName As String

    ''' <summary>
    ''' The row creation date
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public RowCreationDate As Date

    ''' <summary>
    ''' The row last mod date
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public RowLastModDate As Date

    ''' <summary>
    ''' The row NBR
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public RowNbr As Integer

End Class

''' <summary>
''' Class DS_clsUSERGRIDSTATE.
''' </summary>
<System.Runtime.Serialization.DataContract()>
Public Class DS_clsUSERGRIDSTATE

    ''' <summary>
    ''' The user identifier
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public UserID As String

    ''' <summary>
    ''' The screen name
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public ScreenName As String

    ''' <summary>
    ''' The grid name
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public GridName As String

    ''' <summary>
    ''' The col name
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public ColName As String

    ''' <summary>
    ''' The col order
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public ColOrder As Integer

    ''' <summary>
    ''' The col width
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public ColWidth As Integer

    ''' <summary>
    ''' The col visible
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public ColVisible As Boolean

    ''' <summary>
    ''' The col read only
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public ColReadOnly As Boolean

    ''' <summary>
    ''' The col sort order
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public ColSortOrder As Integer

    ''' <summary>
    ''' The col sort asc
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public ColSortAsc As Boolean

    ''' <summary>
    ''' The hive connection name
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public HiveConnectionName As String

    ''' <summary>
    ''' The hive active
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public HiveActive As Boolean

    ''' <summary>
    ''' The repo SVR name
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public RepoSvrName As String

    ''' <summary>
    ''' The row creation date
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public RowCreationDate As Date

    ''' <summary>
    ''' The row last mod date
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public RowLastModDate As Date

    ''' <summary>
    ''' The row NBR
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public RowNbr As Integer

End Class

''' <summary>
''' Class DS_SearchTerms.
''' </summary>
<System.Runtime.Serialization.DataContract()>
Public Class DS_SearchTerms

    ''' <summary>
    ''' The search type code
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public SearchTypeCode As String

    ''' <summary>
    ''' The term
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public Term As String

    ''' <summary>
    ''' The term value
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public TermVal As String

    ''' <summary>
    ''' The term datatype
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public TermDatatype As String

End Class

''' <summary>
''' Class DS_SYSTEMPARMS.
''' </summary>
<System.Runtime.Serialization.DataContract()>
Public Class DS_SYSTEMPARMS

    ''' <summary>
    ''' The system parm
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public SysParm As String

    ''' <summary>
    ''' The system parm desc
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public SysParmDesc As String

    ''' <summary>
    ''' The system parm value
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public SysParmVal As String

    ''' <summary>
    ''' The FLG active
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public flgActive As String

    ''' <summary>
    ''' The is directory
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public isDirectory As String

    ''' <summary>
    ''' The is email folder
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public isEmailFolder As String

    ''' <summary>
    ''' The FLG all sub dirs
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public flgAllSubDirs As String

    ''' <summary>
    ''' The hive connection name
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public HiveConnectionName As String

    ''' <summary>
    ''' The hive active
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public HiveActive As Boolean

    ''' <summary>
    ''' The repo SVR name
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public RepoSvrName As String

    ''' <summary>
    ''' The row creation date
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public RowCreationDate As Date

    ''' <summary>
    ''' The row last mod date
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public RowLastModDate As Date

End Class

''' <summary>
''' Class DS_ZipFiles.
''' </summary>
<System.Runtime.Serialization.DataContract()>
Public Class DS_ZipFiles

    ''' <summary>
    ''' The source name
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public SourceName As String

    ''' <summary>
    ''' The is parent
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public isParent As Boolean

    ''' <summary>
    ''' The source unique identifier
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public SourceGuid As String

End Class

''' <summary>
''' Class DS_VLibraryStats.
''' </summary>
<System.Runtime.Serialization.DataContract()>
Public Class DS_VLibraryStats

    ''' <summary>
    ''' The library name
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public LibraryName As String

    ''' <summary>
    ''' The is public
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public isPublic As String

    ''' <summary>
    ''' The items
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public Items As Integer

    ''' <summary>
    ''' The members
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public Members As Integer

End Class

''' <summary>
''' Class DS_dgGrpUsers.
''' </summary>
<System.Runtime.Serialization.DataContract()>
Public Class DS_dgGrpUsers

    ''' <summary>
    ''' The user name
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public UserName As String

    ''' <summary>
    ''' The user identifier
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public UserID As String

End Class

''' <summary>
''' Class DS_DgAssigned.
''' </summary>
<System.Runtime.Serialization.DataContract()>
Public Class DS_DgAssigned

    ''' <summary>
    ''' The group name
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public GroupName As String

    ''' <summary>
    ''' The group owner user identifier
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public GroupOwnerUserID As String

End Class

''' <summary>
''' Class DS_LibItems.
''' </summary>
<System.Runtime.Serialization.DataContract()>
Public Class DS_LibItems

    ''' <summary>
    ''' The item title
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public ItemTitle As String

    ''' <summary>
    ''' The item type
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public ItemType As String

    ''' <summary>
    ''' The library name
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public LibraryName As String

    ''' <summary>
    ''' The library owner user identifier
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public LibraryOwnerUserID As String

    ''' <summary>
    ''' The added by user unique identifier identifier
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public AddedByUserGuidId As String

    ''' <summary>
    ''' The data source owner user identifier
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public DataSourceOwnerUserID As String

    ''' <summary>
    ''' The source unique identifier
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public SourceGuid As String

    ''' <summary>
    ''' The library item unique identifier
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public LibraryItemGuid As String

End Class

''' <summary>
''' Class DS_DgGroupUsers.
''' </summary>
<System.Runtime.Serialization.DataContract()>
Public Class DS_DgGroupUsers

    ''' <summary>
    ''' The user name
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public UserName As String

    ''' <summary>
    ''' The user identifier
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public UserID As String

    ''' <summary>
    ''' The full access
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public FullAccess As Boolean

    ''' <summary>
    ''' The read only access
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public ReadOnlyAccess As Boolean

    ''' <summary>
    ''' The delete access
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public DeleteAccess As Boolean

    ''' <summary>
    ''' The searchable
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public Searchable As Boolean

End Class

''' <summary>
''' Class DS_VUserGrid.
''' </summary>
<System.Runtime.Serialization.DataContract()>
Public Class DS_VUserGrid

    ''' <summary>
    ''' The user identifier
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public UserID As String

    ''' <summary>
    ''' The user name
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public UserName As String

    ''' <summary>
    ''' The email address
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public EmailAddress As String

    ''' <summary>
    ''' The admin
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public Admin As String

    ''' <summary>
    ''' The is active
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public isActive As String

    ''' <summary>
    ''' The user login identifier
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public UserLoginID As String

    ''' <summary>
    ''' The client only
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public ClientOnly As Boolean

    ''' <summary>
    ''' The hive connection name
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public HiveConnectionName As String

    ''' <summary>
    ''' The hive active
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public HiveActive As Boolean

    ''' <summary>
    ''' The repo SVR name
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public RepoSvrName As String

    ''' <summary>
    ''' The row creation date
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public RowCreationDate As Date

    ''' <summary>
    ''' The row last mod date
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public RowLastModDate As Date

End Class

''' <summary>
''' Class DS_CoOwner.
''' </summary>
<System.Runtime.Serialization.DataContract()>
Public Class DS_CoOwner

    ''' <summary>
    ''' The co owner name
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public CoOwnerName As String

    ''' <summary>
    ''' The co owner identifier
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public CoOwnerID As String

    ''' <summary>
    ''' The row identifier
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public RowID As Integer

End Class

''' <summary>
''' Class DS_VLibraryUsers.
''' </summary>
<System.Runtime.Serialization.DataContract()>
Public Class DS_VLibraryUsers

    ''' <summary>
    ''' The user identifier
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public UserID As String

    ''' <summary>
    ''' The library name
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public LibraryName As String

    ''' <summary>
    ''' The library owner user identifier
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public LibraryOwnerUserID As String

    ''' <summary>
    ''' The user name
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public UserName As String

End Class

''' <summary>
''' Class DS_SEARCHSCHEDULE.
''' </summary>
<System.Runtime.Serialization.DataContract()>
Public Class DS_SEARCHSCHEDULE

    ''' <summary>
    ''' The search name
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public SearchName As String

    ''' <summary>
    ''' The notification SMS
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public NotificationSMS As String

    ''' <summary>
    ''' The search desc
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public SearchDesc As String

    ''' <summary>
    ''' The owner identifier
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public OwnerID As String

    ''' <summary>
    ''' The search query
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public SearchQuery As String

    ''' <summary>
    ''' The send to email
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public SendToEmail As String

    ''' <summary>
    ''' The schedule unit
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public ScheduleUnit As String

    ''' <summary>
    ''' The schedule hour
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public ScheduleHour As String

    ''' <summary>
    ''' The schedule days of week
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public ScheduleDaysOfWeek As String

    ''' <summary>
    ''' The schedule days of month
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public ScheduleDaysOfMonth As String

    ''' <summary>
    ''' The schedule month of QTR
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public ScheduleMonthOfQtr As String

    ''' <summary>
    ''' The start to run date
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public StartToRunDate As Date

    ''' <summary>
    ''' The end run date
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public EndRunDate As Date

    ''' <summary>
    ''' The search parameters
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public SearchParameters As String

    ''' <summary>
    ''' The last run date
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public LastRunDate As Date

    ''' <summary>
    ''' The number of executions
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public NumberOfExecutions As Integer

    ''' <summary>
    ''' The create date
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public CreateDate As Date

    ''' <summary>
    ''' The last mod date
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public LastModDate As Date

    ''' <summary>
    ''' The schedule hour interval
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public ScheduleHourInterval As Integer

    ''' <summary>
    ''' The repo name
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public RepoName As String

End Class

''' <summary>
''' Class DS_ListOfStrings00.
''' </summary>
<System.Runtime.Serialization.DataContract()>
Public Class DS_ListOfStrings00

    ''' <summary>
    ''' The string item
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public strItem As String

End Class

''' <summary>
''' Class DS_ListOfStrings01.
''' </summary>
<System.Runtime.Serialization.DataContract()>
Public Class DS_ListOfStrings01

    ''' <summary>
    ''' The string item
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public strItem As String

End Class

''' <summary>
''' Class DS_ListOfStrings02.
''' </summary>
<System.Runtime.Serialization.DataContract()>
Public Class DS_ListOfStrings02

    ''' <summary>
    ''' The string item
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public strItem As String

End Class

''' <summary>
''' Class DS_ListOfStrings03.
''' </summary>
<System.Runtime.Serialization.DataContract()>
Public Class DS_ListOfStrings03

    ''' <summary>
    ''' The string item
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public strItem As String

End Class

''' <summary>
''' Class DS_ListOfStrings04.
''' </summary>
<System.Runtime.Serialization.DataContract()>
Public Class DS_ListOfStrings04

    ''' <summary>
    ''' The string item
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public strItem As String

End Class

''' <summary>
''' Class DS_RESTOREQUEUE.
''' </summary>
<System.Runtime.Serialization.DataContract()>
Public Class DS_RESTOREQUEUE

    ''' <summary>
    ''' The content unique identifier
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public ContentGuid As String

    ''' <summary>
    ''' The user identifier
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public UserID As String

    ''' <summary>
    ''' The machine identifier
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public MachineID As String

    ''' <summary>
    ''' The FQN
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public FQN As String

    ''' <summary>
    ''' The file size
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public FileSize As Integer

    ''' <summary>
    ''' The content type
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public ContentType As String

    ''' <summary>
    ''' The preview
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public Preview As Boolean

    ''' <summary>
    ''' The restore
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public Restore As Boolean

    ''' <summary>
    ''' The processing completed
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public ProcessingCompleted As Boolean

    ''' <summary>
    ''' The entry date
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public EntryDate As Date

    ''' <summary>
    ''' The processed date
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public ProcessedDate As Date

    ''' <summary>
    ''' The start download time
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public StartDownloadTime As Date

    ''' <summary>
    ''' The end download time
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public EndDownloadTime As Date

    ''' <summary>
    ''' The repo name
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public RepoName As String

    ''' <summary>
    ''' The row unique identifier
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public RowGuid As Guid

End Class

''' <summary>
''' Class DS_Metadata.
''' </summary>
<System.Runtime.Serialization.DataContract()>
Public Class DS_Metadata

    ''' <summary>
    ''' The attribute name
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public AttributeName As String

    ''' <summary>
    ''' The attribute value
    ''' </summary>
    <System.Runtime.Serialization.DataMember()>
    Public AttributeValue As String

End Class


''' <summary>
''' Class DS_ContentDS.
''' </summary>
<DataContract>
Public Class DS_ContentDS
    ''' <summary>
    ''' Gets or sets the content ds.
    ''' </summary>
    ''' <value>The content ds.</value>
    <DataMember>
    Public Property ContentDS As DataTable
End Class

