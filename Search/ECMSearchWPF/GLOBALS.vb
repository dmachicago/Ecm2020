' ***********************************************************************
' Assembly         : ECMSearchWPF
' Author           : wdale
' Created          : 07-16-2020
'
' Last Modified By : wdale
' Last Modified On : 07-16-2020
' ***********************************************************************
' <copyright file="GLOBALS.vb" company="D. Miller and Associates, Limited">
'     Copyright @ DMA Ltd 2020 all rights reserved.
' </copyright>
' <summary></summary>
' ***********************************************************************
''' <summary>
''' Class GLOBALS.
''' </summary>
Module GLOBALS

    ''' <summary>
    ''' The proxy search
    ''' </summary>
    Public ProxySearch As New SVCSearch.Service1Client
    'Public ProxyGateway = New SVCGateway.Service1Client

    ''' <summary>
    ''' The g debug
    ''' </summary>
    Public gDebug As Boolean = False
    ''' <summary>
    ''' The g list of content rows
    ''' </summary>
    Public gListOfContentRows As String = ""
    ''' <summary>
    ''' The g list o email rows
    ''' </summary>
    Public gListOEmailRows As String = ""
    ''' <summary>
    ''' The g download dir
    ''' </summary>
    Public gDownloadDIR As String = ""
    ''' <summary>
    ''' The g selected grid
    ''' </summary>
    Public gSelectedGrid As String = ""
    ''' <summary>
    ''' The g custid
    ''' </summary>
    Public gCUSTID As String = ""
    ''' <summary>
    ''' The g svrname
    ''' </summary>
    Public gSVRNAME As String = ""
    ''' <summary>
    ''' The g dbname
    ''' </summary>
    Public gDBNAME As String = ""
    ''' <summary>
    ''' The g instancename
    ''' </summary>
    Public gINSTANCENAME As String = ""
    ''' <summary>
    ''' The g record NBR
    ''' </summary>
    Public gRecNbr As Integer = -1
    ''' <summary>
    ''' The g secure identifier
    ''' </summary>
    Public gSecureID As Integer = -1

    ''' <summary>
    ''' The g cs repo
    ''' </summary>
    Public gCSRepo As String = ""
    ''' <summary>
    ''' The g cs thesaurus
    ''' </summary>
    Public gCSThesaurus As String = ""
    ''' <summary>
    ''' The g cs hive
    ''' </summary>
    Public gCSHive As String = ""
    ''' <summary>
    ''' The g csdma license
    ''' </summary>
    Public gCSDMALicense As String = ""
    ''' <summary>
    ''' The g cs gate way
    ''' </summary>
    Public gCSGateWay As String = ""
    ''' <summary>
    ''' The g CSTDR
    ''' </summary>
    Public gCSTDR As String = ""
    ''' <summary>
    ''' The g CSK base
    ''' </summary>
    Public gCSKBase As String = ""


    ''' <summary>
    ''' The g row identifier
    ''' </summary>
    Public gRowID As String = ""
    ''' <summary>
    ''' The g int row identifier
    ''' </summary>
    Public gIntRowID As Integer = -1

    ''' <summary>
    ''' The g SVC gateway endpoint
    ''' </summary>
    Public gSVCGateway_Endpoint As String = ""
    ''' <summary>
    ''' The g SVC search endpoint
    ''' </summary>
    Public gSVCSearch_Endpoint As String = ""
    ''' <summary>
    ''' The g SVC download endpoint
    ''' </summary>
    Public gSVCDownload_Endpoint As String = ""

    ''' <summary>
    ''' The g email attach dt
    ''' </summary>
    Public gEmailAttachDT As New System.Data.DataTable
    ''' <summary>
    ''' The g email dt
    ''' </summary>
    Public gEmailDT As New System.Data.DataTable
    ''' <summary>
    ''' The g list of emails
    ''' </summary>
    Public gListOfEmails As New List(Of SVCSearch.DS_EMAIL)
    ''' <summary>
    ''' The g list of content
    ''' </summary>
    Public gListOfContent As New List(Of SVCSearch.DS_CONTENT)
    ''' <summary>
    ''' The g list of emails temporary
    ''' </summary>
    Public gListOfEmailsTemp As New System.Collections.Generic.List(Of SVCSearch.DS_EMAIL)
    ''' <summary>
    ''' The g list of content temporary
    ''' </summary>
    Public gListOfContentTemp As New System.Collections.Generic.List(Of SVCSearch.DS_CONTENT)

    ''' <summary>
    ''' The SQL SVR version
    ''' </summary>
    Public _SqlSvrVersion As String = String.Empty
    ''' <summary>
    ''' The NBR of seats
    ''' </summary>
    Public _NbrOfSeats As String = String.Empty
    ''' <summary>
    ''' The registered users
    ''' </summary>
    Public _RegisteredUsers As String = String.Empty
    ''' <summary>
    ''' The customer identifier
    ''' </summary>
    Public _CustomerID As String = String.Empty
    ''' <summary>
    ''' The maximum clients
    ''' </summary>
    Public _MaxClients As String = String.Empty
    ''' <summary>
    ''' The license valid
    ''' </summary>
    Public _LicenseValid As String = String.Empty
    ''' <summary>
    ''' The maint expire
    ''' </summary>
    Public _MaintExpire As String = String.Empty
    ''' <summary>
    ''' The license expire
    ''' </summary>
    Public _LicenseExpire As String = String.Empty
    ''' <summary>
    ''' The NBR registered machines
    ''' </summary>
    Public _NbrRegisteredMachines As String = String.Empty

    ''' <summary>
    ''' The user identifier
    ''' </summary>
    Public UserID As String = String.Empty
    ''' <summary>
    ''' The user unique identifier
    ''' </summary>
    Public UserGuid As String = String.Empty
    ''' <summary>
    ''' The company identifier
    ''' </summary>
    Public CompanyID As String = String.Empty
    ''' <summary>
    ''' The machine identifier
    ''' </summary>
    Public MachineID As String = String.Empty
    ''' <summary>
    ''' The repo identifier
    ''' </summary>
    Public RepoID As String = String.Empty
    ''' <summary>
    ''' The active unique identifier
    ''' </summary>
    Public ActiveGuid As Guid
    ''' <summary>
    ''' The encrypt pw
    ''' </summary>
    Public EncryptPW As String = ""
    ''' <summary>
    ''' The curr repo cs
    ''' </summary>
    Public CurrRepoCS As String = ""
    ''' <summary>
    ''' The session unique identifier
    ''' </summary>
    Public SessionGuid As Guid
    ''' <summary>
    ''' The is admin
    ''' </summary>
    Public isAdmin As Boolean = False
    ''' <summary>
    ''' The is super admin
    ''' </summary>
    Public isSuperAdmin As Boolean = False
    ''' <summary>
    ''' The is global searcher
    ''' </summary>
    Public isGlobalSearcher As Boolean = False
    ''' <summary>
    ''' The apply recalled search
    ''' </summary>
    Public _ApplyRecalledSearch As Boolean = False
    ''' <summary>
    ''' The dictionary master search
    ''' </summary>
    Public _dictMasterSearch As New Dictionary(Of String, String)
    ''' <summary>
    ''' The affinity delay
    ''' </summary>
    Public _AffinityDelay As Integer = 0
    ''' <summary>
    ''' The g local debug
    ''' </summary>
    Public gLocalDebug As Integer = 0
    ''' <summary>
    ''' The g contract identifier
    ''' </summary>
    Public gContractID As String = ""
    ''' <summary>
    ''' The g search end point
    ''' </summary>
    Public gSearchEndPoint As String = String.Empty
    ''' <summary>
    ''' The g gateway end point
    ''' </summary>
    Public gGatewayEndPoint As String = String.Empty
    ''' <summary>
    ''' The g download end point
    ''' </summary>
    Public gDownloadEndPoint As String = String.Empty
    ''' <summary>
    ''' The g encgwcs
    ''' </summary>
    Public gENCGWCS As String = String.Empty
    ''' <summary>
    ''' The g curr session unique identifier
    ''' </summary>
    Public gCurrSessionGuid As String = ""
    ''' <summary>
    ''' The g curr login
    ''' </summary>
    Public gCurrLogin As String = ""

    ''' <summary>
    ''' Gets or sets the svrname.
    ''' </summary>
    ''' <value>The svrname.</value>
    Property SVRNAME() As String
        Get
            Return gSVRNAME
        End Get
        Set(ByVal value As String)
            gSVRNAME = value
        End Set
    End Property

    ''' <summary>
    ''' Gets or sets the dbname.
    ''' </summary>
    ''' <value>The dbname.</value>
    Property DBNAME() As String
        Get
            Return gDBNAME
        End Get
        Set(ByVal value As String)
            gDBNAME = value
        End Set
    End Property

    ''' <summary>
    ''' Gets or sets the instancename.
    ''' </summary>
    ''' <value>The instancename.</value>
    Property INSTANCENAME() As String
        Get
            Return gINSTANCENAME
        End Get
        Set(ByVal value As String)
            gINSTANCENAME = value
        End Set
    End Property

    ''' <summary>
    ''' Gets or sets the NCGWCS.
    ''' </summary>
    ''' <value>The NCGWCS.</value>
    Property NCGWCS() As String
        Get
            Return gENCGWCS
        End Get
        Set(ByVal value As String)
            gENCGWCS = value
        End Set
    End Property
    ''' <summary>
    ''' Gets or sets the gateway end point.
    ''' </summary>
    ''' <value>The gateway end point.</value>
    Property GatewayEndPoint() As String
        Get
            Return gGatewayEndPoint
        End Get
        Set(ByVal value As String)
            gGatewayEndPoint = value
        End Set
    End Property
    ''' <summary>
    ''' Gets or sets the download end point.
    ''' </summary>
    ''' <value>The download end point.</value>
    Property DownloadEndPoint() As String
        Get
            Return gDownloadEndPoint
        End Get
        Set(ByVal value As String)
            gDownloadEndPoint = value
        End Set
    End Property
    ''' <summary>
    ''' Gets or sets the contract identifier.
    ''' </summary>
    ''' <value>The contract identifier.</value>
    Property ContractID() As String
        Get
            Return gContractID
        End Get
        Set(ByVal value As String)
            gContractID = value
        End Set
    End Property

    ''' <summary>
    ''' Gets or sets a value indicating whether [local debug].
    ''' </summary>
    ''' <value><c>true</c> if [local debug]; otherwise, <c>false</c>.</value>
    Property LocalDebug() As Boolean
        Get
            Return gLocalDebug
        End Get
        Set(ByVal value As Boolean)
            gLocalDebug = value
        End Set
    End Property

    ''' <summary>
    ''' Gets or sets the search end point.
    ''' </summary>
    ''' <value>The search end point.</value>
    Property SearchEndPoint() As String
        Get
            Return gSearchEndPoint
        End Get
        Set(ByVal value As String)
            gSearchEndPoint = value
        End Set
    End Property

    ''' <summary>
    ''' Gets or sets the affinity delay.
    ''' </summary>
    ''' <value>The affinity delay.</value>
    Property AffinityDelay() As Integer
        Get
            Return _AffinityDelay
        End Get
        Set(ByVal value As Integer)
            _AffinityDelay = value
        End Set
    End Property
    ''' <summary>
    ''' Gets or sets a value indicating whether [apply recalled search].
    ''' </summary>
    ''' <value><c>true</c> if [apply recalled search]; otherwise, <c>false</c>.</value>
    Property ApplyRecalledSearch() As Boolean
        Get
            Return _ApplyRecalledSearch
        End Get
        Set(ByVal value As Boolean)
            _ApplyRecalledSearch = value
        End Set
    End Property
    ''' <summary>
    ''' Gets or sets the NBR registered machines.
    ''' </summary>
    ''' <value>The NBR registered machines.</value>
    Property NbrRegisteredMachines() As String
        Get
            Return _NbrRegisteredMachines
        End Get
        Set(ByVal value As String)
            _NbrRegisteredMachines = value
        End Set
    End Property
    ''' <summary>
    ''' Gets or sets the SQL SVR version.
    ''' </summary>
    ''' <value>The SQL SVR version.</value>
    Property SqlSvrVersion() As String
        Get
            Return _SqlSvrVersion
        End Get
        Set(ByVal value As String)
            _SqlSvrVersion = value
        End Set
    End Property
    ''' <summary>
    ''' Gets or sets the NBR of seats.
    ''' </summary>
    ''' <value>The NBR of seats.</value>
    Property NbrOfSeats() As String
        Get
            Return _NbrOfSeats
        End Get
        Set(ByVal value As String)
            _NbrOfSeats = value
        End Set
    End Property
    ''' <summary>
    ''' Gets or sets the registered users.
    ''' </summary>
    ''' <value>The registered users.</value>
    Property RegisteredUsers() As String
        Get
            Return _RegisteredUsers
        End Get
        Set(ByVal value As String)
            _RegisteredUsers = value
        End Set
    End Property
    ''' <summary>
    ''' Gets or sets the customer identifier.
    ''' </summary>
    ''' <value>The customer identifier.</value>
    Property CustID() As String
        Get
            Return gCUSTID
        End Get
        Set(ByVal value As String)
            gCUSTID = value
        End Set
    End Property
    ''' <summary>
    ''' Gets or sets the customer identifier.
    ''' </summary>
    ''' <value>The customer identifier.</value>
    Property CustomerID() As String
        Get
            Return _CustomerID
        End Get
        Set(ByVal value As String)
            _CustomerID = value
        End Set
    End Property
    ''' <summary>
    ''' Gets or sets the maximum clients.
    ''' </summary>
    ''' <value>The maximum clients.</value>
    Property MaxClients() As String
        Get
            Return _MaxClients
        End Get
        Set(ByVal value As String)
            _MaxClients = value
        End Set
    End Property
    ''' <summary>
    ''' Gets or sets the license valid.
    ''' </summary>
    ''' <value>The license valid.</value>
    Property LicenseValid() As String
        Get
            Return _LicenseValid
        End Get
        Set(ByVal value As String)
            _LicenseValid = value
        End Set
    End Property
    ''' <summary>
    ''' Gets or sets the maint expire.
    ''' </summary>
    ''' <value>The maint expire.</value>
    Property MaintExpire() As String
        Get
            Return _MaintExpire
        End Get
        Set(ByVal value As String)
            _MaintExpire = value
        End Set
    End Property
    ''' <summary>
    ''' Gets or sets the license expire.
    ''' </summary>
    ''' <value>The license expire.</value>
    Property LicenseExpire() As String
        Get
            Return _LicenseExpire
        End Get
        Set(ByVal value As String)
            _LicenseExpire = value
        End Set
    End Property

    ''' <summary>
    ''' Gets or sets the machine identifier.
    ''' </summary>
    ''' <value>The machine identifier.</value>
    Property _MachineID() As String
        Get
            Return MachineID
        End Get
        Set(ByVal value As String)
            MachineID = value
        End Set
    End Property

    ''' <summary>
    ''' Searches the dictionary add.
    ''' </summary>
    ''' <param name="sKey">The s key.</param>
    ''' <param name="sVal">The s value.</param>
    Sub SearchDictAdd(ByVal sKey As String, ByVal sVal As String)
        If _dictMasterSearch.ContainsKey(sKey) Then
            _dictMasterSearch.Item(sKey) = sVal
        Else
            _dictMasterSearch.Add(sKey, sVal)
        End If
    End Sub

    ''' <summary>
    ''' Gets or sets the dictionary master search.
    ''' </summary>
    ''' <value>The dictionary master search.</value>
    Property dictMasterSearch() As Dictionary(Of String, String)
        Get
            Return _dictMasterSearch
        End Get
        Set(ByVal value As Dictionary(Of String, String))
            _dictMasterSearch = _dictMasterSearch
        End Set
    End Property

    ''' <summary>
    ''' Gets or sets a value indicating whether this instance is admin.
    ''' </summary>
    ''' <value><c>true</c> if this instance is admin; otherwise, <c>false</c>.</value>
    Property _isAdmin() As Boolean
        Get
            Return isAdmin
        End Get
        Set(ByVal value As Boolean)
            isAdmin = value
        End Set
    End Property

    ''' <summary>
    ''' Gets or sets a value indicating whether this instance is super admin.
    ''' </summary>
    ''' <value><c>true</c> if this instance is super admin; otherwise, <c>false</c>.</value>
    Property _isSuperAdmin() As Boolean
        Get
            Return isSuperAdmin
        End Get
        Set(ByVal value As Boolean)
            isSuperAdmin = value
        End Set
    End Property
    ''' <summary>
    ''' Gets or sets a value indicating whether this instance is global searcher.
    ''' </summary>
    ''' <value><c>true</c> if this instance is global searcher; otherwise, <c>false</c>.</value>
    Property _isGlobalSearcher() As Boolean
        Get
            Return isGlobalSearcher
        End Get
        Set(ByVal value As Boolean)
            isGlobalSearcher = value
        End Set
    End Property

    ''' <summary>
    ''' Gets or sets the user unique identifier.
    ''' </summary>
    ''' <value>The user unique identifier.</value>
    Property _UserGuid() As String
        Get
            Return UserGuid
        End Get
        Set(ByVal value As String)
            UserGuid = value
        End Set
    End Property

    ''' <summary>
    ''' Gets or sets the session unique identifier.
    ''' </summary>
    ''' <value>The session unique identifier.</value>
    Property _SessionGuid() As Guid
        Get
            Return SessionGuid
        End Get
        Set(ByVal value As Guid)
            SessionGuid = value
        End Set
    End Property

    ''' <summary>
    ''' Gets or sets the curr repo cs.
    ''' </summary>
    ''' <value>The curr repo cs.</value>
    Property _CurrRepoCS() As String
        Get
            Return CurrRepoCS
        End Get
        Set(ByVal value As String)
            CurrRepoCS = value
        End Set
    End Property

    ''' <summary>
    ''' Gets or sets the encrypt pw.
    ''' </summary>
    ''' <value>The encrypt pw.</value>
    Property _EncryptPW() As String
        Get
            Return EncryptPW
        End Get
        Set(ByVal value As String)
            EncryptPW = value
        End Set
    End Property
    ''' <summary>
    ''' Gets or sets the active unique identifier.
    ''' </summary>
    ''' <value>The active unique identifier.</value>
    Property _ActiveGuid() As Guid
        Get
            Return ActiveGuid
        End Get
        Set(ByVal value As Guid)
            ActiveGuid = value
        End Set
    End Property
    ''' <summary>
    ''' Gets or sets the secure identifier.
    ''' </summary>
    ''' <value>The secure identifier.</value>
    Public Property _SecureID() As Integer
        Get
            Return gSecureID
        End Get
        Set(ByVal value As Integer)
            gSecureID = value
        End Set
    End Property
    ''' <summary>
    ''' Gets or sets the company identifier.
    ''' </summary>
    ''' <value>The company identifier.</value>
    Property _CompanyID() As String
        Get
            Return CompanyID
        End Get
        Set(ByVal value As String)
            CompanyID = value
        End Set
    End Property
    ''' <summary>
    ''' Gets or sets the repo identifier.
    ''' </summary>
    ''' <value>The repo identifier.</value>
    Property _RepoID() As String
        Get
            Return RepoID
        End Get
        Set(ByVal value As String)
            RepoID = value
        End Set
    End Property

    ''' <summary>
    ''' Gets or sets the user identifier.
    ''' </summary>
    ''' <value>The user identifier.</value>
    Property _UserID() As String
        Get
            Return UserID
        End Get
        Set(ByVal value As String)
            UserID = value
        End Set
    End Property

    'Public Sub ExecuteSQL(ByRef MySql As String)

    '    AddHandler ProxySearch.ExecuteSqlNewConnSecureCompleted, AddressOf client_ExecuteSql
    '    ProxySearch.ExecuteSqlNewConnSecure(MySql)
    'End Sub

    ''' <summary>
    ''' The b updating log
    ''' </summary>
    Private bUpdatingLog As Boolean = False

    ''' <summary>
    ''' RSQ = RemoveSingleQuote
    ''' </summary>
    ''' <param name="tVal">Value to be checked for single quotes</param>
    Private Sub RSQ(ByRef tVal As String)
        Dim S As String = tVal
        If InStr(S, "'") = 0 Then
            Return
        End If
        S = S.Replace("''", "'")
        tVal = S
    End Sub

    ''' <summary>
    ''' REPLSQ - Replace single quotes with the reverse tick "`" char.
    ''' </summary>
    ''' <param name="tVal">The t value.</param>
    Private Sub REPLSQ(ByRef tVal As String)
        Dim S As String = tVal
        If InStr(S, "'") = 0 Then
            Return
        End If
        S = S.Replace("''", "`")
        tVal = S
    End Sub

    ''' <summary>
    ''' Users the parm insert update.
    ''' </summary>
    ''' <param name="ParmName">Name of the parm.</param>
    ''' <param name="UserID">The user identifier.</param>
    ''' <param name="ParmVal">The parm value.</param>
    Public Sub UserParmInsertUpdate(ByVal ParmName As String, ByVal UserID As String, ByVal ParmVal As String)
        Dim RC As Boolean = False
        'Dim proxy As New SVCSearch.Service1Client
        'AddHandler ProxySearch.UserParmInsertUpdateCompleted, AddressOf client_UserParmInsertUpdate
        ProxySearch.UserParmInsertUpdate(gSecureID, ParmName, UserID, ParmVal, RC)
        client_UserParmInsertUpdate(RC, ParmName, ParmVal)
    End Sub

    'Private Sub client_UserParmInsertUpdate(ByVal sender As Object, ByVal e As ProxySearch.UserParmInsertUpdateCompletedEventArgs)
    ''' <summary>
    ''' Clients the user parm insert update.
    ''' </summary>
    ''' <param name="RC">if set to <c>true</c> [rc].</param>
    ''' <param name="ParmName">Name of the parm.</param>
    ''' <param name="ParmVal">The parm value.</param>
    Private Sub client_UserParmInsertUpdate(RC As Boolean, ParmName As String, ParmVal As String)
        If RC Then
        Else
            Console.WriteLine("Failed to add: " + ParmName + " / " + ParmVal)
        End If

    End Sub

    ''' <summary>
    ''' Writes to log.
    ''' </summary>
    ''' <param name="LogName">Name of the log.</param>
    ''' <param name="LoggedMessage">The logged message.</param>
    ''' <param name="Severity">The severity.</param>
    Public Sub WriteToLog(ByVal LogName As String, ByVal LoggedMessage As String, ByVal Severity As String)

        If LoggedMessage.Trim.Length > 4000 Then
            LoggedMessage = LoggedMessage.Substring(1, 3999)
        End If

        Dim EntryUserID As String = gCurrUserGuidID
        RSQ(LogName)
        RSQ(LoggedMessage)
        RSQ(EntryUserID)
        RSQ(Severity)

        If Severity.Trim.Length = 0 Then
            Severity = "ERROR"
        End If
        Dim S As String = ""
        S += " INSERT INTO [ErrorLogs]" + vbCrLf
        S += " ([LogName]" + vbCrLf
        S += " ,[LoggedMessage]" + vbCrLf
        S += " ,[EntryUserID]" + vbCrLf
        S += " ,Severity)" + vbCrLf
        S += " VALUES( " + vbCrLf
        S += " '" + LogName + "'" + vbCrLf
        S += " ,'" + LoggedMessage + "'" + vbCrLf
        S += " ,'" + EntryUserID + "'" + vbCrLf
        S += " ,'" + Severity + "'" + vbCrLf
        S += " )"

        ExecuteSql(gSecureID, S)

    End Sub


    ''' <summary>
    ''' Adds the data table email.
    ''' </summary>
    ''' <param name="EmailData">The email data.</param>
    Public Sub addDataTableEmail(EmailData As Dictionary(Of String, String))

        Dim drNewRow As System.Data.DataRow = gEmailDT.NewRow
        Dim I As Integer = 0
        For Each sKey As String In EmailData.Keys
            Dim tVal As String = EmailData(sKey)
            drNewRow.Item(sKey) = tVal
            I += 1
        Next
        If I > 0 Then
            gEmailDT.Rows.Add(drNewRow)
            gEmailDT.AcceptChanges()
        End If

    End Sub
    ''' <summary>
    ''' Initializes the data table email.
    ''' </summary>
    Public Sub initDataTableEmail()

        gEmailDT.Columns.Add("AllRecipients", GetType(String))
        gEmailDT.Columns.Add("Bcc", GetType(String))
        gEmailDT.Columns.Add("Body", GetType(String))
        gEmailDT.Columns.Add("CC", GetType(String))
        gEmailDT.Columns.Add("CreationTime", GetType(String))
        gEmailDT.Columns.Add("EmailGuid", GetType(String))
        gEmailDT.Columns.Add("FoundInAttach", GetType(String))
        gEmailDT.Columns.Add("isPublic", GetType(String))
        gEmailDT.Columns.Add("MsgSize", GetType(String))
        gEmailDT.Columns.Add("NbrAttachments", GetType(String))
        gEmailDT.Columns.Add("OriginalFolder", GetType(String))
        gEmailDT.Columns.Add("RANK", GetType(String))
        gEmailDT.Columns.Add("ReceivedByName", GetType(String))
        gEmailDT.Columns.Add("ReceivedTime", GetType(String))
        gEmailDT.Columns.Add("RepoSvrName", GetType(String))
        gEmailDT.Columns.Add("RetentionExpirationDate", GetType(String))
        gEmailDT.Columns.Add("RID", GetType(String))
        gEmailDT.Columns.Add("ROWID", GetType(String))
        gEmailDT.Columns.Add("SenderEmailAddress", GetType(String))
        gEmailDT.Columns.Add("SenderName", GetType(String))
        gEmailDT.Columns.Add("SentOn", GetType(String))
        gEmailDT.Columns.Add("SentTO", GetType(String))
        gEmailDT.Columns.Add("ShortSubj", GetType(String))
        gEmailDT.Columns.Add("SourceTypeCode", GetType(String))
        gEmailDT.Columns.Add("SUBJECT", GetType(String))
        gEmailDT.Columns.Add("UserID", GetType(String))

    End Sub

    ''' <summary>
    ''' Adds the data table email attachment.
    ''' </summary>
    ''' <param name="EmailData">The email data.</param>
    Public Sub addDataTableEmailAttachment(EmailData As Dictionary(Of String, String))

        Dim drNewRow As System.Data.DataRow = gEmailAttachDT.NewRow
        Dim I As Integer = 0
        For Each sKey As String In EmailData.Keys
            Dim tVal As String = EmailData(sKey)
            drNewRow.Item(sKey) = tVal
            I += 1
        Next
        If I > 0 Then
            gEmailAttachDT.Rows.Add(drNewRow)
            gEmailAttachDT.AcceptChanges()
        End If

    End Sub

    ''' <summary>
    ''' Initializes the data table email attachment.
    ''' </summary>
    Public Sub initDataTableEmailAttachment()

        gEmailAttachDT.Columns.Add("AttachmentName", GetType(String))
        gEmailAttachDT.Columns.Add("RowID", GetType(String))
        gEmailAttachDT.Columns.Add("EmailGuid", GetType(String))

    End Sub
End Module
