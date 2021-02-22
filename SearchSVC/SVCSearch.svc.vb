' *********************************************************************** Assembly : EcmCloudWcf.Web
' Author : wdale Created : 12-15-2020
'
' Last Modified By : wdale Last Modified On : 12-15-2020 ***********************************************************************
' <copyright file="SVCSearch.svc.vb" company="ECM Library,LLC">
'     Copyright @ECM Library 2020 all rights reserved.
' </copyright>
' <summary>
' </summary>
' ***********************************************************************
Imports ECMEncryption

' NOTE: You can use the "Rename" command on the context menu to change the class name "Service1" in
' code, svc and config file together.
''' <summary>
''' Class SVCSearch. Implements the <see cref="EcmCloudWcf.Web.IService1"/>
''' </summary>
''' <seealso cref="EcmCloudWcf.Web.IService1"/>
Public Class SVCSearch
    Implements IService1

    ''' <summary>
    ''' The CDF
    ''' </summary>
    Dim CDF As New clsCdf

    ''' <summary>
    ''' The database
    ''' </summary>
    Dim DB As New clsDatabaseSVR

    ''' <summary>
    ''' The log
    ''' </summary>
    Dim LOG As New clsLogging

    ''' <summary>
    ''' The gen
    ''' </summary>
    Dim GEN As New clsGeneratorSVR

    ''' <summary>
    ''' The enc
    ''' </summary>
    Public ENC As New ECMEncrypt

    ''' <summary>
    ''' Gets the length of the source.
    ''' </summary>
    ''' <param name="SourceGuid">The source unique identifier.</param>
    ''' <param name="SourceType">Type of the source.</param>
    ''' <returns>Int64.</returns>
    Public Function getSourceLength(ByVal SourceGuid As String, SourceType As String) As Int64 Implements IService1.getSourceLength
        Dim FileLen As Int64 = -1
        FileLen = DB.getSourceLength(SourceGuid, SourceType)
        Return FileLen
    End Function

    ''' <summary>
    ''' Gets the name of the source file.
    ''' </summary>
    ''' <param name="SourceGuid">The source unique identifier.</param>
    ''' <param name="SourceType">Type of the source.</param>
    ''' <returns>System.String.</returns>
    Public Function getSourceName(ByVal SourceGuid As String, SourceType As String) As String Implements IService1.getSourceName
        Return DB.getSourceName(SourceGuid, SourceType)
    End Function

    ''' <summary>
    ''' Downs the load document.
    ''' </summary>
    ''' <param name="TypeImage"> The type image.</param>
    ''' <param name="SourceGuid">The source unique identifier.</param>
    ''' <returns>System.Byte().</returns>
    Public Function DownLoadDocument(ByRef TypeImage As String, ByVal SourceGuid As String) As Byte() Implements IService1.DownLoadDocument
        Return DB.DownLoadDocument(TypeImage, SourceGuid)
    End Function

    ''' <summary>
    ''' Gets the attachment from database.
    ''' </summary>
    ''' <param name="SecureID"> The secure identifier.</param>
    ''' <param name="EmailGuid">The email unique identifier.</param>
    ''' <returns>System.Byte().</returns>
    Public Function GetAttachmentFromDB(ByRef SecureID As Integer, ByVal EmailGuid As String) As Byte() Implements IService1.GetAttachmentFromDB
        Dim fdata As Byte() = DB.GetAttachmentFromDB(SecureID, EmailGuid)
        Return fdata
    End Function

    ''' <summary>
    ''' Tests the IIS connection.
    ''' </summary>
    ''' <returns>System.String.</returns>
    Public Function TestIISConnection() As String Implements IService1.TestIISConnection
        Dim str As String = "IIS Service Running..."
        Return str
    End Function

    ''' <summary>
    ''' Tests the connection.
    ''' </summary>
    ''' <returns>System.String.</returns>
    Public Function TestConnection() As String Implements IService1.TestConnection
        Dim str As String = "Service Running - could not attach to database"
        If DB.getLicenseCount() >= 0 Then
            str = "Service connected and running... and connected to database"
        End If
        Return str
    End Function

    ''' <summary>
    ''' Gets the word inflections.
    ''' </summary>
    ''' <param name="qry">The qry.</param>
    ''' <param name="CS"> The cs.</param>
    ''' <returns>System.String.</returns>
    Public Function getWordInflections(qry As String, CS As String) As String Implements IService1.getWordInflections
        Return DB.getWordInflections(qry, CS)
    End Function

    ''' <summary>
    ''' Removes the expired alerts.
    ''' </summary>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    Public Function removeExpiredAlerts() As Boolean Implements IService1.removeExpiredAlerts
        Return DB.removeExpiredAlerts()
    End Function

    ''' <summary>
    ''' Changes the user password admin.
    ''' </summary>
    ''' <param name="AdminUserID">The admin user identifier.</param>
    ''' <param name="UserLogin">  The user login.</param>
    ''' <param name="NewPw1">     Creates new pw1.</param>
    ''' <param name="NewPw2">     Creates new pw2.</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    Function ChangeUserPasswordAdmin(AdminUserID As String, ByVal UserLogin As String, ByVal NewPw1 As String, ByVal NewPw2 As String) As Boolean Implements IService1.ChangeUserPasswordAdmin
        Return DB.ChangeUserPasswordAdmin(AdminUserID, UserLogin, NewPw1, NewPw2)
    End Function

    ''' <summary>
    ''' Adds the user group.
    ''' </summary>
    ''' <param name="GroupName">       Name of the group.</param>
    ''' <param name="GroupOwnerUserID">The group owner user identifier.</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    Function AddUserGroup(ByVal GroupName As String, ByVal GroupOwnerUserID As String) As Boolean Implements IService1.AddUserGroup
        Return DB.AddUserGroup(GroupName, GroupOwnerUserID)
    End Function

    ''' <summary>
    ''' <br/>
    ''' </summary>
    ''' <param name="MaxNbr">The maximum NBR.</param>
    ''' <returns>System.String.</returns>
    Function getErrorLogs(MaxNbr As String) As String Implements IService1.getErrorLogs
        Return DB.getErrorLogs(MaxNbr)
    End Function

    ''' <summary>
    ''' Sets the email public flag.
    ''' </summary>
    ''' <param name="SecureID"> The secure identifier.</param>
    ''' <param name="EmailGuid">The email unique identifier.</param>
    ''' <param name="isPublic"> if set to <c>true</c> [is public].</param>
    Sub SetEmailPublicFlag(ByRef SecureID As Integer, ByVal EmailGuid As String, ByVal isPublic As Boolean) Implements IService1.SetEmailPublicFlag
        DB.SetEmailPublicFlag(SecureID, EmailGuid, isPublic)
    End Sub

    ''' <summary>
    ''' Sets the document to master.
    ''' </summary>
    ''' <param name="SecureID">  The secure identifier.</param>
    ''' <param name="SourceGuid">The source unique identifier.</param>
    ''' <param name="MasterFlag">if set to <c>true</c> [master flag].</param>
    Sub SetDocumentToMaster(ByRef SecureID As Integer, ByVal SourceGuid As String, ByVal MasterFlag As Boolean) Implements IService1.SetDocumentToMaster
        DB.SetDocumentToMaster(SecureID, SourceGuid, MasterFlag)
    End Sub

    ''' <summary>
    ''' Sets the document public flag.
    ''' </summary>
    ''' <param name="SecureID">  The secure identifier.</param>
    ''' <param name="SourceGuid">The source unique identifier.</param>
    ''' <param name="isPublic">  if set to <c>true</c> [is public].</param>
    Sub SetDocumentPublicFlag(ByRef SecureID As Integer, ByVal SourceGuid As String, ByVal isPublic As Boolean) Implements IService1.SetDocumentPublicFlag
        DB.SetDocumentPublicFlag(SecureID, SourceGuid, isPublic)
    End Sub

    ''' <summary>
    ''' Executes the search json.
    ''' </summary>
    ''' <param name="TypeSearch">     The type search.</param>
    ''' <param name="JsonSearchParms">The json search parms.</param>
    ''' <param name="RetMsg">         The ret MSG.</param>
    ''' <returns>System.String.</returns>
    Function ExecuteSearchJson(TypeSearch As String, ByVal JsonSearchParms As String, ByRef RetMsg As String) As String Implements IService1.ExecuteSearchJson
        Return DB.ExecuteSearchJson(TypeSearch, JsonSearchParms, RetMsg)
    End Function

    ''' <summary>
    ''' Tests the service avail.
    ''' </summary>
    ''' <returns>System.String.</returns>
    Function testServiceAvail() As String Implements IService1.testServiceAvail
        Return "Service running @ " + Date.Today.ToString
    End Function

    ''' <summary>
    ''' Generates the search SQL.
    ''' </summary>
    ''' <param name="TypeSearch">    The type search.</param>
    ''' <param name="SearchParmList">The search parm list.</param>
    ''' <returns>System.String.</returns>
    Function GenerateSearchSQL(ByVal TypeSearch As String, ByVal SearchParmList As Dictionary(Of String, String)) As String Implements IService1.GenerateSearchSQL

        Return GEN.genSearchSQL(TypeSearch, SearchParmList)

    End Function

    ''' <summary>
    ''' Executes the search dt.
    ''' </summary>
    ''' <param name="SearchType">               Type of the search.</param>
    ''' <param name="currSearchCnt">            The curr search count.</param>
    ''' <param name="bGenSql">                  if set to <c>true</c> [b gen SQL].</param>
    ''' <param name="EmailGenSql">              The email gen SQL.</param>
    ''' <param name="SearchParmsJson">          The search parms json.</param>
    ''' <param name="ContentGenSql">            The content gen SQL.</param>
    ''' <param name="strListOEmailRows">        The string list o email rows.</param>
    ''' <param name="strListOfContentRows">     The string list of content rows.</param>
    ''' <param name="bFirstEmailSearchSubmit">  if set to <c>true</c> [b first email search submit].</param>
    ''' <param name="bFirstContentSearchSubmit">if set to <c>true</c> [b first content search submit].</param>
    ''' <param name="EmailRowCnt">              The email row count.</param>
    ''' <param name="ContentRowCnt">            The content row count.</param>
    ''' <returns>DataSet.</returns>
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

    ''' <summary>
    ''' Gets the security end point.
    ''' </summary>
    ''' <returns>System.String.</returns>
    Public Function getSecEndPoint() As String Implements IService1.getSecEndPoint
        Return System.Configuration.ConfigurationManager.AppSettings("ECMSecureLoginEndPoint")
    End Function

    ''' <summary>
    ''' Gets the contract identifier.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="UserID">  The user identifier.</param>
    ''' <returns>System.String.</returns>
    Public Function getContractID(SecureID As Integer, UserID As String) As String Implements IService1.getContractID
        Return DB.getContractID(SecureID, UserID)
    End Function

    ''' <summary>
    ''' Adds the group library access.
    ''' </summary>
    ''' <param name="SecureID">        The secure identifier.</param>
    ''' <param name="UserID">          The user identifier.</param>
    ''' <param name="LibraryName">     Name of the library.</param>
    ''' <param name="GroupName">       Name of the group.</param>
    ''' <param name="GroupOwnerUserID">The group owner user identifier.</param>
    ''' <param name="RC">              if set to <c>true</c> [rc].</param>
    ''' <param name="CurrUserID">      The curr user identifier.</param>
    ''' <param name="SessionID">       The session identifier.</param>
    ''' <param name="ControlSection">  The control section.</param>
    Sub AddGroupLibraryAccess(SecureID As Integer, UserID As String, LibraryName As String, GroupName As String, GroupOwnerUserID As String, ByRef RC As Boolean, CurrUserID As String, SessionID As String, ControlSection As String) Implements IService1.AddGroupLibraryAccess
        DB.AddGroupLibraryAccess(SecureID, UserID, LibraryName, GroupName, GroupOwnerUserID, RC, CurrUserID, SessionID, ControlSection)
    End Sub

    ''' <summary>
    ''' Adds the group user.
    ''' </summary>
    ''' <param name="SecureID">        The secure identifier.</param>
    ''' <param name="SessionID">       The session identifier.</param>
    ''' <param name="CurrUserID">      The curr user identifier.</param>
    ''' <param name="UserID">          The user identifier.</param>
    ''' <param name="FullAccess">      The full access.</param>
    ''' <param name="ReadOnlyAccess">  The read only access.</param>
    ''' <param name="DeleteAccess">    The delete access.</param>
    ''' <param name="Searchable">      The searchable.</param>
    ''' <param name="GroupOwnerUserID">The group owner user identifier.</param>
    ''' <param name="GroupName">       Name of the group.</param>
    ''' <param name="ControlSection">  The control section.</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    Public Function AddGroupUser(SecureID As Integer, SessionID As String, CurrUserID As String, UserID As String, FullAccess As String, ReadOnlyAccess As String, DeleteAccess As String, Searchable As String, GroupOwnerUserID As String, GroupName As String, ControlSection As String) As Boolean Implements IService1.AddGroupUser
        Return DB.AddGroupUser(SecureID, SessionID, CurrUserID, UserID, FullAccess, ReadOnlyAccess, DeleteAccess, Searchable, GroupOwnerUserID, GroupName, ControlSection)
    End Function

    'Function EncryptTripleDES(SecureID As Integer, ByVal Phrase As String, ByVal UserID As String) As String Implements IService1.EncryptTripleDES
    '    Return ENC.AES256DecryptString(SecureID, UserID, Phrase)
    'End Function
    'Function EncryptTripleDES(SecureID As Integer, ByVal Phrase As String, ByVal UserID As String) As String Implements IService1.EncryptTripleDES
    '    Return DB.dbEncryptPhrase(SecureID, UserID, Phrase)
    'End Function
    ''' <summary>
    ''' Cks the content flags.
    ''' </summary>
    ''' <param name="SecureID">  The secure identifier.</param>
    ''' <param name="SourceGuid">The source unique identifier.</param>
    ''' <param name="SD">        if set to <c>true</c> [sd].</param>
    ''' <param name="SP">        if set to <c>true</c> [sp].</param>
    ''' <param name="SAP">       if set to <c>true</c> [sap].</param>
    ''' <param name="bMaster">   if set to <c>true</c> [b master].</param>
    ''' <param name="RSS">       if set to <c>true</c> [RSS].</param>
    ''' <param name="WEB">       if set to <c>true</c> [web].</param>
    ''' <param name="bPublic">   if set to <c>true</c> [b public].</param>
    Public Sub ckContentFlags(SecureID As Integer, SourceGuid As String, ByRef SD As Boolean, ByRef SP As Boolean, ByRef SAP As Boolean, ByRef bMaster As Boolean, ByRef RSS As Boolean, ByRef WEB As Boolean, ByRef bPublic As Boolean) Implements IService1.ckContentFlags
        DB.ckContentFlags(SecureID, SourceGuid, SD, SP, SAP, bMaster, RSS, WEB, bPublic)
    End Sub

    ''' <summary>
    ''' Validates the attach secure login.
    ''' </summary>
    ''' <param name="SecureID">        The secure identifier.</param>
    ''' <param name="CompanyID">       The company identifier.</param>
    ''' <param name="RepoID">          The repo identifier.</param>
    ''' <param name="UserLogin">       The user login.</param>
    ''' <param name="PW">              The pw.</param>
    ''' <param name="RC">              if set to <c>true</c> [rc].</param>
    ''' <param name="RetMsg">          The ret MSG.</param>
    ''' <param name="GateWayEndPoint"> The gate way end point.</param>
    ''' <param name="DownloadEndpoint">The download endpoint.</param>
    ''' <param name="ENCCS">           The enccs.</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
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

    ''' <summary>
    ''' Populates the secure login cb v2.
    ''' </summary>
    ''' <param name="SecureID"> The secure identifier.</param>
    ''' <param name="AllRepos"> All repos.</param>
    ''' <param name="CompanyID">The company identifier.</param>
    ''' <param name="RC">       if set to <c>true</c> [rc].</param>
    ''' <param name="RetMsg">   The ret MSG.</param>
    Public Sub PopulateSecureLoginCB_V2(ByRef SecureID As Integer, ByRef AllRepos As String, ByVal CompanyID As String, ByRef RC As Boolean, ByRef RetMsg As String) Implements IService1.PopulateSecureLoginCB_V2
        DB.PopulateSecureLoginCB_V2(SecureID, AllRepos, CompanyID, RC, RetMsg)
    End Sub

    ''' <summary>
    ''' Gets the customer logo title.
    ''' </summary>
    ''' <returns>System.String.</returns>
    Public Function getCustomerLogoTitle() As String Implements IService1.getCustomerLogoTitle
        Return System.Configuration.ConfigurationManager.AppSettings("CustomerLogoTitle")
    End Function

    ''' <summary>
    ''' Gets the explode email zip.
    ''' </summary>
    ''' <returns>System.String.</returns>
    Public Function getExplodeEmailZip() As String Implements IService1.getExplodeEmailZip
        Return System.Configuration.ConfigurationManager.AppSettings("ExplodeEmailZip")
    End Function

    ''' <summary>
    ''' Gets the name of the facility.
    ''' </summary>
    ''' <returns>System.String.</returns>
    Public Function getFacilityName() As String Implements IService1.getFacilityName
        Return System.Configuration.ConfigurationManager.AppSettings("FacilityName")
    End Function

    ''' <summary>
    ''' Gets the affinitydelay.
    ''' </summary>
    ''' <returns>System.Int32.</returns>
    Public Function getAffinitydelay() As Integer Implements IService1.getAffinitydelay
        Return CInt(System.Configuration.ConfigurationManager.AppSettings("AffinityDelayMS"))
    End Function

    ''' <summary>
    ''' Gets the CLC URL.
    ''' </summary>
    ''' <returns>System.String.</returns>
    Public Function getClcURL() As String Implements IService1.getClcURL
        Return System.Configuration.ConfigurationManager.AppSettings("DownloadClcUrl")
    End Function

    ''' <summary>
    ''' Gets the archiver URL.
    ''' </summary>
    ''' <returns>System.String.</returns>
    Public Function getArchiverURL() As String Implements IService1.getArchiverURL
        Return System.Configuration.ConfigurationManager.AppSettings("DownloadArchiverURL")
    End Function

    ''' <summary>
    ''' Executes the SQL stack.
    ''' </summary>
    ''' <param name="SecureID">      The secure identifier.</param>
    ''' <param name="SqlStack">      The SQL stack.</param>
    ''' <param name="UserID">        The user identifier.</param>
    ''' <param name="SessionID">     The session identifier.</param>
    ''' <param name="ControlSection">The control section.</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    Public Function ExecuteSqlStack(ByRef SecureID As Integer, ByRef SqlStack As Dictionary(Of Integer, String), UserID As String, SessionID As String, ControlSection As String) As Boolean Implements IService1.ExecuteSqlStack
        Return DB.ExecuteSqlStack(SecureID, SqlStack, UserID, SessionID, ControlSection)
    End Function

    ''' <summary>
    ''' Gets the default screen.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="UserID">  The user identifier.</param>
    ''' <returns>System.String.</returns>
    Public Function getDefaultScreen(ByVal SecureID As Integer, ByVal UserID As String) As String Implements IService1.getDefaultScreen
        Return DB.getDefaultScreen(SecureID, UserID)
    End Function

    ''' <summary>
    ''' Recalls the user search.
    ''' </summary>
    ''' <param name="SecureID">   The secure identifier.</param>
    ''' <param name="SearchName"> Name of the search.</param>
    ''' <param name="UID">        The uid.</param>
    ''' <param name="strSearches">The string searches.</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    Public Function RecallUserSearch(ByVal SecureID As Integer, ByVal SearchName As String, ByVal UID As String, ByRef strSearches As String) As Boolean Implements IService1.RecallUserSearch
        Return DB.RecallUserSearch(SecureID, SearchName, UID, strSearches)
    End Function

    ''' <summary>
    ''' Saves the user search.
    ''' </summary>
    ''' <param name="SecureID">   The secure identifier.</param>
    ''' <param name="SearchName"> Name of the search.</param>
    ''' <param name="UID">        The uid.</param>
    ''' <param name="strSearches">The string searches.</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    Public Function SaveUserSearch(ByVal SecureID As Integer, ByVal SearchName As String, ByVal UID As String, ByVal strSearches As String) As Boolean Implements IService1.SaveUserSearch
        Return DB.SaveUserSearch(SecureID, SearchName, UID, strSearches)
    End Function

    ''' <summary>
    ''' Gets the files in zip detail.
    ''' </summary>
    ''' <param name="SecureID">  The secure identifier.</param>
    ''' <param name="ParentGuid">The parent unique identifier.</param>
    ''' <param name="RC">        if set to <c>true</c> [rc].</param>
    ''' <returns>System.String.</returns>
    Public Function GetFilesInZipDetail(ByRef SecureID As Integer, ByVal ParentGuid As String, ByRef RC As Boolean) As String Implements IService1.GetFilesInZipDetail
        Dim ListOfFiles As String = DB.GetFilesInZipDetail(SecureID, ParentGuid, RC)
        Return ListOfFiles
    End Function

    ''' <summary>
    ''' Schedules the file down load.
    ''' </summary>
    ''' <param name="SecureID">   The secure identifier.</param>
    ''' <param name="ContentGuid">The content unique identifier.</param>
    ''' <param name="UserID">     The user identifier.</param>
    ''' <param name="ContentType">Type of the content.</param>
    ''' <param name="Preview">    The preview.</param>
    ''' <param name="Restore">    The restore.</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    Public Function scheduleFileDownLoad(ByVal SecureID As Integer,
                                  ByVal ContentGuid As String,
                                  ByVal UserID As String,
                                  ByVal ContentType As String,
                                  ByVal Preview As Integer,
                                  ByVal Restore As Integer) As Boolean Implements IService1.scheduleFileDownLoad

        Return DB.scheduleFileDownLoad(SecureID, ContentGuid, UserID, ContentType, Preview, Restore)

    End Function

    ''' <summary>
    ''' Gets the content meta data.
    ''' </summary>
    ''' <param name="SecureID">  The secure identifier.</param>
    ''' <param name="SourceGuid">The source unique identifier.</param>
    ''' <returns>System.String.</returns>
    Public Function GetContentMetaData(ByVal SecureID As Integer, ByVal SourceGuid As String) As String Implements IService1.GetContentMetaData
        Dim ListOfItems As List(Of DS_Metadata) = DB.GetContentMetaData(SecureID, SourceGuid)
        Return Newtonsoft.Json.JsonConvert.SerializeObject(ListOfItems)
    End Function

    ''' <summary>
    ''' Removes the restore file by unique identifier.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="RowGuid"> The row unique identifier.</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    Public Function removeRestoreFileByGuid(ByVal SecureID As Integer, ByVal RowGuid As String) As Boolean Implements IService1.removeRestoreFileByGuid
        Return DB.removeRestoreFileByGuid(SecureID, RowGuid)
    End Function

    ''' <summary>
    ''' Removes the restore files.
    ''' </summary>
    ''' <param name="SecureID"> The secure identifier.</param>
    ''' <param name="UserID">   The user identifier.</param>
    ''' <param name="MachineID">The machine identifier.</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    Public Function removeRestoreFiles(ByVal SecureID As Integer, ByRef UserID As String, ByRef MachineID As String) As Boolean Implements IService1.removeRestoreFiles
        Return DB.removeRestoreFiles(SecureID, UserID, MachineID)
    End Function

    ''' <summary>
    ''' Gets the restore file count.
    ''' </summary>
    ''' <param name="SecureID"> The secure identifier.</param>
    ''' <param name="UserID">   The user identifier.</param>
    ''' <param name="MachineID">The machine identifier.</param>
    ''' <param name="Preview">  if set to <c>true</c> [preview].</param>
    ''' <returns>System.Int32.</returns>
    Public Function getRestoreFileCount(ByVal SecureID As Integer, ByRef UserID As String, ByRef MachineID As String, ByRef Preview As Boolean) As Integer Implements IService1.getRestoreFileCount
        Return DB.getRestoreFileCount(SecureID, UserID, MachineID, Preview)
    End Function

    ''' <summary>
    ''' Saves the restore file.
    ''' </summary>
    ''' <param name="SecureID">   The secure identifier.</param>
    ''' <param name="tgtTable">   The TGT table.</param>
    ''' <param name="ContentGuid">The content unique identifier.</param>
    ''' <param name="Preview">    if set to <c>true</c> [preview].</param>
    ''' <param name="Restore">    if set to <c>true</c> [restore].</param>
    ''' <param name="UserID">     The user identifier.</param>
    ''' <param name="MachineID">  The machine identifier.</param>
    ''' <param name="RC">         if set to <c>true</c> [rc].</param>
    ''' <param name="RetMsg">     The ret MSG.</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    Public Function saveRestoreFile(ByVal SecureID As Integer, ByVal tgtTable As String, ByRef ContentGuid As String, ByVal Preview As Boolean, ByVal Restore As Boolean, ByRef UserID As String, ByRef MachineID As String, ByRef RC As Boolean, ByVal RetMsg As String) As Boolean Implements IService1.saveRestoreFile
        Return DB.saveRestoreFile(SecureID, tgtTable, ContentGuid, Preview, Restore, UserID, MachineID, RC, RetMsg)
    End Function

    ''' <summary>
    ''' Gens the email attachments SQL.
    ''' </summary>
    ''' <param name="UserID">           The user identifier.</param>
    ''' <param name="SearchParms">      The search parms.</param>
    ''' <param name="SecureID">         The secure identifier.</param>
    ''' <param name="InputSearchString">The input search string.</param>
    ''' <param name="useFreetext">      if set to <c>true</c> [use freetext].</param>
    ''' <param name="ckWeighted">       if set to <c>true</c> [ck weighted].</param>
    ''' <param name="isEmail">          if set to <c>true</c> [is email].</param>
    ''' <param name="LimitToCurrRecs">  if set to <c>true</c> [limit to curr recs].</param>
    ''' <param name="ThesaurusList">    The thesaurus list.</param>
    ''' <param name="txtThesaurus">     The text thesaurus.</param>
    ''' <param name="cbThesaurusText">  The cb thesaurus text.</param>
    ''' <param name="calledBy">         The called by.</param>
    ''' <returns>System.String.</returns>
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

    ''' <summary>
    ''' Gens the email generated SQL.
    ''' </summary>
    ''' <param name="UserID">     The user identifier.</param>
    ''' <param name="SearchParms">The search parms.</param>
    ''' <param name="SecureID">   The secure identifier.</param>
    ''' <returns>System.String.</returns>
    Public Function GenEmailGeneratedSQL(UserID As String, ByVal SearchParms As List(Of DS_SearchTerms), ByRef SecureID As Integer) As String Implements IService1.GenEmailGeneratedSQL

        Dim SearchTerms As String = ""
        Dim SearchHistory As String = ""

        Dim SearchParmList As New SortedList(Of String, String)
        DB.setSearchParms(SecureID, UserID, SearchParmList, SearchParms)

        Dim tSql As String = ""
        tSql = GEN.GenEmailGeneratedSQL(SearchParmList, SecureID, 0)

        Return tSql

    End Function

    ''' <summary>
    ''' Gens the content search SQL.
    ''' </summary>
    ''' <param name="UserID">           The user identifier.</param>
    ''' <param name="SearchParms">      The search parms.</param>
    ''' <param name="SecureID">         The secure identifier.</param>
    ''' <param name="UID">              The uid.</param>
    ''' <param name="SearchString">     The search string.</param>
    ''' <param name="ckLimitToExisting">if set to <c>true</c> [ck limit to existing].</param>
    ''' <param name="txtThesaurus">     The text thesaurus.</param>
    ''' <param name="cbThesaurusText">  The cb thesaurus text.</param>
    ''' <param name="ckLimitToLib">     if set to <c>true</c> [ck limit to library].</param>
    ''' <param name="LibraryName">      Name of the library.</param>
    ''' <param name="ckWeighted">       if set to <c>true</c> [ck weighted].</param>
    ''' <returns>System.String.</returns>
    Public Function GenContentSearchSQL(UserID As String, ByVal SearchParms As List(Of DS_SearchTerms), ByRef SecureID As Integer, ByVal UID As String, ByVal SearchString As String, ByVal ckLimitToExisting As Boolean, ByVal txtThesaurus As String, ByVal cbThesaurusText As String, ByVal ckLimitToLib As Boolean, ByVal LibraryName As String, ByVal ckWeighted As Boolean) As String Implements IService1.GenContentSearchSQL

        Dim SearchParmList As New SortedList(Of String, String)
        DB.setSearchParms(SecureID, UserID, SearchParmList, SearchParms)

        Dim tSql As String = GEN.GenContentSearchSQL(SearchParmList, SecureID)
        Return tSql

    End Function

    ''' <summary>
    ''' Changes the user content public.
    ''' </summary>
    ''' <param name="ServiceID">           The service identifier.</param>
    ''' <param name="CurrSelectedUserGuid">The curr selected user unique identifier.</param>
    ''' <param name="isPublic">            The is public.</param>
    ''' <param name="RC">                  if set to <c>true</c> [rc].</param>
    ''' <param name="RetMsg">              The ret MSG.</param>
    Public Sub ChangeUserContentPublic(ByVal ServiceID As Integer, ByVal CurrSelectedUserGuid As String, ByVal isPublic As String, ByRef RC As Boolean, ByRef RetMsg As String) Implements IService1.ChangeUserContentPublic
        DB.ChangeUserContentPublic(ServiceID, CurrSelectedUserGuid, isPublic, RC, RetMsg)
    End Sub

    ''' <summary>
    ''' Refactors the specified secure identifier.
    ''' </summary>
    ''' <param name="SecureID">  The secure identifier.</param>
    ''' <param name="NewOwnerID">Creates new ownerid.</param>
    ''' <param name="OldOwnerID">The old owner identifier.</param>
    ''' <param name="RC">        if set to <c>true</c> [rc].</param>
    ''' <param name="RetMsg">    The ret MSG.</param>
    Public Sub Refactor(ByVal SecureID As Integer, ByVal NewOwnerID As String, ByVal OldOwnerID As String, ByRef RC As Boolean, ByRef RetMsg As String) Implements IService1.Refactor
        DB.Refactor(SecureID, NewOwnerID, OldOwnerID, RC, RetMsg)
    End Sub

    ''' <summary>
    ''' Gets the state of the saas.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="UserID">  The user identifier.</param>
    ''' <param name="DirName"> Name of the dir.</param>
    ''' <param name="FullPath">The full path.</param>
    ''' <param name="RetMsg">  The ret MSG.</param>
    ''' <param name="RC">      if set to <c>true</c> [rc].</param>
    ''' <returns>System.String.</returns>
    Public Function getSAASState(ByVal SecureID As Integer, ByVal UserID As String, ByVal DirName As String, ByVal FullPath As String, ByRef RetMsg As String, ByRef RC As Boolean) As String Implements IService1.getSAASState
        Return DB.getSAASState(SecureID, UserID, DirName, FullPath, RetMsg, RC)
    End Function

    ''' <summary>
    ''' Sets the state of the saas.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="UserID">  The user identifier.</param>
    ''' <param name="DirName"> Name of the dir.</param>
    ''' <param name="FullPath">The full path.</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    Public Function SetSAASState(ByVal SecureID As Integer, ByVal UserID As String, ByVal DirName As String, ByVal FullPath As String) As Boolean Implements IService1.SetSAASState
        Return DB.SetSAASState(SecureID, UserID, DirName, FullPath)
    End Function

    ''' <summary>
    ''' Populates the library users grid.
    ''' </summary>
    ''' <param name="SecureID">      The secure identifier.</param>
    ''' <param name="LibraryName">   Name of the library.</param>
    ''' <param name="ckLibUsersOnly">if set to <c>true</c> [ck library users only].</param>
    ''' <returns>System.String.</returns>
    Public Function PopulateLibraryUsersGrid(ByRef SecureID As Integer, ByVal LibraryName As String, ByVal ckLibUsersOnly As Boolean) As String Implements IService1.PopulateLibraryUsersGrid
        Dim ListOfRows As New List(Of DS_VLibraryUsers)
        ListOfRows = DB.PopulateLibraryUsersGrid(SecureID, LibraryName, ckLibUsersOnly)
        Return Newtonsoft.Json.JsonConvert.SerializeObject(ListOfRows)
    End Function

    ''' <summary>
    ''' Gets the user authentication.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="Userid">  The userid.</param>
    ''' <returns>System.String.</returns>
    Public Function getUserAuth(ByRef SecureID As Integer, ByVal Userid As String) As String Implements IService1.getUserAuth
        Return DB.getUserAuth(SecureID, Userid)
    End Function

    ''' <summary>
    ''' Deletes the user.
    ''' </summary>
    ''' <param name="SecureID">        The secure identifier.</param>
    ''' <param name="SelectedUserGuid">The selected user unique identifier.</param>
    ''' <param name="RetMsg">          The ret MSG.</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    Public Function DeleteUser(ByRef SecureID As Integer, ByVal SelectedUserGuid As String, ByRef RetMsg As String) As Boolean Implements IService1.DeleteUser
        Return DB.DeleteUser(SecureID, SelectedUserGuid, RetMsg)
    End Function

    ''' <summary>
    ''' Saves the user.
    ''' </summary>
    ''' <param name="SecureID">          The secure identifier.</param>
    ''' <param name="UserID">            The user identifier.</param>
    ''' <param name="UserName">          Name of the user.</param>
    ''' <param name="EmailAddress">      The email address.</param>
    ''' <param name="UserPassword">      The user password.</param>
    ''' <param name="Admin">             The admin.</param>
    ''' <param name="isActive">          The is active.</param>
    ''' <param name="UserLoginID">       The user login identifier.</param>
    ''' <param name="ClientOnly">        if set to <c>true</c> [client only].</param>
    ''' <param name="HiveConnectionName">Name of the hive connection.</param>
    ''' <param name="HiveActive">        if set to <c>true</c> [hive active].</param>
    ''' <param name="RepoSvrName">       Name of the repo SVR.</param>
    ''' <param name="RowCreationDate">   The row creation date.</param>
    ''' <param name="RowLastModDate">    The row last mod date.</param>
    ''' <param name="ActiveGuid">        The active unique identifier.</param>
    ''' <param name="RepoName">          Name of the repo.</param>
    ''' <param name="RC">                if set to <c>true</c> [rc].</param>
    ''' <param name="RetMsg">            The ret MSG.</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
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

    ''' <summary>
    ''' Saves the search schedule.
    ''' </summary>
    ''' <param name="SecureID">            The secure identifier.</param>
    ''' <param name="SearchName">          Name of the search.</param>
    ''' <param name="NotificationSMS">     The notification SMS.</param>
    ''' <param name="SearchDesc">          The search desc.</param>
    ''' <param name="OwnerID">             The owner identifier.</param>
    ''' <param name="SearchQuery">         The search query.</param>
    ''' <param name="SendToEmail">         The send to email.</param>
    ''' <param name="ScheduleUnit">        The schedule unit.</param>
    ''' <param name="ScheduleHour">        The schedule hour.</param>
    ''' <param name="ScheduleDaysOfWeek">  The schedule days of week.</param>
    ''' <param name="ScheduleDaysOfMonth"> The schedule days of month.</param>
    ''' <param name="ScheduleMonthOfQtr">  The schedule month of QTR.</param>
    ''' <param name="StartToRunDate">      The start to run date.</param>
    ''' <param name="EndRunDate">          The end run date.</param>
    ''' <param name="SearchParameters">    The search parameters.</param>
    ''' <param name="LastRunDate">         The last run date.</param>
    ''' <param name="NumberOfExecutions">  The number of executions.</param>
    ''' <param name="CreateDate">          The create date.</param>
    ''' <param name="LastModDate">         The last mod date.</param>
    ''' <param name="ScheduleHourInterval">The schedule hour interval.</param>
    ''' <param name="RepoName">            Name of the repo.</param>
    ''' <param name="RC">                  if set to <c>true</c> [rc].</param>
    ''' <param name="RetMsg">              The ret MSG.</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    Public Function saveSearchSchedule(ByVal SecureID As Integer, ByRef SearchName As String, ByRef NotificationSMS As String, ByRef SearchDesc As String, ByRef OwnerID As String, ByRef SearchQuery As String, ByRef SendToEmail As String, ByRef ScheduleUnit As String, ByRef ScheduleHour As String, ByRef ScheduleDaysOfWeek As String, ByRef ScheduleDaysOfMonth As String, ByRef ScheduleMonthOfQtr As String, ByRef StartToRunDate As Date, ByRef EndRunDate As Date, ByRef SearchParameters As String, ByRef LastRunDate As Date, ByRef NumberOfExecutions As Integer, ByRef CreateDate As Date, ByRef LastModDate As Date, ByRef ScheduleHourInterval As Integer, ByRef RepoName As String, ByRef RC As Boolean, ByRef RetMsg As String) As Boolean Implements IService1.saveSearchSchedule
        Return DB.saveSearchSchedule(SecureID, SearchName, NotificationSMS, SearchDesc, OwnerID, SearchQuery, SendToEmail, ScheduleUnit, ScheduleHour, ScheduleDaysOfWeek, ScheduleDaysOfMonth, ScheduleMonthOfQtr, StartToRunDate, EndRunDate, SearchParameters, LastRunDate, NumberOfExecutions, CreateDate, LastModDate, ScheduleHourInterval, RepoName, RC, RetMsg)
    End Function

    ''' <summary>
    ''' Gets the search schedule.
    ''' </summary>
    ''' <param name="SecureID">            The secure identifier.</param>
    ''' <param name="SearchName">          Name of the search.</param>
    ''' <param name="NotificationSMS">     The notification SMS.</param>
    ''' <param name="SearchDesc">          The search desc.</param>
    ''' <param name="OwnerID">             The owner identifier.</param>
    ''' <param name="SearchQuery">         The search query.</param>
    ''' <param name="SendToEmail">         The send to email.</param>
    ''' <param name="ScheduleUnit">        The schedule unit.</param>
    ''' <param name="ScheduleHour">        The schedule hour.</param>
    ''' <param name="ScheduleDaysOfWeek">  The schedule days of week.</param>
    ''' <param name="ScheduleDaysOfMonth"> The schedule days of month.</param>
    ''' <param name="ScheduleMonthOfQtr">  The schedule month of QTR.</param>
    ''' <param name="StartToRunDate">      The start to run date.</param>
    ''' <param name="EndRunDate">          The end run date.</param>
    ''' <param name="SearchParameters">    The search parameters.</param>
    ''' <param name="LastRunDate">         The last run date.</param>
    ''' <param name="NumberOfExecutions">  The number of executions.</param>
    ''' <param name="CreateDate">          The create date.</param>
    ''' <param name="LastModDate">         The last mod date.</param>
    ''' <param name="ScheduleHourInterval">The schedule hour interval.</param>
    ''' <param name="RepoName">            Name of the repo.</param>
    ''' <param name="RC">                  if set to <c>true</c> [rc].</param>
    ''' <param name="RetMsg">              The ret MSG.</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    Public Function getSearchSchedule(ByVal SecureID As Integer, ByRef SearchName As String, ByRef NotificationSMS As String, ByRef SearchDesc As String, ByRef OwnerID As String, ByRef SearchQuery As String, ByRef SendToEmail As String, ByRef ScheduleUnit As String, ByRef ScheduleHour As String, ByRef ScheduleDaysOfWeek As String, ByRef ScheduleDaysOfMonth As String, ByRef ScheduleMonthOfQtr As String, ByRef StartToRunDate As Date, ByRef EndRunDate As Date, ByRef SearchParameters As String, ByRef LastRunDate As Date, ByRef NumberOfExecutions As Integer, ByRef CreateDate As Date, ByRef LastModDate As Date, ByRef ScheduleHourInterval As Integer, ByRef RepoName As String, ByRef RC As Boolean, ByRef RetMsg As String) As Boolean Implements IService1.getSearchSchedule
        Return DB.getSearchSchedule(SecureID, SearchName, NotificationSMS, SearchDesc, OwnerID, SearchQuery, SendToEmail, ScheduleUnit, ScheduleHour, ScheduleDaysOfWeek, ScheduleDaysOfMonth, ScheduleMonthOfQtr, StartToRunDate, EndRunDate, SearchParameters, LastRunDate, NumberOfExecutions, CreateDate, LastModDate, ScheduleHourInterval, RepoName, RC, RetMsg)
    End Function

    ''' <summary>
    ''' Inserts the co owner.
    ''' </summary>
    ''' <param name="SecureID">    The secure identifier.</param>
    ''' <param name="CurrentOwner">The current owner.</param>
    ''' <param name="CoOwner">     The co owner.</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    Public Function InsertCoOwner(ByVal SecureID As Integer, ByVal CurrentOwner As String, ByVal CoOwner As String) As Boolean Implements IService1.InsertCoOwner
        Return DB.InsertCoOwner(SecureID, CurrentOwner, CoOwner)
    End Function

    ''' <summary>
    ''' Populates the co owner grid.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="UID">     The uid.</param>
    ''' <returns>System.String.</returns>
    Public Function PopulateCoOwnerGrid(ByVal SecureID As Integer, ByVal UID As String) As String Implements IService1.PopulateCoOwnerGrid
        Return DB.PopulateCoOwnerGrid(SecureID, UID)
    End Function

    ''' <summary>
    ''' Populates the user grid.
    ''' </summary>
    ''' <param name="SecureID"> The secure identifier.</param>
    ''' <param name="UserID">   The user identifier.</param>
    ''' <param name="DBisAdmin">if set to <c>true</c> [d bis admin].</param>
    ''' <returns>System.Collections.Generic.List(Of DS_VUserGrid).</returns>
    Public Function PopulateUserGrid(ByRef SecureID As Integer, ByVal UserID As String, ByVal DBisAdmin As Boolean) As System.Collections.Generic.List(Of DS_VUserGrid) Implements IService1.PopulateUserGrid
        Return DB.PopulateUserGrid(SecureID, UserID, DBisAdmin)
    End Function

    ''' <summary>
    ''' Gets the group users.
    ''' </summary>
    ''' <param name="SecureID"> The secure identifier.</param>
    ''' <param name="GroupName">Name of the group.</param>
    ''' <param name="GroupList">The group list.</param>
    ''' <param name="RC">       if set to <c>true</c> [rc].</param>
    ''' <param name="RetMsg">   The ret MSG.</param>
    Public Sub getGroupUsers(ByRef SecureID As Integer, ByVal GroupName As String, ByRef GroupList As ArrayList, ByRef RC As Boolean, ByRef RetMsg As String) Implements IService1.getGroupUsers
        DB.getGroupUsers(SecureID, GroupName, GroupList, RC, RetMsg)
    End Sub

    ''' <summary>
    ''' Populates the dg group users.
    ''' </summary>
    ''' <param name="SecureID">       The secure identifier.</param>
    ''' <param name="OwnerUserGuidID">The owner user unique identifier identifier.</param>
    ''' <param name="GroupName">      Name of the group.</param>
    ''' <returns>System.String.</returns>
    Public Function PopulateDgGroupUsers(ByRef SecureID As Integer, ByVal OwnerUserGuidID As String, ByVal GroupName As String) As String Implements IService1.PopulateDgGroupUsers
        Dim ListOfItems As New List(Of DS_DgGroupUsers)
        ListOfItems = DB.PopulateDgGroupUsers(SecureID, OwnerUserGuidID, GroupName)
        Return Newtonsoft.Json.JsonConvert.SerializeObject(ListOfItems)
    End Function

    ''' <summary>
    ''' Deletes the group users.
    ''' </summary>
    ''' <param name="SecureID">             The secure identifier.</param>
    ''' <param name="CurrSelectedGroupName">Name of the curr selected group.</param>
    ''' <param name="GroupOwnerGuid">       The group owner unique identifier.</param>
    ''' <param name="UserID">               The user identifier.</param>
    ''' <param name="iDeleted">             The i deleted.</param>
    ''' <param name="RetMsg">               The ret MSG.</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    Public Function DeleteGroupUsers(SecureID As Integer, ByVal CurrSelectedGroupName As String,
                              ByVal GroupOwnerGuid As String,
                              ByVal UserID As String, ByRef iDeleted As Integer, ByRef RetMsg As String) As Boolean Implements IService1.DeleteGroupUsers
        Return DB.DeleteGroupUsers(SecureID, CurrSelectedGroupName, GroupOwnerGuid, UserID, iDeleted, RetMsg)
    End Function

    ''' <summary>
    ''' Gets the name of the group owner unique identifier by group.
    ''' </summary>
    ''' <param name="SecureID"> The secure identifier.</param>
    ''' <param name="GroupName">Name of the group.</param>
    ''' <returns>System.String.</returns>
    Public Function getGroupOwnerGuidByGroupName(ByRef SecureID As Integer, ByVal GroupName As String) As String Implements IService1.getGroupOwnerGuidByGroupName
        Return DB.getGroupOwnerGuidByGroupName(SecureID, GroupName)
    End Function

    ''' <summary>
    ''' Adds the library group user.
    ''' </summary>
    ''' <param name="SecureID">      The secure identifier.</param>
    ''' <param name="GroupName">     Name of the group.</param>
    ''' <param name="RC">            if set to <c>true</c> [rc].</param>
    ''' <param name="CurrUserID">    The curr user identifier.</param>
    ''' <param name="SessionID">     The session identifier.</param>
    ''' <param name="ControlSection">The control section.</param>
    Public Sub AddLibraryGroupUser(ByRef SecureID As Integer, ByVal GroupName As String, ByRef RC As Boolean, CurrUserID As String, SessionID As String, ControlSection As String) Implements IService1.AddLibraryGroupUser
        DB.AddLibraryGroupUser(SecureID, GroupName, RC, CurrUserID, SessionID, ControlSection)
    End Sub

    ''' <summary>
    ''' Populates the group user grid.
    ''' </summary>
    ''' <param name="SecureID"> The secure identifier.</param>
    ''' <param name="GroupName">Name of the group.</param>
    ''' <returns>System.String.</returns>
    Public Function PopulateGroupUserGrid(ByRef SecureID As Integer, ByVal GroupName As String) As String Implements IService1.PopulateGroupUserGrid
        Dim ListOfItems As New List(Of DS_dgGrpUsers)
        ListOfItems = DB.PopulateGroupUserGrid(SecureID, GroupName)
        Return Newtonsoft.Json.JsonConvert.SerializeObject(ListOfItems)
    End Function

    ''' <summary>
    ''' Populates the library items grid.
    ''' </summary>
    ''' <param name="SecureID">   The secure identifier.</param>
    ''' <param name="LibraryName">Name of the library.</param>
    ''' <param name="UserID">     The user identifier.</param>
    ''' <returns>System.String.</returns>
    Public Function PopulateLibItemsGrid(ByRef SecureID As Integer, ByVal LibraryName As String, ByVal UserID As String) As String Implements IService1.PopulateLibItemsGrid
        Dim ListOfItems As New List(Of DS_LibItems)
        ListOfItems = DB.PopulateLibItemsGrid(SecureID, LibraryName, UserID)
        Return Newtonsoft.Json.JsonConvert.SerializeObject(ListOfItems)
    End Function

    ''' <summary>
    ''' Populates the dg assigned.
    ''' </summary>
    ''' <param name="SecureID">   The secure identifier.</param>
    ''' <param name="LibraryName">Name of the library.</param>
    ''' <param name="UserID">     The user identifier.</param>
    ''' <returns>System.String.</returns>
    Public Function PopulateDgAssigned(ByRef SecureID As Integer, ByVal LibraryName As String, ByVal UserID As String) As String Implements IService1.PopulateDgAssigned
        Dim ListOfItems As New List(Of DS_DgAssigned)
        ListOfItems = DB.PopulateDgAssigned(SecureID, LibraryName, UserID)
        Return Newtonsoft.Json.JsonConvert.SerializeObject(ListOfItems)
    End Function

    ''' <summary>
    ''' Resets the library users count.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="RC">      if set to <c>true</c> [rc].</param>
    Public Sub ResetLibraryUsersCount(ByRef SecureID As Integer, ByRef RC As Boolean) Implements IService1.ResetLibraryUsersCount
        DB.ResetLibraryUsersCount(SecureID, RC)
    End Sub

    ''' <summary>
    ''' Deletes the library group user.
    ''' </summary>
    ''' <param name="SecureID">   The secure identifier.</param>
    ''' <param name="GroupName">  Name of the group.</param>
    ''' <param name="LibraryName">Name of the library.</param>
    ''' <param name="RC">         if set to <c>true</c> [rc].</param>
    Public Sub DeleteLibraryGroupUser(ByRef SecureID As Integer, ByVal GroupName As String, ByVal LibraryName As String, ByRef RC As Boolean) Implements IService1.DeleteLibraryGroupUser
        DB.DeleteLibraryGroupUser(SecureID, GroupName, LibraryName, RC)
    End Sub

    ''' <summary>
    ''' Changes the user password.
    ''' </summary>
    ''' <param name="SecureID"> The secure identifier.</param>
    ''' <param name="UserLogin">The user login.</param>
    ''' <param name="OldPW">    The old pw.</param>
    ''' <param name="NewPw1">   Creates new pw1.</param>
    ''' <param name="NewPw2">   Creates new pw2.</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    Public Function ChangeUserPassword(ByRef SecureID As Integer, ByVal UserLogin As String, ByVal OldPW As String, ByVal NewPw1 As String, ByVal NewPw2 As String) As Boolean Implements IService1.ChangeUserPassword
        Return DB.ChangeUserPassword(SecureID, UserLogin, OldPW, NewPw1, NewPw2)
    End Function

    ''' <summary>
    ''' Saves the click stats.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="IID">     The iid.</param>
    ''' <param name="UserID">  The user identifier.</param>
    ''' <param name="RC">      if set to <c>true</c> [rc].</param>
    Public Sub SaveClickStats(SecureID As Integer, ByVal IID As Integer, ByVal UserID As String, ByRef RC As Boolean) Implements IService1.SaveClickStats
        DB.SaveClickStats(SecureID, IID, UserID, RC)
    End Sub

    ''' <summary>
    ''' Cleans up library items.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="UserID">  The user identifier.</param>
    Public Sub cleanUpLibraryItems(ByRef SecureID As Integer, ByVal UserID As String) Implements IService1.cleanUpLibraryItems
        DB.cleanUpLibraryItems(SecureID, UserID)
    End Sub

    ''' <summary>
    ''' Removes the library directories.
    ''' </summary>
    ''' <param name="SecureID">     The secure identifier.</param>
    ''' <param name="UserID">       The user identifier.</param>
    ''' <param name="DirectoryName">Name of the directory.</param>
    ''' <param name="LibraryName">  Name of the library.</param>
    ''' <param name="RC">           if set to <c>true</c> [rc].</param>
    ''' <param name="RetMsg">       The ret MSG.</param>
    Public Sub RemoveLibraryDirectories(ByRef SecureID As Integer, ByVal UserID As String, ByVal DirectoryName As String, ByVal LibraryName As String, ByRef RC As Boolean, ByRef RetMsg As String) Implements IService1.RemoveLibraryDirectories
        DB.RemoveLibraryDirectories(SecureID, UserID, DirectoryName, LibraryName, RC, RetMsg)
    End Sub

    ''' <summary>
    ''' Removes the library emails.
    ''' </summary>
    ''' <param name="SecureID">   The secure identifier.</param>
    ''' <param name="FolderName"> Name of the folder.</param>
    ''' <param name="LibraryName">Name of the library.</param>
    ''' <param name="UserID">     The user identifier.</param>
    ''' <param name="RC">         if set to <c>true</c> [rc].</param>
    ''' <param name="RetMsg">     The ret MSG.</param>
    Public Sub RemoveLibraryEmails(ByRef SecureID As Integer, ByVal FolderName As String, ByVal LibraryName As String, ByVal UserID As String, ByRef RC As Boolean, ByRef RetMsg As String) Implements IService1.RemoveLibraryEmails
        DB.RemoveLibraryEmails(SecureID, FolderName, LibraryName, UserID, RC, RetMsg)
    End Sub

    ''' <summary>
    ''' Adds the system MSG.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="UserID">  The user identifier.</param>
    ''' <param name="tMsg">    The t MSG.</param>
    ''' <param name="RC">      if set to <c>true</c> [rc].</param>
    Public Sub AddSysMsg(ByRef SecureID As Integer, ByVal UserID As String, ByVal tMsg As String, ByVal RC As Boolean) Implements IService1.AddSysMsg
        DB.AddSysMsg(SecureID, UserID, tMsg, RC)
    End Sub

    ''' <summary>
    ''' Adds the library directory.
    ''' </summary>
    ''' <param name="SecureID">    The secure identifier.</param>
    ''' <param name="FolderName">  Name of the folder.</param>
    ''' <param name="LibraryName"> Name of the library.</param>
    ''' <param name="UserID">      The user identifier.</param>
    ''' <param name="RecordsAdded">The records added.</param>
    ''' <param name="RC">          if set to <c>true</c> [rc].</param>
    ''' <param name="RetMsg">      The ret MSG.</param>
    Public Sub AddLibraryDirectory(ByRef SecureID As Integer, ByVal FolderName As String, ByVal LibraryName As String, ByVal UserID As String, ByRef RecordsAdded As Integer, ByRef RC As Boolean, ByRef RetMsg As String) Implements IService1.AddLibraryDirectory
        DB.AddLibraryDirectory(SecureID, FolderName, LibraryName, UserID, RecordsAdded, RC, RetMsg)
    End Sub

    ''' <summary>
    ''' Adds the library email.
    ''' </summary>
    ''' <param name="SecureID">    The secure identifier.</param>
    ''' <param name="EmailFolder"> The email folder.</param>
    ''' <param name="LibraryName"> Name of the library.</param>
    ''' <param name="UserID">      The user identifier.</param>
    ''' <param name="RecordsAdded">The records added.</param>
    ''' <param name="RC">          if set to <c>true</c> [rc].</param>
    ''' <param name="RetMsg">      The ret MSG.</param>
    Public Sub AddLibraryEmail(ByRef SecureID As Integer, ByVal EmailFolder As String, ByVal LibraryName As String, ByVal UserID As String, ByRef RecordsAdded As Integer, ByVal RC As Boolean, ByVal RetMsg As String) Implements IService1.AddLibraryEmail
        DB.AddLibraryEmail(SecureID, EmailFolder, LibraryName, UserID, RecordsAdded, RC, RetMsg)
    End Sub

    ''' <summary>
    ''' Populates the library grid.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="UserID">  The user identifier.</param>
    ''' <returns>System.String.</returns>
    Public Function PopulateLibraryGrid(ByRef SecureID As Integer, ByVal UserID As String) As String Implements IService1.PopulateLibraryGrid
        Dim ListOfItems As New List(Of DS_VLibraryStats)
        ListOfItems = DB.PopulateLibraryGrid(SecureID, UserID)
        Return Newtonsoft.Json.JsonConvert.SerializeObject(ListOfItems)
    End Function

    ''' <summary>
    ''' Gets the list of strings.
    ''' </summary>
    ''' <param name="SecureID">      The secure identifier.</param>
    ''' <param name="strListOfItems">The string list of items.</param>
    ''' <param name="MySql">         My SQL.</param>
    ''' <param name="RC">            if set to <c>true</c> [rc].</param>
    ''' <param name="RetMsg">        The ret MSG.</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    Public Function getListOfStrings(ByRef SecureID As Integer, ByRef strListOfItems As String, ByVal MySql As String, ByRef RC As Boolean, ByRef RetMsg As String) As Boolean Implements IService1.getListOfStrings
        'MySql = ENC.AES256DecryptString(MySql)
        Return DB.getListOfStrings(SecureID, strListOfItems, MySql, RC, RetMsg)
    End Function

    ''' <summary>
    ''' Gets the list of strings1.
    ''' </summary>
    ''' <param name="SecureID">      The secure identifier.</param>
    ''' <param name="strListOfItems">The string list of items.</param>
    ''' <param name="MySql">         My SQL.</param>
    ''' <param name="RC">            if set to <c>true</c> [rc].</param>
    ''' <param name="RetMsg">        The ret MSG.</param>
    ''' <param name="UserID">        The user identifier.</param>
    ''' <param name="SessionID">     The session identifier.</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    Public Function getListOfStrings1(ByRef SecureID As Integer, ByRef strListOfItems As String, ByVal MySql As String, ByRef RC As Boolean, ByRef RetMsg As String, UserID As String, SessionID As String) As Boolean Implements IService1.getListOfStrings1
        'MySql = ENC.AES256DecryptString(MySql)
        Return DB.getListOfStrings1(SecureID, strListOfItems, MySql, RC, RetMsg)
    End Function

    ''' <summary>
    ''' Gets the list of strings2.
    ''' </summary>
    ''' <param name="SecureID">      The secure identifier.</param>
    ''' <param name="strListOfItems">The string list of items.</param>
    ''' <param name="MySql">         My SQL.</param>
    ''' <param name="RC">            if set to <c>true</c> [rc].</param>
    ''' <param name="RetMsg">        The ret MSG.</param>
    ''' <param name="UserID">        The user identifier.</param>
    ''' <param name="SessionID">     The session identifier.</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    Public Function getListOfStrings2(ByRef SecureID As Integer, ByRef strListOfItems As String, ByVal MySql As String, ByRef RC As Boolean, ByRef RetMsg As String, UserID As String, SessionID As String) As Boolean Implements IService1.getListOfStrings2
        MySql = ENC.AES256DecryptString(MySql)
        Return DB.getListOfStrings2(SecureID, strListOfItems, MySql, RC, RetMsg)
    End Function

    ''' <summary>
    ''' Gets the list of strings3.
    ''' </summary>
    ''' <param name="SecureID">      The secure identifier.</param>
    ''' <param name="strListOfItems">The string list of items.</param>
    ''' <param name="MySql">         My SQL.</param>
    ''' <param name="RC">            if set to <c>true</c> [rc].</param>
    ''' <param name="RetMsg">        The ret MSG.</param>
    ''' <param name="UserID">        The user identifier.</param>
    ''' <param name="SessionID">     The session identifier.</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    Public Function getListOfStrings3(ByRef SecureID As Integer, ByRef strListOfItems As String, ByVal MySql As String, ByRef RC As Boolean, ByRef RetMsg As String, UserID As String, SessionID As String) As Boolean Implements IService1.getListOfStrings3
        MySql = ENC.AES256DecryptString(MySql)
        Return DB.getListOfStrings3(SecureID, strListOfItems, MySql, RC, RetMsg)
    End Function

    ''' <summary>
    ''' Gets the list of strings4.
    ''' </summary>
    ''' <param name="SecureID">      The secure identifier.</param>
    ''' <param name="strListOfItems">The string list of items.</param>
    ''' <param name="MySql">         My SQL.</param>
    ''' <param name="RC">            if set to <c>true</c> [rc].</param>
    ''' <param name="RetMsg">        The ret MSG.</param>
    ''' <param name="UserID">        The user identifier.</param>
    ''' <param name="SessionID">     The session identifier.</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    Public Function getListOfStrings4(ByRef SecureID As Integer, strListOfItems As String, ByVal MySql As String, ByRef RC As Boolean, ByRef RetMsg As String, UserID As String, SessionID As String) As Boolean Implements IService1.getListOfStrings4
        MySql = ENC.AES256DecryptString(MySql)
        Return DB.getListOfStrings4(SecureID, strListOfItems, MySql, RC, RetMsg)
    End Function

    ''' <summary>
    ''' is the count.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="S">       The s.</param>
    ''' <returns>System.Int32.</returns>
    Public Function iCount(ByRef SecureID As Integer, ByVal S As String) As Integer Implements IService1.iCount
        Return DB.iCount(SecureID, S)
    End Function

    ''' <summary>
    ''' Gets the log path.
    ''' </summary>
    ''' <param name="tPath">The t path.</param>
    Public Sub GetLogPath(ByRef tPath As String) Implements IService1.GetLogPath
        tPath = Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData)
    End Sub

    ''' <summary>
    ''' Actives the session get value.
    ''' </summary>
    ''' <param name="SecureID">   The secure identifier.</param>
    ''' <param name="SessionGuid">The session unique identifier.</param>
    ''' <param name="ParmName">   Name of the parm.</param>
    ''' <returns>System.String.</returns>
    Public Function ActiveSessionGetVal(ByRef SecureID As Integer, ByRef SessionGuid As Guid, ByRef ParmName As String) As String Implements IService1.ActiveSessionGetVal
        Dim ParmVal As String = DB.ActiveSessionGetVal(SecureID, SessionGuid, ParmName)
        Return ParmVal
    End Function

    ''' <summary>
    ''' Actives the session.
    ''' </summary>
    ''' <param name="SecureID">   The secure identifier.</param>
    ''' <param name="SessionGuid">The session unique identifier.</param>
    ''' <param name="ParmName">   Name of the parm.</param>
    ''' <param name="ParmValue">  The parm value.</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    Public Function ActiveSession(ByRef SecureID As Integer, ByVal SessionGuid As Guid, ByVal ParmName As String, ByVal ParmValue As String) As Boolean Implements IService1.ActiveSession
        Dim B As Boolean = DB.ActiveSession(SecureID, SessionGuid, ParmName, ParmValue)
        Return B
    End Function

    ''' <summary>
    ''' Sets the secure login parms.
    ''' </summary>
    ''' <param name="SecureID">  The secure identifier.</param>
    ''' <param name="sCompanyID">The s company identifier.</param>
    ''' <param name="sRepoID">   The s repo identifier.</param>
    ''' <param name="RC">        if set to <c>true</c> [rc].</param>
    Public Sub setSecureLoginParms(ByRef SecureID As Integer, ByVal sCompanyID As String, ByVal sRepoID As String, ByRef RC As Boolean) Implements IService1.setSecureLoginParms
        DB.setSecureLoginParms(SecureID, sCompanyID, sRepoID, RC)
    End Sub

    ''' <summary>
    ''' Gets the session enc cs.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <returns>System.Object.</returns>
    Public Function getSessionEncCs(ByRef SecureID As Integer) As Object Implements IService1.getSessionEncCs
        Return System.Web.HttpContext.Current.Session.SessionID
        'Return HttpContext.Current.Session("EncryptedCS")
    End Function

    ''' <summary>
    ''' Sets the session enc cs.
    ''' </summary>
    ''' <param name="SecureID">   The secure identifier.</param>
    ''' <param name="MySessionID">My session identifier.</param>
    Public Sub setSessionEncCs(ByRef SecureID As Integer, ByVal MySessionID As String) Implements IService1.setSessionEncCs
        HttpContext.Current.Session("EncryptedCS") = MySessionID
    End Sub

    ''' <summary>
    ''' Gets the HTTP session identifier.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <returns>System.Object.</returns>
    Public Function getHttpSessionID(ByRef SecureID As Integer) As Object Implements IService1.getHttpSessionID
        Return System.Web.HttpContext.Current.Session.SessionID
        'Return HttpContext.Current.Session("MySessionObject")
    End Function

    ''' <summary>
    ''' Sets the session identifier.
    ''' </summary>
    ''' <param name="SecureID">   The secure identifier.</param>
    ''' <param name="MySessionID">My session identifier.</param>
    Public Sub setSessionID(ByRef SecureID As Integer, ByVal MySessionID As String) Implements IService1.setSessionID
        HttpContext.Current.Session("MySessionObject") = MySessionID
    End Sub

    ''' <summary>
    ''' Gets the login unique identifier.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <returns>System.Object.</returns>
    Public Function getLoginGuid(ByRef SecureID As Integer) As Object Implements IService1.getLoginGuid
        Return HttpContext.Current.Session("MyLoginGuid")
    End Function

    ''' <summary>
    ''' Sets the login unique identifier.
    ''' </summary>
    ''' <param name="SecureID">   The secure identifier.</param>
    ''' <param name="MyLoginGuid">My login unique identifier.</param>
    Public Sub setLoginGuid(ByRef SecureID As Integer, ByVal MyLoginGuid As String) Implements IService1.setLoginGuid
        HttpContext.Current.Session("MyLoginGuid") = MyLoginGuid
    End Sub

    ''' <summary>
    ''' Gets the session company identifier.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <returns>System.Object.</returns>
    Public Function getSessionCompanyID(ByRef SecureID As Integer) As Object Implements IService1.getSessionCompanyID
        Return HttpContext.Current.Session("CompanyID")
    End Function

    ''' <summary>
    ''' Sets the session company identifier.
    ''' </summary>
    ''' <param name="SecureID"> The secure identifier.</param>
    ''' <param name="CompanyID">The company identifier.</param>
    ''' <param name="RC">       if set to <c>true</c> [rc].</param>
    Public Sub setSessionCompanyID(ByRef SecureID As Integer, ByVal CompanyID As String, ByRef RC As Boolean) Implements IService1.setSessionCompanyID
        HttpContext.Current.Session("CompanyID") = CompanyID
    End Sub

    ''' <summary>
    ''' Gets the session repo identifier.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <returns>System.Object.</returns>
    Public Function getSessionRepoID(ByRef SecureID As Integer) As Object Implements IService1.getSessionRepoID
        Return HttpContext.Current.Session("RepoID")
    End Function

    ''' <summary>
    ''' Sets the session repo identifier.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="RepoID">  The repo identifier.</param>
    Public Sub setSessionRepoID(ByRef SecureID As Integer, ByVal RepoID As String) Implements IService1.setSessionRepoID
        HttpContext.Current.Session("RepoID") = RepoID
    End Sub

    ''' <summary>
    ''' Gets the login pw.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <returns>System.Object.</returns>
    Public Function getLoginPW(ByRef SecureID As Integer) As Object Implements IService1.getLoginPW
        Return HttpContext.Current.Session("EncPW")
    End Function

    ''' <summary>
    ''' Sets the login pw.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="RepoID">  The repo identifier.</param>
    Public Sub setLoginPW(ByRef SecureID As Integer, ByVal RepoID As String) Implements IService1.setLoginPW
        HttpContext.Current.Session("EncPW") = RepoID
    End Sub

    ''' <summary>
    ''' Expands the inflection terms.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="S">       The s.</param>
    ''' <returns>System.String.</returns>
    Public Function ExpandInflectionTerms(ByRef SecureID As Integer, ByVal S As String) As String Implements IService1.ExpandInflectionTerms
        Dim tStr As String = DB.ExpandInflectionTerms(SecureID, S)
        Return tStr
    End Function

    ''' <summary>
    ''' Gets the name of the server database.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <returns>System.String.</returns>
    Public Function getServerDatabaseName(ByRef SecureID As Integer) As String Implements IService1.getServerDatabaseName
        Dim S As String = ""
        S = DB.getServerDbName(SecureID)
        Return S
    End Function

    ''' <summary>
    ''' Cleans the log.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    Public Sub CleanLog(ByRef SecureID As Integer) Implements IService1.CleanLog
        DB.CleanLog(SecureID)
    End Sub

    ''' <summary>
    ''' Populates the ComboBox.
    ''' </summary>
    ''' <param name="SecureID">  The secure identifier.</param>
    ''' <param name="CB">        The cb.</param>
    ''' <param name="TblColName">Name of the table col.</param>
    ''' <param name="S">         The s.</param>
    Sub PopulateComboBox(ByRef SecureID As Integer, ByRef CB As String(), ByVal TblColName As String, ByVal S As String) Implements IService1.PopulateComboBox
        DB.PopulateComboBox(SecureID, CB, TblColName, S)
    End Sub

    ''' <summary>
    ''' Populates the secure login cb.
    ''' </summary>
    ''' <param name="SecureID"> The secure identifier.</param>
    ''' <param name="CB">       The cb.</param>
    ''' <param name="CompanyID">The company identifier.</param>
    ''' <param name="RC">       if set to <c>true</c> [rc].</param>
    ''' <param name="RetMsg">   The ret MSG.</param>
    Public Sub PopulateSecureLoginCB(ByRef SecureID As Integer, ByRef CB As String, ByVal CompanyID As String, ByRef RC As Boolean, ByRef RetMsg As String) Implements IService1.PopulateSecureLoginCB

        DB.PopulateSecureLoginCB(SecureID, CB, CompanyID, RC, RetMsg)

    End Sub

    ''' <summary>
    ''' Gets the email attachments.
    ''' </summary>
    ''' <param name="SecureID">     The secure identifier.</param>
    ''' <param name="CurrEmailGuid">The curr email unique identifier.</param>
    ''' <returns>System.String.</returns>
    Public Function GetEmailAttachments(ByRef SecureID As Integer, ByVal CurrEmailGuid As String) As String Implements IService1.GetEmailAttachments
        Return DB.GetEmailAttachments(SecureID, CurrEmailGuid)
    End Function

    ''' <summary>
    ''' Databases the write to file.
    ''' </summary>
    ''' <param name="SecureID">  The secure identifier.</param>
    ''' <param name="UID">       The uid.</param>
    ''' <param name="SourceGuid">The source unique identifier.</param>
    ''' <param name="FileName">  Name of the file.</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    Public Function DbWriteToFile(ByRef SecureID As Integer, ByVal UID As String, ByVal SourceGuid As String, ByRef FileName As String) As Boolean Implements IService1.DbWriteToFile
        Dim B As Boolean = False
        B = DB.DbWriteToFile(SecureID, UID, SourceGuid, FileName)
        Return B
    End Function

    ''' <summary>
    ''' Sets the session variable.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="key">     The key.</param>
    ''' <param name="KeyValue">The key value.</param>
    Public Sub SetSessionVariable(ByRef SecureID As Integer, ByVal key As String, ByVal KeyValue As String) Implements IService1.SetSessionVariable
        System.Web.HttpContext.Current.Session(key) = KeyValue
    End Sub

    ''' <summary>
    ''' Gets the session variable.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="key">     The key.</param>
    ''' <returns>System.Object.</returns>
    Public Function GetSessionVariable(ByRef SecureID As Integer, ByVal key As String) As Object Implements IService1.GetSessionVariable
        Return System.Web.HttpContext.Current.Session(key)
    End Function

    ''' <summary>
    ''' Updates the source image compressed.
    ''' </summary>
    ''' <param name="SecureID">            The secure identifier.</param>
    ''' <param name="UploadFQN">           The upload FQN.</param>
    ''' <param name="SourceGuid">          The source unique identifier.</param>
    ''' <param name="LastAccessDate">      The last access date.</param>
    ''' <param name="CreateDate">          The create date.</param>
    ''' <param name="LastWriteTime">       The last write time.</param>
    ''' <param name="VersionNbr">          The version NBR.</param>
    ''' <param name="CompressedDataBuffer">The compressed data buffer.</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
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

    ''' <summary>
    ''' Writes the image source data from database write to file.
    ''' </summary>
    ''' <param name="SecureID">            The secure identifier.</param>
    ''' <param name="SourceGuid">          The source unique identifier.</param>
    ''' <param name="FQN">                 The FQN.</param>
    ''' <param name="CompressedDataBuffer">The compressed data buffer.</param>
    ''' <param name="OriginalSize">        Size of the original.</param>
    ''' <param name="CompressedSize">      Size of the compressed.</param>
    ''' <param name="RC">                  if set to <c>true</c> [rc].</param>
    Public Sub writeImageSourceDataFromDbWriteToFile(ByRef SecureID As Integer, ByVal SourceGuid As String, ByRef FQN As String, ByRef CompressedDataBuffer() As Byte, ByRef OriginalSize As Integer, ByRef CompressedSize As Integer, ByRef RC As Boolean) Implements IService1.writeImageSourceDataFromDbWriteToFile
        DB.writeImageSourceDataFromDbWriteToFile(SecureID, SourceGuid, FQN, CompressedDataBuffer, OriginalSize, CompressedSize, RC)
    End Sub

    ''' <summary>
    ''' Writes the attachment from database write to file.
    ''' </summary>
    ''' <param name="SecureID">            The secure identifier.</param>
    ''' <param name="RowID">               The row identifier.</param>
    ''' <param name="FQN">                 The FQN.</param>
    ''' <param name="CompressedDataBuffer">The compressed data buffer.</param>
    ''' <param name="OriginalSize">        Size of the original.</param>
    ''' <param name="CompressedSize">      Size of the compressed.</param>
    ''' <param name="RC">                  if set to <c>true</c> [rc].</param>
    Public Sub writeAttachmentFromDbWriteToFile(ByRef SecureID As Integer, ByVal RowID As String, ByRef FQN As String, ByRef CompressedDataBuffer() As Byte, ByRef OriginalSize As Integer, ByRef CompressedSize As Integer, ByRef RC As Boolean) Implements IService1.writeAttachmentFromDbWriteToFile
        DB.writeAttachmentFromDbWriteToFile(SecureID, RowID, FQN, CompressedDataBuffer, OriginalSize, CompressedSize, RC)
    End Sub

    ''' <summary>
    ''' Writes the email from database to file.
    ''' </summary>
    ''' <param name="SecureID">            The secure identifier.</param>
    ''' <param name="EmailGuid">           The email unique identifier.</param>
    ''' <param name="SourceTypeCode">      The source type code.</param>
    ''' <param name="CompressedDataBuffer">The compressed data buffer.</param>
    ''' <param name="OriginalSize">        Size of the original.</param>
    ''' <param name="CompressedSize">      Size of the compressed.</param>
    ''' <param name="RC">                  if set to <c>true</c> [rc].</param>
    Public Sub writeEmailFromDbToFile(ByRef SecureID As Integer, ByVal EmailGuid As String, ByRef SourceTypeCode As String, ByRef CompressedDataBuffer() As Byte, ByRef OriginalSize As Integer, ByRef CompressedSize As Integer, ByRef RC As Boolean) Implements IService1.writeEmailFromDbToFile
        DB.writeEmailFromDbToFile(SecureID, EmailGuid, SourceTypeCode, CompressedDataBuffer, OriginalSize, CompressedSize, RC)
    End Sub

    ''' <summary>
    ''' Adds the library items.
    ''' </summary>
    ''' <param name="SecureID">             The secure identifier.</param>
    ''' <param name="SourceGuid">           The source unique identifier.</param>
    ''' <param name="ItemTitle">            The item title.</param>
    ''' <param name="ItemType">             Type of the item.</param>
    ''' <param name="LibraryItemGuid">      The library item unique identifier.</param>
    ''' <param name="DataSourceOwnerUserID">The data source owner user identifier.</param>
    ''' <param name="LibraryOwnerUserID">   The library owner user identifier.</param>
    ''' <param name="LibraryName">          Name of the library.</param>
    ''' <param name="AddedByUserGuidId">    The added by user unique identifier identifier.</param>
    ''' <param name="RC">                   if set to <c>true</c> [rc].</param>
    ''' <param name="rMsg">                 The r MSG.</param>
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

    ''' <summary>
    ''' Populates the group user library combo.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="UID">     The uid.</param>
    ''' <param name="cb">      The cb.</param>
    Public Sub PopulateGroupUserLibCombo(ByRef SecureID As Integer, ByVal UID As String, ByRef cb As String) Implements IService1.PopulateGroupUserLibCombo
        DB.PopulateGroupUserLibCombo(SecureID, UID, cb)
    End Sub

    ''' <summary>
    ''' Gets the name of the library owner by.
    ''' </summary>
    ''' <param name="SecureID">   The secure identifier.</param>
    ''' <param name="LibraryName">Name of the library.</param>
    ''' <returns>System.String.</returns>
    Public Function GetLibOwnerByName(ByRef SecureID As Integer, ByVal LibraryName As String) As String Implements IService1.GetLibOwnerByName
        Dim S As String = ""
        S = DB.GetLibOwnerByName(SecureID, LibraryName)
        Return S
    End Function

    ''' <summary>
    ''' Generates the SQL.
    ''' </summary>
    ''' <param name="SearchParmList">The search parm list.</param>
    ''' <param name="SecureID">      The secure identifier.</param>
    ''' <param name="TypeSQL">       The type SQL.</param>
    ''' <returns>System.String.</returns>
    Function GenerateSQL(ByVal SearchParmList As SortedList(Of String, String), ByRef SecureID As Integer, TypeSQL As String) As String Implements IService1.GenerateSQL
        Dim S As String = ""
        S = DB.GenerateSQL(SearchParmList, SecureID, TypeSQL)
        Return S
    End Function

    ''' <summary>
    ''' Gets the json data.
    ''' </summary>
    ''' <param name="I">The i.</param>
    ''' <returns>System.String.</returns>
    Public Function getJsonData(I As String) As String Implements IService1.getJsonData
        Dim jdata As String = DB.getJsonData(I)
        Return jdata
    End Function


    Public Function getRowIDs(ByRef SearchSQL As String, SearchTypeCode As String, SecureID As Integer) As String Implements IService1.getRowIDs
        Console.WriteLine("Start getRowIDs Search: " + Now.ToString)
        Dim RowIds As String = DB.getRowIDs(SearchSQL, SearchTypeCode, SecureID)
        Return RowIds
    End Function

    ''' <summary>
    ''' Executes the content of the search.
    ''' </summary>
    ''' <param name="SecureID">                 The secure identifier.</param>
    ''' <param name="currSearchCnt">            The curr search count.</param>
    ''' <param name="bGenSql">                  if set to <c>true</c> [b gen SQL].</param>
    ''' <param name="SearchParmsJson">          The search parms json.</param>
    ''' <param name="bFirstContentSearchSubmit">if set to <c>true</c> [b first content search submit].</param>
    ''' <param name="ContentRowCnt">            The content row count.</param>
    ''' <returns>System.String.</returns>
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

    ''' <summary>
    ''' Executes the search email.
    ''' </summary>
    ''' <param name="SecureID">               The secure identifier.</param>
    ''' <param name="currSearchCnt">          The curr search count.</param>
    ''' <param name="bGenSql">                if set to <c>true</c> [b gen SQL].</param>
    ''' <param name="SearchParmsJson">        The search parms json.</param>
    ''' <param name="bFirstEmailSearchSubmit">if set to <c>true</c> [b first email search submit].</param>
    ''' <param name="EmailRowCnt">            The email row count.</param>
    ''' <returns>System.String.</returns>
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

    ''' <summary>
    ''' Saves the state of the search.
    ''' </summary>
    ''' <param name="SecureID">          The secure identifier.</param>
    ''' <param name="SearchID">          The search identifier.</param>
    ''' <param name="UID">               The uid.</param>
    ''' <param name="ScreenName">        Name of the screen.</param>
    ''' <param name="DICT">              The dictionary.</param>
    ''' <param name="rMsg">              The r MSG.</param>
    ''' <param name="RC">                if set to <c>true</c> [rc].</param>
    ''' <param name="HiveConnectionName">Name of the hive connection.</param>
    ''' <param name="HiveActive">        if set to <c>true</c> [hive active].</param>
    ''' <param name="RepoSvrName">       Name of the repo SVR.</param>
    Public Sub saveSearchState(ByRef SecureID As Integer, ByVal SearchID As Integer, ByVal UID As String, ByVal ScreenName As String, ByVal DICT As Dictionary(Of String, String), ByRef rMsg As String, ByRef RC As Boolean, ByVal HiveConnectionName As String, ByVal HiveActive As Boolean, ByVal RepoSvrName As String) Implements IService1.saveSearchState
        DB.saveSearchState(SecureID, SearchID, UID, ScreenName, DICT, rMsg, RC, HiveConnectionName, HiveActive, RepoSvrName)
    End Sub

    ''' <summary>
    ''' Gets the state of the search.
    ''' </summary>
    ''' <param name="SecureID">          The secure identifier.</param>
    ''' <param name="SearchID">          The search identifier.</param>
    ''' <param name="UID">               The uid.</param>
    ''' <param name="ScreenName">        Name of the screen.</param>
    ''' <param name="DICT">              The dictionary.</param>
    ''' <param name="rMsg">              The r MSG.</param>
    ''' <param name="RC">                if set to <c>true</c> [rc].</param>
    ''' <param name="HiveConnectionName">Name of the hive connection.</param>
    ''' <param name="HiveActive">        if set to <c>true</c> [hive active].</param>
    ''' <param name="RepoSvrName">       Name of the repo SVR.</param>
    ''' <returns>List(Of DS_USERSEARCHSTATE).</returns>
    Public Function getSearchState(ByRef SecureID As Integer, ByVal SearchID As Integer, ByVal UID As String, ByVal ScreenName As String, ByRef DICT As Dictionary(Of String, String), ByRef rMsg As String, ByRef RC As Boolean, ByVal HiveConnectionName As String, ByVal HiveActive As Boolean, ByVal RepoSvrName As String) As List(Of DS_USERSEARCHSTATE) Implements IService1.getSearchState
        Dim ListOfRows As New List(Of DS_USERSEARCHSTATE)
        ListOfRows = DB.getSearchState(SecureID, SearchID, UID, ScreenName, DICT, rMsg, RC, HiveConnectionName, HiveActive, RepoSvrName)
        Return ListOfRows
    End Function

    ''' <summary>
    ''' Saves the grid layout.
    ''' </summary>
    ''' <param name="SecureID">          The secure identifier.</param>
    ''' <param name="UserID">            The user identifier.</param>
    ''' <param name="ScreenName">        Name of the screen.</param>
    ''' <param name="GridName">          Name of the grid.</param>
    ''' <param name="ColName">           Name of the col.</param>
    ''' <param name="ColOrder">          The col order.</param>
    ''' <param name="ColWidth">          Width of the col.</param>
    ''' <param name="ColVisible">        if set to <c>true</c> [col visible].</param>
    ''' <param name="ColReadOnly">       if set to <c>true</c> [col read only].</param>
    ''' <param name="ColSortOrder">      The col sort order.</param>
    ''' <param name="ColSortAsc">        if set to <c>true</c> [col sort asc].</param>
    ''' <param name="HiveConnectionName">Name of the hive connection.</param>
    ''' <param name="HiveActive">        if set to <c>true</c> [hive active].</param>
    ''' <param name="RepoSvrName">       Name of the repo SVR.</param>
    ''' <param name="RowCreationDate">   The row creation date.</param>
    ''' <param name="RowLastModDate">    The row last mod date.</param>
    ''' <param name="RowNbr">            The row NBR.</param>
    ''' <param name="RC">                if set to <c>true</c> [rc].</param>
    ''' <param name="rMsg">              The r MSG.</param>
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

    ''' <summary>
    ''' Gets the grid layout.
    ''' </summary>
    ''' <param name="SecureID">          The secure identifier.</param>
    ''' <param name="UID">               The uid.</param>
    ''' <param name="ScreenName">        Name of the screen.</param>
    ''' <param name="GridName">          Name of the grid.</param>
    ''' <param name="DICT">              The dictionary.</param>
    ''' <param name="rMsg">              The r MSG.</param>
    ''' <param name="RC">                if set to <c>true</c> [rc].</param>
    ''' <param name="HiveConnectionName">Name of the hive connection.</param>
    ''' <param name="HiveActive">        if set to <c>true</c> [hive active].</param>
    ''' <param name="RepoSvrName">       Name of the repo SVR.</param>
    ''' <returns>List(Of DS_clsUSERGRIDSTATE).</returns>
    Public Function getGridLayout(ByRef SecureID As Integer, ByVal UID As String, ByVal ScreenName As String, GridName As String, ByVal DICT As Dictionary(Of String, String), ByRef rMsg As String, ByRef RC As Boolean, ByVal HiveConnectionName As String, ByVal HiveActive As Boolean, ByVal RepoSvrName As String) As List(Of DS_clsUSERGRIDSTATE) Implements IService1.getGridLayout
        Dim ListOfRows As List(Of DS_clsUSERGRIDSTATE) = New List(Of DS_clsUSERGRIDSTATE)()
        ListOfRows = DB.getGridLayout(SecureID, UID, ScreenName, GridName, DICT, rMsg, RC, HiveConnectionName, HiveActive, RepoSvrName)
        Return ListOfRows
    End Function

    ''' <summary>
    ''' Saves the state of the screen.
    ''' </summary>
    ''' <param name="SecureID">          The secure identifier.</param>
    ''' <param name="UID">               The uid.</param>
    ''' <param name="ScreenName">        Name of the screen.</param>
    ''' <param name="DICT">              The dictionary.</param>
    ''' <param name="rMsg">              The r MSG.</param>
    ''' <param name="RC">                if set to <c>true</c> [rc].</param>
    ''' <param name="HiveConnectionName">Name of the hive connection.</param>
    ''' <param name="HiveActive">        if set to <c>true</c> [hive active].</param>
    ''' <param name="RepoSvrName">       Name of the repo SVR.</param>
    Public Sub saveScreenState(ByRef SecureID As Integer, ByVal UID As String, ByVal ScreenName As String, ByVal DICT As Dictionary(Of String, String), ByRef rMsg As String, ByRef RC As Boolean, ByVal HiveConnectionName As String, ByVal HiveActive As Boolean, ByVal RepoSvrName As String) Implements IService1.saveScreenState
        'Dim DB As New clsDatabase
        DB.saveScreenState(SecureID, UID, ScreenName, DICT, rMsg, RC, HiveConnectionName, HiveActive, RepoSvrName)
        'DB = Nothing
    End Sub

    ''' <summary>
    ''' Gets the state of the screen.
    ''' </summary>
    ''' <param name="SecureID">          The secure identifier.</param>
    ''' <param name="UID">               The uid.</param>
    ''' <param name="ScreenName">        Name of the screen.</param>
    ''' <param name="DICT">              The dictionary.</param>
    ''' <param name="rMsg">              The r MSG.</param>
    ''' <param name="RC">                if set to <c>true</c> [rc].</param>
    ''' <param name="HiveConnectionName">Name of the hive connection.</param>
    ''' <param name="HiveActive">        if set to <c>true</c> [hive active].</param>
    ''' <param name="RepoSvrName">       Name of the repo SVR.</param>
    ''' <returns>List(Of DS_USERSCREENSTATE).</returns>
    Public Function getScreenState(ByRef SecureID As Integer, ByVal UID As String, ByVal ScreenName As String, ByRef DICT As Dictionary(Of String, String), ByRef rMsg As String, ByRef RC As Boolean, ByVal HiveConnectionName As String, ByVal HiveActive As Boolean, ByVal RepoSvrName As String) As List(Of DS_USERSCREENSTATE) Implements IService1.getScreenState
        Dim ListOfRows As New List(Of DS_USERSCREENSTATE)
        ListOfRows = DB.getScreenState(SecureID, UID, ScreenName, DICT, rMsg, RC, HiveConnectionName, HiveActive, RepoSvrName)
        'DB = Nothing
        Return ListOfRows
    End Function

    ''' <summary>
    ''' xes the get XRT identifier.
    ''' </summary>
    ''' <param name="CustomerID">  The customer identifier.</param>
    ''' <param name="ServerName">  Name of the server.</param>
    ''' <param name="DBName">      Name of the database.</param>
    ''' <param name="InstanceName">Name of the instance.</param>
    ''' <returns>System.Int32.</returns>
    Public Function xGetXrtID(CustomerID As String, ServerName As String, DBName As String, InstanceName As String) As Integer Implements IService1.xGetXrtID
        Dim rid As Integer = DB.xGetXrtID(CustomerID, ServerName, DBName, InstanceName)
        Return rid
    End Function

    ''' <summary>
    ''' Gets the user parms.
    ''' </summary>
    ''' <param name="SecureID"> The secure identifier.</param>
    ''' <param name="UserID">   The user identifier.</param>
    ''' <param name="UserParms">The user parms.</param>
    Public Sub getUserParms(ByRef SecureID As Integer, ByVal UserID As String, ByRef UserParms As Dictionary(Of String, String)) Implements IService1.getUserParms
        DB.getUserParms(SecureID, UserID, UserParms)
    End Sub

    ''' <summary>
    ''' Parses the lic dictionary.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="S">       The s.</param>
    ''' <param name="D">       The d.</param>
    Public Sub ParseLicDictionary(ByRef SecureID As Integer, ByVal S As String, ByRef D As Dictionary(Of String, String)) Implements IService1.ParseLicDictionary
        Dim LM As New clsLicenseMgt()
        LM.ParseLicDictionary(S, D)
        LM = Nothing
    End Sub

    ''' <summary>
    ''' Licenses the type.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="RC">      if set to <c>true</c> [rc].</param>
    ''' <param name="RetMsg">  The ret MSG.</param>
    ''' <returns>System.String.</returns>
    Public Function LicenseType(ByVal SecureID As Integer, ByRef RC As Boolean, ByRef RetMsg As String) As String Implements IService1.LicenseType
        Dim LM As New clsLicenseMgt()
        Dim S As String = LM.LicenseType(SecureID, RC, RetMsg)
        LM = Nothing
        Return S
    End Function

    ''' <summary>
    ''' Gets the NBR users.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <returns>System.Int32.</returns>
    Public Function GetNbrUsers(ByRef SecureID As Integer) As Integer Implements IService1.GetNbrUsers
        Dim I As Integer = DB.GetNbrUsers(SecureID)
        Return I
    End Function

    ''' <summary>
    ''' Determines whether the specified secure identifier is lease.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="RC">      if set to <c>true</c> [rc].</param>
    ''' <param name="RetMsg">  The ret MSG.</param>
    ''' <returns><c>true</c> if the specified secure identifier is lease; otherwise, <c>false</c>.</returns>
    Function isLease(ByVal SecureID As Integer, ByRef RC As Boolean, ByRef RetMsg As String) As Boolean Implements IService1.isLease
        Dim LM As New clsLicenseMgt()
        Dim B As Boolean = LM.isLease(SecureID, RC, RetMsg)
        LM = Nothing
        Return B
    End Function

    ''' <summary>
    ''' Gets the maximum clients.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="RC">      if set to <c>true</c> [rc].</param>
    ''' <param name="RetMsg">  The ret MSG.</param>
    ''' <returns>System.Int32.</returns>
    Public Function getMaxClients(ByVal SecureID As Integer, ByRef RC As Boolean, ByRef RetMsg As String) As Integer Implements IService1.getMaxClients
        Dim LM As New clsLicenseMgt()
        Dim I As Integer = LM.getMaxClients(SecureID, RC, RetMsg)
        LM = Nothing
        Return I
    End Function

    ''' <summary>
    ''' Gets the name of the user host.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <returns>System.String.</returns>
    Public Function GetUserHostName(ByRef SecureID As Integer) As String Implements IService1.GetUserHostName
        Dim S As String = ""
        S = System.Web.HttpContext.Current.Request.UserHostName.ToString
        Return S
    End Function

    ''' <summary>
    ''' Gets the user host address.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <returns>System.String.</returns>
    Public Function GetUserHostAddress(ByRef SecureID As Integer) As String Implements IService1.GetUserHostAddress
        Dim S As String = ""
        S = System.Web.HttpContext.Current.Request.UserHostAddress
        Return S
    End Function

    ''' <summary>
    ''' Gets the user unique identifier identifier.
    ''' </summary>
    ''' <param name="SecureID">   The secure identifier.</param>
    ''' <param name="UserLoginId">The user login identifier.</param>
    ''' <returns>System.String.</returns>
    Public Function getUserGuidID(ByRef SecureID As Integer, ByVal UserLoginId As String) As String Implements IService1.getUserGuidID
        Dim UserGuid As String = DB.getUserGuidID(SecureID, UserLoginId)
        Return UserGuid
    End Function

    ''' <summary>
    ''' Processes the dates.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <returns>Dictionary(Of System.String, System.DateTime).</returns>
    Public Function ProcessDates(ByRef SecureID As Integer) As Dictionary(Of String, Date) Implements IService1.ProcessDates
        Dim D As New Dictionary(Of String, Date)
        D = DB.ProcessDates(SecureID)
        Return D
    End Function

    ''' <summary>
    ''' Gets the NBR machine all.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <returns>System.Int32.</returns>
    Public Function GetNbrMachineAll(ByRef SecureID As Integer) As Integer Implements IService1.GetNbrMachineAll
        Dim I As Integer = DB.GetNbrMachine(SecureID)
        Return I
    End Function

    ''' <summary>
    ''' Gets the NBR machine.
    ''' </summary>
    ''' <param name="SecureID">   The secure identifier.</param>
    ''' <param name="MachineName">Name of the machine.</param>
    ''' <returns>System.Int32.</returns>
    Public Function GetNbrMachine(ByRef SecureID As Integer, ByVal MachineName As String) As Integer Implements IService1.GetNbrMachine
        Dim I As Integer = DB.GetNbrMachine(SecureID, MachineName)
        Return I
    End Function

    ''' <summary>
    ''' Determines whether [is license located on assigned machine] [the specified secure identifier].
    ''' </summary>
    ''' <param name="SecureID">       The secure identifier.</param>
    ''' <param name="ServerValText">  The server value text.</param>
    ''' <param name="InstanceValText">The instance value text.</param>
    ''' <param name="RC">             if set to <c>true</c> [rc].</param>
    ''' <param name="RetMsg">         The ret MSG.</param>
    ''' <returns>
    ''' <c>true</c> if [is license located on assigned machine] [the specified secure identifier];
    ''' otherwise, <c>false</c>.
    ''' </returns>
    Public Function isLicenseLocatedOnAssignedMachine(ByRef SecureID As Integer, ByRef ServerValText As String, ByRef InstanceValText As String, ByRef RC As Boolean, ByRef RetMsg As String) As Boolean Implements IService1.isLicenseLocatedOnAssignedMachine
        Dim LIC As New clsLicenseMgt()
        RC = LIC.isLicenseLocatedOnAssignedMachine(ServerValText, InstanceValText, SecureID, RC, RetMsg)
        LIC = Nothing
        Return RC
    End Function

    ''' <summary>
    ''' Gets the XRT test.
    ''' </summary>
    ''' <param name="dt">The dt.</param>
    ''' <returns>System.String.</returns>
    Public Function GetXrtTest(dt As Date) As String Implements IService1.GetXrtTest
        Return "Executed GetXrtTest: " + dt.ToString()
    End Function

    ''' <summary>
    ''' Gets the XRT.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="RC">      if set to <c>true</c> [rc].</param>
    ''' <param name="RetMsg">  The ret MSG.</param>
    ''' <returns>System.String.</returns>
    Public Function GetXrt(ByRef SecureID As Integer, ByVal RC As Boolean, ByVal RetMsg As String) As String Implements IService1.GetXrt
        'Dim LIC As New clsLicenseMgt()
        'Dim S As String = LIC.GetXrt(SecureID, RC, RetMsg)
        'LIC = Nothing
        Dim S As String = DB.GetXrt(SecureID, RC, RetMsg)
        Return S
    End Function

    ''' <summary>
    ''' Gets the SQL server version.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <returns>System.String.</returns>
    Public Function getSqlServerVersion(ByRef SecureID As Integer) As String Implements IService1.getSqlServerVersion
        Dim S As String = DB.getSqlServerVersion(SecureID)
        Return S
    End Function

    ''' <summary>
    ''' Records the growth.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="RC">      if set to <c>true</c> [rc].</param>
    Public Sub RecordGrowth(ByRef SecureID As Integer, ByRef RC As Boolean) Implements IService1.RecordGrowth
        DB.RecordGrowth(SecureID, RC)
    End Sub

    ''' <summary>
    ''' Parses the lic.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="LT">      The lt.</param>
    ''' <param name="tgtKey">  The TGT key.</param>
    ''' <returns>System.String.</returns>
    Public Function ParseLic(ByRef SecureID As Integer, ByVal LT As String, ByVal tgtKey As String) As String Implements IService1.ParseLic
        Dim S As String = ""
        Dim LM As New clsLicenseMgt()
        S = LM.ParseLic(LT$, "txtCustID")
        LM = Nothing
        Return S
    End Function

    ''' <summary>
    ''' Gets the dbsizemb.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <returns>System.Double.</returns>
    Public Function getDBSIZEMB(ByRef SecureID As Integer) As Double Implements IService1.getDBSIZEMB
        Dim D As Double = DB.getDBSIZEMB(SecureID)
        Return D
    End Function

    ''' <summary>
    ''' Gets the name of the loggedin user.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <returns>System.String.</returns>
    Public Function GetLoggedinUserName(ByRef SecureID As Integer) As String Implements IService1.GetLoggedinUserName
        Dim UTIL As New clsUtilitySVR
        Dim UNAME As String = UTIL.GetLoggedinUserName()
        Return UNAME
    End Function

    ''' <summary>
    ''' Resets the missing email ids.
    ''' </summary>
    ''' <param name="SecureID">      The secure identifier.</param>
    ''' <param name="CurrUserGuidID">The curr user unique identifier identifier.</param>
    ''' <param name="RC">            if set to <c>true</c> [rc].</param>
    Public Sub resetMissingEmailIds(ByRef SecureID As Integer, ByVal CurrUserGuidID As String, ByRef RC As Boolean) Implements IService1.resetMissingEmailIds
        DB.resetMissingEmailIds(SecureID, CurrUserGuidID, RC)
    End Sub

    ''' <summary>
    ''' Users the parm insert update.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="ParmName">Name of the parm.</param>
    ''' <param name="UserID">  The user identifier.</param>
    ''' <param name="ParmVal"> The parm value.</param>
    ''' <param name="RC">      if set to <c>true</c> [rc].</param>
    Public Sub UserParmInsertUpdate(ByRef SecureID As Integer, ByVal ParmName As String, ByVal UserID As String, ByVal ParmVal As String, ByRef RC As Boolean) Implements IService1.UserParmInsertUpdate
        DB.UserParmInsertUpdate(SecureID, ParmName, UserID, ParmVal, RC)
    End Sub

    ''' <summary>
    ''' Validates the login.
    ''' </summary>
    ''' <param name="SecureID">  The secure identifier.</param>
    ''' <param name="UserLogin"> The user login.</param>
    ''' <param name="PW">        The pw.</param>
    ''' <param name="UserGuidID">The user unique identifier identifier.</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    Public Function validateLogin(ByRef SecureID As Integer, ByVal UserLogin As String, ByVal PW As String, ByRef UserGuidID As String) As Boolean Implements IService1.validateLogin
        Dim RC As Boolean = False
        Dim B As Boolean = DB.validateLogin(SecureID, UserLogin, PW, UserGuidID)
        Return B
    End Function

    ''' <summary>
    ''' Gets the logged in user.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <returns>System.String.</returns>
    Public Function getLoggedInUser(ByRef SecureID As Integer) As String Implements IService1.getLoggedInUser
        Return DB.getLoggedInUser(SecureID)
    End Function

    ''' <summary>
    ''' Gets the name of the attached machine.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <returns>System.String.</returns>
    Public Function getAttachedMachineName(ByRef SecureID As Integer) As String Implements IService1.getAttachedMachineName
        Return DB.getAttachedMachineName(SecureID)
    End Function

    ''' <summary>
    ''' Gets the name of the server instance.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <returns>System.String.</returns>
    Public Function getServerInstanceName(ByRef SecureID As Integer) As String Implements IService1.getServerInstanceName
        Return DB.getServerInstanceName(SecureID)
    End Function

    ''' <summary>
    ''' Gets the name of the server machine.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <returns>System.String.</returns>
    Public Function getServerMachineName(ByRef SecureID As Integer) As String Implements IService1.getServerMachineName
        Return DB.getServerMachineName(SecureID)
    End Function

    ''' <summary>
    ''' Gets the system parm.
    ''' </summary>
    ''' <param name="SecureID">   The secure identifier.</param>
    ''' <param name="SystemParms">The system parms.</param>
    Public Sub getSystemParm(ByRef SecureID As Integer, ByRef SystemParms As Dictionary(Of String, String)) Implements IService1.getSystemParm
        DB.getSystemParm(SecureID, SystemParms)
    End Sub

    ''' <summary>
    ''' Gets the synonyms.
    ''' </summary>
    ''' <param name="SecureID">   The secure identifier.</param>
    ''' <param name="ThesaurusID">The thesaurus identifier.</param>
    ''' <param name="Token">      The token.</param>
    ''' <param name="lbSynonyms"> The lb synonyms.</param>
    ''' <returns>System.String.</returns>
    Public Function getSynonyms(ByRef SecureID As Integer, ByVal ThesaurusID As String, ByVal Token As String, ByRef lbSynonyms As String) As String Implements IService1.getSynonyms
        Dim DBSQL As New clsDb
        Dim S As String = DBSQL.getSynonyms(SecureID, ThesaurusID, Token, lbSynonyms)
        DBSQL = Nothing
        Return S
    End Function

    ''' <summary>
    ''' Gets the thesaurus identifier.
    ''' </summary>
    ''' <param name="SecureID">     The secure identifier.</param>
    ''' <param name="ThesaurusName">Name of the thesaurus.</param>
    ''' <returns>System.String.</returns>
    Public Function getThesaurusID(ByRef SecureID As Integer, ByVal ThesaurusName As String) As String Implements IService1.getThesaurusID
        Dim DBSQL As New clsDb
        Dim S As String = DB.getThesaurusID(SecureID, ThesaurusName)
        DBSQL = Nothing
        Return S
    End Function

    ''' <summary>
    ''' is the content of the count.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="MySql">   My SQL.</param>
    ''' <returns>System.Int32.</returns>
    Public Function iCountContent(ByRef SecureID As Integer, ByVal MySql As String) As Integer Implements IService1.iCountContent
        Dim I As Integer
        I = DB.iCountContent(SecureID, MySql)
        Return I
    End Function

    ''' <summary>
    ''' Gets the datasource parm.
    ''' </summary>
    ''' <param name="SecureID">     The secure identifier.</param>
    ''' <param name="AttributeName">Name of the attribute.</param>
    ''' <param name="SourceGuid">   The source unique identifier.</param>
    ''' <returns>System.String.</returns>
    Public Function getDatasourceParm(ByRef SecureID As Integer, ByVal AttributeName As String, ByVal SourceGuid As String) As String Implements IService1.getDatasourceParm
        Dim S As String = ""
        S = DB.getDatasourceParm(SecureID, AttributeName, SourceGuid)
        Return S
    End Function

    ''' <summary>
    ''' Saves the run parm.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="UserID">  The user identifier.</param>
    ''' <param name="ParmID">  The parm identifier.</param>
    ''' <param name="ParmVal"> The parm value.</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    Public Function SaveRunParm(ByRef SecureID As Integer, ByVal UserID As String, ByRef ParmID As String, ByRef ParmVal As String) As Boolean Implements IService1.SaveRunParm
        Dim B As Boolean = False
        B = DB.SaveRunParm(SecureID, UserID, ParmID, ParmVal)
        Return B
    End Function

    ''' <summary>
    ''' is the get row count.
    ''' </summary>
    ''' <param name="SecureID">   The secure identifier.</param>
    ''' <param name="TBL">        The table.</param>
    ''' <param name="WhereClause">The where clause.</param>
    ''' <returns>System.Int32.</returns>
    Public Function iGetRowCount(ByRef SecureID As Integer, ByVal TBL As String, ByVal WhereClause As String) As Integer Implements IService1.iGetRowCount
        Dim I As Integer = DB.iGetRowCount(TBL, WhereClause)
        Return I
    End Function

    ''' <summary>
    ''' Zeroizes the global search.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    Public Function ZeroizeGlobalSearch(ByRef SecureID As Integer) As Boolean Implements IService1.ZeroizeGlobalSearch
        Dim B As Boolean
        B = DB.ZeroizeGlobalSearch(SecureID)
        Return B
    End Function

    ''' <summary>
    ''' Updates the ip.
    ''' </summary>
    ''' <param name="SecureID"> The secure identifier.</param>
    ''' <param name="HostName"> Name of the host.</param>
    ''' <param name="IP">       The ip.</param>
    ''' <param name="checkCode">The check code.</param>
    ''' <param name="RC">       if set to <c>true</c> [rc].</param>
    Public Sub UpdateIP(ByRef SecureID As Integer, ByVal HostName As String, ByVal IP As String, ByVal checkCode As Integer, ByRef RC As Boolean) Implements IService1.updateIp
        DB.UpdateIP(SecureID, HostName, IP, checkCode, RC)
    End Sub

    ''' <summary>
    ''' Populates the source grid with weights.
    ''' </summary>
    ''' <param name="SecureID">    The secure identifier.</param>
    ''' <param name="StartingRow"> The starting row.</param>
    ''' <param name="EndingRow">   The ending row.</param>
    ''' <param name="CallerName">  Name of the caller.</param>
    ''' <param name="MySql">       My SQL.</param>
    ''' <param name="bNewRows">    if set to <c>true</c> [b new rows].</param>
    ''' <param name="SourceRowCnt">The source row count.</param>
    ''' <returns>List(Of DS_CONTENT).</returns>
    Public Function PopulateSourceGridWithWeights(ByRef SecureID As Integer, ByVal StartingRow As Integer, ByVal EndingRow As Integer, ByVal CallerName As String, ByVal MySql As String, ByRef bNewRows As Boolean, ByRef SourceRowCnt As Integer) As List(Of DS_CONTENT) Implements IService1.PopulateSourceGridWithWeights
        Dim ListOfRows As New List(Of DS_CONTENT)
        ListOfRows = DB.PopulateSourceGridWithWeights(SecureID, StartingRow, EndingRow, CallerName, MySql, bNewRows, SourceRowCnt)
        Return ListOfRows
    End Function

    ''' <summary>
    ''' Populates the source grid no weights.
    ''' </summary>
    ''' <param name="SecureID">    The secure identifier.</param>
    ''' <param name="StartingRow"> The starting row.</param>
    ''' <param name="EndingRow">   The ending row.</param>
    ''' <param name="CallerName">  Name of the caller.</param>
    ''' <param name="MySql">       My SQL.</param>
    ''' <param name="bNewRows">    if set to <c>true</c> [b new rows].</param>
    ''' <param name="SourceRowCnt">The source row count.</param>
    ''' <returns>List(Of DS_CONTENT).</returns>
    Public Function PopulateSourceGridNoWeights(ByRef SecureID As Integer, ByVal StartingRow As Integer, ByVal EndingRow As Integer, ByVal CallerName As String, ByVal MySql As String, ByRef bNewRows As Boolean, ByRef SourceRowCnt As Integer) As List(Of DS_CONTENT) Implements IService1.PopulateSourceGridNoWeights
        Dim ListOfRows As New List(Of DS_CONTENT)
        ListOfRows = DB.PopulateSourceGridNoWeights(SecureID, StartingRow, EndingRow, CallerName, MySql, bNewRows, SourceRowCnt)
        Return ListOfRows
    End Function

    ''' <summary>
    ''' Populates the email grid with no weights.
    ''' </summary>
    ''' <param name="SecureID">    The secure identifier.</param>
    ''' <param name="UID">         The uid.</param>
    ''' <param name="CallerName">  Name of the caller.</param>
    ''' <param name="MySql">       My SQL.</param>
    ''' <param name="nbrWeightMin">The NBR weight minimum.</param>
    ''' <param name="StartingRow"> The starting row.</param>
    ''' <param name="EndingRow">   The ending row.</param>
    ''' <param name="bNewRows">    if set to <c>true</c> [b new rows].</param>
    ''' <param name="EmailRowCnt"> The email row count.</param>
    ''' <returns>List(Of DS_EMAIL).</returns>
    Public Function PopulateEmailGridWithNoWeights(ByRef SecureID As Integer, ByVal UID As String, ByVal CallerName As String, ByVal MySql As String, ByVal nbrWeightMin As String, ByVal StartingRow As Integer, ByVal EndingRow As Integer, ByRef bNewRows As Boolean, ByRef EmailRowCnt As Integer) As List(Of DS_EMAIL) Implements IService1.PopulateEmailGridWithNoWeights
        Dim ListOfRows As New List(Of DS_EMAIL)
        ListOfRows = DB.PopulateEmailGridWithNoWeights(SecureID, UID, CallerName, MySql, StartingRow, EndingRow, bNewRows, EmailRowCnt)
        Return ListOfRows
    End Function

    ''' <summary>
    ''' Populates the email grid with weights.
    ''' </summary>
    ''' <param name="SecureID">    The secure identifier.</param>
    ''' <param name="UserID">      The user identifier.</param>
    ''' <param name="CallerName">  Name of the caller.</param>
    ''' <param name="MySql">       My SQL.</param>
    ''' <param name="nbrWeightMin">The NBR weight minimum.</param>
    ''' <param name="StartingRow"> The starting row.</param>
    ''' <param name="EndingRow">   The ending row.</param>
    ''' <param name="bNewRows">    if set to <c>true</c> [b new rows].</param>
    ''' <param name="EmailRowCnt"> The email row count.</param>
    ''' <returns>List(Of DS_EMAIL).</returns>
    Function PopulateEmailGridWithWeights(ByRef SecureID As Integer, ByVal UserID As String, ByVal CallerName As String, ByVal MySql As String, ByVal nbrWeightMin As String, ByVal StartingRow As Integer, ByVal EndingRow As Integer, ByRef bNewRows As Boolean, ByRef EmailRowCnt As Integer) As List(Of DS_EMAIL) Implements IService1.PopulateEmailGridWithWeights
        Dim ListOfRows As New List(Of DS_EMAIL)
        ListOfRows = DB.PopulateEmailGridWithWeights(SecureID, UserID, CallerName, MySql, nbrWeightMin, StartingRow, EndingRow, bNewRows, EmailRowCnt)
        Return ListOfRows
    End Function

    ''' <summary>
    ''' Loads the user search history.
    ''' </summary>
    ''' <param name="SecureID">              The secure identifier.</param>
    ''' <param name="MaxNbrSearches">        The maximum NBR searches.</param>
    ''' <param name="Uid">                   The uid.</param>
    ''' <param name="Screen">                The screen.</param>
    ''' <param name="SearchHistoryArrayList">The search history array list.</param>
    ''' <param name="NbrReturned">           The NBR returned.</param>
    Public Sub LoadUserSearchHistory(ByRef SecureID As Integer, ByVal MaxNbrSearches As Integer, ByVal Uid As String, ByVal Screen As String, ByRef SearchHistoryArrayList As List(Of String), ByRef NbrReturned As Integer) Implements IService1.LoadUserSearchHistory
        DB.LoadUserSearchHistory(SecureID, MaxNbrSearches, Uid, Screen, SearchHistoryArrayList, NbrReturned)
    End Sub

    ''' <summary>
    ''' Gets the attachment weights.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="SL">      The sl.</param>
    ''' <param name="UserID">  The user identifier.</param>
    Public Sub getAttachmentWeights(ByRef SecureID As Integer, ByRef SL As Dictionary(Of String, Integer), ByVal UserID As String) Implements IService1.getAttachmentWeights
        DB.getAttachmentWeights(SecureID, SL, UserID)
    End Sub

    ''' <summary>
    ''' Databases the execute encrypted SQL.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="MySql">   My SQL.</param>
    ''' <param name="EKEY">    The ekey.</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    Public Function DBExecuteEncryptedSql(ByRef SecureID As Integer, ByRef MySql As String, ByVal EKEY As String) As Boolean Implements IService1.DBExecuteEncryptedSql
        Dim B As Boolean = False
        B = DB.DBExecuteEncryptedSql(SecureID, MySql, EKEY)
        Return B
    End Function

    ''' <summary>
    ''' Executes the SQL new connection secure.
    ''' </summary>
    ''' <param name="SecureID">      The secure identifier.</param>
    ''' <param name="EncryptedMySql">The encrypted my SQL.</param>
    ''' <param name="UserID">        The user identifier.</param>
    ''' <param name="ContractID">    The contract identifier.</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
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

    ''' <summary>
    ''' Executes the SQL new conn1.
    ''' </summary>
    ''' <param name="SecureID">      The secure identifier.</param>
    ''' <param name="EncryptedMySql">The encrypted my SQL.</param>
    ''' <param name="UserID">        The user identifier.</param>
    ''' <param name="ContractID">    The contract identifier.</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    Public Function ExecuteSqlNewConn1(ByRef SecureID As Integer, ByRef EncryptedMySql As String, UserID As String, ContractID As String) As Boolean Implements IService1.ExecuteSqlNewConn1
        Dim MySql = ENC.AES256DecryptString(EncryptedMySql)
        Dim B As Boolean = False
        B = DB.DBExecuteSql(SecureID, MySql)
        Return B
    End Function

    ''' <summary>
    ''' Executes the SQL new conn2.
    ''' </summary>
    ''' <param name="SecureID">      The secure identifier.</param>
    ''' <param name="EncryptedMySql">The encrypted my SQL.</param>
    ''' <param name="UserID">        The user identifier.</param>
    ''' <param name="ContractID">    The contract identifier.</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    Public Function ExecuteSqlNewConn2(ByRef SecureID As Integer, ByRef EncryptedMySql As String, UserID As String, ContractID As String) As Boolean Implements IService1.ExecuteSqlNewConn2
        Dim MySql = ENC.AES256DecryptString(EncryptedMySql)
        Dim B As Boolean = False
        B = DB.DBExecuteSql(SecureID, MySql)
        Return B
    End Function

    ''' <summary>
    ''' Executes the SQL new conn3.
    ''' </summary>
    ''' <param name="SecureID">      The secure identifier.</param>
    ''' <param name="EncryptedMySql">The encrypted my SQL.</param>
    ''' <param name="UserID">        The user identifier.</param>
    ''' <param name="ContractID">    The contract identifier.</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    Public Function ExecuteSqlNewConn3(ByRef SecureID As Integer, ByRef EncryptedMySql As String, UserID As String, ContractID As String) As Boolean Implements IService1.ExecuteSqlNewConn3
        Dim MySql = ENC.AES256DecryptString(EncryptedMySql)
        Dim B As Boolean = False
        B = DB.DBExecuteSql(SecureID, MySql)
        Return B
    End Function

    ''' <summary>
    ''' Executes the SQL new conn4.
    ''' </summary>
    ''' <param name="SecureID">      The secure identifier.</param>
    ''' <param name="EncryptedMySql">The encrypted my SQL.</param>
    ''' <param name="UserID">        The user identifier.</param>
    ''' <param name="ContractID">    The contract identifier.</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    Public Function ExecuteSqlNewConn4(ByRef SecureID As Integer, ByRef EncryptedMySql As String, UserID As String, ContractID As String) As Boolean Implements IService1.ExecuteSqlNewConn4
        Dim MySql = ENC.AES256DecryptString(EncryptedMySql)
        Dim B As Boolean = False
        B = DB.DBExecuteSql(SecureID, MySql)
        Return B
    End Function

    ''' <summary>
    ''' Executes the SQL new conn5.
    ''' </summary>
    ''' <param name="SecureID">      The secure identifier.</param>
    ''' <param name="EncryptedMySql">The encrypted my SQL.</param>
    ''' <param name="UserID">        The user identifier.</param>
    ''' <param name="ContractID">    The contract identifier.</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    Public Function ExecuteSqlNewConn5(ByRef SecureID As Integer, ByRef EncryptedMySql As String, UserID As String, ContractID As String) As Boolean Implements IService1.ExecuteSqlNewConn5
        Dim MySql = ENC.AES256DecryptString(EncryptedMySql)
        Dim B As Boolean = False
        B = DB.DBExecuteSql(SecureID, MySql)
        Return B
    End Function

    ''' <summary>
    ''' Gets the parm value.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="UID">     The uid.</param>
    ''' <param name="Parms">   The parms.</param>
    Public Sub GetParmValue(ByRef SecureID As Integer, ByVal UID As String, ByRef Parms As List(Of String)) Implements IService1.GetParmValue
        DB.GetParmValue(SecureID, UID, Parms)
    End Sub

    ''' <summary>
    ''' ds the bis global searcher.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="Userid">  The userid.</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    Public Function DBisGlobalSearcher(ByRef SecureID As Integer, ByVal Userid As String) As Boolean Implements IService1.DBisGlobalSearcher
        Dim B As Boolean = False
        B = DBisGlobalSearcher(SecureID, Userid)
        Return B
    End Function

    ''' <summary>
    ''' ds the bis admin.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="Userid">  The userid.</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    Public Function DBisAdmin(ByRef SecureID As Integer, ByVal Userid As String) As Boolean Implements IService1.DBisAdmin
        Dim B As Boolean = False
        B = DBisAdmin(SecureID, Userid)
        Return B
    End Function

    ''' <summary>
    ''' Gets the user parm.
    ''' </summary>
    ''' <param name="SecureID">        The secure identifier.</param>
    ''' <param name="sVariableToFetch">The s variable to fetch.</param>
    ''' <param name="UserParm">        The user parm.</param>
    Public Sub getUserParm(ByRef SecureID As Integer, ByRef sVariableToFetch As String, ByVal UserParm As String) Implements IService1.getUserParm
        Dim S As String = ""
        S = DB.getUserParm(SecureID, UserParm)
        sVariableToFetch = S
    End Sub

    ''' <summary>
    ''' Removes the unwanted characters.
    ''' </summary>
    ''' <param name="SecureID"> The secure identifier.</param>
    ''' <param name="tgtString">The TGT string.</param>
    Public Sub RemoveUnwantedCharacters(ByRef SecureID As Integer, ByRef tgtString As String) Implements IService1.RemoveUnwantedCharacters
        Dim UTIL As New clsUtilitySVR
        Dim S As String = UTIL.RemoveUnwantedCharacters(tgtString)
        tgtString = S
    End Sub

    ''' <summary>
    ''' Gets the machine ip.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <returns>System.String.</returns>
    Public Function GetMachineIP(ByRef SecureID As Integer) As String Implements IService1.GetMachineIP
        Dim S As String = ""
        Dim UTIL As New clsUtilitySVR
        S = UTIL.GetMachineIP()
        UTIL = Nothing
        Return S
    End Function

    ''' <summary>
    ''' Gets the client licenses.
    ''' </summary>
    ''' <param name="SecureID">    The secure identifier.</param>
    ''' <param name="CompanyID">   The company identifier.</param>
    ''' <param name="ErrorMessage">The error message.</param>
    ''' <param name="RC">          if set to <c>true</c> [rc].</param>
    ''' <returns>List(Of DS_License).</returns>
    Public Function getClientLicenses(ByRef SecureID As Integer, ByVal CompanyID As String, ByRef ErrorMessage As String, ByRef RC As Boolean) As List(Of DS_License) Implements IService1.getClientLicenses

        Dim L As List(Of DS_License)

        Dim RS As New clsRemoteSupport(SecureID)
        L = RS.getClientLicenses(SecureID, CompanyID, ErrorMessage, RC)
        RS = Nothing
        GC.Collect()

        Return L

    End Function



    Public Function getNewListOfStrings(ByRef SecureID As Integer, ByVal MySql As String, ByRef RC As Boolean, ByRef RetMsg As String, UserId As String, SessionID As String) As List(Of String) Implements IService1.getNewListOfStrings
        Return DB.getNewListOfStrings(SecureID, MySql, RC, RetMsg)
    End Function

    ''' <summary>
    ''' Gets the list of strings01.
    ''' </summary>
    ''' <param name="SecureID"> The secure identifier.</param>
    ''' <param name="MySql">    My SQL.</param>
    ''' <param name="RC">       if set to <c>true</c> [rc].</param>
    ''' <param name="RetMsg">   The ret MSG.</param>
    ''' <param name="UserId">   The user identifier.</param>
    ''' <param name="SessionID">The session identifier.</param>
    ''' <returns>System.String.</returns>
    Public Function getListOfStrings01(ByRef SecureID As Integer, ByVal MySql As String, ByRef RC As Boolean, ByRef RetMsg As String, UserId As String, SessionID As String) As String Implements IService1.getListOfStrings01
        'MySql = ENC.AES256DecryptString(MySql)
        Return DB.getListOfStrings01(SecureID, MySql, RC, RetMsg)
    End Function

    ''' <summary>
    ''' Gets the list of strings02.
    ''' </summary>
    ''' <param name="SecureID"> The secure identifier.</param>
    ''' <param name="MySql">    My SQL.</param>
    ''' <param name="RC">       if set to <c>true</c> [rc].</param>
    ''' <param name="RetMsg">   The ret MSG.</param>
    ''' <param name="UserId">   The user identifier.</param>
    ''' <param name="SessionID">The session identifier.</param>
    ''' <returns>List(Of DS_ListOfStrings02).</returns>
    Public Function getListOfStrings02(ByRef SecureID As Integer, ByVal MySql As String, ByRef RC As Boolean, ByRef RetMsg As String, UserId As String, SessionID As String) As List(Of DS_ListOfStrings02) Implements IService1.getListOfStrings02
        MySql = ENC.AES256DecryptString(MySql)
        Return DB.getListOfStrings02(SecureID, MySql, RC, RetMsg)
    End Function

    ''' <summary>
    ''' Gets the list of strings03.
    ''' </summary>
    ''' <param name="SecureID"> The secure identifier.</param>
    ''' <param name="MySql">    My SQL.</param>
    ''' <param name="RC">       if set to <c>true</c> [rc].</param>
    ''' <param name="RetMsg">   The ret MSG.</param>
    ''' <param name="UserId">   The user identifier.</param>
    ''' <param name="SessionID">The session identifier.</param>
    ''' <returns>List(Of DS_ListOfStrings03).</returns>
    Public Function getListOfStrings03(ByRef SecureID As Integer, ByVal MySql As String, ByRef RC As Boolean, ByRef RetMsg As String, UserId As String, SessionID As String) As List(Of DS_ListOfStrings03) Implements IService1.getListOfStrings03
        MySql = ENC.AES256DecryptString(MySql)
        Return DB.getListOfStrings03(SecureID, MySql, RC, RetMsg)
    End Function

    ''' <summary>
    ''' Gets the list of strings04.
    ''' </summary>
    ''' <param name="SecureID"> The secure identifier.</param>
    ''' <param name="MySql">    My SQL.</param>
    ''' <param name="RC">       if set to <c>true</c> [rc].</param>
    ''' <param name="RetMsg">   The ret MSG.</param>
    ''' <param name="UserId">   The user identifier.</param>
    ''' <param name="SessionID">The session identifier.</param>
    ''' <returns>List(Of DS_ListOfStrings04).</returns>
    Public Function getListOfStrings04(ByRef SecureID As Integer, ByVal MySql As String, ByRef RC As Boolean, ByRef RetMsg As String, UserId As String, SessionID As String) As List(Of DS_ListOfStrings04) Implements IService1.getListOfStrings04
        MySql = ENC.AES256DecryptString(MySql)
        Return DB.getListOfStrings04(SecureID, MySql, RC, RetMsg)
    End Function

    ''' <summary>
    ''' Gets the content dt.
    ''' </summary>
    ''' <param name="sourceguid">The sourceguid.</param>
    ''' <returns>DataTable.</returns>
    Public Function getContentDT(sourceguid As String) As DataTable Implements IService1.getContentDT
        Dim DT As DataTable = DB.getContentDT(sourceguid)
        Return DT
    End Function

End Class