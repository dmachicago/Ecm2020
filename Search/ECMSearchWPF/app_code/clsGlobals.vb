' ***********************************************************************
' Assembly         : ECMSearchWPF
' Author           : wdale
' Created          : 06-28-2020
'
' Last Modified By : wdale
' Last Modified On : 06-28-2020
' ***********************************************************************
' <copyright file="clsGlobals.vb" company="D. Miller and Associates, Limited">
'     Copyright @ DMA Ltd 2020 all rights reserved.
' </copyright>
' <summary></summary>
' ***********************************************************************on
Imports System.Threading

''' <summary>
''' Class clsGlobals.
''' </summary>
Public Class clsGlobals
    ''' <summary>
    ''' The lt
    ''' </summary>
    Dim LT As String = ""

    'Dim proxy As New SVCSearch.Service1Client
    ''' <summary>
    ''' The TGT end point
    ''' </summary>
    Dim TgtEndPoint = ""

    ''' <summary>
    ''' The g secure identifier
    ''' </summary>
    Public gSecureID As String = -1

    ''' <summary>
    ''' Initializes a new instance of the <see cref="clsGlobals"/> class.
    ''' </summary>
    Sub New()
        gSecureID = _SecureID
    End Sub

    ''' <summary>
    ''' Gets the user variables.
    ''' </summary>
    ''' <param name="UserID">The user identifier.</param>
    Sub getUserVariables(ByVal UserID As String)

        getUserGuidID(UserID)

    End Sub

    ''' <summary>
    ''' Gets the system variables.
    ''' </summary>
    ''' <param name="iSecureID">The i secure identifier.</param>
    Sub getSystemVariables(ByVal iSecureID As Integer)
        gSecureID = _SecureID
        getLicense()
    End Sub

    ''' <summary>
    ''' Gets the license.
    ''' </summary>
    Public Sub getLicense()

        Dim RC As Boolean = False
        Dim RetMsg As String = ""

        'AddHandler ProxySearch.GetXrtCompleted, AddressOf StepGetLicense
        ''EP.setSearchSvcEndPoint(proxy)
        Dim S As String = ProxySearch.GetXrt(gSecureID, RC, RetMsg)
        StepGetLicense(S)
    End Sub

    ''' <summary>
    ''' Steps the get license.
    ''' </summary>
    ''' <param name="S">The s.</param>
    Sub StepGetLicense(S As String)
        If S.Length > 0 Then
            gEncLicense = S
        Else
            gEncLicense = ""
        End If

        ''RemoveHandler ProxySearch.GetXrtCompleted, AddressOf StepGetLicense
        'AddHandler ProxySearch.ParseLicDictionaryCompleted, AddressOf StepParseLicDictionary
        ''EP.setSearchSvcEndPoint(proxy)
        ProxySearch.ParseLicDictionary(gSecureID, gEncLicense, gLicenseItems)
        StepParseLicDictionary(gLicenseItems)
    End Sub
    ''' <summary>
    ''' Steps the parse lic dictionary.
    ''' </summary>
    ''' <param name="tDict">The t dictionary.</param>
    Sub StepParseLicDictionary(tDict As Dictionary(Of String, String))
        If tDict.Keys.Count > 0 Then
            gLicenseItems = tDict
        Else
            gMaxClients = -1
        End If

        ''RemoveHandler ProxySearch.ParseLicDictionaryCompleted, AddressOf StepParseLicDictionary

        ProcessDates()
        LT = gEncLicense
        getLicenseVars()
        SetDateFormats()
        getSqlServerVersion()

        getAttachedMachineName()
        GetNbrMachineAll()
        getLocalMachineIpAddr()

        isLicenseValid(gServerValText, gInstanceValText)

        getNbrOfRegisteredUsers()

        GetNbrMachine(gSecureID, gMachineID)

        GetNbrMachineAll()

        getMaxClients()

        LicenseType()

    End Sub
    ''' <summary>
    ''' Gets the name of the attached machine.
    ''' </summary>
    Public Sub getAttachedMachineName()
        If _SecureID > 0 Then
            'AddHandler ProxySearch.getAttachedMachineNameCompleted, AddressOf client_getAttachedMachineName
            ''EP.setSearchSvcEndPoint(proxy)
            Dim S As String = ProxySearch.getAttachedMachineName(_SecureID)
            client_getAttachedMachineName(S)
        End If
    End Sub
    ''' <summary>
    ''' Clients the name of the get attached machine.
    ''' </summary>
    ''' <param name="S">The s.</param>
    Sub client_getAttachedMachineName(S As String)
        If S.Length > 0 Then
            gAttachedMachineName = S
            gMachineID = S
        Else
            gAttachedMachineName = "Unknown"
            gMachineID = "Unknown"
        End If
        ''RemoveHandler ProxySearch.getAttachedMachineNameCompleted, AddressOf client_getAttachedMachineName
    End Sub

    ''' <summary>
    ''' Licenses the type.
    ''' </summary>
    Public Sub LicenseType()

        Dim RC As Boolean = False
        Dim RetMsg As String = ""

        'AddHandler ProxySearch.LicenseTypeCompleted, AddressOf step_LicenseType
        ''EP.setSearchSvcEndPoint(proxy)
        Dim I As Integer = ProxySearch.getMaxClients(gSecureID, RC, RetMsg)
    End Sub
    ''' <summary>
    ''' Steps the type of the license.
    ''' </summary>
    ''' <param name="I">The i.</param>
    Sub step_LicenseType(I As Integer)
        gLicenseType = I
    End Sub

    ''' <summary>
    ''' Gets the maximum clients.
    ''' </summary>
    Public Sub getMaxClients()

        Dim RC As Boolean = False
        Dim RetMsg As String = ""

        'AddHandler ProxySearch.getMaxClientsCompleted, AddressOf step_getMaxClients
        ''EP.setSearchSvcEndPoint(proxy)
        gMaxClients = ProxySearch.getMaxClients(gSecureID, RC, RetMsg)
    End Sub
    'Sub step_getMaxClients(ByVal sender As Object, ByVal e As SVCSearch.getMaxClientsCompletedEventArgs)
    '    If RC Then
    '        gMaxClients = e.Result
    '    Else
    '        gMaxClients = -1
    '    End If
    '    MaxClients = gMaxClients.ToString
    '    'RemoveHandler ProxySearch.getMaxClientsCompleted, AddressOf step_getMaxClients
    'End Sub

    ''' <summary>
    ''' Gets the NBR of registered users.
    ''' </summary>
    Public Sub getNbrOfRegisteredUsers()

        'AddHandler ProxySearch.GetNbrUsersCompleted, AddressOf step_CurrNbrOfUsers
        ''EP.setSearchSvcEndPoint(proxy)
        gNbrOfRegisteredUsers = ProxySearch.GetNbrUsers(gSecureID)
        RegisteredUsers = gNbrOfRegisteredUsers
    End Sub
    'Sub step_CurrNbrOfUsers(ByVal sender As Object, ByVal e As SVCSearch.GetNbrUsersCompletedEventArgs)
    '    If RC Then
    '        gNbrOfRegisteredUsers = e.Result
    '    Else
    '        gNbrOfUsers = -1
    '    End If
    '    RegisteredUsers = gNbrOfUsers.ToString
    '    'RemoveHandler ProxySearch.GetNbrUsersCompleted, AddressOf step_CurrNbrOfUsers
    'End Sub

    ''' <summary>
    ''' Sets the date formats.
    ''' </summary>
    Sub SetDateFormats()

        'Dim dateString, format As String
        'Dim result As Date

        Dim Info As System.Globalization.DateTimeFormatInfo
        Info = System.Globalization.CultureInfo.CurrentUICulture.DateTimeFormat

        'Dim S As String = ""
        ''gDateSeparator = Info.DateSeparator
        ''gTimeSeparator = Info.TimeSeparator
        gShortDatePattern = Info.ShortDatePattern
        gShortTimePattern = Info.ShortTimePattern

        Dim Ch As String = ""
        For i As Integer = 1 To gShortDatePattern.Length
            Ch = gShortDatePattern.Substring(i, 1)
            If "/-.".Contains(Ch) Then
                gDateSeparator = Ch
                Exit For
            End If
        Next
        For i As Integer = 1 To gShortTimePattern.Length
            Ch = gShortTimePattern.Substring(i, 1)
            If ":/-.".Contains(Ch) Then
                gTimeSeparator = Ch
                Exit For
            End If
        Next

    End Sub
    ''' <summary>
    ''' Gets the user unique identifier identifier.
    ''' </summary>
    ''' <param name="UserID">The user identifier.</param>
    Public Sub getUserGuidID(ByVal UserID As String)

        'AddHandler ProxySearch.getUserGuidIDCompleted, AddressOf step_getUserGuidID
        ''EP.setSearchSvcEndPoint(proxy)
        Dim S As String = ProxySearch.getUserGuidID(gSecureID, UserID)
        step_getUserGuidID(S)
    End Sub
    ''' <summary>
    ''' Steps the get user unique identifier identifier.
    ''' </summary>
    ''' <param name="S">The s.</param>
    Sub step_getUserGuidID(S As String)

        If S.Length > 0 Then
            gCurrUserGuidID = S
        Else
            gCurrUserGuidID = Nothing
        End If

        ''RemoveHandler ProxySearch.GetNbrUsersCompleted, AddressOf step_CurrNbrOfUsers

        Dim SETGV As New clsSetGlobalVars(gSecureID)
        SETGV.setUserVariables(gCurrUserGuidID)
        SETGV = Nothing

    End Sub

    ''' <summary>
    ''' Processes the dates.
    ''' </summary>
    Public Sub ProcessDates()

        'AddHandler ProxySearch.ProcessDatesCompleted, AddressOf step_ProcessDates
        ''EP.setSearchSvcEndPoint(proxy)
        Dim tDict As Dictionary(Of String, Date) = New Dictionary(Of String, Date)()
        tDict = ProxySearch.ProcessDates(gSecureID)
    End Sub
    ''' <summary>
    ''' Steps the process dates.
    ''' </summary>
    ''' <param name="tDict">The t dictionary.</param>
    Sub step_ProcessDates(tDict As Dictionary(Of String, Date))
        gProcessDates = tDict
    End Sub

    ''' <summary>
    ''' Gets the SQL server version.
    ''' </summary>
    Public Sub getSqlServerVersion()

        'AddHandler ProxySearch.getSqlServerVersionCompleted, AddressOf step_getSqlServerVersion
        ''EP.setSearchSvcEndPoint(proxy)
        gServerVersion = ProxySearch.getSqlServerVersion(gSecureID)
        SqlSvrVersion = gServerVersion.ToString
    End Sub
    'Sub step_getSqlServerVersion(ByVal sender As Object, ByVal e As SVCSearch.getSqlServerVersionCompletedEventArgs)
    '    If RC Then
    '        gServerVersion = e.Result
    '    Else
    '        gServerVersion = "Unknown"
    '    End If
    '    SqlSvrVersion = gServerVersion.ToString
    '    'RemoveHandler ProxySearch.getSqlServerVersionCompleted, AddressOf step_getSqlServerVersion
    'End Sub

    ''' <summary>
    ''' Gets the NBR machine all.
    ''' </summary>
    Public Sub GetNbrMachineAll()

        'AddHandler ProxySearch.GetNbrMachineAllCompleted, AddressOf step_GetNbrMachineAll
        ''EP.setSearchSvcEndPoint(proxy)
        Dim II As Integer = ProxySearch.GetNbrMachineAll(gSecureID)
        step_GetNbrMachineAll(II)
    End Sub
    ''' <summary>
    ''' Steps the get NBR machine all.
    ''' </summary>
    ''' <param name="II">The ii.</param>
    Sub step_GetNbrMachineAll(II As Integer)
        If II > 0 Then
            gNumberOfRegisterdMachines = II
        Else
            gNumberOfRegisterdMachines = 0
        End If

        ''RemoveHandler ProxySearch.GetNbrMachineAllCompleted, AddressOf step_GetNbrMachineAll
    End Sub

    ''' <summary>
    ''' Gets the NBR machine.
    ''' </summary>
    ''' <param name="gSecureID">The g secure identifier.</param>
    ''' <param name="MachineName">Name of the machine.</param>
    Public Sub GetNbrMachine(ByRef gSecureID As String, ByVal MachineName As String)

        'AddHandler ProxySearch.GetNbrMachineCompleted, AddressOf step_GetNbrMachine
        ''EP.setSearchSvcEndPoint(proxy)
        gNumberOfRegisterdMachines = ProxySearch.GetNbrMachine(gSecureID, MachineName)
        NbrRegisteredMachines = gNumberOfRegisterdMachines.ToString
    End Sub

    'Sub step_GetNbrMachine(ByVal sender As Object, ByVal e As SVCSearch.GetNbrMachineCompletedEventArgs)
    '    If RC Then
    '        gNumberOfRegisterdMachines = e.Result
    '    Else
    '        gNumberOfRegisterdMachines = 0
    '    End If
    '    NbrRegisteredMachines = gNumberOfRegisterdMachines.ToString
    '    ''RemoveHandler ProxySearch.GetNbrMachineCompleted, AddressOf step_GetNbrMachine
    'End Sub

    ''' <summary>
    ''' A license MUST be matched to the server running SQL Server and the Instance Name of SQL Server housing the repository.
    ''' Without this match, the license is considered invalid.
    ''' </summary>
    ''' <param name="ServerValText">sets the value gServerValText</param>
    ''' <param name="InstanceValText">sets the value gInstanceValText</param>
    Public Sub isLicenseValid(ByRef ServerValText As String, ByRef InstanceValText As String)

        Dim RC As Boolean = False
        Dim RetMsg As String = ""

        'AddHandler ProxySearch.isLicenseLocatedOnAssignedMachineCompleted, AddressOf step_isLicenseValid
        ''EP.setSearchSvcEndPoint(proxy)
        Dim BB As Boolean = ProxySearch.isLicenseLocatedOnAssignedMachine(gSecureID, ServerValText, InstanceValText, RC, RetMsg)
        step_isLicenseValid(BB, ServerValText, InstanceValText)
    End Sub
    ''' <summary>
    ''' Steps the is license valid.
    ''' </summary>
    ''' <param name="BB">if set to <c>true</c> [bb].</param>
    ''' <param name="ServerValText">The server value text.</param>
    ''' <param name="InstanceValText">The instance value text.</param>
    Sub step_isLicenseValid(BB As Boolean, ServerValText As String, InstanceValText As String)
        If BB Then
            gServerValText = ServerValText
            gInstanceValText = InstanceValText
            gIsLicenseValid = BB
        Else
            gIsLicenseValid = False
        End If
        LicenseValid = gIsLicenseValid.ToString
        ''RemoveHandler ProxySearch.isLicenseLocatedOnAssignedMachineCompleted, AddressOf step_isLicenseValid
    End Sub

    ''' <summary>
    ''' Gets the license vars.
    ''' </summary>
    Sub getLicenseVars()
        Dim LOG As New clsLogMain
        Dim UTIL As New clsUtility
        Dim LL As Integer = 0
        Try
            gCustomerID = UTIL.ParseLic("txtCustID") : LL = 1
            gNbrOfUsers = CInt(UTIL.ParseLic("txtNbrSimlSeats")) : LL = 3
            gNbrOfSeats = CInt(UTIL.ParseLic("txtNbrSeats")) : LL = 4
            gMaintExpire = CDate(UTIL.ParseLic("dtMaintExpire")) : LL = 5
            Dim dtExpire As String = UTIL.ParseLic("dtExpire")
            Dim EndOfLicense As String = UTIL.ParseLic("EndOfLicense")

            CustomerID = gCustomerID
            MaintExpire = UTIL.ParseLic("dtMaintExpire")
            LicenseExpire = UTIL.ParseLic("dtExpire")
            NbrOfSeats = gNbrOfSeats.ToString
            RegisteredUsers = gNbrOfUsers.ToString
        Catch ex As Exception
            Console.WriteLine("ERROR: getLicenseVars - " + LL.ToString + " / " + ex.Message)
        Finally
            LOG = Nothing
            UTIL = Nothing
            GC.Collect()
        End Try
    End Sub

    ''' <summary>
    ''' Gets the global variables.
    ''' </summary>
    Sub getGlobalVariables()

        Step1gv()  'set the logged in user ID

    End Sub

    ''' <summary>
    ''' Step1gvs this instance.
    ''' </summary>
    Sub Step1gv()

        'AddHandler ProxySearch.getUserGuidIDCompleted, AddressOf Step1
        ''EP.setSearchSvcEndPoint(proxy)
        Dim S As String = ProxySearch.getUserGuidID(gSecureID, gCurrLoginID)
        Step1(S)
    End Sub
    ''' <summary>
    ''' Step1s the specified s.
    ''' </summary>
    ''' <param name="S">The s.</param>
    Sub Step1(S As String)
        If S.Length > 0 Then
            gCurrUserGuidID = S
            gLoggedInUser = gCurrLoginID
        Else
            gLoggedInUser = "Unknown"
            gCurrUserGuidID = "Unknown"
        End If
        ''RemoveHandler ProxySearch.getUserGuidIDCompleted, AddressOf Step1
        Step2gv()
    End Sub
    ''' <summary>
    ''' Step2gvs this instance.
    ''' </summary>
    Public Sub Step2gv()

        'AddHandler ProxySearch.getDBSIZEMBCompleted, AddressOf Step2
        ''EP.setSearchSvcEndPoint(proxy)
        Dim D As Double = ProxySearch.getDBSIZEMB(gSecureID)
        Step2(D)
    End Sub
    ''' <summary>
    ''' Step2s the specified d.
    ''' </summary>
    ''' <param name="D">The d.</param>
    Sub Step2(D As Double)
        gCurrDbSize = D
        ''RemoveHandler ProxySearch.getDBSIZEMBCompleted, AddressOf Step2
    End Sub

    ''' <summary>
    ''' Because of Silverlight's limited ability to process with speed and it's inability to process ASYNC calls, all existing
    ''' runtime parameters are loaded at once into a global/static dictionary and then called as needed.
    ''' </summary>
    ''' <param name="Userid">The userid.</param>
    Sub loadUserParms(ByVal Userid As String)

        'AddHandler ProxySearch.getUserParmsCompleted, AddressOf client_getUserParms
        ''EP.setSearchSvcEndPoint(proxy)
        Thread.Sleep(AffinityDelay)
        ProxySearch.getUserParms(_SecureID, Userid, gUserParms)
        'client_getUserParms()
    End Sub
    'Sub client_getUserParms()
    '    gUserParms = e.UserParms

    'End Sub
    ''' <summary>
    ''' Gets the user parameter.
    ''' </summary>
    ''' <param name="tKey">The t key.</param>
    ''' <returns>System.String.</returns>
    Function getUserParameter(ByVal tKey As String) As String
        Dim S As String = ""
        If gUserParms.ContainsKey(tKey) Then
            S = gUserParms.Item(tKey)
        Else
            S = ""
        End If
        Return S
    End Function
    ''' <summary>
    ''' There are many instances when a user runtime parameter will be added or modified. This will add or modify a user execution parameter.
    ''' </summary>
    ''' <param name="Userid">The userid.</param>
    Sub saveAllUserParm(ByVal Userid As String)
        For Each tKey As String In gUserParms.Keys
            Dim tVal As String = gUserParms.Item(tKey)
            saveUserParmToDb(gCurrUserGuidID, tKey, tVal)
        Next
    End Sub
    ''' <summary>
    ''' Saves the single user parm.
    ''' </summary>
    ''' <param name="Userid">The userid.</param>
    ''' <param name="tKey">The t key.</param>
    ''' <param name="tVal">The t value.</param>
    Sub saveSingleUserParm(ByVal Userid As String, ByVal tKey As String, ByVal tVal As String)
        saveUserParmToDb(gCurrUserGuidID, tKey, tVal)
    End Sub
    ''' <summary>
    ''' Saves the user parm to database.
    ''' </summary>
    ''' <param name="Userid">The userid.</param>
    ''' <param name="tKey">The t key.</param>
    ''' <param name="tValue">The t value.</param>
    Sub saveUserParmToDb(ByVal Userid As String, ByVal tKey As String, ByVal tValue As String)

        'AddHandler ProxySearch.SaveRunParmCompleted, AddressOf client_saveUserParmToDb
        ''EP.setSearchSvcEndPoint(proxy)
        Dim BB As Boolean = ProxySearch.SaveRunParm(gSecureID, Userid, tKey, tValue)
        client_saveUserParmToDb(BB, tKey, tValue)
    End Sub

    ''' <summary>
    ''' Clients the save user parm to database.
    ''' </summary>
    ''' <param name="BB">if set to <c>true</c> [bb].</param>
    ''' <param name="tKey">The t key.</param>
    ''' <param name="tValue">The t value.</param>
    Sub client_saveUserParmToDb(BB As Boolean, tKey As String, tValue As String)
        Dim LOG As New clsLogMain
        Dim UTIL As New clsUtility
        Dim B As Boolean = True
        If BB Then
            B = BB
            If Not B Then
                Dim K As String = tKey
                Dim V As String = tValue
                K = UTIL.RemoveSingleQuotes(K)
                V = UTIL.RemoveSingleQuotes(V)
                LOG.WriteToSqlLog("ERROR: failed to add/update userparameter - '" + K + "', value '" + V + "'.")
            End If
        Else
            gUserParms = Nothing
        End If
        LOG = Nothing
        UTIL = Nothing
        ''RemoveHandler ProxySearch.SaveRunParmCompleted, AddressOf client_saveUserParmToDb
    End Sub

    '*********************************************************************************
    ''' <summary>
    ''' Updates the ip.
    ''' </summary>
    ''' <param name="iCode">The i code.</param>
    Sub updateIp(ByVal iCode As Integer)
        Dim RC As Boolean = False

        'AddHandler ProxySearch.updateIpCompleted, AddressOf client_updateIp
        ''EP.setSearchSvcEndPoint(proxy)
        ProxySearch.updateIp(gSecureID, gMachineID, gIpAddr, 0, RC)
        client_updateIp(RC)
    End Sub
    ''' <summary>
    ''' Clients the update ip.
    ''' </summary>
    ''' <param name="RC">if set to <c>true</c> [rc].</param>
    Sub client_updateIp(RC As Boolean)
        Dim LOG As New clsLogMain
        Dim UTIL As New clsUtility
        If Not RC Then
            LOG.WriteToSqlLog("ERROR client_updateIp: Failed to update the associated IP address.")
        Else
            If RC Then
            Else
                LOG.WriteToSqlLog("ERROR 100 client_updateIp: Failed to update the associated IP address.")
            End If
        End If
        LOG = Nothing
        UTIL = Nothing
        ''RemoveHandler ProxySearch.updateIpCompleted, AddressOf client_updateIp
    End Sub
    '***********************************************************************
    ''' <summary>
    ''' Gets the local machine ip addr.
    ''' </summary>
    Public Sub getLocalMachineIpAddr()

        If gLocalMachineIP = "" Then

            'AddHandler ProxySearch.GetMachineIPCompleted, AddressOf client_GetMachineIPAddr
            ''EP.setSearchSvcEndPoint(proxy)
            gLocalMachineIP = ProxySearch.GetMachineIP(gSecureID)
        End If
    End Sub
    'Sub client_GetMachineIPAddr(ByVal sender As Object, ByVal e As SVCSearch.GetMachineIPCompletedEventArgs)
    '    If RC Then
    '        gLocalMachineIP = e.Result
    '    Else
    '        gLocalMachineIP = "NOT FOUND"
    '    End If
    '    'RemoveHandler ProxySearch.GetMachineIPCompleted, AddressOf client_GetMachineIPAddr
    'End Sub
    '***********************************************************************

    ''' <summary>
    ''' Allows an object to try to free resources and perform other cleanup operations before it is reclaimed by garbage collection.
    ''' </summary>
    Protected Overrides Sub Finalize()
        Try
        Finally
            MyBase.Finalize()      'define the destructor
            GC.Collect()
            GC.WaitForPendingFinalizers()
        End Try
    End Sub

    ''' <summary>
    ''' Sets the xx search SVC end point.
    ''' </summary>
    Private Sub setXXSearchSvcEndPoint()

        Dim CurrEndPoint As String = ProxySearch.Endpoint.Address.ToString

        If (SearchEndPoint.Length = 0) Then
            Return
        End If

        Dim ServiceUri As New Uri(SearchEndPoint)
        Dim EPA As New System.ServiceModel.EndpointAddress(ServiceUri)
        ProxySearch.Endpoint.Address = EPA
        GC.Collect()
        GC.WaitForPendingFinalizers()

    End Sub

End Class
