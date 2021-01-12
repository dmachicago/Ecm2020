' ***********************************************************************
' Assembly         : ECMSearchWPF
' Author           : wdale
' Created          : 12-15-2020
'
' Last Modified By : wdale
' Last Modified On : 12-15-2020
' ***********************************************************************
' <copyright file="frmInit.xaml.vb" company="D. Miller and Associates, Limited">
'     Copyright @ DMA Ltd 2020 all rights reserved.
' </copyright>
' <summary></summary>
' ***********************************************************************

Imports System.IO.IsolatedStorage
Imports System.Threading
Imports System.Windows
Imports System.Windows.Threading
Imports System.Windows.Media
Imports System.Windows.Media.Imaging
Imports System.Web
Imports System.ServiceModel.EndpointAddress
'Imports System.Data.SQLite
Imports ECMEncryption
Imports System.Data.SqlClient

''' <summary>
''' Class EcmInitPage.
''' Implements the <see cref="System.Windows.Controls.Page" />
''' Implements the <see cref="System.Windows.Markup.IComponentConnector" />
''' </summary>
''' <seealso cref="System.Windows.Controls.Page" />
''' <seealso cref="System.Windows.Markup.IComponentConnector" />
Class EcmInitPage


    'Dim SLConn As SQLiteConnection = New SQLiteConnection("Data Source=SDB\EcmSL.db;Version=3;New=True;")
    'Dim EP As New clsEndPoint
    ''' <summary>
    ''' The database
    ''' </summary>
    Dim DB As New clsDatabase

    ''' <summary>
    ''' The b populate combo busy
    ''' </summary>
    Dim bPopulateComboBusy As Boolean = False
    ''' <summary>
    ''' The curr proxy search endpoint
    ''' </summary>
    Dim CurrProxySearchEndpoint As String = ""

    ''' <summary>
    ''' The curr gateway
    ''' </summary>
    Dim currGateway As String = ""

    ''' <summary>
    ''' The enc
    ''' </summary>
    Dim ENC As New ECMEncrypt()
    ''' <summary>
    ''' The iso
    ''' </summary>
    Dim ISO As New clsIsolatedStorage
    ''' <summary>
    ''' The parm name
    ''' </summary>
    Dim ParmName As String = ""
    ''' <summary>
    ''' The curr session unique identifier
    ''' </summary>
    Dim CurrSessionGuid As Guid = Guid.NewGuid
    ''' <summary>
    ''' The login identifier
    ''' </summary>
    Dim LoginID As String = ""
    ''' <summary>
    ''' The company identifier
    ''' </summary>
    Dim CompanyID As String = ""
    ''' <summary>
    ''' The repo identifier
    ''' </summary>
    Dim RepoID As String = ""
    ''' <summary>
    ''' The user pw
    ''' </summary>
    Dim UserPW As String = ""

    ''' <summary>
    ''' The SVCFS endpoint
    ''' </summary>
    Dim SVCFS_Endpoint = ""
    ''' <summary>
    ''' The SVC gateway endpoint
    ''' </summary>
    Dim SVCGateway_Endpoint = ""
    ''' <summary>
    ''' The SVCCLC archive endpoint
    ''' </summary>
    Dim SVCCLCArchive_Endpoint = ""
    ''' <summary>
    ''' The SVC search endpoint
    ''' </summary>
    Dim SVCSearch_Endpoint = ""
    ''' <summary>
    ''' The sv CCLC download endpoint
    ''' </summary>
    Dim SVCclcDownload_Endpoint = ""

    ''' <summary>
    ''' The b attached
    ''' </summary>
    Dim bAttached As Boolean = False
    ''' <summary>
    ''' The s secure cs
    ''' </summary>
    Dim sSecureCS As String = ""

    ''' <summary>
    ''' The initialize proxy
    ''' </summary>
    Dim InitProxy As New SVCSearch.Service1Client
    'Dim ProxyGateway As New SVCGateway.Service1Client

    ''' <summary>
    ''' The gv
    ''' </summary>
    Dim GV As New clsGlobals
    ''' <summary>
    ''' The common
    ''' </summary>
    Dim COMMON As New clsCommonFunctions

    ''' <summary>
    ''' The i attempts
    ''' </summary>
    Dim iAttempts As Integer = 1
    'Dim UTIL As New clsUtility
    'Dim LOG As New clsLogMain
    'Dim DMA As New clsDma

    ''' <summary>
    ''' The curr NBR of users
    ''' </summary>
    Dim CurrNbrOfUsers As Integer = 0
    ''' <summary>
    ''' The curr NBR of machine
    ''' </summary>
    Dim CurrNbrOfMachine As Integer = 0

    ''' <summary>
    ''' The i exists
    ''' </summary>
    Dim iExists As Integer = -1
    ''' <summary>
    ''' The b license exists
    ''' </summary>
    Dim bLicenseExists As Boolean = False
    ''' <summary>
    ''' The ip
    ''' </summary>
    Dim IP As String = ""
    ''' <summary>
    ''' The maint expire
    ''' </summary>
    Dim MaintExpire As Date

    ''' <summary>
    ''' The list of repo is
    ''' </summary>
    Dim ListOfRepoIS As New List(Of String)

    ''' <summary>
    ''' The local debug on
    ''' </summary>
    Dim LocalDebugON As Boolean = False

    ''' <summary>
    ''' Initializes a new instance of the <see cref="EcmInitPage"/> class.
    ''' </summary>
    Public Sub New()

        InitializeComponent()

        Image01.Visibility = Visibility.Hidden

        'AddHandler ProxySearch.GetXrtCompleted, AddressOf Step0GetLicense
        'AddHandler ProxySearch.validateLoginCompleted, AddressOf client_validateLogin
        'AddHandler ProxySearch.getCustomerLogoTitleCompleted, AddressOf client_getCustomerLogoTitle

        LocalDebug = LocalDebugON

        If LocalDebugON = True Then
            lblCustom.Content = "DEBUG ON"
        End If

        PB.Visibility = Windows.Visibility.Collapsed

        getPersitData()

        Dim Enc1 As String = ENC.AES256EncryptString(txtLoginID.Text.Trim)
        Dim DeEnc1 As String = ENC.AES256EncryptString(Enc1)
        Dim Enc2 As String = ENC.AESEncryptPhrase(txtLoginID.Text.Trim, "")
        Dim DeEnc2 As String = ENC.AESDecryptPhrase(Enc2, "")
        Dim Enc3 As String = ENC.AES256EncryptString(txtLoginID.Text.Trim)
        Dim DeEnc3 As String = ENC.AES256EncryptString(Enc1)

        gCUSTID = System.Configuration.ConfigurationManager.AppSettings("CustomerID")
        gSVRNAME = System.Configuration.ConfigurationManager.AppSettings("SVRNAME")
        gDBNAME = System.Configuration.ConfigurationManager.AppSettings("DBNAME")
        gINSTANCENAME = System.Configuration.ConfigurationManager.AppSettings("INSTANCENAME")

        gCurrLoginID = txtLoginID.Text
        gCurrLogin = txtLoginID.Text

        lblEndpoint.Content = ProxySearch.Endpoint.Address.ToString

        ckAttach()

    End Sub


    ''' <summary>
    ''' Gets the secure identifier.
    ''' </summary>
    Sub getSecureID()

        Dim sid As Integer = ProxySearch.xGetXrtID(gCUSTID, gSVRNAME, gDBNAME, gINSTANCENAME)
        gSecureID = sid

    End Sub

    ''' <summary>
    ''' Gets the name of the server instance.
    ''' </summary>
    Sub getServerInstanceName()
        If Not bAttached Then
            Return
        End If

        'AddHandler ProxySearch.getServerInstanceNameCompleted, AddressOf client_getServerInstanceName
        'EP.setSearchSvcEndPoint(proxy)
        Thread.Sleep(AffinityDelay)
        Dim S As String = ProxySearch.getServerInstanceName(gSecureID)
        client_getServerInstanceName(S)
    End Sub

    ''' <summary>
    ''' Clients the name of the get server instance.
    ''' </summary>
    ''' <param name="s">The s.</param>
    Sub client_getServerInstanceName(s As String)
        If s.Length > 0 Then
            gServerInstanceName = s
            lblServerInstanceName.Content = s
        Else
            gServerInstanceName = "Unknown"
        End If
        getServerMachineName()
    End Sub
    ''' <summary>
    ''' Gets the name of the server machine.
    ''' </summary>
    Sub getServerMachineName()
        If Not bAttached Then
            Return
        End If

        'AddHandler ProxySearch.getServerMachineNameCompleted, AddressOf client_getServerMachineName
        'EP.setSearchSvcEndPoint(proxy)
        Dim S As String = ProxySearch.getServerMachineName(gSecureID)
        client_getServerMachineName(S)
    End Sub
    ''' <summary>
    ''' Clients the name of the get server machine.
    ''' </summary>
    ''' <param name="S">The s.</param>
    Sub client_getServerMachineName(S As String)
        If S.Length > 0 Then
            gServerMachineName = S
            lblServerMachineName.Content = S
        Else
            gServerMachineName = "Unknown"
            lblServerMachineName.Content = "Unknown"
        End If
        getUserGuidID()
    End Sub

    ''' <summary>
    ''' Gets the user unique identifier identifier.
    ''' </summary>
    Sub getUserGuidID()
        If Not bAttached Then
            Return
        End If
        If gCurrLoginID.Length = 0 Then
            gCurrUserGuidID = "Unknown:" + Now.ToString
        End If
        Dim S As String = ProxySearch.getUserGuidID(gSecureID, gCurrLoginID)
        client_getUserGuidID(S)
    End Sub
    ''' <summary>
    ''' Clients the get user unique identifier identifier.
    ''' </summary>
    ''' <param name="S">The s.</param>
    Sub client_getUserGuidID(S As String)
        If S.Length > 0 Then
            gCurrUserGuidID = S
            lblCurrUserGuidID.Content = S
        Else
            gCurrUserGuidID = "Unknown:" + Now.ToString
            lblCurrUserGuidID.Content = "Unknown:" + Now.ToString
        End If
        GV.getAttachedMachineName()

        ''RemoveHandler ProxySearch.getServerInstanceNameCompleted, AddressOf client_getServerInstanceName
        ''RemoveHandler ProxySearch.getServerMachineNameCompleted, AddressOf client_getServerMachineName
        ''RemoveHandler ProxySearch.getUserGuidIDCompleted, AddressOf client_getUserGuidID

        GC.Collect()
        GC.WaitForPendingFinalizers()

    End Sub

    ''' <summary>
    ''' Loads the system run time parameters.
    ''' </summary>
    Sub LoadSystemRunTimeParameters()
        If Not bAttached Then
            Return
        End If
        'AddHandler ProxySearch.getSystemParmCompleted, AddressOf client_LoadSystemParameters
        'EP.setSearchSvcEndPoint(proxy)
        ProxySearch.getSystemParm(gSecureID, gSystemParms)
        client_LoadSystemParameters(gSystemParms)

    End Sub
    ''' <summary>
    ''' Clients the load system parameters.
    ''' </summary>
    ''' <param name="tDict">The t dictionary.</param>
    Sub client_LoadSystemParameters(tDict As Dictionary(Of String, String))
        If tDict.Keys.Count > 0 Then
            'MessageBox.Show("Step-D 0001 GOOD")
            Dim tKey As String = ""
            Dim tVAl As String = ""
            Dim II As Integer = tDict.Count
            For Each tKey In tDict.Keys
                tVAl = tDict.Item(tKey)
                If Not gSystemParms.ContainsKey(tKey) Then
                    gSystemParms.Add(tKey, tVAl)
                End If
            Next
            lblAttached.Content = "System Parms Loaded: " & gSystemParms.Count & " and DB Connection good."
            Console.WriteLine(tDict.Count)

            'MessageBox.Show("Step-D 0002 GOOD")

            LoadLicenseParameters()
            'MessageBox.Show("Step-D 0003 GOOD")
        Else
            'MessageBox.Show("Step-D 0004 BAD")
            lblAttached.Content = "System Parms field to Load / DB Failed to attach."
        End If

        ''RemoveHandler ProxySearch.getSystemParmCompleted, AddressOf client_LoadSystemParameters

    End Sub
    ''' <summary>
    ''' Sets the pagination.
    ''' </summary>
    Sub SetPagination()
        If Not bAttached Then
            Return
        End If
        ''Dim proxy As New SVCSearch.Service1Client
        'AddHandler ProxySearch.getUserParmCompleted, AddressOf client_SetPagination
        'EP.setSearchSvcEndPoint(proxy)
        Thread.Sleep(AffinityDelay)
        ProxySearch.getUserParm(gSecureID, gMaxRecordsToFetch, "user_MaxRecordsToFetch")
        Console.WriteLine("gMaxRecordsToFetch:" + gMaxRecordsToFetch)
    End Sub
    'Sub client_SetPagination(ByVal sender As Object, ByVal e As SVCSearch.getUserParmCompletedEventArgs)
    '    If RC Then
    '        gMaxRecordsToFetch = e.sVariable
    '    Else
    '        gMaxRecordsToFetch = 75
    '    End If
    '    'RemoveHandler ProxySearch.getUserParmCompleted, AddressOf client_SetPagination
    'End Sub

    ''' <summary>
    ''' Handles the Click event of the btnSubmit control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub btnSubmit_Click(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles btnSubmit.Click
        'getSessionID()
        Image01.Visibility = Visibility.Visible
        Cursor = Cursors.Wait

        Me.UpdateLayout()

        If PasswordBox1.Password.ToUpper.Equals("PASSWORD") Then
            If txtLoginID.Text.Length = 0 Then
                Cursor = Cursors.Arrow
                MessageBox.Show("Please enter your USERID into the Login ID field.")
                Return
            End If
            Dim cw As New popUserPassword()
            Cursor = Cursors.Arrow
            cw.Show()
            Return
        End If

        If txtLoginID.Text.Length = 0 Then
            Cursor = Cursors.Arrow
            MessageBox.Show("You user Login ID is required.")
            Return
        End If
        If PasswordBox1.Password.Length = 0 Then
            Cursor = Cursors.Arrow
            MessageBox.Show("You user Login Password is required.")
            Return
        End If


        lblAttachedMachineName.Content = gAttachedMachineName
        lblCurrUserGuidID.Content = txtLoginID.Text
        lblLocalIP.Content = gLocalMachineIP
        lblServerInstanceName.Content = gServerInstanceName
        lblServerMachineName.Content = gServerMachineName

        lblCurrUserGuidID.Content = txtLoginID.Text
        gCurrUserGuidID = txtLoginID.Text
        gCurrLoginID = txtLoginID.Text

        If gEncLicense Is Nothing Then
            Cursor = Cursors.Arrow
            MessageBox.Show("A license has not been confirmed, please contact an administrator.")
            Return
        End If

        If gAttachedMachineName.Length = 0 Then
            Cursor = Cursors.Arrow
            lblAttached.Content = "Local workstation name missing."
            gAttachedMachineName = "UNKNOWN:" + gIpAddr
            'Return
        End If
        If gCurrUserGuidID.Length = 0 Then
            Cursor = Cursors.Arrow
            lblAttached.Content = "User ID missing, cannot login."
            Return
        End If
        If gIpAddr.Length = 0 Then
            Cursor = Cursors.Arrow
            lblAttached.Content = "Local IP missing, cannot login."
        End If

        '*************************
        getSecureID()
        SaveStaticVars()
        Dim GWPW As String = System.Configuration.ConfigurationManager.AppSettings("EncPW")
        Dim cs As String = DB.getRepoCs()
        '*************************

        lblAttached.Content = "Logging in, standby."

        Dim RC As Boolean = True
        Dim RetMsg As String = ""


        SaveActiveParm("CurrSessionGuid", CurrSessionGuid.ToString)
        SaveActiveParm("LoginID", txtLoginID.Text)
        SaveActiveParm("UserPW", ENC.AES256EncryptString(PasswordBox1.Password))

        SavePersist()

        PB.IsIndeterminate = True
        PB.Visibility = Windows.Visibility.Visible

        COMMON.SaveClick(100, gCurrUserGuidID)
        Dim EPW As String = PasswordBox1.Password.ToString
        EPW = ENC.AES256EncryptString(EPW)

        Thread.Sleep(AffinityDelay)

        gRowID = gSecureID
        Dim bb As Boolean = ProxySearch.validateLogin(gSecureID, txtLoginID.Text.Trim, EPW, gCurrUserGuidID)
        client_validateLogin(bb, gCurrUserGuidID)
        'EP.setSearchSvcEndPoint(proxy)
        If bLicenseExists = False Then
            ProxySearch.GetXrt(gSecureID, RC, RetMsg)
        End If

    End Sub

    ''' <summary>
    ''' Clients the get customer logo title.
    ''' </summary>
    ''' <param name="S">The s.</param>
    Sub client_getCustomerLogoTitle(S As String)

        If S.Length > 0 Then
            If S.Length = 0 Then
                lblCustom.Content = "ECM Library"
                lblCustom.FontSize = 48
            ElseIf S.Length > 25 Then
                lblCustom.FontSize = 26
            ElseIf S.Length > 20 Then
                lblCustom.FontSize = 32
            ElseIf S.Length > 15 Then
                lblCustom.FontSize = 36
            ElseIf S.Length > 12 Then
                lblCustom.FontSize = 40
            Else
                lblCustom.FontSize = 48
            End If
            lblCustom.Content = S
        Else
            lblCustom.Content = "ECM Library"
            lblCustom.FontSize = 48
        End If

    End Sub


    ''' <summary>
    ''' Makes the synchronous call to contract identifier.
    ''' </summary>
    Private Sub MakeSynchronousCallToContractID()

        Try
            Dim S As String = ProxySearch.getContractID(gSecureID, txtLoginID.Text)
            ContractID = S
            client_getContractID(S)
        Catch ex As Exception
            MessageBox.Show(ex.Message)
        Finally
        End Try
    End Sub

    ''' <summary>
    ''' Clients the validate login.
    ''' </summary>
    ''' <param name="bb">if set to <c>true</c> [bb].</param>
    ''' <param name="UserGuidID">The user unique identifier identifier.</param>
    Sub client_validateLogin(bb As Boolean, UserGuidID As String)

        If bb Then

            Dim RC As Boolean = bb
            Dim B As Boolean = bb

            UserID = txtLoginID.Text

            If ContractID Is Nothing Or ContractID.Length = 0 Then
                MakeSynchronousCallToContractID()
                'AddHandler ProxySearch.getContractIDCompleted, AddressOf client_getContractID
                'ProxySearch.getContractID(gSecureID, txtLoginID.Text)
            End If

            If B Then
                If Not Me.Resources.Contains("UserID") Then
                    Me.Resources.Add("UserID", txtLoginID.Text)
                End If

                If Not Me.Resources.Contains("SecureID") Then
                    Me.Resources.Add("SecureID", gSecureID)
                End If

                gCurrUserGuidID = UserGuidID

                GV.loadUserParms(gCurrUserGuidID)

                getServerInstanceName()

                SetPagination()

                PB.IsIndeterminate = False
                PB.Visibility = Windows.Visibility.Collapsed

                Thread.Sleep(AffinityDelay)
                gCurrLogin = txtLoginID.Text

                Dim NewPage As Uri = New Uri("MainPage.xaml", UriKind.RelativeOrAbsolute)
                Me.NavigationService.Navigate(NewPage)

                'Dim NewPage As Uri = New Uri("testPage.xaml", UriKind.RelativeOrAbsolute)
                'Me.NavigationService.Navigate(NewPage)

            Else
                PB.IsIndeterminate = False
                PB.Visibility = Windows.Visibility.Collapsed
                lblAttached.Content = "LOGIN FAILED, please verify your login ID and password."
            End If

        Else
            PB.IsIndeterminate = False
            PB.Visibility = Windows.Visibility.Collapsed
            gServerInstanceName = "Unknown"
            lblAttached.Content = "Failure to validate user - 100x"
            MessageBox.Show("Failure to validate user - 100x")
        End If
        PB.IsIndeterminate = False

    End Sub
    ''' <summary>
    ''' Clients the get contract identifier.
    ''' </summary>
    ''' <param name="S">The s.</param>
    Sub client_getContractID(S As String)

        If S.Length > 0 Then
            ContractID = S
            lblAttached.Content = "Attached to Repository / Contract successful"
        Else
            ContractID = ""
            MessageBox.Show("ERROR: Failed to establish contract handshake, contact administrator or attempt to login again.")
            lblAttached.Content = "Attached to Repository / Contract failed"
        End If
        ''RemoveHandler ProxySearch.getContractIDCompleted, AddressOf client_getContractID

    End Sub
    ''' <summary>
    ''' Initializes the application.
    ''' </summary>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    Private Function InitApplication() As Boolean

        If Not bAttached Then
            Return False
        End If

        Dim LOG As New clsLogMain

        Dim RC As Boolean = True
        Dim LT$ = ""
        HelpOn = True

        'Dim HIVE As New clsHive
        'gHiveEnabled = HIVE.isHiveEnabled()
        'If gHiveEnabled Then
        '    HivePerformanceToolStripMenuItem.Visible = True
        'Else
        '    HivePerformanceToolStripMenuItem.Visible = False
        'End If
        'HIVE = Nothing


        If bLicenseExists = False Then
            MessageBox.Show("A license for the product does not exist, please supply the required license.")
            RC = False
            Return RC
        End If

