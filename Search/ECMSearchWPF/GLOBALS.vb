Module GLOBALS

    Public ProxySearch As New SVCSearch.Service1Client
    'Public ProxyGateway = New SVCGateway.Service1Client

    Public gContentCurrMaxSeq As Int32 = 0
    Public gEmailCurrMaxSeq As Int32 = 0
    Public gContentLastMaxSeq As Int32 = 0
    Public gEmailLastMaxSeq As Int32 = 0

    Public gDebug As Boolean = False
    Public gListOfContentRows As String = ""
    Public gListOEmailRows As String = ""
    Public gDownloadDIR As String = ""
    Public gSelectedGrid As String = ""
    Public gCUSTID As String = ""
    Public gSVRNAME As String = ""
    Public gDBNAME As String = ""
    Public gINSTANCENAME As String = ""
    Public gRecNbr As Integer = -1
    Public gSecureID As Integer = -1

    Public gCSRepo As String = ""
    Public gCSThesaurus As String = ""
    Public gCSHive As String = ""
    Public gCSDMALicense As String = ""
    Public gCSGateWay As String = ""
    Public gCSTDR As String = ""
    Public gCSKBase As String = ""


    Public gRowID As String = ""
    Public gIntRowID As Integer = -1

    Public gSVCGateway_Endpoint As String = ""
    Public gSVCSearch_Endpoint As String = ""
    Public gSVCDownload_Endpoint As String = ""

    Public gEmailAttachDT As New System.Data.DataTable
    Public gEmailDT As New System.Data.DataTable
    Public gListOfEmails As New List(Of SVCSearch.DS_EMAIL)
    Public gListOfContent As New List(Of SVCSearch.DS_CONTENT)
    Public gListOfEmailsTemp As New System.Collections.Generic.List(Of SVCSearch.DS_EMAIL)
    Public gListOfContentTemp As New System.Collections.Generic.List(Of SVCSearch.DS_CONTENT)

    Public RowsToFetch As String = System.Configuration.ConfigurationManager.AppSettings("RowsToFetch")
    Public UseRowsToFetch As String = System.Configuration.ConfigurationManager.AppSettings("UseRowsToFetch")

    Public _SqlSvrVersion As String = String.Empty
    Public _NbrOfSeats As String = String.Empty
    Public _RegisteredUsers As String = String.Empty
    Public _CustomerID As String = String.Empty
    Public _MaxClients As String = String.Empty
    Public _LicenseValid As String = String.Empty
    Public _MaintExpire As String = String.Empty
    Public _LicenseExpire As String = String.Empty
    Public _NbrRegisteredMachines As String = String.Empty

    Public UserID As String = String.Empty
    Public UserGuid As String = String.Empty
    Public CompanyID As String = String.Empty
    Public MachineID As String = String.Empty
    Public RepoID As String = String.Empty
    Public ActiveGuid As Guid
    Public EncryptPW As String = ""
    Public CurrRepoCS As String = ""
    Public SessionGuid As Guid
    Public isAdmin As Boolean = False
    Public isSuperAdmin As Boolean = False
    Public isGlobalSearcher As Boolean = False
    Public _ApplyRecalledSearch As Boolean = False
    Public _dictMasterSearch As New Dictionary(Of String, String)
    Public _AffinityDelay As Integer = 0
    Public gLocalDebug As Integer = 0
    Public gContractID As String = ""
    Public gSearchEndPoint As String = String.Empty
    Public gGatewayEndPoint As String = String.Empty
    Public gDownloadEndPoint As String = String.Empty
    Public gENCGWCS As String = String.Empty
    Public gCurrSessionGuid As String = ""
    Public gCurrLogin As String = ""

    Property SVRNAME() As String
        Get
            Return gSVRNAME
        End Get
        Set(ByVal value As String)
            gSVRNAME = value
        End Set
    End Property

    Property DBNAME() As String
        Get
            Return gDBNAME
        End Get
        Set(ByVal value As String)
            gDBNAME = value
        End Set
    End Property

    Property INSTANCENAME() As String
        Get
            Return gINSTANCENAME
        End Get
        Set(ByVal value As String)
            gINSTANCENAME = value
        End Set
    End Property

    Property NCGWCS() As String
        Get
            Return gENCGWCS
        End Get
        Set(ByVal value As String)
            gENCGWCS = value
        End Set
    End Property
    Property GatewayEndPoint() As String
        Get
            Return gGatewayEndPoint
        End Get
        Set(ByVal value As String)
            gGatewayEndPoint = value
        End Set
    End Property
    Property DownloadEndPoint() As String
        Get
            Return gDownloadEndPoint
        End Get
        Set(ByVal value As String)
            gDownloadEndPoint = value
        End Set
    End Property
    Property ContractID() As String
        Get
            Return gContractID
        End Get
        Set(ByVal value As String)
            gContractID = value
        End Set
    End Property

    Property LocalDebug() As Boolean
        Get
            Return gLocalDebug
        End Get
        Set(ByVal value As Boolean)
            gLocalDebug = value
        End Set
    End Property

    Property SearchEndPoint() As String
        Get
            Return gSearchEndPoint
        End Get
        Set(ByVal value As String)
            gSearchEndPoint = value
        End Set
    End Property

    Property AffinityDelay() As Integer
        Get
            Return _AffinityDelay
        End Get
        Set(ByVal value As Integer)
            _AffinityDelay = value
        End Set
    End Property
    Property ApplyRecalledSearch() As Boolean
        Get
            Return _ApplyRecalledSearch
        End Get
        Set(ByVal value As Boolean)
            _ApplyRecalledSearch = value
        End Set
    End Property
    Property NbrRegisteredMachines() As String
        Get
            Return _NbrRegisteredMachines
        End Get
        Set(ByVal value As String)
            _NbrRegisteredMachines = value
        End Set
    End Property
    Property SqlSvrVersion() As String
        Get
            Return _SqlSvrVersion
        End Get
        Set(ByVal value As String)
            _SqlSvrVersion = value
        End Set
    End Property
    Property NbrOfSeats() As String
        Get
            Return _NbrOfSeats
        End Get
        Set(ByVal value As String)
            _NbrOfSeats = value
        End Set
    End Property
    Property RegisteredUsers() As String
        Get
            Return _RegisteredUsers
        End Get
        Set(ByVal value As String)
            _RegisteredUsers = value
        End Set
    End Property
    Property CustID() As String
        Get
            Return gCUSTID
        End Get
        Set(ByVal value As String)
            gCUSTID = value
        End Set
    End Property
    Property CustomerID() As String
        Get
            Return _CustomerID
        End Get
        Set(ByVal value As String)
            _CustomerID = value
        End Set
    End Property
    Property MaxClients() As String
        Get
            Return _MaxClients
        End Get
        Set(ByVal value As String)
            _MaxClients = value
        End Set
    End Property
    Property LicenseValid() As String
        Get
            Return _LicenseValid
        End Get
        Set(ByVal value As String)
            _LicenseValid = value
        End Set
    End Property
    Property MaintExpire() As String
        Get
            Return _MaintExpire
        End Get
        Set(ByVal value As String)
            _MaintExpire = value
        End Set
    End Property
    Property LicenseExpire() As String
        Get
            Return _LicenseExpire
        End Get
        Set(ByVal value As String)
            _LicenseExpire = value
        End Set
    End Property

    Property _MachineID() As String
        Get
            Return MachineID
        End Get
        Set(ByVal value As String)
            MachineID = value
        End Set
    End Property

    Sub SearchDictAdd(ByVal sKey As String, ByVal sVal As String)
        If _dictMasterSearch.ContainsKey(sKey) Then
            _dictMasterSearch.Item(sKey) = sVal
        Else
            _dictMasterSearch.Add(sKey, sVal)
        End If
    End Sub

    Property dictMasterSearch() As Dictionary(Of String, String)
        Get
            Return _dictMasterSearch
        End Get
        Set(ByVal value As Dictionary(Of String, String))
            _dictMasterSearch = _dictMasterSearch
        End Set
    End Property

    Property _isAdmin() As Boolean
        Get
            Return isAdmin
        End Get
        Set(ByVal value As Boolean)
            isAdmin = value
        End Set
    End Property

    Property _isSuperAdmin() As Boolean
        Get
            Return isSuperAdmin
        End Get
        Set(ByVal value As Boolean)
            isSuperAdmin = value
        End Set
    End Property
    Property _isGlobalSearcher() As Boolean
        Get
            Return isGlobalSearcher
        End Get
        Set(ByVal value As Boolean)
            isGlobalSearcher = value
        End Set
    End Property

    Property _UserGuid() As String
        Get
            Return UserGuid
        End Get
        Set(ByVal value As String)
            UserGuid = value
        End Set
    End Property

    Property _SessionGuid() As Guid
        Get
            Return SessionGuid
        End Get
        Set(ByVal value As Guid)
            SessionGuid = value
        End Set
    End Property

    Property _CurrRepoCS() As String
        Get
            Return CurrRepoCS
        End Get
        Set(ByVal value As String)
            CurrRepoCS = value
        End Set
    End Property

    Property _EncryptPW() As String
        Get
            Return EncryptPW
        End Get
        Set(ByVal value As String)
            EncryptPW = value
        End Set
    End Property
    Property _ActiveGuid() As Guid
        Get
            Return ActiveGuid
        End Get
        Set(ByVal value As Guid)
            ActiveGuid = value
        End Set
    End Property
    Public Property _SecureID() As Integer
        Get
            Return gSecureID
        End Get
        Set(ByVal value As Integer)
            gSecureID = value
        End Set
    End Property
    Property _CompanyID() As String
        Get
            Return CompanyID
        End Get
        Set(ByVal value As String)
            CompanyID = value
        End Set
    End Property
    Property _RepoID() As String
        Get
            Return RepoID
        End Get
        Set(ByVal value As String)
            RepoID = value
        End Set
    End Property

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

    Private bUpdatingLog As Boolean = False

    ''' <summary>
    ''' RSQ = RemoveSingleQuote
    ''' </summary>
    ''' <param name="tVal">Value to be checked for single quotes</param>
    ''' <remarks></remarks>
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
    ''' <param name="tVal"></param>
    ''' <remarks></remarks>
    Private Sub REPLSQ(ByRef tVal As String)
        Dim S As String = tVal
        If InStr(S, "'") = 0 Then
            Return
        End If
        S = S.Replace("''", "`")
        tVal = S
    End Sub

    Public Sub UserParmInsertUpdate(ByVal ParmName As String, ByVal UserID As String, ByVal ParmVal As String)
        Dim RC As Boolean = False
        'Dim proxy As New SVCSearch.Service1Client
        'AddHandler ProxySearch.UserParmInsertUpdateCompleted, AddressOf client_UserParmInsertUpdate
        ProxySearch.UserParmInsertUpdate(gSecureID, ParmName, UserID, ParmVal, RC)
        client_UserParmInsertUpdate(RC, ParmName, ParmVal)
    End Sub

    'Private Sub client_UserParmInsertUpdate(ByVal sender As Object, ByVal e As ProxySearch.UserParmInsertUpdateCompletedEventArgs)
    Private Sub client_UserParmInsertUpdate(RC As Boolean, ParmName As String, ParmVal As String)
        If RC Then
        Else
            Console.WriteLine("Failed to add: " + ParmName + " / " + ParmVal)
        End If

    End Sub

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
        S += " INSERT INTO [ErrorLogs]" + Environment.NewLine
        S += " ([LogName]" + Environment.NewLine
        S += " ,[LoggedMessage]" + Environment.NewLine
        S += " ,[EntryUserID]" + Environment.NewLine
        S += " ,Severity)" + Environment.NewLine
        S += " VALUES( " + Environment.NewLine
        S += " '" + LogName + "'" + Environment.NewLine
        S += " ,'" + LoggedMessage + "'" + Environment.NewLine
        S += " ,'" + EntryUserID + "'" + Environment.NewLine
        S += " ,'" + Severity + "'" + Environment.NewLine
        S += " )"

        ExecuteSql(gSecureID, S)

    End Sub


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

    Public Sub initDataTableEmailAttachment()

        gEmailAttachDT.Columns.Add("AttachmentName", GetType(String))
        gEmailAttachDT.Columns.Add("RowID", GetType(String))
        gEmailAttachDT.Columns.Add("EmailGuid", GetType(String))

    End Sub
End Module