ContinueTheExe:

        If Not bLicenseExists Then
            MessageBox.Show("There does not appear to be an active license for this installation, please contact an administrator - or install a valid license.")
            Return False
        Else
            '** Check the expiration date and the service expiration date

            GV.isLicenseValid(gServerValText, gInstanceValText)
            Dim MachineName$ = lblServerMachineName.Content

            'If gMaxClients > 0 Then
            '    If gNumberOfRegisterdMachines > gMaxClients Then
            '        Dim MSG$ = "It appears all ECM Client licenses have been used." + vbCrLf
            '        MSG += "Please logon from a licensed machine," + vbCrLf + vbCrLf
            '        MSG += "or contact ECM Library for additional client licenses." + vbCrLf + vbCrLf
            '        MSG += "Thank you, closing down." + vbCrLf
            '        MessageBox.Show(MSG)
            '        RC = False
            '        Return RC
            '    End If
            'End If

            '**********************************************************
            '* Done in the class NEW sub
            'Dim CurrNbrOfUsers As Integer = DB.GetNbrUsers
            'Dim CurrNbrOfMachine As Integer = DB.GetNbrMachine
            '**********************************************************

            If gNbrOfRegisteredUsers > gNbrOfUsers Then
                Dim Msg$ = ""
                Msg = Msg + "FrmfrmInit : MachineName : 1103 : " + vbCrLf
                Msg = Msg + "     Number of licenses warning : '" + MachineName + "'" + vbCrLf
                Msg = Msg + "     We are very sorry, but the maximum number of USERS has been exceeded." + vbCrLf
                Msg = Msg + "     ECM found " + CurrNbrOfUsers.ToString + " users currently registered in the system." + vbCrLf
                Msg = Msg + "     Your license awards " + gNbrOfUsers.ToString + " users." + vbCrLf
                Msg = Msg + "You will have to login with an existing User ID and Password." + vbCrLf + "Please contact admin for support."
                LOG.WriteToSqlLog(Msg)
                MessageBox.Show(Msg)
                LOG = Nothing
                RC = False
                Return RC
            End If

            If gNumberOfRegisterdMachines > gNbrOfSeats Then

                Dim IP As String = gLocalMachineIP
                gIpAddr = gLocalMachineIP
                gMachineID = lblAttachedMachineName.Content
                _MachineID = lblAttachedMachineName.Content

                Dim Msg$ = ""
                Msg = Msg + "FrmfrmInit : Current Users : 1103b : " + vbCrLf
                Msg = Msg + "     Number of current SEATS warning : '" + MachineName + "'" + vbCrLf
                Msg = Msg + "     We are very sorry, but the maximum number of seats (WorkStations) has been exceeded." + vbCrLf
                Msg = Msg + "     ECM found " + CurrNbrOfMachine.ToString + " machines registered in the system." + vbCrLf
                Msg = Msg + "     Your license awards " + gNbrOfSeats.ToString + " seats." + vbCrLf
                Msg = Msg + "You will have to login from a WorkStation already defined to ECM." + vbCrLf + "Please contact admin for support."
                LOG.WriteToSqlLog(Msg)
                MessageBox.Show(Msg)
                RC = False
                LOG = Nothing
                Return RC
            Else
                'Dim iExists As Integer = DB.GetNbrMachine(MachineName)
                If gMachineExist = 0 Then
                    Dim MySql$ = "insert into Machine (MachineName) values ('" + MachineName + "')"
                    ExecuteSql(gSecureID, MySql)
                End If
                Dim IP As String = gLocalMachineIP

                gIpAddr = gLocalMachineIP
                gMachineID = lblAttachedMachineName.Content
                _MachineID = lblAttachedMachineName.Content

            End If

            If gIsLease = True Then

                'Dim ExpirationDate As Date = CDate(LM.ParseLic(LT$, "dtExpire"))
                Dim ExpirationDate As Date = gExpirationDate
                Dim dtStartDate As Date = "1/1/2007"
                Dim tsTimeSpan As TimeSpan
                Dim iNumberOfDays As Integer
                'Dim strMsgText As String
                tsTimeSpan = ExpirationDate.Subtract(Now)
                iNumberOfDays = tsTimeSpan.Days

                If Now > ExpirationDate.AddDays(30) Then
                    MessageBox.Show("It is dead - your license has totally exppired.")
                    RC = False
                    Return RC
                End If

                If iNumberOfDays <= 7 Then
                    infoDaysToExpire.Content = "License! " + iNumberOfDays.ToString
                    'infoDaysToExpire.Foreground = "FF141313"
                ElseIf iNumberOfDays <= 14 Then
                    'infoDaysToExpire.BackColor = Color.LightSalmon
                    infoDaysToExpire.Content = "License! " + iNumberOfDays.ToString
                ElseIf iNumberOfDays <= 30 Then
                    'infoDaysToExpire.BackColor = Color.Yellow
                    infoDaysToExpire.Content = "License@ " + iNumberOfDays.ToString
                ElseIf iNumberOfDays <= 60 Then
                    'infoDaysToExpire.BackColor = Color.LightSeaGreen
                    infoDaysToExpire.Content = "License? " + iNumberOfDays.ToString
                ElseIf iNumberOfDays < 90 Then
                    'infoDaysToExpire.BackColor = Color.Green
                    infoDaysToExpire.Content = "License* " + iNumberOfDays.ToString
                Else
                    infoDaysToExpire.Content = " #" + iNumberOfDays.ToString + " days"
                End If


                If Now > ExpirationDate Then
                    LOG.WriteToSqlLog("FrmfrmInit : 1001 We are very sorry, but your software LEASE has expired. Please contact ECM Library support.")
                    MessageBox.Show("We are very sorry, but your software license has expired." + vbCrLf + vbCrLf + "Please contact ECM Library support.")
                    MessageBox.Show("The application will now end, please restart with the new license.")
                    RC = False
                    LOG = Nothing
                    Return RC
                End If
            End If

            MaintExpire = gMaintExpire
            If Now > MaintExpire Then
                Dim NoticeMessage As String = ""
                NoticeMessage = "Crititcal NOTICE Maintenance Expiration : We are very sorry to inform you, but your maintenance agreement has expired. No further support can be supplied and product updates are ended until your maintenance license is renewed." + vbCrLf + vbCrLf + "Please contact ECM Library support."
                Me.Title = "Crititcal NOTICE Maintenance Expired."
                LOG.WriteToSqlLog(NoticeMessage)
            End If

        End If

        Me.AllowDrop = False

        '** If here and no license exists, just quit
        If bLicenseExists = False Then
            LOG.WriteToSqlLog("FATAL: Unrecoverable Error: No license exists... aborting.")
            MessageBox.Show("Cannot continue without a license.")
            RC = False
            LOG = Nothing
            Return RC
        End If

        'InitProcessAsFiles()
        'DFLT.setDefaultAttributes()

        LogIntoSystem()

        If gCurrUserGuidID.Length = 0 Then
            'getUserGuidID()
            gCurrLoginID = txtLoginID.Text
            Console.WriteLine(gCurrUserGuidID)
        End If

        'DB.ckRunAtStartUp()

        SetDefaults()

        'LOG.CleanOutTempDirectory()
        'LOG.CleanOutErrorDirectory()

        Dim SSVersion As String = gServerVersion
        If InStr(SSVersion, "Express", CompareMethod.Text) > 0 Then
            Dim DBSize As Double = 0
            DBSize = gCurrDbSize
            If DBSize > 3250 Then
                lblAttached.Content = "DB Limit Warning @ " + DBSize.ToString + " MB"
                'sb.BackColor = Color.Yellow
            End If
            If DBSize > 3850 Then
                lblAttached.Content = "DB Limit Warning @ " + DBSize.ToString + " MB"
                'sb.BackColor = Color.RED
            End If
            If DBSize > 9000 Then
                lblAttached.Content = "DB Limit Warning @ " + DBSize.ToString + " MB"
                'sb.BackColor = Color.Red
            End If
        End If

        COMMON.resetMissingEmailIds()
        COMMON.RecordGrowth()

        'Dim ServerValText, InstanceValText As String
        'gisLicenseValid As Boolean = LM.isLicenseLocatedOnAssignedMachine(ServerValText, InstanceValText)

        If gIsLicenseValid = False Then
            lblAttached.Content += " @ License mismatch: " + gServerValText
            lblAttached.Content += gInstanceValText
        End If

        LOG = Nothing

        Return True

    End Function

    ''' <summary>
    ''' Sets the defaults.
    ''' </summary>
    Sub SetDefaults()
        If Not bAttached Then
            Return
        End If

        'UserParmInsertUpdate("CurrSearchCriteria", gCurrUserGuidID, " ")
        'UserParmInsertUpdate("ckLimitToExisting", gCurrUserGuidID, "0")
        'DeleteMarkedImageCopyFiles()
        TurnHelpOn(0)

        bInitialized = True

        SystemSqlTimeout = getSystemParm("SqlServerTimeout")

        gMachineID = lblAttachedMachineName.Content
        _MachineID = lblAttachedMachineName.Content

        'LOG.CleanOutTempDirectory()
        'DFLT.AddUserSelectableParameters(gCurrUserGuidID)

        'CheckForDBUpdates(False)
        'Dim S as string = "Select count(*) from Retention"
        'Dim iCnt As Integer = DB.iCount(S)
        'If iCnt = 0 Then
        '    DB.AddDefaultRetentionCode()
        'End If
        Dim UTIL As New clsUtility
        UTIL.SetVersionAndServer()
        UTIL = Nothing

        'Dim bEmbededJPGMetadata As Boolean = DB.ShowGraphicMetaDataScreen

        'AddUserDefaults()

        'DB.UserParmInsert("SoundOn", gCurrUserGuidID, "ON")
        Dim Msg2$ = "Login: " + gCurrLoginID
        Msg2 = Msg2 + ", " + gMachineID
        Dim LOG As New clsLogMain
        LOG.WriteToSqlLog(Msg2)
        LOG = Nothing

    End Sub

    ''' <summary>
    ''' Logs the into system.
    ''' </summary>
    Sub LogIntoSystem()
        If Not bAttached Then
            Return
        End If

        Try
            FilesToDelete.Clear()

            Dim SaveName$ = "UserStartUpParameters"
            Dim SaveTypeCode$ = "StartUpParm"
            Dim CurrentLoginID = ""

Retry:
            If iAttempts >= 4 Then
                MessageBox.Show("Too many failed login attempts, closing down.")
                Return
            End If

BadAutoLogin:
            CurrentLoginID = txtLoginID.Text.Trim
            gCurrLoginID = txtLoginID.Text.Trim
            'getUserGuidID()
GoodLogin:
            GV.getUserGuidID(gCurrLoginID)
            SetDefaults()

            lblAttached.Content += " : Logged in as " + CurrentLoginID
        Catch ex As Exception
            Dim LOG As New clsLogMain
            LOG.WriteToSqlLog("FrmfrmInit : ReLogIntoSystem : 100 : " + ex.Message)
            LOG = Nothing
            MessageBox.Show("LogIntoSystem: Login failed.")
        End Try

    End Sub

    ''' <summary>
    ''' Instantiates the global vars.
    ''' </summary>
    Sub instantiateGlobalVars()
        If Not bAttached Then
            Return
        End If

        GV.getGlobalVariables()
        GV.getSqlServerVersion()

        InitApplication()

        'Dim SS$ = "Select count(*) from LoginClient"
        'Dim EcmClientsDefinedToSystem As Integer = DB.iCount(SS as string)


        'Dim AdminExist As Boolean = DB.adminExist()
        'Dim iExists As Integer = DB.GetNbrMachine(MachineName)
        'Dim IP As String = DMA.getIpAddr

        'gNbrOfSeats = Val(LM.ParseLic(LT$, "txtNbrSeats"))
        'gLicenseType = LM.LicenseType
        'gIsSDK = LM.SdkLicenseExists
        'gNbrOfUsers = Val(LM.ParseLic(LT$, "txtNbrSimlSeats"))

        'CurrNbrOfUsers = DB.GetNbrUsers
        'CurrNbrOfMachine = DB.GetNbrMachine

        'DB.RegisterEcmClient(MachineName as string)
        'DB.RegisterMachineToDB(MachineName as string)
        'gMaxClients = LM.getMaxClients
        'bLicenseExists = DB.LicenseExists
        'LT$ = DB.GetXrt

    End Sub

    ''' <summary>
    ''' Initializes the server attach.
    ''' </summary>
    Public Sub InitServerAttach()
        If Not bAttached Then
            Return
        End If

        Dim RC As Boolean = False
        Dim RetMsg As String = ""

        If _SecureID <= 0 Then
            'lblAttached.Content = "NOTICE: The Gateway has not connected - please wait amoment before logging in to the system."
            Return
        End If

        'EP.setSearchSvcEndPoint(proxy)
        If bLicenseExists = False Then
            'AddHandler ProxySearch.GetXrtCompleted, AddressOf Step0GetLicense
            Dim S As String = ProxySearch.GetXrt(_SecureID, RC, RetMsg)
            Step0GetLicense(S)
        End If

        'AddHandler ProxySearch.GetXrtTestCompleted, AddressOf StepGetXrtTest
        'ProxySearch.GetXrtTest(DateTime.Now)

    End Sub
    ''' <summary>
    ''' Steps the get XRT test.
    ''' </summary>
    ''' <param name="S">The s.</param>
    Sub StepGetXrtTest(S As String)
        If S.Length > 0 Then
            Console.WriteLine(S)
        Else
            MessageBox.Show("License Error 003: StepGetXrtTest FAILED")
            Console.WriteLine(S)
        End If

        ''RemoveHandler ProxySearch.GetXrtTestCompleted, AddressOf StepGetXrtTest
    End Sub
    ''' <summary>
    ''' Step0s the get license.
    ''' </summary>
    ''' <param name="S">The s.</param>
    Sub Step0GetLicense(S As String)

        If S.Length > 0 Then
            If S.Length = 0 Then
                'MessageBox.Show("Step-B 0003 BAd")
                bLicenseExists = False
                gEncLicense = ""
                btnSubmit.IsEnabled = False
                MessageBox.Show("A license for the product does not exist, please supply the required license.")
                Return
            Else
                'MessageBox.Show("Step-B 0003 GOOD")
                LicenseValid = True
                bLicenseExists = True
                btnSubmit.IsEnabled = True
                gEncLicense = S

                'MessageBox.Show("Step-B 0004 GOOD")
                LoadSystemRunTimeParameters()
                'MessageBox.Show("Step-B 0005 GOOD")
                getServerInstanceName()
                'MessageBox.Show("Step-B 0006 GOOD")
            End If

            lblNbrUsers.Content = RegisteredUsers
            lblSqlVersion.Content = SqlSvrVersion
            lblMaintDays.Content = MaintExpire
            lblNbrSeats.Content = NbrOfSeats + "/" + MaxClients
            lblNbrMachines.Content = NbrRegisteredMachines

            lblAttached.Content = "Attached to Repository"

        Else
            bLicenseExists = False
            gEncLicense = ""
            MessageBox.Show("001X - An error occured while verifying the ECM license, please contact an administrator ask him/her to check the LOGS table: ")
            Return
        End If

        'RemoveHandler ProxySearch.GetXrtCompleted, AddressOf Step0GetLicense

    End Sub

    ''' <summary>
    ''' Loads the license parameters.
    ''' </summary>
    Sub LoadLicenseParameters()
        'MessageBox.Show("Step-E  NULL GOOD")
    End Sub


    ''' <summary>
    ''' Handles the Checked event of the ckRememberMe control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub ckRememberMe_Checked(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles ckRememberMe.Checked
        If txtLoginID.Text.Trim.Length = 0 Then
            MessageBox.Show("You must supply a login ID first, returning.")
            Return
        End If

        SavePersist()

    End Sub

    ''' <summary>
    ''' Handles the Unchecked event of the ckRememberMe control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub ckRememberMe_Unchecked(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles ckRememberMe.Unchecked
        Try
            RemovePersist()
            'System.IO.IsolatedStorage.IsolatedStorageSettings.ApplicationSettings.Remove("LoginID")
            lblAttached.Content = "Removed"
        Catch ex As Exception
            lblAttached.Content = "Failed to remove - " + ex.Message
        End Try
    End Sub

    ''' <summary>
    ''' Handles the KeyDown event of the PasswordBox1 control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.Input.KeyEventArgs"/> instance containing the event data.</param>
    Private Sub PasswordBox1_KeyDown(ByVal sender As System.Object, ByVal e As System.Windows.Input.KeyEventArgs) Handles PasswordBox1.KeyDown
        If e.Key = Key.Enter Then
            btnSubmit_Click(Nothing, Nothing)
        End If
    End Sub

    ''' <summary>
    ''' Handles the TextChanged event of the txtLoginID control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.Controls.TextChangedEventArgs"/> instance containing the event data.</param>
    Private Sub txtLoginID_TextChanged(ByVal sender As System.Object, ByVal e As System.Windows.Controls.TextChangedEventArgs) Handles txtLoginID.TextChanged
        lblCurrUserGuidID.Content = txtLoginID.Text
    End Sub

    ''' <summary>
    ''' Clients the set session company identifier.
    ''' </summary>
    ''' <param name="RC">if set to <c>true</c> [rc].</param>
    Sub client_setSessionCompanyID(RC As Boolean)

        If Not RC Then
            Dim LOG As New clsLogMain
            LOG.WriteToSqlLog("ERROR:100.x1-client_setSessionCompanyID:")
            LOG = Nothing
        End If

    End Sub


    ''' <summary>
    ''' Clients the get XRT test.
    ''' </summary>
    ''' <param name="S">The s.</param>
    Sub client_GetXrtTest(S As String)
        Console.WriteLine(S)
        ''RemoveHandler ProxySearch.validateAttachSecureLoginCompleted, AddressOf client_validateAttachSecureLogin
    End Sub



    ''' <summary>
    ''' Saves the static vars.
    ''' </summary>
    Sub SaveStaticVars()
        If gSecureID >= 0 Then
            _SecureID = gSecureID
        End If
        _UserID = txtLoginID.Text
        _ActiveGuid = CurrSessionGuid
        _SessionGuid = CurrSessionGuid

        If Me.Resources.Contains("SecureID") Then
            Me.Resources.Remove("SecureID")
        End If
        Me.Resources.Add("SecureID", gSecureID.ToString)
        If Me.Resources.Contains("CurrSessionGuid") Then
            Me.Resources.Remove("CurrSessionGuid")
        End If
        Me.Resources.Add("CurrSessionGuid", CurrSessionGuid.ToString)
        If Me.Resources.Contains("CompanyID") Then
            Me.Resources.Remove("CompanyID")
        End If

        If Me.Resources.Contains("LoginID") Then
            Me.Resources.Remove("LoginID")
        End If
        Me.Resources.Add("LoginID", txtLoginID.Text)

        SavePersist()

    End Sub



    ''' <summary>
    ''' Saves the active parm.
    ''' </summary>
    ''' <param name="ParmName">Name of the parm.</param>
    ''' <param name="ParmVal">The parm value.</param>
    Sub SaveActiveParm(ByVal ParmName As String, ByVal ParmVal As String)
        If Not bAttached Then
            Return
        End If

        'AddHandler ProxySearch.ActiveSessionCompleted, AddressOf client_ActiveSession
        'EP.setSearchSvcEndPoint(proxy)
        Dim BB As Boolean = ProxySearch.ActiveSession(gSecureID, CurrSessionGuid, ParmName, ParmVal)
        client_ActiveSession(BB)
    End Sub

    ''' <summary>
    ''' Clients the active session.
    ''' </summary>
    ''' <param name="BB">if set to <c>true</c> [bb].</param>
    Sub client_ActiveSession(BB As Boolean)
        If BB Then
            If BB Then
            Else
                lblAttached.Content = "Failure to save " + ParmName
            End If
        Else
            lblAttached.Content = "Failure to save ActiveSession: " + ParmName
        End If
        ''RemoveHandler ProxySearch.ActiveSessionCompleted, AddressOf client_ActiveSession
    End Sub

    ''' <summary>
    ''' Removes the persist.
    ''' </summary>
    Sub RemovePersist()
        ISO.PersistDataInit("NA", "NA")
    End Sub
    ''' <summary>
    ''' Resets the persist.
    ''' </summary>
    Sub ResetPersist()
        'ISO.PersistDataInit("CurrSessionGuid", CurrSessionGuid.ToString)
        txtLoginID.Text = ""
        Dim TPW As String = ""

        ISO.PersistDataSave("LoginID", txtLoginID.Text)
        'Dim TPW As String = pwEncryptPW.Password
        TPW = ENC.AES256EncryptString(TPW)
        ISO.PersistDataSave("UserPW", TPW)
        ISO.PersistDataSave("EOD", "***")
    End Sub
    ''' <summary>
    ''' Saves the persist.
    ''' </summary>
    Sub SavePersist()
        ISO.PersistDataInit("CurrSessionGuid", CurrSessionGuid.ToString)
        ISO.PersistDataSave("LoginID", txtLoginID.Text)
        Dim TPW As String = PasswordBox1.Password.Trim
        If TPW.Length > 0 Then
            TPW = ENC.AES256EncryptString(TPW)
        End If
        ISO.PersistDataSave("UserPW", TPW)

        ISO.PersistDataSave("EOD", "***")
    End Sub
    ''' <summary>
    ''' Gets the persit data.
    ''' </summary>
    Sub getPersitData()

        Dim SID As String = ISO.PersistDataRead("SecureID")
        If SID.Length > 0 Then
            gSecureID = CInt(SID)
            _SecureID = gSecureID
        End If

        Dim val As String = ""

        PasswordBox1.Password = ISO.PersistDataRead("UserPW`")
        txtLoginID.Text = ISO.PersistDataRead("LoginID")

        Dim GWPW As String = System.Configuration.ConfigurationManager.AppSettings("EncPW")

        Dim sCurrSessionGuid As String = ISO.PersistDataRead("CurrSessionGuid")
        If sCurrSessionGuid.Length > 0 Then
            CurrSessionGuid = New Guid(sCurrSessionGuid)
        End If

        If Me.Resources.Contains("CurrSessionGuid") Then
            Me.Resources.Remove("CurrSessionGuid")
        End If
        Me.Resources.Add("CurrSessionGuid", CurrSessionGuid.ToString)
    End Sub

    ''' <summary>
    ''' Handles the Click event of the hlHelp control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub hlHelp_Click(sender As Object, e As RoutedEventArgs) Handles hlHelp.Click
        'Launch Default Braowser to specified URL
        Dim webAddress As String = "http://www.ecmlibrary.com/help"
        System.Diagnostics.Process.Start(webAddress)
    End Sub

    ''' <summary>
    ''' Handles the Click event of the hlLogPath control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub hlLogPath_Click(sender As Object, e As RoutedEventArgs) Handles hlLogPath.Click
        'AddHandler ProxySearch.GetLogPathCompleted, AddressOf client_GetLogPath
        'EP.setSearchSvcEndPoint(proxy)
        Dim S As String = ""
        ProxySearch.GetLogPath(S)
        client_GetLogPath(S)
    End Sub
    ''' <summary>
    ''' Clients the get log path.
    ''' </summary>
    ''' <param name="S">The s.</param>
    Sub client_GetLogPath(S As String)
        If S.Length > 0 Then
            Dim LogPath As String = S
            MessageBox.Show(LogPath)
            Try
                Clipboard.SetText(LogPath)
                MessageBox.Show("Path in clipboard.")
            Catch ex As Exception
                Console.WriteLine(ex.Message)
            End Try
        Else
            MessageBox.Show("Failed to get Error Log path from server.")
        End If
        ''RemoveHandler ProxySearch.GetLogPathCompleted, AddressOf client_GetLogPath
    End Sub

    ''' <summary>
    ''' Handles the Unloaded event of the Page control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub Page_Unloaded(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles MyBase.Unloaded

        ''RemoveHandler ProxySearch.validateLoginCompleted, AddressOf client_validateLogin
        'RemoveHandler ProxySearch.getCustomerLogoTitleCompleted, AddressOf client_getCustomerLogoTitle
        'RemoveHandler ProxySearch.GetXrtCompleted, AddressOf Step0GetLicense


    End Sub


    ''' <summary>
    ''' Handles the MouseEnter event of the txtLoginID control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="MouseEventArgs"/> instance containing the event data.</param>
    Private Sub txtLoginID_MouseEnter(sender As Object, e As MouseEventArgs) Handles txtLoginID.MouseEnter
        lblEndpoint.Content = ProxySearch.Endpoint.Address.ToString
    End Sub


    ''' <summary>
    ''' Handles the Checked event of the ckShowDetails control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub ckShowDetails_Checked(sender As Object, e As RoutedEventArgs) Handles ckShowDetails.Checked
        spDetails.Visibility = Windows.Visibility.Visible
    End Sub

    ''' <summary>
    ''' Handles the Unchecked event of the ckShowDetails control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub ckShowDetails_Unchecked(sender As Object, e As RoutedEventArgs) Handles ckShowDetails.Unchecked
        spDetails.Visibility = Windows.Visibility.Collapsed
    End Sub

    ''' <summary>
    ''' Handles the MouseLeftButtonDown event of the Label4 control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="MouseButtonEventArgs"/> instance containing the event data.</param>
    Private Sub Label4_MouseLeftButtonDown(sender As Object, e As MouseButtonEventArgs) Handles Label4.MouseLeftButtonDown
        Dim webAddress As String = "http://www.DmaChicago.com"
        System.Diagnostics.Process.Start(webAddress)
    End Sub

    ''' <summary>
    ''' Cks the attach.
    ''' </summary>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    Private Function ckAttach() As Boolean
        Dim bAttach As Boolean = True

        Try
            lblAttached.Content = InitProxy.TestConnection()
        Catch ex As Exception
            lblAttached.Content = "NOT ATTACHED : ERROR"
            MessageBox.Show("ERROR in attaching to service:" + vbCrLf + ex.Message + vbCrLf + "*******************************************" + ex.InnerException.ToString)
        End Try

        Return bAttach

    End Function

    ''' <summary>
    ''' Handles the Click event of the btnCkConn control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub btnCkConn_Click(sender As Object, e As RoutedEventArgs) Handles btnCkConn.Click
        Try
            MessageBox.Show(InitProxy.TestConnection())
            lblAttached.Content = "ATTACHED to Database and IIS"
        Catch ex As Exception
            lblAttached.Content = "NOT ATTACHED"
            MessageBox.Show("ERROR in attaching to service:" + vbCrLf + ex.Message + vbCrLf + "*******************************************" + ex.InnerException.ToString)
        End Try
    End Sub

    ''' <summary>
    ''' Handles the Click event of the BtnCkDbConn control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub BtnCkDbConn_Click(sender As Object, e As RoutedEventArgs) Handles btnCkDbConn.Click

        Dim CS As String = gFetchCS()
        Dim fName As String = ""
        Dim iCnt As String = ""

        Try
            Dim S As String = "select count(*) from License"
            Dim CN As New SqlConnection(CS)
            Dim RSData As SqlDataReader = Nothing
            Dim CONN As New SqlConnection(CS)

            CONN.Open()
            Dim command As New SqlCommand(S, CONN)
            RSData = command.ExecuteReader()

            If RSData.HasRows Then
                RSData.Read()
                iCnt = RSData.GetValue(0).ToString
            End If
            RSData.Close()
            RSData = Nothing
            CONN.Dispose()

            CN.Close()
            CN = Nothing
            GC.Collect()
            GC.WaitForPendingFinalizers()
            MessageBox.Show("Successfully connected DIRECTLY to the database...")
        Catch ex As Exception
            iCnt = -1
            MessageBox.Show("Could not connect to the database:" + vbCrLf + ex.Message + vbCrLf + "*******************************************" + ex.InnerException.ToString)
        End Try
    End Sub

    ''' <summary>
    ''' Handles the Click event of the BtnCkIISConn control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub BtnCkIISConn_Click(sender As Object, e As RoutedEventArgs) Handles btnCkIISConn.Click
        Try
            MessageBox.Show(InitProxy.TestIISConnection())
        Catch ex As Exception
            MessageBox.Show("ERROR in attaching to IIS:" + vbCrLf + ex.Message + vbCrLf + "*******************************************" + ex.InnerException.ToString)
        End Try
    End Sub
End Class
